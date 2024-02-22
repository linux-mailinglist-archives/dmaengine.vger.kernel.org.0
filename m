Return-Path: <dmaengine+bounces-1077-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88AE85FE18
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6B11C21591
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546715098C;
	Thu, 22 Feb 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo2SpXVn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C712B83;
	Thu, 22 Feb 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619492; cv=none; b=Xlv9vyUzU3EjoWokkgeZFs1Xjzk/Jf0wOXV6Br1gF5ItZtpRZMkNn9sVvioDF3zi9kJN01/iSS6UvkdgxLUs2RWLmr4Zs327XUJHLOwuDp9pYiZELvkR6eQvjwKqGhjwxWDJbpIL+6Al6O101LGLhnN8nJtMEJL1oNPaNpCpeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619492; c=relaxed/simple;
	bh=WViSle729jln/cusrNIYkwP4EgysdDTOqTUkrf9PF+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD+EDx84jbReGhTulyWvtx/p+HAHqCEkQycvtyr6H+zPayVogzPVUc8HGMhFs286X8pPUgbEih9irYhkZIu/Vo9lLpILO70TEGQyj0j7tZ/W/KY9Oi+y+L3CJMKUBxOhWAnlTpbbi0ACq9FN9cjJjRdrtW4uU6FD4O23hZtSaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo2SpXVn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso8308243a12.1;
        Thu, 22 Feb 2024 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619489; x=1709224289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK3fBlwN45tHe52ZTIC1s6iK0xojr761Y/r57RkeYMQ=;
        b=bo2SpXVne4JNgmBCrKKe/1ivefWUS6wB4FH2X32KtYdiV61oVazwkKLu0d6yiL33fI
         Ot6zPdae0shNoPHeUBl4AFIS4qUmJxCrC6cQ+/pBlYb7erRHFewA7thOJkOuqScwwWT7
         YXulgGqxrMc0bcqeSRFdIZZSx6ZWL2LgV7VlYb5JFKbWevfGjDJIn/+QEsZPQ7+hvyz7
         Uz7d6YlOrvCqAlbJwJa4pFtkHtOqaoX5Bkw1qctOdghOWu43MPAELkwW0cJxLVWJrm7h
         q/UQ8wXLsUggfgh3IsFie6PvYAkhrjhttcci5aI3TofAAqsXztQF1Csd/z+m/yhaUbnx
         vHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619489; x=1709224289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK3fBlwN45tHe52ZTIC1s6iK0xojr761Y/r57RkeYMQ=;
        b=A6TV2suHxBDgeIguA6KocapyeAj9G2kxrOucE7lZ8hpt92nejcQUA8ORW90tdyYjqH
         8Ht0dTUNx8KdaYpjBTOXaa/0y6uXLwQNOdqwXmpeaXwzQ2bwQM35/y6ABfM+Kq1KyefP
         istUbzVXtuODl059uzHUSEcq8k5/ODVHgNPhZWMwjzYyfGw79aIyM9LRh1Q3GQ5E5skC
         EEH586l2koiVbl292uKZPXDwrs2Hyi3DS2gsc7sfH5etqFci1JclbP2B877C4VE494ln
         CqTAY5G0vAFIA+gj38RUk8pfS+Cas+a+Z2bgII9IqZe0FzsnRpMU8/FXeKDBCPyo2fpA
         vhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiViMIR0CNWrGImE01rvKoYZuf6IoOE979kUnhMWnEkjkgqzOebUTcSXDuF0IsBSWHj+SRe7X5Y8SpQPNZ9YsN6mXbQziXIiSxE1z350tTyIWbyhGCtVaDT0IpbXAlbXCx
X-Gm-Message-State: AOJu0YyzsYhBvtmg88OiTkLNyfwFpAPrbidAU0xxLEtlXytEJvpMwtRQ
	uIUm71XRkkfA5d8yW2CsXVB8kwZfie+sAZ5UM7KbPmvmf5eh/RO1
X-Google-Smtp-Source: AGHT+IHcg3zJ+UhLPFmPgEm6hodj6qcE/lv61gzuBdXQ47Cwap85PNZwzlMU2pDGXekQAUqokeo3Jw==
X-Received: by 2002:a50:fb9a:0:b0:564:39b6:fe9 with SMTP id e26-20020a50fb9a000000b0056439b60fe9mr10575186edq.12.1708619488826;
        Thu, 22 Feb 2024 08:31:28 -0800 (PST)
Received: from desktop.gigaio.com ([46.151.20.23])
        by smtp.gmail.com with ESMTPSA id p27-20020a056402501b00b00562d908daf4sm5787035eda.84.2024.02.22.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:31:28 -0800 (PST)
From: Tadeusz Struk <tstruk@gmail.com>
X-Google-Original-From: Tadeusz Struk <tstruk@gigaio.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Eric Pilmore <epilmore@gigaio.com>,
	dmaengine@vger.kernel.org,
	Tadeusz Struk <tstruk@gigaio.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] dmaengine: ptdma: use consistent DMA masks
Date: Thu, 22 Feb 2024 17:30:53 +0100
Message-ID: <20240222163053.13842-1-tstruk@gigaio.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <ZddShyFNaozKwB66@matsya>
References: <ZddShyFNaozKwB66@matsya>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tadeusz Struk <tstruk@gigaio.com>

The PTDMA driver sets DMA masks in two different places for the same
device inconsistently. First call is in pt_pci_probe(), where it uses
48bit mask. The second call is in pt_dmaengine_register(), where it
uses a 64bit mask. Using 64bit dma mask causes IO_PAGE_FAULT errors
on DMA transfers between main memory and other devices.
Without the extra call it works fine. Additionally the second call
doesn't check the return value so it can silently fail.
Remove the superfluous dma_set_mask() call and only use 48bit mask.

Cc: stable@vger.kernel.org
Fixes: b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA resource")
Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index 1aa65e5de0f3..f79240734807 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -385,8 +385,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 	chan->vc.desc_free = pt_do_cleanup;
 	vchan_init(&chan->vc, dma_dev);
 
-	dma_set_mask_and_coherent(pt->dev, DMA_BIT_MASK(64));
-
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
 		goto err_reg;
-- 
2.43.2

