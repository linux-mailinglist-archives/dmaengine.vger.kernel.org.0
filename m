Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1516374A6A
	for <lists+dmaengine@lfdr.de>; Wed,  5 May 2021 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhEEVjp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 May 2021 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhEEVjl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 May 2021 17:39:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2482EC06138B
        for <dmaengine@vger.kernel.org>; Wed,  5 May 2021 14:38:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t21so1935334plo.2
        for <dmaengine@vger.kernel.org>; Wed, 05 May 2021 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5tl04v9finFgI5dTLUvXSF6+C6BwGNEbEHhfHuvsdY=;
        b=ACKDEi3d8y/Es5bvtxn0l07L22kbFP+Tg3bHthNBDjeNhLT0RD0b30luapq6h1jr+k
         ihA0lPDekyGXGNtEsizSa93QkooYXi0yYZ/Hbhgssk+gGhl8Tnpf0bq+Vh+Mh5exkjBd
         L/xDggHHQz56PSkFhqnOEn+NeB+a0Hzp4BjOAVaPK3GhI7G1jIYpFOMnzJyNNJT8Hp8d
         0WuYvDLSLn7AzU5isvMdBRcgavBQQCabPXAsJyTA6Pa3VhV1OvUBxmVdQbr7TOONLK7y
         W944jvb43h9iBU4Sq+rKDsnM81Kq6DcFxOfRsgXcwnqaNUY7LOXwewEsdrmgQZKmjP5T
         P0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5tl04v9finFgI5dTLUvXSF6+C6BwGNEbEHhfHuvsdY=;
        b=RGOvxDFsEfEbJkiDhNwu7FhI3n94mjZnpupTNQnAeYlQcF0gSCPqaVa7jzbHLepK2k
         a/ngnetfsmCjU2VU/1evxN08Ju0ovQxrXffS6fWkX6wniGb4HQaucEdh3f7Bsddtwr7t
         dZaZeHTqeerzHMpLRqF5l+XLcZ9zl7JonLpskGx/zODgXAyzNoJv7MMsbxmG/94KDtFW
         HfPxuMJc4dALaw4i3C33NrpJ12xpsP5HbZmeJScNcncKugnvBAXuM+qJCFe7ClpPtSpD
         kzBfVMD7I0LzH+saSL/Mj+bePHmBSDkOGIVOiSwuM2vdplprLRTW4SB+qxaYLK4cKVw7
         TLcQ==
X-Gm-Message-State: AOAM530twF92clE/ZiccqimQX14Y0OLAZnNKJyLZw4cc4Q4QEU6tCzLk
        cxVCnEpXoG0BW3NIThnvDZRSR+nWmtg7Bg==
X-Google-Smtp-Source: ABdhPJxokI0TPxCQxyWx3qoUxcst1Tw4Diqii8RFo16frzYUDUMAAjgoOQ4pxTkscIz5IfuV9xAs2A==
X-Received: by 2002:a17:90b:8d5:: with SMTP id ds21mr13382570pjb.65.1620250723426;
        Wed, 05 May 2021 14:38:43 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:38:42 -0700 (PDT)
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
Subject: [PATCH v2 07/17] arm64/dts: qcom: Use new compatibles for crypto nodes
Date:   Thu,  6 May 2021 03:07:21 +0530
Message-Id: <20210505213731.538612-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since we are using soc specific qce crypto IP compatibles
in the bindings now, use the same in the device tree files
which include the crypto nodes.

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
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 9fa5b028e4f3..978c34f176de 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -205,7 +205,7 @@ cryptobam: dma-controller@704000 {
 		};
 
 		crypto: crypto@73a000 {
-			compatible = "qcom,crypto-v5.1";
+			compatible = "qcom,ipq6018-qce";
 			reg = <0x0 0x0073a000 0x0 0x6000>;
 			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
 				<&gcc GCC_CRYPTO_AXI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2ec4be930fd6..6423991fa303 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2328,7 +2328,7 @@ cryptobam: dma@1dc4000 {
 		};
 
 		crypto: crypto@1dfa000 {
-			compatible = "qcom,crypto-v5.4";
+			compatible = "qcom,sdm845-qce";
 			reg = <0 0x01dfa000 0 0x6000>;
 			clocks = <&gcc GCC_CE1_AHB_CLK>,
 				 <&gcc GCC_CE1_AHB_CLK>,
-- 
2.30.2

