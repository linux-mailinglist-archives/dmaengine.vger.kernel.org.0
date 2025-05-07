Return-Path: <dmaengine+bounces-5097-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6586AAD554
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 07:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770321BA588D
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 05:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906B1E25E3;
	Wed,  7 May 2025 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnE4mIzB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8340199237;
	Wed,  7 May 2025 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746596285; cv=none; b=vFQ+YgJqidFgRO4PtJ+rv3TI2EHnWFqod1dzL8ZtuYBOpNRK+MfhBzC74CBTW5askcO3s9AVRabJatKtm8aw4G0nAJR6orqauFHh0KXDsJlpSSXkskuBdli14SETIg/vIaoQMyjzrVwfixSjI5K1vpYItfs+IbLqVMErZubMdiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746596285; c=relaxed/simple;
	bh=wP8clbZR3wtgF2UvmFT+vgUtvGorLi06y2emXwfbX4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TYeyIL4Rx+b8qMlUEHEaWQxygRRMNLKnQ/WDxzHBoBhZfYftb/88j2sxPQ3tSpHpKvsYpPbQURlV6GdL9tUqN3FM5CnjJUuU1R248NacaUjndH7/qp6KHcydZEM3Ge41U3drAG9qJbeikGVQOwDfTf+u5YF4o+sZkq8aJA+1IpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnE4mIzB; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-af6a315b491so5897677a12.1;
        Tue, 06 May 2025 22:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746596283; x=1747201083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wnNtboDgAN3l0RxBXJ7GpvEaa0XgYy7m1/m7BgIkhc=;
        b=dnE4mIzB5vx8I+oD10gOE3Bx8uXqi6KftC+pj9XfWQRNck2cUshLe5QCpi21/qu58B
         bP5i44BW+n/sz76Gs+j0NjTr0UfTKBk8GHZYtsIlpHGS2AYZgcf1tqYDAk78DGlF6j0T
         +ojwSpLe2Crr7tBsuCCdZQsmIXN0A/2nkkfQCiFV8MP4pUgkzLvWpduKHqXMasdQgSid
         U3pTJtsYTKDmTmCo6CTPatGu0Xvubcb8TYsHJO78uwZu1Oa4ZJZ0aOXx+JTCWLz0vKBs
         wih8LtAcNK34beYGHoyzvTIGyLmGa8u9cyqiiU/a15eKPShbk1wwQThuhepkdGI5wPFZ
         gzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746596283; x=1747201083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wnNtboDgAN3l0RxBXJ7GpvEaa0XgYy7m1/m7BgIkhc=;
        b=qbl9pIJFV+1Q0NFnmCrWXfCZbTTDBocCUkmfsZ94iMJEvyaLIH4lhlEnth1W2GHsB/
         BWnpainhVRwcirmVJzuwd8eNoVkO4/VS2ry5NH073AcC2SqWQTIgTfHBsWTzokLrS43d
         8SWiqHtDHPEA/0JmXNGhJ1GES2ln2ZwxhGB0axYoDfxeG9WNIYdK3SRckgkqgOKDJXa5
         1u9wZ2KsdGcPJnamAgWvLN7s+vI6v5HFjt/pf9ELxo2MSrWYGyMlnr6wXJnV3spLNbCT
         yIgsgr2PERiwGeiL0pJvQLMSi+3SO3lCKKP/ZLXdmYarfWiZgCinWrh4kZsmfdpsi58w
         yrGw==
X-Forwarded-Encrypted: i=1; AJvYcCVC5DK6v0a+QRro1jS2uDN6l0LGwlL4xqAwgIHSD/G2Ht8ZnfNN/X1oSW0eblVEgknGs7Ri90ol@vger.kernel.org, AJvYcCWiql+oi03mVLxJnCALIGakkECKwSQENup+vfWT3H0JWBVtQKsnDOFzZ/xSfECWNUV6ULS0ypZn/gYdsYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzzu88cG7RY9yXJM4ffOz7mKa9LiZQIj6q2BwywPDOEE25BWr
	qSm0pCm/cMQBiDFu574fJq4jiLgMUCxZs8tlEFEchTGqayHUzA+v
X-Gm-Gg: ASbGnctx4u9vnLz+dItwb8N9tHl+tdDmhFldPqJMUjlwzhMDK3lvLhbCVDAGsW+Fv6Q
	B2AYJ8fz2UECKbDcZzV0u+AcxwlvdhH9/aJvxyhDULnUOgIBFrtW4/2WPVR615HmAvHf72nPyP8
	rRCCnz9A40R4CpLyl8YLOWbGLO+G6WTQQ4phncueWsPqm/w4rWQKdnT4IiCKdixJ4cHSNi7h7BA
	lAmYfivewajPen0Vqawu76NWTdqYoRbe9glLKCdNI5N2rUGqvTSu2qYn3i5DncdYdB6PPsur4D5
	FPLEuar2rJsDhZuddkERx6wIrTziAGEBGG56Rw97ioQCModJoA54w1x57Js=
X-Google-Smtp-Source: AGHT+IHym5Q+YAPg3jYRVQT1AbcSKrkylIIVQ0nly23ygpo9eo5af0TuH69Syh4K6QEhZQ2OLe4vKA==
X-Received: by 2002:a05:6a21:3385:b0:1f5:9175:2596 with SMTP id adf61e73a8af0-2148b81ec6amr3152869637.13.1746596282841;
        Tue, 06 May 2025 22:38:02 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b52759sm8714315a12.19.2025.05.06.22.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 22:38:02 -0700 (PDT)
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
Subject: [PATCH] dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()
Date: Wed,  7 May 2025 13:37:36 +0800
Message-Id: <20250507053736.47220-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes a potential deadlock bug. We observed that in the
mtk-cqdma.c file, most functions like mtk_cqdma_issue_pending() and
mtk_cqdma_free_active_desc() follow the correct locking sequence by
acquiring the pc lock first before taking the vc lock when handling the vc
and pc fields. However, in mtk_cqdma_tx_status(), the function incorrectly
acquires the vc lock first before calling mtk_cqdma_find_active_desc(),
which subsequently acquires the pc lock. This reversed lock acquisition
order (vc → pc) violates the established sequence (pc → vc) and could
potentially trigger deadlock scenarios.

To resolve this issue, we have moved the vc lock acquisition code from
mtk_cqdma_tx_status() into the mtk_cqdma_find_active_desc() function.
This adjustment ensures proper lock ordering while maintaining
functionality. Since mtk_cqdma_find_active_desc() is a static function
with only one call site in mtk_cqdma_tx_status(), this fix effectively
addresses the deadlock risk without introducing unintended side effects
to other components.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations.

Fixes: b1f01e48df5a ("dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/dma/mediatek/mtk-cqdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index d5ddb4e30e71..656354bccb44 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -423,11 +423,14 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 	unsigned long flags;
 
 	spin_lock_irqsave(&cvc->pc->lock, flags);
+	spin_lock_irqsave(&cvc->vc.lock, flags);
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
+			spin_unlock_irqrestore(&cvc->vc.lock, flags);
 			spin_unlock_irqrestore(&cvc->pc->lock, flags);
 			return vd;
 		}
+	spin_unlock_irqrestore(&cvc->vc.lock, flags);
 	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
@@ -452,9 +455,7 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-	spin_lock_irqsave(&cvc->vc.lock, flags);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);
-- 
2.34.1


