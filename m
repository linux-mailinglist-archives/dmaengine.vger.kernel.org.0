Return-Path: <dmaengine+bounces-5371-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60548AD5BA1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2CE3A6EBF
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A61FCFE2;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq9RwuKj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4D15A8;
	Wed, 11 Jun 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658528; cv=none; b=RvaRBdnwxc1wGy+/RCBNxxCoCH6nejJoHJLiFh6lE4Notl5X7kmVyOV1WwaP5fzyzS8FiqLKC4TROd0zUOv21NC0Gnk6wSyk0FOwvGFVzBz3y+TK5JdH5bOMW9HAQTdV0duDAsJke604zYIlzChfolCP1S0Y8uN00OQce1J9Axs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658528; c=relaxed/simple;
	bh=l8GHgN4bthv1D4rTi1VIlfnTVIkCL8BlPGbaZoVw+8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpCzkNBiNKmixGA3fCGClSc58p1Hwyk/ahs3Ry6p+YZ7wEpwCYrHvGQXFnBVfyZTAni2nb+n1B8DnrCGKlnX7fR9wQP7ueHxxqLjBKktuXd6vEOJ03olpEQKVkTjVQIHgTrZ/B1mQjnaErWHjyRbkszQ6W3LCZ4MIjBrxdbBOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq9RwuKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B304DC4CEF4;
	Wed, 11 Jun 2025 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658527;
	bh=l8GHgN4bthv1D4rTi1VIlfnTVIkCL8BlPGbaZoVw+8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Kq9RwuKjdYYEuDWIhN/AdP8+WZCcHeG+mXLGypzgVfsOPH7869YhUikdVuaA6phms
	 h5Zyc5PAH0VzYc9OzDUQfzdREUFeTeU9Pb8UAgFTlptsxMX5Fh5ZfrweNFxOKZ7wl+
	 k3mECkA+V7rk3e8HhczdmZXoLo7Rt8OjqYnbdgJiErtYm6kpC4NkWsx/HiGg9yebZV
	 1ww1UqbO2PEnuXKRYdY/+Duf6AE9HW3JauF3LJ69tlMjeSUgn4XM/g8o+co3C1e5Ij
	 CNcRQfwkv6RHJ8kCkWEgUMrydFxvXhF+wucdDzKbA3CGPx1EveFOFESA+TxlpoDP40
	 dBH2W8zZf3mLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866C3C71136;
	Wed, 11 Jun 2025 16:15:27 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:15:33 +0100
Subject: [PATCH v7 1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for
 zynq
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-dev-axi-clkgen-limits-v7-1-3e7ff89dc366@analog.com>
References: <20250611-dev-axi-clkgen-limits-v7-0-3e7ff89dc366@analog.com>
In-Reply-To: <20250611-dev-axi-clkgen-limits-v7-0-3e7ff89dc366@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658534; l=1051;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JzRJBVV4hmqfyR9B0h2hyDBM9zs6OBzwS0DPME3ZrAA=;
 b=YtNqWyeeeafIzxivB6S+327Shfi2k5Dif3dTAEaaJapROPgYxtF7XMkAO3kEThUsewEuaz4BT
 e9ECWREFZHCD5YdYuvQ2BTbrj/hUdN0QwEFyQQw/8QlA3v1Tnxq3AB0
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
Reviewed-by: David Lechner <dlechner@baylibre.com>
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



