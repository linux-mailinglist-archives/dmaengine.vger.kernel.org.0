Return-Path: <dmaengine+bounces-5135-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5422DAB3B02
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975357A3B73
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1CD22A814;
	Mon, 12 May 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iext/pAk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8C22A7E0;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061207; cv=none; b=Q+xAnpi4aX5QI7Osyep982MxGH0+mkbdzp4d6nlt8A2KeIqbeZPfMT/J0kL3hfXmzrFHywm/tLHVAuBqwCbUMQrUDTxhFMAAMknGN3lEMp4zeots5C+rX7ZeXeJ8goRHQazUhLaqrIMbRxX2rFO+B56ZcIy4VNMmQn/HdJ9EAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061207; c=relaxed/simple;
	bh=H0sabre+aw5mXu5rl5G+Qxz7mlo3raGsNf3vwwzzlGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfR0hf6snrBhdB4fIR4lqHCnRJ+kpOZY5MxBYhivJfZl2OvZkPYkUbYlLG6oQat1+eDHMd4J7O1aowbi7DYolWL0bK4wj1vtE1xljknJyNb435CyOj4+4aRgbUb7Y8HXBeRldCI1fk7b2izcMu0A/h+d0vDmRb820BAegySZPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iext/pAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3E85C4CEF1;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747061206;
	bh=H0sabre+aw5mXu5rl5G+Qxz7mlo3raGsNf3vwwzzlGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iext/pAkU684MlBjZc+eEEgRPCRWCY0eNR646KYLXaBkymPI9noVOzlw1EasvOib7
	 x2GuIlXDsSkoL/HSz6g4LAwze43+2naUwUtnXAURcmZDJc05jUU0xDIE6zYIVYMgVC
	 HZVKZ7qDA75NnYMZVsEiBHuwOcPKRufHj4NvWGUi538jvFyBP9fORmpRP/zYaB/LkO
	 /MeN1tkYHmseM5GeAdtqmRn2R3w9VBfvQBnmEQ7zBxdtWPullCU5KdtYrQG+U6aCB/
	 1LHO8NrtwXU0Ul8RfjQScQMsNv9bcQAfjQHnK9lt6Nfz5yoPCIRQGLC1ksHWyKNz5T
	 NFfQyxxzri9Sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56C3C3ABDA;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 15:46:46 +0100
Subject: [PATCH v5 3/7] include: linux: move adi-axi-common.h out of fpga
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
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
 Mike Turquette <mturquette@linaro.org>, Xu Yilun <yilun.xu@linux.intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747061206; l=5316;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=mZpbKU1HpaoNJwEl762s/lHmHssmUWkIC/kfsyk1Mvc=;
 b=DMv0wwuKTdGaMV1zCoTRwmJu5MbDefimnulW/vXacmNeJj4ien8jhIJsJPRNlig+YEJXD2+qg
 5p3MSKBT5jCAOWfmq5fS+qFi8gCzL1K+ETnb8os/CC5UeyBa4l3eajg
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The adi-axi-common.h header has some common defines used in various ADI
IPs. However they are not specific for any fpga manager so it's
questionable for the header to live under include/linux/fpga. Hence
let's just move one directory up and update all users.

Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c              | 2 ++
 drivers/dma/dma-axi-dmac.c                | 2 +-
 drivers/hwmon/axi-fan-control.c           | 2 +-
 drivers/iio/adc/adi-axi-adc.c             | 3 +--
 drivers/iio/dac/adi-axi-dac.c             | 2 +-
 drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
 drivers/spi/spi-axi-spi-engine.c          | 2 +-
 include/linux/{fpga => }/adi-axi-common.h | 0
 8 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91a648005b3e6 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -16,6 +16,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/err.h>
 
+#include <linux/adi-axi-common.h>
+
 #define AXI_CLKGEN_V2_REG_RESET		0x40
 #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
 #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 36943b0c6d603cbe38606b0d7bde02535f529a9a..5b06b0dc67ee12017c165bf815fb7c0e1bf5abd8 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -6,6 +6,7 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/adi-axi-common.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -22,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/fpga/adi-axi-common.h>
 
 #include <dt-bindings/dma/axi-dmac.h>
 
diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index 35c862eb158b0909dac64c2e9f51f0f9f0e8bf72..b7bb325c3ad966ed2a93be4dfbf4e20661568509 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -4,9 +4,9 @@
  *
  * Copyright 2019 Analog Devices Inc.
  */
+#include <linux/adi-axi-common.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
-#include <linux/fpga/adi-axi-common.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/interrupt.h>
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c7357601f0f869e57636f00bb1e26c059c3ab15c..87fa18f1ec96782556bdfad08bedb5e7549fb93d 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -6,6 +6,7 @@
  * Copyright 2012-2020 Analog Devices Inc.
  */
 
+#include <linux/adi-axi-common.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
@@ -20,8 +21,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <linux/fpga/adi-axi-common.h>
-
 #include <linux/iio/backend.h>
 #include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/buffer.h>
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index b143f7ed6847277aeb49094627d90e5d95eed71c..581a2fe55a7fb35f1a03f96f3a0e95421d1583e7 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -5,6 +5,7 @@
  *
  * Copyright 2016-2024 Analog Devices Inc.
  */
+#include <linux/adi-axi-common.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
@@ -23,7 +24,6 @@
 #include <linux/regmap.h>
 #include <linux/units.h>
 
-#include <linux/fpga/adi-axi-common.h>
 #include <linux/iio/backend.h>
 #include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/buffer.h>
diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 4259a0db9ff45808eecae28680473292d165d1f6..e720191e74558d15f1b04fa18cf2984299f88809 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -18,10 +18,10 @@
  * - Supports normal polarity. Does not support changing polarity.
  * - On disable, the PWM output becomes low (inactive).
  */
+#include <linux/adi-axi-common.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/fpga/adi-axi-common.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 7c252126b33ea83fe6a6e80c6cb87499243069f5..d498132f1ff6adf20639bf4a21f1687903934bec 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -5,9 +5,9 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/adi-axi-common.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
-#include <linux/fpga/adi-axi-common.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/adi-axi-common.h
similarity index 100%
rename from include/linux/fpga/adi-axi-common.h
rename to include/linux/adi-axi-common.h

-- 
2.49.0



