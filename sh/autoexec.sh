#!/usr/bin/env bash
#cito M:755 O:0 G:0 T:/usr/bin/autoexec
#------------------------------------------------------------------------------
# Project Name      - Extra/source/autoexec/autoexec
# Started On        - Thu 31 Oct 22:49:41 GMT 2019
# Last Change       - Mon 13 Dec 21:10:30 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Features:
#
# N/A
#
# Bugs:
#
#TODO: Using AutoExec for man pages (pagers) is buggy, but functional.
#
#      More specifically, the prompt shows through and when ^C-ing, the last
#      line (message line with exit status) still shows. Pretty ugly. I'm not
#      sure this is something which can be fixed, as it's probably just a
#      limitation of Shell/terminals.
#
# Dependencies:
#
#   bash (>= 4.4.18-2)
#   coreutils (>= 8.28-1)
#   file (>= 1:5.32-2)
#   ncurses-bin (>= 6.1-1)
#------------------------------------------------------------------------------

CurVer='2021-12-13'
Progrm=${0##*/}
ProgrmFancy='AutoExec'

Usage(){
	while read; do
		printf '%s\n' "$REPLY"
	done <<-EOF
		Usage: $Progrm [OPTS] [FILE] [FILE_ARGS]

		  -h, --help               - Displays this help information.
		  -v, --version            - Output only the version datestamp.
		  -C, --no-color           - Disable ANSI color escape sequences.
		  -E, --no-exit            - Omit the exit status on the bottom-right.
		  -S, --no-spinner         - Omit 'spinner' from the waiting message.
		  -W, --no-waitmsg         - Omit the waiting message at the end.
		  -c, --check              - Check for errors before executing.
		  -e, --exec <NAME>        - Use NAME as the interpreter or program.
		  -f, --force              - Forces use of that which is unsupported.
		  -o, --once               - Execute FILE only once; no looping.
		  -r, --refresh <INT>      - Adjust to fit your performance needs.
		  -t, --time               - Time the execution of FILE.

		  To exit $ProgrmFancy, send the SIGINT (130) signal using the Ctrl + C
		  shortcut (^C). Your previous terminal layout will be restored.

		  When forcing, unsupported mimetypes and executables will be allowed.
	EOF
}

Err(){
	printf 'ERROR: %s\n' "$2" 1>&2
	(( $1 >= 1 )) && exit $1
}

TIMEFORMAT='[R:%3R|U:%3U|S:%3S|P:%P]'

Check='False'
Color='True'
ExitStatus='True'
Force='False'
Once='False'
Refresh='0.05'
Spinner='True'
Time='False'
WaitMSG='True'

while [ -n "$1" ]; do
	case $1 in
		--)
			break ;;
		--help|-h|-\?)
			Usage; exit 0 ;;
		--version|-v)
			printf "%s\n" "$CurVer"; exit 0 ;;
		--exec|-e)
			shift

			if [ -z "$1" ]; then
				Err 1 'Name of command not provided.'
			#elif ! type -P "$1" > /dev/null 2>&1; then
			#	Err 1 'Provided command not found in PATH.'
			else
				Exec=$1
			fi ;;
		--refresh|-r)
			RefreshArg=$1
			shift

			if [ -z "$1" ]; then
				Err 1 'Unspecified refresh rate.'
			elif ! [[ $1 =~ ^([[:digit:]]+|[[:digit:]]+.[[:digit:]]+)$ ]]; then
				Err 1 'Invalid refresh rate.'
			else
				RefreshCustom='True'
				Refresh=$1
			fi ;;
		--once|-o)
			OnceArg=$1
			Once='true' ;;
		--no-waitmsg|-W)
			WaitMSG='False' ;;
		--no-spinner|-S)
			Spinner='False' ;;
		--no-exit|-E)
			ExitStatus='False' ;;
		--no-color|-C)
			Color='False' ;;
		--force|-f)
			Force='True' ;;
		--time|-t)
			Time='True' ;;
		--check|-c)
			CheckArg=$1
			Check='True' ;;
		-*)
			Err 1 'Incorrect option(s) specified.' ;;
		*)
			break ;;
	esac
	shift
done

if [ "$Once" == 'true' -a "$RefreshCustom" == 'True' ]; then
	Err 1 "OPTs '$OnceArg' and '$RefreshArg' aren't compatible."
fi

[ -z "$1" ] && Err 1 'Missing argument -- file name required.'
[ -f "$1" ] || Err 1 'Provided file is not a file.'
[ -r "$1" ] || Err 1 'Provided file is unreadable.'

ExecFile=$1; shift

DepCount=0
for Dep in file tput stat realpath; {
	if ! type -P "$Dep" &> /dev/null; then
		Err 0 "Dependency '$Dep' not met."
		let DepCount++
	fi
}

(( DepCount > 0 )) && exit 1

#----------------------------------------------Prepare for an Execute Main Loop

if [ "$Force" == 'False' ]; then
	case $Exec in
		*/man|man|*/less|less|*/pager|pager|*/more|more)
			Err 1 "Using pagers with $ProgrmFancy is unsupported." ;;
	esac

	case `file -b --mime-type "$ExecFile"` in
		application|application/*)
			Err 1 'Binary files are not supported.' ;;
	esac
fi

SignalHandler(){
	if [ "$Once" != 'true' ]; then
		tput ed
		tput rmcup
	fi

	if [ -n "$InterpreterMissing" ]; then
		Err 1 "Interpreter '$InterpreterMissing' not found."
	elif [ "$SheBangInvalid" == 'True' ]; then
		Err 1 'Invalid shebang detected.'
	fi

	# Needs to be here otherwise the above line clears it.
	if [ "$Force" == 'False' ] && [ "$UnsupportedCheck" == 'True' ]; then
		Err 1 "OPT '$CheckArg' not supported on FILE."
	fi

	exit 0
}

trap 'SignalHandler' SIGINT EXIT

[ "$Once" == 'true' ] || tput smcup

if [ "$Once" != 'true' ]; then
	shopt -s checkwinsize
	tput clear
	trap 'tput clear' WINCH
fi

while :; do
	# Determine the interpreter to use.
	if [ -z "$Exec" ]; then
		read SheBang < "$ExecFile"

		if [[ $SheBang != '#!'* ]]; then
			SheBangInvalid='True'
			exit 1
		fi

		SheBangMain=${SheBang#\#\!}
		SheBangBase=${SheBangMain##*/}

		if ! type -P "${SheBangMain%% *}" &> /dev/null; then
			InterpreterMissing=$SheBangMain
			exit 1
		fi

		Exec=$SheBangMain
	fi

	if [ -f "$ExecFile" ] && [ -r "$ExecFile" ]; then
		SSE=`stat -c '%Y' "$ExecFile" 2> /dev/null`

		if [ 0${SSEOld//[![:digit:]]} -lt 0${SSE//[![:digit:]]} ]; then
			[ "$Once" == 'true' ] || tput clear

			# If using DASH, BASH, or ZSH, check for errors before executing.
			if [ "$Check" == 'True' ]; then
				unset Errors
				case ${Exec%% *} in
					bash|zsh)
						${Exec%% *} -n "$ExecFile" || Errors='True' ;;
					sh)
						File=`type -P sh`
						Link=`realpath "$File"`
						if [ "$Link" == '/bin/dash' ]; then
							dash -n "$ExecFile" || Errors='True'
						else
							UnsupportedCheck='True'
						fi ;;
					*)
						UnsupportedCheck='True' ;;
				esac

				[ "$Force" == 'False' -a "$UnsupportedCheck" == 'True' ] && exit 1
			fi

			if [ "$Errors" != 'True' ]; then
				if [ "$Time" == 'True' ]; then
					time $Exec "$ExecFile" "$@"
					Exit=$?
				else
					$Exec "$ExecFile" "$@"
					Exit=$?
				fi
			else
				Exit=999
			fi
		fi

		SSEOld=${SSE//[![:digit:]]}
	else
		if [ "$Once" != 'true' ]; then
			tput ed; tput rmcup
		fi

		Err 1 'File not found or inaccessible.'
	fi

	if [ "$Once" != 'true' ]; then
		# Have the exit status on the bottom-right of the terminal.
		if [ "$ExitStatus" == 'True' ]; then
			tput cup $LINES $((COLUMNS - 3))

			if [ "$Color" == 'True' ]; then
				if (( Exit == 0 )); then
					printf '\e[2;37m%#3d\e[0m' $Exit
				else
					printf '\e[1;31m%#3d\e[0m' $Exit
				fi
			else
				printf '%#3d' $Exit
			fi
		fi

		if [ "$WaitMSG" == 'True' ]; then
			if [ "$Spinner" == 'True' ]; then
				for Char in '|' '/' '-' '\'; {
					tput cud $LINES

					if [ "$Color" == 'True' ]; then
						printf '\r\e[2;37m[%s] Waiting for changes...\e[0m ' "$Char"
					else
						printf '\r[%s] Waiting for changes... ' "$Char"
					fi

					read -n 1 -st 0.04
				}
			else
				tput cud $LINES

				if [ "$Color" == 'True' ]; then
					printf '\r\e[2;37mWaiting for changes...\e[0m '
				else
					printf '\rWaiting for changes... '
				fi
			fi
		fi
	fi

	[ "$Once" == 'true' ] && exit 0

	read -n 1 -st $Refresh
done

