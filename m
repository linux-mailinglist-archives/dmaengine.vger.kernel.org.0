Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F1B2F01
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfIOH3w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:29:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35944 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOH3w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:29:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id m29so1251359pgc.3;
        Sun, 15 Sep 2019 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HnPNE6bny7nidosOapEAj+KRL90m9eSVpY97KZloEc=;
        b=SbdyYrUwmxpWw/IGnwApl9GNJByd+tJBzyW7ttbSD3kpB74BJhHDAenksQx1KOhzEi
         OSUIkFxuifbsT8JI2JiFEAcshvMAFP1vBazrnpR8emlPTE9npePVU1jAhcTGpYngvW/R
         iOd65Q7y6v4A5OrUTbGLcNThec0I+4zJkgcAVWYpQhPRU3+GRgMbmu4WwebcJKOFgZAJ
         ZcBloZ2hTvZRoTlMdi5eH+LTTnZnt2TkWQWV+hPdlGDRiYhtEkQxUhPChfvsVQSikYQc
         IzQ0pFYaVZ0mtdQg+X6OeUevfyYARVy+0aJyIGCET6iDZMPPxBK3+x6fQoYN6YdNxI0m
         g3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3HnPNE6bny7nidosOapEAj+KRL90m9eSVpY97KZloEc=;
        b=FBx/Iu2KkMDhlAjBK8+iTSuc+4QwJFRSbeb7+wjnTYLMrdXQPxmdkcp9KrelHUiZft
         +lpJBLB1vUicAQcNwk1bKOkzcxElXqZjhL0Io8g2wXCjsZKm9U1RnuWIPq3UigmNSuqX
         6mdSkUGhbNWI1rJr0lvrNYP13NxztsZWBfr+ZA11s+jdpVoSbCBkmc48gaD/Pf0vT/8D
         IyaKglVorPCrvEvCAq5SiI9RaRoFYJ0or8EwqUVacFrWj1U1tAahkAEELRNbqV9bmog8
         WrHRjT45SUIDans5k7YRY99KXLS+BQ1D++03Qq5JqydogKXtenSWwMmI3g+rpLly1C7i
         RhgA==
X-Gm-Message-State: APjAAAWc9f03Mp7XPqMV7KN48rdkEkLbsLOKuf0qoHKGjEUShGm+Y/7p
        f3M0PQaEuaeGxiV5oJlFP/4=
X-Google-Smtp-Source: APXvYqw5PxTdM1K9L0LNRfE6IZWWx5WTGGNbG/zb6i4AP/v8NpFmj9emb+i7ELsl/NB8c0v4ahPk2g==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr50346497pgc.20.1568532591347;
        Sun, 15 Sep 2019 00:29:51 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id 132sm10029355pgg.52.2019.09.15.00.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:29:50 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] probe/dma/zx: removed redundant code from zx dma controller's probe function
Date:   Sun, 15 Sep 2019 12:59:38 +0530
Message-Id: <20190915072938.23610-1-sst2005@gmail.com>
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
devm_request_irq
are replaced with a macro devm_platform_probe_helper_irq.

2. Removed dmam_pool_destroy from remove method as dmam_pool_create
is already used in probe function.

3. This patch depends on the file include/linux/probe-helper.h
which is pushed in previous patch [01/09].

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 drivers/dma/zx_dma.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 9f4436f7c914..d8c2fbe9766c 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/of_dma.h>
+#include <linux/probe-helper.h>
 
 #include "virt-dma.h"
 
@@ -754,20 +755,17 @@ static struct dma_chan *zx_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 static int zx_dma_probe(struct platform_device *op)
 {
 	struct zx_dma_dev *d;
-	struct resource *iores;
 	int i, ret = 0;
 
-	iores = platform_get_resource(op, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -EINVAL;
-
-	d = devm_kzalloc(&op->dev, sizeof(*d), GFP_KERNEL);
-	if (!d)
-		return -ENOMEM;
-
-	d->base = devm_ioremap_resource(&op->dev, iores);
-	if (IS_ERR(d->base))
-		return PTR_ERR(d->base);
+	/*
+	 * This macro internally combines following functions:
+	 * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+	 * devm_clk_get, platform_get_irq, devm_request_irq,
+	 */
+	ret = devm_platform_probe_helper_irq(op, d, NULL,
+		zx_dma_int_handler, 0, DRIVER_NAME, d);
+	if (ret < 0)
+		return ret;
 
 	of_property_read_u32((&op->dev)->of_node,
 			     "dma-channels", &d->dma_channels);
@@ -776,18 +774,6 @@ static int zx_dma_probe(struct platform_device *op)
 	if (!d->dma_requests || !d->dma_channels)
 		return -EINVAL;
 
-	d->clk = devm_clk_get(&op->dev, NULL);
-	if (IS_ERR(d->clk)) {
-		dev_err(&op->dev, "no dma clk\n");
-		return PTR_ERR(d->clk);
-	}
-
-	d->irq = platform_get_irq(op, 0);
-	ret = devm_request_irq(&op->dev, d->irq, zx_dma_int_handler,
-			       0, DRIVER_NAME, d);
-	if (ret)
-		return ret;
-
 	/* A DMA memory pool for LLIs, align on 32-byte boundary */
 	d->pool = dmam_pool_create(DRIVER_NAME, &op->dev,
 			LLI_BLOCK_SIZE, 32, 0);
@@ -894,7 +880,6 @@ static int zx_dma_remove(struct platform_device *op)
 		list_del(&c->vc.chan.device_node);
 	}
 	clk_disable_unprepare(d->clk);
-	dmam_pool_destroy(d->pool);
 
 	return 0;
 }
-- 
2.17.1

