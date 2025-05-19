Return-Path: <dmaengine+bounces-5199-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0DFABC2F2
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EB317A1B0
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA832868AB;
	Mon, 19 May 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpdsjUGE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FF27FB36;
	Mon, 19 May 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669827; cv=none; b=Bn3XZvX9wChWhNxsmXmCJjgBxspeljwJJqyMj+T1rIJlZunBtJ3+nRFjkFWFLSU2jwDA1oaLv4JT7pszFSVm8jZ1PHVYpAaII+4sSAowqn3dmSqZnvM5Xu50GvDn/nQ2LuVF2+IBVu21uiK0bGxEOol+pG9CoW19LFqSGG2fAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669827; c=relaxed/simple;
	bh=7f0ImEZdmQ4sVUUr9o8k+aVzij3X3LUT7iulVIHgJHQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QKJco1QgR4LWsNjVm+r6mhAVznw5z6tF9Wp10zWaZdQeJHMHeR4IW7edIIuzgGzQzGzofAFzPRenxskl+Tyxjyl5/K0DLEZJqTVH+RfKcInowlSFSLj1ei5bj4jMPtQMAwNZU3wX0fuwHVDcu0j5htk4cVbJ3/69yIHJcpvC71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpdsjUGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E56F9C4CEE4;
	Mon, 19 May 2025 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747669827;
	bh=7f0ImEZdmQ4sVUUr9o8k+aVzij3X3LUT7iulVIHgJHQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EpdsjUGEp5rIIckMYu1aM2uuyC3aCgch0AmgEB8MiR1gCIzurpNwhuGUdCJajDdJF
	 9sMEiELXWKgsdn/kLhMrjgNpzk1cp0fByEbzZmGUM59tpqTNE/x6c/Eo5O+/q1pGv4
	 yztvY574y6fo0VFjGS1WKHaOpfxjKxOSh253SRlqdBcAAe4RsxigCjEBGSqAbYZmNT
	 2LwuiriLKV4ubVENl09Wrb/FL/YXGfM52aE1AhELb4PXL4/L7kxF+USNVnAXcMqk7J
	 tFogYFZOhaCzM642SvEfYrGieswtPtPJ2PO/boazLj0ck7X8wvs+Va/FzOxr0XMfar
	 CHxCIIyXrZVlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DDC2D0CD;
	Mon, 19 May 2025 15:50:26 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v6 0/7] clk: clk-axi-clkgen: improvements and some fixes
Date: Mon, 19 May 2025 16:41:05 +0100
Message-Id: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABFRK2gC/33QQW6DMBAF0KtEXseVZ8Y2OKveo+rC2AOxSqCCC
 KWKuHtN1IpUiMqrb2me//guRh4Sj+J0uIuBpzSmvsvBHg8inH3XsEwxZ4EKjUIoZeRJ+luSof1
 ouJNtuqTrKC3VlQqGA5WVyLOfA9fp9nDf3nM+p/HaD1+PZyZYbn9FtyNOIJVEWxdcgw7RhVff+
 bZvXkJ/EQs54coQ0B6DmYGCPKOPlgA2DK2MVsUeQ5khCkWNRXDRumfm+PM9GuG/cY2KKl1zxOA
 2LfTaIp89Ri8tfDSAmsHxdhnzxADuMSYzvrSV82RLVuYPM8/zN3zgUU8WAgAA
X-Change-ID: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
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
 Mike Turquette <mturquette@linaro.org>, Xu Yilun <yilun.xu@linux.intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747669828; l=1918;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7f0ImEZdmQ4sVUUr9o8k+aVzij3X3LUT7iulVIHgJHQ=;
 b=N4/7QPa94o9EyM9f/xBKR/7JgbVeaFY327xya7hTMLcla4UekqHjzjjybKnA67iuvwLOcB0qQ
 9W4h93MDTXVAoyRtir588nRc2q1f9XpEB/sNogId0cu3hwH9+MoKWHL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

This series starts with a small fix and then a bunch of small
improvements. The main change though is to allow detecting of
struct axi_clkgen_limits during probe().

---
Changes in v6:
- Patch 3:
 * Don't add adi-axi-common.h in axi-clkgen (not needed at this point);
- Patch 5: 
 * Add adi-axi-common.h now.

- Link to v5: https://lore.kernel.org/r/20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com
- Link to v4: https://lore.kernel.org/r/20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com
- Link to v3: https://lore.kernel.org/r/20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com
- Link to v2: https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com
- Link to v1: https://lore.kernel.org/r/20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com

---
Nuno Sá (7):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
      clk: clk-axi-clkgen: make sure to include mod_devicetable.h
      include: linux: move adi-axi-common.h out of fpga
      include: adi-axi-common: add new helper macros
      clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
      clk: clk-axi-clkgen move to min/max()
      clk: clk-axi-clkgen: fix coding style issues

 drivers/clk/clk-axi-clkgen.c        | 159 +++++++++++++++++++++++++-----------
 drivers/dma/dma-axi-dmac.c          |   2 +-
 drivers/hwmon/axi-fan-control.c     |   2 +-
 drivers/iio/adc/adi-axi-adc.c       |   3 +-
 drivers/iio/dac/adi-axi-dac.c       |   2 +-
 drivers/pwm/pwm-axi-pwmgen.c        |   2 +-
 drivers/spi/spi-axi-spi-engine.c    |   2 +-
 include/linux/adi-axi-common.h      |  56 +++++++++++++
 include/linux/fpga/adi-axi-common.h |  23 ------
 9 files changed, 174 insertions(+), 77 deletions(-)
---
base-commit: 82f69876ef45ad66c0b114b786c7c6ac0f6a4580
change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
--

Thanks!
- Nuno Sá



