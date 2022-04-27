Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D35120A2
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbiD0QUo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbiD0QTJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:19:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4701334DB
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:15:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kq17so4422980ejb.4
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HU4wSLZja0C6+OY7L9Gn0/6rVFsXV6MvUCgiU8X0lt4=;
        b=U69RheG92xa7VqGOMDC7qg6AyUTO0FXeQvYmNgjgNP8Gm7F25PB8QveVdq1aioQcuG
         a5tJrlPz3jvO2XxLu/gV+13lwrnIWqkOSnQdmVzRozei7S5QviDz3da+GqR9SvKdocld
         wNaGltnqNqiE/I53JQ0oYWtvzEQVlDfmGEYmxc/U1fupfjWE7yt/xl+OG/7K3nqt6+Zo
         Ib64T7BQRx9HbjOQKs26ddTMMvT8w5WOMboTgY3atg4yQcFhkln+5BhKH9DNre29Ed3E
         7n3CqgjuzL3ALiROscoQXWE1SaNwdjCE1TrUjN/VJ+oK2wEY1UG5d0p0DfAnSXDtu46S
         x3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HU4wSLZja0C6+OY7L9Gn0/6rVFsXV6MvUCgiU8X0lt4=;
        b=VWypOJfHKeMGACMd6wQZENaLZN20LPxgV2T2yCDG1HQUoH7HJDxTLE1Uon0t5xn8mL
         GyRV+G/4z3uyvuRzAIEMSMfNyNRvXjsqLrhYB42cNJjjH1XlB/42zjPSEhpW0GIS3iWd
         TzSxyG9ofU//WsrAdxDdWnLjB5HMdLpRFPpbj4Gjzo0k8lbdJBDwl4S9EQP7cLvXXAH5
         Hztw/31G6ickArWUJtWKJbR9oYXtPMmH9f6bvn507l0KIijalgObmGVKyHQsEwYiWCUd
         0Y50MuzNkThnfFEdrtRyYvcFVA8NPUDBmsHmqu9/nvIahu1inkmDPWFtZ9MUAIrsF2EI
         fRZw==
X-Gm-Message-State: AOAM533d5gPqO3phQkKYHxmunxivsq+MeBrAoLBRS6HbMX4qdthZT/cm
        qWVR/0PCIHraDoDJmzPle7SeJg==
X-Google-Smtp-Source: ABdhPJyzv5+mDeZZ3e8yNOxHBsQrS70oNI4XE4sT0QrhFCwZkOTpeGwrcdlfXZIdNFScLhc7am47uw==
X-Received: by 2002:a17:907:97cc:b0:6da:a8fb:d1db with SMTP id js12-20020a17090797cc00b006daa8fbd1dbmr27520451ejc.267.1651076106720;
        Wed, 27 Apr 2022 09:15:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm7095015ejd.11.2022.04.27.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:15:06 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: dmaengine: mmp: deprecate '#dma-channels' and '#dma-requests'
Date:   Wed, 27 Apr 2022 18:14:56 +0200
Message-Id: <20220427161459.647676-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427161459.647676-1-krzysztof.kozlowski@linaro.org>
References: <20220427161459.647676-1-krzysztof.kozlowski@linaro.org>
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
 Documentation/devicetree/bindings/dma/mmp-dma.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
index 8f7364a7b349..ec18bf0a802a 100644
--- a/Documentation/devicetree/bindings/dma/mmp-dma.txt
+++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
@@ -10,10 +10,12 @@ Required properties:
 		or one irq for pdma device
 
 Optional properties:
-- #dma-channels: Number of DMA channels supported by the controller (defaults
+- dma-channels: Number of DMA channels supported by the controller (defaults
   to 32 when not specified)
-- #dma-requests: Number of DMA requestor lines supported by the controller
+- #dma-channels: deprecated
+- dma-requests: Number of DMA requestor lines supported by the controller
   (defaults to 32 when not specified)
+- #dma-requests: deprecated
 
 "marvell,pdma-1.0"
 Used platforms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
@@ -33,7 +35,7 @@ pdma: dma-controller@d4000000 {
 	      reg = <0xd4000000 0x10000>;
 	      interrupts = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>;
 	      interrupt-parent = <&intcmux32>;
-	      #dma-channels = <16>;
+	      dma-channels = <16>;
       };
 
 /*
@@ -45,7 +47,7 @@ pdma: dma-controller@d4000000 {
 	      compatible = "marvell,pdma-1.0";
 	      reg = <0xd4000000 0x10000>;
 	      interrupts = <47>;
-	      #dma-channels = <16>;
+	      dma-channels = <16>;
       };
 
 
-- 
2.32.0

