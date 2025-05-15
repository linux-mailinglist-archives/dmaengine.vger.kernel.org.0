Return-Path: <dmaengine+bounces-5175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C0AAB80DA
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BF94C21C6
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3A629373E;
	Thu, 15 May 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="O09nBLGs"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259F157A48;
	Thu, 15 May 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297905; cv=none; b=RJfnoceon9mc+2Dr04MWSyxNspfxkmxiI1i/K20aBNXd44vZ48SaOHhnRiwGfKLJfOEiyLtTx10uJSZwUv2kU5IPrLZIznT+D6zi1qikqI+vF64YqjcYNMTNp1Ny4MGNjacRhSmzsfQp7Clb1QM7cIVFJFYAguydz5nZHzwlPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297905; c=relaxed/simple;
	bh=lBssOiQE3kFywGSEPhz6ZUZElYesnqsPZPHmWLEHSRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XuEnfnE3BSGHcNa/mDsIGjB1WbieVKqtXly3oaf8Vze3KE7uW5oLniJtyssMzgDXlsMKnvZSF5bzW5pFgX5ib/7Ch434fuNH0DWwksdtPeITZbNuMQU4MAv/bXHSYU/k9C0+TdDuyZmI7lNYF3zTyzEoYZ59LYDyzxnMclsQSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=O09nBLGs; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CC316A03AE;
	Thu, 15 May 2025 10:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=exUKHrABOcVDanDKzFLqgX6s1Ct1jDnN0Cf/z03HyVU=; b=
	O09nBLGsZL25o5Sdw9J7W0ZTbsXqYSxiZ1vduzlrtVKJdYj3YxyT6oP6n7LEY1ky
	PPRweJ2s1nPsudebivaroOmlMPDL3RrZO1KD/YU4mfilYRSNpIMhN2+OWCi/ZSSI
	JyYIz4pZaE/ebet0tsJEKKjtAtBRlGssiEEH9bvCE/87clbxlHLr8HmHGV9mzOdS
	Twznl8n5y7xqR20ogZn7n6gGEDOAobduJapuzjRFJe2dj1G234baibUUoVvjva1W
	o6ov/ydahEA9TG1yDHCfquwhCMHJgqj6+3ILRjtxuIymdsu+C0QtJ6ys5OmBbxnL
	Y5uOxAaPbcdlDoQbQq0Vzhs0MXIPPdlswc3O8uAmJe58R6+iyHWoITGUHs1IVXoI
	39tPA9TBQfNzZu4vK9fYJxd2PkvkGN3Zaz4DLpKY203JE/LxPTLKlHE5f2lRfU3c
	G0cqawzVtxsVJDhlKY+HLroby5KAJxBcjtCC7kMnxAIF5pMbLbOCksHf5sLwVm9I
	aV73unJFVdy7lc3+c1am/7oiICxtOzWd8cPI9wO6yXCvEWW+ZU2jnja4uOxZUIIB
	JED/gNTrqtF8Jp0uNIr6sUtp4VRo4V5b4NEjzrmfDw9gowFanxGaYTIGPIE2mIhl
	Y4e7x6rxCqQfMAjjNstKE52nA8tyGCMvQ2z1j9uAPtU=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>
Subject: [PATCH v6 0/2] Add `devm_dma_request_chan()` to simplify probe path in atmel-quadspi.c
Date: Thu, 15 May 2025 10:31:28 +0200
Message-ID: <20250515083132.255410-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1747297897;VERSION=7990;MC=2712727080;ID=2670053222;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29BB64155D617062

The probe function of the atmel-quadspi driver got quite convoluted,
especially since the addition of SAMA7G5 support, that was forward-ported
from an older vendor kernel. To alleivate this - and similar problems in
the future - an effort was made to migrate as many functions as possible,
to their devm_ managed counterparts. Patch 1/2 adds the new
`devm_dma_request_chan()` function. Patch 2/2 then uses this APIs to
simplify the probe() function.

Change in v4:
* split PM imbalance fix (now merged) and DMA cleanup (this series)
Change in v6:
* rebase to spi/for-next, see note below:

There is currently no difference in drivers/dma/dmaengine.c between it and
dma/next [1], therefore PATCH 1/2 should be safe for Vinod to apply. But
this way PATCH 2/2 is trivial to apply. I didn't want to pull the whole
linux-next tree, but if any ofyou run into problems, let me know, and I'll
rebase the series on it instead.

[1]
commit 3c018bf5a0ee ("dmaengine: idxd: Remove unused pointer and macro")

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
v5:
https://lore.kernel.org/lkml/20250505184936.312274-1-csokas.bence@prolan.hu

Bence Csókás (2):
  dma: Add devm_dma_request_chan()
  spi: atmel-quadspi: Use `devm_dma_request_chan()`

 drivers/dma/dmaengine.c     | 30 +++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c | 48 ++++++++++---------------------------
 include/linux/dmaengine.h   |  7 ++++++
 3 files changed, 50 insertions(+), 35 deletions(-)


base-commit: 6155cbfffd294bb267f053ec596ced41bcdb0986
-- 
2.43.0



