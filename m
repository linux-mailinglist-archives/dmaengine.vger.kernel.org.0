Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE882A579
	for <lists+dmaengine@lfdr.de>; Sat, 25 May 2019 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfEYQia (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 May 2019 12:38:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33318 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfEYQi3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 May 2019 12:38:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so3327869wmh.0;
        Sat, 25 May 2019 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQgSnfiOxm9+C2oUtvzxOg9ar7+568ZBuQBswlwkWls=;
        b=fpeHWHLeMpy/ARUQ6sMkHjNaXac4FvLA9S2KevDr16zz1QEVFtD3ifGfXYHBW8m2eI
         XaZrIdWmCf/dcE8UEyAm5sCamqwlsNOFXkTvls5yI4nWCqIFYopOzVwdtM2ZP3r3gDBv
         WlPqgnGg9IH1hdGFgbvE+pUObBOGhHtryeLxB+lU/nBN3pJcn2U5Z7OwGAlqVy5YgVc7
         ylQt0W3joyjuwQJ2rLIYkCYsXQD9npOvrNKrHjQgCd2u1CqTR2VCoxZVxYtujhRuIK38
         ukg2oVJfEJi76zoGouU9C+TNfVuUH38/lk8Ljlbq5b1Rh7X/6MpY3rd8yYWPktffTgNi
         pwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQgSnfiOxm9+C2oUtvzxOg9ar7+568ZBuQBswlwkWls=;
        b=YSbVQoE1BQVrQeaot2Mdyg/JsDr8LmUREpSV7TRRN8d4sFuKQVZs+eVAgGXO6rwn/K
         YXwPlyOHLIF3dn8URTg+/43jeHKOKqwFOa+YGoNWoLYzLSbh2DWQ55UkPqS5EwrLWw2o
         RmrY7Eq/ZUsdSGAqH+v7HLE0+ykBKiOEli/znqEVe2dIrBH7hHh3ai8pqWVOywVOJ/kM
         FunLV2vtR7GLbpL0d2+Pljyl9khTweO5U1f1NV3R3Wm50Lmct+kCsNrNaH8pwdbfywbm
         ItMwPHw/qpd9O1GDsNr0hlIHaYankDpxMYCERxV1qKnYfTqeXmQVwOFjAhNHdfQRqYOC
         tsmQ==
X-Gm-Message-State: APjAAAVHAShJ7iuLv31xnzSeXA50zEQ+qbH2n/k2Yv61Cb55f9s+k8hH
        9Vexax08reOXzEl6WMYO/C8=
X-Google-Smtp-Source: APXvYqxY3a/zzzGNpLhQ0PR3vJOW0d0UoB7TVKBeKA8nVBQivbcnkllLZLs+Vh2RVKjGex2r/tP54w==
X-Received: by 2002:a1c:1a49:: with SMTP id a70mr19873320wma.120.1558802307817;
        Sat, 25 May 2019 09:38:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id f65sm9306498wmg.45.2019.05.25.09.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:38:27 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/7] dmaengine: sun6i: Add a quirk for additional mbus clock
Date:   Sat, 25 May 2019 18:38:14 +0200
Message-Id: <20190525163819.21055-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525163819.21055-1-peron.clem@gmail.com>
References: <20190525163819.21055-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 DMA controller needs additional mbus clock to be enabled.

Add a quirk for it and handle it accordingly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/dma/sun6i-dma.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 0cd13f17fc11..7d9606997251 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -129,6 +129,7 @@ struct sun6i_dma_config {
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
+	bool has_mbus_clk;
 };
 
 /*
@@ -182,6 +183,7 @@ struct sun6i_dma_dev {
 	struct dma_device	slave;
 	void __iomem		*base;
 	struct clk		*clk;
+	struct clk		*clk_mbus;
 	int			irq;
 	spinlock_t		lock;
 	struct reset_control	*rstc;
@@ -1208,6 +1210,14 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(sdc->clk);
 	}
 
+	if (sdc->cfg->has_mbus_clk) {
+		sdc->clk_mbus = devm_clk_get(&pdev->dev, "mbus");
+		if (IS_ERR(sdc->clk_mbus)) {
+			dev_err(&pdev->dev, "No mbus clock specified\n");
+			return PTR_ERR(sdc->clk_mbus);
+		}
+	}
+
 	sdc->rstc = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->rstc)) {
 		dev_err(&pdev->dev, "No reset controller specified\n");
@@ -1312,11 +1322,19 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		goto err_reset_assert;
 	}
 
+	if (sdc->cfg->has_mbus_clk) {
+		ret = clk_prepare_enable(sdc->clk_mbus);
+		if (ret) {
+			dev_err(&pdev->dev, "Couldn't enable mbus clock\n");
+			goto err_clk_disable;
+		}
+	}
+
 	ret = devm_request_irq(&pdev->dev, sdc->irq, sun6i_dma_interrupt, 0,
 			       dev_name(&pdev->dev), sdc);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_clk_disable;
+		goto err_mbus_clk_disable;
 	}
 
 	ret = dma_async_device_register(&sdc->slave);
@@ -1341,6 +1359,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdc->slave);
 err_irq_disable:
 	sun6i_kill_tasklet(sdc);
+err_mbus_clk_disable:
+	clk_disable_unprepare(sdc->clk_mbus);
 err_clk_disable:
 	clk_disable_unprepare(sdc->clk);
 err_reset_assert:
@@ -1359,6 +1379,7 @@ static int sun6i_dma_remove(struct platform_device *pdev)
 
 	sun6i_kill_tasklet(sdc);
 
+	clk_disable_unprepare(sdc->clk_mbus);
 	clk_disable_unprepare(sdc->clk);
 	reset_control_assert(sdc->rstc);
 
-- 
2.20.1

