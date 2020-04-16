Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAC1ABFEF
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506472AbgDPLoN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505206AbgDPKgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 06:36:18 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF080C03C1AA
        for <dmaengine@vger.kernel.org>; Thu, 16 Apr 2020 03:36:14 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by xavier.telenet-ops.be with bizsmtp
        id TNWz2200l4dKHqf01NWzxG; Thu, 16 Apr 2020 12:31:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0001cq-O4; Thu, 16 Apr 2020 12:30:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0003zI-Me; Thu, 16 Apr 2020 12:30:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial 4/6] iio: Fix misspellings of "Analog Devices"
Date:   Thu, 16 Apr 2020 12:30:56 +0200
Message-Id: <20200416103058.15269-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416103058.15269-1-geert+renesas@glider.be>
References: <20200416103058.15269-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

According to https://www.analog.com/, the company name is spelled
"Analog Devices".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iio/adc/ad7791.c                       | 2 +-
 drivers/iio/trigger/iio-trig-hrtimer.c         | 2 +-
 drivers/staging/iio/Documentation/overview.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index abb2393926317087..70bfc41052db2740 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -444,5 +444,5 @@ static struct spi_driver ad7791_driver = {
 module_spi_driver(ad7791_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Analog Device AD7787/AD7788/AD7789/AD7790/AD7791 ADC driver");
+MODULE_DESCRIPTION("Analog Devices AD7787/AD7788/AD7789/AD7790/AD7791 ADC driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index a5e670726717f0d8..f59bf8d585866ea2 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) Intuitive Aerial AB
  * Written by Marten Svanfeldt, marten@intuitiveaerial.com
- * Copyright (C) 2012, Analog Device Inc.
+ * Copyright (C) 2012, Analog Devices Inc.
  *	Author: Lars-Peter Clausen <lars@metafoo.de>
  * Copyright (C) 2015, Intel Corporation
  */
diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
index 43f92b06bc3e5574..ebdc64f451d7c798 100644
--- a/drivers/staging/iio/Documentation/overview.txt
+++ b/drivers/staging/iio/Documentation/overview.txt
@@ -34,7 +34,7 @@ turned on or off (if possible) via sysfs interfaces.
 fifo / ring buffers on the sensor chip.  These greatly reduce the load
 on the host CPU by buffering relatively large numbers of data samples
 based on an internal sampling clock. Examples include VTI SCA3000
-series and Analog Device ADXL345 accelerometers.  Each buffer supports
+series and Analog Devices ADXL345 accelerometers.  Each buffer supports
 polling to establish when data is available.
 
 * Trigger and software buffer support. In many data analysis
-- 
2.17.1

