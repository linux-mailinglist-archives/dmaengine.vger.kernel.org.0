Return-Path: <dmaengine+bounces-7065-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B848BC38D8A
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 03:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 474FA4EAC2C
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1C23EA93;
	Thu,  6 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNhcGU+V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460D222578
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395636; cv=none; b=CYbBVaxCAG2dhUOG9PS9vq7BzZPaMoVlH+MQNfrTVGfS7LmYMpedD++SIPbQlnGhXpis0rkiuWovnubc9j25xl/JVV+FL6q/uZUopXG1OeqvO36mfnhFA572soeI8S0DTDnyyfvDuf7MAbkEP8qqBTPU3Dkexrz8kjg3ig2PZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395636; c=relaxed/simple;
	bh=OXHSMPPHIUBOjx5jdSmn+o9Uo0uU1Yv9UY7N7c1/grY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/MdwXgCDcuKcQpjbRuVmNUCnCXte0r7AzlSbLULXCusttJXUQiaT2y2sk6GpB+wnSV7+msRviA/RbCIaE3xgKp1lTyyQrLC2s7eVydbCCNPAFkjIxmkfnCtdm2yiKfBXPOA+pIKUKm112G7suE0FE0mdspbQYaz4anSSD0BEh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNhcGU+V; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a1603a098eso317108b3a.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 18:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395634; x=1763000434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ancoHQbMh61Zmy4JFkPI+TIiC//k3vHCV4hxEmDTqYU=;
        b=JNhcGU+VxpJU/B1hdnzRBRJUgxxGMBCSTlj9sOFacATOlE+JpwlYEluZDePdt/JU+g
         ldB5msnf9ZskyKrOgNu5ylOpLPSAOQtAtwx4uUleDNihC+O8bW07Z4IRI+L1bD/m0PmJ
         iLUGKXud9cot3qI4OwiXv1q/QbX+IHEw49h8PmAdUYOCQQVb08ED81TCdyg5+K38QJg0
         CIbch5bApGNRQ2B9JSOQghO1d+DbJpA7cN5CvztNGAk6nE14mUoZ5I90InVfkZrDIgKe
         xZMs3+ykVG5iT2zKU7k8cbvDAkaXoCs1IIBKI5TddjzV5WhE7zPVWvTsgXiC5EFqtXlY
         itpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395634; x=1763000434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ancoHQbMh61Zmy4JFkPI+TIiC//k3vHCV4hxEmDTqYU=;
        b=kgg8YepsaPaW41UItFE/tl9R5pYvOeDUu4ZWVz0yKV2i1JaTZCeg3KYPLDSAAVSby0
         0WL5CgOWvmhDxEbcLl7ad1rI6dbB7zaVJbFdFBdmMnd32op0uWDhUfGsCSq7ZiIZTrc4
         uHJ6GKIQpK1HGAKEZ/k5cpp1GIH/zhsbBEUusGGeCqNUib8dzFWErUHTItZLMVtWR0tB
         KDK04gdO9R7cIY8yJdRfdkx2bjQZxodgewu61HfnbpngN35Zbb+0xuLkTKzxj1UhbndG
         6RHX/PeCT6Yu3t36NW57GjiHnuWzDW8jzGLfCh/FGjUCGVQsBNj9vQ9JWtLMCo+FEtHW
         S1hw==
X-Gm-Message-State: AOJu0Yw9eQUqaG/4AHiCTbQGklD4RIeIl+v8Fr/qRoIhZtILEOrXv2PO
	mSB1YYsJ7gP/QTGAHqWyDeXO4MvCx7R/zEirHZrPqrppfLHo+YY5QVp/HBLDUw==
X-Gm-Gg: ASbGnctzA57cRGEZ4doTfzNogngNurM8SH+pVoQ5faJvqqQbwoU0XjsXwdT3NwxWNZm
	jTnd4roqt2KFC7dDPJeod7GyD9QKBUjCom73gASJWCU4MVHwAbC+kTC0fj/uhy0i88rFgCSXtFC
	qS/dcEy3ACDoyyGyd/iCiV/QFWcqc6cT323rg7XgvVC6p33n3mQYbwLqSF22ooQC3GAAP4exelX
	DIpsn48OEfqTowskkWWBLvA3yKVrECl2NLMfnEAYc5PwoXSofCmXONpNzkns1fPlaUpLZAKHaPy
	c/ySJDvCegoP8z+7u4t3rqI85XrF/M4uhPSkUpDLoacupPxYJzTW07VqwV+NKzvaEoA/wdRh7r8
	fzX1dhqi+sUWStO7UeWaUm+JDrwROB62XMfXVBsizigZBqjhA3WqJnQEmnQ==
X-Google-Smtp-Source: AGHT+IGpq6uwBfjJREOx3KBhbuv4UhxImGhe8wgrE5sf30EQLGu39b3EiCt9niZiEO5dlsWN+gAzTw==
X-Received: by 2002:a05:6a00:22cc:b0:7aa:aa7:a83a with SMTP id d2e1a72fcca58-7ae1d15cac3mr6415584b3a.9.1762395634403;
        Wed, 05 Nov 2025 18:20:34 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd57f91sm830516b3a.23.2025.11.05.18.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:20:33 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STI ARCHITECTURE)
Subject: [PATCH dmaengine 1/2] dmaengine: st_fdma: change dreg_line to long
Date: Wed,  5 Nov 2025 18:20:14 -0800
Message-ID: <20251106022015.84970-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106022015.84970-1-rosenp@gmail.com>
References: <20251106022015.84970-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code is encoding a pointer into an int which works fine with a
32-bit build. Not with a 64-bit one.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/st_fdma.c | 2 +-
 drivers/dma/st_fdma.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index c65ee0c7bfbd..01211090844f 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -68,7 +68,7 @@ static void st_fdma_dreq_put(struct st_fdma_chan *fchan)
 {
 	struct st_fdma_dev *fdev = fchan->fdev;
 
-	dev_dbg(fdev->dev, "put dreq_line:%#x\n", fchan->dreq_line);
+	dev_dbg(fdev->dev, "put dreq_line:%#lx\n", fchan->dreq_line);
 	clear_bit(fchan->dreq_line, &fdev->dreq_mask);
 }
 
diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
index f296412e96b6..f1e746f7bc7d 100644
--- a/drivers/dma/st_fdma.h
+++ b/drivers/dma/st_fdma.h
@@ -120,7 +120,7 @@ struct st_fdma_chan {
 	struct dma_slave_config scfg;
 	struct st_fdma_cfg cfg;
 
-	int dreq_line;
+	long dreq_line;
 
 	struct virt_dma_chan vchan;
 	struct st_fdma_desc *fdesc;
-- 
2.51.2


