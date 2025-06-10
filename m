Return-Path: <dmaengine+bounces-5333-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55499AD301F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 10:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA383B6BBB
	for <lists+dmaengine@lfdr.de>; Tue, 10 Jun 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C44280A38;
	Tue, 10 Jun 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="diF6WzQX"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82395482EB;
	Tue, 10 Jun 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543783; cv=none; b=alF6B68CbLmva8KQhAyOsPExL1n7OdMV9C0pIkvFfBC7tpkkyGFIxTQ0WZdnrdCg2RoAhh00j1oxVv2Vw4H37a0Lm33o+8Yd1kUOSqC7oqhC+Tukarh/wQ59pdO4z+zk0vL6FNlSNDTR3HOrvggWHAzFd/LLAB8SbkQpAn6JAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543783; c=relaxed/simple;
	bh=CXTfSlzuKSjNdG74ErQwFAdwQ+v/tGTU8rl4IjdyMSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6eG0LrCKUABEJjDMBpfU7cRXCWUM3q58wAJ4vU676fdxkMa/lfO9D1r/k+j7J3pvh5jaLV/ZHq+CCNPVb4IAUWXqbXBB9KuC42H+f7DXfpfRSFYye1CyH22PJY18CI8mEZJuVHlKp/QUAfUoHG154qX3bBPl+NmlL3ipxIoFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=diF6WzQX; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0F87DA03AE;
	Tue, 10 Jun 2025 10:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Wme2rWr9kGPdB2QIlhOE7SoLI/g+93mMfEI/ASWP9iQ=; b=
	diF6WzQXv+ERBGklPIxdDxvvo9OHMxfIKtDE2E/FyLcyGs0qHofj0Ci5QOA4s5h1
	dtGhBRA3oFHtyDcVkr9DB7FQXU6wOdZw4E/Hwe20IvlJApQFNE1w60DVbei8KqeH
	qp3ToMzKCzy/GGkZpI8/TVA2PkGnJaEdMkOOIPdudYJQyiryMP23vU6X+oybq2Iq
	274vFzHPuJ2v4D4/geEjgbz3MVexdgJqu2Emwg7LLTmZm1otOEuVWemhEkMQKcfl
	XNaUzrIqciDRGO8ELa3kHLCKwC+pQPsx23EebJrs7ybDckTW3cI4U58WhM7afje9
	vPVOOVfuycOJSIyvbLxMocZ2hr+LY9zCNjPI8hVGHy53oxd90Wg+ts+JmTYyDjTP
	Fo1DsPmrUGD039EHZe34wuhdBL3zCjRCLlKZLpEJzldvsn0oSnYxUX3koLe2G+xw
	USfaOFTMw5g27kg0P4b97sQ7qks/i+EnoTnYHKMibmrB7E9wEYG6yfp2gqKoc2UT
	1JWDaMh94g91awP7OC99iYRf5akxSIbjITrmocUFxRHZKkaNb/5RmubnlBe+6H01
	20V3ACrev1Spaa3kbLVH+erBTl+QPFNUJfD0qMARSd8XtWVm+euexGmrrUccKboc
	57XUyyB5cYDJ9llAdPkm72Q6AFQv3MiUgOvx2uIx7M8=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Vinod Koul
	<vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>
Subject: [PATCH v7 0/2] Add `devm_dma_request_chan()` to simplify probe path in atmel-quadspi.c
Date: Tue, 10 Jun 2025 10:22:52 +0200
Message-ID: <20250610082256.400492-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1749543778;VERSION=7993;MC=3947185238;ID=452478;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155D62776A

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
* rebase to spi/for-next
Change in v7:
* rebase to dma/next

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
v6:
https://lore.kernel.org/lkml/20250515083132.255410-1-csokas.bence@prolan.hu

Bence Csókás (2):
  dma: Add devm_dma_request_chan()
  spi: atmel-quadspi: Use `devm_dma_request_chan()`

 drivers/dma/dmaengine.c     | 30 +++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c | 48 ++++++++++---------------------------
 include/linux/dmaengine.h   |  7 ++++++
 3 files changed, 50 insertions(+), 35 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.43.0



