Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937152BB50
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfE0UPH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 16:15:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41797 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfE0UPH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 May 2019 16:15:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so2681321wrm.8;
        Mon, 27 May 2019 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXahGaBrkqUKt9hjO+RHzxhaODt54utR6Qk5vi9eCaQ=;
        b=owUyFwlXphbnCdPceA7pSRSRDBr3F1cc+EYPPm79e3Mf5qHXv14oDJt46X6NAUyIRR
         G8rIbeApWCEHEMmhlRx3sXskvz5BaS8egS4Oe3eTA7Ys+yuNij75fEoMQUizaMmwhxBD
         t8vJk+fQL+MCUNgL065d067WNqHgghWlYg2ur8Q/sOYgpDjMMkPOTouS7+pZphyN091F
         AEsIEBlrTAAuj60d8VMJv1XBSDROb2vq/4aMIo8KqsQ1aVp92V7++kk+PL/L39FQJifY
         hgTsxXS33KvZVSk33Hw64di1otY89d/aw5+eSOpGEVTZFs4aQbB2d+qHXBUr9wnla9jo
         sP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXahGaBrkqUKt9hjO+RHzxhaODt54utR6Qk5vi9eCaQ=;
        b=rHbJRNzilttVTAwCdxzQvoE1BTcBFascxyrKJUdTofPyn0HC/QZqY3v7Df34HNAmQv
         pZlvePpFHgJ3/NBofq7GBeumMAUnrNOUGpfYoikqlM6yuEJZ6LHmg3OdoBUx621hcImg
         Uqk4a0uKoJ+SOcieDDIaEqOARV3wJRkRTijkQTGE+zNHikaRksQosuCiMfcai2yJM3VY
         2qRzA0rC3njxSJxIoaKdGJkpStG2vhjJdKMpPZ/m/ceVk9ybsTgv4MqL7PXG1HXratYU
         kgFJg3L4+f0fZDzlUDcTuWKLgKl/vIR8AQQZUiizzjnDFtGtsx0hyESdOLPbtMEIviii
         wyvw==
X-Gm-Message-State: APjAAAWeKWXwvVGr/22l6PcR8sz75OWGiC86zRiq16GMtvI4UUXbQhD7
        r9zepb5aeCEoWKa0/yhq+f8=
X-Google-Smtp-Source: APXvYqxEJpHEqBC0rATeo4Jp5k5kbxhG9dMgCDzdVg4d/5zHBKkoNf1NUwOJp8BMU3gPMRXlDfRdQg==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr75764699wrv.52.1558988105323;
        Mon, 27 May 2019 13:15:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id i27sm347146wmb.16.2019.05.27.13.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:15:04 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/7] Allwinner H6 DMA support
Date:   Mon, 27 May 2019 22:14:52 +0200
Message-Id: <20190527201459.20130-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This series has been first proposed by Jernej Skrabec[1].
As this series is mandatory for SPDIF/I2S support and because he is
busy on Cedrus stuff. I asked him to make the minor change requested
and repost it.
Authorship remains to him.

I have tested this series with SPDIF driver and added a patch to enable
DMA_SUN6I_CONFIG for arm64.

Original Post:
"
DMA engine engine on H6 almost the same as on older SoCs. The biggest
difference is that it has slightly rearranged bits in registers and
it needs additional clock, probably due to iommu.

These patches were tested with I2S connected to HDMI. I2S needs
additional patches which will be sent later.

Please take a look.

Best regards,
Jernej
"

Thanks,
Clément

Changes since v2:
 - Drop the change of "dma-request" default value

Changes since v1:
 - Enable DMA_SUN6I in arm64 defconfig
 - Change mbus_clk to has_mbus_clk
 - Collect Rob H. reviewed-by

Clément Péron (1):
  arm64: defconfig: enable Allwinner DMA drivers

Jernej Skrabec (6):
  dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
  dmaengine: sun6i: Add a quirk for additional mbus clock
  dmaengine: sun6i: Add a quirk for setting DRQ fields
  dmaengine: sun6i: Add a quirk for setting mode fields
  dmaengine: sun6i: Add support for H6 DMA
  arm64: dts: allwinner: h6: Add DMA node

 .../devicetree/bindings/dma/sun6i-dma.txt     |   9 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  12 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/dma/sun6i-dma.c                       | 147 +++++++++++++-----
 4 files changed, 132 insertions(+), 37 deletions(-)

-- 
2.20.1

