#!/bin/bash


if [ $# -lt 4 ];then
	echo "Usage "
	echo "PARAM 1 : - The path that stores the Image. Must not exsit already."
	echo "PARAM 2 : - iframe size x, default 8500"
	echo "PARAM 3 : - iframe size y, default 8600"
	echo "PARAM 4 : - webkit2png path, get this module from github https://github.com/adamn/python-webkit2png, assume this source code folder is /home/somebody/webkit2png, then this parameter should be /home/somebody/webkit2png . "
	
	echo "Note: this script needs a linux environment to run, and webkit2png must be already installed."
	exit -1;
fi


TARGET_FOLDER=$1
TARGET_FOLDER=${TARGET_FOLDER%/}
RES_X=$2
RES_Y=$3
BIN=$4
BIN=${BIN%/}
HTMLFILE="cache.html"
LOGFILE="log.txt"

if [ ! -d $TARGET_FOLDER ];then
  mkdir $TARGET_FOLDER ;
else
  echo "Target Folder $TARGET_FOLDER exsits, exit." ;
  exit -1 ;
fi

cd $TARGET_FOLDER;

echo "=============Start Download Google Maps============" > $LOGFILE ;

la="-35.150000"
lo="149.000000"
la_step="-0.0090126"
lo_step="0.0109745"

for y in {0..39..1}
  do
    for x in {0..39..1}
    do
      cd $TARGET_FOLDER;
      la_cur=$(echo "$la + $x * $la_step" | bc -l) 
      lo_cur=$(echo "$lo + $y * $lo_step" | bc -l)
      
      echo "$x, $y, $la_cur, $lo_cur" ;
      echo "$x, $y, $la_cur, $lo_cur" >> $LOGFILE ;
      
      echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" > $HTMLFILE ;

      echo "<html xmlns=\"http://www.w3.org/1999/xhtml\">" >> $HTMLFILE ;
      echo "<head>" >> $HTMLFILE ;
      echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />" >> $HTMLFILE ;
      echo "<title>Google Maps</title>" >> $HTMLFILE ;
      echo "</head>" >> $HTMLFILE ;
      echo "<body>" >> $HTMLFILE ;

      echo "<iframe width=\"$RES_X\" height=\"$RES_Y\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" marginwidth=\"0\" src=\"https://maps.google.com.au/?ie=UTF8&amp;ll=" >> $HTMLFILE ;
      echo "$la_cur,$lo_cur" >> $HTMLFILE ;
      echo "&amp;spn=0.000896,0.001206&amp;t=k&amp;z=20&amp;output=embed\"></iframe>" >> $HTMLFILE ;


      echo "</body>" >> $HTMLFILE ;
      echo "</html>" >> $HTMLFILE ;
      
      
      $BIN/scripts/webkit2png "-T" "-w" "2" "-x" "$RES_X" "$RES_Y" "-F" "javascript" "-o" "$TARGET_FOLDER/Image_${x}_${y}.png" "file://$TARGET_FOLDER/$HTMLFILE" ;
      sleep 5 ;
      echo "done."
      rm -rf $TARGET_FOLDER/$HTMLFILE ;
    
    done
done

#crop example, coz the actual image is 8508x8610, 204 and 313 is the top left corner.

#echo "Cropping Images to 8000x8000."
#cd $TARGET_FOLDER;
#mogrify -crop 8000x8000+204+313 *.png ;
#echo "Cropping is done."


echo "=============Finish Download Google Maps============" > $LOGFILE ;




