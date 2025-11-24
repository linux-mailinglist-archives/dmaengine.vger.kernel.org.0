Return-Path: <dmaengine+bounces-7326-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB2C80991
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFA324E6B3F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE066302CD0;
	Mon, 24 Nov 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="CJRdsx3Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B830148C;
	Mon, 24 Nov 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988638; cv=none; b=C+uRbcH+VvGtC7ietV+mQp+KW91js/ZPbalARne2NLphuIB4Z+H756N3k0FAt+zgSSXzXO2p+Mpc1PhdKzWoMaflMOzP5sRCsuF1cA73N3cm0/JB4uA6ZRMlYlPTw+R8xtIAoQLYusdNleq3n/96j+8azDYHNWGtYAroPPuORFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988638; c=relaxed/simple;
	bh=PxyHjH/UiLxDT0MWhbZ4dz/BirBhchQz9nA3F2FTYp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLe9CkB5tl9/HukKHmEjUpoz+1J3UDT26fmZdJczmYngPL1vPvJ4ecLxzhnviTpOqGEl4aFT+nhf8SqNPSOhbUJLZhIv6bpqXFvex7h80fDRTYFzAoNmp2idS0YNeIXloBBlSQxVpLHreOuzeeXi4ho0UOxxmMv9chvOm2VUR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=CJRdsx3Z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06413443ED;
	Mon, 24 Nov 2025 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1763988628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozLzF+fWx01MoD9aQyXZjPvCyi55DbAMQ97yOxrC6OI=;
	b=CJRdsx3ZnYjQiURA3jbjwk+GFY7Fqby0xLMgKfYfax6VlbU16WPGCIylgKt3AqWGgIxH5d
	fQSfQd1YqYFKWf+zu8EqoMPFwAhXcPI5V7nLQQ5EvrMDv92lEsa48bG8UrYKjr/jaNrbQw
	XeEf0eCZ9y1RuaOPkmCk6sW7xpQsnUVRBJUlt76NuKs8Xid7j3fmdaNAYuBX0+FCkAUQt1
	DASdw6VulebrWxs78+gi2WBOhjOFGBaWjhaybbt0tGJ4Oh8gTpEGkckgU+AwQzzA3i3nU0
	crVehfN91F+jEsZcez7QOWsXuwflJzBUZRs5XtP9tUm7RWgBqOfRdIgn1zxFVw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 24 Nov 2025 13:50:24 +0100
Subject: [PATCH 3/7] dma: mcf-edma: Add per-channel IRQ naming for
 debugging
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-dma-coldfire-v1-3-dc8f93185464@yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
In-Reply-To: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763988624; l=2436;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=PxyHjH/UiLxDT0MWhbZ4dz/BirBhchQz9nA3F2FTYp8=;
 b=bco11Z9osduN8tdyp+sOFgrSrlK9smZin/Ub2zzTWzUUv3LzWlg7qMttYwb7bjWil7DtHqtBh
 odXXRGQD2zlDML7pghxGGGgcQnRD73PgJT+tUSJKZcNOJ/xbgpOADJo
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeffjefhtdelhffhheevheeutefghfefteeluedvudfhgeegteeitddtuefhhfelteenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgspdhhvghlohephihoshgvlhhiqdihohgtthhordihohhsvghlihdrohhrghdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepkedprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhrt
 ghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Add dynamic per-channel IRQ naming to make DMA interrupt identification
easier in /proc/interrupts and debugging tools.

Instead of all channels showing "eDMA", they now show:
- "eDMA-0" through "eDMA-15" for channels 0-15
- "eDMA-16" through "eDMA-55" for channels 16-55
- "eDMA-tx-56" for the shared channel 56-63 interrupt
- "eDMA-err" for the error interrupt

This aids debugging DMA issues by making it clear which channel's
interrupt is being serviced.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/mcf-edma-main.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index f95114829d8006fe4558169888ff38037d7610de..8a7c1787adb1f66f3b6729903635b072218afad1 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -81,8 +81,12 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
 	if (!res)
 		return -1;
 
-	for (ret = 0, i = res->start; i <= res->end; ++i)
-		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
+	for (ret = 0, i = res->start; i <= res->end; ++i) {
+		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"eDMA-%d", i - res->start);
+
+		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
+	}
 	if (ret)
 		return ret;
 
@@ -91,15 +95,19 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
 	if (!res)
 		return -1;
 
-	for (ret = 0, i = res->start; i <= res->end; ++i)
-		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
+	for (ret = 0, i = res->start; i <= res->end; ++i) {
+		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"eDMA-%d", 16 + i - res->start);
+
+		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
+	}
 	if (ret)
 		return ret;
 
 	ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
 	if (ret != -ENXIO) {
 		ret = request_irq(ret, mcf_edma_tx_handler,
-				  0, "eDMA", mcf_edma);
+				  0, "eDMA-tx-56", mcf_edma);
 		if (ret)
 			return ret;
 	}
@@ -107,7 +115,7 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
 	ret = platform_get_irq_byname(pdev, "edma-err");
 	if (ret != -ENXIO) {
 		ret = request_irq(ret, mcf_edma_err_handler,
-				  0, "eDMA", mcf_edma);
+				  0, "eDMA-err", mcf_edma);
 		if (ret)
 			return ret;
 	}

-- 
2.39.5


