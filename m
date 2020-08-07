Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB32C23E724
	for <lists+dmaengine@lfdr.de>; Fri,  7 Aug 2020 08:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgHGGF5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Aug 2020 02:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgHGGF4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 7 Aug 2020 02:05:56 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE88D20866;
        Fri,  7 Aug 2020 06:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596780355;
        bh=SZtoAZmzio3bHrmvZmazdPaIg3lLA0bdq1G1ghCmIOc=;
        h=Date:From:To:Cc:Subject:From;
        b=OxC8q3wvLnVsI0fOMpUU5SclFpeszFa7BrXLeBjNa3q4dVSWa3oiKZsttAJhsp4C/
         DxY7vIbEJPK1aPg/WaxBfC0xyp08V3Pk7mQcZx4hAUQ2g0iYOysOeOEspYxWg3uidt
         WhSutYmYPzix/uT30WtYoNTHfakAy9Im9E7Jg8vE=
Date:   Fri, 7 Aug 2020 11:35:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.9-rc1
Message-ID: <20200807060551.GL12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Now that mail.kernel.org is back, time to send the pull request.

Please pull to receive the below updates for dmaengine. Please note that
SFR has reported conflicts with MAINTAINERS file update in this request,
am sure that would be easy for you to manage :)

The following changes since commit 87730ccbddcb48478b1b88e88b14e73424130764:

  dmaengine: ioat setting ioat timeout as module parameter (2020-07-06 14:4=
9:34 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.9-rc1

for you to fetch changes up to 00043a2689232631f39ebbf6719d545b1d799086:

  Merge branch 'topic/xilinx' into fixes (2020-08-07 11:13:37 +0530)

----------------------------------------------------------------
dmaengine updates for v5.9-rc1

Core:
 - Support out of order dma completion
 - Support for repeating transaction

New controllers:
 - Support for Actions S700 DMA engine
 - Renesas R8A774E1, r8a7742 controller binding
 - New driver for Xilinx DPDMA controller

Others:
 - Support of out of order dma completion in idxd driver
 - W=3D1 warning cleanup of subsystem
 - Updates to ti-k3-dma, dw, idxd drivers

----------------------------------------------------------------
Amit Singh Tomar (3):
      dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
      dmaengine: Actions: get rid of bit fields from dma descriptor
      dmaengine: Actions: Add support for S700 DMA engine

Andy Shevchenko (4):
      dmaengine: dw: Register ACPI DMA controller for PCI that has companion
      dmaengine: dw: Replace 'objs' by 'y'
      dmaengine: acpi: Drop double check for ACPI companion device
      dmaengine: dw: Don't include unneeded header to platform data header

Dave Jiang (6):
      dmaengine: cookie bypass for out of order completion
      dmaengine: idxd: add leading / for sysfspath in ABI documentation
      dmaengine: idxd: move submission to sbitmap_queue
      dmaengine: idxd: add work queue drain support
      dmaengine: idxd: move idxd interrupt handling to mask instead of igno=
re
      dmaengine: idxd: add missing invalid flags field to completion

Gustavo A. R. Silva (2):
      dmaengine: hisilicon: Use struct_size() in devm_kzalloc()
      dmaengine: ti: k3-udma: Use struct_size() in kzalloc()

Hyun Kwon (1):
      dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver

Koehrer Mathias (ETAS/EES-SL) (1):
      dmaengine: Extend NXP QDMA driver to check transmission errors

Lad Prabhakar (3):
      dt-bindings: dmaengine: renesas,usb-dmac: Add binding for r8a7742
      dt-bindings: dma: renesas,rcar-dmac: Document R8A774E1 bindings
      dt-bindings: dma: renesas,usb-dmac: Add binding for r8a774e1

Laurent Pinchart (3):
      dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
      dmaengine: Add support for repeating transactions
      dmaengine: xilinx: dpdma: Fix kerneldoc warning

Lee Jones (17):
      dmaengine: mediatek: mtk-hsdma: Fix formatting in 'struct mtk_hsdma_p=
desc' doc block
      dmaengine: of-dma: Fix misspellings/formatting issues in some functio=
n headers
      dmaengine: ep93xx_dma: Provide some missing struct attribute document=
ation
      dmaengine: mmp_pdma: Demote obvious misuse of kerneldoc to standard c=
omment blocks
      dmaengine: pl330: Demote obvious misuse of kerneldoc to standard comm=
ent block
      dmaengine: ste_dma40: Supply 2 missing struct attribute descriptions
      dmaengine: altera-msgdma: Fix struct documentation blocks
      dmaengine: at_hdmac: Repair parameter misspelling and demote non-kern=
eldoc headers
      dmaengine: sun4i-dma: Demote obvious misuse of kerneldoc to standard =
comment blocks
      dmaengine: fsl-qdma: Fix 'struct fsl_qdma_format' formatting issue
      dmaengine: imx-sdma: Correct formatting issue and provide 2 new descr=
iptions
      dmaengine: iop-adma: Function parameter documentation must adhere to =
correct formatting
      dmaengine: nbpfaxi: Provide some missing attribute docs and split out=
 slave info
      dmaengine: xgene-dma: Provide descriptions for 'dev' and 'clk' in dev=
ice's ddata
      dmaengine: mv_xor_v2: Supply some missing 'struct mv_xor_v2_device' a=
ttribute docs
      dmaengine: ioat: init: Correct misspelling of function parameter 'c' =
for channel
      dmaengine: ioat: Fix some parameter misspelling and provide descripti=
on for phys_complete

Lubomir Rintel (2):
      dmaengine: mmp_pdma: Do not warn when IRQ is shared by all chans
      dmaengine: mmp_tdma: share the IRQ line

Ludovic Desroches (1):
      MAINTAINERS: dmaengine: Microchip: add Tudor Ambarus as co-maintainer

Peter Ujfalusi (7):
      dmaengine: ti: k3-udma: Remove dma_sync_single calls for descriptors
      dmaengine: ti: k3-udma: Do not use ring_get_occ in udma_pop_from_ring
      dmaengine: ti: k3-udma: Use common defines for TCHANRT/RCHANRT regist=
ers
      dmaengine: ti: k3-udma-private: Use udma_read/write for register acce=
ss
      dmaengine: ti: k3-udma: Use udma_chan instead of tchan/rchan for IO f=
unctions
      dmaengine: ti: k3-udma: Use defines for capabilities register parsing
      dmaengine: ti: k3-udma: Query throughput level information from hardw=
are

Randy Dunlap (3):
      Documentation/driver-api: dmaengine/provider: drop doubled word
      dmaengine: idxd: fix PCI_MSI build errors
      dmaengine: linux/dmaengine.h: drop duplicated word in a comment

Serge Semin (10):
      dt-bindings: dma: dw: Convert DW DMAC to DT binding
      dt-bindings: dma: dw: Add max burst transaction length property
      dmaengine: Introduce min burst length capability
      dmaengine: Introduce max SG burst capability
      dmaengine: Introduce DMA-device device_caps callback
      dmaengine: dw: Take HC_LLP flag into account for noLLP auto-config
      dmaengine: dw: Set DMA device max segment size parameter
      dmaengine: dw: Initialize min and max burst DMA device capability
      dmaengine: dw: Introduce max burst length hw config
      dmaengine: dw: Initialize max_sg_burst capability

Sugar Zhang (5):
      dmaengine: pl330: Make sure the debug is idle before doing DMAGO
      dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
      dmaengine: pl330: Improve transfer efficiency for the dregs
      dt-bindings: dma: pl330: Document the quirk 'arm,pl330-periph-burst'
      dmaengine: pl330: Add quirk 'arm,pl330-periph-burst'

Vinod Koul (5):
      MAINTAINERS: switch dmaengine tree to kernel.org
      dmaengine: xilinx: dpdma: remove comparison of unsigned expression
      dmaengine: xilinx: dpdma: add missing kernel doc
      Merge branch 'for-linus' into fixes
      Merge branch 'topic/xilinx' into fixes

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |   56 +-
 .../devicetree/bindings/dma/arm-pl330.txt          |    1 +
 Documentation/devicetree/bindings/dma/owl-dma.txt  |   47 -
 Documentation/devicetree/bindings/dma/owl-dma.yaml |   79 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |    1 +
 .../devicetree/bindings/dma/renesas,usb-dmac.yaml  |    2 +
 .../bindings/dma/snps,dma-spear1340.yaml           |  176 +++
 Documentation/devicetree/bindings/dma/snps-dma.txt |   69 -
 .../bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml     |   68 +
 Documentation/driver-api/dmaengine/client.rst      |    4 +-
 Documentation/driver-api/dmaengine/provider.rst    |   70 +-
 MAINTAINERS                                        |   40 +-
 drivers/dma/Kconfig                                |   13 +-
 drivers/dma/acpi-dma.c                             |   17 +-
 drivers/dma/altera-msgdma.c                        |    6 +-
 drivers/dma/at_hdmac.c                             |    6 +-
 drivers/dma/dmaengine.c                            |   12 +
 drivers/dma/dmatest.c                              |   11 +-
 drivers/dma/dw/Makefile                            |    6 +-
 drivers/dma/dw/acpi.c                              |    2 +
 drivers/dma/dw/core.c                              |   48 +-
 drivers/dma/dw/of.c                                |    5 +
 drivers/dma/dw/pci.c                               |    4 +
 drivers/dma/dw/regs.h                              |    3 +
 drivers/dma/ep93xx_dma.c                           |    2 +
 drivers/dma/fsl-qdma.c                             |   65 +-
 drivers/dma/hisi_dma.c                             |    5 +-
 drivers/dma/idxd/cdev.c                            |    3 +
 drivers/dma/idxd/device.c                          |  222 ++-
 drivers/dma/idxd/dma.c                             |    3 +-
 drivers/dma/idxd/idxd.h                            |   21 +-
 drivers/dma/idxd/init.c                            |   34 +-
 drivers/dma/idxd/irq.c                             |   43 +-
 drivers/dma/idxd/submit.c                          |   74 +-
 drivers/dma/idxd/sysfs.c                           |   22 +-
 drivers/dma/imx-sdma.c                             |    4 +-
 drivers/dma/ioat/dma.c                             |    7 +-
 drivers/dma/ioat/init.c                            |    2 +-
 drivers/dma/iop-adma.c                             |    3 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |    8 +-
 drivers/dma/mmp_pdma.c                             |    8 +-
 drivers/dma/mmp_tdma.c                             |    2 +-
 drivers/dma/mv_xor_v2.c                            |    6 +-
 drivers/dma/nbpfaxi.c                              |   13 +-
 drivers/dma/of-dma.c                               |    8 +-
 drivers/dma/owl-dma.c                              |  139 +-
 drivers/dma/pl330.c                                |   66 +-
 drivers/dma/ste_dma40.c                            |    2 +
 drivers/dma/sun4i-dma.c                            |   12 +-
 drivers/dma/ti/k3-udma-glue.c                      |   79 +-
 drivers/dma/ti/k3-udma-private.c                   |    8 +-
 drivers/dma/ti/k3-udma.c                           |  309 ++--
 drivers/dma/ti/k3-udma.h                           |   69 +-
 drivers/dma/xgene-dma.c                            |    2 +
 drivers/dma/xilinx/Makefile                        |    1 +
 drivers/dma/xilinx/xilinx_dpdma.c                  | 1535 ++++++++++++++++=
++++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h        |   16 +
 include/linux/dmaengine.h                          |   37 +-
 include/linux/platform_data/dma-dw.h               |   10 +-
 include/uapi/linux/idxd.h                          |    6 +
 60 files changed, 2779 insertions(+), 813 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dma-spear134=
0.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/snps-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqm=
p-dpdma.yaml
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

Thanks
--=20
~Vinod

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl8s7z8ACgkQfBQHDyUj
g0cYvA/+Pzjb+bwnGmzeqSm/o9UFpoyaZvfANPGgQ8YegE+fdjFvQVOHVAp5KsWe
mLKl0Rm+zCf+czgM7kL1CgQNJqDmH/v0HnLjfseFkhWQzwusTgaPBEBgfIvFrtel
dW435wOgJna8DfHjLQ32Ylcx7SmmmQzWbCjZm4hN5PBKT5HFO1n8BZOgPZbCM3o/
tETsenEa7VAFB984zQNmmhx/okcnloK7JzMAHzDnlxbinkGfPYJH+O4N9GNi7tCy
Z7FMAu3NBQPSUeX/+OoqgnPwi9RzDJR7l/tLlsU3I2nm2BU1IY+XwwKWE836DWwk
KRowELvizJFn+57HDqnSnNxVXuCBe0FpViOldH71BnAVlXZmrBPHkwTV+lmrZzZa
SWD+Se6BdCMayZTXvuXHWwRmyydfwAqySJ3UmOx3HvdivbYcTZpe6ZnWSTjxHDRp
QuVHNyzDXJUT1fpSDQGODNRbPrQTuCntdOne7mM2Nm/4e4owDyHQeq40MU0xH15l
Sv7X4s9Q2JlEETc0n7tEhzbdunLa/jwTgB5mpaZAftXgMCrddFx+NQzv6smuS1jY
SxLPqO3N6Voipw3o2hUGzBQK1TtAOG1/gXc6uart/mbp8XczwByAMt5vIO3CckZy
Fh3T+4nknx8GvxPxZnII8SciTvhSI4Abh4R/eaYC7bEjppCjkGY=
=0Psa
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
