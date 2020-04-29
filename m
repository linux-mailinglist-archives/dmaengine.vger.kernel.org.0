Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885701BEAA0
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 23:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgD2V5H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 17:57:07 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:39061 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2V5H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 17:57:07 -0400
X-IronPort-AV: E=Sophos;i="5.73,333,1583161200"; 
   d="scan'208";a="46009187"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Apr 2020 06:57:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D547F40ECBAC;
        Thu, 30 Apr 2020 06:57:00 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 00/18]  Add R8A7742/RZG1H board support
Date:   Wed, 29 Apr 2020 22:56:37 +0100
Message-Id: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

This patch set adds initial board support for R8A7742 SoC,
enabling R8A7742 arch in defconfigs with initial dtsi.

Cheers,
--Prabhakar

Lad Prabhakar (18):
  soc: renesas: Add Renesas R8A7742 config option
  ARM: shmobile: defconfig: Enable r8a7742 SoC
  ARM: multi_v7_defconfig: Enable r8a7742 SoC
  ARM: debug-ll: Add support for r8a7742
  dt-bindings: pinctrl: sh-pfc: Document r8a7742 PFC support
  pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
  ARM: dts: r8a7742: Initial SoC device tree
  dt-bindings: irqchip: renesas-irqc: Document r8a7742 bindings
  ARM: dts: r8a7742: Add IRQC support
  dt-bindings: rcar-dmac: Document r8a7742 support
  ARM: dts: r8a7742: Add SYS-DMAC support
  dt-bindings: serial: renesas,scif: Document r8a7742 bindings
  dt-bindings: serial: renesas,scifa: Document r8a7742 bindings
  dt-bindings: serial: renesas,scifb: Document r8a7742 bindings
  dt-bindings: serial: renesas,hscif: Document r8a7742 bindings
  ARM: dts: r8a7742: Add [H]SCIF{A|B} support
  dt-bindings: gpio: rcar: Add r8a7742 (RZ/G1H) support
  ARM: dts: r8a7742: Add GPIO support

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   1 +
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   1 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   1 +
 .../devicetree/bindings/serial/renesas,scifa.yaml  |   1 +
 .../devicetree/bindings/serial/renesas,scifb.yaml  |   1 +
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/boot/dts/r8a7742.dtsi                     | 939 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/shmobile_defconfig                |   1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |   4 +
 drivers/pinctrl/sh-pfc/Makefile                    |   1 +
 drivers/pinctrl/sh-pfc/core.c                      |   6 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               |  24 +
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   1 +
 drivers/soc/renesas/Kconfig                        |   7 +
 18 files changed, 1002 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7742.dtsi

-- 
2.7.4

