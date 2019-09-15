Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A9B2F14
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfIOHcq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:32:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34144 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOHcq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:32:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so17546662pgc.1;
        Sun, 15 Sep 2019 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=epiWAfrrjHwKJt0b7IMtr8i9SbnEcdcq2Ym8PuAYz04=;
        b=QtyDwWHemh4cRk7EU4ZwvpL1HMwqx2nSdOePw1BNvFwHm0++GYgWCO69MOU5SAKKDm
         bKw7HlAcNKeeEef1wKUPYaoqxyyGhnUEnrX76doUT1E9IVXloFaZ5hCd8yamr+EFN5sm
         Qzlmxo7+hTrXuKITqoZuvRdpEeZn1nzaypHV7OdEL5a1O1G1pVVS8cErf1GaFIZinCFt
         qHt1+Hfyw3JpHB28dugHsdi6DRiIFHED+53aUfUVtD7k35ST9XD6p9FxKcc3djaGw4VK
         kVPj0oGNypP+oTC1Ps0drCM284c1u6ZwNTvUe/F2F7aWLOvfL5VR5LWWXjKdgbbMF+Ue
         W3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=epiWAfrrjHwKJt0b7IMtr8i9SbnEcdcq2Ym8PuAYz04=;
        b=ZAmaUnjIN/cPfO0AROWVAxN2ATsJil9qC3fAYnJcLGZvcsK0LbCYow4G61M0Av/ZZC
         SjuvRbRH0ImfEZ8zyR4pqnfRmjk5rQ5QIN7LQD4Yx4JrQg3TshX03UkgYX+fXmCek6iv
         fEjBTMIW6IyGtB1sR2OQz1z1qOxZOVj9djWmNr59I1bP3bNYtulQEfIS9HRBOv6h9mkR
         J4yi1ytYxRau76KaVCBCOEOcdJIWgNL413DgB2HPwwo1iF8eQMKPPL8fLK1vf0qSWl+0
         03v3qJmuIcfb8Z4oj58WGgR/CeGoQ39Qaz0LNw+T5yLrdGHc9b4amlLH2xAqr+eUrVvf
         a8IA==
X-Gm-Message-State: APjAAAWCjwDwQ8dcWEj6JMAgI66iJ1BYl7bU7IC+AG4v4HpHVtvC30KL
        gVEFVQOT9gzlN8EPI0bNwrk=
X-Google-Smtp-Source: APXvYqxKE6UOnyayAFP+Ed+EdafQY4inmPdkuc4MpFTdLnndQPUnn3o556ROa4qcANt3ls98+BqUww==
X-Received: by 2002:a63:5652:: with SMTP id g18mr19651857pgm.393.1568532765954;
        Sun, 15 Sep 2019 00:32:45 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id b6sm27961404pgq.26.2019.09.15.00.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:32:45 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] probe/dma/owl: removed redundant code from owl dma controller's probe function
Date:   Sun, 15 Sep 2019 13:02:36 +0530
Message-Id: <20190915073237.24176-1-sst2005@gmail.com>
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
 drivers/dma/owl-dma.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 90bbcef99ef8..03e692fc25a1 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/slab.h>
+#include <linux/probe-helper.h>
 #include "virt-dma.h"
 
 #define OWL_DMA_FRAME_MAX_LENGTH		0xfffff
@@ -1045,20 +1046,15 @@ static int owl_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct owl_dma *od;
-	struct resource *res;
 	int ret, i, nr_channels, nr_requests;
-
-	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
-	if (!od)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	od->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(od->base))
-		return PTR_ERR(od->base);
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq
+	 */
+	ret = devm_platform_probe_helper(pdev, od, NULL);
+	if (ret < 0)
+		return ret;
 
 	ret = of_property_read_u32(np, "dma-channels", &nr_channels);
 	if (ret) {
@@ -1105,18 +1101,11 @@ static int owl_dma_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&od->dma.channels);
 
-	od->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(od->clk)) {
-		dev_err(&pdev->dev, "unable to get clock\n");
-		return PTR_ERR(od->clk);
-	}
-
 	/*
 	 * Eventhough the DMA controller is capable of generating 4
 	 * IRQ's for DMA priority feature, we only use 1 IRQ for
 	 * simplification.
 	 */
-	od->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, od->irq, owl_dma_interrupt, 0,
 			       dev_name(&pdev->dev), od);
 	if (ret) {
-- 
2.17.1

