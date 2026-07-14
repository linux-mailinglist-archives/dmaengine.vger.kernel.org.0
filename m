Return-Path: <dmaengine+bounces-12527-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6QXyLcLIVmqwBAEAu9opvQ
	(envelope-from <dmaengine+bounces-12527-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF557597B6
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ke/oBmRT";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12527-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12527-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B4B30FD0EF
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808A424D60;
	Tue, 14 Jul 2026 23:39:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A137268B
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 23:39:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072343; cv=none; b=fAvryf6q2ZpHavBY8WPqIObiGqM2dQgKkP0iX/b6umij8vnVx/nt9AX6Je04VNJwSFuLFs5jMJkf33cuN/DAMf1M2bvUfSEUMTsjHat0oJcnKcYd20JxGecPWnuW2NoE5Io/1gr1vL+8VXo3TW/0IjIaQs9V1bQiJ8TFApge9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072343; c=relaxed/simple;
	bh=wi/MMgULAybZVLtK8371fsJgjgFlbmj6qmhUZ12gmMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGTg82SrKuJdnDcfG/QVEHHUL7XKV07uKgekc0dFMUIJP4mHoHxA5dmdiRBPH/esUOPQ4ci12FTFsw57xfrn4hs+dZ/LTWOVGMC9TdsLfITjsXcBqj5KGAHI8Tzu7+6hqPW54LmOxHo4areQ/0cK+EMuVWqJOnrv+G73LSuetRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke/oBmRT; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1422542a91.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784072341; x=1784677141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1l02xGyRBTD067iKEsMBqmmqfaPsVp34wo3pg2+qQRU=;
        b=ke/oBmRTZjMSaREqpKL1WGCzz+GqXQ4mg2nRNkuzZ5qqYSUwMHJXPeDHPE4KcxdLUl
         /XAEyJoadkZcthC7UMu31ik/pP6RT1F76ybcTyD8NKriMipAbUTFhN/WKYBTzK/h2zRm
         XK2yCGWWaiHErgTercD+CUZlFse2nBe1zMax3E45mEn2JB9OXwuaTjkzvw2/0EFofYAb
         vGWMBwYA04htxljOqX07Jn16yq6QTb++oqxfxzGQKv7dK68WgzL7vbN/J19bJSlE8GBm
         kf3Awi+ioZqf2gscFgVyIwwzfEBCJbS59QsyNQM/v/ouUmtSV8hWXDV4anszOrFuPuNN
         3Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072341; x=1784677141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1l02xGyRBTD067iKEsMBqmmqfaPsVp34wo3pg2+qQRU=;
        b=FReWk0cafBttD1NXbNmXgfTbcZyVpERzuLW0P7C6kfVyKN2f7wtkf2fy/Z/9wTRgSC
         PHPT1hsboUj3iiXqsqfofgVUYwv7FNpioRl6wc1RWbj2Ay2JJgLxpai5Z4dKRKRWRR/7
         1CjhOHY5XCPuUIEH5j3BQMfKGmQcq3CDEIKkOWlI/VmneVDj9L9vGMJauPwZZa/LP0bT
         H7zD5GrFiP9EfYsejxyuq7Cb3p/08NjM9jbR9FAawun6+2APhsEPJnCXPHKtBhgZQsnz
         9rIR4EfS4ge5YPIKQc2RBGNP0SMSZ3qdYn6or522NQBLSOQDGBG3o8az9v4yR2Hs6ilt
         odzA==
X-Gm-Message-State: AOJu0YyD935k+KgrWx1aS3V+TtVroWwHxOU4KPHzBLlx4cBey2CWIOTV
	52P3jcW05sN1lLhzly81ndEtiYTGM0RmQiceqljmnNCo8paZ6+hx1GlWXqd8Gg==
X-Gm-Gg: AfdE7cm/Oz437dqMbIqXDFz2M9NMFMBN+YmNgFJh73FHb/TDhM8s1W7Edg5dzvezCi2
	PUWJS8tMKvj1OkL+ba6VaDVOcOQ7XAM0pMd+LthiKbb+tAsyj7+ri01q51DJ1xyIxJDqR442w5b
	5E0cV0RwTul00S1jKiyNLkQc0K83lF4CSKiwlnyvFmTaQxXnO/gIjWWQ4ulVj5P7z05aSCIZAJV
	hGt6WtBE7SqSyvmSXTFwUAhHDWix7DVkLWl3ChpYYAWmW2G8PBi5Ht9l+ONoElyMVorWfiV7zWc
	qTMvsHFxTZn32jyZdAe2jIw9suKGP9VCxUQAaPLi2bXMPa6ytEGPvktKTL6nDAO31T2hyMJfeyk
	ViJ6lwqg9rdTJeCc854ikBTHYmhut66/KkI9ltMwgo1QSMg1CHDy/UvLzzwMaSgYnOsTg9jsOuH
	GzOZG4KMSR+29idFndthZ6R4aVLRIS7yHgPgzpjJm16zXpeOpUPGSnYGqlhgutK5ZeE7823rbio
	Uk0y3HRSzkbqM0AIbGHuiy46z+yZpOC/NOs/b+oEMZxoxGKFZSOidyewpP70r/i6g==
X-Received: by 2002:a17:90b:5344:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-38dc74d5646mr14736298a91.16.1784072340901;
        Tue, 14 Jul 2026 16:39:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm72317509eec.20.2026.07.14.16.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:38:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] dma: fsl_raid: keep MMIO bases as void __iomem and cast at access
Date: Tue, 14 Jul 2026 16:38:54 -0700
Message-ID: <20260714233855.870797-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714233855.870797-1-rosenp@gmail.com>
References: <20260714233855.870797-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12527-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AF557597B6

The fsl_re_ctrl and fsl_re_chan_cfg structures describe memory-mapped
RAID Engine registers accessed only via ioread32be()/iowrite32be(), yet
the pointers to them (re_regs in struct fsl_re_drv_private, and jrregs
in struct fsl_re_chan) were not __iomem-qualified, so sparse emitted
"different address spaces" warnings for every register access.

Store both MMIO bases as a plain void __iomem * and derive jrregs with
void __iomem * arithmetic from re_regs, rather than carrying typed
register struct pointers through the driver. Each function that touches
the registers introduces a local typed pointer (struct fsl_re_ctrl
__iomem *ctrl / struct fsl_re_chan_cfg __iomem *jr) and uses ->field,
which is the idiomatic kernel pattern and keeps the registers' __iomem
qualification intact.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: https://lore.kernel.org/oe-kbuild-all/202008111749.yy85rFMD%25lkp@intel.com/
Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsl_raid.c | 66 ++++++++++++++++++++----------------------
 drivers/dma/fsl_raid.h |  4 +--
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 888f55b672a5..47ebdf274331 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -106,15 +106,17 @@ static dma_cookie_t fsl_re_tx_submit(struct dma_async_tx_descriptor *tx)
 static void fsl_re_issue_pending(struct dma_chan *chan)
 {
 	struct fsl_re_chan *re_chan;
+	struct fsl_re_chan_cfg __iomem *jr;
 	int avail;
 	struct fsl_re_desc *desc, *_desc;
 	unsigned long flags;
 
 	re_chan = container_of(chan, struct fsl_re_chan, chan);
+	jr = re_chan->jrregs;
 
 	spin_lock_irqsave(&re_chan->desc_lock, flags);
 	avail = FSL_RE_SLOT_AVAIL(
-		in_be32(&re_chan->jrregs->inbring_slot_avail));
+		in_be32(&jr->inbring_slot_avail));
 
 	list_for_each_entry_safe(desc, _desc, &re_chan->submit_q, node) {
 		if (!avail)
@@ -127,7 +129,7 @@ static void fsl_re_issue_pending(struct dma_chan *chan)
 
 		re_chan->inb_count = (re_chan->inb_count + 1) &
 						FSL_RE_RING_SIZE_MASK;
-		out_be32(&re_chan->jrregs->inbring_add_job, FSL_RE_ADD_JOB(1));
+		out_be32(&jr->inbring_add_job, FSL_RE_ADD_JOB(1));
 		avail--;
 	}
 	spin_unlock_irqrestore(&re_chan->desc_lock, flags);
@@ -158,6 +160,7 @@ static void fsl_re_cleanup_descs(struct fsl_re_chan *re_chan)
 static void fsl_re_dequeue(struct tasklet_struct *t)
 {
 	struct fsl_re_chan *re_chan = from_tasklet(re_chan, t, irqtask);
+	struct fsl_re_chan_cfg __iomem *jr = re_chan->jrregs;
 	struct fsl_re_desc *desc, *_desc;
 	struct fsl_re_hw_desc *hwdesc;
 	unsigned long flags;
@@ -167,7 +170,7 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
 	fsl_re_cleanup_descs(re_chan);
 
 	spin_lock_irqsave(&re_chan->desc_lock, flags);
-	count =	FSL_RE_SLOT_FULL(in_be32(&re_chan->jrregs->oubring_slot_full));
+	count =	FSL_RE_SLOT_FULL(in_be32(&jr->oubring_slot_full));
 	while (count--) {
 		found = 0;
 		hwdesc = &re_chan->oub_ring_virt_addr[re_chan->oub_count];
@@ -192,8 +195,7 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
 		oub_count = (re_chan->oub_count + 1) & FSL_RE_RING_SIZE_MASK;
 		re_chan->oub_count = oub_count;
 
-		out_be32(&re_chan->jrregs->oubring_job_rmvd,
-			 FSL_RE_RMVD_JOB(1));
+		out_be32(&jr->oubring_job_rmvd, FSL_RE_RMVD_JOB(1));
 	}
 	spin_unlock_irqrestore(&re_chan->desc_lock, flags);
 }
@@ -201,12 +203,12 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
 /* Per Job Ring interrupt handler */
 static irqreturn_t fsl_re_isr(int irq, void *data)
 {
-	struct fsl_re_chan *re_chan;
+	struct device *dev = data;
+	struct fsl_re_chan *re_chan = dev_get_drvdata(dev);
+	struct fsl_re_chan_cfg __iomem *jr = re_chan->jrregs;
 	u32 irqstate, status;
 
-	re_chan = dev_get_drvdata((struct device *)data);
-
-	irqstate = in_be32(&re_chan->jrregs->jr_interrupt_status);
+	irqstate = in_be32(&jr->jr_interrupt_status);
 	if (!irqstate)
 		return IRQ_NONE;
 
@@ -216,13 +218,13 @@ static irqreturn_t fsl_re_isr(int irq, void *data)
 	 * need to do something more than just crashing
 	 */
 	if (irqstate & FSL_RE_ERROR) {
-		status = in_be32(&re_chan->jrregs->jr_status);
+		status = in_be32(&jr->jr_status);
 		dev_err(re_chan->dev, "chan error irqstate: %x, status: %x\n",
 			irqstate, status);
 	}
 
 	/* Clear interrupt */
-	out_be32(&re_chan->jrregs->jr_interrupt_status, FSL_RE_CLR_INTR);
+	out_be32(&jr->jr_interrupt_status, FSL_RE_CLR_INTR);
 
 	tasklet_schedule(&re_chan->irqtask);
 
@@ -627,6 +629,7 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 	struct device *dev, *chandev;
 	struct fsl_re_drv_private *re_priv;
 	struct fsl_re_chan *chan;
+	struct fsl_re_chan_cfg __iomem *jr;
 	struct dma_device *dma_dev;
 	u32 ptr;
 	u32 status;
@@ -657,8 +660,8 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 		goto err_free;
 	}
 
-	chan->jrregs = (struct fsl_re_chan_cfg *)((u8 *)re_priv->re_regs +
-			off + ptr);
+	jr = re_priv->re_regs + off + ptr;
+	chan->jrregs = jr;
 
 	/* read irq property from dts */
 	chan->irq = irq_of_parse_and_map(np, 0);
@@ -709,30 +712,23 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 	}
 
 	/* Program the Inbound/Outbound ring base addresses and size */
-	out_be32(&chan->jrregs->inbring_base_h,
-		 chan->inb_phys_addr & FSL_RE_ADDR_BIT_MASK);
-	out_be32(&chan->jrregs->oubring_base_h,
-		 chan->oub_phys_addr & FSL_RE_ADDR_BIT_MASK);
-	out_be32(&chan->jrregs->inbring_base_l,
-		 chan->inb_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
-	out_be32(&chan->jrregs->oubring_base_l,
-		 chan->oub_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
-	out_be32(&chan->jrregs->inbring_size,
-		 FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
-	out_be32(&chan->jrregs->oubring_size,
-		 FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
+	out_be32(&jr->inbring_base_h, chan->inb_phys_addr & FSL_RE_ADDR_BIT_MASK);
+	out_be32(&jr->oubring_base_h, chan->oub_phys_addr & FSL_RE_ADDR_BIT_MASK);
+	out_be32(&jr->inbring_base_l, chan->inb_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
+	out_be32(&jr->oubring_base_l, chan->oub_phys_addr >> FSL_RE_ADDR_BIT_SHIFT);
+	out_be32(&jr->inbring_size, FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
+	out_be32(&jr->oubring_size, FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT);
 
 	/* Read LIODN value from u-boot */
-	status = in_be32(&chan->jrregs->jr_config_1) & FSL_RE_REG_LIODN_MASK;
+	status = in_be32(&jr->jr_config_1) & FSL_RE_REG_LIODN_MASK;
 
 	/* Program the CFG reg */
-	out_be32(&chan->jrregs->jr_config_1,
-		 FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status);
+	out_be32(&jr->jr_config_1, FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status);
 
 	dev_set_drvdata(chandev, chan);
 
 	/* Enable RE/CHAN */
-	out_be32(&chan->jrregs->jr_command, FSL_RE_ENABLE);
+	out_be32(&jr->jr_command, FSL_RE_ENABLE);
 
 	return 0;
 
@@ -752,6 +748,7 @@ static int fsl_re_probe(struct platform_device *ofdev)
 	u8 ridx = 0;
 	struct dma_device *dma_dev;
 	struct resource *res;
+	struct fsl_re_ctrl __iomem *re_regs;
 	int rc;
 	struct device *dev = &ofdev->dev;
 
@@ -767,17 +764,18 @@ static int fsl_re_probe(struct platform_device *ofdev)
 	re_priv->re_regs = devm_ioremap(dev, res->start, resource_size(res));
 	if (!re_priv->re_regs)
 		return -EBUSY;
+	re_regs = re_priv->re_regs;
 
 	/* Program the RE mode */
-	out_be32(&re_priv->re_regs->global_config, FSL_RE_NON_DPAA_MODE);
+	out_be32(&re_regs->global_config, FSL_RE_NON_DPAA_MODE);
 
 	/* Program Galois Field polynomial */
-	out_be32(&re_priv->re_regs->galois_field_config, FSL_RE_GFM_POLY);
+	out_be32(&re_regs->galois_field_config, FSL_RE_GFM_POLY);
 
 	dev_info(dev, "version %x, mode %x, gfp %x\n",
-		 in_be32(&re_priv->re_regs->re_version_id),
-		 in_be32(&re_priv->re_regs->global_config),
-		 in_be32(&re_priv->re_regs->galois_field_config));
+		 in_be32(&re_regs->re_version_id),
+		 in_be32(&re_regs->global_config),
+		 in_be32(&re_regs->galois_field_config));
 
 	dma_dev = &re_priv->dma_dev;
 	dma_dev->dev = dev;
diff --git a/drivers/dma/fsl_raid.h b/drivers/dma/fsl_raid.h
index 69d743c04973..6069615e2e1e 100644
--- a/drivers/dma/fsl_raid.h
+++ b/drivers/dma/fsl_raid.h
@@ -256,7 +256,7 @@ struct fsl_re_hw_desc {
 struct fsl_re_drv_private {
 	u8 total_chans;
 	struct dma_device dma_dev;
-	struct fsl_re_ctrl *re_regs;
+	void __iomem *re_regs;
 	struct fsl_re_chan *re_jrs[FSL_RE_MAX_CHANS];
 	struct dma_pool *cf_desc_pool;
 	struct dma_pool *hw_desc_pool;
@@ -273,7 +273,7 @@ struct fsl_re_chan {
 	struct device *dev;
 	struct fsl_re_drv_private *re_dev;
 	struct dma_chan chan;
-	struct fsl_re_chan_cfg *jrregs;
+	void __iomem *jrregs;
 	int irq;
 	struct tasklet_struct irqtask;
 	u32 alloc_count;
-- 
2.55.0


