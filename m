Return-Path: <dmaengine+bounces-11415-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hOV1JFwxKmp3jwMAu9opvQ
	(envelope-from <dmaengine+bounces-11415-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:54:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E811066E0ED
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="JgF/g1dl";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11415-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11415-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E16311A1AB
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401933321B1;
	Thu, 11 Jun 2026 03:53:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED353358B0
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149989; cv=none; b=QYqrAM66CHZbuUwrqNRStnwkW/WtYYS7QRV6hYOkuHeOpo/1GFFB6urlES3xKt3EmDf5U5eIcVMgigh0zPCmofS8CR03MoSr3XjBC54OoBJOQgsQWOIv3cJTKoQUDUVRFLSi0BE2CZ6Kw8vlzE8d6tjBwIcmFGFrcYb3Sm5YTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149989; c=relaxed/simple;
	bh=RWGgQ+fIx5zEE7hIr/SdyaUnQQt8wM2jyEcHAPXGR1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1aL/cFlAVrSlrdIxq2Zz2vye8hmX4YIDhU4qGy/m7zgS4Rk7eLx+Vr+keb2WtkC0PMzAGPNF6GlztbuLaZhiFC8SxU9ur91ZJt5mIwBfcbicBY7GIfrNprdi/tS0ggyYtOBJqFpXEnBEmW1NYDtmeoHwbPihWfSdI0wR8HbDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgF/g1dl; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-372b4330deeso3074379a91.0
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149987; x=1781754787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=JgF/g1dlR9yUXz5jMKZsKEYcnMC5+68CN3eLima2V0DYhYaINM1Zt8R8lwCRYnBwbe
         WjV2QtGy5wLuU6t3hu+tgoOmxlRWgj5C0hfhQ77XGvOIwm143HRAGTDbvOAp3opSZ7XW
         V5IHwvxNIzbaBRyft733gnZvA+Vjw4tzP8HlwZlR0sqyblbT0BeutQSNSgcUKmyUo0Yi
         FVsJQGQvqsQh5vqFWzhsC5IB0malOQ02002vk3HLzPhY8ZBbKAKRdapruJrJYlkm8gL0
         iq+nRhH5bpvsofiFf8aCHb1MLmcjN4pnekudhCwby48iDN3v8iN52WYk1pcHOviXdRJw
         FB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149987; x=1781754787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=INY8rQ/XHa6hs38DsJ/D2RcWeNdjfooMmqwUD7k0yBT0cKwnFfBzIc7y3PxOKOxYLp
         BGFV+svNA5A7atWwCi/WolxcPgD55cJ4Y42rDvfRhtpAFui2Ax/5ei9Hxnzi7BBOLGUh
         CNjZp8ALFx7GTvgX9h8xublDmm9jVz2h5/eiiE7HVLePU3ulQv5t6wFxpE0AAopJzk2l
         +lO40DtCOJtRbVYNR8j2mir79W9a4HIw+LU1MYlCLXpPUoh8Zb7naHKa3NdTXzaz99c1
         e2jBbgg5zVmP1svKsepmFSRzbHAuUkuDRic18Ktcq0LKYzgBmDABfRGW06z9KTdmxZRn
         l+ig==
X-Gm-Message-State: AOJu0Yys+ceoyyAt3bUAxyI3j5WjQUYe8gKap9YVDKWqq65LE2wBSfrS
	deBZm25eyTOni2OYnjKS470Jc4A3h8+Ukw01vOl67OaKGQEcfuGyTDpq6l5ypw==
X-Gm-Gg: Acq92OEu/MmpWkrrIoLPs6dOjxZlMFIPvHXqyUwi0/XpXCM0N4/7AQFP3KXWNfSjLNK
	DxuN9YPJPfluobuYqPb8t6/xugDf7B8hjNWsA6WrlbBFeofLZ4gCGiw4P0DXfm+B1zjVM1N7hw2
	uSP5ab6luhi7ZXOZlKoOeg0m2BiOq75kYSCr2wuNDNA51tPG0MccHrfqf6SK3sxKrfFWh+gOSFq
	b5zAlFR5j1CpSczkdhzp0E/l5ltGWZGuS2CIgqEfDyHevBMRVZ1nddY/OzuCO7RMgDmBUojuMXJ
	bCU0ojriJt4bkZjEAakwA1vSfxOD1pocBETzOidz5egLhbshcoszWTnJPwDo+f+dhzzOEmPtcz0
	+NamheNqiPWSZmiR7dbv2KW5PcbEvqOh+KFu5WAfTgioORh1aLoF1H4cgGoZf3LJPaNUSu7VIIl
	bAT+CXf4b3iV+Xh+eaOuCaHfYZZvyuBWX3zqkHh5JxsItH3Jrm4MBp9RYE5n0K1v/+WDlEdEDUI
	AZGK5p0IIZmqn4sLkbEfaL0CzB4BMrn/flJ90Q/gsNNkQ==
X-Received: by 2002:a17:90b:4984:b0:36c:e254:4d5 with SMTP id 98e67ed59e1d1-3779c569455mr1233425a91.4.1781149987152;
        Wed, 10 Jun 2026 20:53:07 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv4 02/15] dmaengine: fsldma: drop desc_lock before invoking client callback
Date: Wed, 10 Jun 2026 20:52:32 -0700
Message-ID: <20260611035245.13439-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611035245.13439-1-rosenp@gmail.com>
References: <20260611035245.13439-1-rosenp@gmail.com>
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
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11415-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E811066E0ED

fsldma_run_tx_complete_actions() calls dmaengine_desc_get_callback_invoke()
while still holding chan->desc_lock.  If the client submits a new
transaction from their completion callback, fsl_dma_tx_submit()
tries to acquire the same non-recursive spinlock, causing a
self-deadlock.

Fix by extracting the callback info under the lock, removing the
descriptor from ld_running, dropping the lock, then invoking the
callback and running dependencies outside the lock.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 108 ++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 0e2f84862261..455d21d738de 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -496,16 +496,19 @@ static void fsldma_clean_completed_descriptor(struct fsldma_chan *chan)
 }
 
 /**
- * fsldma_run_tx_complete_actions - cleanup a single link descriptor
+ * fsldma_run_tx_complete_actions - unmap and extract callback from a descriptor
  * @chan: Freescale DMA channel
- * @desc: descriptor to cleanup and free
+ * @desc: descriptor to process
  * @cookie: Freescale DMA transaction identifier
+ * @cb: returned callback information
  *
- * This function is used on a descriptor which has been executed by the DMA
- * controller. It will run any callbacks, submit any dependencies.
+ * Unmap the descriptor if it has been submitted and extract its callback
+ * into @cb.  The caller must invoke the callback and run dependencies
+ * after releasing chan->desc_lock.
  */
 static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
-		struct fsl_desc_sw *desc, dma_cookie_t cookie)
+		struct fsl_desc_sw *desc, dma_cookie_t cookie,
+		struct dmaengine_desc_callback *cb)
 {
 	struct dma_async_tx_descriptor *txd = &desc->async_tx;
 	dma_cookie_t ret = cookie;
@@ -514,49 +517,14 @@ static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
 
 	if (txd->cookie > 0) {
 		ret = txd->cookie;
-
 		dma_descriptor_unmap(txd);
-		/* Run the link descriptor callback function */
-		dmaengine_desc_get_callback_invoke(txd, NULL);
 	}
 
-	/* Run any dependencies */
-	dma_run_dependencies(txd);
+	dmaengine_desc_get_callback(txd, cb);
 
 	return ret;
 }
 
-/**
- * fsldma_clean_running_descriptor - move the completed descriptor from
- * ld_running to ld_completed
- * @chan: Freescale DMA channel
- * @desc: the descriptor which is completed
- *
- * Free the descriptor directly if acked by async_tx api, or move it to
- * queue ld_completed.
- */
-static void fsldma_clean_running_descriptor(struct fsldma_chan *chan,
-		struct fsl_desc_sw *desc)
-{
-	/* Remove from the list of transactions */
-	list_del(&desc->node);
-
-	/*
-	 * the client is allowed to attach dependent operations
-	 * until 'ack' is set
-	 */
-	if (!async_tx_test_ack(&desc->async_tx)) {
-		/*
-		 * Move this descriptor to the list of descriptors which is
-		 * completed, but still awaiting the 'ack' bit to be set.
-		 */
-		list_add_tail(&desc->node, &chan->ld_completed);
-		return;
-	}
-
-	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
-}
-
 /**
  * fsl_chan_xfer_ld_queue - transfer any pending transactions
  * @chan : Freescale DMA channel
@@ -635,22 +603,23 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
  */
 static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 {
-	struct fsl_desc_sw *desc, *_desc;
+	struct fsl_desc_sw *desc;
 	dma_cookie_t cookie = 0;
 	dma_addr_t curr_phys = get_cdar(chan);
 	int seen_current = 0;
 
 	fsldma_clean_completed_descriptor(chan);
 
-	/* Run the callback for each descriptor, in order */
-	list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
-		/*
-		 * do not advance past the current descriptor loaded into the
-		 * hardware channel, subsequent descriptors are either in
-		 * process or have not been submitted
-		 */
-		if (seen_current)
-			break;
+	/*
+	 * Take descriptors one at a time from the front of the running
+	 * queue.  We re-read the list each iteration so that we don't
+	 * chase a stale next pointer across the lock-drop below.
+	 */
+	while (!seen_current && !list_empty(&chan->ld_running)) {
+		struct dmaengine_desc_callback cb;
+
+		desc = list_first_entry(&chan->ld_running,
+					struct fsl_desc_sw, node);
 
 		/*
 		 * stop the search if we reach the current descriptor and the
@@ -662,9 +631,42 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
 				break;
 		}
 
-		cookie = fsldma_run_tx_complete_actions(chan, desc, cookie);
+		cookie = fsldma_run_tx_complete_actions(chan, desc, cookie, &cb);
 
-		fsldma_clean_running_descriptor(chan, desc);
+		/*
+		 * Remove from the running list before dropping the lock so
+		 * that terminate_all cannot free this descriptor while we
+		 * call into the client below.
+		 */
+		list_del(&desc->node);
+
+		/*
+		 * Prevent dma_run_dependencies() from calling
+		 * fsl_chan_xfer_ld_queue() while we are not holding the
+		 * lock.  That would splice pending descriptors into
+		 * ld_running before they have been completed by hardware.
+		 * fsl_chan_xfer_ld_queue at the end of this function will
+		 * re-evaluate the situation.
+		 */
+		chan->idle = false;
+
+		/*
+		 * Drop the lock before invoking the client callback, since
+		 * the DMAengine API explicitly allows clients to submit new
+		 * transactions from their completion callback.  Otherwise
+		 * we self-deadlock on chan->desc_lock.
+		 */
+		spin_unlock(&chan->desc_lock);
+		dmaengine_desc_callback_invoke(&cb, NULL);
+		dma_run_dependencies(&desc->async_tx);
+		spin_lock(&chan->desc_lock);
+
+		chan->idle = true;
+
+		if (!async_tx_test_ack(&desc->async_tx))
+			list_add_tail(&desc->node, &chan->ld_completed);
+		else
+			dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
 	}
 
 	/*
-- 
2.54.0


