Return-Path: <dmaengine+bounces-4937-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD364A973B3
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD40176FA2
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1141DFDA1;
	Tue, 22 Apr 2025 17:39:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4D1A304A;
	Tue, 22 Apr 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343596; cv=none; b=uddu8YKuIwuL1sR0SvAq0OIBdeC7TyrkOeHiPD3xwUwWgdDL4UJnGmgv/aW+zMiGbsWt7k7iSUjhCDF3SWaXugnbBKVJpP9kaRjMIcv9ns+lpp7DsF3WnnMCET+f9Z5zAwTuB9exqiQaPFuRSC3GVpuSF4etMEd1Vuw5PtBsTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343596; c=relaxed/simple;
	bh=8tUVVV01tcIGNH/0m7tdeQsLKQBE6i5+He7iePk0j4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhk9mR1sQrY15zkMIg3BrFWNCEVeC3f+sVysywiIFvKsHf4uw3tr8DYk8eVPby/kwAtU+OVofC/PnMnDE+8DdHDi6RIlpuvb7I4LPWBaefR6cL38k62Lq8SPAVOjvI7Eb8DVSqJr+4zplw32V35nuY/k0bMaIHtf5QO4ROIqtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: mEY1gjZPS62smDfocteWvw==
X-CSE-MsgGUID: fWVepJYYTVyoxYF5L7mLbw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Apr 2025 02:39:45 +0900
Received: from mulinux.home (unknown [10.226.92.16])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4047740437A5;
	Wed, 23 Apr 2025 02:39:40 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 0/6] Add DMAC support to the RZ/V2H(P)
Date: Tue, 22 Apr 2025 18:39:31 +0100
Message-Id: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear All,

This series adds DMAC support for the Renesas RZ/V2H(P) SoC.

Cheers,
Fab

v5->v6:
* Reworked the RZ/V2H specific dt-bindings patch as per Geert's
  comments.
* Collected tags throughout.
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

 .../bindings/dma/renesas,rz-dmac.yaml         | 107 ++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 165 ++++++++++++++++++
 drivers/dma/sh/rz-dmac.c                      |  84 ++++++++-
 drivers/irqchip/irq-renesas-rzv2h.c           |  35 ++++
 include/linux/irqchip/irq-renesas-rzv2h.h     |  23 +++
 5 files changed, 388 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

-- 
2.34.1


