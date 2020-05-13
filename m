Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9B1D1BB3
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 18:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbgEMQ7z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgEMQ7z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 12:59:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573DC061A0C
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2020 09:59:55 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 93BDA51F;
        Wed, 13 May 2020 18:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1589389193;
        bh=mtabb/MpHzBd56dLR+58xlaLRaJzhC2kTVGyuLagWBw=;
        h=From:To:Cc:Subject:Date:From;
        b=LYALR95umfNRAR2gVV6Um1yw07MoTnm3RkKSvjPD3IdYikAbRRep3YKke6sZz7tNz
         HQUKGmANuHuu0AwGMM9rCDmThGPjH8ZKB4yonb/0tFs5akFuUG1MR1Fd/Su3/s0BZk
         +8ni2zVyL/kgXeXrbpbeTVNJOG+9DZkuVrNf8RUU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 0/6] dma: Add Xilinx ZynqMP DPDMA driver
Date:   Wed, 13 May 2020 19:59:37 +0300
Message-Id: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.26.2
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
taken into account. The most notable change is the replacement of the
proposed new DMA transfer type that combined interleaved and cyclic
tranfers with a new dma_ctrl_flags (patch 3/6, suggested by Peter).

The driver has been successfully tested with the ZynqMP DisplayPort
subsystem DRM driver.

[1] https://lore.kernel.org/dmaengine/20200123022939.9739-1-laurent.pinchart@ideasonboard.com/

Hyun Kwon (1):
  dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver

Laurent Pinchart (5):
  dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
  dmaengine: virt-dma: Use lockdep to check locking requirements
  dmaengine: Add support for repeating transactions
  dmaengine: xilinx: dpdma: Add debugfs support
  arm64: dts: zynqmp: Add DPDMA node

 .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         |   68 +
 MAINTAINERS                                   |    9 +
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |    4 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   10 +
 drivers/dma/Kconfig                           |   10 +
 drivers/dma/virt-dma.c                        |    2 +
 drivers/dma/virt-dma.h                        |   10 +
 drivers/dma/xilinx/Makefile                   |    1 +
 drivers/dma/xilinx/xilinx_dpdma.c             | 1771 +++++++++++++++++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
 include/linux/dmaengine.h                     |   10 +
 11 files changed, 1911 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

-- 
Regards,

Laurent Pinchart

