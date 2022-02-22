Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1AD4BF607
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiBVKf2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 05:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiBVKf1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 05:35:27 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734E15B3DF;
        Tue, 22 Feb 2022 02:35:01 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 56BA0FF807;
        Tue, 22 Feb 2022 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645526100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3+Oux1VnR7Sdvr4JNewwQWXvXdVydwtng7Wz92aPOw=;
        b=Rs5Thr7UPSPoBCcldQOzahowLYpB2rTIsHN/0iJ0sSvMqNBmPZqXszkHWfgHpLVLwyJGUc
        8x8AqRU3xlhaevV7OXGRZT5u3Va6LwukmWtcgovR15gk3Kcdi/L+TbZFGWxLb2Ie6NxMTH
        FG2JWBhm1oMTfHMAsDzwHl+0bS7DaMs8c7SEoePbpXxhYrS/rSsv3Iuui2mOMkQCOJifze
        ScsFLUjm8UzXD9RmdNvNzsnbMhagV0NFGnyxiduUJ3XwbzEtWwGTAhpnChvGkvRVw3dPzb
        i29Kp20MpkwBhpRqDD7triCJfu4Y6IQJ9GIu3UsiYwOR3PdLajZXe2iW1ToLIw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 3/8] soc: renesas: rzn1-sysc: Export function to set dmamux
Date:   Tue, 22 Feb 2022 11:34:32 +0100
Message-Id: <20220222103437.194779-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220222103437.194779-1-miquel.raynal@bootlin.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dmamux register is located within the system controller.

Without syscon, we need an extra helper in order to give write access to
this register to a dmamux driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c        | 31 +++++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h | 11 +++++++
 2 files changed, 42 insertions(+)
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index c99942f0e4d4..370c89490be9 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -20,9 +20,12 @@
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
+#include <linux/soc/renesas/r9a06g032-sysctrl.h>
 #include <linux/spinlock.h>
 #include <dt-bindings/clock/r9a06g032-sysctrl.h>
 
+#define R9A06G032_SYSCTRL_DMAMUX 0xA0
+
 struct r9a06g032_gate {
 	u16 gate, reset, ready, midle,
 		scon, mirack, mistat;
@@ -315,6 +318,28 @@ struct r9a06g032_priv {
 	void __iomem *reg;
 };
 
+/* Exported helper to access the DMAMUX register */
+static struct r9a06g032_priv *sysctrl_priv;
+int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val)
+{
+	unsigned long flags;
+	u32 dmamux;
+
+	if (!sysctrl_priv)
+		return -EPROBE_DEFER;
+
+	spin_lock_irqsave(&sysctrl_priv->lock, flags);
+
+	dmamux = readl(sysctrl_priv->reg + R9A06G032_SYSCTRL_DMAMUX);
+	dmamux &= ~mask;
+	dmamux |= val & mask;
+	writel(dmamux, sysctrl_priv->reg + R9A06G032_SYSCTRL_DMAMUX);
+
+	spin_unlock_irqrestore(&sysctrl_priv->lock, flags);
+
+	return 0;
+}
+
 /* register/bit pairs are encoded as an uint16_t */
 static void
 clk_rdesc_set(struct r9a06g032_priv *clocks,
@@ -922,6 +947,12 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	clocks->reg = of_iomap(np, 0);
 	if (WARN_ON(!clocks->reg))
 		return -ENOMEM;
+
+	if (sysctrl_priv)
+		return -EBUSY;
+
+	sysctrl_priv = clocks;
+
 	for (i = 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
 		const struct r9a06g032_clkdesc *d = &r9a06g032_clocks[i];
 		const char *parent_name = d->source ?
diff --git a/include/linux/soc/renesas/r9a06g032-sysctrl.h b/include/linux/soc/renesas/r9a06g032-sysctrl.h
new file mode 100644
index 000000000000..066dfb15cbdd
--- /dev/null
+++ b/include/linux/soc/renesas/r9a06g032-sysctrl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SOC_RENESAS_R9A06G032_SYSCTRL_H__
+#define __LINUX_SOC_RENESAS_R9A06G032_SYSCTRL_H__
+
+#ifdef CONFIG_CLK_R9A06G032
+int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val);
+#else
+static inline int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val) { return -ENODEV; }
+#endif
+
+#endif /* __LINUX_SOC_RENESAS_R9A06G032_SYSCTRL_H__ */
-- 
2.27.0

