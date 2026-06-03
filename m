Return-Path: <dmaengine+bounces-11134-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id baNiB7abH2oInwAAu9opvQ
	(envelope-from <dmaengine+bounces-11134-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:12:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75781633CAB
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:12:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jw0pT8eu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11134-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11134-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDA1F30D130B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B453E6388;
	Wed,  3 Jun 2026 03:08:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32D3E6DE0
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:08:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456108; cv=none; b=YGV837RPM7RwDCAzvB1q8zBE10Isb3yCE16RE4VVhLkDxFCl/3ySeURBtWS+DUR9q6Ztj+Jg7F51fjKR5doPTaj79vZ5ThDURDxug6kj5mI8cNb2SLVAQS7KhfgYobquVxuvxidxRkZGEUzb6J1NH5quS1fP9q6w+bPiB489Nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456108; c=relaxed/simple;
	bh=GJjxv6I4KbyYJcLAYZXL2OfmKR11Tsw/rO82A+IHuJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVrilHQ1ozyGt3ubKjKzsnjL5y3QwOBKMV2mTmU0qEGt/7F+JWlJHCuDIc/JNceIJNQ+JS5YP/B+f7E9AuJIEI1xtqt/3MU9S/fzX7Z4AkK0rcr5PMaTalZEOhNq4z3nlSUhF14WUzgHgmq4VztCKtyxiwDiznC/mnqFkZGKLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jw0pT8eu; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9033d230so89500a91.1
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456106; x=1781060906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/7UILlPUwdg4xP+wSM0nxIBSMKN8rKynfm10QKhZoA=;
        b=jw0pT8euhBc20d7qfmke4VEEebkcmILnxUNU9n52c65UWZD8ob2Se8y6DP9LLkXWIs
         F/3+yJqDI41I0CfHXVQJQ0rIWU2itiZOZe7OlDE+hFO7Y5+ai15w6GzTTKMCeZY4xG25
         ZMK74Mn4nomYfUU+3I7AEuLdUHKnzrfDWmDeFl/PpdwRkMo/5jmxGC6HZbufQ+1KWQZF
         JkO9kZS93mQVX/etLE1mgdrMTRzqgDARG30amxZQxJqUPcNMgXC6Jgt5tVi+B3NWP5qU
         O2IXzxcULxO0brAVkBSkNw+gwQ2jp4BlpfENIo1PpiRFQ79BSBR+llV5SDX6311E7TeE
         LI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456106; x=1781060906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/7UILlPUwdg4xP+wSM0nxIBSMKN8rKynfm10QKhZoA=;
        b=muCCxrGCkKfxofME0wHdThDh87/CT2NkRMJeTZXJItId4skgTwozjNEO9KUUzThhha
         7o4O+4bRkTBEmZJJ9vJZSF5oLDZFIQxrI0g8okH4Chm1ec9WYq0/kd0nAWtbs3wf+ZDq
         RHH3zEJcqEQtCwcwly+x8IO1Lzn1GoA6QfEXDgyKGB8xcvj9/1ECxg+E8YB+txwzHEI8
         QOnIDcOB6VtTlzJfVhlEmdIlOYWZYLIjnW0TuvHHw3XVcIzFB3BmUeuiirWM8yskK6jg
         8dJsqzUXD50BzRDteXZJ4szjssvt1h/NhlcrbKUAKOOuvQEaUioscM+aj/A6/Kf/BkhL
         5vqw==
X-Gm-Message-State: AOJu0Yw3ImZFhmqDDf2mqUKxirDhdbVdMdaxbkz3qzxgcc8xM8fWlX+s
	gIYLhdEvCmMJBsdY5bHMZPiRdM5t03pwDxE7QlvVoEbXgl890ElYyhZw+AuDRPvu
X-Gm-Gg: Acq92OHf4TGP4nSptloi7yyyfsQJGiYBcCElaDWW9TDx4HosyoHIYE5wDrL1lDNwxOa
	ew2J23RVABECfGcRQsJ8xqRtxPXB4gIjR5GCcqoBP2/IX2oJetQFTtEDNEEiw9DvxgZUlwr/kUu
	k5ktvm76YzIjwKoogvr4/gSMATJVHs4Zgk+1dFB9T5qv5YmlZh4Pr0Vz13oHnsWe5emZYg2vfuU
	Ps3pLRwDthE+AV0C8Y5KrU0jNBpkqgDM9syQGttEIWrWyanw8H5FpMqGuGXIt88xkAtXUjoEQo/
	YRJWLqy5Pd5iuJG1ZdicbLeXQBQfIqc7ocoMaoxI+aSlDqROA44g8QDfIZLA85BaPBocnouC1DM
	PnLsxeZIsqiSbHo3S27vDZwzi1m3v2c2GybtoexocRFpGZn8JFmir86efDWAtWDUdYiS3qXaqXR
	uDVEVyPd58mmLFOR5tQUgQvCFxooI16ZkRXX16bFSdlz3fr4j9H2XdwQBtsEbI6R/K18bssWBKz
	ETRFMejTIJR+Dmn45KnmUJqYwVKiDqHIa4PTNdrOiQ50qbfn/nOc+82
X-Received: by 2002:a17:90b:4c4a:b0:36b:8e97:fb06 with SMTP id 98e67ed59e1d1-36e3a0f4ebdmr1048567a91.8.1780456106063;
        Tue, 02 Jun 2026 20:08:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 7/8] dmaengine: ti: omap-dma: fix interrupt handling in remove
Date: Tue,  2 Jun 2026 20:07:53 -0700
Message-ID: <20260603030754.288757-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,atomide.com,arm.linux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11134-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:vulab@iscas.ac.cn,m:tony@atomide.com,m:rmk+kernel@arm.linux.org.uk,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,m:rmk@arm.linux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75781633CAB

The remove path had several pre-existing bugs:

1. Interrupts are enabled via IRQENABLE_L1 in probe and
   alloc_chan_resources, but the remove path writes to IRQENABLE_L0,
   which has no effect on the L1 interrupt line. The DMA engine can
   continue asserting its IRQ during removal. Write to IRQENABLE_L1
   instead.

2. devm_free_irq() was called before disabling hardware interrupts.
   With IRQF_SHARED, the hardware may still assert the IRQ line after
   the handler is freed, causing unhandled interrupts that can lead to
   the kernel permanently disabling the shared IRQ line. Disable
   interrupts first.

3. platform_get_irq() return value was not checked before
   devm_free_irq(). If it returns an error code (<= 0), passing it to
   devm_free_irq() is incorrect. Add a guard.

4. Clearing od->irq_enable_mask and writing to IRQENABLE_L1 raced with
   the interrupt handler, which reads irq_enable_mask under the
   spinlock. Hold irq_lock around the disable.

5. The posted write to IRQENABLE_L1 used _relaxed accessors with no
   readback to drain the write buffer. Add a readback flush before
   devm_free_irq() to ensure the hardware has actually disabled the
   interrupt line.

Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index c0890d8c43ba..7343325ce2b1 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1517,9 +1517,11 @@ static int omap_dma_chan_init(struct omap_dmadev *od)
 
 static void omap_dma_free(struct omap_dmadev *od)
 {
+	struct omap_chan *c;
+
 	while (!list_empty(&od->ddev.channels)) {
-		struct omap_chan *c = list_first_entry(&od->ddev.channels,
-			struct omap_chan, vc.chan.device_node);
+		c = list_first_entry(&od->ddev.channels,
+				     struct omap_chan, vc.chan.device_node);
 
 		omap_dma_terminate_all(&c->vc.chan);
 		list_del(&c->vc.chan.device_node);
@@ -1878,16 +1880,20 @@ static void omap_dma_remove(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-	irq = platform_get_irq(pdev, 1);
-	devm_free_irq(&pdev->dev, irq, od);
-
 	dma_async_device_unregister(&od->ddev);
 
 	if (!omap_dma_legacy(od)) {
-		/* Disable all interrupts */
-		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
+		spin_lock_irq(&od->irq_lock);
+		od->irq_enable_mask = 0;
+		omap_dma_glbl_write(od, IRQENABLE_L1, 0);
+		spin_unlock_irq(&od->irq_lock);
+		omap_dma_glbl_read(od, IRQENABLE_L1);
 	}
 
+	irq = platform_get_irq(pdev, 1);
+	if (irq > 0)
+		devm_free_irq(&pdev->dev, irq, od);
+
 	omap_dma_free(od);
 
 	if (od->ll123_supported)
-- 
2.54.0


