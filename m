Return-Path: <dmaengine+bounces-820-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02E83AA26
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jan 2024 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB04B2917F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jan 2024 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719477634;
	Wed, 24 Jan 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TY7p6pAt"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153C7762E;
	Wed, 24 Jan 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100233; cv=none; b=EcCokAbGsrw3BaAs2TXasV2Dosi5/VhScQXt4x6kp0hJt7nMH3wE0QNiQs7C2xdKa0sJ3xbfO6zQvr9pL0kDSn2PMHp8VuSd542HRA8wdDlaoBWHBmgacFaxrwRoqQV5nusM/ct678ksZ/zq5rjNU9z063ORBe8M4MDcdi02yug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100233; c=relaxed/simple;
	bh=853Da6S+w2tEe8aoGvtUhhxtRpry9eHaAWtaL49/QWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmhSQedgf6kPcK9ZOP5vOowswTL4URc/RTH/5xuyHYi19+Dom6Gzo+b6u/P17OhkYkJncmNYh/z2JqSXKhK3RUOjG+XXo+ZNJ0qI8iPI8Th6T2d7WrN5R+s7kbID8uj8WXO+w5iArtoREjFPjoaG0T5oL2bHldoF3j6x/8AbeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TY7p6pAt; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OChXbN122197;
	Wed, 24 Jan 2024 06:43:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706100213;
	bh=YZQ02OzklrmfVeZDB8bFvdGF+ukwLWncFXWyKW7PPnA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TY7p6pAtkTbcow/yJZ60iGxUVYmjuTI6e0hCyLPAKjINWfXdFBnKiIHYzn9Z7oaih
	 LO/SyYkTQY1BNB7Cnz0SBiSSFbV8JFD7j+g27GXxe+WJqLGUn1ZGsmeHBep4cce4Vi
	 pS4ojKL8Ztp1Qr0Obl130lWbh9fcTi+DpLriRhys=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OChXC8064480
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 06:43:33 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 06:43:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 06:43:32 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OChJPh014062;
	Wed, 24 Jan 2024 06:43:30 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 4/4] dmaengine: ti: k3-udma-glue: Add function to request RX chan for thread ID
Date: Wed, 24 Jan 2024 18:13:19 +0530
Message-ID: <20240124124319.820002-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124124319.820002-1-s-vadapalli@ti.com>
References: <20240124124319.820002-1-s-vadapalli@ti.com>
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
Add support to request RX DMA channel for a given thread ID in the form of
a new function named k3_udma_glue_request_remote_rx_chn_for_thread_id().
Also, export it for use by drivers which are probed by alternate methods
(non device-tree) but still wish to make use of the existing DMA APIs. Such
drivers could be informed about the thread ID corresponding to the RX DMA
channel by RPMsg for example.

Since the new function k3_udma_glue_request_remote_rx_chn_for_thread_id()
reuses most of the code in k3_udma_glue_request_remote_rx_chn(), create a
new function named k3_udma_glue_request_remote_rx_chn_common() for the
common code.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 137 ++++++++++++++++++++++---------
 include/linux/dma/k3-udma-glue.h |   5 ++
 2 files changed, 103 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index a475bbea35ee..c9b93055dc9d 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1073,52 +1073,21 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
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
 						rx_chn->common.psdata_size,
 						rx_chn->common.swdata_size);
 
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
@@ -1129,7 +1098,7 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
 		put_device(&rx_chn->common.chan_dev);
 		rx_chn->common.chan_dev.parent = NULL;
-		goto err;
+		return ret;
 	}
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
@@ -1141,19 +1110,109 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 
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
+k3_udma_glue_request_remote_rx_chn_for_thread_id(struct device *dev,
+						 struct k3_udma_glue_rx_channel_cfg *cfg,
+						 struct device_node *udmax_np, u32 thread_id)
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
+EXPORT_SYMBOL_GPL(k3_udma_glue_request_remote_rx_chn_for_thread_id);
 
 struct k3_udma_glue_rx_channel *
 k3_udma_glue_request_rx_chn(struct device *dev, const char *name,
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index c81386ceb1c1..1e491c5dcac2 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -114,6 +114,11 @@ struct k3_udma_glue_rx_channel *k3_udma_glue_request_rx_chn(
 		const char *name,
 		struct k3_udma_glue_rx_channel_cfg *cfg);
 
+struct k3_udma_glue_rx_channel *
+k3_udma_glue_request_remote_rx_chn_for_thread_id(struct device *dev,
+						 struct k3_udma_glue_rx_channel_cfg *cfg,
+						 struct device_node *udmax_np, u32 thread_id);
+
 void k3_udma_glue_release_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
 int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
 void k3_udma_glue_disable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn);
-- 
2.34.1


