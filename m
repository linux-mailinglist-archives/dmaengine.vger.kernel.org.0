Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713615BF6A3
	for <lists+dmaengine@lfdr.de>; Wed, 21 Sep 2022 08:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiIUGtk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Sep 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiIUGtX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Sep 2022 02:49:23 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569780F6A;
        Tue, 20 Sep 2022 23:49:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663742959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEJmLrPoMgX0Ufwum40DKuD+1qe+vQ7nWlr03KXuIqE=;
        b=lA99QoahA8cMq0GbqXG9SQwR3gKOeCQo6roHOKkyj1ULlHIagwO8HHMNHDvBfT3sukinei
        ruX/tXVvFj5xr5m9P/m80pS6ZwtBEtG9TXO85P++qk2mM3nrqxjXVMWvKfkBfobH9ekix/
        14kcyTDs7P8M/Ae9UQ7ULx2CooBA0yo=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com
Cc:     caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: dw-edma: Rename dw_edma_core_ops structure to dw_edma_plat_ops
Date:   Wed, 21 Sep 2022 14:48:50 +0800
Message-Id: <20220921064859.10328-2-cai.huoqing@linux.dev>
In-Reply-To: <20220921064859.10328-1-cai.huoqing@linux.dev>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: caihuoqing <caihuoqing@baidu.com>

Rename dw_edma_core_ops structure to dw_edma_plat_ops,
because the 'ops' is related to platform device

Signed-off-by: caihuoqing <caihuoqing@baidu.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
 include/linux/dma/edma.h           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3f9dadc73854..5604f3771866 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 	return region.start;
 }
 
-static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
+static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.irq_vector = dw_edma_pcie_irq_vector,
 	.pci_address = dw_edma_pcie_address,
 };
@@ -225,7 +225,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	chip->mf = vsec_data.mf;
 	chip->nr_irqs = nr_irqs;
-	chip->ops = &dw_edma_pcie_core_ops;
+	chip->ops = &dw_edma_pcie_plat_ops;
 
 	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 9d44da4aa59d..642dd325259b 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -37,7 +37,7 @@ struct dw_edma_region {
  *			iATU windows. That will be done by the controller
  *			automatically.
  */
-struct dw_edma_core_ops {
+struct dw_edma_plat_ops {
 	int (*irq_vector)(struct device *dev, unsigned int nr);
 	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
 };
@@ -77,7 +77,7 @@ enum dw_edma_chip_flags {
 struct dw_edma_chip {
 	struct device		*dev;
 	int			nr_irqs;
-	const struct dw_edma_core_ops   *ops;
+	const struct dw_edma_plat_ops   *ops;
 	u32			flags;
 
 	void __iomem		*reg_base;
-- 
2.25.1

