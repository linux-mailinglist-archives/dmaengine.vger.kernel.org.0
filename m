Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B747B987
	for <lists+dmaengine@lfdr.de>; Tue, 21 Dec 2021 06:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLUF1h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Dec 2021 00:27:37 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:15239 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229690AbhLUF1h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Dec 2021 00:27:37 -0500
X-IronPort-AV: E=Sophos;i="5.88,222,1635174000"; 
   d="scan'208";a="104664121"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Dec 2021 14:27:36 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 61E2D41D5D91;
        Tue, 21 Dec 2021 14:27:36 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/3] treewide: rcar-dmac: Add support for R-Car S4-8
Date:   Tue, 21 Dec 2021 14:27:19 +0900
Message-Id: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series adds support for rcar-dmac of R-Car S4-8.
To use the rcar-dmac, we also need to enable the module clocks
by the following patch:
https://patchwork.kernel.org/project/linux-renesas-soc/patch/20211221052423.597283-1-yoshihiro.shimoda.uh@renesas.com/

Yoshihiro Shimoda (3):
  dt-bindings: renesas,rcar-dmac: Add r8a779f0 support
  dmaengine: rcar-dmac: Add support for R-Car S4-8
  arm64: dts: renesas: r8a779f0: Add sys-dmac nodes

 .../bindings/dma/renesas,rcar-dmac.yaml       |  5 ++
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     | 70 +++++++++++++++++++
 drivers/dma/sh/rcar-dmac.c                    |  7 +-
 3 files changed, 80 insertions(+), 2 deletions(-)

-- 
2.25.1

