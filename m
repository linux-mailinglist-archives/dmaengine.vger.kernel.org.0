Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77C43B9ECE
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jul 2021 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGBKIS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jul 2021 06:08:18 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:21609 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231455AbhGBKIR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jul 2021 06:08:17 -0400
X-IronPort-AV: E=Sophos;i="5.83,317,1616425200"; 
   d="scan'208";a="86432295"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jul 2021 19:05:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id ADB344010738;
        Fri,  2 Jul 2021 19:05:29 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/4] Add RZ/G2L DMAC support
Date:   Fri,  2 Jul 2021 11:05:23 +0100
Message-Id: <20210702100527.28251-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series aims to add DMAC support on RZ/G2L SoC's.

It is based on the work done by Chris Brandt for RZ/A DMA driver.

This patch series is based on [1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/rzg2l-update-clock-defs-v4

Note:-  This patch has dependency on #include <dt-bindings/clock/r9a07g044-cpg.h> file which will be in next 5.14-rc1 release.

v2->v3:
  * Described clocks and resets in binding file as per Rob's feedback.

v1->v2
 * Started using virtual DMAC
 * Added Geert's Rb tag for binding patch.

Biju Das (4):
  dt-bindings: dma: Document RZ/G2L bindings
  drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
  arm64: dts: renesas: r9a07g044: Add DMAC support
  arm64: defconfig: Enable DMA controller for RZ/G2L SoC's

 .../bindings/dma/renesas,rz-dmac.yaml         | 124 +++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  36 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/dma/sh/Kconfig                        |   9 +
 drivers/dma/sh/Makefile                       |   1 +
 drivers/dma/sh/rz-dmac.c                      | 946 ++++++++++++++++++
 6 files changed, 1117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
 create mode 100644 drivers/dma/sh/rz-dmac.c


base-commit: 06c1e6911a7a76b446e4b00fc8bad5d8465932f8
-- 
2.17.1

