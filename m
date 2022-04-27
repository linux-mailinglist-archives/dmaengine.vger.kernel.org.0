Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805FE511D4E
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbiD0QU2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbiD0QSr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:18:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960D83B03
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:14:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k27so2528710edk.4
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8alvGyBBDkI+jnFt5S8vbtqPulfD6lL++1vfGqh/pyA=;
        b=SIDxM8u7nMxxqj5wsbYizeXXTLXYGtlGEjLw60UnJal85YRIm1PE8fq5Q1knv0G6qs
         SrpXniDJb13xtNYcGUPaKI9VJ74Wy5r8G/pDTSOFcIn1bwLwoEbNBOPAZdZsbqHNgF4M
         KgLxWj+n8YD/9yowwKM/gG86oyZJY8f+CIwhA4HnmM5ioUX1JOUBnq7fuF+NeHHFAI9W
         ll14I3oAfA9dECJ80yh8YgkSrMKzxarCR532JluTUDD0HNTkblVoSq3qwMzYinrqd3TJ
         ej6xJ9wBAJ8oXB/otALdykILgxfdE8rM6cO9pcrny4QDv8yRwvq7go0ydvyML04+CfRs
         F4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8alvGyBBDkI+jnFt5S8vbtqPulfD6lL++1vfGqh/pyA=;
        b=HbdZO6qVRMuzFe5435RnSPyl/htsw8QqelF906mP9t3psiTgkmbTuDMefsiuGqf+lQ
         EYDJs49t7Y7nZsHM9vzYwgbnhlL9SLKfUKNe2fyU7DM98WLzA3yFWKT7fVaMHnb1FNOs
         FOG/Mir1r+Ag5DIF0PqrNTLnpSz5x8xB77vEe+LLTvMLpcGFW06s5aVb3RT/48hniR+d
         vqbsJMpSHffTM/Ox095/YuR8+EuImDMaxkPmvtytFlpWnAA/6t6xz+3s2wBO9CYOope3
         /r+/x8ZldY2zR81Z3zCOMwEqj2cjSUay6ZVuMySXS6hWdyTsovoT8wmE+aWf4IBIIuHt
         W5Ow==
X-Gm-Message-State: AOAM532IkCOtcZMLcXm70xRJVVhWjdJiukGsePNE5LK3kR2R8ltQY8xv
        bmGPRl28OdgV4zoXqKlZgfHgtg==
X-Google-Smtp-Source: ABdhPJz6HWk5sB9nwfwdf1kQDcgkA+wqGy0z6ftS09yTJNkx6ybSS1PM3iIUUoGohfHi4XmFs5lz8A==
X-Received: by 2002:a05:6402:1bce:b0:425:bfaf:f20c with SMTP id ch14-20020a0564021bce00b00425bfaff20cmr29534634edb.359.1651076070280;
        Wed, 27 Apr 2022 09:14:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm8583383edu.44.2022.04.27.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:14:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: sprd: use new 'dma-channels' property
Date:   Wed, 27 Apr 2022 18:14:23 +0200
Message-Id: <20220427161423.647534-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427161423.647534-1-krzysztof.kozlowski@linaro.org>
References: <20220427161423.647534-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/sprd/whale2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 79b9591c37aa..945f0e02d364 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -126,7 +126,7 @@ ap_dma: dma-controller@20100000 {
 				reg = <0 0x20100000 0 0x4000>;
 				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 				#dma-cells = <1>;
-				#dma-channels = <32>;
+				dma-channels = <32>;
 				clock-names = "enable";
 				clocks = <&apahb_gate CLK_DMA_EB>;
 			};
@@ -272,7 +272,7 @@ agcp_dma: dma-controller@41580000 {
 				compatible = "sprd,sc9860-dma";
 				reg = <0 0x41580000 0 0x4000>;
 				#dma-cells = <1>;
-				#dma-channels = <32>;
+				dma-channels = <32>;
 				clock-names = "enable", "ashb_eb";
 				clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
 				       <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
-- 
2.32.0

