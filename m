Return-Path: <dmaengine+bounces-78-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F25C7E8AD8
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 13:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCEC1C208EC
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774B1427A;
	Sat, 11 Nov 2023 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KtyKfLIV"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B01426E
	for <dmaengine@vger.kernel.org>; Sat, 11 Nov 2023 12:16:17 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B493C05;
	Sat, 11 Nov 2023 04:16:15 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCG473085225;
	Sat, 11 Nov 2023 06:16:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699704964;
	bh=ty0k+nUDroDXWh953h5rmRqpmQr5kzDJwr8S4izFvZo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KtyKfLIVWHhbSeaSe4WBfkAlyVfDNotuBEBuUSuQbN5+XciFPj5t5+R4HyxhsM0YC
	 r1bGbRXzqOb7T6IX9UtdBZ8Dh9r0VSivQf+OgdsGAf4nQycZNDXZK7qITaEhgtPlSZ
	 IjxjaNTqQhKLILlYfQo7Yo7OJ9thkgTph3YDOL7Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ABCG336081736
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 11 Nov 2023 06:16:04 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 Nov 2023 06:16:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 Nov 2023 06:16:03 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCFtVX100939;
	Sat, 11 Nov 2023 06:16:01 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 2/3] dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
Date: Sat, 11 Nov 2023 17:45:54 +0530
Message-ID: <20231111121555.2656760-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111121555.2656760-1-s-vadapalli@ti.com>
References: <20231111121555.2656760-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The existing function k3_udma_glue_request_tx_chn() supports requesting
a TX DMA channel by its name. Add support to request TX channel by ID in
the form of a new function k3_udma_glue_request_tx_chn_by_id() and
export it.

Since the implementation of k3_udma_glue_request_tx_chn_by_id() reuses
most of the code in k3_udma_glue_request_tx_chn(), create a new function
for the common code named as k3_udma_glue_request_tx_chn_common().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 101 +++++++++++++++++++++++--------
 include/linux/dma/k3-udma-glue.h |   4 ++
 2 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 9979785d30aa..d3f04d446c4e 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -278,29 +278,13 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 	return tisci_rm->tisci_udmap_ops->tx_ch_cfg(tisci_rm->tisci, &req);
 }
 
-struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
-		const char *name, struct k3_udma_glue_tx_channel_cfg *cfg)
+static int
+k3_udma_glue_request_tx_chn_common(struct device *dev,
+				   struct k3_udma_glue_tx_channel *tx_chn,
+				   struct k3_udma_glue_tx_channel_cfg *cfg)
 {
-	struct k3_udma_glue_tx_channel *tx_chn;
 	int ret;
 
-	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
-	if (!tx_chn)
-		return ERR_PTR(-ENOMEM);
-
-	tx_chn->common.dev = dev;
-	tx_chn->common.swdata_size = cfg->swdata_size;
-	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
-	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
-	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
-	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
-
-	/* parse of udmap channel */
-	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
-					&tx_chn->common, true);
-	if (ret)
-		goto err;
-
 	tx_chn->common.hdesc_size = cppi5_hdesc_calc_size(tx_chn->common.epib,
 						tx_chn->common.psdata_size,
 						tx_chn->common.swdata_size);
@@ -316,7 +300,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	if (IS_ERR(tx_chn->udma_tchanx)) {
 		ret = PTR_ERR(tx_chn->udma_tchanx);
 		dev_err(dev, "UDMAX tchanx get err %d\n", ret);
-		goto err;
+		return ret;
 	}
 	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
 
@@ -329,7 +313,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
 		put_device(&tx_chn->common.chan_dev);
 		tx_chn->common.chan_dev.parent = NULL;
-		goto err;
+		return ret;
 	}
 
 	if (xudma_is_pktdma(tx_chn->common.udmax)) {
@@ -353,7 +337,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 					     &tx_chn->ringtxcq);
 	if (ret) {
 		dev_err(dev, "Failed to get TX/TXCQ rings %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	/* Set the dma_dev for the rings to be configured */
@@ -369,13 +353,13 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	ret = k3_ringacc_ring_cfg(tx_chn->ringtx, &cfg->tx_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = k3_ringacc_ring_cfg(tx_chn->ringtxcq, &cfg->txcq_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	/* request and cfg psi-l */
@@ -386,11 +370,42 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	ret = k3_udma_glue_cfg_tx_chn(tx_chn);
 	if (ret) {
 		dev_err(dev, "Failed to cfg tchan %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	k3_udma_glue_dump_tx_chn(tx_chn);
 
+	return 0;
+}
+
+struct k3_udma_glue_tx_channel *
+k3_udma_glue_request_tx_chn(struct device *dev, const char *name,
+			    struct k3_udma_glue_tx_channel_cfg *cfg)
+{
+	struct k3_udma_glue_tx_channel *tx_chn;
+	int ret;
+
+	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
+	if (!tx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	tx_chn->common.dev = dev;
+	tx_chn->common.swdata_size = cfg->swdata_size;
+	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
+	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
+	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
+	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
+
+	/* parse of udmap channel */
+	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
+					&tx_chn->common, true);
+	if (ret)
+		goto err;
+
+	ret = k3_udma_glue_request_tx_chn_common(dev, tx_chn, cfg);
+	if (ret)
+		goto err;
+
 	return tx_chn;
 
 err:
@@ -399,6 +414,40 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn);
 
+struct k3_udma_glue_tx_channel *
+k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,
+				  struct device_node *udmax_np, u32 thread_id)
+{
+	struct k3_udma_glue_tx_channel *tx_chn;
+	int ret;
+
+	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
+	if (!tx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	tx_chn->common.dev = dev;
+	tx_chn->common.swdata_size = cfg->swdata_size;
+	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
+	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
+	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
+	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
+
+	ret = of_k3_udma_glue_parse_chn_by_id(udmax_np, &tx_chn->common, true, thread_id);
+	if (ret)
+		goto err;
+
+	ret = k3_udma_glue_request_tx_chn_common(dev, tx_chn, cfg);
+	if (ret)
+		goto err;
+
+	return tx_chn;
+
+err:
+	k3_udma_glue_release_tx_chn(tx_chn);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn_by_id);
+
 void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
 	if (tx_chn->psil_paired) {
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index e443be4d3b4b..6205d84430ca 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -26,6 +26,10 @@ struct k3_udma_glue_tx_channel;
 struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 		const char *name, struct k3_udma_glue_tx_channel_cfg *cfg);
 
+struct k3_udma_glue_tx_channel *
+k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,
+				  struct device_node *udmax_np, u32 thread_id);
+
 void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn);
 int k3_udma_glue_push_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 			     struct cppi5_host_desc_t *desc_tx,
-- 
2.34.1


