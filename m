Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7AD603212
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 20:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJRSMn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJRSMm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 14:12:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0D72EFF;
        Tue, 18 Oct 2022 11:12:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u21so21708688edi.9;
        Tue, 18 Oct 2022 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzZ/0kJ25IZFQ+fXOgV6ivprSS9GGp5SkUxE38Mr8iA=;
        b=k8xt6iNp8AcFdSbK5TpAFwVfQGD8kzS1kC6Gr7mGPcM+PIz2oqR6qUL6anbtPwywAd
         inRlyMNZxNauWxt8LngR5DFaqBlfF7Z9rKvf6OAZ9nD9Xrlkq58jLV1zDlZU4s0hQ3z6
         pQttw5sQ2hJCrl/Kzn62nInyVt3dIk/kN2ES+GtEWQTP2jekrXNC1lDkF0QKwRPLikdH
         LVc1OQJxV7Fua6vrWqlvQlGIxX3IdiyqnV4PNIwmHC6GCRvqNjG8v9+nGKmEiwa/0EB5
         vBMlD6x0bmleit0GXufS3+lJlJWgMP6OIwzat7PKTQZ++B3dLjb5VU7ukxIFfBmTsiwp
         BLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzZ/0kJ25IZFQ+fXOgV6ivprSS9GGp5SkUxE38Mr8iA=;
        b=m5eUhsnXThzaJyw9gmbUUKUOQ9G5W8eTijk+uwMSP31G5pSRCE6zf7HMtI32JC2CVy
         A1yFC6bB49wIiFCCJvGDtwpUf+VJLkaL1tsnyHCv42rjVSnzhZxfiFwR/wbOqhpppBPd
         deACfY8jEprfByVKvOKZZAshBBHmZLaNHDEP1gavvnLy/Yd0RQEfqwU4by81g68n8coM
         qITdAF6PfrTicYnS1J0fTHDftet8omqg6PIvARlwXploorQhb1wnBytulv+HDbd+e1SF
         HyPhfRlCzq1GzdsFouJ2TRRTpIlaytMzQwe+TDBTDQ8wghcLwII/4k/hcs4fDvnqvfA1
         Lojw==
X-Gm-Message-State: ACrzQf1BV3IVs7V14ihFegMDIpKDXfEdG9pfuVDI6KS+tW3Y29goxSvf
        1qaPJv13/m6s4Gv4ItjNOMU=
X-Google-Smtp-Source: AMsMyM7khN6IDOMf/4HA4PpsYLo3zP45OqH+nan1ktNTyRT+c7HkNuqf5tCA174m4vWjqOaixElq8Q==
X-Received: by 2002:aa7:c98d:0:b0:45c:6451:320e with SMTP id c13-20020aa7c98d000000b0045c6451320emr3809315edt.172.1666116760660;
        Tue, 18 Oct 2022 11:12:40 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-1-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.1.39])
        by smtp.gmail.com with ESMTPSA id u22-20020a056402111600b00458dc7e8ecasm9253043edv.72.2022.10.18.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:12:40 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: ingenic: Add support for the JZ4755 dmaengine
Date:   Tue, 18 Oct 2022 21:12:18 +0300
Message-Id: <20221018181219.3251309-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221018181219.3251309-1-lis8215@gmail.com>
References: <20221018181219.3251309-1-lis8215@gmail.com>
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

Update documentation prior to adding driver changes.

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

