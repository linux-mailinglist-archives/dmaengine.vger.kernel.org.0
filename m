Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159D65B3A08
	for <lists+dmaengine@lfdr.de>; Fri,  9 Sep 2022 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiIIN66 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Sep 2022 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiIIN6v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Sep 2022 09:58:51 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BAD50710;
        Fri,  9 Sep 2022 06:58:38 -0700 (PDT)
Received: from robin.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 8E74A26EFE9;
        Fri,  9 Sep 2022 15:51:03 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, er <povik+lin@cutebit.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/10] Apple M1 Pro/Max/Ultra device trees
Date:   Fri,  9 Sep 2022 15:50:53 +0200
Message-Id: <20220909135103.98179-1-j@jannau.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hej,

this series contains device trees for Apple's M1 Pro, Max and Ultra SoCs
and devices based on these SoCs.

Quoting from the main commit:

These SoCs are found in Apple devices with M1 Pro (t6000), M1 Max
(t6001) and M1 Ultra (t6002).

t6000 is a cut-down version of t6001, so the former just includes the
latter and disables the missing bits (This is currently just one PMGR
node and all of its domains.

t6002 is two connected t6001 dies. The implementation seems to use
t6001 with blocks disabled (mostly on the second die). MMIO addresses on
the second die have a constant offset. The interrupt controller is
multi-die aware. This setup can be represented in the device tree with
two top level "soc" nodes. The MMIO offset is applied via "ranges" and
devices are included with preproceesor macros to make the node labels
unique and to specify the die number for the interrupt definition.

Device nodes are distributed over dtsi files based on whether they are
present on both dies or just on the first die. The only execption is the
NVMe controller which resides on the second die. Its nodes are in a
separate file.

I'm open for ideas how to improve the preprocessor handling but I'm
convinced that it should be avoided to duplicate the device nodes
manually.

For dts verification this series depends on t6000-dart support
(https://lore.kernel.org/linux-iommu/20220901012519.7167-1-j@jannau.net/T/#t)
expected to be queued for v6.1.

Even with the t6000-dart support t600x devices are not terribly useful
in upstream. There is no input device support. The laptop's keyboard
and touchpad are missing SPI and HID over SPI drivers. The dwc3
USB-C ports are not yet added since they require special handling
after disconnect. The PCIe based USB xhci controller in the Mac Studio
requires firmware downloaded in a similar way as USB_XHCI_PCI_RENESAS.

For dependency handling this series contains a fix for the aic
dt-bindings and carries mostly identical device tree additions for M1
and M1 Pro/Max/Ultra as part of audio support.

The series passes dtbs_check with 2 additional bindings already
submitted elsewhere:
- "ASoC: Add Apple MCA I2S transceiver bindings" (6ed462d1c11675)
  in sound/for-next
- "dt-bindings: iommu: dart: add t6000 compatible"
  https://lore.kernel.org/linux-iommu/20220901012519.7167-2-j@jannau.net/

New bindings passes dt_binding_check


Hector Martin (3):
  arm64: dts: apple: Fix j45x model years
  arm64: dts: apple: Add initial t6000/t6001/t6002 DTs
  arm64: dts: apple: Add J314 and J316 devicetrees

Janne Grunau (6):
  dt-bindings: apple,aic: Fix required item "apple,fiq-index" in
    affinity description
  dt-bindings: dma: apple,admac: Add iommus and power-domains properties
  dt-bindings: apple,aic2: Add CPU PMU per-cpu pseudo-interrupts
  dt-bindings: arm: apple: Add t6001/t6002 Mac Studio compatibles
  arm64: dts: apple: Add J375 devicetrees
  arm64: dts: apple: t600x: Add MCA and its support

Martin Povišer (1):
  arm64: dts: apple: t8103: Add MCA and its support

 .../devicetree/bindings/arm/apple.yaml        |   11 +-
 .../devicetree/bindings/dma/apple,admac.yaml  |    7 +
 .../interrupt-controller/apple,aic.yaml       |    2 +-
 .../interrupt-controller/apple,aic2.yaml      |   29 +
 arch/arm64/boot/dts/apple/Makefile            |    6 +
 arch/arm64/boot/dts/apple/multi-die-cpp.h     |   23 +
 arch/arm64/boot/dts/apple/t6000-j314s.dts     |   18 +
 arch/arm64/boot/dts/apple/t6000-j316s.dts     |   18 +
 arch/arm64/boot/dts/apple/t6000.dtsi          |   18 +
 arch/arm64/boot/dts/apple/t6001-j314c.dts     |   18 +
 arch/arm64/boot/dts/apple/t6001-j316c.dts     |   18 +
 arch/arm64/boot/dts/apple/t6001-j375c.dts     |   18 +
 arch/arm64/boot/dts/apple/t6001.dtsi          |   63 +
 arch/arm64/boot/dts/apple/t6002-j375d.dts     |   50 +
 arch/arm64/boot/dts/apple/t6002.dtsi          |  173 ++
 arch/arm64/boot/dts/apple/t600x-common.dtsi   |  137 ++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi     |  360 +++
 arch/arm64/boot/dts/apple/t600x-dieX.dtsi     |  103 +
 .../arm64/boot/dts/apple/t600x-gpio-pins.dtsi |   45 +
 .../arm64/boot/dts/apple/t600x-j314-j316.dtsi |  114 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi     |  119 +
 arch/arm64/boot/dts/apple/t600x-nvme.dtsi     |   42 +
 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi     | 2012 +++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j456.dts      |    2 +-
 arch/arm64/boot/dts/apple/t8103-j457.dts      |    2 +-
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     |    4 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |   73 +
 27 files changed, 3481 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/multi-die-cpp.h
 create mode 100644 arch/arm64/boot/dts/apple/t6000-j314s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6000-j316s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j314c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j316c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j375c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6002-j375d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6002.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-die0.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-dieX.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-j375.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-nvme.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi

-- 
2.35.1

