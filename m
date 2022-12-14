Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61A64D3E1
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 00:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLNXxl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Dec 2022 18:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLNXxS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Dec 2022 18:53:18 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D28B4A07E;
        Wed, 14 Dec 2022 15:53:17 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 39213E0ED8;
        Thu, 15 Dec 2022 02:53:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=epmzGansytPxz5Hgaxj/E76J3uOG4CCTCqPVcuYibtE=; b=O8huWynoKiOo
        9nL3r0CAahyoRdLTQ3jSQUt5y4yFW0MguXzBw6G2P0or1hoQ0EK0qplMDDVRkTFV
        /zT81noRhQ9y+sZ3nmhQxCVloU+CHibRNRo6JO5C4OiEwOJQCm1+wMH9wK362IQH
        CKbfVufZZoLpA2TtG+jHmDwKcsi6QUo=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 2C922E0E6B;
        Thu, 15 Dec 2022 02:53:17 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 15 Dec 2022 02:53:16 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 13/25] dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
Date:   Thu, 15 Dec 2022 02:52:53 +0300
Message-ID: <20221214235305.31744-14-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently all the DW eDMA DebugFS nodes descriptors are allocated on
stack, while the DW eDMA driver private data and CSR limits are statically
preserved. Such design won't work for the multi-eDMA platforms. As a
preparation to adding the multi-eDMA system setups support we need to have
each DebugFS node separately allocated and described. Afterwards we'll put
an addition info there like Read/Write channel flag, channel ID, DW eDMA
private data reference.

Note this conversion is mainly required due to having the legacy DW eDMA
controllers with indirect Read/Write channels context CSRs access. If we
didn't need to have a synchronized access to these registers the DebugFS
code of the driver would have been much simpler.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>

---

Changelog v2:
- Drop __iomem qualifier from the struct dw_edma_debugfs_entry instance
  definition in the dw_edma_debugfs_u32_get() method. (@Manivannan)
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 2121ffc33cf3..78f15e4b07ac 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -53,7 +53,8 @@ struct dw_edma_debugfs_entry {
 
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
-	void __iomem *reg = data;
+	struct dw_edma_debugfs_entry *entry = data;
+	void __iomem *reg = entry->reg;
 
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
@@ -94,14 +95,22 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
 
-static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry entries[],
+static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
 				       int nr_entries, struct dentry *dir)
 {
+	struct dw_edma_debugfs_entry *entries;
 	int i;
 
+	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
+			       GFP_KERNEL);
+	if (!entries)
+		return;
+
 	for (i = 0; i < nr_entries; i++) {
+		entries[i] = ini[i];
+
 		debugfs_create_file_unsafe(entries[i].name, 0444, dir,
-					   entries[i].reg, &fops_x32);
+					   &entries[i], &fops_x32);
 	}
 }
 
-- 
2.38.1


