Return-Path: <dmaengine+bounces-8013-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32853CF360A
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 12:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E8730390C6
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 11:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C2338584;
	Mon,  5 Jan 2026 11:50:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3E337BB8;
	Mon,  5 Jan 2026 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613852; cv=none; b=kLA4O66yLU9YC/RlatggyK+Ncd9ENTsR1UyhHcOwXzfka2IHRes9hrbPqNR9jM00XktU9C8PJU8YjYGH61IFVv04SZ5M2SYPJZuHigpUvWf4KKRUGStDbKXmfKCaLwY0QKXjjrIHVRvKDQd2iwNfH4Jc/1Tyrl6QLVhYGRiO2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613852; c=relaxed/simple;
	bh=snQtFXhMfL0UkoI1/gff761gT0FdnfFb1zzs4OQ/20M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bb8HlnTQFLVp9idhaFV/DoKCziSAyzuQSLPLYb3D78pb8xdnkwKMh0qNXk42439nic1ljYCtgERwYUL4Vce4dGcqKv6l4/Rr9XkW/WTKl6XgkjTR93gGYUg/hAekwk+H51Ie/vRHww+UwOtmjY9H9kOR/aR+FVJA/heGVQGA2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: /Jl6MBB+Sde52w5E0XOfWg==
X-CSE-MsgGUID: Z025EZ3zTrK4runtz1RWfA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2026 20:45:41 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.160])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AB8AA41AF7ED;
	Mon,  5 Jan 2026 20:45:36 +0900 (JST)
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
Subject: [PATCH v4 0/4] Add DMA support for RZ/T2H and RZ/N2H
Date: Mon,  5 Jan 2026 13:44:41 +0200
Message-ID: <20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

V4:
 * drop device tree patches already queued up by Geert
 * pick up Geert's Reviewed-by
 * dma_req_no_default -> default_dma_req_no
 * register_dma_req -> icu_register_dma_req
 * rz_dmac_common_info -> rz_dmac_generic_info

V3:
 * replace -1 with direct usage of dma_req_no_default and remove the
   check inside rz_dmac_set_dma_req_no()
 * pick up Rob's Reviewed-by tag

V2:
 * remove notes

Cosmin Tanislav (4):
  dmaengine: sh: rz_dmac: make error interrupt optional
  dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
  dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
  dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support

 .../bindings/dma/renesas,rz-dmac.yaml         | 100 ++++++++++++++----
 drivers/dma/sh/rz-dmac.c                      |  91 +++++++++-------
 2 files changed, 134 insertions(+), 57 deletions(-)

-- 
2.52.0


