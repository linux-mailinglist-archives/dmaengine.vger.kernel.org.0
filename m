Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D84EBA4E
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 07:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiC3FrR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 01:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbiC3FrQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 01:47:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44D25B922;
        Tue, 29 Mar 2022 22:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6834B81ACC;
        Wed, 30 Mar 2022 05:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEF2C340F0;
        Wed, 30 Mar 2022 05:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648619129;
        bh=+dFFtZ8prwqR8keMMZ0czQlcVb6F+bnUCinktbzjtIc=;
        h=Date:From:To:Cc:Subject:From;
        b=Uyvobwzy0RXtYkwjjXIvWrUilYts+edBdUPQZM6QTkOL7dMDFwsbt96OA77ayQze2
         +swnS912xaJU2AQwLdu0EI8g+wpw/gVxbug8VUZ7exPros0ydr0CnoQ9VielDTTTeb
         rLjrtxA60HV/WBFWxHwCIvxzJ8RsyQ2rJ2dekc7pS7KwnnNb/7C09Den0V5NWphuQt
         9apqy6WAZ6BaMHZTrknVWU2ozgDsR6Vtl/rJh93ImrXSw8gkpzj47r+Inww0ipLErh
         5hd6N6G6cb+zWK2rdwMQwyZ7S7Wp2/Mhg+TxUQnOrrLS1gaoAntzychfLn4oIH9FtS
         VV6ER/yzniw8w==
Date:   Wed, 30 Mar 2022 11:15:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v5.18-rc1
Message-ID: <YkPudJlxlw+Ab3Fi@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Linus,

Please pull to receive updates for dmaengine. This time we have bunch of
driver updates and some new device support.

The following changes since commit 455896c53d5b803733ddd84e1bf8a430644439b6:

  dmaengine: shdma: Fix runtime PM imbalance on error (2022-02-15 11:04:16 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.18-rc1

for you to fetch changes up to b95044b38425f563404234d96bbb20cc6360c7e1:

  dmaengine: hisi_dma: fix MSI allocate fail when reload hisi_dma (2022-03-11 16:05:39 +0530)

----------------------------------------------------------------
dmaengine updates for v5.18-rc1

New support:
 - Document RZ/V2L and RZ/G2UL dma binding
 - TI AM62x k3-udma and k3-psil support

Updates:
 - Yaml conversion for Mediatek uart apdma schema
 - Removal of DMA-32 fallback configuration for various drivers
 - imx-sdma updates for channel restart

----------------------------------------------------------------
Amelie Delaunay (1):
      dmaengine: stm32-dma: set dma_device max_sg_burst

AngeloGioacchino Del Regno (1):
      dt-bindings: dma: Convert mtk-uart-apdma to DT schema

Biju Das (2):
      dt-bindings: dma: rz-dmac: Document RZ/V2L SoC
      dt-bindings: dma: rz-dmac: Document RZ/G2UL SoC

Cai Huoqing (1):
      dmaengine: ppc4xx: Make use of the helper macro LIST_HEAD()

Christophe JAILLET (4):
      dmaengine: iot: Remove useless DMA-32 fallback configuration
      dmaengine: altera-msgdma: Remove useless DMA-32 fallback configuration
      dmaengine: qcom_hidma: Remove useless DMA-32 fallback configuration
      dmaengine: idxd: Remove useless DMA-32 fallback configuration

Dave Jiang (1):
      dmaengine: idxd: restore traffic class defaults after wq reset

Geert Uytterhoeven (1):
      dmaengine: fsl-dpaa2-qdma: Drop comma after SoC match table sentinel

Jie Hai (1):
      dmaengine: hisi_dma: fix MSI allocate fail when reload hisi_dma

Lad Prabhakar (1):
      dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency for RZ_DMAC config option

Sanjay R Mehta (2):
      dmaengine: ptdma: fix concurrency issue with multiple dma transfer
      dmaengine: ptdma: handle the cases based on DMA is complete

Tom Rix (2):
      dmaengine: ti: cleanup comments
      dmaengine: dw-axi-dmac: cleanup comments

Tomasz Moń (2):
      dmaengine: imx-sdma: restart cyclic channel if needed
      dmaengine: imx-sdma: fix cyclic buffer race condition

Vignesh Raghavendra (2):
      dmaengine: ti: k3-udma: Add AM62x DMSS support
      dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data

Vinod Koul (2):
      Merge tag 'dmaengine-fix-5.17' into next
      dmaengine: Revert "dmaengine: shdma: Fix runtime PM imbalance on error"

Yang Li (1):
      dmaengine: imx-sdma: clean up some inconsistent indenting

 .../devicetree/bindings/dma/mediatek,uart-dma.yaml | 122 ++++++++++++++
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |  56 -------
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |   4 +-
 drivers/dma/altera-msgdma.c                        |   4 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |   8 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |   2 +-
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h            |   2 +-
 drivers/dma/hisi_dma.c                             |   2 +-
 drivers/dma/idxd/device.c                          |   9 +-
 drivers/dma/idxd/init.c                            |   2 -
 drivers/dma/imx-sdma.c                             |  22 ++-
 drivers/dma/ioat/init.c                            |   2 -
 drivers/dma/ppc4xx/adma.c                          |   2 +-
 drivers/dma/ptdma/ptdma-dmaengine.c                |  24 ++-
 drivers/dma/qcom/hidma.c                           |   4 +-
 drivers/dma/sh/Kconfig                             |   6 +-
 drivers/dma/sh/shdma-base.c                        |   4 +-
 drivers/dma/stm32-dma.c                            |   1 +
 drivers/dma/ti/Makefile                            |   3 +-
 drivers/dma/ti/cppi41.c                            |   6 +-
 drivers/dma/ti/edma.c                              |  10 +-
 drivers/dma/ti/k3-psil-am62.c                      | 186 +++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h                      |   1 +
 drivers/dma/ti/k3-psil.c                           |   1 +
 drivers/dma/ti/k3-udma.c                           |   1 +
 drivers/dma/ti/omap-dma.c                          |   2 +-
 26 files changed, 383 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
 create mode 100644 drivers/dma/ti/k3-psil-am62.c

Thanks
-- 
~Vinod
