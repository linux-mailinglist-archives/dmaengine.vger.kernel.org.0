Return-Path: <dmaengine+bounces-6868-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1EBE413A
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 17:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 126E935921E
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD3343D9C;
	Thu, 16 Oct 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLa1gW8K"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B53054C4;
	Thu, 16 Oct 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626935; cv=none; b=ADgAswYStOQQf8ap1kgdzDNsiVYArijSrJ8K2x9HRgI3pVnLTmFrxcuXRTSKCaXPdcF38kwqjQPQPhJjjEDaoS4SFW0rNyf6HPVclaOs7+oQv0eA5YMqFczVvX40tmc2cp10ojAqPfFl2aqTxl5VawrK/sEqNAUDxYArwGszHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626935; c=relaxed/simple;
	bh=CGTHOVxNdDTbVb4t6UFB/sD9rp7p9tHM+z31re3JEWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IFHPGfItgB2nXW1ajLLtxf0s8vagpAed9eEVsjrXEkushCpOhWfj5fkNfuU1aOK6tSY1v6dxEQsDBZQBjHCQZtdDRPX39auvEywx8vqnir67EyPx6nZBLMC8/hEKPj8TV+/hbvM7d+4XMbx9TImGGM1ep1z3tJShhry31W2amwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLa1gW8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E1CC4CEF1;
	Thu, 16 Oct 2025 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760626935;
	bh=CGTHOVxNdDTbVb4t6UFB/sD9rp7p9tHM+z31re3JEWE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gLa1gW8KEtUYex2l0UseNtIdzaS0x5oXHssoTZv9fPXxSWIE5WP4srYTXrJWn97Xm
	 RL6x2uk+Imy4f2JlufNopD+4/mh7FgcRV9X+rD99NYRx0bnMWPk7vDoUG0to071YKS
	 hL7/hTUdFiZzPvCj3zhWKgZR4NYupdLpx1kzIVlPUIEJkf1VwMLLXjJImnIXi0jkqI
	 t9X882lMphj7pG6tYM8xel9CCm3NsW0HJxXKXbLfhuw5ZJH9QpywEWz7/2DmAypF2h
	 iNOde+EiBNOLIL3JM0xcIhHFnEZ6LSzf+/AOZDpPqOUkBMnTRin4uBRTqNQbvwLxvX
	 qn8QqhxsYky1Q==
From: Vinod Koul <vkoul@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar <prabhakar.csengg@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251002124735.149042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: sh: Kconfig: Drop ARCH_R7S72100/ARCH_RZG2L
 dependency
Message-Id: <176062693263.525215.4104492280324397032.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 20:32:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 02 Oct 2025 13:47:35 +0100, Prabhakar wrote:
> The RZ DMA controller is used across multiple Renesas SoCs, not only
> RZ/A1 (R7S72100) and RZ/G2L. Limiting the build to these SoCs prevents
> enabling the driver on newer platforms such as RZ/V2H(P) and RZ/V2N.
> 
> Replace the ARCH_R7S72100 || ARCH_RZG2L dependency with ARCH_RENESAS so
> the driver can be built for all Renesas SoCs.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sh: Kconfig: Drop ARCH_R7S72100/ARCH_RZG2L dependency
      commit: bc2c39600212979b6fc836113bde1b707c02f442

Best regards,
-- 
~Vinod



