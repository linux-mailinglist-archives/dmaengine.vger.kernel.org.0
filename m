Return-Path: <dmaengine+bounces-5058-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D0AA995C
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BE717C53A
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E826A0E2;
	Mon,  5 May 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxmNvawv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DD25A2AD;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463298; cv=none; b=LXcmaZyIKICqbKJepp8zr1vS9u7XELiJEgC3QPERZXc3AYl0gciGhprbVzBMTtMlRHvh/2YyYW3FBPk9BnenNBrnQy53M/AUPeteXxbGEviM3XFhCB9O3EBz2At6mK0PtjZ9r1XJFVP+lptgeh+9tCTgygh7C4k6lJfAX9bbWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463298; c=relaxed/simple;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fg6unijdNWKttU4igF68x3vlXPEmdJED23ibJ9Dhy+cXBHRSVDaL0Ji2sy1NatkYuaI0X25xdlfziBblT1GgfsSe8X8S1H7eyT3g6SylBNNzNkQEBgJyd855ND9fsGpu8yN98uRcAFHkdrzXWbLxKQ5oQTkPAX5gH4ZsA1VgZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxmNvawv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BC61C4CEEF;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463297;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dxmNvawvOySthKC2h5HX3OBYp7mNZOccBje4oN3+8uEKBuxvPAVLPiHXhxp/zFQ/h
	 otCd2vhOyzUmegmT4pTTnike213vqj5DSTaRrpJY81eqeINYNmGjDoYezpQRT5nNW3
	 c3r9H/ssA9egWPCLSUDEkqHZ1j2Zf38Jmby8j6zIz9KlXY4y3IenQUMJU0NdpOKGaa
	 nRoNYTyQPqbhugfxwOf5T2IJuYtiq9D+v9TcdVivPKoOdQuFoh5Ks3ZIJ+w5GTnHaT
	 44Al+HMz52fUa4bdgCyoTNbnRJpvqjBfzgDBdYmqJ8Xqwui5ZFAtkxJTDPSRItHuwj
	 qVffrBaa+mYBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB9C3ABBB;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 05 May 2025 17:41:32 +0100
Subject: [PATCH v4 1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for
 zynq
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-dev-axi-clkgen-limits-v4-1-3ad5124e19e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746463295; l=999;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5+y858CS+pLM6RSN4Bbzxos5w9xYK0rwoYDgzKAlxLk=;
 b=JnMILPfgdPrKiAjlHa+0kVVuFT7iIapl+s0dtmxMQRdGK4FggI5iS5L0WswSPT5cL/SUCXp0K
 5L+kR1/Pz8sDGrP3kWDs9xbb6IAKZvvMsbdYURtP4fe+A9WYDroBDRA
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



