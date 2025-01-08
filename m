Return-Path: <dmaengine+bounces-4087-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C28A05672
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DC31888A85
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2025 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A71F0E33;
	Wed,  8 Jan 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHo429h+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC51F03C3
	for <dmaengine@vger.kernel.org>; Wed,  8 Jan 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327606; cv=none; b=PwYtu8PC16gZgXP1IDtEaH72Nt2IAPXsWX/XmjoqJgOJXg49t5b24MfnAAZ7QFyRVvsah3bYUuXf9W/0b9CPj1sHdhSdyPNDuHl0pn03NvNr9eO6HA9OnWsOdljKP4+JmgWnOzoxfWOQLbQkkTYprEtrUWVk4oxjTlF7+g6j1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327606; c=relaxed/simple;
	bh=apMMjVP+kwbKtHPFp/A5uUFdrg+Nshc3Olcebw/xj6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LclJ0JX55079SA/9x8NbrtICw4gs0mqpix7WlSWqMfj2TIy4MSGuHt1EUXkR/6d1X88qXwRNBT32M4vNn+J1lwcw7TJaIPgCezTk28f4IJKm2puK/wOdcNB2bLBVL0D20IaeBqWGOfBHuNA6B/qTenk7Ejhzg7Lnm7W5i/WY4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHo429h+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso163595065e9.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Jan 2025 01:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736327603; x=1736932403; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzXs3KFyj+OlwwBWlXhhhHxWf9NDPhglowmb8OrsU0U=;
        b=aHo429h+SPawfeaDbWlms7HxQFlUOrZkfZ5RP8ZXt0urvOkAMKbgIJxTbP6lLbu6i9
         JkDR+E792lAhzulQ2cohPyGG3pR6AsjSKsU9n6F2xXH1CpD5uFaR7Th9ORk77Jqpr/VB
         Uah7JCFm1oJ0XzjBOUI30gtaC6BDPARk1wO1t0jBYwIqd5x1LW8OVDP1CrG34CNJELd6
         O4lxaYEJk3C9jlqgsNdahh9+xlybDF9qNxRcmB4t1b7kGMwis4hrhXDfDCJ27/JMV0Ic
         2xyjO5PJsHf6adhzMRr3PmOFZSeYbCFGJgHCV88jueAlKPJhNg2KHV8DqqsbQgDPaltd
         giMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736327603; x=1736932403;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzXs3KFyj+OlwwBWlXhhhHxWf9NDPhglowmb8OrsU0U=;
        b=CJ6eiIrZNWQrBdJaAQy2QHjxcYk1FfrNe9u9OIb2qs8coBuWN/xBGir2oESkI1aWus
         3W38R9iaNJPZToy13QNRUfBxkmO0iZhEAnnoaq9AJbjQnxdeY8cRRGE3MIGxDqEcURUC
         y8Rp6+TP5K8WaGMd794ZR5EI9PqwO16dpPaBfvLLC428S0cSXdh1YEBd8vmpO3nt3mZq
         bNUJMi1yp3psEgHWeJzc0ocL1jiRly1W7AuTs9kMJEGikgPo++a5a00hODi4fXWd6F/t
         x25WWQr1SnNgxuNufGBPfQObIaW8HWiO/E9ZaZgf8fLO6B4Kr43G0z8t3IGKjoQptdiU
         uRtA==
X-Forwarded-Encrypted: i=1; AJvYcCWkJjBLS98dmlMmB7ua7kqPAmlyKQdemwkYQeJ3Sx30sOepdJOn4FE+uIsn0TZ1+gPlW9L48IRjYsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4mYx9sReW00+ls9QW36nq1hpyyqZvv/bqHCHIlpsVVmU6Xkw
	zylq2XEk7/LmTFBw01gx7Z4GfV2+n0MEVFHwfyJiDrBS5vAgIcTKk8K9mGRw4bs=
X-Gm-Gg: ASbGnctI+FeF+c0k83Jj65Q+Rn1ef2k8HTJnyybpQm/pzpUBNa+VPIrtYpvF1V8LPKQ
	FiBorg0sO2VsDlci2pz8RG4Knenge/mZsishw/xZLC7U5Xgi0xm5HQJdUPWqwvU9fjsKmioeVKx
	rM9RRSsu8tg6Yy+mOJ6cuz9mfx7kV+NFc1RaD2D0A7n3W6+/1U2N55iLaL+gT3UduuI4oDX42Cl
	/7omCKWqWdIi7KWVMNQdKfnqHAy4+IwZP0vGdQ9YYx4om3GEtNAMXGpng3s2w==
X-Google-Smtp-Source: AGHT+IHGv+AYtNiD8pZSgTeJJr69q8hxwaeSukDvA5nr1zKw8kvCDzL2/uyOHrj1po6Sh+MfWJg6+A==
X-Received: by 2002:a05:600c:4f09:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-436e2707f13mr11755805e9.23.1736327603629;
        Wed, 08 Jan 2025 01:13:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6401sm13964575e9.2.2025.01.08.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:13:23 -0800 (PST)
Date: Wed, 8 Jan 2025 12:13:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Delete unnecessary NULL check
Message-ID: <ec38214e-0bbb-4c5a-94ff-b2b2d4c3f245@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "saved_evl" pointer is a offset into the middle of a non-NULL struct.
It can't be NULL and the check is slightly confusing.  Delete the check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/idxd/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b946f78f85e1..fca1d2924999 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -912,8 +912,7 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
 
 	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
 
-	if (saved_evl)
-		idxd->evl->size = saved_evl->size;
+	idxd->evl->size = saved_evl->size;
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *saved_group, *group;
-- 
2.45.2


