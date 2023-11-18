Return-Path: <dmaengine+bounces-152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA37F008C
	for <lists+dmaengine@lfdr.de>; Sat, 18 Nov 2023 16:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E362F1C208CE
	for <lists+dmaengine@lfdr.de>; Sat, 18 Nov 2023 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618C1BDC2;
	Sat, 18 Nov 2023 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLM9Ml01"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA610F5;
	Sat, 18 Nov 2023 07:51:25 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5c6705515d8so20371277b3.2;
        Sat, 18 Nov 2023 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322684; x=1700927484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vgDBzQP5sgQpLZgXf8Y/I5f9ETKynbv5QtuyG4UrSA=;
        b=NLM9Ml01qJ4IkgQbv+Ri2+76QFWWzLh3mkWpi2OMleBF9fCxNnKV5WDc06aryh1ZCn
         vgOHDqjT7TWl8ljXxWzhEk3nj/Rd37oKoCseY8zyOTDceyspJJZJLUMxHczflHr6WWiw
         Deqd55futvd833FMrWwCkW7ijwTE1YzqyTTnYiqV7sUY2VObBW7IK/Yb/L3r+4qtbuSD
         lGs/RspReC5DpMizaE+J0JUaIJ99LGvfX/+urpzt4h3ltI6Sop1MaPpEmGu+q/dLMQGh
         ig5sveUuNKNUpxCnyXMTgAGx32LMQxZLI/Rsz88fRT36Sfd/3YlkIzw6AX/ru5Vxgku/
         SJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322684; x=1700927484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vgDBzQP5sgQpLZgXf8Y/I5f9ETKynbv5QtuyG4UrSA=;
        b=oMZ2QVn4WxpBJ5vMypY2awJI3IUtglNe8gR6mNOxIkxy263dtx1wKXYhE5j5/VhuP8
         7A6Gz7dHzS6QZbbrYzvJfwgdoLSXBIfrUwcbx9O7QWSuA8Y/nA0veHz/CLXpx2D39ipW
         81j1mXz/B1WVkhHlTeHIet3MHRENMF3hFJQg+EiHNYVQcj6VtnHTuHZQfGWYz4lOKLhB
         Dxw1eg1ZT5t9LT0zt/XODIYHvdUv1ZonCVmx1lDXywfTIvZso7SNIk6Myr3XvhJOUqcF
         nv/UqMRagQVx2CqWcbqlV3PVSApHF/OPVxThZfQvcYnzkAzfGhYJ41X1dbn8FFfVqHxP
         mdcA==
X-Gm-Message-State: AOJu0YzCOvVbW5kpSYk52bruo/clHnp9aJNaVqjyXPUBPzocVqsNUJ5A
	UnJmYkW4h01GOgI2UHB8hsXumyjjWavZEoWM
X-Google-Smtp-Source: AGHT+IGKUabWy1RoWpF0AivPJpAkOwQIu7XshCT/EYgQUvHZZdNmVZ1HNLqdDOrbGznPbsb+d6S/4A==
X-Received: by 2002:a0d:ccd4:0:b0:5a8:7cb2:15d0 with SMTP id o203-20020a0dccd4000000b005a87cb215d0mr2911801ywd.11.1700322683795;
        Sat, 18 Nov 2023 07:51:23 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id j63-20020a0dc742000000b005a7d9fca87dsm1157680ywd.107.2023.11.18.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:22 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 09/34] dmaengine: idxd: optimize perfmon_assign_event()
Date: Sat, 18 Nov 2023 07:50:40 -0800
Message-Id: <20231118155105.25678-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function searches used_mask for a set bit in a for-loop bit by bit.
We can do it faster by using atomic find_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/dma/idxd/perfmon.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index fdda6d604262..4dd9c0d979c3 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -134,13 +134,9 @@ static void perfmon_assign_hw_event(struct idxd_pmu *idxd_pmu,
 static int perfmon_assign_event(struct idxd_pmu *idxd_pmu,
 				struct perf_event *event)
 {
-	int i;
-
-	for (i = 0; i < IDXD_PMU_EVENT_MAX; i++)
-		if (!test_and_set_bit(i, idxd_pmu->used_mask))
-			return i;
+	int i = find_and_set_bit(idxd_pmu->used_mask, IDXD_PMU_EVENT_MAX);
 
-	return -EINVAL;
+	return i < IDXD_PMU_EVENT_MAX ? i : -EINVAL;
 }
 
 /*
-- 
2.39.2


