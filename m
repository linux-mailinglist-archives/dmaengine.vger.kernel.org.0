Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C564FE8E3
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 21:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiDLTnN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359036AbiDLTmK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 15:42:10 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2881637BE6;
        Tue, 12 Apr 2022 12:39:48 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0ED41200006;
        Tue, 12 Apr 2022 19:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649792387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZQwq9EVWiu0S9glnJx6yd3klQequgPHgMCbo1b5VzU=;
        b=bLb3N1GusMPD8qnjT5lZDDFBgzQnVpGHSlSNKoaj6xTFlpJWbiitSaHPwDu9z5oqL4p3EI
        e6OfAxsdVZ75zkqGO7vlfngPgG2i2v4/MjFfLQNJj2DiSjecKDS4VBeNcoN/8/4ybn7BLX
        WlUbXd9Ek4sg/NRd5xqDp2WW3uBGAzm3MhrUhAcLrhdX79rr2Fho8BdMjMe552tJgklNbW
        VPbR+29zA5ubyqqf3DuLHUla4IYxlqHcdb2i3aJNFbp9l1duBuVFJj/t+qbd3XhAGea+Py
        impCNjIEEHSkViAAzhZGyIh9UxED+aJBBjT9zV22XwCrWnDgR06xhrTVAvsf+g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v10 4/9] soc: renesas: rzn1-sysc: Export function to set dmamux
Date:   Tue, 12 Apr 2022 21:39:31 +0200
Message-Id: <20220412193936.63355-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412193936.63355-1-miquel.raynal@bootlin.com>
References: <20220412193936.63355-1-miquel.raynal@bootlin.com>
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
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/renesas/r9a06g032-clocks.c        | 35 ++++++++++++++++++-
 include/linux/soc/renesas/r9a06g032-sysctrl.h | 11 ++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/soc/renesas/r9a06g032-sysctrl.h

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index c99942f0e4d4..052d99059981 100644
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
@@ -315,6 +318,30 @@ struct r9a06g032_priv {
 	void __iomem *reg;
 };
 
+static struct r9a06g032_priv *sysctrl_priv;
+
+/* Exported helper to access the DMAMUX register */
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
+EXPORT_SYMBOL_GPL(r9a06g032_sysctrl_set_dmamux);
+
 /* register/bit pairs are encoded as an uint16_t */
 static void
 clk_rdesc_set(struct r9a06g032_priv *clocks,
@@ -963,7 +990,13 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	return r9a06g032_add_clk_domain(dev);
+	error = r9a06g032_add_clk_domain(dev);
+	if (error)
+		return error;
+
+	sysctrl_priv = clocks;
+
+	return 0;
 }
 
 static const struct of_device_id r9a06g032_match[] = {
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

