Return-Path: <dmaengine+bounces-4523-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC580A3ACA2
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C827C188AC48
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 23:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969A1DE2CD;
	Tue, 18 Feb 2025 23:43:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18441C3F1C;
	Tue, 18 Feb 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922203; cv=none; b=HmJBPs9Qmw/3EpQ0VVyiy3I02J7NZrp0+g0J4Am958gMd7no0gVh5paAccHqJ2Bko0EBwTMiXA6WFy5+91EyXq7kFUw3XR7kcVWVJ9F/pMIIP7Xr1D2wpG9eWC1xu2v5rYgcVRCNowS6MS3q2CLZ0vzF6hhyY76n3XVatj4qvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922203; c=relaxed/simple;
	bh=v4Y10AUBUTN8XgnIfF+UzLeCnhQZG1T/W38GXemsOEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAeS53pTvVD/10V+cPHNKP6B8LKnjtlLKJaDGbSeBWAZDVsCM4teidr2/3afiu8/Y5k5+n+VLY0MVfMySJpYxwMdkQ/B624p9JU27NJpshnZaFt+Cehk1bEA6y4ysXyTwcoJSnmPGeb/0bNscmkDhtChEsa58F3C2d/s3FgSno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: STD1KL/kQBO/gmMzygOx8g==
X-CSE-MsgGUID: eZdFOidhRj+bYV/+Eo1iuw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Feb 2025 08:43:13 +0900
Received: from mulinux.example.org (unknown [10.226.92.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7ED9140FDDB6;
	Wed, 19 Feb 2025 08:43:07 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/7] Add DMAC support to the RZ/V2H(P)
Date: Tue, 18 Feb 2025 23:42:57 +0000
Message-Id: <20250218234305.700317-1-fabrizio.castro.jz@renesas.com>
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

v2->v3:
* Replaced rzv2h_icu_register_dma_req_ack with
  rzv2h_icu_register_dma_req_ack() in ICU patch changelog
* Added dummy for rzv2h_icu_register_dma_req_ack()
* Reworked DMAC driver as per Geert's suggestions.
v1->v2:
* Improved macros in ICU driver
* Shared new macros between ICU driver and DMAC driver
* Improved dt-bindings

Fabrizio Castro (7):
  clk: renesas: r9a09g057: Add entries for the DMACs
  dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
  dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
  irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req_ack()
  dmaengine: sh: rz-dmac: Allow for multiple DMACs
  dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
  arm64: dts: renesas: r9a09g057: Add DMAC nodes

 .../bindings/dma/renesas,rz-dmac.yaml         | 113 ++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 165 ++++++++++++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           |  24 +++
 drivers/clk/renesas/rzv2h-cpg.h               |   2 +
 drivers/dma/sh/rz-dmac.c                      | 160 +++++++++++++++--
 drivers/irqchip/irq-renesas-rzv2h.c           |  56 ++++++
 include/linux/irqchip/irq-renesas-rzv2h.h     |  26 +++
 7 files changed, 513 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

-- 
2.34.1


