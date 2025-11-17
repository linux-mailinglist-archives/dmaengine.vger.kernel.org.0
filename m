Return-Path: <dmaengine+bounces-7200-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96091C62E1F
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 09:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3794E4286
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F94316182;
	Mon, 17 Nov 2025 08:25:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDE280328;
	Mon, 17 Nov 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763367946; cv=none; b=ms8r7FPrIxw+wqG1y0GAbSDTlsYOc5JxyQfhWu2GrMv9glRDvozhQJNR4+1wVRzpBEC8PtrgeX/LaGjP+7mxGmmG81AJG8UxykmmbBbFmlxEdZpfz61W3kleS1iE11TCrmVPqGdFM+K5De9azkP22y8J7xTNZZbGBL4jB8gA25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763367946; c=relaxed/simple;
	bh=A3TSK9J85pbNRB7/61xFX+IxlSgMX2hqlE7LuvPpJ9g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aJeGMGIw8n0VhrtTMpojSaDosUepOZGL991tHHSk3b5L3+Qc/ep6OhzkwXNfqXxMMreqiX333gkJopPz3whty0abD4EQh8lHmKoTKjTmOwXe7ozv491DDfaRcsA556EHXpxIubQUK41aqNONW8iTeSeQFW2gRnOUvX6ALM0TyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowADXa8v92xppHAUHAQ--.14111S2;
	Mon, 17 Nov 2025 16:25:40 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: ti-dma-crossbar: Fix error handling in ti_am335x_xbar_route_allocate
Date: Mon, 17 Nov 2025 16:25:32 +0800
Message-Id: <20251117082532.918-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowADXa8v92xppHAUHAQ--.14111S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4ktrWfGr18JrWxWF48JFb_yoW5XFyUpa
	y8Ga4Yv395KF1Ig34rCw4UuFWakr4Fqa1agrWxC340kwnIqryjqrW5Ja40qr1Yyr97JF4D
	XF17tr4rCFy7urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjhF4tUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

ti_am335x_xbar_route_allocate() calls of_find_device_by_node() which
increments the reference count of the platform device, but fails to
call put_device() to decrement the reference count before returning.
This could cause a reference count leak each time the function is
called, preventing the platform device from being properly cleaned up
and leading to memory leakage.

Add proper put_device() calls in all exit paths to fix the reference
count imbalance.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 42dbdcc6bf96 ("dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/dma/ti/dma-crossbar.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 7f17ee87a6dc..58bc515ec8b3 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -80,33 +80,40 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
 	struct ti_am335x_xbar_data *xbar = platform_get_drvdata(pdev);
 	struct ti_am335x_xbar_map *map;
+	int ret;
 
-	if (dma_spec->args_count != 3)
-		return ERR_PTR(-EINVAL);
+	if (dma_spec->args_count != 3) {
+		ret = -EINVAL;
+		goto err_put_device;
+	}
 
 	if (dma_spec->args[2] >= xbar->xbar_events) {
 		dev_err(&pdev->dev, "Invalid XBAR event number: %d\n",
 			dma_spec->args[2]);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto err_put_device;
 	}
 
 	if (dma_spec->args[0] >= xbar->dma_requests) {
 		dev_err(&pdev->dev, "Invalid DMA request line number: %d\n",
 			dma_spec->args[0]);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto err_put_device;
 	}
 
 	/* The of_node_put() will be done in the core for the node */
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "Can't get DMA master\n");
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto err_put_device;
 	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		of_node_put(dma_spec->np);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto err_put_device;
 	}
 
 	map->dma_line = (u16)dma_spec->args[0];
@@ -120,7 +127,12 @@ static void *ti_am335x_xbar_route_allocate(struct of_phandle_args *dma_spec,
 
 	ti_am335x_xbar_write(xbar->iomem, map->dma_line, map->mux_val);
 
+	put_device(&pdev->dev);
 	return map;
+
+err_put_device:
+	put_device(&pdev->dev);
+	return ERR_PTR(ret);
 }
 
 static const struct of_device_id ti_am335x_master_match[] __maybe_unused = {
-- 
2.17.1


