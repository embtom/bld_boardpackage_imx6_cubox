#!/bin/bash

simlink? () {
  test "$(readlink "${1}")";
}

cd ./poky/
#rm build-imx5 -Rf

if simlink? "meta-imx6-cubox"; then
  echo Link exits
else
  ln -s ../meta-imx6-cubox meta-imx6-cubox
fi

if simlink? "meta-embtom"; then
  echo Link exits
else
  ln -s ../meta-embtom meta-embtom
fi

if simlink? "meta-qt5"; then
  echo Link exits
else
  ln -s ../meta-qt5 meta-qt5
fi

source oe-init-build-env build-cubox
cp ../../layerConf/bblayers.conf ./conf/
cp ../../layerConf/local.conf ./conf/

bitbake cubox-embtom-image
bitbake cubox-embtom-image -c populate_sdk

mkdir -p ../../buildOut/deploy

cp tmp/deploy/images/imx6-cubox/cubox-embtom-image-imx6-cubox.wic.gz ../../buildOut/deploy
cp tmp/deploy/sdk/*.sh ../../buildOut/deploy

cd ../../buildOut/deploy && gunzip cubox-embtom-image-imx6-cubox.wic.gz -f
