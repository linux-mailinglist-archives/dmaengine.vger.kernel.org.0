Return-Path: <dmaengine+bounces-12441-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2eA3AaScVWrkqwAAu9opvQ
	(envelope-from <dmaengine+bounces-12441-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:19:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B575056C
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:19:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12441-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12441-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E579301327A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE7737D11C;
	Tue, 14 Jul 2026 02:19:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29001F942;
	Tue, 14 Jul 2026 02:19:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995553; cv=none; b=nI8k1k8yS+j1SeFmUQlYa1aWaZZi9b0nfAxrgFaikjONgCQPyXuZviaVLWXnBd3M4Wo6xgVqVFUcX0s43x7gao1BSSSQAx3lkvyL8PNlQAdEG4qu4qPyNBNPsJrMWOZp8lp806QOWEHg2COu27lACN8A8lxrUUt87NqiD4UxS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995553; c=relaxed/simple;
	bh=CHSQNLW3A/NkNZfZSWLZL6Uuk8fxjN/BNQCuDsK2o7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k/K3Dg7G9bwC8GuJNlK1MOe1xYlh0ETF8HOEHYw9XfumuoEszf9cbENdvCKNDLqobXVEZY8htiLJiHFAbvpA9ak/a9Mf5rgbwWJElsjSlKlVS+Tm7GVTo7gvGxOGFw+EXGrO/eAFXNyT2hMBw8aJstz2Er2WlhYthAYaHzE35a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 616f46ce7f2a11f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e328e8df-f2f2-4d26-9dbd-b9940e0a73f7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:8c40c6ec2e0d51ac1c6d4e291a08cf7f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 616f46ce7f2a11f1aa26b74ffac11d73-20260714
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 365658842; Tue, 14 Jul 2026 10:19:02 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	arnd@arndb.de,
	jonas.jensen@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: moxart: Fix use-after-free by proper tasklet cleanup
Date: Tue, 14 Jul 2026 10:18:58 +0800
Message-Id: <20260714021858.642473-1-zenghongling@kylinos.cn>
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
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-12441-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:arnd@arndb.de,m:jonas.jensen@gmail.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:zenghongling@kylinos.cn,m:stable@vger.kernel.org,m:jonasjensen@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B8B575056C

The moxart DMA driver has a use-after-free vulnerability:
- vchan_init() creates tasklets that access moxart_chan memory
- Neither probe error paths nor remove() call tasklet_kill()
- devm_free_irq() only waits for IRQ handler, NOT tasklets
- mdc is devm-managed and freed after probe/remove
- Running tasklets accessing freed memory → Use-After-Free!

Fix by adding moxart_dma_free_channels() helper that calls
tasklet_kill() for each channel, and ensuring proper teardown order:

In remove():
- devm_free_irq() FIRST to stop the IRQ handler (implies
  synchronize_irq(), preventing new tasklets from being scheduled)
- moxart_dma_free_channels() to kill already-scheduled tasklets
- Then of_dma_controller_free() and dma_async_device_unregister()
  to safely unregister the device

In probe error path:
- moxart_dma_free_channels() to kill tasklets created by vchan_init()
- devm_request_irq() is automatically released by devres, so no
  explicit devm_free_irq() is needed

Fixes: 5f9e685a0d46 ("dmaengine: Add MOXA ART DMA engine driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/dma/moxart-dma.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 442f5aa16031..d01eaa6b964b 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -553,6 +553,22 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static void moxart_dma_free_channels(struct moxart_dmadev *mdc)
+{
+	struct moxart_chan *ch;
+	int i;
+
+	for (i = 0; i < APB_DMA_MAX_CHANNEL; i++) {
+		ch = &mdc->slave_chans[i];
+		/*
+		 * Wait for any scheduled tasklet to complete before channel
+		 * memory is freed by devres.
+		 */
+		tasklet_kill(&ch->vc.task);
+		list_del(&ch->vc.chan.device_node);
+	}
+}
+
 static int moxart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -609,19 +625,23 @@ static int moxart_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&mdc->dma_slave);
 	if (ret) {
 		dev_err(dev, "dma_async_device_register failed\n");
-		return ret;
+		goto err_dma_register;
 	}
 
 	ret = of_dma_controller_register(node, moxart_of_xlate, mdc);
 	if (ret) {
 		dev_err(dev, "of_dma_controller_register failed\n");
 		dma_async_device_unregister(&mdc->dma_slave);
-		return ret;
+		goto err_dma_register;
 	}
 
 	dev_dbg(dev, "%s: IRQ=%u\n", __func__, irq);
 
 	return 0;
+
+err_dma_register:
+	moxart_dma_free_channels(mdc);
+	return ret;
 }
 
 static void moxart_remove(struct platform_device *pdev)
@@ -630,10 +650,12 @@ static void moxart_remove(struct platform_device *pdev)
 
 	devm_free_irq(&pdev->dev, m->irq, m);
 
-	dma_async_device_unregister(&m->dma_slave);
+	moxart_dma_free_channels(m);
 
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
+
+	dma_async_device_unregister(&m->dma_slave);
 }
 
 static const struct of_device_id moxart_dma_match[] = {
-- 
2.25.1


