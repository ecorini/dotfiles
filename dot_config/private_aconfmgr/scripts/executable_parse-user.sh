#!/bin/bash -xv
set -euo pipefail

tmp_dir=tmp

function Die() {
	local fmt=$1
	shift
	# shellcheck disable=SC2059
	printf "$fmt\n" "$@" 1>&2
	exit 1
}

if [[ -r /etc/shadow ]]
then
	printf 'Importing from system configuration.\n' 1>&2
	fn_passwd=/etc/passwd
	fn_shadow=/etc/shadow
	fn_group=/etc/group
	fn_gshadow=/etc/gshadow
else
	for base in . config ~/.config/aconfmgr
	do
		if [[ -r "$base"/files/etc/passwd ]]
		then
			printf 'Importing from configuration in %s.\n' "$base" 1>&2
			fn_passwd="$base"/files/etc/passwd
			fn_group="$base"/files/etc/group
			fn_gshadow="$base"/files/etc/gshadow
			if [[ -f "$base"/passwd/shadow ]]
			then
				fn_shadow="$base"/passwd/shadow
			else
				fn_shadow="$base"/files/etc/gshadow
			fi
			break
		fi
	done
	if [[ ! -v fn_passwd ]]
	then
		Die "Can't find import location - re-run as root to import from system or run from your aconfmgr config dir."
	fi
fi

# Read users

declare -A users
user_order=()

while IFS=: read -r username ppassword uid gid desc home shell
do
	test -z "${users[$username:seen]+x}" || Die 'Duplicate user in passwd file: %s' "$username"
	user_order+=("$username")
	users[$username:seen]=y
	users[$username:ppassword]=$ppassword
	users[$username:uid]=$uid
	users[$username:gid]=$gid
	users[$username:desc]=$desc
	users[$username:home]=$home
	users[$username:shell]=$shell
done < $fn_passwd

while IFS=: read -r username password last minage maxage pwwarn pwinact acctexp res
do
	test -n "${users[$username:seen]+x}" || Die 'Unknown user in shadow file: %s' "$username"
	users[$username:password]=$password
	users[$username:last]=$last
	users[$username:minage]=$minage
	users[$username:maxage]=$maxage
	users[$username:pwwarn]=$pwwarn
	users[$username:pwinact]=$pwinact
	users[$username:acctexp]=$acctexp
	users[$username:res]=$res
done < $fn_shadow

# Read groups

declare -A groups
group_order=()

rm -rf "$tmp_dir"/usergroups
mkdir -p "$tmp_dir"/usergroups

while IFS=: read -r gname gpassword gid gmembers
do
	test -z "${groups[$gname:seen]+x}" || Die 'Duplicate group in group file %s' "$gname"
	group_order+=("$gname")
	groups[$gname:seen]=y
	groups[$gname:gpassword]=$gpassword
	groups[$gname:gid]=$gid
	groups[$gname:gmembers]=$gmembers

	gmembersarr=()
	IFS=, read -ra gmembersarr <<<"$gmembers"
	for member in "${gmembersarr[@]}"
	do
		printf '%s\n' "$gname" >> "$tmp_dir"/usergroups/"$member"
	done
done < $fn_group

while IFS=: read -r gname gspassword gsadmins gsmembers
do
	test -n "${groups[$gname:seen]+x}" || Die 'Unknown group in gshadow file: %s' "$gname"
	groups[$gname:gspassword]=$gspassword
	groups[$gname:gsadmins]=$gsadmins
	groups[$gname:gsmembers]=$gsmembers
done < $fn_gshadow

# Convert users

declare -A usergroups

rm -f generated-users.sh

for username in "${user_order[@]}"
do
	printf 'Processing user %s\n' "$username" 1>&2
	for var in ppassword uid gid desc home shell  password last minage maxage pwwarn pwinact acctexp res
	do
		declare $var="${users[$username:$var]}"
	done

	[[ "$ppassword" == x            ]] || Die 'passwd file password is not x'
	[[ "$uid"       =~ ^[0-9]+$     ]] || Die 'UID not numeric'
	[[ "$gid"       =~ ^[0-9]+$     ]] || Die 'GID not numeric'
	[[ "$home"      == /*           ]] || Die 'Home directory not absolute path'
	[[ "$shell"     == /*           ]] || Die 'Shell not absolute path'
	[[ "$last"      =~ ^[0-9]*$     ]] || Die 'Last password change not empty or numeric'
	[[ "$minage"    =~ ^0?$         ]] || Die 'Minimum password age not empty or 0'
	[[ "$maxage"    =~ ^(99999|)$   ]] || Die 'Maximum password age not empty or 99999'
	[[ "$pwwarn"    =~ ^7?$         ]] || Die 'Password warning period not empty or 7'
	[[ "$pwinact"   == ''           ]] || Die 'Password inactivity period not empty'
	[[ "$acctexp"   == ''           ]] || Die 'Account expiration date not empty'
	[[ "$res"       == ''           ]] || Die 'Reserved field not empty'

	grouplist=()
	if [[ -f "$tmp_dir"/usergroups/"$username" ]]
	then
		mapfile -t grouplist < "$tmp_dir"/usergroups/"$username"
	fi
	IFS=, groupstr="${grouplist[*]}"

	gpassword="${groups[$username:gspassword]}"

	env printf 'AddUser %q %q %d %d %q %q %q %q %q\n' \
		   "$username" \
		   "$password" \
		   "$uid" \
		   "$gid" \
		   "$gpassword" \
		   "$desc" \
		   "$home" \
		   "$shell" \
		   "$groupstr" \
		   >> generated-users.sh

	usergroups["$username"]="$gid"
done

# Convert groups

for gname in "${group_order[@]}"
do
	printf 'Processing group %s\n' "$gname" 1>&2
	for var in gpassword gid gmembers gspassword gsadmins gsmembers
	do
		declare $var="${groups[$gname:$var]}"
	done

	[[ "$gpassword"  == x            ]] || Die 'group file password is not x'
	[[ "$gid"        =~ ^[0-9]+$     ]] || Die 'GID not numeric'
	[[ "$gspassword" =~ ^(|!|!!|x)$  ]] || Die 'Group password not empty, !, !!, or x: %q' "$gspassword"
	[[ "$gsadmins"   == ''           ]] || Die 'Group administrators not empty'
	[[ "$gsmembers"  == "$gmembers"  ]] || Die 'group/gshadow group members mismatch'

	if [[ -n "${usergroups[$gname]+x}" ]]
	then
		[[ "$gid" == "${usergroups[$gname]}" ]] || Die 'User GID and user'\''s group GID mismatch: %s/%s' "$gid" "${usergroups[$gname]}"
	else
		env printf 'AddGroup %q %q %d\n' \
			   "$gname" \
			   "$gspassword" \
			   "$gid" \
			   >> generated-users.sh
	fi
done