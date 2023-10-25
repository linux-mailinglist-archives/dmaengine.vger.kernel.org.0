Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92117D64E2
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjJYIXM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjJYIXL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 04:23:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA711F
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 01:23:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d9552d765so3875596f8f.2
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698222186; x=1698826986; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSGFKKRMkp9iHb/AjbOT8f/04pl7mJkL38aKBmG+OHQ=;
        b=QJimMa8CXH7rkVOkHciXsZDcV0lpCzHAvFhahBAXhd73wk1aIoSIxvpbM9gY92Borh
         NP7ixeB3T1bf3BLz+uF48h0+zfPmUAYDn7FHKD/cSuXcGOOYckBDFsxHEALMKlwolGNv
         8OG1bZMC/9Fm3DIu9tkFbwcvPtFCKLZ12lUabmjE5Fodb/RaThRjsJOQ8Z/X/KeAI312
         kGqcEmBonKYdDYadqVy1be2BvY3dEHWQDMQFRcsVezHw4C9YxZefTqBf9r4wL3WToTVh
         LbI/Ryf3YiKtN6HIZhDiUCXP0mcQDzZiUMt7J2T+w3zRmwGJDGBmVEJZtrKWYB0k5+sv
         2fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222186; x=1698826986;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSGFKKRMkp9iHb/AjbOT8f/04pl7mJkL38aKBmG+OHQ=;
        b=ejcLDQKoHeW8uigr/uhBUBk1tyY2c9O1OQbIV/i/4Kj9O2aMQ7ZBRjcsULElo6uASj
         dWtTx2UP+2ks8cti5A06kFTuZoXR4+WFsbSKmh+z3j4Thzim8Xj7T7ISpyQIFowT3VZF
         3UUjT22eF0ewiDM2lv3W51Vh/r7DeoJm8SeWPPkDtX0rwgEO1NoiABAhTZI1Hy+FVkTa
         s5inLLUQo6a41OoOsyhU8Ctsr+fx5vKJ6nSZLd3ZzIRHUYIiEY4iDopaVkTbb95iE6Cv
         rRSI46JutiY2N1rsRB9H7PbM1unO+WuSv5fIsvrCD0SnCU+kipuPWXqaoNeYHEoPIpTS
         6rYA==
X-Gm-Message-State: AOJu0Yzaos/CTty+oPvpwDx54MncsOXRPhPrMBMDbK8Rlq3qYI0aMLzb
        JJaw/tmp2JHKAg1zQ7U8LSYpPw==
X-Google-Smtp-Source: AGHT+IFjdt41QwRL5JFVLmHoRz3Gpv7tsA6HiLPMYQzLyAJ5Y2wUqOUYZmVoLTqnQj21UvD3DNf7+g==
X-Received: by 2002:adf:e507:0:b0:329:6e92:8d77 with SMTP id j7-20020adfe507000000b003296e928d77mr10093346wrm.51.1698222186349;
        Wed, 25 Oct 2023 01:23:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f9-20020adff449000000b0032d81837433sm11539756wrp.30.2023.10.25.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:23:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 10:23:04 +0200
Subject: [PATCH v2] dt-bindings: dma: qcom,gpi: document the SM8650 GPI DMA
 Engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGfQOGUC/42NQQ6CMBAAv0J6dk27QFM9+Q/DocJSNtG2aZFoC
 H+3Eh/gceYws4pMiSmLc7WKRAtnDr4AHirRT9Y7Ah4KC5RYK6k0zCFyD/lhdCvhGfOcyD7gxn5
 g7zK4yIAni61W2hCOooRiopFf++TaFZ44zyG99+eivvaXx/af/KJAQU3GYGOpMbK/3NnbFI4hO
 dFt2/YB4CFYJtUAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cpOmH9BEKtyMhepaWaWQ0BUU4FW2dDNEuqF7HPgi9iU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlONBoAlUtR4JRgUcJK40BRvcxR18leP5DGiRGLAm+
 RlCCAWuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjQaAAKCRB33NvayMhJ0XM4D/
 9T66+ZSO2aLkz/OFvYk1udheG0Lq7TzXikqo5ROURpL5FWGdqhtLFyrHq3REsm05hDJAR8Eg/onwwn
 zbWUh2Xm7ecMbNJNJbDMzPUloYLpy3IKfw0g8uLPnt7HU9z8zMWV7aFSHvLsnt0LZbNZOlbrBDM4+T
 j+KaTcwnvjYHFBt8zPVwK37kWTVquxpEd+jGyJtTxZebtudYCOKM7u4eBwDuv2JCtbi9xbELceM82A
 bYG1vniDrPV//b2eOK7pT97NqxEuFXjcO5hfxiv4IHnjdX9z9jv80ZJ7ZGlis03XDbI0H30NT2CAbI
 C7PbEiOw5rjg/EbTliVJzrLYH7RIsVKLk2PF2lzuxoAluawVkIpk3rgnD+PmUPkBa1Cp3BF/4jEQja
 CCVzpaKecFoCm4c3CK1x55iyrI9THLSaZjxCSLvwLI3HUSQRLh1sTzOcloSXBSeN+Vrk686CfDPauU
 XRQpTE9UCSkZhcJUJqNXNuSkjcCEYCr4dNPXvYzkSHKRlkt+c/cNZy5FsYYSnPxP1ehQrAFOoyB7Fa
 07cNUVQWTBwpCh15hCDHx/dAzqt8kktBajmVeLt4/Bel+A8KJ2HwrdwyZAv0SqbFdFdQk8KBkaZdT/
 2/0+nKpjn3sQstrDY43z6wP3SDRtASDMWpSyHvuBSvphGnJxwj4/2UHyzKfg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the GPI DMA Engine on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
Changes in v2:
- Fixed typo in subject
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-gpi-v1-1-3e8824ae480c@linaro.org
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 88d0de3d1b46..0985b039e6d5 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -32,6 +32,7 @@ properties:
               - qcom,sm8350-gpi-dma
               - qcom,sm8450-gpi-dma
               - qcom,sm8550-gpi-dma
+              - qcom,sm8650-gpi-dma
           - const: qcom,sm6350-gpi-dma
       - items:
           - enum:

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-gpi-29a256168e2f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

