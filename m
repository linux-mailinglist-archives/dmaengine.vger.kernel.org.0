Return-Path: <dmaengine+bounces-6457-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB5B53E3B
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 23:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D98AA6524
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 21:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779D2E6CB2;
	Thu, 11 Sep 2025 21:57:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBB2E5B08
	for <dmaengine@vger.kernel.org>; Thu, 11 Sep 2025 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627823; cv=none; b=LrP3OQphqOQ63Zup2xb7ukq0JSgYBuKtCkQfNkq2+59+5UluQDD1IukQJlSW7PsrZJDyiRnDGcuAbBhafzPGR56kO9YI1qV7LDbI/3N9jOy7ZtkSGNzymZs9Sdonwm9lqbytsUyGa3vb89HLmBHb2eG1ZdhU6xb8VuQqabzC4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627823; c=relaxed/simple;
	bh=JArEK4n+a/w0HvNnxmxDlCIQJnQfiMESKmv6ycA8i+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HI0ev06Mpu4AJR8Il+SSqPafuknmtUHZfZGtgpDpV2VFPZA6jYtykOhO7Z6tAZhm/rrqq2hga3VNfmQOiIGOEUMJe4wjCjgsdyiMI90z4zuXbEMVdvm0dy2d+u9XLtGGdPe8P42faRflm5rf/12ean+gFJ6PCYjb3JPSUM4j1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpHd-0004g5-VH; Thu, 11 Sep 2025 23:56:49 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 00/10] i.MX SDMA cleanups and fixes
Date: Thu, 11 Sep 2025 23:56:41 +0200
Message-Id: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpFw2gC/32NOw6DMBAFr4K2zkbGJPyq3COi8GeBLWIjm1hEi
 LvH4QApZ6Q3b4dIgSlCX+wQKHFk7zLISwFmVm4iZJsZpJB30YkKU41ljatf2GC0L4U304620lo
 0VQt5tgQaeTuTzyHzzHH14XM+pPJn/8RSiQKVabTSteyo1Y+F3PReg3e8XS3BcBzHF7H9iEO1A
 AAA
X-Change-ID: 20250903-v6-16-topic-sdma-4c8fd3bb0738
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Hi,

by this series the i.MX SDMA handling for i.MX8M devices is fixed. This
is required because these SoCs do have multiple SPBA busses.

Furthermore this series does some cleanups to prepare the driver for the
upcoming DMA devlink support. The DMA devlink support is required to fix
the consumer <-> provider issue because the current i.MX SDMA driver
doesn't honor current active DMA users once the i.MX SDMA driver is
getting removed. Which can lead into very situations e.g. hang the whole
system.

Regards,
  Marco

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de
- Split DMA devlink support and SDMA driver fixes&cleanups into two series
- Make of_dma_controller_free() fix backportable
- Update struct sdma_channel documentation
- Shuffle patches to have fixes patches at the very start of the series
- Fix commit message wording
- Check return value of devm_add_action_or_reset()

---
Marco Felsch (10):
      dmaengine: imx-sdma: fix missing of_dma_controller_free()
      dmaengine: imx-sdma: fix spba-bus handling for i.MX8M
      dmaengine: imx-sdma: drop legacy device_node np check
      dmaengine: imx-sdma: sdma_remove minor cleanups
      dmaengine: imx-sdma: cosmetic cleanup
      dmaengine: imx-sdma: make use of devm_kzalloc for script_addrs
      dmaengine: imx-sdma: make use of devm_clk_get_prepared()
      dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma_device
      dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma-controller
      dmaengine: imx-sdma: make use of dev_err_probe()

 drivers/dma/imx-sdma.c | 181 ++++++++++++++++++++++++++-----------------------
 1 file changed, 96 insertions(+), 85 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250903-v6-16-topic-sdma-4c8fd3bb0738

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


