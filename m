Return-Path: <dmaengine+bounces-3335-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2999ADE5
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 22:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421781C22992
	for <lists+dmaengine@lfdr.de>; Fri, 11 Oct 2024 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FD81D173C;
	Fri, 11 Oct 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmaF5XXr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E001D1503;
	Fri, 11 Oct 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680295; cv=none; b=fSjfY//TKItReziFqb69rjYM24nlJ2M4B5kHPXcgVx5QZl6y8Ne9kkc5BoVzPdRJhtBLlGgKoT+Wsl+OBOdO2k/aGSzP/nvwxae3wluvfGAX+w2bNMQhmRbmRupRHOdsDplJDdEWiqEIaoajPS5bv2njd8MxTWEUeRab7i166xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680295; c=relaxed/simple;
	bh=MGiRJQRlTN7J+7JxykzupyNUy4nkFJfjvSNd24lKiR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lG6p72sGYUDtob263PPF9gG27QM3uMyx1y+AcjYzrvj/YndHvOmRwTwwxm7HTzbxX9DwRsjYgcHwBfU8Ri3FYbjqQHqndSOh2aa7GeHgFTtrfIiovD7p5F3BWeSRM3KXuoI9thfow7Q/eE6pP2KctBkTXWwO8KVLNAj7pPuuKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmaF5XXr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so22351205e9.0;
        Fri, 11 Oct 2024 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728680293; x=1729285093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYm+fth7FkSXHtEW/AOABJSnZauIPXeR8ZJasDXUzK4=;
        b=LmaF5XXrcCFqMaq7BY2PnHuVW35g+I/CM/OKWAqbOG5GTwGQYoOkUV6vOercoS5fWj
         tTIAfVfJue2ejN1IMpp0KPW+nMb4fkfw4wv+FXFdbENTsuNhZLZGjz+a3AwrBykeDnK/
         aNoz/Rwzz760ZA1PZdg5z+rNQcYffvlJLxojeX6YQIoQ1u03ORJbHYPqstAiLTgC1Fmm
         F6R9pF3AF1VkQgBKaaUwLtZKwhhk9Zfi48lFdyXDR8cPSNiYvSSW6QJIMss8NCWzNVPw
         I1SKm/x87EWxu7Hha4OnyVWGsB3qpnjD2MSPbauXD52Uohi+NU+bp3Cqoa3flJxXqgDw
         Z4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680293; x=1729285093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYm+fth7FkSXHtEW/AOABJSnZauIPXeR8ZJasDXUzK4=;
        b=tNqz157B1ejCcEZckcMGTIpgQIcpnZNlwCPutYfvkrvJcETWBO5sSJGDCHU1t8EJPd
         BTcg845oCIKDYN75UTUxYdPksyCo2NCGUPEvhVRB8zeXxMi+SBKsDc5VvM53VG6NBfLw
         WQ/Udmg3eUMG7GicZoMP47hKxEZJw/b0gDF4LDy1QTwll+QQmYfg77LCpJZXnjHifTW9
         3hpHgLJBJwRNho64o3uhBOAhyh+bunSBtkTvBKQnCi6MQazHHxemITuun+JUhHcQuVjA
         k/qMQGyNdKc99tCC8etZyRsUtoo8ludKoByvSn8XsV+UhjcZo2XJsdMiWOc6kpyv9ENh
         jFWg==
X-Forwarded-Encrypted: i=1; AJvYcCUUQcm+Gul2QS4lCHjzzInmhIrH4DsE8pgEAojc9eBbGZlo5t9AdP11wzgoOlBPE9IQRd0v7ux+@vger.kernel.org, AJvYcCWA6w9hUs0bNtJD02bdQo/l+Ge1dQq6Vsz633TXfEbn2jw3DFls6cZird9eEDjUhuJAetiTIvApjd/2hvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozTHOodrKxIkU7YWZo5Ie9t+HMKwRNai+cwnIxovWqlUTjxfc
	RkQmcWiKpD+h8G/I7wBTclopDKv9PA2mmVGyXcsvhTLSBsyXEeVi
X-Google-Smtp-Source: AGHT+IGt04KkHkZhzsOAQ/MJBhCpr2wxNiAWvMQKf6REcNSMQ9r2HRkHEPTBYY4dZBuCaVFl0EQvhA==
X-Received: by 2002:a05:600c:4e8e:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-4311df420c8mr31731665e9.23.1728680292488;
        Fri, 11 Oct 2024 13:58:12 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-55c0-165d-e76c-a019.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:55c0:165d:e76c:a019])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835c4fbsm50984055e9.39.2024.10.11.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 13:58:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 11 Oct 2024 22:57:59 +0200
Subject: [PATCH 1/2] dmaengine: mv_xor: fix child node refcount handling in
 early exit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-dma_mv_xor_of_node_put-v1-1-3c2de819f463@gmail.com>
References: <20241011-dma_mv_xor_of_node_put-v1-0-3c2de819f463@gmail.com>
In-Reply-To: <20241011-dma_mv_xor_of_node_put-v1-0-3c2de819f463@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728680289; l=1067;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=MGiRJQRlTN7J+7JxykzupyNUy4nkFJfjvSNd24lKiR8=;
 b=Uh7i3LtjOWEbHfQ26R59A/+tLP0+rGXLngjqTc2pQ7gTNR5jNtMvj3Gytg4wsZFmDi7sT27ER
 5iMk9m5bpo4D9vcNwhxuZDz6K/X6xNMM4dlI9tVXg/zQU+y3WE7LWrO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The for_each_child_of_node() loop requires explicit calls to
of_node_put() to decrement the child's refcount upon early exits (break,
goto, return).

Add the missing calls in the two early exits before the goto
instructions.

Cc: stable@vger.kernel.org
Fixes: f7d12ef53ddf ("dma: mv_xor: add Device Tree binding")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/dma/mv_xor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 43efce77bb57..40b76b40bc30 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1388,6 +1388,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			irq = irq_of_parse_and_map(np, 0);
 			if (!irq) {
 				ret = -ENODEV;
+				of_node_put(np);
 				goto err_channel_add;
 			}
 
@@ -1396,6 +1397,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 			if (IS_ERR(chan)) {
 				ret = PTR_ERR(chan);
 				irq_dispose_mapping(irq);
+				of_node_put(np);
 				goto err_channel_add;
 			}
 

-- 
2.43.0


