Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1A511F91
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiD0QUc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbiD0QTX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:19:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE20939CD
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:16:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p18so2525314edr.7
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikx9HZ+yBGChQJqSXuq9OtG7Yyq5sAT2KIDRyjVy2Ew=;
        b=k9lz0sQhbRTwPHt2muLKlXs9a5W5z2xtvBDrZ3E0nj9D2eC1AjA7FEpUxl0/v40NHT
         wm61gDgL4blRe9F+iSoMzVnqzdbIbduB4aI0LEyo+Cd6386bJ6NtFjgQWzRStKWFHizZ
         M/8hdEaSHjpYqmwiwUOk0MEUVfudG88JutG26cgXUkc9r1j2R1u69/v5MHBg79m3+fLK
         ORpZA1HL8fN8khg05nIi/b8JMiojUAYb5RnOjkIFOdaJBxaIPdEOrCO73Juve/oS0mqH
         OrJasXHsPa3r1gY4ABG/y+sa0S8F47v1dWxjYAM6HqDwk4DwU72+EDo0NxSwcvcIN0Va
         Btkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikx9HZ+yBGChQJqSXuq9OtG7Yyq5sAT2KIDRyjVy2Ew=;
        b=meUUO9XfzgtKDkOzt3q1KpDx6v1ROEv6e43skgMuPBrfbbSA5ewkUxeFfor/3YtWnN
         xJ/5BeuXO26ft+KqjnFxMQXfyhxmY/nxblMBzbYQG9Di5bnBFwYRYtqXmvTUbLr297wS
         59gvQxWkjfG4On8SuJ36Uhlx5/s5ZtLs0HKI5lwiCnOE+paS+cR78YJHj2GwnF7VpOZr
         6HXq1QrsCi5ohiGaJVdUo8jFpXVo3CPpOCi8+MsC2gf6n3VOj1F0Q7PzHoGc54rzOW40
         9ms2QGr37D+AWZE6XwQMuU4ud7eR6kinyqATRwxLxbSrpP2BOuVtwOLMZbaIuwSduXUQ
         3XVQ==
X-Gm-Message-State: AOAM530cNwTTcd0B5hokE9pXoMZFOhVAQfyhXzEZmiFWkbz31XeGQANg
        27FemYKwjjE6FzepuzjtRbtg2g==
X-Google-Smtp-Source: ABdhPJxBkczXJ03bluk/rb8a+lRgpdHRXkDsGrW8J/qjPIBcWncX4iSCWz3kGJJfzbZhBzuwpCm6sQ==
X-Received: by 2002:a50:d707:0:b0:425:e37d:4ef3 with SMTP id t7-20020a50d707000000b00425e37d4ef3mr18981209edi.167.1651076141717;
        Wed, 27 Apr 2022 09:15:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709064cd100b006e78206fe2bsm7131192ejt.111.2022.04.27.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:15:41 -0700 (PDT)
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
Subject: [PATCH 2/2] ARM: dts: imx27: use new 'dma-channels' property
Date:   Wed, 27 Apr 2022 18:15:33 +0200
Message-Id: <20220427161533.647837-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
References: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The '#dma-channels' property was deprecated in favor of one defined by
generic dma-common DT bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index fd525c3b16fa..b660c7d05584 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -96,7 +96,7 @@ dma: dma@10001000 {
 					 <&clks IMX27_CLK_DMA_AHB_GATE>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <1>;
-				#dma-channels = <16>;
+				dma-channels = <16>;
 			};
 
 			wdog: watchdog@10002000 {
-- 
2.32.0

