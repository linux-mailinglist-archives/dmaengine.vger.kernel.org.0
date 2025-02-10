Return-Path: <dmaengine+bounces-4413-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077ADA2FE6D
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 00:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A34165A25
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3825EF9F;
	Mon, 10 Feb 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4fn23Go"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFE25A35F;
	Mon, 10 Feb 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230186; cv=none; b=sC0oFh8TU8wtj4UgKLBR8GnWi1feG79sj15ah9mbvcaiz2+Qm/kQC6oBMGSTa3CF9HzgLbXUNmOq9kmTu0562/PLQ8cMLyWUxhGVIkaFiC1pYeoM/BpBnbEBvifvzLX5Sr9khxJNglvLHesH5JOzu9B2K71wnSGSJ2EHdJh7W0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230186; c=relaxed/simple;
	bh=UfArX+5faIlbV37jzYrR6suEime03V/svivPcDFy+jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AR3zqh3q0iH6kYkTtEZwh8Z/MysHObDpQrB/Ui+FN1g+83apWVhj+7B4ZjIAmmCB+nDPkd1G1xC+IDmf+VlgpeCdaHSGT/nfIiyqbnVmLDXE8Jd0eNjfmEk+Jl+NroiKFK518BVfKRxfcU2uQ81Ra+YihsRtokiNz5FGQWp7uew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4fn23Go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05EECC4CED1;
	Mon, 10 Feb 2025 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739230186;
	bh=UfArX+5faIlbV37jzYrR6suEime03V/svivPcDFy+jo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F4fn23GoGyTE2LUhbZLGHrqejOeNg0jDDo3cM5/ReioQrnh8U19ebI39YRSOijvid
	 Bjc6dXLoc7aOY7Ka3kkeO8FxdWr7Dvc+xqa7+KHRYcIk5Rt9aFTlqQbIzQJ9G4ktBJ
	 4HK2DrjlQW3is+Uw7oAXDTPoa8khtqimVrNFbZlO59S0Cm7TRIYclsXTdsC+FUA9bW
	 E2sW1gpH6gOed3kkIWtAtclDqZgiazRfih/EXRELVh3bW4K/jxWWZELt7gG+9s6bQH
	 hY/rCkNDqXp69gDJMYUgjWBCMv6408LsLpj5SN8XtLGXmiR9wUNWAuWf9AhY74uL2q
	 8JTQcX5ZyVOCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8040C02198;
	Mon, 10 Feb 2025 23:29:45 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 10 Feb 2025 17:29:11 -0600
Subject: [PATCH] dmaengine: Remove device_prep_dma_imm_data from struct
 dma_device
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-dmaengine-drop-imm-data-v1-1-e017766da2fa@amd.com>
X-B4-Tracking: v=1; b=H4sIAMaLqmcC/x3MSwqEMBBF0a1IjbsgBsXPVqQHhXnRGiRKItIQ3
 HsHh2dwb6GMpMg0N4USbs16xIr209C6S9zA6qrJGtsb2xp2QRA3jWCXjpM1BHZyCftBRgzd5Fd
 4qvWZ4PX3npfv8/wBAttvX2kAAAA=
X-Change-ID: 20250210-dmaengine-drop-imm-data-f7a8e749fcef
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739230184; l=1774;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=sXjE4x9Dbe9KQkwP5XNR830aZAR+1CIxnoSjbiiaAbk=;
 b=XxCcMUYHxv5qITDImcQuJbWFVgkGchmfqg8g+UnTZ+n01bHul4r3+72ROxnXuy50Y+PFTsq2g
 xhgZBPLLoMLA2zs83eJsaGaNy9ssNCyPOEhUMpgnv7mRGiXHVP+zG/d
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

The device_prep_dma_imm_data() method isn't implemented or invoked by
any code since commit 80ade22c06ca ("misc: mic: remove the MIC drivers").

Remove it, shrinking struct dma_device by a few bytes.

Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 include/linux/dmaengine.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index a360e0330436470bfea17f8df567ff785e4293ea..bb146c5ac3e4ccd7bc0afbf3b28e5b3d659ad62f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -839,7 +839,6 @@ struct dma_filter {
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
  * @device_prep_interleaved_dma: Transfer expression in a generic way.
- * @device_prep_dma_imm_data: DMA's 8 byte immediate data to the dst address
  * @device_caps: May be used to override the generic DMA slave capabilities
  *	with per-channel specific ones
  * @device_config: Pushes a new configuration to a channel, return 0 or an error
@@ -942,9 +941,6 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags);
-	struct dma_async_tx_descriptor *(*device_prep_dma_imm_data)(
-		struct dma_chan *chan, dma_addr_t dst, u64 data,
-		unsigned long flags);
 
 	void (*device_caps)(struct dma_chan *chan, struct dma_slave_caps *caps);
 	int (*device_config)(struct dma_chan *chan, struct dma_slave_config *config);

---
base-commit: 2c17e9ea0caa5555e31e154fa1b06260b816f5cc
change-id: 20250210-dmaengine-drop-imm-data-f7a8e749fcef

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



