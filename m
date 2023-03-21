Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA22F6C3984
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCUSs7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCUSs5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 14:48:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C563F53DAF
        for <dmaengine@vger.kernel.org>; Tue, 21 Mar 2023 11:48:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ix20so17030166plb.3
        for <dmaengine@vger.kernel.org>; Tue, 21 Mar 2023 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679424501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OU2TpmTbkt/6hvSTm+PPEoXU/hSqJlv3qM+jLeXgjsM=;
        b=OVw0ECtyo2lDexPfAB5v+xW9q4bqZYx4ZfJqU2SL5kXXnye4/lrm/ei4i+2v4vBE70
         5lQb1OCAoRw8sN4zTYaaR0isVYdumbxVJQLLwe9hQvmcq8R/g9l0Bs3NyBkvFfslZmUA
         4n2Hh8fqXkOGJeVfvZuoh1KkaZRFXyaONmAhQefe9xb/sNJrdGApo26vdhUnxorrgjNq
         9GWI7d12jnIS+TqpVA200Zdmeu/lAGY9WQ1qZhNVlPfUkSQyDU73ANsjwWZ9R6vnrgjI
         UqR9/hVdy9PEhsC0sYoGn0wZg/NfjqPKFHpEjUktqegt2qR1HUSjDqISD5j4a+q7TOqL
         Va1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU2TpmTbkt/6hvSTm+PPEoXU/hSqJlv3qM+jLeXgjsM=;
        b=DbYZA2MftxRS4ydSJX0ifZPy8eaw+F7olarFGpOZQ1BKO9GTjKu69raxmcDyyxchey
         +yDLNvFR5mO1mPuCO9etOV8B9wJeVpyF1y5IyKLqNMYW8iGgDFp/0I0QnXGl0eX0mQKd
         Q4Sa11ckfsBkRFrJ5+GKFXgV24iWsiFuiACezQSt4aXhwgkyh4+pioRNRjzt4OBl+OHJ
         W8AXZ59eKO6rdPkthy1mYW9/iGTbt89Zyo7l4fl4HvypzbVeDnG0mKolHMnM+x3LXV8i
         CDQ90A4my32ExZ6iCJHHOYPr+p19dQtXrD+15/gCk5+ABWTzOfJpWV8r0zWqVgFFfU7Z
         EanQ==
X-Gm-Message-State: AO0yUKWx4Xr8fVzKVgCVjh2+Y6zBpKs7vJzdJKSkwjIYwAt9WGAVjx4S
        hAqw9KDSXYrbJCosqOkvaXlV7Or5OkpLUuxfSEE=
X-Google-Smtp-Source: AK7set8XEqG4QjXF0VsgxuBGSQjsXwO402XZCIkV0X3tEjleTYEVr/x82XLGqxVgbgCGh5vDIOLbsA==
X-Received: by 2002:a05:6a20:baa1:b0:d5:b3d1:bff9 with SMTP id fb33-20020a056a20baa100b000d5b3d1bff9mr2305721pzb.52.1679424500498;
        Tue, 21 Mar 2023 11:48:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b005d4360ed2bbsm8590817pfm.197.2023.03.21.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:48:20 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org
Subject: [PATCH v2 1/1] dt-bindings: dma: Add support for SM6115 and QCS2290 SoCs
Date:   Wed, 22 Mar 2023 00:18:11 +0530
Message-Id: <20230321184811.3325725-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add new compatible for BAM DMA engine version v1.7.4 which is
found on Qualcomm SM6115 and QCS2290 SoCs. Since its very similar
to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
accordingly.

While at it, also update qcom,bam-dma bindings to add comments
which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
This provides an easy reference for identifying the actual BAM DMA
version available on Qualcomm SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---

Changes since v1:
 ~ v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230320071211.3005769-1-bhupesh.sharma@linaro.org/
 ~ Addressed Konrad's comments on v1, where he suggested how compatibles
   should be used for SoCs which support BAM DMA engine v1.7.4
 ~ Dropped v1's [PATCH 2/2] in v2.

 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index f1ddcf672261..bed966fa7653 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -15,13 +15,21 @@ allOf:
 
 properties:
   compatible:
-    enum:
-        # APQ8064, IPQ8064 and MSM8960
-      - qcom,bam-v1.3.0
-        # MSM8974, APQ8074 and APQ8084
-      - qcom,bam-v1.4.0
-        # MSM8916 and SDM845
-      - qcom,bam-v1.7.0
+    oneOf:
+      - items:
+          - enum:
+              # APQ8064, IPQ8064 and MSM8960
+              - qcom,bam-v1.3.0
+              # MSM8974, APQ8074 and APQ8084
+              - qcom,bam-v1.4.0
+              # MSM8916
+              - qcom,bam-v1.7.0
+
+      - items:
+          - enum:
+              # SDM845, SM6115, SM8150, SM8250 and QRB2290
+              - qcom,bam-v1.7.4
+          - const: qcom,bam-v1.7.0
 
   clocks:
     maxItems: 1
-- 
2.38.1

