Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E236C5D77
	for <lists+dmaengine@lfdr.de>; Thu, 23 Mar 2023 04:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCWDtz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 23:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCWDty (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 23:49:54 -0400
Received: from out-37.mta1.migadu.com (out-37.mta1.migadu.com [IPv6:2001:41d0:203:375::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CEF4683
        for <dmaengine@vger.kernel.org>; Wed, 22 Mar 2023 20:49:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679543390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7dsvccvkRHrBjwsXoKqpaTIV3NUG6wQWgO51YCAk8w0=;
        b=tNYtdks0+Ea1rAa1e9C2nj6lJNjdGxxnYV3PHpDQK4pnGSHrFH0EFrhL76RFm3+kyhauVu
        XgXgvEf6bGR1jhVs1mtPlxqQ2cW7w8YVw36PEbIhlBMS9xrdv5dnatohiCeoC2Q13GkeZD
        uVfr+mAt0chwSWsaY0q9PvMCyH9W7tI=
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
Subject: [PATCH v8 0/4] dmaengine: dw-edma: Add support for native HDMA
Date:   Thu, 23 Mar 2023 11:49:37 +0800
Message-Id: <20230323034944.78357-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Cai Huoqing (1):
  dmaengine: dw-edma: Add support for native HDMA

Cai huoqing (3):
  dmaengine: dw-edma: Rename dw_edma_core_ops structure to
    dw_edma_plat_ops
  dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
    abstract controller operation
  dmaengine: dw-edma: Add HDMA DebugFS support

v7->v8:
  1.Remove the [5/5] patch in v7.
  [3/4]
  2.Get back the static methods: dw_hdma_v0_core_clear_done_int(),
    dw_hdma_v0_core_clear_abort_int() and dw_hdma_v0_core_status_int().
  [4/4]
  3.Drop some unused field in dw_hdma_debugfs_entry.

v7 link:
  https://lore.kernel.org/lkml/20230315012840.6986-1-cai.huoqing@linux.dev/

 drivers/dma/dw-edma/Makefile                 |   8 +-
 drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
 drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c        |  85 +++++-
 drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 296 +++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 173 +++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 130 ++++++++
 drivers/pci/controller/dwc/pcie-designware.c |   2 +-
 include/linux/dma/edma.h                     |   7 +-
 13 files changed, 811 insertions(+), 91 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h

-- 
2.34.1

