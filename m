Return-Path: <dmaengine+bounces-6234-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9919EB38BE6
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6861C22C57
	for <lists+dmaengine@lfdr.de>; Wed, 27 Aug 2025 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEB828643A;
	Wed, 27 Aug 2025 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWK3COZs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F262F3C26;
	Wed, 27 Aug 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332012; cv=none; b=eh0JnRTtS34Qf8qy40LYUpl25TFsuL+IWoOTfM+q+8NZjlT9u09F+T5wb9LQCN93Ykn7VR8PxE9ww/GvhvC40rbHlQ8nyjyFQONn51SbNDIVH5LWFv8Z0K1PedpB45YmcwsxmuYwVPqAtihhOMmlVXINArstQf7+w6u/SrhGxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332012; c=relaxed/simple;
	bh=xMvW1NipylYcAHgDeiDS1bLvbSfKOIuwb8djTDKxS2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOYteVz0zeGAx1O/3x4Go6Qm8/sTCZ02JTV0Y9YMYEKzSJvmPDXCeQOhJrHDocXnhS3CvfTUEpdAqv5477JXQX7Ub14n5RfUFvmSHbhrkfR0kuEo7ytku2FEAgCehwvqnipLX7C8e0bgzD4LHIwEb1yrcEW+L08qLFWbXAcqXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWK3COZs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77057c4d88bso357712b3a.2;
        Wed, 27 Aug 2025 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756332010; x=1756936810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqTPmWovOAbxl0W7h/uTcQKLLpK3p7MDInPfhhT7a8M=;
        b=NWK3COZss/cDTcgqwMXV4SQIJpVyq70xw9I9C6ayPlvCDzbqxFIJDslY+X6oSFadTX
         2YvolGQMen/iFeyYj7iSN7PTsUK/a8toKscjjevEmBu1fzMOJ/jxM8Ku3FHn07OKPEKL
         7ASzTRnb+YlZzL62E27BlXsDS9G/tO9BG9OGrMM5qr34zJhQVL9LQBkedlnnViYvjJ9h
         GKOOw0mSlI83IX6COx9kjqDEFRyyQPrGSopnxGb2nb4ESlNcxhwWHBa4IX9TL4dycsOm
         zawUtcd5xtBIhL6MnEKc4fkounBff2Ukpqf0uuhNGKkK9f2yYCazH4GZvvx2IiNprc+G
         NDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332010; x=1756936810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqTPmWovOAbxl0W7h/uTcQKLLpK3p7MDInPfhhT7a8M=;
        b=fHXWCA3O5lCGNSrMT3AwW6zBxfgU5SELsGN0CcsOzNHaGoLxb0DmJ5cvDpF41eZJL+
         5UsUI9gxb2RF02+HsgxvfHlWsgoVra+pZeylUPUAVxmpMnQ7NOymctzIhZnVxLlUWE7O
         2bjGl8deG++CkAHUjCPG2b/kyF0XGE9GiwNICsXzSVK89iN0Sfu071cV6mcfrNvXnaiE
         ChovXb2sWSBVnTYaW/7ZmTnY7qfey5mITAQW/wc+gRudRf8kZfzsyi8ODosqiDNL4meW
         rm7W40RkojuStadOdQ1OhhRkPiHprN43tsizv0r7uc3Zn4a9Btk6mWTdcLuBnfUfM6W9
         zK8g==
X-Forwarded-Encrypted: i=1; AJvYcCXk6z1teeUYHKwpfdgqArRu1LkhAx/rtj7nZbpZdAhT4+7lam9ieFiL8/iMD63fVn4nZyQk49oKt1F/c/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3zXUsxC5/ggDFttZz2UJETFz8wooLnlnrkVgiQfmYzWHZeNug
	+H/pvqA5NLPx9KGbUfWla5fHVml5aZ3swnPr9aPAEPwntiaUEsKYkcSXhPNurg==
X-Gm-Gg: ASbGnctH9mnzfaaBuiRUaGbJXSO/cTwcT1+PTrw7s0Pafps6+XkgI0bZBu5ndtAX/gu
	VPFyF0AijdZj8XKcoyLe/85jKe5Yq+vKN3U1507VK/mGECqogGmpUoHf6mWPDbJO421EdIesMeO
	KuXDm0EC6xNISXzGG7Dv1OoUXvlRkxzKCryDh5ORDPknJJMSXHoBki7jf1JoNILq55m+9lo3LhS
	zAgSbMaONVjQ5a+SOGqn2MTCtPhj7UoSbHlDYoQ5qu/R7939i+nPrbP/7tkpkqzh1KXi+K+lptv
	+dIN3lRrnF6PJuEiLk2Vbc2QDKoLfbfWMckh3QMXVMoBKfTrxvDcn+PfEdZFUzfX8BRMyYpuX03
	2nBNTTzjWu57OtYpiPHV0Gp1MjU0KHF7Uxe2BGWKqR3Ydjfu1Qoj7x4Hg/cC5Ic/jqg==
X-Google-Smtp-Source: AGHT+IGsQQhZ8dCdCkdTAdovOy5g8N/ZObZRNN6qP9PgpHQ1/3MLGdIeMA1Cjn6OSRaayZRDCI/1cA==
X-Received: by 2002:a05:6a21:328c:b0:243:a5be:c4a8 with SMTP id adf61e73a8af0-243a5bec653mr3165832637.22.1756332010190;
        Wed, 27 Aug 2025 15:00:10 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7bf2dsm12389128a12.31.2025.08.27.15.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:00:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 3/3] dmaengine: mv_xor: use devm for request_irq
Date: Wed, 27 Aug 2025 15:00:05 -0700
Message-ID: <20250827220005.82899-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827220005.82899-1-rosenp@gmail.com>
References: <20250827220005.82899-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is only called in _probe. Removes the need to manually free_irq.

Same with irq_dispose_mapping.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index d15a1990534b..81799ac2f48b 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1025,8 +1025,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 		list_del(&chan->device_node);
 	}
 
-	free_irq(mv_chan->irq, mv_chan);
-
 	return 0;
 }
 
@@ -1112,8 +1110,9 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/* clear errors before enabling interrupts */
 	mv_chan_clear_err_status(mv_chan);
 
-	ret = request_irq(mv_chan->irq, mv_xor_interrupt_handler,
-			  0, dev_name(&pdev->dev), mv_chan);
+	ret = devm_request_irq(&pdev->dev, mv_chan->irq,
+			       mv_xor_interrupt_handler, 0,
+			       dev_name(&pdev->dev), mv_chan);
 	if (ret)
 		goto err_free_dma;
 
@@ -1138,14 +1137,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		ret = mv_chan_memcpy_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
 		if (ret)
-			goto err_free_irq;
+			goto err_free_dma;
 	}
 
 	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
 		ret = mv_chan_xor_self_test(mv_chan);
 		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
 		if (ret)
-			goto err_free_irq;
+			goto err_free_dma;
 	}
 
 	dev_info(&pdev->dev, "Marvell XOR (%s): ( %s%s%s)\n",
@@ -1156,12 +1155,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_dma;
 
 	return mv_chan;
 
-err_free_irq:
-	free_irq(mv_chan->irq, mv_chan);
 err_free_dma:
 	dma_free_wc(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
@@ -1400,7 +1397,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 						  cap_mask, irq);
 			if (IS_ERR(chan)) {
 				ret = PTR_ERR(chan);
-				irq_dispose_mapping(irq);
 				goto err_channel_add;
 			}
 
@@ -1435,11 +1431,8 @@ static int mv_xor_probe(struct platform_device *pdev)
 
 err_channel_add:
 	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++)
-		if (xordev->channels[i]) {
+		if (xordev->channels[i])
 			mv_xor_channel_remove(xordev->channels[i]);
-			if (pdev->dev.of_node)
-				irq_dispose_mapping(xordev->channels[i]->irq);
-		}
 
 	return ret;
 }
-- 
2.51.0


