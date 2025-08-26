Return-Path: <dmaengine+bounces-6217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61979B36F7C
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081EF1895271
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD412417D9;
	Tue, 26 Aug 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNBDI3/5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF8271448;
	Tue, 26 Aug 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224461; cv=none; b=Wcf6gP79eOH5LWLfE6ZwzYYbYPZTeiK3Hv+FXD6woXFD/Rk78S6yOQC8F42/yorsH5SLbWteInf+5ZaBizRBayn7+vCm1zoo2Ye7EDNlXk7pwjQymL0yFOk63GeZHlWDseZPFh7Yrbyhl5Nv08A4GFrUO1XdNQjsYqEhyAieYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224461; c=relaxed/simple;
	bh=UxuKFI9Gz6XRsBEgIbEMc2qAqnLEy9QJYLuXH+fSscY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/lyNGnLfawij07WL5MRoDmmOfqF8YBGoiHqjapDrcKKyUrSGPl7scfSKJ7GB8ySV0n2W8VVu2tJaVlir9/juDi1dcFVvtuQZEBhemZ+tuFjwkXGgBe6J2wh/BzTaq1SJbjWuau0/HWb2El0UBBcBkQuuA7li6aG6l3peRZNDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNBDI3/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95743C4CEF1;
	Tue, 26 Aug 2025 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756224460;
	bh=UxuKFI9Gz6XRsBEgIbEMc2qAqnLEy9QJYLuXH+fSscY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=PNBDI3/53J1sL6A0DDzao4eFz0dzHyzyX9zhXy1rEOfL2rRmAA1gFqUP2WjaIWeR0
	 hn1LV7J67TtBrAM6g1X8i3/XWAbvJioxz+hZCb5XXFhek4850mckBRU5Wck+Cjpa6P
	 3zrooSWEtIbpcc6Mdq9Y6W/SAu0Ud/aYeEUH4jmIpa4KCYg7jOWwQOh9fBlATaJ2xI
	 zj8W7yaMIsgzqh1gKRjpWpgdUU8dX6Xp3v4puR8gaarn3Ip8gue1R8lq4seJKF6o27
	 yiU3ezmcAEFaHkjAVsKxbWaIhKnkGMyNEmbnXDThSi6KFtPhkMIwDUjTlxEs6At9jE
	 UFXwTNrD7srZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C61CA0FF2;
	Tue, 26 Aug 2025 16:07:40 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 26 Aug 2025 11:07:38 -0500
Subject: [PATCH RESEND] dmaengine: Fix dma_async_tx_descriptor->tx_submit
 documentation
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-dma_async_tx_desc-tx_submit-doc-fix-v1-1-18a4b51697db@amd.com>
X-B4-Tracking: v=1; b=H4sIAMnbrWgC/x2NMQvCMBBG/0q52YOaagnOdu2go0hIcle9oankq
 lRK/7vB6fHe8H0rKGdhhVO1QuaPqEypyH5XQXz69GAUKg6mNsfamhZp9M7rN0U3L45YIxbqO4w
 yI00RB1mwCZZsaIcDxQbK0itzyf+XG1y6a9ef4b5tP2/pqXF9AAAA
X-Change-ID: 20250826-dma_async_tx_desc-tx_submit-doc-fix-3b8d8b6f4dc3
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756224459; l=1773;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=dIS6RoLkC1q3aI/0+NdaHu4Yd3RD9SjlUuZZHRlnaK8=;
 b=kKd1JVU0GPX4JoS9X5N5yAf9XN3rDuTtvp0R4k3NWvYCBveJlX5Eo2PK+jS4ERpVmfrXOSWjO
 uYYYnlNiM1EC9UGsIEYBOMW6hSpUb2zhB30IxZK8DxdL0pXMlol+IGy
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Commit 790fb9956eea ("linux/dmaengine.h: fix a few kernel-doc
warnings") inserted new documentation for @desc_free in the middle of
@tx_submit's description.

Put @tx_submit's description back together, matching the indentation
style of the rest of the documentation for dma_async_tx_descriptor.

Fixes: 790fb9956eea ("linux/dmaengine.h: fix a few kernel-doc warnings")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
Originally sent 12 Mar 2025:
https://lore.kernel.org/dmaengine/20250312-dma_async_tx_desc-tx_submit-doc-v1-1-16390060264c@amd.com/
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6de7c05d6bd8c99e176fe2fde0a9c3b55d40b37c..99efe2b9b4ea9844ca6161208362ef18ef111d96 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -594,9 +594,9 @@ struct dma_descriptor_metadata_ops {
  * @phys: physical address of the descriptor
  * @chan: target channel for this operation
  * @tx_submit: accept the descriptor, assign ordered cookie and mark the
+ *	descriptor pending. To be pushed on .issue_pending() call
  * @desc_free: driver's callback function to free a resusable descriptor
  *	after completion
- * descriptor pending. To be pushed on .issue_pending() call
  * @callback: routine to call after this operation is complete
  * @callback_result: error result from a DMA transaction
  * @callback_param: general parameter to pass to the callback routine

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250826-dma_async_tx_desc-tx_submit-doc-fix-3b8d8b6f4dc3

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



