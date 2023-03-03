Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74876A9773
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCCMqz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 07:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCCMqz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 07:46:55 -0500
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [IPv6:2001:41d0:203:375::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D4199EF
        for <dmaengine@vger.kernel.org>; Fri,  3 Mar 2023 04:46:54 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677847610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M6pZyT/67NWijZcPpIJ5sKmOZPf0rH1QPbb9QcorFOc=;
        b=aPwRRuPxNWGO4HrjpTemwHdCqLgl5zvBqeXarmoMg9ldY+VKCM7cFGugnAkPlUpefqj/2R
        sXWWPqiSAbZBee3Zi6AS/+A7qcKEkX71oahK8A1ZBe4oB3D0//wB1V0f8/dU1LgROp0Odx
        Somi49PJ1rgoHIVt21Ymi03ruD+FMhw=
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
Subject: [PATCH v5 0/4] dmaengine: dw-edma: Add support for native HDMA
Date:   Fri,  3 Mar 2023 20:46:30 +0800
Message-Id: <20230303124642.5519-1-cai.huoqing@linux.dev>
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

  v4->v5:
    [1/4]
    1.Revert the instance dw_edma_pcie_core_ops
    2.Move the change EDMA_MF_HDMA_NATIVE to patch[3/4] 
    [2/4]
    3.Refactor add return irqreturn_t to dw_edma_core_handle_int
    4.Define dw_edma_core_handle_int as inline fuction and move to
      dw-edma-core.h.
    [3/4]
    5.Add missing the function call -dw_hdma_v0_core_register.
    [4/4]
    6.Remove the check of *regs_dent *ch_dent.

  v4 link:
  https://lore.kernel.org/lkml/Y%2F62%2FXUiHz363qmD@chq-MS-7D45/

 drivers/dma/dw-edma/Makefile                 |   8 +-
 drivers/dma/dw-edma/dw-edma-core.c           |  87 ++----
 drivers/dma/dw-edma/dw-edma-core.h           |  64 ++++
 drivers/dma/dw-edma/dw-edma-pcie.c           |   2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c        |  75 ++++-
 drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 304 +++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 175 +++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
 drivers/pci/controller/dwc/pcie-designware.c |   2 +-
 include/linux/dma/edma.h                     |   7 +-
 13 files changed, 815 insertions(+), 91 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h

-- 
2.34.1

