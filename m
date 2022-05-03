Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2E3517DDC
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiECG5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiECG4P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:56:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E20193FD
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:52:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a21so18827197edb.1
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVwYpRv6A4+S1bhstcYmZjP3ooQB2ceztq/bgoKx4Y0=;
        b=m+UMq9HjFGL1pawSHWXNJXY44LbxRl3b3jZvFdOr24LdN7cVAsl0Yc71DBJ/7+Errp
         SnNqwB6EnkY9DVlJXEW2Xv4nWFaVNGVJ0vTRZj3aMNR6UgDW1CPJKmEUG95memNdbie1
         v06aoP4J842g6uQ+MwMldH5MnXWRA5K88BqSPnV8fXbKGcyps6jxcJSoHGDQ1GmbbPUy
         bNjktXdRRKrdZWa6sINABtOr2Vu3rNQiwCgn2G36ZgNY5awGpYOY2IiMCGYKkQdXLBE1
         HXoYaNb2ZSUtqBpX8+pUHe4G4am33WQOfTMXcxwZeJF+sslF2nrSE1AWzoj44Mrxv85X
         xjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVwYpRv6A4+S1bhstcYmZjP3ooQB2ceztq/bgoKx4Y0=;
        b=O9bcJzs3YMPNH868k/D0ocKYYll4NSTCqLrCApeGeyR1t8fav5FW7oDWJW2YjuNqLI
         cgwSdzjBFUza9cx4Xy6UmVqnPN/ECQwOclN1LQz9LJNPkpWO6Wj3dO3W66ZVrxlvpnPW
         zOmo+fmJU7mUewuNP/B4hZ9nXv5PAbQmBzjrb+169NKmf8HXpVGm9Q33rIqqeGcylJMR
         wDJo+eS7K2K86OH9L/zVdYwYy9n9bW6+QvILJV+gzTp6voJUKGVyaD5qi3fl34kQi6aD
         RTdMEi3eYwZjPHHETa8QdpX5vvr1dg8aXYoThqnomMdbo267kqzcH1c08hNsdq4TdY18
         O1sQ==
X-Gm-Message-State: AOAM531drl3aqOUFQ3/lxlI1tGPIMTRPB0elzqAxG9MQ10fP0xx7rR/V
        vrZPLQh8JDY3+wf9uNWU3qeaBA==
X-Google-Smtp-Source: ABdhPJxX41ad42ohDONU2inC36SvNn3yJ8FVybQJC23jj81KFEG0aHFRSNIgZA4e/OODJOxCriEyJg==
X-Received: by 2002:aa7:c04e:0:b0:400:4daf:bab1 with SMTP id k14-20020aa7c04e000000b004004dafbab1mr16455194edo.101.1651560726854;
        Mon, 02 May 2022 23:52:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e2fsm4382915ejc.149.2022.05.02.23.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:52:06 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: usb: am33xx-usb: deprecate '#dma-channels'
Date:   Tue,  3 May 2022 08:51:56 +0200
Message-Id: <20220503065201.51818-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
References: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The generic property, used in most of the drivers and defined in generic
dma-common DT bindings, is 'dma-channels'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/am33xx-usb.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 7a198a30408a..654ffc62d013 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -61,8 +61,9 @@ DMA
   endpoint number (0 … 14 for endpoints 1 … 15 on instance 0 and 15 … 29
   for endpoints 1 … 15 on instance 1). The second number is 0 for RX and
   1 for TX transfers.
-- #dma-channels: should be set to 30 representing the 15 endpoints for
+- dma-channels: should be set to 30 representing the 15 endpoints for
   each USB instance.
+- #dma-channels: deprecated
 
 Example:
 ~~~~~~~~
@@ -193,7 +194,7 @@ usb: usb@47400000 {
 		interrupts = <17>;
 		interrupt-names = "glue";
 		#dma-cells = <2>;
-		#dma-channels = <30>;
-		#dma-requests = <256>;
+		dma-channels = <30>;
+		dma-requests = <256>;
 	};
 };
-- 
2.32.0

