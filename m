Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FA7D6844
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 12:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJYKWb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 06:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjJYKWb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 06:22:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A883123;
        Wed, 25 Oct 2023 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698229350; x=1729765350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYuw1o7okKebBJNCnZT/Iov2A07t5OeBvEwPkDvAo7w=;
  b=PbsgyYvsZLd2KKGsJP1mdf9lS6PaiXbIr2ozapeHrynWzVCzjQDs0Q4A
   GofTMkCTHA8gjDxUrs7mgnkdWS3Nbrz5Mk1eXoONliMXDzGZZfw2a2M3E
   wOj4ZIVFemlb5rLxAWyECQ8t412wyFHbWinQKnRSK0zteRRjgi5iCOXff
   LY+B5RMglTdeYLzTC5gqkinVuzJy71agk+EdDA51niJNBH9FqHDhVF5/h
   iAhMeLmDClMkXTdridSZ4GDSw9Wzysj6UYfHkOMcBNKB6UaispESQbTz6
   5Qt5szS8xMwViEraA/MJlS+A358FOjQOo8BMGHbBkxXt4iyt8bkSa9Uwd
   g==;
X-CSE-ConnectionGUID: hCRWSLnNROWYEPYDprosFg==
X-CSE-MsgGUID: FCcQ+OH0Sb2QnGb6dXeiJQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="10660976"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 03:22:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 03:22:06 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 03:22:01 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v3 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
Date:   Wed, 25 Oct 2023 15:52:50 +0530
Message-ID: <20231025102251.3369472-4-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025102251.3369472-1-shravan.chippa@microchip.com>
References: <20231025102251.3369472-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Sifive platform dma does not allow out-of-order transfers,
Add a PolarFire SoC specific compatible and code to support
for out-of-order dma transfers

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
 drivers/dma/sf-pdma/sf-pdma.h |  8 +++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 4c456bdef882..9cc4beec40f0 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -25,6 +25,8 @@
 
 #include "sf-pdma.h"
 
+#define PDMA_QUIRK_NO_STRICT_ORDERING   BIT(0)
+
 #ifndef readq
 static inline unsigned long long readq(void __iomem *addr)
 {
@@ -66,7 +68,7 @@ static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
 static void sf_pdma_fill_desc(struct sf_pdma_desc *desc,
 			      u64 dst, u64 src, u64 size)
 {
-	desc->xfer_type = PDMA_FULL_SPEED;
+	desc->xfer_type =  desc->chan->pdma->transfer_type;
 	desc->xfer_size = size;
 	desc->dst_addr = dst;
 	desc->src_addr = src;
@@ -520,6 +522,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
 
 static int sf_pdma_probe(struct platform_device *pdev)
 {
+	const struct sf_pdma_driver_platdata *ddata;
 	struct sf_pdma *pdma;
 	int ret, n_chans;
 	const enum dma_slave_buswidth widths =
@@ -545,6 +548,14 @@ static int sf_pdma_probe(struct platform_device *pdev)
 
 	pdma->n_chans = n_chans;
 
+	pdma->transfer_type = PDMA_FULL_SPEED | PDMA_STRICT_ORDERING;
+
+	ddata  = device_get_match_data(&pdev->dev);
+	if (ddata) {
+		if (ddata->quirks & PDMA_QUIRK_NO_STRICT_ORDERING)
+			pdma->transfer_type &= ~(PDMA_STRICT_ORDERING) ;
+	}
+
 	pdma->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdma->membase))
 		return PTR_ERR(pdma->membase);
@@ -632,9 +643,19 @@ static int sf_pdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sf_pdma_driver_platdata mpfs_pdma = {
+	.quirks = PDMA_QUIRK_NO_STRICT_ORDERING,
+};
+
 static const struct of_device_id sf_pdma_dt_ids[] = {
-	{ .compatible = "sifive,fu540-c000-pdma" },
-	{ .compatible = "sifive,pdma0" },
+	{
+		.compatible = "sifive,fu540-c000-pdma",
+	}, {
+		.compatible = "sifive,pdma0",
+	}, {
+		.compatible = "microchip,mpfs-pdma",
+		.data	    = &mpfs_pdma,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 5c398a83b491..267e79a5e0a5 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -48,7 +48,8 @@
 #define PDMA_ERR_STATUS_MASK				GENMASK(31, 31)
 
 /* Transfer Type */
-#define PDMA_FULL_SPEED					0xFF000008
+#define PDMA_FULL_SPEED					0xFF000000
+#define PDMA_STRICT_ORDERING				BIT(3)
 
 /* Error Recovery */
 #define MAX_RETRY					1
@@ -112,8 +113,13 @@ struct sf_pdma {
 	struct dma_device       dma_dev;
 	void __iomem            *membase;
 	void __iomem            *mappedbase;
+	u32			transfer_type;
 	u32			n_chans;
 	struct sf_pdma_chan	chans[];
 };
 
+struct sf_pdma_driver_platdata {
+	u32 quirks;
+};
+
 #endif /* _SF_PDMA_H */
-- 
2.34.1

