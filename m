Return-Path: <dmaengine+bounces-5061-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE59AA997A
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35ABC7A51FD
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF326B959;
	Mon,  5 May 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACiUd32F"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1126B099;
	Mon,  5 May 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463298; cv=none; b=TbMRCT4dMuw9WRVi/1nsuxyv36Arq/tW5Hlh6A16eGa0VaXYjmK2Po24TgRNQZ6LWl8TS60g1ebibJmQ7mzZltLsYViPE4gXNNd1ZvJeSTpiCCZJq/W9d0ho2P9TcO+8VqHTMzlAGoBi4EcsZaBAIJs1F5eX1EtD2T0sOwmFZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463298; c=relaxed/simple;
	bh=LsVRHSLSiecEqe62Du55n0ikOAMGKXU1HUtTJ0lMc5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Butr0oXPy3SmtztHe8je2titcFbzNG/J6a5TaxZYan9Jvmkepx1hQhOATlzjLwDCUyGbmYtfAE2T4y6GymIQb9juDA1L4nUvwlwJzBrj2FSrluv62BVwJK6dJCaVS8+UhpoARUpgrG0K+wDKTKrY9Ulk8qThuz3aHwd3CrPi3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACiUd32F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA5C6C4CEFA;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463297;
	bh=LsVRHSLSiecEqe62Du55n0ikOAMGKXU1HUtTJ0lMc5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ACiUd32F9XAXt+BMliz2tJcRMUiAEld6L4dTS1z1jrdxltCtvhDLcxbJ2haGaXVjU
	 4aQQvPE/E6HtaXFcRL8+uKtHJP7VMAd85S/M9MpxLtol+8cBWGvaxKjkfIHL3Wop96
	 DJOR8iMwwZegI0jABEuunQWgvfGHBXnY8Yuu/OLb+r5KI4KJJznXYULlMpdK1/sGs4
	 A2syFHOrmQMpgPTxiqCYEJEmkdZ/dkvIc5TuBmOzh7vcz1ehilMEqaO49UG3wBCMPe
	 7YnIDnH6zahrh2h9hvaMzVxcPtBPPIWlJukhDZdRe1EoDnz3QZhKFsrm49eaWHzu5m
	 CsNh2FJTEG8Qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C1C3ABBF;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 05 May 2025 17:41:37 +0100
Subject: [PATCH v4 6/7] clk: clk-axi-clkgen move to min/max()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-dev-axi-clkgen-limits-v4-6-3ad5124e19e1@analog.com>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
In-Reply-To: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746463295; l=1495;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=0Z1yXXcU6N6OEnmuARXTcAq1DZDWN+Kl5h68bn+CnOk=;
 b=A+64PSzx8Uoa9y+c4A2b//ZatQb2A3EvmxLURxe6qs4a2e9xRT3u7RZJM/XcK3n2YtsbspwPA
 70mXxhjwU+nA3HqUu9pn+KzZWMJoNPHnZDbFVzBq5pU3zCi/kgsq3Dd
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
index a4cc6e1f0742fb22904c9a4c266198f62ede9c65..d8634d1cb401fff2186702354ecda7b4fcda006f 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -144,15 +144,15 @@ static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
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



