Return-Path: <dmaengine+bounces-5659-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD6AEBA9E
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 16:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E97168F5F
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C562E8888;
	Fri, 27 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLowtbml"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB22D662C;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036355; cv=none; b=BUn+mQMr8ioCAOOPi+xgC6IQtfP4UaxI0M0UdHFq5tlSbLz3AQrb7umECotBJMyucVlLf6l5Fxl3gguq9d6SfRpJGwgAPft7jZtBu/lkpO1xufkMsxEApUon06t3N1HHpGe6pT9xMXU8vhsiCKhVqzTNnkURutiksLtHX4cqVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036355; c=relaxed/simple;
	bh=tYiLJujWc+iv8z7OkMU3wg41iVItPHvcvfpeKX54doE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asreawR+3PPEzUhx92Jc4PxoAhvQ9MDo4UyM1iiQTUrW3EbLsQ78uwUyB14W7OvQWywSMKebezw9NPcW8hk9QgXKiQUepjJKvILMzTdzQxm/WcpN5pjmJWptjnkxxa9bB5W7IIGCrOsliyDifyaXxQ4YLxJYCoLR0dETU/f/BQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLowtbml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA8D6C4CEF5;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036354;
	bh=tYiLJujWc+iv8z7OkMU3wg41iVItPHvcvfpeKX54doE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QLowtbmlA13dsfEoH/r/fdvTymmQz6l01Spbk0Z+HrR44PrXr/wi06PEFXmsQKSp4
	 1GaI540/fCzWNiE1SdWpCv2wndS80RDhlRMBF6AEH9svvg9wiOTnyPMOq2EehI2GNj
	 XnJjbZQfyt/xqHvOe+b7qDAs3fw43cTyxg0ieCVk+wdTM0xA05Sqt72+dNPTO1xllI
	 fFcEqjufhE1sHJXGIoSo3wLcpSXW2YihOR0gb6n/JteVdVwnaQUCYMETaN4yJY5IJn
	 TCw283sVO2XwGRPe2/5QPzNY7vwUhGW8gpx2TnnIixWqY0QfbZT6KsJTvA+1Fq5dkR
	 W+52D7vrouCgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62A8C77B7F;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Jun 2025 15:59:11 +0100
Subject: [PATCH RESEND v7 2/7] clk: clk-axi-clkgen: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-dev-axi-clkgen-limits-v7-2-e4f3b1f76189@analog.com>
References: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
In-Reply-To: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036364; l=711;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=MyQa116l4E9wDyCm1ZTrQoq6qju7oKOtUMHCY6i0bL8=;
 b=2tz7oTZMPTpdwccq3C4mYynkH8wyt/mU8mG8vfXZ7twDrZ5eUmC35jV6dn9UsBNjjpYAJPddt
 p3QC9opyrKCAWBUN6nIpLPGp6B8DVFEdO+wvsbebS81sVuXMBUmiNt6
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The mod_devicetable header is the one to be used for struct
of_device_id.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 00bf799964c61a3efc042b0f3a9ec3bc8625c9da..2a95f9b220234a1245024a821c50e1eb9c104ac9 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/err.h>
 
 #define AXI_CLKGEN_V2_REG_RESET		0x40

-- 
2.49.0



