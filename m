Return-Path: <dmaengine+bounces-5911-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31FDB16494
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C6916C942
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A72DC357;
	Wed, 30 Jul 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep5n4pl3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8F1C7013;
	Wed, 30 Jul 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892871; cv=none; b=cEjxy9Dx4ceiSn/8QbBmRkzu5apPWdSSoGJf5aQyjJITnhETs0Tz2WD6J/YjpYjnccfmvoTEfhgKE711BeZ0FpolsWC9/lNKkmsmTaObHThiAttJvxQNU1OnSG1TBs5W3ej9wqhCx0McTL5UiebZDBKOHkx+Uup2Y9GGFVtcHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892871; c=relaxed/simple;
	bh=IBd88+g75enem8ZFwiFE6FmfjZAFd6OhLTrZnh/J7ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nsTh9KTc4u7ccZTP+nshNFgHtPiiTObnXyj1fXztya+p9ceWIlroHMODzfSj/9wr58ThhvbNsAhPY56bA9YLJuim3oVeMUe0s0Vfgdz0gdmUuJ6xzmNFscvn9DE+/6Pi+hH63h24KAMfeEnALZ2Qc9LaedH5irFuqATZBzcyX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep5n4pl3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45892deb1dcso5704065e9.1;
        Wed, 30 Jul 2025 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753892868; x=1754497668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BqqfmK2qoQp6Ai7p0EgtaM5Od+R/trV0qF5iEdPoHE=;
        b=ep5n4pl3Tm3pkjK2gf0ISUv1oB+pTLRKK3QIP8Gg7xrjsrEyf3IMyRmaU66DfxOlOM
         07vO/UKkSlZMQkMp4FB5impVCh6aBGDmVAWaAtNNRURWhssyAnkO3FdIwa0vnwu7Us5s
         S4hc7GYjnIOiw6Bj6oHv5HZU3FSI2N0NrysQFa8Q86ZhyUdRITFlhIUNKamTeGJjEFaw
         3sbWdxMhle9h4KPTw9Mkojiz7dmAp5myBrIi2lZ1mzcyNjJ2jZzYOOCl/icmsffj4qvh
         zxgkdYlS89OSPIYcJ7uTz3SFizAVDA4UXrVB+sds7qu8zTdc/9bCI4ax+9Jq5raDCd2v
         /OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892868; x=1754497668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BqqfmK2qoQp6Ai7p0EgtaM5Od+R/trV0qF5iEdPoHE=;
        b=TQgpQnZk+Kh0f1k7xaCzCrBlaKvhM19DjJmPsXQKTDjeZbD5fAcdcu2mlZa3/z2W28
         jCdzCWKM64LDpictZaLuCON2qEepJrcmKbJ1vIJKp1zqsa/SW3kCdZyitv4/W340tphW
         /4wGHEAMvJnQwvlPMdEqeymHMi3kjiP6NhdpKCU6wxD6TR5VlHcvtFyjFtKIf0i/1wvb
         v7G6Cukac6FM2Vo7DhlBnhpJrb+9QfTD4veyhR7LJkd/kBnj75VhWYZ6rZ6QPKvnsnWQ
         G1JvK9kbu82PVFcivtioCn+Uyv5FgsYy+PRWqRDOd6si+QprxgLHB4uyzQ+D1vTJOTRq
         vGng==
X-Forwarded-Encrypted: i=1; AJvYcCVqWN7vQryBi35mo2FJdg2QYJ6C8dShoDO1/ChybBcSNT4i7JBzBVBt441emAsS0lFusHeGGJzVvdk=@vger.kernel.org, AJvYcCXzkgSHlWpRmoePtplQMPEl7xXo1PPJjYt/jG9MiC/j0XUwxssgXhWaoY32dQtTaUl+b0nG6G8ajZqKknnq@vger.kernel.org
X-Gm-Message-State: AOJu0YzKB07QIJcpv5kiimMUYxpi2M6gaTl7vbkJPbGSpWGae9m6WkV5
	uh+vBXzcSPDDU8+wqNiWHJDTkOX2mIzzBi9NxYbM7kMq30xpAmzLbdQW
X-Gm-Gg: ASbGncsBs1JqGqk8MmIDlhC7maZzthRM5hIfDuHq8bGxUMIQRkX/XXHKKyZBO+1Q6ba
	KedGS+90nzI+qI7tvMJ/Yp8YzHpifO94jyb778nIpUvX23rakQ5oN2J11xMQb7zJRiTJBmFsSCp
	0HVKX0FAWNzqR/eEpy7a84L+hVSEnJxL8wK+Ca1L/dJ3MziXzw8pwdhO3bxy2EqL7uzUlbq3tZA
	rk0Pc+tNPBNFzGEvddHy/+bkF1NrWU/1bWvjADV5pUeiQA7B6DXcw7Q6N23COvxkHMcnFAY4Yv4
	/k7TZg0eOh/VQ2CF5NDqrxpvyFc3zZqsQrsrDA2USJWWW4kTyqKGjJ+8MNEpXpD6yojH3dsoR8K
	9WXjvjeCloSJS+iNTF/6DYGxTFbYsbO0=
X-Google-Smtp-Source: AGHT+IFNTEfL8MXUiyul7/qYy2OufuFwuC1wS29v9JYelkS5QR/IryALVLKRVISTNCURBmibZxI9Yg==
X-Received: by 2002:a05:600c:3488:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-4589c3650eamr18294605e9.18.1753892867826;
        Wed, 30 Jul 2025 09:27:47 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589536bc42sm33362385e9.7.2025.07.30.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:27:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: ppc4xx: Remove space before newline
Date: Wed, 30 Jul 2025 17:27:12 +0100
Message-ID: <20250730162712.2086439-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a extraneous space before a newline in pr_err and dev_dbg
messages. Remove the spaces.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/ppc4xx/adma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 9d2a5a967a99..61500ad7c850 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -874,7 +874,7 @@ static int ppc440spe_dma2_pq_slot_count(dma_addr_t *srcs,
 		pr_err("%s: src_cnt=%d, state=%d, addr_count=%d, order=%lld\n",
 			__func__, src_cnt, state, addr_count, order);
 		for (i = 0; i < src_cnt; i++)
-			pr_err("\t[%d] 0x%llx \n", i, srcs[i]);
+			pr_err("\t[%d] 0x%llx\n", i, srcs[i]);
 		BUG();
 	}
 
@@ -3636,7 +3636,7 @@ static void ppc440spe_adma_issue_pending(struct dma_chan *chan)
 
 	ppc440spe_chan = to_ppc440spe_adma_chan(chan);
 	dev_dbg(ppc440spe_chan->device->common.dev,
-		"ppc440spe adma%d: %s %d \n", ppc440spe_chan->device->id,
+		"ppc440spe adma%d: %s %d\n", ppc440spe_chan->device->id,
 		__func__, ppc440spe_chan->pending);
 
 	if (ppc440spe_chan->pending) {
-- 
2.50.0


