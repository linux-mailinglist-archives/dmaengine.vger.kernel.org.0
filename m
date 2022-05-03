Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1435951920F
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiECXFA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbiECXEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:11 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A873312773
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:36 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 94932C02;
        Wed,  4 May 2022 01:52:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 94932C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618320;
        bh=coZ4Tk8Je9NrW0abYtYTSxv57iRG+Q7tf8o0Dvrehag=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=B9/WD50rUO7iWvdrZ8MoL2V49cDmILYLZbXRXfUPNeZet2VmFzXsxjjjcnI2lDnLz
         TIaXeqEtcyK7O6xhUpSUym9zZNQDJ7wnvaSBU7zCQnGlec1j4exodkFi4zXsLUUZco
         V3VFisTquc7kUljUHSZZ5UVxF5QQbS0xfDSOZ+hk=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:26 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/26] dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
Date:   Wed, 4 May 2022 01:50:52 +0300
Message-ID: <20220503225104.12108-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
2.35.1

