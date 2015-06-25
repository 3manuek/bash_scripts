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


#     -B  $WORK_FILE_PAGING_STATS     
#     -b  $WORK_FILE_IO_TRANSFER_RATE 
#     -d  $WORK_FILE_DEVICE_ACTIVITY  
#     -H  $WORK_FILE_HUGE_PAGES 
#     -I SUM $WORK_FILE_INTERRUPTION -I SUM   (ALL is harder to parse)
#            $WORK_FILE_CPUS_ALL  #NO OPTIONS
#     -q $WORK_FILE_LOAD 
#     -R $WORK_FILE_MEMORY 
#     -r $WORK_FILE_MEMORY_UTIL 
#     -S $WORK_FILE_SWAP 
#     -u ALL $WORK_FILE_CPU_FULL 
#     -v $WORK_FILE_INODE_KER
#     -w $WORK_CONTEXT_SWITCH
#     -W $WORK_SWAP_WRITES
      
      
