Return-Path: <dmaengine+bounces-5787-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DACB0329F
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3763E7AC481
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F397287519;
	Sun, 13 Jul 2025 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQhJPrVP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396A2874E1;
	Sun, 13 Jul 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430958; cv=none; b=opnj4I9riImgUzQL32iG2OEuO5VPSdvLMEX6fi97mXYMy4XJPvGYUGO0umef3C3L0JKVBefbx7wdYMf0eYaCEa4IcuCFed3J6rVOIBA8VoosX+kNHBnuCartxU2m/JRogXJwykACTq7pIgs7AgOGJJzpIbaBBnRrBuoIfgbV9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430958; c=relaxed/simple;
	bh=vCjR9l/2ifl81kRjbUqgUc73Cc/Bb0CwIdVVHnUqmxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqHDZgD/XI14HAG9Oozu+VUdCVXpxrK85vOWCwcX05VOnAa+qe+YGsND36ULjauMWCI9t3nS4I9KxD7l85oN7YFgFq9EUgfy5kx2nq2TIsSVdTtS6Knkctg58Uo1xotndK8ATWTNrnCv1MQNUBt+V0uQNpmiF7MWYV9oIMnKo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQhJPrVP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so769061966b.1;
        Sun, 13 Jul 2025 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752430955; x=1753035755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXx82M30xW2kCpWwnPxMPInFyBrFrSqnkyvpgRTA3A8=;
        b=MQhJPrVPhGJspFFbng6JGASsOnJ+M2urH2S994a0Y329ktNZJtEjNMjDPaScwa6iHx
         bd7YkVAojT2Mhow0OabZ/RXUhifwZE//Te7HiFzOWaJK8crDKw5ihVJr7ewReJ4f1FC0
         nO36YEtROuvDFuU4LcGiAJ3h0VvTEHVhoIFxX4NkVDRVhe+c5QhhZIFSHsB8Zr0q8Ple
         zfxO9MyyksDKx8LpwjfQ5ym1q9ATWyTMhXW4hgobYndoLo2fhtBamS6ACJzDHsKbBB7J
         C8cvMVAxtOGO8260Oq/w4pi/XKK5lfJn2GRzEFtnhZPmVah2lCzXBTW71WFFsJ6kUPsT
         xKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752430955; x=1753035755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXx82M30xW2kCpWwnPxMPInFyBrFrSqnkyvpgRTA3A8=;
        b=JcThW9i1y7mXW7t4qkgxve3W9Gca2o7kvQVLcgb6E3fEVq/YzYOfnl2eySZMa22Oap
         pcEJdRRwW+EvwTC51DQcCsx7XxmUeiDIyZerKOfOs1l20KbUi+hn1dPrm2prRhCs96Ys
         KRVqzuA1FyyiOQHb5t3LtyPGMlmb/7i3EjsnZs8pCfV9VfgW06Bp6IDYKU4LaXVo4HiQ
         6qwLHauvVkkMIrInFNL03vTHLRn3T3ex/UENRPKIH8lSiP6I4UOqDeFq5Ql14hSbDfsP
         3qaBPbRFXJNr499TROZPoNjiBcMOvf7l1jSC6sbqsKTmX8/rT0SRnc1uIubEaBZ0NKti
         jq5A==
X-Forwarded-Encrypted: i=1; AJvYcCUH/lZeLCngP3wBsCPbLBT5fQTO5yfaqiUPYaP+Hbwo0vyuAFCkesq2GyDavEeDkX+JcDmkprfWq2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZQbUDZOjo7kYepKoC7HksDOMZrLF/6its4m5LYjrwnb2xyFG
	Ofa9TLSINLVNQeo3MG0GiSD4R3muCPwfS2ekMudsKh7KGnz2VgOey4t6
X-Gm-Gg: ASbGncuJgC4Lmmc6bLyGlYQMHO0qABHkLfkIFekkBNDbb27o67df78mtyR2DIixiKxo
	GACq4KkM729F5Jc1SvJa8M4J//fAIi8+xVDENfuvCY+UbhTJmaWOxbL0oJ09fd4WC64nH2+5TiI
	FxsbZUHIEoiDzW5G/Z2BDdMjpB1XXcB7I91aw3vUzHOFNXvybY8U9aht5vc+ULeAeB89kqRVsBG
	EwfH7WSn8Iqo70oWko9acH4T99BBOAKQeeAVOJWKb4HlzqzRXe0aWn4ry6+rPiAHFLES4A57+lo
	ygd17jrPSLoiFQA+DnFABcdY5dwyR21D36DdLhoPm1W3F7cspvfliDaOHGEnSlPEkiDA9AcnAbn
	uKiHBlRhiwTG+wPR1XXSJksXfeQ2u0n+eXEOpoku/lQC6vvAZ/9AM+O08EpkZlDC0+bvWt9lTe7
	ZP/ObTdSVUn2IjdCxfa+6sfHlmyLspYm+qBnvtfxQ66UNv1s4b2M6287DNgw==
X-Google-Smtp-Source: AGHT+IG833IcCg0t1s6QmZk1L9wmlkYuHn/xOdyvUYfSqkkPxC6g75xiWEA/hejcDwqn1HkUcHw7Dg==
X-Received: by 2002:a17:907:3e9f:b0:ae0:c092:ee12 with SMTP id a640c23a62f3a-ae6fb8a8660mr1067317966b.22.1752430954408;
        Sun, 13 Jul 2025 11:22:34 -0700 (PDT)
Received: from chimera.arnhem.chello.nl (2001-1c08-0704-3500-e8db-9ca5-bd37-0cbc.cable.dynamic.v6.ziggo.nl. [2001:1c08:704:3500:e8db:9ca5:bd37:cbc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df56esm686869066b.156.2025.07.13.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 11:22:33 -0700 (PDT)
From: Thomas Andreatta <thomasandreatta2000@gmail.com>
X-Google-Original-From: Thomas Andreatta <thomas.andreatta2000@gmail.com>
To: vkoul@kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Thomas Andreatta <thomas.andreatta2000@gmail.com>
Subject: [PATCH] drivers: dma: sh: setup_xref error handling
Date: Sun, 13 Jul 2025 20:20:55 +0200
Message-Id: <20250713182054.795254-1-thomas.andreatta2000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the type of setup_xref from void to int and handles
errors since the function can fail.

`setup_xref` now returns the (eventual) error from
`dmae_set_dmars`|`dmae_set_chcr`, while `shdma_tx_submit` handles the
result, removing the chunks from the queue and marking PM as idle in
case of an error.

First time hittin DMA, if something's off every feedback is welcome.

Signed-off-by: Thomas Andreatta <thomas.andreatta2000@gmail.com>
---
 drivers/dma/sh/shdma-base.c | 25 +++++++++++++++++++------
 drivers/dma/sh/shdmac.c     | 17 +++++++++++++----
 include/linux/shdma-base.h  |  2 +-
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 6b4fce453c85..834741adadaa 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -129,12 +129,25 @@ static dma_cookie_t shdma_tx_submit(struct dma_async_tx_descriptor *tx)
 			const struct shdma_ops *ops = sdev->ops;
 			dev_dbg(schan->dev, "Bring up channel %d\n",
 				schan->id);
-			/*
-			 * TODO: .xfer_setup() might fail on some platforms.
-			 * Make it int then, on error remove chunks from the
-			 * queue again
-			 */
-			ops->setup_xfer(schan, schan->slave_id);
+
+			ret = ops->setup_xfer(schan, schan->slave_id);
+			if (ret < 0) {
+				dev_err(schan->dev, "setup_xfer failed: %d\n", ret);
+
+				/* Remove chunks from the queue and mark them as idle */
+				list_for_each_entry_safe(chunk, c, &schan->ld_queue, node) {
+					if (chunk->cookie == cookie) {
+						chunk->mark = DESC_IDLE;
+						list_move(&chunk->node, &schan->ld_free);
+					}
+				}
+
+				schan->pm_state = SHDMA_PM_ESTABLISHED;
+				ret = pm_runtime_put(schan->dev);
+
+				spin_unlock_irq(&schan->chan_lock);
+				return ret;
+			}
 
 			if (schan->pm_state == SHDMA_PM_PENDING)
 				shdma_chan_xfer_ld_queue(schan);
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 093e449e19ee..603e15102e45 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -300,21 +300,30 @@ static bool sh_dmae_channel_busy(struct shdma_chan *schan)
 	return dmae_is_busy(sh_chan);
 }
 
-static void sh_dmae_setup_xfer(struct shdma_chan *schan,
-			       int slave_id)
+static int sh_dmae_setup_xfer(struct shdma_chan *schan, int slave_id)
 {
 	struct sh_dmae_chan *sh_chan = container_of(schan, struct sh_dmae_chan,
 						    shdma_chan);
 
+	int ret = 0;
 	if (slave_id >= 0) {
 		const struct sh_dmae_slave_config *cfg =
 			sh_chan->config;
 
-		dmae_set_dmars(sh_chan, cfg->mid_rid);
-		dmae_set_chcr(sh_chan, cfg->chcr);
+		ret = dmae_set_dmars(sh_chan, cfg->mid_rid);
+		if (ret < 0)
+			goto END;
+
+		ret = dmae_set_chcr(sh_chan, cfg->chcr);
+		if (ret < 0)
+			goto END;
+
 	} else {
 		dmae_init(sh_chan);
 	}
+
+END:
+	return ret;
 }
 
 /*
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 6dfd05ef5c2d..03ba4dab2ef7 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -96,7 +96,7 @@ struct shdma_ops {
 	int (*desc_setup)(struct shdma_chan *, struct shdma_desc *,
 			  dma_addr_t, dma_addr_t, size_t *);
 	int (*set_slave)(struct shdma_chan *, int, dma_addr_t, bool);
-	void (*setup_xfer)(struct shdma_chan *, int);
+	int (*setup_xfer)(struct shdma_chan *, int);
 	void (*start_xfer)(struct shdma_chan *, struct shdma_desc *);
 	struct shdma_desc *(*embedded_desc)(void *, int);
 	bool (*chan_irq)(struct shdma_chan *, int);
-- 
2.34.1


