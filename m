Return-Path: <dmaengine+bounces-2006-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A28BF432
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2024 03:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1FA28281F
	for <lists+dmaengine@lfdr.de>; Wed,  8 May 2024 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFA2563;
	Wed,  8 May 2024 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT4zx3kd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF31A2C12
	for <dmaengine@vger.kernel.org>; Wed,  8 May 2024 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132611; cv=none; b=czaqvXk4zMuWpUmpqGXxvj6CRgbVt5U6g8wtpAt3PW5zJ963Ny+EeWMT8LYNBbHCRxa3TfjZEA3D7GUMccLkduUFmTBUYTIka1jr11t3gmd6sIyWzourvnplzdsFwAujTUvU5IHONW7fCudM7egORv3DOrEuPhSCv1uJzHetk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132611; c=relaxed/simple;
	bh=Ugpf/QZ+/eVcGEeMArUhQ+WsD3q6VJmq+5VZQuuWgK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/lGPva/NnnIOB4aby6smXwy8pnXtH56rED1EQaRdw/rR8rAlqV/qLZdDR5MZ31x3rU2XjoFJnUvhFKo14yc5wfpJy9e+Yy69eUjpyCuYl7pAjfBxJK/pq5rdDL4vGCsOtzYxgQhhr7NGWT8jkJD+k+oL1zSTWO8hQCf18NJojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT4zx3kd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2195805a12.3
        for <dmaengine@vger.kernel.org>; Tue, 07 May 2024 18:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715132609; x=1715737409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQZcjxY3GcvpxZoTfNHgbcmr3U6H1C83Efj5y/1m668=;
        b=IT4zx3kd3xb1Y6lMxAP9oqs0Rc84KZi4A1BFsRyI5m3/eJYFOj2d2z1qArZtNLIi3H
         z7ebfD7zcx1uTlNUQ3alLHr5RqabmdFU1f2Du6IRQEmjnVKYaoxcqfE2jsgHQxerJFE8
         4W/c/Q99eW/e+khvb6Rjb4pJA55zMZ/xDdM3lZlm+teR3S5fyQlvuQs2wb6czS6ewkHX
         38jZfn9Lu3DJeMQQOlaqJI4yqlyPH8EEN5fsQZ6cLBickBgjHivHXJB3kywp9SiE2fla
         mTq3JAJV3eI4OGFZaFS/740GjVFVgnqopK++ejVxXR3sDK5OIU5WtKsQNw8aATdnLfLD
         tpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132609; x=1715737409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQZcjxY3GcvpxZoTfNHgbcmr3U6H1C83Efj5y/1m668=;
        b=bsgSir+LmL+m+f5nAh40AbrVbhozTp7uXxWX9X6kr7Jeu8mxNjS9RRMzUkN+el9auM
         d9C0G51HZPh0tkUgglK0VHn9J2E6f3qJM0Vwmro6Ouhz06xWwddOJcaH71hHdCxkM4ax
         XqBHM6rj+RjLSuXz8SOAkbcoWickyf2O5Gi+3xFEBvc+SCsi3ANYomQxKeMGaAxH/zt6
         7oxWNCvi51ca/SbFNXimj3oHE4Rali+zu4j7QGeGrUE9/cTfpijUFqmhSEgVBkDwa0MO
         sxKjd+a8diqQ3s0/bWp9WyZc5QD9OHX7TBNmxs+0hfAiuBuWwezbpp3R5zQC42SW3BB+
         jSdg==
X-Gm-Message-State: AOJu0YxhltSnqKbGilyLpSRlCbRI+D9+yjYtrpRYv+HrAiN3tmm5e3gl
	XNmCSG87+SSEk+n+BQGlNEyWM2Jo4pUHufaGSayxgBflKbugwe+j/5P53fS8
X-Google-Smtp-Source: AGHT+IGUzTutr321Sl35a/rUN0LLozqoBrGdaDn8Mq7B9R7N8+Gs4UzogcgCR8kC5TXqTy7S600rdQ==
X-Received: by 2002:a05:6a21:33aa:b0:1ad:2016:dff2 with SMTP id adf61e73a8af0-1afc8d517ffmr1785632637.26.1715132609066;
        Tue, 07 May 2024 18:43:29 -0700 (PDT)
Received: from localhost.localdomain ([202.188.176.82])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001e43576a7a1sm10617369plh.222.2024.05.07.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 18:43:28 -0700 (PDT)
From: Tan En De <endeneer@gmail.com>
X-Google-Original-From: Tan En De <ende.tan@starfivetech.com>
To: dmaengine@vger.kernel.org
Cc: Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com,
	jiajie.ho@starfivetech.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [v4,1/1] dmaengine: dw-axi-dmac: Support src_maxburst and dst_maxburst
Date: Wed,  8 May 2024 09:42:16 +0800
Message-Id: <20240508014217.1411-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.38.1.windows.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation has hardcoded CHx_CTL.SRC_MSIZE and
CHx_CTL.DST_MSIZE with a constant, namely DWAXIDMAC_BURST_TRANS_LEN_4.

However, to support hardware with different source/destination burst
transaction length, the aforementioned values shall be configurable
based on dma_slave_config set by client driver.

So, this commit is to allow client driver to configure
- CHx_CTL.SRC_MSIZE via dma_slave_config.src_maxburst
- CHx_CTL.DST_MSIZE via dma_slave_config.dst_maxburst

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
v3 -> v4: Update patch after rebase with dmaengine/next
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 18 +++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  3 ++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index fffafa86d964..18ce7d64958b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -657,7 +657,7 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 	size_t axi_block_ts;
 	size_t block_ts;
 	u32 ctllo, ctlhi;
-	u32 burst_len;
+	u32 burst_len, src_burst_trans_len, dst_burst_trans_len;
 
 	axi_block_ts = chan->chip->dw->hdata->block_size[chan->id];
 
@@ -721,8 +721,20 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 
 	hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
 
-	ctllo |= DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
-		 DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS;
+	dst_burst_trans_len = chan->config.dst_maxburst ?
+				__ffs(chan->config.dst_maxburst) - 1 :
+				DWAXIDMAC_BURST_TRANS_LEN_4;
+	if (dst_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+		return -EINVAL;
+	ctllo |= dst_burst_trans_len << CH_CTL_L_DST_MSIZE_POS;
+
+	src_burst_trans_len = chan->config.src_maxburst ?
+				__ffs(chan->config.src_maxburst) - 1 :
+				DWAXIDMAC_BURST_TRANS_LEN_4;
+	if (src_burst_trans_len > DWAXIDMAC_BURST_TRANS_LEN_MAX)
+		return -EINVAL;
+	ctllo |= src_burst_trans_len << CH_CTL_L_SRC_MSIZE_POS;
+
 	hw_desc->lli->ctl_lo = cpu_to_le32(ctllo);
 
 	set_desc_src_master(hw_desc);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..d76d3d88ceb6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -270,7 +270,8 @@ enum {
 	DWAXIDMAC_BURST_TRANS_LEN_128,
 	DWAXIDMAC_BURST_TRANS_LEN_256,
 	DWAXIDMAC_BURST_TRANS_LEN_512,
-	DWAXIDMAC_BURST_TRANS_LEN_1024
+	DWAXIDMAC_BURST_TRANS_LEN_1024,
+	DWAXIDMAC_BURST_TRANS_LEN_MAX  = DWAXIDMAC_BURST_TRANS_LEN_1024
 };
 
 #define CH_CTL_L_DST_WIDTH_POS		11
-- 
2.34.1


