Return-Path: <dmaengine+bounces-5107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C589EAAF4B9
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471C47AE57B
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B9721D596;
	Thu,  8 May 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN5tUL8c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AE195FE8;
	Thu,  8 May 2025 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689814; cv=none; b=jsHFSs6o2b4Op+Tfg1/SClvwjZHsVxq6eeeIhCMrDWF5V8oMdYhk+SeU0xXtYmNE3rqpz+gCa0Q9HAdhMTzGk4ttrfiwYIdw+rF8dLx44oVJq1EnAVYFf1R8QpG+6JGsSbl597L7n68y76cvkeQiaBTd60DQizQOtucR/HmGabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689814; c=relaxed/simple;
	bh=hGAbVqQFT69FqQTzOmATV5AJRMzSHoqIT19dRWp0pMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=No7bORQbKVoNFQRmfVS8XERRDKoBR4K4iKqTufeTwS2ynMxkwBIlPfFK3B1eKzC90Hg1gWmiMa4DvrfN1XIYbAYsK20fy2T++IYQZ81opWl6JFJ67s8wf9bsknowYAo+V6OBN1zWOjHyct9+La01aoA41+nbaA06xZZHYvpup6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN5tUL8c; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso923815b3a.0;
        Thu, 08 May 2025 00:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746689812; x=1747294612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fwr70jRROQnhTfVJ4M+ZZqp2+Z1EXWKMCwGS7IUNFQ=;
        b=eN5tUL8cw61K/XSDIC6pxdrSPAOQUjUBpquKJHe/HksTNiQyJusL+WtXSA4JCHvYWA
         ipKjYsDfnf08flMtPoixHV3817Xnx0PDiauiwgyA98fuEVI4IqoG5GuVqaFqM7RWMP7b
         mNBk8RkmpzoGgbTdqKvI8yjkcQzFEG2K4O+h/sHIe0/xAJctU7sag3/iYaduq3tMfeua
         8f1OVj45WXcqaItAeMBj6nLNdTGPnyD7eJQO0HJ2ZpyJBL/ODEmHKOUYaAfgXa+/Tm1g
         dn6FdfP8nXHsfrfI9XHie2xzjahOYadBFfh812jwmyWtKUnbABQfbqZIrOyQ5aRbT4Zq
         hgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746689812; x=1747294612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fwr70jRROQnhTfVJ4M+ZZqp2+Z1EXWKMCwGS7IUNFQ=;
        b=xIbHNAyAaw0/ac7meL1xjST1tRpPWdTYvTBn+dKldy+S6pZoweQ2rdri5Og9hpTHKl
         /cFreIVmaoJjJBnVO2RPAatWJ1rw7v+rUd3K4UIoeb1xjnLeUrrJPrJPaZ/M1t+PuIsm
         DYwyvTjt4oPd3NgiUGWv22YldSfX1joz1dwflNlUNpeOcL1AfIZAww2G8aDUyXHVl2lf
         pyiixw5lqSvib1A93gnn4fgzru2fNg0KaQD6egeWHG4h70aLakOIjgByIKVJZtRrnnGL
         oF9xeOtVc81pe/68jRD15RyFEnHlweDFN5cz93w/p5LLuSw97u6bfVHVDCoNsIBcAupr
         JhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0BCViFDxfwbadwsMFLkDimSJcB6IKOfRhQWeCbLB8uAdwIFnu6BUtSI699T3oismnLDEiAM+h@vger.kernel.org, AJvYcCUzB3SrwZXrVVHjHFj9hI3QV5guIzDHauFkfpDWAnuM1FTBRYH1suFZCnjMhayHatxVWhZSvPsl+A+wmZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcESY9YllYiU2rPnEUTys/WMReIDTax0Kg9uEnqE0btS6rSzcp
	fknddi2IPahcKa7lqfvG7mLYW3hhYHAUDNP6BhcH/+cZlopDe/tt
X-Gm-Gg: ASbGncvfpv+TGJ1X1kJdviCMlgN77pyGWtO8tb6PTo5ImpBCSWQSYskLpa+j/Moo1nE
	HIhJW/Ty6gA/lefLttT5eotWvfPlLBDSykaadQHEgfDPyDMvwsrkb7QQcZKmwcmoCBhTXm2+G3k
	pxeKPX+q3UehYdwCUpD4BSOulL1p51YYJm5oTG9CXu9iuqzDLcYHbe5Q3qSknYeqZdXMjlzmB69
	fZF6CXbeXMyCW9JifEWyHBR2hIaKqcWh5/30qr6Y6gEvMJiiWL4dOZ/CBSIqRB717JqkeOCqGk2
	EB7Bq/f4868JlEndyGNDIgTJlEsGV7CSP9xl3jxHXtD2n+6hdIf3ESdEyfH53FCwDTZxfA==
X-Google-Smtp-Source: AGHT+IHPnNoxLhV7GIw/VlymXwTFp+WFlPFIfHMoS/t+AGVcolUKDOh9qji1dI06No4oykb/YQlDeA==
X-Received: by 2002:a05:6a20:2d2b:b0:1f5:59e5:8ada with SMTP id adf61e73a8af0-2148b81f041mr10087427637.4.1746689812362;
        Thu, 08 May 2025 00:36:52 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905d16asm12570475b3a.127.2025.05.08.00.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 00:36:51 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()
Date: Thu,  8 May 2025 15:36:33 +0800
Message-Id: <20250508073634.3719-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a potential deadlock bug. Observe that in the mtk-cqdma.c
file, functions like mtk_cqdma_issue_pending() and
mtk_cqdma_free_active_desc() properly acquire the pc lock before the vc
lock when handling pc and vc fields. However, mtk_cqdma_tx_status()
violates this order by first acquiring the vc lock before invoking
mtk_cqdma_find_active_desc(), which subsequently takes the pc lock. This
reversed locking sequence (vc → pc) contradicts the established
pc → vc order and creates deadlock risks.

Fix the issue by moving the vc lock acquisition code from
mtk_cqdma_find_active_desc() to mtk_cqdma_tx_status(). Ensure the pc lock
is acquired before the vc lock in the calling function to maintain correct
locking hierarchy. Note that since mtk_cqdma_find_active_desc() is a
static function with only one caller (mtk_cqdma_tx_status()), this
modification safely eliminates the deadlock possibility without affecting
other components.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including deadlocks, data races and atomicity violations.

Fixes: b1f01e48df5a ("dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2:
Revised the fix approach and updated the description to address the
reduced protection scope of the vc lock in the V1 solution.
---
 drivers/dma/mediatek/mtk-cqdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index d5ddb4e30e71..e35271ac1eed 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -422,13 +422,10 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cvc->pc->lock, flags);
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
-			spin_unlock_irqrestore(&cvc->pc->lock, flags);
 			return vd;
 		}
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
 		if (vd->tx.cookie == cookie)
@@ -452,9 +449,11 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
+	spin_lock_irqsave(&cvc->pc->lock, flags);
 	spin_lock_irqsave(&cvc->vc.lock, flags);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
 	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);
-- 
2.34.1


