Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBF9517DC8
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiECG4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiECGzp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:55:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C8919021
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:51:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i19so31587831eja.11
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWso6SETa3zmnQdk3zavu/Qn/dZv2mGNi7dOArTUaJU=;
        b=w3sCbaVhdxKfSGWyhX040512wTc69vx2SUBodkB0g2Tdbg0kRkxlZ6AWWb/9BruAhv
         V2Qx7wQg2daDTYJiZhgtCdUQlgUu2YwGHybtQr03nAZKxawAJjgl0mO8sUcBkBnJDy/L
         PFNJrEde2YyZrkDYKDCoPqL/mYeNSrz6ywbQxepw4yFPAkkZFMklxcOKP4Id5ThCQpXt
         Wrsn79iQxXbMs16ic6AaUDN6Vb0+MzQoL5lz+BGEmLHwOHE79P6vq+DQpOPDYnQWH/Ut
         uucQJdSGjvInbTaiaX1fiedUMqnhnNc2aj6lRRJw/m1DlhCwnkenjQQDmSbowNJ5M6+q
         +KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWso6SETa3zmnQdk3zavu/Qn/dZv2mGNi7dOArTUaJU=;
        b=RLq3Ot5TP+mxYUd5r4+kdf1VtucIdNNGIzFAvLDFb2uyJ5opclvtf/Betpv8Rdqmow
         VNuXjpMxODUvKzC2ohduIVbaILRDzFk+XfYeB2d/tti/kfUAqna2J2iQzwaWAw/1GK/L
         nNOblLda0C+DFtGEak1auOBWStWo+w+nQyZOhOS66ArL/9+4Ntom89G6L0PFukmS52JN
         vZ03LBZTXJr5kIZxiDa9utZQ3F2323He/k0iSCOapq9p/Vw9EeMY4TK8RzUktDWIrTLR
         EUfnHlyYErZvyyhZTSPzYTt8CwF180BSNH9Id4nhr5tKg96mKsE+Mcx4C6A/XpvbdSZO
         wuxQ==
X-Gm-Message-State: AOAM531ZktaLjaLJqWC6H1kgypfCv2yoffSA4oEADCjsxnBB1O1SZIb+
        nYtIZsbXQ6b0fXIEX9LJHHM7tQ==
X-Google-Smtp-Source: ABdhPJwz38M4xbaO2wUwwhfgjWjZcDTE1d5C1v2hzgq3bOMG27kZiRkxckaXy2K4QNxkqurHswPA0g==
X-Received: by 2002:a17:906:cb09:b0:6f3:87ca:1351 with SMTP id lk9-20020a170906cb0900b006f387ca1351mr14242199ejb.674.1651560717964;
        Mon, 02 May 2022 23:51:57 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709070b1400b006f3ef214db8sm4246237ejl.30.2022.05.02.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:51:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: sprd: use new 'dma-channels' property
Date:   Tue,  3 May 2022 08:51:47 +0200
Message-Id: <20220503065147.51728-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065147.51728-1-krzysztof.kozlowski@linaro.org>
References: <20220503065147.51728-1-krzysztof.kozlowski@linaro.org>
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

The '#dma-channels' property was deprecated in favor of one defined by
generic dma-common DT bindings.  Add new property while keeping old one
for backwards compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 79b9591c37aa..89d91abbd5d1 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -126,7 +126,9 @@ ap_dma: dma-controller@20100000 {
 				reg = <0 0x20100000 0 0x4000>;
 				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 				#dma-cells = <1>;
+				/* For backwards compatibility: */
 				#dma-channels = <32>;
+				dma-channels = <32>;
 				clock-names = "enable";
 				clocks = <&apahb_gate CLK_DMA_EB>;
 			};
@@ -272,7 +274,9 @@ agcp_dma: dma-controller@41580000 {
 				compatible = "sprd,sc9860-dma";
 				reg = <0 0x41580000 0 0x4000>;
 				#dma-cells = <1>;
+				/* For backwards compatibility: */
 				#dma-channels = <32>;
+				dma-channels = <32>;
 				clock-names = "enable", "ashb_eb";
 				clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
 				       <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
-- 
2.32.0

