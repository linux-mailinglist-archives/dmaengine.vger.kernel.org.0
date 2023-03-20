Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B756C0B2A
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 08:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCTHMf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCTHMd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 03:12:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF62195D
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 00:12:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso12806264pjc.1
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679296343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPJTzAUBl9aQkaatQh9jv7wmEMUxBwZiAFZub+QkGFU=;
        b=wesqcDIp6CGIDZkttFy2CU6UGJ47kp56J2X9DNeu+p4pf5NQMe4OUzMv79j8IeI4+y
         4gPEP3f1Cxg1ImguOlmI3/Hb4pD6ZJJXREwkgmYZeuTQlQ67Tx/qQ9e3jzr0sDllh7yy
         aupO6L7PjeMqeyHHJ9P52Lgg0t4MA5Agm6W63CD1A1StYW4HrzDPbqPXrsBCx8rcvboZ
         zr1LLvEHFmA5apuWqDJeAGdoDpG7f7JkrnbJ/lLDBuCWJOcvanZku3Z+31zE6dhrotbV
         7DpwaUpunZDeiyhtvGa3pfWyC8qUcTXMNVG7PtjOf7Gdje6lfV+2exWifqkedTmw/Kkn
         bCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679296343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPJTzAUBl9aQkaatQh9jv7wmEMUxBwZiAFZub+QkGFU=;
        b=7Lm9iyF/BmYMnUOEHJzCEUQgAqv4oc3mkdR7FsXdmNhz20TGVU/B0YU9g3+yNto9SC
         HESjql0a1Mw1xr+ILSeVpYao+1/tBjcL9QgjPyeavcFYbSDwFHrZHKtDdk20vBs3LrbE
         qQYK08FeMvk9kMOpAeBBmuH9Ew77p92CqG0/DedO8SGIW4XlliVAl2Pf0hE2TOIMzVEr
         /yZ5+8kOmFa1knwcHQrnhhzl4WjrgdrEqmKeFbEv280ll6sV45lQFl24GQK+ZUySsEsw
         6sT2zT6ib67F3tnQHTilcRuOEm0IiILVg45j0/511WFPdDPuARXmQTSDaYbFeLFI/C0l
         7V5Q==
X-Gm-Message-State: AO0yUKWVuI/SF3MuoYVKPBfovyDGarv3Ifn654og8Je3z5b5fYBI4g9k
        maalIpgQKCIbwuxpRywzthWqj48OpKkd6OK29yA=
X-Google-Smtp-Source: AK7set8+GGQ0GBnKezfamELSnYM3iCzRrxwRSznc7c7dTN7KY6YaM6wT3eo4ISJH84tWfbzbSgb/pA==
X-Received: by 2002:a17:90b:1bc4:b0:23b:bd09:7f0b with SMTP id oa4-20020a17090b1bc400b0023bbd097f0bmr18084040pjb.30.1679296343242;
        Mon, 20 Mar 2023 00:12:23 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:7331:922d:c0be:85c4:f0ae])
        by smtp.gmail.com with ESMTPSA id m3-20020a63fd43000000b004facdf070d6sm5619477pgj.39.2023.03.20.00.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 00:12:22 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org
Subject: [PATCH 1/2] dt-bindings: dma: Add support for SM6115 and QCS2290 SoCs
Date:   Mon, 20 Mar 2023 12:42:10 +0530
Message-Id: <20230320071211.3005769-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Add new compatible for BAM DMA engine version v1.7.4 which is
found on Qualcomm SM6115 and QCS2290 SoCs.

While at it, also update qcom,bam-dma bindings to add comments
which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
This provides an easy reference for identifying the actual BAM DMA
version available on Qualcomm SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index f1ddcf672261..4c8536df98fe 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -20,8 +20,10 @@ properties:
       - qcom,bam-v1.3.0
         # MSM8974, APQ8074 and APQ8084
       - qcom,bam-v1.4.0
-        # MSM8916 and SDM845
+        # MSM8916, SDM845, SM8150 and SM8250
       - qcom,bam-v1.7.0
+        # SM6115 and QRB2290
+      - qcom,bam-v1.7.4
 
   clocks:
     maxItems: 1
-- 
2.38.1

