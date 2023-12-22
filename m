Return-Path: <dmaengine+bounces-643-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277881CE47
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 19:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EAC1C21598
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9E2C1A6;
	Fri, 22 Dec 2023 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOsqJa9Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E72C19A;
	Fri, 22 Dec 2023 18:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0766C433CB;
	Fri, 22 Dec 2023 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703268411;
	bh=1NacUmbt0EL+svtNIQXZRZLRDTEQIO2JqZEQWM/2bL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bOsqJa9Z2mcuE07Kuz2eSAWosTxeaDtF/q2v65sbHGA7ebEHuNTiSVjILmaTGKqm0
	 1viWAz+89BjuLjd0fo7Vf7K3baMl0HfFHMT5utV0/eEEGIGknPAqI5gKSvfOvXLKg0
	 vUQw6x7EXx3m8T4FzUvL2XZJh+vcW0xKLAvEGQyVB8TbJ0Y62++OOtbpnxIzfe+HcY
	 AOlRCcjhwSokLf46G1Yk2dT8jCdV/pviSByjpFHe9iuvbEEbqCdSvU/7J42v+/0I6D
	 Cbo0nRCToqM/HhW9CTqyLPxYuOG7/KLWd4gNyQdOcKgSeuQn6tUrwkUObA5IdfLhW8
	 pWWX19xVjAw+Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 22 Dec 2023 11:06:45 -0700
Subject: [PATCH 2/2] dmaengine: xilinx: xdma: Fix initialization location
 of desc in xdma_channel_isr()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-dma-xilinx-xdma-clang-fixes-v1-2-84a18ff184d2@kernel.org>
References: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
In-Reply-To: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
To: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com, 
 vkoul@kernel.org, jankul@alatek.krakow.pl
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=nathan@kernel.org;
 h=from:subject:message-id; bh=1NacUmbt0EL+svtNIQXZRZLRDTEQIO2JqZEQWM/2bL4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmtFyz1xZ3TE51/h8nMXfzmg90qwSjOtSXl6o9Pl51zm
 iDiani6o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEykRJrhn8lFq0c/dhlvlqi7
 stmgek3Xfq3Sl+pm5T0v1NoS4l7tCmL4X8m6dGvo+leXfKrMLm/T04zVfqj6yKvxqkqfoL3LB9Y
 rjAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/dma/xilinx/xdma.c:894:3: error: variable 'desc' is uninitialized when used here [-Werror,-Wuninitialized]
    894 |                 desc->error = true;
        |                 ^~~~

The initialization of desc was moved too far forward, move it back so
that this assignment does not result in a potential crash at runtime
while clearing up the warning.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1972
Fixes: 2f8f90cd2f8d ("dmaengine: xilinx: xdma: Implement interleaved DMA transfers")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/dma/xilinx/xdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index d5b9fc3fd955..ee595d1ebc63 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -888,6 +888,8 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	if (ret)
 		goto out;
 
+	desc = to_xdma_desc(vd);
+
 	st &= XDMA_CHAN_STATUS_MASK;
 	if ((st & XDMA_CHAN_ERROR_MASK) ||
 	    !(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) {
@@ -901,7 +903,6 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	if (ret)
 		goto out;
 
-	desc = to_xdma_desc(vd);
 	if (desc->interleaved_dma) {
 		xchan->busy = false;
 		desc->completed_desc_num += complete_desc_num;

-- 
2.43.0


