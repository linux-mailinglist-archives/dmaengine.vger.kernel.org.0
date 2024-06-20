Return-Path: <dmaengine+bounces-2456-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FFD910FE0
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBAD1C24306
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416991BE24C;
	Thu, 20 Jun 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW2+F/2z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE521BE23F;
	Thu, 20 Jun 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906259; cv=none; b=YvWy5ZD1oUhuxW4/xxUlbbVp8J4QGhGbIcFs8NXp5uEI7s0+qSafFQ4n8f4b+b3BZPPSKRDmbbPLke438mSqcPIQSsMXdJ/N+i42HMfWTQnbbY57SdQiTZ3iiU2RdN1OUSJ5N1K8VGTilwebqF7ZAb315VQkYsumMnhCPj4SXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906259; c=relaxed/simple;
	bh=z4fUClb8dXuu+9jxRPnwJI/cA/pCMiUgLCw/o06uyx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeaeXwCBNs+AmV+3QgiTGNHEUMxIHJ7uureN6F2bcz66tI4eAUlvmYzFv7HRmraLXz7okCcrmJCbZkAXoFv+TwxPGwpgIUskSO7whD78T/TO0KqPY8RnbwF428vySx1VHgoj8y8imgPXwZfcHO8vNuvMthpy8zBBLnRoIZC+AEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW2+F/2z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9aa039327so10177265ad.2;
        Thu, 20 Jun 2024 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906257; x=1719511057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S217yThdoIjU6QeboD3InxZjcbGcSzSpB5H/7IT54JI=;
        b=RW2+F/2zWMGQqFszbWwyd3img/QWoXlD5hZNpcP4AlE7S8GcAo/Zu+fbnLrgL75OP3
         sW6h7jSEp1Ja02h0b8YEo3PYYEwdMWjhHUyFyl16kUs5LU+vaykGzgCYIkd+Ie8vZJ21
         zyYvUBj/RTmf2wDmDZx62ETIJkEh1Tmja0z8aHX+Yq/C+wszPPkmARTewHks+RGZv6/X
         zu0XXgokWU+6zVjWqRaspMcGvgONFFDwy9YXQ9tMXzC3Kyj3BCHyDQ8UnyDkBj9XdBYk
         3lfaMZ78uXIzCF+sEvSWfNHCVIH9pf/Mzs2oCZOKC4h+gHcjNnkPmWlnf/gSb/XH8sEL
         wFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906257; x=1719511057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S217yThdoIjU6QeboD3InxZjcbGcSzSpB5H/7IT54JI=;
        b=OgOJJ+5Eer9yHAoJZLmKk65ka7B75LtRr1WbXZPxkIRQNkMd9dvbVnjwyKJGLLkFE5
         VWr7iMqLwx8bQkGbuiPEcX+5xob8bH3nEBwZzgWZFWvuqf5duAIMGeywvsyN6hxmNDSe
         PHpYLqx5I5K0RH1k5ydBn4yhHja6cU9bD0Ue/VS0JjCjK1D4NtaL2cSvOGApcwHwXNmI
         T709gqOq7gyucPds/L1fyfWIaH6HSvhYZ4YDgOtCTuGyvr1ALJTDz5ANAscs0T7Exwxh
         1mAoijHaeOieNI27TL1L94v6BbCpPOqLZQTXa2ruLYQGbwxndLlewmaaV1K+GQgFa5qP
         o5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV+aDMqmPmf8DRiZkrvONwCL8hjTqTi/Fq0FT6b6zilwlVZbfboNtxEc2D7z9YEgdw+NSZyGkgWG90Lb2f1q00JoCPsSpKHqTH/
X-Gm-Message-State: AOJu0YyS4nyfMJ/ALdURHt5xLRs+5FcL5OQcoUz0norqAKXF1VqMCEIp
	vBkdS9Zp1kzkixcCwIkxvrrY0kch9apgaCCDeeRqUERsRg3oG7IWZMWeVPmdmyw=
X-Google-Smtp-Source: AGHT+IEsuBQgU5tFbCUFweOZuFt81ozFdug3U9h5V494KH6XT54Y5Mu4sLWTPUs8g0qHcojBfwlzTw==
X-Received: by 2002:a17:902:ea01:b0:1f6:3445:3437 with SMTP id d9443c01a7336-1f9aa3de130mr63778435ad.27.1718906257091;
        Thu, 20 Jun 2024 10:57:37 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f5e72asm140359505ad.308.2024.06.20.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:36 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 10/40] dmaengine: idxd: optimize perfmon_assign_event()
Date: Thu, 20 Jun 2024 10:56:33 -0700
Message-ID: <20240620175703.605111-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function searches used_mask for a set bit in a for-loop bit by
bit. Simplify it by using atomic find_and_set_bit(), and make a nice
one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/perfmon.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index 5e94247e1ea7..063ee78fb132 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 Intel Corporation. All rights rsvd. */
 
+#include <linux/find_atomic.h>
 #include <linux/sched/task.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "idxd.h"
@@ -134,13 +135,9 @@ static void perfmon_assign_hw_event(struct idxd_pmu *idxd_pmu,
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
2.43.0


