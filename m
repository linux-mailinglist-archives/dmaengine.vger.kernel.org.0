Return-Path: <dmaengine+bounces-897-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3103B84295B
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40BB1F27EDE
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1512C54A;
	Tue, 30 Jan 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBgUr2m4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94412C54C
	for <dmaengine@vger.kernel.org>; Tue, 30 Jan 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632352; cv=none; b=LgiVZ/Pkv8fzlfr7TtcyBT+6Ofv7WnZzyc/lCSrJb/OJEEkh2AOoQfZf+FJ+lKlQ86PkwA941tsSmIR9jg6XtlMGq8GIRT+BA8yZ29o037rdAPbCxRVsyqUSX9hYimoWDS0ehbAzVPHPDWuYGG247yyvj9V0Old8fc4rdVa+hQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632352; c=relaxed/simple;
	bh=wZ57uzC12Q9Pwafg2LW/+VktNHt4IPaSm9ND4/kMBsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0qZs+ieUqwNJRHchMgL6a7KpgTgd+9apGQ1LxwNiEV0tMjiFrS/4v6mnJ+Q8WmSEnRXiOH1Wx+bNQAroFPI6WlEfqE8jazddJM9SG1AmeM6NCmuaAq09EP2+8GXQUGZnBeBHGe3pjPHH9px0nS3ys+3EMg1XOgJSPssEATnZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBgUr2m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF21C43390;
	Tue, 30 Jan 2024 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706632351;
	bh=wZ57uzC12Q9Pwafg2LW/+VktNHt4IPaSm9ND4/kMBsY=;
	h=From:To:Cc:Subject:Date:From;
	b=SBgUr2m41a/mXylfewNFpWQJm5fBz/h8MV+qRKcj0x+OcEnto/QARdR19BfKGGaPa
	 M3juZJw3rloAiHu660g9c9Fr9qmvzqTeuYqj5HsY5hsC6FfUtzwbCOEZ6OIyC6Id4/
	 2/NjPGcMQbX/1Hy19lZKlue9ZX8N/MYX3LUzcX3SJA1ymwj+SBmKkG9i0xruQD6FTz
	 FIKis38DGXHPiDJRGoCtGyOowZD99stt4+A9yKXDffkGeGp9FBUqRmjYoaO+HK7AMG
	 hmmBqDdzvUr/OIc0+4m56yVKCAp0jX1D42x7qhWXLSZ9UuN4IATW+fGP2WzKkOlE9M
	 Lt6lReaxM01ag==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dmaengine: at_hdmac: add missing kernel-doc style description
Date: Tue, 30 Jan 2024 22:02:16 +0530
Message-ID: <20240130163216.633034-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We get following warning with W=1:

drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'boundary' not described in 'at_desc'
drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'dst_hole' not described in 'at_desc'
drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'src_hole' not described in 'at_desc'
drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_buffer' not described in 'at_desc'
drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_paddr' not described in 'at_desc'
drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_vaddr' not described in 'at_desc'
drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_PAUSED' not described in enum 'atc_status'
drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_CYCLIC' not described in enum 'atc_status'
drivers/dma/at_hdmac.c:287: warning: Function parameter or struct member 'cyclic' not described in 'at_dma_chan'
drivers/dma/at_hdmac.c:350: warning: Function parameter or struct member 'memset_pool' not described in 'at_dma'

Fix this by adding the required description and also drop unused struct
member 'cyclic' in 'at_dma_chan'

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/at_hdmac.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6bad536e0492..57d0697ad194 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -224,6 +224,12 @@ struct atdma_sg {
  * @total_len: total transaction byte count
  * @sglen: number of sg entries.
  * @sg: array of sgs.
+ * @boundary: Interleaved dma boundary
+ * @dst_hole: Interleaved dma destination hole
+ * @src_hole: Interleaved dma source hole
+ * @memset_buffer: buffer for memset
+ * @memset_paddr: paddr for buffer for memset
+ * @memset_vaddr: vaddr for buffer for memset
  */
 struct at_desc {
 	struct				virt_dma_desc vd;
@@ -247,6 +253,9 @@ struct at_desc {
 /**
  * enum atc_status - information bits stored in channel status flag
  *
+ * @ATC_IS_PAUSED: If channel is pause
+ * @ATC_IS_CYCLIC: If channel is cyclic
+ *
  * Manipulated with atomic operations.
  */
 enum atc_status {
@@ -282,7 +291,6 @@ struct at_dma_chan {
 	u32			save_cfg;
 	u32			save_dscr;
 	struct dma_slave_config	dma_sconfig;
-	bool			cyclic;
 	struct at_desc		*desc;
 };
 
@@ -333,6 +341,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
  * @save_imr: interrupt mask register that is saved on suspend/resume cycle
  * @all_chan_mask: all channels availlable in a mask
  * @lli_pool: hw lli table
+ * @memset_pool: hw memset pool
  * @chan: channels table to store at_dma_chan structures
  */
 struct at_dma {
-- 
2.43.0


