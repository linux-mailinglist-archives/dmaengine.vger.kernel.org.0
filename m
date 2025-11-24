Return-Path: <dmaengine+bounces-7322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E01C80988
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 685634E5AD5
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862430149F;
	Mon, 24 Nov 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="dzB13r1A"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0B2874FE;
	Mon, 24 Nov 2025 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988636; cv=none; b=miSISEl7frP3d9WvuhAU4yRG/L37WUZnbuP0EwAdLqcg7EUQzomTxVN1dfuUudKLNw4wU438gmlsZbzMbH/Z7QtX6mKFWoKWv4HpVQ/cKT+nDfDVaKrtfXKSPTcX0Uu2ggW5NJakQNgpvgNxO1lW8zSJJ9rC1uPCijN3Aa6q75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988636; c=relaxed/simple;
	bh=Am/rzQ0IYN1ljIZfblco1hpJOru0W+mU/bl94mc/5G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjdi4bLM2WoCzr4XMDP31PIdciGs6LQP4bw9AUMgQeZUuli6KO/PP8Gvs+PDdfO7r92/U2gvQcB7ONGwvjQ4z7dupBvtHVVf9kuSBjXN/3LC0HtzbDG1AAqcB+eTn0ilCZDRAhI0Q+jGLw8OnP/1oxaFKNJbXKdbper1dysMjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=dzB13r1A; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42825443F3;
	Mon, 24 Nov 2025 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1763988632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRVv+nJggHB2NVFJ/jtfPoNfHMQMyOCHv8ab1FARrSg=;
	b=dzB13r1AD+HIfzQIx/Mne3asm8qnGJqH4bjY3KFT3uZV3QJsb+maCnAshydOabupYwLZ2n
	A3mnEOI5UBlYmUarhBaPJGDoSzl5ciWxl+U0WG/qaRxtnqfi5nZ4wV74/YkQG5/9rmmbj5
	HDve0mVOgM/Aipf0cTveQAU96+fo3jlsbpN4a+8r8LzCYsPH+CPZeH+gGtTNMwMYc/2zuO
	KhcYun0SyoOtnrivO1bhiyfP91TDEkcQ6MywLBAiHEBYH8SIiGLLGX1PzP1K+ahMYiyo57
	41fandHUeTki0AWiyFI0HYlDexUZQVbXxNP+vRxELrTRcpZXAtbV4vuXlZJ2zw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 24 Nov 2025 13:50:27 +0100
Subject: [PATCH 6/7] dma: mcf-edma: Fix error handler for all 64 DMA
 channels
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-dma-coldfire-v1-6-dc8f93185464@yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
In-Reply-To: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763988624; l=2788;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=Am/rzQ0IYN1ljIZfblco1hpJOru0W+mU/bl94mc/5G4=;
 b=pSeX/Ghnsxe14PHuZ07DpJROJmTRTD9gpx83nHaFNTGdx0jSTxS64TKYIitROwgd7YXn2QAWg
 X3q9OQ+PG7WBAanAlumYTZ3+cpLM5b6TXXD+F2ZWlq3B5RaLpN9SJMI
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeffjefhtdelhffhheevheeutefghfefteeluedvudfhgeegteeitddtuefhhfelteenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgsnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgspdhhvghlohephihoshgvlhhiqdihohgtthhordihohhsvghlihdrohhrghdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepkedprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhrt
 ghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Fix the DMA error interrupt handler to properly handle errors on all
64 channels. The previous implementation had several issues:

1. Returned IRQ_NONE if low channels had no errors, even if high
   channels did
2. Used direct status assignment instead of fsl_edma_err_chan_handler()
   for high channels

Split the error handling into two separate loops for the low (0-31)
and high (32-63) channel groups, using for_each_set_bit() for cleaner
iteration. Both groups now consistently use fsl_edma_err_chan_handler()
for proper error status reporting.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/mcf-edma-main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index dd64f50f2b0a70a4664b03c7d6a23e74c9bcd7ae..adae2914c23db3ce9244c0cb8d4208fd71874f76 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -12,6 +12,7 @@
 #include "fsl-edma-common.h"
 
 #define EDMA_CHANNELS		64
+#define EDMA_CHANS_PER_REG	(EDMA_CHANNELS / 2)
 #define EDMA_MASK_CH(x)		((x) & GENMASK(5, 0))
 
 static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
@@ -42,33 +43,33 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
-	unsigned int err, ch;
+	unsigned int ch;
+	unsigned long err;
+	bool handled = false;
 
+	/* Check low 32 channels (0-31) */
 	err = ioread32(regs->errl);
-	if (!err)
-		return IRQ_NONE;
-
-	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
-		if (err & BIT(ch)) {
+	if (err) {
+		handled = true;
+		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
 			fsl_edma_disable_request(&mcf_edma->chans[ch]);
 			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
 			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
+	/* Check high 32 channels (32-63) */
 	err = ioread32(regs->errh);
-	if (!err)
-		return IRQ_NONE;
-
-	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
-		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
-			fsl_edma_disable_request(&mcf_edma->chans[ch]);
-			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
-			mcf_edma->chans[ch].status = DMA_ERROR;
+	if (err) {
+		handled = true;
+		for_each_set_bit(ch, &err, EDMA_CHANS_PER_REG) {
+			fsl_edma_disable_request(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
+			iowrite8(EDMA_CERR_CERR(ch + EDMA_CHANS_PER_REG), regs->cerr);
+			fsl_edma_err_chan_handler(&mcf_edma->chans[ch + EDMA_CHANS_PER_REG]);
 		}
 	}
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int mcf_edma_irq_init(struct platform_device *pdev,

-- 
2.39.5


