if cat /etc/issue | grep Ubuntu; then

BUILDSTRUCT=linux

else

BUILDSTRUCT=darwin

fi

if [ -e $BUILDSTRUCT/mkbootimg ]; then
rm $BUILDSTRUCT/mkbootimg
fi
if [ -e $BUILDSTRUCT/unpackbootimg ]; then
rm $BUILDSTRUCT/unpackbootimg
fi

cd replicant-system_core
gcc -o ../$BUILDSTRUCT/mkbootimg libmincrypt/*.c mkbootimg/mkbootimg.c -Iinclude
gcc -o ../$BUILDSTRUCT/unpackbootimg libmincrypt/*.c mkbootimg/unpackbootimg.c -Iinclude

cd ../

if [ -e $BUILDSTRUCT/simg2img ]; then
rm $BUILDSTRUCT/simg2img
fi

cd simg2img
gcc -c sparse_crc32.c
gcc sparse_crc32.o simg2img.c -w -o ../$BUILDSTRUCT/simg2img

cd ../

if [ -e $BUILDSTRUCT/dtbtool ]; then
rm $BUILDSTRUCT/dtbtool
fi

cd dtbtool
gcc dtbtool.c -w -o ../$BUILDSTRUCT/dtbtool

cd ../