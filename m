Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043E5517DBD
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiECG5A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiECG43 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:56:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666421AD9B
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:52:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so31632503ejd.9
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uPBTkDisPWIPiz4fbigxN/qpqS0KGaulp0SsPCNcau0=;
        b=t4KrqEJ/h15gUWJSLYY3MUKbfEd3VUaK4JAv+p+reF9rOqJN7S/TAk5YJmCAYrsPXo
         aDXMb7O4vMFgvjBgSMfIDxqx9wTP4D12JkvtMXEeiMyfxBJ+69V3sq5/KeoA982vFadm
         tVQByYanFDMF2PGYCASFU9rvxredPLcyOzN1h9o7B0Cosl2F17GXfnzDaN7dZdhnRXsv
         T+1LIIJC0Wqs2yJ0TOhzO4UkU44cRmZqX5KSLjxRbo62gJynSOygw26jWuL1WZD04AFo
         SFG+Hl7AavHFmalQ2zWGwyLlohQBuJtweUS46QntjrAeC8YmBCQKhxzrgKLgaw3W5Z8V
         nWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPBTkDisPWIPiz4fbigxN/qpqS0KGaulp0SsPCNcau0=;
        b=nzQnxQrsOjVcvwuMV63UCLO5CVpbFdCNGS7lpANY3Bw5A0WwlDvx2hEip4l6BmhMGO
         oEhDgjGIc55LUK1+dj3+Pc5CPdczX6YCUTle0B5C2cgIOlkIADplg8Z9NBWRKfun+oBy
         uoXn+GO8aZ3U12td4MTnBuvEkrH/wN5WLbB9fqXlpaih5APPYen2bHFdym9120dKjRgD
         1OTFiTr1VbX0DZgQL9TSz+GgCACAB8G/W/diaGLgpqs7cvGrK83P03n9Kb4HYQzZh/yc
         u79l3al+Kf32jAn89WGD385o+7UFRxnEsOad3OIffiZgBqh1PWHNlCKcgEaPxtQhcft5
         mvww==
X-Gm-Message-State: AOAM533sxOxCvc5nSGX+pEljRY48QFmtxUKvUULf6JCwDWskxtMyq/pH
        ao5+XbpqN1O5qGWnhawjtwF4DA==
X-Google-Smtp-Source: ABdhPJzz8whStayZ25mFT6CP6vZmwkhtis9sMlNq/kcPbjhYCFLFPFfntTVW7/VQLhuzRFEYgArCzw==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr14079537ejc.762.1651560733885;
        Mon, 02 May 2022 23:52:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e2fsm4382915ejc.149.2022.05.02.23.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:52:13 -0700 (PDT)
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
Subject: [PATCH v3 6/6] ARM: dts: dm81xx: use new 'dma-channels/requests' properties
Date:   Tue,  3 May 2022 08:52:01 +0200
Message-Id: <20220503065201.51818-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
References: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

The '#dma-channels' and '#dma-requests' properties were deprecated in
favor of these defined by generic dma-common DT bindings.  Add new
properties while keeping old ones for backwards compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/dm814x.dtsi | 3 +++
 arch/arm/boot/dts/dm816x.dtsi | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 7702e048e110..a92630113f57 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -167,8 +167,11 @@ cppi41dma: dma-controller@47402000 {
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
+				/* For backwards compatibility: */
 				#dma-channels = <30>;
+				dma-channels = <30>;
 				#dma-requests = <256>;
+				dma-requests = <256>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index a9e7274806f4..eb0a95da94b2 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -655,8 +655,11 @@ cppi41dma: dma-controller@47402000 {
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
+				/* For backwards compatibility: */
 				#dma-channels = <30>;
+				dma-channels = <30>;
 				#dma-requests = <256>;
+				dma-requests = <256>;
 			};
 		};
 
-- 
2.32.0

