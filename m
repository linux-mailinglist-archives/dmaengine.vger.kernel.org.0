Return-Path: <dmaengine+bounces-99-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF47EABBC
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 09:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B7B20B4F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBD15491;
	Tue, 14 Nov 2023 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xIW2j0q4"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5575154AC
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 08:39:26 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3DA4;
	Tue, 14 Nov 2023 00:39:24 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8dH3f020383;
	Tue, 14 Nov 2023 02:39:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699951157;
	bh=VPVOyYGUIuFjbpFVz4WDtMguuciLFwkUVgaypjccsg0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xIW2j0q4Euj9+lGrWySdNdlBwkv+ueoWif38je4lPRkBegALlh+CS6tF02AQP6eD2
	 OiZu4sTxKrXFfRamGYZdkZJGrdDZ4T4n8dnlH7k57qp2Ip/XjCf6R81DRq4Lir+0Y6
	 4ZH3flS01hTxx/2EHpe+TKlauHl/wX7zP7158jIQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AE8dHHm019436
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Nov 2023 02:39:17 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 02:39:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 02:39:17 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8d6OG128120;
	Tue, 14 Nov 2023 02:39:15 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 3/4] dmaengine: ti: k3-udma-glue: Add function to request RX channel by ID
Date: Tue, 14 Nov 2023 14:09:05 +0530
Message-ID: <20231114083906.3143548-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114083906.3143548-1-s-vadapalli@ti.com>
References: <20231114083906.3143548-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The existing function k3_udma_glue_request_remote_rx_chn() supports
requesting an RX DMA channel and flow by the name of the RX DMA channel.
Add support to request RX channel by ID in the form of a new function
k3_udma_glue_request_remote_rx_chn_by_id() and export it.

Since the implementation of k3_udma_glue_request_remote_rx_chn_by_id()
reuses most of the code in k3_udma_glue_request_remote_rx_chn(), create
a new function k3_udma_glue_request_remote_rx_chn_common() for the
common code.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 140 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   4 +
 2 files changed, 103 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index d3f04d446c4e..167fe77de71e 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1076,52 +1076,21 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 	return ERR_PTR(ret);
 }
 
-static struct k3_udma_glue_rx_channel *
-k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
-				   struct k3_udma_glue_rx_channel_cfg *cfg)
+static int
+k3_udma_glue_request_remote_rx_chn_common(struct k3_udma_glue_rx_channel *rx_chn,
+					  struct k3_udma_glue_rx_channel_cfg *cfg,
+					  struct device *dev)
 {
-	struct k3_udma_glue_rx_channel *rx_chn;
 	int ret, i;
 
-	if (cfg->flow_id_num <= 0 ||
-	    cfg->flow_id_use_rxchan_id ||
-	    cfg->def_flow_cfg ||
-	    cfg->flow_id_base < 0)
-		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Remote RX channel is under control of Remote CPU core, so
-	 * Linux can only request and manipulate by dedicated RX flows
-	 */
-
-	rx_chn = devm_kzalloc(dev, sizeof(*rx_chn), GFP_KERNEL);
-	if (!rx_chn)
-		return ERR_PTR(-ENOMEM);
-
-	rx_chn->common.dev = dev;
-	rx_chn->common.swdata_size = cfg->swdata_size;
-	rx_chn->remote = true;
-	rx_chn->udma_rchan_id = -1;
-	rx_chn->flow_num = cfg->flow_id_num;
-	rx_chn->flow_id_base = cfg->flow_id_base;
-	rx_chn->psil_paired = false;
-
-	/* parse of udmap channel */
-	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
-					&rx_chn->common, false);
-	if (ret)
-		goto err;
-
 	rx_chn->common.hdesc_size = cppi5_hdesc_calc_size(rx_chn->common.epib,
-						rx_chn->common.psdata_size,
-						rx_chn->common.swdata_size);
+							  rx_chn->common.psdata_size,
+							  rx_chn->common.swdata_size);
 
 	rx_chn->flows = devm_kcalloc(dev, rx_chn->flow_num,
 				     sizeof(*rx_chn->flows), GFP_KERNEL);
-	if (!rx_chn->flows) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!rx_chn->flows)
+		return -ENOMEM;
 
 	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
 	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
@@ -1132,7 +1101,7 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
 		put_device(&rx_chn->common.chan_dev);
 		rx_chn->common.chan_dev.parent = NULL;
-		goto err;
+		return ret;
 	}
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
@@ -1144,19 +1113,108 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 
 	ret = k3_udma_glue_allocate_rx_flows(rx_chn, cfg);
 	if (ret)
-		goto err;
+		return ret;
 
 	for (i = 0; i < rx_chn->flow_num; i++)
 		rx_chn->flows[i].udma_rflow_id = rx_chn->flow_id_base + i;
 
 	k3_udma_glue_dump_rx_chn(rx_chn);
 
+	return 0;
+}
+
+static struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
+				   struct k3_udma_glue_rx_channel_cfg *cfg)
+{
+	struct k3_udma_glue_rx_channel *rx_chn;
+	int ret;
+
+	if (cfg->flow_id_num <= 0 ||
+	    cfg->flow_id_use_rxchan_id ||
+	    cfg->def_flow_cfg ||
+	    cfg->flow_id_base < 0)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Remote RX channel is under control of Remote CPU core, so
+	 * Linux can only request and manipulate by dedicated RX flows
+	 */
+
+	rx_chn = devm_kzalloc(dev, sizeof(*rx_chn), GFP_KERNEL);
+	if (!rx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	rx_chn->common.dev = dev;
+	rx_chn->common.swdata_size = cfg->swdata_size;
+	rx_chn->remote = true;
+	rx_chn->udma_rchan_id = -1;
+	rx_chn->flow_num = cfg->flow_id_num;
+	rx_chn->flow_id_base = cfg->flow_id_base;
+	rx_chn->psil_paired = false;
+
+	/* parse of udmap channel */
+	ret = of_k3_udma_glue_parse_chn(dev->of_node, name,
+					&rx_chn->common, false);
+	if (ret)
+		goto err;
+
+	ret = k3_udma_glue_request_remote_rx_chn_common(rx_chn, cfg, dev);
+	if (ret)
+		goto err;
+
+	return rx_chn;
+
+err:
+	k3_udma_glue_release_rx_chn(rx_chn);
+	return ERR_PTR(ret);
+}
+
+struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn_by_id(struct device *dev, struct device_node *udmax_np,
+					 struct k3_udma_glue_rx_channel_cfg *cfg, u32 thread_id)
+{
+	struct k3_udma_glue_rx_channel *rx_chn;
+	int ret;
+
+	if (cfg->flow_id_num <= 0 ||
+	    cfg->flow_id_use_rxchan_id ||
+	    cfg->def_flow_cfg ||
+	    cfg->flow_id_base < 0)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Remote RX channel is under control of Remote CPU core, so
+	 * Linux can only request and manipulate by dedicated RX flows
+	 */
+
+	rx_chn = devm_kzalloc(dev, sizeof(*rx_chn), GFP_KERNEL);
+	if (!rx_chn)
+		return ERR_PTR(-ENOMEM);
+
+	rx_chn->common.dev = dev;
+	rx_chn->common.swdata_size = cfg->swdata_size;
+	rx_chn->remote = true;
+	rx_chn->udma_rchan_id = -1;
+	rx_chn->flow_num = cfg->flow_id_num;
+	rx_chn->flow_id_base = cfg->flow_id_base;
+	rx_chn->psil_paired = false;
+
+	ret = of_k3_udma_glue_parse_chn_by_id(udmax_np, &rx_chn->common, false, thread_id);
+	if (ret)
+		goto err;
+
+	ret = k3_udma_glue_request_remote_rx_chn_common(rx_chn, cfg, dev);
+	if (ret)
+		goto err;
+
 	return rx_chn;
 
 err:
 	k3_udma_glue_release_rx_chn(rx_chn);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(k3_udma_glue_request_remote_rx_chn_by_id);
 
 struct k3_udma_glue_rx_channel *
 k3_udma_glue_request_rx_chn(struct device *dev, const char *name,
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index 6205d84430ca..a81d1b8f889c 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -108,6 +108,10 @@ struct k3_udma_glue_rx_channel_cfg {
 
 struct k3_udma_glue_rx_channel;
 
+struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn_by_id(struct device *dev, struct device_node *udmax_np,
+					 struct k3_udma_glue_rx_channel_cfg *cfg, u32 thread_id);
+
 struct k3_udma_glue_rx_channel *k3_udma_glue_request_rx_chn(
 		struct device *dev,
 		const char *name,
-- 
2.34.1


