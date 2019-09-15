Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFBB2F0E
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfIOHcN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:32:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45924 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOHcN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:32:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so17497778pgm.12;
        Sun, 15 Sep 2019 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4PgIGQ3wJQUQthoZj1zqeVCz9S7XcbHvEQ97PV6+tM=;
        b=eK5araplelxFt5qbQ2yVZnHo79vn6Wv45m52C1zwcLZlVgsLls4QF3DE+Jz8oX6muB
         w1OTTbKsAzjUfTYwmTzpWqpUNkVoK1py5YfJa5hfOf4pZ0Zhf9KFPDdknI5BhN6pCITT
         g9qN+ZZPP1vjXH3aBQW4C0UsQTLkb7EsQx6U4xNRW7HaHvb6qW0YA8eUrDOzQ0bq3/D/
         JrdoCpbL23u9b0yJ31RxMmeG3JChQ5TtY17t8zp5yUJVu5B1KQtTeykS/MUCDK/jsupe
         fIS7nh+bP+w+fsHJKAEtnt3a+dtP2KoyzEu0g6Z7Huc78nKCTDW6h6xl+Tus5O6lttjn
         1O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4PgIGQ3wJQUQthoZj1zqeVCz9S7XcbHvEQ97PV6+tM=;
        b=o4ZLDzdRy53uaRBBDoDNbpkZLVKIsMBdDiJVjXIA1kvJTok2wBHC22ShCmVXXCiXKc
         jrABSbKxjRm1Nocm+CQDPxYUSqiZGO3wffbVfSLwwuFM0Vqz5kP2/FiCLRig3WF5wZ+q
         NmuDUA89dhF13CSgcPHu+kWySR0Pr76/RM6Sj0En6p5ChHkBSVPY2rdrEkwEZEmsFWZC
         L/W50g+zjvjw3O1Ac7EmnW6KctI1Y9TYAoRtdv6n4r/em/Yxpzma54oFwz9OkXpGM0UD
         S1phwkjnLIp3vm4+tifh3r+JF6BXxkMlxRPhZDJDVNH8FQIyZXy+c8E5bqMCJ9YJp5Ia
         33CA==
X-Gm-Message-State: APjAAAV0JN7XUj1vZgZT/o6HP9tadRdWAxOi8qeVbXPhPS765xecNeAs
        MeD9mOWGZXbmd2ZhBhNOnoo=
X-Google-Smtp-Source: APXvYqw4GNHiM/JotTPC37vIr0f7HSYy4qPrwREclNq9g2KRIxRE6+gg2fLKcFMNvrV/T8jwjBTuFg==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr13936707pjr.84.1568532732350;
        Sun, 15 Sep 2019 00:32:12 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id 30sm7567118pjk.25.2019.09.15.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:32:11 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] probe/dma/sun4i: removed redundant code from sun4i dma controller's probe function
Date:   Sun, 15 Sep 2019 13:02:00 +0530
Message-Id: <20190915073201.24032-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190915072644.23329-1-sst2005@gmail.com>
References: <20190915072644.23329-1-sst2005@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1. In order to remove duplicate code, following functions:
platform_get_resource
devm_kzalloc
devm_ioremap_resource
devm_clk_get
platform_get_irq
are replaced with a macro devm_platform_probe_helper.

2. This patch depends on the file include/linux/probe-helper.h
which is pushed in previous patch [01/09].

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/sun4i-dma.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 1f80568b2613..5db139ff43ac 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/probe-helper.h>
 
 #include "virt-dma.h"
 
@@ -1119,29 +1120,16 @@ static irqreturn_t sun4i_dma_interrupt(int irq, void *dev_id)
 static int sun4i_dma_probe(struct platform_device *pdev)
 {
 	struct sun4i_dma_dev *priv;
-	struct resource *res;
 	int i, j, ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		return priv->irq;
-	}
-
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "No clock specified\n");
-		return PTR_ERR(priv->clk);
-	}
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq
+	 */
+	ret = devm_platform_probe_helper(pdev, priv, NULL);
+	if (ret < 0)
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 	spin_lock_init(&priv->lock);
-- 
2.17.1

