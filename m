Return-Path: <dmaengine+bounces-4450-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17BA3322F
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 23:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE993AA196
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC02203711;
	Wed, 12 Feb 2025 22:13:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C151EBA0C;
	Wed, 12 Feb 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398399; cv=none; b=O9pCdd3f2Xi+uyoio6sKwf8u4LHWTMo13rFU07WjQqLJhh5BckFpnYs92CrBFNsmTxW9gYArtq6wY7lJvM2NZnJ006N3ZwXU+l2gYhyOfTo46FPaTl2/k5GBbkpoi7leaPdMedcz3j29jyJi8kQgVPELQqRTQd3v4A5z9FwE7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398399; c=relaxed/simple;
	bh=N5IK13DJ6LnwPwC02e2aqsOqTe2QDLovLs8E0lyG83c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IWdW0YX+9nQUoubXszSFSnLCM8HQ61M32ICw28ikMPCGtM0BUfKWipA3HQfHMejyXTLEZGlI/wJR5y6MhlXsN703yw5MTvHiNs6oPbBtBbrL7uRwPUHnlyF58kAZVXevrThMOz2XFjPARFWs9Qjq7nWR2XsKs0s6JqknxeI10vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: asgVNVzpSty0OW2moQBTDw==
X-CSE-MsgGUID: viPmXcvdSf6GhzuDzqklCQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Feb 2025 07:13:13 +0900
Received: from mulinux.example.org (unknown [10.226.93.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C5DA340AACBB;
	Thu, 13 Feb 2025 07:13:07 +0900 (JST)
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/7] Add DMAC support to the RZ/V2H(P)
Date: Wed, 12 Feb 2025 22:12:58 +0000
Message-Id: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com>
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

v1->v2:
* Improved macros in ICU driver
* Shared new macros between ICU driver and DMAC driver
* Improved dt-bindings

Fabrizio Castro (7):
  clk: renesas: r9a09g057: Add entries for the DMACs
  dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
  dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
  irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req_ack
  dmaengine: sh: rz-dmac: Allow for multiple DMACs
  dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
  arm64: dts: renesas: r9a09g057: Add DMAC nodes

 .../bindings/dma/renesas,rz-dmac.yaml         | 113 ++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 165 +++++++++++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           |  24 +++
 drivers/clk/renesas/rzv2h-cpg.h               |   2 +
 drivers/dma/sh/Kconfig                        |   1 +
 drivers/dma/sh/rz-dmac.c                      | 167 ++++++++++++++++--
 drivers/irqchip/irq-renesas-rzv2h.c           |  56 ++++++
 include/linux/irqchip/irq-renesas-rzv2h.h     |  21 +++
 8 files changed, 516 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

-- 
2.34.1


