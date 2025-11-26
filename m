Return-Path: <dmaengine+bounces-7356-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B50AFC88AB7
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A52C04E279A
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D56319871;
	Wed, 26 Nov 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKbQmNhR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37E31960C;
	Wed, 26 Nov 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146164; cv=none; b=fTNCyvShhVDtXr1QE1TWAIc4rJliG8kqoFJXi5ZoHG2t5jD2digdILBZhXHgnCgfI2Lp/9Ppm1fw+7k33TsXRoAsKDTwkDCSPM3GkUYPH80jaloVAQGSLTG39l6D8rBimzUuDPi+pkGjY8OD3NIZZTFEw0r45wgDLGmGybiw8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146164; c=relaxed/simple;
	bh=c4hfh7JuwsfiLhuVDttvKrbLU4tWLHCTyrAp7i/wpyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxFzFtGt5tufeCBvp2YE7uDekHgYp9EkWICjzXZwLTZ5+vhMoTH3rhs/UkRHiCzx0M0VPeDevQRLzLfWTZ7FnxDni+sd37iQZ3v+rFWvBOd6j/L2D5NgCHDlcqHobfG3x1E0Q7MfjVT1EQslwkDtVNiRDTQV6kEGxA5Iwb71mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKbQmNhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F12F9C113D0;
	Wed, 26 Nov 2025 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764146164;
	bh=c4hfh7JuwsfiLhuVDttvKrbLU4tWLHCTyrAp7i/wpyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YKbQmNhRN98Gh94Ty3hQcr/E7uvX/SqdiLG1JevNmiZHtDXBarb84xL8ao8ss/etg
	 N2bbLYLGZKgn0m6urGNjSDIdAZr+3ZgLRuVyok/PIBnCT00J0FAnKEMpFkZYxv+nOy
	 GcNpoxz20ORQqyALBjvPlEf/soDRDl1IvfqYzRvW4JZzeeJMBraovqpp4at/VH3Fjl
	 Vqu/lu5bLCZfuJ9fsPRGX2x4DsbJnCVKZa+B3uY/DQihDUo1lMh5pDNPvSrkS2yEaq
	 6gjuDJMh/vivfvp2FsMKAB8sX/8RiFmnxxC7+80vKMSLKbls0iL8oyFF/jnn+l9F1P
	 TanBqy5gxehkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D04D10391;
	Wed, 26 Nov 2025 08:36:03 +0000 (UTC)
From: Jean-Michel Hautbois via B4 Relay <devnull+jeanmichel.hautbois.yoseli.org@kernel.org>
Date: Wed, 26 Nov 2025 09:36:02 +0100
Subject: [PATCH v2 1/5] dma: fsl-edma: Add FSL_EDMA_DRV_MCF flag for
 ColdFire eDMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-dma-coldfire-v2-1-5b1e4544d609@yoseli.org>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
In-Reply-To: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764146162; l=2499;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=9Rl/w8Flv4FYHKNwt2QAAOrN5X7BfFjFIc6s+uDV++s=;
 b=qxtJdH6M5NqML0HZbwh4Es0Y/QUSnr+NBgpH0A7u7ay9142548awxn+ruhMWpHWc4nIiSjk+d
 zdxCMuA6eGvA/cpjqTlKje7dvM+vNG2IsC+9xGT50DAinjJ/8aNrUFL
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-Endpoint-Received: by B4 Relay for
 jeanmichel.hautbois@yoseli.org/20240925 with auth_id=570
X-Original-From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Reply-To: jeanmichel.hautbois@yoseli.org

From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/fsl-edma-common.h | 5 ++++-
 drivers/dma/mcf-edma-main.c   | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094..4c86f2f39c1d 100644
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
index 9e1c6400c77b..f95114829d80 100644
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



