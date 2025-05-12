Return-Path: <dmaengine+bounces-5133-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B3AB3B07
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0461888D3E
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237F21578F;
	Mon, 12 May 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVesmxv4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976A19C569;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061206; cv=none; b=U3knhArpRhWjdL4eLqEQdGnrLO8iBtylLznEWr8efW31XRBCrkfzShKoLYZNbpt6Kh+fvC8oN2S0jl//3adVGcni9wf0H3WgUumUqjE5G4vTx+wRQShDU5r2nFH5N8bXuL35oyzyJclFwBmHGHZlvahu0H0ZLPTyaFAxwfWSxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061206; c=relaxed/simple;
	bh=JkM/nxZuW8/XtDWXx2zZGIoDGGsavYmJRK+QqVbajJI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M5BGeECu1KqY2S0YDApWtvXEZD25at8GEjYYRvLzyP57T10EJj1Bkh3iE5Xy6kqp5YlngaoyfdAlforSkrXy1rKYRgMNu38KYrFLYdnqO8EOwHvmnHtYyQ3I+SnMZm+wmsFCXE2A02CMRqX1qENDE2DU+/V1glArAv1DJJfsyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVesmxv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C07CC4CEE7;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747061206;
	bh=JkM/nxZuW8/XtDWXx2zZGIoDGGsavYmJRK+QqVbajJI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MVesmxv41We+7F72e7PtVsvCBvv91s5xU5hCghkJoW8SO/YIDgxAWNOavgcR6BYFz
	 uJ6zl9RAXK6EI8VMqrm9dxFqWFj0khKCuaV6A5EuYJrgt6ACQ3B3txKq/+HDn8e/Si
	 84q5k8oHvtxItigKhH55sMQalbQBJoPKa/ZnQ3Ru0Oy+fTBdoajfyaw7+aKXIrJXOD
	 7AUcIc38xNq5gandCeQSIyjLQfACunq5bOIrl7U3OHR/XKq0iFwaYK4cP0AU3bOdok
	 Uk5geLw0ojo/lAiX+Gxc5W9oIxNc9hEVBTBcQKzrdvChf/90uj5jTnBsefdjb4OnZv
	 jj+4bV/ouy6JQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EB2C3ABC3;
	Mon, 12 May 2025 14:46:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v5 0/7] clk: clk-axi-clkgen: improvements and some fixes
Date: Mon, 12 May 2025 15:46:43 +0100
Message-Id: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANMJImgC/33QQW7DIBAF0KtErEPFzGA7dNV7VFlgGBxUx65Mh
 BJFvntx1MqtIlesPtI8/nAXiafISbzu7mLiHFMchxKq/U64kx06ltGXLFBhpRAO0nOW9hql6z8
 6HmQfz/GSZE2hVa5iR4dWlNnPiUO8Ptz3Y8mnmC7jdHs8k2G5/RHNhphBKol1aDiAdt64NzvYf
 uxe3HgWC5lxZQhoi8HCQEOW0fqaAJ4YWhmtmi2GCkPkmoCNM742v5n99/dohP/GNSpqdWCPzjy
 10GuLcrYYvbSwvgLUDIb/LjPP8xf9wCNvzwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747061206; l=1903;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JkM/nxZuW8/XtDWXx2zZGIoDGGsavYmJRK+QqVbajJI=;
 b=hHrYNf5zdtiVEfAwcvmOhlMT+ZU1AkRzIsgLoiDGry69CjKzUCbhlVY0RfXmGxN4pKrc5pVmC
 ZcKXEopQJzqAX+m/sI6uEaAxg/7M2jXGpKgRMURR4Of1Orfqswj7jOQ
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
Changes in v5:
- Patch 5:
  * Drop voltage register from common header (not common);
  * Drop 'fpga' from the commit subject.
- Patch 6:
  * Define voltage register here.
- Patch 8:
  * Sort headers in alphabetical order.

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

 drivers/clk/clk-axi-clkgen.c        | 160 +++++++++++++++++++++++++-----------
 drivers/dma/dma-axi-dmac.c          |   2 +-
 drivers/hwmon/axi-fan-control.c     |   2 +-
 drivers/iio/adc/adi-axi-adc.c       |   3 +-
 drivers/iio/dac/adi-axi-dac.c       |   2 +-
 drivers/pwm/pwm-axi-pwmgen.c        |   2 +-
 drivers/spi/spi-axi-spi-engine.c    |   2 +-
 include/linux/adi-axi-common.h      |  56 +++++++++++++
 include/linux/fpga/adi-axi-common.h |  23 ------
 9 files changed, 175 insertions(+), 77 deletions(-)
---
base-commit: 82f69876ef45ad66c0b114b786c7c6ac0f6a4580
change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
--

Thanks!
- Nuno Sá



