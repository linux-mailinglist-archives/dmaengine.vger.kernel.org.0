Return-Path: <dmaengine+bounces-9683-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A36Arj0xWnbEgUAu9opvQ
	(envelope-from <dmaengine+bounces-9683-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 04:08:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135A33EAE5
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 04:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 327F7302DDD7
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF732936C;
	Fri, 27 Mar 2026 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcX3uQpZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5E340D90
	for <dmaengine@vger.kernel.org>; Fri, 27 Mar 2026 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580403; cv=none; b=s0KhTSdr62R+pbKh2gAf4qgTDLzKCJjKNGPhQgx804pTcRN7TLMWFwLlbPlyi1fh6rFkLKhuSkq/aQ69CRe0QolxSKDjr91lBUpn5XawhvX1SnCsIkaH4I79Bs9i46VpgJsDXPx5ETxVY1DdontJHJ3t64yP8/4UktBoIoPTlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580403; c=relaxed/simple;
	bh=hKwae93xmtHYAdjpVNsr+gAY5z09ypQ9lhd/Gtk52cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcuFVSND0/d4tloR3F9WXX17bEyc4EFZd1qFahfvpq5gt0Qtwp+sHfScH7kgBvl3vYEaDQY3O3RtS8hIXDmPf616gXnMasvrBnAQCCqHP6irC5NIeeLGXyuu1KhYOPpLD6TsFKnzBEmEx3QebOjT1Si/TbEa5A55OsjuXqzWIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcX3uQpZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0c8362d93so6534745ad.3
        for <dmaengine@vger.kernel.org>; Thu, 26 Mar 2026 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580401; x=1775185201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AE2oYD/S8jc9LBiWpGPXEFCYuSoSUhxv8UwWq86+mY=;
        b=rcX3uQpZJqRcRhVX63HBhEr/SikcY1kb29Lcm1S3LBTCgONVANSzO/vdJml9J9DQQJ
         mLOMiESny304tPuNyHnoATbeOFfgu6ttwgcMO1C+B+DJ/VEcYBejuaDyzKZzs4BFr3cZ
         b0jkIAmmG/ILbJMze/kKiB5lWR+/ti81fARnoPqjioZjQH3+u+YYB7Ja1kbe6hhFp2Zq
         gQ7dLw0wr2MA1u++EHgdAxhBCac/ciNSghG6pef32q8Z9vMVCMk9gmbYm+4nZEwHFtAA
         CvX40ynGeHKSqhOKvYr3XjifMF49Qa8AW60JAciTirZxwK26aXIHa2An0dvLWj8E9rUZ
         lbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580401; x=1775185201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AE2oYD/S8jc9LBiWpGPXEFCYuSoSUhxv8UwWq86+mY=;
        b=mgu59T9IVWpJm3RX3H1ucI7dCAtL3ybxHwjwytWMpMycidhLJ2n1KfDw1KBXWk1b6G
         3PHB7SWZmEzVSbChmokUzkjmxRmpvdbOacxK3JUMjX3UhZksGos1gzrmtFVVNOgEAix+
         Pl9Xq8r1kZ+HFi2SCYdpSCF3AbiAfP+9IAfW4dS/dun+BwTya7GcfCdDXDiITZck6f9Q
         8zk2v189TZUmm0r1kFIq2kZvf/9TsNQrU4O9ob4oNX7OlcS0ogB+ccmj8iTlwOZyje0t
         xZvUqz1EhDIe2C1K0a10ffnED5Ktj5Z6or5GIaxtwuEh4PhCRnEmGbs2r4toCjxqaJzK
         780g==
X-Gm-Message-State: AOJu0Yyg5wg/FriiMvc1STux+Qs3Sf2eu8ZKcA6s1cPZeYIvV25xdX9g
	Qc2OaAqy0/3xB94Bl45yQyYVZDI4C1WQIY0qOZcdn3KonUTOlj9ZnJ9OK6RcQeWq
X-Gm-Gg: ATEYQzwOlJsTCJBQtLeTHT2NMq8qy4l1pPSEbJfiqCp1ptR0rvWDewAU3I+mwyR6Xy3
	f3pRyZL/xhQx29yOm9V13cFxHhbcvo6G8zpnd7WgeN8tDfz+3H3kHPiV00ClTYwNIxwBcRQ6UAS
	fdEuYAmNK0aiUwgWImbbshmRcGqv0NxAT9rG6yY69uSvW40x1FbJ4uSb2jmIha0W62zf5OjLLfy
	564IRJQyoPJcjBtyCNtyy7JaR6dM+USjOeWyeqa9zt4W5ilGZo2WaFnVU9D3pD7AjE5KCMlw3SS
	Y+v3V6miOlhxflTzKAigqi8QrGnLMJCEwJDWksy3BIHHOzBh/W5ng7Vq5x2WxnaRg3TEBaeANfX
	rfzx6pIurlFo/9wTbWGE3NI0On2yxv990ELEi2YP9D802khtBcwBp5IiwIJyWgJfKmfoRKaWWNT
	Sb6K0DEBxdJTRAfWh2ojKDi5GF3+t0Oe9yPUGvEucCPLRnHARX69vrDhZLXq75Od1Lpg==
X-Received: by 2002:a17:903:98f:b0:2b0:b075:f2fb with SMTP id d9443c01a7336-2b0cdcb87e7mr10769425ad.35.1774580400926;
        Thu, 26 Mar 2026 20:00:00 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm44174115ad.59.2026.03.26.19.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:00:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: hsu: use kzalloc_flex
Date: Thu, 26 Mar 2026 19:59:43 -0700
Message-ID: <20260327025943.8178-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9683-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3135A33EAE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Remove hsu_dma_alloc_desc. It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct hsu_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/hsu/hsu.c | 37 ++++++++-----------------------------
 drivers/dma/hsu/hsu.h |  4 ++--
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index f62d60d7bc6b..150c6567eede 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -241,28 +241,10 @@ int hsu_dma_do_irq(struct hsu_dma_chip *chip, unsigned short nr, u32 status)
 }
 EXPORT_SYMBOL_GPL(hsu_dma_do_irq);
 
-static struct hsu_dma_desc *hsu_dma_alloc_desc(unsigned int nents)
-{
-	struct hsu_dma_desc *desc;
-
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
-	if (!desc)
-		return NULL;
-
-	desc->sg = kzalloc_objs(*desc->sg, nents, GFP_NOWAIT);
-	if (!desc->sg) {
-		kfree(desc);
-		return NULL;
-	}
-
-	return desc;
-}
-
 static void hsu_dma_desc_free(struct virt_dma_desc *vdesc)
 {
 	struct hsu_dma_desc *desc = to_hsu_dma_desc(vdesc);
 
-	kfree(desc->sg);
 	kfree(desc);
 }
 
@@ -276,10 +258,12 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;
 
-	desc = hsu_dma_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, sg, sg_len, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
+	desc->nents = sg_len;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		desc->sg[i].addr = sg_dma_address(sg);
 		desc->sg[i].len = sg_dma_len(sg);
@@ -287,7 +271,6 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 		desc->length += sg_dma_len(sg);
 	}
 
-	desc->nents = sg_len;
 	desc->direction = direction;
 	/* desc->active = 0 by kzalloc */
 	desc->status = DMA_IN_PROGRESS;
@@ -430,21 +413,17 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 	void __iomem *addr = chip->regs + chip->offset;
 	unsigned short i;
 	int ret;
+	unsigned short nr_channels;
 
-	hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
+	/* Calculate nr_channels from the IO space length */
+	nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
+	hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
 	if (!hsu)
 		return -ENOMEM;
 
+	hsu->nr_channels = nr_channels;
 	chip->hsu = hsu;
 
-	/* Calculate nr_channels from the IO space length */
-	hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
-
-	hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
-				 sizeof(*hsu->chan), GFP_KERNEL);
-	if (!hsu->chan)
-		return -ENOMEM;
-
 	INIT_LIST_HEAD(&hsu->dma.channels);
 	for (i = 0; i < hsu->nr_channels; i++) {
 		struct hsu_dma_chan *hsuc = &hsu->chan[i];
diff --git a/drivers/dma/hsu/hsu.h b/drivers/dma/hsu/hsu.h
index 3bca577b98a1..f6ca1014bccf 100644
--- a/drivers/dma/hsu/hsu.h
+++ b/drivers/dma/hsu/hsu.h
@@ -71,11 +71,11 @@ struct hsu_dma_sg {
 struct hsu_dma_desc {
 	struct virt_dma_desc vdesc;
 	enum dma_transfer_direction direction;
-	struct hsu_dma_sg *sg;
 	unsigned int nents;
 	size_t length;
 	unsigned int active;
 	enum dma_status status;
+	struct hsu_dma_sg sg[] __counted_by(nents);
 };
 
 static inline struct hsu_dma_desc *to_hsu_dma_desc(struct virt_dma_desc *vdesc)
@@ -115,8 +115,8 @@ struct hsu_dma {
 	struct dma_device		dma;
 
 	/* channels */
-	struct hsu_dma_chan		*chan;
 	unsigned short			nr_channels;
+	struct hsu_dma_chan		chan[] __counted_by(nr_channels);
 };
 
 static inline struct hsu_dma *to_hsu_dma(struct dma_device *ddev)
-- 
2.53.0


