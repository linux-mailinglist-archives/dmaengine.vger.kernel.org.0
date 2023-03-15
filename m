Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7B6BA499
	for <lists+dmaengine@lfdr.de>; Wed, 15 Mar 2023 02:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCOB2z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Mar 2023 21:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCOB2y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Mar 2023 21:28:54 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [IPv6:2001:41d0:203:375::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482CF19C4A
        for <dmaengine@vger.kernel.org>; Tue, 14 Mar 2023 18:28:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678843726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SbhNB0cfLDO3HtuutBQ598/LzaRS6h4ccRnDWxuQ86I=;
        b=oSHp16b9M+WrfR1yGZCG7/6dHjG0AKOnISXP5kGNnGVPjLSgNJe4i8vJP7lTaS62fNhjse
        3aJEne0h7bxxPnXJQDrCopbmF67nhLTQga9fB8yto7zS5iEixOrnwwNyE67juKqNIbGR2n
        ZL0JdLqQQ/oqb0XABKwBDyWAkWjClBQ=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 0/5] dmaengine: dw-edma: Add support for native HDMA
Date:   Wed, 15 Mar 2023 09:28:31 +0800
Message-Id: <20230315012840.6986-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for HDMA NATIVE, as long the IP design has set
the compatible register map parameter-HDMA_NATIVE,
which allows compatibility for native HDMA register configuration.

The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
And the native HDMA registers are different from eDMA,
so this patch add support for HDMA NATIVE mode.

HDMA write and read channels operate independently to maximize
the performance of the HDMA read and write data transfer over
the link When you configure the HDMA with multiple read channels,
then it uses a round robin (RR) arbitration scheme to select
the next read channel to be serviced.The same applies when
youhave multiple write channels.

The native HDMA driver also supports a maximum of 16 independent
channels (8 write + 8 read), which can run simultaneously.
Both SAR (Source Address Register) and DAR (Destination Address Register)
are aligned to byte.

Cai Huoqing (2):
  dmaengine: dw-edma: Add support for native HDMA
  dmaengine: dw-edma: Optimization in dw_edma_v0_core_handle_int

Cai huoqing (3):
  dmaengine: dw-edma: Rename dw_edma_core_ops structure to
    dw_edma_plat_ops
  dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
    abstract controller operation
  dmaengine: dw-edma: Add HDMA DebugFS support

v6->v7:
  [1/5]
  1.Update the commit log.
  [2/5]
  2.Revert dw_edma_core_handle_int back to dw-edma-core.h.
  3.Fix code style.
  [3/5]
  4.Move the change of register file from patch[4/5] to patch[3/5].
  5.Fix code style.

v6 link:
  https://lore.kernel.org/lkml/20230310032342.17395-1-cai.huoqing@linux.dev/

 drivers/dma/dw-edma/Makefile                 |   8 +-
 drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
 drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c        |  91 ++++--
 drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 277 +++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 176 ++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 130 +++++++++
 drivers/pci/controller/dwc/pcie-designware.c |   2 +-
 include/linux/dma/edma.h                     |   7 +-
 13 files changed, 785 insertions(+), 107 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h

-- 
2.34.1

