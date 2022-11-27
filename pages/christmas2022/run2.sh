#!/bin/bash
#

exec 9<<END
Alex Christine
Allie David
Blaine Elizabeth
Caleb Hans
Carrie Jake
Christine Jas
David Jim
Elizabeth John
Hans Kelli
Jake Laura
Jas Lissa
Jim  Lucas
John Peter
Kelli Rebecca
Laura Rivers
Lissa Ruby
Lucas Sage
Peter Sam
Rebecca Shannen
Rivers Sue
Ruby Suzanne
Sage Tommy
Sam Alex
Shannen Allie
Sue Blaine
Suzanne Caleb
Tommy Carrie
END

cat <&9 | while read line; do
  giver=`echo $line | cut -d" " -f1`
  recip=`echo $line | cut -d" " -f2`
  echo "<html><body>Giver $giver gives a gift to $recip</body></html>" > ../../assets/xmas2022/$giver.html
  echo "<a href=\"https://pburkholder.dev/assets/xmas2022/$giver.html\">$giver link for gift exchange</a><br>"
done


