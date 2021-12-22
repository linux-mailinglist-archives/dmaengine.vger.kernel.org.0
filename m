Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78DD47D12F
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 12:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhLVLpZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 06:45:25 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53136 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232235AbhLVLpY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 06:45:24 -0500
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000"; 
   d="scan'208";a="104834397"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2021 20:45:23 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0015942E4FFC;
        Wed, 22 Dec 2021 20:45:22 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/2] dmaengine: rcar-dmac: Add support for R-Car S4-8
Date:   Wed, 22 Dec 2021 20:45:05 +0900
Message-Id: <20211222114507.1252947-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series adds support for rcar-dmac of R-Car S4-8.
To use the rcar-dmac, we also need to enable the module clocks
by the following patch:
https://lore.kernel.org/all/20211221052423.597283-1-yoshihiro.shimoda.uh@renesas.com/

Changes from v1:
 - Fix typo in patch 1.
 - Add commit description in patch 2.
 - Rename "V3U" of some definitions/comments to "GEN4" in patch 2.
 - Add Reviewed-by tags in patch 1 and 2.
 - Remove patch 3 of v1 because the patch got acceptance.
https://lore.kernel.org/all/20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com/

Yoshihiro Shimoda (2):
  dt-bindings: renesas,rcar-dmac: Add r8a779f0 support
  dmaengine: rcar-dmac: Add support for R-Car S4-8

 .../bindings/dma/renesas,rcar-dmac.yaml         |  5 +++++
 drivers/dma/sh/rcar-dmac.c                      | 17 ++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.25.1

