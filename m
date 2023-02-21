Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138B869D977
	for <lists+dmaengine@lfdr.de>; Tue, 21 Feb 2023 04:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjBUDrG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Feb 2023 22:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBUDrG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Feb 2023 22:47:06 -0500
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0088F233E2
        for <dmaengine@vger.kernel.org>; Mon, 20 Feb 2023 19:47:04 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676951222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=glhrY5x814R+m/N+0kgmuOwwASDPjGlBa+He80uRzD0=;
        b=Hlsl71ou3UkEfNUJwgG+LPhlN4BFIigHfrHpXC7jLWKaeBossmpaprs+4gk46kw+KjHPqU
        HAT3ujW7DRv5T4frcxJwx6DmMYJBDdIByQTyfYuRO5k9fwqykiEoj4t77vy6KqLXxvw+NA
        X9/rooCkg220pMEHM5SkquoiQWr/yu0=
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
Subject: [PATCH v4 0/4] dmaengine: dw-edma: Add support for native HDMA
Date:   Tue, 21 Feb 2023 11:46:51 +0800
Message-Id: <20230221034656.14476-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
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

Cai huoqing (4):
  dmaengine: dw-edma: Rename dw_edma_core_ops structure to
    dw_edma_plat_ops
  dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
    abstract controller operation
  dmaengine: dw-edma: Add support for native HDMA
  dmaengine: dw-edma: Add HDMA DebugFS support

  v3->v4:
    [1/4]
    1.Update the structure name dw_edma_plat_ops in commit log
    2.Fix code stytle.
    [2/4]
    3.Refactor dw_edma_interrupt() and related callbacks to
      make the code more readable, the calls hierarchy like this:

      irq: dw_edma_interrupt_{write,read}()
      +-> dw_edma_core_handle_int() (dw-edma-v0-core.c)
          +-> dw_edma_v0_core_status_done_int() (dw-edma-v0-core.c)
          +-> dw_edma_v0_core_clear_done_int() (dw-edma-v0-core.c)
          +-> dw_edma_done_interrupt() (dw-edma-core.c)
          +-> dw_edma_v0_core_status_abort_int() (dw-edma-v0-core.c)
          +-> dw_edma_v0_core_clear_abort_int() (dw-edma-v0-core.c)
          +-> dw_edma_abort_interrupt() (dw-edma-core.c)
    4.Use the dw_edma_v0_core name for the dw_edma_core_ops structure instance.
    [3/4]
    5.Fix weird indentation of control1, func_num, etc.
    6.Include 'linux/io-64-nonatomic-lo-hi.h' to fix warning.
    7.Refactor dw_edma_core_handle_int related callback in dw_hdma_v0_core ops.
    [4/4]
    8.Add field watermark_en, func_num, qos, msi_watermark,etc.
    9.Make variables reverse xmas tree order.
    10.Declare const for 'struct dw_hdma_debugfs_entry'

  v3 link:
  https://lore.kernel.org/lkml/20230213132411.65524-1-cai.huoqing@linux.dev/

 drivers/dma/dw-edma/Makefile                 |   8 +-
 drivers/dma/dw-edma/dw-edma-core.c           |  77 ++---
 drivers/dma/dw-edma/dw-edma-core.h           |  56 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c        |  73 ++++-
 drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 302 +++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 181 +++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
 drivers/pci/controller/dwc/pcie-designware.c |   2 +-
 include/linux/dma/edma.h                     |   7 +-
 13 files changed, 807 insertions(+), 85 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h

-- 
2.34.1

