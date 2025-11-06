Return-Path: <dmaengine+bounces-7068-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A5C38DC3
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 03:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5418C8090
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F7B248881;
	Thu,  6 Nov 2025 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwakF7d3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5812459D7
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395868; cv=none; b=O3s4qXebtaXDc4DsJ7IZc+fr3GAmw1w9L1EVqq9OQhpAdXbkNEnJVv7BP/nW10mh+ujHrM2VM+uMTsV5fxNnztkz7ZkAjq4Sg7FKPRplsrxjjuzwZTYfokuJdeafYeteUvhy/G2BxxQaUCRB/en8u0MhKUWWf8X25fyGBfjPOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395868; c=relaxed/simple;
	bh=GWioAa/HgKfztWuwH96e7QbbpPMk5PfvPdRvxZmAORI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foh6Tcjj7KwRSZEPyPx12QJU+bGAnNV9d/GSpYtvajftQ2FbUlmvNrRYVI7CvImQWRwKS5wFjKe7Uky7E0A82a++sZmHoKKf75Cs6KVWjhi/YyHjLHG63ACjC/fbYj4l4nPbjj2rTfNt5Gup2usTXr8FtlYdmIaoUmax7uRKGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwakF7d3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2953b321f99so5482145ad.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 18:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395865; x=1763000665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMEWMetexcI+STkq+hwuSVo2b3x2WsR206J4SHSMQSs=;
        b=bwakF7d3zZVzwO6AEzbOsdGdnS9CaPkOowGUVJ0hQYeKIGKY3xkY0DeIA9zjR1tko2
         +Yaw6z+6WDTgQXJCC38mCgwvSXGFkMx9pydKBOkIyvC67p2CBjZSK9Rocwzk34c2CEL8
         XLRSR0FGbWVKrtZs+WWY/CS45JiQAkxFC6VoccrwoEZQQEUWN4jBZetJza3sP359lNMz
         vaLZIoVOaIij3tlyMAF29KSezhKeeyvnmia8pw7PUDXdWtH4tXrU+Zyn8PIBij794HU4
         0wxQhWF598olfRC3IA1AyGDr8u33x+bMAOJLfsgJSARVGJ+ShEkPRvtkMaqsPi7Vg89K
         N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395865; x=1763000665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMEWMetexcI+STkq+hwuSVo2b3x2WsR206J4SHSMQSs=;
        b=eT5kCIx2uyOWPYswxPTIw7K8H/FrlPnJrRm53mnFbUDispL5SFLpn7I8cwi0Wz4lE5
         6c9WAdhb6oIqcDAi9TT9HUl7LCWzctBy50yMXFu+jdhUMS3ogeD+oucqnb15vtWn+gX7
         WMENGmUmJKcWWYdMVPg9O4MaVCwbLrf2HkiGqOmoT9tRchgpA2lZ/ZtTjjS6UDUHN4vi
         r7mY9HjuxXQrFoLN+O+CMN6J9Me3juEiJ46sCabYNmWgw+REeS5pmLyUCz7k5VhgkQld
         1m1DZcY/UT9nw2ka6j4gWZM4VWcBkGMpdRnWSVJoQJCFuwr6Oo54BTew+z242Zsyt1XP
         vpow==
X-Gm-Message-State: AOJu0YwmdXREboBC3UyACFXwW7EBLhrTo672+KXrrCCAEnFRj/ZEhBxb
	HpXQpBYHUsrw7KAosV5Jgq6in7X5NB6QVE9UoVMtfG03vL/+8H79RdmNpGZIjg==
X-Gm-Gg: ASbGncv7caaNG/IhFHHRaHEqkRsNTvKZalg7ZB5izUKUVzP2L/iWop3RwAlKzcdC1F9
	/ksUKpqL1zCC+ECuW+G65Ze2Mv6gQc8wmCSDkPiBSAwtUeP997OYKiAEUgSWPbtTFNyDCxQwT+l
	Imo1KUHdbCkvN7Irid2uqEp+ElvJYnU9mZlIiS2F68yoQwrY74DbEq/PW6g0Qpsoh0K9FydyriG
	3L7Mgx4uplTDfhiWlo/6BMVIRhAP6C/wHoDlLJ3ZnHHz0RnLslPgp54cwhxSMAIesghvyxEhpjf
	STRcYqaIQx6XkIETsmEuufdKqWY6IED0Zxa7SRoMQ74Yu2S3QHYmYR9K0uV2IEdTIGiLgysf20j
	OuvfHB2Dp8DjeRNVqROfsbh+M9pH9fgp4oUZlDQenTQKnhJI=
X-Google-Smtp-Source: AGHT+IENNM4E7OUgvdk01D8ULNDZQyF8NWNscTrYBkmBG5cFCwDSrn2aDfQaeI7APGPNpdLQZG7HDw==
X-Received: by 2002:a17:903:1447:b0:295:4d97:8503 with SMTP id d9443c01a7336-2962ada67bcmr70131855ad.30.1762395864661;
        Wed, 05 Nov 2025 18:24:24 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm9399935ad.44.2025.11.05.18.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:24:24 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP AT91 DMA DRIVERS)
Subject: [PATCH dmaengine 1/2] dmaengine: at_hdmac: fix formats under 64-bit
Date: Wed,  5 Nov 2025 18:24:04 -0800
Message-ID: <20251106022405.85604-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106022405.85604-1-rosenp@gmail.com>
References: <20251106022405.85604-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

size_t formats under 32-bit evaluate to the same thing and GCC does not
warn against it. Not the case with 64-bit.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/at_hdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 2d147712cbc6..7d226453961f 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -887,7 +887,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 	first = xt->sgl;
 
 	dev_info(chan2dev(chan),
-		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
+		 "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start, xt->numf,
 		xt->frame_size, flags);
 
@@ -1174,7 +1174,7 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 	int			i;
 	int			ret;
 
-	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
+	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%x f0x%lx\n", __func__,
 		 value, sg_len, flags);
 
 	if (unlikely(!sgl || !sg_len)) {
@@ -1503,7 +1503,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	unsigned int		periods = buf_len / period_len;
 	unsigned int		i;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%d/%d)\n",
+	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%zu/%zu)\n",
 			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
 			&buf_addr,
 			periods, buf_len, period_len);
-- 
2.51.2


