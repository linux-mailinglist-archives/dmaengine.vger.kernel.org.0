Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B9A7DBF
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 10:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfIDIYl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 04:24:41 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:52203 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729398AbfIDIYl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Sep 2019 04:24:41 -0400
X-IronPort-AV: E=Sophos;i="5.64,465,1559487600"; 
   d="scan'208";a="25494496"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2019 17:24:39 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 08FF54009641;
        Wed,  4 Sep 2019 17:24:39 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/3] dmaengine: rcar-dmac: use of_data and add dma-channel-mask support
Date:   Wed,  4 Sep 2019 17:24:35 +0900
Message-Id: <1567585478-23902-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series is based on the latest slave-dma.git / next branch and
merge the latest slave-dma.git / fixes branch. This is because this patch
series depends on the following commit:
---
commit cf24aac38698bfa1d021afd3883df3c4c65143a4
Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date:   Mon Sep 2 20:44:03 2019 +0900

    dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu is mapped
---

Changes from v1:
 - Combine two patch series into this patch series.
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=166457&state=*
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=166457&state=*
 - Remove a patch because updated patch is already merged into
   the latest slave-dma.git / fixes branch as described above.
 - Add Reviewed-by tags into all patches.
 - Rename a member of rcar_dmac_of_data.
 - Just ignore the return value of of_property_read_u32() for dma-channel-mask.

Yoshihiro Shimoda (3):
  dmaengine: rcar-dmac: Use of_data values instead of a macro
  dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
  dmaengine: rcar-dmac: Add dma-channel-mask property support

 drivers/dma/sh/rcar-dmac.c | 47 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

-- 
2.7.4

