Return-Path: <dmaengine+bounces-5139-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA50AB3B0D
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020C417E49A
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184F22CBE8;
	Mon, 12 May 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eweUzEQ4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E422A808;
	Mon, 12 May 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061207; cv=none; b=F2BE9xAKC3U3ZiZjdnGsk5uDIkuY6u9QzTsz0KsPnP/NI/6EB18w9bVAnQ02Tl+wkwTyZZC6ycFlA/49h2cd4FMLehuo2UqSkJCpZHhVljSrGipzsukMGOakMMgK49L7B2xBxsqJNUKyKM6X+ozxel+3+8YGkh3qihFDFzw5ryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061207; c=relaxed/simple;
	bh=wflTF8yBCbCqHRelQjYXhd8dkEpvYuLOqoYjxvmmw1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbyRe9ZPR0Hkz0/ntedM2vjHy7LJluQEUJfX5sK7sUyzOFsgToAvpgtBoY8Aros8wF8hQxEnZDtK+8Hzhy0Y4YyMc8FHB5cIWimuQjeEiWoy3ET5rJObdHt9TdaN/nC8ONEh5AiyKD+J4DjQSTkeQo8Scar5rDZe6owLRh4CVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eweUzEQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCB3FC4CEF4;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747061206;
	bh=wflTF8yBCbCqHRelQjYXhd8dkEpvYuLOqoYjxvmmw1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eweUzEQ4YKUAJhnbK75OXQFGpXPfcWxfFEAOe206qNVJtYz1dF9Klxes8Jlo+Qs9W
	 9dhLjsm7tqO4d07VEvUid/Ly1HcfZwJzMUTuO+uK5wwa2mgIihVlTKZfDueu6VWLrv
	 EigufDRxI6B6rxbWJwn+VMAFVBam2TkD521V0sUj4BuXJknnJ7d+R+SMHWOKiP3boL
	 Hv/wGt7yjFzPkA1h9EBsFAGlT5uAiEmCcarFlWc9IywWAu6JRPa+DY3IT3+5hje5tb
	 bZktHeOMbi2L34+IIe0dMKspFZ2Y3YbinNZGDdsGl7kzxX05cl20AUtm9hNnxirGf9
	 bkiblXT8E21HQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31CDC3ABD8;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 15:46:49 +0100
Subject: [PATCH v5 6/7] clk: clk-axi-clkgen move to min/max()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-axi-clkgen-limits-v5-6-a86b9a368e05@analog.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Mike Turquette <mturquette@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747061206; l=1495;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gt9miHRutGA3DDiEc3o4Y6MbcZamkscKCqXw72BR1/E=;
 b=Sln9W7rnO2AaR0AIe4j3pEqWJKMPbOAcFMEM4oCq053MWzkFn201n1anwO0SUek75Fwz/JbbM
 3AHosgfj6YUBvBKeRcERu36Kr6TMnrtitC0I4dB/Dqub+RzfIrhHUzB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Instead of using the type versions of min/max(), use the plain ones as
now they are perfectly capable of handling different types like
unsigned and non negative integers that are compiletime constant.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index a611451eae9dda1aa21ea269899a510994ecd42e..40ca03204010a15078f90935effbe58c4c3a00bf 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -148,15 +148,15 @@ static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
 	*best_m = 0;
 	*best_dout = 0;
 
-	d_min = max_t(unsigned long, DIV_ROUND_UP(fin, limits->fpfd_max), 1);
-	d_max = min_t(unsigned long, fin / limits->fpfd_min, 80);
+	d_min = max(DIV_ROUND_UP(fin, limits->fpfd_max), 1);
+	d_max = min(fin / limits->fpfd_min, 80);
 
 again:
 	fvco_min_fract = limits->fvco_min << fract_shift;
 	fvco_max_fract = limits->fvco_max << fract_shift;
 
-	m_min = max_t(unsigned long, DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
-	m_max = min_t(unsigned long, fvco_max_fract * d_max / fin, 64 << fract_shift);
+	m_min = max(DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
+	m_max = min(fvco_max_fract * d_max / fin, 64 << fract_shift);
 
 	for (m = m_min; m <= m_max; m++) {
 		_d_min = max(d_min, DIV_ROUND_UP(fin * m, fvco_max_fract));

-- 
2.49.0



