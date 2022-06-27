Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5313055D405
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiF0Tlp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiF0Tl2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 15:41:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A217A82
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2265810wmb.3
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzCNuZqg5sJhSSZ4d8it+v4YJ89K4kJOhMYbzqau3T0=;
        b=cUa3Qgj83LJO9FwTx4+4xOL790JLFgJuhmgrSJi2YTyi4TgZ3QHn23OZlSeP4eGr4a
         +enZvFjacedK5hJJSmGuCcyBjxh6MEKPUZcAKWykCCkkzvwUXNfJsUoFjLQwQryYFGEJ
         SEbmehS1/iTbEmVVTU2q3WXprQHUDo8Yv+5IRCY/CL6szKGQQ7BpxVYKxwivyntZnwWp
         5Xv8KR8mPYL/SOmWZuX8ct7NDa7Xzt9ST4L4cgfrh9H9lYDK+db/7RreYUhPECg4PNpK
         JaGXGh00MEhhzcMG33inGWEsNDk9YWUpGPQgCmkOL0K2m2AjTH2Zi02b+cHy0MmqI0tK
         MzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzCNuZqg5sJhSSZ4d8it+v4YJ89K4kJOhMYbzqau3T0=;
        b=PhCgn0d7VfNKrFzNmg2kLCYuv2W7xYhX9POs8WJdORBziGajQUmWPYkLjT9dWmj6sJ
         XKaBi2HpLvnjSiGjDDkUyI0PAGmhyW62Vr5n87HkEeCS/lfXhlxlnApsz3xTVE+2rCVV
         /yhZcQzmKIHoDdzJaaC07MrgzG2/uzfj44hLwJjDQhItPaA/rhq2+rJCNxb+gWeVfzRw
         sviFsEEgYd9JGZS+mMXc+Hfoq/3to1MQP3WONYeQpIhBRXutJZ89WkVKiipz25y0oueD
         qJlnIhha7pn3EgJapKQBd1llzY2O4LbHxXXGYG2iYkevj246oGs/zDw8sn67qRJYl11I
         qdxw==
X-Gm-Message-State: AJIora8M63I2xU3wSmX7qxQ8RSR1FB92ERwCgBWG1Rmq3qQL9ojJafuk
        yqOHr12u0UHsZGrmYa3u8/AmVA==
X-Google-Smtp-Source: AGRyM1t6tJJ0mxAtUsYUzthMYkrnacnVvnK447unbGgsisXeL7ZGVx2xR03CLUvVfWRC838snmZcVA==
X-Received: by 2002:a1c:4b05:0:b0:3a0:32df:533 with SMTP id y5-20020a1c4b05000000b003a032df0533mr22012475wma.155.1656358885670;
        Mon, 27 Jun 2022 12:41:25 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:25 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 06/16] dt-bindings: timer: add Canaan k210 to Synopsys DesignWare timer
Date:   Mon, 27 Jun 2022 20:39:54 +0100
Message-Id: <20220627194003.2395484-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
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

The Canaan k210 apparently has a Sysnopsys Designware timer but
according to the documentation & devicetree it has 2 interrupts rather
than the standard one. Add a custom compatible that supports the 2
interrupt configuration and falls back to the standard binding (which
is currently the one in use in the devicetree entry).

Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/timer/snps,dw-apb-timer.yaml     | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
index d33c9205a909..9a76acc7a66f 100644
--- a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
@@ -12,6 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: canaan,k210-apb-timer
+          - const: snps,dw-apb-timer
       - const: snps,dw-apb-timer
       - enum:
           - snps,dw-apb-timer-sp
@@ -21,9 +24,6 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
-
   resets:
     maxItems: 1
 
@@ -41,7 +41,23 @@ properties:
 
   clock-frequency: true
 
-additionalProperties: false
+unevaluatedProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: canaan,k210-apb-timer
+
+then:
+  properties:
+    interrupts:
+      maxItems: 2
+
+else:
+  properties:
+    interrupts:
+      maxItems: 1
 
 required:
   - compatible
@@ -60,8 +76,8 @@ oneOf:
 examples:
   - |
     timer@ffe00000 {
-      compatible = "snps,dw-apb-timer";
-      interrupts = <0 170 4>;
+      compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
+      interrupts = <0 170 4>, <0 170 4>;
       reg = <0xffe00000 0x1000>;
       clocks = <&timer_clk>, <&timer_pclk>;
       clock-names = "timer", "pclk";
-- 
2.36.1

