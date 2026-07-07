Return-Path: <dmaengine+bounces-12068-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LjMaFHYVTWo4uwEAu9opvQ
	(envelope-from <dmaengine+bounces-12068-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 17:04:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82671CFAD
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 17:04:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="P/lNqtG9";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12068-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12068-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D49743012B0B
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286F3783B1;
	Tue,  7 Jul 2026 15:04:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD797351C3C
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 15:04:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436645; cv=none; b=ELxeRPSWCTT3hUCtPcYdMSDSW5R69GpsvHO4H91e+2SuEkjgM0MKthEa16Qhjo9Xlln9fKUKw8Xax/sClcPkr9PQ9mw2mjMUFHhq1MyRghB4DRGTrQsAV7iueu6tmQh5dynv+d6t6UlBfz80cqBGH1+7NTENKGv8uI/jNYmjyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436645; c=relaxed/simple;
	bh=fQ6mFyDDY/RwR8PDXHtDizhl4iyfDoUkR404aYaU2G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxIirZqhDG3d0bYjbqS/O637aZumgkm8FQrIzu0bgcYVvkXZza43rKBrK5yp452mu5NMdCSmBPdicpRdJK+XZXmRk8spbWOYJnww8FI9cA6fWiwgmw326oXQN22V5X8mxoD/N7tYnw1SQ5VUYctR7TlDD9H8ufYJQeZfritGzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/lNqtG9; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84830c774a0so784056b3a.1
        for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783436643; x=1784041443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aju07XlckgqUCnU3/0JH44YKWW5kX2cTHx1V+eWIJdA=;
        b=P/lNqtG9k+1+OLi4Z9xgfMXUxUfFz84bWCGna8S9fGMWXsjA+09E5lExScQGWnqhCw
         yhJdeAm0gvuYQAKtDgWou6Tj5Leihpmb+ZG6IgA6/E/pCf8F+R9ndPlxYhNryVGSVhtg
         yPOlaWvisCfV9zWmd+jdLVWU3Pq8wiYRDQSMk5cGR05Bg6onrqeRsigzQzbhxz8kPJrz
         Afuyr4+/6ylvsqh472KJMOQedrrPCOrSNbJaKRQMt4AreilAghzzwZN6DUarF8KiJ+Cf
         kQzorVne5QTk+DzcEjNNxZgDpQKZO/L3VsBSLa+9pVGZCCPzMLkTT4nsdBX6fj1ybWe0
         dkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436643; x=1784041443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aju07XlckgqUCnU3/0JH44YKWW5kX2cTHx1V+eWIJdA=;
        b=iZvprbnxFpSpdcJOeC1TR4Fqaz0BUBdToysJ7vxQaIL/CytKNj6igZ2FFqAT669NJy
         e/90idcx9ewO0WKvOYI29X4CDRaGdWMYudnYiLjv9OfdDJ80ehf5zSIKE8GqN0Tsscbu
         i2fndmCpA9+vnHaGrowFKyMHrIuX9zShWVyryJYak6R/wiWrdV9HAdqpcbsjdrFomBc0
         covURysU1OL5udznMWybW9QLIyPUFhawbTNoXf6+jK+Iag7VMEmYXf6ep2zgfnRXgPTC
         sqT1Hh7dekdX8y+3CArzzE1qQHoZVZbvCK6zHW88/0UrC+ePDmW15DMVOWXXEW4it0zR
         VhNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoELhD2r+IAoMZlcTX9mmKX8etu6JvqpJMOFDYVk7lGgfI5Ib5XP1ouQmd5UhG9zB9wkZBvVawZjIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTB7cySKYWvP27PbSSds3Tu0/MZDMD/py8qefKRR+OYLZVv5aB
	3pMMnSB+/d9F24U/4wrZ5rHmbNLN8CrxFkSROmD+IaCNpAc5j2LtRX6N
X-Gm-Gg: AfdE7clJ4r4pCnzmpmqNC4Xnw8F5O7NdIyVzrQBxoRgJYHrxudf6mC9/kjhbo8yOCnE
	1oOwoZA76WhQuehatINwFFi5dnJTUtwQKjcpoKoi7LsC+2MlZe+3QsrC0NLajp0tf2bhZONn2vD
	+dWaZdA1gWKSQRnq6F259Jm1LTbUSNATgtz5/66sTDadt7A1FLJHqvGrC3AyrWnlO/lyow3y9YY
	WfICq0MwWH//gsglHD5WwIrQPz38CdepU8/qmRIDG5nYecM4ZWM4CEIpRd9Vg7mAKNJPbLD8Azc
	0jbHqraiYiNbKvboFEsawqZno6vqr/164xPY0xLu2jTKujksXjOqI2sIsevjWp8+6ubZgrZotto
	mATAwjfJE3hW9KF4OE+GEXZhc6WWG7GNx9HeNbIQOXlLfSuTOkRapn7NSQIO4W90u2/nK5acu+H
	wxL1PDMIIn+rOjuI8b6pveOXtAOgvC9PYx
X-Received: by 2002:a05:6a00:a0d:b0:847:9aa8:d3ce with SMTP id d2e1a72fcca58-84826be277bmr4930295b3a.2.1783436643169;
        Tue, 07 Jul 2026 08:04:03 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:239e:a31b:1d0d:374f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4edb4sm5616225b3a.33.2026.07.07.08.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:04:02 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org
Cc: arnd@arndb.de,
	zhangfei.gao@marvell.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] dmaengine: mmp_pdma: Check virtual channel before scheduling tasklet
Date: Tue,  7 Jul 2026 23:03:55 +0800
Message-ID: <20260707150356.2257833-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,marvell.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12068-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:arnd@arndb.de,m:zhangfei.gao@marvell.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE82671CFAD

mmp_pdma_chan_handler() clears a physical-channel interrupt and then
unconditionally schedules phy->vchan->tasklet. The physical channel can
be detached from its virtual channel when the channel is terminated or
when no pending work remains, so a late or shared interrupt can reach the
handler with phy->vchan already NULL.

Snapshot phy->vchan in the interrupt path, skip tasklet scheduling when
there is no virtual channel, and use the same snapshot for the BUSERR
warning. Use WRITE_ONCE() for the matching attach/detach stores because
the IRQ path reads this pointer without taking phy_lock.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: c8acd6aa6bed ("dmaengine: mmp-pdma support")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/dma/mmp_pdma.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 386e85cd4882a..6f379e9f10017 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -351,6 +351,7 @@ static void disable_chan(struct mmp_pdma_phy *phy)
 
 static int clear_chan_irq(struct mmp_pdma_phy *phy)
 {
+	struct mmp_pdma_chan *vchan;
 	u32 dcsr;
 	u32 dint = readl(phy->base + DINT);
 	u32 reg = (phy->idx << 2) + DCSR;
@@ -361,8 +362,9 @@ static int clear_chan_irq(struct mmp_pdma_phy *phy)
 	/* clear irq */
 	dcsr = readl(phy->base + reg);
 	writel(dcsr, phy->base + reg);
-	if ((dcsr & DCSR_BUSERR) && (phy->vchan))
-		dev_warn(phy->vchan->dev, "DCSR_BUSERR\n");
+	vchan = READ_ONCE(phy->vchan);
+	if ((dcsr & DCSR_BUSERR) && vchan)
+		dev_warn(vchan->dev, "DCSR_BUSERR\n");
 
 	return 0;
 }
@@ -370,11 +372,16 @@ static int clear_chan_irq(struct mmp_pdma_phy *phy)
 static irqreturn_t mmp_pdma_chan_handler(int irq, void *dev_id)
 {
 	struct mmp_pdma_phy *phy = dev_id;
+	struct mmp_pdma_chan *vchan;
 
 	if (clear_chan_irq(phy) != 0)
 		return IRQ_NONE;
 
-	tasklet_schedule(&phy->vchan->tasklet);
+	vchan = READ_ONCE(phy->vchan);
+	if (!vchan)
+		return IRQ_HANDLED;
+
+	tasklet_schedule(&vchan->tasklet);
 	return IRQ_HANDLED;
 }
 
@@ -427,7 +434,7 @@ static struct mmp_pdma_phy *lookup_phy(struct mmp_pdma_chan *pchan)
 				continue;
 			phy = &pdev->phy[i];
 			if (!phy->vchan) {
-				phy->vchan = pchan;
+				WRITE_ONCE(phy->vchan, pchan);
 				found = phy;
 				goto out_unlock;
 			}
@@ -453,7 +460,7 @@ static void mmp_pdma_free_phy(struct mmp_pdma_chan *pchan)
 	writel(0, pchan->phy->base + reg);
 
 	spin_lock_irqsave(&pdev->phy_lock, flags);
-	pchan->phy->vchan = NULL;
+	WRITE_ONCE(pchan->phy->vchan, NULL);
 	pchan->phy = NULL;
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
 }
-- 
2.51.0


