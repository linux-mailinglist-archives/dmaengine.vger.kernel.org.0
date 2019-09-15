Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8376B2F08
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbfIOHa7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:30:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41905 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOHa6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:30:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so20526743pfo.8;
        Sun, 15 Sep 2019 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GkvCW2yDGpRo3PSFTuRArziiou4pMe6vPX17Y8y6Dnc=;
        b=jH53rpPk8Uk1MSBhnWEhXTfoJMN+iJEQ7EKpauS+mO+CCAQ033B4UaLO04rOUTzP9Z
         PWJfnMr8F1cxat2FMQdXS2RJJ1iqxl+Ly5gMy7fE6XV6H3/Dvqci/SSY4YzCsumfD9VD
         0S0HaXx4zVtosSZZQ5Vt1m3HfctPhInLJAyRuKiMEPe3JR7UT/I4dFsaNYmNiAby8+d6
         mfaUBZP6heEKzHQR8jC+6grUVpMO7KekOvRcDWcq7hWfDtElp27rRwCOlRWJQ4u9PBVF
         6aLTQYOVDHUKwV0yJ6E7AuHoHSZLagv8Sqmmz+O4IupGz8GOqVKzxUnpkbDWF+JaO3q4
         245A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GkvCW2yDGpRo3PSFTuRArziiou4pMe6vPX17Y8y6Dnc=;
        b=eAmVxGJ/tm1SEU7azCI7UHws78TRJyjc4STFmCY/rptpOKBlC1IbVwH2ZL2tdg2ktM
         FLgV/TSzegBjyl33iv0MnqpmDtY5ROMHymy26R0rzrw8rm0fzglrajbofuyMVMV5eyiK
         mQdDp1/3NNcL8SzrjSIjmq0fdgh1OukQxKmVO3KR5UZ16qTAEXfoe3+LQ9pWHn432FCa
         MHg0/Ddtp+Ow4xmBD3On74FPOFbUzJHBLTOj4bJZbNHatOucNF8LWhGHxPCmoJSkeImy
         T+NM22Rklojq3EjJKPsVr2yVXx+qlqPSWm0/4n8w3/Jiox+Wh6KsHZVbqt9dIuIn9s7f
         PiOw==
X-Gm-Message-State: APjAAAUQ1rIBjttH2ibr8Gjpl49tm667sFPQFbYUiEomC8vfZhcJVVOO
        +jdPnRuwef8cKkErxgHan0o=
X-Google-Smtp-Source: APXvYqxuah8yl/pvu9JVO+yv2YIraDJx3bTe6QtVyQFOYlpd+/GcXmhFtP4zDYlq6PIBRRZ/EtEAEQ==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr13948462pjs.54.1568532657679;
        Sun, 15 Sep 2019 00:30:57 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id c11sm65160088pfj.114.2019.09.15.00.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:30:56 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] probe/dma/mtk-hs: removed redundant code from mediatek hs dma controller's probe function
Date:   Sun, 15 Sep 2019 13:00:48 +0530
Message-Id: <20190915073048.23817-1-sst2005@gmail.com>
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

2. Fixed a memory leak when devm_request_irq fails,
Called of_dma_controller_free in such case.

3. This patch depends on the file include/linux/probe-helper.h
which is pushed in previous patch [01/09].

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/mediatek/mtk-hsdma.c | 38 ++++++++++----------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 1a2028e1c29e..6fc01093aeea 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -23,6 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/probe-helper.h>
 
 #include "../virt-dma.h"
 
@@ -896,41 +897,24 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	struct mtk_hsdma_device *hsdma;
 	struct mtk_hsdma_vchan *vc;
 	struct dma_device *dd;
-	struct resource *res;
 	int i, err;
 
-	hsdma = devm_kzalloc(&pdev->dev, sizeof(*hsdma), GFP_KERNEL);
-	if (!hsdma)
-		return -ENOMEM;
-
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq
+	 */
+	err = devm_platform_probe_helper(pdev, hsdma, "hsdma");
+	if (err < 0)
+		return err;
 	dd = &hsdma->ddev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hsdma->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hsdma->base))
-		return PTR_ERR(hsdma->base);
-
 	hsdma->soc = of_device_get_match_data(&pdev->dev);
 	if (!hsdma->soc) {
 		dev_err(&pdev->dev, "No device match found\n");
 		return -ENODEV;
 	}
 
-	hsdma->clk = devm_clk_get(&pdev->dev, "hsdma");
-	if (IS_ERR(hsdma->clk)) {
-		dev_err(&pdev->dev, "No clock for %s\n",
-			dev_name(&pdev->dev));
-		return PTR_ERR(hsdma->clk);
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "No irq resource for %s\n",
-			dev_name(&pdev->dev));
-		return -EINVAL;
-	}
-	hsdma->irq = res->start;
-
 	refcount_set(&hsdma->pc_refcnt, 0);
 	spin_lock_init(&hsdma->lock);
 
@@ -997,7 +981,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"request_irq failed with err %d\n", err);
-		goto err_unregister;
+		goto err_free;
 	}
 
 	platform_set_drvdata(pdev, hsdma);
@@ -1006,6 +990,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free:
+	of_dma_controller_free(pdev->dev.of_node);
 err_unregister:
 	dma_async_device_unregister(dd);
 
-- 
2.17.1

