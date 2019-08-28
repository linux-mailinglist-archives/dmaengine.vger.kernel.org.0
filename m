Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B908BA0091
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1LPj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 07:15:39 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:61955 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbfH1LPj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Aug 2019 07:15:39 -0400
X-IronPort-AV: E=Sophos;i="5.64,440,1559487600"; 
   d="scan'208";a="25148804"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Aug 2019 20:15:37 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5E54642296E6;
        Wed, 28 Aug 2019 20:15:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] dmaengine: rcar-dmac: Add dma-channel-mask property support
Date:   Wed, 28 Aug 2019 20:13:53 +0900
Message-Id: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series is based on
 - renesas-drivers.git / renesas-drivers-2019-08-13-v5.3-rc4 tag
 - and the following patch series:
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=165881

The commit e2d896c08ca3 ("Documentation: bindings: dma: Add binding for
dma-channel-mask") adds the generic property and R-Car also has such
use cases so that I made this patch series. Before adding the property
support, I made a clean-up patch as the patch 1/2.

Yoshihiro Shimoda (2):
  dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1 if iommu is mapped
  dmaengine: rcar-dmac: Add dma-channel-mask property support

 drivers/dma/sh/rcar-dmac.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
2.7.4

