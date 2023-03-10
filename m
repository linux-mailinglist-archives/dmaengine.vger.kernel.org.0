Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFD56B34BB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Mar 2023 04:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCJDXy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Mar 2023 22:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCJDXy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Mar 2023 22:23:54 -0500
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [IPv6:2001:41d0:203:375::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10352591E7
        for <dmaengine@vger.kernel.org>; Thu,  9 Mar 2023 19:23:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678418630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/jzu8+pSkAradaQDPCXdijqxCtBj4zASOgRk5utxWrw=;
        b=RS4b3cBQknsRe1MIFarSG4NHVQkEQSZctgbU9a6tWUJ8peK7aYXBvyxG8aVCCEh43i3Y0Q
        ZTfvFJle1VIMMzEi7f/wvch9k3nMBWT+yRcDOMrPOjV7etNoB33N4sgHpMOfRbRuRJiaI9
        0/IHjH/fN/fWXm4nzFayTGTZpPy+HKw=
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
Subject: [PATCH v6 0/5] dmaengine: dw-edma: Add support for native HDMA
Date:   Fri, 10 Mar 2023 11:23:33 +0800
Message-Id: <20230310032342.17395-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

v5->v6:
  [1/5]
  1.Change the commit log to explain dw_edma_core_ops structure.
  2.Revert the instance dw_edma_pcie_plat_ops.
  [2/5]
  3.include "linux/irqreturn.h" to the head of the file.
  4.Add irq state 'ret' to indicate whether the IRQ was actually handled.
  5.Using edma_done_interrupt/_abort_interrupt() callback instead of global fucntion.
  [3/5]
  6.Remove some unnecessary wrapper function.
  7.Using one loop instead two in dw_hdma_v0_core_handle_int.
  8.Fix the method to returning the actual IRQ-handling status.
  [4/5]
  9.Fix 'reg' pointing error in dw_hdma_debugfs_u32_get.
  10.Add padding_1/_2 reserve to fix wrong reg offset.
  [5/5]
  11.Remove some unnecessary wrapper function.

v5 link:
  https://lore.kernel.org/lkml/20230303124642.5519-1-cai.huoqing@linux.dev/

 drivers/dma/dw-edma/Makefile                 |   8 +-
 drivers/dma/dw-edma/dw-edma-core.c           |  84 +++---
 drivers/dma/dw-edma/dw-edma-core.h           |  55 ++++
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
 13 files changed, 784 insertions(+), 103 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h

-- 
2.34.1

