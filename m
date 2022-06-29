Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A771D560970
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 20:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiF2Sow (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiF2Sot (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 14:44:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F525296
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q9so23798097wrd.8
        for <dmaengine@vger.kernel.org>; Wed, 29 Jun 2022 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPbPYlymephNVmTF4XMmqzgSP29N1hKW0nY3OhQ8kt4=;
        b=bIL3O+08jSafbGtb7U08BFLv6ancGGHOyy8t0PuyztZ0247LnqujD+WEk1rMsOM5Hz
         x4rbXKhptTq9voYY62GNR7QzTopeKEUDk0JivS1uwsBcjxPN2n/CXBB4IOSdhPCdVN30
         iF4DDu2c2NUkBuOkWAkNrx+XHLu5HWbytieuTXQ6YOIsvbQ3CRlZuDbN/QNvkIFSLxZj
         KsKxVsL/5aI2KP2l0tOnjXqGzGAaXjkz+ia9erDlkqPPUZmRGN65QSlMuzTTewm+GZuH
         ISKmZiEQbwwDDwl11tRKVMC2d29J4mdLuNUJQ9OcdhM2RVwpRHFZFcpIHcUw/K+zE38G
         XLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPbPYlymephNVmTF4XMmqzgSP29N1hKW0nY3OhQ8kt4=;
        b=pDhhlMhYiqAbV8gu7LlirPORvSLaGpLDbzpRLK+oAy0SIklplJ/xMK/HOQE23A8l7g
         P6SvcjPlB2Kj8+uNe6z78uYC269F0/pyj6LqH4k6Z1nWi42aWEFLvNJhRP5f/a/Thddl
         1L9kESEISRkW1GTTWlt2DPK/Kfs7lOx0AdxT8fs+LGMOeEIpG3yfDcGLhdgucAyFSTd6
         tfKYVTDls22U7529yhl2CjCJGMsMq+mH0fdBBBUCG24+1NwThkTZGgGn8yy1qjlshsZB
         fPyyatG5wjz1mvP9EAPeoPHPRpxOp1ItiWw7F/pAhLLOUZD7J6bX9+5ixAcBDeBRRGFT
         tKbg==
X-Gm-Message-State: AJIora+5Izt5lQ8HRJ2WOKGcnhAQt6U4kl6Xl+Zy9DuTYRvRuiZEBnW0
        XPSUENWhbyuWyNsLPs++BeULXQ==
X-Google-Smtp-Source: AGRyM1thyJi31gfTX2uVAqIx3UeLhb+ISWNyFKRvah2HDTfAAbgqaVsuL5zuItNJWE1qpvCtHqQqvg==
X-Received: by 2002:a05:6000:1446:b0:21d:2245:ab65 with SMTP id v6-20020a056000144600b0021d2245ab65mr4552665wrx.315.1656528287443;
        Wed, 29 Jun 2022 11:44:47 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:46 -0700 (PDT)
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
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 07/15] riscv: dts: canaan: fix the k210's memory node
Date:   Wed, 29 Jun 2022 19:43:36 +0100
Message-Id: <20220629184343.3438856-8-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
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

The k210 U-Boot port has been using the clocks defined in the
devicetree to bring up the board's SRAM, but this violates the
dt-schema. As such, move the clocks to a dedicated node with
the same compatible string. The regs property does not fit in
either node, so is replaced by comments.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 44d338514761..cd4eae82d8b2 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -69,11 +69,13 @@ cpu1_intc: interrupt-controller {
 
 	sram: memory@80000000 {
 		device_type = "memory";
+		reg = <0x80000000 0x400000>, /* sram0 4 MiB */
+		      <0x80400000 0x200000>, /* sram1 2 MiB */
+		      <0x80600000 0x200000>; /* aisram 2 MiB */
+	};
+
+	sram_controller: memory-controller {
 		compatible = "canaan,k210-sram";
-		reg = <0x80000000 0x400000>,
-		      <0x80400000 0x200000>,
-		      <0x80600000 0x200000>;
-		reg-names = "sram0", "sram1", "aisram";
 		clocks = <&sysclk K210_CLK_SRAM0>,
 			 <&sysclk K210_CLK_SRAM1>,
 			 <&sysclk K210_CLK_AI>;
-- 
2.36.1

