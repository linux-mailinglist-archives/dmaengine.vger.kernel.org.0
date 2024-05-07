Return-Path: <dmaengine+bounces-2005-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E428BEFFA
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2024 00:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5753B1F236BF
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2024 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02CF7F7D9;
	Tue,  7 May 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azmfSubT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4F79B8E;
	Tue,  7 May 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122650; cv=none; b=HfxdGU6vQgnv1WOBvTL5qB6OtXQApPMueHfzzFLm8Y3ZBrjQ6SUVg515rPdRZF5pWvw9XE1sipbVdluiD7WkS25qEXcpNe/XOzw8/VgHXkMgFnB0qWvaajgq3bgACQ3Nvh+Tkv8SKHZxWojADD6PTs7Z9/30ry/+q+KXzX/zacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122650; c=relaxed/simple;
	bh=Y1YLWG+vsFsh3hpRPVr6H50UnxjkL+DQp6CYRFrDAUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPwkLIijBW7w1yrS7X5+ZuVFfVWGUASg3dUDb+HTRFHPtD6Q86AFo+xJF9GHzj7e222jPMOy8umlUIY+fXeLXxLcWDA9xbeXhGyTIRs1QZv2nPxXTwmPoqZL0sRApYaCj1ee7IehUO5FpZuj8xHnwbQAaWAALg/5pm3qLh//xAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azmfSubT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F5AC4AF63;
	Tue,  7 May 2024 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122650;
	bh=Y1YLWG+vsFsh3hpRPVr6H50UnxjkL+DQp6CYRFrDAUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azmfSubTCO4JtJWIXpS8L/Q3PNKwtHFJrFY+rFgzH75tiSRJ92xzxqRidqF9gwSFD
	 wLDhWjbe+PJORMNpOia6EU4CG+6+ViLXNA11YI2zOcxsmwJpw9IL10ziFyXZvIDnat
	 SP+/CqAgdm7Vi8Xw0N2z+OuU+e7zzjGvPThvXaMc4/LnwzGQHPk9IH8rSOKBt8iHVs
	 VhnLtvhIUeXjipTUail05Rz8l+twGuECYmiLwmo2MC+Vmxwefk4no//WU7FT4iS24Y
	 G0lBdfxfBIA8UztFRJMkmak45f6mGQ/W1N2SysSKhJlF7b6QNa/l5JwcCCdpPuvkA+
	 iHG0Pn6qnamFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 02/23] dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver
Date: Tue,  7 May 2024 18:56:28 -0400
Message-ID: <20240507225725.390306-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 7a71c6dc21d5ae83ab27c39a67845d6d23ac271f ]

Clarify the kernel doc of xdma_fill_descs(), especially how big chunks
will be handled.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://lore.kernel.org/stable/20240327-digigram-xdma-fixes-v1-3-45f4a52c0283%40bootlin.com
Link: https://lore.kernel.org/r/20240327-digigram-xdma-fixes-v1-3-45f4a52c0283@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xdma.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 5a3a3293b21b5..313b217388fe9 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -554,12 +554,14 @@ static void xdma_synchronize(struct dma_chan *chan)
 }
 
 /**
- * xdma_fill_descs - Fill hardware descriptors with contiguous memory block addresses
- * @sw_desc: tx descriptor state container
- * @src_addr: Value for a ->src_addr field of a first descriptor
- * @dst_addr: Value for a ->dst_addr field of a first descriptor
- * @size: Total size of a contiguous memory block
- * @filled_descs_num: Number of filled hardware descriptors for corresponding sw_desc
+ * xdma_fill_descs() - Fill hardware descriptors for one contiguous memory chunk.
+ *		       More than one descriptor will be used if the size is bigger
+ *		       than XDMA_DESC_BLEN_MAX.
+ * @sw_desc: Descriptor container
+ * @src_addr: First value for the ->src_addr field
+ * @dst_addr: First value for the ->dst_addr field
+ * @size: Size of the contiguous memory block
+ * @filled_descs_num: Index of the first descriptor to take care of in @sw_desc
  */
 static inline u32 xdma_fill_descs(struct xdma_desc *sw_desc, u64 src_addr,
 				  u64 dst_addr, u32 size, u32 filled_descs_num)
-- 
2.43.0


