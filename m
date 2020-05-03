Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64861C2F89
	for <lists+dmaengine@lfdr.de>; Sun,  3 May 2020 23:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgECVrM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 May 2020 17:47:12 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:8668 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729104AbgECVrL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 3 May 2020 17:47:11 -0400
X-IronPort-AV: E=Sophos;i="5.73,349,1583161200"; 
   d="scan'208";a="46019240"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 May 2020 06:47:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 39AB94006DF9;
        Mon,  4 May 2020 06:47:06 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 00/10] Add initial support for R8A7742/RZG1H SoC and iW-RainboW-G21D-Qseven development board support
Date:   Sun,  3 May 2020 22:46:44 +0100
Message-Id: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

This patch set adds initial support for R8A7742 SoC and 
iW-RainboW-G21D-Qseven development board.

Cheers,
--Prabhakar

Changes for v2:
* Dropped patches 1-5 from v1[1] as they have been already queued.
* Split up the pfc for r8a7790 as common and automotive.
* Enabled dmac and scifa2 as part of initial SoC dtsi so that by default
  board can be booted from eMMC.
* New patches 4, 7-10
* Dropped patches 12, 14-18 from v1[1] and will be posted after acceptance
  of this series.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=279727

Lad Prabhakar (10):
  dt-bindings: pinctrl: sh-pfc: Document r8a7742 PFC support
  pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
  dt-bindings: serial: renesas,scifa: Document r8a7742 bindings
  dt-bindings: mmc: renesas,mmcif: Document r8a7742 DT bindings
  dt-bindings: renesas,rcar-dmac: Document r8a7742 support
  ARM: dts: r8a7742: Initial SoC device tree
  dt-bindings: arm: Document iW-RainboW-G21M-Qseven-RZG1H system on
    module
  dt-bindings: arm: Document iW-RainboW-G21D-Qseven-RZG1H board
  ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H Qseven SOM
  ARM: dts: r8a7742-iwg21d-q7: Add support for iWave G21D-Q7 board based
    on RZ/G1H

 .../devicetree/bindings/arm/renesas.yaml      |  10 +
 .../bindings/dma/renesas,rcar-dmac.yaml       |   1 +
 .../devicetree/bindings/mmc/renesas,mmcif.txt |   1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt  |   1 +
 .../bindings/serial/renesas,scifa.yaml        |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  37 +
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi         |  53 ++
 arch/arm/boot/dts/r8a7742.dtsi                | 389 +++++++++
 drivers/pinctrl/sh-pfc/Kconfig                |   4 +
 drivers/pinctrl/sh-pfc/Makefile               |   1 +
 drivers/pinctrl/sh-pfc/core.c                 |   6 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c          | 744 +++++++++---------
 drivers/pinctrl/sh-pfc/sh_pfc.h               |   1 +
 14 files changed, 898 insertions(+), 352 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21m.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7742.dtsi

-- 
2.17.1

