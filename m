Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42306403366
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 06:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhIHEk0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 00:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhIHEk0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 00:40:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAD12610FF;
        Wed,  8 Sep 2021 04:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631075958;
        bh=UpZRQfX16jgEni17pcvYq88zgV8N8pBwwpB8Bbkle7c=;
        h=Date:From:To:Cc:Subject:From;
        b=c/hkvyBlsQh0BdQaBibFBbGVg7m4ETqO5AJqi+LdJsqMBOXRLzhevbfh0MhGRkDRD
         Kz02HmjL3nm6yWU1CkOuLDAQWCNUmzt73+5n+Zfbfzr0Ch2L20n0Soio4BuedOXeRC
         udE2myCEAVx/MtZbWDflK5mceTRapXa7/sI8SNqCkMpQWukmmUf6gX4QaYDr0AwDwC
         p5MUubEg+6KX7V137Q6ooJunhvpDVA04A+YhfXs1SzaR2bqr514hvkoCeL1UY2FHks
         TJ/Sn/jIWHSpUYhKUJNK5w86WssTZy2GQiEtmDrCmBP3QCKEwtQh9a+azCN6tEb3Co
         hQtz37+tA6ZRA==
Date:   Wed, 8 Sep 2021 10:09:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.15-rc1
Message-ID: <YTg+csY9wy4mk035@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KoQp2lLz9rVFR4nv"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--KoQp2lLz9rVFR4nv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine updates for v5.15-rc1. Please do note
that this also contains bus_remove_return_void-5.15 tag from Greg to fix
the dependencies for idxd driver.

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.15-rc1

for you to fetch changes up to 11a427be2c4749954e8b868ef5301dc65ca5a14b:

  dmaengine: sh: fix some NULL dereferences (2021-08-31 21:50:23 +0530)

----------------------------------------------------------------
dmaengine updates for v5.15-rc1

New drivers/devices
 - Support for Renesas RZ/G2L dma controller
 - New driver for AMD PTDMA controller

Updates:
 - Big pile of idxd updates
 - Updates for Altera driver, stm32-dma, dw etc

Also contains, bus_remove_return_void-5.15 to resolve dependencies

----------------------------------------------------------------
Alexander Sverdlin (1):
      dmaengine: ep93xx: Prepare clock before using it

Amelie Delaunay (2):
      dt-bindings: dma: add alternative REQ/ACK protocol selection in stm32=
-dma
      dmaengine: stm32-dma: add alternate REQ/ACK protocol management

Andy Shevchenko (6):
      dmaengine: dw: Program xBAR hardware for Elkhart Lake
      dmaengine: dw: Remove error message from DT parsing code
      dmaengine: dw: Convert members to u32 in platform data
      dmaengine: dw: Simplify DT property parser
      dmaengine: acpi: Avoid comparison GSI with Linux vIRQ
      dmaengine: acpi: Check for errors from acpi_register_gsi() separately

Baokun Li (3):
      dmaengine: xilinx_dma: Use list_move_tail instead of list_del/list_ad=
d_tail
      dmaengine: fsl-dpaa2-qdma: Use list_move_tail instead of list_del/lis=
t_add_tail
      dmaengine: zynqmp_dma: Use list_move_tail instead of list_del/list_ad=
d_tail

Biju Das (3):
      dt-bindings: dma: Document RZ/G2L bindings
      dmaengine: Extend the dma_slave_width for 128 bytes
      dmaengine: sh: Add DMAC driver for RZ/G2L SoC

Christophe JAILLET (3):
      dmaengine: idxd: Simplify code and axe the use of a deprecated API
      dmaengine: hisi_dma: Remove some useless code
      dmaengine: idxd: Fix a possible NULL pointer dereference

Cl=E9ment L=E9ger (1):
      dmaengine: at_xdmac: use platform_driver_register

Colin Ian King (2):
      dmaengine: fsl-dpaa2-qdma: Fix spelling mistake "faile" -> "failed"
      dmaengine: sh: Fix unused initialization of pointer lmdesc

Dan Carpenter (1):
      dmaengine: sh: fix some NULL dereferences

Dave Jiang (40):
      dmanegine: idxd: cleanup all device related bits after disabling devi=
ce
      dmaengine: idxd: Add wq occupancy information to sysfs attribute
      dmaengine: idxd: have command status always set
      dmaengine: idxd: add missing percpu ref put on failure
      dmaengine: idxd: assign MSIX vectors to each WQ rather than roundrobin
      dmaengine: idxd: fix sequence for pci driver remove() and shutdown()
      dmaengine: idxd: add driver register helper
      dmaengine: idxd: add driver name
      dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev
      dmaengine: idxd: remove IDXD_DEV_CONF_READY
      dmaengine: idxd: move wq_enable() to device.c
      dmaengine: idxd: move wq_disable() to device.c
      dmaengine: idxd: remove bus shutdown
      dmaengine: idxd: remove iax_bus_type prototype
      dmaengine: idxd: fix bus_probe() and bus_remove() for dsa_bus
      dmaengine: idxd: move probe() bits for idxd 'struct device' to device=
=2Ec
      dmaengine: idxd: idxd: move remove() bits for idxd 'struct device' to=
 device.c
      dmanegine: idxd: open code the dsa_drv registration
      dmaengine: idxd: add type to driver in order to allow device matching
      dmaengine: idxd: create idxd_device sub-driver
      dmaengine: idxd: create dmaengine driver for wq 'device'
      dmaengine: idxd: create user driver for wq 'device'
      dmaengine: dsa: move dsa_bus_type out of idxd driver to standalone
      dmaengine: idxd: move dsa_drv support to compatible mode
      dmaengine: idxd: remove fault processing code
      dmaengine: idxd: Set defaults for GRPCFG traffic class
      dmaengine: idxd: fix uninit var for alt_drv
      dmaengine: idxd: fix wq slot allocation index check
      dmaengine: idxd: rotate portal address for better performance
      dmanegine: idxd: add software command status
      dmaengine: idxd: fix abort status check
      dmaengine: idxd: add capability check for 'block on fault' attribute
      dmaengine: idxd: clear block on fault flag when clear wq
      dmaengine: idxd: make I/O interrupt handler one shot
      dmaengine: idxd: remove interrupt flag for completion list spinlock
      dmaengine: idxd: make submit failure path consistent on desc freeing
      dmaengine: idxd: set descriptor allocation size to threshold for swq
      dmaengine: idxd: fix setting up priv mode for dwq
      dmaengine: idxd: remove interrupt disable for cmd_lock
      dmaengine: idxd: remove interrupt disable for dev_lock

Geert Uytterhoeven (1):
      MAINTAINERS: Fix AMD PTDMA DRIVER entry

Johannes Berg (2):
      dmaengine: idxd: depends on !UML
      dmaengine: ioat: depends on !UML

Jordy Zomer (1):
      dmaengine: usb-dmac: make usb_dmac_get_current_residue unsigned

Juergen Borleis (1):
      dma: imx-dma: configure the generic DMA type to make it work

Marek Vasut (1):
      dmaengine: xilinx: Add empty device_config function

Nathan Chancellor (1):
      dmaengine: idxd: Remove unused status variable in irq_process_work_li=
st()

Olivier Dautricourt (2):
      dt-bindings: dma: altera-msgdma: make response port optional
      dmaengine: altera-msgdma: make response port optional

Pandith N (3):
      dmaengine: dw-axi-dmac: Remove free slot check algorithm in dw_axi_dm=
a_set_hw_channel
      dmaengine: dw-axi-dmac: support parallel memory <--> peripheral trans=
fers
      dmaengine: dw-axi-dmac: Burst length settings

Pratyush Yadav (1):
      dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX

Radhey Shyam Pandey (1):
      dmaengine: xilinx_dma: Set DMA mask for coherent APIs

Salah Triki (1):
      ppc4xx: replace sscanf() by kstrtoul()

Sanjay R Mehta (4):
      dmaengine: ptdma: Initial driver for the AMD PTDMA
      dmaengine: ptdma: register PTDMA controller as a DMA resource
      dmaengine: ptdma: Add debugfs entries for PTDMA
      dmaengine: ptdma: remove PT_OFFSET to avoid redefnition

Uwe Kleine-K=F6nig (5):
      PCI: endpoint: Make struct pci_epf_driver::remove return void
      s390/cio: Make struct css_driver::remove return void
      s390/ccwgroup: Drop if with an always false condition
      s390/scm: Make struct scm_driver::remove return void
      bus: Make remove callback return void

Vinod Koul (5):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge tag 'bus_remove_return_void-5.15' into next
      Merge branch 'fixes' into next
      Merge tag 'v5.14-rc5' into next

Zhang Qilong (1):
      dmaengine: tegra210-adma: Using pm_runtime_resume_and_get to replace =
open coding

Zou Wei (1):
      dmaengine: sprd: Add missing MODULE_DEVICE_TABLE

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |   9 +
 Documentation/admin-guide/kernel-parameters.txt    |   5 +
 .../devicetree/bindings/dma/altr,msgdma.yaml       |   4 +-
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   | 130 +++
 .../devicetree/bindings/dma/st,stm32-dma.yaml      |   7 +
 MAINTAINERS                                        |   6 +
 arch/arm/common/locomo.c                           |   3 +-
 arch/arm/common/sa1111.c                           |   4 +-
 arch/arm/mach-rpc/ecard.c                          |   4 +-
 arch/mips/sgi-ip22/ip22-gio.c                      |   3 +-
 arch/parisc/kernel/drivers.c                       |   5 +-
 arch/powerpc/platforms/ps3/system-bus.c            |   3 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   3 +-
 arch/powerpc/platforms/pseries/vio.c               |   3 +-
 arch/s390/include/asm/eadm.h                       |   2 +-
 arch/sparc/kernel/vio.c                            |   4 +-
 drivers/acpi/bus.c                                 |   3 +-
 drivers/amba/bus.c                                 |   4 +-
 drivers/base/auxiliary.c                           |   4 +-
 drivers/base/isa.c                                 |   4 +-
 drivers/base/platform.c                            |   4 +-
 drivers/bcma/main.c                                |   6 +-
 drivers/bus/sunxi-rsb.c                            |   4 +-
 drivers/cxl/core.c                                 |   3 +-
 drivers/dax/bus.c                                  |   4 +-
 drivers/dma/Kconfig                                |  28 +-
 drivers/dma/Makefile                               |   3 +-
 drivers/dma/acpi-dma.c                             |  18 +-
 drivers/dma/altera-msgdma.c                        |  37 +-
 drivers/dma/at_xdmac.c                             |   8 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  56 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |   4 +
 drivers/dma/dw/idma32.c                            | 138 ++-
 drivers/dma/dw/internal.h                          |  16 +
 drivers/dma/dw/of.c                                |  49 +-
 drivers/dma/dw/pci.c                               |   6 +-
 drivers/dma/dw/platform.c                          |   6 +-
 drivers/dma/ep93xx_dma.c                           |   6 +-
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  10 +-
 drivers/dma/hisi_dma.c                             |  10 +-
 drivers/dma/idxd/Makefile                          |   8 +
 drivers/dma/idxd/bus.c                             |  91 ++
 drivers/dma/idxd/cdev.c                            |  73 +-
 drivers/dma/idxd/compat.c                          | 107 +++
 drivers/dma/idxd/device.c                          | 382 ++++++--
 drivers/dma/idxd/dma.c                             |  96 +-
 drivers/dma/idxd/idxd.h                            | 167 +++-
 drivers/dma/idxd/init.c                            | 148 ++--
 drivers/dma/idxd/irq.c                             | 190 +---
 drivers/dma/idxd/registers.h                       |   6 +
 drivers/dma/idxd/submit.c                          |  43 +-
 drivers/dma/idxd/sysfs.c                           | 603 +++----------
 drivers/dma/ppc4xx/adma.c                          |  12 +-
 drivers/dma/ptdma/Kconfig                          |  13 +
 drivers/dma/ptdma/Makefile                         |  10 +
 drivers/dma/ptdma/ptdma-debugfs.c                  | 106 +++
 drivers/dma/ptdma/ptdma-dev.c                      | 305 +++++++
 drivers/dma/ptdma/ptdma-dmaengine.c                | 389 +++++++++
 drivers/dma/ptdma/ptdma-pci.c                      | 243 ++++++
 drivers/dma/ptdma/ptdma.h                          | 324 +++++++
 drivers/dma/sh/Kconfig                             |   9 +
 drivers/dma/sh/Makefile                            |   1 +
 drivers/dma/sh/rz-dmac.c                           | 969 +++++++++++++++++=
++++
 drivers/dma/sh/usb-dmac.c                          |   2 +-
 drivers/dma/sprd-dma.c                             |   1 +
 drivers/dma/stm32-dma.c                            |   8 +-
 drivers/dma/tegra210-adma.c                        |   7 +-
 drivers/dma/ti/k3-psil-j721e.c                     |  73 ++
 drivers/dma/xilinx/xilinx_dma.c                    |  17 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |   3 +-
 drivers/firewire/core-device.c                     |   4 +-
 drivers/firmware/arm_scmi/bus.c                    |   4 +-
 drivers/firmware/google/coreboot_table.c           |   4 +-
 drivers/fpga/dfl.c                                 |   4 +-
 drivers/hid/hid-core.c                             |   4 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c              |   4 +-
 drivers/hv/vmbus_drv.c                             |   5 +-
 drivers/hwtracing/intel_th/core.c                  |   4 +-
 drivers/i2c/i2c-core-base.c                        |   5 +-
 drivers/i3c/master.c                               |   4 +-
 drivers/input/gameport/gameport.c                  |   3 +-
 drivers/input/serio/serio.c                        |   3 +-
 drivers/ipack/ipack.c                              |   4 +-
 drivers/macintosh/macio_asic.c                     |   4 +-
 drivers/mcb/mcb-core.c                             |   4 +-
 drivers/media/pci/bt8xx/bttv-gpio.c                |   3 +-
 drivers/memstick/core/memstick.c                   |   3 +-
 drivers/mfd/mcp-core.c                             |   3 +-
 drivers/misc/mei/bus.c                             |   4 +-
 drivers/misc/tifm_core.c                           |   3 +-
 drivers/mmc/core/bus.c                             |   4 +-
 drivers/mmc/core/sdio_bus.c                        |   4 +-
 drivers/net/netdevsim/bus.c                        |   3 +-
 drivers/ntb/core.c                                 |   4 +-
 drivers/ntb/ntb_transport.c                        |   4 +-
 drivers/nubus/bus.c                                |   6 +-
 drivers/nvdimm/bus.c                               |   3 +-
 drivers/pci/endpoint/pci-epf-core.c                |   7 +-
 drivers/pci/pci-driver.c                           |   3 +-
 drivers/pcmcia/ds.c                                |   4 +-
 drivers/platform/surface/aggregator/bus.c          |   4 +-
 drivers/platform/x86/wmi.c                         |   4 +-
 drivers/pnp/driver.c                               |   3 +-
 drivers/rapidio/rio-driver.c                       |   4 +-
 drivers/rpmsg/rpmsg_core.c                         |   7 +-
 drivers/s390/block/scm_drv.c                       |   4 +-
 drivers/s390/cio/ccwgroup.c                        |   6 +-
 drivers/s390/cio/chsc_sch.c                        |   3 +-
 drivers/s390/cio/css.c                             |   7 +-
 drivers/s390/cio/css.h                             |   2 +-
 drivers/s390/cio/device.c                          |   9 +-
 drivers/s390/cio/eadm_sch.c                        |   4 +-
 drivers/s390/cio/scm.c                             |   5 +-
 drivers/s390/cio/vfio_ccw_drv.c                    |   3 +-
 drivers/s390/crypto/ap_bus.c                       |   4 +-
 drivers/scsi/scsi_debug.c                          |   3 +-
 drivers/sh/superhyway/superhyway.c                 |   8 +-
 drivers/siox/siox-core.c                           |   4 +-
 drivers/slimbus/core.c                             |   4 +-
 drivers/soc/qcom/apr.c                             |   4 +-
 drivers/spi/spi.c                                  |   4 +-
 drivers/spmi/spmi.c                                |   3 +-
 drivers/ssb/main.c                                 |   4 +-
 drivers/staging/fieldbus/anybuss/host.c            |   4 +-
 drivers/staging/greybus/gbphy.c                    |   4 +-
 drivers/target/loopback/tcm_loop.c                 |   5 +-
 drivers/thunderbolt/domain.c                       |   4 +-
 drivers/tty/serdev/core.c                          |   4 +-
 drivers/usb/common/ulpi.c                          |   4 +-
 drivers/usb/serial/bus.c                           |   4 +-
 drivers/usb/typec/bus.c                            |   4 +-
 drivers/vdpa/vdpa.c                                |   4 +-
 drivers/vfio/mdev/mdev_driver.c                    |   4 +-
 drivers/virtio/virtio.c                            |   3 +-
 drivers/vlynq/vlynq.c                              |   4 +-
 drivers/vme/vme.c                                  |   4 +-
 drivers/xen/xenbus/xenbus.h                        |   2 +-
 drivers/xen/xenbus/xenbus_probe.c                  |   4 +-
 drivers/zorro/zorro-driver.c                       |   3 +-
 include/linux/device/bus.h                         |   2 +-
 include/linux/dmaengine.h                          |   3 +-
 include/linux/pci-epf.h                            |   2 +-
 include/linux/platform_data/dma-dw.h               |  21 +-
 include/uapi/linux/idxd.h                          |  24 +
 sound/ac97/bus.c                                   |   6 +-
 sound/aoa/soundbus/core.c                          |   4 +-
 146 files changed, 4186 insertions(+), 1190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.y=
aml
 create mode 100644 drivers/dma/idxd/bus.c
 create mode 100644 drivers/dma/idxd/compat.c
 create mode 100644 drivers/dma/ptdma/Kconfig
 create mode 100644 drivers/dma/ptdma/Makefile
 create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
 create mode 100644 drivers/dma/ptdma/ptdma-dev.c
 create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
 create mode 100644 drivers/dma/ptdma/ptdma-pci.c
 create mode 100644 drivers/dma/ptdma/ptdma.h
 create mode 100644 drivers/dma/sh/rz-dmac.c

Thanks
--=20
~Vinod

--KoQp2lLz9rVFR4nv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmE4PnIACgkQfBQHDyUj
g0fn/xAAvyhFtlEVR2uIHkKAKCMnD4OvDmYnbJXAHp+WHfrC7Wt97LVqm2bEYCVi
9aW/jSiZ6aWYIFNscmyhkuhsztkck7PzyIih7Cc+2ORkRh5DgOo3qYa+Vbnz2ZlQ
O90A45xB5albkOGvErocH/QXOo1DYtOXLqE8PCbjl5d81zZTMACvbniHGBlD1Myg
z0YbY3qHnshRr+9e/HboQ7BdXfcevqorCIbz9hKTYVJMRx0s7kIFHPO0w4Siss3y
C4R3kgmCEIAR854JUjSIGqMjqTRe2X/NiSs1LZtx1tkPL149fCmzVcJebKsL1nJ5
DLCd/QiWSV8xS1p35J6RQ8YMab7U60ieVC4UBP57mcty6eZ1brayX8tT+UC/tBkz
h+JdxuEEt3CHPuOJ+1sx06tfErRxCLHjTxeaOQnjJnLXqe8fYD00w1TDAuTJPv4N
h3fI8tZPrL9b3Rwv4Zd25EyAvgyw2NZ48rZOsGynEboFuXAvU3xIdFN0gzHVpWOj
AgaPSkPfO1dFEqfn/ZYxUiuYgQWPF3nSzbMYc3cB9wGeS5poDFkraHhiUCkEhN7r
P0oYhCl8Eeqx7jsnQRWotE0vzrhhWH808bMNvdfOHv/1MLuM/MavmkAZjc8UsuHj
Vfud/Rap16YG6W4CeqMjMZrnaOIRGtqSRGRyF76iC+p6yu1VNUU=
=5gK1
-----END PGP SIGNATURE-----

--KoQp2lLz9rVFR4nv--
