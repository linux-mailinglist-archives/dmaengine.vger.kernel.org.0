Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8E6C7BEC
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 10:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCXJuF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 05:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCXJuE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 05:50:04 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6973A8E;
        Fri, 24 Mar 2023 02:50:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,287,1673881200"; 
   d="scan'208";a="153658925"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Mar 2023 18:50:02 +0900
Received: from localhost.localdomain (unknown [10.226.93.228])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81B9A4000C76;
        Fri, 24 Mar 2023 18:50:00 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/3] RZ/G2L DMAC enhancements
Date:   Fri, 24 Mar 2023 09:49:54 +0000
Message-Id: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=AC_FROM_MANY_DOTS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series aims to add enhancement to RZ/G2L DMAC driver.
It is basically for supporting SCIF DMA.

It is based on a patch in the BSP by Long Luu which is similar to
rcar-dmac implementation.
<long.luu.ur@renesas.com>

Tested audio, RSPI and scif with these changes.
 15:      65880          0     GICv3 157 Edge      11820000.dma-controller:0
 16:      65880          0     GICv3 158 Edge      11820000.dma-controller:1
 17:      28498          0     GICv3 159 Edge      11820000.dma-controller:2
 18:      28498          0     GICv3 160 Edge      11820000.dma-controller:3
 19:       7934          0     GICv3 161 Edge      11820000.dma-controller:4
 20:       5766          0     GICv3 162 Edge      11820000.dma-controller:5
 21:          0          0     GICv3 163 Edge      11820000.dma-controller:6
 22:          0          0     GICv3 164 Edge      11820000.dma-controller:7
 23:          0          0     GICv3 165 Edge      11820000.dma-controller:8
 24:          0          0     GICv3 166 Edge      11820000.dma-controller:9
 25:          0          0     GICv3 167 Edge      11820000.dma-controller:10
 26:          0          0     GICv3 168 Edge      11820000.dma-controller:11
 27:          0          0     GICv3 169 Edge      11820000.dma-controller:12
 28:          0          0     GICv3 170 Edge      11820000.dma-controller:13
 29:          0          0     GICv3 171 Edge      11820000.dma-controller:14
 30:          0          0     GICv3 172 Edge      11820000.dma-controller:15

Biju Das (3):
  dmaengine: sh: rz-dmac: Reinitialize lmdescriptor head
  dmaengine: sh: rz-dmac: Add device_tx_status() callback
  dmaengine: sh: rz-dmac: Add device_pause() callback

 drivers/dma/sh/rz-dmac.c | 196 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 1 deletion(-)

-- 
2.25.1

