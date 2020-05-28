Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA21E5437
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgE1Cwx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Cwx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 22:52:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D1C05BD1E
        for <dmaengine@vger.kernel.org>; Wed, 27 May 2020 19:52:53 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E24A2A3;
        Thu, 28 May 2020 04:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590634370;
        bh=Zp78SJWMMplActPr+rENlM3Vup9e93Q1KlGMRCF+YdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sli9+osRhaCNVoT4kep3l3KjEv/hXXeCv3wlE+EU9P1QXr9WP1wKfBHbwqeEFuduD
         9k0bqjM+lP1ev/7Ta8HPmtoyOa47MUJj6y1r2pYtlB9crpYieFU662qYi5qoDpwtmb
         r8yv+U9mNy8DOcgz82GgvCyAsFWljNwqMVBHwtis=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 0/6] dma: Add Xilinx ZynqMP DPDMA driver
Date:   Thu, 28 May 2020 05:52:22 +0300
Message-Id: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
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
taken into account. The only change is the addition of the
DMA_PREP_LOAD_EOT transaction flag (and the corresponding DMA_LOAD_EOT
capability bit), as requested during the review of v4. Please see the
discussions from v4 for the rationale.

The driver has been successfully tested with the ZynqMP DisplayPort
subsystem DRM driver.

[1] https://lore.kernel.org/dmaengine/20200513165943.25120-1-laurent.pinchart@ideasonboard.com/

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
 drivers/dma/xilinx/xilinx_dpdma.c             | 1782 +++++++++++++++++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
 include/linux/dmaengine.h                     |   19 +
 11 files changed, 1931 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

-- 
Regards,

Laurent Pinchart

