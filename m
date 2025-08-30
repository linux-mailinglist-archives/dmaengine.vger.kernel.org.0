Return-Path: <dmaengine+bounces-6301-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE4B3C9EA
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 11:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A573D568950
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878122A4F8;
	Sat, 30 Aug 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L49tdd/6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CE221271
	for <dmaengine@vger.kernel.org>; Sat, 30 Aug 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547400; cv=none; b=qN3VG5UvceAWvgIC5TopWoTJ6YKd/DE5tSwBH/VUH1Ny48q2AQ/KXYKrA0MMiAg2dcuI5vqzvfgSAQ0kafMQpW7DGMtxABgYSHnnKtCUrQA216nwyKn8dAj6HYgMW0O1GqQx9LxLu57vQGtH0nsfMu09SPc9ncV14vbWUxhDlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547400; c=relaxed/simple;
	bh=MhydSjpAwABmF/rCF0KsztuXi9gwym6dmu8o5mvUOII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/ND2vXorOzqlyhUnOM94M7zVAvZuhNovfUIz2yQWdgzGPzon76TO2pi1mqyYXpjfFi0xc2H+Ew3fUhMEk2apgA5XuTlSBGey9kKEZ8QImO48MGglcGc56iQHZA/qMpzZxBVfELtMgmQPtutFPYlh82/4d6KtjBzO1js2C6lIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L49tdd/6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f731a360cso17689e87.2
        for <dmaengine@vger.kernel.org>; Sat, 30 Aug 2025 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756547397; x=1757152197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRNROOHHAw2Bc/THJAy9MOJuP831ZvEwTWSfbFMLjGk=;
        b=L49tdd/6XCRK6SBM5NBertOUCHAhaX+AeNgZzWfPAn14t+pDP8QIz2IMuZTRksxmZK
         bjD0VC5TTzLz/hVitDT9EIdxz2iL1tlVKpbT2QA17BiKpEEHnMu5dPTeNw8Xh/C0gHwF
         4c7xKlDHjc/Doo9hXkxs0ncUpbAZ8uuP3PhSV2jH2JCf3m9WJYR2vpKt33O9E2ql8hBs
         PckSUziW3WrJdjt5f/3zex7/57sDkW/Zja/0IzhGVgscBN+Zub2GE7pYNMDoWQa1BRuO
         HwqCKdItZrbS9g28GwNPevlvcdRoFDoviKmQ4OvOA55tBMBxoS2qD/lAaDlAFUzWSAut
         lo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756547397; x=1757152197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRNROOHHAw2Bc/THJAy9MOJuP831ZvEwTWSfbFMLjGk=;
        b=nivQWBhogIfvQskqyz0UhYcWnaeC9NsB2Z+/PLhufNrmI4VFEXRGWl9/ziO6e166G7
         8sWDu3dnjsvma1JVHsL1mxfg9rpp/XOMECOqfIwM88BvjVnfgchy40JsfMSZBcr9IJIR
         4/WSCB6xE29Z0dx/sU+2/ogcz/r1RhnC9JyDB2YKEELW3rtFYDxdU3Om4HifhehIH7ln
         dKvFjohUUzX7Hf4lqWtDe5uzR7RanScPd9trho+4B251FrK6Uni1BRbXoREaZGDF7H+H
         Nw0fKO+Ri+AfKFsOpZjovXO8AGY0WDTC63gtWKiNEfQbCVLpeR435zfeRjz6bWbhRYd5
         2aYw==
X-Gm-Message-State: AOJu0YyqFd+eBMtY0WbxD88cWHf90jRSYu4vX5G5yiyR8YPbG4R/EX4X
	Dky4HVWZ6RXNranpyIMGlgXMcsfjnRuf8W6w2EZqxWqF7ldogg1u2u44769pu3XmRFA=
X-Gm-Gg: ASbGnctHG/p9lUdR1YQ/xtqVjKcNMz+uFgSTwBNU/Jl2K/lqN0Cvz6IaeOOG9RZKy6A
	XpbNAZPVmmO78TML68GYh0/gZJZBeaJsCos1Nq2Y9E3MoBbPexKh3XoS2s2MqDQozEe6dxfKMUD
	M7UKCpZnqDgxtp5MXdrCkhT0tFVH45tHBIlkS2lTDOdfyLU340UYAZzYqc1+nF3XuNaiLo5OS4B
	Wgjfj0oEynUism3ybDisfkN6588Ct+ja5eJAdmPMt5j94DsYRVQ8wQ2ovANah3Z14wWzLGLUHUt
	jL5y0GogfAbX+AG6i1XZPClV6k4XzBNverueGCsy16OQGGeoBAwcV8cvmRXSK8GuvtDRgw7V0ko
	KVJBGzCRCkC4cjrV86hwtYmeRGglVho1Kkd3ZRfNckHGhtGGA+F82tRVTYFgZ2/nGUI+H
X-Google-Smtp-Source: AGHT+IG3HJ4okzHDbXzyC+DgyjCqGWEYnjZkIT75Na3msr+BLTTBdvc2Ju4vaDO6zUBBUpv9efwGtg==
X-Received: by 2002:a05:6512:104e:b0:55f:612b:b350 with SMTP id 2adb3069b0e04-55f6afd91d7mr563621e87.3.1756547396895;
        Sat, 30 Aug 2025 02:49:56 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55f6784fdcbsm1325961e87.98.2025.08.30.02.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:49:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org,
	nathan@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	benjamin.copeland@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2] dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
Date: Sat, 30 Aug 2025 11:49:53 +0200
Message-ID: <20250830094953.3038012-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829232132.GA1983886@ax162>
References: <20250829232132.GA1983886@ax162>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a critical memory allocation bug in edma_setup_from_hw() where
queue_priority_map was allocated with insufficient memory. The code
declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8),
but allocated memory using sizeof(s8) instead of the correct size.

This caused out-of-bounds memory writes when accessing:
  queue_priority_map[i][0] = i;
  queue_priority_map[i][1] = i;

The bug manifested as kernel crashes with "Oops - undefined instruction"
on ARM platforms (BeagleBoard-X15) during EDMA driver probe, as the
memory corruption triggered kernel hardening features on Clang.

Change the allocation to use sizeof(*queue_priority_map) which
automatically gets the correct size for the 2D array structure.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/dma/ti/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3ed406f08c44..552be71db6c4 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2064,8 +2064,8 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
-					  GFP_KERNEL);
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1,
+					  sizeof(*queue_priority_map), GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
 
-- 
2.50.1


