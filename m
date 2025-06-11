Return-Path: <dmaengine+bounces-5372-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42602AD5BA4
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F53A6CFD
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495A202976;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izrdkLHp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9974059;
	Wed, 11 Jun 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658528; cv=none; b=N6GqOjIeFokWhybNQRJJF2f06qzszCWQVf8RRoBrMYKoluRWAdr9cLy7L5GXk21SjSz/mZtVnka7jVXCnRO1WUvFWrIfBJW/9GMjJFGOk8zXw/lCzSYOARG3YnP3wEV6BesAV9pnK+u4qTh2KCfnnYvWLCTx7kPHpwJUUkD3ZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658528; c=relaxed/simple;
	bh=LcRIuFbM1cuh0iJM4xeVjUdgUfBnzrnn8Y4VYEQkqDg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N68FYa4ojrf25zQ66BuQ4sOewSLyiuZUTyztkwFbTWWkcpeCiDF+eckWvnMyBKKFOviluAC/avtjPdHnSjCgpYqhtDm8201xLcS7QLlOvKN6ceHBdeZXhCaXzQ/rSMF/Cd1JPhXColwMquAr2IZKKCrTgh3+rDHnHykfsLbFpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izrdkLHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83BD9C4CEF0;
	Wed, 11 Jun 2025 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658527;
	bh=LcRIuFbM1cuh0iJM4xeVjUdgUfBnzrnn8Y4VYEQkqDg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=izrdkLHpCp7KDqJZeWV03eR2yrZKoS/xUuvzjv+L1amUILi6Z1txNoqr2TVAnVCk3
	 nP/vk9f9hmYd2gmO+86S0XWlP+fgIlXzdu8AShY0Yx2FbqbF5KlqG+IpxnjPlKSSLq
	 CQ69u95ACgJuzZtGHy3q3p2+ppCwR+jtjqtBQL66FePVjCflozzBn2SwVr7pRg7lwQ
	 qEC9tAQsa8JDzc7jH9p8ZUYpPINvzJxCvNRus9ICy92j0ZujKDLSPDXLMLUoRXy0CO
	 CuYHYtPKquLdbhCH9ucFtunYwGo6Sv/iMQL0eKeqvHuEQ1kFtWFroFa40Nr1p0ULFc
	 9iYJ5lPS93nwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76127C71131;
	Wed, 11 Jun 2025 16:15:27 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v7 0/7] clk: clk-axi-clkgen: improvements and some fixes
Date: Wed, 11 Jun 2025 17:15:32 +0100
Message-Id: <20250611-dev-axi-clkgen-limits-v7-0-3e7ff89dc366@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKSrSWgC/33RTWrDMBAF4KsEraOimZFlK6veo3Shn7EjmtjFD
 iYl+O6VQ4tdjItWTzCfnqSHGLhPPIjT4SF6HtOQujaH8ngQ4ezahmWKOQtUWCiESkYepbsnGS4
 fDbfykq7pNkhDtVeh4ECVF3n2s+c63Z/u23vO5zTcuv7recwI8+6vaHfEEaSSaOqSa9Ah2vDqW
 nfpmpfQXcVMjrgwBLTHYGagJMfooiGADUMLo1W5x1BmiEJZYxlsNHbNHH+eRyP8N65Rkdc1Rwx
 200IvLfLaY/TcwsUCUDNY3l6mWDGAe0yRGVcZbx2ZilWxYcya2f0hkxkftCdvIELUf5hpmr4BX
 uAVi10CAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658534; l=1918;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=LcRIuFbM1cuh0iJM4xeVjUdgUfBnzrnn8Y4VYEQkqDg=;
 b=UdP/tocAWz8o+9vYBOVduAReLpWi575YBu7LlGCJxEas2urPks4ef/H+i0LSNSVjLCJvlmMfs
 CZHRMcT+yNOBy9thdxlzV4LX7k51YJ9uWydk/iUC0fi9v9DAaff1mIm
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



