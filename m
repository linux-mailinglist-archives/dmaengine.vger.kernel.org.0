Return-Path: <dmaengine+bounces-5055-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B3AA9984
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560A518844EC
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43235266577;
	Mon,  5 May 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLLkMQhX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347E1F582C;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463298; cv=none; b=kAhx/gMrLHS8c9qzjdsieUh4590QOyxFtLD/0Eszw4G3eXZ/DW5kpgU4ZxNrTMVoYdSP6gkoa6Fw4l4EApsZlwxsW19Gb14bpbu5+VqMr8jX/MlCVhluGNAud3Ydf+W5z8e/SmDX/7386M7L3klf5RfMQsNzN8n/pLOEoyza3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463298; c=relaxed/simple;
	bh=UfQERZUmaMDG9Xd7FBgSPsejb+n6JanVqO6qHKkPXWI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pcl9CKMt67yG+ueAfh+HDcInoEAeDiuS4sSrAKBWeawaWwYnV2CMjh9QDEVtp+om5+2J+CBy66m8+zPura1uYe0w/p+bSRbpCKZcjyAboPDL3pw/i/CIXR9Fo9Zo2dOAMHJ23eMraorw+SigBSG6yTnjnFxL/eSzawcGgbp8s48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLLkMQhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AAE4C4CEE4;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463297;
	bh=UfQERZUmaMDG9Xd7FBgSPsejb+n6JanVqO6qHKkPXWI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QLLkMQhXGRrYaichtMt3PsfOO5R4nvUwZwheN/0/oeyOg6LmILv/VNWiO271sFJ4t
	 Sf23j8UPhNz51f9eOBxYvjWZoKD5DwwyTRLLvh5GNOhJF+gooETXHvXSVP+RL90Sct
	 bIyCwdcU3/vSoJKff6Ejhj3XWUra+zPIOB2SfNeZRHlkU1bVSe9pcENvKsQhTFFquu
	 AX0ZlXK9Xxr40e9KewDVhfEW3x7Ol/dZNj9dZpGCa3XTUBR/9kvSMvZhMyB1eDFuX4
	 LH2v+E7vO+KQIGZkbFV0uBVgCADQvOZHVHU3vLJ0+/T+gp7s/Tn9tgA2wFORfaYBn9
	 zEVV2bV6dPB9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924AC3ABAA;
	Mon,  5 May 2025 16:41:37 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v4 0/7] clk: clk-axi-clkgen: improvements and some fixes
Date: Mon, 05 May 2025 17:41:31 +0100
Message-Id: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADvqGGgC/33QQWrDMBAF0KsEraMizShW3FXvUbKQRyNnqGMXK
 4iU4LtXCS1pKe7yD/z3Ya4q8yyc1fPmqmYukmUaa3DbjaJjGHvWEmtWYGBnwO515KLDRTQNbz2
 PepCTnLNuMHWGdky471Ttvs+c5HJ3Xw81HyWfp/njPlPs7fottitisdpoaJLnZB3Fll7CGIapf
 6LppG5kgQeDFtcYqIz1GBhCbNDaPww+GGf8GoOVQSSfwFMbm/Yns/16jwP7X92Bwc4ljkC/6od
 lWT4BukOctYgBAAA=
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
 Mike Turquette <mturquette@linaro.org>, Xu Yilun <yilun.xu@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746463295; l=2004;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UfQERZUmaMDG9Xd7FBgSPsejb+n6JanVqO6qHKkPXWI=;
 b=0lBYprgJYebAK6Horu/uWNWFd6GFkQ2PlVGU3azekb21t7s2fu46YHefFGLmf+R3vr3EO1NTk
 FlsW+6os/PLAa3EvuOgo6vyQW+638w2qt+0t0GIGgVEhUjKWDI1Mr1X
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
Changes in v4:
- Patch 3:
    * New patch to move the adi-axi-common header. 
- Link to v3: https://lore.kernel.org/r/20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com

Changes in v3:
- Patch 6:
    * Revert change and parenthesis back on 'if (((params->edge == 0) ^
      (frac_divider == 1))'. While checkpatch complains, it's more
      readable like this and in some configs we might even get -Wparentheses.
- Link to v2: https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com

Changes in v2:
- Patch 3
   * Rename adi_axi_fgpa_technology -> adi_axi_fpga_technology.

- Link to v1: https://lore.kernel.org/r/20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com

---
Nuno Sá (7):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
      clk: clk-axi-clkgen: make sure to include mod_devicetable.h
      include: linux: move adi-axi-common.h out of fpga
      include: fpga: adi-axi-common: add new helper macros
      clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
      clk: clk-axi-clkgen move to min/max()
      clk: clk-axi-clkgen: fix coding style issues

 drivers/clk/clk-axi-clkgen.c        | 147 +++++++++++++++++++++++++-----------
 drivers/dma/dma-axi-dmac.c          |   2 +-
 drivers/hwmon/axi-fan-control.c     |   2 +-
 drivers/iio/adc/adi-axi-adc.c       |   3 +-
 drivers/iio/dac/adi-axi-dac.c       |   2 +-
 drivers/pwm/pwm-axi-pwmgen.c        |   2 +-
 drivers/spi/spi-axi-spi-engine.c    |   2 +-
 include/linux/adi-axi-common.h      |  58 ++++++++++++++
 include/linux/fpga/adi-axi-common.h |  23 ------
 9 files changed, 169 insertions(+), 72 deletions(-)
---
base-commit: 82f69876ef45ad66c0b114b786c7c6ac0f6a4580
change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
--

Thanks!
- Nuno Sá



