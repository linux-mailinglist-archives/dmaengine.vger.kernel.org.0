Return-Path: <dmaengine+bounces-11284-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3IEUEohUJmrCUwIAu9opvQ
	(envelope-from <dmaengine+bounces-11284-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:35:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E805652D5D
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:35:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HHCM57di;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11284-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11284-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2699B300A12F
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 05:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905522F8E9C;
	Mon,  8 Jun 2026 05:35:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB7223DE9
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 05:34:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896901; cv=none; b=hWRUBTTmecZlGQX34eLYdckU1fI6XAxZKoE1wsklqBt50ErK62LKB+QXgz+JuLNViVh9t2CHpnjyji/nd+qLhJbgl25z3pgoeuWmv/wh6dUKL3x/qLU6zM0yRLUgHPHdo/G6iySu6ggzdVs9fxH2/936a7WEfFjfSVxWio3NgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896901; c=relaxed/simple;
	bh=E9EXltGUPi7GInM/HKRa+EDpEO3ZORGTmisE12T+vUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKu4KT1g4EZvPFf/DjgZJdFohmR6ZAIk0R8FTVDphcvGJZ+rAtLogOkuWOkMocmvt1CSHsyhrEXLAXlajZFXg8U3txRmlvvdSvL5YFM5/r+XAFbbbFv5WS+eiyOYzzcc18E524bl94Qcuhk2E9mQzgcM7+f4X8szcLkp5JN7tEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHCM57di; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf30d530bdso40007905ad.3
        for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780896899; x=1781501699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=luDPs6eWrPS3k4LIbRTsPyLHqymYxByZ21lv9Pt3/l4=;
        b=HHCM57diZswtNSOu/hlnYptbqBzgQDFAVW7nV8TKazZ9SOCz7kPY8IuVzhKuSZej9C
         cq8ilsGvtV3EY4JyvmjJjjvta8PZevZPxsmDdtvntVMHefrfEsLDwRGskiunBYOiyaf6
         WxjJ4Mi7+8dzJakIqIMwaHOZ8erDwy1HZsB4+/MiOWyw8lvzo0GacBk9qWNVG5rtHG/K
         Ac/8rct41wdRnMOzcOcRzhOdV32gyEycFL8S5RJRQfORwxmqcPEftMrz42Qa5ciyvssu
         ++NXGaTSrMBUSZbBqTaedgGkp5DDcYK09DVFO2Wk8NGqwoawCmN7JlhFS4V+Q6uOLju8
         Iaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780896899; x=1781501699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luDPs6eWrPS3k4LIbRTsPyLHqymYxByZ21lv9Pt3/l4=;
        b=DB1b01HOrUY7fVi4LDLUoeQt+UMS6mJ/qWiPfr3tRZY1ffuqCKJ6BankCTkBH+Dg6t
         xoZkYqfrTIWvgxZtxslOgSD2P4Yo8/3qkM9zaNDdwrNDW8oWcGW8lv08k/T8dlNFeMSd
         J9gZj7B0MFPeVrg9tgwFY409VdGFZF+uBWwUdJxxvtR2ugP3+GWLVxrmEzGqSXRlRFnB
         1LRf9lOQc2BpO1gynAWRKe/tJQMeiuVWM7gitlin5rkT+6nPKh20naY5jyMM5oU7ha77
         1h18qSu/dW+1+Mzd7PwdPm6VNRJQ2isOr5H8c2nCWzn22xbYF7L/h2mbiZlNuaA6Dsf+
         ju/Q==
X-Gm-Message-State: AOJu0YwsXmGA9V5mvFOb66llxiq8tfQLHTAi8BYcUv4/DA9X9LdMbMmZ
	EcnfrsMpovFLHPpH3Y2G89cTbSVSqRlOGXdP45jga+QJt1c9+xBOTcm32q6yWfhd
X-Gm-Gg: Acq92OEjebvRQT4kbhR0BZT+BUzqnIdYdPtlSfKs2YbwYlia8I07UFrmyfqzg3B8DNJ
	dcc5/7Y+fAXycaccPzk7a7R12ObdM20PduVNZbZJX9JCeBfiGXApiIvdT1Din6bIzkOAFt9c+rh
	6YjRo7o1OId7Daawar5XBRD5kDt40EJ9OzdRfK4T15Huk9CB+MfnyZqkPPzv5CjrFgY9wlETy+h
	T2R9rQFE4jiWjZ9HvPE/vSv46rE7DBvsCjXm9nrfv49bCa10rqpHAp0n7D32O82XBcCPkrMs4JA
	zMDwzUkI1JqYAQWCt1ktRUZ05BBVuYxMYygd630CRabgLZNSukHeuua1d5s9BHeMu/liahJWzQE
	5iGz9vxzQt9F8uoq0KlZ6d9Syh9pB2IllzfnMJhSeTt8ucP3KUWv6kZhVLbjqMc7xGQ09Xv0pzk
	ZzDMI2gB0ZCxDbKywSIXMU0BL11cZENTwXPzb3Y94wKhpzYz2+TnUorIcE1jZNlyEjUL1UPIVZS
	0slyXlQifaCKDTjB7XyBo817Dn0q72xJHbfq83sP61rWA==
X-Received: by 2002:a17:903:1a06:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2c1e7e866dcmr162901985ad.15.1780896899497;
        Sun, 07 Jun 2026 22:34:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d69csm166380315ad.2.2026.06.07.22.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:34:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma: fsl_raid: replace in_be32/out_be32 with ioread32be/iowrite32be
Date: Sun,  7 Jun 2026 22:34:41 -0700
Message-ID: <20260608053441.12238-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	TAGGED_FROM(0.00)[bounces-11284-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E805652D5D

Mechanical conversion of the ppc4xx-specific accessors to the generic
portable helpers.

As a result, enable COMPILE_TEST for extra compile coverage.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig    |  4 ++--
 drivers/dma/fsl_raid.c | 50 ++++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f16bd4059d84..302021540d76 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -242,7 +242,7 @@ config FSL_QDMA
 
 config FSL_RAID
 	tristate "Freescale RAID engine Support"
-	depends on FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH
+	depends on (FSL_SOC && !ASYNC_TX_ENABLE_CHANNEL_SWITCH) || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_ENGINE_RAID
 	help
@@ -448,7 +448,7 @@ config MOXART_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the MOXA ART SoC DMA controller.
- 
+
 	  Say Y here if you enabled MMP ADMA, otherwise say N.
 
 config MPC512X_DMA
diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 99945845d8b5..dedd4a83ac72 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -114,7 +114,7 @@ static void fsl_re_issue_pending(struct dma_chan *chan)
 
 	spin_lock_irqsave(&re_chan->desc_lock, flags);
 	avail = FSL_RE_SLOT_AVAIL(
-		in_be32(&re_chan->jrregs->inbring_slot_avail));
+		ioread32be(&re_chan->jrregs->inbring_slot_avail));
 
 	list_for_each_entry_safe(desc, _desc, &re_chan->submit_q, node) {
 		if (!avail)
@@ -127,7 +127,7 @@ static void fsl_re_issue_pending(struct dma_chan *chan)
 
 		re_chan->inb_count = (re_chan->inb_count + 1) &
 						FSL_RE_RING_SIZE_MASK;
-		out_be32(&re_chan->jrregs->inbring_add_job, FSL_RE_ADD_JOB(1));
+		iowrite32be(FSL_RE_ADD_JOB(1), &re_chan->jrregs->inbring_add_job);
 		avail--;
 	}
 	spin_unlock_irqrestore(&re_chan->desc_lock, flags);
@@ -167,7 +167,7 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
 	fsl_re_cleanup_descs(re_chan);
 
 	spin_lock_irqsave(&re_chan->desc_lock, flags);
-	count =	FSL_RE_SLOT_FULL(in_be32(&re_chan->jrregs->oubring_slot_full));
+	count =	FSL_RE_SLOT_FULL(ioread32be(&re_chan->jrregs->oubring_slot_full));
 	while (count--) {
 		found = 0;
 		hwdesc = &re_chan->oub_ring_virt_addr[re_chan->oub_count];
@@ -192,8 +192,7 @@ static void fsl_re_dequeue(struct tasklet_struct *t)
 		oub_count = (re_chan->oub_count + 1) & FSL_RE_RING_SIZE_MASK;
 		re_chan->oub_count = oub_count;
 
-		out_be32(&re_chan->jrregs->oubring_job_rmvd,
-			 FSL_RE_RMVD_JOB(1));
+		iowrite32be(FSL_RE_RMVD_JOB(1), &re_chan->jrregs->oubring_job_rmvd);
 	}
 	spin_unlock_irqrestore(&re_chan->desc_lock, flags);
 }
@@ -206,7 +205,7 @@ static irqreturn_t fsl_re_isr(int irq, void *data)
 
 	re_chan = dev_get_drvdata((struct device *)data);
 
-	irqstate = in_be32(&re_chan->jrregs->jr_interrupt_status);
+	irqstate = ioread32be(&re_chan->jrregs->jr_interrupt_status);
 	if (!irqstate)
 		return IRQ_NONE;
 
@@ -216,13 +215,13 @@ static irqreturn_t fsl_re_isr(int irq, void *data)
 	 * need to do something more than just crashing
 	 */
 	if (irqstate & FSL_RE_ERROR) {
-		status = in_be32(&re_chan->jrregs->jr_status);
+		status = ioread32be(&re_chan->jrregs->jr_status);
 		dev_err(re_chan->dev, "chan error irqstate: %x, status: %x\n",
 			irqstate, status);
 	}
 
 	/* Clear interrupt */
-	out_be32(&re_chan->jrregs->jr_interrupt_status, FSL_RE_CLR_INTR);
+	iowrite32be(FSL_RE_CLR_INTR, &re_chan->jrregs->jr_interrupt_status);
 
 	tasklet_schedule(&re_chan->irqtask);
 
@@ -708,30 +707,23 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
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
+	iowrite32be(chan->inb_phys_addr & FSL_RE_ADDR_BIT_MASK, &chan->jrregs->inbring_base_h);
+	iowrite32be(chan->oub_phys_addr & FSL_RE_ADDR_BIT_MASK, &chan->jrregs->oubring_base_h);
+	iowrite32be(chan->inb_phys_addr >> FSL_RE_ADDR_BIT_SHIFT, &chan->jrregs->inbring_base_l);
+	iowrite32be(chan->oub_phys_addr >> FSL_RE_ADDR_BIT_SHIFT, &chan->jrregs->oubring_base_l);
+	iowrite32be(FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT, &chan->jrregs->inbring_size);
+	iowrite32be(FSL_RE_RING_SIZE << FSL_RE_RING_SIZE_SHIFT, &chan->jrregs->oubring_size);
 
 	/* Read LIODN value from u-boot */
-	status = in_be32(&chan->jrregs->jr_config_1) & FSL_RE_REG_LIODN_MASK;
+	status = ioread32be(&chan->jrregs->jr_config_1) & FSL_RE_REG_LIODN_MASK;
 
 	/* Program the CFG reg */
-	out_be32(&chan->jrregs->jr_config_1,
-		 FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status);
+	iowrite32be(FSL_RE_CFG1_CBSI | FSL_RE_CFG1_CBS0 | status, &chan->jrregs->jr_config_1);
 
 	dev_set_drvdata(chandev, chan);
 
 	/* Enable RE/CHAN */
-	out_be32(&chan->jrregs->jr_command, FSL_RE_ENABLE);
+	iowrite32be(FSL_RE_ENABLE, &chan->jrregs->jr_command);
 
 	return 0;
 
@@ -768,15 +760,15 @@ static int fsl_re_probe(struct platform_device *ofdev)
 		return -EBUSY;
 
 	/* Program the RE mode */
-	out_be32(&re_priv->re_regs->global_config, FSL_RE_NON_DPAA_MODE);
+	iowrite32be(FSL_RE_NON_DPAA_MODE, &re_priv->re_regs->global_config);
 
 	/* Program Galois Field polynomial */
-	out_be32(&re_priv->re_regs->galois_field_config, FSL_RE_GFM_POLY);
+	iowrite32be(FSL_RE_GFM_POLY, &re_priv->re_regs->galois_field_config);
 
 	dev_info(dev, "version %x, mode %x, gfp %x\n",
-		 in_be32(&re_priv->re_regs->re_version_id),
-		 in_be32(&re_priv->re_regs->global_config),
-		 in_be32(&re_priv->re_regs->galois_field_config));
+		 ioread32be(&re_priv->re_regs->re_version_id),
+		 ioread32be(&re_priv->re_regs->global_config),
+		 ioread32be(&re_priv->re_regs->galois_field_config));
 
 	dma_dev = &re_priv->dma_dev;
 	dma_dev->dev = dev;
-- 
2.54.0


