Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB98F2512
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 03:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfKGCOQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 21:14:16 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47150 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCOQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 21:14:16 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72B86329;
        Thu,  7 Nov 2019 03:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1573092853;
        bh=m+upZtqmdVim8a6NuvGi8Sw8PFYd1YF2HJbVPj6o7yQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l/N8uW6PAlJ8OVWFu7IV5gRrqmgiN9HdiuQb2XA6kXLMOpZQa7614rl6H8M1VZz8F
         gB3IvVzfWgQ07lDwBk3/JMjYyZLaqZMrDWRviLCe+9Jhv1EmCxXZwPVaETQRFJ3Kat
         xV2tNYULIK4AswgGyBT3ueq7g7j+wLt1tlT4ScxM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: [PATCH v2 0/4] dma: Add Xilinx ZynqMP DPDMA driver
Date:   Thu,  7 Nov 2019 04:13:56 +0200
Message-Id: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

This patch series adds a new driver for the DPDMA engine found in the
Xilinx ZynqMP. It is based on the version posted by Hyun in [1] and [2].
I have rebased the driver on top of v5.4-rc6, incorporated most review
comments, and successfully tested the result with the ZynqMP DisplayPort
subsystem DRM driver.

There is one review comment that is still pending: switching to
virt-dma. I started investigating this, and it quickly appeared that
this would result in an almost complete rewrite of the driver's logic.
While the end result may be better, I wonder if this is worth it, given
that the DPDMA is tied to the DisplayPort subsystem and can't be used
with other DMA slaves. The DPDMA is thus used with very specific usage
patterns, which don't need the genericity of descriptor handling
provided by virt-dma. Vinod, what's your opinion on this ? Is virt-dma
usage a blocker to merge this driver, could we switch to it later, or is
it just overkill in this case ?

[1] https://lore.kernel.org/dmaengine/1515204848-3493-1-git-send-email-hyun.kwon@xilinx.com/
[2] https://lore.kernel.org/dmaengine/1515204848-3493-2-git-send-email-hyun.kwon@xilinx.com/

Hyun Kwon (1):
  dma: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver

Laurent Pinchart (3):
  dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
  dma: xilinx: dpdma: Add debugfs support
  arm64: dts: zynqmp: Add DPDMA node

 .../dma/xilinx/xlnx,zynqmp-dpdma.yaml         |   68 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi    |    4 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   10 +
 drivers/dma/Kconfig                           |    9 +
 drivers/dma/xilinx/Makefile                   |    1 +
 drivers/dma/xilinx/xilinx_dpdma.c             | 2304 +++++++++++++++++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
 8 files changed, 2421 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

-- 
Regards,

Laurent Pinchart

