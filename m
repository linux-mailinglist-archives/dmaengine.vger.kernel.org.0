Return-Path: <dmaengine+bounces-6990-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E4C09837
	for <lists+dmaengine@lfdr.de>; Sat, 25 Oct 2025 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9A60500691
	for <lists+dmaengine@lfdr.de>; Sat, 25 Oct 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CA30E837;
	Sat, 25 Oct 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIQ/pP45"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8130E826;
	Sat, 25 Oct 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409160; cv=none; b=p2pPrAqp2DedTcB1WzCcxLFWE8UHhmfk192Mw5jeJT2Z7QyeaQWQzDVzYvK5IKEc3Ty5G+XHuprqXhQuuoVN5zYqhrAQJPGNsfAnlN5YbEwBaICSSKYQC+C+nHUI5PDmpcggf4AxkKn+DdtywZ3j3IcGEzI/I9t8J6vjt+Zdg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409160; c=relaxed/simple;
	bh=9tuynwr3DlIJ4MzBHrEW0xZhrIW1/c8bpKQA5dTOmjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+EJCf+Un0lB87+YzgZM4j3PjHRlMDSVCU5w2NJC4niZvtD86ZKUYyu3Shy/STIfb+tKsE56/VNXq9XcxRSy4lHvjY8+eZdq6n15ea5JL2zC9Au208cIWet8Dh7GaweJ61nSJhKtba9NfmXBgtHrLS4cc1j1TCLzzl/z8nH3Gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIQ/pP45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17AEC4CEF5;
	Sat, 25 Oct 2025 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409160;
	bh=9tuynwr3DlIJ4MzBHrEW0xZhrIW1/c8bpKQA5dTOmjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIQ/pP45jRPtZfmRzoqLGzq9HrG/POVjtOXfY+tmA9pzrPBn4NamnIMjukVxdML7m
	 lObPoCSTTJ+7J4v9vNUocOWA55sBjDmTQKT1r2xcShvUJy73SKcvm93/dmXkEJvHlX
	 xF0ZeazXkBfuHJjTLguKfN9TbL7uK5w1pk5giDp0xcye6tf9+c1NROb1Vcxx6auNjW
	 FgNa1GLGj9iZ/aVqxVIERpf6czr6KVHV00bKoyWY1ESHK5DEwInK7Xk/dhSQkd6gG3
	 9JjnKdbTJAW6L2XeupiBdrJ6z0fFXJuM0kiQoC1v0Gu/71qDUajbawPy65C99be4/S
	 eQTCp6CSw9q6w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] dmaengine: mv_xor: match alloc_wc and free_wc
Date: Sat, 25 Oct 2025 11:57:35 -0400
Message-ID: <20251025160905.3857885-224-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit a33e3b667d2f004fdfae6b442bd4676f6c510abb ]

dma_alloc_wc is used but not dma_free_wc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Link: https://lore.kernel.org/r/20250821220942.10578-1-rosenp@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- The change fixes a real API mismatch: the descriptor pool is allocated
  with write‑combined attributes via `dma_alloc_wc`, but previously
  freed with `dma_free_coherent`. The patch replaces those frees with
  the correct `dma_free_wc` in both teardown paths:
  - `mv_xor_channel_remove`: drivers/dma/mv_xor.c:1016-1017
  - `mv_xor_channel_add` error path (`err_free_dma`):
    drivers/dma/mv_xor.c:1166-1167
- The allocation site clearly uses WC memory for the descriptor pool:
  - `dma_alloc_wc(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
    GFP_KERNEL)`: drivers/dma/mv_xor.c:1079-1082
  - The surrounding comment explicitly notes the write-combine choice
    for performance and the need to handle it correctly.
- Why this matters:
  - The DMA API requires pairing `dma_alloc_wc` with `dma_free_wc`.
    Freeing WC allocations with `dma_free_coherent` can fail to tear
    down mappings with the correct attributes, leading to DMA-API debug
    warnings, potential resource leaks, or attribute mismatches on some
    architectures.
  - The affected code runs in deterministic paths (channel remove and
    probe error unwind), so it’s directly user-visible on driver unload,
    device removal, or probe failures.
- Risk assessment:
  - The fix is minimal and localized (two call-site substitutions), with
    no architectural or behavioral changes to normal data paths.
  - It is strictly a correctness fix and reduces the chance of DMA-API
    issues; it does not introduce new features or touch wider
    subsystems.
- Stable backport criteria:
  - Fixes a concrete bug (API misuse) that can affect users (warnings,
    potential mapping/attribute teardown issues).
  - Small, self-contained change limited to `drivers/dma/mv_xor.c`.
  - Very low regression risk, as the free operations now match the
    established allocation method already in use.
- Applicability note:
  - This should be backported to stable series where `mv_xor` allocates
    the descriptor pool with `dma_alloc_wc`. If an older stable tree
    still uses `dma_alloc_coherent` for this pool, the patch is not
    applicable there.

 drivers/dma/mv_xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 1fdcb0f5c9e72..5e83862960461 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1013,7 +1013,7 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 
 	dma_async_device_unregister(&mv_chan->dmadev);
 
-	dma_free_coherent(dev, MV_XOR_POOL_SIZE,
+	dma_free_wc(dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 	dma_unmap_single(dev, mv_chan->dummy_src_addr,
 			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
@@ -1163,7 +1163,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 err_free_irq:
 	free_irq(mv_chan->irq, mv_chan);
 err_free_dma:
-	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
+	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
 err_unmap_dst:
 	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
-- 
2.51.0


