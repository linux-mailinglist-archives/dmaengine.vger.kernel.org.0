Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0F1BEB14
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 23:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgD2V6M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 17:58:12 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:35985 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD2V6L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 17:58:11 -0400
X-IronPort-AV: E=Sophos;i="5.73,333,1583161200"; 
   d="scan'208";a="46009223"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Apr 2020 06:58:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8A46540ECBAC;
        Thu, 30 Apr 2020 06:58:05 +0900 (JST)
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
Subject: [PATCH 06/18] pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
Date:   Wed, 29 Apr 2020 22:56:43 +0100
Message-Id: <1588197415-13747-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Renesas RZ/G1H (R8A7742) is pin compatible with R-Car H2 (R8A7790).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/Kconfig       |  4 ++++
 drivers/pinctrl/sh-pfc/Makefile      |  1 +
 drivers/pinctrl/sh-pfc/core.c        |  6 ++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 24 ++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  1 +
 5 files changed, 36 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 9552851..c461a2f 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -12,6 +12,7 @@ config PINCTRL_SH_PFC
 	select PINCTRL_PFC_EMEV2 if ARCH_EMEV2
 	select PINCTRL_PFC_R8A73A4 if ARCH_R8A73A4
 	select PINCTRL_PFC_R8A7740 if ARCH_R8A7740
+	select PINCTRL_PFC_R8A7742 if ARCH_R8A7742
 	select PINCTRL_PFC_R8A7743 if ARCH_R8A7743
 	select PINCTRL_PFC_R8A7744 if ARCH_R8A7744
 	select PINCTRL_PFC_R8A7745 if ARCH_R8A7745
@@ -74,6 +75,9 @@ config PINCTRL_PFC_R8A7740
 	bool "R-Mobile A1 pin control support" if COMPILE_TEST
 	select PINCTRL_SH_PFC_GPIO
 
+config PINCTRL_PFC_R8A7742
+	bool "RZ/G1H pin control support" if COMPILE_TEST
+
 config PINCTRL_PFC_R8A7743
 	bool "RZ/G1M pin control support" if COMPILE_TEST
 
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index 9ebe321..3855d82 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_SH_PFC_GPIO)	+= gpio.o
 obj-$(CONFIG_PINCTRL_PFC_EMEV2)	+= pfc-emev2.o
 obj-$(CONFIG_PINCTRL_PFC_R8A73A4)	+= pfc-r8a73a4.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7740)	+= pfc-r8a7740.o
+obj-$(CONFIG_PINCTRL_PFC_R8A7742)	+= pfc-r8a7790.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7743)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7744)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7745)	+= pfc-r8a7794.o
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index a2e19ef..f368383 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -485,6 +485,12 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a7740_pinmux_info,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7742
+	{
+		.compatible = "renesas,pfc-r8a7742",
+		.data = &r8a7742_pinmux_info,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7743
 	{
 		.compatible = "renesas,pfc-r8a7743",
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 3366ed5..11cbcff 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -5736,6 +5736,7 @@ static const struct sh_pfc_soc_operations r8a7790_pinmux_ops = {
 	.pin_to_pocctrl = r8a7790_pin_to_pocctrl,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 	.name = "r8a77900_pfc",
 	.ops = &r8a7790_pinmux_ops,
@@ -5755,3 +5756,26 @@ const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
+#endif
+
+#ifdef CONFIG_PINCTRL_PFC_R8A7742
+const struct sh_pfc_soc_info r8a7742_pinmux_info = {
+	.name = "r8a77420_pfc",
+	.ops = &r8a7790_pinmux_ops,
+	.unlock_reg = 0xe6060000, /* PMMR */
+
+	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
+
+	.pins = pinmux_pins,
+	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.groups = pinmux_groups,
+	.nr_groups = ARRAY_SIZE(pinmux_groups),
+	.functions = pinmux_functions,
+	.nr_functions = ARRAY_SIZE(pinmux_functions),
+
+	.cfg_regs = pinmux_config_regs,
+
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
+};
+#endif
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index d57e633..0f01382 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -304,6 +304,7 @@ struct sh_pfc_soc_info {
 extern const struct sh_pfc_soc_info emev2_pinmux_info;
 extern const struct sh_pfc_soc_info r8a73a4_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7740_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7742_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7743_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7744_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7745_pinmux_info;
-- 
2.7.4

