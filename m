Return-Path: <dmaengine+bounces-98-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5B7EABBA
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 09:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF781C209CB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556915486;
	Tue, 14 Nov 2023 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xztT5IOe"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AC15491
	for <dmaengine@vger.kernel.org>; Tue, 14 Nov 2023 08:39:26 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B034D42;
	Tue, 14 Nov 2023 00:39:24 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8dKdY075666;
	Tue, 14 Nov 2023 02:39:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1699951160;
	bh=YxxSV/Iq5pcLxWMtOGqpMQxefWGrkV/IHCtaCrNJvsI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xztT5IOePOA0ShmwuSjd4Kiae+NtBJNRyiWAVyktPux1HH8pVBaD75pcr6EFEfppe
	 K2Ws683YgniURFrTL+Pf9Vdbo32mwtQiWBdaXCF3n/qUNiZgbVBBloTX8SdWUEvqSk
	 2bQuXsoIPgLPwQnDNRCzZmQV0bmUR/eiS8oeE958=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AE8dJ06072602
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Nov 2023 02:39:19 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 02:39:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 02:39:19 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AE8d6OH128120;
	Tue, 14 Nov 2023 02:39:17 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 4/4] dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
Date: Tue, 14 Nov 2023 14:09:06 +0530
Message-ID: <20231114083906.3143548-5-s-vadapalli@ti.com>
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

A single RX Channel can have multiple flows. It is possible that a
single device requests multiple flows on the same RX Channel. In such
cases, the existing implementation of naming the device on the basis of
the RX Channel can result in duplicate names. The existing
implementation only uses the RX Channel source thread when naming, which
implies duplicate names when different flows are being requested on the
same RX Channel. In order to avoid duplicate names, include the RX flow
as well in the name.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 167fe77de71e..9415f03757bb 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1094,8 +1094,8 @@ k3_udma_glue_request_remote_rx_chn_common(struct k3_udma_glue_rx_channel *rx_chn
 
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


