Return-Path: <dmaengine+bounces-4248-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C053A25336
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 08:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760757A19AB
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 07:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B791E7C2D;
	Mon,  3 Feb 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nIESzpK1"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5211C695;
	Mon,  3 Feb 2025 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738568974; cv=none; b=hTTDk7YVj/s5fBTJ8zuofjgYgV0cPUCSMJrKq/Ec4NI1U3ocU39gjkgjFngulNp1H6qbK8hG+bm5v0zSisW7Q1P5aS3s06HtWhcoiiuGbMXJTxVsdwHYE7/EYfA+PLkgH7sGsr9NZd0T0IxAToOPY2/bg8N+x7AbaqygbPxkyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738568974; c=relaxed/simple;
	bh=UWOdnQSXCQCUpLex2fFMN2HU0ExUKNaMCm3aZTAkfxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n9tcf4+1ZPxkcXziggLQb9zJQ7fTjx47tKPE5fclkUmfm27ukabtkcMleUoJ1r3VzlMIzlZBBkyIZprpHuby05oU70xX9llvNcr9T2iKKzxGIJcsRN92nwQb1upT8FlExFvvUeQ6fjrjU1A5wqEnt5oloQ+J9HGtusTJEVU5oT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nIESzpK1; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5137nKm82978540
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 01:49:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738568960;
	bh=0ixPdjMr9uhbk9uqgulbTw/c2bwsozG2r58q5xC4kRE=;
	h=From:To:CC:Subject:Date;
	b=nIESzpK1RM1OAEphFOgCcsXaOkTCscsp6oWROrFxk3c4pRhJe/J2H+MZQMemZEi5K
	 tmDyoACbuMOcCmQ5gXUDjdpgSSw6cN18MjJNyDeAePUGOSmXYcMWqfu/OaKu4nrpdO
	 S+YuNXjAoVLqvcDbK6Cwa1Bmun6LcSnac0BXW0oQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5137nK2C008081
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Feb 2025 01:49:20 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Feb 2025 01:49:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Feb 2025 01:49:19 -0600
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5137nHIi114856;
	Mon, 3 Feb 2025 01:49:17 -0600
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <y-abhilashchandra@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy
Date: Mon, 3 Feb 2025 13:19:15 +0530
Message-ID: <20250203074915.3634508-1-y-abhilashchandra@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Currently, a local dma_cap_mask_t variable is used to store device
cap_mask within udma_of_xlate(). However, the DMA_PRIVATE flag in
the device cap_mask can get cleared when the last channel is released.
This can happen right after storing the cap_mask locally in
udma_of_xlate(), and subsequent dma_request_channel() can fail due to
mismatch in the cap_mask. Fix this by removing the local dma_cap_mask_t
variable and directly using the one from the dma_device structure.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Cc: stable@vger.kernel.org
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
RFC: https://lore.kernel.org/all/20250117121728.203452-1-y-abhilashchandra@ti.com/ 

 drivers/dma/ti/k3-udma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7ed1956b4642..c775a2284e86 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4246,7 +4246,6 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 				      struct of_dma *ofdma)
 {
 	struct udma_dev *ud = ofdma->of_dma_data;
-	dma_cap_mask_t mask = ud->ddev.cap_mask;
 	struct udma_filter_param filter_param;
 	struct dma_chan *chan;
 
@@ -4278,7 +4277,7 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 		}
 	}
 
-	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
+	chan = __dma_request_channel(&ud->ddev.cap_mask, udma_dma_filter_fn, &filter_param,
 				     ofdma->of_node);
 	if (!chan) {
 		dev_err(ud->dev, "get channel fail in %s.\n", __func__);
-- 
2.34.1


