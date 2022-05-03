Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E8E517DDD
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiECG6V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiECG6L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:58:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73956222A9
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:54:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g6so31699500ejw.1
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31n4NKx1muSic9R+KSUXp8YhkBAU/fz0QvMncbQEELc=;
        b=Z5OIn2rGyBFk1Z0vLmDQ388oecgW+5bheVurOGOOLeKLfpQMU/B0yOM6ZWJfiGK7qd
         0DCYzPrCJ+5W/frYoExpIvaiU9h9meCDGS50IlADuFtCVv9NLSC6cvj+StOhCh7IUWQm
         Cc1pVuYmnVfxpeZfxEr5j8x40k+ZfNzbNNYCXEH+hfUxcBLspZUCLK0tKCKhLrhCfkno
         9BlR3PiImyJK2Hf7rdvOQgpGV1//1g5z3g6VBjh9KoXN1ONPAZ8h0ad0La1e/hErSKl9
         RPe7P6RiKVoL8IOaXnMdaAr4s+fii8ZiRjaQTygT59ozkDNR678+FD3WKbx8VKk864NX
         pzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31n4NKx1muSic9R+KSUXp8YhkBAU/fz0QvMncbQEELc=;
        b=ePaubD4CK3U2kk3mfv0E0our8ne4EhuuMTep7jbNzRLL1zReCyhy/WQPg0SZGtFGi+
         BNVVMBeLWcc8p4fD5cYhr4Z4ehzRuOeYkMlBGNBcWxN6efyuSg3lQZE1GERYziT2NEdu
         TfnUSOH7jbCO/3ISHsmexWjfoAbva2Y+3R7gmkcXzzRDRtPg8MYtsQ6RB2wNuZgGI36T
         tO8CRBcSw6xG3Ye9tghxxDnn1B4ta1F3M6mlgIJ3gWC+YEo/LyjjX3/1crOAvx5RNJSd
         JefTFugBqqAhrlwTudVVzDiHCltmSpiDd/5uomFd0xxIVfXedoPuVz3w6HGVGP5ELSOU
         PJOw==
X-Gm-Message-State: AOAM530V7QYykeFaQAjbr1gMZB58LXv8qh1kwIfVeNjqIIkwrVrM6AX8
        HSuQL9BjwrPPBJCZl5jc9VcbdQ==
X-Google-Smtp-Source: ABdhPJzDXkyPokM0IM43pGWhXvxnvp8eZB1vqKbFxpPmZDLh9aEzEuzQI4DcfJhCWvBSd40FFqZaHg==
X-Received: by 2002:a17:907:6e02:b0:6f3:d185:5d25 with SMTP id sd2-20020a1709076e0200b006f3d1855d25mr14343646ejc.14.1651560853020;
        Mon, 02 May 2022 23:54:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0042617ba6396sm7565326edr.32.2022.05.02.23.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:54:12 -0700 (PDT)
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
Subject: [PATCH v2 2/4] dmaengine: pxa: deprecate '#dma-channels' and '#dma-requests'
Date:   Tue,  3 May 2022 08:54:05 +0200
Message-Id: <20220503065407.52188-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
References: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The generic properties, used in most of the drivers and defined in
generic dma-common DT bindings, are 'dma-channels' and 'dma-requests'.
Switch to new properties while keeping backward compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/pxa_dma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 6078cc81892e..e7034f6f3994 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1365,10 +1365,17 @@ static int pxad_probe(struct platform_device *op)
 
 	of_id = of_match_device(pxad_dt_ids, &op->dev);
 	if (of_id) {
-		of_property_read_u32(op->dev.of_node, "#dma-channels",
-				     &dma_channels);
-		ret = of_property_read_u32(op->dev.of_node, "#dma-requests",
+		/* Parse new and deprecated dma-channels properties */
+		if (of_property_read_u32(op->dev.of_node, "dma-channels",
+					 &dma_channels))
+			of_property_read_u32(op->dev.of_node, "#dma-channels",
+					     &dma_channels);
+		/* Parse new and deprecated dma-requests properties */
+		ret = of_property_read_u32(op->dev.of_node, "dma-requests",
 					   &nb_requestors);
+		if (ret)
+			ret = of_property_read_u32(op->dev.of_node, "#dma-requests",
+						   &nb_requestors);
 		if (ret) {
 			dev_warn(pdev->slave.dev,
 				 "#dma-requests set to default 32 as missing in OF: %d",
-- 
2.32.0

