Return-Path: <dmaengine+bounces-413-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA55480A142
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1C8B20B32
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0613C2B;
	Fri,  8 Dec 2023 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XjMLrnR1"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BD1BE3;
	Fri,  8 Dec 2023 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702031921; x=1733567921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2EQm1WbcHBB0qSzV6W9atlXp3QWQx/LQ8hNLQCOVPww=;
  b=XjMLrnR1BYOfqjIMufW5l5GNysiZ/p3l3qfCBzhheGmQQDKaZTid1kdl
   vQGPLV92AvzViZSt53UnpcaSkybXLtT08jsr0lcTZhs6G6B16i7wXPf+0
   f9cviRjtNL1XyiJRUD248lHfCC3Ed3FzbVRyZ3pMZYdmryhL22EGszAL9
   +AvbrT+Pakq+pjArkK4+Un3bJ8X2VWI7SHd+F1Nr2+5qAsvirrEVY3LQP
   bwDyO6FMH+I8iHC3BkPuTvSTvnWqcTgoMVUn2nJh4SBc3piSqoJN9A8MV
   64SoeYeSXJKIYsqJ5gg0rjrFO99xx6/i77zJM7Ghq66pBh8QlbxEGE5+2
   Q==;
X-CSE-ConnectionGUID: Cvz3gSbpStiroKFn2Lwqew==
X-CSE-MsgGUID: TlwQAlMGSYWg/x1j129+hg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="13864089"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2023 03:38:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 03:38:04 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 03:37:59 -0700
From: shravan chippa <shravan.chippa@microchip.com>
To: <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
	<shravan.chippa@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>
Subject: [PATCH v5 3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
Date: Fri, 8 Dec 2023 16:08:55 +0530
Message-ID: <20231208103856.3732998-4-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208103856.3732998-1-shravan.chippa@microchip.com>
References: <20231208103856.3732998-1-shravan.chippa@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Shravan Chippa <shravan.chippa@microchip.com>

Sifive platform dma (sf-pdma) has both in-order and out-of-order
configurations but sf-pdam driver configured to do in-order DMA
transfers, with out-of-order configuration got better throughput
in the PolarFire SoC platform.

Add a PolarFire SoC specific compatible and code to support
for out-of-order dma transfers

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
 drivers/dma/sf-pdma/sf-pdma.h |  8 +++++++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6109e1c5a09e..428473611115 100644
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
@@ -493,6 +495,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 
 static int sf_pdma_probe(struct platform_device *pdev)
 {
+	const struct sf_pdma_driver_platdata *ddata;
 	struct sf_pdma *pdma;
 	int ret, n_chans;
 	const enum dma_slave_buswidth widths =
@@ -518,6 +521,14 @@ static int sf_pdma_probe(struct platform_device *pdev)
 
 	pdma->n_chans = n_chans;
 
+	pdma->transfer_type = PDMA_FULL_SPEED | PDMA_STRICT_ORDERING;
+
+	ddata  = device_get_match_data(&pdev->dev);
+	if (ddata) {
+		if (ddata->quirks & PDMA_QUIRK_NO_STRICT_ORDERING)
+			pdma->transfer_type &= ~PDMA_STRICT_ORDERING;
+	}
+
 	pdma->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdma->membase))
 		return PTR_ERR(pdma->membase);
@@ -603,9 +614,19 @@ static void sf_pdma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&pdma->dma_dev);
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
index d05772b5d8d3..215e07183d7e 100644
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
 	struct sf_pdma_chan	chans[] __counted_by(n_chans);
 };
 
+struct sf_pdma_driver_platdata {
+	u32 quirks;
+};
+
 #endif /* _SF_PDMA_H */
-- 
2.34.1


