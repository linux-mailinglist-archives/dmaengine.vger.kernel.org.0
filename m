Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1595BF6A2
	for <lists+dmaengine@lfdr.de>; Wed, 21 Sep 2022 08:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIUGtU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Sep 2022 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIUGtR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Sep 2022 02:49:17 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C9C80F7E;
        Tue, 20 Sep 2022 23:49:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663742950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W1RFpst4VQOTLpVGnlysDlt9TL1azrIROKSRIvQcbkY=;
        b=kJyl8jiP5pCaeGDe3exP3MRVWRc7uuhKh9BtrFe+4swwagCERUTaP0JH0OP6XFsQdSC9Gm
        QbCrc4IpqI1qRenK2fP53KKq6FYFQLA6kB9C2uti9Y+lSaYX3lczEcrTPHw2BfakrqyER0
        FAve+P9y18RTk8xKGedDmPaRmO+f7Z4=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com
Cc:     caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH 0/3] dmaengine: dw-edma: Add support for native HDMA
Date:   Wed, 21 Sep 2022 14:48:49 +0800
Message-Id: <20220921064859.10328-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: caihuoqing <caihuoqing@baidu.com>

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
the next read channel to be serviced.
The same applies when you have multiple write channels.

The native HDMA driver also supports a maximum of 16 independent
channels (8 write + 8 read), which can run simultaneously.
Both SAR (Source Address Register) and DAR (Destination Address Register)
are alignmented to byte.dmaengine: dw-edma: Add support for native HDMA

These series based on the series
https://lore.kernel.org/dmaengine/20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru/

Cai Huoqing (3):
  dmaengine: dw-edma: Rename dw_edma_core_ops structure to
    dw_edma_plat_ops
  dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
    abstract controller operation
  dmaengine: dw-edma: Add support for native HDMA

 drivers/dma/dw-edma/Makefile             |   6 +-
 drivers/dma/dw-edma/dw-edma-core.c       |  65 ++---
 drivers/dma/dw-edma/dw-edma-core.h       |  19 ++
 drivers/dma/dw-edma/dw-edma-pcie.c       |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c    |  90 ++++++-
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  14 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c    | 304 +++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.h    |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 150 +++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 ++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h    |  98 ++++++++
 include/linux/dma/edma.h                 |   7 +-
 12 files changed, 725 insertions(+), 71 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h

-- 
2.25.1

