Return-Path: <dmaengine+bounces-11155-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5MBODV5FIWpECQEAu9opvQ
	(envelope-from <dmaengine+bounces-11155-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 11:29:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B436763E89E
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 11:29:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11155-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11155-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEB793094A36
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20412E8DEB;
	Thu,  4 Jun 2026 09:23:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541991F5834;
	Thu,  4 Jun 2026 09:23:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565016; cv=none; b=YHjn9N6uc/5UtwwsGiFq0JxEEAkbWycuDu1qapwG6Fs9/UCeauCOzZz97UZUsBXVvAWEkLqWU1pkQPWNTCe44DCLYEtcs8L69/fxHm9T6fKVJ0PAkQduE3TZNLbj6mCCWCfEUBzdoVX0IYiNZyorB0kenR5NhdQZqb3nxr+f/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565016; c=relaxed/simple;
	bh=nFnAWIh4P/Fpg1Glg6W+rMtIfeYmRbEzGAiGMAUQwZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HatIZf4LGEo6rNZ4o6GWY927gAIn0mO7fdamkKvwMxW33dqYsp4p+Ea7ADskyp764yYvsOakfDEjNbnfEk5hkekN3dlYTehOKz8lUtxeSpf5ZTgD+9WpLv81Qb9YunsZoXJB7WTfBCXDnwSEGzde4ttfJ+qKjzpzK7ohbESJt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 0a27f7325ff711f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5b624450-47ea-4371-ae5f-1258fe4495b8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:e4c7805d934a014666a993804dd046ea,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0a27f7325ff711f1aa26b74ffac11d73-20260604
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 860169002; Thu, 04 Jun 2026 17:23:25 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: ludovic.desroches@microchip.com,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	tudor.ambarus@linaro.org,
	nicolas.ferre@microchip.com
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	sashiko-bot@kernel.org
Subject: [PATCH] dma: at_hdmac: Fix use-after-free by proper tasklet cleanup
Date: Thu,  4 Jun 2026 17:23:20 +0800
Message-Id: <20260604092320.257303-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11155-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:ludovic.desroches@microchip.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:tudor.ambarus@linaro.org,m:nicolas.ferre@microchip.com,m:linux-arm-kernel@lists.infradead.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:zenghongling@kylinos.cn,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,126.com,kylinos.cn,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:from_mime,kylinos.cn:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B436763E89E

Current cleanup paths have a use-after-free vulnerability:
- vchan_init() creates tasklets that access at_dma_chan memory
- free_irq() only waits for IRQ handler, NOT tasklets
- atdma is devm-managed and freed after probe/remove
- Running tasklets accessing freed memory → Use-After-Free!

The fix requires careful ordering:
- Disable interrupts FIRST to stop new tasklets from being scheduled
- Then kill tasklets to wait for already-scheduled ones to complete
- Only then free IRQs and other resources

Fixes: ac803b56860f ("dmaengine: at_hdmac: Convert driver to use virt-dma")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel.org/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/dma/at_hdmac.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index e5b30a57c477..ac45e88e16da 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1940,6 +1940,19 @@ static void at_dma_off(struct at_dma *atdma)
 		cpu_relax();
 }
 
+static void at_dma_cleanup_channels(struct at_dma *atdma)
+{
+	struct dma_chan *chan, *_chan;
+
+	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
+			device_node) {
+		/* Disable interrupts */
+		atc_disable_chan_irq(atdma, chan->chan_id);
+		tasklet_kill(&to_at_dma_chan(chan)->vc.task);
+		list_del(&chan->device_node);
+	}
+}
+
 static int __init at_dma_probe(struct platform_device *pdev)
 {
 	struct at_dma		*atdma;
@@ -2109,6 +2122,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 err_memset_pool_create:
 	dma_pool_destroy(atdma->lli_pool);
 err_desc_pool_create:
+	at_dma_cleanup_channels(atdma);
 	free_irq(platform_get_irq(pdev, 0), atdma);
 err_irq:
 	clk_disable_unprepare(atdma->clk);
@@ -2125,17 +2139,12 @@ static void at_dma_remove(struct platform_device *pdev)
 		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_device);
 
+	at_dma_cleanup_channels(atdma);
+
 	dma_pool_destroy(atdma->memset_pool);
 	dma_pool_destroy(atdma->lli_pool);
 	free_irq(platform_get_irq(pdev, 0), atdma);
 
-	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
-			device_node) {
-		/* Disable interrupts */
-		atc_disable_chan_irq(atdma, chan->chan_id);
-		list_del(&chan->device_node);
-	}
-
 	clk_disable_unprepare(atdma->clk);
 }
 
-- 
2.25.1


