Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9E6A1CF0
	for <lists+dmaengine@lfdr.de>; Fri, 24 Feb 2023 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBXNXZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 08:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBXNXV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 08:23:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB2729B;
        Fri, 24 Feb 2023 05:23:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52AD5B81C5F;
        Fri, 24 Feb 2023 13:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75834C433EF;
        Fri, 24 Feb 2023 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677244984;
        bh=cbR8uAH8FMCf7AI+eZE/BNI3CtpMujoaWI9PPpn9PXA=;
        h=Date:From:To:Cc:Subject:From;
        b=cScYkId7dJ+3ya2Zl/Gaa9iHYaD0HfCS4152cjCtZz4AunvAkcWpgxnPUr/xIhv9s
         zL7OZsQ9E1+CTaOeJjbIbPRfzvquDCd3vPMcKYyZx2C7XrnhR0D/lRwYROqOfkg5KD
         bo5v9NzatoJh08Sg76YZ424ZPTbT4OVXFV/ZyvTWr9Xs0VhM740PXr5cc/uPUlXUXm
         qpG3Ju4zPeKzsnPWWm+DJBZKRs4kyBAiujmqCVsj/ec2YlVw8u5yk22txlaTevMMEl
         o3OsDwbv63tqUcoxsZ7gQ9Qgjv0CNI406M8S+5p2MVk2o2cX/CYYvDEvM3d8zoxdwF
         SDh+NoWzoz7xA==
Date:   Fri, 24 Feb 2023 18:52:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.3
Message-ID: <Y/i6M7DxoQQwL5Et@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LJuaWkJpLxVxPSkZ"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--LJuaWkJpLxVxPSkZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine subsystem updates for v6.3. A new
driver, couple of device support and binding conversion along with bunch
of driver updates are features of this request. You have already
received request from Bjorn on edma driver updates thru pci tree.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.3-rc1

for you to fetch changes up to e922bbf37564a4c67efca9dd6133eaadbffb65f5:

  dmaengine: idma64: Update bytes_transferred field (2023-02-16 18:45:48 +0=
530)

----------------------------------------------------------------
dmaengine updates for v6.3

 New support:
 - TI AM62Ax controller support
 - Xilinx xdma driver
 - Qualcomm SM6125, SM8550, QDU1000/QRU1000 GPI controller

 Updates:
 - Runtime pm support for at_xdmac driver
 - IMX sdma binding conversion to yaml and HDMI audio support
 - IMX mxs binding conversion to yaml

----------------------------------------------------------------
Aman Kumar (1):
      dmaengine: idma64: Update bytes_transferred field

Andy Shevchenko (4):
      dmaengine: Make an order in struct dma_device definition
      dmaengine: use sysfs_emit() to instead of scnprintf()
      dmaengine: Simplify dmaenginem_async_device_register() function
      dmaengine: dw: Move check for paused channel to dwc_get_residue()

Claudiu Beznea (3):
      dmaengine: at_xdmac: align properly function members
      dmaengine: at_xdmac: add runtime pm support
      dmaengine: at_xdmac: remove empty line

Eric Pilmore (1):
      dmaengine: ptdma: check for null desc before calling pt_cmd_callback

Fenghua Yu (2):
      dmaengine: idxd: Set traffic class values in GRPCFG on DSA 2.0
      dmaengine: idxd: Fix default allowed read buffers value in group

Geert Uytterhoeven (1):
      dmaengine: HISI_DMA should depend on ARCH_HISI

Jai Luthra (1):
      dmaengine: ti: k3-psil-am62a: Add AM62Ax PSIL and PDMA data

Jayesh Choudhary (1):
      dmaengine: ti: k3-udma: remove non-fatal probe deferral log

Jiapeng Chong (1):
      dmaengine: idxd: Remove the unused function set_completion_address()

Joy Zou (2):
      dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
      dmaengine: imx-sdma: support hdmi in sdma

Kai-Heng Feng (1):
      dmaengine: imx-sdma: Set DMA channel to be private

Kees Cook (1):
      dmaengine: dw-axi-dmac: Do not dereference NULL structure

Krzysztof Kozlowski (2):
      dt-bindings: dma: drop unneeded quotes
      dt-bindings: dma: cleanup examples - indentation, lowercase hex

Lizhi Hou (2):
      dmaengine: xilinx: xdma: Add xilinx xdma driver
      dmaengine: xilinx: xdma: Add user logic interrupt support

Marek Vasut (1):
      dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT schema

Martin Botka (1):
      dt-bindings: dma: gpi: Document SM6125 compatible

Melody Olvera (1):
      dt-bindings: dmaengine: qcom: gpi: Add QDU1000/QRU1000 gpi device

Neil Armstrong (1):
      dt-bindings: dma: qcom: gpi: add compatible for sm8550

Samuel Holland (1):
      dmaengine: sun6i: Set the maximum segment size

Shravan Chippa (1):
      dmaengine: sf-pdma: pdma_desc memory leak fix

Tudor Ambarus (1):
      dmaengine: drivers: Use devm_platform_ioremap_resource()

Vignesh Raghavendra (4):
      dt-bindings: dma: ti: k3-bcdma: Add bindings for BCDMA CSI RX
      dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
      dmaengine: ti: k3-udma: Add support for DMAs on AM62A SoC
      dmaengine: ti: k3-udma: Add support for BCDMA CSI RX

ye xingchen (1):
      dmaengine: ppc4xx: Convert to use=A0sysfs_emit()/sysfs_emit_at() APIs

 .../bindings/dma/allwinner,sun4i-a10-dma.yaml      |   2 +-
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |   2 +-
 .../bindings/dma/allwinner,sun6i-a31-dma.yaml      |   2 +-
 .../devicetree/bindings/dma/altr,msgdma.yaml       |   2 +-
 .../devicetree/bindings/dma/apple,admac.yaml       |   2 +-
 .../devicetree/bindings/dma/arm-pl08x.yaml         |   2 +-
 .../devicetree/bindings/dma/dma-controller.yaml    |   2 +-
 .../devicetree/bindings/dma/dma-router.yaml        |   2 +-
 .../devicetree/bindings/dma/fsl,edma.yaml          |   2 +-
 .../devicetree/bindings/dma/fsl,imx-sdma.yaml      | 149 ++++
 .../devicetree/bindings/dma/fsl,mxs-dma.yaml       |  80 ++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt       | 118 ---
 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |  60 --
 .../devicetree/bindings/dma/ingenic,dma.yaml       |   2 +-
 .../devicetree/bindings/dma/intel,ldma.yaml        |   2 +-
 .../devicetree/bindings/dma/mediatek,uart-dma.yaml |   2 +-
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |   2 +-
 .../bindings/dma/nvidia,tegra210-adma.yaml         |   2 +-
 Documentation/devicetree/bindings/dma/owl-dma.yaml |   2 +-
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |   2 +-
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   5 +-
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   2 +-
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |   2 +-
 .../bindings/dma/renesas,rzn1-dmamux.yaml          |   2 +-
 .../devicetree/bindings/dma/renesas,usb-dmac.yaml  |   2 +-
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   2 +-
 .../bindings/dma/snps,dma-spear1340.yaml           |   2 +-
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  |  38 +-
 .../bindings/dma/socionext,uniphier-mio-dmac.yaml  |   2 +-
 .../bindings/dma/socionext,uniphier-xdmac.yaml     |   2 +-
 .../devicetree/bindings/dma/st,stm32-dma.yaml      |   2 +-
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |   2 +-
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     |   2 +-
 .../devicetree/bindings/dma/stericsson,dma40.yaml  |  18 +-
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml       |  77 +-
 MAINTAINERS                                        |  11 +
 drivers/dma/Kconfig                                |  16 +-
 drivers/dma/at_xdmac.c                             | 220 ++++-
 drivers/dma/bcm2835-dma.c                          |   4 +-
 drivers/dma/dma-axi-dmac.c                         |   4 +-
 drivers/dma/dmaengine.c                            |  26 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |   6 +-
 drivers/dma/dw/core.c                              |  11 +-
 drivers/dma/fsl-edma.c                             |   8 +-
 drivers/dma/fsl-qdma.c                             |  10 +-
 drivers/dma/idma64.c                               |   8 +-
 drivers/dma/idxd/device.c                          |  14 +-
 drivers/dma/idxd/dma.c                             |   6 -
 drivers/dma/idxd/init.c                            |   7 +-
 drivers/dma/idxd/sysfs.c                           |   4 +-
 drivers/dma/img-mdc-dma.c                          |   4 +-
 drivers/dma/imx-dma.c                              |   4 +-
 drivers/dma/imx-sdma.c                             |  43 +-
 drivers/dma/mcf-edma.c                             |   5 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |   4 +-
 drivers/dma/mmp_pdma.c                             |   4 +-
 drivers/dma/mmp_tdma.c                             |   4 +-
 drivers/dma/moxart-dma.c                           |   4 +-
 drivers/dma/mv_xor_v2.c                            |   7 +-
 drivers/dma/mxs-dma.c                              |   4 +-
 drivers/dma/nbpfaxi.c                              |   4 +-
 drivers/dma/ppc4xx/adma.c                          |  12 +-
 drivers/dma/ptdma/ptdma-dmaengine.c                |   2 +-
 drivers/dma/pxa_dma.c                              |   4 +-
 drivers/dma/qcom/bam_dma.c                         |   4 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |   7 +-
 drivers/dma/sf-pdma/sf-pdma.h                      |   1 -
 drivers/dma/sh/usb-dmac.c                          |   4 +-
 drivers/dma/stm32-dmamux.c                         |   4 +-
 drivers/dma/stm32-mdma.c                           |   4 +-
 drivers/dma/sun4i-dma.c                            |   4 +-
 drivers/dma/sun6i-dma.c                            |   7 +-
 drivers/dma/tegra210-adma.c                        |   4 +-
 drivers/dma/ti/Makefile                            |   3 +-
 drivers/dma/ti/cppi41.c                            |  10 +-
 drivers/dma/ti/k3-psil-am62a.c                     | 196 +++++
 drivers/dma/ti/k3-psil-priv.h                      |   1 +
 drivers/dma/ti/k3-psil.c                           |   1 +
 drivers/dma/ti/k3-udma.c                           |  42 +-
 drivers/dma/ti/omap-dma.c                          |   4 +-
 drivers/dma/xilinx/Makefile                        |   1 +
 drivers/dma/xilinx/xdma-regs.h                     | 166 ++++
 drivers/dma/xilinx/xdma.c                          | 974 +++++++++++++++++=
++++
 drivers/dma/xilinx/zynqmp_dma.c                    |   4 +-
 include/linux/dma/amd_xdma.h                       |  16 +
 include/linux/dma/imx-dma.h                        |   1 +
 include/linux/dmaengine.h                          |  13 +-
 include/linux/platform_data/amd_xdma.h             |  34 +
 88 files changed, 2119 insertions(+), 445 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
 create mode 100644 drivers/dma/ti/k3-psil-am62a.c
 create mode 100644 drivers/dma/xilinx/xdma-regs.h
 create mode 100644 drivers/dma/xilinx/xdma.c
 create mode 100644 include/linux/dma/amd_xdma.h
 create mode 100644 include/linux/platform_data/amd_xdma.h

--=20
~Vinod

--LJuaWkJpLxVxPSkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmP4ujMACgkQfBQHDyUj
g0dBAg/9FfEfETxIWbeYHCW+aE5DfWOAD7D2WwpFPFTkM21rxE1anv1bnGqyrtwW
1B9ZBiPGXZHzgJv8YdzgbSSaA3FNWAYpTwssCaBkOW/XcHzx+QvJJHEwf04a6FAp
LcJ34JQmhLY4YCM+vl4asJsYm+rknF+dkCEx4yz0+8/czlUnVH8U8OaMIwg4Aare
sdsbuv4jUxQWpRCm06eNZhP/2AXAr8J4HUpiYP9zaNFGAz0Blc1wVLCzrmMi8WKS
qXFCCLLX7SsoqvpOdhbpUrOPEN01R0xWHZ6wNsRM6TyP13bgetOeeNWmFE47mstc
ajnLszTUy7c03+x5JOHXrALYnSPG5L94vSQxDAvHmC3i0m6+++T2xjDrSO+6FdDC
LRu+cAns0+WkwhEgapVXuFvyFjPxEk7zmd8SURWz9LdvTN3MrPETuUVqFEBtqXEO
cZjJQIkCWBFeMTI40X4MbmJVgWtTifcLtoYCZfamEoMid/V06ECKyys8MmwI2y1i
9FPOmzlsqs1e/kc4aP/sS8XsWpb6OaJDkey6u88UxdxqDrxgw3r31MgIaqwQcncP
9vtZSKVpDjHMSk/oqLMevNA+9Kzs8sJPd6EKiaVS64GUZjavFaTGSM+rH8zcFr4a
Wfv4Kmrnm4bh5/qbaF3vS8+zORAdpZ0ZuUz/GzduHea4kUt+FtY=
=yUPm
-----END PGP SIGNATURE-----

--LJuaWkJpLxVxPSkZ--
