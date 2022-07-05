Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9BA567994
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiGEVwd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiGEVwa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:52:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AE315FD6
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h17so6232547wrx.0
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bn7NMU6i2JipaHjilcDVj2dVJzF0Mozbq5+lea1OdzA=;
        b=Slkpsl7r9Kp451ZNey0oEZzxjuQF0suIIjxL9cZ2NQwn/t1lFAU9Tnh+suky4eMS1h
         YUmFPg8cYA3FAofnfJJV8ocNpuN2u1BAa+fQ35PTOkwttnxQ1zDR1Qc8de64sYsXnBUH
         ajLI4JkOsiOJ4FmFcWefB6nrvs/7GyrBRKYz+6/eOYVP/BE+xSu4DAnMoA7m08+pWwaW
         ELJHDcXeFjTZU4OrOCwONiswxxTNfceAQzWy+UcN47rs6g67curC4Asuc1MmU70KlF/V
         nasOCrdsJTNHCfg3y67UHtpYybbM7aKBZTTjA/5NNdVuWhbOCRNbKDRc0WOCbLp1OcZd
         jA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bn7NMU6i2JipaHjilcDVj2dVJzF0Mozbq5+lea1OdzA=;
        b=CLVFWSS4HN9o7yJyxxC6EqsCO4120fF33xATPczGfTsqnLt69tohC3gkWo+Rbt4oME
         R7IQzyiI95n3lF6HlYnKgeeTVIAm/XYfIxlu9Lwqv1QbwYljKgnFqdyCI+s+82HYlwJ9
         wMMH2YD9T/kohqLyowdjg68EoV7Wow48g0cBXIIR4P+lhOsj4FmMzICaEPaNy6inw1v1
         CHBP22ZNvaDuEbiJbkCKsZfsTAE5LDKljgSKbMFpxEJArDW/1OLQK0yJMWqLWfzMpuM/
         vu8vIOvvHbPIggkyG/4LG5Mwew9KqcRnr0YpVzYbq9tKnW1OvJO6g3fWuFgfeeFaG7WG
         RSog==
X-Gm-Message-State: AJIora/Bn7IZLo+bhQ5rmBABAZ3dfZlvFsyBGwXCZXYwT9HgB26OsLBd
        lLEZEg15tUu8D7HIs0XU/2mBEQ==
X-Google-Smtp-Source: AGRyM1uDlF2/DUTmOv95q9ml3VpkOLRHZuDe6OmNqYM6t+SWDXd/DCAq3Jod5QPF4ItOmxcBKE2/jA==
X-Received: by 2002:a05:6000:1888:b0:21c:9a16:5cdd with SMTP id a8-20020a056000188800b0021c9a165cddmr34342146wri.562.1657057948113;
        Tue, 05 Jul 2022 14:52:28 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:27 -0700 (PDT)
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
Subject: [PATCH v5 03/13] dt-bindings: dma: dw-axi-dmac: extend the number of interrupts
Date:   Tue,  5 Jul 2022 22:52:04 +0100
Message-Id: <20220705215213.1802496-4-mail@conchuod.ie>
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

The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
controller, but according to the documentation & devicetree it has 6
interrupts rather than the standard one. Support the 6 interrupt
configuration by unconditionally extending the binding to a maximum of
8 per-channel interrupts thereby matching the number of possible
channels.

Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 51
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 4324a94b26b2..67aa7bb6d36a 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -34,7 +34,12 @@ properties:
       - const: axidma_apb_regs
 
   interrupts:
-    maxItems: 1
+    description:
+      If the IP-core synthesis parameter DMAX_INTR_IO_TYPE is set to 1, this
+      will be per-channel interrupts. Otherwise, this is a single combined IRQ
+      for all channels.
+    minItems: 1
+    maxItems: 8
 
   clocks:
     items:
-- 
2.37.0

