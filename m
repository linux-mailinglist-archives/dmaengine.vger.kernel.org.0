Return-Path: <dmaengine+bounces-5198-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC961ABC2E8
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0203AEEE9
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D404228689D;
	Mon, 19 May 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paaJkUuC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186627932B;
	Mon, 19 May 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669827; cv=none; b=g3m8/psOG9MGo5Q0ha3i60EGo5KAi0XutOt7Ud+d5ziR0uBhAGFkpTfDvI9ozeXzoJw5OUmFaG6CWHnPGgMcEiehtKvg0UkDS0aL6Lu6i4OqPlhn2NJu9f081zTFUl0dPfw8hVddJyfXqX2xIhjRwTEbB+XT89oPnZ0wnOAoLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669827; c=relaxed/simple;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbyWe9wEAaAJCZctE0E4KnE6XUtCx5yxUflSqZyg/jpVvgfeUTM2gBGzQjeA0VmicVZGrgdemffajk8VWTyP8E7dt8SSg7U5zE0vC2AaUcaCcQMmpGHsFYxYjV7D2xq0TvpoqjaJ6y2bfYSiFKcrsHFi7TYK10OJHGjblKZNBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paaJkUuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0065DC4CEEF;
	Mon, 19 May 2025 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747669827;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=paaJkUuCOgZ/lTYECQK4/sJW9HVQkjdamkMUCsXktyqg8rG4z95O95HJUIfvDCsMc
	 jvxw4pRebTglUJGNmYOfXWkXbR87fUw3orp1PUepI8AmUMo1oE95BywMM0TBUE2Isp
	 iDp8zpmC4aJ2r+xLhQ7mhQp15/tpMTsGV6719/aWHxjDuzwf3X8Bo3NCRts0ZUNS+w
	 sw+jA4aY/WbpsB/77gyoK3jbjTTGKtfBnhhg9jjPP6YKYjkrxqMsby4VgCMxhyDITP
	 KocEM/rK7SsRTO0XHpFz9Mgos6aVr4VPFeE/OX97FjjLqY7Suk/wYkUwgqHZhGu+dS
	 acP4+lXtUCtrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E49C3DA6D;
	Mon, 19 May 2025 15:50:26 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 19 May 2025 16:41:06 +0100
Subject: [PATCH v6 1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for
 zynq
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250519-dev-axi-clkgen-limits-v6-1-bc4b3b61d1d4@analog.com>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
In-Reply-To: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747669828; l=999;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5+y858CS+pLM6RSN4Bbzxos5w9xYK0rwoYDgzKAlxLk=;
 b=tamk4aw8ooIO0KwzFlKfPlcNPp2PXXfkMN/Cp7GtTJDwJODKTUzreO//ExrX9abFq0s9J259V
 C1H9qMaWDpNAoF7h5Be+x9rcMqgxoy+qLjWmdI8lGydQDfDisC5KQ0e
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The fpfd_max frequency should be set to 450 MHz instead of 300 MHz.
Well, it actually depends on the platform speed grade but we are being
conservative for ultrascale so let's be consistent. In a following
change we will set these limits at runtime.

Fixes: 0e646c52cf0e ("clk: Add axi-clkgen driver")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 934e53a96dddac8ed61dd109cfc188f3a2a0539a..00bf799964c61a3efc042b0f3a9ec3bc8625c9da 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -118,7 +118,7 @@ static const struct axi_clkgen_limits axi_clkgen_zynqmp_default_limits = {
 
 static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
 	.fpfd_min = 10000,
-	.fpfd_max = 300000,
+	.fpfd_max = 450000,
 	.fvco_min = 600000,
 	.fvco_max = 1200000,
 };

-- 
2.49.0



