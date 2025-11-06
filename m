Return-Path: <dmaengine+bounces-7087-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6792C3C227
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 16:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB32D4E4DF9
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D37302179;
	Thu,  6 Nov 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Oj2hIZ0f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3D302CC4
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443900; cv=none; b=TDQm/TRgEZqMmdnO2UP698N4Ppizw3LjklL91l/5748osZpW4Qb5xEN0kOnWXjTwAtNq7lf+thE4u2zBgMtWEI5sKJi++HyFzyehHpW0h+wgrSMMQMf1tt0NBNmT+CuCjgXZ6mRZouf1GKPjIWqnenllhDwGYvwVFOs/xRB2ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443900; c=relaxed/simple;
	bh=m5IGuc219hR91E6jxj726r30nxaBrIgbepoJBLfYMuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cgZ1F8ypU3OK2Kfg/UoVZKq124TmXrssvaK6hahQtMvOarentuHPf5OOyYyZBZAMSLuibbE2Xaud9obRfj3uuAr9KybvTjBTSZAwMZvmxQn5DibY8Y0KCk/oqNWwLKRbnFYjfjoEB/98mp08WMqjGp1SK8F1kUthhR2mTd3z9Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Oj2hIZ0f; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563e28a3so9149345e9.1
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 07:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762443897; x=1763048697; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aT/t6a4KBrR+Dsl/bounBEPokvpfPwhEHbEcRC2FxNM=;
        b=Oj2hIZ0ffij1IL671TsaxYfCizRNi4PiWHj2CGlxxuWJkg+bS43UlUlghY5QHuovEv
         UDyHqUBtbmoKFbK8ypGY2KvCQxzcgTlPEPfDry9L0xL3mf7kSw9s02eedusFOuDvNe3N
         pS1EReXYleAsf8LN9d8Fks0/GyEQ7f0upAajCat0ce24YsJftUeTs8eaav7e8Ie8Ts7C
         0K1BNqBJ0q/3VoWyqXZ8AQboWsl/SAf4XVU2n1RbWl+IVKpBREku8ik69NSRxxZ4fmfI
         xfKECQ4ZHfEtipb0IdGYQDNNqrGlpG5ejKs421LehU4TonSneUIqfLRT+0QZJQjBvgj2
         vYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443897; x=1763048697;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT/t6a4KBrR+Dsl/bounBEPokvpfPwhEHbEcRC2FxNM=;
        b=pT+Te/29vYxmZnHSFNFXGHwiy0o/HGfXPyFwIQtaVe88BbpuXmnLbMCevjAT6ZUpOx
         4OwvMggaPHa+3nQJ796qmOoh5EsV9UCM7D43op1GEto8Bnkxyr9lMH6v8QjlfeImJPzo
         xScwYlWOnKPiww5Y1b62w9Gtu+e+f5peCWNJOnigRpQx+1fUjERhcxbbnBOb29qrVcnZ
         4NEB60f4O071esRFFLMtjJ3e+vYVr2OrwL8D+EnCxyNFaJnNIXVa4weWFgOiexMW4m6p
         YO1HbqqZCqOheKyv2OYtlRAJlxN6z4YmQ3xGig0aipaZgrUh7iQBUnnBXTAfBWCAK/pZ
         gC9w==
X-Forwarded-Encrypted: i=1; AJvYcCVcg4EvlIS/k5khsZQTSTf31WdeiZLIUaipnwqPq/IfHGygL804ec1zMEvPbrwvL04jMN1U5aek2+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLgOW3S/zYLgy15kJZH0eoXYTeBTzzSGmGRe56eoknD1m/7Ov
	7JyVTjiZaMDnvP1GcoJhpwxSrz7F8mCZClbxVr1OZ2uHlSdXI9ZjbVBh5VJnVQXfueU=
X-Gm-Gg: ASbGnctQSgRrvQKkItwDoqkzg+XE+Zak1aaoDLh+Jvqk4jLQFfETHKayDlLxyWGHB0Q
	exAOsYPYnTzd2GWqCSGefpP2RUwHtsUIQX8lmHyUy54h3l07s5FQwN4o//mmBsTER3RH1cv6FAb
	ZJbQvMbA/qUXWUq+7NbiKDFdME8+QLMCytIohedTNFvZga554UiDM0HLrd///G1ZAsbwGNQgZH0
	QpI8a54T2hkFN+g22H6woJHKkBnXSMUWwyEeJh+NoWa4x5fO7GMywd7Vgr1lARxBH7O4EP7GQFb
	6nOhoM3XgUKTMp3GgO3bF+6iPEhnJiyW2OruK7EIT47O160zDLPMSZLCgw8hEcdmJTZN/oXDEUw
	eM333i6PFg+bOebCYWusQc14wSEGtAQDH38209JaJBDdWehQNR0KkYbAL8qzxCHT9/0rU1Sq6J9
	lLfWmr
X-Google-Smtp-Source: AGHT+IE9fxs4rMTAf1h1yPirBF6DFkbLD1LQP4bNnKenkfRTYH5bQ38vhZIY+6TZBwAkKcgCf4p+PQ==
X-Received: by 2002:a05:600c:1988:b0:477:6373:ce7c with SMTP id 5b1f17b1804b1-4776ba75d9bmr501805e9.3.1762443896962;
        Thu, 06 Nov 2025 07:44:56 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e66b1fsm20621705e9.1.2025.11.06.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:44:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] dmengine: qcom: bam_dma: some driver refactoring
Date: Thu, 06 Nov 2025 16:44:49 +0100
Message-Id: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHCDGkC/x2MSQqAMBDAviJzdsC2bvgV8dBl1DnUaisiiH+3e
 AwheSBRZEowFA9Eujhx2DKIsgC76m0hZJcZZCUbIaoWDxs8Gu3ReY2RZm3PELE2qpVdY3qrHOR
 2z4bv/ztO7/sBAnI09mcAAAA=
X-Change-ID: 20251106-qcom-bam-dma-refactor-4b36275b8c3d
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=703;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=m5IGuc219hR91E6jxj726r30nxaBrIgbepoJBLfYMuU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDMJzgNgQRm8qx7/pmdbGI2+JW/uD2olQMBTY5
 5r3mhZZLh6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQzCcwAKCRARpy6gFHHX
 cjIHEACCwHmB0cdbopPZxqv/VaUmPRQSXbSe9fvcixEcfilOkHFTELwlKm2in6/WaykAMQUY61X
 vvllhAECOdGGOnfLcF8Wm/Yaixt6eJWJ9m9lsANmehPCtkBbYtUg2HkfF/rLV2C576YjerxfrJD
 2+fLZwOtBOMjk9kziEbUWWE8fptx3JFFew9OWF5dS2eVVPT7Tg9yDCnFo+L8dUlFxLoqaE/EmVy
 EY/l5wGDSi5Le0YODuc4qSlwfwGY6CGQRFiEpzfMHAmNE9c8Iq0vqrmlG14IowjNHFSlmyJ1UCe
 9NPOJmTWBc8zFxdBq2ZITP4Hiv2zF4Fmefjyfs8N43+5+HWZIr4K0vm94Mcgr7IEObiq58bKMuT
 g9aOO3aVBiRJga9jI9RCOEbJZoJWlZ06KWbTQl9v/Q2aNXFoZA2NYlXhC8bGH68jh84BG7nvrVQ
 LPCSzu9LGLiVAdoEz0J/6nIUwBzXzXiHr0pDAyv11s/6X7Pr0edUjmtLyn8h9QX+kdHTX/0vLrE
 LpR8hH65KFRLnml+1Jc9wLmJ+r4LwXAJvP8XyUMla0J/HkzAgO+1s9dx4cBlI4fW7cZusADRas8
 XEaJaf0h9RkOwd4HrhK2GML4dVtV20ePtHpRAEBCcoQY8/YKmljFaAz7Un1rO6evOlfu6OvsgNZ
 KPkdJ4aCFCPKTyg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here are some changes I figured would be nice to have while working on
the BAM locking feature.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (3):
      dmaengine: qcom: bam_dma: order includes alphabetically
      dmaengine: qcom: bam_dma: use lock guards
      dmaengine: qcom: bam_dma: convert tasklet to a workqueue

 drivers/dma/qcom/bam_dma.c | 184 +++++++++++++++++++++------------------------
 1 file changed, 85 insertions(+), 99 deletions(-)
---
base-commit: 0297a4fa6f372fd3ed8fe9b4d49b96ff8708ac71
change-id: 20251106-qcom-bam-dma-refactor-4b36275b8c3d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


