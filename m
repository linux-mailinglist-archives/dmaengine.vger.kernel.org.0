Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856A628F227
	for <lists+dmaengine@lfdr.de>; Thu, 15 Oct 2020 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgJOMd0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Oct 2020 08:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgJOMdY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Oct 2020 08:33:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C5C061755
        for <dmaengine@vger.kernel.org>; Thu, 15 Oct 2020 05:33:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so3264977wrs.5
        for <dmaengine@vger.kernel.org>; Thu, 15 Oct 2020 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6dwpPJHIiSRutrnQDaT8pB3t0nr9YNcN7bL7QingKY=;
        b=CL0IeNygAWXDyHEF5dwiKs8tsJ2RBgFNADeO0tnvF12aY/p6MjRiIBlStLJkEAdqZ8
         oo79xUd0CaQDEZtx4xzEJNBhLGZZlt+sSpf2lNdMyu+MMdPsWk58ykqLEa9aKU3oTl18
         hSXDYQsyx5y4nJfPs6TlkL3yL8IYNQzOc31PW1IkzVlvlo0YU4C1e9GzKdwu3KnVn50v
         IfzDRfw/b/HqbPdDpn1jvCQspP/jOXXBHpkV181q4LeI5FnbhjP9yw6fSvW1FIVaVabp
         Ub3ZMMo/PMY2MEB5cpo8WdJMTMmhUrmndssBLEfoUF12iJd811Vu0c+CYOANxjyb/l2d
         8bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6dwpPJHIiSRutrnQDaT8pB3t0nr9YNcN7bL7QingKY=;
        b=ByQVrL52IvZxzzNVVWdnMU1p+EZCCyqAhxgm6tSKMdEaU07699NewrN1fjO8l0evNf
         8qTJOHvNp+zThYkBt2MMPDKcYF5/Ru9+yYWGx/EQ9kXyppECr6QotG5/rAs8HZMGle9B
         18vgpiFJbNAMG9ghNW6jm7mTY3w1nw8P1+4gniafZ3HRZL+CgOGOIZ5lnTzfCeW+O7YG
         eGQfS7ID0AyHT4Xzn0x8B/PTSq14RgVkDks4izTNBcvahNaCKrQquAX6JfalOx3yll+0
         UI6WgL+WpW17rDGECyL6MM3WHD/Ok7cWVu+oM0U5S+vA3OWdWVsdpDgRvt+XpQeOhsVi
         QRFQ==
X-Gm-Message-State: AOAM533NofYb6LzeH0yDFFh+nFsM9tReJMh2mL3TB4oWzp1qwmAdFd6E
        1n+b4K+Bh/dzCs4lAbF5skNrqg==
X-Google-Smtp-Source: ABdhPJwn8zFW5bol5nozv7XpuQ8bkJ9yy2YxRvVgK+PZfhXBXEPqEnWgwqKL4QcFwdvP8BNFI0OqoA==
X-Received: by 2002:adf:e589:: with SMTP id l9mr4067420wrm.110.1602765201333;
        Thu, 15 Oct 2020 05:33:21 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net. [81.185.163.129])
        by smtp.gmail.com with ESMTPSA id j7sm4017406wmc.7.2020.10.15.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 05:33:20 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, vkoul@kernel.org,
        sean.wang@mediatek.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8516: add support for APDMA
Date:   Thu, 15 Oct 2020 14:33:15 +0200
Message-Id: <20201015123315.334919-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015123315.334919-1-fparent@baylibre.com>
References: <20201015123315.334919-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support the APDMA IP on MT8516. APDMA is a DMA controller
for UARTs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index eca7969e15ab..a017664f8eed 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -269,6 +269,27 @@ gic: interrupt-controller@10310000 {
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		apdma: dma-controller@11000480 {
+			compatible = "mediatek,mt8516-uart-dma",
+				     "mediatek,mt6577-uart-dma";
+			reg = <0 0x11000480 0 0x80>,
+			      <0 0x11000500 0 0x80>,
+			      <0 0x11000580 0 0x80>,
+			      <0 0x11000600 0 0x80>,
+			      <0 0x11000980 0 0x80>,
+			      <0 0x11000a00 0 0x80>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_LOW>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_LOW>;
+			dma-requests = <6>;
+			clocks = <&topckgen CLK_TOP_APDMA>;
+			clock-names = "apdma";
+			#dma-cells = <1>;
+		};
+
 		uart0: serial@11005000 {
 			compatible = "mediatek,mt8516-uart",
 				     "mediatek,mt6577-uart";
@@ -277,6 +298,8 @@ uart0: serial@11005000 {
 			clocks = <&topckgen CLK_TOP_UART0_SEL>,
 				 <&topckgen CLK_TOP_UART0>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 0
+				&apdma 1>;
 			status = "disabled";
 		};
 
@@ -288,6 +311,8 @@ uart1: serial@11006000 {
 			clocks = <&topckgen CLK_TOP_UART1_SEL>,
 				 <&topckgen CLK_TOP_UART1>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 2
+				&apdma 3>;
 			status = "disabled";
 		};
 
@@ -299,6 +324,8 @@ uart2: serial@11007000 {
 			clocks = <&topckgen CLK_TOP_UART2_SEL>,
 				 <&topckgen CLK_TOP_UART2>;
 			clock-names = "baud", "bus";
+			dmas = <&apdma 4
+				&apdma 5>;
 			status = "disabled";
 		};
 
-- 
2.28.0

