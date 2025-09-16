Return-Path: <dmaengine+bounces-6572-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F744B5A2AE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FAB5861F7
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1D2F9D8E;
	Tue, 16 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1edpLyF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3C323F66;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=GKMt0T+X+JoOnxLH5hElDxJZ+Hy1KKG1Bd/mgyk/mh2w87nnQp0+ySGuZP1R5KUqPN/rudiBbOZWi/Vj3iBMtC2VJkR6vlPUr2WcCt+jMQCkoxl0a9SMDv2fPUx9BGdzI7BPCNsltECqFBSQPL2WGjzKrD3Y7JQ+6HsM2CZhaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=gQdj+jO5OwYIixP+cClgewhJqb0eZSY9VuHBGl/18WU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8WLSgb1Zh2Ri4eN/i1kqKxRVemDI8JgKu4V4gwtXq/p57XqbXRa8H6t5K4exGxfsxWkRnD101tKHRVZYYbbx+O+lH6LRTycHRoLylPCzlFDET+o1Hbz8cGcUdX73NK5USTATITX46KZIGeTVHYxxVvUU1Tcu2vlNEBGSNy6+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1edpLyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1448C4CEFE;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=gQdj+jO5OwYIixP+cClgewhJqb0eZSY9VuHBGl/18WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o1edpLyFj5jxP8LHIX+jFCvGtEv5LIFI/FSqg1M15wy0SXuZffg2o/uIAP2QoS17I
	 dBfEIgkeDRDLFtauo5sC4bYwgLky8VWwmoIlEdnzFCbA2FNRnrZt6tfGMsMRA/NLwt
	 b0ZiYpWvTY1CldLM4pCvqdUKf0I4ze91LlkSoIdwjxorzZRqPM6eEXGtjk04ZCZZ/l
	 8/rRaFiXFi5Nd0PA7K8r4UvyrzrFwXz37OjY/oUIumiLJb+bMJoxta1zXAy8c+PoJv
	 jR4j9iZz+7TvhvW2/y1QYoNxb51HCmqhEq3aEtsBZYyUFHMP7mWOl9WgZqOSeRS3KH
	 T32/ntpYPfGzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7395CAC59D;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:12 +0700
Subject: [PATCH 15/25] power: reset: Add basic power reset driver for
 RDA8810PL
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-15-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=4260;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=HFlkcuGoP8mh0AtLbkenNjV8o+UREGJUxRrmMlpYY+8=;
 b=tDnwi027u0ZztdCHk9SEr/lKN0wXoeRqVTLuHk786MC7CkCmAPImsXjgN/ULbHg//6qHti8x6
 8cGQKoU4pBQCo0nPOwWFQeuoR0ZX1cppWJGWEFpFHKUyjOi/YBYx5Y2
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

This basic driver can only reboot, powering off requires the modem
firmware which we don't have yet.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 MAINTAINERS                      |  6 +++++
 drivers/power/reset/Kconfig      |  9 +++++++
 drivers/power/reset/Makefile     |  1 +
 drivers/power/reset/rda-reboot.c | 58 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cbe2ab8af6dcd40dd1456d9df55673dace3c87b2..5ec24d8657bffb55c160947a930980e428c6a6b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21399,6 +21399,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
 F:	drivers/clk/rda/clk-rda8810.c
 
+RDA MICRO MODEM RESET DRIVER
+M:	Dang Huynh <dang.huynh@mainlining.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/rda,md-reset.yaml
+F:	drivers/power/reset/rda-reboot.c
+
 RDA MICRO REAL TIME CLOCK DRIVER
 M:	Dang Huynh <dang.huynh@mainlining.org>
 S:	Maintained
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 77ea3129c70806929f3c248667db42f05f5f1d27..de9b1afb94d14a5d23286ddb302af4107d649c12 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -205,6 +205,15 @@ config POWER_RESET_QNAP
 
 	  Say Y if you have a QNAP NAS.
 
+config POWER_RESET_RDA
+	bool "RDA Micro Reset Driver"
+	depends on ARCH_RDA
+	help
+	  This driver supports soft resetting RDA Micro boards by writing
+	  magic values to the modem register.
+
+	  Say Y if you have a board with RDA Micro SoC.
+
 config POWER_RESET_REGULATOR
 	bool "Regulator subsystem power-off driver"
 	depends on OF && REGULATOR
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index b7c2b5940be9971548a5527384d1931abff11c4c..14371230410dad2852489160f4fc23d8fd087d6e 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) += odroid-go-ultra-poweroff.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
+obj-$(CONFIG_POWER_RESET_RDA) += rda-reboot.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
diff --git a/drivers/power/reset/rda-reboot.c b/drivers/power/reset/rda-reboot.c
new file mode 100644
index 0000000000000000000000000000000000000000..d87b063ba67d847f8e869e50a6c01427b2866889
--- /dev/null
+++ b/drivers/power/reset/rda-reboot.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Dang Huynh <dang.huynh@mainlining.org>
+ *
+ * Based on drivers/power/reset/msm-poweroff.c:
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/pm.h>
+#include <linux/mfd/syscon.h>
+
+static void __iomem *rda_md_sysctrl;
+
+static int do_rda_reboot(struct sys_off_data *data)
+{
+	/* unprotect md registers */
+	writel(0x00A50001, rda_md_sysctrl);
+
+	/* reset all */
+	writel(0x80000000, rda_md_sysctrl + 4);
+
+	return NOTIFY_DONE;
+}
+
+static int rda_reboot_probe(struct platform_device *pdev)
+{
+	rda_md_sysctrl = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rda_md_sysctrl))
+		return PTR_ERR(rda_md_sysctrl);
+
+	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+				      128, do_rda_reboot, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id of_rda_reboot_match[] = {
+	{ .compatible = "rda,md-reset", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_rda_reboot_match);
+
+static struct platform_driver rda_reboot_driver = {
+	.probe = rda_reboot_probe,
+	.driver = {
+		.name = "rda-reboot",
+		.of_match_table = of_match_ptr(of_rda_reboot_match),
+	},
+};
+builtin_platform_driver(rda_reboot_driver);

-- 
2.51.0



