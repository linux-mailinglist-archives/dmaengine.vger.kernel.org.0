Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2744F14A6A6
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgA0O6l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 09:58:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgA0O6l (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jan 2020 09:58:41 -0500
Received: from localhost (unknown [122.181.201.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D38E20716;
        Mon, 27 Jan 2020 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580137119;
        bh=CI43Gl8PocZcyWdd2Y9B2ZIX5SDFF7tkvcq+rO/Yf6g=;
        h=Date:From:To:Cc:Subject:From;
        b=CXQ0WyWWlhIhkB0JEyQe4qSpH2zspL2a+SXA6kFWFbvrAEJhEOfRs++BW9V7bxctE
         GqASvwM3WcFEm/m7czDyRPKRXw6N91wgxp2bn7ZXU8kFqHn16D9vWdCH2mDQrXWwUR
         ROoQtbET3mglFaCLWqqBlCVbXxa/LcjFoOfn+4S8=
Date:   Mon, 27 Jan 2020 20:28:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.6-rc1
Message-ID: <20200127145835.GI2841@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the dmaengine updates for v5.6-rc1. This time we
have a bunch of core changes to support dynamic channels, hotplug of
controllers, new apis for metadata ops etc along with new drivers for
Intel data accelerators, TI K3 UDMA, PLX DMA engine and hisilicon
Kunpeng DMA engine. Also usual assorted updates to drivers.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.6-rc1

for you to fetch changes up to 71723a96b8b1367fefc18f60025dae792477d602:

  dmaengine: Create symlinks between DMA channels and slaves (2020-01-24 11=
:41:32 +0530)

----------------------------------------------------------------
dmaengine updates for v5.6-rc1

 - Core:
   - Support for dynamic channels
   - Removal of various slave wrappers
   - Make few slave request APIs as private to dmaengine
   - Symlinks between channels and slaves
   - Support for hotplug of controllers
   - Support for metadata_ops for dma_async_tx_descriptor
   - Reporting DMA cached data amount
   - Virtual dma channel locking updates

 - New drivers/device/feature support support:
   - Driver for Intel data accelerators
   - Driver for TI K3 UDMA
   - Driver for PLX DMA engine
   - Driver for hisilicon Kunpeng DMA engine
   - Support for eDMA support for QorIQ LS1028A in fsl edma driver
   - Support for cyclic dma in sun4i driver
   - Support for X1830 in JZ4780 driver

----------------------------------------------------------------
Anson Huang (1):
      dt-bindings: fsl-imx-sdma: Add i.MX8MM/i.MX8MN/i.MX8MP compatible str=
ing

Chen Zhou (1):
      dmaengine: fsl-qdma: fix duplicated argument to &&

Chuhong Yuan (2):
      dmaengine: ti: edma: add missed operations
      dmaengine: axi-dmac: add a check for devm_regmap_init_mmio

Colin Ian King (2):
      dmaengine: s3c24xx-dma: fix spelling mistake "to" -> "too"
      dmaengine: ti: k3-udma: fix spelling mistake "limted" -> "limited"

Dave Jiang (8):
      x86/asm: add iosubmit_cmds512() based on MOVDIR64B CPU instruction
      dmaengine: break out channel registration
      dmaengine: add support to dynamic register/unregister of channels
      dmaengine: idxd: Init and probe for Intel data accelerators
      dmaengine: idxd: add configuration component of driver
      dmaengine: idxd: add descriptor manipulation routines
      dmaengine: idxd: connect idxd to dmaengine subsystem
      dmaengine: idxd: add char driver to expose submission portal to userl=
and

Geert Uytterhoeven (6):
      dt-bindings: dmaengine: rcar-dmac: Document r8a77961 support
      dmaengine: Remove spaces before TABs
      dmaengine: Remove dma_device_satisfies_mask() wrapper
      dmaengine: Remove dma_request_slave_channel_compat() wrapper
      dmaengine: Move dma_get_{,any_}slave_channel() to private dmaengine.h
      dmaengine: Create symlinks between DMA channels and slaves

Grygorii Strashko (3):
      bindings: soc: ti: add documentation for k3 ringacc
      soc: ti: k3: add navss ringacc driver
      dmaengine: ti: k3-udma: Add glue layer for non DMAengine users

Jing Lin (1):
      dmaengine: idxd: add sysfs ABI for idxd driver

Logan Gunthorpe (8):
      dmaengine: Store module owner in dma_device struct
      dmaengine: Call module_put() after device_free_chan_resources()
      dmaengine: Move dma_channel_rebalance() infrastructure up in code
      dmaengine: Add reference counting to dma_device struct
      dmaengine: ioat: Support in-use unbind
      dmaengine: plx-dma: Introduce PLX DMA engine PCI driver skeleton
      dmaengine: plx-dma: Implement hardware initialization and cleanup
      dmaengine: plx-dma: Implement descriptor submission

Matthias Fend (1):
      dmaengine: zynqmp_dma: fix burst length configuration

Peng Ma (2):
      dt-bindings: dma: fsl-edma: add new fsl,fsl,ls1028a-edma
      dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A platform

Peter Ujfalusi (9):
      dmaengine: doc: Add sections for per descriptor metadata support
      dmaengine: Add metadata_ops for dma_async_tx_descriptor
      dmaengine: Add support for reporting DMA cached data amount
      dmaengine: Add helper function to convert direction value to text
      dmaengine: ti: Add cppi5 header for K3 NAVSS/UDMA
      dmaengine: ti: k3 PSI-L remote endpoint configuration
      dt-bindings: dma: ti: Add document for K3 UDMA
      dmaengine: ti: New driver for K3 UDMA
      dmaengine: ti: k3-psil: make symbols static

Sascha Hauer (9):
      dmaengine: bcm2835: do not call vchan_vdesc_fini() with lock held
      dmaengine: virt-dma: Add missing locking
      dmaengine: virt-dma: remove debug message
      dmaengine: virt-dma: Do not call desc_free() under a spin_lock
      dmaengine: virt-dma: Add missing locking around list operations
      dmaengine: virt-dma: use vchan_vdesc_fini() to free descriptors
      dmaengine: imx-sdma: rename function
      dmaengine: imx-sdma: find desc first in sdma_tx_status
      dmaengine: imx-sdma: Fix memory leak

Stefan Mavrodiev (1):
      dmaengine: sun4i: Add support for cyclic requests with dedicated DMA

Ulf Hansson (2):
      dmaengine: pl330: Drop boilerplate code for suspend/resume
      dmaengine: pl330: Convert to the *_late and *_early system sleep call=
backs

Vinod Koul (3):
      dmaengine: move module_/dma_device_put() after route free
      dmaengine: print more meaningful error message
      Merge TI ringacc driver from Santosh

Wei Yongjun (1):
      dmaengine: ti: edma: Fix error return code in edma_probe()

Zhou Wang (1):
      dmaengine: hisilicon: Add Kunpeng DMA engine support

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (2):
      dt-bindings: dmaengine: Add X1830 bindings.
      dmaengine: JZ4780: Add support for the X1830.

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |  171 +
 Documentation/devicetree/bindings/dma/fsl-edma.txt |    1 +
 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |    3 +
 .../devicetree/bindings/dma/jz4780-dma.txt         |    6 +-
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |    1 +
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |  184 ++
 .../devicetree/bindings/soc/ti/k3-ringacc.txt      |   59 +
 Documentation/driver-api/dmaengine/client.rst      |   87 +
 Documentation/driver-api/dmaengine/provider.rst    |   48 +
 MAINTAINERS                                        |   13 +
 arch/x86/include/asm/io.h                          |   36 +
 drivers/dma/Kconfig                                |   30 +
 drivers/dma/Makefile                               |    3 +
 drivers/dma/bcm2835-dma.c                          |    5 +-
 drivers/dma/dma-axi-dmac.c                         |   10 +-
 drivers/dma/dma-jz4780.c                           |    7 +
 drivers/dma/dmaengine.c                            |  628 ++--
 drivers/dma/dmaengine.h                            |   11 +
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |    8 +-
 drivers/dma/fsl-edma-common.c                      |    5 +
 drivers/dma/fsl-edma-common.h                      |    1 +
 drivers/dma/fsl-edma.c                             |    8 +
 drivers/dma/fsl-qdma.c                             |    2 +-
 drivers/dma/hisi_dma.c                             |  611 ++++
 drivers/dma/idxd/Makefile                          |    2 +
 drivers/dma/idxd/cdev.c                            |  302 ++
 drivers/dma/idxd/device.c                          |  693 ++++
 drivers/dma/idxd/dma.c                             |  217 ++
 drivers/dma/idxd/idxd.h                            |  316 ++
 drivers/dma/idxd/init.c                            |  533 +++
 drivers/dma/idxd/irq.c                             |  261 ++
 drivers/dma/idxd/registers.h                       |  336 ++
 drivers/dma/idxd/submit.c                          |   95 +
 drivers/dma/idxd/sysfs.c                           | 1528 +++++++++
 drivers/dma/imx-sdma.c                             |   37 +-
 drivers/dma/ioat/init.c                            |   38 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |    3 +-
 drivers/dma/of-dma.c                               |    2 +
 drivers/dma/owl-dma.c                              |    3 +-
 drivers/dma/pl330.c                                |   16 +-
 drivers/dma/plx_dma.c                              |  639 ++++
 drivers/dma/s3c24xx-dma.c                          |   24 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |    4 +-
 drivers/dma/sun4i-dma.c                            |   48 +-
 drivers/dma/ti/Kconfig                             |   24 +
 drivers/dma/ti/Makefile                            |    3 +
 drivers/dma/ti/edma.c                              |   39 +-
 drivers/dma/ti/k3-psil-am654.c                     |  175 +
 drivers/dma/ti/k3-psil-j721e.c                     |  222 ++
 drivers/dma/ti/k3-psil-priv.h                      |   43 +
 drivers/dma/ti/k3-psil.c                           |   90 +
 drivers/dma/ti/k3-udma-glue.c                      | 1198 +++++++
 drivers/dma/ti/k3-udma-private.c                   |  133 +
 drivers/dma/ti/k3-udma.c                           | 3432 ++++++++++++++++=
++++
 drivers/dma/ti/k3-udma.h                           |  151 +
 drivers/dma/virt-dma.c                             |   10 +-
 drivers/dma/virt-dma.h                             |   27 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |   24 +-
 drivers/soc/ti/Kconfig                             |   11 +
 drivers/soc/ti/Makefile                            |    1 +
 drivers/soc/ti/k3-ringacc.c                        | 1157 +++++++
 include/dt-bindings/dma/x1830-dma.h                |   39 +
 include/linux/dma/k3-psil.h                        |   71 +
 include/linux/dma/k3-udma-glue.h                   |  134 +
 include/linux/dma/ti-cppi5.h                       | 1059 ++++++
 include/linux/dmaengine.h                          |  161 +-
 include/linux/soc/ti/k3-ringacc.h                  |  244 ++
 include/uapi/linux/idxd.h                          |  228 ++
 68 files changed, 15347 insertions(+), 364 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-dma-idxd
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 drivers/dma/hisi_dma.c
 create mode 100644 drivers/dma/idxd/Makefile
 create mode 100644 drivers/dma/idxd/cdev.c
 create mode 100644 drivers/dma/idxd/device.c
 create mode 100644 drivers/dma/idxd/dma.c
 create mode 100644 drivers/dma/idxd/idxd.h
 create mode 100644 drivers/dma/idxd/init.c
 create mode 100644 drivers/dma/idxd/irq.c
 create mode 100644 drivers/dma/idxd/registers.h
 create mode 100644 drivers/dma/idxd/submit.c
 create mode 100644 drivers/dma/idxd/sysfs.c
 create mode 100644 drivers/dma/plx_dma.c
 create mode 100644 drivers/dma/ti/k3-psil-am654.c
 create mode 100644 drivers/dma/ti/k3-psil-j721e.c
 create mode 100644 drivers/dma/ti/k3-psil-priv.h
 create mode 100644 drivers/dma/ti/k3-psil.c
 create mode 100644 drivers/dma/ti/k3-udma-glue.c
 create mode 100644 drivers/dma/ti/k3-udma-private.c
 create mode 100644 drivers/dma/ti/k3-udma.c
 create mode 100644 drivers/dma/ti/k3-udma.h
 create mode 100644 drivers/soc/ti/k3-ringacc.c
 create mode 100644 include/dt-bindings/dma/x1830-dma.h
 create mode 100644 include/linux/dma/k3-psil.h
 create mode 100644 include/linux/dma/k3-udma-glue.h
 create mode 100644 include/linux/dma/ti-cppi5.h
 create mode 100644 include/linux/soc/ti/k3-ringacc.h
 create mode 100644 include/uapi/linux/idxd.h


Thanks
--=20
~Vinod

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl4u+poACgkQfBQHDyUj
g0cFxhAApSnDMT2wxwdQHM3MvMjAsIwifmW+kD8WhQCl0hsYXcM+jgj+eH3XFzhL
8A19nuN3qxpnK8mt5VCkiR5a56clT3T5PKy1QiKOmdqxhSqQviT/hCb5xAro/8z8
MmPpDByv743iATX+psibB77RfH5TrrN0pyMlFBtw6QDjB/4FjltYqN8Ym7zRcw26
+zVRRxUc9LQ3QIfm0MwA4i+92aYrCmUWfZzUpJhCRMX8oQsWUOpVKhW0xNIdHrxY
L19n9AAyzg6ANgJWokxDqz36AF8JeK7yw0/Wywmwy2vjff/glhKUgfPofo9vn740
1t93jteygkPYRy3RtP8wFV1pj8G+i/ooawG374lnCOLdVtZfqweaz9Sv5xqeAWmj
5k267wY3zw7uEuXrV4B8agA/wzaqiQNtXazK6N/HuaHwGrgN9Fzwbr5QkNw5cxup
l8Ubqwqed6CffoHZAannAe5q/LvAeGwaOQshvaYt7E5nXkAIkWK1fbEPRhU7Fg7c
ujeyv7GgHAMa7a/5FDHge07pqKmeZBaC0lUeP+JnpgXttOxpItn7oSLyMoU16uV4
NRq1B1jdTjJVJDPedpd0ZGMmiH+MScTQf/WUx+VZ5sfu/E5WH16f/eN5VcIZEce8
ZG6uQrJmqygab4AUhOlHmrOJSivPrCRhw3SVjBQixPRbA4XiCno=
=OZZS
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
