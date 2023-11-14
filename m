Return-Path: <dmaengine+bounces-96-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C17EABB9
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 09:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18067B20B07
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EFD15486;
	Tue, 14 Nov 2023 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iFW3YfWV"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971614F7B
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 08:39:21 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADEA4;
	Tue, 14 Nov 2023 00:39:19 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8dCG8057956;
	Tue, 14 Nov 2023 02:39:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699951152;
	bh=V4T4sch1tiJyW5MPqw/gLkRYEZf1vXcBY1djKhH51uw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iFW3YfWVXcgqieUhxHueCPSYl/pvidMSBpnCX50iM7DQOFjFNQmRAnXcVZXhABHS0
	 vPlHuDDbbTqJX5fS1gvfhH4FIokNGH0Bv2qLFjax6h1Bf6/u+zorATjsMb4iPrKIaB
	 NUvRE0W1GT4Xxw92VmwPjimixE5dEcmXBrsRCi4M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AE8dCSn003849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Nov 2023 02:39:12 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 02:39:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 02:39:12 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8d6OE128120;
	Tue, 14 Nov 2023 02:39:09 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/4] dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
Date: Tue, 14 Nov 2023 14:09:03 +0530
Message-ID: <20231114083906.3143548-2-s-vadapalli@ti.com>
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

The existing helper function of_k3_udma_glue_parse() fetches the DMA
Channel thread ID from the device-tree node. This makes it necessary to
have a device-tree node with the Channel thread IDs populated. However,
in the case where the thread ID is known by alternate methods (an
example being that of Firmware running on remote core sharing details of
the thread IDs), there is no equivalent function to implement the
functionality of the existing of_k3_udma_glue_parse() function.

Add the of_k3_udma_glue_parse_chn_by_id() helper function which accepts
the thread ID as an argument, thereby making it unnecessary to have a
device-tree node for obtaining the thread ID.

Since of_k3_udma_glue_parse() and of_k3_udma_glue_parse_chn_by_id()
share a lot of code in common, create a new function to handle the
common code which is named as of_k3_udma_glue_parse_chn_common().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c | 81 +++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index c278d5facf7d..9979785d30aa 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -111,6 +111,35 @@ static int of_k3_udma_glue_parse(struct device_node *udmax_np,
 	return 0;
 }
 
+static int of_k3_udma_glue_parse_chn_common(struct k3_udma_glue_common *common, u32 thread_id,
+					    bool tx_chn)
+{
+	if (tx_chn && !(thread_id & K3_PSIL_DST_THREAD_ID_OFFSET))
+		return -EINVAL;
+
+	if (!tx_chn && (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET))
+		return -EINVAL;
+
+	/* get psil endpoint config */
+	common->ep_config = psil_get_ep_config(thread_id);
+	if (IS_ERR(common->ep_config)) {
+		dev_err(common->dev,
+			"No configuration for psi-l thread 0x%04x\n",
+			thread_id);
+		return PTR_ERR(common->ep_config);
+	}
+
+	common->epib = common->ep_config->needs_epib;
+	common->psdata_size = common->ep_config->psd_size;
+
+	if (tx_chn)
+		common->dst_thread = thread_id;
+	else
+		common->src_thread = thread_id;
+
+	return 0;
+}
+
 static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
 		const char *name, struct k3_udma_glue_common *common,
 		bool tx_chn)
@@ -153,38 +182,36 @@ static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
 		common->atype_asel = dma_spec.args[1];
 	}
 
-	if (tx_chn && !(thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)) {
-		ret = -EINVAL;
+	ret = of_k3_udma_glue_parse_chn_common(common, thread_id, tx_chn);
+	if (ret)
 		goto out_put_spec;
-	}
-
-	if (!tx_chn && (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)) {
-		ret = -EINVAL;
-		goto out_put_spec;
-	}
-
-	/* get psil endpoint config */
-	common->ep_config = psil_get_ep_config(thread_id);
-	if (IS_ERR(common->ep_config)) {
-		dev_err(common->dev,
-			"No configuration for psi-l thread 0x%04x\n",
-			thread_id);
-		ret = PTR_ERR(common->ep_config);
-		goto out_put_spec;
-	}
-
-	common->epib = common->ep_config->needs_epib;
-	common->psdata_size = common->ep_config->psd_size;
-
-	if (tx_chn)
-		common->dst_thread = thread_id;
-	else
-		common->src_thread = thread_id;
 
 out_put_spec:
 	of_node_put(dma_spec.np);
 	return ret;
-};
+}
+
+static int
+of_k3_udma_glue_parse_chn_by_id(struct device_node *udmax_np, struct k3_udma_glue_common *common,
+				bool tx_chn, u32 thread_id)
+{
+	int ret = 0;
+
+	if (unlikely(!udmax_np))
+		return -EINVAL;
+
+	ret = of_k3_udma_glue_parse(udmax_np, common);
+	if (ret)
+		goto out_put_spec;
+
+	ret = of_k3_udma_glue_parse_chn_common(common, thread_id, tx_chn);
+	if (ret)
+		goto out_put_spec;
+
+out_put_spec:
+	of_node_put(udmax_np);
+	return ret;
+}
 
 static void k3_udma_glue_dump_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
-- 
2.34.1


