Return-Path: <dmaengine+bounces-5663-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3AAEBAC2
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09AF1C22D58
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4E2E92BC;
	Fri, 27 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuffVo3H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FC2E7F00;
	Fri, 27 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036355; cv=none; b=E20HFoco09kk3e5xZGeAJ8NUNS9jQ9hrUBCyZm5IBfFm0oRQ5SGEaetyYMKPXiJl1opVW+z5CClWOkAD7plyF3CKlOxAX8+QDOlSk+H/7nH++KeT1Zo6ekda3USrnpvIOcZYbK6bv1i9dTj0NgOp64nll9Fbu75yFq4GrsoYs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036355; c=relaxed/simple;
	bh=QIiuXtrBlH8VQb4Kh0Au+xvFFn8KUJ1zYPChv1e6lKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDmNnknrVoIICB5kBJRFNjknfdk1pJprzhIz27nCv/IbjOb1zvm8lnBSu3cIyX0rA72p3g8No2f/N4CvqlEaU/UqXr68pir17qbXYpiMV5Ot/regeZB9pN6jbSsika/VRWUzgLa7f+phlpMVhKrmcWHT52pAcaMEv3x5+hsosAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuffVo3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC031C4CEF1;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036354;
	bh=QIiuXtrBlH8VQb4Kh0Au+xvFFn8KUJ1zYPChv1e6lKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tuffVo3Hv7DYPTMHqwdQHWe7ai0DW27zK0b+g4k+jvFlF/qs+HbZsMHA8+3M0EpQa
	 WcYXTXmWsxq4RTW70tbMwBJFEemBybm/1xanJeD2X5wDj9IELIR0w8Hx0/x7y+12BT
	 zq3Ynpxk5c9A6jSGLE/6cLEietQwgFHAcIPAH6zTyPgy+Suyo0e8xZ6PNC6XECtjeE
	 JhD5aySRmIW0VoBn0673YPOv3tT6bqnH/EMEt6n22mQ9SIehQV8+3+5Gnmx/m6THRR
	 prJ/T8tnat0HLPEz4YQPVaB9H5vOQBFNoj1ApQYVksCoLzEFOTHK6f9OwFTWc0R0+R
	 xdDLoVs791hbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9591C83013;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Jun 2025 15:59:12 +0100
Subject: [PATCH RESEND v7 3/7] include: linux: move adi-axi-common.h out of
 fpga
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-dev-axi-clkgen-limits-v7-3-e4f3b1f76189@analog.com>
References: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
In-Reply-To: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036364; l=4922;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yfuzhyQ99zS15NVAtmX0gWwBIRxX8p3l95YLPlSA540=;
 b=LtNaI6B68AhIWbqgUjz4SvWCFY9u0CxcSXA759DEmgFeWHQXIVOL8KODjOVItGZuHPQM1yRIN
 rtcz0CjyZ8AD7vpN6xU1I4GOuUzwfY/9Tj0YH4bWTkvVfdhRez1RkUw
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
Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c                | 2 +-
 drivers/hwmon/axi-fan-control.c           | 2 +-
 drivers/iio/adc/adi-axi-adc.c             | 3 +--
 drivers/iio/dac/adi-axi-dac.c             | 2 +-
 drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
 drivers/spi/spi-axi-spi-engine.c          | 2 +-
 include/linux/{fpga => }/adi-axi-common.h | 0
 7 files changed, 6 insertions(+), 7 deletions(-)

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



