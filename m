Return-Path: <dmaengine+bounces-5836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B713AB0B32C
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jul 2025 04:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5843C302B
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jul 2025 02:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AE7E0E4;
	Sun, 20 Jul 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBIu0Llw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA328382;
	Sun, 20 Jul 2025 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752978093; cv=none; b=SusQn0wec21qxvD2TOUUcXQ3krRL45QOGa9BI1agihG/z6EAiT/0+0mWvFfNaPr8FM3gufsewSnBGs0ZHdnFVC459NwoXdt2FfNnijg71QC50WZGtJHGE7u12V9e4E8/xBYEDEOk6n1RZnocKB2qeDfP6n3+9Pi0yIAgXxiPuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752978093; c=relaxed/simple;
	bh=hggDzZf3pokcQ15G96XECNvD2Szk1e/6quur3elF7i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBjdRtXUReuYSUs3zQNseFAOJL+fDqBAuC+w1HPXJtdltSZ6Z8l5JDx83/92VBLiIAZakr+3nII4OC4GIXvyVm2Ad38UHaRZaBYog/l+DhxLmdjV9s/MPEEpkVlqz70I9Chz1A3k8C0Cd4d+S7FMfc3ZaODWu7LhfJQ0VKbBa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBIu0Llw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e302191a3so30411167b3.2;
        Sat, 19 Jul 2025 19:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752978091; x=1753582891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=20X0PhCRcRj6aFiBuS5mrmdrBSw8ydwTa695mVAjRJA=;
        b=HBIu0Llw88PI827NOOYI3YHremADb2IP2z9srmBke0W7X9m4T6hN7B4rsdkFaV2ZRx
         UO/glzauuW4Xz6AV8/0Xz/wZdLTxb6UvkYPszpqxnkej+Jok3W7qllP6AKw8iTzgre8S
         58OqpmhAJbsQVfjRVOeRwuNiMwqArGZ5yU+/vH2zzKHgPruDyOVtQusJ1oLyxbRqU//m
         Bk2RlztjLnZk8by9Zrvt1UGj+a1vH6CB0a2lo97XMCpbk6RxcC6ky7nlPSQic5WJkB11
         yuW4OgIKu6dgzLdiT5koiQ51ESuE512tivsfG77tF66F/Kpmra4gCXs8wR7PmKbxiupw
         GyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752978091; x=1753582891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20X0PhCRcRj6aFiBuS5mrmdrBSw8ydwTa695mVAjRJA=;
        b=ZD8MJfmlATbMt9CJqPS89eDOAGMu4f23p5JGbXiHQVrnBsntjr5xCFgJZ056EWIktQ
         wSXHFdiCwCU/EWXQsBy/7InmiJwrR1dNm+UFIYs45S2SQ82UOKDGgxrzfshN3tcd7Z28
         l6e5i9YgmCHqvUdaVLNAiY3iWsBsBGBsAbH3Ee49InDO7hQRk9NZ1pZedKoDXLV/6thv
         hJk3LdCCc4iuT3EXR9i8cUjSf+Yfg5QOUwexkkHPzxNQZnFB5vVEEwjbhaVhBBbw8aRU
         Z3wJRrNsKC3RvvXLwlih3THsARARCD2cOA3jmU4Gqpy2ZofaV1kfO/KxGEsE27dbYuAq
         w2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAHKaLtf6l9P2fmdaw8mWS5OY93nh2i00g9vtHFD0GmK9mUdrKOhHqowjCkd2zm0wIbUVLPdAbMChNbCXz@vger.kernel.org, AJvYcCUq3dpTyiU/7VysUt7/Ud+a4tACprdxGQgdYvMwBgapIIstUZfzj4tuuaQzWcDZDzQCm0sV7+zc90c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHv/drtFBQ7/TKH9QxY6uCEiUf8IIHk/oTH3g/V1slj/AgRnNm
	wrEgXXe+eCCDMgwpX8j+fKStDoUCxTxIzKRIHP4wLaN4iYC9wChibbMsBuSYDQ==
X-Gm-Gg: ASbGncujG7qtklIGrU6g831AdyyKcb1jV6+oIDgwgPmjHEk6Ygsat7M9lUNN8Q2YwqG
	M5/5D75dStMAoDxU78yE7Cr+Hwtpudb0WXEhBFhXJLN5rKThFreVWZifOm6P4Y035ga7TD6UaOh
	kcucMus0UgqFe4A0Md0rZiSgxBeUjvMq/z3i4TQ3EJKY4+v9dW5fGW6e/6oaJK3+AjX/QsfxyFh
	dN/SAs8WoztYprrOYV+TeMKMduemdlXZsIA/grBBcLtduR8lKe4WSqcQOMlLirgwB6eo5oWZk7l
	R5Jl/NG8eq7dyBUYvYl34uDDYg2Gp8DDnFKF5Dm7LUelzPtcR1IY1PjmDQrRfKORB+GevyoVvH7
	3P80F0y/bHw7uz6vf5wY7nXVwhESXzV+Rt+oCXNqHs4Pc9lKu7mpDMQoKROTeLlfCScaF
X-Google-Smtp-Source: AGHT+IGQeBqt1JgArpYmqU9CC64rnAVFyPtgmr6zEcLd7fPQHv+Rm+/NeKHZqrBKHF8zawaTftE66g==
X-Received: by 2002:a05:690c:46ca:b0:70e:73ce:80de with SMTP id 00721157ae682-71835185a29mr205173357b3.25.1752978091242;
        Sat, 19 Jul 2025 19:21:31 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310a968sm11599877b3.2.2025.07.19.19.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 19:21:30 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] ste_dma40: simplify d40_handle_interrupt()
Date: Sat, 19 Jul 2025 22:21:28 -0400
Message-ID: <20250720022129.437094-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Use for_each_set_bit() iterator and drop housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/dma/ste_dma40.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index d52e1685aed5..6cc76f935c7c 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1664,7 +1664,7 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
 	int i;
 	u32 idx;
 	u32 row;
-	long chan = -1;
+	long chan;
 	struct d40_chan *d40c;
 	struct d40_base *base = data;
 	u32 *regs = base->regs_interrupt;
@@ -1677,15 +1677,7 @@ static irqreturn_t d40_handle_interrupt(int irq, void *data)
 	for (i = 0; i < il_size; i++)
 		regs[i] = readl(base->virtbase + il[i].src);
 
-	for (;;) {
-
-		chan = find_next_bit((unsigned long *)regs,
-				     BITS_PER_LONG * il_size, chan + 1);
-
-		/* No more set bits found? */
-		if (chan == BITS_PER_LONG * il_size)
-			break;
-
+	for_each_set_bit(chan, (unsigned long *)regs, BITS_PER_LONG * il_size) {
 		row = chan / BITS_PER_LONG;
 		idx = chan & (BITS_PER_LONG - 1);
 
-- 
2.43.0


