Return-Path: <dmaengine+bounces-8770-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGA6NK2uhWkRFAQAu9opvQ
	(envelope-from <dmaengine+bounces-8770-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 10:04:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34328FBC96
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 10:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F773011BC3
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C1F352FA2;
	Fri,  6 Feb 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b="j/yR3Rmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pjku9ZbL"
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C24346AD3;
	Fri,  6 Feb 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368503; cv=none; b=GcprOp2jby9MPUukio5XTRCIavLsF6hxksmELraQ0lAQfDZ/YrtitNGDhqfN7jDaTey03z1HwicX9FsJ3ZZ/D615ypB3iz4gWUB5F5ZP57qGVjeKk8+waUZL1QjxFc/BZ8roAfGpucsjoaiM1LHGqVa7LFK6DqEVTnDk7NwN5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368503; c=relaxed/simple;
	bh=asJVk3oDuqmwmZ312NC0mB7ORGNHM32Qh/uEQ9O2u5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUQ7oaC3TnfbGn96wSn2IHWQEKyJdnPemVpx9GEfzpy+pvHkqy+9p/B+momVuQUIUnOhTwWhMKsaqI70VXXGIvCPjEtujK6/Gvf5tA1tVwFBDxrrszCzTQ1JKGMoMOFIsaCi8lPsPMeBnNTpEUZDtxP1uuCGy40TEX5biZCAP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io; spf=pass smtp.mailfrom=likewhatevs.io; dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b=j/yR3Rmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pjku9ZbL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=likewhatevs.io
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91C687A0021;
	Fri,  6 Feb 2026 04:01:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 06 Feb 2026 04:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=likewhatevs.io;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1770368501; x=1770454901; bh=e6Q5jFK43Z
	J1Twf/eEHkLZQeVBspSGKtpQIWC0nWZzI=; b=j/yR3RmcRCUQB3p3fOJmIVSMfN
	l+iXWCqX6UvNAyb5hQVBeGVVMwciZbgRFYQjcM7dgneTs6unJEsdVMvxVwUEIoGz
	Xyr59fxbOPg4HIgmA858d8ytVE0rSb2HlDdgYzvo2QNsogP5U7u2EgDEiDjvEO7n
	9gGOd0O3jd1yJp0v8/yVuhWO+L6MGcXElD33Ktbz5/x3LOyLLRj4MXKmqgtY7Dpn
	wWHtCOv287afDheS9TOyMmXPC8WYrL7+CXOfrx23Lm0gItc7J6K6pGoLVGSe0qeF
	YXDEWZhzLZO6sU+n23nU5PFpL8d7CJ9ym51Qu+Jgi8M8lknjCIkFKzam2kaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770368501; x=1770454901; bh=e6Q5jFK43ZJ1Twf/eEHkLZQeVBspSGKtpQI
	WC0nWZzI=; b=pjku9ZbLF9pgCVJ6NcW4j8i70bylRNpHUdSFQwiNkUOVzrvn9K0
	L1zfywn23i8jHdH37inaSX3nxMLpal7/jV8dj3eiO9T11cWk1C74K1z24dWiQENm
	dZfJcDNhbZv1GYTPkOcqy0cdaXyz368PshzBcLRg2ZUzYe+XByUu9iFRv7cDwMed
	emok0U6Vdcccmyn88WQHmwC/5gcZgIdoEFun0oPCLH/dP56bgM+0oVPaUIQbINGm
	xYWfe6ey5q9qFc2Bf4bu2phW5p09clR66mp8bkI/ENpwqF/Wp6t2yaqAOY2DJD8f
	ppNCH3057Xh80k0nkbkWOaG5g4BpnBg9I1A==
X-ME-Sender: <xms:9a2FaVp8IOx3GOl2FHnzwimgDZoVeQF4aVpIeO7SWcdtKNvqa0nlRw>
    <xme:9a2Faf3e9yqur2x4TbczquCjtx1LGTIfe-fzhh460zijE_Y6z7HILnfzylSdQOusa
    _LpN_toz0uBdVgVKCyeob37fmqCtUZOWq6svdJfaUgfvSyZUmfQtcQ>
X-ME-Received: <xmr:9a2FadwBmH5Dw7Y36mBRQn76cprdMKr1n70wyzx5GY7pwVEu7L7i-Zo0dPkZCZERMn3gA-U5OO1gIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheprfgrthcuufhomhgr
    rhhuuceophgrthhsoheslhhikhgvfihhrghtvghvshdrihhoqeenucggtffrrghtthgvrh
    hnpeefveeiveeijefgueettdejleelieefvddtkeekudduveetveeutdehffeiueehuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtsh
    hosehlihhkvgifhhgrthgvvhhsrdhiohdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtjheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsehjrghnnhgruhdrnhgv
    thdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    grlhesghhomhhprgdruggvvhdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9a2Fabj4rFlVceoykmXZ55DOWR_EXYQaBKOcAjsqhCH_khiu37X_2w>
    <xmx:9a2FaQp6CWeQ8J7QU6WwbaOLg1I12bP7CIeQypKc_qZ1MF4GwUjOaw>
    <xmx:9a2FaSjFyoYkl6vt8RKuIjEDRC5goa6Og3xPFASZKp1TAanN3Rbx7A>
    <xmx:9a2FaSP9ItJ-9B6L8-X36eynNjlYQo0ikQqXmvksV1Z6apEsPlO6UA>
    <xmx:9a2FaSK_1RCmuqsYENXBncnezyaQFNrmPH10evF_gX7DHebGJPyke9U->
Feedback-ID: i7f194913:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 04:01:40 -0500 (EST)
From: Pat Somaru <patso@likewhatevs.io>
To: Tejun Heo <tj@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Vinod Koul <vkoul@kernel.org>
Cc: Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pat Somaru <patso@likewhatevs.io>
Subject: [PATCH] dma: apple-admac: Convert from tasklet to BH workqueue
Date: Fri,  6 Feb 2026 04:01:37 -0500
Message-ID: <20260206090137.1127897-1-patso@likewhatevs.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[likewhatevs.io:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[likewhatevs.io:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8770-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[likewhatevs.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patso@likewhatevs.io,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,likewhatevs.io:email,likewhatevs.io:dkim,likewhatevs.io:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34328FBC96
X-Rspamd-Action: no action

The only generic interface to execute asynchronously in the BH context
is tasklet; however, it's marked deprecated and has some design flaws
such as the execution code accessing the tasklet item after the
execution is complete which can lead to subtle use-after-free in certain
usage scenarios and less-developed flush and cancel mechanisms.

To replace tasklets, BH workqueue support was recently added. A BH
workqueue behaves similarly to regular workqueues except that the queued
work items are executed in the BH context.

This patch converts drivers/dma/apple-admac.c from tasklet to BH
workqueue.

The Apple ADMAC driver uses a per-channel tasklet to invoke DMA
completion callbacks for cyclic transactions. This conversion maintains
the same execution semantics while using the modern BH workqueue
infrastructure.

This patch was tested by:
    - Building with allmodconfig: no new warnings (compared to v6.18)
    - Building with allyesconfig: no new warnings (compared to v6.18)
    - Booting defconfig kernel via vng and running `uname -a`:
    Linux virtme-ng 6.18.0-virtme #1 SMP PREEMPT_DYNAMIC 0 x86_64 GNU/Linux

Semantically, this is an equivalent conversion and there shouldn't be
any user-visible behavior changes. The BH workqueue implementation uses
the same softirq infrastructure, and performance-critical networking
conversions have shown no measurable performance impact.

Maintainers can apply this directly to the DMA subsystem tree or ack it
for the workqueue tree to carry.

Signed-off-by: Pat Somaru <patso@likewhatevs.io>
---
 drivers/dma/apple-admac.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index bd49f0374291..8a0e100d5aaf 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -16,6 +16,7 @@
 #include <linux/reset.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 #include "dmaengine.h"
 
@@ -89,7 +90,7 @@ struct admac_chan {
 	unsigned int no;
 	struct admac_data *host;
 	struct dma_chan chan;
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 
 	u32 carveout;
 
@@ -522,8 +523,8 @@ static int admac_terminate_all(struct dma_chan *chan)
 		adchan->current_tx = NULL;
 	}
 	/*
-	 * Descriptors can only be freed after the tasklet
-	 * has been killed (in admac_synchronize).
+	 * Descriptors can only be freed after the work
+	 * has been cancelled (in admac_synchronize).
 	 */
 	list_splice_tail_init(&adchan->submitted, &adchan->to_free);
 	list_splice_tail_init(&adchan->issued, &adchan->to_free);
@@ -543,7 +544,7 @@ static void admac_synchronize(struct dma_chan *chan)
 	list_splice_tail_init(&adchan->to_free, &head);
 	spin_unlock_irqrestore(&adchan->lock, flags);
 
-	tasklet_kill(&adchan->tasklet);
+	cancel_work_sync(&adchan->work);
 
 	list_for_each_entry_safe(adtx, _adtx, &head, node) {
 		list_del(&adtx->node);
@@ -662,7 +663,7 @@ static void admac_handle_status_desc_done(struct admac_data *ad, int channo)
 		tx->reclaimed_pos %= 2 * tx->buf_len;
 
 		admac_cyclic_write_desc(ad, channo, tx);
-		tasklet_schedule(&adchan->tasklet);
+		queue_work(system_bh_wq, &adchan->work);
 	}
 	spin_unlock_irqrestore(&adchan->lock, flags);
 }
@@ -712,9 +713,9 @@ static irqreturn_t admac_interrupt(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static void admac_chan_tasklet(struct tasklet_struct *t)
+static void admac_chan_work(struct work_struct *work)
 {
-	struct admac_chan *adchan = from_tasklet(adchan, t, tasklet);
+	struct admac_chan *adchan = from_work(adchan, work, work);
 	struct admac_tx *adtx;
 	struct dmaengine_desc_callback cb;
 	struct dmaengine_result tx_result;
@@ -886,7 +887,7 @@ static int admac_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&adchan->issued);
 		INIT_LIST_HEAD(&adchan->to_free);
 		list_add_tail(&adchan->chan.device_node, &dma->channels);
-		tasklet_setup(&adchan->tasklet, admac_chan_tasklet);
+		INIT_WORK(&adchan->work, admac_chan_work);
 	}
 
 	err = reset_control_reset(ad->rstc);
-- 
2.52.0


