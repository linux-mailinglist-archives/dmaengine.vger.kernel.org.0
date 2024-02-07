Return-Path: <dmaengine+bounces-983-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0484D51B
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 23:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB21C20C00
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F534135A6B;
	Wed,  7 Feb 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLe+iGHM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E7135A52;
	Wed,  7 Feb 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341228; cv=none; b=Z7lkesgLR+py8ivGp76AwAfwIe+F2rNMsV1M2hhcgnHpf2mHZiNROw4uJHnI1arbX2nmBVBDq85oQF5x5yHmYjYL7+rtAp0A3Q9FJtb7ilTeYhm7asaFfurdx6EQ7SMtyWzdteHnHdeKA59FYvF3jcuG7lAMBWiCsN0u3sgmJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341228; c=relaxed/simple;
	bh=9m1jj0JfmvljBoVsanyPCb70uqWdNvxZtOaXmyRb2l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYouPaHBWgKwSK7NOpNEz5phtKgoFTErfx2RGDdxTEPS7m2y5DMf7d6jPh/F+L1zPOBzOm1uVczDRBW6oxnt37rgdllBJAC+tsgzPA+pCojtuAlpHsjiIcR5khGoauLd/abasU8RuAmS/Sc8pViLNp+NX1Jl1zrqIcFVK+vJ4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLe+iGHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567BAC433C7;
	Wed,  7 Feb 2024 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341226;
	bh=9m1jj0JfmvljBoVsanyPCb70uqWdNvxZtOaXmyRb2l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLe+iGHMIR1odpGwmSAbEeuEFHHLQVboMOJuGrUm5iNhrQi1pkDWUh+HXYSLc3coC
	 8JTSIO1hBvwQfmovRWkx2DdCtlM0/q7uBG+Tc3IPchz5gDUGRg4PJ1LUZ4YulItxXi
	 +BveYICwkvea3UoigJ4IPQMz4aspi4dsjLmWhrDoDsUocFTBkL5kXMv1us0UF43PPN
	 7dd2KKN4Xo94N+iX/3WgG7TszxXozFcV7mHCEBficLCvwdHvcany8c/cKLFXF8/ze/
	 ljrnUHQR/3ID7Fpun6hGFUNQ9x1a/Nf52D4ycSUhG8FjlnFWoiDdpIvgMtvNQZsYNx
	 BgGtNBHngtEDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.ujfalusi@gmail.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/16] dmaengine: ti: edma: Add some null pointer checks to the edma_probe
Date: Wed,  7 Feb 2024 16:26:43 -0500
Message-ID: <20240207212700.4287-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369 ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118031929.192192-1-chentao@kylinos.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/edma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index a1adc8d91fd8..69292d4a0c44 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2462,6 +2462,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
@@ -2478,6 +2483,11 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
+
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
-- 
2.43.0


