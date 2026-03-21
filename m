Return-Path: <dmaengine+bounces-9570-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H5QTAWkVvmmzGAMAu9opvQ
	(envelope-from <dmaengine+bounces-9570-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 21 Mar 2026 04:50:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8A2E3275
	for <lists+dmaengine@lfdr.de>; Sat, 21 Mar 2026 04:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54D0230107E4
	for <lists+dmaengine@lfdr.de>; Sat, 21 Mar 2026 03:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912A33E347;
	Sat, 21 Mar 2026 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO4Yesqh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79BF30F812
	for <dmaengine@vger.kernel.org>; Sat, 21 Mar 2026 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774064992; cv=none; b=IGM5L4ZFH9XkrUA4l7dc5XfBxekL8yk9AQv5l/mWTS+pku/0SiP+cDFm6y6xP96Aar2EiPy61jtpppwMuw1/9ZD9LG2bP4XA0p/tcZfa/SmxusHaTwFz86tJpbC/qUUfN55ISB5dlw6OJYSJ+ixYqMj2oiqD6E3U/B0kDwjT55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774064992; c=relaxed/simple;
	bh=sUucHyftZa0FYePXO3IcRk8QdWluSoIklCyhxwTdv74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzBxL4Rf83fdG+qm83SsrjgoJIJjSCWZQMwHc3H0HwGXGuumxJgJt3H8qw9gPQjn1mTGNQ7HzNFF2xT4ZUd++FNw428BcV0P/7D0I6paLud7UZKIhm9Kkj//V32IHAW71A3WX6qnJVWbluGylpoiSp3HsiWGQAEH/g76fU7D9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO4Yesqh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so32892555ad.2
        for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774064989; x=1774669789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8rhPFZF8wJ82HmtlvMV9Pq9jCuJhWYy0x5uY1ldnvU=;
        b=XO4Yesqh9Gu7zSBwl6mwZ/+pFfrtNotjIlWpVI30X/PxgFfGH38hD9s5TtfJDuk0Nn
         f/dHbnKxdGsNdfGX5rJ/Jbq2UWhzvO+y73g2Z+/XuQWputQgOXZiig5sOTyvaj+rKxou
         tYXNSeVUnIAURC8m5jIA0kZRRVe0WjfCRcC3u8cTJR6VKSCP8e9nh6nlf7UzwarbzddV
         R2HGbN8zn85c+YLoY+RUCTpQwBc1nJeq3XCGT9VN5IeAC5f8dFgsPBtqcIUv6kPiAVrG
         NX64Yt/MgPv+g3xHmv+KAAkBy9bdPOBvYkUbmGu50mxIRwBwTLHPHaDCi1j+XeIIaLuN
         V9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774064989; x=1774669789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8rhPFZF8wJ82HmtlvMV9Pq9jCuJhWYy0x5uY1ldnvU=;
        b=WO8TvlDGA9R2di4UL0efgtQ37c0NwazSzB5eC7HNiLFQTcust1kIXyLItDoz8dRQ8x
         l/hJNlXBYOf2l2nsfJsTqIqbT+U34nYkBnTHQfvXhE1DSppTwSIgxNZg6NPEwQGMcKyA
         o4BgcNm9qO40wVLaHxAjOlUT8yGoOjmzzZe8DL8mHpv/rgVJuW22oOKFGsXCno5/uIQN
         SuWCjG298zAFXhsGzy5oc5LlMRqoFm7ZzBHf5yBdKQTm+5iW/CLm2FAekSB7qiLLo+Ab
         PADPaOzYMLMhQkyyovsd1ilwZ3l+452twHy7IP3llwg9yX/9Nr1r/OoGgaBqhugGAoiK
         zdGw==
X-Gm-Message-State: AOJu0Yy9101xENv4eHtezAcsMei49zZ7/JLUIOFz0MJJMUEFzxpjkHZ+
	s4VUHop2OAWGhhEe6hpLRExbt2+6As/BVNxogPM9izPkdeF5oaepkxM07RAPjG4p
X-Gm-Gg: ATEYQzzFJ6y6+2f81dh631HC69sogvAZiHFqbyzJE3EJ4X6qEaUye373P2tgo5/7THK
	b3LtB3eW6q1HypbR/tNr1fn+gnMSi6s32RhU0GRw1sG/kBCiERfpLaVWuLoqZrKegX3fdPwLx+J
	rAFyb2fNFT2Xn2gmXfAcsMDwY1lXsDJtOH/9oWvhSs6SYbEH0G6dQJL5CJuaVo/wRlcLmQfBG7t
	P+LkyEIbr8zlC4TemljQOBovRaSyQLZqMgCermeiYqaKTaMNuNo8MGPBz4b4UNNLUWrgvMyqjDX
	JH5SWrx9NblBBbpQSbhnCTryo1NgOfTbmdZHKWbGzuQVK7Iro27sP8cQbDMgaraaGkFxTOv5d8z
	Cv647hWbck/B+Yn7+IgsKKg/oeB9E/5LG5dt1g/Dn1CQYn9GXuq+Ws/94XZwzBmRDOXUMQu+Meb
	7zu9UsZ0M2D2UI5tNmO/vKgnZ3W5XvE1l9odZXQpni+ZsaBQqhxijBRm4=
X-Received: by 2002:a17:902:d4c5:b0:2ad:dfb8:8ed3 with SMTP id d9443c01a7336-2b0826d7570mr47830505ad.8.1774064989651;
        Fri, 20 Mar 2026 20:49:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835161a0sm46218305ad.10.2026.03.20.20.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:49:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] dmaengine: idma64: use kzalloc_flex
Date: Fri, 20 Mar 2026 20:49:31 -0700
Message-ID: <20260321034931.9950-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9570-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BC8A2E3275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Remove idma64_alloc_desc. It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct idma64_dma and devm_kzalloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: allocate with GFP_NOWAIT. Was mistakenly removed.
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
2.53.0


