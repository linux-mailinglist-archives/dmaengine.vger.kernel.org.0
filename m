Return-Path: <dmaengine+bounces-637-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEE181C768
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 10:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE16287701
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78B0DDA3;
	Fri, 22 Dec 2023 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2Bxy7em"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB44D51E
	for <dmaengine@vger.kernel.org>; Fri, 22 Dec 2023 09:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C818BC433C8;
	Fri, 22 Dec 2023 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703238011;
	bh=7/zzLv+s75yYxyalmRpzEO7n63IpBkhs1hC0dCtI+yQ=;
	h=From:To:Cc:Subject:Date:From;
	b=u2Bxy7emgqix39GPYWdBQZwdTc/75PHyvcK/SR1QcnSMK5hXiCNQvPxPUM5+D2/01
	 PXa6loV9Ax9lUc/YBOgImmGiY+M7YWT/ejOSJgOw335MLarkRR+XhYMHIPgDTFg6T9
	 HpVgcu1es0uRWv2ZTdqFYHGviHcZR5JSqv1GTk+ag2T1r3iS6I/JTHNI8Pb+6AXzI4
	 Kt/QW+NCms9FXi8Gz0jsjTPExdcCmxKWnhC7f+ghEFZMMSCykk4vxUhfkOSju76k93
	 ZL/Tj4JY9i4bP5DY+9wyhberkFDYagkEAS23zTi199ZdDDeoi1AGJDWPeX7U2WbLRQ
	 kIz4jFrXXGRcA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] dmaengine: xilinx: xdma: statify xdma_prep_interleaved_dma
Date: Fri, 22 Dec 2023 15:10:01 +0530
Message-ID: <20231222094001.731889-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdma_prep_interleaved_dma() was local to file but not declared static,
leading to warning:

drivers/dma/xilinx/xdma.c:729:1: warning: no previous prototype for 'xdma_prep_interleaved_dma' [-Wmissing-prototypes]
  729 | xdma_prep_interleaved_dma(struct dma_chan *chan

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 9360b85131ef..4ebc90b41bdb 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -725,7 +725,7 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t address,
  * @xt: DMA transfer template
  * @flags: tx flags
  */
-struct dma_async_tx_descriptor *
+static struct dma_async_tx_descriptor *
 xdma_prep_interleaved_dma(struct dma_chan *chan,
 			  struct dma_interleaved_template *xt,
 			  unsigned long flags)
-- 
2.43.0


