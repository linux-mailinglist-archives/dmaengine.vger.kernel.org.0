Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A0E4572F
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFNIPq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 04:15:46 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50254 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfFNIPq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 10AB81A05C7;
        Fri, 14 Jun 2019 10:15:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F12D11A05D0;
        Fri, 14 Jun 2019 10:15:37 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 473C3402E6;
        Fri, 14 Jun 2019 16:15:30 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com, angelo@sysam.it
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v4 0/6] add edma2 for i.mx7ulp
Date:   Fri, 14 Jun 2019 16:17:18 +0800
Message-Id: <20190614081724.13366-1-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

This patch set add new version of edma for i.mx7ulp, the main changes
are as belows:
 1. only one dmamux.
 2. another clock dma_clk except dmamux clk.
 3. 16 independent interrupts instead of only one interrupt for
    all channels
For the first change, need modify fsl-edma-common.c and mcf-edma,
so create the first two patches to prepare without any function impact.

For the third change, need request single irq for every channel with
the legacy handler. But actually 2 dma channels share one interrupt(16
channel interrupts, but 32 channels.),ch0/ch16,ch1/ch17... For now, just
simply request irq without IRQF_SHARED flag, since 16 channels are enough
on i.mx7ulp whose M4 domain own some peripherals.

change from v1:
  1. check .data of 'of_device_id' in probe instead of compatible name.

change from v2:
  1. move the difference between edma and edma2 into driver data so that
     no need version checking in fsl-edma.c.

change from v3:
  1. remove duplicated 'version' and 'dmamux_nr' in 'struct fsl_edma_engine'
     since they are included in drvdata already.
  2. downgrade print log level.
  3. address some minor indent issues raised by Vinod.

Robin Gong (6):
  dmaengine: fsl-edma: add drvdata for fsl-edma
  dmaengine: fsl-edma-common: move dmamux register to another single
    function
  dmaengine: fsl-edma-common: version check for v2 instead
  dt-bindings: dma: fsl-edma: add new i.mx7ulp-edma
  dmaengine: fsl-edma: add i.mx7ulp edma2 version support
  ARM: dts: imx7ulp: add edma device node

 Documentation/devicetree/bindings/dma/fsl-edma.txt |  44 ++++++++-
 arch/arm/boot/dts/imx7ulp.dtsi                     |  28 ++++++
 drivers/dma/fsl-edma-common.c                      |  83 ++++++++++------
 drivers/dma/fsl-edma-common.h                      |  14 ++-
 drivers/dma/fsl-edma.c                             | 109 ++++++++++++++++++---
 drivers/dma/mcf-edma.c                             |  11 ++-
 6 files changed, 239 insertions(+), 50 deletions(-)

-- 
2.7.4

