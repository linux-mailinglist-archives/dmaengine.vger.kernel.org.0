Return-Path: <dmaengine+bounces-7511-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB131CA8294
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 16:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C96631946CA
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB52C3271;
	Fri,  5 Dec 2025 15:14:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077D2ECEAC;
	Fri,  5 Dec 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947641; cv=none; b=PoH8RnrtU0oYAXLwDESEEFhZQ5Bw6CFbVS+51a9L8kyIPy77j+KmX94THGkZEWAyHr4CQpS0juBSKCeIhda91p6u0P+bphSUEG8bkPsEPiI/mGowkRVdoDZCLm0/cGWxQk6N8Telm2h1bSXqxTB5mEW1diAkJQYvMfyzGv9k7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947641; c=relaxed/simple;
	bh=F5TzxMh+0YaMYxIKRkdSSQv11YuDIpQY2wxoroxNYxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvHejn3asBOt4HMWXGXjvFDvfE3p3gXWeTpwTcpiEhjW8gVfH4THOrGdXHaAtHCtwvEJbrMufWRDt8JcSI+Srh0J1rV3P/IwN1Kj9U8JFxxgEpbFAsMgE5phsBR+KauZXKjLyU5GbNhXghoFOXJIC1YDL3Vgy26eikObtemsSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: ij9cNXIeT0CtZ9ES620jgg==
X-CSE-MsgGUID: /UEiOz0uSPO41BP5o4dl8A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2025 00:13:47 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.202])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B5054007D09;
	Sat,  6 Dec 2025 00:13:42 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/6] Add DMA support for RZ/T2H and RZ/N2H
Date: Fri,  5 Dec 2025 17:12:48 +0200
Message-ID: <20251205151254.2970669-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three
DMAC instances. Compared to the previously supported RZ/V2H, these SoCs
are missing the error interrupt line and the reset lines, and they use
a different ICU IP.

This series depends on the ICU series [1].

[1]: https://lore.kernel.org/lkml/20251201112933.488801-1-cosmin-gabriel.tanislav.xa@renesas.com/

V3:
 * replace -1 with direct usage of dma_req_no_default and remove the
   check inside rz_dmac_set_dma_req_no()
 * pick up Rob's Reviewed-by tag

V2:
 * remove notes

Cosmin Tanislav (6):
  dmaengine: sh: rz_dmac: make error interrupt optional
  dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
  dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
  dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
  arm64: dts: renesas: r9a09g077: add DMAC support
  arm64: dts: renesas: r9a09g087: add DMAC support

 .../bindings/dma/renesas,rz-dmac.yaml         | 100 ++++++++++++++----
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  90 ++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  90 ++++++++++++++++
 drivers/dma/sh/rz-dmac.c                      |  91 +++++++++-------
 4 files changed, 314 insertions(+), 57 deletions(-)

-- 
2.52.0


