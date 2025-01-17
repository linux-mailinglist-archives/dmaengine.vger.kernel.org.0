Return-Path: <dmaengine+bounces-4148-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E92FA15501
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B273AC6CD
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692C119F135;
	Fri, 17 Jan 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="a0MXx/10"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABB19E97B;
	Fri, 17 Jan 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132807; cv=none; b=Hhl+7ju0BUOK4JTq322zIPmNGBIls/W1cazUSmwP0F80rBBXDYl5zjWxa/2j3EFSPCVCOtW1/juifOvbHxPu6ZYK1A0PmyO/FcNtCEsBjQsmQAPqYDXRjJyZSApYcuz+4xyRuFqC5xPxQv7+PY86q1C7i63R5wDVf5/y8dYoRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132807; c=relaxed/simple;
	bh=FU6l4kydza1d8Z9tJY6/YtYKCb3WfYC3I70nG66/0f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/Q+CwBtSPqEL6/3OqZsz6FyIkp7GIM/r+Zu6F/DX04xhct4qMXlfDhzO8bd4WYBRjB1Wq7XtblLYwwNu7vOkmNIFjFQ4Ua2txh2RqITSKPLGfk1PYoZbquZDiI0qhVUgs6J6uJgjC4VFURrWNcDMhjem0qgHj7SzOjosN3z18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=a0MXx/10; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 34E18A02FA;
	Fri, 17 Jan 2025 17:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=CpHtADWgXcC5f/xSKBlH
	96Muxz2w2hu/GITHwyhpecU=; b=a0MXx/10c4fcRGDH7klzyvH5+buqCcfLe/t7
	XwBcop+ncavEvEGjyxLOKREqf2UKfvJxbGXjgpbzWRiqCV+Mg6Di73z7zb9B/kDL
	DepvkhBBtF+yUoBXng7JVJoXQDf+TRKG9py7Y6NiyTWXHnnblQpnXAjzcFxjpBSr
	7gk+JCLwgIEChRrT17xIEcDM/xw6rvSo4yVPRfPfXm2IW4CIgCLK5rsFBTFYFISz
	/dmVHRAWra+9+tFPqaZ6CI6018hYG6F/k9sNE2v+b44oC42ewscbkh4GY6JkFt8/
	cFIrlEY5GvPTFYAmeCN6aoMhITF+L96U1q7Of+C3pEYiYSSclwkPlvTqNp26BeIl
	m5tX3VWhsAXsee/ZwYeS5BgICFv3udJjaH+5QcYQlpxvSLzfj0zMxILCBiy++nja
	sngfbMQKDI1RBFM32bFo1i+KjWSugWsTKmuWiDotepw0mar+Ms8BWGzPi5Qh/OVS
	WVsuPqc8D6R1h4tfR5r17+OqzQyzb2fVj+U/vE8ehBuuuDorzE1652O2LZHeAU0G
	GhsSq53IOrNXhWW5i8y50WxyymXqCksEpRNRHjzQEf2oKISBYCCqq07WNaev77gl
	n3/FZIM0nqhtpu2GcrnlNukRHqryy8o8XBjmM92pGesDycBUQfSx0kL+KzSKR8f/
	vSkZXpY=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
CC: Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Alexander Dahl <ada@thorsis.com>
Subject: [PATCH 0/4] Add more devm_ functions to simplify probe path in drivers/spi/atmel-quadspi.c
Date: Fri, 17 Jan 2025 17:52:24 +0100
Message-ID: <20250117165224.1233255-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115160244.1102881-1-csokas.bence@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737132793;VERSION=7983;MC=2736459822;ID=315655;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485264726B

The probe function of the atmel-quadspi
driver got quite convoluted, especially
since the addition of SAMA7G5 support,
that was forward-ported from an older
vendor kernel. To alleivate this - and
similar problems in the future - an
effort was made to migrate as many
functions as possible, to their devm_
managed counterparts. The few functions,
which did not yet have a devm_ variant,
are added in patch 1 and 2 of this series.
Patch 3 and 4 then use these APIs to
simplify and fix the probe() function.

Bence Csókás (4):
      dma: Add devm_dma_request_chan()
      pm: runtime: Add new devm functions
      spi: atmel-quadspi: Use `devm_dma_request_chan()`
      spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

 drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/dma/dmaengine.c      | 30 ++++++++++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c  | 62 ++++++++++++++++----------------------------------------------
 include/linux/dmaengine.h    |  7 +++++++
 include/linux/pm_runtime.h   |  4 ++++
 5 files changed, 93 insertions(+), 46 deletions(-)

-- 
2.48.1



