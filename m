Return-Path: <dmaengine+bounces-4796-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A888DA7867C
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 04:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B581891564
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 02:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BC84D08;
	Wed,  2 Apr 2025 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC3qMMFg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BD33C9;
	Wed,  2 Apr 2025 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743561550; cv=none; b=NBicjp7ikIpnSHhcOWgtzfHFXNMZz/EqfqrsEwTt+Afyxckh2dJPUS5/29LcAu8JeLHD5JShzqu6gtpKib7ZCkQaOcSIc0IBFwJY2ldMY1omMp8icLNyF4maTV8AKMV/xpzy45gJG6Xf0h7Ob6qrpxdgo5ux/ap8Pp0uu0AEeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743561550; c=relaxed/simple;
	bh=3abjfXCbj/PSro5zEDsoIit1avgJG8LAE+LKPMwYcSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1sWdlGTyeKHzKKMpt+H7PP/LAyBvs+53GyTWnVSacczJmRrf8T1k1UahK+8B6+m75P5aHtaa0Otd4xcFpYGcR8utJw61h98FSxFxfDduTJQflIY8Bb5HZFODUKQpHNI34VhwVeoJocB2Jeu0uFneUMQg1s6CB5SFJ2zoLszhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC3qMMFg; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso10245451a91.0;
        Tue, 01 Apr 2025 19:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743561549; x=1744166349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XwOLIHJIAy2dOsI8s3bg1wV3SaOv47d2J5QpbnBW3c=;
        b=iC3qMMFgR+whrof74SoblxbKoPSIGk9EZ4fj2uACkSFzLYbxgNsiM/KConHCtDJkBj
         jMM8oyrSmkyd196Vcv321dCIynZO49T1M55o22cwSsef/8sqZ6ecp72xzCYVFZEcbxOa
         OcqvyXYAQ9LD5hhEzwH9t8pmQdmWnX1hCjPHd/+ulQub1igTVi3U7Q/0d2NhiOD8yyEU
         aAcMl6F+hL6zfgerwZNYBgIPUHKCvkatpT8RubZBBHMBCxlW7MDMi9H7yoNgPg9OC+O/
         Or/povy3ccsJz+rwT1OlamnvQsPvovn4e9I9q4VUQiS6GPHXVj0vUW89kkpLd2sL/PUE
         pFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743561549; x=1744166349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XwOLIHJIAy2dOsI8s3bg1wV3SaOv47d2J5QpbnBW3c=;
        b=iuArv7BBcUGp3Fczp/TVN3ykoV0T8jQG9+Mx06Hb9Xu8CEJPUXYeXqFlVERHLpYmvP
         +qf1wghB96lEl8oxskzfUQY6hiTo/BhqtnEKjR3pEGAte3mRHAAG+KEQzWjiHhN8s7OO
         Wh+kZMy3b5v6xOAEujSTukEaacjX1o+GjEDyl5cq1y/38qRtL6Ts6N3zzfd/13EpJwGH
         eeVSprSriq8nr6ruq8E60fAdmi9BrUUFMb5cjdvE173Qu4mNDGquDhnl1jAV57kIfqsR
         3FyAXxlu2H78Yr4q10SR5px5gY5baXsVB+WeEs7mPZO8kwU2LhJDMCRG//P9/9T7CwfG
         1Y7w==
X-Forwarded-Encrypted: i=1; AJvYcCXROD77S8OfYj8q5P+Eyz0aErPS6zDxoBO5jaZp5vfksA2F1k2wRXrxNWyDMR6VxcRjjTIrLyBLbDnPMe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPSU2d63yl4pvqvcHdDFqyxahGCswoT/tuojtpDrTtMlu7QAC
	phS+9cvyz+5bEqNeN6vk7UmUimhpao4Zj1RL04mY3tqfCpEfowqXXKFVx39dCVBdVQ==
X-Gm-Gg: ASbGnctgYCF8EhtcGXl+Of78NWpYddSjfWjk466JbwBg5f9TWK/6Ur2g5IiOXeC/C2T
	FIj1DRvw6oyIwjKcAJW7t6XTH6JqZu8lXbox+MhkNcpuyZ2T0quNw58j2dHeVNsDNAXz88bMqy6
	23xBriVw8+6tVHu7UiboQAo3gKcY0dBKsjVQQ9JcxkRIvUoImaxQUOK1oUpaxf+s5p0StcClXhl
	4rzymg1v0ARKwR5UV7E5B0T2E47RawTJOvfhPDYIoAgXIS0yZMGGdSetFv1M3hsPxC/2oPmGTBj
	hUshRzimEg/T8j63NVLQHP+71Eq2p0Brdx7euVjvGgMJ6oann2wOLkVbtApZOFXGjKn5y4M=
X-Google-Smtp-Source: AGHT+IH/peSgVybRZVHTTZKlkdx+Qa99lE/p1LQoedRbFRbWsJRJo4TdosYp7h5YD5s9x7/KsLpBrQ==
X-Received: by 2002:a17:90b:1f92:b0:2f7:e201:a8cc with SMTP id 98e67ed59e1d1-305320b1002mr27114871a91.18.1743561548511;
        Tue, 01 Apr 2025 19:39:08 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca20esm97061305ad.51.2025.04.01.19.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 19:39:08 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v1] dmaengine: ti: Add NULL check in udma_probe()
Date: Wed,  2 Apr 2025 10:39:00 +0800
Message-Id: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
udma_probe() does not check for this case, which results in a NULL
pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/dma/ti/k3-udma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7ed1956b4642..f1c2f8170730 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5582,7 +5582,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
-
+		if (!uc->name)
+			return -ENOMEM;
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
 		tasklet_setup(&uc->vc.task, udma_vchan_complete);
-- 
2.34.1


