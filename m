Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF542512099
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbiD0QUh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbiD0QTX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:19:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F21336E38
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:16:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k23so4430338ejd.3
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4VzhkWiZCxUXRF8iX+xp5MfZBCcHCDwpOVdBeFnavlE=;
        b=U1HBEC4cHR49LZJPnRWWK5GyEYH+FgfciW/s3I7EUYGqhlzXQGJz2Vrb/dTjPF2/o9
         jzHB/vXO+QChU30hQu22ZfQlvP7Uf4l2oFJ/U7OSH+GoyiByPQZRhNfISFypO2EoPR0K
         TXoHkihZBoKu2URuvf34R8k6hMFaYJPuxHoKQS1W+NybncDhdLAGwxAwLDQTq8zNfB6m
         xS7sC2Rl4c4wlzaw/9RnGh1eKcZuVnu/hYx/Xvqpj6d810Ktp2BOQy7EVTTt0+Upl59A
         LI3OxacDVkOZmCeqFbb8GJsI8ZoAIKtRqEzhlnXjIBgLSFkR59BUD0L0RA3NtUgX9VwL
         gVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4VzhkWiZCxUXRF8iX+xp5MfZBCcHCDwpOVdBeFnavlE=;
        b=Ut6+aNIDugWJl//YlxQ9Sb15DKjbNFyBC1F2Fr6lOAp/tQ8ipPCS0wUwzOCBtC/c47
         SkUYy5RJMg+A2imPlSyBZQFhgbg9vT2SIiBfbPG9nFHrk4G5aArnV3KA9ZvSgsA8Yv5q
         XooGtvYbR3r0dUDLt4Yk63fhMAc5CNXONKreUq0cwLJQPR7qQ6QO/xokUQbTgKn3Juwu
         QqjQVFPn3iNOzAz14qGVvauomotjMAtHg9e1SXDO84yu361RHpCydibLTSPOojP3qI9H
         anvlYXSztU/yUcz2WGNs+HePbMtvPPkuOmC+rd1e2wX3nLqtiokeSEIJ0q5FAg7mYzgX
         ep+w==
X-Gm-Message-State: AOAM530UocpyWyr57KLvaVY6kYnXIDVomkoz5Iw0Az0reF99bh9NMp8p
        FBp8N3d1bZK0S1bs6BLo1hnDsg==
X-Google-Smtp-Source: ABdhPJx+J4Fwg1jZEwuFrg1VMUFB/mcoAonFGOK4HecHtr8mYLo0eQf0a8XbCgNBKyZUSf0780iYqg==
X-Received: by 2002:a17:906:3f83:b0:6f3:c1ca:9c72 with SMTP id b3-20020a1709063f8300b006f3c1ca9c72mr4736318ejj.539.1651076140638;
        Wed, 27 Apr 2022 09:15:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709064cd100b006e78206fe2bsm7131192ejt.111.2022.04.27.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:15:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: dmaengine: fsl-imx: deprecate '#dma-channels' and '#dma-requests'
Date:   Wed, 27 Apr 2022 18:15:32 +0200
Message-Id: <20220427161533.647837-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
References: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The generic properties, used in most of the drivers and defined in
generic dma-common DT bindings, are 'dma-channels' and 'dma-requests'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
index 7bd8847d6394..1c9929d53727 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
@@ -13,8 +13,10 @@ Required properties:
 - #dma-cells : Has to be 1. imx-dma does not support anything else.
 
 Optional properties:
-- #dma-channels : Number of DMA channels supported. Should be 16.
-- #dma-requests : Number of DMA requests supported.
+- dma-channels : Number of DMA channels supported. Should be 16.
+- #dma-channels : deprecated
+- dma-requests : Number of DMA requests supported.
+- #dma-requests : deprecated
 
 Example:
 
@@ -23,7 +25,7 @@ Example:
 		reg = <0x10001000 0x1000>;
 		interrupts = <32 33>;
 		#dma-cells = <1>;
-		#dma-channels = <16>;
+		dma-channels = <16>;
 	};
 
 
-- 
2.32.0

