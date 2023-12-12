Return-Path: <dmaengine+bounces-473-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D080E1C8
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 03:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3941C21746
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069682104;
	Tue, 12 Dec 2023 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeT0ewIv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57808DB;
	Mon, 11 Dec 2023 18:28:10 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5e1a2253045so6490097b3.2;
        Mon, 11 Dec 2023 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348089; x=1702952889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PPaj8bONHO84DcPLdZn/HzTWIYQqNGS4xiypCmsJDM=;
        b=EeT0ewIvIPYinBZYW6XCaUORYpOhz3jr3Z0GrxT/kf4OVCroVDB6tyMkj66+RRHzqM
         YmvftBXHOj9dQ7XYG6QcYxFMG1HCU7CZQm1kbLG0UTskk1gvX4myd+1PFk+et4UjnJWl
         FJZJLN6toQuu2l/jvRqfJsqEOtQT6x5GIj49i+Z3kLh+i49OOQmwzAhOHUlRv9p0EiFF
         UYmsEYTj0PdAGEMr6mWBrPqi7nZj28KRJ+jETrJ7YBuslj957L7+BD7Vi58dLswi9VgO
         suCPXi+W6taNzRlhJrJGGj+J2RLZmx8z1zeDh1BVT9sCrHX2bKTEKWIuMmFjWs4UIq+N
         5/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348089; x=1702952889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PPaj8bONHO84DcPLdZn/HzTWIYQqNGS4xiypCmsJDM=;
        b=B1GN6upNiIbnwH5D39OmDD1HD+jr+oyM1RFtgE+tYs+JyoNf5BWWY6W3AlKuTJ5dPh
         Lj7d0frHanBn+v61bexfqzIbdbKhMS8nSAzrhsfma9Cx0KMq8TJNKtasUXnMzc4M2P+q
         S5RlnlhMYTfGR3+NtZlI09aikaAdqPXQkaEIWQqUH7/ITxMUIYh0PVyZ3loEqGRrkqBq
         r617LQw2381cSyRD1mVZeDDZJ8EpGYWO+5nnmNt47leCx3o6othkkmxoeuQ5NOP0EU/L
         XsHfuF6PIga2rn2JtGIOrJdgkGzxps93VEeiAklbxq/95B+jVI8W73eE5jmW/X4Gr0f9
         WT8Q==
X-Gm-Message-State: AOJu0YxmZMuGuOQXLj5f/mABk/AjDzrBOufgfoTNR4E9X5PrPXjchs6/
	aZR8+dU4h/DZc+Kf4Ex96jL/dJr519Vm9w==
X-Google-Smtp-Source: AGHT+IFfVJcg/DUfJP67/YgD49DyRzNNSoiDPbtETNKOnY44IEAlaTBX9EewmceS0nAr7MYstmZuAw==
X-Received: by 2002:a0d:cc8e:0:b0:5d3:8400:ba9 with SMTP id o136-20020a0dcc8e000000b005d384000ba9mr4160620ywd.48.1702348088892;
        Mon, 11 Dec 2023 18:28:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id u13-20020a81a50d000000b005cc8b377fe9sm3395652ywg.121.2023.12.11.18.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:08 -0800 (PST)
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
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 10/35] dmaengine: idxd: optimize perfmon_assign_event()
Date: Mon, 11 Dec 2023 18:27:24 -0800
Message-Id: <20231212022749.625238-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function searches used_mask for a set bit in a for-loop bit by bit.
Simplify it by using atomic find_and_set_bit(), and make a nice
one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
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
2.40.1


