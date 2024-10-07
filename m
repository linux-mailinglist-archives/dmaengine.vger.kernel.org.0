Return-Path: <dmaengine+bounces-3274-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F49929D4
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 13:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9490B249CA
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 11:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FF1D14F8;
	Mon,  7 Oct 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AtyVKDjC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E81D0E26
	for <dmaengine@vger.kernel.org>; Mon,  7 Oct 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298943; cv=none; b=VdOCnY+KqFEY8v9HUw4DhCARkm3NAagJ505DoNjKyfVsYlBdqCRou7Y95QPL0NRU85vgzDvpCbE16xRyX5pLgKgZuzm0CDnb+e0oAy6lbjGwlOLjD9ClP7xDRMIOGeh6iogOs/EzThXNWSf2dQn1DDNe4G6Zog5SWgKKdwMR14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298943; c=relaxed/simple;
	bh=nngkMCmzlD5/KK2C1otq3AMCD9ZO8njuW2Mc4Pw1Jm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghgv8Zxji+kdUtWcXMSILEIPsnSdGZWTkydtLqw7ErxLCkNCyrj3G6gmbF38nhLmW01EuuljM4V8nYOeWQtQxRFRMcNuRyx8BmyqH/65/H0fRJstRKBp1mLNKiyjDabgmM8S4hxfGv8zsK4GxZy++5xVCrc4OBFhdN+Vqit7HyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AtyVKDjC; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=5nn0eQkafRUSLXQ4NP1rAJgTSymJ6mkYq8l8n/TCLFU=; b=AtyVKD
	jCdYpyfqb52c+/EvJ9NaGZD1nBAwrrS91l9lUw9aOpxTBJ7ScsY2zAf1cqPVL+i4
	cHYLzP1OxNsYaGKw5/tGHLhdo3Lfhb2sxC+Ke7DGqdGPyiCqgzaPu9PzrdoezxYC
	+9aByF1miwdOHLfZqqS+I95/hXy/FBpsgxco1PB8Ug8epFcBauLM4I//JBKCOBrv
	2ND0kGChhpMCuXxXUhwsj1zfkXZkry8hyYpmpNb7k824YuaFshc5aylr9E+UwSyy
	UUW0Lrh108jvfu8/V2SPiO78MFqcTlt9/fa4YMY7TUXxf9XoCorFjRFmsQrigeIb
	Y6X4+VSZGP/D48bA==
Received: (qmail 100788 invoked from network); 7 Oct 2024 13:02:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Oct 2024 13:02:16 +0200
X-UD-Smtp-Session: l3s3148p1@myEt9OAjsI0gAwDPXxi/APzxl2QXB/xr
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	dmaengine@vger.kernel.org
Subject: [PATCH v3 1/3] dmaengine: sh: rz-dmac: handle configs where one address is zero
Date: Mon,  7 Oct 2024 13:02:01 +0200
Message-ID: <20241007110200.43166-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007110200.43166-5-wsa+renesas@sang-engineering.com>
References: <20241007110200.43166-5-wsa+renesas@sang-engineering.com>
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
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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


