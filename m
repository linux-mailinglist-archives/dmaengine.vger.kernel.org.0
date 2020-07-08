Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB5219150
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2020 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgGHUTU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jul 2020 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGHUTU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jul 2020 16:19:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFCC08C5C1
        for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2020 13:19:19 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E748543;
        Wed,  8 Jul 2020 22:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594239555;
        bh=7eQEZAgBXD4bDmlhlWvWPECpEiOtm2wXUYrOY+bHBWw=;
        h=From:To:Cc:Subject:Date:From;
        b=cHjU7YeWDu3qR5PFoZ5Ob/pU/qM1IOeesJfH/3xbGMU0Ws88keIbPwVlNwJRKfNH5
         SvasXRyYDtHR58n5U8Vw/oY4H0/G0GEDdtVyNFkFPL9dk7BWP/hxyjLsBS1WZk1qBD
         Dlj4cTbNJCgkurnZij0tUOPcUTQKYcRRM3/TRS/Y=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6 0/6] dma: Add Xilinx ZynqMP DPDMA driver
Date:   Wed,  8 Jul 2020 23:19:00 +0300
Message-Id: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This patch series adds a new driver for the DPDMA engine found in the
Xilinx ZynqMP.

The previous version can be found at [1]. All review comments have been
taken into account. The main change is the addition of documentation.

The driver has been successfully tested with the ZynqMP DisplayPort
subsystem DRM driver.

As I would like to merge both this series and the DRM driver that
depends on it for v5.9, I have based those patches on top of v5.8-rc1
and pushed a tag to

	git://linuxtv.org/pinchartl/media.git dma-zynqmp-20200708-base

to be merged in both the dmaengine and DRM tree (Daniel and Dave on CC).
There's unfortunately a conflict with the DMA engine next branch, which
I have resolved and pushed to

	git://linuxtv.org/pinchartl/media.git dma-zynqmp-20200708-resolved

The first tag would thus be merged in the DRM tree, while the second tag
would be merged in the DMA engine tree (unless Vinod would prefer
merging the first tag and resolving the conflict himself). Vinod, could
you please confirm that this is OK with you ? I'll create new signed
tags with your Acked-by/Reviewed-by tags once you finish reviewing the
series (unless you prefer applying the patches yourself and provide a
base branch on top of v5.8-rc1 as I've done).

[1] https://lore.kernel.org/dmaengine/20200528025228.31638-1-laurent.pinchart@ideasonboard.com/

Hyun Kwon (1):
  dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver

Laurent Pinchart (5):
  dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
  dmaengine: virt-dma: Use lockdep to check locking requirements
  dmaengine: Add support for repeating transactions
  dmaengine: xilinx: dpdma: Add debugfs support
  arm64: dts: zynqmp: Add DPDMA node

 .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         |   68 +
 Documentation/driver-api/dmaengine/client.rst |    4 +-
 .../driver-api/dmaengine/provider.rst         |   49 +
 MAINTAINERS                                   |    9 +
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |    4 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   10 +
 drivers/dma/Kconfig                           |   10 +
 drivers/dma/virt-dma.c                        |    2 +
 drivers/dma/virt-dma.h                        |   10 +
 drivers/dma/xilinx/Makefile                   |    1 +
 drivers/dma/xilinx/xilinx_dpdma.c             | 1771 +++++++++++++++++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
 include/linux/dmaengine.h                     |   17 +
 13 files changed, 1970 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

-- 
Regards,

Laurent Pinchart

