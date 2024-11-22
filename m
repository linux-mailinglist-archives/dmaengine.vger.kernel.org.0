Return-Path: <dmaengine+bounces-3768-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3035C9D61C0
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E19282FE1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7176E1D5164;
	Fri, 22 Nov 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="V1hwB9KD"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BE2FC23;
	Fri, 22 Nov 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292046; cv=none; b=AJZ4cuiZZHaTR68rMRO4ESw42ETu8DW6aZxTxoeuaYDQaX+yZ0MNevgm5Ej27ArAxrO6T4PMXyAnDFoxNZq+QivR9tk6NtTeFyyuWZ4MFoUj9qvakS6lrWMxnn3jTevbbPyq+yQx5ozNHRUjYBr6rTX0XGr7c4XxwAcV31e7Jcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292046; c=relaxed/simple;
	bh=0EA4UV4RNGE7xqGqlrrJvHIA53WJ1uWQg6/4nAZb2Vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IZ+0cbzGFSyXE50trdekOO823Tlnc3hh0i7LNBn2ggC/CJkRWA9DzMPal+Si+YCFxx96TLoJQtqIb0aU14/ZZ5txTYvR/5wit46AUNR6aBAGWdLoJujToSjraGgqDbImlPYkEQS5XYT0473nB8QaaGBC7fhkOolUMb/A8aqxXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=V1hwB9KD; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 580BBA048D;
	Fri, 22 Nov 2024 17:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=3nQSFIndLHlk5B599D4K9i6Wy/lcEPJpfLWck+sxXK8=; b=
	V1hwB9KDoD7MK/AAh0RD4IKKiCgdZt9qaWNHb7qqVCixDSXpQ7NdY39maGKNEfM9
	VtJQ/Fem7fmGXY7yOI63l71zTmIMnIW8zKfPjDBhDffnOIREOy3qImsBrkvGO1tT
	YQtR0in3J5WUY/FQ2JfCq0Tl0H/hxb5ShX2J2/YmkyPhUBQ8H90X5qqSajs6bCmD
	IcfiNNDVH5UiM6yfhxPmG4gwRI3UN/ABfjo+N+kYAAYkK9awxJeAJ3tlLoXDg5gN
	tPIQ6RAbvvVBLlOM9SXA/+xbLi8tHwvlKtIkXAM33Rcp7pVBj8KfnMN+jK77aVoH
	cAM3CXVH3aAWpLx0bGwxqjhpUNOkuFGUJWL+c6DWmDwGbyevV0WFsK4WpH5KlMvX
	s7ZO8YChllnUILGnI/RPLG0wvDjU5ihsiXbp8FEKS5IMrx6wm9zJ4z/MI8DX2NvM
	dbjz7fIP9seh/PyPk+6XvRLo5iMEtsEaa4xB7pkWabrpyoRMOsLHuXPimgn0G74K
	VcDrNUly9Cd51BoTWgWrwZGDspFQ45oBYjwO4soVSrpjUeIhZiPWHTIDj0z0Jb1O
	6sROahwf/HfQtuU43jyTygaeWRGqQyuIjD2tfFy/sFq9YYV74fLF1IYDttTAg4F+
	Zui8qgO3hGGIALdSNn6o/2gRCMA7rLDYXqxYxRcZc1w=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Mark
 Brown" <broonie@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul
	<vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Chen-Yu
 Tsai" <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Conor Dooley <conor.dooley@microchip.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v5 0/5] Add support for DMA of F1C100s
Date: Fri, 22 Nov 2024 17:11:23 +0100
Message-ID: <20241122161128.2619172-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732292038;VERSION=7980;MC=955160253;ID=83447;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855607263

Support for Allwinner F1C100s/200s series audio was
submitted in 2018 as an RFC series, but was not merged,
despite having only minor errors. However, this is
essential for having audio on these SoCs.
This series was forward-ported/rebased to the best of
my abilities, on top of Linus' tree as of now:
commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel")

Link: https://lore.kernel.org/all/cover.1543782328.git.mesihkilinc@gmail.com/

As requested by many, this series will now be split in 2, the DMA and the
ALSA/ASoC codec driver. This is the DMA part of the series.

Csókás, Bence (1):
  dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA

Mesih Kilinc (4):
  dma-engine: sun4i: Add a quirk to support different chips
  dma-engine: sun4i: Add has_reset option to quirk
  dma-engine: sun4i: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for DMA

 .../bindings/dma/allwinner,sun4i-a10-dma.yaml |   4 +-
 .../arm/boot/dts/allwinner/suniv-f1c100s.dtsi |  10 +
 drivers/dma/Kconfig                           |   4 +-
 drivers/dma/sun4i-dma.c                       | 208 +++++++++++++++---
 4 files changed, 191 insertions(+), 35 deletions(-)

-- 
2.34.1



