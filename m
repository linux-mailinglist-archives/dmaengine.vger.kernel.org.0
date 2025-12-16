Return-Path: <dmaengine+bounces-7669-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11427CC371A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 15:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA04E30047D7
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5537C0FA;
	Tue, 16 Dec 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="glLR6ZNN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB5334E267
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894267; cv=none; b=rXTmonY/Nxfv0EkWLXkwoQtSLZd7MGtwRRx0GO66b2GZIulKXyxwuYeZ85ji48V2fiVHeVvqDBzoeC5Ta01X3ia2F0WzqdWczmxhYTX18SNeCFkPsdsu59ISUC9JcVd3ev6f6R4pPlqhZTXejYZAOfoZc4AE9wYCky4MRhr0VTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894267; c=relaxed/simple;
	bh=XYOEb0zf8jXCKwsHsvzzu3YtIHkS2WRUQr2IbZW/Umc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jKUHQMeqTpSaKb6h4oDcxdXtCjn0nIposKP+Yqew9Iu+9/27+sIpZOhEBNZgw8p2ldKRM4ee6r24Hy41/zOAOkmqxuSej1QewqttaFqVGMgpwYofvKufbMwobljsLsmBnojaG4CiTmCzv9fy3nqU15T0ZlFO1Um03iu3vcLfu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=glLR6ZNN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so579978b3a.0
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 06:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765894263; x=1766499063; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0mQ2j55HYzsWAqKi9hLFK12hbv+niMldudmD970L/A=;
        b=glLR6ZNNKNPxWNJZ0eM9xaBPlVEOC7arBWWE7wbFCaENgqmtsdUPCx195ZqqwHJLeR
         N71czyFMSYG1YnT8QFl69CJJcB4Sj8vlMx3kIq1p2iZDrHv2yzGDHAhAAIfzi/sR/oOS
         GJ+qZL0iPYTUqayWhHWrpgoITDKuVP3tH4iJsBxc5EDZ9hrqbLtcURe9nkZPDZcOp3xT
         l9JowyYwdfq2PhC8FViDQ2xWP0eTANf8JL3YEXZt7tuW0moVGwUm+aB4ZFkPdY+NRr43
         jI17sj86MlllCMOIjnQXXl7vKGKMX+/Fo16R6VuIP4mdOoxLjWzPSfyXbHXL77YJ1ceE
         6MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894263; x=1766499063;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0mQ2j55HYzsWAqKi9hLFK12hbv+niMldudmD970L/A=;
        b=vo4Zktej95/CLYkPCRjPxfZhD0O0UC/+EBPCIPQYauSbP0olERMZhcpy8Yqv8t/Qv+
         9unYqOcRu+KTR+LEy4puZca5ABq1lo0H7DdlqS7v2D5upV06spxYy7uFQp5HaQ3KMHef
         HPglh07o9F3LG8ISvXIJ7795uV+rxi9b+q5h7fDwEKi7am1hD0AjC633Y08Jc2HTYpkV
         4EwispAZikyZ5wYq4bTwWnew7I9D8eixf8LXZIutLqL8hHeA/9v65DEJUtJYSiSrzhhq
         e2WQMEhLucMkwU9pP08c5zKhGLmhuUGwGq0cCfPIHPjt7pNLV6Eth90R2izjRwmOWK5r
         TEJg==
X-Forwarded-Encrypted: i=1; AJvYcCXzNqkfg4xAOrAk1SHqh8ytiMCy+q1EJxw8KggfLMcD+WvW3/qaNumPWXCrsYfgWcAQVxuOfg8bssw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMkDYfsHU3dXDR23g9kGkX1MkzBKelRC3njEX/FZ45e+WSdPa
	19jSPNT3AoI1wA6NrTHerBKukhzBh4kGOhy2XG4ceGjfvMTz4ZR0lIzT9O1m5w92zmo=
X-Gm-Gg: AY/fxX4eqdDnPKp0Jrwpsxh4wG3/SnNIX6aY3DwnYuQCVvmVUewsycp/obgzDl4oDai
	a1p1YsI4dVKyoy6DF0cTdCjLs6eTtcr2k478Awua7nyC7AC7btfF6tm+D6S2ow5RqpxsrgzYSrS
	B1t0feTVKFE0LSfA8gsb0HkT0xLLzLZPibsDUNqMuzSV7vFSKL/GwmdRnG5teRzhdFtDK4MrFWj
	HhxUkAJwxxqoiGMwd/4rMtpISxSQvGx4cpJTOksp79fZ5vfmuTB8DOfwAQLVBs05aiQmN/1BWpG
	a+u/5YjK9660Ih/kd0HJvYdr9NH9j59kN6hGB+bVlSe7I84H0sU+Pr689dDzz8xm+710IugzIzz
	dLKiPjtKHY3/BG380eA+RJXTcfYKt9fLfRk3DzwM5s8C7QfCKExahnK7fekypfssrO6adF1c/5z
	0tymmnzfNMwvhgk0+g4EWxzGRPd6+4+hs=
X-Google-Smtp-Source: AGHT+IFdznc94KTDkz6BoktpmFeuIds91RWVwGw8kUgSdrZJ6fQjtIW9/MuumcftUmESsfRMEb1Hmg==
X-Received: by 2002:a05:6a20:e210:b0:35f:10a7:df67 with SMTP id adf61e73a8af0-369ad9d21c0mr14335397637.17.1765894263443;
        Tue, 16 Dec 2025 06:11:03 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe200077sm12055352a91.3.2025.12.16.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:11:03 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 22:10:06 +0800
Subject: [PATCH] dmaengine: mmp_pdma: Fix race condition in
 mmp_pdma_residue()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-mmp-pdma-race-v1-1-976a224bb622@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAD1oQWkC/x3MTQqAIBBA4avErBvIof+rRAvTqWZhiUIE4t2Tl
 t/ivQSRg3CEuUoQ+JEo91Wg6grMqa+DUWwxUEOdItWjcx69dRqDNox2GMzYkpo2MlAaH3iX9/8
 ta84fhHNzfV8AAAA=
X-Change-ID: 20251216-mmp-pdma-race-d77c84219b2c
To: Vinod Koul <vkoul@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: Alex Elder <elder@riscstar.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Juan Li <lijuan@linux.spacemit.com>, 
 Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Add proper locking in mmp_pdma_residue() to prevent use-after-free when
accessing descriptor list and descriptor contents.

The race occurs when multiple threads call tx_status() while the tasklet
on another CPU is freeing completed descriptors:

CPU 0                              CPU 1
-----                              -----
mmp_pdma_tx_status()
mmp_pdma_residue()
  -> NO LOCK held
     list_for_each_entry(sw, ..)
                                   DMA interrupt
                                   dma_do_tasklet()
                                     -> spin_lock(&desc_lock)
                                        list_move(sw->node, ...)
                                        spin_unlock(&desc_lock)
  |                                     dma_pool_free(sw) <- FREED!
  -> access sw->desc <- UAF!

This issue can be reproduced when running dmatest on the same channel with
multiple threads (threads_per_chan > 1).

Fix by protecting the chain_running list iteration and descriptor access
with the chan->desc_lock spinlock.

Signed-off-by: Juan Li <lijuan@linux.spacemit.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index d07229a748868b8115892c63c54c16130d88e326..481b58c414e470cc08812d5a9fe7283cc48e5827 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -928,6 +928,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 {
 	struct mmp_pdma_desc_sw *sw;
 	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(chan->chan.device);
+	unsigned long flags;
 	u64 curr;
 	u32 residue = 0;
 	bool passed = false;
@@ -945,6 +946,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 	else
 		curr = pdev->ops->read_src_addr(chan->phy);
 
+	spin_lock_irqsave(&chan->desc_lock, flags);
+
 	list_for_each_entry(sw, &chan->chain_running, node) {
 		u64 start, end;
 		u32 len;
@@ -989,6 +992,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 			continue;
 
 		if (sw->async_tx.cookie == cookie) {
+			spin_unlock_irqrestore(&chan->desc_lock, flags);
 			return residue;
 		} else {
 			residue = 0;
@@ -996,6 +1000,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 		}
 	}
 
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
+
 	/* We should only get here in case of cyclic transactions */
 	return residue;
 }

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251216-mmp-pdma-race-d77c84219b2c

Best regards,
-- 
Guodong Xu <guodong@riscstar.com>


