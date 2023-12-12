Return-Path: <dmaengine+bounces-482-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1D80E9EF
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 12:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7651F2135D
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484D5DF0B;
	Tue, 12 Dec 2023 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RsFiL61F"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2DB26BA;
	Tue, 12 Dec 2023 03:10:41 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAMko052438;
	Tue, 12 Dec 2023 05:10:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702379422;
	bh=7+jdojrvI/WT4WBoua2xkCIhykh2otOmQh/gKolYxxQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RsFiL61FcvnYtZw0dLfiJfPHyvJd0iaK1ZxaGaXcwR3B0PBBPx1cWBjC3FCvYdH/b
	 +Qr/8KljboBpOhT5jZtnsM9MW3J17NL4kGkkK8OqtVYru96tCRkuE295s5z0gxLbDb
	 TSvcNkjc3NCEj0iuDCG2H5wyqWvw9ssAIzJoFRjc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCBAM6P014659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Dec 2023 05:10:22 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 05:10:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 05:10:22 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBABA0088764;
	Tue, 12 Dec 2023 05:10:19 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 3/4] dmaengine: ti: k3-udma-glue: Add function to request TX channel by ID
Date: Tue, 12 Dec 2023 16:40:10 +0530
Message-ID: <20231212111011.1401641-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212111011.1401641-1-s-vadapalli@ti.com>
References: <20231212111011.1401641-1-s-vadapalli@ti.com>
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
the form of a new function k3_udma_glue_request_tx_chn_by_id() and export
it for use by drivers which are probed by alternate methods (non
device-tree) but still wish to make use of the existing DMA APIs. Such
drivers could be informed about the TX channel to use by RPMsg for example.

Since the implementation of k3_udma_glue_request_tx_chn_by_id() reuses
most of the code in k3_udma_glue_request_tx_chn(), create a new function
for the common code named as k3_udma_glue_request_tx_chn_common().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes since v1:
- Updated commit message indicating the use-case for which the patch is
  being added.

 drivers/dma/ti/k3-udma-glue.c    | 101 +++++++++++++++++++++++--------
 include/linux/dma/k3-udma-glue.h |   4 ++
 2 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index eff1ae3d3efe..ea5119a5e8eb 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -274,29 +274,13 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
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
@@ -312,7 +296,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	if (IS_ERR(tx_chn->udma_tchanx)) {
 		ret = PTR_ERR(tx_chn->udma_tchanx);
 		dev_err(dev, "UDMAX tchanx get err %d\n", ret);
-		goto err;
+		return ret;
 	}
 	tx_chn->udma_tchan_id = xudma_tchan_get_id(tx_chn->udma_tchanx);
 
@@ -325,7 +309,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
 		put_device(&tx_chn->common.chan_dev);
 		tx_chn->common.chan_dev.parent = NULL;
-		goto err;
+		return ret;
 	}
 
 	if (xudma_is_pktdma(tx_chn->common.udmax)) {
@@ -349,7 +333,7 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 					     &tx_chn->ringtxcq);
 	if (ret) {
 		dev_err(dev, "Failed to get TX/TXCQ rings %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	/* Set the dma_dev for the rings to be configured */
@@ -365,13 +349,13 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
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
@@ -382,11 +366,42 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
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
@@ -395,6 +410,40 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
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


