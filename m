Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7151B4A87
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2019 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfIQJdk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Sep 2019 05:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfIQJdk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Sep 2019 05:33:40 -0400
Received: from localhost (unknown [122.167.81.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2070120862;
        Tue, 17 Sep 2019 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568712819;
        bh=JRId7hSefq1FkbBfit2jTyVG+T17WzZuUZkLZOYgGZc=;
        h=Date:From:To:Cc:Subject:From;
        b=LY7/wk/3Xn63wgREdRR2+vzA5owG4NDcZKIj1EiesxLrw60vdM9sOzk7/w/NoGcFK
         y3aBifWugON1DYBKUQycz5TpZ4m+q6oj2k71w3IPsLVE7yXnHquF2zcHK2dJLHYgZs
         ao0kJZqRJlfI/rI3wgQukMgq3pfgei6h9aV0BjVQ=
Date:   Tue, 17 Sep 2019 15:02:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine updates for v5.4-rc1
Message-ID: <20190917093229.GL4392@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to receive following changes for v5.4-rc1.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.4-rc1

for you to fetch changes up to c5c6faaee6e0c374c7dfaf053aa23750f5a68e20:

  dmaengine: ti: edma: Use bitmap_set() instead of open coded edma_set_bits=
() (2019-09-04 15:19:19 +0530)

----------------------------------------------------------------
dmaengine updates for v5.4-rc1

 - Move Dmaengine DT bindings to YAML and convert Allwinner to schema.
 - FSL dma device_synchronize implementation
 - DW split acpi and of helpers and updates to driver and support for Elkha=
rt
   Lake
 - Move filter fn as private for omap-dma and edma drivers and improvements
   to these drivers
 - Mark expected switch fall-through in couple of drivers
 - Renames of shdma and nbpfaxi binding document
 - Minor updates to bunch of drivers

----------------------------------------------------------------
Andrey Smirnov (1):
      dmaengine: fsl-edma: implement .device_synchronize callback

Andy Shevchenko (12):
      dmaengine: stm32-dmamux: Switch to use device_property_count_u32()
      dmaengine: stm32-mdma: Switch to use device_property_count_u32()
      dmaengine: acpi: Set up DMA mask based on CSRT
      dmaengine: acpi: Add kernel doc parameter descriptions
      dmaengine: dw: Export struct dw_dma_chip_pdata for wider use
      dmaengine: dw: platform: Use struct dw_dma_chip_pdata
      dmaengine: dw: platform: Enable iDMA 32-bit on Intel Elkhart Lake
      dmaengine: dw: platform: Use devm_platform_ioremap_resource()
      dmaengine: dw: platform: Switch to acpi_dma_controller_register()
      dmaengine: dw: platform: Move handle check to dw_dma_acpi_controller_=
register()
      dmaengine: dw: platform: Split ACPI helpers to separate module
      dmaengine: dw: platform: Split OF helpers to separate module

Arnd Bergmann (3):
      dmaengine: omap-dma: make omap_dma_filter_fn private
      dmaengine: edma: make edma_filter_fn private
      dmaengine: ti: unexport filter functions

Denis Efremov (1):
      MAINTAINERS: dmaengine: dw axi dmac: Fix typo in a path

Dmitry Osipenko (1):
      dmaengine: tegra-apb: Support per-burst residue granularity

Fuqian Huang (3):
      dmaengine: imx-sdma: Remove call to memset after dma_alloc_coherent
      dmaengine: qcom_hidma: Remove call to memset after dmam_alloc_coherent
      dmaengine: pl330: use the same attributes when freeing pl330->mcode_c=
pu

Gustavo A. R. Silva (4):
      dmaengine: imx-dma: Mark expected switch fall-through
      dmaengine: fsldma: Mark expected switch fall-through
      dmanegine: ioat/dca: Use struct_size() helper
      dmaengine: stm32-dma: Use struct_size() helper

Jarkko Nikula (1):
      dmaengine: dw: Update Intel Elkhart Lake Service Engine acronym

Jonathan Hunter (1):
      dmaengine: tegra210-adma: Don't program FIFO threshold

Mao Wenan (2):
      dmaengine: make mux_configure32 static
      dmaengine: change alignment of mux_configure32 and fsl_edma_chan_mux

Maxime Ripard (3):
      dt-bindings: dmaengine: Add YAML schemas for the generic DMA bindings
      dt-bindings: dmaengine: Convert Allwinner A10 DMA to a schema
      dt-bindings: dmaengine: Convert Allwinner A31 and A64 DMA to a schema

Nathan Huckleberry (1):
      dmaengine: mv_xor_v2: Fix -Wshift-negative-value

Nishka Dasgupta (1):
      dmaengine: qcom: hidma_mgmt: Add of_node_put() before goto

Paul Cercueil (1):
      dmaengine: dma-jz4780: Break descriptor chains on JZ4740

Peter Ujfalusi (12):
      dmaengine: ti: omap-dma: Readability cleanup in omap_dma_tx_status()
      dmaengine: ti: omap-dma: Improved memcpy polling support
      dmaengine: ti: edma: Clean up the 2x32bit array register accesses
      dmaengine: ti: edma: Correct the residue calculation (fix for memcpy)
      dmaengine: ti: edma: Support for polled (memcpy) completion
      dmaengine: ti: edma: Remove 'Assignment in if condition'
      dmaengine: ti: omap-dma: Remove 'Assignment in if condition'
      dmaengine: ti: omap-dma: Remove variable override in omap_dma_tx_stat=
us()
      dmaengine: dmatest: Add support for completion polling
      dmaengine: ti: edma: Do not reset reserved paRAM slots
      dmaengine: ti: edma: Only reset region0 access registers
      dmaengine: ti: edma: Use bitmap_set() instead of open coded edma_set_=
bits()

Randy Dunlap (1):
      dmaengine: iop-adma.c: fix printk format warning

Robin Gong (1):
      dmaengine: fsl-edma: add i.mx7ulp edma2 version support

Simon Horman (2):
      dt-bindings: dmaengine: shdma: Rename bindings documentation file
      dt-bindings: dmaengine: nbpfaxi: Rename bindings documentation file

Stefan Wahren (1):
      dmaengine: bcm2835: Print error in case setting DMA mask fails

Stephen Boyd (1):
      dmaengine: Remove dev_err() usage after platform_get_irq()

Yoshihiro Shimoda (1):
      dt-bindings: dmaengine: dma-common: Fix the dma-channel-mask property

YueHaibing (1):
      dmaengine: iop-adma: remove set but not used variable 'slots_per_op'

 .../bindings/dma/allwinner,sun4i-a10-dma.yaml      |  55 +++++
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |  88 ++++++++
 .../bindings/dma/allwinner,sun6i-a31-dma.yaml      |  62 ++++++
 .../devicetree/bindings/dma/dma-common.yaml        |  45 ++++
 .../devicetree/bindings/dma/dma-controller.yaml    |  35 ++++
 .../devicetree/bindings/dma/dma-router.yaml        |  50 +++++
 Documentation/devicetree/bindings/dma/dma.txt      | 114 +----------
 .../dma/{nbpfaxi.txt =3D> renesas,nbpfaxi.txt}       |   0
 .../bindings/dma/{shdma.txt =3D> renesas,shdma.txt}  |   0
 .../devicetree/bindings/dma/sun4i-dma.txt          |  45 ----
 .../devicetree/bindings/dma/sun6i-dma.txt          |  81 --------
 MAINTAINERS                                        |   2 +-
 drivers/dma/acpi-dma.c                             |  12 +-
 drivers/dma/bcm2835-dma.c                          |   4 +-
 drivers/dma/dma-jz4780.c                           |  19 +-
 drivers/dma/dmatest.c                              |  35 +++-
 drivers/dma/dw/Makefile                            |   4 +-
 drivers/dma/dw/acpi.c                              |  53 +++++
 drivers/dma/dw/internal.h                          |  51 +++++
 drivers/dma/dw/of.c                                | 131 ++++++++++++
 drivers/dma/dw/pci.c                               |  62 ++----
 drivers/dma/dw/platform.c                          | 221 +++++------------=
---
 drivers/dma/fsl-edma-common.c                      |  20 +-
 drivers/dma/fsl-edma-common.h                      |   4 +
 drivers/dma/fsl-edma.c                             |  81 +++++++-
 drivers/dma/fsl-qdma.c                             |   9 +-
 drivers/dma/fsldma.c                               |   1 +
 drivers/dma/imx-dma.c                              |   1 +
 drivers/dma/imx-sdma.c                             |   4 -
 drivers/dma/ioat/dca.c                             |   3 +-
 drivers/dma/iop-adma.c                             |   6 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |   4 +-
 drivers/dma/mv_xor_v2.c                            |  11 +-
 drivers/dma/pl330.c                                |   9 +-
 drivers/dma/qcom/hidma_ll.c                        |   2 -
 drivers/dma/qcom/hidma_mgmt.c                      |   9 +-
 drivers/dma/s3c24xx-dma.c                          |   5 +-
 drivers/dma/sh/rcar-dmac.c                         |   4 +-
 drivers/dma/sh/usb-dmac.c                          |   4 +-
 drivers/dma/st_fdma.c                              |   4 +-
 drivers/dma/stm32-dma.c                            |  18 +-
 drivers/dma/stm32-dmamux.c                         |   3 +-
 drivers/dma/stm32-mdma.c                           |   7 +-
 drivers/dma/sun4i-dma.c                            |   4 +-
 drivers/dma/sun6i-dma.c                            |   4 +-
 drivers/dma/tegra20-apb-dma.c                      |  75 ++++++-
 drivers/dma/tegra210-adma.c                        |  12 +-
 drivers/dma/ti/edma.c                              | 228 +++++++++++++----=
----
 drivers/dma/ti/omap-dma.c                          |  62 +++---
 drivers/dma/uniphier-mdmac.c                       |   5 +-
 drivers/dma/xgene-dma.c                            |   8 +-
 include/linux/edma.h                               |  29 ---
 include/linux/omap-dma.h                           |   2 -
 include/linux/omap-dmaengine.h                     |  18 --
 54 files changed, 1083 insertions(+), 742 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun4i-a=
10-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun50i-=
a64-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun6i-a=
31-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/dma-common.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/dma-controller.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/dma/dma-router.yaml
 rename Documentation/devicetree/bindings/dma/{nbpfaxi.txt =3D> renesas,nbp=
faxi.txt} (100%)
 rename Documentation/devicetree/bindings/dma/{shdma.txt =3D> renesas,shdma=
=2Etxt} (100%)
 delete mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/sun6i-dma.txt
 create mode 100644 drivers/dma/dw/acpi.c
 create mode 100644 drivers/dma/dw/of.c
 delete mode 100644 include/linux/edma.h
 delete mode 100644 include/linux/omap-dmaengine.h

Thanks
--=20
~Vinod

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdgKgtAAoJEHwUBw8lI4NHqV8QAKz9VCY/EFLV7lrRl1azKkLc
X7NBzMbsXTC0OmNE2OGUVYUMho8MBSKsJqdXWR/kxXXuU8y1v3ibcxK7kgUVS8es
bru+D1el7AdUGAX3H8l7zO9j6TrqemV2fOj23zULGomrpM8aWZBgRM3thsbOykNf
AzatoKNfLHVnlYFfgtYmZDUo/GVyE8AkRIWznZpAVueAuCnXSfa9tIZIHeYJMFsE
jnjYdRdcSUE45WnmxMLK1KEjrYjnyzIx/NpgJIgCbsiyLu6BfZaqSPPvcWPlMin2
HC9uR1Sm6gv7uOP68OlveBMIAhG8a2kUmEiQV4hjPScDanIhuY0ZZIHfLtZqLyfz
FTPrAwey0HIql3p+Dwyhca5AgNYvdtpmBUaCzRHe9JYYy1eHiA5p2ILpQRHsDEAS
vxLk1Q21ZmV75cGbctY8hoJ1NMxsi2JXV57U8vuxHILaJgr82bChU+/qpXaerPYj
VfLC7NJyg4oJudTF1WIiSIGX+HkbQPwqxQOt6qP9hF0ic6S5KVx0HxHO299IIBXt
QK0gFMPp6A/HsB3NDhnE3jOPD121egyYmFd3FNaL+2VGmlxeZj1N2aSGrrq462l2
EDMPdwkm62qe+79Wg2GWVtrtVEAMIeEhVBGSPonG0OthllkMMA3mftB3I+Upesza
M6i9cvACIcEFUnQQ+tGF
=4mv6
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
