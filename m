Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD18749A84
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jul 2023 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjGFLV6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jul 2023 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjGFLV5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jul 2023 07:21:57 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF96F199C;
        Thu,  6 Jul 2023 04:21:55 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,185,1684767600"; 
   d="scan'208";a="167207525"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jul 2023 20:21:55 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D531C4007546;
        Thu,  6 Jul 2023 20:21:52 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/2] RZ/G2L DMA fix/improvements
Date:   Thu,  6 Jul 2023 12:21:48 +0100
Message-Id: <20230706112150.198941-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series aims to fix/improve RZ/DMAC driver.

The improvement patch is related to fix cleanup order in probe/remove().
and fixes patch is related to wrong SDS/DDS settings, when we change/update
the DMA bus width several times.

v2->v3:
 * Added bitfield.h header file and replaced CHCFG_FILL_{SDS,DDS}
   macros with FIELD_PREP.
 * Updated commit header 'dma: rz-dmac'->'dmaengine: sh: rz-dmac'.
v1->v2:
 * Update patch header and description.

Biju Das (1):
  dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()

Hien Huynh (1):
  dmaengine: sh: rz-dmac: Fix destination and source data size setting

 drivers/dma/sh/rz-dmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.25.1

