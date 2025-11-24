Return-Path: <dmaengine+bounces-7323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA1C8093A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A842E343FE9
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDFA30171B;
	Mon, 24 Nov 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="DUO3Q/4D"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A43009F8;
	Mon, 24 Nov 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988637; cv=none; b=uX7RXO87QerR0QklOO4z53Z9QqipmwHB+bTfhvjIeV+RN5ZXZqq1SFeYIHgcuna8ZD7DX22kHkOhnUcN0IkDBTg8w4+ZZ+0c3IXgWkhO8Y9M+fgoiShwcIruriVE0P+JFB9BI8O+3irhg5puDuIZbwiRcKe/0zy67RSJhvVYsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988637; c=relaxed/simple;
	bh=TOm+AG6uF8CfcdSbL2xYPSPWo5+as6JemfuXqaEAOA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Og6Sm9GZkAWN5eJEVtfNMN1Ms+yN9E2cMqRG484axPBeE3Eehx/lQ8sWnNCvrep0tLzALvMr+b1iPTuDgucyJJizg2MHa0FMMeP/gIJADiiQVip/7tUPlwvSRXb75Xb6tH5arTj0UT7XyxHfC3++IdsCRygO//m7smsLigrt+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=DUO3Q/4D; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFF47443E8;
	Mon, 24 Nov 2025 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1763988626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ehjZNtUsee2gHpqkc7I7IUXRa8sx2e2DcqqUX9xRgSY=;
	b=DUO3Q/4DEfnPPyeQK/O63oOc6e0fDyr7jVOTmGdBvHqNDGuKxvHNDQigHjpu23MeXtuxTT
	PjjpU6UBqjHpfB+2mJXFkm6Z5CWVL09GRf0/PisGcbcgwgTjViUBtqIs6MyiKKCLSMjfrA
	XeHKw+KdWu9mDDkxdXktcP/shwXCLMc/yZw3hvX5btnyeOhPMHCoRoepkwjavXRK/MUQJZ
	qDDyeP5eUdTguawISOEcaYFuRSKxvPdwVzelt8nKtjv+UU5Ej1ajfsFzKLBiZ89ewGnOHb
	Q4SDUZ7SRr0xXQjrNHXBVMHmoUdhVGbDLB6DfyxebANwcI2XhxpPVNWsEvJ5WA==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 24 Nov 2025 13:50:22 +0100
Subject: [PATCH 1/7] dma: fsl-edma: Add write barrier after TCD descriptor
 fill
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-dma-coldfire-v1-1-dc8f93185464@yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
In-Reply-To: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763988624; l=1002;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=TOm+AG6uF8CfcdSbL2xYPSPWo5+as6JemfuXqaEAOA0=;
 b=8YQJIkpqyGnTjA05bX1fveT2ic+xvpu2zIa3x+BAoyxm8V7OBvQrsPddbXNYQu8lBgSTcvFjC
 72dofqLtOIpA+eJFWOZdhvb7RKUsLAhvpBGpRURm9kSV2uR5Y40RYVn
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeffjefhtdelhffhheevheeutefghfefteeluedvudfhgeegteeitddtuefhhfelteenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgspdhhvghlohephihoshgvlhhiqdihohgtthhordihohhsvghlihdrohhrghdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepkedprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhrt
 ghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Add dma_wmb() barrier after filling TCD descriptors to ensure all
descriptor writes are visible to the DMA engine before starting
transfers. This prevents potential race conditions where the DMA
hardware might read partially written descriptors.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/fsl-edma-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4976d7dde08090d16277af4b9f784b9745485320..db36a6aafc910364d75ce6c5d334fd19d2120b6b 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -553,6 +553,9 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
 
 	trace_edma_fill_tcd(fsl_chan, tcd);
+
+	/* Ensure descriptor writes are visible to DMA engine */
+	dma_wmb();
 }
 
 static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,

-- 
2.39.5


