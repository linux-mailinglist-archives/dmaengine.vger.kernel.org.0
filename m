Return-Path: <dmaengine+bounces-5137-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E452CAB3B2B
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 16:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BD33BF1B8
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F022B8C2;
	Mon, 12 May 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7OcJzco"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC6622A7E5;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061207; cv=none; b=E/UL8BFqRdBicJja/yHN+xAdfArNsouz26vI23VdF5/OstUGoz2Ee4SS/XsWcr5ybOkK4JGVRCel1uKlLboNhl5wH+OP82x+SJMGJaEGwH9JoopKQ/mFvZfZ4wB8xd2z9Yy9uS0NulsqqZh0WsxgOmttTX7pbOkUuZfEHKL2GH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061207; c=relaxed/simple;
	bh=Lc+0ipnOsOyMrbnE9ygCUwscmE7Y6WD4G1olrBmxHzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ps76m8VMyHM9lrf9f9zqbhiki4VYvYq+XZ2gwWPiWtZ+Pr5o+KJWnr3L5nsROp8WPoWCLcivfbid2bZOmMM9Cc6r85p7tIsmbsKWK4BERB7hol+QXByXKQCNZP7mcz7CeEaVLuH5vW1arBM7t/Q5Pu6e4iXvfpUe2nQENoPgcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7OcJzco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A75C9C4CEED;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747061206;
	bh=Lc+0ipnOsOyMrbnE9ygCUwscmE7Y6WD4G1olrBmxHzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A7OcJzcoiXFmYQTSqFfAdYD4AcNXac/QKomacYQUvcEPdtV4WXUY41O5wS3OGklsQ
	 GgIeNpnrKybInUQxLocsW098l1FfjW+jf1mcdDLpkpGhpgU+H+I+1xrAGxO7fa9DC9
	 P+OzkFlTAhS2c0wXdUagpmV5aywUMyF6v4SyZHFz7aJVKXx/GzP9NeWj8foCHHchev
	 UOb12WK78qb2vspj3PVu9Alz+U+eDkbWedpoqfMNULY6lm65bYoi/KQ6ob+bkRzq68
	 QkdO2D49FSL6oUpJJp+x33OTjplYqXvUrILtg2j7kjO7q+jW9bmgrGCWWAvgMcKCfg
	 EP6ngdnbGtqaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F6AC3ABD7;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 15:46:45 +0100
Subject: [PATCH v5 2/7] clk: clk-axi-clkgen: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-axi-clkgen-limits-v5-2-a86b9a368e05@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747061206; l=659;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/HIQW7i7xy9rSNcN8n33vnPmXH+zPymhP7sV+jmjYCI=;
 b=UkbeSD8ZNQWnYCPH/yXBgvChQpIOfNybfAOgTFpWjJvyOUqtnAR4FWPD9eIRfJA2znSmn3TSj
 hsP6zChynleC4CmzX7FIjBpHOaNJ6emk0aFBdQ7bdtLkRX47wF3PZ1h
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The mod_devicetable header is the one to be used for struct
of_device_id.

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



