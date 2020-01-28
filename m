Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7E14AF21
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 06:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgA1FgN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 00:36:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46929 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1FgN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 00:36:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so3533887pfp.13;
        Mon, 27 Jan 2020 21:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ETtmj92dMxQ/nDAdyiV4y6n6dPMRnfeIUJGrUNEUib8=;
        b=o/Mt99aLf84cqRfH/lrRWLwIrv4xFzF0dkz+MI/gWtAWj59gg+wqMwNozt7Um0x9p7
         wpXD0IHhQzBldl83LOckx42e2tN5EnkLL7pAyY2nypg4XTIxMRpIrrfdHjmTV3ntE5sM
         +6eYJ+cXkt1pRI3hg0AHL+2C6I7VOl7U6oAf/C232oh04RZ461AY/6leVNxBVCKC2FtD
         Syfzav51zspiPWi5zvoiHVhww/StEBY1WmMkTyRYWCjjtkMFyZfRzf/HVZ9Zcumygwoz
         EwJCGvA/paOTO/CofZBqNPl6N78nhwTMKAQz2L4f0AnicxSs/jaLxjWoNJp39ATWItuL
         jupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ETtmj92dMxQ/nDAdyiV4y6n6dPMRnfeIUJGrUNEUib8=;
        b=ROvyLhXQz2yh3/xhk8uFa476YV9IVv9ngaQfogXdWHqJkPQpdax1dcAV8SDBHUiJxb
         08IpAg46Cu1VFaXFRxhr8OF9M2U9S82GdzoumhtkTfHJw+U3bW84RTsNEvHueIiHEbp5
         5SbDl5c0ZOUn17/Se4nDmbHv0Y6/MHqA3z5uNdN894ZkfOvIANg1CyE1EuATFo0lXJxj
         CGhwKx7E6a3XHzlrLiwiO1kBpMgS7ISNEgM3smQMUI5SspcBU2GxJo+AYNYkRd9Aa3Ik
         8wadQahUl2LVXosll1lvTa5a808GngyDcUhm2eDP/6DnBVnI0HCiNQDXKrHm2pTccGtH
         oTXg==
X-Gm-Message-State: APjAAAWerRmpUXTK4Rer39PE1oF9M5uRqEda2PSA9XnstYPx/oVpKDQ3
        5jRtEinlnNenhG6StciCezw=
X-Google-Smtp-Source: APXvYqw94ejRRZ6gTfNBUySlYzSPB5npM08i5FiOQEro9XpE55diLSQ51nYy7td/jfmwrJUKAYG9uQ==
X-Received: by 2002:aa7:8f3d:: with SMTP id y29mr2337488pfr.183.1580189772955;
        Mon, 27 Jan 2020 21:36:12 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z30sm18792569pfq.154.2020.01.27.21.36.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Jan 2020 21:36:12 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     vkoul@kernel.org, dan.j.williams@intel.com, allison@lohutok.net,
        peter.ujfalusi@ti.com, kstewart@linuxfoundation.org
Cc:     tglx@linutronix.de, wenwen@cs.uga.edu, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] dma: ti: dma-crossbar: convert to devm_platform_ioremap_resource()
Date:   Tue, 28 Jan 2020 13:35:46 +0800
Message-Id: <1580189746-2864-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Use a new API devm_platform_ioremap_resource() to simplify code.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
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

