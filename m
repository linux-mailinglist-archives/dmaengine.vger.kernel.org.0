Return-Path: <dmaengine+bounces-3251-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3AF98BC74
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF41C22F6D
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90051C32E7;
	Tue,  1 Oct 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UH0HCM5U"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F91C32EF
	for <dmaengine@vger.kernel.org>; Tue,  1 Oct 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786605; cv=none; b=uqY8PyJJnG4CV1yABz+WnGXoETtcH4yocja+Uoz3HXribvPzW+DiVluYuz4BHegNe0YwzBKGGikUfLJMS5FLUDtFR/v7yPps/pDR50Q8LdI9GKf7yKmgG5Z1Q/Vq/Lgo/xe2OnB00+M6FoYklNV99NQyIYoWKlpIIiO0owud/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786605; c=relaxed/simple;
	bh=funEQOjGU7Omtk2Q/rdES2ixyx+zejpAJEh/Q5Av1Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plBTYHl2De9AnLlOt6ugY6bch8eCH11hQmqA1JsOb/1+dYr2KzaB11g1oaUnGNvqLRewpvQrCeh4CXkP5hg3RgZE9MA5JslLl0qMU4mJVbfDvbozBoWT2H38iq9SKCtOzg/Uyd2fYuoG2mNoU1+dRDPJvQRV4WkGthXLRqPJ4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UH0HCM5U; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=SBKfrYLwWACNHIy0QWXmrXYW2TneHhxDyMo3N9Sf1q8=; b=UH0HCM
	5Uh62pLd5khWZ0sXaue0MUonaOodVfTRhvqDA1xBXvmfYx7twGsBEVKgUyVJMsuU
	KRRub8+2Y0TEz8AZND9b84970NZcgX/BsK3CesqW6wtbpDzS+vrube8DIQXCHpfR
	wLPOOCcRY17U00Tl0mJn5ZMPdu+DlXlBQ8trlQldIXYBe7jVxo13EH+zhOVfeTOm
	A7KlSvzzzAYzEJYncXDHYKvKzGXHIznTUROHUU8CkCdu1B1jMJw1X/0WPiPrpbRj
	an5YteWdqcWTur6+pcmD6vgNBG0wraOQZmOd02Kgh4vYiWcvxchZmvx/oJulYvfv
	lTTEh9RU+sPaR9YA==
Received: (qmail 2523620 invoked from network); 1 Oct 2024 14:43:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Oct 2024 14:43:14 +0200
X-UD-Smtp-Session: l3s3148p1@D+wrqmkjtNoujnuV
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	dmaengine@vger.kernel.org
Subject: [PATCH v2 1/3] dmaengine: sh: rz-dmac: handle configs where one address is zero
Date: Tue,  1 Oct 2024 14:43:07 +0200
Message-ID: <20241001124310.2336-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
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


