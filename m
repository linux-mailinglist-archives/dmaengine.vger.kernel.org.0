Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA99539259
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345122AbiEaNvu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344979AbiEaNvb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 09:51:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C386C986DD
        for <dmaengine@vger.kernel.org>; Tue, 31 May 2022 06:50:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f7-20020a1c3807000000b0039c1a10507fso1225639wma.1
        for <dmaengine@vger.kernel.org>; Tue, 31 May 2022 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl0eUhfQkf22AJDmTLSjt67Vrs4AO/BddtK22iFmA/I=;
        b=YZO96mhcYG0MG87d8UPaolLiT4EBhzbYR+2tvzycFKH95/lqHD4Jvzk66jQVmww9GM
         Kfuya/cPBUoxIoak9XlXW8H5NmofpLD8gqIUsA33sVyo/Yuc72GVVUFaMBT1tI9z/EKt
         NS0T+fZwjd0jYvUswsjsKudEOEmH7IyunZjW0vI6BwdFL1QiOfrQQQndMC6y+6yEGjoo
         WUJ3xntSihv5qvWX5bY6EsT4t/XTIGneUSkxDd+JFVeUG0kyU5v35dRrRxEPhkSvKohE
         Q/wmLZ/0Dfhgbn0UZjwaY0AWfzaLcCmgbdayY/VxweaTPGhE8DjhUj3npWKQfucbxM0R
         2K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl0eUhfQkf22AJDmTLSjt67Vrs4AO/BddtK22iFmA/I=;
        b=R2juDfHOP3fMI/vfDl/O0QybvjRkk3h42ihFoTYNSm+ujQE4vJysML0uuUtQVrNUcr
         FWmyJdlCfNHDkZldniInsHID7looX9sByyIrdCoLGNR0AXYM6pPAgRQoCe5a0kIU6z9f
         ZlSu/dW4c4tIi+QJo158wxXL0iP6A7G7xEcKiZ7r8Hzp7M7/tX6ERdnhGWJdP5ms7OXm
         s4Wl3v80ovb1XcWP82gNLLSSJAVjyhYB9ADmmCrwpoE2gLmj2ngblmgxOjEs/0JMWvgK
         fftYxwTUW1r0T5ggOkcEkGAhvF+yqcmjFgaugnCwVNlQ7D5pp2m1J7wFh9vr+j6XOblK
         rh/w==
X-Gm-Message-State: AOAM532ZHWfk45jG+Patv7BkqKsN9/WD9e5sHndOIaSyw4zrbcx8F+x8
        p6e57NT/l2NomEK8GE0ILLj9OA==
X-Google-Smtp-Source: ABdhPJzY1EA1gKYAjC0/wFLQ8zOis9WUaThFryPbsCAa6HYcRuwOQnBjCPCWIyToQh8i4anN2+EsDQ==
X-Received: by 2002:a05:600c:2182:b0:397:58f5:c6cf with SMTP id e2-20020a05600c218200b0039758f5c6cfmr23289080wme.86.1654005057059;
        Tue, 31 May 2022 06:50:57 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:56 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 10/17] dt-bindings: serial: mediatek: add MT8365 bindings
Date:   Tue, 31 May 2022 15:50:19 +0200
Message-Id: <20220531135026.238475-11-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 4ff27d6d4d5b..71e78f285e47 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -44,6 +44,7 @@ properties:
               - mediatek,mt8186-uart
               - mediatek,mt8192-uart
               - mediatek,mt8195-uart
+              - mediatek,mt8365-uart
               - mediatek,mt8516-uart
           - const: mediatek,mt6577-uart
 
-- 
2.36.1

