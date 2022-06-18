Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC6550477
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiFRMcG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiFRMcF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 08:32:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9714D3F
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c21so8820565wrb.1
        for <dmaengine@vger.kernel.org>; Sat, 18 Jun 2022 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wA+ekkpjde0Zx9cXanks0YsUmdtDvWig/ia7r5xRwsg=;
        b=NLP+j4VvWO4pMdDxz+jP2qakHnxjIhWDW5IcIZ6iTjVuR6PvXGlfRvScvAs6fv4LGC
         tVHzVYgFUHCv1IRJ4Ht4KdNVLD+jSSS5h4H+avCrhP5W5KXZfsniSNzQaIy0Vmjf7cJe
         1JtCXoeodTgNGx3zxBouJNSTU+BRjTFYSAg0N4jBQrfeC5wyTPkZscKwWYLFzG+dbNUH
         VQDUJvWUJkk/fS8UHWuapx2oX/lVLREXGX91trMzLN+PvRD1VA55gaBikAJhJXd6EtNJ
         TXtuW3AI8LcIC7NdxtxNMfIR5WAfMQnhkZScOGuGAVa6FafYwFTfgLXwxWgUJlRmcjG8
         FuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wA+ekkpjde0Zx9cXanks0YsUmdtDvWig/ia7r5xRwsg=;
        b=QAACXNU+CJb5mxe5IN+hmjqzmhj2S/+h4Azef80+raNUPK++RTN3z3GkWoeAkb5fqs
         MtwoRMmXMvwnBY6Y2XmMjHRkWOnW5E1eBs4Uyk4mViExNYkYRhEtFTU4+mGuAfF58SL4
         KZ8FQeaT1kpFMwHpSbYR+SN+j6TqBl+P09RQFblzHAu/Vb9DV65h3TvaMEna5RSBCNhW
         hbL5GlNYsBjOxdV2E0YkSL/KWDCk9rgV7P81bcHW7B7igC95UQO0dzeApx1IukQEYmPO
         3Ox4+9wZgAh9ecX6WOsU4YhT2O/HqZnNOlIHc6sc7OVrNJGo53L1ufrBReP3UMF+ZxcN
         qyxQ==
X-Gm-Message-State: AJIora+APXdeyhvKd1yP7PEUVKtFezZjtZpThXSrafKat5pgTCKmKbT8
        +zva+nb4o3jWZk7W3QswPJEQrw==
X-Google-Smtp-Source: AGRyM1uabX5izdogY/5f2icOXRBDHwfiqcRqU22eeMbzZR7yfphBy2Stjoi6dvehhY38C8EymhY+dA==
X-Received: by 2002:adf:ef52:0:b0:21b:81e8:5d0b with SMTP id c18-20020adfef52000000b0021b81e85d0bmr6154762wrp.502.1655555522853;
        Sat, 18 Jun 2022 05:32:02 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:02 -0700 (PDT)
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
Subject: [PATCH 02/14] dt-bindings: display: panel: allow ilitek,ili9341 in isolation
Date:   Sat, 18 Jun 2022 13:30:24 +0100
Message-Id: <20220618123035.563070-3-mail@conchuod.ie>
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

The dt-binding for the ilitek,ili9341 does not allow it to be used as a
compatible in isolation. This generates a warning for the Canaan kd233
devicetree:
arch/riscv/boot/dts/canaan/canaan_kd233.dtb: panel@0: compatible:0: 'ilitek,ili9341' is not one of ['st,sf-tc240t-9370-t']
        From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
arch/riscv/boot/dts/canaan/canaan_kd233.dtb: panel@0: compatible: ['ilitek,ili9341'] is too short
        From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
Allow ilitek,ili9341 to be selected in isolation.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/display/panel/ilitek,ili9341.yaml     | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index 94ca92878434..c402bedaa37a 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -19,12 +19,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          # ili9341 240*320 Color on stm32f429-disco board
-          - st,sf-tc240t-9370-t
-          - adafruit,yx240qv29
-      - const: ilitek,ili9341
+    oneOf:
+      - items:
+          - const: ilitek,ili9341
+      - items:
+          - enum:
+              - st,sf-tc240t-9370-t
+              - adafruit,yx240qv29
+          - const: ilitek,ili9341
 
   reg: true
 
-- 
2.36.1

