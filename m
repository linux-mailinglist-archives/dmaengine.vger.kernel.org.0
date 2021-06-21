Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1F33AEB64
	for <lists+dmaengine@lfdr.de>; Mon, 21 Jun 2021 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFUOgC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Jun 2021 10:36:02 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:13241 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230161AbhFUOf7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Jun 2021 10:35:59 -0400
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="85068679"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jun 2021 23:33:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.241])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EFBE3400A8A8;
        Mon, 21 Jun 2021 23:33:41 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        dmaengine@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 0/4] Add RZ/G2L DMAC support
Date:   Mon, 21 Jun 2021 15:33:35 +0100
Message-Id: <20210621143339.16754-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series aims to add DMAC support on RZ/G2L SoC's.

It is based on the work done by Chris Brandt for RZ/A DMA driver.

This patch set is based on master branch [1]
[1]https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/

v1->v2
 * Started using virtual DMAC
 * Added Geert's Rb tag for binding patch.

Biju Das (4):
  dt-bindings: dma: Document RZ/G2L bindings
  drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
  arm64: dts: renesas: r9a07g044: Add DMAC support
  arm64: defconfig: Enable DMA controller for RZ/G2L SoC's

 .../bindings/dma/renesas,rz-dmac.yaml         | 120 +++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  36 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/dma/sh/Kconfig                        |   9 +
 drivers/dma/sh/Makefile                       |   1 +
 drivers/dma/sh/rz-dmac.c                      | 946 ++++++++++++++++++
 6 files changed, 1113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
 create mode 100644 drivers/dma/sh/rz-dmac.c

-- 
2.17.1

