Return-Path: <dmaengine+bounces-4182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F82A1B200
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 09:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68153AE79A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D51218ADB;
	Fri, 24 Jan 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="I2wpu0CY"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0C1DB134;
	Fri, 24 Jan 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708975; cv=none; b=TBHycdPLn2k0KCdqSGTj97MHM8rB7tz5GAoSw2c2CmRNjtvpE2gMkCnKKZn4Im8VV6lWfBzKMmlS148Cm0ihhUsM+q6l+dMWGXh2qdiPw0n21r0tgbAFOoHJdLv3E+LZL3lktQfVbHen+uOsCEDLcga3ZvJvdMjPkEV0wTXYC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708975; c=relaxed/simple;
	bh=Hqlynt3aXaASMjV6IHpr6I7vkH/wXBNRmEpnJSwFjOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UeKlgMjTyX0B8F1p+JS1+7/JoQq3Sd0tcZGPXkED3DNY7gMAGZHQOUExttqxKJNxno7WVOdyPjkJwYNK2/qq8Oh57ez2r+ld3V4fBE/nlh4qXL2lfWtDA+Ezmdk+qtkL0ERYfZ19X6y5b+WCRgJ3fm9mWWGxb1RHagL2PI6FYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=I2wpu0CY; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 77A16A09FF;
	Fri, 24 Jan 2025 09:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=2pmYbnPeKyxt+7NbOVL6/kIIAp9oX3TCI0RQTsRH730=; b=
	I2wpu0CYQR3CbV7x/T8QxbdvunrCx/t0jUpMRxMYpyId8G1pMhUNmdxEX83rMcNT
	pOmVn95QyZYXyo2TL12E5CBBTmuzCI4utQ6vYMyPvWinrw3cm/qcFJ8Dve7ncTbk
	tE3RBCH/UbX1PG0Dy+HrfOUpLWdDfHUj+mz6Rvy5CqovsI5+EstokJIeMPk4AxZB
	MC/706/lLvOIotm6HCExFUfSvsZNlv/u4uvP0LNcOHwUfwEHdAWLaFhl8FV80f1n
	f1tuG4uJFPua4e8ZNvIl8O/9z02dE2R9Ir6eX+fz0HhxSK2Jo/5ujwxPMfjZO54S
	HYPRFgp0O/+N0+fHM2cSTNtaNMRFZylvKBRnh9i9cQlcdHvu5WSlYMJfOzBYG5Uc
	QFtKtaIJiZQockkYKNCogeMiAwc1ZI4r8LmfJwbSQ/tXvq3jnkz5aqCoG+pVEHcD
	vy6Epopg1/SE3QTEQjCKbdAYEjviyliCGoB3oy7nK/hicCr0hm1eSCNhe3v4tn9r
	1NNyj6t6dE7cZsVVcqNuyZ3UyN5UFjEZp6EFI/F8cGokMbgiY7xtwERhz6XNxYei
	Lag+JNCYz2nlwDNx81wLR0zyqOCj3kgg6oS0JaTfWovgkmz4Z4Dg3EA1fTZcqSiO
	5iQsfTe3+NOx9o1oDeoFH28XFX7l02ShVkcUgTh9AU8=
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
	<dmaengine@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/4] Add more devm_ functions to simplify probe path in drivers/spi/atmel-quadspi.c
Date: Fri, 24 Jan 2025 09:52:16 +0100
Message-ID: <20250124085221.766303-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737708961;VERSION=7984;MC=4288689662;ID=70488;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852677063

The probe function of the atmel-quadspi driver got quite convoluted,
especially since the addition of SAMA7G5 support, that was forward-ported
from an older vendor kernel. To alleivate this - and similar problems in
the future - an effort was made to migrate as many functions as possible,
to their devm_ managed counterparts. The few functions, which did not yet
have a devm_ variant, are added in patch 1 and 2 of this series. Patch 3
and 4 then use these APIs to simplify and fix the probe() function.

Change in v2: rebased onto Linus' master, which is:
commit bc8198dc7ebc ("Merge tag 'sched_ext-for-6.14' of
 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")

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

-- 
2.48.1



