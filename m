Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10F346A355
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbhLFRqk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 12:46:40 -0500
Received: from aposti.net ([89.234.176.197]:59566 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245340AbhLFRqi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Dec 2021 12:46:38 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/6] dmaengine: jz4780: Driver updates v2
Date:   Mon,  6 Dec 2021 17:42:53 +0000
Message-Id: <20211206174259.68133-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

A small set of updates to the dma-jz4780 driver.

It adds support for the MDMA/BDMA engines in the JZ4760(B) and JZ4770
SoCs, which are just regular cores with less channels.

It also adds support for bidirectional channels, so that devices that
only do half-duplex transfers can request a single DMA channel for both
directions.

Changes since V1 include:
- indentation fixes in patch [1/6],
- a better worded documentation in patch [2/6],
- a new patch [5/6] to convert all uses of uint32_t to u32.

You mentioned the fact that it would be great to have an exemple in the
documentation file that uses #dma-cells = <3>. I will add one in a
future patchset to the SD controller's binding documentation, when its
driver will be updated to support bidirectional DMA channels.

Cheers,
-Paul

Paul Cercueil (6):
  dt-bindings: dma: ingenic: Add compatible strings for MDMA and BDMA
  dt-bindings: dma: ingenic: Support #dma-cells = <3>
  dmaengine: jz4780: Work around hardware bug on JZ4760 SoCs
  dmaengine: jz4780: Add support for the MDMA and BDMA in the JZ4760(B)
  dmaengine: jz4780: Replace uint32_t with u32
  dmaengine: jz4780: Support bidirectional I/O on one channel

 .../devicetree/bindings/dma/ingenic,dma.yaml  |  42 ++++---
 drivers/dma/dma-jz4780.c                      | 118 +++++++++++++-----
 2 files changed, 113 insertions(+), 47 deletions(-)

-- 
2.33.0

