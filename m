Return-Path: <dmaengine+bounces-4145-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FABA14F14
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 13:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3770C3A56DE
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460141FDE3A;
	Fri, 17 Jan 2025 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M81ivHMZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F01FC7FF;
	Fri, 17 Jan 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116276; cv=none; b=OkzxFtlxstHMQfTZAusL40JJDTFA/6WYC9J/ji6QCaeeN8e8oGB+dO56RHuxIyKk7s9nG/5n1WbcOgv4TyWv+ahyjGCKQKMpDdfiyQjpj868AG+7lmuzvZ+YE4V5ItJDduk6mnstM1ah1B7ywWTqQ4fOsywMv498AwsvShT/e+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116276; c=relaxed/simple;
	bh=/HpH99sjcE85Bu7IpqyA7nmaJehvO9FV+eGXMRdz9W8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lu8TpYuTFK9JAjYlzcBqMbPShR9QHdtXfdYSGjozTkgKHRQNDkjj4oLJV8dhQmKaotHz9PniZKEX2VPdaWg9P8WqLMqg87NxzuV+k7CSQRc2fGntQGSag0gK6suw8Er3kOtJ8E6t55rBeJ9mPzH8s+xXioRTG1TFXaNEDAzwXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M81ivHMZ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50HCHchB184675
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 06:17:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1737116258;
	bh=LFQSTElW6NmjiOC3x0rgEsjtkY9Sw6lqirhLIf3t8m0=;
	h=From:To:CC:Subject:Date;
	b=M81ivHMZmgfCxC+zLMFMWn0s8x+FdGMMrg1u+liXUTkMPsH498go2HrjfE1GziZHu
	 +thfgnaTcWjpknKTQUHUOseCc5gq9y3OEpW5VKhB6XwEkTPcf1DKxRf0/dP6PN0HWw
	 r4NFr7BmUCZUrZRAjxbmacTa1LXkx0v3jV1eAzvc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50HCHcwG081724
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jan 2025 06:17:38 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Jan 2025 06:17:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Jan 2025 06:17:38 -0600
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50HCHZcL111472;
	Fri, 17 Jan 2025 06:17:36 -0600
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <y-abhilashchandra@ti.com>
Subject: [PATCH RFC] dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy
Date: Fri, 17 Jan 2025 17:47:28 +0530
Message-ID: <20250117121728.203452-1-y-abhilashchandra@ti.com>
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
udma_of_xlate() and subsequent dma_request_channel() can fail due to
mismatch in the cap_mask. Fix this by removing the local dma_cap_mask_t
variable and directly using the one from the dma_device structure.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
---
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


