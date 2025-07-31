Return-Path: <dmaengine+bounces-5925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC34B17521
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80AC3AF8D5
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E07241131;
	Thu, 31 Jul 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oJSEv3Hy"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530623CEFF;
	Thu, 31 Jul 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980117; cv=none; b=f9cgNo8nkptXM6l4g/vnk5nMbSENrR1fDnsJP7WjqXF8MKatZZBRDbA4k9l+p+2SS8JSQf70mGS9zs/VfYk+z/agkWl/PE5hyGWA42afjtkBq8VcDewqiun0z4/WCw86IMQzQEpNVhdS86AEVnNwPeWP2ry8UKA8n6sgpdT0oAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980117; c=relaxed/simple;
	bh=8kWaYMO4/TPF0++aa8eWEkKJzwuOUB0FYKWwLyDxXEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLNAUJxpevsLuBgNzMIiRjRcQBJ7mbA4bQ5RR+zfJZ/sLoHCYsHRvd6KxyclBhLooq+i1cu656gUulTZHdWrG/EzQDbYBlsmk36Fm1l7ajUctClZSJ1f3QxrPYU+KoFbGAmwP7oGZnO6FVGWKSIMg1mw4QO/KoTXEmRVi5JsFbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oJSEv3Hy; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3E204428E;
	Thu, 31 Jul 2025 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753980113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrXkFCzrUMvz3TNlu59g94FVpAyOWOwiIIhTB/3kxOg=;
	b=oJSEv3Hy6tjLUqerOs4tJYtpsHhqDtAD29rregL+jk3biP4961ck35BpL3qwpOYq+oRnEI
	7hog93NqLMOfpflBginPtJ7PTC2ErXltwlHilA9aWSZzE9d+K6WC1PPacbDU6Fb05JDmN5
	cMq4LpsWQ879/TilvevXgZUwuNjNg/4TSatfQ0VgLM2oJf4dWSfGQV1GDDwZ/jP45PmI//
	PV2MHluf2qD9obcFoN2yhbOWH871q9PybTHm4DOG6/yHPrq2+/hLMivyf/xtZtv8+KtWmv
	2GL2S5tmASQVwInxpAGcpV9ZUy1Qf/TcTtxtClWCvAyOJ89m0v1jUktE7atgbg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 31 Jul 2025 18:41:29 +0200
Subject: [PATCH 1/3] dmaengine: ti: k3-udma: Reduce completion polling
 delay
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-ti-dma-timeout-v1-1-33321d2b7406@bootlin.com>
References: <20250731-ti-dma-timeout-v1-0-33321d2b7406@bootlin.com>
In-Reply-To: <20250731-ti-dma-timeout-v1-0-33321d2b7406@bootlin.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhihghhorhhiihdrshhtrhgrshhhkhhosehtihdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgri
 iiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrrdhujhhfrghluhhsihesthhirdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh

DMA transfers may be slow if the peer device is slow (eg. a UART
controller, a SPI controller...). The completion worker is started very
early compared to the actual draining speed, leading to low speed
devices suffering from a full 1s delay before noticing the transfers are
done, further delaying the execution of their callback.

1s seems overly large for a polling delay, reduce it to arbitrarily
100us which is the minimum amount of time to transfer a byte (and see
some progress on the residue variable) on a 100kHz bus. Based on this
first measure, the next sleep will be much closer to what is actually
needed for the transfer to complete.

The 1 second polling delay involves that any device driver with a (very
standard) 1 second timeout will error out indicating a transfer error,
whereas the data has actually been transferred correctly.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Cc: stable@vger.kernel.org # 5.7
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
This issue has been observed by playing with the DMA controller on
Beagle Play.

The patch will not apply before v5.7 and probably do not need to be
backported before anyway.
---
 drivers/dma/ti/k3-udma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index aa2dc762140f6eee334f4506a592e72600ae9834..b2059baed1b2ffc81c10feca797c763e2a04a357 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1115,19 +1115,18 @@ static void udma_check_tx_completion(struct work_struct *work)
 			time_diff = ktime_sub(uc->tx_drain.tstamp,
 					      time_diff) + 1;
 			residue_diff -= uc->tx_drain.residue;
+			/*
+			 * Try to guess when we should check next time by
+			 * calculating rate at which data is being drained at
+			 * the peer device. Slow devices might have not yet
+			 * started, showing no progress. Use an arbitrary delay
+			 * in this case.
+			 */
 			if (residue_diff) {
-				/*
-				 * Try to guess when we should check
-				 * next time by calculating rate at
-				 * which data is being drained at the
-				 * peer device
-				 */
 				delay = (time_diff / residue_diff) *
 					uc->tx_drain.residue;
 			} else {
-				/* No progress, check again in 1 second  */
-				schedule_delayed_work(&uc->tx_drain.work, HZ);
-				break;
+				delay = 100000;
 			}
 
 			spin_unlock_irqrestore(&uc->vc.lock, flags);

-- 
2.50.1


