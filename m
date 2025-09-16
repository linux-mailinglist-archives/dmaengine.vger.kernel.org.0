Return-Path: <dmaengine+bounces-6565-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F86B5A26C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C283B6A84
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6432B4A8;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbqz4/4M"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3B313D7A;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=RXvA6vqsDUfFjswO5bjHKgKXOWpVSzN6tBX6qgQJRTfo/d8XOz6nUm/gU3M+YvtpSGKVEn1G/39zjamrLAh/AeVHAGe03Tet5XgebtZDyHYZ8lwegFROJczSs9eZbazdDirkbN12zkiU6EBHsBYzU9SrKJhbOALd4ujDQ9s9MnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=6a7uRpDFFwmJD90P9fw5aBw9D1Bqy2wqv4v3bXssn10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX8gxeEH/T/Y8rqkq4/qCuC+VKE9hJdxGzGaeAT5CSnSVPtEaYZLy9+MmYwTc2BzD8bGqonrBlG32FZX2wiNZOSp3XBi6nMdL+FdNftZExcwO9BZdHKrXPxioP5C78oA1Yyqb4eDEjGMrH4SdNUoxXm4AJeXjMLpxzWec6Oj4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbqz4/4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CB05C116B1;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=6a7uRpDFFwmJD90P9fw5aBw9D1Bqy2wqv4v3bXssn10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nbqz4/4Ms1V2NDIjE037IPoihF7TCtIfauQ00yIKCPcNACiZj1p6MjSeyTuT7et+C
	 HSpG9aPw2oPL5OlRPiQPdxlCrelFCwZ8U5lfiLf8evTMNqe6oaFl9bJD3+/ZJ3rSi0
	 MriJ2iJqJBZHmS+UFuME7QhY6k0Y9l3d4S0kDey0yhdJLxmnItCz2suMhmTYoXphLj
	 1FPLlTURZ9QVfMpAWxlboym9P9yKkxc6xyODFY8HSC9AhWrbHUnyeWvoAlZ6STnwjM
	 vsQvTh4PX2qIqsf0fOGDazevcjcYeimA74M2fYaSGbFTwWE4G8oBjBgGI9DqjQD/Ai
	 QnXzBuQt/MWPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41236CAC59F;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:03 +0700
Subject: [PATCH 06/25] rtc: Add driver for RDA Micro SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-6-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=12867;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=cSJlbB/SvEEJA+EINZDwWhdF79lGvQa4JzoffiXw/8A=;
 b=Kerwaw//6fBvHo9376TQSXrx+rBI8DCHbXxwdiEX7xIvpmGu5dhndFwWTM6Vg5geOi9Y7Neu5
 CSES8aJIaDmCPO9wetq+ZJzdPpI13ZweHRK6Z2NhRw7BxkASASNYofo
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

The RDA Micro SoC has built-in RTC, it supports read/write date
as well as alarm.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 MAINTAINERS           |   6 +
 drivers/rtc/Kconfig   |  11 ++
 drivers/rtc/Makefile  |   1 +
 drivers/rtc/rtc-rda.c | 356 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 374 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7f80bd7b2f8bd2099acb9f38070498e7b1cc7e..0549b1d0657f2caaf86a723db139cf9d84d59c4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21393,6 +21393,12 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	tools/testing/selftests/rcutorture
 
+RDA MICRO REAL TIME CLOCK DRIVER
+M:	Dang Huynh <dang.huynh@mainlining.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
+F:	drivers/rtc/rtc-rda.c
+
 RDACM20 Camera Sensor
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 64f6e9756aff4a1f6f6c50f9b4fc2140f66a8578..287fc3bbd474ab78a9bd3b8813e8b9d475c07198 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1471,6 +1471,17 @@ config RTC_DRV_OMAP
 	  This driver can also be built as a module, if so, module
 	  will be called rtc-omap.
 
+config RTC_DRV_RDA
+	tristate "RDA Micro RTC"
+	depends on ARCH_RDA || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  If you say yes here you get support for the built-in RTC on
+	  RDA Micro SoC.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called rtc-rda.
+
 config RTC_DRV_S3C
 	tristate "Samsung S3C series SoC RTC"
 	depends on ARCH_EXYNOS || ARCH_S3C64XX || ARCH_S5PV210 || \
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 789bddfea99d8fcd024566891c37ee73e527cf93..02f73062bb158fe4738a3043c58ee40f8a58b3c6 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_RTC_DRV_PS3)	+= rtc-ps3.o
 obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
 obj-$(CONFIG_RTC_DRV_R7301)	+= rtc-r7301.o
 obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701.o
+obj-$(CONFIG_RTC_DRV_RDA)	+= rtc-rda.o
 obj-$(CONFIG_RTC_DRV_RC5T583)	+= rtc-rc5t583.o
 obj-$(CONFIG_RTC_DRV_RC5T619)	+= rtc-rc5t619.o
 obj-$(CONFIG_RTC_DRV_RK808)	+= rtc-rk808.o
diff --git a/drivers/rtc/rtc-rda.c b/drivers/rtc/rtc-rda.c
new file mode 100644
index 0000000000000000000000000000000000000000..bb5aa25fb7d0ad538a0f7f67a80d08fe67af1c5d
--- /dev/null
+++ b/drivers/rtc/rtc-rda.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RTC driver for RDA Micro
+ *
+ * Copyright (C) 2013-2014 RDA Microelectronics Inc.
+ * Copyright (C) 2024 Dang Huynh <dang.huynh@mainlining.org>
+ */
+
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
+struct rda_rtc {
+	struct rtc_device *rtc_dev;
+	struct regmap *regmap;
+};
+
+/* RTC Registers */
+#define RDA_RTC_CTRL_REG 0x0
+#define RDA_RTC_CMD_REG 0x4
+#define RDA_RTC_STA_REG 0x8
+#define RDA_RTC_CAL_LOAD_LOW_REG 0xC
+#define RDA_RTC_CAL_LOAD_HIGH_REG 0x10
+#define RDA_RTC_CUR_LOAD_LOW_REG 0x14
+#define RDA_RTC_CUR_LOAD_HIGH_REG 0x18
+#define RDA_RTC_ALARM_LOW_REG 0x1C
+#define RDA_RTC_ALARM_HIGH_REG 0x20
+
+/* RTC Bits */
+#define RDA_RTC_CMD_CAL_LOAD BIT(0)
+#define RDA_RTC_CMD_ALARM_LOAD BIT(4)
+#define RDA_RTC_CMD_ALARM_ENABLE BIT(5)
+#define RDA_RTC_CMD_ALARM_DISABLE BIT(6)
+#define RDA_RTC_CMD_INVALID BIT(31)
+#define RDA_RTC_STA_ALARM_ENABLE BIT(20)
+#define RDA_RTC_STA_NOT_PROG BIT(31)
+
+/* RTC Masks */
+#define RDA_SEC_MASK GENMASK(7, 0)
+#define RDA_MIN_MASK GENMASK(15, 8)
+#define RDA_HRS_MASK GENMASK(23, 16)
+
+#define RDA_MDAY_MASK GENMASK(7, 0)
+#define RDA_MON_MASK GENMASK(11, 8)
+#define RDA_YEAR_MASK GENMASK(22, 16)
+#define RDA_WDAY_MASK GENMASK(26, 24)
+
+static int rda_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct rda_rtc *rtc = dev_get_drvdata(dev);
+	u32 high, low;
+	int ret;
+
+	ret = rtc_valid_tm(tm);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The number of years since 1900 in kernel,
+	 * but it is defined since 2000 by HW.
+	 * The number of mons' range is from 0 to 11 in kernel,
+	 * but it is defined from 1 to 12 by HW.
+	 */
+	low = FIELD_PREP(RDA_SEC_MASK, tm->tm_sec) |
+		FIELD_PREP(RDA_MIN_MASK, tm->tm_min) |
+		FIELD_PREP(RDA_HRS_MASK, tm->tm_hour);
+
+	high = FIELD_PREP(RDA_MDAY_MASK, tm->tm_mday) |
+		FIELD_PREP(RDA_MON_MASK, tm->tm_mon + 1) |
+		FIELD_PREP(RDA_YEAR_MASK, tm->tm_year - 100) |
+		FIELD_PREP(RDA_WDAY_MASK, tm->tm_wday);
+
+	ret = regmap_write(rtc->regmap, RDA_RTC_CAL_LOAD_LOW_REG, low);
+	if (ret < 0) {
+		dev_err(dev, "Failed to update RTC low register: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(rtc->regmap, RDA_RTC_CAL_LOAD_HIGH_REG, high);
+	if (ret < 0) {
+		dev_err(dev, "Failed to update RTC low register: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG, RDA_RTC_CMD_CAL_LOAD, 1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to update RTC cal load register: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rda_rtc_readtime(struct device *dev, struct rtc_time *tm)
+{
+	struct rda_rtc *rtc = dev_get_drvdata(dev);
+	unsigned int high, low;
+	int ret;
+
+	/*
+	 * Check if RTC data is valid.
+	 *
+	 * When this bit is set, it means the data in the RTC is invalid
+	 * or not configured.
+	 */
+	ret = regmap_test_bits(rtc->regmap, RDA_RTC_STA_REG, RDA_RTC_STA_NOT_PROG);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read RTC status: %d\n", ret);
+		return ret;
+	} else if (ret > 0)
+		return -EINVAL;
+
+	ret = regmap_read(rtc->regmap, RDA_RTC_CUR_LOAD_HIGH_REG, &high);
+	if (ret) {
+		dev_err(dev, "Failed to read RTC high reg: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(rtc->regmap, RDA_RTC_CUR_LOAD_LOW_REG, &low);
+	if (ret) {
+		dev_err(dev, "Failed to read RTC low reg: %d\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec = FIELD_GET(RDA_SEC_MASK, low);
+	tm->tm_min = FIELD_GET(RDA_MIN_MASK, low);
+	tm->tm_hour = FIELD_GET(RDA_HRS_MASK, low);
+	tm->tm_mday = FIELD_GET(RDA_MDAY_MASK, high);
+	tm->tm_mon = FIELD_GET(RDA_MON_MASK, high);
+	tm->tm_year = FIELD_GET(RDA_YEAR_MASK, high);
+	tm->tm_wday = FIELD_GET(RDA_WDAY_MASK, high);
+
+	/*
+	 * The number of years since 1900 in kernel,
+	 * but it is defined since 2000 by HW.
+	 */
+	tm->tm_year += 100;
+	/*
+	 * The number of mons' range is from 0 to 11 in kernel,
+	 * but it is defined from 1 to 12 by HW.
+	 */
+	tm->tm_mon -= 1;
+
+	return 0;
+}
+
+static int rda_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct rda_rtc *rtc = dev_get_drvdata(dev);
+	struct rtc_time *tm = &alrm->time;
+	unsigned int high, low;
+	int ret;
+
+	ret = regmap_read(rtc->regmap, RDA_RTC_ALARM_HIGH_REG, &high);
+	if (ret) {
+		dev_err(dev, "Failed to read alarm low reg: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(rtc->regmap, RDA_RTC_ALARM_LOW_REG, &low);
+	if (ret) {
+		dev_err(dev, "Failed to read alarm low reg: %d\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec = FIELD_GET(RDA_SEC_MASK, low);
+	tm->tm_min = FIELD_GET(RDA_MIN_MASK, low);
+	tm->tm_hour = FIELD_GET(RDA_HRS_MASK, low);
+	tm->tm_mday = FIELD_GET(RDA_MDAY_MASK, high);
+	tm->tm_mon = FIELD_GET(RDA_MON_MASK, high);
+	tm->tm_year = FIELD_GET(RDA_YEAR_MASK, high);
+	tm->tm_wday = FIELD_GET(RDA_WDAY_MASK, high);
+
+	/*
+	 * The number of years since 1900 in kernel,
+	 * but it is defined since 2000 by HW.
+	 */
+	tm->tm_year += 100;
+	/*
+	 * The number of mons' range is from 0 to 11 in kernel,
+	 * but it is defined from 1 to 12 by HW.
+	 */
+	tm->tm_mon -= 1;
+
+	return 0;
+}
+
+static int rda_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct rda_rtc *rtc = dev_get_drvdata(dev);
+
+	if (enabled)
+		return regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG,
+				RDA_RTC_CMD_ALARM_ENABLE, 1);
+
+	return regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG,
+			RDA_RTC_CMD_ALARM_DISABLE, 1);
+}
+
+static int rda_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct rda_rtc *rtc = dev_get_drvdata(dev);
+	struct rtc_time *tm = &alrm->time;
+	u32 high, low;
+	int ret;
+
+	ret = rtc_valid_tm(tm);
+	if (ret < 0)
+		return ret;
+
+	/* TODO: Check if it's necessary to disable IRQ first */
+	rda_rtc_alarm_irq_enable(dev, 0);
+
+	/*
+	 * The number of years since 1900 in kernel,
+	 * but it is defined since 2000 by HW.
+	 * The number of mons' range is from 0 to 11 in kernel,
+	 * but it is defined from 1 to 12 by HW.
+	 */
+	low = FIELD_PREP(RDA_SEC_MASK, tm->tm_sec) |
+		FIELD_PREP(RDA_MIN_MASK, tm->tm_min) |
+		FIELD_PREP(RDA_HRS_MASK, tm->tm_hour);
+
+	high = FIELD_PREP(RDA_MDAY_MASK, tm->tm_mday) |
+		FIELD_PREP(RDA_MON_MASK, tm->tm_mon + 1) |
+		FIELD_PREP(RDA_YEAR_MASK, tm->tm_year - 100) |
+		FIELD_PREP(RDA_WDAY_MASK, tm->tm_wday);
+
+
+	ret = regmap_write(rtc->regmap, RDA_RTC_ALARM_LOW_REG, low);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set low alarm register: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(rtc->regmap, RDA_RTC_ALARM_HIGH_REG, high);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set low alarm register: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(rtc->regmap, RDA_RTC_CMD_REG, RDA_RTC_CMD_ALARM_LOAD, 1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set alarm register: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "Alarm set: %4d-%02d-%02d %02d:%02d:%02d\n",
+			2000 + (tm->tm_year - 100), tm->tm_mon + 1, tm->tm_mday,
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	return 0;
+}
+
+static int rda_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	struct rda_rtc *rtc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_test_bits(rtc->regmap, RDA_RTC_STA_REG, RDA_RTC_STA_ALARM_ENABLE);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read alarm status: %d\n", ret);
+		return ret;
+	}
+
+	seq_printf(seq, "alarm enable\t: %s\n", (ret > 0) ? "yes" : "no");
+
+	return 0;
+}
+
+static const struct rtc_class_ops rda_rtc_ops = {
+	.read_time = rda_rtc_readtime,
+	.set_time = rda_rtc_settime,
+	.read_alarm = rda_rtc_readalarm,
+	.set_alarm = rda_rtc_setalarm,
+	.proc = rda_rtc_proc,
+	.alarm_irq_enable = rda_rtc_alarm_irq_enable,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int rda_rtc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	/* TODO: Check if it's okay to turn on alarm IRQ when it's not set */
+	return rda_rtc_alarm_irq_enable(&pdev->dev, 1);
+}
+
+static int rda_rtc_resume(struct platform_device *pdev)
+{
+	/* If alarms were left, we turn them off. */
+	return rda_rtc_alarm_irq_enable(&pdev->dev, 0);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(rda_rtc_pm_ops, rda_rtc_suspend, rda_rtc_resume);
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int rda_rtc_probe(struct platform_device *pdev)
+{
+	struct rda_rtc *rda_rtc;
+	void __iomem *base;
+
+	rda_rtc = devm_kzalloc(&pdev->dev, sizeof(*rda_rtc), GFP_KERNEL);
+	if (!rda_rtc)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				"failed to remap resource\n");
+
+	rda_rtc->regmap = devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
+	if (!rda_rtc->regmap)
+		return dev_err_probe(&pdev->dev, PTR_ERR(rda_rtc->regmap),
+				"can't find regmap\n");
+
+	rda_rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rda_rtc->rtc_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rda_rtc->rtc_dev),
+				"failed to allocate rtc device\n");
+
+	rda_rtc->rtc_dev->ops = &rda_rtc_ops;
+	rda_rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rda_rtc->rtc_dev->range_max = RTC_TIMESTAMP_END_2127;
+
+	platform_set_drvdata(pdev, rda_rtc);
+
+	return devm_rtc_register_device(rda_rtc->rtc_dev);
+}
+
+static const struct of_device_id rda_rtc_id_table[] = {
+	{ .compatible = "rda,8810pl-rtc", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rda_rtc_id_table);
+
+static struct platform_driver rda_rtc_driver = {
+	.probe = rda_rtc_probe,
+	.driver = {
+		.name = "rtc-rda",
+		.pm = &rda_rtc_pm_ops,
+		.of_match_table = rda_rtc_id_table,
+	},
+};
+module_platform_driver(rda_rtc_driver);
+
+MODULE_AUTHOR("Dang Huynh <dang.huynh@mainlining.org>");
+MODULE_DESCRIPTION("RDA Micro RTC driver");
+MODULE_LICENSE("GPL");

-- 
2.51.0



