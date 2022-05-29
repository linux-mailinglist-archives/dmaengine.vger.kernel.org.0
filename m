Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC845371F2
	for <lists+dmaengine@lfdr.de>; Sun, 29 May 2022 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiE2Rus (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 May 2022 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiE2Rur (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 May 2022 13:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B336306;
        Sun, 29 May 2022 10:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D584A60F7C;
        Sun, 29 May 2022 17:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5B9C385A9;
        Sun, 29 May 2022 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653846644;
        bh=Nqu6LYi1M4TPdDOmmWSfOpvLTe+WZrU2kCZcF4a6gI8=;
        h=Date:From:To:Cc:Subject:From;
        b=F/zx9KHAPf1tP86yl2jLf1PQIp3+Ixelus19x/JS6X/vALzwUDNWe+hQnqs/hpw1w
         xZASRwfc1j8Ej/2LqOzRXRbgMYlA3IsqcS+k/mRtAxOkZ/Oz3LqfE4HTZasbfARFKN
         2O1gorstC+W44RYlf2C8rIAnY3Qs5Go2I471XVTOJu0eqmUb5tNrYwuLPY95xKP13s
         Q+zoKhqulQKlXjiyWjUv/11jEz1UGyRlpj4D5Xrd7KBvHw9vwPtUIIizv4KF0l9pUh
         zfsO0759mnoNxVPSnOhH/VUuDEBcFjjjT4A9ux15lNaQkfk1mWQLN4fGL+kPfwc4a4
         4S4DC4c8uNMAg==
Date:   Sun, 29 May 2022 23:20:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.19-rc1
Message-ID: <YpOyb40/g5gIYigF@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lBz0p5SFweCV4BB4"
Content-Disposition: inline
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--lBz0p5SFweCV4BB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the dmaengine updates for this cycle. Nothing
special, this includes a couple of new device support and new driver
support and bunch of driver updates.

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-5.19-rc1

for you to fetch changes up to d1a28597808268b87f156138aad3104aa255e62b:

  dmaengine: idxd: make idxd_wq_enable() return 0 if wq is already enabled =
(2022-05-19 23:43:41 +0530)

----------------------------------------------------------------
dmaengine updates for v5.19-rc1

 New support:
 - Tegra gpcdma Driver support
 - Qualcomm SM8350, Sm8450 and SC7280 Device support
 - Renesas RZN1 dma and platform support

 Updates:
 - stm32 device pause/resume support and updates
 - DMA memset ops Documentation and usage clarification
 - Deprecate '#dma-channels' & '#dma-requests' bindings
 - Driver updates for stm32, ptdma idsx etc

----------------------------------------------------------------
Aidan MacDonald (1):
      dmaengine: jz4780: set DMA maximum segment size

Akhil R (5):
      dt-bindings: dmaengine: Add doc for tegra gpcdma
      dmaengine: tegra: Add tegra gpcdma driver
      dmaengine: tegra: Use platform_get_irq() to get IRQ resource
      dmaengine: tegra: Fix uninitialized variable usage
      dmaengine: tegra: Remove unused switch case

Amelie Delaunay (9):
      dmaengine: stm32-mdma: check the channel availability (secure or not)
      dmaengine: stm32-mdma: remove GISR1 register
      dmaengine: stm32-mdma: fix chan initialization in stm32_mdma_irq_hand=
ler()
      dmaengine: stm32-mdma: use dev_dbg on non-busy channel spurious it
      dmaengine: stm32-dmamux: avoid reset of dmamux if used by coprocessor
      dmaengine: stm32-dma: introduce stm32_dma_sg_inc to manage chan->next=
_sg
      dmaengine: stm32-dma: pass DMA_SxSCR value to stm32_dma_handle_chan_d=
one()
      dmaengine: stm32-dma: rename pm ops before dma pause/resume introduct=
ion
      dmaengine: stm32-dma: add device_pause/device_resume support

Ben Walker (4):
      dmaengine: Document dmaengine_prep_dma_memset
      dmaengine: at_hdmac: In atc_prep_dma_memset, treat value as a single =
byte
      dmaengine: at_xdmac: In at_xdmac_prep_dma_memset, treat value as a si=
ngle byte
      dmaengine: hidma: In hidma_prep_dma_memset treat value as a single by=
te

Bjorn Andersson (1):
      dmaengine: qcom: gpi: Add SM8350 support

Christophe JAILLET (2):
      dmaengine: Remove a useless mutex
      dmaengine: idxd: Fix the error handling path in idxd_cdev_register()

Christophe Leroy (1):
      dmaengine: bestcomm: Prepare cleanup of powerpc's asm/prom.h

Dave Jiang (16):
      dmaengine: idxd: don't load pasid config until needed
      dmaengine: idxd: remove trailing white space on input str for wq name
      dmaengine: idxd: update IAA definitions for user header
      dmaengine: idxd: set DMA_INTERRUPT cap bit
      dmaengine: idxd: set max_xfer and max_batch for RO device
      dmaengine: add verification of DMA_INTERRUPT capability for dmatest
      dmaengine: idxd: move wq irq enabling to after device enable
      dmaengine: idxd: refactor wq driver enable/disable operations
      dmaengine: idxd: Separate user and kernel pasid enabling
      dmaengine: idxd: fix lockdep warning on device driver removal
      dmaengine: idxd: free irq before wq type is reset
      dmaengine: idxd: remove redudant idxd_wq_disable_cleanup() call
      dmaengine: idxd: make idxd_register/unregister_dma_channel() static
      dmaengine: idxd: skip irq free when wq type is not kernel
      dmaengine: idxd: add missing callback function to support DMA_INTERRU=
PT
      dmaengine: idxd: make idxd_wq_enable() return 0 if wq is already enab=
led

Geert Uytterhoeven (1):
      dt-bindings: renesas,rcar-dmac: R-Car V3U is R-Car Gen4

Haowen Bai (2):
      dmaengine: pl08x: drop the useless function
      dmaengine: mediatek: mtk-hsdma: use NULL instead of using plain integ=
er as pointer

Ilya Novikov (1):
      dmaengine: PTDMA: support polled mode

Jayesh Choudhary (1):
      dmaengine: ti: k3-psil-am62: Update PSIL thread for saul.

Jiapeng Chong (1):
      dmaengine: tegra: Remove unused including <linux/version.h>

Krzysztof Kozlowski (7):
      dt-bindings: dmaengine: sprd: deprecate '#dma-channels'
      dmaengine: sprd: deprecate '#dma-channels'
      dt-bindings: dmaengine: mmp: deprecate '#dma-channels' and '#dma-requ=
ests'
      dmaengine: pxa: deprecate '#dma-channels' and '#dma-requests'
      dmaengine: mmp: deprecate '#dma-channels'
      dmaengine: ti: deprecate '#dma-channels'
      dt-bindings: dma: pl330: Add power-domains

Lad Prabhakar (4):
      dmaengine: sh: Kconfig: Make RZ_DMAC depend on ARCH_RZG2L
      dmaengine: nbpfaxi: Use platform_get_irq_optional() to get the interr=
upt
      dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to get the int=
errupt
      dmaengine: mediatek-cqdma: Use platform_get_irq() to get the interrupt

Minghao Chi (1):
      dmaengine: idxd: Remove unnecessary synchronize_irq() before free_irq=
()

Miquel Raynal (7):
      dt-bindings: dmaengine: Introduce RZN1 dmamux bindings
      dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
      dt-bindings: dmaengine: Introduce RZN1 DMA compatible
      clk: renesas: r9a06g032: Export function to set dmamux
      dmaengine: dw: dmamux: Introduce RZN1 DMA router support
      clk: renesas: r9a06g032: Probe possible children
      dmaengine: dw: Add RZN1 compatible

Olivier Dautricourt (2):
      MAINTAINERS: update my email address
      dt-bindings: altr,msgdma: update my email address

Paul Kocialkowski (1):
      dmaengine: Clarify cyclic transfer residue documentation

Radhey Shyam Pandey (3):
      dt-bindings: dmaengine: xilinx_dma: Add MCMDA channel ID index descri=
ption
      dmaengine: zynqmp_dma: In struct zynqmp_dma_chan fix desc_size data t=
ype
      dmaengine: zynqmp_dma: use pm_runtime_resume_and_get() instead of pm_=
runtime_get_sync()

Samuel Holland (4):
      dt-bindings: dma: sun50i-a64: Add compatible for D1
      dmaengine: sun6i: Do not use virt_to_phys
      dmaengine: sun6i: Add support for 34-bit physical addresses
      dmaengine: sun6i: Add support for the D1 variant

Shravya Kumbham (1):
      dmaengine: zynqmp_dma: check dma_async_device_register return value

Vinod Koul (6):
      dmaengine: qcom: gpi: set chain and link flag for duplex
      dt-bindings: dmaengine: qcom: gpi: add compatible for sm8350/sm8350
      dmaengine: qcom: gpi: Add support for ee_offset
      dt-bindings: dmaengine: qcom: gpi: add compatible for sc7280
      dmaengine: ptdma: statify pt_tx_status
      dmaengine: qcom: gpi: Add support for sc7280

YueHaibing (1):
      dmaengine: tegra: Fix build error without IOMMU_API

Yunbo Yu (2):
      dmaengine: plx_dma: Move spin_lock_bh() to spin_lock()
      dmaengine: mv_xor_v2 : Move spin_lock_bh() to spin_lock()

Zong Li (2):
      dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and =
modify compatible
      dmaengine: sf-pdma: Get number of channel by device tree

jianchunfu (1):
      dmaengine: ep93xx: Remove redundant word in comment

 .../bindings/clock/renesas,r9a06g032-sysctrl.yaml  |   11 +
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |    9 +-
 .../devicetree/bindings/dma/altr,msgdma.yaml       |    2 +-
 .../devicetree/bindings/dma/arm,pl330.yaml         |    3 +
 Documentation/devicetree/bindings/dma/mmp-dma.txt  |   10 +-
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  110 ++
 .../devicetree/bindings/dma/qcom,gpi.yaml          |    3 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   10 +-
 .../bindings/dma/renesas,rzn1-dmamux.yaml          |   51 +
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   19 +-
 .../bindings/dma/snps,dma-spear1340.yaml           |    8 +-
 Documentation/devicetree/bindings/dma/sprd-dma.txt |    7 +-
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    6 +-
 Documentation/driver-api/dmaengine/provider.rst    |    8 +-
 MAINTAINERS                                        |    3 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |   40 +-
 drivers/dma/Kconfig                                |   14 +-
 drivers/dma/Makefile                               |    1 +
 drivers/dma/amba-pl08x.c                           |   11 -
 drivers/dma/at_hdmac.c                             |   10 +-
 drivers/dma/at_xdmac.c                             |    9 +-
 drivers/dma/bestcomm/bestcomm.c                    |    2 +
 drivers/dma/dma-jz4780.c                           |    9 +
 drivers/dma/dmaengine.c                            |    7 -
 drivers/dma/dmatest.c                              |   13 +-
 drivers/dma/dw/Kconfig                             |    9 +
 drivers/dma/dw/Makefile                            |    2 +
 drivers/dma/dw/platform.c                          |    1 +
 drivers/dma/dw/rzn1-dmamux.c                       |  155 ++
 drivers/dma/ep93xx_dma.c                           |    2 +-
 drivers/dma/idxd/cdev.c                            |   18 +-
 drivers/dma/idxd/device.c                          |  152 +-
 drivers/dma/idxd/dma.c                             |   65 +-
 drivers/dma/idxd/idxd.h                            |   20 +-
 drivers/dma/idxd/init.c                            |   30 +-
 drivers/dma/idxd/registers.h                       |    1 +
 drivers/dma/idxd/sysfs.c                           |   12 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |   12 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |   13 +-
 drivers/dma/mmp_pdma.c                             |   14 +-
 drivers/dma/mv_xor_v2.c                            |    4 +-
 drivers/dma/nbpfaxi.c                              |   14 +-
 drivers/dma/plx_dma.c                              |    4 +-
 drivers/dma/ptdma/ptdma-dev.c                      |   36 +-
 drivers/dma/ptdma/ptdma-dmaengine.c                |   16 +-
 drivers/dma/ptdma/ptdma.h                          |   13 +
 drivers/dma/pxa_dma.c                              |   13 +-
 drivers/dma/qcom/gpi.c                             |   21 +-
 drivers/dma/qcom/hidma.c                           |   13 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |   24 +-
 drivers/dma/sf-pdma/sf-pdma.h                      |    8 +-
 drivers/dma/sh/Kconfig                             |    2 +-
 drivers/dma/sprd-dma.c                             |    6 +-
 drivers/dma/stm32-dma.c                            |  311 +++-
 drivers/dma/stm32-dmamux.c                         |    2 +-
 drivers/dma/stm32-mdma.c                           |   53 +-
 drivers/dma/sun6i-dma.c                            |   92 +-
 drivers/dma/tegra186-gpc-dma.c                     | 1498 ++++++++++++++++=
++++
 drivers/dma/ti/cppi41.c                            |    6 +-
 drivers/dma/ti/k3-psil-am62.c                      |    8 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |   17 +-
 include/linux/dmaengine.h                          |    9 +-
 include/linux/soc/renesas/r9a06g032-sysctrl.h      |   11 +
 include/uapi/linux/idxd.h                          |   31 +-
 64 files changed, 2744 insertions(+), 350 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-g=
pc-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmam=
ux.yaml
 create mode 100644 drivers/dma/dw/rzn1-dmamux.c
 create mode 100644 drivers/dma/tegra186-gpc-dma.c
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

--=20
~Vinod

--lBz0p5SFweCV4BB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmKTsm8ACgkQfBQHDyUj
g0c53A/9GNKxL2aqneaesmpBwbKZh3kJY975zjW+eUFu0ojyqxDjpjrMzWuDXBXt
FAUU+hgqvm1Q9JoZ91DkuSc6mlmPZX5AXFm7XaYJ0enVXkN0aseIXvrMa0IpS9Oz
QwzFu7HG+qm1gKUqG6s7V3+HlfFYeb0Kmvc46vycaWs23G4XSEv29wZ0qiiK3B9Y
0qpu+f/ryRHDSkLDHB1UNUPtCVvSikh/fnxScHeHE7vDoT0AJrZcyEjGfky6Oq7S
SUd3LxHsfdbIkWb94VuGCzIndFyq6wdTejarIk8tCWZ7tmm4QszatBIQ78kmUEsX
uD05AWkkRljsRUqrElz27tdRcL4bBSmH2DUjkhpKeVOvaGxEiItF+C661T2oc9us
d7DILXdJNPslQr4rpjXus59rbHb6c7g20gelCIsHqiQNh20C1t/V3j5Z7NTk1GP6
qHmfO5Dq4hLh5+9/ave3qKS7LYkoubEYi8M+EK/PkA7xfYTgSpb3FcpKLIURB68i
NfyKNeSABkOn/4ELQRidjQDmpmXeulFnzGrIWqWy960QXKpExmEnII+GYC4a6VRb
Oc8TgBEMBlQfAIf6bX0RKqSp8VBpUPyme5P/xX+vIPCrrhif4pOCQbqQsSCW3tf5
uZs5OpN99limQBV0zMdtAOUZVeoWYtl1c8iorwUwyrZ1GV4Xhl4=
=doeh
-----END PGP SIGNATURE-----

--lBz0p5SFweCV4BB4--
