Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAC6224BA4
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jul 2020 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgGRNwV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jul 2020 09:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgGRNwU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 18 Jul 2020 09:52:20 -0400
Received: from localhost.localdomain (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33487207DD;
        Sat, 18 Jul 2020 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595080340;
        bh=v14RUrLpqw5e23XhDMif2sgNKz4wLFS80KSOAwmN2hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHaSVuhVw6b+gI5ZYpbKz4sNTaqxz2Or+eiiBOT+s8vVrO4sCCWfz1DGI4bHRkK6i
         SkKIkPHvlrEFABfTuStC/oaswNpgE5/hBApzT/cJRZlh5165bcq3Xz7WmXTDT7hbmw
         +0YYww2Ife6NBiNfEj78D8hUMQ2ZxAv9EAOwTtwQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 2/3] dmaengine: xilinx: dpdma: add missing kernel doc
Date:   Sat, 18 Jul 2020 19:22:00 +0530
Message-Id: <20200718135201.191881-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200718135201.191881-1-vkoul@kernel.org>
References: <20200718135201.191881-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

xilinx_dpdma_sw_desc_set_dma_addrs() documentation is missing describing
'xdev', so add it

drivers/dma/xilinx/xilinx_dpdma.c:313: warning: Function parameter or
member 'xdev' not described in 'xilinx_dpdma_sw_desc_set_dma_addrs'

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 8e602378f2dc..430f3714f6a3 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -295,6 +295,7 @@ static inline void dpdma_set(void __iomem *base, u32 offset, u32 set)
 
 /**
  * xilinx_dpdma_sw_desc_set_dma_addrs - Set DMA addresses in the descriptor
+ * @xdev: DPDMA device
  * @sw_desc: The software descriptor in which to set DMA addresses
  * @prev: The previous descriptor
  * @dma_addr: array of dma addresses
-- 
2.26.2

