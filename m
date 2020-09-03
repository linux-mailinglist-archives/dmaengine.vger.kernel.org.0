Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D9225CA24
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgICU0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 16:26:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICU0R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 16:26:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556CE1045;
        Thu,  3 Sep 2020 13:26:14 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 773FC3F71F;
        Thu,  3 Sep 2020 13:26:13 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] dmaengine: Tidy up dma_parms
Date:   Thu,  3 Sep 2020 21:25:44 +0100
Message-Id: <cover.1599164692.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Just a bit of trivial housekeeping now that it's no longer necessary for
platform and AMBA devices to allocate their own dma_parms. Feel free to
squash patches if desired.

I have no idea why I'm spending my own Thursday evening on this, but
apparently the itch has to be scratched :)

Robin.


Robin Murphy (9):
  dmaengine: axi-dmac: Drop local dma_parms
  dmaengine: bcm2835: Drop local dma_parms
  dmaengine: imx-dma: Drop local dma_parms
  dmaengine: imx-sdma: Drop local dma_parms
  dmaengine: mxs: Drop local dma_parms
  dmaengine: rcar-dmac: Drop local dma_parms
  dmaengine: ste_dma40: Drop local dma_parms
  dmaengine: qcom: bam_dma: Drop local dma_parms
  dmaengine: pl330: Drop local dma_parms

 drivers/dma/bcm2835-dma.c  | 3 ---
 drivers/dma/dma-axi-dmac.c | 3 ---
 drivers/dma/imx-dma.c      | 2 --
 drivers/dma/imx-sdma.c     | 2 --
 drivers/dma/mxs-dma.c      | 2 --
 drivers/dma/pl330.c        | 5 -----
 drivers/dma/qcom/bam_dma.c | 2 --
 drivers/dma/sh/rcar-dmac.c | 2 --
 drivers/dma/ste_dma40.c    | 3 ---
 9 files changed, 24 deletions(-)

-- 
2.28.0.dirty

