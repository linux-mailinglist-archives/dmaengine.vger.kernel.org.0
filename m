Return-Path: <dmaengine+bounces-5378-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090BAAD5BC8
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E44516C971
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFF3220F20;
	Wed, 11 Jun 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GraR6YWa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D5211293;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658529; cv=none; b=mmKoxM1Syr8RbVAydeQ2fYkbBY8JzZMbSUBSa33oW/9byebacvmFm0PFt73+BuuMV1A4FNO4Hy+gWhWKn9ZHxF67OZ5w/ZYBDlu3Dy/h0DtTcrNJHqAQoY/DQEiyKiTHC25B0bXfAhYLmr7hZrHX7RCFb/ap7SzwWyjCwmyf/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658529; c=relaxed/simple;
	bh=k04+yFYhyix5iovoGyw4Z+sUh6381n5yhJqlsKR1SpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZnqBLn6YmQi/qaQ8dO1/GcItdYKh95/oSAq7bMIhHfYTkMNLaqHv7vVAOQpfx6SN11LGuSRzqCIlRC+ozHEo+z+rF0KQiyzAsvC9iyOgU81AXrgzq72udN8ZBzKZq7ft5CXsNly4q6ivUrP2OJVHqmDjm4j03cRjykEzxLYZV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GraR6YWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 966C4C4CEEF;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658528;
	bh=k04+yFYhyix5iovoGyw4Z+sUh6381n5yhJqlsKR1SpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GraR6YWaY58wFeErPEorm+z9HuGUfQ1xHElfZ90TwmswCxm4cmEHeZ/b9eYphCURb
	 sczFyhrDhQN/c3fGZH4E+aVqsIu/qyo2PJ+egE6k677se8el5AOqsdsjhJlzg4CChE
	 HyqKi7K/R3V2QHaTtv1yFbLnDR4o+WFWTG3VIHOe3d3a4zr22oy2maxnEB4VSgopFM
	 ne1E1gFvtkboVpc8Cp+3AxsRJIhGVZll+ZGfrsWyx6Et75xRglSES18wufsg2fDhsT
	 uyzCLbV8X3+fpdUFXxO62JKdaERWzsDopGsJmPAdydZFuUEg5xpGpyozCVp8LwKNOX
	 R4WrB48waNPoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EAC71137;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:15:39 +0100
Subject: [PATCH v7 7/7] clk: clk-axi-clkgen: fix coding style issues
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-dev-axi-clkgen-limits-v7-7-3e7ff89dc366@analog.com>
References: <20250611-dev-axi-clkgen-limits-v7-0-3e7ff89dc366@analog.com>
In-Reply-To: <20250611-dev-axi-clkgen-limits-v7-0-3e7ff89dc366@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Mike Turquette <mturquette@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658534; l=8920;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=sorHKMrAW+F3I7VGWSk76fxF6xnhAstzzbm7Y/HmTtw=;
 b=Nigpkwfqk9+9ZdoAIPKMwIRulpX4OzWeE0X9ugMT3oTDpjGWe/CKfgxCkOpij8oCQpa+sdsP4
 sLxFm9ItelRA5tfgloKsROLbtJjp+gFI68+Oc+O3nFrA0YlpmE7sY+I
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

This is just cosmetics and so no functional changes intended.

While at it, sort header in alphabetical order.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 81 ++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 63951209c460f26ed3940879da536e31ae530188..2bb52c4dc7be5167380c1d158d96c7618d16c558 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -8,15 +8,15 @@
 
 #include <linux/adi-axi-common.h>
 #include <linux/bits.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/slab.h>
+#include <linux/err.h>
 #include <linux/io.h>
-#include <linux/of.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #define AXI_CLKGEN_V2_REG_RESET		0x40
 #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
@@ -96,7 +96,7 @@ static uint32_t axi_clkgen_lookup_filter(unsigned int m)
 	}
 }
 
-static const uint32_t axi_clkgen_lock_table[] = {
+static const u32 axi_clkgen_lock_table[] = {
 	0x060603e8, 0x060603e8, 0x080803e8, 0x0b0b03e8,
 	0x0e0e03e8, 0x111103e8, 0x131303e8, 0x161603e8,
 	0x191903e8, 0x1c1c03e8, 0x1f1f0384, 0x1f1f0339,
@@ -108,7 +108,7 @@ static const uint32_t axi_clkgen_lock_table[] = {
 	0x1f1f012c, 0x1f1f0113, 0x1f1f0113, 0x1f1f0113,
 };
 
-static uint32_t axi_clkgen_lookup_lock(unsigned int m)
+static u32 axi_clkgen_lookup_lock(unsigned int m)
 {
 	if (m < ARRAY_SIZE(axi_clkgen_lock_table))
 		return axi_clkgen_lock_table[m];
@@ -130,8 +130,9 @@ static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
 };
 
 static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
-	unsigned long fin, unsigned long fout,
-	unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
+				   unsigned long fin, unsigned long fout,
+				   unsigned int *best_d, unsigned int *best_m,
+				   unsigned int *best_dout)
 {
 	unsigned long d, d_min, d_max, _d_min, _d_max;
 	unsigned long m, m_min, m_max;
@@ -198,9 +199,9 @@ struct axi_clkgen_div_params {
 };
 
 static void axi_clkgen_calc_clk_params(unsigned int divider,
-	unsigned int frac_divider, struct axi_clkgen_div_params *params)
+				       unsigned int frac_divider,
+				       struct axi_clkgen_div_params *params)
 {
-
 	memset(params, 0x0, sizeof(*params));
 
 	if (divider == 1) {
@@ -228,7 +229,7 @@ static void axi_clkgen_calc_clk_params(unsigned int divider,
 		if (params->edge == 0 || frac_divider == 1)
 			params->low--;
 		if (((params->edge == 0) ^ (frac_divider == 1)) ||
-			(divider == 2 && frac_divider == 1))
+		    (divider == 2 && frac_divider == 1))
 			params->frac_wf_f = 1;
 
 		params->frac_phase = params->edge * 4 + frac_divider / 2;
@@ -236,13 +237,13 @@ static void axi_clkgen_calc_clk_params(unsigned int divider,
 }
 
 static void axi_clkgen_write(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int val)
+			     unsigned int reg, unsigned int val)
 {
 	writel(val, axi_clkgen->base + reg);
 }
 
 static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int *val)
+			    unsigned int reg, unsigned int *val)
 {
 	*val = readl(axi_clkgen->base + reg);
 }
@@ -263,7 +264,7 @@ static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
 }
 
 static int axi_clkgen_mmcm_read(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int *val)
+				unsigned int reg, unsigned int *val)
 {
 	unsigned int reg_val;
 	int ret;
@@ -287,7 +288,8 @@ static int axi_clkgen_mmcm_read(struct axi_clkgen *axi_clkgen,
 }
 
 static int axi_clkgen_mmcm_write(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int val, unsigned int mask)
+				 unsigned int reg, unsigned int val,
+				 unsigned int mask)
 {
 	unsigned int reg_val = 0;
 	int ret;
@@ -308,8 +310,7 @@ static int axi_clkgen_mmcm_write(struct axi_clkgen *axi_clkgen,
 	return 0;
 }
 
-static void axi_clkgen_mmcm_enable(struct axi_clkgen *axi_clkgen,
-	bool enable)
+static void axi_clkgen_mmcm_enable(struct axi_clkgen *axi_clkgen, bool enable)
 {
 	unsigned int val = AXI_CLKGEN_V2_RESET_ENABLE;
 
@@ -325,31 +326,31 @@ static struct axi_clkgen *clk_hw_to_axi_clkgen(struct clk_hw *clk_hw)
 }
 
 static void axi_clkgen_set_div(struct axi_clkgen *axi_clkgen,
-	unsigned int reg1, unsigned int reg2, unsigned int reg3,
-	struct axi_clkgen_div_params *params)
+			       unsigned int reg1, unsigned int reg2,
+			       unsigned int reg3,
+			       struct axi_clkgen_div_params *params)
 {
 	axi_clkgen_mmcm_write(axi_clkgen, reg1,
-		(params->high << 6) | params->low, 0xefff);
+			      (params->high << 6) | params->low, 0xefff);
 	axi_clkgen_mmcm_write(axi_clkgen, reg2,
-		(params->frac << 12) | (params->frac_en << 11) |
-		(params->frac_wf_r << 10) | (params->edge << 7) |
-		(params->nocount << 6), 0x7fff);
+			      (params->frac << 12) | (params->frac_en << 11) |
+			      (params->frac_wf_r << 10) | (params->edge << 7) |
+			      (params->nocount << 6), 0x7fff);
 	if (reg3 != 0) {
 		axi_clkgen_mmcm_write(axi_clkgen, reg3,
-			(params->frac_phase << 11) | (params->frac_wf_f << 10), 0x3c00);
+				      (params->frac_phase << 11) | (params->frac_wf_f << 10),
+				      0x3c00);
 	}
 }
 
-static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
-	unsigned long rate, unsigned long parent_rate)
+static int axi_clkgen_set_rate(struct clk_hw *clk_hw, unsigned long rate,
+			       unsigned long parent_rate)
 {
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
 	unsigned int d, m, dout;
 	struct axi_clkgen_div_params params;
-	uint32_t power = 0;
-	uint32_t filter;
-	uint32_t lock;
+	u32 power = 0, filter, lock;
 
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
@@ -369,22 +370,22 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 
 	axi_clkgen_calc_clk_params(dout >> 3, dout & 0x7, &params);
 	axi_clkgen_set_div(axi_clkgen,  MMCM_REG_CLKOUT0_1, MMCM_REG_CLKOUT0_2,
-		MMCM_REG_CLKOUT5_2, &params);
+			   MMCM_REG_CLKOUT5_2, &params);
 
 	axi_clkgen_calc_clk_params(d, 0, &params);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_CLK_DIV,
-		(params.edge << 13) | (params.nocount << 12) |
-		(params.high << 6) | params.low, 0x3fff);
+			      (params.edge << 13) | (params.nocount << 12) |
+			      (params.high << 6) | params.low, 0x3fff);
 
 	axi_clkgen_calc_clk_params(m >> 3, m & 0x7, &params);
 	axi_clkgen_set_div(axi_clkgen,  MMCM_REG_CLK_FB1, MMCM_REG_CLK_FB2,
-		MMCM_REG_CLKOUT6_2, &params);
+			   MMCM_REG_CLKOUT6_2, &params);
 
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK1, lock & 0x3ff, 0x3ff);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK2,
-		(((lock >> 16) & 0x1f) << 10) | 0x1, 0x7fff);
+			      (((lock >> 16) & 0x1f) << 10) | 0x1, 0x7fff);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK3,
-		(((lock >> 24) & 0x1f) << 10) | 0x3e9, 0x7fff);
+			      (((lock >> 24) & 0x1f) << 10) | 0x3e9, 0x7fff);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_FILTER1, filter >> 16, 0x9900);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_FILTER2, filter, 0x9900);
 
@@ -413,7 +414,7 @@ static int axi_clkgen_determine_rate(struct clk_hw *hw,
 }
 
 static unsigned int axi_clkgen_get_div(struct axi_clkgen *axi_clkgen,
-	unsigned int reg1, unsigned int reg2)
+				       unsigned int reg1, unsigned int reg2)
 {
 	unsigned int val1, val2;
 	unsigned int div;
@@ -440,7 +441,7 @@ static unsigned int axi_clkgen_get_div(struct axi_clkgen *axi_clkgen,
 }
 
 static unsigned long axi_clkgen_recalc_rate(struct clk_hw *clk_hw,
-	unsigned long parent_rate)
+					    unsigned long parent_rate)
 {
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	unsigned int d, m, dout;
@@ -448,9 +449,9 @@ static unsigned long axi_clkgen_recalc_rate(struct clk_hw *clk_hw,
 	unsigned int val;
 
 	dout = axi_clkgen_get_div(axi_clkgen, MMCM_REG_CLKOUT0_1,
-		MMCM_REG_CLKOUT0_2);
+				  MMCM_REG_CLKOUT0_2);
 	m = axi_clkgen_get_div(axi_clkgen, MMCM_REG_CLK_FB1,
-		MMCM_REG_CLK_FB2);
+			       MMCM_REG_CLK_FB2);
 
 	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_DIV, &val);
 	if (val & MMCM_CLK_DIV_NOCOUNT)
@@ -623,7 +624,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 
 	clk_name = pdev->dev.of_node->name;
 	of_property_read_string(pdev->dev.of_node, "clock-output-names",
-		&clk_name);
+				&clk_name);
 
 	init.name = clk_name;
 	init.ops = &axi_clkgen_ops;

-- 
2.49.0



