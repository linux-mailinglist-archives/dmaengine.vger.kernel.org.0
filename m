Return-Path: <dmaengine+bounces-4026-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF29F7274
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 03:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F48E160FB9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 02:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B535956;
	Thu, 19 Dec 2024 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="Kpmr9XCU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A1A31
	for <dmaengine@vger.kernel.org>; Thu, 19 Dec 2024 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573920; cv=none; b=h77GNrLSK3tLR0S/MWzmJk+WhtA1QJFiOD7X+Ic3Uks60G+YzuUPCEZ5ihpuFj0HkmUu20xxaoLSZI42CrXeIZZJ3n4+bUbd6UQdvcc02vEaZwxrGtwLZp76O+syoK23hQZL0O3kO2RndNkV0hCf0jVbL+sbD4BJAsaqMsCm614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573920; c=relaxed/simple;
	bh=7w5JxjxF4XkktjUCmlmkIZc9oGUBBBIVI9fv1UdFh/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkL/yjcLLiHJMae+oEbO5c9XvUzxL7JhLCei+fVWLYM3ELTwnyfb6oMiDO+0aDbFo4qwRjs7ZZ4eGt9WflKBXJdXyG4ezMOlwwTxZ6AuLDhAn3yH0beY3eJ6ykkRD2poYsphjAxvFawLC9FPyPS88flBITsBUixOTGHNuWN4Ia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=Kpmr9XCU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-218c80a97caso2738295ad.0
        for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 18:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734573917; x=1735178717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn55GV4Q+P/3NLoQpmNVWnzinNnJfbQvWn3wTKJ8wSk=;
        b=Kpmr9XCUf02FZQuC/Wa8UXfJaz4oEy+Iqr3AchnI2nXmpM7q9/k6NZZ5PMTFv/dvBI
         YFoonT9ZdK1q0e43VLZa1i37WorF8+BJ2n9GCTo06gsLEpplOKFevSYlRezwsBw3yFAt
         g4UMByw0OjGFumoHFWM9+8mI3xXS7YRa4nnatoJCunv45LwvbVNxckarUR6SYwvVkRCV
         W2Z3x8Cr1jOsal0LhHhS3u5+gGnGYGVBOfYM4jZ7JmTZIrosgKCD8MSk1QIjeDx/IFla
         VTq3ILCoAqKm/BNsAtQmqcvjVZLrdujvmeLXCIrBMBrVcyvHNKnqViKAOgdvVj7G4/Ap
         8VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734573917; x=1735178717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn55GV4Q+P/3NLoQpmNVWnzinNnJfbQvWn3wTKJ8wSk=;
        b=SUcaEdUk/SdsNZwCA2DkC6X/KofHUbxtukCLSg+XWY2en7/00v9SpJAPdTmntmhbSn
         BW7fil0+usBrhg7PjP1kUoz/2nL6gs/o9Jr4MgvteDSOSWCDMNvR6luZbGP8EwGhrKtp
         bHHuGjP6rLLvL44HLbram1ja2h9EJ3yoUTJNRy7Oj5B+8KPRtfJ+4sVK7Czllz4ETuEZ
         4m0s5A2T9mtox/AVkv5SHmNOAbnJgH9lBebjHVcAjX4II7thvJCCTlv0G9ZC+8FoiRIE
         t2RgDuTLLApnRSwlSFfCzkYMKnB3KtyMHkHxW9xXWjn9IKnNvPa/gFtuK/ZErRnzSrXz
         RgJw==
X-Gm-Message-State: AOJu0YyVYoLCitX7GrB526mWVHI+dLTIO34XeWHFXvCt88A0mQ6/900C
	mT7OJLNfQ8NULCT+HVopLyjx8H8JgN2Jz0jG320Bz/rl/xFcwe0ntrCZKsoULlc=
X-Gm-Gg: ASbGnctyYdSa6ScZ3KKtnmSaFE5Bi3V27RF0rLQl7cUotolpUlhucTPKlmeHf8Uw5Wh
	T4Z+HqLOBv+C7V/fTPaGQz1tOVPymvvelOaAVti0RfwlJ0GEEJ9wrmxjffresqt39LsDxBzTl0l
	yQjc6cauOH2a0BjMDhlQOnVsXhTgI+GV/+8nNoXaNDfGqiMowK1F23Dztwo4T70908M99/D24Lr
	JnZWhTYIDAcDvF6x0ByD82vl7DbK7THMSvUeNzaFnbklSCrXe3wHA/IKv6kMh9Ct1Dqu7GItfHS
	2AM11iV0Blig4XzTakxmIzj4E4JGbzIS6gYxSlaByYU=
X-Google-Smtp-Source: AGHT+IHJe+tTuDqHLz9izvyxe1yjPoJd3dEEutyMZN7iPhxI3dgfkH/T6AHHONj3Gr5S9j6iwxNCyw==
X-Received: by 2002:a17:903:90f:b0:216:3b31:56c2 with SMTP id d9443c01a7336-218d726cba9mr69763135ad.53.1734573917173;
        Wed, 18 Dec 2024 18:05:17 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964b84sm2044295ad.50.2024.12.18.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 18:05:16 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	dan.carpenter@linaro.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v3 1/2] dmaengine: ti: edma: make the loop condition simpler in edma_probe()
Date: Thu, 19 Dec 2024 11:05:06 +0900
Message-Id: <20241219020507.1983124-2-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When i == ecc->num_tc, the edma_probe() calls
of_parse_phandle_with_fixed_args() and breaks from the loop regardless
of the return value. Since neither the returned value nor the output
argument tc_args is used, set i < ecc->num_tc as the loop condition.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/dma/ti/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 343e986e66e7..08f6c67d381e 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2460,10 +2460,10 @@ static int edma_probe(struct platform_device *pdev)
 			goto err_reg1;
 		}
 
-		for (i = 0;; i++) {
+		for (i = 0; i < ecc->num_tc; i++) {
 			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
 							       1, i, &tc_args);
-			if (ret || i == ecc->num_tc)
+			if (ret)
 				break;
 
 			ecc->tc_list[i].node = tc_args.np;
-- 
2.34.1


