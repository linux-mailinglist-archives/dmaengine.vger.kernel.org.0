Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26905EA6B2
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiIZM7F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiIZM6p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 08:58:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E196CF60
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 04:32:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d82so6365764pfd.10
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JYDoWINnTnWSLstS0U4CDHaR+NWzszIow/uHYNqrLqs=;
        b=g8lNQl16VInhr8fQ1rv/n0nIZV//JkcF0keGq+gempO8uCVYTU+H63nmK7nU2hMpLe
         Njj07s3zeBlBr9UexgLer+HpLpvJaqQbyQQ0eF53+TYDbRmpJY5e7NU1vvn2iGQMLsym
         SSMHR03IeaQnlN88FvM6YVl9uXdvs60c6ZFzaYqWpI8cr2YdUNi3lD/Cvex2tuHMmkiO
         9HT3fHoGkirhHn2fIHZbC7dHRabAMNZq5N36tDboZzbGj2j7LByFRuI1ePq+53bTM+6b
         FqOUhWcKzXIktRRsimpfBGLrWmfh/BSsgnG5989KrDLosVrijb0yVGgjaAQd67+cCwmq
         S21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JYDoWINnTnWSLstS0U4CDHaR+NWzszIow/uHYNqrLqs=;
        b=xgZUTUqirAKT5qQiaTGvQkFoyyE7Oyo7CM86Pv2pYZGtruwNbnVvdBHhXNBIZz3iF0
         tuln2UFG6/3qZ6I6QQt810cLAT31kUorwMMTtxSuEhkmnihAGXPDRUrJywYhQvaUTfpy
         7n5fspwkrVVyFKzZeUxVRqdIWFD65wCLCcukkrz5xq9YskMZGhDZWvfV4bhVDG0tX6Ca
         REy9cIZHlDTwEV8epbsxFYdmY6CVTvIkLB58QWWbMRIbg/dwa5DyZVjHYnX9+EiQZemg
         RZ3rmT3Sve0F7n+5anOd+HtMrHGPFPjP5BHvtihYiTlaUJMjwCk3Q952gH/eOnG/9Lb8
         K2og==
X-Gm-Message-State: ACrzQf1nE6dh453rQdnXTrZEiAe+vaEVMKqsLoD7RJr6dA2mEatrb3jy
        BK2nlCqulO8efejsD2mbwUv+u428ITf3bA==
X-Google-Smtp-Source: AMsMyM74+1NNHJgu7WyQesL5hoEKzfq6L9qRrAIaL/fTtmfCUGntVGvjnG3d33XG33OgJMgTUCkgjA==
X-Received: by 2002:a17:903:44e:b0:178:8492:d0ff with SMTP id iw14-20020a170903044e00b001788492d0ffmr21768016plb.146.1664191340419;
        Mon, 26 Sep 2022 04:22:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:95f8:d0c3:cac:4cc3:5957])
        by smtp.gmail.com with ESMTPSA id mm10-20020a17090b358a00b002005f5ab6a8sm6277418pjb.29.2022.09.26.04.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 04:22:19 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, agross@kernel.org, dmaengine@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org
Subject: [PATCH v2] dt-bindings: dma: Make minor fixes to qcom,bam-dma binding doc
Date:   Mon, 26 Sep 2022 16:52:00 +0530
Message-Id: <20220926112200.1948080-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
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

As a user recently noted, the qcom,bam-dma binding document
describes the msm8974 BAM DMA node in the 'example section'
incorrectly. Fix the same by making it consistent with the node
present inside 'qcom-msm8974' dts file, namely the 'reg' and
'interrupt' values which are incorrect in the 'example section'.

While at it also make two additioanal minor cleanups:
 - mention Bjorn's new email ID in the document, and
 - add SDM845 in the comment line for the SoCs on which
   qcom,bam-v1.7.0 version is supported.

Fixes: 4f46cc1b88b3 ("dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format")
Cc: konrad.dybcio@somainline.org
Cc: robh+dt@kernel.org
Cc: andersson@kernel.org
Cc: krzysztof.kozlowski@linaro.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- v1 can be seen here: https://lore.kernel.org/all/20220918081119.295364-1-bhupesh.sharma@linaro.org/
- Fixed Krzysztof's comments on v1 regarding describing the problem more
  clearly in the commit log.

 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 9bf3a1b164f1..003098caf709 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Technologies Inc BAM DMA controller
 
 maintainers:
   - Andy Gross <agross@kernel.org>
-  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Bjorn Andersson <andersson@kernel.org>
 
 allOf:
   - $ref: "dma-controller.yaml#"
@@ -20,7 +20,7 @@ properties:
       - qcom,bam-v1.3.0
         # MSM8974, APQ8074 and APQ8084
       - qcom,bam-v1.4.0
-        # MSM8916
+        # MSM8916 and SDM845
       - qcom,bam-v1.7.0
 
   clocks:
@@ -90,8 +90,8 @@ examples:
 
     dma-controller@f9944000 {
         compatible = "qcom,bam-v1.4.0";
-        reg = <0xf9944000 0x15000>;
-        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+        reg = <0xf9944000 0x19000>;
+        interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&gcc GCC_BLSP2_AHB_CLK>;
         clock-names = "bam_clk";
         #dma-cells = <1>;
-- 
2.37.1

