Return-Path: <dmaengine+bounces-7354-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF0C88ABA
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C234734D8B0
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03434319848;
	Wed, 26 Nov 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnOymYDF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24B319603;
	Wed, 26 Nov 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146164; cv=none; b=DvqTyJn6io5aqU9IktkFpiu5au8HnyfYKkDzAIMTNoRyD5zXeH/4UJKSbdgNOtNQe3RYgbxZZ346K4KLjdEW7TX6df112+DxPzPnqt44SW3EzHMG1OKz5CmRdXEQdCQIfxPsshM/EmIKGwqoeTyXsHhCDN1bJ8kQ13TstxvmcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146164; c=relaxed/simple;
	bh=sjzSudo3EoBVY+lDVXdn/xFAbAYc+5JQiCsHKUpfBW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrLLckzHZKzujvpDN6vVopd/gZCm741/s1bGDWKdXmlygpfNaULRm2GERCV4DuSmbsQ+veUZfIZDBWJWcUrScsnKG4N5WsnzpDz6Pfw5qWtwhaOkOGZhabA9/O3+HsxiqWaKTQOKyxodah06zRs091S+q0PvVFJRtAKkT2i6kUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnOymYDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07DCEC116D0;
	Wed, 26 Nov 2025 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764146164;
	bh=sjzSudo3EoBVY+lDVXdn/xFAbAYc+5JQiCsHKUpfBW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OnOymYDFaTJedmGS42+ISGis2z+Vz7I/WkxLK/bD4NG7Irc6doyp96rDSegK0xQY2
	 GfWXrzQxzOvYd215+JxRIHrO5WvMVdcg2q8/icDoSlINSKNcej19qObo4YTmBHOvZR
	 aD6MOe9kru/LEblqG264oQYx/xfI/hgzHNj7CmULyqpjl4ozhaEA/czDZ83lflOnJc
	 EhDZz/D51w89PsacfFigm5PwsQ+reZmihDvDtzvuZ6iLt6kvdBII0PyQGa/s+speYW
	 +OBmEKXW7+v7X88jdWYyMIIywBYt5bzQ2/p33gRh1vudevoKecvPLBHOdo4fepf3E1
	 jREPBEO4KLuUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC106D10390;
	Wed, 26 Nov 2025 08:36:03 +0000 (UTC)
From: Jean-Michel Hautbois via B4 Relay <devnull+jeanmichel.hautbois.yoseli.org@kernel.org>
Date: Wed, 26 Nov 2025 09:36:03 +0100
Subject: [PATCH v2 2/5] dma: mcf-edma: Add per-channel IRQ naming for
 debugging
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-dma-coldfire-v2-2-5b1e4544d609@yoseli.org>
References: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
In-Reply-To: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764146162; l=2484;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=TOkFpkS4T7DbH7y0xlolnOAKUy6LY9n/XPRytl2P/DM=;
 b=eXEURz7RQO0BH0cJTkHQf62CHI2X69oRsk8d+iX2tOt9SVdilKka5OtxkRGVOhFlVYbteVbXa
 fHPERnOPFXaDjLqwnSSABn7K2/lG265dpaDWM0d6p5epUVBuRLHSQ4/
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-Endpoint-Received: by B4 Relay for
 jeanmichel.hautbois@yoseli.org/20240925 with auth_id=570
X-Original-From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Reply-To: jeanmichel.hautbois@yoseli.org

From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

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
 drivers/dma/mcf-edma-main.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index f95114829d80..6a7d88895501 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -81,8 +81,14 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
 	if (!res)
 		return -1;
 
-	for (ret = 0, i = res->start; i <= res->end; ++i)
-		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
+	for (ret = 0, i = res->start; i <= res->end; ++i) {
+		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"eDMA-%d", (int)(i - res->start));
+		if (!irq_name)
+			return -ENOMEM;
+
+		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
+	}
 	if (ret)
 		return ret;
 
@@ -91,23 +97,27 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
 	if (!res)
 		return -1;
 
-	for (ret = 0, i = res->start; i <= res->end; ++i)
-		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
+	for (ret = 0, i = res->start; i <= res->end; ++i) {
+		char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"eDMA-%d", (int)(16 + i - res->start));
+		if (!irq_name)
+			return -ENOMEM;
+
+		ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
+	}
 	if (ret)
 		return ret;
 
 	ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
 	if (ret != -ENXIO) {
-		ret = request_irq(ret, mcf_edma_tx_handler,
-				  0, "eDMA", mcf_edma);
+		ret = request_irq(ret, mcf_edma_tx_handler, 0, "eDMA-tx-56", mcf_edma);
 		if (ret)
 			return ret;
 	}
 
 	ret = platform_get_irq_byname(pdev, "edma-err");
 	if (ret != -ENXIO) {
-		ret = request_irq(ret, mcf_edma_err_handler,
-				  0, "eDMA", mcf_edma);
+		ret = request_irq(ret, mcf_edma_err_handler, 0, "eDMA-err", mcf_edma);
 		if (ret)
 			return ret;
 	}

-- 
2.39.5



