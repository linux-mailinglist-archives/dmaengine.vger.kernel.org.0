Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F26039ED
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 08:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJSGka (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 02:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJSGkL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 02:40:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614F814D25;
        Tue, 18 Oct 2022 23:39:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so37243231ejc.4;
        Tue, 18 Oct 2022 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzZ/0kJ25IZFQ+fXOgV6ivprSS9GGp5SkUxE38Mr8iA=;
        b=m/L/QUe9BT9Bx6rjulcvTeel7RT82sBotg2IWuC8/omI0b/k3xnEGLTvkR6M5ZN8vv
         M0MzO83iNJuzy7YulBWxv7FuZge7RhJdg8/0yiWsa7iZAlN/qkDoEOC8RZhnEmWZvjHt
         dT17Vq0L4v8IWbIr9bjmOv+sFuzqa8ZIRJZMFNPLLI8tSQ822vKQVZtYW86DUlW2tI4B
         uBJ1Hi0bIMuVwuCIqAHvhKjVAbH9vXY1JNctAvUXLqqnH3HhhXd8fGHNfvQS+hHk4PEY
         pyZzH2BGfrEU4c84BgnyFq12VJ8lMOvq6n2GFnOux5CT/E7LLblDG5m+4dLiiy4BR/fp
         WQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzZ/0kJ25IZFQ+fXOgV6ivprSS9GGp5SkUxE38Mr8iA=;
        b=6WHMCvJBxUx757+JinFllA7vgybfA1cfv5mFA59kb1VH/Ox67ANd95V/eAObv+k4Jp
         HDgwJi6ka1TYWoULU8kXa8rziq90cL8xt+U2Q4nTrWJYy2vr9QpsTtyZYQj+OVSETBlw
         AFMSdU5TrzCMw8mSVxFlvcafDYms0TqUihdGekrNd+Ft0pqtXtqvE8RlbiIRpO/FEXGu
         xbDgNKuHved4jFOhqsIr9sFRzwgG9gCQQ9UOUfJkQPHEvhodc9xiFcGS1ClXzY+5wPAA
         fRgMJnP1WRuJwF3wj4hty+V9qsVea+ioAooGYZdyJg499EMgcwlBuskXOXjEopGHu5lz
         G9ig==
X-Gm-Message-State: ACrzQf3EqpnQqX5m+ObCO5pP1LyZlPkmRXIvtGrNX7cEGypHZMh1mmWy
        Uf0O2dbwAnOcnAALsiqIYMpJgWSCkTt+uQ==
X-Google-Smtp-Source: AMsMyM4ngi5sZCNuH4gIjBYEUamjjffCUGLF7/XehIS4LgCEkXFfNeEJ2PvjMxVWoGs3h65Pyx/PnQ==
X-Received: by 2002:a17:907:d04:b0:76e:e208:27ba with SMTP id gn4-20020a1709070d0400b0076ee20827bamr5632131ejc.652.1666161583511;
        Tue, 18 Oct 2022 23:39:43 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-4-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.4.39])
        by smtp.gmail.com with ESMTPSA id fy19-20020a170906b7d300b00781dbdb292asm8467168ejb.155.2022.10.18.23.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:39:43 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: ingenic: Add support for the JZ4755 dmaengine
Date:   Wed, 19 Oct 2022 09:39:33 +0300
Message-Id: <20221019063934.3278444-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221019063934.3278444-1-lis8215@gmail.com>
References: <20221019063934.3278444-1-lis8215@gmail.com>
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

