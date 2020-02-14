Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B215CFA1
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 03:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgBNCBD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 21:01:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44535 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgBNCBC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Feb 2020 21:01:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id y5so4044660pfb.11
        for <dmaengine@vger.kernel.org>; Thu, 13 Feb 2020 18:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=87y16Eke3JoFDTS3mJX5f9505D+ep7pI/R4smcsdKCE=;
        b=Kd+Lrt12jStMjtScuz0e7OU4tcnnPn0BW9j2zKCYXFjRovCOlFSey12cklLwgeqB5y
         wIwhy0XwBOuPEYdqoqZCcEsydkXbayaoZ/fTiA1OzxfCz6O9HjelAgVCiu8RRLFHl0hk
         0aSR/RmLd0bOq8pq3h0Gq7/klJWo9XGzX6zA3M/TkO9km3quXxQr1mM/t6RGVFjFFJFd
         og+vUZFNqM3hhEoHJi9Gkgs+0hhqTyTsfNaAjJfVKGUItjPYscaO1epTOY2D2k3/upS5
         HLEzIkKXt3b0yHe/Y2AgBGhm8OS/B07dHD0h0qiSodFwmNlE/nvrwH/9Tfqi4aO3nJWU
         sUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=87y16Eke3JoFDTS3mJX5f9505D+ep7pI/R4smcsdKCE=;
        b=CtHFGU+9O8rquX64d9MRObMpwBvR9ueVYvWpHgwk/+hI8sfeQ4qUkjN5vcLpAbzcdv
         WZQ65nwmWpTvmmbxI5L7qgNJtRWJ79a45qHdUeEKUMPKuba+00f8bw/3Y9KjPnQlqwP2
         FA/MXE83jDfxTbv3K7OcS5d5br8xDy7UgdJvqgG9MwVwoFgtW3RE02igo5GhPS4FYyj4
         npBDjQmvDm8Z7veYa8pyAfBvhOVRnyWC1le/imI5qteSagMQTxjlGl4CGxL+l76i50j9
         cOKK83puMgwAmOUdjvxgyWZz4a7KIifzR52UXtjuIl+HJRJBeCAl6cU7YOZ0kkFAFBAE
         5DRQ==
X-Gm-Message-State: APjAAAXhLuSAGPe4PXkyiDI1K2lIPEtYF3R4w1bmyxd7JCynCvg9NkIg
        Ce8TqFZvKzWe37b+RYgE6qQ=
X-Google-Smtp-Source: APXvYqzg/SevLog/y980NI0yiW/G/VtndW6frH3lAf9myEno7R1ASuN+bzfiiaVxvrEGfrktAzwdqQ==
X-Received: by 2002:a62:36c2:: with SMTP id d185mr890306pfa.203.1581645661013;
        Thu, 13 Feb 2020 18:01:01 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b21sm4742722pfp.0.2020.02.13.18.01.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Feb 2020 18:01:00 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     dan.j.williams@intel.com, vkoul@kernel.org, peter.ujfalusi@ti.com
Cc:     kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        info@metux.net, wenwen@cs.uga.edu, tglx@linutronix.de,
        dmaengine@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v2] dmaengine: ti: dma-crossbar: convert to devm_platform_ioremap_resource()
Date:   Fri, 14 Feb 2020 10:00:55 +0800
Message-Id: <1581645655-22968-1-git-send-email-qiwuchen55@gmail.com>
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

