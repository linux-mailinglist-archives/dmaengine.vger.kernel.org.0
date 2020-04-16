Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C151ABFFC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 13:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506580AbgDPLpS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505193AbgDPKgN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 06:36:13 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Apr 2020 03:36:13 PDT
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75673C0610D5
        for <dmaengine@vger.kernel.org>; Thu, 16 Apr 2020 03:36:13 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by xavier.telenet-ops.be with bizsmtp
        id TNWz2200i4dKHqf01NWzxE; Thu, 16 Apr 2020 12:31:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0001cj-Ll; Thu, 16 Apr 2020 12:30:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0003z7-JX; Thu, 16 Apr 2020 12:30:59 +0200
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
Subject: [PATCH trivial 0/6] Fix misspellings of "Analog Devices"
Date:   Thu, 16 Apr 2020 12:30:52 +0200
Message-Id: <20200416103058.15269-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

	Hi all,

In several files the company also known as ADI is spelled as "Analog
Device".  However, according to https://www.analog.com/, the company
name is spelled "Analog Devices".

Hence this patch series, one per subsystem, fixes these misspellings.

Thanks for your comments!

Geert Uytterhoeven (6):
  dt-bindings: Fix misspellings of "Analog Devices"
  dma: Fix misspelling of "Analog Devices"
  drm: Fix misspellings of "Analog Devices"
  iio: Fix misspellings of "Analog Devices"
  ALSA: Fix misspellings of "Analog Devices"
  ASoC: Fix misspellings of "Analog Devices"

 .../devicetree/bindings/display/bridge/adi,adv7123.txt        | 4 ++--
 .../devicetree/bindings/display/bridge/adi,adv7511.txt        | 4 ++--
 Documentation/devicetree/bindings/dma/adi,axi-dmac.txt        | 2 +-
 Documentation/devicetree/bindings/iio/dac/ad5755.txt          | 2 +-
 drivers/dma/Kconfig                                           | 2 +-
 drivers/gpu/drm/bridge/adv7511/Kconfig                        | 2 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                           | 2 +-
 drivers/gpu/drm/tegra/fb.c                                    | 2 +-
 drivers/iio/adc/ad7791.c                                      | 2 +-
 drivers/iio/trigger/iio-trig-hrtimer.c                        | 2 +-
 drivers/staging/iio/Documentation/overview.txt                | 2 +-
 sound/isa/ad1816a/ad1816a.c                                   | 2 +-
 sound/pci/ac97/ac97_patch.c                                   | 2 +-
 sound/pci/hda/Kconfig                                         | 4 ++--
 sound/soc/codecs/ad1980.c                                     | 2 +-
 sound/soc/codecs/ad73311.c                                    | 2 +-
 sound/soc/codecs/wm8782.c                                     | 2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
