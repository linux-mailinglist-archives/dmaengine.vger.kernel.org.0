Return-Path: <dmaengine+bounces-4756-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833DAA651E0
	for <lists+dmaengine@lfdr.de>; Mon, 17 Mar 2025 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58497A711A
	for <lists+dmaengine@lfdr.de>; Mon, 17 Mar 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A04123FC74;
	Mon, 17 Mar 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Tr2NgHJA"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172323E34E;
	Mon, 17 Mar 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219637; cv=none; b=RuPoYEpw68Q+n1Ha9POaQF9KIkUFyPyPZDGira/iFx8CyVpzBtFTtkmMv80INHiU5aYNqZFnVBSmzbAx2oXbFVD6vizulLjckyxSVAH7XUAt4zoq+QGdr1l+qG6K+dITWmNv+hvLKh0iIvprortvhKNyFbKw2Kug4XR1E1NGnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219637; c=relaxed/simple;
	bh=TzVF+VseBxemugrIi5lFGtBk9lTNgeveFOacPZEDCbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PtzWeO2AJhaqqL0KTgftD9gPMten5zo/obnKHGufVVBcsAmj5D4jdOB4PqhW8fWBDNNNEwSCuGAC2xFs/7MRUnC9s1MiQb6QjxFgbkLr8UpQ0PDgcPWXEOPRXH4T+B2qufhZCFVyTGmklb9j7RD+VssQwU6h9xeb1wJpgp2gfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Tr2NgHJA; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7735FA02E3;
	Mon, 17 Mar 2025 14:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=vW45Eevfr0UBpOE/gxMFRs6QWIzi9YcGFWpOxweiOQ0=; b=
	Tr2NgHJAnGKpz9P0iyFjnrROvAJyRjVeWKR9vlIQaJKhiPEFUrelC8+I9yzOoiGI
	3Ws2+hWl9K58e4Rg1v0W/PxXLJQ4NxVI6T7iP1ek+TTudAWc1c4pGnmt3ARadCOE
	v9chae1nxG56/rAMnKAGsDiVjgcChUT22/q0vPkH1Pms+zucbNJdmr8pYa8hskzN
	2ha3KNPcn4z8W5WRGrQ0Shg7hA+ZqtcsFCZNi6kEERIjwghckmKubPIe5qkzCONF
	R+ysD4VmglioFko0tF5aRtYqtnyUUC12lq4JON/M4Rvl6fx7+YwOlUSG3A7KsHm4
	x3x7RbXYAo7+BZ/uOB2u2CZPPwemSKGhvYmjBkrbCIOa2xqM9CmS90JcjRSl6Zab
	aEnPdts8ERakkAqylGyHE6NYrXquACPMd8I5KydCDh5GBFA6YfAIiUFiPdmnuRze
	aDnv1KPQFqtywWzrWbNT10/mzAfTwJemyb1+GEYLQi4avksOR/nJnoBdzfBDI3/h
	84qbOMe6Vn0sTV/vSTQcreA2Q1wEL9LtmDN2LfpQj0UtCiih5hSdk+99UTBYju/g
	QURzWniqfeGv3b5YfMgPbIVhymPQULQOhhvQjkkHmkdNEluZ2pLW40Dv76vcOXey
	lkCmzigsGLKv1JEhTln3bmMHKu9cSnYmX+OsfbWSErY=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To:
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, Alexander Dahl <ada@thorsis.com>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] Add `devm_dma_request_chan()` to simplify probe path in atmel-quadspi.c
Date: Mon, 17 Mar 2025 14:53:36 +0100
Message-ID: <20250317135340.382532-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1742219629;VERSION=7985;MC=71617524;ID=155895;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD948526D7460

The probe function of the atmel-quadspi driver got quite convoluted,
especially since the addition of SAMA7G5 support, that was forward-ported
from an older vendor kernel. To alleivate this - and similar problems in
the future - an effort was made to migrate as many functions as possible,
to their devm_ managed counterparts. Patch 1 adds the new
`devm_dma_request_chan()` function. Patch 2 then uses this APIs to
simplify the probe() function.

Change in v4:
* split PM imbalance fix [1] and DMA cleanup [this series]

This series is to be applied after the PM imbalance fix [1].

[1]
https://lore.kernel.org/linux-kernel/20250317093445.361821-1-csokas.bence@prolan.hu/

Links to previous versions:
pre-series:
https://lore.kernel.org/linux-kernel/20241222141427.819222-1-csokas.bence@prolan.hu/
https://lore.kernel.org/linux-kernel/20250114222851.1023194-1-csokas.bence@prolan.hu/
v1:
https://lore.kernel.org/linux-kernel/20250115160244.1102881-1-csokas.bence@prolan.hu/
v2:
https://lore.kernel.org/linux-kernel/20250124085221.766303-8-csokas.bence@prolan.hu/
v3:
https://lore.kernel.org/linux-kernel/20250207124802.165408-1-csokas.bence@prolan.hu/

Bence Csókás (2):
  dma: Add devm_dma_request_chan()
  spi: atmel-quadspi: Use `devm_dma_request_chan()`

 drivers/dma/dmaengine.c     | 30 +++++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c | 44 ++++++++++---------------------------
 include/linux/dmaengine.h   |  7 ++++++
 3 files changed, 48 insertions(+), 33 deletions(-)

-- 
2.48.1



