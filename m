Return-Path: <dmaengine+bounces-5376-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A050FAD5BC3
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B4917E7D7
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0718D213224;
	Wed, 11 Jun 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGPV256y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA720F067;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658528; cv=none; b=K48Oq2EObU7dgT31dMEQ9RBrEZIr0tmKzMw5gTZi4WQdzwFHIeuMQFMGvH/ae73t476WvbIbP9JvQqeycfAtXZxoIoJ3qKZPV/GE0BMSQQEK85zv9FA3NWsSbRMAB6Q03QC9unNUjFI6fYraRkLOPDpN5s5ZhzizjnaI4oLppwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658528; c=relaxed/simple;
	bh=iNvB270qem/r9rmaw3HGvdR0SSzJxJVoWK0iTe66R78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iq8UCFzByOp8JTN4nqs8kVOLg15A4C2Kp1H/fk2NG1WUeLTv6XqRccYtqp4fU3si96W2TqsRRZRRU+1a3a2Tgah3zutE1b7SUyHkUc/zF/+xEVTIPUWBI2GqVBi5soS8/46KcULjRAeVQvbdBwFAnQ467nNQfbBEKmgb7b/wVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGPV256y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81C87C4AF0B;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658528;
	bh=iNvB270qem/r9rmaw3HGvdR0SSzJxJVoWK0iTe66R78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JGPV256y5Bf+Db9uQmAlHKw96kNf37Py+IoowxLodm50Si+IW6u+93fH78HxQxRjs
	 2rSKN6W2dFdXaeXI16eTnHji95Gl/atQ79YGqJGBEJ34tiygRigLP0ONZd/odtrL7F
	 KjCnwbvpOLoepbNkh0WvoBubFudQC3Otqv81/1KVM3G5Ej2Ul7MgMRaRok578wa+dX
	 ZBeQt/Sm2yAUAF0VQZ8+2nkPrFFTsSXN9Dp0ERsUVgUdpeWKizUhjMD2EqjBByfgXd
	 MNPHS8wUTBOld0RQn2z0kIWWWI4If6ekmlT/K7Gi9su0lm6INb+p5w3jmwz45k3RXS
	 wLSpqlf5PbWNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A83C7113C;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:15:38 +0100
Subject: [PATCH v7 6/7] clk: clk-axi-clkgen move to min/max()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-dev-axi-clkgen-limits-v7-6-3e7ff89dc366@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658534; l=1547;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=piuSskdq8cMRdCP+4hCdaWdOTgdc2I6WLf29pd00o00=;
 b=2tHpYLnoiaPEdaPdbjtDfWiBrJbsGu700SIg58vpsWt3h9J220f/DBofXHKBXPTHkVMf8zphl
 +tBm0n69B/IC0kWc7/D0M9S8jwSQ3dOM3w7gxaGEGOaIFNXVrb+O08L
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index f4e96394e9c25c817b09ee0c08751147083f19b7..63951209c460f26ed3940879da536e31ae530188 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -147,15 +147,15 @@ static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
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



