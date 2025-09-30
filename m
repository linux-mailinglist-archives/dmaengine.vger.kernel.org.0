Return-Path: <dmaengine+bounces-6730-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A573BACBAB
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 13:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE771926BF9
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25454265CCD;
	Tue, 30 Sep 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="K94TX6oE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C223183F;
	Tue, 30 Sep 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232714; cv=none; b=p8OHldu2lSMqblR8/BemGdZZHRNfyeOl9aRc+gR+nIXEpCMJSrXheraprSSvbGVpqNet5Xa93TtHHSBSU3p02E8I3dUzvhkeTrsFXt8BF9ImwJvZDTtO8MYlMN2jjS6BE+49mIaaNVAhfrt2wR1rd1JvYx17AT7HN5MwAKfgtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232714; c=relaxed/simple;
	bh=06xqzx9iZIdzEVLA4Gr4hpuQC/wIvoKSxnQxmz3M1Sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jQi7AJy0hKj6O3mEQHujEmbB4k5adWKKafZ8s+BatpE6snUvm3jZUsNFf5iiTe0ph3V+cCPRqXPyUj5wbjYSmXPoX2YreFk8cNsoA9plejCXHDB79XyGa8XvIXLPyGCx1huF66WdCixhgDy8b74MF26Sooso+yQhI8jO2v1SXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=K94TX6oE; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1759232702;
	bh=UbnZon0QmzAam7WeQAwOovhnEdeFHUczqXe7nDAqmPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=K94TX6oE9CA0Lt/yxc14HWmVGwGqsvK3lluSJcDxApYjcoL2HBHDpJevy0jBIreqW
	 5+YA1MxGauxwNKYmub8O9Ofqfd2jyEj6AXxx+3F80y3M/vJ7wDM+tL75bre+hTliDR
	 m2kcbI88wC2NaUq87jEDOJB3hil4ki3X74Ie83ux6DXB8/jRmg5qQNTSAHpWzUFz7s
	 7HHA9wofHs9lo71QFoAhNyURKXSLUyBqVzB64Uwe/N0m/FpjDrqKz29AHvS7+ae6JW
	 qToaPGjCFhkcTx3qelQjD088q1FMl60dMCQvtu0gMX2nAwtrS1Dpv0KlCvntMCn6/l
	 cSvhPOIOXnHZQ==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id 121713E7AF1;
	Tue, 30 Sep 2025 14:45:02 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 4299F3E24B7;
	Tue, 30 Sep 2025 14:45:01 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Tue, 30 Sep
 2025 14:45:00 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Vinod Koul
	<vkoul@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "open
 list:TEXAS INSTRUMENTS DMA DRIVERS" <dmaengine@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: 
Date: Tue, 30 Sep 2025 14:44:58 +0300
Message-ID: <20250930114500.103860-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV1.avp.ru (10.64.57.51) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/30/2025 11:30:37
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196698 [Sep 30 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 67 0.3.67
 f6b3a124585516de4e61e2bf9df040d8947a2fd5
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: zhigulin-p.avp.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/30/2025 11:32:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/30/2025 9:59:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/30 06:26:00 #27867362
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

Date: Tue, 30 Sep 2025 14:33:50 +0300
Subject: [PATCH] dma: k3-udma - fix potential null dereference in
 k3_udma_glue_request_rx_chn_priv()

In k3_udma_glue_request_rx_chn_priv(), the pointer rx_chn->flows is
compared to NULL, but then passed to k3_udma_glue_release_rx_chn().
There it is dereferenced unconditionally after being passed to
k3_udma_glue_release_rx_flow() in a for loop. This happens because
rx_chn->flow_num is set before successful allocation.

This patch sets rx_chn->flow_num only after rx_chn->flows is
successfully allocated, which prevents the for loop from running if
allocation fails.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/dma/ti/k3-udma-glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f87d244cc2d6..221be7f00794 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1031,8 +1031,6 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 			rx_chn->flow_id_base = rx_chn->udma_rchan_id;
 	}

-	rx_chn->flow_num = cfg->flow_id_num;
-
 	rx_chn->flows = devm_kcalloc(dev, rx_chn->flow_num,
 				     sizeof(*rx_chn->flows), GFP_KERNEL);
 	if (!rx_chn->flows) {
@@ -1040,6 +1038,8 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 		goto err;
 	}

+	rx_chn->flow_num = cfg->flow_id_num;
+
 	ret = k3_udma_glue_allocate_rx_flows(rx_chn, cfg);
 	if (ret)
 		goto err;
--
2.43.0


