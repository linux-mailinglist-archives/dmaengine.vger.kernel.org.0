Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C015C47FC6A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbhL0MGc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:32 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbhL0MG3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:29 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mn2eN-1mcccN1wmd-00k7Z1; Mon, 27 Dec 2021 13:06:12 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 00/11] dmaengine: bcm2835: add BCM2711 40-bit DMA support
Date:   Mon, 27 Dec 2021 13:05:34 +0100
Message-Id: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:n8L7CB9vxhx6BvkcavWPpSDOqXrCRecf/OKbFitrcrJ1LEBuu19
 DDCQdw6xc7AIEaNpC/kKauCLmaXi0yEUysqepepwcV92y0VRPHy4gYvTqMsl9Zve09mhIMG
 3HIrqqYpNd0yrsR64Iai068VPhnO0Q3V/1EipqlLuJP9hi9uD2DWiYesbX8bHSRlsxrhL4k
 0p8vN5Q9h9sAfUSyPXMTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9DqQyM+pTk=:rAH/4koWNMxz08AJlZM7uz
 g8CjYi1dLMl3l/7KInabh6YcIgIIrPlUfv/5LXdNaK9HMvHY1hzStQqglEsvam9OaGnQakFLn
 WOtk43U5cKidgDJijpoCvPx+/mySJZHEmvnriu5KWwaLSypozuExeW31dyTnTlvYNlKi7J4Ym
 Vyg0QZP85b8RqNiEnakTDt+oYMzPux321i/bPFZkjuA4XszJx/b2fTRgw0zTrlZBI4cACKV07
 EgWQy2caglOn8eahvM6hlpHuNkRyihtgPE1yl3zAYGKZzqEkCIpQ7r2qV+7fpBfgxgHCH40ai
 G+ubgUU+u63juUW88g6wMTP/BegtauiHSJiUhysPvtZ65j+9LIQWdu4yuglNWFWlJfblax/XQ
 u0VFzGQtgShsdmi56NdbKgNv+48UF4v73GzoLHntlulMzzucUJViuV38N9OSyynmXYII+9gFO
 pZY132trrQfnujQTI5Ge3EIRgxXhImGeKfnY4/5zd+nwztxr/e7V7Ytqv3P5nv2FHHgX2KQ8A
 SCCKs2NBUfEVoxD8slcZSynoNpKXJ+Wjxbw1BuPCRaql93JYcswsdbJ/zAs3/+RLoToyzBusf
 FYvLIhjOKICsqjUPD3b7xpidHovTbaK4CmpMiJH+729pkkqrz0UHk0dLhabHVI6KnuaOQ5saw
 1h4QPZO3CGGi73oTiFhDBF3XC3G/7j2IaH5A2JYv+w7tCG2su9xYNjHA585CxyikE7V+WvfHI
 JF1dtrnJ3zkDsLFs
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
to access the full 4GB of memory on a Pi 4. This patch series serves as a
basis for a discussion (just compile tested, so don't expect anything working)
which include the following points:

* correct DT binding and representation for BCM2711

According to the vendor DTS [1] the 4 DMA channels are connected to SCB.
I'm not sure how this is properly adapted to the mainline DT.

* general implementation approach

The vendor approach mapped all the BCM2835 control block bits to the BCM2711
layout and the rest of the differences are handled by a lot of is_40bit_channel
conditions. An advantage of this is the small amount of changes to the driver.
But on the down side the code is now much harder to understand and maintain.

This series tries to implement this feature in a more cleaner way
while keeping it in the bcm2835-dma driver. Before this series the driver
has ~ 1000 lines and after that ~ 1500 lines.

So the question is this approach acceptable?

Patches 1 - 3 are just clean-ups.

Disclaimer: my knowledge about the DMA controller is very limited

More information:

https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf

[1] - https://github.com/raspberrypi/linux/blob/561deffcf471ba0f7bd48541d06a79d5aa38d297/arch/arm/boot/dts/bcm2711-rpi-ds.dtsi#L47
[2] - https://github.com/raspberrypi/linux/commit/44364bd140b0bc9187c881fbdc4ee358961059d5

Stefan Wahren (11):
  ARM: dts: bcm283x: Update DMA node name per DT schema
  dt-bindings: dma: Convert brcm,bcm2835-dma to json-schema
  dmaengine: bcm2835: Support common dma-channel-mask
  dmaengine: bcm2835: move CB info generation into separate function
  dmaengine: bcm2835: move CB final extra info generation into function
  dmaengine: bcm2835: make address increment platform independent
  dmaengine: bcm2385: drop info parameters
  dmaengine: bcm2835: pass dma_chan to generic functions
  dmaengine: bcm2835: introduce multi platform support
  dmaengine: bcm2835: add BCM2711 40-bit DMA support
  ARM: dts: bcm2711: add bcm2711-dma node

 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |  83 ---
 .../devicetree/bindings/dma/brcm,bcm2835-dma.yaml  | 107 +++
 arch/arm/boot/dts/bcm2711.dtsi                     |  18 +-
 arch/arm/boot/dts/bcm2835-common.dtsi              |   2 +-
 drivers/dma/bcm2835-dma.c                          | 745 +++++++++++++++++----
 5 files changed, 734 insertions(+), 221 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml

-- 
2.7.4

