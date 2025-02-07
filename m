Return-Path: <dmaengine+bounces-4328-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B45A2C2FF
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 13:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FB63A4F60
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750071E5B67;
	Fri,  7 Feb 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="BytzGPT3"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD051DC99E;
	Fri,  7 Feb 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932491; cv=none; b=lhsBDRI8JFoY6Tg4SR0FAmUAzu4TFMN7tqE24LRE0mAISQU7lp7sm2Q6rg0kD8j4RP50d2/N6VfGO04OTIRpFEMnZsC5UGrSSf4SPTHS0P4f41eFYzF8dsnNQDKtU34r4teK/d1ST2md6aKU626ZyqKpiI2i94vHal2B7Df81Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932491; c=relaxed/simple;
	bh=Z7GlX4G3CLXl4PdntmkGapZgBz10huhVzZfNPwGxMJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dR9HmUdtU6WrndBEwJWzk623y4l2fw6GqaJcaTu+x5YpVYlLhDVp7PHmKmtFN/BVKHpJS/1dIjj8HccY3TaYgy/CfHF/IF6etyZZZ9hssKvwLN0W/tWFz0g57y5RhU5TKFNKnUAzJdmG1XVsKUkciarC22VyJxnEYeX7f3Hd978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=BytzGPT3; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9D100A037B;
	Fri,  7 Feb 2025 13:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=BCu/ryqDczot25TDMnKcJhaUWntHdW2uO8lsXLpQ4VQ=; b=
	BytzGPT360C98IhBFxeTx3NOwsyn+LLjSv0HyYRHltnx/CHg6fMAUgNUP0g/vhjs
	HJxPAeodhFy0B9L8D+VPCYnu98rFe4cKHSX/pojtKyvogse4DqFFAbg51iZ2Jup5
	uIxAv+GAjZemdhK5q5MI/MPNV7WbWu1fyaoPYgvY6svrrFaBp0nRadftitN00V5D
	pzR5HEXN65zo1P+kvq0W5U7nf6H8KYekVzRcB8DAYKyDC0q9SdChzmib9RP2W9EF
	Hjq/LD2nIqLG5a4Q0+oThW6llaY4XNGwZvFLuVeonmW/LKGf3ztbwQF86bU1w2ED
	wmdGDqj9mMFWbvbAVzr77z75vqzYYAbFqPy9iAvdB+GCvSPsPU+wtvC6yGdtLwJI
	y8BkaR6EFSwIqjbZSUsmqlDSH9EIyqGuWDOp6+jRRvddW/TY0Z/ncsWqzfX0Ckry
	QSAQ7jIvcO96yTxLPoTddO2EAZcNQIKRvcCbUSYLvoKz/+2KphB+qP3TyvMh4fmT
	26DbUX/oORlbm50fgAzvDeZ3Yd7CIqen5uEGq3CfegZacs6yVTjjLMfVScpOAcus
	TE6BU59rVCQ1HTxjXJxUthHBY7RTKe92xlAAO6xfmM9Tqgb6iRBkXfljpFvsXwTM
	8axDWRciHBAbucV/68S2oTKfum+ucJ5A8Nd7pygzZYk=
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
Subject: [PATCH for-6.14 v3 0/4] Add more devm_ functions to simplify probe path in drivers/spi/atmel-quadspi.c
Date: Fri, 7 Feb 2025 13:47:55 +0100
Message-ID: <20250207124802.165408-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738932485;VERSION=7985;MC=412144077;ID=401531;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852617560

The probe function of the atmel-quadspi driver got quite convoluted,
especially since the addition of SAMA7G5 support, that was forward-ported
from an older vendor kernel. To alleivate this - and similar problems in
the future - an effort was made to migrate as many functions as possible,
to their devm_ managed counterparts. The few functions, which did not yet
have a devm_ variant, are added in patch 1 and 2 of this series. Patch 3
and 4 then use these APIs to simplify and fix the probe() function.

Patch 4 in particular, fixes a bug present in 6.14-rc1, where the PM get()
and put() calls were imbalanced.

Links to previous versions:
pre-series:
https://lore.kernel.org/linux-kernel/20241222141427.819222-1-csokas.bence@prolan.hu/
https://lore.kernel.org/linux-kernel/20250114222851.1023194-1-csokas.bence@prolan.hu/
v1:
https://lore.kernel.org/linux-kernel/20250115160244.1102881-1-csokas.bence@prolan.hu/
v2:
https://lore.kernel.org/linux-kernel/20250124085221.766303-8-csokas.bence@prolan.hu/

Bence Csókás (4):
  dma: Add devm_dma_request_chan()
  pm: runtime: Add new devm functions
  spi: atmel-quadspi: Use `devm_dma_request_chan()`
  spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

 drivers/base/power/runtime.c | 36 +++++++++++++++++++++
 drivers/dma/dmaengine.c      | 30 +++++++++++++++++
 drivers/spi/atmel-quadspi.c  | 62 ++++++++++--------------------------
 include/linux/dmaengine.h    |  7 ++++
 include/linux/pm_runtime.h   |  4 +++
 5 files changed, 93 insertions(+), 46 deletions(-)


base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
-- 
2.48.1



