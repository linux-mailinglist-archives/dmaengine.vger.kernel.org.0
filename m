Return-Path: <dmaengine+bounces-7327-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6BC80952
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68B8A34441B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104D30171E;
	Mon, 24 Nov 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="UVOph1kT"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A830101A;
	Mon, 24 Nov 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988641; cv=none; b=keFTQPzKqna2zxmWTN6K9S84zgAs2AN9ZrR650LNKnI6gqfg6XZOtVuMFls8yPHClMrKg6xxS7JrKBPWXbR13YJ8gdzy0JwKt6FZOADHrOeTAjkpXrRc5o3uLagTULQm2Owzyfn4FPOOeJqjjBSUCOBNMNyvYnCCLoB26b3JZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988641; c=relaxed/simple;
	bh=8QaBSNeO5kdt+ln9LrPGqaa9zAB6if0CpaKn6ztCju4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiaRlugQaPcydbVLrP//p7ZAPulmecIGlMXHDma00d6m11yVkAcubAxtIS8hvsiAMUjRKiGL+7HUPW/kBRONRWIBkqYDX8MrfzOyE1iCw9ClYht0KcqKUpS7poV9L+lcNicmNDlnDpvZDyn+29oDoEg5B8f8Xw7RRWLbIH/Jw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=UVOph1kT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D3D14439A;
	Mon, 24 Nov 2025 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1763988630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJi0EEOLF66K6fXIemZGZRw8QFUtMWuNIXre435RcYA=;
	b=UVOph1kTSpJbSVFk3tvG7/Hi5yqgtCk18z1xrAoyG7xcSsNDMsKu4EkGyoYILcs8x++c9z
	vFa3PRRylRTat8PF+2VJgubk8UmW+MtyqU0h5ryeI1BF080ZMJgdKGscc4UJe/gI3tWdIS
	nAmN01Z2apdSCnzRO+qaO512ELI0/Crg4aRmwR++fxxe5nHMutATjxvnASAZnMi1gQxZVb
	gxReGkAi4Tn7XNavm04IKELQ4HBFqADmRdxXG1+rufkXg4eLojhlA52kYwrhUbid1WPau+
	xUQLnL+x48Gtn92EdbrZYj6ohqsfq1vfTl2Xz+t5dzwnyemAbmxuQUa8Sorpeg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 24 Nov 2025 13:50:25 +0100
Subject: [PATCH 4/7] dma: mcf-edma: Fix interrupt handler for 64 DMA
 channels
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-dma-coldfire-v1-4-dc8f93185464@yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
In-Reply-To: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763988624; l=1748;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=8QaBSNeO5kdt+ln9LrPGqaa9zAB6if0CpaKn6ztCju4=;
 b=nTQkhwNpZuZNtopipUrgh4Bamgu+noJJ30i88aDiz3p9k+OYlWp9HPOhWXG5PsswvIlTfQksb
 t5Dhfp174RMBeCwkS7MqC/7mGBpqdjkyEwMh9HzD7jTeXuIb6kbL56I
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeffjefhtdelhffhheevheeutefghfefteeluedvudfhgeegteeitddtuefhhfelteenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgspdhhvghlohephihoshgvlhhiqdihohgtthhordihohhsvghlihdrohhrghdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepkedprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhrt
 ghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Fix the DMA completion interrupt handler to properly handle all 64
channels on MCF54418 ColdFire processors.

The previous code used BIT(ch) to test interrupt status bits, which
causes undefined behavior on 32-bit architectures when ch >= 32 because
unsigned long is 32 bits and the shift would exceed the type width.

Replace with bitmap_from_u64() and for_each_set_bit() which correctly
handle 64-bit values on 32-bit systems by using a proper bitmap
representation.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/mcf-edma-main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 8a7c1787adb1f66f3b6729903635b072218afad1..dd64f50f2b0a70a4664b03c7d6a23e74c9bcd7ae 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -18,7 +18,8 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
-	unsigned int ch;
+	unsigned long ch;
+	DECLARE_BITMAP(status_mask, 64);
 	u64 intmap;
 
 	intmap = ioread32(regs->inth);
@@ -27,11 +28,11 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	if (!intmap)
 		return IRQ_NONE;
 
-	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
-		if (intmap & BIT(ch)) {
-			iowrite8(EDMA_MASK_CH(ch), regs->cint);
-			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
-		}
+	bitmap_from_u64(status_mask, intmap);
+
+	for_each_set_bit(ch, status_mask, mcf_edma->n_chans) {
+		iowrite8(EDMA_MASK_CH(ch), regs->cint);
+		fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
 	}
 
 	return IRQ_HANDLED;

-- 
2.39.5


