Return-Path: <dmaengine+bounces-7324-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85CC8098E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA8AF4E5B76
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27283019A3;
	Mon, 24 Nov 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="U15TD4HS"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157F30102C;
	Mon, 24 Nov 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988637; cv=none; b=OYXnKvjLrA2VdE8pONmwuXoJpH62tynQCog1tnxUIOd18+nCQP9QLv3E+zsm5FIKG6ozWk4BxRXoKOkjxKPlFa1ic3uUD6JdvbqPc38tIjj5c4hv8yaJnPsP0ew22tdNjiaDlFsgyE4fJhOITaAwmpjk98Fp9A5Va/3m1wOwGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988637; c=relaxed/simple;
	bh=FKaWobWJViggwPnsZtfIAribt87lp1BCi3e4jWWfCu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0nbJIfvHkLIXux5Lg5RmxGK4sfJWJYweJS6csjWdm+aHvAa1COznqc23bNqjeazqp2mUw4IHjHuNUAal6RqHGNC93htRN0JhSHicenYR2WnO19vSYDBJ60qpMqKbPF25qzy4MCOlqGmlDw+/Lyb70WykLn6hWs4JSPo73tmpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=U15TD4HS; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FC6B443B9;
	Mon, 24 Nov 2025 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1763988633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFRCqjmZTDjYwXs9mHTwQzP6v0YfpJFAmMSvBfVoyHo=;
	b=U15TD4HSkHAMYItwQM7vgmkCbaMyiG3kyDRBFaP2O/KBbGwQj5GrzmTqqROk/aFmUxzUbq
	4rIjnPLXZYH1vb59EClBZlAxQlrAS9UqXDw+OQuYeTfGJS86JOi3TvboKSvweq20u0Sp65
	F8BXhrLFan5PJzJU05z3EL+FcX2kWn4tjvAY2fYNGlAHzd3wzi+D6EkdPQWTjnS3r/PAJw
	GyK+uEynZcAJ02L++y2CwHCRaFhuuGvZOIbXRzNTFkqmrZH612LRTpqtrQ1AQ6KAJhSQkA
	qYEc+fyNrShgSqsqlb/HhDY0sdxvLqJmWs41q5dFMONG4y/+oPfCKB6lVMea/Q==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 24 Nov 2025 13:50:28 +0100
Subject: [PATCH 7/7] dma: fsl-edma: Support source stride for interleaved
 DMA transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-dma-coldfire-v1-7-dc8f93185464@yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
In-Reply-To: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763988624; l=1817;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=FKaWobWJViggwPnsZtfIAribt87lp1BCi3e4jWWfCu4=;
 b=ZCvvR4NFd0F1MK2oKb9mLxd1UhjGQdDhiI93WRdjZ8MUKl+Tun9eVHJkDV+PuaxjlNBCCM579
 V56STaWPPNZAxi75LsvF9ncwbF4axnDWG15e2rq6Bwf3k9ny25yVMFd
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeffjefhtdelhffhheevheeutefghfefteeluedvudfhgeegteeitddtuefhhfelteenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgsnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgspdhhvghlohephihoshgvlhhiqdihohgtthhordihohhsvghlihdrohhrghdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepkedprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhrt
 ghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Add support for using src_port_window_size to configure the source
address stride (SOFF) in DMA transfers. This enables interleaved
memory access patterns needed for applications like stereo audio
de-interleaving.

When src_port_window_size is set, the source offset is calculated as:
  SOFF = src_port_window_size * dst_addr_width

This allows DMA to skip samples in memory while writing consecutive
samples to the device, enabling efficient stereo-to-mono de-interleaving
without CPU intervention.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/fsl-edma-common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 40ac6a7d8480b9ed2c6a2bdec59b4fda5fcb6271..e510cab24382fa557a2623465393c852b616fef3 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -647,6 +647,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
 			if (fsl_chan->cfg.dst_port_window_size)
 				doff = fsl_chan->cfg.dst_addr_width;
+			if (fsl_chan->cfg.src_port_window_size)
+				soff = fsl_chan->cfg.src_port_window_size *
+					fsl_chan->cfg.dst_addr_width;
 		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = dma_buf_next;
@@ -714,6 +717,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
 			doff = 0;
+			if (fsl_chan->cfg.src_port_window_size)
+				soff = fsl_chan->cfg.src_port_window_size *
+					fsl_chan->cfg.dst_addr_width;
 		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = sg_dma_address(sg);

-- 
2.39.5


