Return-Path: <dmaengine+bounces-6293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B187B3BC46
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 15:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CEC5A0C52
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E86A322770;
	Fri, 29 Aug 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixg87rgR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9E322529
	for <dmaengine@vger.kernel.org>; Fri, 29 Aug 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473242; cv=none; b=igJiTqsRN+XBeuk6rC2VYGiMBm0xbnAFuhZkBhslSbq4N3sS1cSHVA3SaqyTejiy1NeT7FULf1ZFIbZrshG6bRvHN5JkU8tE+jGqb8uFhQpIVUc6naWlUzSbeKa+XaouJNh45aoudAp+V7RLITomaDwjUSsX+Zdxax6O41fWCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473242; c=relaxed/simple;
	bh=jEDrWRqVtKULrTucTSLr0n/DeF/H+SMQdH2t6erHpwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwQPjoVKA5bXxNpDxegylhGobvWJdBFc4WtbbrLQtYFzFvKpecmUjGxNNxi310HrIYtGhslPV9AoEHuTkFnY341hKOw3lHCQQ2nMfkJYZtuICVWL8pfTid6Wt9OIgXm6duT+kM3p5q65S0CpeMA0MwTefNQAPW5C8kOENS/EHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixg87rgR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3357e082402so748761fa.3
        for <dmaengine@vger.kernel.org>; Fri, 29 Aug 2025 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756473237; x=1757078037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FE9Jl8MLsGFXC4bdNsn+0eHbgCcJaZ4UJYq9PxJ9Nrw=;
        b=ixg87rgRVcKadRFH6hrf2zLsYXOOyQFv49peJ0OnnRCToTXNzyG47yQdTgTwY4JMlf
         l81WyqLAooYLKsj7J+KuKmklqZljZ+9yYy3LEtNHag9xkjGjpLxABiB34XquzMF6XPYA
         /PPgSNuDFDz61IZ2eWsoZWHydeKtjY6+Kzgkg4p6UK+mImuLsZJ4/Zl59wXcsG4an4ai
         275UAMoexefvpHOAQ9Psr6RWkf/s/2JBoLwJk6Sq9YN3KlW4wDVAOTs9YOk2+897md+3
         dfjjGNIObZkzxQtlvKN61AsGIx58RuC1JDZlA5Nz70o0dbyHMxhphnsebGYkecPEUccP
         EBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756473237; x=1757078037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE9Jl8MLsGFXC4bdNsn+0eHbgCcJaZ4UJYq9PxJ9Nrw=;
        b=bYpDUbkJo3kuDfCwqXqvFac2055AnTlcO9nlNnoWdKOV7J2C8YK4QcJZMpndsZPawp
         LQndPI+BFKJLrUluKorvVvXasqz1+OtQdkn8Ml5xwE4nkbiPeOMKME8EXrUiD3KQHD/7
         1um4VLQGh3SBRRNWiNGFifrXiBuCakOFYjq88/SbyxoZwvWFYAW8/XcjKj49VfCg2jk1
         RpKu7g4eR7ajfqQXEQsOwVSFvMvGjUzIgt1BYd55BmIYMKpC14Z442m+Cd05npOo0j7q
         n+WLLBZTvdl9Iulm1kcVmlINXrDkqgNeF3BlHCD8wvaswdi57yM7xD4B7jfHom8TpiZK
         jpbA==
X-Gm-Message-State: AOJu0YyhdZDYtzqKmctt0C/f7bha7LY0sccH8N2WE9VMALQi7PITcd5T
	8sGOBA1ZgL5BcgwK8n0AMEoFDStJJjvXiED5cIoF1MZhrg3Xr8B/n2qU+eLsoYPX1QQ=
X-Gm-Gg: ASbGncs5y0o1i/PNUs61trPwfeYyx1RErtCbR0oz6HAMXD+6k5eyjhL/LQVwaVm2NY7
	RURvSS35uUBf2K/RzMrOigwCWtZclb2KOeWHsCbIqjZS72O073uWe+gEAxoeetnSYnZcMVQtKdy
	aZsy95nzSStraBb9ri5wPjlA5XEJKl7Jys5L2OClI7szIDI27lutqZVW5MVjzhbLl1MrpO5MRzw
	FKGEUY5p8HBvdN4RGUqOjK7pNY4aNPGBgbJmAuoxwf20I3RXJH/nI546Xd4EdiaoR3Vt5qcuOrZ
	xrM9HSJdVEwkIELabkp1jwR+QGyJtDRlolZwtXRzPxgJY1s+CVa+GGhXR3OuwRkMIL2O5BteUFe
	OMNbZp7yxUwKr0LBzHmx2bQiQWjkxMQtoWGaqQEkJJAnS1HMbbRaBc+ZQHLYlzMAKu7SA
X-Google-Smtp-Source: AGHT+IG/8Xqj716iiBt/qchOr1OFGqPi5/74id2OSt/hQJFdA0DdakhT+OcqxRtL9E/IhDxB0ZX1Dg==
X-Received: by 2002:a05:651c:2121:b0:336:a73b:b605 with SMTP id 38308e7fff4ca-336b8da6293mr2896991fa.5.1756473236831;
        Fri, 29 Aug 2025 06:13:56 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-336b489c487sm4641041fa.49.2025.08.29.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:13:56 -0700 (PDT)
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
Subject: [PATCH] dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
Date: Fri, 29 Aug 2025 15:13:46 +0200
Message-ID: <20250829131346.3697633-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a critical memory allocation bug in edma_setup_from_hw() where
queue_priority_map was allocated with insufficient memory. The code
declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8), but
allocated memory using sizeof(s8) instead of sizeof(s8[2]).

This caused out-of-bounds memory writes when accessing:
  queue_priority_map[i][0] = i;
  queue_priority_map[i][1] = i;

The bug manifested as kernel crashes with "Oops - undefined instruction"
on ARM platforms (BeagleBoard-X15) during EDMA driver probe, as the
memory corruption triggered kernel hardening features on Clang.

Change the allocation from:
  devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8), GFP_KERNEL)
to this:
  devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8[2]), GFP_KERNEL)

This ensures proper allocation of (ecc->num_tc + 1) * 2 bytes to match
the expected 2D array structure.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/dma/ti/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3ed406f08c44..8f9b65e4bc87 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2064,7 +2064,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
+	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8[2]),
 					  GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
-- 
2.50.1


