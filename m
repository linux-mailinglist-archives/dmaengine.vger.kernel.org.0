Return-Path: <dmaengine+bounces-4027-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9340C9F7276
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 03:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2723160CE2
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 02:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A13594F;
	Thu, 19 Dec 2024 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="kvESEiWp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520EA31
	for <dmaengine@vger.kernel.org>; Thu, 19 Dec 2024 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573922; cv=none; b=K0Tnutx8gBoHhrfBkwPNBzITNIdHZ0xvv3FGAiQXY/WLJydsdyS/DhVRn+rOO5cIG7HM95i3kEPxX9K4l7JqzJOUmrRsySidsgG/aRycGGS/F2x2pppWsf0pgxsE5l7u+jifZRC89OJdSYfkFO4+8C3zSVRK3E1QZ3l0XUkf8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573922; c=relaxed/simple;
	bh=FZI9rPP8jacAFQfSpz1rLRfbOEae3k90QZ+3nug9ti4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7ZM/5kWOx34AVMrV0hnBsmBm9Aaq/WHMSzPPFgNPBfuokQ41DP2/V1rx0gKcaqqiPr9X4+zY7HY3OPG0yEtLTbCyVXGy0DCO17OoEWy1dOp7XMk0PU8mPJlTSQNr9csH7pSRpVymRG7sx4ubZ8CJXlqhA7M/du5AMcTOdDawxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=kvESEiWp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725f3594965so241919b3a.3
        for <dmaengine@vger.kernel.org>; Wed, 18 Dec 2024 18:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734573920; x=1735178720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g2cgfG+Z+UFYkuXzTgJjjXI+inqDjm+x/J97fYCAP8=;
        b=kvESEiWp58+BIF4hhwzy5MO5VwqcQQEV3Rpc59VnDiTOkLE/qePJv5qZFcQeMz2D5D
         wr50ivLrSW+gtwhN1lT1GPylm723ReMHy5WbLupxy0Z2Oz5FjhJ2qN53lDGnwh17hAPW
         jd+TyofBqKzjRHfM6Vg9nFFrd71DkFM8O3goy9J2FlCkzTUSv6O/dVIXiTmaUJIFtSNq
         d8jim+DUuFt2Wf86mFVcabhqAJ3vV/huF2gLG4jynYqvHVGde+zz3vPP32yGUqR7F7L/
         7gFnUBT295UpOA1NSxeuSvOB+AJCVlnNnYLvQHYpgD7g6NWHn6j6G+7c5xOYalKjhr4X
         87Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734573920; x=1735178720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g2cgfG+Z+UFYkuXzTgJjjXI+inqDjm+x/J97fYCAP8=;
        b=qXl0NbPPK++piHuk7QItS7KKe3SABafXxmKioC8NNioFJCszrFp8J38Pyy9XCnmaLm
         D6PB7EVAPAMZ8zhd/9tDDwk7t50lGhyqUn4QG9FqEi/+Jw4gtpP1/pb1iKVFQA4WT3k7
         7TW1oFB16o3wwGPEvRRyq7mBU0Ep440WHN2A2rNzlZdEJ5gfiYY+DJwviYnpLxzOiNnE
         mAIn5IIl+fVS/+s3stzLtjC115RcwBps3IeWLpO2IX4zZJkJYqnaXSz5g6c6vXqPlZGB
         sxstagLxQ6r2Xa3hYM8l74bmNpp+JbOTRbpFV+Rb6hvn/DFDzBltYHe0Tn1SUkqdcV0t
         vECA==
X-Gm-Message-State: AOJu0YzsSijSHDFVIYc7dU35LhKqcAs5Azpeoq4awfKGkCpZnUXH3G7+
	Db5tc3gqQuJmcCxDDgOi22jEccDP7mIFGV+I5MnKXDKspn8LkvUxSaHNES1DwI4=
X-Gm-Gg: ASbGncti0ncPmjpl2dIU9Ls8Xw4ocJgcpu67yyNHDZlgL+RgiFduvtMyniTZDZUT0Dl
	2KHChTx2QakmeS9tpZ2S1I5ulMEmYViCzEDuowhYv1ZbP4IKAPbBoVtsmWSfnrkYV1KOq4iYKkJ
	H6PeLddRjDI6ANkHo2ri8ass/JxbcGmDCtpCx5oiIlDDN3+TaEJYZPMkwfUDiPHUw0voqEGy89l
	gF6BI+c+MsNHPMfNPaCLY4jowaQFEQ9OO9i8BDZtpTHGyibLRGWsA8Wosk7i1qnebO2Tt4bP/zm
	oVhKCMjZXt79ekYpY+KIPrwtwnPEgB4x02Elz/gMr6g=
X-Google-Smtp-Source: AGHT+IH6k3hyrq/0l4b4JkT1gCN+78JUg8LClhOUdcFRDUh42oNZbUMejm+61OfzdqiOw6Mp4Sk0Xg==
X-Received: by 2002:a17:902:fc44:b0:216:4c88:d939 with SMTP id d9443c01a7336-218d724d4a4mr89329495ad.38.1734573920709;
        Wed, 18 Dec 2024 18:05:20 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964b84sm2044295ad.50.2024.12.18.18.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 18:05:20 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peter.ujfalusi@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	dan.carpenter@linaro.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v3 2/2] dmaengine: ti: edma: fix OF node reference leaks in edma_driver
Date: Thu, 19 Dec 2024 11:05:07 +0900
Message-Id: <20241219020507.1983124-3-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241219020507.1983124-1-joe@pf.is.s.u-tokyo.ac.jp>
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
 drivers/dma/ti/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 08f6c67d381e..4ece125b2ae7 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -208,7 +208,6 @@ struct edma_desc {
 struct edma_cc;
 
 struct edma_tc {
-	struct device_node		*node;
 	u16				id;
 };
 
@@ -2466,13 +2465,13 @@ static int edma_probe(struct platform_device *pdev)
 			if (ret)
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


