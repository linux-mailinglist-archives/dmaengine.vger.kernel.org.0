Return-Path: <dmaengine+bounces-5377-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E679AAD5BE4
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B0518900AA
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E505213E98;
	Wed, 11 Jun 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcTktXJv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5B20F062;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658528; cv=none; b=p0x+L01zhudnJ9AnT9CiMJA4RvOgSMiXrv9dZZtNC+VVAqk062RSlDOjlkMVbxWhHGeOeAAGwZpPViwzXySFPvAsXqTcJ/dzIY+fPra/xBdqrXr7UdbAH1GZ/I3mflkqeuE+6gBOeBYrCVzkJjpWf5ZRAljnXlbhdAkOSZU31aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658528; c=relaxed/simple;
	bh=j9/RALxD1SKb25mLlSiuMDxtfhgVeK371XMTkwVz7/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXiD56YQJ/bhaqE9MT8rKtfJAlj+ghExfVmaT7feGtwRjKoKjeycupABxT4yzxgAdymPmMLZXsK1bqF5Ninvpl5PcZVOG88j0KCtGiKQhRfWxJHlQQXGouXbB/Tr7qDhcjbEYC199i+68SF5LXqKeUgXfrw83iTonIf39YLsErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcTktXJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 689ECC4CEE3;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658528;
	bh=j9/RALxD1SKb25mLlSiuMDxtfhgVeK371XMTkwVz7/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VcTktXJvf08cnQr/LDqc8Yqao9ifW2193YPK/Dl7aiOhRnkQyjbSVWH/v84TJ1IPf
	 aY7c8quGCbE16nATg7IZioktEZeJ68vguY1pYP5Nr51BQcJuyZqOrf3MFX8p5KfvhR
	 Ww7fZhAU22AGhATKmgenSZn+2FypW+9POqC4XN0/cqSsp6+9AcMKOmkRN+el4t1RU9
	 VAaVPzeNEJRhj2Ej5XmqsNJ+ELD2LkmFVuGn0e1SMAz7Cyu+lqjRbrLgTodG2WEhEn
	 BjK1AeqLM3/OroN2DN3wP4BZyG2JvkktG3czec7T7T2t5tm09cHCWEcPQJ2mIu73Cq
	 yl8WOj/kO5XfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D66DC71131;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:15:37 +0100
Subject: [PATCH v7 5/7] clk: clk-axi-clkgen: detect axi_clkgen_limits at
 runtime
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-dev-axi-clkgen-limits-v7-5-3e7ff89dc366@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658534; l=4033;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oa8GDBu7Mkar5AH+bEzIfBrJjWKmaurG/C1FZ+6SxNw=;
 b=hJx/cE+R89xiFEIctQ8TKVT0FSinw6GZ4d8ojqOFIfY1ZwFUt7reOsEQfij1la4lVhBEa9oO7
 gxDO/pgX5UaAWHOXkEv+MDOAzt5inBfZ+hKvlNReAI/5ztxTFokTMI0
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

This patch adds support for setting the limits in struct
axi_clkgen_limits  in accordance with fpga speed grade, voltage,
technology and family. This new information is extracted from
two new registers implemented in the ip core that are only available
for core versions higher or equal to 4.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 65 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 2a95f9b220234a1245024a821c50e1eb9c104ac9..f4e96394e9c25c817b09ee0c08751147083f19b7 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -6,6 +6,8 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/adi-axi-common.h>
+#include <linux/bits.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
@@ -29,6 +31,9 @@
 
 #define AXI_CLKGEN_V2_DRP_STATUS_BUSY	BIT(16)
 
+#define ADI_CLKGEN_REG_FPGA_VOLTAGE		0x0140
+#define ADI_CLKGEN_INFO_FPGA_VOLTAGE(val)	((val) & GENMASK(15, 0))
+
 #define MMCM_REG_CLKOUT5_2	0x07
 #define MMCM_REG_CLKOUT0_1	0x08
 #define MMCM_REG_CLKOUT0_2	0x09
@@ -497,6 +502,54 @@ static u8 axi_clkgen_get_parent(struct clk_hw *clk_hw)
 	return parent;
 }
 
+static int axi_clkgen_setup_limits(struct axi_clkgen *axi_clkgen,
+				   struct device *dev)
+{
+	unsigned int tech, family, speed_grade, reg_value;
+
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_INFO, &reg_value);
+	tech = ADI_AXI_INFO_FPGA_TECH(reg_value);
+	family = ADI_AXI_INFO_FPGA_FAMILY(reg_value);
+	speed_grade = ADI_AXI_INFO_FPGA_SPEED_GRADE(reg_value);
+
+	axi_clkgen->limits.fpfd_min = 10000;
+	axi_clkgen->limits.fvco_min = 600000;
+
+	switch (speed_grade) {
+	case ADI_AXI_FPGA_SPEED_1 ... ADI_AXI_FPGA_SPEED_1LV:
+		axi_clkgen->limits.fvco_max = 1200000;
+		axi_clkgen->limits.fpfd_max = 450000;
+		break;
+	case ADI_AXI_FPGA_SPEED_2 ... ADI_AXI_FPGA_SPEED_2LV:
+		axi_clkgen->limits.fvco_max = 1440000;
+		axi_clkgen->limits.fpfd_max = 500000;
+		if (family == ADI_AXI_FPGA_FAMILY_KINTEX || family == ADI_AXI_FPGA_FAMILY_ARTIX) {
+			axi_clkgen_read(axi_clkgen, ADI_CLKGEN_REG_FPGA_VOLTAGE,
+					&reg_value);
+			if (ADI_CLKGEN_INFO_FPGA_VOLTAGE(reg_value) < 950) {
+				axi_clkgen->limits.fvco_max = 1200000;
+				axi_clkgen->limits.fpfd_max = 450000;
+			}
+		}
+		break;
+	case ADI_AXI_FPGA_SPEED_3:
+		axi_clkgen->limits.fvco_max = 1600000;
+		axi_clkgen->limits.fpfd_max = 550000;
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV, "Unknown speed grade %d\n",
+				     speed_grade);
+	};
+
+	/* Overwrite vco limits for ultrascale+ */
+	if (tech == ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS) {
+		axi_clkgen->limits.fvco_max = 1600000;
+		axi_clkgen->limits.fvco_min = 800000;
+	}
+
+	return 0;
+}
+
 static const struct clk_ops axi_clkgen_ops = {
 	.recalc_rate = axi_clkgen_recalc_rate,
 	.determine_rate = axi_clkgen_determine_rate,
@@ -511,6 +564,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 {
 	const struct axi_clkgen_limits *dflt_limits;
 	struct axi_clkgen *axi_clkgen;
+	unsigned int pcore_version;
 	struct clk_init_data init;
 	const char *parent_names[2];
 	const char *clk_name;
@@ -556,7 +610,16 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	memcpy(&axi_clkgen->limits, dflt_limits, sizeof(axi_clkgen->limits));
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION, &pcore_version);
+
+	if (ADI_AXI_PCORE_VER_MAJOR(pcore_version) > 0x04) {
+		ret = axi_clkgen_setup_limits(axi_clkgen, &pdev->dev);
+		if (ret)
+			return ret;
+	} else {
+		memcpy(&axi_clkgen->limits, dflt_limits,
+		       sizeof(axi_clkgen->limits));
+	}
 
 	clk_name = pdev->dev.of_node->name;
 	of_property_read_string(pdev->dev.of_node, "clock-output-names",

-- 
2.49.0



