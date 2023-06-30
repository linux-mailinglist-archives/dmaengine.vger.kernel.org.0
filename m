Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAC7436FD
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jun 2023 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjF3IXK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Jun 2023 04:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjF3IW6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Jun 2023 04:22:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48D359E
        for <dmaengine@vger.kernel.org>; Fri, 30 Jun 2023 01:22:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666eb03457cso1035898b3a.1
        for <dmaengine@vger.kernel.org>; Fri, 30 Jun 2023 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688113375; x=1690705375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB/NARlS5Ir2yzVRaT0fYnfX6oqtCT4qz1PmDL02FdU=;
        b=k1xTiUS8cd+tudGaoFNEjYyn20oxUcTr40P1+dDR6fSuTqYDuDgapbkNAapa2OMGEK
         YUTO/kla71gAiyt0HID5SqziWZrYztcyPkt8nOwMWIjfdjO+We2UqiByXJl9fzh/BMsU
         6fJVEbpcFS7Xw4aQUkTmCmq+fvLna6iUc+uyDrGNg1m7FoUPUXAD8kRmGi6xCcJs8hfs
         mMSxQL9QFPklzqxfxAtm/5GmXEGLqRQ7gtTeQXbuBBtmiMuYY46Sp3yApCRmeYnx48Le
         37xrvxj2h5squB9QuyBKgrtUALCf6fZxyChQGfB0N27D8xWMtR0TceQtn5RAvoiofWTf
         ErCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113375; x=1690705375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB/NARlS5Ir2yzVRaT0fYnfX6oqtCT4qz1PmDL02FdU=;
        b=YCtRu0zmRskvkNAwy7HPsJZjnTBg4HE9ESeqJcXov42LNueAh5Je/FC1ce5lPrKlA+
         Hg4theCk/9jLFUmH4w0v0KKx2xxrFXvUGhbD0vKLsB0xzolFFibN72yXN7PHpoPOT+l0
         cy0ltu24gw4AtJSCxtnqHIhieZFQ5XTyeK7JwNQLc+YXsR82QN7NYZI+w3KFZ/37H1kL
         Ih4WGrBG0XNqThM0IWOCgx/bv1KcV6Hd+RkF4RbD6oJM+Nt9SVmPNswrLc/lDrJU2kvf
         d+v0rVgOW6S1m4jNxkhqbA9RbPb7NIyZ2oszilZLQPd0VGla9PD/NJjkCDdHZKRagmSN
         bvqg==
X-Gm-Message-State: AC+VfDwh80yTkmnTlAf7ItB+TkzMems8Ua6o4iDo2wbFjdIG5xegsqPM
        psdKBFBzuwezrt4vz4K0tsMGSg==
X-Google-Smtp-Source: ACHHUZ42fhIYo4LeKf9iiBZSi2OLijZ04X55oE1u2vKp61P7Nv7KzUbbp06RSmmgrScmmb10J29DeA==
X-Received: by 2002:a05:6a20:12c4:b0:127:462b:c41c with SMTP id v4-20020a056a2012c400b00127462bc41cmr2026373pzg.37.1688113375346;
        Fri, 30 Jun 2023 01:22:55 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b00666e2dac482sm9462967pfn.124.2023.06.30.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:22:55 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        konrad.dybcio@linaro.org, conor+dt@kernel.org, robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH v9 2/2] dt-bindings: dma: Increase iommu maxItems for BAM DMA
Date:   Fri, 30 Jun 2023 13:52:30 +0530
Message-Id: <20230630082230.2264698-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230630082230.2264698-1-bhupesh.sharma@linaro.org>
References: <20230630082230.2264698-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since SM8250 BAM DMA engine supports six iommu entries,
increase the maxItems in the iommu property section, without
which 'dtbs_check' would throw errors.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index c663b6102f50..6433f2892ae4 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -44,7 +44,7 @@ properties:
 
   iommus:
     minItems: 1
-    maxItems: 4
+    maxItems: 6
 
   num-channels:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.38.1

