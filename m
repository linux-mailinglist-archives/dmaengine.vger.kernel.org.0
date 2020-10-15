Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1A28ED5D
	for <lists+dmaengine@lfdr.de>; Thu, 15 Oct 2020 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgJOHG3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 03:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgJOHG2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Oct 2020 03:06:28 -0400
Received: from localhost (unknown [122.171.209.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE72F22247;
        Thu, 15 Oct 2020 07:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602745586;
        bh=EU3EFxDZ3VsWlZFcdRmTKCPfCb/8+1jNJTu+ObglhzU=;
        h=Date:From:To:Cc:Subject:From;
        b=T3AD6KSqobb/DWA1IPqHvMnrzQFfLsPEd42bwHQSUqXQ7yhi4qfZ80ESteoquECtq
         vOEoReXDFAJ76WpXIbAc3nx0Og0yPDHo+TqC3o8QN0S77ebHMVcsM1TyD2yKgD7JQP
         0nPbIB95G951ihOIC3m9n+vfzjP3ctSQoC8Qv4xQ=
Date:   Thu, 15 Oct 2020 12:36:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine updates for v5.10-rc1
Message-ID: <20201015070622.GS2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive dmaengine updates for v5.10-rc1. No new drivers
this time, few subsystem conversions and updates to drivers.


The following changes since commit ce65d55f92a67e247f4d799e581cf9fed677871c:

  dmaengine: dmatest: Prevent to run on misconfigured channel (2020-09-22 2=
0:18:05 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.10-rc1

for you to fetch changes up to fc143e38ddd47d3b01ac276786ee78edf053bf5d:

  dmaengine: owl-dma: fix kernel-doc style for enum (2020-10-08 15:18:48 +0=
530)

----------------------------------------------------------------
dmaengine updates for v5.10-rc1

Core:
 - Mark dma_request_slave_channel() deprecated in favour of dma_request_cha=
n()
 - subsystem conversion for tasklet_setup() API
 - subsystem removal of local dma_parms for arm drivers

Updates to bunch of driver notably TI, DW and AXI-DMAC

----------------------------------------------------------------
Alexandru Ardelean (6):
      dmaengine: axi-dmac: move version read in probe
      dmaengine: axi-dmac: move active_descs list init after device-tree in=
it
      dmaengine: axi-dmac: move clock enable earlier
      dmaengine: axi-dmac: wrap entire dt parse in a function
      dmaengine: axi-dmac: wrap channel parameter adjust into function
      dmaengine: axi-dmac: add support for reading bus attributes from regi=
sters

Allen Pais (36):
      dmaengine: altera-msgdma: convert tasklets to use new tasklet_setup()=
 API
      dmaengine: at_hdmac: convert tasklets to use new tasklet_setup() API
      dmaengine: at_xdmac: convert tasklets to use new tasklet_setup() API
      dmaengine: coh901318: convert tasklets to use new tasklet_setup() API
      dmaengine: dw: convert tasklets to use new tasklet_setup() API
      dmaengine: ep93xx: convert tasklets to use new tasklet_setup() API
      dmaengine: imx-dma: convert tasklets to use new tasklet_setup() API
      dmaengine: ioat: convert tasklets to use new tasklet_setup() API
      dmaengine: iop_adma: convert tasklets to use new tasklet_setup() API
      dmaengine: ipu: convert tasklets to use new tasklet_setup() API
      dmaengine: k3dma: convert tasklets to use new tasklet_setup() API
      dmaengine: mediatek: convert tasklets to use new tasklet_setup() API
      dmaengine: mmp: convert tasklets to use new tasklet_setup() API
      dmaengine: mpc512x: convert tasklets to use new tasklet_setup() API
      dmaengine: mv_xor: convert tasklets to use new tasklet_setup() API
      dmaengine: mxs-dma: convert tasklets to use new tasklet_setup() API
      dmaengine: nbpfaxi: convert tasklets to use new tasklet_setup() API
      dmaengine: pch_dma: convert tasklets to use new tasklet_setup() API
      dmaengine: pl330: convert tasklets to use new tasklet_setup() API
      dmaengine: ppc4xx: convert tasklets to use new tasklet_setup() API
      dmaengine: qcom: convert tasklets to use new tasklet_setup() API
      dmaengine: sa11x0: convert tasklets to use new tasklet_setup() API
      dmaengine: sirf-dma: convert tasklets to use new tasklet_setup() API
      dmaengine: ste_dma40: convert tasklets to use new tasklet_setup() API
      dmaengine: sun6i: convert tasklets to use new tasklet_setup() API
      dmaengine: tegra20: convert tasklets to use new tasklet_setup() API
      dmaengine: timb_dma: convert tasklets to use new tasklet_setup() API
      dmaengine: txx9dmac: convert tasklets to use new tasklet_setup() API
      dmaengine: virt-dma: convert tasklets to use new tasklet_setup() API
      dmaengine: xgene: convert tasklets to use new tasklet_setup() API
      dmaengine: xilinx: convert tasklets to use new tasklet_setup() API
      dmaengine: plx_dma: convert tasklets to use new tasklet_setup() API
      dmaengine: k3-udma: convert tasklets to use new tasklet_setup() API
      dmaengine: fsl: convert tasklets to use new tasklet_setup() API
      dmaengine: sf-pdma: convert tasklets to use new tasklet_setup() API
      dmaengine: xilinx: dpdma: convert tasklets to use new tasklet_setup()=
 API

Andy Shevchenko (4):
      dmaengine: Save few bytes and increase readability of dma_request_cha=
n()
      dmaengine: dmatest: Print error codes as signed value
      dmaengine: dmatest: Check list for emptiness before access its last e=
ntry
      dmaengine: dmatest: Return boolean result directly in filter()

Barry Song (1):
      dmaengine: zx: remove redundant irqsave in hardIRQ

Brad Kim (1):
      dmaengine: sf-pdma: Fix an error that calls callback twice

Dave Jiang (4):
      dmaengine: idxd: clear misc interrupt cause after read
      dmaengine: idxd: add support for configurable max wq xfer size
      dmaengine: idxd: add support for configurable max wq batch size
      dmaengine: idxd: add command status to idxd sysfs attribute

Grygorii Strashko (1):
      dmaengine: ti: k3-udma-glue: fix channel enable functions

Gustavo Pimentel (2):
      dmaengine: dw-edma: Fix typo in comments offset
      dmaengine: dw-edma: Fix Using plain integer as NULL pointer in dw-edm=
a-v0-debugfs.c

Jason Yan (1):
      dmaengine: ioat: Make two symbols static

Julia Lawall (2):
      dmaengine: sh: drop double zeroing
      dmaengine: rcar-dmac: drop double zeroing

Krzysztof Kozlowski (4):
      dmaengine: ti: omap-dma: Drop of_match_ptr to fix -Wunused-const-vari=
able
      dmaengine: pl330: Simplify with dev_err_probe()
      dmaengine: stm32: Simplify with dev_err_probe()
      dmaengine: xilinx: Simplify with dev_err_probe()

Lad Prabhakar (2):
      dt-bindings: renesas,rcar-dmac: Document r8a7742 support
      dmaengine: Kconfig: Update description for RCAR_DMAC config

Laurent Pinchart (1):
      dmaengine: xilinx: dpdma: Add debugfs support

Liu Shixin (1):
      dmaengine: mediatek: simplify the return expression of mtk_uart_apdma=
_runtime_resume()

Logan Gunthorpe (1):
      dmaengine: ioat: Allocate correct size for descriptor chunk

Paul Cercueil (1):
      dmaengine: dma-jz4780: Fix race in jz4780_dma_tx_status

Peter Ujfalusi (7):
      dmaengine: ti: k3-psil: Use soc_device_match to get the psil map
      dmaengine: ti: k3-psil: add map for j7200
      dmaengine: ti: k3-psil-j721e: Add entries for 2nd port of MCU SA2UL
      dmaengine: ti: k3-udma: Remove redundant is_slave_direction() checks
      dmaengine: Remove unused define for dma_request_slave_channel_reason()
      dmaengine: Mark dma_request_slave_channel() deprecated
      dmaengine: ti: k3-udma: Use soc_device_match() for SoC dependent para=
meters

Rob Herring (1):
      dt-bindings: Fix 'reg' size issues in zynqmp examples

Robin Murphy (9):
      dmaengine: axi-dmac: Drop local dma_parms
      dmaengine: bcm2835: Drop local dma_parms
      dmaengine: imx-dma: Drop local dma_parms
      dmaengine: imx-sdma: Drop local dma_parms
      dmaengine: mxs: Drop local dma_parms
      dmaengine: rcar-dmac: Drop local dma_parms
      dmaengine: ste_dma40: Drop local dma_parms
      dmaengine: qcom: bam_dma: Drop local dma_parms
      dmaengine: pl330: Drop local dma_parms

Serge Semin (5):
      dt-bindings: dma: dw: Add optional DMA-channels mask cell support
      dmaengine: dw: Activate FIFO-mode for memory peripherals only
      dmaengine: dw: Discard dlen from the dev-to-mem xfer width calculation
      dmaengine: dw: Ignore burst setting for memory peripherals
      dmaengine: dw: Add DMA-channels mask cell support

Vaibhav Gupta (1):
      dmaengine: pch_dma: use generic power management

Vinod Koul (12):
      Merge tag 'v5.9-rc4' into next
      dmaengine: sf-pdma: remove unused 'desc'
      dmaengine: sf-pdma: remove unused 'desc'
      Merge branch 'fixes' into next
      dmaengine: pl330: fix argument for tasklet
      Merge branch 'topic/tasklet' into next
      dmaengine: fsl: remove bad channel update
      dmaengine: altera-msgdma: fix kernel-doc style for tasklet
      dmaengine: qcom: bam_dma: fix kernel-doc style for tasklet
      dmaengine: xilinx_dma: fix kernel-doc style for tasklet
      dmaengine: zynqmp_dma: fix kernel-doc style for tasklet
      dmaengine: owl-dma: fix kernel-doc style for enum

Wei Yongjun (1):
      dmaengine: xilinx: dpdma: Make symbol 'dpdma_debugfs_reqs' static

YueHaibing (1):
      dmaengine: iop-adma: Fix pointer cast warnings

Zhang Qilong (1):
      dmaengine: ti: k3-udma: use devm_platform_ioremap_resource_byname

=C5=81ukasz Stelmach (1):
      dmaengine: pl330: fix instruction dump formatting

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |  20 ++
 .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   |   8 +-
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   1 +
 .../bindings/dma/snps,dma-spear1340.yaml           |   7 +-
 .../bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml     |   2 +-
 drivers/dma/altera-msgdma.c                        |   8 +-
 drivers/dma/at_hdmac.c                             |   7 +-
 drivers/dma/at_xdmac.c                             |   7 +-
 drivers/dma/bcm2835-dma.c                          |   3 -
 drivers/dma/coh901318.c                            |   7 +-
 drivers/dma/dma-axi-dmac.c                         | 141 +++++++++----
 drivers/dma/dma-jz4780.c                           |   7 +-
 drivers/dma/dmaengine.c                            |  24 +--
 drivers/dma/dmatest.c                              |  23 ++-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c           |   2 +-
 drivers/dma/dw-edma/dw-edma-v0-regs.h              |   2 +-
 drivers/dma/dw/core.c                              |  12 +-
 drivers/dma/dw/dw.c                                |   7 +-
 drivers/dma/dw/idma32.c                            |   5 +-
 drivers/dma/dw/of.c                                |   7 +-
 drivers/dma/ep93xx_dma.c                           |   7 +-
 drivers/dma/fsl_raid.c                             |   8 +-
 drivers/dma/fsldma.c                               |   6 +-
 drivers/dma/idxd/device.c                          |  10 +-
 drivers/dma/idxd/idxd.h                            |   3 +
 drivers/dma/idxd/init.c                            |   2 +
 drivers/dma/idxd/irq.c                             |   2 +-
 drivers/dma/idxd/sysfs.c                           |  95 +++++++++
 drivers/dma/imx-dma.c                              |   9 +-
 drivers/dma/imx-sdma.c                             |   2 -
 drivers/dma/ioat/dma.c                             |  12 +-
 drivers/dma/ioat/dma.h                             |   2 +-
 drivers/dma/ioat/init.c                            |   4 +-
 drivers/dma/iop-adma.c                             |  19 +-
 drivers/dma/ipu/ipu_idmac.c                        |   6 +-
 drivers/dma/k3dma.c                                |   6 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |   7 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |   7 +-
 drivers/dma/mmp_pdma.c                             |   6 +-
 drivers/dma/mmp_tdma.c                             |   6 +-
 drivers/dma/mpc512x_dma.c                          |   6 +-
 drivers/dma/mv_xor.c                               |   7 +-
 drivers/dma/mv_xor_v2.c                            |   8 +-
 drivers/dma/mxs-dma.c                              |   9 +-
 drivers/dma/nbpfaxi.c                              |   6 +-
 drivers/dma/owl-dma.c                              |   3 +-
 drivers/dma/pch_dma.c                              |  42 ++--
 drivers/dma/pl330.c                                |  30 ++-
 drivers/dma/plx_dma.c                              |   7 +-
 drivers/dma/ppc4xx/adma.c                          |   7 +-
 drivers/dma/qcom/bam_dma.c                         |  10 +-
 drivers/dma/qcom/hidma.c                           |   6 +-
 drivers/dma/qcom/hidma_ll.c                        |   6 +-
 drivers/dma/sa11x0-dma.c                           |   6 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |  25 ++-
 drivers/dma/sh/Kconfig                             |   4 +-
 drivers/dma/sh/rcar-dmac.c                         |   4 +-
 drivers/dma/sh/shdma-base.c                        |   2 +-
 drivers/dma/sirf-dma.c                             |   6 +-
 drivers/dma/ste_dma40.c                            |  10 +-
 drivers/dma/stm32-dma.c                            |   8 +-
 drivers/dma/stm32-dmamux.c                         |   9 +-
 drivers/dma/stm32-mdma.c                           |   9 +-
 drivers/dma/sun6i-dma.c                            |   6 +-
 drivers/dma/tegra20-apb-dma.c                      |   7 +-
 drivers/dma/ti/Makefile                            |   5 +-
 drivers/dma/ti/k3-psil-j7200.c                     | 175 +++++++++++++++++
 drivers/dma/ti/k3-psil-j721e.c                     |   3 +
 drivers/dma/ti/k3-psil-priv.h                      |   1 +
 drivers/dma/ti/k3-psil.c                           |  19 +-
 drivers/dma/ti/k3-udma-glue.c                      |  17 +-
 drivers/dma/ti/k3-udma.c                           |  64 +++---
 drivers/dma/ti/omap-dma.c                          |   2 +-
 drivers/dma/timb_dma.c                             |   6 +-
 drivers/dma/txx9dmac.c                             |  14 +-
 drivers/dma/virt-dma.c                             |   6 +-
 drivers/dma/xgene-dma.c                            |   7 +-
 drivers/dma/xilinx/xilinx_dma.c                    |  45 ++---
 drivers/dma/xilinx/xilinx_dpdma.c                  | 218 +++++++++++++++++=
+++-
 drivers/dma/xilinx/zynqmp_dma.c                    |   8 +-
 drivers/dma/zx_dma.c                               |   6 +-
 include/linux/dmaengine.h                          |  17 +-
 include/linux/platform_data/dma-dw.h               |   2 +
 83 files changed, 935 insertions(+), 442 deletions(-)
 create mode 100644 drivers/dma/ti/k3-psil-j7200.c

Thanks
--=20
~Vinod

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl+H9O4ACgkQfBQHDyUj
g0d23hAA0PHkbzizXA1mQ0hAx56syQg1J8Ye5MmYYRUwThdM3R+LvoHW6Api0dlL
RHFVyaGgMs0cMiGHe2kIa15jaNyWpYm0oYjRdIsvCPny/4GJel2o31af6NUeHMvk
5sIFnrAZipRDg4qfO77zXhOc30nWMXkJ7fIRLD1e6uk5iKwvXgXPGP2k47Cj9oYu
Hq5My9wSk8Ai673iVIyqyD4TvxjgyT3EK4VPSEUKWRoXEDFPW/K3LFzkN6Qj/VWB
UsSir3mpHZwonAAbIbzbyOi2cAS0xFl/4iEbfv83mRaP1K0/2Qpy0uDPJW/Ge4+a
/q6KfBFwdiJW+1GKK74qULNlIf3HAEzuOW4dx8qVwN5RqRMScKo0pfrSsxMVYqcT
f4wbSX52Px+RkCM/hFP9bxbNCLu5dfdr+DiUv2J1GNg0Dbpb+biC9hS5lrsWD7yC
PbLE7yPeMOwX7IZ1NhCtplL+nrEJjV9aMJaXaGEodFfIQikDm5i6nbE3zFGBVxdE
dfbk4Zcslc+2nksrbG2P3Z69TzsXXVkLu9hGJNjPwMrK5WF6z5KwLIMQcDibTd7l
qyJrHshK2dZbzqfzP2UDLF/fsAGvfFpLZZ6iEz1yA+4ivvlS1GxHn0jF1j3aI3oJ
5biHSyYjNTHnhKDPpUXCcv6wlP4WrcpYrVY1uwVogqBYFWCjBnw=
=ZsyH
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--
