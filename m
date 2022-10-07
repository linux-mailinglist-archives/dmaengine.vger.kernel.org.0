Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130665F8019
	for <lists+dmaengine@lfdr.de>; Fri,  7 Oct 2022 23:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJGVgu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Oct 2022 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJGVgt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Oct 2022 17:36:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3410325D;
        Fri,  7 Oct 2022 14:36:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p70so4613322iod.13;
        Fri, 07 Oct 2022 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnLisYNzZ2Cx+Hy6K1ojWQdmqkrBIHIVv0ZAdBzW2gI=;
        b=gvPHLnxb7hkkWQW0bdDqi4Q1cBxccOFoe13OdU6+F5Qc5XhCD5aS8oIhJZX8hbvfYJ
         VvICmDzXRR/bJFwiGK7E4DAUTegIeS4DMB3o04z5IVWNhFPUJ9O29D/0b/m1dA3M3r+c
         JaKx90R7lIYHHb1tsaCxd2Q6tV/krQ3rdbyK+3Zgzl8ho0zBgTPVLnYDjRyYKiETRTmb
         Aldo6PbSpCqaueAJEZq/d7Mb3/5+aR5jSZ6COwlHhUAt3u8PgM299f6eDPeMpCnif3h8
         YP2PeFAyrg/EbAnlqkVTBbAXgkmgHkPT2+++G09ABqyQkO6TmC9G2s1ipdNhXgX8DCsM
         Ivog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnLisYNzZ2Cx+Hy6K1ojWQdmqkrBIHIVv0ZAdBzW2gI=;
        b=V2wjVKOEdVe2EY8s3dt2E6JRQSch+CW+fimVjF1FmRcMMsofTuwg8HaydAnGBLPlyI
         XAcOK43r5FKVCm9t4o82mvelmUDuYuQVgnzmbk+tGu2LsEauix/coc4t+rkLJHoxniUo
         3b9fC67S1iudEqTokNFt5GP37ZwyJlEHNuPtoZQfg4qrhHEYsPgl4VNpNnBoGWlUABKd
         z0W7WBF+RaMZoarMeu0qRJZtZdHurrwHRia1SOEMQxPQf+nZlRHl9+dj6T605SeDosnv
         CBr7WrXOuYFBs6fij4oSlfRtHEzg6QHgrltGMA7MXdf5E66lOz/knXyZwi+2AkuCXeIl
         laAA==
X-Gm-Message-State: ACrzQf014fhatXJMrmVXNIAhQm4EPkgKIBlWWJ7hFnHujouat2YPDSx8
        EICaJ0Ju8n8ntEopgCWRHAwP5mMny2k8Yg==
X-Google-Smtp-Source: AMsMyM5o2EpfRA8JfJXdJKTHvVLNN8yOWtEITFB1g7b6S5po/8/HwptvXihP8oY76Gwe0N0td6XcKg==
X-Received: by 2002:a6b:690a:0:b0:6bb:8bc0:7184 with SMTP id e10-20020a6b690a000000b006bb8bc07184mr3152946ioc.92.1665178607686;
        Fri, 07 Oct 2022 14:36:47 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::b714])
        by smtp.gmail.com with UTF8SMTPSA id o15-20020a056e02102f00b002f510cd1739sm1297957ilj.19.2022.10.07.14.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 14:36:47 -0700 (PDT)
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
Subject: [PATCH v5 1/3] dt-bindings: dma: qcom: gpi: add fallback compatible
Date:   Fri,  7 Oct 2022 17:36:38 -0400
Message-Id: <20221007213640.85469-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007213640.85469-1-mailingradian@gmail.com>
References: <20221007213640.85469-1-mailingradian@gmail.com>
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
2.38.0

