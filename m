Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E34AB548
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 07:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiBGG4N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 01:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiBGGbR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 01:31:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42645C043189
        for <dmaengine@vger.kernel.org>; Sun,  6 Feb 2022 22:30:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id qe15so2291307pjb.3
        for <dmaengine@vger.kernel.org>; Sun, 06 Feb 2022 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3fmm4nvalmQleWa1byPzKYwRMYCW7Pxtk8Gk5epwAE=;
        b=Mev+fmMrEndOiPaIwMiostWKbCgoFUolVWzZCS5uUOeb6YzZKZEj6A9J+rHrqQqR1b
         FfCWf6jS25cRBOHFXTGitsymEc26oKLYlLLr4D4R0sNOup6+y6vzmEnPUbVKelaVdhFg
         F03jL7I3xrKN6prjd7rT616gqxvZcctqtMaWnyXsuQNlrEkD/GbYCOXrEZfqeuDGJh9+
         oFz365NpbqYAz4kSJOv6L1wQBP8D7yXOe8Unverh0JpEvOQvoMIA0+i3rH4v57fyrLOf
         Ps15s79JTNhaF4VRgNZYkbR6r0o9WR6DTFOTFXw3AqgmOZarWyVpad9aRR1sKCPoxEUM
         CLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3fmm4nvalmQleWa1byPzKYwRMYCW7Pxtk8Gk5epwAE=;
        b=iVQDWRC0MZgU7I/CPG/haaElzQEtsHHA9/z0MIpgfbG1N5WiIOVqLgbym1a1pGTGhu
         uFT9vRIVufOmN+2sS7urrEhA3svJDynfQ7dPXc2hIxCV+BriTRiHEbJIdAS7J4O4DQBH
         6opocwl0nO5OQNyuGlh9gxnXvltZIP16EHYE8hxMOZUARWDYdTNF7fXZSfLvr774LSoW
         PScQRFXVuU4ppmDgvFGpLzfEnRLeCDXVkly1kHp5ChOZGWgX5RRo+Dj7kxURSbdakEJK
         oFybIPf62MFigZGP9o7omcJtEosV9P8+ftaJOjGPXsDAe6ucr+kgAkm5Y2fplxUvMbv0
         F+7g==
X-Gm-Message-State: AOAM532dicmNLP4hDRuGb9PyJ4jSJ+H5sDPAFfEQ4c8GNA7WaUVUaRRz
        NSw2O9oT1cW9hIII9KGa7MrgoQ==
X-Google-Smtp-Source: ABdhPJz8oBJ3w7oZV38zeOV4odPSlf2oJfYGXKEsseSqcLYbDUnaotjNjwPZV1gk/z/pgQvbgRWgyg==
X-Received: by 2002:a17:90a:5a01:: with SMTP id b1mr7252147pjd.134.1644215453808;
        Sun, 06 Feb 2022 22:30:53 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i10sm5266634pjd.2.2022.02.06.22.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 22:30:53 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v5 2/3] riscv: dts: Add dma-channels property and modify compatible
Date:   Mon,  7 Feb 2022 14:30:39 +0800
Message-Id: <ed0a70966acded2d9b8f7208d6e01b6d8324c1bf.1644215230.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644215230.git.zong.li@sifive.com>
References: <cover.1644215230.git.zong.li@sifive.com>
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

Add dma-channels property, then we can determine how many channels there
by device tree, in addition, we add the pdma versioning scheme for
compatible.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 3 ++-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 869aaf0d5c06..d8869ec99945 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -187,11 +187,12 @@ plic: interrupt-controller@c000000 {
 		};
 
 		dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
+			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic>;
 			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
 				     <30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 
diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 3eef52b1a59b..6a3011180846 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -168,11 +168,12 @@ uart0: serial@10010000 {
 			status = "disabled";
 		};
 		dma: dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
+			compatible = "sifive,fu540-c000-pdma", "sifive,pdma0";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
 				     <30>;
+			dma-channels = <4>;
 			#dma-cells = <1>;
 		};
 		uart1: serial@10011000 {
-- 
2.31.1

