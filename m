Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD769D97A
	for <lists+dmaengine@lfdr.de>; Tue, 21 Feb 2023 04:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjBUDrQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Feb 2023 22:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjBUDrO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Feb 2023 22:47:14 -0500
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [IPv6:2001:41d0:1004:224b::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A10F24C82
        for <dmaengine@vger.kernel.org>; Mon, 20 Feb 2023 19:47:12 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676951229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lZlpXM0RasbuEh/SFmeA+F3NrQEBaNxGxEjW9Wkpag=;
        b=tX5Ee3mim0FBMI5LSmnHghi9ctGugBrlweWfOV6eYDo4NTvWV6Ehd9T7obSuAAYq0EfY1E
        xbVO2YzW1y4d15Hw6sdoEPpLrDLEP8Ao0CPqzfYGBnD9eenG35CPS7rwUMSyGlmxzm9stt
        CeinTnLI8QBgJ40lizLXXu1n6/UCQFI=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com
Cc:     Cai huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 1/4] dmaengine: dw-edma: Rename dw_edma_core_ops structure to dw_edma_plat_ops
Date:   Tue, 21 Feb 2023 11:46:52 +0800
Message-Id: <20230221034656.14476-2-cai.huoqing@linux.dev>
In-Reply-To: <20230221034656.14476-1-cai.huoqing@linux.dev>
References: <20230221034656.14476-1-cai.huoqing@linux.dev>
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

From: Cai huoqing <cai.huoqing@linux.dev>

Rename dw_edma_core_ops structure to dw_edma_plat_ops, the ops is platform
specific operations: the DMA device environment configs like IRQs,
address translation, etc.

The dw_edma_plat_ops name was supposed to refer to the platform which
the DW eDMA engine is embedded to, like PCIe end-point (accessible via
the PCIe bus) or a PCIe root port (directly accessible by CPU).
Needless to say that for them the IRQ-vector and PCI-addresses are
differently determined. The suggested name has a connection with the
kernel platform device only as a private case of the eDMA/hDMA embedded
into the DW PCI Root ports, though basically it was supposed to refer to
any platform in which the DMA hardware lives.

Anyway the renaming was necessary to distinguish two types of
the implementation callbacks:
1. DW eDMA/hDMA IP-core specific operations: device-specific CSR
setups in one or another aspect of the DMA-engine initialization.
2. DW eDMA/hDMA platform specific operations: the DMA device
environment configs like IRQs, address translation, etc.

dw_edma_core_ops is supposed to be used for the case 1, and
dw_edma_plat_ops - for the case 2.

Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
---
  v3->v4:
    [1/4]
    1.Update the structure name dw_edma_plat_ops in commit log
    2.Fix code stytle.

  v3 link:
  https://lore.kernel.org/lkml/20230213132411.65524-2-cai.huoqing@linux.dev/

 drivers/dma/dw-edma/dw-edma-pcie.c           | 4 ++--
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 include/linux/dma/edma.h                     | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2b40f2b44f5e..798cb0662cef 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 	return region.start;
 }
 
-static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
+static const struct dw_edma_plat_ops dw_edma_plat_ops = {
 	.irq_vector = dw_edma_pcie_irq_vector,
 	.pci_address = dw_edma_pcie_address,
 };
@@ -225,7 +225,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	chip->mf = vsec_data.mf;
 	chip->nr_irqs = nr_irqs;
-	chip->ops = &dw_edma_pcie_core_ops;
+	chip->ops = &dw_edma_plat_ops;
 
 	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..44e90b71d429 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -828,7 +828,7 @@ static int dw_pcie_edma_irq_vector(struct device *dev, unsigned int nr)
 	return platform_get_irq_byname_optional(pdev, name);
 }
 
-static struct dw_edma_core_ops dw_pcie_edma_ops = {
+static struct dw_edma_plat_ops dw_pcie_edma_ops = {
 	.irq_vector = dw_pcie_edma_irq_vector,
 };
 
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index d2638d9259dc..3080747689f6 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -40,7 +40,7 @@ struct dw_edma_region {
  *			iATU windows. That will be done by the controller
  *			automatically.
  */
-struct dw_edma_core_ops {
+struct dw_edma_plat_ops {
 	int (*irq_vector)(struct device *dev, unsigned int nr);
 	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
 };
@@ -48,7 +48,8 @@ struct dw_edma_core_ops {
 enum dw_edma_map_format {
 	EDMA_MF_EDMA_LEGACY = 0x0,
 	EDMA_MF_EDMA_UNROLL = 0x1,
-	EDMA_MF_HDMA_COMPAT = 0x5
+	EDMA_MF_HDMA_COMPAT = 0x5,
+	EDMA_MF_HDMA_NATIVE = 0x7,
 };
 
 /**
@@ -80,7 +81,7 @@ enum dw_edma_chip_flags {
 struct dw_edma_chip {
 	struct device		*dev;
 	int			nr_irqs;
-	const struct dw_edma_core_ops   *ops;
+	const struct dw_edma_plat_ops	*ops;
 	u32			flags;
 
 	void __iomem		*reg_base;
-- 
2.34.1

