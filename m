Return-Path: <dmaengine+bounces-818-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2CD83AA21
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jan 2024 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7950028788A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jan 2024 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60A77F1E;
	Wed, 24 Jan 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SdqPxX1c"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187477765E;
	Wed, 24 Jan 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100215; cv=none; b=SVNp5NqI7u69lRbc3dVLqJLREPZYU8eJ/jGay+MkA2RMYTcZ+A6Y1tlm/DRDDFqtO5bN1HeAJiHcn7oFD10c+F61wo4A+B3UGyQK3UC9xxJbABDEvjv3gp5UN3KVbssUb4PXyhhYGvxiuHFf8x+qx2aibhq7sThBALtkK4YDcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100215; c=relaxed/simple;
	bh=iBA1Ekgfcwre8gWPZQCZmmeWwBWZ8PabuM/kNIAbgSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfS0itIioz2RexB5Zm+xxbzon7AEBBgdPK7ehgw3bgLMUccq4IhMt90NTETtWhuNg8yEqgb4B0HPRfmP+ZGsAKPTI93R2+xksdnLB/enrpmx7wyxQtZy/AWimfmoIscoy1XPQ9AMrrjWTJdu09hziJKZPQ++ADvgot6csP7lI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SdqPxX1c; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OChS54010398;
	Wed, 24 Jan 2024 06:43:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706100208;
	bh=q53fhWLVnSaneAHJMzZkkEoZ9j0WFpva4OEM0vdeJ4g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SdqPxX1caFEvG6f8/Bx//FIt79hMEC0YqRXob3+lU4V2Vh5pWzbpKP4+4vTZGFcY1
	 qhAPfiNl3ni5jfhMPDRmbNLEE0btkfi6ZgtDAhFM+nm2o5i58OvAgOdroQPIhUJQda
	 /hX6BnzfkJNkxpteZNjG/SZoIKhaHxN9rKcrIxJ8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OChSVC019748
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 06:43:28 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 06:43:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 06:43:27 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OChJPf014062;
	Wed, 24 Jan 2024 06:43:25 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 2/4] dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
Date: Wed, 24 Jan 2024 18:13:17 +0530
Message-ID: <20240124124319.820002-3-s-vadapalli@ti.com>
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

A single RX Channel can have multiple flows. It is possible that a
single device requests multiple flows on the same RX Channel. In such
cases, the existing implementation of naming the device on the basis of
the RX Channel can result in duplicate names. The existing implementation
only uses the RX Channel source thread when naming, which implies duplicate
names when different flows are being requested on the same RX Channel.

In order to avoid duplicate names, include the RX flow as well in the name.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
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


