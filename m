Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168A0224BA5
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jul 2020 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGRNwX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jul 2020 09:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgGRNwW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 18 Jul 2020 09:52:22 -0400
Received: from localhost.localdomain (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B6E20684;
        Sat, 18 Jul 2020 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595080342;
        bh=u9Upr7Cditq41YfgIAZXfUwHFBvS8KDwmmsKJQE8Zxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjgOIGQJmvrIK7utA7B+DXNyou5ywpPsze+kPPorEkc/sm9Em+6Z/uDH4CbxbeL1K
         +LGwdoKb2PqUYMBJny7xrUkUoYd7Xoy9wuBgzJDnfIyeGuca61jNVdEzpTzT7WSu7O
         S6QcPeBBZRpJKN4TkzBtn3f8+OpMGAz5g5wG4DoE=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 3/3] dmaengine: xilinx: dpdma: fix kernel doc format
Date:   Sat, 18 Jul 2020 19:22:01 +0530
Message-Id: <20200718135201.191881-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718135201.191881-1-vkoul@kernel.org>
References: <20200718135201.191881-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

xilinx_dpdma_chan structure documents 'desc' members, but that leads
to warnings, so split that up and describe members

drivers/dma/xilinx/xilinx_dpdma.c:241: warning: Function parameter or
member 'desc' not described in 'xilinx_dpdma_chan'

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 430f3714f6a3..d94c75a842f8 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -214,8 +214,8 @@ struct xilinx_dpdma_tx_desc {
  * @lock: lock to access struct xilinx_dpdma_chan
  * @desc_pool: descriptor allocation pool
  * @err_task: error IRQ bottom half handler
- * @desc.pending: Descriptor schedule to the hardware, pending execution
- * @desc.active: Descriptor being executed by the hardware
+ * @desc: pending: Descriptor schedule to the hardware, pending execution
+ *        active: Descriptor being executed by the hardware
  * @xdev: DPDMA device
  */
 struct xilinx_dpdma_chan {
-- 
2.26.2

