Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8471517DA6
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiECGzr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiECGz2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:55:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9F1834F
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:51:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z99so18822625ede.5
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXFFTUALU/8aWUEnUkYb7ujeKf4ayBbE0A4maETvon8=;
        b=ghcGEGkDJgXdnqqaDjnZs2KLn8eN/PpXDDg2h4Af92aTMcGe5OVx2KJjdExvljv6WB
         X8rrZSIAHcqHCbhvVKiawXr2l0nexzZg4nGiQM1vrCfhBg6MN+b/SE4wqh3SOofXPWWi
         5JwFXiAFQ1J7i+wqHcpsUu4f61XBto2jAP/RNDyY7t6N9jw3AemR+pN5e6jwa02214bm
         Ug9cpn8B1jH+TK1UjDDzLPPe73yCvu2cz1MPYneBjzB3oPvxvCt4NdG40Lt8mtGD0sKs
         S+3GQZOKo3I2noLaYetrnhO9tS/ggECFHXW52xvSYEUDsPJdQaQ7S0nPSmtjSU5lqBfq
         X76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXFFTUALU/8aWUEnUkYb7ujeKf4ayBbE0A4maETvon8=;
        b=pKBR9WUjQdOgBJXF5trbLogcu3zrpmoJ3XKe1S50c7a4bSQZRTp7bYAYEW9yQxiaAE
         1JmP8DdPH6YdgkFPHVu4Gd+YZ1GzerM8Nh/YU1s6+FVQjz01tzCtLz4tkP9UGMDG+pkF
         F0hxjhsI5eNUeT+5v2MAVbA75KqD5HWP7qiN+ZonXdbs0SmdHZ+79JVx45tu5BbGR9Qr
         bMGeR/8atsl0xohcq3qpWzIX5DfXtUje8+eXKnRszhHlhy8laKNmZeDpbm/4w0aAbviL
         qA3NoVZoIUuiJPfkAVSaFzNGK//eg/dSWNmRChJxCaCI+Hh9SRG0SYaR/czSL70Y59ws
         LIhw==
X-Gm-Message-State: AOAM533gieAL8CPOzFotASGHAYTrSmUWJde0lVpiaLgh9NiGqYC8pqnO
        QscpqMV/RiJULla74ukJO76XVLkEK3iL4w==
X-Google-Smtp-Source: ABdhPJxTROx9nsAyFQ7ae8gf/7Cu+f3ib2hRsIHe7UuO8q8pr9uyJpczkViMPleFFqI8dD/6SsIxvA==
X-Received: by 2002:a05:6402:354a:b0:427:d0e1:8ef3 with SMTP id f10-20020a056402354a00b00427d0e18ef3mr6076134edd.66.1651560715209;
        Mon, 02 May 2022 23:51:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709070b1400b006f3ef214db8sm4246237ejl.30.2022.05.02.23.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:51:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: dmaengine: sprd: deprecate '#dma-channels'
Date:   Tue,  3 May 2022 08:51:45 +0200
Message-Id: <20220503065147.51728-2-krzysztof.kozlowski@linaro.org>
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

The generic property, used in most of the drivers and defined in generic
dma-common DT bindings, is 'dma-channels'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/sprd-dma.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
index adccea9941f1..c7e9b5fd50e7 100644
--- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
@@ -8,10 +8,13 @@ Required properties:
 - interrupts: Should contain one interrupt shared by all channel.
 - #dma-cells: must be <1>. Used to represent the number of integer
 	cells in the dmas property of client device.
-- #dma-channels : Number of DMA channels supported. Should be 32.
+- dma-channels : Number of DMA channels supported. Should be 32.
 - clock-names: Should contain the clock of the DMA controller.
 - clocks: Should contain a clock specifier for each entry in clock-names.
 
+Deprecated properties:
+- #dma-channels : Number of DMA channels supported. Should be 32.
+
 Example:
 
 Controller:
@@ -20,7 +23,7 @@ apdma: dma-controller@20100000 {
 	reg = <0x20100000 0x4000>;
 	interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 	#dma-cells = <1>;
-	#dma-channels = <32>;
+	dma-channels = <32>;
 	clock-names = "enable";
 	clocks = <&clk_ap_ahb_gates 5>;
 };
-- 
2.32.0

