Return-Path: <dmaengine+bounces-12173-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rtIXBJ6cT2oxlAIAu9opvQ
	(envelope-from <dmaengine+bounces-12173-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 15:05:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D5F73160B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 15:05:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=K33ViNGY;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12173-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12173-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F51A301A1E6
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEDB1C84CB;
	Thu,  9 Jul 2026 13:01:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D822097
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 13:01:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602099; cv=none; b=IkOf4E7YBuOI4W+kBIeUudm473BftjhzAL6X6G55OBtSbsPfnISfHkVn2pb0IoLBFFL2LZi1zgV2Fd5XOIKC3dN0326nQsdVgIUu+9wDzBadt5WjS0IytAWERXiIvnUjY30Fhd0VCbj2J59s9rK+scjp3GAEUs5x4oqpEZo3YSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602099; c=relaxed/simple;
	bh=jsI6ncJVu9W5D1GK1gXXTDH2I7Q00ERsUO2b58yAOVY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f1ndOUXDakSb0sES5Bp7LnEJU+2G9chrgrtY2Rm/3NXzKnto/2XtsN4FhNs9C/ZgiMhOhXs7+bpixoNzOsAg3bUR3Y1csHtDxMZ25r6OZRx2+eeCJGmrLBk+pbhoEinVtrZxIlfPQGDoUU3LEoFCq7PSct5NPubkEn2/O72OoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mayankmishraa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K33ViNGY; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84865f326efso326104b3a.0
        for <dmaengine@vger.kernel.org>; Thu, 09 Jul 2026 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783602097; x=1784206897; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bRdzjBtu4VvXAkhDsOfjSOAB+1gpNe7QRYZXWJaV5do=;
        b=K33ViNGYRPRQRWXtsMGwpFpA8L91wWIK87HL92WIm3R4vfY1fFZSKwcgAHcGCoMuzQ
         ovdczx1iO7QPg69O9Xd9CDP5vDznfOrj3kLvUYQbefqGcXvMaJc8FDeQ6As7SUQMyifB
         n51q/1hwctMYgbkfOgaBCy8ummX8/+hBfo135GH6HSaUL9RQMwk3cjGUW5yHUpLU6Cmk
         Vy55bBx/8fFMeM1Z0USFgGf0utASi8Vv0kxOg3+eE68UgpJjEMyJc2lhHUn21zUKRBdK
         ZbRe28XFlX2mQR5i8kW1omN8sUSoxWIMRnQsGG0HaSqIYiaw//zJvIVdBKl5uXcGODDO
         xTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602097; x=1784206897;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRdzjBtu4VvXAkhDsOfjSOAB+1gpNe7QRYZXWJaV5do=;
        b=lnar4KLTM2u79BcopldXtCXB+YRPNzyxp86Wv/+FievGpiWBaxfWKepFYSqCj+KV3v
         Mf0KaODcmwO3Nf1lmCT/2nMj/9JajcVGiIvrKKP2wPLtPIfviHD5hYZO7QcNpGsEC5aV
         Tp1wlGoEbwtcw/kPLVYA5AhKng+zH2yy7X7LY5MaG+yefZ7KFYgL/K9AOLu/hnOJlLrV
         QAhArjavaZVPmgOvIla7jshbvjh3z9dmgfcULJIOnU05Y0pkx8hIb7/qToCoPRGk1NYF
         Ladmb40S1udpzC8uc2KD1Lo7GaXD+Px0igi6xznFR1edgZ7LbsgQv7FHZy+RYSkh7DKK
         lMTw==
X-Forwarded-Encrypted: i=1; AHgh+RoXJfR/RFlJXpCaLuHVyNeohaWykEvIEwOFRMHDxLWoTxW+sHL3rWJM62WwPxhqWbPeF8ezE/QBQ18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7r76edZaUCL4jBXrrdFJMoKktxdB7QMiBK1o1R0HvFLEv0P1A
	nxenmc1FXBTW6+UJn8Qbh/ks2jvRDEhazkg3bmh7A6uDcgHn+KM2Fo5KX86cG622AwimuZty+/s
	3keWwk3Fvo2RgZ5YTmGXyW1G4obasdweO+w==
X-Received: from pfbfe24.prod.google.com ([2002:a05:6a00:2f18:b0:847:87ec:2a9f])
 (user=mayankmishraa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:94ce:b0:848:6895:b763 with SMTP id d2e1a72fcca58-8486895c085mr776569b3a.40.1783602096747;
 Thu, 09 Jul 2026 06:01:36 -0700 (PDT)
Date: Thu,  9 Jul 2026 12:59:13 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709125914.1079328-1-mayankmishraa@google.com>
Subject: [PATCH] dmaengine: pl330: Fix NULL pointer dereference in tasklet
 during channel release
From: Mayank Mishra <mayankmishraa@google.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Jassi Brar <jassi.brar@samsung.com>, Dan Williams <djbw@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mayankmishraa@google.com, vamshigajjela@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12173-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mayankmishraa@google.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:jassi.brar@samsung.com,m:djbw@kernel.org,m:linusw@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mayankmishraa@google.com,m:vamshigajjela@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mayankmishraa@google.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69D5F73160B

When a DMA transfer aborts (e.g., due to a translation fault), the
interrupt handler stops the channel, schedules completion callbacks,
and marks the descriptors as DONE with an error status.

Subsequent channel release via pl330_free_chan_resources() clears the
hardware thread by calling pl330_release_channel(), which reschedules
the tasklet, and then sets pch->thread to NULL.

Because pl330_free_chan_resources() and pl330_tasklet() were not
synchronized on the setting of pch->thread (holding pl330->lock and
pch->lock respectively), a TOCTOU race condition occurred:

1. pl330_tasklet() verified that pch->thread was non-NULL.
2. pl330_free_chan_resources() concurrently set pch->thread to NULL.
3. pl330_tasklet() resumed and dereferenced pch->thread->dmac->lock,
   resulting in a kernel NULL pointer dereference at offset 0x10.

Resolve this by acquiring the channel lock pch->lock before the global
pl330->lock inside pl330_free_chan_resources() when setting the thread
pointer to NULL, enforcing the driver's existing locking hierarchy
(pch->lock -> pl330->lock). Additionally, add safety checks inside
pl330_tasklet() to verify that pch->thread is valid before dereferencing.

Fixes: b3040e40675e ("DMA: PL330: Add dma api driver")
Signed-off-by: Mayank Mishra <mayankmishraa@google.com>
---
 drivers/dma/pl330.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 25ba84b18704..acb9949f4a62 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2086,12 +2086,23 @@ static void pl330_tasklet(struct tasklet_struct *t)
 	fill_queue(pch);
 
 	if (list_empty(&pch->work_list)) {
-		spin_lock(&pch->thread->dmac->lock);
-		_stop(pch->thread);
-		spin_unlock(&pch->thread->dmac->lock);
-		power_down = true;
-		pch->active = false;
-	} else {
+		/*
+		 * Verify pch->thread is still valid before dereferencing
+		 * it, as it could be set to NULL asynchronously during
+		 * channel release after transfer aborts.
+		 */
+		if (pch->thread) {
+			spin_lock(&pch->thread->dmac->lock);
+			_stop(pch->thread);
+			spin_unlock(&pch->thread->dmac->lock);
+			power_down = true;
+			pch->active = false;
+		}
+	} else if (pch->thread) {
+		/*
+		 * Verify pch->thread is valid before starting it, ensuring
+		 * safe abort cleanups when channel resources are released.
+		 */
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
 		pl330_start_thread(pch->thread);
@@ -2109,7 +2120,8 @@ static void pl330_tasklet(struct tasklet_struct *t)
 		if (pch->cyclic) {
 			desc->status = PREP;
 			list_move_tail(&desc->node, &pch->work_list);
-			if (power_down) {
+			/* Verify thread validity before restarting cyclic channel */
+			if (power_down && pch->thread) {
 				pch->active = true;
 				spin_lock(&pch->thread->dmac->lock);
 				pl330_start_thread(pch->thread);
@@ -2357,7 +2369,14 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	tasklet_kill(&pch->task);
 
 	pm_runtime_get_sync(pch->dmac->ddma.dev);
-	spin_lock_irqsave(&pl330->lock, flags);
+	/*
+	 * Acquire pch->lock before pl330->lock to respect the locking hierarchy
+	 * (pch->lock -> pl330->lock) used inside the tasklet. This ensures
+	 * that setting pch->thread to NULL and checking it inside the tasklet
+	 * is fully synchronized, preventing TOCTOU race conditions.
+	 */
+	spin_lock_irqsave(&pch->lock, flags);
+	spin_lock(&pl330->lock);
 
 	pl330_release_channel(pch->thread);
 	pch->thread = NULL;
@@ -2365,7 +2384,8 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	if (pch->cyclic)
 		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
 
-	spin_unlock_irqrestore(&pl330->lock, flags);
+	spin_unlock(&pl330->lock);
+	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
 	pl330_unprep_slave_fifo(pch);
 }
-- 
2.55.0.795.g602f6c329a-goog


