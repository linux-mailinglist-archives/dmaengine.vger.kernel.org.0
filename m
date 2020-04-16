Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4501AC97F
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395157AbgDPPXg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 11:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395153AbgDPPXc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Apr 2020 11:23:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A022214D8;
        Thu, 16 Apr 2020 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587050611;
        bh=ZIoIsXIaQkSSo9DwrSDuxVUKUDWHBUIiPNGyWCNpMjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bBTzd9OrYpXGg6ORHDevc26biU8U6Ir9eDMrYVbq0oazh6OMuVNc+sGyIZ47f/7em
         9meS9HRqxJekEbvO8q77PIn9Lnv5yio2WbX+XoF1s/KEVYXbiaOmjD7h4soWVtcrHG
         7bhbBJI+VfwXU79XQ6M8zC9fvfiC7rsu/xGQ/jfU=
Date:   Thu, 16 Apr 2020 16:23:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     alsa-devel@alsa-project.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jaroslav Kysela <perex@perex.cz>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Applied "ASoC: Fix misspellings of "Analog Devices"" to the asoc tree
In-Reply-To:  <20200416103058.15269-7-geert+renesas@glider.be>
Message-Id:  <applied-20200416103058.15269-7-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patch

   ASoC: Fix misspellings of "Analog Devices"

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b938b25f49cdb47397b0215b69cdd5251b4b2f8b Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Apr 2020 12:30:58 +0200
Subject: [PATCH] ASoC: Fix misspellings of "Analog Devices"

According to https://www.analog.com/, the company name is spelled
"Analog Devices".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20200416103058.15269-7-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad1980.c  | 2 +-
 sound/soc/codecs/ad73311.c | 2 +-
 sound/soc/codecs/wm8782.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index c4414c725c1f..43b1337bac37 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -2,7 +2,7 @@
 /*
  * ad1980.c  --  ALSA Soc AD1980 codec support
  *
- * Copyright:	Analog Device Inc.
+ * Copyright:	Analog Devices Inc.
  * Author:	Roy Huang <roy.huang@analog.com>
  * 		Cliff Cai <cliff.cai@analog.com>
  */
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 10daf61f0294..b98bf19f594e 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -2,7 +2,7 @@
 /*
  * ad73311.c  --  ALSA Soc AD73311 codec support
  *
- * Copyright:	Analog Device Inc.
+ * Copyright:	Analog Devices Inc.
  * Author:	Cliff Cai <cliff.cai@analog.com>
  */
 
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index aa5577e364d0..f89855c616eb 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -7,7 +7,7 @@
  * Author: Johannes Stezenbach <js@sig21.net>
  *
  * based on ad73311.c
- * Copyright:	Analog Device Inc.
+ * Copyright:	Analog Devices Inc.
  * Author:	Cliff Cai <cliff.cai@analog.com>
  */
 
-- 
2.20.1

