Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455872F9F57
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jan 2021 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbhARMS4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jan 2021 07:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391269AbhARMSw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Jan 2021 07:18:52 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C06C061574
        for <dmaengine@vger.kernel.org>; Mon, 18 Jan 2021 04:18:11 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p5so7355980qvs.7
        for <dmaengine@vger.kernel.org>; Mon, 18 Jan 2021 04:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2BSOeaSyLstS6j482GNO2SPq687l8/DBnTGIFxurKY=;
        b=LF8v+pL4kRIsP+lX0wq1XoWLX2wSWzoCUathfpvmruVsZeb5A5MV4Tc5Kjkt1aCips
         GpBBx0hBuNFHUplysfRxMEBqaHmR+1BMINF43QhP/MJ5+4yWfBv7OhqZp6HjgaR+6OYq
         I5uxtbWgjT+rw925p6RxuwAqWrZtv3RLpwXB9jlYpToBuwMmRNY2j/RM3kfucgT3j6X1
         3F/fYPjQIoTAW5QTuxrOIWxjOPiLfWD4x+dvafgZIe6NrsKwyFkeFQskPplyx5qyoMFb
         DEG1TYz9b0iZ2y5x8GEK4tQTRtgCXJpO5Pn/9A9QXk9Vj/QzeFOd4QwNymDcqCCr5oOf
         MDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2BSOeaSyLstS6j482GNO2SPq687l8/DBnTGIFxurKY=;
        b=eKFJqsnZga1B0nz0xc1IA46kLeX3gNXaSft+r+xpsJU/zZ5J6BL5qaWcDQO5vHlzXq
         oZYtHcgnoqT/eTPwqdnMk2c07onjs2EdyagCMA7DGuy2pGW1snhTEF60/r8dnMjou3rb
         HpLKZKnzJcnGsp9FYqjOd6aunGzD1MwaoC3EKPfwgtMlcUq9axqgVmQPJYnrsc3HWI3u
         3N1pPrFEgDtQ8oTdMw2vlkz/elO1TqwmTf8WeaVmdgUO4RFcoUbYyd3LS84I4duu6c9v
         886bxntmv2FFi8z9gsG2TfU3OGKPWI98hWqU2XPtT0BflT4jS4BnyIP7mQmuknz6ZWZk
         imSw==
X-Gm-Message-State: AOAM531L5v78oW+4T45rir5Sme7D5uCa2bp/dQCUCpSeeowgihkxFKbp
        lzbKQPJCPMssTjCiYkYe8IbBxFiwDyY=
X-Google-Smtp-Source: ABdhPJy0rzrbvfwhGZGpy8pYQGgrhQksS7xIKthiTr7mfzypjiUznq0Vhd27rKh4LSxbvQBlCGHRvA==
X-Received: by 2002:a0c:fe04:: with SMTP id x4mr23516207qvr.13.1610972291057;
        Mon, 18 Jan 2021 04:18:11 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
        by smtp.gmail.com with ESMTPSA id 74sm10259565qko.59.2021.01.18.04.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 04:18:10 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     shawnguo@kernel.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] dmaengine: imx-sdma: Use of_device_get_match_data()
Date:   Mon, 18 Jan 2021 09:15:49 -0300
Message-Id: <20210118121549.1625217-2-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118121549.1625217-1-festevam@gmail.com>
References: <20210118121549.1625217-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use of_device_get_match_data() to make the code simpler.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/dma/imx-sdma.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a68950f80635..d5590c08db51 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1952,8 +1952,6 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 
 static int sdma_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(sdma_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *spba_bus;
 	const char *fw_name;
@@ -1964,13 +1962,6 @@ static int sdma_probe(struct platform_device *pdev)
 	int i;
 	struct sdma_engine *sdma;
 	s32 *saddr_arr;
-	const struct sdma_driver_data *drvdata = NULL;
-
-	drvdata = of_id->data;
-	if (!drvdata) {
-		dev_err(&pdev->dev, "unable to find driver data\n");
-		return -EINVAL;
-	}
 
 	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret)
@@ -1983,7 +1974,7 @@ static int sdma_probe(struct platform_device *pdev)
 	spin_lock_init(&sdma->channel_0_lock);
 
 	sdma->dev = &pdev->dev;
-	sdma->drvdata = drvdata;
+	sdma->drvdata = of_device_get_match_data(sdma->dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.17.1

