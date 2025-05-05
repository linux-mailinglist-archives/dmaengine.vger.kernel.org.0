Return-Path: <dmaengine+bounces-5066-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D168FAA9BE7
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1663C3BED30
	for <lists+dmaengine@lfdr.de>; Mon,  5 May 2025 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B825D53B;
	Mon,  5 May 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="BObpQanz"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D751D54EE;
	Mon,  5 May 2025 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470985; cv=none; b=PBSTRIP5MTrwLbxj1acPyN3vokv4LSFPk8Ewt2cC0RVHxpFrlWYaJgyXMMy3Un9tD80abtRSefBwQFlu0dOlhZ42JDCP4MbXBNKhY6YwlfTwXbRu4cNXB2MNd7ION77XI0CmiNJooKSvGJdQXC5yhDFOXv7qzyTEsTlc3aOqQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470985; c=relaxed/simple;
	bh=T6Ncts6N/Z58qzqhIEes9iZ3oovStagca0bRASPa1Kk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YInFQ87yR5qMcrX7qNis1q/JGbrXC+Th5DCHx1z44PR8s0WNSCkUYG0mDB9Ida9PcMme5cCDbfC/M1NRacqYjXdEOUvrmeOyT+9DyIlorcZwRt6G/Taalwbm7oJL4R5HiMKj9gu4ILCALn3mDOUw1kYCzV96NWz6vUDUi7niO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=BObpQanz; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8C8FFA075A;
	Mon,  5 May 2025 20:49:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=R/6cNWBETRGF/BzVYwj3W2JbTh79XOgcLvtKJ6KLVXg=; b=
	BObpQanzbwc2zx5Bu3udvjAbucVfX4D/BXajPDzK3MyuHoeKcV1xgftTvPwlcMRB
	MPndqU2RX12hVVuCKclMxGeYzm5kKS0c42zJ/SBUrkMGAvEwegqPeR6Q2QX5PRL/
	Z02zXsysnmiSuTQxkBlvVpWjK2/oOUf8vRteUH9cyF2F+4hqcA+aLc1/+dnYbVRm
	Sx2D6zaiitgFZyuGJ5uaQ65MyAXVK/NnPmS0FY9+TzB1UMqoeOPrttxAh2P6fvJB
	anFMv3xqWp87WgS2hD98LaEOpfh7t/BrqrE1rogd4qjgsY/WMRXPhryHLA3Cy8+F
	Qe9Wayzh1bLCqFDgaX0VTa0uUno1zZ/yhV0WJ6zrLMjqYgkyv19uI1W8v+fOPAmU
	5o/Ev1QDu5Rilik81hRxL6bBsWrlXU7mLNqIXNTXqB0EaawFTkXOT4kWzbANZ98W
	5TJ/jS0B4xHZKrwZG35fa+g8IExUYOuSZ7DFpKnZxbducb00D3HGUKMQ7q3FanKn
	+rONFBMoGRBERKlOt50zFn9g5/weDnon5z+mXUkBlHHPvWytXmqzJ+se4C38uowL
	75t9mQguYsVxtdSEgr+EGqdxjKWfEwqebXlcGpewkUiedyCQlHgLQ4C0f/YKDFjT
	KqeuZaPCZFgHujwRxQfaO2XRP/M2pwUFOymTbTYAKiM=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>
Subject: [PATCH v5 0/2] Add `devm_dma_request_chan()` to simplify probe path in atmel-quadspi.c
Date: Mon, 5 May 2025 20:49:32 +0200
Message-ID: <20250505184936.312274-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1746470978;VERSION=7990;MC=3789806188;ID=217951;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94853667166

The probe function of the atmel-quadspi driver got quite convoluted,
especially since the addition of SAMA7G5 support, that was forward-ported
from an older vendor kernel. To alleivate this - and similar problems in
the future - an effort was made to migrate as many functions as possible,
to their devm_ managed counterparts. Patch 1/2 adds the new
`devm_dma_request_chan()` function. Patch 2/2 then uses this APIs to
simplify the probe() function.

Change in v4:
* split PM imbalance fix [1] and DMA cleanup [this series]

Patch 2/2 is to be applied after the PM imbalance fix [1]. Patch 1/2 can
(and should) be applied immediately, to a for-6.16 branch.

[1]
https://lore.kernel.org/lkml/20250327195928.680771-2-csokas.bence@prolan.hu/

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
v4:
https://lore.kernel.org/lkml/20250317135340.382532-1-csokas.bence@prolan.hu/

Bence Csókás (2):
  dma: Add devm_dma_request_chan()
  spi: atmel-quadspi: Use `devm_dma_request_chan()`

 drivers/dma/dmaengine.c     | 30 +++++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c | 44 ++++++++++---------------------------
 include/linux/dmaengine.h   |  7 ++++++
 3 files changed, 48 insertions(+), 33 deletions(-)


base-commit: 70cb3b9a371fe9ff4f50cd7889763abd4ab621dc
base-tree: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
prerequisite-patch-id: e698614397eaaf4da550babe05eea26b7ebbfe39
-- 
2.49.0



