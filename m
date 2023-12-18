Return-Path: <dmaengine+bounces-555-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE26A81667D
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 07:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9521D28263F
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 06:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852AAF9CD;
	Mon, 18 Dec 2023 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KzaBeBN4"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B8F9C1;
	Mon, 18 Dec 2023 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BI6Qn5n041875;
	Mon, 18 Dec 2023 00:26:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702880809;
	bh=dyqviI7GwGtSeJl4sxgKTXGo8yaA63h9KE0oUhFvIVs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KzaBeBN4jwW2FS3I7GL/H4soC/b8UPfbfKufhYOngpRmKngtTHJm9EUjj90mzlh8u
	 0neTPnbow/N59NVSnij1q5ZDMd18URUMVvLAprgsvJiR+l0EN8lSYEdlwc1jDv++Mu
	 8lqfP0JlUYQuwWjfc8HrYoxRHENguIt4LTscPGz4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BI6QnWA044355
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Dec 2023 00:26:49 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 00:26:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 00:26:49 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BI6QebH063306;
	Mon, 18 Dec 2023 00:26:46 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/4] dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
Date: Mon, 18 Dec 2023 11:56:38 +0530
Message-ID: <20231218062640.2338453-3-s-vadapalli@ti.com>
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

A single RX Channel can have multiple flows. It is possible that a
single device requests multiple flows on the same RX Channel. In such
cases, the existing implementation of naming the device on the basis of
the RX Channel can result in duplicate names. The existing implementation
only uses the RX Channel source thread when naming, which implies duplicate
names when different flows are being requested on the same RX Channel.

In order to avoid duplicate names, include the RX flow as well in the name.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes since v2:
- None.

Changes since v1:
- None.

 drivers/dma/ti/k3-udma-glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index d8781625034b..eff1ae3d3efe 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1072,8 +1072,8 @@ k3_udma_glue_request_remote_rx_chn(struct device *dev, const char *name,
 
 	rx_chn->common.chan_dev.class = &k3_udma_glue_devclass;
 	rx_chn->common.chan_dev.parent = xudma_get_device(rx_chn->common.udmax);
-	dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x",
-		     rx_chn->common.src_thread);
+	dev_set_name(&rx_chn->common.chan_dev, "rchan_remote-0x%04x-0x%02x",
+		     rx_chn->common.src_thread, rx_chn->flow_id_base);
 	ret = device_register(&rx_chn->common.chan_dev);
 	if (ret) {
 		dev_err(dev, "Channel Device registration failed %d\n", ret);
-- 
2.34.1


