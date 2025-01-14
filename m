Return-Path: <dmaengine+bounces-4114-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7CA110ED
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 20:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E3B18888BA
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392731FBCB8;
	Tue, 14 Jan 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJGTeHbQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF71FAC29
	for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882006; cv=none; b=Xz9feyvF4q3nWDAsY8Ttn3HKXTc4xF0VIlQVhP28dfs1z3I69VzdNerjaHCHuVI2s2fVF30z9SskikSrqUjV27fhVkjDXRYCgztctowFI/HRBHCgaMvDWKhypbQss9mfETWRtAx3XdAeLA9LcGN8Qq6IZqD6eH9j81ypzFirZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882006; c=relaxed/simple;
	bh=k7IsBi5ieyhnEhM6fyajIW2nBVHAO9NmMCImrDmXTaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUZTW8D1gN88fHprqdXHJh5BXX2h+B2RZG9l+nZwbeV9jmcqgGobec8jZbQ0PBbOhmcxEJ8hB3yt9Kj5jbqi6//bg7hFxYRpzAShIW1oqh4hmJi/X8AVRIXvb84M/Nt7eeSS3a8zsmy9GGcE4OBeB3s9d0z5lMBmHyQUby/2Dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJGTeHbQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f09be37so7411265e9.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Jan 2025 11:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736882003; x=1737486803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wl7tKpwKeYK8cvnyb6x9sT/UwWoYgOB2ZsNSDFKMQA=;
        b=OJGTeHbQ19bbsxIoVVf84IciJd8IgmihIObwzVFMrluJ1wdPI2okABHE3mlZsoGxV+
         lnceTF5NUmzTg8L7MRY3mDqZ7SjId+5EUrPPyade82dXv2hei1gzX5NsDyNwj5BU6GhD
         ODYa3dVpXD/060Ck3NqCjkSc236K7MAZ3qGeYTCLbkWVx2+jBY2DlsdKof+/djZVceHu
         +OYJXgWtFJE9PcbZ9ldKHgMKe7hQhuWWE9BFlhzRLHE1l99QI/I/QUUaAJzIKxlGubh2
         k5z/DT7GTYVv28boyrQI30MD4BraekS6YSO7zC2W6TQV1UwXBJw2md3w3R/RSxFGxbum
         afgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736882003; x=1737486803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wl7tKpwKeYK8cvnyb6x9sT/UwWoYgOB2ZsNSDFKMQA=;
        b=ZT5Ey1znYUewnmPy4DPh02svPpXctEoQ/mBsI8L8WghwDHX9gGmLGkXiC/8PGcinXz
         VzX9v20aw+S815Sss5SAe/tB2gAkoVlLfRHJ/kJ2dLHzVtlXBsWXQCFoN7iBas1pR/GC
         WNHw1J7QLHBdeQAX0ctUp0k/ZBlFO2drRy927NPGnKtRzLzsyXj74n5hPelABqkQWz+3
         WsfKj7e7jnJc1RbRjoBEtJYMll5KUmcCnlb+JHqxNSjSC15WkIhI+tKHIEFJbV41WrVq
         mJ0OlZpyuWR4qWZtOjP7YaXd9LQUM6itVA+Ek11VITBJVbnAEXXFsl2aBpYndST3UMog
         5dhA==
X-Forwarded-Encrypted: i=1; AJvYcCUf9y+q3R1k6vWY22Gix/a6GlYtwSxufoiJMLWNBWm0a9dA4jjPpq4KxghmsqDgvECz8h1RTrF9y3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VaZ9U8d+VX1kCJy7AAHUBukgBTNp2kbjNdbTmT9Dk2qJDA/z
	6KOvMhMFUI/RR1DO3+8k+HKPfRuDAeRKHxnw449RjJiNa4LEulUIJK2N1xkCp9w=
X-Gm-Gg: ASbGncuMdSSeUzqvnR8b/8+Bkh/fx50lbXYTyfpnUrogn1i6oso3DSdNB9gWmTd/9Fs
	lOSSAcuoUQ/x5H6I/tOTzt1d9++dIAJtISGdTCv4ZB3qr9dmmBauvw4F85TS0TH5KJ17x9q9dc/
	bC0JD4D3a0SA4XZmnDJD/huoApZZZFq34UXKnsy08rXh16DxEkhjmMUgKvTfsabQ3GtbMp4fsfy
	1v0mYiV/Mz3mtcJQLpBNdzSGNjwuXmloAsyjQNCRp4IedbapQg8UkwW+DjyQ5iWRE3reTI=
X-Google-Smtp-Source: AGHT+IHcdisH2w41GtL10pQD5dU9j+js5oAERihWoWX2WfAm4V/01RG4LlY7+mTlTx/wiFlkIv9Wmg==
X-Received: by 2002:a05:6000:2aa:b0:385:e10a:4d9f with SMTP id ffacd0b85a97d-38a87088249mr8578870f8f.0.1736882002698;
        Tue, 14 Jan 2025 11:13:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3834a6sm15508266f8f.28.2025.01.14.11.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:13:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] dmaengine: pxa: Enable compile test
Date: Tue, 14 Jan 2025 20:13:16 +0100
Message-ID: <20250114191316.857154-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
References: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PXA_DMA driver does not include any asm/mach headers, so it can be
compile tested for build coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Fix subject typo
2. Drop () in Kconfig
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8afea2e23360..df2d2dc00a05 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -546,7 +546,7 @@ config PL330_DMA
 
 config PXA_DMA
 	bool "PXA DMA support"
-	depends on (ARCH_MMP || ARCH_PXA)
+	depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.43.0


