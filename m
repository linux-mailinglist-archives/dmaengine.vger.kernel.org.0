Return-Path: <dmaengine+bounces-2321-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C709013AE
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 23:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D6B5B21689
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 21:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784322E62F;
	Sat,  8 Jun 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2TXtVV6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EB1B947;
	Sat,  8 Jun 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717882368; cv=none; b=hmxn21tydkRxISqwg+eBRGnqoF7J/n4F3HLzD6ggxbpwG4GDB+AYlm1xl283pBSOppi2YODuVtcTMg9I/UgKshgcyt9d9M/bwOHCo1AKo2Gv660qyMXqcgfXgMRqKutbpo0pJIqtA8cKA28bbv8guAOr9rss4nVZzGUJXQLVvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717882368; c=relaxed/simple;
	bh=+Rs8wYwBoiG3K7IcsS1TPmK0AG2mOW1LQ3u5KD71wcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulAl5cv1w5gEBITyicpuL1tlcU7KjIzrUwGI35FPeBz6/RNikWDGEtvP0s11NRZa1ZU5gLeWS6pzb3lTAxcsT2fNwcyOFrltmGem4hs74h36ssoqF7HtRFV0kO50xoyjYH26GFLw1i5NKDW7POdNTA/T2bvHK8CvovOe9yii1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2TXtVV6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso2563133f8f.0;
        Sat, 08 Jun 2024 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717882365; x=1718487165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu++zvi3hy03WnBvFMzNx4Almv3OZW4GRR+MRySyAmA=;
        b=h2TXtVV6mxPS/scq3Sod+ZfH35T+r1L4hCsj7wgE+3ThiOrNYHr0qtF+93939bO5FF
         XOPXDJSRQ2QrvAhPrCacPrpbXrVjY+FfxXY1u/R3u2GroRqbjuM8zWtY/k/Ut9zEA8Cm
         /6v0hNCu2d+3IuS9R7GlDNVxy/erauI6RIGXhoA1Q9g3O+Pdj2v7jkZWGvYzAkgtYXY8
         R5gr+dfi28M4gnZ50uDQLT7tZ53aqNnL0kFMLviC3NwPzCp3s722cc6iRQZ1ZPykhloz
         WfsvZ1UybkGToiIeZRYrj7edN/7WkM0obK83XjP3et35kA+TCDC/i7Xb34DXPuYMMEgp
         KDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717882365; x=1718487165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu++zvi3hy03WnBvFMzNx4Almv3OZW4GRR+MRySyAmA=;
        b=uMe9B4zerh56RPSyti1XI2uLrbSTGJCRGELtNeCoRQntARu5H7uTNeACVbpin5foYa
         5eDP2cDgPo8+x3Gx4cXOIvDGjGfOuSKG2+0UPd9e5lCxH/PKnUQ9GrtGd6td7hZgXG6B
         L8eikj6TqrLME9Dsa+cI0jiarPKk5/yBCzJS7rxbgGdI75dO2mMx86F2cj8OmYKv+rnY
         XeODFunybPHtHYU2crJwAqsCQaq+pCO3icUpVUNb50+MmR8vmQJgXRUX2u94kLu2H2Ek
         wFk7P30YNoAuVKdYEVoNDqyK1ls72frjuJ35Oh4Z0o1LphMbZEXrG7KV0Mx3kRszwnQB
         wB/A==
X-Forwarded-Encrypted: i=1; AJvYcCXYcmTqYm9GjAQ9i0mK0Gtc2C4gcSJ1g5mKqd6a9QwuP+rl6OtsdEV5HeuuH8qleq1ZCGIuSwv/L0zQiCpm2QC8wIE456oQnQQL
X-Gm-Message-State: AOJu0Yy5egtFXYVuIVcw/u4QBQXPMirT87fOtOF7mocoYaZhERQSyXRJ
	0AHzZU369jx0hpyOETCzeu1i6stpd/HS84qJn65kgcFLhuQOwgYI
X-Google-Smtp-Source: AGHT+IHqfdWSpcopHsiLkd0Mmd6Q+telmoC4X1GiQmjw2Z73x32UZNrXesKuSxOK4cMxRs2gtsPAXA==
X-Received: by 2002:a5d:42c8:0:b0:35f:1f19:594d with SMTP id ffacd0b85a97d-35f1f1959aamr220070f8f.33.1717882365133;
        Sat, 08 Jun 2024 14:32:45 -0700 (PDT)
Received: from localhost.localdomain (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f116540d5sm2793247f8f.15.2024.06.08.14.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 14:32:44 -0700 (PDT)
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Eric Schwarz <eas@sw-optimization.com>,
	Olivier Dautricourt <olivierdautricourt@gmail.com>
Subject: [PATCH v2 3/3] dmaengine: altera-msgdma: properly free descriptor in msgdma_free_descriptor
Date: Sat,  8 Jun 2024 23:31:48 +0200
Message-ID: <20240608213216.25087-3-olivierdautricourt@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240608213216.25087-1-olivierdautricourt@gmail.com>
References: <20240608213216.25087-1-olivierdautricourt@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove list_del call in msgdma_chan_desc_cleanup, this should be the role
of msgdma_free_descriptor. In consequence replace list_add_tail with
list_move_tail in msgdma_free_descriptor.

This fixes the path:
   msgdma_free_chan_resources -> msgdma_free_descriptors ->
   msgdma_free_desc_list -> msgdma_free_descriptor

which does not correctly free the descriptors as first nodes were not
removed from the list.

Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
Tested-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
---
 drivers/dma/altera-msgdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index f32453c97dac..0968176f323d 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -233,7 +233,7 @@ static void msgdma_free_descriptor(struct msgdma_device *mdev,
 	struct msgdma_sw_desc *child, *next;
 
 	mdev->desc_free_cnt++;
-	list_add_tail(&desc->node, &mdev->free_list);
+	list_move_tail(&desc->node, &mdev->free_list);
 	list_for_each_entry_safe(child, next, &desc->tx_list, node) {
 		mdev->desc_free_cnt++;
 		list_move_tail(&child->node, &mdev->free_list);
@@ -590,8 +590,6 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
 		struct dmaengine_desc_callback cb;
 
-		list_del(&desc->node);
-
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		if (dmaengine_desc_callback_valid(&cb)) {
 			spin_unlock_irqrestore(&mdev->lock, irqflags);
-- 
2.45.0


