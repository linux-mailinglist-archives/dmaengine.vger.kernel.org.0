Return-Path: <dmaengine+bounces-4015-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A10099F5C22
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 02:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B82C1891AD5
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590C1E86E;
	Wed, 18 Dec 2024 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="zzPtpevI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AEAD31
	for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484530; cv=none; b=jzt1bQuvbWp7pU9nWwLtrRIedBjRIZ8/UCwOQLaC+MW3Ops30hQMEOiW9hk2QDqWhfNqyatI2GfTRRIyISI+MFfOtsvShJsciP4TN54EsngDfZcdUYPpGb8TcVa+frlM0fGNkjRfQ8qhHCH4Q5u+vltPdJcz0Ca9PvhrRwYn6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484530; c=relaxed/simple;
	bh=nL2QIS+btP/0/DdDhS4pfhsQQtaBEYd5pPYGrFwUqYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V4lfCiQThmYjnbXCibIvE37xeR3eFah+WS4tlsFxm4JufmEZ15f9V3PKcFYTVfGcWZSW8vbf1Zb3dwJZaY6CRkKvmF2vDAjlvOYHAxO5/UDfj530gJ0m3FKnugVWM9qHaG3xas4/q99z0bbYGOHs6hYy+lQ/mGJj0n0IldWE3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=zzPtpevI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728f1e66418so5199548b3a.2
        for <dmaengine@vger.kernel.org>; Tue, 17 Dec 2024 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734484527; x=1735089327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7W4/eD6qTNJOxDN5bkQUitjlqiqzRmxq4jQTLuIGko=;
        b=zzPtpevIz2FTZ50ycifK4yWYD5ioHCqp8zSjrtOXJb4JaUBJXxJcN0Ln1pMa8x4kIC
         YplS9cEBX/QpFeK0tx0SJKWawk37hWaDdLqMOFFuzwZ+duV1d2t5bYk/rYrEjLBe2ztO
         zpExWAUq3ZE6/Gn42WbIvh0J5o+MQKG0JdgCc6HyznTYISYLKad9KRQEHabEVcLHKJFP
         96uv8Kv2M82h/gzwhgIsvCDLW+ecgWynGg9Wkhgha2YgEBVJHo2PUfOl9NlyHyQa3F0d
         ba0V2eVdpUElPIVnVxndYgJfRSm3cZb41KtZdO+njaLTZV1w8bVV/TvG290VTYWd7GTQ
         PcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734484527; x=1735089327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7W4/eD6qTNJOxDN5bkQUitjlqiqzRmxq4jQTLuIGko=;
        b=tQImcjNaRSiJml4AGLW9GnfhF/1BkAPDMb4q3b8P10+txHForgfWZvdAKf0kXjD1/t
         g7fYWjaSSlDqVyTkqk2JM07hyqzNn11MIwwniZGBh7C/63hjLhAVQLtiGrC0wPoX3mKA
         uKLTP1wj4SvkOVXyCMAsBUMTdvrTNEpSeAPU+a6NV0zJkm6TEkj9OoitcZ4xpJWXkBlk
         D3IDzw9ycExArtsfanCEjYPIeUVKRTNm868jAG4ADq8vOpAf+qGbrW24Nbr7m6QqzsYp
         A+ZZpr/UOiTM7+rYmF6xKWZUCdSE1qWBjA+t2S0AkVSGDTDMrLBp+uAxPsO4FiZm1U5b
         j0Iw==
X-Gm-Message-State: AOJu0Yxh6fY4alpjSOU9OG+edHH5XUNGM32GN4Tfw8USeTBF4j6jyV+4
	PovUk8daIqNYvnH+/G/XO7SG+KImDjuhy+5OM8OQzs5J1lyqUB9abquMl9+s0Lecmqej/u0zQBh
	ZSOjt1A==
X-Gm-Gg: ASbGnctP4oqdge2rWTIICX5/4xJcp/Fl/raNo2jc6ARbrg5gcSLgZk7c82pMji+wSQg
	wIHrr+J9IQBPt3AYjqSmvMt1o6Z6dbJe3F3iRno+//JzhKCazzmFQge92Gk0/Yz5BS8j5OlC6XN
	bNYiphVW8jvyY+NLFFD4tAJlKyjJgO5k9hGxiJ/0+dO60z2D9I1fUj91i3zUw6LVNi+dm4k3jcd
	G9vyog+5G5A61w7PlDSKyoEHFkZuRB96MreomCJJZcr0zb3UYq5kS1Vyz2JyKxLfFxi7/nzJ77K
	YVM96kbHOhvp6sTlooXRC8z4r6fVjoMImaYoYcH1ntc=
X-Google-Smtp-Source: AGHT+IE2sg9XNqlj87oIcuMIZW2XlwvIUMml00TEHpdr6EwXF66HBS4MYrYSkTiQdh3kPM+uio7mHg==
X-Received: by 2002:a05:6a21:328b:b0:1e5:b082:e38f with SMTP id adf61e73a8af0-1e5b48a6f7dmr1984822637.45.1734484527162;
        Tue, 17 Dec 2024 17:15:27 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f0esm7579538b3a.121.2024.12.17.17.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 17:15:26 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	dan.carpenter@linaro.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] dmaengine: ti: edma: fix OF node reference leaks in edma_driver
Date: Wed, 18 Dec 2024 10:15:20 +0900
Message-Id: <20241218011520.2579828-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .probe() of edma_driver calls of_parse_phandle_with_fixed_args() but
does not release the obtained OF nodes. Thus add a of_node_put() call.

This bug was found by an experimental verification tool that I am
developing.

Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v2:
- Get rid of the .node field in struct edma_tc and put the node in
  .probe().
---
 drivers/dma/ti/edma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 343e986e66e7..4ece125b2ae7 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -208,7 +208,6 @@ struct edma_desc {
 struct edma_cc;
 
 struct edma_tc {
-	struct device_node		*node;
 	u16				id;
 };
 
@@ -2460,19 +2459,19 @@ static int edma_probe(struct platform_device *pdev)
 			goto err_reg1;
 		}
 
-		for (i = 0;; i++) {
+		for (i = 0; i < ecc->num_tc; i++) {
 			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
 							       1, i, &tc_args);
-			if (ret || i == ecc->num_tc)
+			if (ret)
 				break;
 
-			ecc->tc_list[i].node = tc_args.np;
 			ecc->tc_list[i].id = i;
 			queue_priority_mapping[i][1] = tc_args.args[0];
 			if (queue_priority_mapping[i][1] > lowest_priority) {
 				lowest_priority = queue_priority_mapping[i][1];
 				info->default_queue = i;
 			}
+			of_node_put(tc_args.np);
 		}
 
 		/* See if we have optional dma-channel-mask array */
-- 
2.34.1


