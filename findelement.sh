#! /bin/bash
sddsprintout $1 -col=ElementName | grep $2 -i -n | sed s/:// | awk '{if ($1>4) print ($1-4)/2}'

