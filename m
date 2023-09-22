Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072227AAEC8
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 11:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjIVJug (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 05:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjIVJud (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 05:50:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D5A19E;
        Fri, 22 Sep 2023 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695376224; x=1726912224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ZtGZQCOpOvo7LrB2f95E58MjLGOFkMkoha+wYJN62g=;
  b=c6S0Om6Bh84yrVq2MNZhrAO9q6H7IF+b+PxctmoBa16uTCLyapifNXHM
   nu+XMQ7hc+eQVStUu5hw49cYyFZBcTfRMFGw0EPc9qtePPEmTn/FaXM4v
   lBJRs+xnpvW3l/6ey4jtwtvD2sTw1N/wfghFMbmbjklBwFZc+tUNlApWq
   2t6k80UCigl2PuLOjX3aRT76t4c2twWCcL6CD/xPN6k8RxipRM+RpQuHo
   nDMkR3RRoYeE+DI78bl3J0mT65jUfCTyNPEW/qV1+4aC50pozBuZA9BuN
   B8rpnHwZN/N1VR77ueS75bSsD8IIg5NgPhqK8KEuDX2mb0/e3ZQVfE+yT
   g==;
X-CSE-ConnectionGUID: Z5JENQJSR8GFy34Gp7khAQ==
X-CSE-MsgGUID: 4dAFJKL4T/Ka0GLHtmRe7g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="236602712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2023 02:50:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 22 Sep 2023 02:50:20 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 22 Sep 2023 02:50:15 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>,
        <palmer@sifive.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1 3/3] dmaengine: sf-pdma: add mpfs-pdma compatible name
Date:   Fri, 22 Sep 2023 15:20:39 +0530
Message-ID: <20230922095039.74878-4-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922095039.74878-1-shravan.chippa@microchip.com>
References: <20230922095039.74878-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Sifive platform dma does not allow out-of-order transfers,
buf out-of-order dma has a significant performance advantage.
Add a PolarFire SoC specific compatible and code to support
for out-of-order dma transfers

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 27 ++++++++++++++++++++++++---
 drivers/dma/sf-pdma/sf-pdma.h |  6 ++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index c7558c9f9ac3..992a804166d5 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 
 #include "sf-pdma.h"
@@ -66,7 +67,7 @@ static struct sf_pdma_desc *sf_pdma_alloc_desc(struct sf_pdma_chan *chan)
 static void sf_pdma_fill_desc(struct sf_pdma_desc *desc,
 			      u64 dst, u64 src, u64 size)
 {
-	desc->xfer_type = PDMA_FULL_SPEED;
+	desc->xfer_type =  desc->chan->pdma->transfer_type;
 	desc->xfer_size = size;
 	desc->dst_addr = dst;
 	desc->src_addr = src;
@@ -520,6 +521,7 @@ static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
 
 static int sf_pdma_probe(struct platform_device *pdev)
 {
+	const struct sf_pdma_driver_platdata *ddata;
 	struct sf_pdma *pdma;
 	int ret, n_chans;
 	const enum dma_slave_buswidth widths =
@@ -545,6 +547,14 @@ static int sf_pdma_probe(struct platform_device *pdev)
 
 	pdma->n_chans = n_chans;
 
+	pdma->transfer_type = PDMA_FULL_SPEED;
+
+	ddata  = of_device_get_match_data(&pdev->dev);
+	if (ddata) {
+		if (ddata->quirks & NO_STRICT_ORDERING)
+			pdma->transfer_type &= ~(NO_STRICT_ORDERING);
+	}
+
 	pdma->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdma->membase))
 		return PTR_ERR(pdma->membase);
@@ -629,11 +639,22 @@ static int sf_pdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sf_pdma_driver_platdata mpfs_pdma = {
+	.quirks = NO_STRICT_ORDERING,
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
+
 MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
 
 static struct platform_driver sf_pdma_driver = {
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 5c398a83b491..3b16db4daa0b 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -49,6 +49,7 @@
 
 /* Transfer Type */
 #define PDMA_FULL_SPEED					0xFF000008
+#define NO_STRICT_ORDERING				BIT(3)
 
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

