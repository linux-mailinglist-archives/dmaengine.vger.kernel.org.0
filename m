Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A644BBF23
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiBRSMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 13:12:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiBRSMx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 13:12:53 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA4035DFC;
        Fri, 18 Feb 2022 10:12:35 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6003D2000D;
        Fri, 18 Feb 2022 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645207953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WsRY6Xgen9o25djTmhqLF7wHC9LXU0mBjNpNId5xwA=;
        b=JL/j8o9rnrcnJYOqKSTtcfAornE56vALLZ60MibNyu+cwdKSUQ/DR3ijR+yLS4ErCkA91T
        Yn7QMQG4Y3xzyaebKDdKAgCzH44tJyGyIzFxj14NPt1TTqfVW6YNExwNIR/kDbjh+eztpr
        OrxLFoCFqFMp8jog4X0MpUYFDNq+g4uDPgwR3bzYQDOFyHiFCtGgmF0GgvEy9fsBUq17Xf
        ji/OG+jUHMh9DYR1Cf3KhZGsIANa83orc28sMlPgI3EnBi1I8bpD4DdPId8Hy6Z1i+R7Qb
        sDl8Wie9W66UcoU31ldFR4YX1aL+eFAN83KdzVT2CdZt/H6WpLxB3EluUrwb7g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/8] soc: renesas: rzn1-sysc: Export function to set dmamux
Date:   Fri, 18 Feb 2022 19:12:21 +0100
Message-Id: <20220218181226.431098-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220218181226.431098-1-miquel.raynal@bootlin.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/renesas/r9a06g032-clocks.c        | 27 +++++++++++++++++++
 include/dt-bindings/clock/r9a06g032-sysctrl.h |  2 ++
 include/linux/soc/renesas/r9a06g032-syscon.h  | 11 ++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 include/linux/soc/renesas/r9a06g032-syscon.h

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index c99942f0e4d4..3bca60fac21c 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -315,6 +315,27 @@ struct r9a06g032_priv {
 	void __iomem *reg;
 };
 
+/* Exported helper to access the DMAMUX register */
+static struct r9a06g032_priv *syscon_priv;
+int r9a06g032_syscon_set_dmamux(u32 mask, u32 val)
+{
+	u32 dmamux;
+
+	if (!syscon_priv)
+		return -EPROBE_DEFER;
+
+	spin_lock(&syscon_priv->lock);
+
+	dmamux = readl(syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
+	dmamux &= ~mask;
+	dmamux |= val & mask;
+	writel(dmamux, syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
+
+	spin_unlock(&syscon_priv->lock);
+
+	return 0;
+}
+
 /* register/bit pairs are encoded as an uint16_t */
 static void
 clk_rdesc_set(struct r9a06g032_priv *clocks,
@@ -922,6 +943,12 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	clocks->reg = of_iomap(np, 0);
 	if (WARN_ON(!clocks->reg))
 		return -ENOMEM;
+
+	if (syscon_priv)
+		return -EBUSY;
+
+	syscon_priv = clocks;
+
 	for (i = 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
 		const struct r9a06g032_clkdesc *d = &r9a06g032_clocks[i];
 		const char *parent_name = d->source ?
diff --git a/include/dt-bindings/clock/r9a06g032-sysctrl.h b/include/dt-bindings/clock/r9a06g032-sysctrl.h
index 90c0f3dc1ba1..609e7fe8fcb1 100644
--- a/include/dt-bindings/clock/r9a06g032-sysctrl.h
+++ b/include/dt-bindings/clock/r9a06g032-sysctrl.h
@@ -145,4 +145,6 @@
 #define R9A06G032_CLK_UART6		152
 #define R9A06G032_CLK_UART7		153
 
+#define R9A06G032_SYSCON_DMAMUX		0xA0
+
 #endif /* __DT_BINDINGS_R9A06G032_SYSCTRL_H__ */
diff --git a/include/linux/soc/renesas/r9a06g032-syscon.h b/include/linux/soc/renesas/r9a06g032-syscon.h
new file mode 100644
index 000000000000..d97e0e91cc6a
--- /dev/null
+++ b/include/linux/soc/renesas/r9a06g032-syscon.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__
+#define __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__
+
+#ifdef CONFIG_CLK_R9A06G032
+int r9a06g032_syscon_set_dmamux(u32 mask, u32 val);
+#else
+static inline int r9a06g032_syscon_set_dmamux(u32 mask, u32 val) { return -ENODEV; }
+#endif
+
+#endif /* __LINUX_SOC_RENESAS_R9A06G032_SYSCON_H__ */
-- 
2.27.0

