Return-Path: <dmaengine+bounces-4063-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C39FBC95
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 11:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4A51883A13
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03B1B6547;
	Tue, 24 Dec 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAAe9jtJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7BB1AFB36;
	Tue, 24 Dec 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036925; cv=none; b=Re1AnEcLetQSOF6LdFs2m7qIfprrPJ+dep3cdhzpl/IebbAsww+s1szNtCNcaalVKIz/JxPQceX7ypplCKL0KvwiBcO1DS0Bs1qLCDb4gZlVTUMdScdivolBJ4Pq9ZZrTv5bBZ821souU1BViY9NGzGxuoc/dw9NuCPHQKOIRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036925; c=relaxed/simple;
	bh=3NiatL6/r44VNZvzjqvZN0UfR00HM1AXLi2rpkPbVtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sRqwGkz6OJ9RMzHV3uTB8zreRVjIicif89AglDY+wniP+fXr24ldXBO7Ph6/KHOZSyQI6URIWRYF9qfNZ0k6MdNz1BgMih5u7pj6igpFIXCAiTEjXQXUUU4xlceOl2p63/ajcZ79xscO5ggRupukW4yMdzqF5x/HpLAn8tQUkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAAe9jtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FC7C4CED0;
	Tue, 24 Dec 2024 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036925;
	bh=3NiatL6/r44VNZvzjqvZN0UfR00HM1AXLi2rpkPbVtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sAAe9jtJtdNXFcbdmgMnCyKhAafu1SXavwBXW8MRmLOfu6joOSXYTzpLoqkW71l2o
	 rmxPDT9lMsBYGoXTMe0m4cg9XJ52y2Y8FwODLsugpcfqR05rtiZi+L9GA6lXmSLqX9
	 kIrOBQV5NMxF4pD0QIldC3SpLoD4051Tj0hYENWbI4lEpmgmrV1RWz7UfnsIPOV49q
	 MGMHrDe4xKShMbJp+DNuXmRoIHNbpnL8gEXMOUndGbb5JdRB+MuYCPqA3Heptm90tU
	 8ZZeUx0JvQEZFYympyn6mrVG1ZpAg1jryvpq0OawM1ZdgdkvVvFSY+n2PcjU4OqaFq
	 S2kEvSzS+RA6Q==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com, 
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
 Enric Balletbo <eballetb@redhat.com>
In-Reply-To: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
References: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
Subject: Re: [PATCH v3 0/5] Add eDMAv3 support for S32G2/S32G3 SoCs
Message-Id: <173503692101.903491.14135752418586666375.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 16:12:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 19 Dec 2024 12:24:09 +0200, Larisa Grigore wrote:
> S32G2 and S32G3 SoCs share the eDMAv3 module with i.MX SoCs, with some hardware
> integration particularities.
> 
> S32G2/S32G3 includes two system eDMA instances based on v3 version, each of
> them integrated with 2 DMAMUX blocks.
> Another particularity of these SoCs is that the interrupts are shared between
> channels as follows:
> - DMA Channels 0-15 share the 'tx-0-15' interrupt
> - DMA Channels 16-31 share the 'tx-16-31' interrupt
> - all channels share the 'err' interrupt
> 
> [...]

Applied, thanks!

[1/5] dmaengine: fsl-edma: select of_dma_xlate based on the dmamuxs presence
      commit: a4b00f54a20bba0bbfc952a8cb4c3cbe29e408b0
[2/5] dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing muxbase
      commit: e7732945db1d4612072e26e5b459d74e9d790b7c
[3/5] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
      commit: 57eeb0a566a82621ab731b0372a5a2894b0d572e
[4/5] dmaengine: fsl-edma: add support for S32G based platforms
      commit: 2500243e5cc2e45e6fae826cbc64e9986a9b8194
[5/5] dmaengine: fsl-edma: read/write multiple registers in cyclic transactions
      commit: 66d88e16f2044400fe6cc75cd51e1e74c4f9d96d

Best regards,
-- 
~Vinod



