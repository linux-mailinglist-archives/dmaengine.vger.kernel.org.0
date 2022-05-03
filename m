Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441E1517DDF
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiECG6T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiECG6K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 02:58:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782EE2183F
        for <dmaengine@vger.kernel.org>; Mon,  2 May 2022 23:54:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a1so18846559edt.3
        for <dmaengine@vger.kernel.org>; Mon, 02 May 2022 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbr9VzhYtH1KQia9kQjc/iWRHBu+/GHX1fXDlV9Qp10=;
        b=taH+615Te3bYmh19ehO9DwAHEfYNduM3QpunHXljirkjB/R++x6QkiMV4/97GeXsz5
         aT7dZuryJ4H9UYWq7HEB6uz5SWwDAD4v8NUrRjkFf4m04IEFewxerdw7SvtTiuyOill9
         bfE/9KS1edAbUp4yyUUyZuE47t6cve45RcHOg+jJ9dZRw9aHTFG5UJSTlNnbxYfrohyx
         JH67v2H9zegyf3N8BpF0+EfRTgynQZg76uoFd7CQSNdGbBmGW1pZsb1gDpwFXrec3Cpn
         BdUZzeFehPWxpYUNf5MThdarjRW272ar8wnffWIRwLGXqun26xkCKO8NWmqhf4oCXXCf
         ZsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbr9VzhYtH1KQia9kQjc/iWRHBu+/GHX1fXDlV9Qp10=;
        b=4evpAWyOKbjllw8giFVJ1gv/c+lVcR4ZiJ5blaq2qPPcpbIkQDVSFkc3KAtJAZlZ3Y
         5/L22IGrl8k+QAkj48mE5XVJtIbcZIqJsNY5bHhF8OXroi+3bQvn2GOEuPA5bktWYBTX
         /0+eA11Lq1DRc6m96QBPsjkfGgeKrf67KWrLIvYrjZGNK041HlR/xnaWg30VWeKoTc7w
         K75YlPcha8bVHoVIgsik9IT4/9wIPlLLtWhJFDZbMMNnKQo1MRRGpulXJBbStLss35/p
         PksvdIi5U+3q7A5YiTklP0ukCg9W9Tnu6yT7xDmn62DzUpwg0YJn5kKYU09X/qFv2eQY
         vIig==
X-Gm-Message-State: AOAM532J5bT1mKSJxoabFvLt3HIuj/UD1qfnlM3kUB4xpkrYQupPj5vX
        L9yFoFHBaP5MKezEUa3g/z+LFw==
X-Google-Smtp-Source: ABdhPJyuiSY1Y+8unsHjhPEOleQKUh9CluUqqJLDo59OOwbpWvojeb6rDWDCTfNn4Lq2qaa99AOi5A==
X-Received: by 2002:a05:6402:2792:b0:427:e39b:f396 with SMTP id b18-20020a056402279200b00427e39bf396mr1899811ede.226.1651560851962;
        Mon, 02 May 2022 23:54:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0042617ba6396sm7565326edr.32.2022.05.02.23.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:54:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: dmaengine: mmp: deprecate '#dma-channels' and '#dma-requests'
Date:   Tue,  3 May 2022 08:54:04 +0200
Message-Id: <20220503065407.52188-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
References: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
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

The generic properties, used in most of the drivers and defined in
generic dma-common DT bindings, are 'dma-channels' and 'dma-requests'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/mmp-dma.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
index 8f7364a7b349..ec18bf0a802a 100644
--- a/Documentation/devicetree/bindings/dma/mmp-dma.txt
+++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
@@ -10,10 +10,12 @@ Required properties:
 		or one irq for pdma device
 
 Optional properties:
-- #dma-channels: Number of DMA channels supported by the controller (defaults
+- dma-channels: Number of DMA channels supported by the controller (defaults
   to 32 when not specified)
-- #dma-requests: Number of DMA requestor lines supported by the controller
+- #dma-channels: deprecated
+- dma-requests: Number of DMA requestor lines supported by the controller
   (defaults to 32 when not specified)
+- #dma-requests: deprecated
 
 "marvell,pdma-1.0"
 Used platforms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
@@ -33,7 +35,7 @@ pdma: dma-controller@d4000000 {
 	      reg = <0xd4000000 0x10000>;
 	      interrupts = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>;
 	      interrupt-parent = <&intcmux32>;
-	      #dma-channels = <16>;
+	      dma-channels = <16>;
       };
 
 /*
@@ -45,7 +47,7 @@ pdma: dma-controller@d4000000 {
 	      compatible = "marvell,pdma-1.0";
 	      reg = <0xd4000000 0x10000>;
 	      interrupts = <47>;
-	      #dma-channels = <16>;
+	      dma-channels = <16>;
       };
 
 
-- 
2.32.0

