Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B105EB71B
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 03:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiI0BtA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 21:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiI0Bs7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 21:48:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE892A7ABA;
        Mon, 26 Sep 2022 18:48:58 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id m16so4432246ili.9;
        Mon, 26 Sep 2022 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uCw6DKz14oWO5Q1awZk2JWnMv0CjLlIwxnWvwSKwYeY=;
        b=Yu0Icm348zsArCobAD/oIPtOoBbaJViUe45YE7H+a15a0ddyrWoAWEq7CRUuwDBs17
         I1noHP8hjA0JWsWfB+dS1KoBFFvM/0t9cCdiR29V8TkB8azNmIRMUbedFHkOmnPQeMiE
         /EGP2Pqf6a40ERdT0Tb1RDOLp5vIaAf6gUTlR49y8dHs9+Gr29yzKJLw/sCOzpvOvrEG
         Z3dmRkOtLoMG5FT/frHIDa5eXw1HeFNBmd3aPMN27UAZH+1cwMmaeJ+/CBT/E6M9PUuI
         Ho2ik7bwgaJ0bM5/3i0G7HanvN4FWY5vKnwHP91BH8E56huSmAF+cwt7ACiv/c4OuO+Z
         wc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uCw6DKz14oWO5Q1awZk2JWnMv0CjLlIwxnWvwSKwYeY=;
        b=Z9eLzROofvBPJUOiAm0eey4FdEQ5W6LHkjskdGjvArZZdwRNuaZhrp7UuoSF+g/G5z
         B71OoSkRqfeeaIO744xtz/zrnyiFicE/D1HHiN4ewv6eiqYWYTPabaC8yt/KpyjM63q+
         zwgwMtiJM4+ulCx/lmehfR8fBHCdeFDS5R9L+lID6wEJBDqaPm/oAvnGHzeBhtktmlLx
         FMOQCmaYJTOE+YH5wna4Hd4aJDJF9LMq2yoTw1Xk16zqzINDTkfN6KTk8aE1f/hb8NKO
         R2YhzjT/RvZRwGr55HwN6XWaNbSJ5TvTCEJzOiO1Y1LFn7PfH7UBT5uHIgcYdElmRKjU
         VrmQ==
X-Gm-Message-State: ACrzQf1ZH7U5EicN79x7cIvfQ5n9OfTFATZ/nfqO6xabQYZ+NI441oPX
        JmFm1EfaxnRsFhhxHHvlpkNUfr61nPc=
X-Google-Smtp-Source: AMsMyM5GqcBMDu0/XVgG3AcT5sLUY8HcLkaQY9zc66oTwzCBgwKkAZliBMEce/qM7qyqiAK/w5vCzA==
X-Received: by 2002:a92:c64e:0:b0:2f5:9ba:8055 with SMTP id 14-20020a92c64e000000b002f509ba8055mr11777618ill.290.1664243338054;
        Mon, 26 Sep 2022 18:48:58 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id r6-20020a924406000000b002eb4c9bb34asm148113ila.55.2022.09.26.18.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 18:48:57 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: dma: qcom: gpi: add fallback compatible
Date:   Mon, 26 Sep 2022 21:48:43 -0400
Message-Id: <20220927014846.32892-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927014846.32892-1-mailingradian@gmail.com>
References: <20220927014846.32892-1-mailingradian@gmail.com>
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
---
 .../devicetree/bindings/dma/qcom,gpi.yaml     | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index eabf8a76d3a0..081b8a2d393d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -18,14 +18,19 @@ allOf:
 
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
+
+      - items:
+          - enum:
+              - qcom,sm8150-gpi-dma
+              - qcom,sm8250-gpi-dma
+          - const: qcom,sdm845-gpi-dma
 
   reg:
     maxItems: 1
-- 
2.37.3

