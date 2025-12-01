Return-Path: <dmaengine+bounces-7423-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CCAC9769B
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 13:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AF73A28C9
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EB730CDB5;
	Mon,  1 Dec 2025 12:50:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DF30E0C6;
	Mon,  1 Dec 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593405; cv=none; b=I91unHWJ7Gqo+vS8LT7n/lhMp6vuxEUrwmLTjJ6vSfMFruQ14EQg7U/3AzCKhfGXPvmGsU1kK+TcqtXcXVtb60Ftix+6BbtToGe+0Xe5llEiEtva0VBVTeIBcczfAJR5E02gO4/rgCJDXqy7h1PKDfGCI4F2BXNh4snTN8NIjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593405; c=relaxed/simple;
	bh=IWMQypBnyQRwWjZg5iiIAxpqwL5I5qhysJPmHfxV9eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzuX7ARs6vL+EWQQR7+wAPQdrySlp1VlbCTJfip7CY34ACQs8cXBut18/DsF7toZefKZcsAbW2pu5wmZxoabiphFY7xyVUGrmuuSLTkRx/AYnqAvr68xIaHe+2hwPiMXcNEOsneLicA3q1NitBwN5/ya1TrYMLAw+Ns8KDWcGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: x6vslG3dRKCV6a8BodWDPg==
X-CSE-MsgGUID: I9J3KQGoRZKAw0juJq7HEg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 21:50:00 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 01A1742100C2;
	Mon,  1 Dec 2025 21:49:55 +0900 (JST)
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
Subject: [PATCH v2 0/6] Add DMA support for RZ/T2H and RZ/N2H
Date: Mon,  1 Dec 2025 14:49:05 +0200
Message-ID: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
 drivers/dma/sh/rz-dmac.c                      |  94 +++++++++-------
 4 files changed, 317 insertions(+), 57 deletions(-)

-- 
2.52.0


