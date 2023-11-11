Return-Path: <dmaengine+bounces-77-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377777E8AD6
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 13:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F6280EA5
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21BE14273;
	Sat, 11 Nov 2023 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lQEn/0jn"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE414006
	for <dmaengine@vger.kernel.org>; Sat, 11 Nov 2023 12:16:16 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B23AA6;
	Sat, 11 Nov 2023 04:16:15 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCG15g095445;
	Sat, 11 Nov 2023 06:16:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699704961;
	bh=V4T4sch1tiJyW5MPqw/gLkRYEZf1vXcBY1djKhH51uw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lQEn/0jncR8JisFB4/YDriCEpYFZKKNVept1MeulnrZbDU7jxYL82dQmTZHCan7ea
	 40gt/x3IqfVQKgGqBgeS3YYVdY/NcCa2kVcHubBkshDJhPVWG1mKebiEjs+B2b12b3
	 3bk+noeDmOGRTID9+0Sll4ip9xwmMWvRerx1uxhM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ABCG13d081646
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 11 Nov 2023 06:16:01 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 Nov 2023 06:16:01 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 Nov 2023 06:16:01 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ABCFtVW100939;
	Sat, 11 Nov 2023 06:15:59 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH 1/3] dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
Date: Sat, 11 Nov 2023 17:45:53 +0530
Message-ID: <20231111121555.2656760-2-s-vadapalli@ti.com>
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


