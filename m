Return-Path: <dmaengine+bounces-6769-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC40BBE12D
	for <lists+dmaengine@lfdr.de>; Mon, 06 Oct 2025 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5726C3AC333
	for <lists+dmaengine@lfdr.de>; Mon,  6 Oct 2025 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFDD27FB1C;
	Mon,  6 Oct 2025 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="U72hKuoW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868725783B;
	Mon,  6 Oct 2025 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754592; cv=none; b=oP2YwLINznfYKo7IdVKUbm72CGgO9uVQ0eHwTC38TTtI9ZoGsMC1UtHQoZar34JzrsSZxEw1JnrhdD9KxpvgDJmo2f2hD7RJWj1u5Dj1dniNz1KuIgFwxmja9ksDR7Tm4Xlrz7zdOH8StXCGzd1+R0C4AFgs+5o0OIIaMfFAInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754592; c=relaxed/simple;
	bh=cIIPOtM+MaWT3tKlgJwoQWdpNA89gMEH5S0UZqvrSls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnjpX6BHbPGEgDRwBQMj2/VPx0soyjG2sOclTFgPoDzIntoQrTXmYc5iIQbbHdVdN4E5okIzaj75jrvg5w0u6vacK3koWTYs9QWL11MyrmuYaYngiRZoGGmXawx+kkIwMQ+AXMFez90qlYRnLkdQB0puBziNbpQ/3iX4uNA0bS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=U72hKuoW; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1759754580;
	bh=A8kN43CSt5tHncoCjW3K35WUWORepP6KI277EfOvNrk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=U72hKuoWw/GwVAHJTndakAeR5zoXNCBWm8PJ86DOzbpxkDc3gEQJaEDHJA4nCTsEl
	 ODRFkqfgwXlC6cm1F6/TjZH9XFIgHclLBImF/7p6d2MXJ4CNjMy78qYOLfUbWSAo3A
	 tznGayPRprkBYxhqQD+sr36Ot48sXhVhzGPvDX42dRS6F7bk49sB9hbEmppQfUqORS
	 RjTlbVRCZeZ3T/ZofdY8KLZOsBTo35wRjz15zqJJBeBTxxRvppOLf6iDB7cd4IHv8M
	 liJUkpz3OMOGO4u/5gUgHB4k6GaNc+9AJB2XpaI5cB09/aks6oyrQawLFhAn880SMx
	 HWwDjoBgYjckw==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id B7E373E2129;
	Mon,  6 Oct 2025 15:43:00 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 12AA63E21A8;
	Mon,  6 Oct 2025 15:43:00 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Mon, 6 Oct
 2025 15:42:59 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Vinod Koul
	<vkoul@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dma: k3-udma - fix potential null dereference in k3_udma_glue_request_rx_chn_priv()
Date: Mon, 6 Oct 2025 15:42:57 +0300
Message-ID: <20251006124258.1132312-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930114500.103860-1-Pavel.Zhigulin@kaspersky.com>
References: 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/06/2025 12:28:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196838 [Oct 06 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 69 0.3.69
 3c9ee7b2dda8a12f0d3dc9d3a59fa717913bd018
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;kaspersky.com:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;zhigulin-p.avp.ru:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/06/2025 12:29:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/6/2025 10:41:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/06 03:36:00 #27884816
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

In function k3_udma_glue_request_rx_chn_priv(), the pointer rx_chn->flows,
after being compared to NULL, is passed to k3_udma_glue_release_rx_chn(),
where it is dereferenced unconditionally after being passed to
k3_udma_glue_release_rx_flow() in a for loop. This happens because
rx_chn->flow_num is set before successful allocation.

This fix sets rx_chn->flow_num only after rx_chn->flows is successfully
allocated, preventing the for loop from running if allocation fails.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
v2: Fix passing uninitialized rx_chn->flow_num to devm_kcalloc. Add
proper subject to patch.

 drivers/dma/ti/k3-udma-glue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f87d244cc2d6..03679f61c241 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1031,15 +1031,15 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
 			rx_chn->flow_id_base = rx_chn->udma_rchan_id;
 	}

-	rx_chn->flow_num = cfg->flow_id_num;
-
-	rx_chn->flows = devm_kcalloc(dev, rx_chn->flow_num,
+	rx_chn->flows = devm_kcalloc(dev, cfg->flow_id_num,
 				     sizeof(*rx_chn->flows), GFP_KERNEL);
 	if (!rx_chn->flows) {
 		ret = -ENOMEM;
 		goto err;
 	}

+	rx_chn->flow_num = cfg->flow_id_num;
+
 	ret = k3_udma_glue_allocate_rx_flows(rx_chn, cfg);
 	if (ret)
 		goto err;
--
2.43.0


