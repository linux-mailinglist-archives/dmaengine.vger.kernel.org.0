Return-Path: <dmaengine+bounces-552-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F56816673
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 07:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5753C1F22A62
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 06:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B66FBA;
	Mon, 18 Dec 2023 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dy7r5cle"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E126FA3;
	Mon, 18 Dec 2023 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BI6QkCi121872;
	Mon, 18 Dec 2023 00:26:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702880806;
	bh=m9jjy1qyyaNCh2U8cWve6iIhYhOqjY1jfz82P/MAGFQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Dy7r5clekN5VahVzi8FtWIOeOh4r7xNlGGYVvga0dyXs0ZK48dZtVDnuDSAkQrxLu
	 84xnx7so1dWCurA2fZbNhuGnMV+BaitDhcIRg5Rq28qCQZBasZco2o48dBgG0COgWD
	 mUKxUmSnXv5eB9PMRJN3AC6MNm0zfQS/5m9mSWTQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BI6QkkT101897
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Dec 2023 00:26:46 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 00:26:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 00:26:46 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BI6QebG063306;
	Mon, 18 Dec 2023 00:26:44 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/4] dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
Date: Mon, 18 Dec 2023 11:56:37 +0530
Message-ID: <20231218062640.2338453-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218062640.2338453-1-s-vadapalli@ti.com>
References: <20231218062640.2338453-1-s-vadapalli@ti.com>
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
functionality of the existing of_k3_udma_glue_parse() function. In such
cases, the driver utilizing the DMA APIs might not even have a
device-tree node to begin with, since it could be probed with other
methods (RPMsg-Bus for example).

Add the of_k3_udma_glue_parse_chn_by_id() helper function which accepts
the thread ID as an argument, thereby making it unnecessary to have a
device-tree node for obtaining the thread ID.

Since of_k3_udma_glue_parse() and of_k3_udma_glue_parse_chn_by_id()
share a lot of code in common, create a new function to handle the
common code which is named as of_k3_udma_glue_parse_chn_common().

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes since v2:
- None.

Changes since v1:
- Updated commit message indicating that this patch is helpful for cases
  where the driver utilizing the DMA APIs might not be probed by a
  device-tree node.
- Removed unnecessary return value check within
  "of_k3_udma_glue_parse_chn()" function since it will fall through to
  "out_put_spec" anyway.
- Removed unnecessary return value check within
  "of_k3_udma_glue_parse_chn_by_id()" function since it will fall through
  to "out_put_spec" anyway.

 drivers/dma/ti/k3-udma-glue.c | 79 ++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index c278d5facf7d..d8781625034b 100644
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
@@ -153,38 +182,32 @@ static int of_k3_udma_glue_parse_chn(struct device_node *chn_np,
 		common->atype_asel = dma_spec.args[1];
 	}
 
-	if (tx_chn && !(thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)) {
-		ret = -EINVAL;
-		goto out_put_spec;
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
+	ret = of_k3_udma_glue_parse_chn_common(common, thread_id, tx_chn);
 
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
+
+out_put_spec:
+	of_node_put(udmax_np);
+	return ret;
+}
 
 static void k3_udma_glue_dump_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
-- 
2.34.1


