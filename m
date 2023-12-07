Return-Path: <dmaengine+bounces-396-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43006808942
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1376283134
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696E3D0C9;
	Thu,  7 Dec 2023 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd60ctfh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E7123;
	Thu,  7 Dec 2023 05:35:04 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce32821a53so444814b3a.0;
        Thu, 07 Dec 2023 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956104; x=1702560904; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRTzlruS03W9af/VQ5z7QRDszsj8/IYotlOynmYM3G8=;
        b=gd60ctfhqdAJeSenjc7HWhJyG/vHJSmX1k/u8CeudLcV+1UeZdZN6Fah0JKszmY9Bb
         0bjV7qvzj9V07v/FFaXSrutS00s/MmPr3qDGD/DwlZ6Np5VdcY/QjUGQ0pvTmHH1v9hK
         0bp0ATvs6CwOxSuIOndLLlEa7XJ9NyHK2hm76tBFiwzCb30wSXGBKRLoNtqOFhb+KloD
         rCiF2jrHUdnGoTteqvRCK6YN546aGexIvytDQIuSFEXmUVneTPahK1J5L1DTzwZBILBV
         Tqzc40PtywOrjRWe653jqvKgxztHXOg0MTV6AoIObDMenU+pRBnY5Raip82YTjS0xg+m
         QaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956104; x=1702560904;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRTzlruS03W9af/VQ5z7QRDszsj8/IYotlOynmYM3G8=;
        b=iufawzxmQlxZY/Tgn3+TvcHZ3Qh4GfGTP78A+7sk42QTbSEIHEk7RGaqZBh4fGu4x9
         amh54NuVFPlGAEDptRuDidL1jbUjKFZMrawwSPay3TFk5Pnny7QSYpiCgSiw5NbpVJhH
         fMyNjKGJJ6bG332f6gQbjlxFrb/i3YFBbdtKkZt0oWS9mgCihXunqc3AUYz8zIgeSZxn
         cndtcr4DNxrOIU/eVRCdmH1R6SJ0Si5d31SEj9HVjmXC3zc3ZTEJl7elqi0VypXF/AIn
         ROwCdUdcyt0psA7i5doT7BaPPJfEcnE+qQiAc1RmkP/hckSYXNN3oWiN1YkiIy7A/5S2
         3Jxg==
X-Gm-Message-State: AOJu0YydumiMeiUVvIeRljf7pY3hI5E/iFaFDlxEewhvvM3MFYGdEmxs
	PPXPF11s/xgaOKyc81oEAW0=
X-Google-Smtp-Source: AGHT+IHFIIBb/Pc2NOsSGu4FGrav3Qw1ptK/bHaF+FmbByi3IJkvRqbxEBe5UfCHredzqwZQQYnSqg==
X-Received: by 2002:a05:6a00:8d93:b0:6ce:60d7:2aa0 with SMTP id im19-20020a056a008d9300b006ce60d72aa0mr2207083pfb.55.1701956103608;
        Thu, 07 Dec 2023 05:35:03 -0800 (PST)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b006ce7d0d2590sm1299176pfa.0.2023.12.07.05.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:35:03 -0800 (PST)
From: Chengfeng Ye <dg573847474@gmail.com>
To: vkoul@kernel.org,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	christophe.jaillet@wanadoo.fr
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] dmaengine: pch_dma: Fix potential deadlock on &pd_chan->lock
Date: Thu,  7 Dec 2023 13:34:52 +0000
Message-Id: <20231207133452.14726-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

As &pd_chan->lock is acquired by pdc_tasklet() under softirq context,
other acquisition of the same lock under process context should at least
disable bottom half, otherwise deadlock could happen if the tasklet
preempts the execution while the lock is held under process context on
the same CPU.

pd_issue_pending(), pd_tx_submit(), pdc_desc_put() and pdc_desc_get()
seem like that could execute under process context without bottom half
disaled.

One Possible deadlock scenario:
pd_prep_slave_sg()
    -> pdc_desc_put()
    -> spin_lock(&pd_chan->lock)
        <tasklet softirq interruption>
        -> pdc_tasklet()
        -> spin_lock_irqsave(&pd_chan->lock, flags); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_bh() to
disable bottom half while lock is held.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
V2: change to spin_lock_bh() instead of spin_lock_irqsave()

 drivers/dma/pch_dma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index c359decc07a3..2c4e479ca124 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -410,7 +410,7 @@ static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 	struct pch_dma_desc *desc = to_pd_desc(txd);
 	struct pch_dma_chan *pd_chan = to_pd_chan(txd->chan);
 
-	spin_lock(&pd_chan->lock);
+	spin_lock_bh(&pd_chan->lock);
 
 	if (list_empty(&pd_chan->active_list)) {
 		list_add_tail(&desc->desc_node, &pd_chan->active_list);
@@ -419,7 +419,7 @@ static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 		list_add_tail(&desc->desc_node, &pd_chan->queue);
 	}
 
-	spin_unlock(&pd_chan->lock);
+	spin_unlock_bh(&pd_chan->lock);
 	return 0;
 }
 
@@ -447,7 +447,7 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 	struct pch_dma_desc *ret = NULL;
 	int i = 0;
 
-	spin_lock(&pd_chan->lock);
+	spin_lock_bh(&pd_chan->lock);
 	list_for_each_entry_safe(desc, _d, &pd_chan->free_list, desc_node) {
 		i++;
 		if (async_tx_test_ack(&desc->txd)) {
@@ -457,15 +457,15 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 		}
 		dev_dbg(chan2dev(&pd_chan->chan), "desc %p not ACKed\n", desc);
 	}
-	spin_unlock(&pd_chan->lock);
+	spin_unlock_bh(&pd_chan->lock);
 	dev_dbg(chan2dev(&pd_chan->chan), "scanned %d descriptors\n", i);
 
 	if (!ret) {
 		ret = pdc_alloc_desc(&pd_chan->chan, GFP_ATOMIC);
 		if (ret) {
-			spin_lock(&pd_chan->lock);
+			spin_lock_bh(&pd_chan->lock);
 			pd_chan->descs_allocated++;
-			spin_unlock(&pd_chan->lock);
+			spin_unlock_bh(&pd_chan->lock);
 		} else {
 			dev_err(chan2dev(&pd_chan->chan),
 				"failed to alloc desc\n");
@@ -478,11 +478,12 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 static void pdc_desc_put(struct pch_dma_chan *pd_chan,
 			 struct pch_dma_desc *desc)
 {
+
 	if (desc) {
-		spin_lock(&pd_chan->lock);
+		spin_lock_bh(&pd_chan->lock);
 		list_splice_init(&desc->tx_list, &pd_chan->free_list);
 		list_add(&desc->desc_node, &pd_chan->free_list);
-		spin_unlock(&pd_chan->lock);
+		spin_unlock_bh(&pd_chan->lock);
 	}
 }
 
@@ -557,9 +558,9 @@ static void pd_issue_pending(struct dma_chan *chan)
 	struct pch_dma_chan *pd_chan = to_pd_chan(chan);
 
 	if (pdc_is_idle(pd_chan)) {
-		spin_lock(&pd_chan->lock);
+		spin_lock_bh(&pd_chan->lock);
 		pdc_advance_work(pd_chan);
-		spin_unlock(&pd_chan->lock);
+		spin_unlock_bh(&pd_chan->lock);
 	}
 }
 
-- 
2.17.1


