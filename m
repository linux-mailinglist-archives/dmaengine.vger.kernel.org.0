Return-Path: <dmaengine+bounces-12357-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e/cwMNsOVGoIhgMAu9opvQ
	(envelope-from <dmaengine+bounces-12357-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:02:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFE746176
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:02:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g68vZbOW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12357-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12357-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9460B302F271
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113137C916;
	Sun, 12 Jul 2026 22:00:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9C449985
	for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 22:00:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893644; cv=none; b=KlNJ7YSPWlvOVPuytBjs6nvd2lLYuKbQpfxaU5Xd51lCYRdpB7k/pU2ims+B+anlRMLuCdM3EdVTMS+ADsNAGDH0768UdQgOeB5xt9GpYO0CZRFAebzDRnWGcZwMxHdZlzpeWqeFWF8SLoQq8b/R30noTIelIfkLAseCmVTePxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893644; c=relaxed/simple;
	bh=XB/FXyBc5Jaregb9hd8KLGeQNU5RAms9ksjPvVxmUe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBlgQcosKbIfKvzbJtmBoOYLrJoJh06YkTzGgf7DOai8wKa/5NvbisUWcz9szPKhWhTvE57t2/GxdZjbeGO4xQLYwYbe2WjKGclI4e5Puphwphhp+Gpex8ZZDHSIvQiszUZlPXlokotSdJQbg09xxferwXBgt5eOemMpMMKt5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g68vZbOW; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so20637095ad.3
        for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783893643; x=1784498443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIRKxzKpxKWrf9QwtK6Xlt/4yAtQNiP0hgI5FE3Urag=;
        b=g68vZbOWHuExJvNrqF7s8VcamZ1I01pKUZTiwYVI2CoqoxJuTVNGxgpngwq8NMWBw8
         xoIxA2Zij8YDYCR8I8Ge2ID8JOH8NN0VVpcG/45uaC167DzalqNcNIAoT80SXRph+Ibj
         smcUIxAYBqbqk21pxF8VHnm//z8Mq1gx0O61lGTpOcxGchQOC6WVjrcIYTt57bgNzHIS
         1WUuxczZUjG3GlYV2UFbWf0AMMU7ZHM2kgYCSnvUMd5Lsm2vypn0ZrsejdbO8RoMmPOO
         tTQecUB0naKAE1l7K4cAu2OK0MkXwUcW+kTdtuEU8ydgx/3gdR0IFqETkSd0l/Bmr2eH
         dwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893643; x=1784498443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIRKxzKpxKWrf9QwtK6Xlt/4yAtQNiP0hgI5FE3Urag=;
        b=qUMTzl1DsZlrIt0URSrsCipqk4yGbWKktsSFkA6XPq7taLvTvY7wbz+SIGS0LFQ2aH
         hcWd428Lf0vPJpmo1uGz9G6ofIE/+uslmMtnwIhqXZGOpScvWaLR21vBqpB1MYCvbxjI
         NEJDH7IaDhjWZjesaIx1yTXemGs7YcFXZFiDsYuBQULkY4ymUO2zXufK237K2R24npPH
         f7K4pIKyWvOXX6O/bf4maErGJ3/AdvPo23NY6kbcOY/MMwQZQwva+G9bhL07F2fHuq3X
         ZTUawtlALAr9KfAOgAZDJLhIbR6irY3WKCSXqdGC2bb9DFpI03/5JFKRZYDL0sP/Nig3
         OMZA==
X-Gm-Message-State: AOJu0YwjVXOK5F5hA4liWLeGN6OiIjeZn5oZw8AfQ7MU6tPS7LfHYEOm
	QUY3DWEJMLaDBgTnuchi5xYPLt9mWiy5i/r8vCWgve3M1D1J5OiYXk5lcZY29g==
X-Gm-Gg: AfdE7claCcjNBJq6Xum3MpPCMITr2x4BUPhoCYwyawD3/IklqVc82C617kDrXq++O7W
	HNKweHIeswRo+fta/78AyzJgpMZNHubxNV24LXRdVZRdtc+NfdJuL0rynFc+EqTj80621KBtqWy
	C/Ly1Unm6G9id5vlQ3urBFf1pCNWdsL7jHZofGjWhfCIljVXExJsGJaYu7FNVVe/5cdHxFrXQyn
	ez8TZAoUmTTWbAEroNHEPtYtlQUo7YZdDM7dzpX0MHqVHJjjytMPKZySu0PG3JPjqExv2VY0f79
	5vDz1/bTuu3NIvmhdoIulH/94TxDVVvM+F0Rz4JD+eK7RhbRfdsKn3+CAed+TDGB3cQweZ/D3Re
	x1cVNErbi3BmTvsyX/frRRgs6dVkoZc5pfuRxgMSLpv9LxzuS1wCSklojL7BiugjfDocsMxnu8i
	9gaxyyIrrFNhLHvIdAvv1BpQR5pB6+2M2L9WaIt5rY+5Y5+m1VeNlVelGnlJlkC35ryB39xXi0+
	+RDYzX6f6NpT/iTCHFY34LcCs1aIHMDiHV+ICG1g6uyUKuTarzrkwNAHQNHj2RhR845sGDeLjWh
X-Received: by 2002:a17:90b:2884:b0:387:e0db:bc22 with SMTP id 98e67ed59e1d1-38dc77b3846mr7049245a91.34.1783893642805;
        Sun, 12 Jul 2026 15:00:42 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm14856305eec.13.2026.07.12.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:00:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 1/2] dmaengine: idma64: use kzalloc_flex
Date: Sun, 12 Jul 2026 15:00:38 -0700
Message-ID: <20260712220039.924958-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712220039.924958-1-rosenp@gmail.com>
References: <20260712220039.924958-1-rosenp@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12357-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27AFE746176

Simplifies allocations by using a flexible array member in this struct.

Remove idma64_alloc_desc. It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct idma64_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/idma64.c | 30 ++++--------------------------
 drivers/dma/idma64.h |  4 ++--
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 5fcd1befc92d..d914f50ec309 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -192,23 +192,6 @@ static irqreturn_t idma64_irq(int irq, void *dev)
 
 /* ---------------------------------------------------------------------- */
 
-static struct idma64_desc *idma64_alloc_desc(unsigned int ndesc)
-{
-	struct idma64_desc *desc;
-
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
-	if (!desc)
-		return NULL;
-
-	desc->hw = kzalloc_objs(*desc->hw, ndesc, GFP_NOWAIT);
-	if (!desc->hw) {
-		kfree(desc);
-		return NULL;
-	}
-
-	return desc;
-}
-
 static void idma64_desc_free(struct idma64_chan *idma64c,
 		struct idma64_desc *desc)
 {
@@ -223,7 +206,6 @@ static void idma64_desc_free(struct idma64_chan *idma64c,
 		} while (i);
 	}
 
-	kfree(desc->hw);
 	kfree(desc);
 }
 
@@ -307,10 +289,12 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;
 
-	desc = idma64_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, hw, sg_len, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
+	desc->ndesc = sg_len;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct idma64_hw_desc *hw = &desc->hw[i];
 
@@ -326,7 +310,6 @@ static struct dma_async_tx_descriptor *idma64_prep_slave_sg(
 		hw->len = sg_dma_len(sg);
 	}
 
-	desc->ndesc = sg_len;
 	desc->direction = direction;
 	desc->status = DMA_IN_PROGRESS;
 
@@ -541,18 +524,13 @@ static int idma64_probe(struct idma64_chip *chip)
 	unsigned short i;
 	int ret;
 
-	idma64 = devm_kzalloc(chip->dev, sizeof(*idma64), GFP_KERNEL);
+	idma64 = devm_kzalloc(chip->dev, struct_size(idma64, chan, nr_chan), GFP_KERNEL);
 	if (!idma64)
 		return -ENOMEM;
 
 	idma64->regs = chip->regs;
 	chip->idma64 = idma64;
 
-	idma64->chan = devm_kcalloc(chip->dev, nr_chan, sizeof(*idma64->chan),
-				    GFP_KERNEL);
-	if (!idma64->chan)
-		return -ENOMEM;
-
 	idma64->all_chan_mask = (1 << nr_chan) - 1;
 
 	/* Turn off iDMA controller */
diff --git a/drivers/dma/idma64.h b/drivers/dma/idma64.h
index d013b54356aa..1a67dbb24db5 100644
--- a/drivers/dma/idma64.h
+++ b/drivers/dma/idma64.h
@@ -113,10 +113,10 @@ struct idma64_hw_desc {
 struct idma64_desc {
 	struct virt_dma_desc vdesc;
 	enum dma_transfer_direction direction;
-	struct idma64_hw_desc *hw;
 	unsigned int ndesc;
 	size_t length;
 	enum dma_status status;
+	struct idma64_hw_desc hw[] __counted_by(ndesc);
 };
 
 static inline struct idma64_desc *to_idma64_desc(struct virt_dma_desc *vdesc)
@@ -187,7 +187,7 @@ struct idma64 {
 
 	/* channels */
 	unsigned short all_chan_mask;
-	struct idma64_chan *chan;
+	struct idma64_chan chan[];
 };
 
 static inline struct idma64 *to_idma64(struct dma_device *ddev)
-- 
2.55.0


