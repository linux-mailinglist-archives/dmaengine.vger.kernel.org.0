Return-Path: <dmaengine+bounces-2681-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4A92E92E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62501F2403A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28B15E5CD;
	Thu, 11 Jul 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="D2mA1RMZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D8415AAD3
	for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704018; cv=none; b=qDtFk7xGV+lHQtpwtUORE8NJcBPPAar1PjoC+I2fOw780EHiNRmzaj02GdxOrG/NPWX7PKZHzOFd6fho6Jku30W6mEVAqO3dCc9kAPN/LKnYI1ZfwiTDAIqrQtxZV0VkYbaEPGvSA+QOQxllI0U6rpKQ6U2KZEfJ0ZYeFPK4Lus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704018; c=relaxed/simple;
	bh=5SS6Gig9JOcYP1tR9qy0HzJLtPdDcsxtsaoCT8N8pvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X9gKtqtOfSaIsToVmXIXvYe2xBCsfUcvcveyB0o2yMi5HLfIjMkI9XXNQUC+w7qk79Bo28BJXlBou5vU1zWHag7ymhSX4uTtobJYzJth8FXrNQtNNeBTJl8gV14mNPdwPULBZIyDUt0ITl38R8KiA7Z7ZttA2l3lxde+Od0MjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=D2mA1RMZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so5492495e9.1
        for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2024 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720704014; x=1721308814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym2mv6R1wISSehFAd6D4uPYCq8YgxL980mxPOz0BbwY=;
        b=D2mA1RMZE9YuEs/r7M/E8aHSmCzlLDGJ3SrL6cO9ZNGe4sGmyDThTfiml7kqDERQOv
         m83GSrOLw16TUU/l7ek2XKNloeNAHxJwGnbRsCYDD1DGyph9ezAfGG3Jrlr34r/HIE7F
         Y4sUgFHjMYwCVI7q97VQyP9e5khZL5UxpplSbFzl3Kn3wAtxssRu7dG29QJ+YAFYRF1Z
         MMgkjbsRT72iIsGqyUlYecX+kUztnXLkmqqYdGD0lbdsAOIwfjfthXInAxqALkZx57Bv
         hYeLa5P/2o4KezGfnEOC0t42UmbwDd6Xs2hZ2ReHEn5hX9QMgyuuBwPItrjQJgijEXfA
         jyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720704014; x=1721308814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ym2mv6R1wISSehFAd6D4uPYCq8YgxL980mxPOz0BbwY=;
        b=LNyd0S/FfDuP0XWR2dy3+Ez/0UMsSVX207kr15jD7socX0X18WSjP0r3Ecb3DwfEAg
         KPjC35Eo0JHhIzX+TwLUWStcrVB522zYMqWZdcXPMzjDjfT3LSEi0PUWmMD3xfkClS3S
         DmKINkBIBq6dZR9t0tD58f5zoTGa0K/iKdHhkN9ArxawVyIrQdfgq5+S/0CtOzGJJrsN
         xuFdjyn9cu1dR597vO01mZU2d09FNX6Pu8vxDZXmY07qdPPBXTHmHWJ0OSTnOtx+rChX
         LpUoOaCSuTqubwOABsijt/QaH527j5LbXi2IVNLK3h8CV2ezfB7kKiROGPYzlyevZSY0
         I0fA==
X-Gm-Message-State: AOJu0Yy34zZ7iVvhlV8jS6R1JgdF1V1chFG3kCLsDtErS2eoKsIEVADd
	3ZwJ6w7azwQCZvSK+JXkrmXPv0p/SP/OHAzFMReuAX3taTwgCzdA1mbZUOh28Gw=
X-Google-Smtp-Source: AGHT+IHDlGShq8OX6brCIrvM/SSvzZHCPM5f95IdzjifVjJpmMGv26lmBMO1Glf+xHPW9s2m+p7h6A==
X-Received: by 2002:a7b:c4c7:0:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-427981b7727mr24132235e9.7.1720704014338;
        Thu, 11 Jul 2024 06:20:14 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279731a60dsm44652145e9.40.2024.07.11.06.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:20:13 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] dmaengine: dmatest: Explicitly cast divisor to u32
Date: Thu, 11 Jul 2024 15:20:01 +0200
Message-Id: <20240711132001.92157-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comment explains, the while loop ensures that runtime fits into
32 bits. Since do_div() casts the divisor to u32 anyway, explicitly cast
runtime to u32 to remove the following Coccinelle/coccicheck warning
reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/dma/dmatest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 1f201a542b37..91b2fbc0b864 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -500,7 +500,7 @@ static unsigned long long dmatest_persec(s64 runtime, unsigned int val)
 
 	per_sec *= val;
 	per_sec = INT_TO_FIXPT(per_sec);
-	do_div(per_sec, runtime);
+	do_div(per_sec, (u32)runtime);
 
 	return per_sec;
 }
-- 
2.39.2


