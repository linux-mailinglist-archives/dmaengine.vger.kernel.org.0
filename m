Return-Path: <dmaengine+bounces-5315-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D298ACFD51
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A623A961A
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDC58210;
	Fri,  6 Jun 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/S2ocwP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E143596A;
	Fri,  6 Jun 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194253; cv=none; b=fhuy4r1mm5VwlT8bcNSvpECXNRxkLBbGu4mKxqPhqWLilRrNrkqGUOCePqcPHESGCpJi3fEG9j5eNo6ktrbuBSiNA20HZVvVsMK7ZU1W3RuO0RtoEF2hHc/2clK6A+GxJYqRSIns4VUMP/9BWQM9Eexf+seuHG8NuUNTZRhM0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194253; c=relaxed/simple;
	bh=9t12MyJG8VW40lDR99jNCtmzlyczu/kzZL9Ahq6Na1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HpTNYtUVAoRQ5EscwSoZWaQNbnc0BZE1pGuyMywWhOZnljE0Tb5bMEg9mOf8hl9JQXNzT7zhOVIMhwZGL4EJo1P/1S4DWesBwmWldb5zu9FBfQPeaamlqsMTunIypM5XLjEmkA/Tn+utawAY5shuu1TqQPg77lAl60Q0yCS1y3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/S2ocwP; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-231e8553248so18567445ad.1;
        Fri, 06 Jun 2025 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749194250; x=1749799050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKV+4ax/i9KS9PUFjbXXlSMf8xi5c4xdtzVPWafiCz4=;
        b=k/S2ocwPF55Oxo0YnegweDhyoPODzwzKVYq5auMcmVe2b8HJPfQpmCW89PRiR/MUoL
         pYc8TgJ6P5J3JdLWBunopETwYKL6P6zN99yKPOXwan4KaWlyVgOhZR0JG3/826zVP3nP
         +aLZju2CYnyAVVGiDU/ejFENj9Cy4jnuMWAl11+6IgQXLx3N0po/YX3TeoikF/brEwcw
         UAdCmRTHJOjaUSivZaG7iiSPdKcw9LAxAtArMXfnOoaub3x4ZKlSiI0AwvheGWlJM78a
         /EZ5pOs5WheVJIoe+NERVfX5KH/0q4VRbXMBjGx1EmtpjBKtyVmk8LUs0TNcYo4Nga6X
         IgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749194250; x=1749799050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKV+4ax/i9KS9PUFjbXXlSMf8xi5c4xdtzVPWafiCz4=;
        b=aAJVnZptgud5crX4YHUFaw6ibLYqGUZjdTgMgoNCCJOBumjK0AP2x6nKao1d2dhVOO
         fMBTwaOzYUJEmKReyZOYhXzgwanHqHBtyuxfxNqS9Xd2mi1Qolnxb08SFaGnO3iVYHMq
         swuKsqSxIbn4hsVwcCK1EejxFxRj9Gqsi5/bxWBps50MIgdngbhnCa7aloPz49Tp0pIW
         6IpQD9XzQFhgrCrkfQACfVk8Cf9rdStdVGex/K2wvrOJgR/oJnTcgZItobggnnGOZHQp
         0jefr/NVvszlbqZ2LH1t5K020Hw2TQLRcgofMVrXp0sPVHM6mMmvTm3DORG570fth00J
         2tow==
X-Forwarded-Encrypted: i=1; AJvYcCVIS4fhtTVBDH1l+AyVbAjGpectbtHSPIjQXu9pwU8nLMRucJjsJ0fUtaXUHlfP4h9XZEwqOvoA2YUKaEU=@vger.kernel.org, AJvYcCWRdSa/hN/5dljEl0aFh+6McFTxVR6WBByCArEYOkOlHW9x8/+n/03ZtWkxOOOOPbpM5wnDU7dU@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLCk5/I5GEhLwJsM7o4TI4z+I6p8pKmoM5H966T9iLDON0NgG
	88OTNjdGCzeuZC3ugbMLxEqMW8Y5EPP1v8lzemsLJ1B4Ri+Pkvvh3Drn
X-Gm-Gg: ASbGnctjZz3XkCu6KRKDrrF50j5TKKsdav97kkju1h0T6Rqy25lm9EvZ96r3svgmYQc
	6Nbfk4QMughHVTwiBZcd32k/+eg12qL4Qa5127Q/gC6/31lY3Pg44M5YvbwIBtZ8Q6Bvuw58aBu
	6Ck6dB7USMYcKXmryDREKYsgeNeKRILhi26aJVuRUn/zILVr4X0+u4h4+yMHrOLlxf/gV/OQW00
	89EmW3Sue2/AOqlImQ32aoqxEEb328CgK8O12OxIVhCs1DQ0R2gF1iGpIZrh2pu76JrRkQLoK+4
	76eN3CVoL4B5pmt6wYLihkTpLeAMSm2rOrfenBPSJIyEm41/8YFhCLLopzXxGcTpwZ9aRnNcpA1
	flY+2
X-Google-Smtp-Source: AGHT+IGNo3qVc1h80cdtsdbqFE6SC5h8TPFPCwUyuDcI25fbiI6mtb5/kXy0fdjUUtBwCDDEu4pmyA==
X-Received: by 2002:a17:903:230b:b0:234:ef42:5d48 with SMTP id d9443c01a7336-23601d82cf8mr34434925ad.38.1749194250516;
        Fri, 06 Jun 2025 00:17:30 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032ff216sm6482015ad.111.2025.06.06.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 00:17:30 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: sean.wang@mediatek.com,
	vkoul@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()
Date: Fri,  6 Jun 2025 15:17:09 +0800
Message-Id: <20250606071709.4738-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.

Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505270641.MStzJUfU-lkp@intel.com/
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/dma/mediatek/mtk-cqdma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 47c8adfdc155..f7b870d2ca90 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -441,18 +441,19 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	struct mtk_cqdma_vdesc *cvd;
 	struct virt_dma_desc *vd;
 	enum dma_status ret;
-	unsigned long flags;
+	unsigned long pc_flags;
+	unsigned long vc_flags;
 	size_t bytes = 0;
 
 	ret = dma_cookie_status(c, cookie, txstate);
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-	spin_lock_irqsave(&cvc->pc->lock, flags);
-	spin_lock_irqsave(&cvc->vc.lock, flags);
+	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
+	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
+	spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
+	spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);
-- 
2.34.1


