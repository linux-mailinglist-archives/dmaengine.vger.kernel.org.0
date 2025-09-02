Return-Path: <dmaengine+bounces-6314-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C0B3F995
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 115E37A00D9
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994B82EAB61;
	Tue,  2 Sep 2025 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNOrsB3z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEDB2EA15B;
	Tue,  2 Sep 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803849; cv=none; b=Z05KtUYV9AKAnFA6ZHiP7f7DeKKOdL4xXq7FJDQy5Dz+kQLQxSw+kUVDLmwtTsK+a27dHyARMDZYWW2r0/F4Od5buxDItuV1AA8+hkdyLlh7l3zEeiUSY/4Yudpop2633svl3140I8W3tNMSyyvLCSkrU8TCLJSotNjU0YxUU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803849; c=relaxed/simple;
	bh=9/4dSQil6gCNmsV1F2nLp74J56kfb9oNf3kGFxP6zZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fDCyTLH+qHJuQyYsHbqliNb1DxSid+yiS5/SK7CZ22Xjs9DDHUyxQaF8pCm5sCLtmBunj5OB4PUej0hCkSv8J4U6nlnp/YcVQoG2DXMTry47T2mNPd0fg7k3oHGuVXlzCPuEGKLW2vIL5esP62BGv0pocOQ3PSnq3VW0T84LN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNOrsB3z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so2880950a12.3;
        Tue, 02 Sep 2025 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756803847; x=1757408647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q0TdqGH+SedUbO0icaQXU5WTMKI4ygvvuC7x3PRRyI=;
        b=HNOrsB3zqdTQbm1QPR1FaUxIJr0XWqIrzXRGnGoR8tR0t1ET+QB0aavWyuIlGjARLA
         0Ca3wdzgPmITKSCLQRvW8vwBnv0UuD5utxGdH0cid3NY25fKFUqZu/5J3IPRvlGfJWkI
         IsQwDIv7lF/4I4IV1PvJk/Bh+5Dvx4UBlIT7GcLtqN8axHBiNTxzUB609pNjYFFGdZqc
         gMpF/cv2AJNpf2awmhEsXRgwzphUj86OU7fiu4+gvlNJwAHKyWUmURDOwW1ba6er3v5W
         4aEn1hw2c2aQs6OMBK313H9ZAsmqHbP7c5kznVmaSX140BLpF9bkxCSSVvN2ZBoA3z5T
         W0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803847; x=1757408647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Q0TdqGH+SedUbO0icaQXU5WTMKI4ygvvuC7x3PRRyI=;
        b=pcSTfF7G6Mz5SeyQoyoJn1bPQqvTb0r1i1Tsg9C/qeK8wRcAYRrLuP6qcOLmI4J2RZ
         wsT0Eh9mKUKKZBJxf+8Brv95HjFqhxhiWAa7zP9CL8NvSGrqifZvC5JNIcndYbT5EGno
         XEHphOyNIxKO69hoAyjlAnT7hobxUL+trmzvtO8JfyFSJpR7rqQJyslA+I6gbI4oDHL4
         /xR2US1vTwzawqug0ZsixiENhD2l2c5YrnVvrmIQx+tJq1upIbLCM64hrG+/YZcuYR0O
         boHYEEhpTUQSV25zJNSpAWByzIICfACvc3G1+NKf21vW6NuOghGExNRak1AX/kEy/ZTB
         VhTg==
X-Forwarded-Encrypted: i=1; AJvYcCVzum1GW7Y298fHTsMa/Yw+lqNkzptBXd+R0A14yeK8U9WlsIb+dAQBbLf+rxCyLKaw9u0LuRl9914P3RbN@vger.kernel.org, AJvYcCWBmNeqkVAJE4Js5JMoB+4y3dB+qp1XTDqK3Wgc18PKaAZ7nctyCHs2qumqQdxoeQrCC5IEQCJV@vger.kernel.org, AJvYcCXilPxtF8Iu6qi2KlYvVKmfAQLQWUTK3CzYcabDrTY4uNdEgmmhrdsVXIo5zJ+SQX+MMMQVLTGngMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1WLnlsBXkC1gwn1KV+hzVUO+froXgj2LHWv2d9xZTGe+2ICG
	XqEdBrhxuZ6HXR0d8Pa9umBQVCTftCC2kSE41zwuo1/9e+SJJl57bIPo
X-Gm-Gg: ASbGncs0Qg9ZOWbnmnypIrWsaamUxRsFTWoTXlzkxBvmCjariihu4CNRi/II36mecGL
	Vr1nHJjW+ydXDJCC0pVP8Cpv5BTL+GVPbNsF2iJvizMCRvxP5Ek9tcoKASFCXTjn4DsmkyY2TLt
	OZeJ62aN3ii6EEGXY2sXKzgsxxAXdIlx1J/XQffatHYWXdxqRt4oNJW6hha1uPES+CvaZPLjpA5
	7a1yzXOrdnAQqQ54lWuKHhfc1S9eWXEwNjsDpccGhgFrPZhFW1La0ULZdjvuZsO29N3WtVCXjXl
	EFkXlpCN5p3GOKGmqxHazSqLMlFp7+B9Wcv/QW5FDOUO0xBmEtz2EntpoudFqafqjnVDFhMQ2Zq
	fRBAb26VIQ4Ep/7tLZEyVgBbJrOTv6ul30F+pEfuFtvyRMpVufV0Xjl8FCt6+7IGkQllCMk+VOX
	mruutx+Eerrmout6MjqTH13v5I2jOQv5oCVidS4OYQs6/rKQ==
X-Google-Smtp-Source: AGHT+IFyanZcjAkF9HeLJ3lRjhUkpz4bCvq5ZgbnJtfm7KF29FCpEsN59SsHPIhpiuAbEi1lvHyW4w==
X-Received: by 2002:a17:902:e745:b0:246:e1f3:77b2 with SMTP id d9443c01a7336-24944b65071mr130427125ad.53.1756803847329;
        Tue, 02 Sep 2025 02:04:07 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.34])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24b2570cfc8sm6300135ad.76.2025.09.02.02.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:04:06 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: dw: dmamux: Fix device reference leak in rzn1_dmamux_route_allocate
Date: Tue,  2 Sep 2025 17:03:58 +0800
Message-Id: <20250902090358.2423285-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference taken by of_find_device_by_node()
must be released when not needed anymore.
Add missing put_device() call to fix device reference leaks.

Fixes: 134d9c52fca2 ("dmaengine: dw: dmamux: Introduce RZN1 DMA router support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/dw/rzn1-dmamux.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 4fb8508419db..deadf135681b 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -48,12 +48,16 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	u32 mask;
 	int ret;
 
-	if (dma_spec->args_count != RNZ1_DMAMUX_NCELLS)
-		return ERR_PTR(-EINVAL);
+	if (dma_spec->args_count != RNZ1_DMAMUX_NCELLS) {
+		ret = -EINVAL;
+		goto put_device;
+	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (!map)
-		return ERR_PTR(-ENOMEM);
+	if (!map) {
+		ret = -ENOMEM;
+		goto put_device;
+	}
 
 	chan = dma_spec->args[0];
 	map->req_idx = dma_spec->args[4];
@@ -94,12 +98,15 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	if (ret)
 		goto clear_bitmap;
 
+	put_device(&pdev->dev);
 	return map;
 
 clear_bitmap:
 	clear_bit(map->req_idx, dmamux->used_chans);
 free_map:
 	kfree(map);
+put_device:
+	put_device(&pdev->dev);
 
 	return ERR_PTR(ret);
 }
-- 
2.35.1


