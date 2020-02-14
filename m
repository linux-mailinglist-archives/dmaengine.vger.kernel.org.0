Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F5015CF91
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 02:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgBNBwL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 20:52:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34424 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgBNBwL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Feb 2020 20:52:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so4127449pgi.1
        for <dmaengine@vger.kernel.org>; Thu, 13 Feb 2020 17:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=87y16Eke3JoFDTS3mJX5f9505D+ep7pI/R4smcsdKCE=;
        b=B+bFRB2+E1zYaFZ2w8+4JNCqciHV3did2c2TS/gfpuzKlWko4BB8YsB94gwIrDph9T
         tjliYRrDhuBNx/W2BoTbp99y27VyLEgVeN2Aa6B/YYOszVv270hGyVmktA0HxP7a0U9z
         PuHXre754JIKgQvb6CSNjEH8B5+EAHFZAYMMHWRbMFwDgtFDsXVvfucBJajheF2/P6QO
         ffb8LRQFHtnIGxpH9L6u35t+jetlKNYoGuBZK/Lb38Q5JaM+dydNoIel/c2golpCzE1Y
         1ZCStTHYzYH3c6Z/VSzGQ7EfiKNxGnFOtjvMBpVN3rNbsuN5zRnp4mYZoiq9gs9V8sQX
         JnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=87y16Eke3JoFDTS3mJX5f9505D+ep7pI/R4smcsdKCE=;
        b=ovdibGEPKjlN9T32imKVoZQCalbn4lVr3hrwGhYt80BMa041EirBB67rcT7Cu2JJ5s
         AkfWL+T1jFR19EA4n8LFUALxgqfUkVG7SecEczDz7f6FADENsq5jHQ08JvvVoI89YOK8
         6RX9ZM4Pfx8nHa0hsd99+2QS03aO4t+sD60JVYgIOMYDCwgZU5AtFtSE7K4ChJRvXins
         0xO9yDScvs3VHvfKqxolRtU5SUEFwWcz47Etvsfst4Kt0r1N0RC8UoADvRtPF4jPcUHo
         z/HX39U1Pp12MhU9bRnQ5mvDZr4XpIR1sXBK7k0Hod+Iy0YgbPhjx7ZZ7Lp/TJeol39H
         0Epw==
X-Gm-Message-State: APjAAAUd4YIy7LxrpFRj9+sMYCNH6/8Wa1PvQFYGi4h11HYD+S0f64ZR
        KN8gVDo6MsPiyPoUVnFub5g=
X-Google-Smtp-Source: APXvYqyPJ9A5b8Ei8d2HjFdHBiKhM56KHcmV7bVvM/Biyy6igvq5jLgJ1KALPmMGZIwTWXClj7gucw==
X-Received: by 2002:a62:19d1:: with SMTP id 200mr856625pfz.26.1581645129489;
        Thu, 13 Feb 2020 17:52:09 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id gx18sm4234355pjb.8.2020.02.13.17.52.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Feb 2020 17:52:08 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     dan.j.williams@intel.com, koul@kernel.org, peter.ujfalusi@ti.com
Cc:     kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        info@metux.net, wenwen@cs.uga.edu, tglx@linutronix.de,
        dmaengine@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v2] dmaengine: ti: dma-crossbar: convert to devm_platform_ioremap_resource()
Date:   Fri, 14 Feb 2020 09:52:03 +0800
Message-Id: <1581645123-22819-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Use a new API devm_platform_ioremap_resource() to simplify code.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
changes in v2:
    Subsystem name is 'dmaengine', use that tag instead.
---
 drivers/dma/ti/dma-crossbar.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index f255056..4ba8fa5 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -133,7 +133,6 @@ static int ti_am335x_xbar_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct device_node *dma_node;
 	struct ti_am335x_xbar_data *xbar;
-	struct resource *res;
 	void __iomem *iomem;
 	int i, ret;
 
@@ -173,8 +172,7 @@ static int ti_am335x_xbar_probe(struct platform_device *pdev)
 		xbar->xbar_events = TI_AM335X_XBAR_LINES;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iomem = devm_ioremap_resource(&pdev->dev, res);
+	iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(iomem))
 		return PTR_ERR(iomem);
 
@@ -323,7 +321,6 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 	struct device_node *dma_node;
 	struct ti_dra7_xbar_data *xbar;
 	struct property *prop;
-	struct resource *res;
 	u32 safe_val;
 	int sz;
 	void __iomem *iomem;
@@ -403,8 +400,7 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
 		kfree(rsv_events);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iomem = devm_ioremap_resource(&pdev->dev, res);
+	iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(iomem))
 		return PTR_ERR(iomem);
 
-- 
1.9.1

