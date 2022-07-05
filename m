Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7A567999
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiGEVwb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiGEVw3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:52:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A896A462
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r14so13594161wrg.1
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/fojUw0EeEcK+rqcJSp3I2q4GoLWZt/YWa+Regpf2w=;
        b=Jr18FWZSzSRSneVObsSjnVJxBEUXAHsbqU/4W10bboXeXN2L2pGC6VHQ4lgo/UBYrp
         J0CMP0GRKp8dUKbMzK9I1qdn1rq3wK26lnd4XTIQ0sX7h71LptFUbULc6iaAnW6WGhm/
         okjirNplhv/WA9IcoywKUcGHw+BXG46zwI2GDKyZOkmqjyOn04Z5BJhC7yJplgdtIB49
         wuTwK1SUud924+xRGcyrhru3Yn2If8/5ynnTC895rXmhv7F9KKS2ySwpJDiF/o/a0tk6
         AVZPaubBcC4eXqg35e2ngXfchcbpzRQnzCgaBYEME++JqIp0fl9txiaPCPAGuTEtjsUi
         YJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/fojUw0EeEcK+rqcJSp3I2q4GoLWZt/YWa+Regpf2w=;
        b=PHLriqTw4j0IjlwPYbzzON/q+M42qDmPmbliCO4wRJzMViTa5BUyHz7IarU5jX3XK6
         bi+TMlv6xh7OyRDoByEqRrJA9gfJe+DNe/Ug8/m2WcyeVLeAZnNGFq9jcA1ZFnf5ud5F
         jCDLhSficp4QD/jmqLF77xHvZtftQm4JJfH8BmWXFFPA60DH9nM5jgQXSU2iga6UucEY
         4jIrm8XexzIlmrN+NuV9CttO16QG0dOVluh36ljPbzU61YgjtVOAEBIZbotYXoJMr9d7
         oPsmzueohA5feC3jvHXT7s5s4zsuWlLdcisH+88CgBS02P4sZuKRQdJSY24/3I2/RrJl
         Na0A==
X-Gm-Message-State: AJIora9vk7j07cdZ/AiSOUSAvG+cBcLo1IHU3ip0iV3PueBktaSCmI7f
        +ARHC7X0lJEkm5MwykTt0wjDtw==
X-Google-Smtp-Source: AGRyM1tX5bERlh6TaveO6GrgyXdZI+WLqirgKBhUqp4y28CVn8caA9+OntupBTJIPlHx+MDpz9T9Gg==
X-Received: by 2002:a5d:5985:0:b0:21b:c74b:5a7 with SMTP id n5-20020a5d5985000000b0021bc74b05a7mr31952683wri.242.1657057946655;
        Tue, 05 Jul 2022 14:52:26 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:26 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 02/13] dt-bindings: display: ili9341: document canaan kd233's lcd
Date:   Tue,  5 Jul 2022 22:52:03 +0100
Message-Id: <20220705215213.1802496-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

The Canaan KD233 development board has a built in LCD.
Add a specific compatible for it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9341.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index c5571391ca28..99e0cb9440cf 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -24,6 +24,7 @@ properties:
           - adafruit,yx240qv29
           # ili9341 240*320 Color on stm32f429-disco board
           - st,sf-tc240t-9370-t
+          - canaan,kd233-tft
       - const: ilitek,ili9341
 
   reg: true
-- 
2.37.0

