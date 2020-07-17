Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A74223054
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 03:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGQBdx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jul 2020 21:33:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41662 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgGQBdx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jul 2020 21:33:53 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17E892B7;
        Fri, 17 Jul 2020 03:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594949629;
        bh=g89E7lXxeRsbGlTknoXrwEpehj/Bnwy80mqtm68Hv+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=rsPBKlRkPGHh/Uj7Z3jv6JuWlK+8OFnlKHiVGrhet2HObd6BArEEyJsGVxd5EP71D
         kFcPqKaHUHX0LKLRpZN6Rx+mYcQN/0b3NsBiX5HASbM06xs0j1xOzgnViAPkFQweyB
         bAorYZLYIgULzFvTPH+kVgljcAp0V1QZrVVFtT4U=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v7 0/5] dma: Add Xilinx ZynqMP DPDMA driver
Date:   Fri, 17 Jul 2020 04:33:32 +0300
Message-Id: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
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
taken into account. The main changes are in the DPDMA driver, with
cleanups in the debugfs support, and handling of the !LOAD_EOT case when
preparing transactions.

The driver has been successfully tested with the ZynqMP DisplayPort
subsystem DRM driver.

As I would like to merge both this series and the DRM driver that
depends on it for v5.9 (if still possible), I have based those patches
on top of v5.8-rc1. There's unfortunately a conflict with the DMA engine
next branch, which is easy to resolve.

Vinod, if you're fine with the series, I can propose two ways forward:

- You can apply the patches on top of v5.8-rc1, push that to a base
  branch, merge it into the dmaengine -next branch, and push the base
  branch to a public git tree to let me base the DRM driver on it.

- I can perform that work if you give me a Reviewed-by tag for the
  series (at for patches 2/5 to 4/5), providing you with two signed
  tags, one for the base branch and one for the merged branch. You could
  then just pull the merged branch (please make sure not to rebase it or
  otherwise modify it in that case).

What's your preference ?

[1] https://lore.kernel.org/dmaengine/20200708201906.4546-1-laurent.pinchart@ideasonboard.com/

Hyun Kwon (1):
  dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver

Laurent Pinchart (4):
  dt: bindings: dma: xilinx: dpdma: DT bindings for Xilinx DPDMA
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
 drivers/dma/xilinx/Makefile                   |    1 +
 drivers/dma/xilinx/xilinx_dpdma.c             | 1771 +++++++++++++++++
 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h   |   16 +
 include/linux/dmaengine.h                     |   17 +
 11 files changed, 1958 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 create mode 100644 drivers/dma/xilinx/xilinx_dpdma.c
 create mode 100644 include/dt-bindings/dma/xlnx-zynqmp-dpdma.h

-- 
Regards,

Laurent Pinchart

