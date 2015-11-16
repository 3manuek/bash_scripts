#http://www.esdebian.org/articulos/36816/dos-scripts-utiles-fans-consolas-diccionarios-on-line

#!/bin/bash
Diccionario="http://buscon.rae.es/draeI/SrvltGUIBusUsual?origen=RAE&LEMA=$1" # RAE
#Diccionario="http://buscon.rae.es/dpdI/SrvltGUIBusDPD?origen=RAE&lema=$1"    # Panhispánico
lynx -useragent=mozilla -display_charset=UTF-8 -dump -nolist "$Diccionario" 2> /dev/null


#!/bin/bash
# buscador múltiple de word reference
# introducir wr seguido de los terminos a buscar en inglés
echo RESULTADOS DE BUSQUEDA DE:
echo $@
for i
do
        echo -e ++++++++++++++++++++++++++++++++++++++++++++
        echo -e WORD REFERENCE: $i
        echo -e ++++++++++++++++++++++++++++++++++++++++++++"\n"
        wget http://wordreference.com/es/translation.asp\?tranword=$i\&dict=enes\&B10=Search -U mozilla -q -O /tmp/wordref$i
        html2text -utf8 -o /tmp/wordref$i.txt /tmp/wordref$i
        cat /tmp/wordref$i.txt|tail -n +20|head -n 20
        rm /tmp/wordref$i /tmp/wordref$i.txt
done


#!/bin/bash
# buscador múltiple del diccionario de la RAE
# introducir rae seguido de los terminos a buscar en inglés
echo RESULTADOS DE BUSQUEDA DE:
echo $@
for i
do
        echo -e ++++++++++++++++++++++++++++++++++++++++++++
        echo -e Diccionario RAE: $i
        echo -e ++++++++++++++++++++++++++++++++++++++++++++"\n"
        wget buscon.rae.es/draeI/SrvltGUIBusUsual\?LEMA=$i\&origen=RAE\&TIPO_BUS=3 -q -U mozilla -O /tmp/rae$i
        html2text -o /tmp/rae$i.txt /tmp/rae$i
        cat /tmp/rae$i.txt|head -n 24
        rm /tmp/rae$i /tmp/rae$i.txt
done

