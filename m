Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD65F6E41BF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDQH43 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjDQH4C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 03:56:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA053C3E
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ec8148f73eso1203001e87.1
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718157; x=1684310157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WctxKpomw5MLFuTazOUJElliLOUHb46B+NNI3oGGJOk=;
        b=nrm3vCoDnCsGk5roNJOkOPJb/qrgzSDL7HZTpjuS0DYFM6k0XGk3ilID4Iatv3LMvT
         U8XRVJCyLpQPX9QHRfpxzhPr+M0L7uNCX/jXSFPGuAct/7na75uNhvspwNSp+NPOOgy2
         c5sf/zmkK6CZ4sSFs4FPA+pTrK5+A6eQfN2XMWFzbyvyf0fKZzzaenFoeKS3LNFBdHez
         7Cpjj8F9/dvQDjk24cKykEUjvRQCrPGJwkXmFFL2E04fQ0gOv9h34nIfWleyj3Q+tie1
         6lbhupaT40ktTPvKuE2LOCfoE9spvTMDf8WK04iGb50AQ3vq605S/bKk3klAWPhdAT0S
         muzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718157; x=1684310157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WctxKpomw5MLFuTazOUJElliLOUHb46B+NNI3oGGJOk=;
        b=Yp898vSZIFTrIe9P079gqqKElnjHf4zLhe/gX5nkaDhUh1BiDs87QNUxzO/s1pZK5p
         t5B3vcz3xzzhqd+Jtajd1UARBuG/zRcK3Xbm657v60pBy8ieD7Upv8RXRfMsdkewyCKf
         xRrmBxnaMqmdiIR/7oUPPTa8T7sY/nKIicQvlgtkh3BgOBbjnsUsyPaom7+U8BhBHjxs
         5yG+uZpcJtG16o2X2nFrfuO07ggnpUKSHmR+f39P2FVEwyOr8SFuVCug80SvRlNcZMyD
         PJcqt8sq5YZ97uBV/WCSItevSJ6CLU4ux+iym+w0bEA+qP8DbTiAZ+dcpUyT1RY+Nrnq
         S+cA==
X-Gm-Message-State: AAQBX9cy9emUSOF1Vp0PiiD7YxvbolTO1urGkYhSmTNQN9AAGgodRw3z
        7LK4tgg5UP8yrisDhfgjcCELFw==
X-Google-Smtp-Source: AKy350brBnsZQMq3FHoLYXhVv31Cc/XfOFRTXUTswulWQSeew8raaiwxMvUBRANzUX5EgIbKWZTllw==
X-Received: by 2002:a05:6512:924:b0:4eb:274b:a69 with SMTP id f4-20020a056512092400b004eb274b0a69mr2163114lft.26.1681718157639;
        Mon, 17 Apr 2023 00:55:57 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004eb274b3a43sm1952547lfc.134.2023.04.17.00.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:55:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:55:50 +0200
Subject: [PATCH 5/7] dmaengine: ste_dma40: Pass dev to OF function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v1-5-b26324956e47@linaro.org>
References: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The OF platform data population function only wants to
use struct device *dev, so pass that instead.

This change makes the compiler realize that the local
platform data variable is unused, so drop that too.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e5df28cdc4c8..fe98f12b8130 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3480,14 +3480,14 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 	return ret;
 }
 
-static int __init d40_of_probe(struct platform_device *pdev,
+static int __init d40_of_probe(struct device *dev,
 			       struct device_node *np)
 {
 	struct stedma40_platform_data *pdata;
 	int num_phy = 0, num_memcpy = 0, num_disabled = 0;
 	const __be32 *list;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
@@ -3500,7 +3500,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 	num_memcpy /= sizeof(*list);
 
 	if (num_memcpy > D40_MEMCPY_MAX_CHANS || num_memcpy <= 0) {
-		d40_err(&pdev->dev,
+		d40_err(dev,
 			"Invalid number of memcpy channels specified (%d)\n",
 			num_memcpy);
 		return -EINVAL;
@@ -3515,7 +3515,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 	num_disabled /= sizeof(*list);
 
 	if (num_disabled >= STEDMA40_MAX_PHYS || num_disabled < 0) {
-		d40_err(&pdev->dev,
+		d40_err(dev,
 			"Invalid number of disabled channels specified (%d)\n",
 			num_disabled);
 		return -EINVAL;
@@ -3526,7 +3526,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 				   num_disabled);
 	pdata->disabled_channels[num_disabled] = -1;
 
-	pdev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	return 0;
 }
@@ -3534,7 +3534,6 @@ static int __init d40_of_probe(struct platform_device *pdev,
 static int __init d40_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct stedma40_platform_data *plat_data = dev_get_platdata(dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
 	int ret = -ENOENT;
@@ -3544,7 +3543,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	int num_reserved_chans;
 	u32 val;
 
-	if (d40_of_probe(pdev, np)) {
+	if (d40_of_probe(dev, np)) {
 		ret = -ENOMEM;
 		goto report_failure;
 	}

-- 
2.39.2

