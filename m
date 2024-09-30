Return-Path: <dmaengine+bounces-3237-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B89D98A80A
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E57EB28268
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B659192599;
	Mon, 30 Sep 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Iga73FiM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2B19258C
	for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708401; cv=none; b=R+eCYNgagC5P36R6wweW7HQPegfit0V6ryHXzjPwJ/7MlakcriKgzF7dsT1tUSyo70wiXRREy1HQIhhd5L3rwKU2oQ/EBJo8uyjenjej7WhNEFW0+o2comkpOuCUHbWbtqHAciiDwcdVKsVEnRo2p18v7G0Wi3B22b/nd1YuEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708401; c=relaxed/simple;
	bh=IW4P0dA51k8Ccb+8Vq9h4ral2GecoXnmNnoryGsZxMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE5E8pL0B+vsT/fhS7FcbLPXRi9RB9Nw8MxKzCRNPqHCi3qyJRLYyyM+QLGlvr1NXSRB/746jzmd8+GyswO5BAOIUEgN+/JvM9CBMoIZhZTPX15S1dcq8EINjyjfchu1F8TLB5pQZhf9B6UDN+KkWJQh+UvAwVP/2UicOt0R9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Iga73FiM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=1t1j0IfehHHrwnyAo3CZ9tu5Bk9Gr8jQRiRmvo9kQHA=; b=Iga73F
	iMy4sZKwtZAfA9pAr1DZK+Y+zzpE6B5fbQJFjnYi9qA4ElO569eiO7GwBB1sn0BC
	msNOB61C0V7gvwMN55NroSVyWYZtM5oXYsf15FruX7dkoLSzLNg+mvwMfLPgDyJY
	TyPEXgTUG4yczqM8/MkbVaRZYMUda1U3MdnoSmYKZLDfoBE/sS9Emox8ukrev9yz
	3nS02+mkWpUnh3RGDV4n95icMlfFQD0Sd7Ci/0NSWeePQ0+f2zTfjcCIvDBipfU1
	yu0UzWjj3S0z62+R5uduR3sTr7+z3pwuZc+nrklwrdbLyWvHlg7sY94q2IFxLEWp
	SjL/kRgvHWsAn54Q==
Received: (qmail 2222634 invoked from network); 30 Sep 2024 16:59:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2024 16:59:57 +0200
X-UD-Smtp-Session: l3s3148p1@S1FOdVcj4OYujnsJ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	dmaengine@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one address is zero
Date: Mon, 30 Sep 2024 16:59:52 +0200
Message-ID: <20240930145955.4248-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configs like the ones coming from the MMC subsystem will have either
'src' or 'dst' zeroed, resulting in an unknown bus width. This will bail
out on the RZ DMA driver because of the sanity check for a valid bus
width. Reorder the code, so that the check will only be applied when the
corresponding address is non-zero.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 65a27c5a7bce..811389fc9cb8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -601,22 +601,25 @@ static int rz_dmac_config(struct dma_chan *chan,
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	u32 val;
 
-	channel->src_per_address = config->src_addr;
 	channel->dst_per_address = config->dst_addr;
-
-	val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
-	if (val == CHCFG_DS_INVALID)
-		return -EINVAL;
-
 	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
-	channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
+	if (channel->dst_per_address) {
+		val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
+		if (val == CHCFG_DS_INVALID)
+			return -EINVAL;
 
-	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
-	if (val == CHCFG_DS_INVALID)
-		return -EINVAL;
+		channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
+	}
 
+	channel->src_per_address = config->src_addr;
 	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
-	channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
+	if (channel->src_per_address) {
+		val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
+		if (val == CHCFG_DS_INVALID)
+			return -EINVAL;
+
+		channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
+	}
 
 	return 0;
 }
-- 
2.45.2


