Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A652512060
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiD0QRE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiD0QPg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:15:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E733E18
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:11:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g6so4426825ejw.1
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1p5Gf/ZzMBda/+Dyw0bd70cBiwm1tqXf7hCWQtWqsEE=;
        b=smFD5V6J9pPL6PEJv25+/3PFL2X+WQ3Kyn12ozctaStrdNKV5sG6aqFI8JCZ5ddHCE
         ECQCPe/hY0ENMJzK8NjAefYL1znjAJ4MC0z1veVjm+99Lhv2bilZNlhaRLpH6+C0/lXu
         XEqzIKVhXU0tE3DPOvCEFtlpxfU0OysHyIPl0jFQczRGCf3kmrLen7e9QYBaPdxYH7P2
         66rd4jZu47gMnjCXc4UhX8wxezYzOrgLwYJJhsL+BiSRNlaUep00H2hYHjn5RV/6yzoT
         zosfmLTcVVMmTWTu9hBDTeN9YP40ueo8rpZldzL7wxzQ59cl7iMDrXlYTo5PoJgjmWpn
         MEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1p5Gf/ZzMBda/+Dyw0bd70cBiwm1tqXf7hCWQtWqsEE=;
        b=UdyiW7i1C6GWjAoFqIQ7hxVzf3MZOn64hc16G2sWh5hGICbDfRAbbZwsQp1TKcBt9g
         WxeQ/j0ONqlGJRJQBHijL/HSMY50EZ+w+RQum/DkxGBKcWwOse5oymJ79FnrnXykw3rE
         W8rUfyU0aeXrglzbjj8pTqSL49jGjlpU1gjVvWLzQkhFBDuxdqWWoCYVelsrfJAzTk+a
         dXGE/elr8KnzahL+Dn3ex/7c5fA2mwUPcIKdaWCKXxOYAaSsqi3LMscHh22WkCyPayx5
         7FkfYyZLtouRgKeqjw3jLKk8HR5Y7ecdUyLjo/bjdo9RPIl6lcz4/Ip+xKKnR5eACC+T
         01rQ==
X-Gm-Message-State: AOAM533gqf6p9AxidcVB6+lJZLsUReiDMXre9T7/wTf5DltSMx8cnikD
        pTMJIELZJZBZLFw5zSbsCuKiWw==
X-Google-Smtp-Source: ABdhPJwXKEYcbdCdmGX9YcKJChevv92DETVDL64z5HohA/FFcRgldB5wG73bsS8XPMg1i6ElPuKMIQ==
X-Received: by 2002:a17:907:629a:b0:6d7:b33e:43f4 with SMTP id nd26-20020a170907629a00b006d7b33e43f4mr27742808ejc.149.1651075910203;
        Wed, 27 Apr 2022 09:11:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906234100b006ef83025804sm7124610eja.87.2022.04.27.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:11:47 -0700 (PDT)
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
Subject: [PATCH v2 4/6] ARM: dts: am33xx: use new 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 18:11:24 +0200
Message-Id: <20220427161126.647073-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
References: <20220427161126.647073-1-krzysztof.kozlowski@linaro.org>
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

The '#dma-channels' and '#dma-requests' properties were deprecated in
favor of these defined by generic dma-common DT bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6ec85d58dd1..55ffb0813ded 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -461,8 +461,8 @@ cppi41dma: dma-controller@2000 {
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
-				#dma-channels = <30>;
-				#dma-requests = <256>;
+				dma-channels = <30>;
+				dma-requests = <256>;
 			};
 		};
 
-- 
2.32.0

