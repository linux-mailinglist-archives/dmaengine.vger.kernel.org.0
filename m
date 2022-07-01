Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631CF5639DC
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 21:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiGATYE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGATYD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 15:24:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216B13FA4;
        Fri,  1 Jul 2022 12:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68B5CCE34E4;
        Fri,  1 Jul 2022 19:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518B6C385A2;
        Fri,  1 Jul 2022 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656703439;
        bh=5IRTSJGvFO4OHAMn+9sgGglU08Ime9shNTeY7wLOS4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrIL0NFFH8GvPv14X6eBnhKCVhPnGfzzX07lePmAewtmHaPeitZxlRu5IOvEN8SlI
         7G4EMoPHK8/OJfdGHElOOxvxKtHEGBTh//armumSOFz9SgygpEPyYZyqI3WB/e7umc
         AAIAZGIRKQ2ob/9ffk+5nMiI1uo9wHVqrT5J0L2sEEGf1q+qs3x0O8h7KlkxhudyOh
         xrIjmbssGpN0IuOXCgIgIzdSs3GD8enEK0Fj8RMS0uHS0tuu0OEkdYsa+XsIJHziFr
         94Tt4K0kSGITB4vKyoCbTjhgRa3Lnz3LfdtzLexUetgtpQS8PsXArIyYWSE7rBcfEz
         Fb1GAc9SDJGTg==
From:   Conor Dooley <conor@kernel.org>
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
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 04/14] dt-bindings: dma: dw-axi-dmac: extend the number of interrupts
Date:   Fri,  1 Jul 2022 20:22:50 +0100
Message-Id: <20220701192300.2293643-5-conor@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220701192300.2293643-1-conor@kernel.org>
References: <20220701192300.2293643-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 4324a94b26b2..98c2ab18d04f 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -34,7 +34,12 @@ properties:
       - const: axidma_apb_regs
 
   interrupts:
-    maxItems: 1
+    description: |
+      If the IP-core synthesis parameter DMAX_INTR_IO_TYPE is set to 1, this
+      will be per-channel interrupts. Otherwise, this is a single combined IRQ
+      for all channels.
+    minItems: 1
+    maxItems: 8
 
   clocks:
     items:
-- 
2.37.0

