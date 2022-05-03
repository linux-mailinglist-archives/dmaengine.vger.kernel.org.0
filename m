Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC59517DE0
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiECG6b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiECG6L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:58:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD13240B7
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:54:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so31663719ejb.4
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rzcyxWl1wMJihRThXzFaCrK82eFdfscpNcxmBTO4Zs=;
        b=rp2vJMX2WRd+WTVaQ+gAByXbAnWH+BH3nPt1AIbQ7cvijNLUhZuGgyhenA0yhVQfPG
         uWS19Gc5sw0Cwo9fi2HSZpD67a0AFpYFAUu+FDSkPNG39e0Sx1ZxADNP7bzrMieFkE/V
         8I7cwqj7gLtG5QpeDaFiAjIEVz6T3rbfNTPh/cdoOKAtJTJ9t/lnpE2F/LD7EQ0vYbtm
         HTQRRII0xkl3ds2941iMPvF/OlTtArm0GX17CBUY6NV/OT2rQk8F2HMS6ZW78f2GplHd
         j3Y3clcH9BQiy9by7+RaPrellpvkMGHsA16N1spNie00vu/pjSs3NAixMIxJh58SYvLf
         YE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rzcyxWl1wMJihRThXzFaCrK82eFdfscpNcxmBTO4Zs=;
        b=GLLEQVN4r3iNvA2/476b/U2gQlKhkQlO4oNSWwnl9XpQFHvdZGJzP0DnQlUQIyjewI
         gzM+MZfC4rElcbM627BGTFHCZblkzPV29bMpoTGJ2auNvseTOvjQ4qZNUibHWVnAfmDb
         cjVuPYCSIDfPCxv3Sf2U0CrDKmB/OcnXx1P6h5F+2GCLmlwZUB8Isf3wuv2i4rRlcOa5
         8hvpepPOCKRxP+8Rv0qNIif16sRAFOUUNQ37V0geCGgmY56yVVYtWDlQ80bEH1J9i+by
         0yjFh12RCTsM8NdIldyTuHnD0g0oYz9D4MBWkqZoBKHniCHU+kzKXjI+/KPM7eY+U/6b
         bklA==
X-Gm-Message-State: AOAM531KtxL95B15TZvVmpgtvV6GyGcw/PfAneLKmTO6UHTag6s9tzsv
        /vcNXGMYh8GT0KKfJcV7XO6+2w==
X-Google-Smtp-Source: ABdhPJzlAgp3dhSdZgvOmwYwRgPSdCumZoCd77/K2/s+req5QrJ7sIjCLWN5Fwu2Fu5B5FKCAmrc9Q==
X-Received: by 2002:a17:907:9706:b0:6f4:7ed4:db57 with SMTP id jg6-20020a170907970600b006f47ed4db57mr2916444ejc.432.1651560854100;
        Mon, 02 May 2022 23:54:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0042617ba6396sm7565326edr.32.2022.05.02.23.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:54:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] dmaengine: mmp: deprecate '#dma-channels'
Date:   Tue,  3 May 2022 08:54:06 +0200
Message-Id: <20220503065407.52188-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
References: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The generic property, used in most of the drivers and defined in generic
dma-common DT bindings, is 'dma-channels'.  Switch to new property while
keeping backward compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/mmp_pdma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 5a53d7fcef01..e8d71b35593e 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1043,13 +1043,17 @@ static int mmp_pdma_probe(struct platform_device *op)
 		return PTR_ERR(pdev->base);
 
 	of_id = of_match_device(mmp_pdma_dt_ids, pdev->dev);
-	if (of_id)
-		of_property_read_u32(pdev->dev->of_node, "#dma-channels",
-				     &dma_channels);
-	else if (pdata && pdata->dma_channels)
+	if (of_id) {
+		/* Parse new and deprecated dma-channels properties */
+		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",
+					 &dma_channels))
+			of_property_read_u32(pdev->dev->of_node, "#dma-channels",
+					     &dma_channels);
+	} else if (pdata && pdata->dma_channels) {
 		dma_channels = pdata->dma_channels;
-	else
+	} else {
 		dma_channels = 32;	/* default 32 channel */
+	}
 	pdev->dma_channels = dma_channels;
 
 	for (i = 0; i < dma_channels; i++) {
-- 
2.32.0

