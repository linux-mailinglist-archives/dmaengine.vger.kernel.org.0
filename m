Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D33419C01F
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgDBLZG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 07:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388012AbgDBLZG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Apr 2020 07:25:06 -0400
Received: from localhost (unknown [106.51.104.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8139206F8;
        Thu,  2 Apr 2020 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585826704;
        bh=wUyPsBoTndMWwaoKir292RjEut6k6m9SMtHPKUpyXg0=;
        h=Date:From:To:Cc:Subject:From;
        b=v+WAQqgrevEVs+3P9Lqm+7dkJ1+KekNXc0lFENM/ZglAOo7CN+RlS/SCTWas150nD
         hnjHBEJ+DrYzG69blDvu5AbscMTP9aroROzbxD0sgN9wLCi2jOqASMcePMcVJl3jve
         DT2PzSfgyTTY1lIBrvp/SmGSu/HS4J7YV1/avAeU=
Date:   Thu, 2 Apr 2020 16:55:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.7-rc1
Message-ID: <20200402112500.GJ72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here are the changes for this cycle. SFR has told me that you might see
a merge conflict, but I am sure you would be okay with it :)

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.7-rc1

for you to fetch changes up to cea582b5ee5645839650b6667335cfb40ec71c19:

  dt-bindings: dma: renesas,usb-dmac: add r8a77961 support (2020-03-26 12:2=
3:31 +0530)

----------------------------------------------------------------
dmaengine updates for v5.7-rc1

  - Core:
    - Some code cleanup and optimization in core by Andy
    - Debugfs support for displaying dmaengine channels by Peter

  - Drivers:
    - New driver for uniphier-xdmac controller
    - Updates to stm32 dma, mdma and dmamux drivers and PM support
    - More updates to idxd drivers
    - Bunch of changes in tegra-apb driver and cleaning up of pm functions
    - Bunch of spelling fixes and Replace zero-length array patches
    - Shutdown hook for fsl-dpaa2-qdma driver
    - Support for interleaved transfers for ti-edma and virtualization
      support for k3-dma driver
    - Support for reset and updates in xilinx_dma driver
    - Improvements and locking updates in at_hdma driver

----------------------------------------------------------------
Amelie Delaunay (6):
      dmaengine: stm32-mdma: driver defers probe for clock and reset
      dmaengine: stm32-mdma: use vchan_terminate_vdesc() in .terminate_all
      dmaengine: stm32-dma: use dma_set_max_seg_size to set the sg limit
      dmaengine: stm32-dma: add copy_align constraint
      dmaengine: stm32-dma: fix sleeping function called from invalid conte=
xt
      dmaengine: stm32-dma: use vchan_terminate_vdesc() in .terminate_all

Andy Shevchenko (4):
      dmaengine: Refactor dmaengine_check_align() to be bit operations only
      dmaengine: Use negative condition for better readability
      dmaengine: Drop redundant 'else' keyword
      dmaengine: consistently return string literal from switch-case

Colin Ian King (2):
      dmaengine: ti: edma: fix null dereference because of a typo in pointe=
r name
      dmaengine: fix spelling mistake "exceds" -> "exceeds"

Dave Jiang (4):
      dmaengine: idxd: check return result from check_vma() in cdev
      dmaengine: idxd: expose general capabilities register in sysfs
      dmaengine: idxd: reflect shadow copy of traffic class programming
      dmaengine: idxd: remove global token limit check

Dmitry Osipenko (19):
      dmaengine: tegra-apb: Implement synchronization hook
      dmaengine: tegra-apb: Prevent race conditions on channel's freeing
      dmaengine: tegra-apb: Clean up tasklet releasing
      dmaengine: tegra-apb: Use devm_platform_ioremap_resource
      dmaengine: tegra-apb: Use devm_request_irq
      dmaengine: tegra-apb: Fix coding style problems
      dmaengine: tegra-apb: Remove unneeded initialization of tdc->config_i=
nit
      dmaengine: tegra-apb: Remove assumptions about unavailable runtime PM
      dmaengine: tegra-apb: Remove duplicated pending_sg_req checks
      dmaengine: tegra-apb: Keep clock enabled only during of DMA transfer
      dmaengine: tegra-apb: Clean up suspend-resume
      dmaengine: tegra-apb: Add missing of_dma_controller_free
      dmaengine: tegra-apb: Allow to compile as a loadable kernel module
      dmaengine: tegra-apb: Remove MODULE_ALIAS
      dmaengine: tegra-apb: Support COMPILE_TEST
      dmaengine: tegra-apb: Remove unused function argument
      dmaengine: tegra-apb: Improve error message about DMA underflow
      dmaengine: tegra-apb: Don't save/restore IRQ flags in interrupt handl=
er
      dmaengine: tegra-apb: Improve DMA synchronization

Etienne Carriere (7):
      dmaengine: stm32-mdma: use reset controller only at probe time
      dmaengine: stm32-mdma: disable clock in case of error during probe
      dmaengine: stm32-dmamux: fix clock handling in probe sequence
      dmaengine: stm32-dmamux: use reset controller only at probe time
      dmaengine: stm32-dmamux: driver defers probe for clock and reset
      dmaengine: stm32-dma: use reset controller only at probe time
      dmaengine: stm32-dma: driver defers probe for reset

Gustavo A. R. Silva (7):
      dmaengine: bcm-sba-raid: Replace zero-length array with flexible-arra=
y member
      dmaengine: uniphier-mdmac: replace zero-length array with flexible-ar=
ray member
      dmaengine: ti: omap-dma: Replace zero-length array with flexible-arra=
y member
      dmaengine: sa11x0: Replace zero-length array with flexible-array memb=
er
      dmaengine: sprd: Replace zero-length array with flexible-array member
      dmaengine: tegra210-adma: Replace zero-length array with flexible-arr=
ay member
      dmanegine: ioat/dca: Replace zero-length array with flexible-array me=
mber

Johan Hovold (1):
      dt-bindings: dma: ti-edma: fix example compatible property

Kunihiko Hayashi (2):
      dt-bindings: dmaengine: Add UniPhier external DMA controller bindings
      dmaengine: uniphier-xdmac: Add UniPhier external DMA controller driver

Peng Ma (1):
      dmaengine: fsl-dpaa2-qdma: Adding shutdown hook

Peter Ujfalusi (6):
      dmaengine: ti: edma: Support for interleaved mem to mem transfer
      dt-bindings: dma: ti: k3-udma: Update for atype support (virtualizati=
on)
      dmaengine: ti: k3-udma: Implement support for atype (for virtualizati=
on)
      dmaengine: Add basic debugfs support
      dmaengine: ti: k3-udma: Implement custom dbg_summary_show for debugfs
      dmaengine: Create debug directories for DMA devices

Pierre-Yves MORDRET (5):
      dmaengine: stm32-mdma: add suspend/resume power management support
      dmaengine: stm32-mdma: enable descriptor_reuse
      dmaengine: stm32-dmamux: add suspend/resume power management support
      dmaengine: stm32-dma: add suspend/resume power management support
      dmaengine: stm32-dma: enable descriptor_reuse

Radhey Shyam Pandey (3):
      dmaengine: xilinx_dma: Reset DMA channel in dma_terminate_all
      dmaengine: xilinx_dma: Extend dma_config structure to store max chann=
el count
      dmaengine: xilinx_dma: In dma channel probe fix node order dependency

Takashi Iwai (1):
      dmaengine: ppc4xx: Use scnprintf() for avoiding potential buffer over=
flow

Tony Luck (1):
      dmaengine: idxd: Merge definition of dsa_batch_desc into dsa_hw_desc

Tudor Ambarus (10):
      dmaengine: at_hdmac: Substitute kzalloc with kmalloc
      dmaengine: at_hdmac: Drop locking in at_hdmac_alloc_chan_resources()
      dmaengine: at_hdmac: Return err in case the chan is not free at alloc=
 res time
      dmaengine: at_hdmac: Drop description for a not defined parameter
      dmaengine: at_hdmac: Switch atomic allocations to GFP_NOWAIT
      dmaengine: at_hdmac: Fix deadlocks
      dmaengine: at_xdmac: Drop always true check
      dmaengine: at_xdmac: Drop locking in at_xdmac_alloc_chan_resources()
      dmaengine: at_xdmac: GFP_KERNEL for user that can sleep
      dmaengine: at_xdmac: Fix locking in tasklet

Vinod Koul (2):
      dmaengine: sun4i: set the linear_mode properly
      dmaengine: uniphier-xdmac: Remove redandant error log for platform_ge=
t_irq

Yoshihiro Shimoda (1):
      dt-bindings: dma: renesas,usb-dmac: add r8a77961 support

YueHaibing (5):
      dmaengine: idxd: remove set but not used variable 'group'
      dmaengine: idxd: remove set but not used variable 'idxd_cdev'
      dmaengine: sun4i: use 'linear_mode' in sun4i_dma_prep_dma_cyclic
      dmaengine: fsl-dpaa2-qdma: remove set but not used variable 'dpaa2_qd=
ma'
      dmaengine: tegra-apb: mark PM functions as __maybe_unused

Zhenfang Wang (1):
      dmaengine: sprd: Set request pending flag when DMA controller is acti=
ve

chenqiwu (1):
      dmaengine: ti: dma-crossbar: convert to devm_platform_ioremap_resourc=
e()

 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   1 +
 .../bindings/dma/socionext,uniphier-xdmac.yaml     |  63 +++
 Documentation/devicetree/bindings/dma/ti-edma.txt  |   2 +-
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |  19 +-
 drivers/dma/Kconfig                                |  15 +-
 drivers/dma/Makefile                               |   1 +
 drivers/dma/at_hdmac.c                             | 121 ++--
 drivers/dma/at_hdmac_regs.h                        |   2 -
 drivers/dma/at_xdmac.c                             |  44 +-
 drivers/dma/bcm-sba-raid.c                         |   2 +-
 drivers/dma/dmaengine.c                            | 102 +++-
 drivers/dma/dmaengine.h                            |  16 +
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  15 +
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c                |  21 +
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h                |   2 +
 drivers/dma/idxd/cdev.c                            |   4 +-
 drivers/dma/idxd/device.c                          |   4 +-
 drivers/dma/idxd/sysfs.c                           |  19 +-
 drivers/dma/ioat/dca.c                             |   2 +-
 drivers/dma/ppc4xx/adma.c                          |   2 +-
 drivers/dma/sa11x0-dma.c                           |   2 +-
 drivers/dma/sh/rcar-dmac.c                         |   2 +-
 drivers/dma/sh/shdma-base.c                        |   2 +-
 drivers/dma/sprd-dma.c                             |  26 +-
 drivers/dma/stm32-dma.c                            |  96 +++-
 drivers/dma/stm32-dmamux.c                         |  93 +++-
 drivers/dma/stm32-mdma.c                           |  78 ++-
 drivers/dma/sun4i-dma.c                            |   4 +-
 drivers/dma/tegra20-apb-dma.c                      | 546 +++++++++---------
 drivers/dma/tegra210-adma.c                        |   2 +-
 drivers/dma/ti/dma-crossbar.c                      |   8 +-
 drivers/dma/ti/edma.c                              |  79 +++
 drivers/dma/ti/k3-udma-glue.c                      |  18 +-
 drivers/dma/ti/k3-udma.c                           | 113 +++-
 drivers/dma/ti/omap-dma.c                          |   2 +-
 drivers/dma/uniphier-mdmac.c                       |   2 +-
 drivers/dma/uniphier-xdmac.c                       | 609 +++++++++++++++++=
++++
 drivers/dma/xilinx/xilinx_dma.c                    |  65 +--
 include/linux/dmaengine.h                          |  68 +--
 include/uapi/linux/idxd.h                          |  21 +-
 40 files changed, 1749 insertions(+), 544 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphie=
r-xdmac.yaml
 create mode 100644 drivers/dma/uniphier-xdmac.c

--=20
~Vinod

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl6Fy4sACgkQfBQHDyUj
g0ce9hAAwhE0vCPzLF2ZCzdwM+bmV3kqhy0RnR4USWBbu5oaY9MGgzR682LV26+G
fhSZsqw1HsHi3X3tHidyRD5Kuzo8UEL+FC9LN4yTP0nvqAQ/Sa8Ip7bP4rIi7Tnj
wezYBADwX/I42oCNcHKL91e6COL47OJ1d736Q9KZt7Ugt4Yfcn1qSgZRgmrIZGPn
sK+0VOjFRmc0bY4mGnnF0k/9Ku8o2wLUIuHQWqe3FsrabV43yvuV26iuCFSlw7q1
JmGgJpw5GXc7X4bkU3uGVK+OvXKmNIwNqcwrSbGIyjAYaAlW1Fp0VdSI2BRLbBNQ
JhpGeKea+a5ljepuCiBLicGisLgzOvZOx1vsVbsUQ5g+3OTi/2I22BiDrdLlTL5O
jd01dP1270vf+GTDaQArxoBNxpvqcE917sA5ixxzf7gjROJWzNi650xZvii9Mewx
5lKT0oKszxTd5ebgSjkmHsGb2xt4EnIzPHqttDr3JNrmyu+j2IGZ3SGZGKPHIQuC
z7t1WSPVv4GZFPWGXAg84ngKHEVkbt6Dy0r2HMKvKTj+8LravNekdrJ2vbbkVKic
TDIZmPWZ1rjWjXbIrlmxbwZJqSTyg6U2N2L2wS9Ean9WmFCepYeL2xFHVWiJSYcX
GB8EkoIPfoabkEWFM7ZCF1nH0tmCPBlrR8r5geNrx1RKOLUX244=
=woHo
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
