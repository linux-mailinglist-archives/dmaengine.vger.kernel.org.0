Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928F3550494
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiFRMcS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 08:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiFRMcL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 08:32:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C271DA53
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v14so8802310wra.5
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xc3yLaPJl3fJMhU7mLPNTXUDP5YmMspTrPH6skgYH5k=;
        b=WWI5aigpx63NXABwWobIVtxzeWyDWABcTlqhEd7p5galGx1leb4l0QUX6DRW4V7R2/
         7tCNkKvAuMxDi861SOauKvR8OiOrKRFQWKbf/UOyK4ZoNWlOxvSKeVmw3Pjw/ViKSDBb
         bJGQhxOX2sak4JARX2cUY3oHghGpdM5DQO1bngmpG9k9r1Q9YO+8El+G/rDrBCypfz88
         jYj4Hwbu5WXw7XC7sEypXuV849AqQEAwqdgU0LsiCYfp++8WMxNxdrDQLMOhAiSs1NIp
         AxnI+k8juFNCyik85P9Aotl91uS4CXhVavQDoNI3Z5E9qqRGU5RemiTnsiZNhX6+GfbW
         +y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xc3yLaPJl3fJMhU7mLPNTXUDP5YmMspTrPH6skgYH5k=;
        b=7gYma4ZK2hvjxuoAjimQ9PHFi4kZ9Q98WsVZp3oov1nV5hyqcKFT7uQRBPC6uu+9Km
         aOzWztAdYdEyNFdqO2fieF103aAtu/iY7XYk1ovpb9/CnhKc/DUiLQELEv/H5Y/3MKBO
         2dQ/TShnyYPnSexDp8mVWIqQ4lrrBkSTjgZgjcOO0j/bedfrpz9bNZ9+Dx4FTMESfz/n
         BqOKSMjFFzuxtJl4fk73iUYKPe5OK8tkMfIW+AYWIivyGzVtp6A9LrLgmvu380i8wsba
         Sx3TArLN/MUnlZFcdUjmML/hKC+m5yDkST2ie7Mm1xH1pwF5embanwpKKxExtuTT7c3o
         edXw==
X-Gm-Message-State: AJIora+7XpDm5Htisp7NjC/CMJpM1InoI0IVCXfbHNGhyX3dsg0xIrO4
        wT+sIEpoRWolFz7KSgnrHvGr0A==
X-Google-Smtp-Source: AGRyM1vjUOgV8azxYb57OQztWrqMQYhc0lprasxXMnlkIZhmfHP3nu/9sasVI2/ycyhjwJt5Z7ma0Q==
X-Received: by 2002:a05:6000:1789:b0:219:2aa8:7159 with SMTP id e9-20020a056000178900b002192aa87159mr13617696wrg.474.1655555529797;
        Sat, 18 Jun 2022 05:32:09 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:09 -0700 (PDT)
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
Subject: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update spi-{r,t}x-bus-width for dwc-ssi
Date:   Sat, 18 Jun 2022 13:30:28 +0100
Message-Id: <20220618123035.563070-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618123035.563070-1-mail@conchuod.ie>
References: <20220618123035.563070-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
this.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index e25d44c218f2..f2b9e3f062cd 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -135,19 +135,41 @@ properties:
       of the designware controller, and the upper limit is also subject to
       controller configuration.
 
-patternProperties:
-  "^.*@[0-9a-f]+$":
-    type: object
-    properties:
-      reg:
-        minimum: 0
-        maximum: 3
-
-      spi-rx-bus-width:
-        const: 1
-
-      spi-tx-bus-width:
-        const: 1
+if:
+  properties:
+    compatible:
+      contains:
+        const: snps,dwc-ssi-1.01a
+
+then:
+  patternProperties:
+    "^.*@[0-9a-f]+$":
+      type: object
+      properties:
+        reg:
+          minimum: 0
+          maximum: 3
+
+        spi-rx-bus-width:
+          const: 4
+
+        spi-tx-bus-width:
+          const: 4
+
+else:
+  patternProperties:
+    "^.*@[0-9a-f]+$":
+      type: object
+      properties:
+        reg:
+          minimum: 0
+          maximum: 3
+
+        spi-rx-bus-width:
+          const: 1
+
+        spi-tx-bus-width:
+          const: 1
 
 unevaluatedProperties: false
 
-- 
2.36.1

