Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8956A50F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 11:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGPJkK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 05:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfGPJkJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jul 2019 05:40:09 -0400
Received: from localhost (unknown [122.178.232.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90562145D;
        Tue, 16 Jul 2019 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563270007;
        bh=8DwohLaEDxEgS1oQjjXx7A30jUcmngovmOWF5ubvbF0=;
        h=Date:From:To:Cc:Subject:From;
        b=XqaQxf04Av0c5JQvhDumOn98Vh5Mt7MaQE00l99xIX2HWslWIX9Hn3x6SX+Q8GI0u
         K4veKdxrVXQ4GM6rAwHLA7OfY5dZsK2sg14qylTz4C4nvtkcUKjBtPF3QoxgTbHp+w
         jjJB6hYiJdFMgDeUZEmCj2/LRIPsEOGiv5OkGCRY=
Date:   Tue, 16 Jul 2019 15:06:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine updates for v5.3-rc1
Message-ID: <20190716093657.GD12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the update for v5.3-rc1. Please note there will be trivial
merge conflict with your tree due to a) SPDX conflicts and
b) removal of sudmac driver and addition of spdx tags to it.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.3-rc1

for you to fetch changes up to 5c274ca4cfb22a455e880f61536b1894fa29fd17:

  dmaengine: Revert "dmaengine: fsl-edma: add i.mx7ulp edma2 version suppor=
t" (2019-07-08 09:44:45 +0530)

----------------------------------------------------------------
dmaengine updates for v5.3-rc1

 - Add support in dmaengine core to do device node checks for DT devices and
   update bunch of drivers to use that and remove open coding from drivers
 - New driver/driver support for new hardware, namely:
   - MediaTek UART APDMA
   - Freescale i.mx7ulp edma2
   - Synopsys eDMA IP core version 0
   - Allwinner H6 DMA
 - Updates to axi-dma and support for interleaved cyclic transfers
 - Greg's debugfs return value check removals on drivers
 - Updates to stm32-dma, hsu, dw, pl330, tegra drivers

----------------------------------------------------------------
Alexandru Ardelean (7):
      include: fpga: adi-axi-common.h: add common regs & defs header
      dmaengine: axi-dmac: assign `copy_align` property
      dmaengine: axi-dmac: update license header
      dmaengine: virt-dma: store result on dma descriptor
      dmaengine: axi-dmac: populate residue info for completed xfers
      dmaengine: axi-dmac: terminate early DMA transfers after a partial one
      dmaengine: axi-dmac: add regmap support

Amelie Delaunay (1):
      dmaengine: stm32-dma: Fix redundant call to platform_get_irq

Andy Shevchenko (3):
      dmaengine: hsu: Revert "set HSU_CH_MTSR to memory width"
      dmaengine: dw: Distinguish ->remove() between DW and iDMA 32-bit
      dmaengine: dw: Enable iDMA 32-bit on Intel Elkhart Lake

Baolin Wang (8):
      dmaengine: Add matching device node validation in __dma_request_chann=
el()
      soc: tegra: fuse: Use dma_request_channel instead of __dma_request_ch=
annel()
      dmaengine: imx-sdma: Let the core do the device node validation
      dmaengine: dma-jz4780: Let the core do the device node validation
      dmaengine: mmp_tdma: Let the core do the device node validation
      dmaengine: mxs-dma: Let the core do the device node validation
      dmaengine: sh: rcar-dmac: Let the core do the device node validation
      dmaengine: sh: usb-dmac: Let the core do the device node validation

Dinh Nguyen (2):
      dt-bindings: pl330: document the optional resets property
      dmagengine: pl330: add code to get reset property

Dmitry Osipenko (1):
      dmaengine: tegra-apb: Error out if DMA_PREP_INTERRUPT flag is unset

Dragos Bogdan (1):
      dmaengine: axi-dmac: Add support for interleaved cyclic transfers

Fabio Estevam (1):
      dmaengine: Revert "dmaengine: fsl-edma: support little endian for edm=
a driver"

Geert Uytterhoeven (3):
      dmaengine: Grammar s/the its/its/, s/need/needs/
      dmaengine: sh: usb-dmac: Use [] to denote a flexible array member
      dmaengine: rcar-dmac: Reject zero-length slave DMA requests

Greg Kroah-Hartman (6):
      dmaengine: amba-pl08x: no need to cast away call to debugfs_create_fi=
le()
      dmaengine: bcm-sba-raid: no need to check return value of debugfs_cre=
ate functions
      dmaengine: coh901318: no need to cast away call to debugfs_create_fil=
e()
      dmaengine: pxa_dma: no need to check return value of debugfs_create f=
unctions
      dmaengine: mic_x100_dma: no need to check return value of debugfs_cre=
ate functions
      dmaengine: qcom: hidma: no need to check return value of debugfs_crea=
te functions

Gustavo Pimentel (6):
      dmaengine: Add Synopsys eDMA IP core driver
      dmaengine: Add Synopsys eDMA IP version 0 support
      dmaengine: Add Synopsys eDMA IP version 0 debugfs support
      PCI: Add Synopsys endpoint EDDA Device ID
      dmaengine: Add Synopsys eDMA IP PCIe glue-logic
      MAINTAINERS: Add Synopsys eDMA IP driver maintainer

Hook, Gary (2):
      dmaengine: dmatest: timeout value of -1 should specify infinite wait
      Documentation: dmaengine: clean up description of dmatest usage

Jernej Skrabec (5):
      dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
      dmaengine: sun6i: Add a quirk for additional mbus clock
      dmaengine: sun6i: Add a quirk for setting DRQ fields
      dmaengine: sun6i: Add a quirk for setting mode fields
      dmaengine: sun6i: Add support for H6 DMA

Lars-Peter Clausen (2):
      dmaengine: axi-dmac: Sanity check memory mapped interface support
      dmaengine: axi-dmac: Discover length alignment requirement

Long Cheng (2):
      dmaengine: mediatek: Add MediaTek UART APDMA support
      dt-bindings: dma: uart: rename binding

Michael Hennerich (1):
      dmaengine: axi-dmac: Enable TLAST handling

Paul Cercueil (1):
      dmaengine: jz4780: Use SPDX license notifier

Peng Ma (3):
      dmaengine: fsl-qdma: fixed the source/destination descriptor format
      dmaengine: fsl-qdma: Continue to clear register on error
      dmaengine: fsl-edma: support little endian for edma driver

Raag Jadav (1):
      dmaengine: at_xdmac: check for non-empty xfers_list before invoking c=
allback

Robin Gong (5):
      dmaengine: fsl-edma: add drvdata for fsl-edma
      dmaengine: fsl-edma-common: move dmamux register to another single fu=
nction
      dmaengine: fsl-edma-common: version check for v2 instead
      dt-bindings: dma: fsl-edma: add new i.mx7ulp-edma
      dmaengine: fsl-edma: add i.mx7ulp edma2 version support

Sameer Pujar (1):
      dmaengine: tegra210-adma: remove PM_CLK dependency

Simon Horman (1):
      dmaengine: sudmac: remove unused driver

Vinod Koul (2):
      dmaengine: xilinx_dma: Remove set but unused =E2=80=98tail_desc=E2=80=
=99
      dmaengine: Revert "dmaengine: fsl-edma: add i.mx7ulp edma2 version su=
pport"

Weitao Hou (1):
      dmaengine: stm32: use to_platform_device()

YueHaibing (1):
      dmaengine: dw-edma: Fix build error without CONFIG_PCI_MSI

kbuild test robot (1):
      dmaengine: dw-edma: fix semicolon.cocci warnings

 .../devicetree/bindings/dma/8250_mtk_dma.txt       |  33 -
 .../devicetree/bindings/dma/arm-pl330.txt          |   3 +
 Documentation/devicetree/bindings/dma/fsl-edma.txt |  44 +-
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |  54 ++
 .../devicetree/bindings/dma/sun6i-dma.txt          |   9 +-
 Documentation/driver-api/dmaengine/dmatest.rst     |  21 +-
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |   5 +-
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amba-pl08x.c                           |   5 +-
 drivers/dma/at_xdmac.c                             |  11 +-
 drivers/dma/bcm-sba-raid.c                         |  13 +-
 drivers/dma/coh901318.c                            |   6 +-
 drivers/dma/dma-axi-dmac.c                         | 204 ++++-
 drivers/dma/dma-jz4780.c                           |  13 +-
 drivers/dma/dmaengine.c                            |  14 +-
 drivers/dma/dmatest.c                              |   6 +-
 drivers/dma/dw-edma/Kconfig                        |  19 +
 drivers/dma/dw-edma/Makefile                       |   7 +
 drivers/dma/dw-edma/dw-edma-core.c                 | 937 +++++++++++++++++=
++++
 drivers/dma/dw-edma/dw-edma-core.h                 | 165 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c                 | 229 +++++
 drivers/dma/dw-edma/dw-edma-v0-core.c              | 354 ++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h              |  28 +
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c           | 310 +++++++
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h           |  27 +
 drivers/dma/dw-edma/dw-edma-v0-regs.h              | 158 ++++
 drivers/dma/dw/pci.c                               |  33 +-
 drivers/dma/fsl-edma-common.c                      |  69 +-
 drivers/dma/fsl-edma-common.h                      |  10 +-
 drivers/dma/fsl-edma.c                             |  43 +-
 drivers/dma/fsl-qdma.c                             |  22 +-
 drivers/dma/hsu/hsu.c                              |   4 +-
 drivers/dma/imx-sdma.c                             |   9 +-
 drivers/dma/mcf-edma.c                             |  11 +-
 drivers/dma/mediatek/Kconfig                       |  11 +
 drivers/dma/mediatek/Makefile                      |   1 +
 drivers/dma/mediatek/mtk-uart-apdma.c              | 666 +++++++++++++++
 drivers/dma/mic_x100_dma.c                         |   6 +-
 drivers/dma/mmp_tdma.c                             |  10 +-
 drivers/dma/mxs-dma.c                              |   8 +-
 drivers/dma/of-dma.c                               |   4 +-
 drivers/dma/pl330.c                                |  40 +
 drivers/dma/pxa_dma.c                              |  56 +-
 drivers/dma/qcom/hidma.h                           |   5 +-
 drivers/dma/qcom/hidma_dbg.c                       |  37 +-
 drivers/dma/sh/Kconfig                             |   6 -
 drivers/dma/sh/Makefile                            |   1 -
 drivers/dma/sh/rcar-dmac.c                         |   8 +-
 drivers/dma/sh/sudmac.c                            | 414 ---------
 drivers/dma/sh/usb-dmac.c                          |   8 +-
 drivers/dma/stm32-dma.c                            |   1 -
 drivers/dma/stm32-dmamux.c                         |   6 +-
 drivers/dma/sun6i-dma.c                            | 147 +++-
 drivers/dma/tegra20-apb-dma.c                      |  12 +-
 drivers/dma/virt-dma.c                             |   4 +-
 drivers/dma/virt-dma.h                             |   4 +
 drivers/dma/xilinx/xilinx_dma.c                    |   4 +-
 drivers/misc/pci_endpoint_test.c                   |   2 +-
 drivers/soc/tegra/fuse/fuse-tegra20.c              |   2 +-
 include/linux/dma/edma.h                           |  47 ++
 include/linux/dmaengine.h                          |  12 +-
 include/linux/fpga/adi-axi-common.h                |  19 +
 include/linux/pci_ids.h                            |   1 +
 include/linux/platform_data/dma-imx.h              |   1 -
 include/linux/sudmac.h                             |  52 --
 66 files changed, 3671 insertions(+), 808 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
 create mode 100644 drivers/dma/dw-edma/Kconfig
 create mode 100644 drivers/dma/dw-edma/Makefile
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-pcie.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-regs.h
 create mode 100644 drivers/dma/mediatek/mtk-uart-apdma.c
 delete mode 100644 drivers/dma/sh/sudmac.c
 create mode 100644 include/linux/dma/edma.h
 create mode 100644 include/linux/fpga/adi-axi-common.h
 delete mode 100644 include/linux/sudmac.h

Thanks
--=20
~Vinod

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdLZq5AAoJEHwUBw8lI4NH3LUQAK4T3Qo4aBHz+yOySwfVln8+
vDJeDiaRdml2SS5AubKlB/Q3V+LVQImuZgG5UfTIWYKGMj0f2efDd4Y2RSQXnToT
BTDcTcpKxe9Tkv9NymLKQAOSdv8OVJFZYS36WpV/6F3pqazKs2iKr7puhFlR4a+x
rajE9VbipeQtgiX8/t/XLwdMwN2jsprqRMxBDck1fgOByupeC53pEsug1yk3sBOe
3lQLzbWWP4KSlP6dCVTSnHM3QkCeEZStK6euC3JF/qaAuSCE9t063qz1AP/HZS0v
D0TFQggZqRzbdIETqdUw6FnimQvfD7oSq9NiKjH8Xnrfqa1ciF1aFE/iQ2I8K23m
fSMB/qsbWYwIePVc6UlUeN3Ji36EhEMQuefNOveyBoLJSjFmVPgeWM+KlvrhbTbd
44ZoZiwQK+FpSonKiZIyn9A8DDrmtjGd2zT8pIU5FBXKau5qlQHXFNUFRby8SFRP
Vl2U+71JefeMpsWF//2ARLOxeOAJ8+xE1SjIfKqnNtz280xvv/Bcc0oj3scNf6gP
DyV1pG4j1SfXSwZKVZ+iFnIUT1n85gcy/ru4joh7NcgZ6lxOEHmVcacynjbSLos9
/BYAPNSZMc4WaMorgeP+0/n7HTkD/Kps7KDoIcVhCou8YG+Ex8Kshp8cGVAwZMWZ
Gzf3cbrJHRu9ri3tV1Pz
=pYSb
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
