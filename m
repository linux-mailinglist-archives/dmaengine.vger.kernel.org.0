Return-Path: <dmaengine+bounces-5255-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7AAC2724
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0911B6220E
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625828382;
	Fri, 23 May 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZzB1YIv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFF130E58
	for <dmaengine@vger.kernel.org>; Fri, 23 May 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016420; cv=none; b=e8f0zZbs5HjRKn4Ys8tDexKnIaG6M6xMuuLiqI5UZ7lBgBXF3OUUFyX2lTzI1Wu0oojN915d6Lw9ilrLNLDjCLhej8IWbs5hH0TaYIEJMGVeQszQBr0RafDenQPL/yT99LqWfKG8zWIvl8tUbclBKz5UrZ8Bl4tEEbKCtruIG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016420; c=relaxed/simple;
	bh=WA5dqhze8NRn8+fhKp+DCFUWDEMVFNX6jxw+Hwyiv9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I55vuKdRuOsPGkH3ip4PUxhJt5+JtI5zF8STKAu++sp/VwHa8YnD7fvN0YoXmeqxSPij6ApsPhau6dKtvvdRoxElzxaDbAyTnyWCVJWtqVbNCGQTdPywFjNZUqCuxByMH5zmDi7ppwQe8lVfjaZJ6Ly9bpEIrnHc4LRa0Y1h3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZzB1YIv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe574976so68813425e9.1
        for <dmaengine@vger.kernel.org>; Fri, 23 May 2025 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748016418; x=1748621218; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVA1Wq02RwkJ8tKlxk+KwgWL1KTqqPjG9SMiOazJCzY=;
        b=yZzB1YIvtdng6TWNstVm/zzhkQlF30/ijeSBTsOSwyCFqFGCOVaihTq5ysFVckeqz1
         eCCp4Am1G6X92cHKXcpRCjf+wDlXzIP3X2KJrv6+Y0/Fvfj7AuMT+RROKVmpGTYr1Uoc
         EwLRgjERzNdw4SuxsU45LwHTvzcJ2QPXLTSXEQQwabmixLew23PxlgSNOTmKPEMefK12
         h56LlV+b5LkkZfePCgINh3hnlSunv5+JqDK2Dc/Fkj8BRl5SLJHHmQlsrXQ1Nex9AgBz
         5lZg/2U1BWygkcGAsuqLMYN9wx7LcGyO+Yu95lJ/KiZaVEOgJPBkw/VS/PICikh/Dybu
         MeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016418; x=1748621218;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVA1Wq02RwkJ8tKlxk+KwgWL1KTqqPjG9SMiOazJCzY=;
        b=tRQWm44pD7EMDyzzuJa7Ld/sTr0T6vpb2sH7qmBQIN3YH9flyjIOUqtdEVfCtVcr1n
         HFFtomYCozD4qFc8dp2wi95nHu56PxyodCN3+lGU/HCJCMxA2LC6NIi5PCayC1Rn50bm
         mtHsKs2Mpc8/ePKOi8VjUkJAYQjm27SeLT5vPvPnU1xaXoelj0YHKbzPy7u0yDZ7Fcwr
         1dbaXtI6JdTaw0w5akZ5NgdWD4qWia2ca2TQ3NLcfS2xQhVPUq/16x89ZdJBTCAvBAOI
         HVcCo5JvhIz21iIFk6oJ9IVLHUIu3lqcxkk5RXcTUDWY5YDwEduxRVT3xOCDN3P+hnOr
         K3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVd+fR0lXR48kzLjJXRvF4Z6SR+HMHt1hxly6Dd13RiaCadO8QSU9TRDweBYbJIgvcN/HvkrWH4DRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySsml84vJqY4UuuHy0ZYzHKj5e9UGrNB3Zeo+akvR3+cXkxXE7
	ytOzPBKoMoDUGYMnSaDs3mpwEtP9Kvkzq4GSzL3wp2nxXwjXTk4AW1FBA+dIbdRP9fk=
X-Gm-Gg: ASbGncs1/pMYv+zf2dV4x6k5HSSaO02crSKaZ7wdTpk5qA2ISKAaUJb59iMaNmCPXro
	cFWE93kd1SWcXztDHRUd0FK83maKmYzJUAtBqrfdkaZlnhNddrofiK+l3uaO5Vq7p2d/ZtlFQfH
	o23eIPbJqqj3beIzgz3bSWYwCwol+7xSItxQ6bS/lC+EMD0uExiJ5RvXdF/XlsZ04gLUZ6TaOij
	ZRWTqt7w01Zcw4PuThhHMo8A75vv9ETA4mRY1S6xbm6c1cJ3OsSeBovc+K2uSDAKZmvSnN4AnN3
	uePLagxMGocJKRpY0V0Y1bMa/sZ51M0X9GdgErWwzSf1fY1IU1vqJVslDxfsi3DKh5g=
X-Google-Smtp-Source: AGHT+IF56UQSCz5q5QoQKyBHSndYLKMFyKvT78EcNJOHgSCsSRrkaKawUqXQh0qLd3vhveIRpS1mOQ==
X-Received: by 2002:a05:6000:2011:b0:3a3:6f1a:b8f9 with SMTP id ffacd0b85a97d-3a36f1aba52mr19442998f8f.15.1748016417661;
        Fri, 23 May 2025 09:06:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca5a8cfsm27334537f8f.37.2025.05.23.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:06:57 -0700 (PDT)
Date: Fri, 23 May 2025 19:06:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: mediatek: Re-enable IRQs in mtk_cqdma_tx_status()
Message-ID: <aDCdHh-G2ShU6uid@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code calls spin_lock_irqsave() twice but obviously we can't store
two sets of flags in the same "flags" variable.  The result is that we
never re-enable IRQs in mtk_cqdma_tx_status().

Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/mediatek/mtk-cqdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 47c8adfdc155..9f0c41ca7770 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -449,9 +449,9 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 		return ret;
 
 	spin_lock_irqsave(&cvc->pc->lock, flags);
-	spin_lock_irqsave(&cvc->vc.lock, flags);
+	spin_lock(&cvc->vc.lock);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock(&cvc->vc.lock);
 	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
-- 
2.47.2


