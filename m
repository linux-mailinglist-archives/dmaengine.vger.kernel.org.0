Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6138B324
	for <lists+dmaengine@lfdr.de>; Thu, 20 May 2021 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhETP00 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 May 2021 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbhETPZu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 May 2021 11:25:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B01AC06138D
        for <dmaengine@vger.kernel.org>; Thu, 20 May 2021 08:24:28 -0700 (PDT)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A0F4D41;
        Thu, 20 May 2021 17:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1621524266;
        bh=SG0GYay4hut6hsoBVa79nvEXinnyFlIsFMAALJWtLVg=;
        h=From:To:Cc:Subject:Date:From;
        b=JwLDq8X7XfwPVNJyD5UqzFQqY58PIss5SvphXVtZRDKt0Vp1+/fcCMB6vN17uVwPn
         rfPVjfdx4oz4cMz7jQMV29wrIL5rSv+yH7FEF4Qn3SayBTRyhuqlyXezQB1kxjFRmx
         bxxmJdLldeQCdoz3zK8KBKudnPXtcCsi1p/Afy9U=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Jianqiang Chen <jianqian@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] dmaengine: xilinx: dpdma: Fix freeze after 64k frames
Date:   Thu, 20 May 2021 18:24:16 +0300
Message-Id: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.28.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This patch series addresses an issue in the Xilixn ZynqMP DPDMA driver
that causes a display freeze after 65536 frames. The first three patches
include a small compilation breakage issue (1/4) and enhancements to the
messages logged by the driver (2/4 and 3/4). The last patch fixes the
freeze bug. Please see individual patches for details.

Laurent Pinchart (4):
  dmaengine: xilinx: dpdma: Add missing dependencies to Kconfig
  dmaengine: xilinx: dpdma: Print channel number in kernel log messages
  dmaengine: xilinx: dpdma: Print debug message when losing vsync race
  dmaengine: xilinx: dpdma: Limit descriptor IDs to 16 bits

 drivers/dma/Kconfig               |  1 +
 drivers/dma/xilinx/xilinx_dpdma.c | 45 ++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 15 deletions(-)

-- 
Regards,

Laurent Pinchart

