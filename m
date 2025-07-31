Return-Path: <dmaengine+bounces-5926-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC71B1751F
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 18:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BAA1C25B2B
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010EF27A913;
	Thu, 31 Jul 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dtcWBCy1"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890223D29B;
	Thu, 31 Jul 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980117; cv=none; b=tlVsgglS6trz04PdM/3XJ/w+N/EhrPSCXGKeQ+YfwSXQeKe8k1bXACxdgXqoqIGKGXRcEtBZt3Rz4J17fjJdn6I9sozfuQDiFYwvYs6TX0YwdfgX2BDNJbNJlFsQZek3x8fAZN7SPLvN1L+DmMbg1dGNdUf7uE/ULBbgdAHfEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980117; c=relaxed/simple;
	bh=J7RNG/7xvpoBqH05h6aB+j8xGF21xMDc3MAc75QY2lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ct1jvXvEKmH0SSjuikJl6UgtU63Wtzy6RBFI0oQ0bnOVOrZZkbUA3cFpDGuM9HjxS3yIUiILQJyb57ORyBvzQAnUODKcG6TfOiCswHcA7YuIzYenphx6ne433aeZTiKBNpL41sFFYHhsWQ2ZTYt+bI30r2JFjvdRSKnkEqlfwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dtcWBCy1; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E270F442A7;
	Thu, 31 Jul 2025 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753980114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju676odYa3fzthpZBub6TEXhiCg5nHSgO4/BZxB4t/c=;
	b=dtcWBCy1JonFpo/ZMWfC0X9ELTP8QJ1OFRCbY8nhzd0+hwcTHcK4NCzmcQnH5OCoR9VPRN
	uNGi+VyDFifLwJMUREKuLWZns2f2W73DQHvtTx8DO11HHlAPTmLd+0VmQSXn7bFiEWiBse
	qDy17syGZN8SoMH7q+ZRTfF7FweVgGs4Q4kLHqqdtfWGm3IlrMTCqKAGKRh6NNGDX4re7T
	x5fjcTjMJtOZh5YeACgTI+TeXYDdTAgk/2KY+rIoKPpw/FQ7/QFuYj2vV/6SmFxa63jrB3
	yBIuNQjqKhhgumpfmnW6BkFUEdS2Ow5QvmlXJ/BJLLdNiRklfN4RYfxGGIRbcg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 31 Jul 2025 18:41:31 +0200
Subject: [PATCH 3/3] dmaengine: ti: k3-udma: Simplify the completion worker
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-ti-dma-timeout-v1-3-33321d2b7406@bootlin.com>
References: <20250731-ti-dma-timeout-v1-0-33321d2b7406@bootlin.com>
In-Reply-To: <20250731-ti-dma-timeout-v1-0-33321d2b7406@bootlin.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhihghhorhhiihdrshhtrhgrshhhkhhosehtihdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgri
 iiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehpvghtvghrrdhujhhfrghluhhsihesthhirdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehpvghtvghrrdhujhhfrghluhhsihesghhmrghilhdrtghomh

The function does nothing in the !uc->desc condition.

No need to go through the entire delay guessing logic if the descriptor
is already done when we first check.

Invert the "no descriptor" and "descriptor done" conditions. This
greatly simplifies the function by dropping two indentation levels and
improves the readability.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/ti/k3-udma.c | 86 ++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 50 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 11232b306475edd5e1ed75d938bbf49ed9c2aabd..fb323df15a1b6693d917750f18f907e63bb38c53 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1087,69 +1087,55 @@ static void udma_check_tx_completion(struct work_struct *work)
 {
 	struct udma_chan *uc = container_of(work, typeof(*uc),
 					    tx_drain.work.work);
-	bool desc_done = true;
+	struct udma_desc *d = uc->desc;
+	bool desc_done;
 	u32 residue_diff;
 	ktime_t time_diff;
 	unsigned long delay;
 	unsigned long flags;
 
+	if (!d)
+		return;
+
 	while (1) {
 		spin_lock_irqsave(&uc->vc.lock, flags);
 
-		if (uc->desc) {
-			/* Get previous residue and time stamp */
-			residue_diff = uc->tx_drain.residue;
-			time_diff = uc->tx_drain.tstamp;
-			/*
-			 * Get current residue and time stamp or see if
-			 * transfer is complete
-			 */
-			desc_done = udma_is_desc_really_done(uc, uc->desc);
-		}
-
-		if (!desc_done) {
-			/*
-			 * Find the time delta and residue delta w.r.t
-			 * previous poll
-			 */
-			time_diff = ktime_sub(uc->tx_drain.tstamp,
-					      time_diff) + 1;
-			residue_diff -= uc->tx_drain.residue;
-			/*
-			 * Try to guess when we should check next time by
-			 * calculating rate at which data is being drained at
-			 * the peer device. Slow devices might have not yet
-			 * started, showing no progress. Use an arbitrary delay
-			 * in this case.
-			 */
-			if (residue_diff) {
-				delay = (time_diff / residue_diff) *
-					uc->tx_drain.residue;
-				if (delay < 1000)
-					delay = 1000;
-			} else {
-				delay = 100000;
-			}
-
-			spin_unlock_irqrestore(&uc->vc.lock, flags);
-
-			usleep_range(ktime_to_us(delay),
-				     ktime_to_us(delay) + 10);
-			continue;
-		}
-
-		if (uc->desc) {
-			struct udma_desc *d = uc->desc;
-
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
-			vchan_cookie_complete(&d->vd);
+		/* Get previous residue and time stamp */
+		residue_diff = uc->tx_drain.residue;
+		time_diff = uc->tx_drain.tstamp;
+		/* Get current residue and time stamp or see if transfer is complete */
+		desc_done = udma_is_desc_really_done(uc, uc->desc);
+		if (desc_done)
 			break;
+
+		/* Find the time delta and residue delta w.r.t previous poll */
+		time_diff = ktime_sub(uc->tx_drain.tstamp, time_diff) + 1;
+		residue_diff -= uc->tx_drain.residue;
+		/*
+		 * Try to guess when we should check next time by
+		 * calculating rate at which data is being drained at
+		 * the peer device. Slow devices might have not yet
+		 * started, showing no progress. Use an arbitrary delay
+		 * in this case.
+		 */
+		if (residue_diff) {
+			delay = (time_diff / residue_diff) * uc->tx_drain.residue;
+			if (delay < 1000)
+				delay = 1000;
+		} else {
+			delay = 100000;
 		}
 
-		break;
+		spin_unlock_irqrestore(&uc->vc.lock, flags);
+
+		usleep_range(ktime_to_us(delay),
+			     ktime_to_us(delay) + 10);
 	}
 
+	udma_decrement_byte_counters(uc, d->residue);
+	udma_start(uc);
+	vchan_cookie_complete(&d->vd);
+
 	spin_unlock_irqrestore(&uc->vc.lock, flags);
 }
 

-- 
2.50.1


