Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40A81ABE62
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505244AbgDPKrZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505252AbgDPKgY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 06:36:24 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A054C061A41
        for <dmaengine@vger.kernel.org>; Thu, 16 Apr 2020 03:36:24 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by andre.telenet-ops.be with bizsmtp
        id TNWz2200b4dKHqf01NX0RZ; Thu, 16 Apr 2020 12:31:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0001cw-Ou; Thu, 16 Apr 2020 12:30:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0003zL-Nb; Thu, 16 Apr 2020 12:30:59 +0200
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
Subject: [PATCH trivial 5/6] ALSA: Fix misspellings of "Analog Devices"
Date:   Thu, 16 Apr 2020 12:30:57 +0200
Message-Id: <20200416103058.15269-6-geert+renesas@glider.be>
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
 sound/isa/ad1816a/ad1816a.c | 2 +-
 sound/pci/ac97/ac97_patch.c | 2 +-
 sound/pci/hda/Kconfig       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index ce4c8ba2fa9873e7..ca18fe3ff8a59a9f 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(clockfreq, "Clock frequency for ad1816a driver (default = 0).")
 static const struct pnp_card_device_id snd_ad1816a_pnpids[] = {
 	/* Analog Devices AD1815 */
 	{ .id = "ADS7150", .devs = { { .id = "ADS7150" }, { .id = "ADS7151" } } },
-	/* Analog Device AD1816? */
+	/* Analog Devices AD1816? */
 	{ .id = "ADS7180", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } } },
 	/* Analog Devices AD1816A - added by Kenneth Platz <kxp@atl.hp.com> */
 	{ .id = "ADS7181", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } } },
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index ebf926728c5f84af..45ef0f52ec55b803 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -1356,7 +1356,7 @@ static int patch_cx20551(struct snd_ac97 *ac97)
 }
 
 /*
- * Analog Device AD18xx, AD19xx codecs
+ * Analog Devices AD18xx, AD19xx codecs
  */
 #ifdef CONFIG_PM
 static void ad18xx_resume(struct snd_ac97 *ac97)
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index e1d3082a4fe93153..7ba542e45a3d7f88 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -99,10 +99,10 @@ comment "Set to Y if you want auto-loading the codec driver"
 	depends on SND_HDA=y && SND_HDA_CODEC_REALTEK=m
 
 config SND_HDA_CODEC_ANALOG
-	tristate "Build Analog Device HD-audio codec support"
+	tristate "Build Analog Devices HD-audio codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y or M here to include Analog Device HD-audio codec support in
+	  Say Y or M here to include Analog Devices HD-audio codec support in
 	  snd-hda-intel driver, such as AD1986A.
 
 comment "Set to Y if you want auto-loading the codec driver"
-- 
2.17.1

