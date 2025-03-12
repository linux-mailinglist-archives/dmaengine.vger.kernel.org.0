Return-Path: <dmaengine+bounces-4717-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24136A5E065
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654D13B5817
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5A24CEFD;
	Wed, 12 Mar 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfCnUMdr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CB156237;
	Wed, 12 Mar 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793580; cv=none; b=d9DijGlqraborReK3L2T1SPrEJdKCkrFLTWMvy18DcBXaC+Y3Vn8EczF3crPf941lRSTGpUQ7EJqBaAcibqjRFRt6qY67SidqLnnHGbxsf3Wx+o880rUs38aLbzL5QGQghs7aACIYqcKJigPNhB8LdYTkTqDp+xk+sc+2W8G8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793580; c=relaxed/simple;
	bh=k8azDV9EbMbJx2U1RMa8e+dntG00oZwMiLEuibATBbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CumEQY9KrCA82UdfojJYy+tFYk/cWEoRb+QjSesGswNi5F6kPmZvXpP2WF/5vvDBoum1f/gy1kxFX3+IKTjYcxvh0uGsgD4dZke4CG59Nl0qG694MFDJH8nUnNth3klZKItREfmPm3ixjesZL6QRKEkSCYI6JA+dwsMKYhPkIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfCnUMdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE6AC4CEDD;
	Wed, 12 Mar 2025 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741793580;
	bh=k8azDV9EbMbJx2U1RMa8e+dntG00oZwMiLEuibATBbw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nfCnUMdrWKxq7/lHng+6OW2NkFHvSXhK3oLyGFjP2V4Iv/F0JbJ2xaCZmbIy1NnuJ
	 HEG1eTnLacVzDeNX831o3vZzV+ZBzGaeDI9ecl5ZFDeRaJGM7Z3+YFdxjkwjdDep3o
	 XHmBHjl/HZXvdCP/U1USPzyCFCzn1GhWpwztaOOoVLo1PoKkw280oU2fR5vUfqiKZl
	 mMzsdYwC3UG+zukH3h7EDdlOCG+fpJzcG/hO2RZku9Xx55v6z6oV0inVBLVTYS8C4E
	 c3l7bkxHYjNc27bbKZKbc9P8895nYoyAYn7AYC05sP9U1TVhsw2Lh49ziEZM10Sl7k
	 2FZqjSKZjH5tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DA6C28B28;
	Wed, 12 Mar 2025 15:33:00 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Wed, 12 Mar 2025 10:32:50 -0500
Subject: [PATCH] dmaengine: Fix dma_async_tx_descriptor->tx_submit
 documentation
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-dma_async_tx_desc-tx_submit-doc-v1-1-16390060264c@amd.com>
X-B4-Tracking: v=1; b=H4sIACGp0WcC/x2NwQqDMBAFf0X23AVNK4i/UkqIm6fuwViytljEf
 2/wNMxl5iBDVhj11UEZXzVdU5HmVpHMIU1gjcXJ1a6t743juAQf7JfEb7uPMOFC+wyLbhxX4bY
 LDxkBh26gUnlnjLpfh+frPP84Wem8cQAAAA==
X-Change-ID: 20250312-dma_async_tx_desc-tx_submit-doc-58a4cfee2e8b
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741793579; l=1583;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=jp/DMy7JLfNicBeQPv3Ol20fnz7oTC0prR6cxoePnxE=;
 b=Mgbv/xwUHT1whJBL31TEUUUXdJfr2k6dY0JVcSLvH5yc3PnMmNCEzdW3p4i45rFohDbZJBN9w
 +xPAaXzrtP4Dd41ZF6C8Aw++raCCJPJa/3lwGJp9wqXu1XDLMq0HvCQ
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
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bb146c5ac3e4ccd7bc0afbf3b28e5b3d659ad62f..51e1e357892a0325646f82d580b199321d59ced4 100644
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
base-commit: 6565439894570a07b00dba0b739729fe6b56fba4
change-id: 20250312-dma_async_tx_desc-tx_submit-doc-58a4cfee2e8b

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



