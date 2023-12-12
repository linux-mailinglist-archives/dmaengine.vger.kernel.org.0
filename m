Return-Path: <dmaengine+bounces-483-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D2E80E9F0
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 12:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE2E281B6B
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92065DF0D;
	Tue, 12 Dec 2023 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AQWNiUre"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BC0D5B;
	Tue, 12 Dec 2023 03:11:06 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAJ9U052432;
	Tue, 12 Dec 2023 05:10:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702379419;
	bh=rJFXrrgFOd1lUZkhXA6Tx5Vqg9CUHLXSKpgDsjyKI+I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AQWNiUrejD8z82OePDbeJG/Htv3WIYLSvoUiidk8Hj46obJ5wqP5PM21s6kUuMld9
	 U4Y6AHz+lmq35qwhS1vn/xtZSwG0GJDZAn8LCRgLwh792rm6m2hfKCAxhOZ8IkvGRD
	 uSfBtnetaQ7JO8akYtj/OkDuxmcHlfVqptzf0O4A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCBAJqn021165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Dec 2023 05:10:19 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 05:10:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 05:10:19 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCBAB9x088764;
	Tue, 12 Dec 2023 05:10:17 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 2/4] dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
Date: Tue, 12 Dec 2023 16:40:09 +0530
Message-ID: <20231212111011.1401641-3-s-vadapalli@ti.com>
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

A single RX Channel can have multiple flows. It is possible that a
single device requests multiple flows on the same RX Channel. In such
cases, the existing implementation of naming the device on the basis of
the RX Channel can result in duplicate names. The existing implementation
only uses the RX Channel source thread when naming, which implies duplicate
names when different flows are being requested on the same RX Channel.

In order to avoid duplicate names, include the RX flow as well in the name.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
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


