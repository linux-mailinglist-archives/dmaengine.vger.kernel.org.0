Return-Path: <dmaengine+bounces-4319-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B793A2B4A2
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE50E164FB5
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6CD22FF41;
	Thu,  6 Feb 2025 22:03:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C322FF22;
	Thu,  6 Feb 2025 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879403; cv=none; b=HbvgyWpX79meq/+YsQwlHWpmKZthNulE9nb/g0ZG53roc+QbAdNEuq1HMlRzSHGcvpfhvDyVxcPg4jaxqko1l/5C2C4MJBn9O3snCcYLLB052ud6aHkCwzKzLVLD7gPr+LX5Zj8rr4NUOEhzGtiqBwF+PgILMLmjBfvCIklLgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879403; c=relaxed/simple;
	bh=T9S3SlEM08zIdMPS0+kGE5sEJCeV+6w4sawVogoumo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dYu84kRXcl0rd+xKjzCl/yN46EIMQXgWxeiXsK23WmymWDBkLc19cSiThEfTqA1PBD8SLhWtXYT5JemsfneEnLUZGyevTRQuSIqKEsIZ83iv8TD1aDiGk/7Va/jw1O0VkfBQdeAtxiJskoUxQl1mTJnDvu1hPl7gp8XBEKHc4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: IOxmfAN+Tg2cYa9PuhdzIQ==
X-CSE-MsgGUID: m/8ySjWrRtWfWf2hdAqoAA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Feb 2025 07:03:18 +0900
Received: from mulinux.example.org (unknown [10.226.93.55])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CC07040AF2B1;
	Fri,  7 Feb 2025 07:03:12 +0900 (JST)
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/7] Add DMAC support to the RZ/V2H(P)
Date: Thu,  6 Feb 2025 22:03:01 +0000
Message-Id: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
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

Fabrizio Castro (7):
  clk: renesas: r9a09g057: Add entries for the DMACs
  dt-bindings: dma: rz-dmac: Restrict properties for RZ/A1H
  dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
  irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req_ack
  dmaengine: sh: rz-dmac: Allow for multiple DMACs
  dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
  arm64: dts: renesas: r9a09g057: Add DMAC nodes

 .../bindings/dma/renesas,rz-dmac.yaml         | 148 +++++++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 165 +++++++++++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           |  24 +++
 drivers/clk/renesas/rzv2h-cpg.h               |   2 +
 drivers/dma/sh/Kconfig                        |   1 +
 drivers/dma/sh/rz-dmac.c                      | 170 ++++++++++++++++--
 drivers/irqchip/irq-renesas-rzv2h.c           |  61 +++++++
 include/linux/irqchip/irq-renesas-rzv2h.h     |  19 ++
 8 files changed, 555 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

-- 
2.34.1


