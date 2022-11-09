Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173AF6229D8
	for <lists+dmaengine@lfdr.de>; Wed,  9 Nov 2022 12:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKILMr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Nov 2022 06:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKILMp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Nov 2022 06:12:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59CD2872F
        for <dmaengine@vger.kernel.org>; Wed,  9 Nov 2022 03:12:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f7so26666796edc.6
        for <dmaengine@vger.kernel.org>; Wed, 09 Nov 2022 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/pc7jhWkIohCmzvLPeFxuZOhmufYr1Nl7f4rSC4zF4=;
        b=CuYAPoJXdqq8N/Hkqw6+Dyphx6DZiSKDjujPOlLyWRAxasWQOjLGr0mDvDWXoz0LfG
         wd/cMAMguAOFiOumC2hM7NQhgDNWyucdDdBhx1PBoqFhG9rQKfUsjRbWMBTWDao31/Tg
         Xnyzbg6Alum5LrezL0ZhqG+bsaka3rGY4Ml5QHHrbdMxBJft0Ul42cT0TDRvPikeulk2
         Wh6kyjBF0Z6TOY2Ab081x7OjhMv05XhAHbELPiMGftSpoJUpYyuCs968qPwY2o1PDfiJ
         Bfhgc4K491D9RUQ2zyN7ClaRF2KojHazUQ5NfCSSS8FSWlXR/xUGgReuaIiyk0h0Ccyu
         DLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/pc7jhWkIohCmzvLPeFxuZOhmufYr1Nl7f4rSC4zF4=;
        b=SVc8k+hQqWzSbrP0nzt4nXESuDDV7aqxWNSk0DtPC+raWtvfNvwnrp6WNaUfJTQkqI
         q8zUcUzImdnHhQFwK6Bz7hDF9wEXe+4Lxr9Aws5YNc+aXW5g0jtxxaPgexYClhLtK/MA
         RN8eRtfKYnHGSaZe2fq1zd4FXXX++VYkjlhnD/XadAvYDRJIt/L+sxlSZ5umU7Co6o79
         Z/ncYqQS6BO7oojXPugysG98uPkcP+uEDDIxkIMT7Qrrud0eLzjjUA0mfme8IxhzKaAA
         nk481aBd+U8oQcbA5Unawcp1rhEY3pmmUw/gxrpOd8ltXJWnFFCbSOCdYVb7JheGn2Kf
         ofRw==
X-Gm-Message-State: ACrzQf0A/QLlcdPfM4Qy9LYfQIs/JuBOgNtR5+vNXnCIMzKgQiIk5Dd+
        uiKSEfIXB+/7ekLoHTCox3Yr/A==
X-Google-Smtp-Source: AMsMyM7GeVr/zvBHi6rK2a85LLgMSVm6NEWavbdp+4Oo2zE/I5mfFViR3XR+UwerJ7HyyO3kN5UJqw==
X-Received: by 2002:a05:6402:2793:b0:462:39d7:3bbc with SMTP id b19-20020a056402279300b0046239d73bbcmr59490539ede.47.1667992363232;
        Wed, 09 Nov 2022 03:12:43 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] dt-bindings: dmaengine: qcom: gpi: add compatible for SM6375
Date:   Wed,  9 Nov 2022 12:12:27 +0100
Message-Id: <20221109111236.46003-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
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

Document the compatible for GPI DMA controller on SM6375 SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 232895fa1d8d..e7ba1c47a88e 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - qcom,sc7280-gpi-dma
               - qcom,sm6115-gpi-dma
+              - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
           - const: qcom,sm6350-gpi-dma
-- 
2.38.1

