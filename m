Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E241460B8
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 03:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAWCaB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 21:30:01 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59046 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAWCaB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jan 2020 21:30:01 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E81762E5;
        Thu, 23 Jan 2020 03:29:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579746599;
        bh=hL+ZJjJl57D49P6/L6YtuMuonqe2sTZf+JuEqSRp1MM=;
        h=From:To:Cc:Subject:Date:From;
        b=DDrPzAFGj9ovxzzWxQ4wtBsCruyt4U5AEuozjqfaZBuZwHkOywnK+S7cmYGjbJEgz
         2Ns70QscNVI+NgQDG/AY8MpgVWn+a4QWb6JIl5xQKBKCavbfoAwbQ0Ho5JD6+JLyoa
         Qija8cf3JUGenMRIYMRbKTptVwkdc8h1S6Qcf558=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 0/6] dma: Add Xilinx ZynqMP DPDMA driver
Date:   Thu, 23 Jan 2020 04:29:33 +0200
Message-Id: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
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
taken into account. The most notable changes are

- Introduction of a new DMA transfer type that combines interleaved and
  cyclic tranfers (patch 2/6, suggested by Vinod)

- Switch to virt-dma (including a drive-by lockdep addition to virt-dma
  in patch 3/6)

- Removal of all non-interleaved, non-cyclic transfer types, as I have
  currently no way to test them given how the IP core is integrated in
  the hardware. Support for non-interleaved cyclic transfers may be
  added later for audio.

The driver has been successfully tested with the ZynqMP DisplayPort
subsystem DRM driver.

Vinod, please let me know if you would like authorship of patch 2/6 to
be assigned to you, in which case I will need your SoB line.

[1] https://lore.kernel.org/dmaengine/20191107021400.16474-1-laurent.pinchart@ideasonboard.com/

Hyun Kwon (1):
  dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver

Laurent Pinchart (5):
  dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
  dmaengine: Add interleaved cyclic transaction type
  dmaengine: virt-dma: Use lockdep to check locking requirements
  dmaengine: xilinx: dpdma: Add debugfs support
  arm64: dts: zynqmp: Add DPDMA node

 .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         |   68 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi    |    4 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   10 +
 drivers/dma/Kconfig                           |   10 +
 drivers/dma/dmaengine.c                       |    8 +-
 drivers/dma/virt-dma.c                        |    2 +
 drivers/dma/virt-dma.h                        |   14 +
 drivers/dma/xilinx/Makefile                   |    1 +
 drivers/dma/xilinx/xilinx_dpdma.c             | 1754 +++++++++++++++++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
 include/linux/dmaengine.h                     |   18 +
 12 files changed, 1913 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h


base-commit: d1eef1c619749b2a57e514a3fa67d9a516ffa919
-- 
Regards,

Laurent Pinchart

