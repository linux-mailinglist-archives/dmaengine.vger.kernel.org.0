Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE7589987
	for <lists+dmaengine@lfdr.de>; Thu,  4 Aug 2022 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiHDIyT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Aug 2022 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiHDIyS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Aug 2022 04:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC8F03;
        Thu,  4 Aug 2022 01:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3075B614D9;
        Thu,  4 Aug 2022 08:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BCCC433D6;
        Thu,  4 Aug 2022 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659603256;
        bh=tkKPSh8kyDhnq3IzJjjXOCdA6Qkeb1uUtfHbUbuOX2s=;
        h=Date:From:To:Cc:Subject:From;
        b=npADsvgdtsnuILlktuvNZWTg4mehhUKaESuLh30aTKWz62BZD/RJrcOOZJ5aDGZJy
         xExCrKiAZgZNvxXDa9T7ATm1GxP5xQsxVkZdwSvmCUGRPyG3StrbXCOnqIvSl0dcBU
         PvZEiLJATUynMKwUV1epniwMRKvevTfAfbrFOMWJP42cpiZtzpRbMc4axgzUjdA6Zb
         4qXcTTfuDzvFjgfNjIDadGj//BA1D1E3W6FJFbNfLPEmKgaZ9nGNy+2vjWARTp1aLn
         /hU1gHSs/ih7WjdxwXd2TzMImTVpmzaO98mfgoTo6Xkl7+tQ5sk7z2oeg50TBOjO8d
         66Yl1O/hwwjdQ==
Date:   Thu, 4 Aug 2022 14:24:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.0-rc1
Message-ID: <YuuJNJ7/3AXzKMF7@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RuxD/X4zjazRFSzM"
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--RuxD/X4zjazRFSzM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine updates for v6.0-rc1. One thing which
might interest you is the Apple ADMAC driver which should be for your
shiny new laptop :)

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.0-rc1

for you to fetch changes up to a1873f837f9e5c1001462a635af1b0bab31aa9fd:

  dmaengine: mediatek: mtk-hsdma: Fix typo 'the the' in comment (2022-07-26=
 22:06:05 +0530)

----------------------------------------------------------------
dmaengine updates for v6.0-rc1

 New support/Core
 - Remove DMA_MEMCPY_SG for lack of users
 - Tegra 234 dmaengine support
 - Mediatek MT8365 dma support
 - Apple ADMAC driver

 Updates:
 - Yaml conversion for ST-Ericsson DMA40 binding and Freescale edma
 - rz-dmac updates and device_synchronize support
 - Bunch of typo in comments fixes in drivers
 - multithread support in sf-pdma driver

----------------------------------------------------------------
Akhil R (2):
      dt-bindings: dmaengine: Add compatible for Tegra234
      dmaengine: tegra: Add terminate() for Tegra234

Alexey Khoroshilov (1):
      dmaengine: stm32-mdma: Remove dead code in stm32_mdma_irq_handler()

Ben Dooks (2):
      dmaengine: dw-axi-dmac: do not print NULL LLI during error
      dmaengine: dw-axi-dmac: ignore interrupt if no descriptor

Biju Das (1):
      dmaengine: sh: rz-dmac: Add device_synchronize callback

Christoph Hellwig (1):
      dmaengine: remove DMA_MEMCPY_SG once again

Colin Ian King (1):
      dmaengine: fsl-edma: remove redundant assignment to pointer last_sg

Conor Dooley (1):
      dt-bindings: dma: dw-axi-dmac: extend the number of interrupts

Dave Jiang (1):
      MAINTAINERS: idxd driver maintainer update

Fabien Parent (1):
      dt-bindings: dma: mediatek,uart-dma: add MT8365 bindings

Fabio Estevam (2):
      dmaengine: imx-sdma: Improve the SDMA irq name
      dmaengine: imx-dma: Cast of_device_get_match_data() with (uintptr_t)

Fenghua Yu (1):
      dmaengine: idxd: Correct IAX operation code names

Geert Uytterhoeven (3):
      dmaengine: dmatest: Remove spaces before tabs
      dmaengine: dmatest: Replace symbolic permissions by octal permissions
      dmaengine: apple-admac: Use {low,upp}er_32_bits() to split 64-bit add=
ress

Jayesh Choudhary (1):
      dmaengine: ti: k3-psil-j721s2: Add psil threads for sa2ul

Jiang Jian (1):
      dmaengine: ep93xx: Fix typo in comments

Jiapeng Chong (1):
      dmaengine: altera-msgdma: Fixed some inconsistent function name descr=
iptions

Julia Lawall (7):
      dmaengine: fix typos in comments
      dmaengine: mediatek-cqdma: fix typo in comment
      dmaengine: owl: fix typo in comment
      dmaengine: qcom: fix typo in comment
      dmaengine: s3c24xx: fix typo in comment
      dmaengine: jz4780: fix typo in comment
      dmaengine: ste_dma40: fix typo in comment

Linus Walleij (1):
      dt-bindings: dma: Rewrite ST-Ericsson DMA40 to YAML

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/dma to DMA GENERIC OFFLOAD ENGIN=
E SUBSYSTEM

Martin Povi=C5=A1er (3):
      dt-bindings: dma: Add Apple ADMAC
      dmaengine: apple-admac: Add Apple ADMAC driver
      MAINTAINERS: Add ADMAC driver under ARM/APPLE MACHINE

Mathias Tausen (1):
      dmaengine: axi-dmac: check cache coherency register

Miquel Raynal (2):
      dmaengine: dw: dmamux: Export the module device table
      dmaengine: dw: dmamux: Fix build without CONFIG_OF

Peng Fan (1):
      dt-bindings: dma: fsl-edma: Convert to DT schema

Rob Herring (1):
      dt-bindings: dma: apple,admac: Fix example interrupt parsing

Samuel Holland (1):
      dmaengine: sun4i: Set the maximum segment size

Shengjiu Wang (2):
      dmaengine: imx-sdma: Add missing struct documentation
      dmaengine: imx-sdma: Add FIFO stride support for multi FIFO script

Slark Xiao (1):
      dmaengine: mediatek: mtk-hsdma: Fix typo 'the the' in comment

Tang Bin (1):
      dmaengine: xilinx_dpdma: Omit superfluous error message in xilinx_dpd=
ma_probe()

Uwe Kleine-K=C3=B6nig (1):
      dmaengine: sprd: Cleanup in .remove() after pm_runtime_get_sync() fai=
led

Viacheslav Mitrofanov (1):
      dmaengine: sf-pdma: Add multithread support for a DMA channel

Vinod Koul (1):
      dmaengine: apple-admac: Fix print format

Vladimir Zapolskiy (1):
      dmaengine: dw-edma: remove a macro conditional with similar branches

Xiang wangx (2):
      dmaengine: at_xdmac: Fix typo in comment
      dmaengine: mediatek: mtk-hsdma: Fix typo in comment

XueBing Chen (2):
      dmaengine: dmatest: use strscpy to replace strlcpy
      dmaengine: xilinx: use strscpy to replace strlcpy

 .../devicetree/bindings/dma/apple,admac.yaml       |  80 ++
 .../devicetree/bindings/dma/fsl,edma.yaml          | 155 ++++
 Documentation/devicetree/bindings/dma/fsl-edma.txt | 111 ---
 .../devicetree/bindings/dma/mediatek,uart-dma.yaml |   1 +
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |   4 +-
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  |   7 +-
 .../devicetree/bindings/dma/ste-dma40.txt          | 138 ----
 .../devicetree/bindings/dma/stericsson,dma40.yaml  | 159 ++++
 Documentation/driver-api/dmaengine/provider.rst    |  10 -
 MAINTAINERS                                        |   6 +-
 drivers/dma/Kconfig                                |   8 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/altera-msgdma.c                        |   4 +-
 drivers/dma/amba-pl08x.c                           |   2 +-
 drivers/dma/apple-admac.c                          | 818 +++++++++++++++++=
++++
 drivers/dma/at_xdmac.c                             |   2 +-
 drivers/dma/dma-axi-dmac.c                         |  16 +
 drivers/dma/dma-jz4780.c                           |   2 +-
 drivers/dma/dmaengine.c                            |   7 -
 drivers/dma/dmatest.c                              |  45 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  11 +
 drivers/dma/dw-edma/dw-edma-v0-core.c              |   8 -
 drivers/dma/dw/rzn1-dmamux.c                       |   3 +
 drivers/dma/ep93xx_dma.c                           |   2 +-
 drivers/dma/fsl-edma-common.c                      |   3 -
 drivers/dma/imx-dma.c                              |   2 +-
 drivers/dma/imx-sdma.c                             |  38 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |   2 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |   4 +-
 drivers/dma/mv_xor_v2.c                            |   2 +-
 drivers/dma/owl-dma.c                              |   2 +-
 drivers/dma/s3c24xx-dma.c                          |   2 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |  44 +-
 drivers/dma/sh/rz-dmac.c                           |  17 +
 drivers/dma/sprd-dma.c                             |   5 +-
 drivers/dma/ste_dma40.c                            |   2 +-
 drivers/dma/stm32-mdma.c                           |   5 -
 drivers/dma/sun4i-dma.c                            |  32 +-
 drivers/dma/tegra186-gpc-dma.c                     |  26 +-
 drivers/dma/ti/k3-psil-j721s2.c                    |   8 +
 drivers/dma/xilinx/xilinx_dma.c                    | 122 ---
 drivers/dma/xilinx/xilinx_dpdma.c                  |   6 +-
 include/linux/dma/imx-dma.h                        |  13 +
 include/linux/dma/qcom-gpi-dma.h                   |   2 +-
 include/linux/dmaengine.h                          |  20 -
 include/uapi/linux/idxd.h                          |   6 +-
 46 files changed, 1461 insertions(+), 502 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,edma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/ste-dma40.txt
 create mode 100644 Documentation/devicetree/bindings/dma/stericsson,dma40.=
yaml
 create mode 100644 drivers/dma/apple-admac.c

Thanks
--=20
~Vinod

--RuxD/X4zjazRFSzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmLrWuMACgkQfBQHDyUj
g0df5g/8D4IyxwFdewZthyL58Rn33OcPaw1L4NJ53hMAW07474q7+TFhu5zuwhfB
AMoaVjS3SGLCeTQD33/ahOQSgBVJK5C/44v1S+6koyIEn4PyqkKditJ/MGgNS1Tb
YWv/Gy+ufzYkmERaXl4WAYRXconKMA9DijRxJol3anePfS3lF3etdUQZdFOOYtl4
iQh24oO3Hk4tavCGnuN/r/JuJ6MpeObxEtNJBQgwIw6oMq15AsATlpTed90jsWP6
IIHi55FL3G3IHEsPBDP0m4M38ABD79DShiRR4Dy7ClzcrxO+Zo25BzaEROUG05oT
xiY/Sz6/iSuOyZ7go+a86sQXnMS/nb81Zjq4n2tt+Z02VBKlt4CnF5dzwueMwZSv
7Wtc3oJo9f0nIYyN70w33+xq/+LYpt1RYymFRCndYI4RwbzEnBIusAQXQVj7yLwj
yUt+2JOQegfw9z44D+2GnIzEsiNAjLqxtWLGOsmQlzDAnNnc9q2eQDCVu+ipUr81
OtjSNoDHBH6TEYltkeZM9aZMFwVJC7nvt407bwT7q/rXQhtR7TjI9bcr72SD0/U6
oEhcK/csE8WyZtFhTw+t1Ym3yCSH4fh1bBszSSzNu0ysbNmUtGvflLBvo86kzXia
HgA0fVYCk7y3m2EOokATaJhhdy1NYjxyGwR/p/uFK2EqIzy94hI=
=mQTe
-----END PGP SIGNATURE-----

--RuxD/X4zjazRFSzM--
