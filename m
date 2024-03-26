Return-Path: <dmaengine+bounces-1509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCD88C13B
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003E41C3EC8D
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A3C6BFCB;
	Tue, 26 Mar 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="hvhxAB34"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C06A8DE
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453792; cv=none; b=TbrEv4bHuzdURdg6UBv6ONGU+aeALycWeTRQOgJXvNHT/1Y3xTLb1kg3kDkk+NG8TMpDLV84c32UK0Or9T4ytnmHVgyjLX+/XBQ23/3gcakW4pjzaPXJHhmBrJVhzEb4mXC6h2DSaQZX0/tozjB/whbKZO5EgJv487gOX4UhL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453792; c=relaxed/simple;
	bh=fSqusGyvBnmv0oGIv3+qh26oMOCu/9aSBwhyHc4PwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7PbSULDl8KlbGESxRsaJ11UFwSRlPhs9MXN6ZJNEBafIPRIGPgQamV5USBdXHiW693SgX/iJauTvHVfQEf5sQ+5Ku6haDhPOk/DSO28FFmf26daYajT3YlUHvbO3a0TP6fx2/WFHomp6owymn9k/BbRj8YWG2NoGkiE8V5valU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=hvhxAB34; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 5DA12440FA3;
	Tue, 26 Mar 2024 13:43:05 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1711453385;
	bh=fSqusGyvBnmv0oGIv3+qh26oMOCu/9aSBwhyHc4PwVY=;
	h=From:To:Cc:Subject:Date:From;
	b=hvhxAB344Gbgl2QLXXZjtR0+6JLfD7I1SNqHh2d9tuG4mXMMMMiFK0f24MKAbtq8x
	 k48uA4oFl7C4FSleH6YEmRHtODE4CIqCZLrpyWusu5N/634FKd61h+wlQk13N3Mr/g
	 diVWSVEC5ojZLMzSh7ndizJZON2Dt85KgUrju2y3dfdIeZFHVat5c3yftj/pSXTqHG
	 0ldZb86nBS0bA5SEH0/t9r3MrW5CnvcxyO+C08irkWjhnz9L6o+3uL7jsmP9ejKaec
	 gj9W6fYrBxZe1p+briQuJdzEFgSq0U/sCoxYhjCt/DNvRjzLoF3+iRzuJVpWkRUsRA
	 9slhRXA8tlU3g==
From: Baruch Siach <baruch@tkos.co.il>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] dma: dw-axi-dmac: support per channel interrupt
Date: Tue, 26 Mar 2024 13:43:07 +0200
Message-ID: <ebab52e886ef1adc3c40e636aeb1ba3adfe2e578.1711453387.git.baruchs-c@neureality.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware might not support a single combined interrupt that covers all
channels. In that case we have to deal with interrupt per channel. Add
support for that configuration.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 29 ++++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +-
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a86a81ff0caa..b5a5dd523dd6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1445,6 +1445,24 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 	return 0;
 }
 
+static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
+{
+	int irq_count = platform_irq_count(pdev);
+	int ret;
+
+	for (int i = 0; i < irq_count; i++) {
+		chip->irq[i] = platform_get_irq(pdev, i);
+		if (chip->irq[i] < 0)
+			return chip->irq[i];
+		ret = devm_request_irq(chip->dev, chip->irq[i], dw_axi_dma_interrupt,
+				IRQF_SHARED, KBUILD_MODNAME, chip);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int dw_probe(struct platform_device *pdev)
 {
 	struct axi_dma_chip *chip;
@@ -1471,10 +1489,6 @@ static int dw_probe(struct platform_device *pdev)
 	chip->dev = &pdev->dev;
 	chip->dw->hdata = hdata;
 
-	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0)
-		return chip->irq;
-
 	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
@@ -1515,8 +1529,7 @@ static int dw_probe(struct platform_device *pdev)
 	if (!dw->chan)
 		return -ENOMEM;
 
-	ret = devm_request_irq(chip->dev, chip->irq, dw_axi_dma_interrupt,
-			       IRQF_SHARED, KBUILD_MODNAME, chip);
+	ret = axi_req_irqs(pdev, chip);
 	if (ret)
 		return ret;
 
@@ -1629,7 +1642,9 @@ static void dw_remove(struct platform_device *pdev)
 	pm_runtime_disable(chip->dev);
 	axi_dma_suspend(chip);
 
-	devm_free_irq(chip->dev, chip->irq, chip);
+	for (i = 0; i < DMAC_MAX_CHANNELS; i++)
+		if (chip->irq[i] > 0)
+			devm_free_irq(chip->dev, chip->irq[i], chip);
 
 	of_dma_controller_free(chip->dev->of_node);
 
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 454904d99654..fd8bfb90bc25 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -65,7 +65,7 @@ struct dw_axi_dma {
 
 struct axi_dma_chip {
 	struct device		*dev;
-	int			irq;
+	int			irq[DMAC_MAX_CHANNELS];
 	void __iomem		*regs;
 	void __iomem		*apb_regs;
 	struct clk		*core_clk;
-- 
2.43.0


