#!/bin/bash
# get sar for exploratory analysis

SARDIR=/var/log/sa/
OUTDIR=sars
options="-B -b -d -H -q -R -r -S -v -w -W  "

[ -d $OUTDIR ] || ( mkdir $OUTDIR ; )

for i in $options
do
  for file in $(ls -d ${SARDIR}sa[0-9][0-9])
  do
    opt=${i/\-/}
    day=$(date -r $file +%y%m%d_%A)
    output="$OUTDIR/${day}_${opt}"
    sadf -d $file -- ${i}  > $output &
    sadf -d $file -- -u ALL  > "${OUTDIR}/${day}_u" &
    sadf -d $file -- -I SUM  > "${OUTDIR}/${day}_I" &
    sadf -d $file > "${OUTDIR}/${day}_proc" &
  done
done

tar cf sars.tar $OUTDIR

