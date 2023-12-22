Return-Path: <dmaengine+bounces-642-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149381CE45
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB541F22E0B
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948A2C188;
	Fri, 22 Dec 2023 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVu6VfJq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747C2C19A;
	Fri, 22 Dec 2023 18:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2331BC433C9;
	Fri, 22 Dec 2023 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703268410;
	bh=lX+6lFYU6sXpA5iyj5rt2HioLz9F3owwQBDV7k0OyTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fVu6VfJq2xG417MNUBKyvn4J5v99Z+2F/SHFohDTYUwqLcESvql6+1cHd1naw60YF
	 3V9EgoNP78KyLWVidzbzO9b63qr5eO/xlUZ3LDQ+Sk1CbIS9G7EHkARiTvm5Vnc18i
	 xJa9H+186q/CDsHSKB+Cs3jz19yvfcNRbqf0in1pa625/q+QqDw4HCyr6Pb98U7bpw
	 wIIg7bP6oIG22bO5ATf42G0jpaT6WO7trDgnZ0+LnuHndL+JEpS7mcHUJVWiPGREdJ
	 5yzUpXhD7uB3TkXUoRt6N1m823icEgz7XhBRkoVLgqlxYdQJVmj1zSX3o5WUBhMwUv
	 h2yRWtJWKk+jg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 22 Dec 2023 11:06:44 -0700
Subject: [PATCH 1/2] dmaengine: xilinx: xdma: Fix operator precedence in
 xdma_prep_interleaved_dma()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-dma-xilinx-xdma-clang-fixes-v1-1-84a18ff184d2@kernel.org>
References: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
In-Reply-To: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
To: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com, 
 vkoul@kernel.org, jankul@alatek.krakow.pl
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4102; i=nathan@kernel.org;
 h=from:subject:message-id; bh=lX+6lFYU6sXpA5iyj5rt2HioLz9F3owwQBDV7k0OyTM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmtFyx7Ze4/VD7pt1h+W8lNnvprb278cv+W4XF7seK9o
 5ZnX4vt6ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATafrB8L/IdbfJXEcTx1zX
 Esfv06SS5HecypBTfLHE5Erng29H2WYzMvxIvrAr7HXZEtaIxiM29qHFAWvbyqQ+MiYe9TnTkNZ
 yjAcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/dma/xilinx/xdma.c:757:68: error: operator '?:' has lower precedence than '+'; '+' will be evaluated first [-Werror,-Wparentheses]
    757 |                 src_addr += dmaengine_get_src_icg(xt, &xt->sgl[i]) + xt->src_inc ?
        |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
  drivers/dma/xilinx/xdma.c:757:68: note: place parentheses around the '+' expression to silence this warning
    757 |                 src_addr += dmaengine_get_src_icg(xt, &xt->sgl[i]) + xt->src_inc ?
        |                                                                                  ^
        |                             (                                                   )
  drivers/dma/xilinx/xdma.c:757:68: note: place parentheses around the '?:' expression to evaluate it first
    757 |                 src_addr += dmaengine_get_src_icg(xt, &xt->sgl[i]) + xt->src_inc ?
        |                                                                                  ^
        |                                                                      (
    758 |                                                               xt->sgl[i].size : 0;
        |
        |                                                                                  )
  drivers/dma/xilinx/xdma.c:759:68: error: operator '?:' has lower precedence than '+'; '+' will be evaluated first [-Werror,-Wparentheses]
    759 |                 dst_addr += dmaengine_get_dst_icg(xt, &xt->sgl[i]) + xt->dst_inc ?
        |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
  drivers/dma/xilinx/xdma.c:759:68: note: place parentheses around the '+' expression to silence this warning
    759 |                 dst_addr += dmaengine_get_dst_icg(xt, &xt->sgl[i]) + xt->dst_inc ?
        |                                                                                  ^
        |                             (                                                   )
  drivers/dma/xilinx/xdma.c:759:68: note: place parentheses around the '?:' expression to evaluate it first
    759 |                 dst_addr += dmaengine_get_dst_icg(xt, &xt->sgl[i]) + xt->dst_inc ?
        |                                                                                  ^
        |                                                                      (
    760 |                                                               xt->sgl[i].size : 0;
        |
        |                                                                                  )

The src_inc and dst_inc members of 'struct dma_interleaved_template' are
booleans, so it does not make sense for the addition to happen first.
Wrap the conditional operator in parantheses so it is evaluated first.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1971
Fixes: 2f8f90cd2f8d ("dmaengine: xilinx: xdma: Implement interleaved DMA transfers")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/dma/xilinx/xdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 4ebc90b41bdb..d5b9fc3fd955 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -754,10 +754,10 @@ xdma_prep_interleaved_dma(struct dma_chan *chan,
 	dst_addr = xt->dst_start;
 	for (i = 0; i < xt->frame_size; ++i) {
 		desc_num += xdma_fill_descs(sw_desc, src_addr, dst_addr, xt->sgl[i].size, desc_num);
-		src_addr += dmaengine_get_src_icg(xt, &xt->sgl[i]) + xt->src_inc ?
-							      xt->sgl[i].size : 0;
-		dst_addr += dmaengine_get_dst_icg(xt, &xt->sgl[i]) + xt->dst_inc ?
-							      xt->sgl[i].size : 0;
+		src_addr += dmaengine_get_src_icg(xt, &xt->sgl[i]) + (xt->src_inc ?
+							      xt->sgl[i].size : 0);
+		dst_addr += dmaengine_get_dst_icg(xt, &xt->sgl[i]) + (xt->dst_inc ?
+							      xt->sgl[i].size : 0);
 		period_size += xt->sgl[i].size;
 	}
 	sw_desc->period_size = period_size;

-- 
2.43.0


