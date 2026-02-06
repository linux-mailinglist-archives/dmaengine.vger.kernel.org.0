Return-Path: <dmaengine+bounces-8811-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMbCCkhnhmmAMwQAu9opvQ
	(envelope-from <dmaengine+bounces-8811-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 23:12:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AC103AC9
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 23:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B73B3020EFD
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387530ACE3;
	Fri,  6 Feb 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b="XeSX3y5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fm+4d4qh"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C030497C;
	Fri,  6 Feb 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770415938; cv=none; b=LzzOHwAbb0302PlavqvKnWoB0lbX2Nnkl/+QvQSKAka8Wgl8gv1GF2MNhYGomhO2whzSMrbCdxqSVEdfHt/iWx3VFwQkIgnt1uPlXkZw+tdfaSh30apad1Z9sq482ABLNbSik6i+lXOhkIHkGnDYKaGWRsqdgZ+nx6CnbZUyKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770415938; c=relaxed/simple;
	bh=NhBTIoUFO3jPR/nChJXtmHx5jc1jcGiEH9jTLs13ilo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0VLh3tZWvY2zGVMeSEhWQGRaSJBgSfjh3ftUkBGLul1u/BWUFWIKpVcSGeisRtZ6hJwD+ieLrnxMPXqb+2sHqEeeBAVbzi3Engf+G5HvZxMZPqhp36l0JQKm7NlgOffEPUxOJLhaPLplVxDR4lQNlqrIwzfYUue5LyjO9O2Sxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io; spf=pass smtp.mailfrom=likewhatevs.io; dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b=XeSX3y5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fm+4d4qh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=likewhatevs.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 49FB71D00011;
	Fri,  6 Feb 2026 17:12:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 17:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=likewhatevs.io;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1770415937; x=1770502337; bh=7gD00ofvgd
	E2X5UA+AH8QBhGtuM17gN4fure9pmx0xo=; b=XeSX3y5WNjP3YOv/mH/kzEMF8j
	KsSP5hRz5psK/lWHyHwwdGIzye0Q60sfPUn7oSG/alqgJ+tQOVqhOH4mEPx+zuru
	MiaCd11l9SoMyViTMD9r9L/UIclVWcvfvKzRFixUkHYrwsAqSchwYeBSj7TbVsUf
	uRSU2hkWNbvgjVtuF/TVnONcb+PCj5bO75Y5pPu1MJ4vrWPqjzj1/H9wKvb2di/g
	Lb0cYXtVSqCm6w7diCJ2GB14GMI+sOAHJEHn7uM7aiBP+c+DC3I0oUkuyA53mN4I
	yQGr6OyMfg5i7TtcE/A0bvrcTcKNwc0h23tTb8oAOi1Is9jAxNwhUwjgK3uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770415937; x=1770502337; bh=7gD00ofvgdE2X5UA+AH8QBhGtuM17gN4fur
	e9pmx0xo=; b=fm+4d4qhBAR0zgb4evNXydaGTby/BHkfsRsQnZvZ/KG8/WXEADc
	vT0MQvgdHOsspvf/MBh1DsiQw39MvSVHGcet+xX0UZShUah1kqBngnmC+9ZPNngD
	YkvVLPgLRbvs1EjpasFzjyN2FkP7uDtKh9R2y+iUe8i0eto8Xycop0NVtF+Nna7s
	Df6uMgaOR4O7tAmQUVkVfYPlJLlAcs0NiRw14hd1XuVsJ4kAAIEVlDTYoEIL+TeO
	E4tETnsoDxDss5gZjnGOFp+O2Za78xIBKrK3y1reIoYUfEW4omKkRrA+6m3MV3m0
	e1PtvR5mZhIZGIaYPkwJVcHv8jEb+Vj/yrg==
X-ME-Sender: <xms:QGeGaT3AKB2-9_5-U0KsBLA5wy4z2RusDVexFKt5WRvqTkbyWJQXJA>
    <xme:QGeGad4SfuIlx36RvVJw1Mq-WuZeDLFs01Y3kZJThAOvJDkyD4x7e4UtTKhqdZEBU
    S26Yi6bpJ1FxgOXJq0_-_MDVobDvOvJAY8aytvrj1_zEvnGiOtavF5Z>
X-ME-Received: <xmr:QGeGafS1mmUG_7sTYzDJ6h32j56YI3ksP1q4LTWgTVwZz3hjDdBzuOYOHSGthHN99NQDdGvWFIztmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheprfgrthcuufhomhgr
    rhhuuceophgrthhsoheslhhikhgvfihhrghtvghvshdrihhoqeenucggtffrrghtthgvrh
    hnpeefveeiveeijefgueettdejleelieefvddtkeekudduveetveeutdehffeiueehuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtsh
    hosehlihhkvgifhhgrthgvvhhsrdhiohdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtjheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsehjrghnnhgruhdrnhgv
    thdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    grlhesghhomhhprgdruggvvhdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QGeGaSXu9skGpcL3m21MSqLgcIhyVOW5ttPMjCBkiaNvpfezD5aw1w>
    <xmx:QGeGaUE6v74vlcakoq93tPWKfFuKpxlfxH2SjqvIzy23lx_f_Hce9w>
    <xmx:QGeGaVcFrUI-ubSg4bjiAxMRuRLswXmyNLPBh5Eeof9V_aWb2ETRSg>
    <xmx:QGeGadp9RP7UPI6l7NmlWKiIawf4rqwy-9wNWsccQ8fdJTFFTVqSkw>
    <xmx:QWeGae3l4YhOJLx8Q6S6lkzGMFcgNDs6vLdVdk6HUahF-67o_3crtjm5>
Feedback-ID: i7f194913:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 17:12:16 -0500 (EST)
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
	Pat Somaru <patso@likewhatevs.io>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] dma: apple-admac: Convert from tasklet to BH workqueue
Date: Fri,  6 Feb 2026 17:11:43 -0500
Message-ID: <20260206221143.1261191-1-patso@likewhatevs.io>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[likewhatevs.io:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[likewhatevs.io:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8811-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[likewhatevs.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patso@likewhatevs.io,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,likewhatevs.io:email,likewhatevs.io:dkim,likewhatevs.io:mid]
X-Rspamd-Queue-Id: 7A8AC103AC9
X-Rspamd-Action: no action

The only generic interface to execute asynchronously in the BH context
is tasklet; however, it's marked deprecated and has some design flaws
such as the execution code accessing the tasklet item after the
execution is complete which can lead to subtle use-after-free in certain
usage scenarios and less-developed flush and cancel mechanisms.

To replace tasklets, BH workqueue support was recently added. A BH
workqueue behaves similarly to regular workqueues except that the queued
work items are executed in the BH context.

Convert apple-admac.c from tasklet to BH workqueue

Semantically, this is an equivalent conversion and there shouldn't be
any user-visible behavior changes. The BH workqueue implementation uses
the same softirq infrastructure, and performance-critical networking
conversions have shown no measurable performance impact.

Signed-off-by: Pat Somaru <patso@likewhatevs.io>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 v2: Updated commit message

 The Apple ADMAC driver uses a per-channel tasklet to invoke DMA
 completion callbacks for cyclic transactions. This conversion maintains
 the same execution semantics while using the modern BH workqueue
 infrastructure.

 This patch was tested by:
    - Building with allmodconfig: no new warnings (compared to v6.18)
    - Building with allyesconfig: no new warnings (compared to v6.18)
    - Booting defconfig kernel via vng and running `uname -a`:
    Linux virtme-ng 6.18.0-virtme #1 SMP PREEMPT_DYNAMIC 0 x86_64 GNU/Linux

 Maintainers can apply this directly to the DMA subsystem tree or ack it
 for the workqueue tree to carry.

 Thanks for letting me know about talk to maintainer section, Frank!

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


