Return-Path: <dmaengine+bounces-4644-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E013EA4F25B
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 01:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC80188F672
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 00:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD74D2FF;
	Wed,  5 Mar 2025 00:21:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A22E3367;
	Wed,  5 Mar 2025 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134095; cv=none; b=H1mnNM7Jh4zOhoj3bfkhb1xjjoq0Av2oPkXon8G281RrQTHQn5UHzu+C1TfIEwe4/KCVksO1mhkfT076clbDFTCjeJcp6p2UWoxxSQOVTRxAWJ5BypHPvEgw7cCtK0fenRzt/NistMPhgUG5rh0GJVowttffFEpqUm/YkIuFUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134095; c=relaxed/simple;
	bh=OUdIdqEN4Ejl2rilMBLaVg3UDkVe2mMlVb3pv4BgKV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B9JnsGEu90MZXGgevKmAiaSjfGDdGfkRk2hsmDnOPvjJ0EfO6HTry7tdwsp+uDUUv2dSSmd0M5wJ4hfjwjLPS1gHrsNqvnCEQZmcCTNATloQi+9O54NiQfwmHpm4Qy6uQwD1bDJ3HH1utMObie/J8Tukv/nmL50q9bhAzE3fozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Ph8L+9opSjaCdT3CTzln7Q==
X-CSE-MsgGUID: wDZszRNdRSqQv9fEGau7+g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Mar 2025 09:21:25 +0900
Received: from mulinux.home (unknown [10.226.92.17])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D7BEB404E421;
	Wed,  5 Mar 2025 09:21:20 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 0/6] Add DMAC support to the RZ/V2H(P)
Date: Wed,  5 Mar 2025 00:21:06 +0000
Message-Id: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear All,

This series adds DMAC support to the Renesas RZ/V2H(P).

Cheers,
Fab

v4->v5:
* Clock patch queued up for v6.15, therefore dropped from this
  version of the series
* Adjusted the dmac cell specification according to Geert's
  comments
* Removed registration of ACK No. throughout
* Reworked DMAC driver as per Geert's comments
v3->v4:
* Fixed an issue with mid_rid/req_no/ack_no initialization
v2->v3:
* Replaced rzv2h_icu_register_dma_req_ack with
  rzv2h_icu_register_dma_req_ack() in ICU patch changelog
* Added dummy for rzv2h_icu_register_dma_req_ack()
* Reworked DMAC driver as per Geert's suggestions.
v1->v2:
* Improved macros in ICU driver
* Shared new macros between ICU driver and DMAC driver
* Improved dt-bindings
Fabrizio Castro (6):
  dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
  dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
  irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
  dmaengine: sh: rz-dmac: Allow for multiple DMACs
  dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
  arm64: dts: renesas: r9a09g057: Add DMAC nodes

 .../bindings/dma/renesas,rz-dmac.yaml         | 112 ++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 165 ++++++++++++++++++
 drivers/dma/sh/rz-dmac.c                      |  84 ++++++++-
 drivers/irqchip/irq-renesas-rzv2h.c           |  35 ++++
 include/linux/irqchip/irq-renesas-rzv2h.h     |  23 +++
 5 files changed, 394 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

-- 
2.34.1


