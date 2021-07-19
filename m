Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283413CD0A9
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jul 2021 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhGSIpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jul 2021 04:45:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:33190 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235752AbhGSIpB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jul 2021 04:45:01 -0400
X-IronPort-AV: E=Sophos;i="5.84,251,1620658800"; 
   d="scan'208";a="88060100"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2021 18:25:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 13099400A88B;
        Mon, 19 Jul 2021 18:25:37 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 0/4] Add RZ/G2L DMAC support
Date:   Mon, 19 Jul 2021 10:25:31 +0100
Message-Id: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series aims to add DMAC support on RZ/G2L SoC's.

It is based on the work done by Chris Brandt for RZ/A DMA driver.

v3->v4:
 * Added Rob's Rb tag for binding patch.
 * Incorporated Vinod and Geert's review comments.
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
 drivers/dma/sh/rz-dmac.c                      | 929 ++++++++++++++++++
 6 files changed, 1100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
 create mode 100644 drivers/dma/sh/rz-dmac.c

-- 
2.17.1

