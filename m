Return-Path: <dmaengine+bounces-4909-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CEA915D1
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628DB190750C
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89782222A2;
	Thu, 17 Apr 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8WgWN+R"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDC221F30;
	Thu, 17 Apr 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876547; cv=none; b=i+HiC8cP0qT13tHJInFmZ9GI8THLQeEgR/C74ZVU4mvo3UEE0iVdQOql7cL5a6mSAlHimMaROsCR7GH3qMp0NDBbcJmcYMUtLeN9qC0U8MRXdZ4o08svOv/o5Bwpwl9CMebtpqPntZDsnQN497s1UmjCownJjJO7KsRpNA7e2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876547; c=relaxed/simple;
	bh=4i5YgCrOGdBrtwwWThX/LhUHhP/fkzwgzMCsIxQCG+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGU07rUJ/v7R+4/Fa2NWIzmr3/fgXbkvqWpr1njPaQI8gTVEum4JwJw4WeUS8idGps/KomsADbKI8nHJfGil/RvgCcQmfNtMmzJ4XYheslaHflhS9mckLLjtmLIM5IxDTsJGWSVEZ8s7rv9WqsWwPM2uyRCIBj0amShgTi3Ro6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S8WgWN+R; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53H7tehS2909553
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 02:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744876540;
	bh=P5bcOC/5bs1h8a5DNn2BHPGF4s2BivbRSPsmGSQjsVI=;
	h=From:To:CC:Subject:Date;
	b=S8WgWN+RqpPRfwKYRzSh3S1m9QCjMMqR7qL0Hz+kqO6cBmroj8+KB32ZLIh395R1c
	 TVUAOOQ9v3lKf4EtSp+T1jqZ8ztwl4fXaDl0tBonFCDdvIUC4DoH3eEv9gy0cxKo81
	 7ucdZpNRDjBirF1ewapoi96y2TfqawKvsGfUFwOM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53H7teWl008094
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 02:55:40 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 02:55:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 02:55:39 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53H7tanv104512;
	Thu, 17 Apr 2025 02:55:37 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <peter.ujfalusi@gmail.com>, <grygorii.strashko@ti.com>, <vkoul@kernel.org>
CC: <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <y-abhilashchandra@ti.com>,
        <stable@vger.kernel.org>
Subject: [PATCH RESEND] dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy
Date: Thu, 17 Apr 2025 13:25:21 +0530
Message-ID: <20250417075521.623651-1-y-abhilashchandra@ti.com>
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
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
---
 drivers/dma/ti/k3-udma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b223a7aacb0c..08ed8cd7f1dd 100644
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


