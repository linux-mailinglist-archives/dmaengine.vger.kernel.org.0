Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51666285A7C
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgJGIbb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 04:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgJGIbb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 04:31:31 -0400
Received: from localhost.localdomain (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37FE2080A;
        Wed,  7 Oct 2020 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602059489;
        bh=t0YlAL+dz89S7sqeODYaBgJKZnpjU1we1P+FVYxA01U=;
        h=From:To:Cc:Subject:Date:From;
        b=15wO4hFSF41UTkw0JYZYQ1ZyD4IjiFV3T4T8AQRQErkpDjWps/Ens46nyGgXvAJEk
         i5kWeP+2YTYW35R+79mTcjlwNE1ysca6JQOcKXEaYcGgpCRpILCwZ0gPnsZahy2KoD
         HLDF5v3rm+NG2DQ19t6F25cg3ZiNLXI6J2X4PyG0=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Fix warning in dmaengine subsystem
Date:   Wed,  7 Oct 2020 14:01:08 +0530
Message-Id: <20201007083113.567559-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some kernel-doc warns have crept in so fix them up.

drivers/dma/altera-msgdma.c:684: warning: Function parameter or member 't' not described in 'msgdma_tasklet'
drivers/dma/altera-msgdma.c:684: warning: Excess function parameter 'data' description in 'msgdma_tasklet'
drivers/dma/xilinx/zynqmp_dma.c:748: warning: Function parameter or member 't' not described in 'zynqmp_dma_do_tasklet'
drivers/dma/xilinx/zynqmp_dma.c:748: warning: Excess function parameter 'data' description in 'zynqmp_dma_do_tasklet'
drivers/dma/owl-dma.c:139: warning: cannot understand function prototype: 'enum owl_dmadesc_offsets '
drivers/dma/qcom/bam_dma.c:1078: warning: Function parameter or member 't' not described in 'dma_tasklet'
drivers/dma/qcom/bam_dma.c:1078: warning: Excess function parameter 'data' description in 'dma_tasklet'
drivers/dma/xilinx/xilinx_dma.c:1050: warning: Function parameter or member 't' not described in 'xilinx_dma_do_tasklet'
drivers/dma/xilinx/xilinx_dma.c:1050: warning: Excess function parameter 'data' description in 'xilinx_dma_do_tasklet'


Vinod Koul (5):
  dmaengine: altera-msgdma: fix kernel-doc style for tasklet
  dmaengine: qcom: bam_dma: fix kernel-doc style for tasklet
  dmaengine: xilinx_dma: fix kernel-doc style for tasklet
  dmaengine: zynqmp_dma: fix kernel-doc style for tasklet
  dmaengine: owl-dma: fix kernel-doc style for enum

 drivers/dma/altera-msgdma.c     | 2 +-
 drivers/dma/owl-dma.c           | 3 ++-
 drivers/dma/qcom/bam_dma.c      | 2 +-
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.26.2

