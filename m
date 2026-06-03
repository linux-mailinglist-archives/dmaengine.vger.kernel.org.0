Return-Path: <dmaengine+bounces-11150-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EhlIQ+BIGrF4QAAu9opvQ
	(envelope-from <dmaengine+bounces-11150-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 21:31:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D472063ADE4
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 21:31:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QUGvaaa5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11150-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11150-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FA833032047
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D588048BD26;
	Wed,  3 Jun 2026 19:26:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693E481A97
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 19:26:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514819; cv=none; b=Y9a8zyyfgYjFMnrMdsSNC78S0GbXIyeDK0FhzJhaqKuit5CkoPkLAAV0GkeC8TTkGUUsncVVSbHbbOLTFLRjJ/KQytWudytHUOuITvHK3Sv401OQA/Dogiu495k0Xv4wm0BTa7IMkw4H4aaCL7AY90A0R9tIxpsUwSq1X+DR9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514819; c=relaxed/simple;
	bh=6DguKxYNrjeiAjnVpMdGCeRta/Ai5Rj0mgA9Ap8X6X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHswxKPgezNUH5ch4KooKP6Xmz//1WU111D5UpZ3AMRY6IKZiofKCF5fcIGxc7SfBOH6tzKTfLntSM2KMIUYY3r7cHKEaDOogQpnizGVi4Ltqc0WNJYCccLU1YwefgToKrn4S5whqEDjF9dmlvMDUUC86lhvfJ5428IExmSGoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUGvaaa5; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccef9eabccso10218816d6.1
        for <dmaengine@vger.kernel.org>; Wed, 03 Jun 2026 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780514817; x=1781119617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgc8o+7qGhfK18Q7gHfB7Dy44SLCuAFy1Rt3y6EuBIw=;
        b=QUGvaaa5Hq3egKp4b/+cPndkfIK5binO9iXEVgXspsNM/uPNwJ82fhv/kh/CHnDEJO
         ZbukwXnevirxrNfXhqVQ/HytUsOU767vLF3Vk+f+9hi5JmSKTCQ2Hp2etuWnbEY2GW7c
         LdrwbR60AOLrXZY12sT0n3RaD6R7BCOaNN5i+Dw9152fXVeRxVf14HCj+9UGFocCbKl8
         vxwU9N2Xgq79Jud/kf8EsLFJ3oRyXcN1sWUpkYrhI+4CKM9x1jye+z6vISsP3s1Jwi7o
         tKYBqo2ctLGTfQXRjP355gdJ1+U9sbxfcjGPDXoR4TNGvddGHbhzetM9jsOkK+oYjEkd
         9iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514817; x=1781119617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgc8o+7qGhfK18Q7gHfB7Dy44SLCuAFy1Rt3y6EuBIw=;
        b=ZRJX3VnPYtCp5SclLMdhA4TjAnU5/oAV6aplSs/ZS7BU+SJFN5RjDjDgrbqq4PJcT9
         Gqk5s2k7Gy9cwM2HmAM3SJR0Q5VqYZIoYMNR5H/sCNUC/UWRi3BQJEfbX0cHutvm0sGp
         5ZmtUdp2zJpaCuusG88r1I98pKZLd4sXGZHf/uT1kt2Ckv5wxmFXHQ5SI3qz7mFjlrOL
         Oz2SpeIsslleEPBtZQduiHNKNw8BXC77UvJbU8u8719emG61Db9eGGT/k/z24cf3ZOoh
         7IbwJc4U2n+fpFTV0dfbaZVxFucPpBHVKoPkhyHRNh861hkou73/s1g6IfWiReWVKFB1
         5I6A==
X-Gm-Message-State: AOJu0YyGYwx+YNgT/SRnfgbwELlS6E0JVc9zOaCYx83gDpRWs10PQEbM
	PllYPdsy+WduABzk/IXqGx6Y2q5jSsVkEHRXhDrNuUe0zo6mUEL3HcUOBqrzHOoD
X-Gm-Gg: Acq92OFH2YQWj1b72oK7AyXor3ROjTChBZcWI5tlewhe2w7kRMJanzwSYC3BFOt9Ib3
	1/DDIhb9BTS5lYhPHIlCpKLqnGn9dRJ/9cZFIoNhSRKCeXcMYdzeAN/5rTzDSDviTU/vWNWT8Gw
	RwFEz92LKNYf1RS3FRghbM5/z/kmbuOd+Y22XfT6edkpD1DP62yD2/zI9Gb+wRD709uS6rnrdK0
	Af+hPfZqP+oGixp4IUyAXYaJYWv/ZzC9KGzJGzH9OYLlnMS40caDgW5zzg0cbHLYnChE+Pg9O9v
	LA+z3fy51Ci9n+Wm17VpXZAxd5zwp9RDtM7neS9dVTfzpVnt9GUa7aAmazrG2SIwN6K1ddYom+x
	fUmT4q4KLHDvvRlqNKtGkPvkp/o+lyPCZ0US18aYb6QJ5OaCVUXrW5MiG0tLX5CQQIQnTawiqCk
	LBUifp3cgp955et86sqgn1mSHZaDk0zeA++xSCbyKVFNBvQ5Tfv6JZTNaDmXH+Fnb5ujsOD9p4/
	+J1uvQfQIcB7XG2sm/dmJ/iLm5uTBJaLsxECvf/p/j86Jy9EboQYjXc
X-Received: by 2002:a05:6214:4986:b0:8cc:f3a0:209b with SMTP id 6a1803df08f44-8ced825a094mr13495176d6.17.1780514816618;
        Wed, 03 Jun 2026 12:26:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda0904sm30038596d6.7.2026.06.03.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:26:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma: mpc512x: replace in_be32/out_be32/out_8 with ioread32be/iowrite32be/iowrite8
Date: Wed,  3 Jun 2026 12:26:38 -0700
Message-ID: <20260603192638.7001-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11150-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: D472063ADE4

Mechanical conversion of the ppc4xx-specific accessors to the generic
portable helpers.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mpc512x_dma.c | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 0adc8e01057e..8b9c44032bc8 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -304,13 +304,13 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 
 	if (mdma->is_mpc8308) {
 		/* MPC8308, no request lines, software initiated start */
-		out_8(&mdma->regs->dmassrt, cid);
+		iowrite8(cid, &mdma->regs->dmassrt);
 	} else if (first->will_access_peripheral) {
 		/* Peripherals involved, start by external request signal */
-		out_8(&mdma->regs->dmaserq, cid);
+		iowrite8(cid, &mdma->regs->dmaserq);
 	} else {
 		/* Memory to memory transfer, software initiated start */
-		out_8(&mdma->regs->dmassrt, cid);
+		iowrite8(cid, &mdma->regs->dmassrt);
 	}
 }
 
@@ -328,8 +328,8 @@ static void mpc_dma_irq_process(struct mpc_dma *mdma, u32 is, u32 es, int off)
 
 		spin_lock(&mchan->lock);
 
-		out_8(&mdma->regs->dmacint, ch + off);
-		out_8(&mdma->regs->dmacerr, ch + off);
+		iowrite8(ch + off, &mdma->regs->dmacint);
+		iowrite8(ch + off, &mdma->regs->dmacerr);
 
 		/* Check error status */
 		if (es & (1 << ch))
@@ -352,7 +352,7 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
 	uint es;
 
 	/* Save error status register */
-	es = in_be32(&mdma->regs->dmaes);
+	es = ioread32be(&mdma->regs->dmaes);
 	spin_lock(&mdma->error_status_lock);
 	if ((es & MPC_DMA_DMAES_VLD) && mdma->error_status == 0)
 		mdma->error_status = es;
@@ -360,11 +360,11 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
 
 	/* Handle interrupt on each channel */
 	if (mdma->dma.chancnt > 32) {
-		mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmainth),
-					in_be32(&mdma->regs->dmaerrh), 32);
+		mpc_dma_irq_process(mdma, ioread32be(&mdma->regs->dmainth),
+					ioread32be(&mdma->regs->dmaerrh), 32);
 	}
-	mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmaintl),
-					in_be32(&mdma->regs->dmaerrl), 0);
+	mpc_dma_irq_process(mdma, ioread32be(&mdma->regs->dmaintl),
+					ioread32be(&mdma->regs->dmaerrl), 0);
 
 	/* Schedule tasklet */
 	tasklet_schedule(&mdma->tasklet);
@@ -535,7 +535,7 @@ static int mpc_dma_alloc_chan_resources(struct dma_chan *chan)
 	spin_unlock_irqrestore(&mchan->lock, flags);
 
 	/* Enable Error Interrupt */
-	out_8(&mdma->regs->dmaseei, chan->chan_id);
+	iowrite8(chan->chan_id, &mdma->regs->dmaseei);
 
 	return 0;
 }
@@ -576,7 +576,7 @@ static void mpc_dma_free_chan_resources(struct dma_chan *chan)
 		kfree(mdesc);
 
 	/* Disable Error Interrupt */
-	out_8(&mdma->regs->dmaceei, chan->chan_id);
+	iowrite8(chan->chan_id, &mdma->regs->dmaceei);
 }
 
 /* Send all pending descriptor to hardware */
@@ -885,7 +885,7 @@ static int mpc_dma_device_terminate_all(struct dma_chan *chan)
 	/* Disable channel requests */
 	spin_lock_irqsave(&mchan->lock, flags);
 
-	out_8(&mdma->regs->dmacerq, chan->chan_id);
+	iowrite8(chan->chan_id, &mdma->regs->dmacerq);
 	list_splice_tail_init(&mchan->prepared, &mchan->free);
 	list_splice_tail_init(&mchan->queued, &mchan->free);
 	list_splice_tail_init(&mchan->active, &mchan->free);
@@ -1020,38 +1020,38 @@ static int mpc_dma_probe(struct platform_device *op)
 	 */
 	if (mdma->is_mpc8308) {
 		/* MPC8308 has 16 channels and lacks some registers */
-		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_ERCA);
+		iowrite32be(MPC_DMA_DMACR_ERCA, &mdma->regs->dmacr);
 
 		/* enable snooping */
-		out_be32(&mdma->regs->dmagpor, MPC_DMA_DMAGPOR_SNOOP_ENABLE);
+		iowrite32be(MPC_DMA_DMAGPOR_SNOOP_ENABLE, &mdma->regs->dmagpor);
 		/* Disable error interrupts */
-		out_be32(&mdma->regs->dmaeeil, 0);
+		iowrite32be(0, &mdma->regs->dmaeeil);
 
 		/* Clear interrupts status */
-		out_be32(&mdma->regs->dmaintl, 0xFFFF);
-		out_be32(&mdma->regs->dmaerrl, 0xFFFF);
+		iowrite32be(0xFFFF, &mdma->regs->dmaintl);
+		iowrite32be(0xFFFF, &mdma->regs->dmaerrl);
 	} else {
-		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_EDCG |
+		iowrite32be(MPC_DMA_DMACR_EDCG |
 						MPC_DMA_DMACR_ERGA |
-						MPC_DMA_DMACR_ERCA);
+						MPC_DMA_DMACR_ERCA, &mdma->regs->dmacr);
 
 		/* Disable hardware DMA requests */
-		out_be32(&mdma->regs->dmaerqh, 0);
-		out_be32(&mdma->regs->dmaerql, 0);
+		iowrite32be(0, &mdma->regs->dmaerqh);
+		iowrite32be(0, &mdma->regs->dmaerql);
 
 		/* Disable error interrupts */
-		out_be32(&mdma->regs->dmaeeih, 0);
-		out_be32(&mdma->regs->dmaeeil, 0);
+		iowrite32be(0, &mdma->regs->dmaeeih);
+		iowrite32be(0, &mdma->regs->dmaeeil);
 
 		/* Clear interrupts status */
-		out_be32(&mdma->regs->dmainth, 0xFFFFFFFF);
-		out_be32(&mdma->regs->dmaintl, 0xFFFFFFFF);
-		out_be32(&mdma->regs->dmaerrh, 0xFFFFFFFF);
-		out_be32(&mdma->regs->dmaerrl, 0xFFFFFFFF);
+		iowrite32be(0xFFFFFFFF, &mdma->regs->dmainth);
+		iowrite32be(0xFFFFFFFF, &mdma->regs->dmaintl);
+		iowrite32be(0xFFFFFFFF, &mdma->regs->dmaerrh);
+		iowrite32be(0xFFFFFFFF, &mdma->regs->dmaerrl);
 
 		/* Route interrupts to IPIC */
-		out_be32(&mdma->regs->dmaihsa, 0);
-		out_be32(&mdma->regs->dmailsa, 0);
+		iowrite32be(0, &mdma->regs->dmaihsa);
+		iowrite32be(0, &mdma->regs->dmailsa);
 	}
 
 	/* Register DMA engine */
-- 
2.54.0


