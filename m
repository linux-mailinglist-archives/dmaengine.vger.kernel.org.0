Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D661299C
	for <lists+dmaengine@lfdr.de>; Sun, 30 Oct 2022 10:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJ3Jnc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Oct 2022 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJ3JnN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Oct 2022 05:43:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657FBD10A;
        Sun, 30 Oct 2022 02:43:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l14so12116177wrw.2;
        Sun, 30 Oct 2022 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEHqsPqv95R3eGrYKhg4ruWGo3ymO/H/xi/Qhw4VFG0=;
        b=WK2hF+vuK3yG0ecPgY6uKRUUPFghjZB9XmWCti0Jk/MWl4A5UFU620msKEzGSiSdB5
         xwDV3KiEWdaEO3jjnY1xenzUh4JzhHF61broc17FdKC+adqFZ/EbDyE3dL8UV9VMyUc/
         1q3b86DQntJXMK2By1KrJTirZ9v/RD3TK6Mw0y03B1Ss8Zmr53KayO/7kSED1KuSfV6S
         VPy/gzErZCgfy48SIiSYuBhxJmJ+fcwA7hA54cJtMebRqlXTPZoV7kG426m1Gj67Hauu
         ifxZW4j1QhiKXkJBiicUSvR2PuiWXbcqAVXItdlChcFwIJxL7+Kv5cvrnUZ9pNuLW2iH
         bcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEHqsPqv95R3eGrYKhg4ruWGo3ymO/H/xi/Qhw4VFG0=;
        b=Tk67YWZROIo3ehC6uMB9T1MOVrB3mrOtO7z+hu7lwNCiKjCuICN9MHXrN92+u/EV2V
         ZiXqCsGy8jDzCPIeTEtPSdCjFEUvsuXDEItWHnmUPpNh3rlcQx9XvhMhelT8CMe5UwRS
         Az0lFyw981Tct1ugScm3jW/FNJkKg14xqZcYJvzEeItdxy/LbfWYVs8elag073ekx8C+
         EQsmFh69t0UJhXSKmT8Aa/tzFKekKz0i4FT31LazUujukWni4uJVuhFND7Js5icNJJ5m
         22bJv6t1s8OGg/rYG6P7rcTvxTzuaACLtU5ZqP4/vzKA/WI731iYJ8VosYWsnr3AfHKJ
         g6xQ==
X-Gm-Message-State: ACrzQf2MpUuoFAGIY54tKysdOan3UfOdTLlrq9skNerBPsv8XdhZrOPP
        HD5W9mtMYWzYBca54xeB0Ig=
X-Google-Smtp-Source: AMsMyM66e4g3WQ6fedXjdOCMEKxZ3pSirsYGsXa5o877lNeILtX1jNDDqqDvS106b3qK0FCV/GqiRg==
X-Received: by 2002:a05:6000:408c:b0:236:a7b4:fb4d with SMTP id da12-20020a056000408c00b00236a7b4fb4dmr4407306wrb.524.1667122990901;
        Sun, 30 Oct 2022 02:43:10 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c384400b003c3a1d8c8e6sm3916879wmr.19.2022.10.30.02.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:10 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115
Date:   Sun, 30 Oct 2022 11:42:53 +0200
Message-Id: <20221030094258.486428-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Adam Skladowski <a39.skl@gmail.com>

Document the compatible for GPI DMA controller on SM6115 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 0c2894498845..232895fa1d8d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,sc7280-gpi-dma
+              - qcom,sm6115-gpi-dma
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
           - const: qcom,sm6350-gpi-dma
-- 
2.38.1

