Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C557347D4F3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhLVQPp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 11:15:45 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:29248 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234060AbhLVQPo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 11:15:44 -0500
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000"; 
   d="scan'208";a="104375071"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2021 01:15:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 41CE640A14AC;
        Thu, 23 Dec 2021 01:15:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] dmaengine: Use platform_get_irq*() variants to fetch IRQ's
Date:   Wed, 22 Dec 2021 16:15:31 +0000
Message-Id: <20211222161534.1263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

This patch series aims to drop using platform_get_resource() for IRQ types
in preparation for removal of static setup of IRQ resource from DT core
code.

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  dmaengine: nbpfaxi: Use platform_get_irq_optional() to get the
    interrupt
  dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to get the
    interrupt
  dmaengine: mediatek-cqdma: Use platform_get_irq() to get the interrupt

 drivers/dma/mediatek/mtk-cqdma.c | 12 ++++--------
 drivers/dma/mediatek/mtk-hsdma.c | 11 ++++-------
 drivers/dma/nbpfaxi.c            | 13 ++++++-------
 3 files changed, 14 insertions(+), 22 deletions(-)

-- 
2.17.1

