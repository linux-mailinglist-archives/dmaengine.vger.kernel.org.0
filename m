Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C441BEABB
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 23:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgD2V6B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 17:58:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:28940 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2V6B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 17:58:01 -0400
X-IronPort-AV: E=Sophos;i="5.73,333,1583161200"; 
   d="scan'208";a="45795831"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Apr 2020 06:58:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2278840ECCF1;
        Thu, 30 Apr 2020 06:57:55 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 04/18] ARM: debug-ll: Add support for r8a7742
Date:   Wed, 29 Apr 2020 22:56:41 +0100
Message-Id: <1588197415-13747-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable low-level debugging support for RZ/G1H (R8A7742). RZ/G1H uses
SCIFA2 for the debug console.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f46e18a..d0631e2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -976,6 +976,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF4 on Renesas RZ/G1E (R8A7745).
 
+	config DEBUG_RCAR_GEN2_SCIFA2
+		bool "Kernel low-level debugging messages via SCIFA2 on ARCH_R8A7742"
+		depends on ARCH_R8A7742
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIFA2 on Renesas RZ/G1H (R8A7742).
+
 	config DEBUG_RMOBILE_SCIFA0
 		bool "Kernel low-level debugging messages via SCIFA0 on R8A73A4"
 		depends on ARCH_R8A73A4
@@ -1577,6 +1584,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF1
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF2
 	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF4
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIFA2
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA0
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA1
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
@@ -1701,6 +1709,7 @@ config DEBUG_UART_PHYS
 	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
 	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
 	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
+	default 0xe6c60000 if DEBUG_RCAR_GEN2_SCIFA2
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2 || DEBUG_R7S9210_SCIF2
 	default 0xe8009000 if DEBUG_R7S9210_SCIF4
 	default 0xf0000000 if DEBUG_DIGICOLOR_UA0
@@ -1737,6 +1746,7 @@ config DEBUG_UART_PHYS
 		DEBUG_RCAR_GEN1_SCIF0 || DEBUG_RCAR_GEN1_SCIF2 || \
 		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF1 || \
 		DEBUG_RCAR_GEN2_SCIF2 || DEBUG_RCAR_GEN2_SCIF4 || \
+		DEBUG_RCAR_GEN2_SCIFA2 || \
 		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
 		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
 		DEBUG_S3C64XX_UART || \
-- 
2.7.4

