Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9D601FFD
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 02:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJRA55 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 20:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJRA5x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 20:57:53 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B948C69;
        Mon, 17 Oct 2022 17:57:51 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g13so6760454ile.0;
        Mon, 17 Oct 2022 17:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYmIKV5WPOxQST0lRoOmvuuhcps77DyDd+agr9i4Abg=;
        b=YtwGxS7XY9wE08C4dA9XCLCCjB32iHpduedtI+tY0f9+L3HBmcgb0AWIKifWBsduX+
         hyjHQQBwbIRb6kk+vRK3lXNvCsbzmUd/FpJG7zL9HUV6be5sQa6tHhEN7jeGfJSYcmkb
         WFt81+0pUsZRm4MOK0lvqnbrPgI5y33wal+iFmk4VfjazGQtYE8lUHlSZQna29lIVbC+
         j3lYMF+WEBbvWDUasoxOilKHcLGoH6v9zMZOPFasmopDlLK6VI+H2MAtJlYmW/OeVgYI
         Ev5zGhINABaJN0r+lAFMIyfoVJFn3wWaRndE6U/gZsANpczFz2cIjnG4ueciAP+Ji+Dv
         QKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYmIKV5WPOxQST0lRoOmvuuhcps77DyDd+agr9i4Abg=;
        b=l5/fxOvXCPMVX1JHm4h65Hpl4kBl412W0Tyu8p+ZrtQqvKEyrhty39NaASQrUB0kzY
         0HHkpqU9zUmiaDBv88DVv2ouU2vQNO1cRBxUqu7imVp6dEWAsIFwBvDkMwhx9NOut26I
         2sYaAVQxUBAUNzgjTXzBrvhmdBtTvDHcfBTxMSuB0hGAiPp4MxAQiz/WhJCbE+aYVb+2
         ipf4OyWBxRZjWxWS4roSK2s7POmgfAlwJMFa1smtWtmHNOrmyMaGpncBgWQcUCP7HzPU
         iqJN3FxpHQZHbRDqBPQZQoD5MnSbSCiy6CfOR28Rim2xhOax3yrPDP4eSVXTCA6AbBJH
         gLgA==
X-Gm-Message-State: ACrzQf3ZjKOHSeOInDYw1L80AqmTiAPkZ10l9HU+qVqcHYauS8lHYsQr
        Oo24Xq58YMVVJJdVBhhVrNiYgcChCM+qLg==
X-Google-Smtp-Source: AMsMyM503ARv4Fso+JTsGa42PLLvIYkX+IjpcJ8WcOT32C1TpEuWr+fiVCg669LFUT+OrrfTlZdAGA==
X-Received: by 2002:a05:6e02:168f:b0:2fa:894c:7881 with SMTP id f15-20020a056e02168f00b002fa894c7881mr512525ila.176.1666054670599;
        Mon, 17 Oct 2022 17:57:50 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id x10-20020a0566380caa00b00349d33a92a2sm508229jad.140.2022.10.17.17.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 17:57:49 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: dma: qcom: gpi: add fallback compatible
Date:   Mon, 17 Oct 2022 20:57:37 -0400
Message-Id: <20221018005740.23952-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018005740.23952-1-mailingradian@gmail.com>
References: <20221018005740.23952-1-mailingradian@gmail.com>
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

The drivers are transitioning from matching against lists of specific
compatible strings to matching against smaller lists of more generic
compatible strings. Use the SDM845 compatible string as a fallback in
the schema to support this change.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/dma/qcom,gpi.yaml     | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index eabf8a76d3a0..182b8573230d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -18,14 +18,18 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7280-gpi-dma
-      - qcom,sdm845-gpi-dma
-      - qcom,sm6350-gpi-dma
-      - qcom,sm8150-gpi-dma
-      - qcom,sm8250-gpi-dma
-      - qcom,sm8350-gpi-dma
-      - qcom,sm8450-gpi-dma
+    oneOf:
+      - enum:
+          - qcom,sc7280-gpi-dma
+          - qcom,sdm845-gpi-dma
+          - qcom,sm6350-gpi-dma
+          - qcom,sm8350-gpi-dma
+          - qcom,sm8450-gpi-dma
+      - items:
+          - enum:
+              - qcom,sm8150-gpi-dma
+              - qcom,sm8250-gpi-dma
+          - const: qcom,sdm845-gpi-dma
 
   reg:
     maxItems: 1
-- 
2.38.0

