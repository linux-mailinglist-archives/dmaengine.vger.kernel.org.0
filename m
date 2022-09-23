Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FBE5E8497
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 23:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiIWVJr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIWVJo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 17:09:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C2959A;
        Fri, 23 Sep 2022 14:09:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 138so905802iou.9;
        Fri, 23 Sep 2022 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3c4ZAc9dBRUfN8kF3XkqGE0NE2NzTCE9N19aY/1pR8g=;
        b=f21iVcAcCZkGjQ5arBU+W/9189SGgFnXRy4+wlnyC17/DypF4Zw0n5+FgPrxduPq3W
         XERw8FADfJJnc/WCz1mvbuBJiC8592siaUrJ/3EMQ9dwg566jzvDAwbCEmO4A6r+irAl
         q/2IYYpvzkwnk74ioa/lMS/DqVzbAD38V+XupciGmNj6bOpathSLtYutsbX0aOVzM6YP
         3l6Nm207f88M1CUhpc/Y27cJIATr3kFkEugpQDytFtMj1MZV2DLH+Z4WiBYbu3iRhbZA
         3IzrQVbfYEUXmfY0JBPiMwrJxFuY4uXo8ADat6BbYmEysqzZBADJHdeqqAYtElSk1tZo
         z0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3c4ZAc9dBRUfN8kF3XkqGE0NE2NzTCE9N19aY/1pR8g=;
        b=DKZct3axBNQn/7kfWok0FLHgmhhe9MwYuzNo7GmqrKC4lI45RoZAWIyYQVDigAjAil
         xw/klpTUfUmw1yZX7ulvqEDN3io3ZR2z0+PQqb0Lj15NaJAVrxkuqR6LJdIc/h9TZuh0
         dtI5wjpZvP+mI3HBghC4rh6+b3kCrfMbArUWGo0U5oIBuNDI7Bl+rrBW1t1/YRAmqWLC
         OP6xYk+P8dO5+FSNfXvGDtvQE0Cxt41I/KYFka1PXYsQXwHousk1egKXVMA/XNqvPphq
         AVBOG9ttpXhVnzw9t5F0ME5oABbkruKmawtiq6bO6U136WIQ8Jrr+og0SGC3ZV7yujXN
         3kOA==
X-Gm-Message-State: ACrzQf16zLXF5JUbGGXxUrTZM74mRprSdUmTA6FZ81buvigChZ5KMltn
        oaW+fj4pf6A8cx4SsS8KSfnzt9b70Hk=
X-Google-Smtp-Source: AMsMyM6exuRICTOYWGmQS7cNUzxHbnkecOd+p6VkCup1aeDR20fMUzFcXUc/Fd0QXZz9U66EPqmT7g==
X-Received: by 2002:a05:6638:22ce:b0:35a:4e78:9bc4 with SMTP id j14-20020a05663822ce00b0035a4e789bc4mr5740221jat.127.1663967379868;
        Fri, 23 Sep 2022 14:09:39 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id v20-20020a056e020f9400b002eb75fb01dbsm3525921ilo.28.2022.09.23.14.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 14:09:39 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: dma: qcom: gpi: add fallback compatible
Date:   Fri, 23 Sep 2022 17:09:31 -0400
Message-Id: <20220923210934.280034-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923210934.280034-1-mailingradian@gmail.com>
References: <20220923210934.280034-1-mailingradian@gmail.com>
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
compatible strings. Add a fallback compatible string in the schema to
support this change.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 .../devicetree/bindings/dma/qcom,gpi.yaml       | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index eabf8a76d3a0..25bc1a6de794 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -18,14 +18,15 @@ allOf:
 
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
+    - enum:
+        - qcom,sc7280-gpi-dma
+        - qcom,sdm845-gpi-dma
+        - qcom,sm6350-gpi-dma
+        - qcom,sm8150-gpi-dma
+        - qcom,sm8250-gpi-dma
+        - qcom,sm8350-gpi-dma
+        - qcom,sm8450-gpi-dma
+    - const: qcom,gpi-dma
 
   reg:
     maxItems: 1
-- 
2.37.3

