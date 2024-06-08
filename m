Return-Path: <dmaengine+bounces-2319-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211E9013AB
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 23:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED37282082
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 21:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6AF1D531;
	Sat,  8 Jun 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG//4t7R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54EED9;
	Sat,  8 Jun 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717882367; cv=none; b=pRFZE4RgAHVCYF7VthDX1HV+idE5sO/Bh0yFTMwWBOU6GpYp1htfnix+iuqx+wAIOx3oxTzbuTwGIDiCYq80YiVSPYSIYEyIpAE45RZ1NfCNx/1Qi0gF9ccZzmDaLqMjpNKaQ3TnP/C2FmfYI6OCODUo1Kpf4oO4ssDU9WeLOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717882367; c=relaxed/simple;
	bh=zVflGiVL0wY9HCA+JTMHCw5+k5mGjuP8/ZU6BhUj2Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBwjFvbLE99IWWmgRXjgFsEhiiBF8w4y2mwYVXYqurRkzrLzswJu2fDKxhpftHGHLBQ8BD66RioKEYSTqQASu46jD1nbwLgopvBxAHFnYj//d3myCbUp7VSH3r5pCifvdxQgYEpbWq7Rsa/VugzkrsoiYXqJ5TVR9cyhj3ylj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG//4t7R; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f1c209893so418272f8f.2;
        Sat, 08 Jun 2024 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717882364; x=1718487164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWNPi1kJTrBS+pEUGE0/YU8V0dOXg4gzyeqJvrLnBPk=;
        b=FG//4t7RUX+dC072mQiXgAq9iNjrupI2p1m5j8AwRzYyyzJrwaQ1RRKeL9W4I8XHHB
         uEKKFo4yilr7rEfkYKs6mnloyzrIjr9VYWR46HzWib39LnQaA54t0BxJ515eeHf8Pcxl
         YTEdq4xcd1uiAXusJNjoeqO0/2QPtooUTB2NGLo7Yt0pQR9jR2Briw+5be4Z9XU+fDn9
         CsS6lyCJyqlpFhXOyJLiRfEW+sNvWzf7y8I8KKtyAS18YFCddkTTwekjjdTKxeM4apj5
         Pl9o1bTkctOPcj7LWm2HEjjiF8wjiu1f7gtvn+mnDePYh/B0H6fWYNV/rGhKSE83ZHi3
         nZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717882364; x=1718487164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWNPi1kJTrBS+pEUGE0/YU8V0dOXg4gzyeqJvrLnBPk=;
        b=Hz9JCsXMP2gZm5uL+PSfcksD6IQPirybiXGRgifd8hQw0WbneDxHvqrdop1Cc5Xowz
         e+PDlovpEjs4vJTom52tMGo4RZSmhUgC2Hce0CStpUHNu/Vl6QyWI6vXjPrw+/fhHISG
         pzBFidLnh5pj0hfJvO/OAD/2FnigLI40movgsSuH4SdlpOhlyJJllBM2vIIrRyfDH85I
         jsMqWNHxX0HJYqNIuZdoWVmIPWRqb8eKRufHDdrmbDvkj3ESOJcaK/15dR0A3B1+OrC4
         r3CJskVQi3pD+M8xYZmJLdCu/C3Xv0Upyab+0Zd5FxINWYbR/ihsnMjfNDA9cWhkE9Ki
         cK1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZWiCNk4SXPknrWq4yhagOrOeXXRq9gea6tQeZn0Pmy1kXgbTWHkG0gYd6hQUJiaab+tGU8zV++Cdutnkekt0KLbao5BEn2/w
X-Gm-Message-State: AOJu0Yyt+WDI2mNh86gT6AKFGXkC2XzVnQoW9K3V2CFEbjFLKK6EXwDW
	ypy/C1aqcoN4XmKACso3lSganDR+dnHp+zIpqzLpt3OebPVXXfaY
X-Google-Smtp-Source: AGHT+IGrvNI123vWJSNjSF27urRRDGCSmw+7i51AIdkARWNrkjb3GUiXJCx8/xx+T6mbeU7KeYm7Bw==
X-Received: by 2002:adf:ec4b:0:b0:35f:1aac:156f with SMTP id ffacd0b85a97d-35f1aac193amr1012237f8f.13.1717882363853;
        Sat, 08 Jun 2024 14:32:43 -0700 (PDT)
Received: from localhost.localdomain (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f116540d5sm2793247f8f.15.2024.06.08.14.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 14:32:43 -0700 (PDT)
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Eric Schwarz <eas@sw-optimization.com>,
	Olivier Dautricourt <olivierdautricourt@gmail.com>
Subject: [PATCH v2 1/3] dmaengine: altera-msgdma: use irq variant of spin_lock/unlock while invoking callbacks
Date: Sat,  8 Jun 2024 23:31:46 +0200
Message-ID: <20240608213216.25087-1-olivierdautricourt@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we first take the lock with spin_lock_irqsave in msgdma_tasklet, Lockdep
might complain about this. Inspired by commit 9558cf4ad07e
("dmaengine: zynqmp_dma: fix lockdep warning in tasklet")

Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
Tested-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
Suggested-by: Eric Schwarz <eas@sw-optimization.com>
---
 drivers/dma/altera-msgdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index a8e3615235b8..160a465b06dd 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -583,6 +583,7 @@ static void msgdma_issue_pending(struct dma_chan *chan)
 static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 {
 	struct msgdma_sw_desc *desc, *next;
+	unsigned long irqflags;
 
 	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
 		struct dmaengine_desc_callback cb;
@@ -591,9 +592,9 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock(&mdev->lock);
+			spin_unlock_irqrestore(&mdev->lock, irqflags);
 			dmaengine_desc_callback_invoke(&cb, NULL);
-			spin_lock(&mdev->lock);
+			spin_lock_irqsave(&mdev->lock, irqflags);
 		}
 
 		/* Run any dependencies, then free the descriptor */
-- 
2.45.0


