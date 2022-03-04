Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB04CD053
	for <lists+dmaengine@lfdr.de>; Fri,  4 Mar 2022 09:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiCDIn6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Mar 2022 03:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiCDIny (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Mar 2022 03:43:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C60652D6
        for <dmaengine@vger.kernel.org>; Fri,  4 Mar 2022 00:43:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m2so1157796pll.0
        for <dmaengine@vger.kernel.org>; Fri, 04 Mar 2022 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBjY8RLSr4Wf/RqUjGw1XSvLuEMUT8Kxzt7XGrbbTA4=;
        b=LBoOjG64D/UMKqjjSUSfIyY9paBrboCxsj/Gk30Ux0Yb8y2kWr8kPSLbNzGy9XG2XZ
         jJKBTfU6YXbux6peglEz/OoYAgwv5D7xs3apAmtrKkzbjAt9B2ES3SJA7604uFndWa+p
         GUaLKENTUVnG3n1zgZcMa9GA9rMGA0wnwIq+DQCI7UjWacOD8kH8QkyF6o0aTMgP7mp2
         0JjHtm0FN65X88abSM4OcXgWdEzFFOE9nC9+ah0WVYNODF01angmKItlODyivzSO7ypR
         lj7XJxlv87EAfbZ/E5AEKz8ScT1O0caqrF6EfKajxxRpjtIywTJoQLKQ0Lg+nErySjqK
         sb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBjY8RLSr4Wf/RqUjGw1XSvLuEMUT8Kxzt7XGrbbTA4=;
        b=nyLWdRwlDYIR0KGrtJuaQDSkvMslKI1f25h/yYX9J82sHZZtKSNElTxYjIVTSJgoQb
         q7BUV6OsijiqeF/b8mve6BPJsYBpFPYfvMV6CoYfu8zsiV1N+lrLzOaWwsllBzuFicYz
         B3vaTKKKSkI69PmBqpPvwi7cdqPfEZnZ7CGnjoDg7wcuRdRlfpC7sm3skzfv8I758m+3
         vjXS2lnxcBuz1rsjCSt1CRIxvoTP7vZ8c3bvczXnCJnaUWC5PARawwBr0j0rN/xLW5bF
         pHNyotzBxLj0tPFycYsOiFfdGsLDRLK2vG8evJA5V53eNtywuyMlf6zBC+dbNNju0Le+
         lKvg==
X-Gm-Message-State: AOAM530tubSrMsRnLi4u+yz+zZv5wU8gFXNE0oW7DvjaoAuBxventy7j
        Nj3QajxnQYX+wNTdKCDyph78Kw==
X-Google-Smtp-Source: ABdhPJwogdPTQWP1HP1Zd+7+fIG0Cal3Ojoq8ZMgoufYmc6w15ueqOAsSeXr5UrPaoE8WU/Z25lopA==
X-Received: by 2002:a17:90b:1809:b0:1bf:59c:d20b with SMTP id lw9-20020a17090b180900b001bf059cd20bmr9506145pjb.220.1646383386342;
        Fri, 04 Mar 2022 00:43:06 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001bedddf2000sm4245191pjb.14.2022.03.04.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:43:05 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: Add dma-channels property and modify compatible
Date:   Fri,  4 Mar 2022 16:42:55 +0800
Message-Id: <12cff3b68de1bd02a8915bd70999bb4edafaca1b.1646383150.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646383150.git.zong.li@sifive.com>
References: <cover.1646383150.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree, rather than statically defining it in PDMA driver.
In addition, we also modify the compatible for PDMA versioning scheme.

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 75ad898c59bc..92f410f54d72 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -25,7 +25,15 @@ description: |
 properties:
   compatible:
     items:
-      - const: sifive,fu540-c000-pdma
+      - enum:
+          - sifive,fu540-c000-pdma
+      - const: sifive,pdma0
+    description:
+      Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
+      Supported compatible strings are -
+      "sifive,fu540-c000-pdma" for the SiFive PDMA v0 as integrated onto the
+      SiFive FU540 chip resp and "sifive,pdma0" for the SiFive PDMA v0 IP block
+      with no chip integration tweaks.
 
   reg:
     maxItems: 1
@@ -34,6 +42,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  dma-channels:
+    description: For backwards-compatibility, the default value is 4
+    minimum: 1
+    maximum: 4
+    default: 4
+
   '#dma-cells':
     const: 1
 
@@ -48,8 +62,9 @@ additionalProperties: false
 examples:
   - |
     dma@3000000 {
-      compatible = "sifive,fu540-c000-pdma";
+      compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
       reg = <0x3000000 0x8000>;
+      dma-channels = <4>;
       interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>, <30>;
       #dma-cells = <1>;
     };
-- 
2.31.1

