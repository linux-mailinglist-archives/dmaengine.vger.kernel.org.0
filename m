Return-Path: <dmaengine+bounces-5292-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C9ACA0A1
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 00:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AD016CECF
	for <lists+dmaengine@lfdr.de>; Sun,  1 Jun 2025 22:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE313AD05;
	Sun,  1 Jun 2025 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEKq18TA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B25674E;
	Sun,  1 Jun 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817776; cv=none; b=GJOlLd4A78TiE5+rbTNMnpXtx3iH5hfDXhsfEC4txvwabLi5mdli1OrovMNj5TTRqZo4Im0/+/pvw2KEc3yFRCDhhHk3oWQT8q84Fm1M6JyCkUfIpqBxwZQAwoe0dV9difsdnG80iEs7cO4fKlKNEb4iTfvM65H5a96+IBwseVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817776; c=relaxed/simple;
	bh=OwtEGgMBw3KRAYa6XNqI7gOVNBLirULiL2OhVC2WxcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kc3HyUaAB2DHHHp7TI12SJTwldysE7UBAvQ8thwNJMR0DA2MaVwSDrBz7ryxot1MWmpYp12ADn5qJDOUpEHB/QOi3us3KD2IppW2QUq0DbSUFdfhha2mvyk9tcgqchKzpTiJI67MO7juLMuWj1UsY7RaAogG2xt94iOYj0Dksg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEKq18TA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450ce671a08so23471445e9.3;
        Sun, 01 Jun 2025 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748817773; x=1749422573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLnY+e4DmR9UwbO0AVGv5r5TxRv2i22KZH8nci/gU7o=;
        b=aEKq18TAzyPub6qfwym43G5QttPEPIeytj8p+mH81pxOvJKRzPOWCEZHW/i6wQSBS4
         k7u1KKWT9LuXWGL9Jnd3EYNkUP60avBtJILFNEOhWaLCeboq5vo7IdVspTQbhd8w1iT6
         jhnsZQBTM0WjuIONw0U66oKgWvT4ev3omWC+Fnv7ACu5pSodqHpdoE8Q9g1KSy7Ucdey
         kTrSRNQH/F3iuGGt+uN1wF35nTcB457JtgD1izaxikNB5MUTJ+vlhVJr3IHADC3K7xkS
         bxvuLPCG2JbrOOhf/A9N79sHv9AbdnzvW2m9jLhIcG8HWe4T1XIrmgKmBHVh7rtGxqwJ
         V4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748817773; x=1749422573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLnY+e4DmR9UwbO0AVGv5r5TxRv2i22KZH8nci/gU7o=;
        b=IUScN9kFz0l0t+C1r/Bz2Pe/vbsVoKCvB0MmZeUQz+ocLeKu8Tnr5jPGtETwkup82s
         X5971LhVidDfLcQDxcwlvaLxa7TyMNZ3PDrhmECy9x1XHe7nlXuNXzhc/r++4d8U8yEc
         NoaBU58CXjZsejB++ELVhEPl4jvzlk5nt6mt7KG2BYVWxZdrCDIHJ2G8oMYqJXZvaH/g
         sg1yL7W2L0O/g4g9Wdf536wX4GhkGDyPwDhAfsVc32+ZQz0MnifAq2NkAaymFXPFL1af
         07ty2K8rHaPoGBiNguevKEqshqJFXK4H3BqJ5U6FeREerX50mquGxCKQ1lgFOvzq+tNX
         4UbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH3ujZbGpSdOrLTfsAaTHXhQ5DJfUGl2gf4JRfm1UUEuoa+Xrwc0eLyQEHa+SgnqLhUnJG16s22cg=@vger.kernel.org, AJvYcCVJbVA4NhaGle0Jbqmgb9gPbqVnWvRJrC+l6XrPhfiMDxun1oNFM4ZA+Boh37lfytplCP8lzIIU@vger.kernel.org, AJvYcCVYzRbKqii3jaRaLDMuvGVQ7c8+PJII+aaCVDdnl9hCY/cxJXaTUJcZhevMR9D1f6gN/lmrbLx4GyxImyFGDg==@vger.kernel.org, AJvYcCXQ35P5RJzz0tnE7Loaj8eHjrswGep7WIzpp5IWM2RiKog9wvWf2E2hFqg8zokMUqqNPJjEnvfrjy/zbcKd@vger.kernel.org
X-Gm-Message-State: AOJu0YwPP7WyHxd5ZmNmg+nUTpQPiLTvDjAjRNc1X7owduKb3TFztw7g
	zp+6KaR3nXuEvrhkV/RlYbz3o4SBnW9ZQbse+OScrz9LhwKlaXbuLdNJQaB22w==
X-Gm-Gg: ASbGncsL0XDyQnMMsSu1cV85DR2IjxDzLsFG9gRCNtu6ZwlNvblSB5exYMl95JgvIn5
	9FitGFnRTrenJ+91vI/H7yEeC+K7CPJL9S3TLHsxgTTWePQRtKLyGFaS+IAJ2Z/l6gUUI1zFdkU
	nnXOUKokjR7CJuOg8iXvRDPX1NuqwaHhQz/VTxCzWGqndZSzZuMkW9yoVIGlhP37E1uVMUdDjG4
	bIWftM+gHmYZNa4zxFoHxfyKSNAs4wh8QrjlPhhyg6LaWY9xgszccu1cg8oj9O+jLb6kF5CXcX4
	hUVccBS2J1G0LL9gojMh89th77hiIB1kCy2bWpD3ZaEph4enaS1x
X-Google-Smtp-Source: AGHT+IHxEKNQmFH5Esn7+vrvKFhdlzvPKzJzwz+54lO3XiTb8Qi5En7rA6ezLo4Cpju1T9Y1p/Pn6Q==
X-Received: by 2002:a05:600c:a53:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-4511ee1103fmr45441295e9.33.1748817773483;
        Sun, 01 Jun 2025 15:42:53 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:4518:757b:6751:290f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm12916554f8f.53.2025.06.01.15.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 15:42:52 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: Sinan Kaya <okaya@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qasim Ijaz <qasdev00@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: qcom_hidma: fix memory leak on probe failure
Date: Sun,  1 Jun 2025 23:42:30 +0100
Message-Id: <20250601224231.24317-2-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601224231.24317-1-qasdev00@gmail.com>
References: <20250601224231.24317-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hidma_ll_init() is invoked to create and initialise a struct hidma_lldev
object during hidma probe. During this a FIFO buffer is allocated, but
if some failure occurs after (like hidma_ll_setup failure) we should
clean up the FIFO.

Fixes: d1615ca2e085 ("dmaengine: qcom_hidma: implement lower level hardware interface")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/dma/qcom/hidma_ll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 53244e0e34a3..fee448499777 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -788,8 +788,10 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 		return NULL;
 
 	rc = hidma_ll_setup(lldev);
-	if (rc)
+	if (rc) {
+		kfifo_free(&lldev->handoff_fifo);
 		return NULL;
+	}
 
 	spin_lock_init(&lldev->lock);
 	tasklet_setup(&lldev->task, hidma_ll_tre_complete);
-- 
2.39.5


