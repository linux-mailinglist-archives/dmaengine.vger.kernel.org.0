Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B559E600076
	for <lists+dmaengine@lfdr.de>; Sun, 16 Oct 2022 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJPPNm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Oct 2022 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJPPNl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Oct 2022 11:13:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57198317EE;
        Sun, 16 Oct 2022 08:13:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s2so12886376edd.2;
        Sun, 16 Oct 2022 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEloXwBPQTOedM4DLcY3IOyF8FmsTUScb2vDbAYT/NM=;
        b=YEm9ni7PVpFNwHuyU353T8Xplmw16Fde4tPVB0MIPraLB1e8iarlUqrv/if931TSAg
         MbGPVDnbJ3gDaJBO4JSDOhQdiItL95tnjqm0U+2C4kck2bADWGLyz8ubMVLQdjD6HMZH
         kUb85FvLo6aYiwe9aPnbrgMr3q6i6Nj4sFAcgqn1rFCYgSaUOHgjlktf4EJWJMzt/HB1
         P57DN3/x+NdY652oT23ad1JfgWuwx2hMfPF3DECVIjDP0HYRtfwOJizeUXMvsfXp88hn
         RVlTwU7FSWK+es4fyLnc8BESs9+uZMe7ByqvE8XQ8ETVhEcOKz2pNkA2bbg3IDUdacEY
         CigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEloXwBPQTOedM4DLcY3IOyF8FmsTUScb2vDbAYT/NM=;
        b=IYrP494SR8+MMVK4ppn4XO3H6ygfHSKz7Pfp7BOXTAyQNhOMibaYhLK2P2GqrKrR7m
         hrvRJgnlbyAsNiKH8IHasedriEXEvcQQAcCevdxalQrhhS8ShyEIFaePw2UmbFgqFHNY
         9CDNskO5pddSRvLWGMqIYq2a/Sxf5klg7TiL0ciSRd9wbeerchRRg1niU+rbbSiXN0vC
         QhcFJGnaj5GoWU9oV9jzQOJWP6yLzdnXxP+eMVlSwV78yfL2QmfLa9EqlmnQ75KdSkvf
         npl1jiy8ofA3COmREBGhSy4xFd9whGNL4goO7fgIDGGLMOGcmTxleFyaStSNsa4cOU02
         MYFA==
X-Gm-Message-State: ACrzQf342NxYxtxu2lBctYFEDGE4ABToL+07KXnTe7M+AdzE2n9VfNaQ
        xkN2deekX+2qWhMCDQjzOK/a2P32DX7UUQ==
X-Google-Smtp-Source: AMsMyM4sc7Ud02+QTmTS+wL+YqS6rMlbrZe6uTF99Vk0q6BzkH2bI9uIbu4aVZW3oA0MQ9lJRY5nhw==
X-Received: by 2002:aa7:cd74:0:b0:45c:78fb:1d89 with SMTP id ca20-20020aa7cd74000000b0045c78fb1d89mr6329789edb.87.1665933218965;
        Sun, 16 Oct 2022 08:13:38 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id i8-20020a1709061e4800b0078d4c72e2cesm4702735ejj.44.2022.10.16.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:13:38 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: ingenic: Add support for the JZ4755 dmaengine
Date:   Sun, 16 Oct 2022 18:12:55 +0300
Message-Id: <20221016151256.3021729-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016151256.3021729-1-lis8215@gmail.com>
References: <20221016151256.3021729-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/devicetree/bindings/dma/ingenic,dma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
index 3b0b3b919..e42b8ce94 100644
--- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
+++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - ingenic,jz4740-dma
           - ingenic,jz4725b-dma
+          - ingenic,jz4755-dma
           - ingenic,jz4760-dma
           - ingenic,jz4760-bdma
           - ingenic,jz4760-mdma
-- 
2.36.1

