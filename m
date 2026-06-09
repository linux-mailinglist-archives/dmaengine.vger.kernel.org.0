Return-Path: <dmaengine+bounces-11360-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VBe1HvGRKGqSGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11360-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:21:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD64664884
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:21:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YvYP+sOm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11360-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11360-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A614F3078340
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E5361DD0;
	Tue,  9 Jun 2026 22:19:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C6374A1D
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:19:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043592; cv=none; b=T89o/bVgbk34icNoeisGOrhxTDilgL10s1cGoq8tHfsW2vpw/iOgL015TwFaF3nOxVGKVJV/hwO44Z2Vy/3ms+P1cH5jhrvj2NaKAv52ikoeRJzgq989P67W9Cghp1xVqEo6Viu4kOPvl8J2D/HwsNPd7ug7PaiNYXdRFcxlCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043592; c=relaxed/simple;
	bh=RWGgQ+fIx5zEE7hIr/SdyaUnQQt8wM2jyEcHAPXGR1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naHViGyXKnk1IqU1iSpsHQSj0fkrXD1OrRzuHnPAYlvhV4px9AY5dQrN64IxsFkPLkpFqIPrU5N0pAavAzd2HMUJXQdKFezvgeIq5lZ+QA0B1By3aTQvU2ztkyInVRaWVTuuXHECvkeh7NaghtbSvBTo9D5SEELVZJggOwsXgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvYP+sOm; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so3589616a12.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043590; x=1781648390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=YvYP+sOm52HfucXlQuhMXOMTH526TtppmmlAGLg0wmwFjWslZU2l3lKJBFEVV8TToh
         d5NxotlEM3bAb2oTRITRpzin8LTKbcQb67JIgXpPLgsQA3kcP+nYMjsf9Gtm/XJ8Uv8w
         klTVjrCPe0pSngThzYarGkPO0I+5Xw0jaRr1x70nynsOns9IboFmW87ftLeYF4AVYZaT
         IEw573ntPLu9TRVq3zzpI5gJEp1h6ZsN5TDpGuBLlIvGyXJ7R65g7LoXi498zRWVdlTH
         NRiBQ4ZMNeRTntzfp0aE/GLTeAxtMjbZxve+D8KLVjkd5+4WPsvipvGwYzCFZKbEcCuG
         Sc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043590; x=1781648390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twBxGuT7Vyeqc2tSt+1Cu5dVnnD709Tu79Udll0+igY=;
        b=rMXZ6ndHCHFb41RzX4H9vfdVtpG+9+MiDnsCkeCfgDgJMbep/+3Ju3uowsXCkJzqEw
         AHPbvGEODYZrKSam5/NZJh4m0A0gdSZr67hypKtMxqFFZJMg9WPSVKg+UwTjy73vT6au
         +96FVzN3sMwGyc1i3e58FqP3Dx2wgLZ+CaZfUB2OXxeBCsjb2bWbYeha9ycuKEBON/d5
         k1bdsQonQktTFTpxcS4sjAJJXtt+XLheKUQ7PJstjEx1I9DAjPbHCEz1J2A8icKd7L6Y
         AoJzw2giy8p4vEjlbm0mb9GUOWkKriLPF4UbiFqMH9oNve4/MtrvjtueIpZ66sttxw92
         OSFw==
X-Gm-Message-State: AOJu0Yw78TL4z2zqK7282oPSoF5jGzyRQDPPnW8BiN6dCtlVgbZCf9rd
	HPPPfUdeZdTjrmAnxsL92yYTOCSEz93XeJYPNtp8JpLO6DEPqBmram6dZuZ4n4tl
X-Gm-Gg: Acq92OHfkG++hCI3gf31DD3IIdDKduIShQK39U79oqR/qmAElEZB6ZFGDmFhBE7qygj
	sS6d0NS6Y7uxnQHsEHvQU4wcSzrRNAUygZY4p9K7ViGc110pCxqhQDYpEnzucvIZCepnLyc4j1T
	7ZCQiZGDavzAa9fTFGi1qnQCru8ZoMxxAmOsKRFFCLbpErtwFL9I2d8gXaGKqTmcF7lSZ/E+WPe
	l6IRR/xdpjk7X44SxAU2NvI1hHkUdvSvT0ugvlWvXPgf1Q3fxCIFjE54BbqbWbuvk2nopRbb493
	OHaaSgBC51d0iTjM7UEB9Ukq+WmnnzBgCvyh5OWi3tbs6MtWtNQk/k4+w37UtJ1azO+0U4TBNcC
	B0yzXc5I7Do4P+ORNfETsFwH/Pf1sShmaPAP4XbfZq4Udru9RgZubEmCFeeCJeZkGv3WcKsVUC4
	oZSVYd7leAlf8FAs69DfPNdfoc1LfeT1/xc8OTpe1MY+lDcTHy0Sz3a7tQTnfjE0PuTHU4oDlNK
	+q4wa/hiFCjdc6c3R3J3Utd2GnwUiV3QFCd6EP3rvh+lw==
X-Received: by 2002:a05:6a20:1609:b0:39f:3ca8:a33b with SMTP id adf61e73a8af0-3b4ccd764e8mr27610402637.17.1781043590415;
        Tue, 09 Jun 2026 15:19:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:49 -0700 (PDT)
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
Subject: [PATCHv3 02/15] dmaengine: fsldma: drop desc_lock before invoking client callback
Date: Tue,  9 Jun 2026 15:19:13 -0700
Message-ID: <20260609221926.35538-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609221926.35538-1-rosenp@gmail.com>
References: <20260609221926.35538-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11360-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: CFD64664884

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


