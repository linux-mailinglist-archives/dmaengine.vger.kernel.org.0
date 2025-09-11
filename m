Return-Path: <dmaengine+bounces-6468-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD70B53E6D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 00:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7544C5C028B
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B034167D;
	Thu, 11 Sep 2025 22:00:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C82D24B9
	for <dmaengine@vger.kernel.org>; Thu, 11 Sep 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628052; cv=none; b=ZBPNxUfVpNOi+McNMZSPg6Z5WWDLoIF8mYDBUHOIAEzLETg8V8e/JKrvxLDg03KQtlST3f+NMCiAsoG5KWY/avWpZJfUe0bE5y3lgS28n7WjWs10jSmLRBJ8u0AsePhamGM7LXzjFB9RwvD9JXU5S3M5pgUTN8TrrFON4thmvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628052; c=relaxed/simple;
	bh=Qe1ANLg+UbG618GCGlFDMXEswSaHkopjm3ovDaNBe4I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nujEozHCOnkyuFHOtJfLcj7fM29gslB6Tn7/KbsX+EMTg/43HyBTpHfxEPW5SwSC7yhEd1zhZ0I0ablozYIALVR/QFjnVaJ5OQcchPbKQ2q318kWc0OHu2aXSG8PvnI2qMjeBtm/rJDRk5u4Wc1xPm6hu0fv9ia937HrNu/qEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwpLU-0005sG-JT; Fri, 12 Sep 2025 00:00:48 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 0/2] Add DMA devlink support
Date: Fri, 12 Sep 2025 00:00:40 +0200
Message-Id: <20250912-v6-16-topic-dma-devlink-v1-0-4debc2fbf901@pengutronix.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIhGw2gC/x2MQQ5AMBAAvyJ7tsmWEHxFHKpdbFDSSiMRf9e4T
 DKHmQcCe+EAXfaA5yhBDpdE5RmYRbuZUWxyKKioqFWEsUZV43WcYtDuGi3HTdyKRGNDpal0IqT
 69DzJ/Z/74X0/4X5UwGkAAAA=
X-Change-ID: 20250910-v6-16-topic-dma-devlink-00b803c5a803
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Hi,

this is a new series which was previously part of [1].

While debugging the i.MX SDMA driver we noticed that the driver doesn't
honor current active DMA users. So the supplier (dmaengine) driver can
be removed before the users are removed. This cause use-after-frees
failures and the whole system is frozen.

To address this the Linux devlink support is added to the dmaengine
framework. This series uses the managed devlink support which ensures
that the users are removed first before the supplier is removed, which
is the main goal of this series.

Managed devlinks require that both link devices are backed by a driver
(of course). Therefore this series uses the dmaengine device as devlink
supplier device and _not_ the dma-channel devices. The dma-channel
devices are virtual devices which don't have a driver.

Frank Li already mentioned that dma-channel devices should be used to
gain a more fine grained runtime-PM support, e.g. to control clocks for
each DMA channel. This would require the devlink to be STATELESS.
Stateless devlinks don't ensure the correct device remove order (main
goal of this series).

Having a more fine grained runtime-PM support (for each channel) is
valid, but IMHO this is rather an addition to this series. The support
for this use-case requires that the dma_devclass implements the .pm
hook. This hook would need to call into the dmaengine driver to perform
runtime-PM on the dedicated channel. This also requires a HW which
supports clock gating for each DMA channel.

Regards,
  Marco

[1] https://lore.kernel.org/r/20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de
- Split series into SDMA cleanup&fixes and this DMA devlink support
- Add dmaegine flag to create the devlinks
- Update the kernel doc
- Update commit message

---
Marco Felsch (2):
      dmaengine: add device_link support
      dmaengine: imx-sdma: fix supplier/consumer dependency handling

 drivers/dma/dmaengine.c   | 15 +++++++++++++++
 drivers/dma/imx-sdma.c    | 15 +--------------
 include/linux/dmaengine.h |  3 +++
 3 files changed, 19 insertions(+), 14 deletions(-)
---
base-commit: 1b6bf726c96272139c2b20db3bee4c22c869a22b
change-id: 20250910-v6-16-topic-dma-devlink-00b803c5a803

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


