Return-Path: <dmaengine+bounces-7325-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF83C80961
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C783A9A9A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4913019D7;
	Mon, 24 Nov 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="ovijoCbJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3544301039;
	Mon, 24 Nov 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988638; cv=none; b=sgkXduNooXjCU0P9tm/jJ3dre7qi/8ju8Lndk49NwOftzKXQ3RQN0M4528D5zJM4K0dHC7SHdrnMDjfuUR1UXxpeZj5PbKgYfhFywrCg+r6I7LDS5regOIOZNc8/rgcUXw/nAiCLwEPdE7Xp85b8qHZ2T+iD0FkU8WN6oV4/TVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988638; c=relaxed/simple;
	bh=NC3qxNqmP4HK1nvjbqrndKPXY2/Q9zKHsvGxZJ8Uckk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utaUuV5kNoCEXDW4010D6ZgkOLeARvOpaoD7oZCYtu5PEEcP0zzLVSjpprynI/D+qD/NklTkE86e9M53waE/wJ1NyJgNoNgZK9Kkr7PBH0vslmrchTSxmg6zI3ybpCBFK+dMd6YQUmmXA+VO3oS1Hur2bq4AuS7fYAORoj67f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=ovijoCbJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1372443F0;
	Mon, 24 Nov 2025 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1763988627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qm+mub2CsjoKJKFrgQvB1fzGBYlrYQ1WARbF1U7F/co=;
	b=ovijoCbJXm46QY2vkR+tUzKLVpdohQQHIQSxdRyJbDjQqUEpi6ktp+els0OK6uDNGOoNsB
	Yja6E7kOz42KDyjMLdrIlN+xoEalI55jghLx6zdNjOOhVyyisbOs4sTrUGpiFNO23swIO0
	a5cxTkBxVEhAZ5AHShwHoTggWaIzBC7JDyi5srRL87787z24zLwv3L4o01u171KICVTMAa
	wK8gfIsuCdITeRK0OD20N8k1YZk0BuBnlH6E1lbuudZ5m61U2xZmqU2AW7htONwpVrMPh2
	aD5YaOIKG1CcKf7SxqbadsaGYUgIc5pXScWLWEMl7LPa11jINrf4gelC6r+MOg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 24 Nov 2025 13:50:23 +0100
Subject: [PATCH 2/7] dma: fsl-edma: Add FSL_EDMA_DRV_MCF flag for ColdFire
 eDMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-dma-coldfire-v1-2-dc8f93185464@yoseli.org>
References: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
In-Reply-To: <20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763988624; l=2569;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=NC3qxNqmP4HK1nvjbqrndKPXY2/Q9zKHsvGxZJ8Uckk=;
 b=qGB8yWl6L08p1IXyt7ydTMeOGc6tztSHwFnrsTGl3ZQDMM0uvRo2fVaGMNG5gagj5wbuEMAzY
 Y2tvCmJ3EAGC80Em5EHN4x1hiNaBkIoB9OyvH/utTCHBL8xkdx2jQ8I
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgvrghnqdfoihgthhgvlhcujfgruhhtsghoihhsuceojhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgqeenucggtffrrghtthgvrhhnpeffjefhtdelhffhheevheeutefghfefteeluedvudfhgeegteeitddtuefhhfelteenucfkphepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmeduieelmeejudegtdemkeeksgefmeehudehfeemtgdvieegmeegfhgspdhhvghlohephihoshgvlhhiqdihohgtthhordihohhsvghlihdrohhrghdpmhgrihhlfhhrohhmpehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdpnhgspghrtghpthhtohepkedprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhrt
 ghpthhtohepghgvrhhgsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehvkhhouhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Add FSL_EDMA_DRV_MCF driver flag to identify MCF ColdFire eDMA
controllers which have a native M68K register layout.

The edma_writeb() function applies an XOR ^ 0x3 byte-lane adjustment for
big-endian eDMA controllers where byte registers within a 32-bit word
need address correction.

However, the MCF54418 eDMA 8-bit registers (SERQ, CERQ, SEEI, CEEI,
CINT, CERR, SSRT, CDNE) are located at sequential byte addresses
(0x4018-0x401F) as documented in the MCF54418 Reference Manual Table
19-2. No byte-lane adjustment is needed, as applying the XOR causes
writes to target incorrect registers (writing to CERR at 0x401D would
actually access SSRT at 0x401E).

Set this flag in the MCF eDMA driver to bypass the XOR adjustment and
access registers at their documented addresses.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/fsl-edma-common.h | 5 ++++-
 drivers/dma/mcf-edma-main.c   | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094805aa728b72a51ae101cd88fa003..4c86f2f39c1db9a812245fe85755ec8d1169c44c 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -225,6 +225,8 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_TCD64		BIT(15)
 /* All channel ERR IRQ share one IRQ line */
 #define FSL_EDMA_DRV_ERRIRQ_SHARE       BIT(16)
+/* MCF eDMA: Different register layout, no XOR for byte access */
+#define FSL_EDMA_DRV_MCF                BIT(17)
 
 
 #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
@@ -419,7 +421,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
 			       u8 val, void __iomem *addr)
 {
 	/* swap the reg offset for these in big-endian mode */
-	if (edma->big_endian)
+	/* MCF eDMA has different register layout, no XOR needed */
+	if (edma->big_endian && !(edma->drvdata->flags & FSL_EDMA_DRV_MCF))
 		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
 	else
 		iowrite8(val, addr);
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 9e1c6400c77be237684855759382d7b7bd2e6ea0..f95114829d8006fe4558169888ff38037d7610de 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -145,7 +145,7 @@ static void mcf_edma_irq_free(struct platform_device *pdev,
 }
 
 static struct fsl_edma_drvdata mcf_data = {
-	.flags = FSL_EDMA_DRV_EDMA64,
+	.flags = FSL_EDMA_DRV_EDMA64 | FSL_EDMA_DRV_MCF,
 	.setup_irq = mcf_edma_irq_init,
 };
 

-- 
2.39.5


