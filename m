Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FF511EEE
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiD0QR6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbiD0QPb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:15:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB73ECC92
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:11:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so4370547ejd.9
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVilUoRevfZDW2H5vRfurHd/Fm2AVNqP5L2gftL/36g=;
        b=HFE74/sy74Ts9hOtHQkpkkhIGjvp71P78ebNvVgzzwuV/A0o0Ik9eQbvh/8R1FyiL0
         ywd8UQvKTYLmRNCskg/d09oPajbA1Aa09AUygozHoZIntMLTSgWr9soMislFB6k/4gVn
         nY5jwfLX2bk2gXaTd1vxd3KjOwLnHJMBM5Pgo37uYSKqm7ARBi1qeYqaN3C+MQ5q+Wo4
         9g3s5sh2s9my7tLUpmjeXNwDPz4QsxDf8PtZ6lloeN45TsypWiopzPu173xCFsL+DXYr
         v2BToql5KzZ08cMthVU/bx3zssRX8IXhD8I38m7P+VudT2i7yjyWNQyuhg9kZ7c3R11j
         Ykxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVilUoRevfZDW2H5vRfurHd/Fm2AVNqP5L2gftL/36g=;
        b=09kZim4H8D9RbDqwpT/OtfI7BcSiiLiywO3lBHdwHDqxopM5kdEDCY9WDT1Yi3Mei7
         xeG9baUhQ2JsuqxDwGBasRaysaLQIklvXwYL90MICEFaRGx1fD/H1ty8xON0527cHvkL
         giV7M8F1DM7h6L/4HiaJ7i6webz9AyIigjozaR+v5WLXKY6qI5k7d3wzT5A5IT061zit
         C8DKU3JSmxci1aclHAwSTW2KZPtbbUIAZic7ickeotlCc6PO1qwZIeNbEPISu4/3y74N
         mk/YXyiJADuVQAOVX4sMVIWtgdJCvox3lltmJbl22420pAiyw9DlkVMBZyEq0dT+TUTK
         B8Sg==
X-Gm-Message-State: AOAM532aKC9VFDmFWqZsfsPNqapUhWCq4OlLXAISXMrEL19dxBh8tagl
        K/InyrD6cY6TBIrr7DXt2YIF8A==
X-Google-Smtp-Source: ABdhPJzawuxVKwUV1aVJsaz89L6ORSEr8BOw8peEovEn4hzo9tavQ039MLdrmVJCwy8CjjMef9zlQg==
X-Received: by 2002:a17:907:86a8:b0:6f0:1f97:d7da with SMTP id qa40-20020a17090786a800b006f01f97d7damr27532206ejc.663.1651075903799;
        Wed, 27 Apr 2022 09:11:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906234100b006ef83025804sm7124610eja.87.2022.04.27.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:11:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/6] dt-bindings: usb: da8xx-usb: deprecate '#dma-channels'
Date:   Wed, 27 Apr 2022 18:11:22 +0200
Message-Id: <20220427161126.647073-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The generic property, used in most of the drivers and defined in generic
dma-common DT bindings, is 'dma-channels'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/da8xx-usb.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
index 9ce22551b2b3..fb2027a7d80d 100644
--- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
@@ -36,7 +36,8 @@ DMA
 - #dma-cells: should be set to 2. The first number represents the
   channel number (0 … 3 for endpoints 1 … 4).
   The second number is 0 for RX and 1 for TX transfers.
-- #dma-channels: should be set to 4 representing the 4 endpoints.
+- dma-channels: should be set to 4 representing the 4 endpoints.
+- #dma-channels: deprecated
 
 Example:
 	usb_phy: usb-phy {
@@ -74,7 +75,7 @@ Example:
 			reg-names = "controller", "scheduler", "queuemgr";
 			interrupts = <58>;
 			#dma-cells = <2>;
-			#dma-channels = <4>;
+			dma-channels = <4>;
 		};
 
 	};
-- 
2.32.0

