Return-Path: <dmaengine+bounces-3147-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D678975B2A
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2718B213CD
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 19:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C77D1B9B57;
	Wed, 11 Sep 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoB8s6Hp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C21885A8
	for <dmaengine@vger.kernel.org>; Wed, 11 Sep 2024 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084623; cv=none; b=JQrfQn4/kNZazLrdNtTPwlmHlh8GaZTWQMVSzv5uf3AqDcXYjOiRiBuch40yVY4g2G6a5Y4s/LmjiPJ4/tYxVHgxkwv6bA8koYBg4S+AHw9rS2m+ql8RCwJg52tHJ0NQdgg9dT8klyKgu+VpVi5+sdJDj+heAKUAT3qg1x5q4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084623; c=relaxed/simple;
	bh=9Huow7Tj44jIpm1K66CWk6R90M02ofeuIPz/Y4iNXwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvdDmkkwE7j6rTYIrGaM5eAjeCuKfnTXGvv5ElKub04ZCT/xDtNWAiF5fd1rvUc+gM8YhEudjwGirnsAy2N/l07i8wwAyqv4/j7xM7aR73iDuTynWK8etYWj8N5v1Tq+i8gEBqCabljLqI5sPlRGMQ9YPW7DZXO2FOK2R7Ejq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoB8s6Hp; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so238881276.3
        for <dmaengine@vger.kernel.org>; Wed, 11 Sep 2024 12:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726084620; x=1726689420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7XsJ3DCARnjSIN2XBSTxPFxwScX/3QXEvSqqigmPW88=;
        b=JoB8s6Hp20k5sxQqyY+ubvdV43+25gKitUFG302/sJ71bg658o0nXpHZt5hjkqBUiJ
         WbJvY25tdmnct4wEVbq7FJi5YMHEYbvrckDA23lm0oWeiYACO8tr7EGEsN5WaHZqS5ny
         Tv8EVh55KfMSUPQ65mN2lPtabgtOGak5xDrdsgIwgkoYRQPm4kOeE8SZF3JmBazF99Fd
         +CcJdflU7BBr+zEqrkHZbedbolap+CMXZ5on7ayHG/IluitseogLSYIK4woj+iRlWVy5
         Uc++ZdUAir1W36hW/zRDt43T7pu4zdijJd/c4u4pRsmQupHNwwthHqJjbP1csY6Bhe/R
         AlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084620; x=1726689420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7XsJ3DCARnjSIN2XBSTxPFxwScX/3QXEvSqqigmPW88=;
        b=CcSusNkuE86jzbdQuAxn6SUC525+Mipt8n0fEnyx9s0TQDDebfX3chUszHc1ihE7mt
         1VUXGVYAc6k+yTH8NxcpuYicCFXW50S7HlHm8kizDEKVGfs4sMLX9rGvFfLCFr3vekML
         n8FvqNbM3ehowwsSYFtcPjbZ/SA58DRQXRrVGArnfkHrkS9/MXocvgoU1VfQvAIQ5Zl/
         4S2QMHGs0KZNoDd1ITPN6rQZ8em+lh6AYGBZ5iVSVWofbt9CkjpDkkmcEaELMB7X5cJC
         +P6vfqm9ppu5VLJxsYZBb7Xtj8diMohz3XHGWqNk9fFpWrQ/qzXnGWiMG1tkY0WjIwiF
         +jeA==
X-Gm-Message-State: AOJu0YyfUBHCl0xNLfwXzcTnlnDPIgbdwecLc2dDjFuNO5KIq9tTrl+2
	gpqPTx2I9b+5ADI3EJGRadAafasf/0wfsien3tOXd4nSOU6lXjF5
X-Google-Smtp-Source: AGHT+IHvi+WaLA5de21FasJuYj99QuggUPU377u/LkBvcK+NzEunGfMHrmV/8609YXzFAEdIklrT2Q==
X-Received: by 2002:a05:6902:e0a:b0:e1a:a580:e1dc with SMTP id 3f1490d57ef6-e1d9dc787d8mr556000276.57.1726084620436;
        Wed, 11 Sep 2024 12:57:00 -0700 (PDT)
Received: from kendra-linux.. ([64.234.79.138])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d7b9e3088sm808446276.13.2024.09.11.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:56:59 -0700 (PDT)
From: kendra.j.moore3443@gmail.com
To: gustavoars@kernel.org
Cc: dmaengine@vger.kernel.org,
	Kendra Moore <kendra.j.moore3443@gmail.com>
Subject: [PATCH] Fix typo in drivers/dma/qcom/bam_dma.c
Date: Wed, 11 Sep 2024 15:56:18 -0400
Message-ID: <20240911195618.94973-1-kendra.j.moore3443@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kendra Moore <kendra.j.moore3443@gmail.com>

This patch corrects two spelling errors in this file.

Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5e7d332731e0..2d7550b8e03e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -440,7 +440,7 @@ static void bam_reset(struct bam_device *bdev)
 	val |= BAM_EN;
 	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
 
-	/* set descriptor threshhold, start with 4 bytes */
+	/* set descriptor threshold, start with 4 bytes */
 	writel_relaxed(DEFAULT_CNT_THRSHLD,
 			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 
@@ -667,7 +667,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 	for_each_sg(sgl, sg, sg_len, i)
 		num_alloc += DIV_ROUND_UP(sg_dma_len(sg), BAM_FIFO_SIZE);
 
-	/* allocate enough room to accomodate the number of entries */
+	/* allocate enough room to accommodate the number of entries */
 	async_desc = kzalloc(struct_size(async_desc, desc, num_alloc),
 			     GFP_NOWAIT);
 
-- 
2.43.0


