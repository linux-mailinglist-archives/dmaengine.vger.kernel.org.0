Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB6E1ABFF5
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506567AbgDPLoz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505202AbgDPKgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Apr 2020 06:36:18 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF93C03C1A8
        for <dmaengine@vger.kernel.org>; Thu, 16 Apr 2020 03:36:14 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by xavier.telenet-ops.be with bizsmtp
        id TNWz2200j4dKHqf01NWzxF; Thu, 16 Apr 2020 12:31:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0001ci-Lk; Thu, 16 Apr 2020 12:30:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1nP-0003z9-KO; Thu, 16 Apr 2020 12:30:59 +0200
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
Subject: [PATCH trivial 1/6] dt-bindings: Fix misspellings of "Analog Devices"
Date:   Thu, 16 Apr 2020 12:30:53 +0200
Message-Id: <20200416103058.15269-2-geert+renesas@glider.be>
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
 .../devicetree/bindings/display/bridge/adi,adv7123.txt        | 4 ++--
 .../devicetree/bindings/display/bridge/adi,adv7511.txt        | 4 ++--
 Documentation/devicetree/bindings/dma/adi,axi-dmac.txt        | 2 +-
 Documentation/devicetree/bindings/iio/dac/ad5755.txt          | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7123.txt b/Documentation/devicetree/bindings/display/bridge/adi,adv7123.txt
index a6b2b2b8f3d9e3a6..d3c2a4914ea2c247 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7123.txt
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7123.txt
@@ -1,5 +1,5 @@
-Analog Device ADV7123 Video DAC
--------------------------------
+Analog Devices ADV7123 Video DAC
+--------------------------------
 
 The ADV7123 is a digital-to-analog converter that outputs VGA signals from a
 parallel video input.
diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
index e8ddec5d9d910a5a..659523f538bfc0ee 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
@@ -1,5 +1,5 @@
-Analog Device ADV7511(W)/13/33/35 HDMI Encoders
------------------------------------------
+Analog Devices ADV7511(W)/13/33/35 HDMI Encoders
+------------------------------------------------
 
 The ADV7511, ADV7511W, ADV7513, ADV7533 and ADV7535 are HDMI audio and video
 transmitters compatible with HDMI 1.4 and DVI 1.0. They support color space
diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt b/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
index b38ee732efa9fd5f..cd17684aaab5bcd3 100644
--- a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
@@ -1,4 +1,4 @@
-Analog Device AXI-DMAC DMA controller
+Analog Devices AXI-DMAC DMA controller
 
 Required properties:
  - compatible: Must be "adi,axi-dmac-1.00.a".
diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
index f0bbd7e1029bd44d..502e1e55adbdebd0 100644
--- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
@@ -1,4 +1,4 @@
-* Analog Device AD5755 IIO Multi-Channel DAC Linux Driver
+* Analog Devices AD5755 IIO Multi-Channel DAC Linux Driver
 
 Required properties:
  - compatible: Has to contain one of the following:
-- 
2.17.1

