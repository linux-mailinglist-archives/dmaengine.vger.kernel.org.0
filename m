Return-Path: <dmaengine+bounces-985-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AAC84E9AE
	for <lists+dmaengine@lfdr.de>; Thu,  8 Feb 2024 21:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4C928E408
	for <lists+dmaengine@lfdr.de>; Thu,  8 Feb 2024 20:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9B383AE;
	Thu,  8 Feb 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1LVfB1q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB53383AC
	for <dmaengine@vger.kernel.org>; Thu,  8 Feb 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424075; cv=none; b=sRQfPE9larejlEpLS5AVgXK1BopcrG9tPD6Se4/0+c35bYDy6mSrijLMS+mLJRigiMlBQbcTcqCSvnLcqgwwV5Gb9VNs1Jgs/dME2D8wQX6StaoeGcEIRd3/LhUxm8BsuUc2Cy//ZWoIwPZu9X52ZPXccwhlVvaPEZJJmj1A+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424075; c=relaxed/simple;
	bh=gpdmiFJjJucd1Zl9QhqyKAFaEgPM4+P1pUU2iwmfaAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3NHEnRYAtT06wuEqDuFV3l0LhjK3T9TaVfqPQwUO8D5Woprsg4fwxziRFl3wNaqW2w9sfsf7x7Ch8VWxnjBUOMlacH6x+pCDW6BFE0B17hcUZCOrXrkVlhzIqd115C8s2DZOXDuXoRcxQeTOb1dv9T5IYDn/Dh6Klge8S1iY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1LVfB1q; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41059577fc1so2177955e9.1
        for <dmaengine@vger.kernel.org>; Thu, 08 Feb 2024 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707424067; x=1708028867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIl3nKoqWKpsBAq33qAsQr6tTJHAtXKfr8vYfHmeqPU=;
        b=M1LVfB1qw6VDUQWfzOeWtNkxTDOBjJc5nexd8cTg4vzFlCsetjtOrdpXerWVT3oIYF
         X07CWoTa/Zh4fwyRz/mFNgC7X8kuBgBCaqtFKNzTXhZWZ8eMCs5Aj4bW7EFFGHA2+O7d
         TqsAsn/IIXD7gPcGkPwkpXyLFaEMzIl8KDWVyluXjqCDWABI3JxfB18RP1nJCOYDOI5G
         2CtUhuMiWjCK+f9AZmiV47QaF21HZuIsyoqVo5hSV2fw7esSgirG5aDAg/WlIGjLUbfs
         QxPxeCj62iiZQ9QXwjG/HcM8ChdVqvWogP2DKm6SzeBBT/JmjiW5zhO7Kw1igY3GCBcj
         T7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424067; x=1708028867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIl3nKoqWKpsBAq33qAsQr6tTJHAtXKfr8vYfHmeqPU=;
        b=Nzexv37id3m9FTmAZOoeItmPLckw0May5X3uHD3Nun9OJc7exOSdLBqmRarGF+wuY6
         HNSqIICzFZourx9OLU3VLvxuYCM73HUopFoHVLFZFS94Q1Z42ioK7OumMw49jDfG8cbx
         oB/cbWZ8Q04Orthb/kik/7qT99ZAUFH5VCc12GZIbxtBP3rQC6XvZQcBpITDzLLdW4f0
         N07Qr3hszYlGaNZudwtCIP5FAO5NRdeSviaXYNK+sUO0cpRuxQ7OyNJ5jmtxAWZVMFL0
         jP+/5gLHSdw3ew7NggqqJ7WBOB+HtuS496usZ+/hUEdzJl6BINwhb20tcDYzIAj73MKa
         xGpw==
X-Gm-Message-State: AOJu0YwlVqSS5s74r9BiIjLgrHLvGt7TZXhB05eZyon+L4//dFUNS5T7
	6s8YcX8xqq9GSvxzl8STfluPwS0nAB02F+rRKlrZDpULNuxzOkjY/ixMrBU6f3E=
X-Google-Smtp-Source: AGHT+IH9x0C9PHX8twbeNoIdkRdFmX3e8OorcM8cAuSlloGIaF6SLoCL2BKVtZXrEwAi2LAn8VUSTQ==
X-Received: by 2002:a05:600c:3595:b0:40f:df2d:870f with SMTP id p21-20020a05600c359500b0040fdf2d870fmr299007wmq.41.1707424067333;
        Thu, 08 Feb 2024 12:27:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKOn7hUxxacPQonDj1sCI1q2P7LYutfLlDrjtemlI58fVapiIBWbUo6U/jxDBTKWpqnF5Z0hXAvytErcEB/L0izRsYp7DjWKZtHWvMQRN/9tJrr24vx5ngkgreIs01drwRCsdzxNXv
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b0040fa661ee82sm368027wmq.44.2024.02.08.12.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:27:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dmaengine: pl08x: constify pointer to char in filter function
Date: Thu,  8 Feb 2024 21:27:41 +0100
Message-Id: <20240208202742.631307-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The opaque argument chan_id passed to filter function is actually
pointer to const memory, so make that obvious in the filter for code
readability and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/amba-pl08x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index eea8bd33b4b7..fbf048f432bf 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2239,7 +2239,7 @@ static int pl08x_resume(struct dma_chan *chan)
 bool pl08x_filter_id(struct dma_chan *chan, void *chan_id)
 {
 	struct pl08x_dma_chan *plchan;
-	char *name = chan_id;
+	const char *name = chan_id;
 
 	/* Reject channels for devices not bound to this driver */
 	if (chan->device->dev->driver != &pl08x_amba_driver.drv)
-- 
2.34.1


