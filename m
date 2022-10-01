Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500C45F1FB7
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJAVTn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 17:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiJAVTm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 17:19:42 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E42BC1;
        Sat,  1 Oct 2022 14:19:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l127so3236745iof.12;
        Sat, 01 Oct 2022 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IhR4jS5mTKqz4s743v2gTnl33ynzzzLSD1UxLXxB31Q=;
        b=GVfTBp1WvMFPhDUQGNZ8fnj0xKNKzm99WezeKAC0YvLWmIyk+yVXz4WBtEPcoYFyG0
         GL9DdKiMBEJnC5h03qv5TpfEi7DQFf5KEv96nMScmaIXCKe7lkvf/24JtjKpVEYNjm89
         XfOpKTp9SQkh9eNKNoccv1GmmHtrYlcnrbMX0s+0B0CgNB1iNvvVvkBsBRCw9rxXubjp
         TK3VccIjbS/tkRhdItjhXrRSpvD8iBIt+tgZD1qexK5V9SLu9TcbpGNPU2urgiVKFg2C
         kINmgJu+Guzo9Im3mYLyRbakAMZ4BDZfpG2fmD73S5Cu9hs+DpCanTvuGSzCXVNL9kqL
         WESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IhR4jS5mTKqz4s743v2gTnl33ynzzzLSD1UxLXxB31Q=;
        b=yJVPa72F5FyLIomF6vQCJhSCPMP3cqKxKR5NFgaSk3prn0sCOM8Gtgp6DSPn1yeNZZ
         D7GC0fcD7k5PIwyNPsFRcmezxssJB0IKi16jbZFHYr8UQlBAmKoaPpZ8q+u5I8C+Y5IP
         +dBL8KQIvbglU04Rz+FCT0SBsI45dCFP5uZn+9ulpgoIyz+sBzZmKsUuP27x29wflSju
         MQNn6FWRa2VN3oCZEEjycDaIKIlRqcXL/y1lCHvndlTcyU6rPy1OIP7z5Izln+zP2UnS
         /TXWq/DLQ97dLuuN7bLon42KYpZoVbomJlowbEx856oDH/jGDLD0eXs5hve5t8Vc3Bvw
         oHAw==
X-Gm-Message-State: ACrzQf2GiDCktn+BI1NLOsd4vck/BOD0ewNhFHAADCf8DMym6TBNOKMk
        2FZOx3XMJyoiMsJ9YzX/cy6D0iUe8l8DVQ==
X-Google-Smtp-Source: AMsMyM5c0ZceTmIceQmKCmHevF5/W1F/ZoIuoScWE8IalNjG8pAEWwsqGwqqNThFY3/t8V+JZmQrbw==
X-Received: by 2002:a05:6638:2725:b0:362:1b0f:ce9b with SMTP id m37-20020a056638272500b003621b0fce9bmr1121907jav.250.1664659180430;
        Sat, 01 Oct 2022 14:19:40 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id x7-20020a056638010700b0035a995a34d6sm2432272jao.60.2022.10.01.14.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:19:39 -0700 (PDT)
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
Subject: [PATCH v4 1/4] dt-bindings: dma: qcom: gpi: add fallback compatible
Date:   Sat,  1 Oct 2022 17:19:31 -0400
Message-Id: <20221001211934.62511-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001211934.62511-1-mailingradian@gmail.com>
References: <20221001211934.62511-1-mailingradian@gmail.com>
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
2.37.3

