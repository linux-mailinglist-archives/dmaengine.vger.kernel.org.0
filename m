Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31269389154
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354423AbhESOkG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354350AbhESOjk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:39:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B5C061763
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g18so8375170pfr.2
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4+Pmvy+Kn++u+tJ4TtTc+C+SSq9T8K7CwVNxOIPf08=;
        b=x2HRCTgG0GipiWBQV07MrWomyjGTmV7e4awp8zrWM08SFfCgZhcczG3pxZ8iD2a1/d
         kAyVzuq69LQyP0DH5u32JgTO48NM0M4agymuMF3Y9akEUjkPGSnpqualcBZl5Ue3lLvr
         h2+udxNYvoW8ZM9ymO8oRwyLaJkasizAM7pMMZLyQJzZoVO8lpaitttXtcVF+I5FLH89
         WN1gbQo2LRRpT5OPvqlATjjUahEWcsUSi99+xxRd9LEynK5VUH/lCulfveJozVyPs5OA
         uFgEO51te7ziVGkJRdeKwxlRDLlhzFDQX3T5VDhwxhCq8bjJ6PbcXW5aCW/02q4cidEr
         ISIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4+Pmvy+Kn++u+tJ4TtTc+C+SSq9T8K7CwVNxOIPf08=;
        b=l/qYMfxmOteTfih2l/aelZayFNvU28spLrsab8qrnMzrcMoYMAm26H05qv9orxWo6b
         imY2bEr2GE9OYB0Uen5oKmr8b8MkToU+BIfbHtOl6x5nt+yCW3Fpv+MjKZc2RiluqcsO
         kU9fKI77OPScP4/1FLjfakQUeGu6aDnKv7cGI440VnB5CpltjZMvLSlHDCO0o/PJ9dta
         zKdlFjGQid2m1caRjmwd5MBjPnBBboy/Y8ZxJI1p/F2BQUi9hiXjR64YS2hahmX7Ovgj
         jrnn/PPBho+UWDcxCCXX6je4VQkWGhs1DV5zO3L0WT+TRQ8xlCBMLZuLxWN3CmS44uUp
         zTRQ==
X-Gm-Message-State: AOAM531MSgxd4+sbm5UbG+cf4W92tyk3q9BFAl1ts5VTJ7Do+Zfivugh
        WfzpVUOeEs8B2HO0NmcjzgnZ9A==
X-Google-Smtp-Source: ABdhPJwQ8L+n4Xe7Qq4tu9SJumb4UjS8KaJ/uz1/vXqSGC2KvOezTn5DRRaQ0RPlEN0HrPsxQ4PLvA==
X-Received: by 2002:a63:bf4a:: with SMTP id i10mr10994699pgo.200.1621435099126;
        Wed, 19 May 2021 07:38:19 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:38:18 -0700 (PDT)
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
Subject: [PATCH v3 08/17] dt-bindings: crypto : Add new compatible strings for qcom-qce
Date:   Wed, 19 May 2021 20:06:51 +0530
Message-Id: <20210519143700.27392-9-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Newer qcom chips support newer versions of the qce crypto IP, so add
soc specific compatible strings for qcom-qce instead of using crypto
IP version specific ones.

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
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 4be9ce697123..7722ac9529bf 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -15,7 +15,12 @@ description: |
 
 properties:
   compatible:
-    const: qcom,crypto-v5.1
+    enum:
+      - qcom,ipq6018-qce
+      - qcom,sdm845-qce
+      - qcom,sm8150-qce
+      - qcom,sm8250-qce
+      - qcom,sm8350-qce
 
   reg:
     maxItems: 1
@@ -71,7 +76,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-apq8084.h>
     crypto-engine@fd45a000 {
-        compatible = "qcom,crypto-v5.1";
+        compatible = "qcom,ipq6018-qce";
         reg = <0xfd45a000 0x6000>;
         clocks = <&gcc GCC_CE2_AHB_CLK>,
                  <&gcc GCC_CE2_AXI_CLK>,
-- 
2.31.1

