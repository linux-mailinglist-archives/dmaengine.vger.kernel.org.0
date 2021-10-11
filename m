Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988D0429204
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhJKOjI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 10:39:08 -0400
Received: from aposti.net ([89.234.176.197]:46554 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238868AbhJKOjD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Oct 2021 10:39:03 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/5] dmaengine: dma-jz4780: Driver updates
Date:   Mon, 11 Oct 2021 16:36:47 +0200
Message-Id: <20211011143652.51976-1-paul@crapouillou.net>
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

Cheers,
-Paul

Paul Cercueil (5):
  dt-bindings: dma: ingenic: Add compatible strings for MDMA and BDMA
  dt-bindings: dma: ingenic: Support #dma-cells = <3>
  dmaengine: jz4780: Work around hardware bug on JZ4760 SoCs
  dmaengine: jz4780: Add support for the MDMA and BDMA in the JZ4760(B)
  dmaengine: jz4780: Support bidirectional I/O on one channel

 .../devicetree/bindings/dma/ingenic,dma.yaml  | 34 +++++---
 drivers/dma/dma-jz4780.c                      | 84 +++++++++++++++----
 2 files changed, 91 insertions(+), 27 deletions(-)

-- 
2.33.0

