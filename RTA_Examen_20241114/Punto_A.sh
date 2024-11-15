Punto A: Primero vemos los discos de la maquina virtual:

sudo fdisk -l


Acceder al disco de 1gb:

sudo fdisk /dev/sdd


Particionar como indica el ejercicio (5mb):

add a new partition=
n

Default=
p

Default=
1

Enter

Espacio=
+5M

change a partition type=
t

Linux LVM=
8e

Guardar=
wq


Se convierte la particion a volumen fisico:

sudo pvcreate /dev/sdd1


Creamos el grupo de volumenes “VG” (vg_datos):

sudo vgcreate vg_datos /dev/sdd1


Acceder al disco de 2gb:

sudo fdisk /dev/sdc


Particionar como indica el ejercicio (1.5gb):

add a new partition=
n

Default=
p

Default=
1

Enter

Espacio=
+1.5G

change a partition type=
t

Linux LVM=
8e

Guardar=
wq


Luego volvemos a convertir a volumen fisico:

sudo pvcreate /dev/sdc1


Creamos el grupo de volumenes VG:

sudo vgextend vg_datos /dev/sdc1

Acceder al disco de 2gb:

sudo fdisk /dev/sdc


Particionar como indica el ejercicio (512mb):

add a new partition=
n

Default=
p

Default=
1

Enter

Espacio=
Enter

change a partition type=
t

2

Linux LVM=
8e

Guardar=
wq


Luego volvemos a convertir a volumen fisico:

sudo pvcreate /dev/sdc2


Creamos el grupo de volumenes (VG):

sudo vgcreate vg_temp /dev/sdc2


Corroborar que los grupos de volumenes esten bien asignados:

sudo vgs


Creamos el volumen logico de lv_docker “LV”:

sudo lvcreate -L +4M vg_datos -n lv_docker


Creamos el volumen logico de lv_workareas:

sudo lvcreate -l +100%FREE vg_datos -n lv_workareas


Creamos el volumen logico de lv_swap:

sudo lvcreate -l +100%FREE vg_temp -n lv_swap


Corroboramos que los volumenes logicos esten bien asignados:

sudo lvs


Primero para hacer el montaje hay que dar un formato o file system

Hacemos sudo fdisk -l para ver las particiones creadas y rutas.

-Y formateamos las particiones: 

Ej: Sudo mksf.ext4 /dev/<tu ruta de la particion>

sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker

sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas

-El swap tiene un formateo distinto:

sudo mkswap /dev/mapper/vg_temp-lv_swap


-Por ultimo, queda montarlos:

sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker

sudo mount /dev/mapper/vg_datos-lv_workareas /work/

-Corroborar que se hayan montado correctamente con ‘df -h’

sudo swapon /dev/vg_temp/lv_swap

-Corroborar que se haya montado con ‘free -h’
