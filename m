Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA0389139
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354218AbhESOjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354256AbhESOjF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:39:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9CC06138B
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so3524796pjb.2
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfYY0SynHLUvKImA0WJS6vFoZYpwQQ4sgm9paKqwl54=;
        b=LMDyQ/zuyHaHFHZdUKNQlFAxMEqlWRr2VaQPfUkGnDJDmV1+yF8C00rnS4gCFd5v3o
         wmKj8D69QYlT2IY21LKAQ0umZwSOx99YlOm4ZSXhnsW99gHN8TXUbgLX0Eb8fK0zkumk
         FdBnnYmInjarV5Kb4JQQZNhGs7UyCgGhYZP2EaVOV5jar1VxohlN80/G1vglN9Fd8ggq
         Ob3cnQ5JAkQIJOWIEfUR8y8ZCpf5ftFAVaI1C3nk1Hiet1VVrGz47+vRcGsbpknC9fSF
         PVRMdV64UtNnZqwUmS3jKeDnvAOLOMsfnQ3rQ/EQkvoZS1dkgakaTpK7VDyUKEZGSSJC
         FClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfYY0SynHLUvKImA0WJS6vFoZYpwQQ4sgm9paKqwl54=;
        b=oIDfwBePqhjLQw3hAYdwpatp/XZT9OVF3mLGSOHdPK7bw+0f8+x0qjDnoZfuEsnXd9
         etuxnkj3umaSKv7Pbn5eb6DDAMUTLNVrxK1VW4lAhOKwMtAey19mt0x+Ks6VXovMgVFn
         /w5+xwbpty7VNuOK5a6m7eSwtEgVc2ICXkxbRZ9B9OKo5rZOsLGMnwbRvrlaZLOsGNwd
         F6Pawjy7zRcyjgf2FUmkxBfHbKmrXo9+u8/8fE/ZhL50ojNhksONI5o9AKD/m3h0p75u
         xaR1MccjsahDuVbBB+jAWPXTuleHmy/se8w10BB3OlLKF9R4m4OLqcnhIVwADnYKz0Y1
         to5A==
X-Gm-Message-State: AOAM531DDRzsh6Qzl4R37rBFNSZ+W27L2TuGNhe6OtfIBHCefxrnNuw1
        Dd2SenEb22LJtpXn21lCEbJNQA==
X-Google-Smtp-Source: ABdhPJwy849Ca+hXXvP504HCbRthfcaqff/Mo+T2X7D7E2ExfjN7Ipe/+RyMBbaOmwnYSCCO9oSKDw==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr11697000pjb.33.1621435064459;
        Wed, 19 May 2021 07:37:44 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:37:44 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v3 03/17] dt-bindings: qcom-bam: Add 'iommus' to required properties
Date:   Wed, 19 May 2021 20:06:46 +0530
Message-Id: <20210519143700.27392-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the missing required property - 'iommus' to the
device-tree binding documentation for qcom-bam DMA IP.

This property describes the phandle(s) to apps_smmu node with sid mask.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/dma/qcom_bam_dma.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
index d2900616006c..2479862a3654 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml
@@ -55,6 +55,12 @@ properties:
   interconnect-names:
     const: memory
 
+  iommus:
+    minItems: 1
+    maxItems: 8
+    description: |
+      phandle to apps_smmu node with sid mask.
+
   qcom,ee:
     $ref: /schemas/types.yaml#/definitions/uint8
     description:
@@ -81,6 +87,7 @@ required:
   - clocks
   - clock-names
   - "#dma-cells"
+  - iommus
   - qcom,ee
 
 additionalProperties: false
@@ -96,4 +103,8 @@ examples:
         clock-names = "bam_clk";
         #dma-cells = <1>;
         qcom,ee = /bits/ 8 <0>;
+        iommus = <&apps_smmu 0x584 0x0011>,
+                 <&apps_smmu 0x586 0x0011>,
+                 <&apps_smmu 0x594 0x0011>,
+                 <&apps_smmu 0x596 0x0011>;
     };
-- 
2.31.1

