Return-Path: <dmaengine+bounces-5660-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49610AEBAA0
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC61D3B9EC4
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134C2E8897;
	Fri, 27 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP/eyYe+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B572E7625;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036355; cv=none; b=PsywMAYwd8IIRhVK1+y+4DNb0xbWo9YTGQ0whr8rGuenpKdE6Vyeg9dwS3eRE69tdYtXUeNYgijz/zFXuPrz8+fSJ1yNLCFmsU/ouh6uQlFogNrNfQqp/F8u9df/Eloh5RlDFyi7DfHwGbH5qVPRkL57zbT8zt1XTyewI28ytk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036355; c=relaxed/simple;
	bh=IS+1lVLpNuNJ3U8UpcITAgJNJAxvYgVZbjciSjmZKqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d4ebaWa4guwb3kTTkN8J+qsxrRrf2sOobtzFWv2bVhnji4AvzO2OxBLQ14nU0ZjkPVJAdGAeqeny6cj+zhzvW0ORtswlH2tD3b9ERjxQGe1PE7d3CQu7qvuyj8SnD9FzB/HDWufoeiaa8ewiRtvAXkQn1E8X2HkOKU+A15iYcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP/eyYe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A29C4CEE3;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036354;
	bh=IS+1lVLpNuNJ3U8UpcITAgJNJAxvYgVZbjciSjmZKqs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aP/eyYe+9CrzSyqddtUv9A/6RBwBfw122L5dRpzI9jmdmPQDmTkHk44As+8KyNo2Q
	 GwJ1rn2yhRw8cuU9H4VZxkmLnPzZvQ4YTeGvz/EX7kTdAUKc6KHPpOZf6L1ADOBrKK
	 x00/qBsD0vPO/X0Q8yhlys+HGlHLYvCrtmbXiLE/9XZkrFzcbQCgjf6ibiPKNttbvR
	 EqcN7jgOJMGnFui2iC0AzSoB6/4xrT4LSx88t3hWLuZ7AyO11r8r3xlVW7/2zE6mbI
	 S+DVHRESiyJ5z3R3Er1ycexX24BHvJKR+9NQx09pIgz3v4zBJqNsSs33AHM8yX8dV9
	 rQ8VCkTcO3azg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7C6C7EE2A;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND v7 0/7] clk: clk-axi-clkgen: improvements and some
 fixes
Date: Fri, 27 Jun 2025 15:59:09 +0100
Message-Id: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036364; l=1954;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=IS+1lVLpNuNJ3U8UpcITAgJNJAxvYgVZbjciSjmZKqs=;
 b=S1oYs+xF+TEEEi33Vt7+HTiDO+9YZoqqBIaiuCBkKDWnQsuBXMxxlRhSaaQkUEB9yi+llghHp
 zRFO9EFcEzoAlc3UG0RgO7Tki8MV5bTaaAHaHi54uKsT6nv4jm4A0dK
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
Changes in v7:
 - Just include new tags.

- Link to v6: https://lore.kernel.org/r/20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com
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
-- 
Nuno Sá <nuno.sa@analog.com>



