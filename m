Return-Path: <dmaengine+bounces-2254-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABE8FB32A
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 15:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D1E2834F7
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095E146019;
	Tue,  4 Jun 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1NncuGe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B93144D2E
	for <dmaengine@vger.kernel.org>; Tue,  4 Jun 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506439; cv=none; b=Kr3M+dAr0j55Hv3bCtoBnoJE4QJ9WcEATPGuOsU4peN1JSE8RW9K6dQ1MvEvNAyFUm9uviH2OCjp/XLxA6pL6E8tleQbflrQHfv47sr5sobqdMlYdfPqkk791ulBk82CDzRwGJPhdKWTB3hEKhJMjzGFaNVbrxfXmQDTltTRUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506439; c=relaxed/simple;
	bh=L2/y78fs3Ls4EwfkbLjyb/X63FzWFtm4d8pkiRLS8Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNR/HpwXwPFe4pazRc2zIr8nerJMfLSwCMAB41Gm5aLMCpRaneFMdvjYaae90F2XVwnoBlsshSas+tzqv+i+oeUmeiu0Vb3RnPCHXLLfWSp2yNJL6REJcyzojaV8nsuixRoQVf72PPA7gLWQKIJBKZ2ZSoq90kKCiKSUGUUS+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1NncuGe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b9dda4906so2211244e87.2
        for <dmaengine@vger.kernel.org>; Tue, 04 Jun 2024 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717506436; x=1718111236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JJxWa/1zoPOcHlTccLV+MlOQAo4FcwAYphEzwxysY0=;
        b=q1NncuGe7l5VMjnvjp8md7rszgcX3WG3XtXesb++Z5zVZJagh2Zi8UU/XL4fOyv6Hb
         2LHCK9cI1kYgui+vyro4jXxfTR8vdVzSUqUhsonKdBDMRqNi+cPxYihk0Rl7qByES3Mv
         exUtaLFdWYbguR36Bn2qiQ4xFEAJCnHXxd5bA9Noz641f7gSOb8PVAaWE/MlHOIPLQjx
         jAwOHqUhYbMJuOjpNAiNzSb/Vo+kz1hhoPK39iO77IeRGEqFOsfW0+t9EkjNM/7EUWGn
         b7gO4p52XZ1vMRlpyx131D+Yf2jzG3ffu/h9out+mqTqs33xBeIs4f4HSVQic8+1GHaH
         bFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506436; x=1718111236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JJxWa/1zoPOcHlTccLV+MlOQAo4FcwAYphEzwxysY0=;
        b=cBzT7Y99QLYizGKD/0P/kdjjuKGZbcGHRNb7AZ2zop5+PCh2yAKvH2H1YOhiZuo3ig
         pFzrtXkHvl+mpMPR8pPQcrgApkfpp7A8Hs5k3QIjNjYJRozyt3qAwpwW9gSCuU4TAsMd
         Y+DdS8XlGvAaKAn4JexZw5aYNCI/OuJ2f0R9kZNs1FZjGBz2ia5ySNQVI8KTZdj0f00J
         tT9WlVXUJy7b3ECbEwWCWpPTQZRqkv5B5HHiMMYnOZvlp3aLBKvN8uPg85JZWU89/H86
         n4e9JTih9IZuhLEwSJL03/Uwtco11w6oXOkXzpokfZVBN3Ux/Gf2F9EcgFOiLufWJgrY
         ozUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUCB6hZ2LE3cL3tQi04BH1UdkBUzga1Hj2UmTraIiWNP9qt3o0/38JpChj2Up7CCLfbiaYEsQQnZhpWnuJsriNGuPd1B0vYipq
X-Gm-Message-State: AOJu0YzvWub03zUTBCcNKPE59E9/Rn6V7fDIipBIRpFupQQjgO+eoBNR
	wr5xRJbxKCjVnZYoi3NnQxhEDRQ0GfcPmo8jmyximJrwYRKZFAiXcl3n2oZFnTKSAD3v+t51EW6
	EkuY=
X-Google-Smtp-Source: AGHT+IFmOwVhp5MCRgtqHuZ+/NrUtbmCP/7CKOxeR+X4MTadpuAQolbr6ss96NjVUrIKAcClNYifhQ==
X-Received: by 2002:a05:6512:3599:b0:52b:67cb:280c with SMTP id 2adb3069b0e04-52b89573691mr9128600e87.18.1717506436352;
        Tue, 04 Jun 2024 06:07:16 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064affasm11516562f8f.106.2024.06.04.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:07:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] dmaengine: ti: k3-udma: fix module autoloading
Date: Tue,  4 Jun 2024 15:07:14 +0200
Message-ID: <20240604130714.185681-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6400d06588a2..d7259caa0200 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4405,6 +4405,7 @@ static const struct of_device_id udma_of_match[] = {
 	},
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, udma_of_match);
 
 static struct udma_soc_data am654_soc_data = {
 	.oes = {
-- 
2.43.0


