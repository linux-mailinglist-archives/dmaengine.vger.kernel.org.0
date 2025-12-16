Return-Path: <dmaengine+bounces-7699-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE869CC47FE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C04E13009DAA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82F2D877A;
	Tue, 16 Dec 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0OWcfUb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F424A058;
	Tue, 16 Dec 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904371; cv=none; b=LAqYE+TNrqKbkeL6/0uPWFiIqgV79CYySnJdtyaGcwjfdGd0nQDacSKjc1I4Qk0kzUHUYrrMgEXrxkc+6DgXFCSo0XWPLeC4nUEb/yjd+7arfcceWcceJJYkBbn54BtCEgmg4TGxKbSUk19H2bqjA3s5BtVnRzNXUBdxJiq3Qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904371; c=relaxed/simple;
	bh=vc1iSBm3wFs8fhJAJ1q2N7a2JIySHMcFeo++xQQ9R2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=odilQtQzRfSy7lIgzKFSjV5lLMu3zVVxQvJAvJ2fb8a2EQdyt2AQTKndeyUak8GV1KB6mIiRMl0nEgxJrGHDmOYiVQRPuPmHZQINOkP+POlF2pvdQEdVGAkPghTcJGOFpAk56CGwXYH6K0hQ24hfYyjcqFPmU3eFiphIjL941OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0OWcfUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE8C4CEFB;
	Tue, 16 Dec 2025 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904371;
	bh=vc1iSBm3wFs8fhJAJ1q2N7a2JIySHMcFeo++xQQ9R2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M0OWcfUbedRtcNUKJMb69nusPgQfV5j2alU6ZE7s2Rx2WiJ/PZi3Abbo3YidSNcaM
	 oyuT4r9p6SnlOxTfvuKoutLObJXipYKy57xgMexf2LBPYr41Lih9X5aYtXarohimN3
	 PdgFR4vX6PLya3HJDwYyY8kqqrCtl8ks4tmB/UjJ9a19klO2UznkV/hsi0KslRty/E
	 Ju3HzUdX+jN7BWUcr4ZooiK3Ol4PeudbYMlCmQeaAUoBuF0P5xkp1xU7WryIVoAof0
	 JkpA/EX7nV86lLI2fDHLsov6XKrtQTrpen14cPfP76KsILzcRzMWydBtFt5x5T29ii
	 3j1D5j0Fvbc+g==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Prabhakar <prabhakar.csengg@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251125212621.267397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
Message-Id: <176590436727.430148.10863238173576645400.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 25 Nov 2025 21:26:21 +0000, Prabhakar wrote:
> Document the DMA controller on the Renesas RZ/V2N SoC, which is
> architecturally identical to the DMAC found on the RZ/V2H(P) SoC.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: rz-dmac: Document RZ/V2N SoC support
      commit: f94163e950c9568fe2d2d88317d9602ce021e646

Best regards,
-- 
~Vinod



