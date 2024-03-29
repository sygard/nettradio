#!/bin/bash
#
###############################################################################
#    This program is free software: you can redistribute it and/or modify     #
#    it under the terms of the GNU General Public License as published by     #
#    the Free Software Foundation, either version 3 of the License, or        #
#    (at your option) any later version.                                      #
#                                                                             #
#    This program is distributed in the hope that it will be useful,          #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
#    GNU General Public License for more details.                             #
#                                                                             #
#    You should have received a copy of the GNU General Public License        #
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.    #
#                                                                             #
###############################################################################

. ./nettradio.strm

DEBUG=0

PLAYER="mplayer"
PLAYER_ARGS="-vo null"
PIDFILE="nettradio.pid"

function play_radio {
	stop_radio
	if [ $DEBUG -eq 1 ] ; then
		$PLAYER $PLAYER_ARGS "$1" 
	else
		$PLAYER $PLAYER_ARGS "$1" < /dev/null > /dev/null 2>&1 &
		PID=`echo $!`
		echo $PID > $PIDFILE
	fi
}

function stop_radio {
	if [[ -f $PIDFILE ]] ; then
		kill `cat $PIDFILE` > /dev/null 2>&1
		rm $PIDFILE > /dev/null 2>&1
	fi
}

function print_help {

	echo "USAGE: $0 [CHANNEL]"
	echo "USAGE: $0 help -- brings up the help menu"
	echo ""
	echo ""
	echo "CHANNEL:"
	echo "  p4          - P4 Norge"
	echo "  rnorge      - Radio Norge"
	echo "  rn          - Radio Nova"
	echo "  mp3         - NRK mP3"
	echo "  p1          - NRK P1"
	echo "  p2          - NRK P2"
	echo "  p3          - NRK P3"
	echo "  urort       - NRK Urort"
	echo "  pyro        - NRK Pyro"
	echo "  voiceos     - The VOICE Oslo"
	echo "  voicetr     - The VOICE Trondheim"
	echo "  voicest     - The VOICE Stavanger"
	echo "  radio1os    - Radio1 Oslo"
	echo "  radio1bg    - Radio1 Bergen"

	exit 1
}

if [[ $# -lt 1 ]] ; then
	print_help
fi

if [[ $1 = "stop" ]] ; then
	stop_radio
	exit 1
fi

if [[ $1 = "help" ]] ; then
	print_help
fi

case $1 in
	"p4")
		play_radio $P4
	;;
	"rnorge")
		play_radio $RADIO_NORGE
	;;
	"mp3")
		play_radio $NRK_MP3
	;;
	"p1")
		play_radio $NRK_P1
	;;
	"p2")
		play_radio $NRK_P2
	;;
	"p3")
		play_radio $NRK_P3
	;;
	"urort")
		play_radio $NRK_ORORT
	;;
	"pyro")
		play_radio $NRK_PYRO
	;;
	"voiceos")
		play_radio $VOICE_OSLO
	;;
	"voicetr")
		play_radio $VOICE_TRONDHEIM
	;;
	"voicest")
		play_radio $VOICE_STAVANGER
	;;
	"radio1os")
		play_radio $RADIO1_OSLO
	;;
	"radio1bg")
		play_radio $RADIO1_BERGEN
	;;
	"rn")
		play_radio $RADIO_NOVA
	;;
	*)
		echo "No channel selected"
		print_help
	;;
esac


