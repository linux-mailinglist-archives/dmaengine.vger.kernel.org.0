Return-Path: <dmaengine+bounces-4285-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508EEA283D8
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 06:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750EA166DEE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 05:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01321D5BE;
	Wed,  5 Feb 2025 05:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D5q2Dpuw"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7817BEBF;
	Wed,  5 Feb 2025 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734477; cv=none; b=RMsxpwxHJwnrrp0HPl2MX/0lyfhvE6fU95bx4YcWV+xWhLg63TtMYlJSLd/Dnx9liYMcl1bH1cCMbz7OAMrmwjgmeJLM6iThjl6lu2BxF5jeKBqXGS/V7KlVhM2F9oqQbqC5qDZBzwlWpgDwDnrw9vdrUMj3ck1c4+r0jhnYYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734477; c=relaxed/simple;
	bh=JsjoMsPukH3T9bblFYEe4cs8XB5AgUk3iFQC9hIrb0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MMQtOla9I8EOV2Wcba7Jd/LCiJ7/WP1/wrq8hBbLppHS8RHsm29QHdECoWW5bAm5zG2YYmrRk7GNONNuUPhjG3ssze2Q/Mt/c+CNvfkffR6YnMeCcIG57TUCSc4WykGm9GzBeshyqhIC51oZSTZ7HPflqxIFc2soKUwtcTGfM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D5q2Dpuw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738734476; x=1770270476;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JsjoMsPukH3T9bblFYEe4cs8XB5AgUk3iFQC9hIrb0o=;
  b=D5q2DpuwVP9lyq4pTPg0+aK6Xe9vBZIvXcSlZpjf3d5/5oh6pwfsIqZ+
   6hbQhWmClmJo3mGNnsrkfW0jDN/yrG0pmvV7Q79WHM9PPwJsTHReE/jdO
   8bfZVYrEgj2ESRod6y5hVC1Q7L51Lic5QPF7rM1psze4/HMQZnfsn8v1H
   H1FzGjLBImJJRS8FSBOvE/avsA0ijvBVRKywJecZgX3nghXKjuAXIEDz+
   /EsS1So5BlYAkVRy/AUoZagVoDq8ThXl0ouPhEIxtmCfkeP8deH04hzRt
   LKl+VC1Tb00CLFVb+q5YSm1vjHl8Gox5RqgdvPGEntdL3RLDSBhfjpZOY
   Q==;
X-CSE-ConnectionGUID: a1yIP19sQpy3wWAhZXasEg==
X-CSE-MsgGUID: w4SM+3nqQ7OA++T7fyzE7g==
X-IronPort-AV: E=Sophos;i="6.13,260,1732604400"; 
   d="scan'208";a="268620150"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Feb 2025 22:47:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Feb 2025 22:47:17 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Feb 2025 22:47:11 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 5 Feb 2025 11:17:02 +0530
Subject: [PATCH 1/2] dmaengine: at_xdmac: get the number of DMA channels
 from device tree
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250205-mchp-dma-v1-1-124b639d5afe@microchip.com>
References: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
In-Reply-To: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Vinod Koul
	<vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Charan Pedumuru <charan.pedumuru@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>, Tony Han <tony.han@microchip.com>,
	Cristian Birsan <cristian.birsan@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738734425; l=1880;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=X9SQwn97RGxJg8ugL0Ib/dqZ8wQ0Ij6oC+ZtdNgnIYg=;
 b=3ftho3/4GdrP6BA9CFwUb30ZhtSnR4DgrScHBRl8xbqlrnW2oEimp6Hp9AZca55l2SCQPVHEu
 wN1IVZvpjyKBlkmuMfPIAgLw/aI7RyH9FxvJUQaIJUegfXltGHOleDZ
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

From: Tony Han <tony.han@microchip.com>

In case of kernel runs in non-secure mode, the number of DMA channels can be
got from device tree since the value read from GTYPE register is "0" as it's
always secured. As the number of channels can never be negative, update them
to the type "unsigned".

Signed-off-by: Tony Han <tony.han@microchip.com>
Reviewed-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/dma/at_xdmac.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ba25c23164e7..f777b0665c63 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2259,12 +2259,29 @@ static int __maybe_unused atmel_xdmac_runtime_resume(struct device *dev)
 	return clk_enable(atxdmac->clk);
 }
 
+static inline int at_xdmac_get_channel_number(struct platform_device *pdev,
+					      u32 reg, u32 *pchannels)
+{
+	int ret;
+
+	if (reg) {
+		*pchannels = AT_XDMAC_NB_CH(reg);
+		return 0;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels", pchannels);
+	if (ret)
+		dev_err(&pdev->dev, "can't get number of channels\n");
+
+	return ret;
+}
+
 static int at_xdmac_probe(struct platform_device *pdev)
 {
 	struct at_xdmac	*atxdmac;
-	int		irq, nr_channels, i, ret;
+	int		irq, ret;
 	void __iomem	*base;
-	u32		reg;
+	u32		nr_channels, i, reg;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -2280,7 +2297,10 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	 * of channels to do the allocation.
 	 */
 	reg = readl_relaxed(base + AT_XDMAC_GTYPE);
-	nr_channels = AT_XDMAC_NB_CH(reg);
+	ret = at_xdmac_get_channel_number(pdev, reg, &nr_channels);
+	if (ret)
+		return ret;
+
 	if (nr_channels > AT_XDMAC_MAX_CHAN) {
 		dev_err(&pdev->dev, "invalid number of channels (%u)\n",
 			nr_channels);

-- 
2.43.0


