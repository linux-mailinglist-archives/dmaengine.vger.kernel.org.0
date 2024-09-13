Return-Path: <dmaengine+bounces-3156-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172C97829A
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2024 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEDD1F23471
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007E11C83;
	Fri, 13 Sep 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvxhms9T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444821119A
	for <dmaengine@vger.kernel.org>; Fri, 13 Sep 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238118; cv=none; b=iX7wPj+QC1ln59NSzz9rl6PCm2l3IWTQVZP5KjCOeennFnRp05XzjpQZDOPL4GJH0paS7X6RLPs3cuvei/xmP0q7RsyfCKyBz5rr1tnOHfDKzqFacdIqe+V09fKcMcrM0j5Gtc/f8wh3iOFH/ZzLrUlQcfyawSPmgq4x9Qx8IP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238118; c=relaxed/simple;
	bh=fA4AWaAbXnOOYk1783H913R2EXn6N6behOyf1uOVEVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FXr7lzHwr0+RCb2/NVR1QqbYVlgk/0AyTEyrlxOlHRi6A7yVc1zt8+nyGhMZGAU6YUre9Pt3EXY09zw94FUs5b0sSfg1A0Sh4bO+flV8FdIar6d24jzj7I3H94b1DgBqRqdLAxzYL/kr3xuJcbc2U+kJTv1Ngg9YWCqosxwUTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fvxhms9T; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so283759566b.1
        for <dmaengine@vger.kernel.org>; Fri, 13 Sep 2024 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726238116; x=1726842916; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPpJqdDj9nMsP3j5hQglMwhS09myjVI2wZ8NOXrgLTQ=;
        b=fvxhms9TCHrIhpMaGXRfjvMxAwdEAgXaCcqOlka2DKTPH6DRj6PDbKj+y1VJsCUTv5
         /duKxZQDo4iHGMCVBtVwT9oOXz8O5h+UqPEmCoBArVwjX/J/Yj4ciYh7fsXjZTQA1Xe/
         vmmo0KE+Ikds1/C9Pk6gXzNPA2mSKciwH6siGIz62auvtngWB6rIZuXPuE/Ns6KCAzUh
         qsBTpgdDvRr1aAL7gZutUfLEOoQyV5Am0bHQMWXHNUk3X6RwDRg/m4kysm9vjWUksM/r
         M/kUq8JIMheUT316lW226UP7CuMTpYTn0rBGGmN5vHsidv51/qHDP5+95sVFD0xX3yDJ
         ghqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238116; x=1726842916;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPpJqdDj9nMsP3j5hQglMwhS09myjVI2wZ8NOXrgLTQ=;
        b=lq6LB8AwVsCWnlC/4G51ymEwbSOooyu6UI31Yr6dzmjEW6wZdrxr6xV5NjRBBzY8bX
         9z5TmjMdATaSQi+eB+jhvjc66etZbAY7h4z15beW8aEjloOKPjiWRYvJEYZWAZ27zMZn
         2KyuEmUHBIv3TEYBh3aJ+C0a40e7IOZAj9D/eYkIR5EIi2JxCkN+6U1+HguW9ot0yitX
         gIWtKI6Ig2RGFh0mhajtF5Xz4VWjAYkW/pvj5GqnhdgiZftlI7TcrDVoL80jL9c/XKMQ
         BBf3LFd2kUw/nZRHePZsL1ymtS8F8DwFZd8Yu0lOHBXxI/Hurjv6A5jMP3ZlL6hEVwGv
         PFww==
X-Forwarded-Encrypted: i=1; AJvYcCX4u9jPcKTD6ntysYNL4iWTG2KboEa3COzAJYmCvR/iuLsFwP6OzSvbMMB7pNM3L+nR/vfeL+hlhpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1skNQRCZcs2N/0a801IE0c7T8zOofcxf4/FUXTepNDVLf0nTn
	vIp61dzzLsydn/dLLYx0oJXfn/1n6UoAXfYN4VYPUZ601tYFbVvRWg/dheUgmw0=
X-Google-Smtp-Source: AGHT+IE7zfPqYBpqVTOIdWqsFzLTQ9zGoS19bNShZp/HujGmJgWJRxZEfBbSVizhrSTnrvtHw8zm3A==
X-Received: by 2002:a17:907:f75b:b0:a8d:4d76:a75e with SMTP id a640c23a62f3a-a90294d0958mr616258366b.30.1726238115474;
        Fri, 13 Sep 2024 07:35:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ceed73sm882316566b.174.2024.09.13.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:35:15 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:35:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] dmaengine: ep93xx: Fix a NULL vs IS_ERR() check in
 probe()
Message-ID: <459a965f-f49c-45b1-8362-5ac27b56f5ff@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was intended to be an IS_ERR() check, not a NULL check.  The
ep93xx_dma_of_probe() function doesn't return NULL pointers.

Fixes: 4e8ad5ed845b ("dmaengine: cirrus: Convert to DT for Cirrus EP93xx")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/ep93xx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d084bd123c1c..ca86b2b5a913 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1504,7 +1504,7 @@ static int ep93xx_dma_probe(struct platform_device *pdev)
 	int ret;
 
 	edma = ep93xx_dma_of_probe(pdev);
-	if (!edma)
+	if (IS_ERR(edma))
 		return PTR_ERR(edma);
 
 	dma_dev = &edma->dma_dev;
-- 
2.45.2


