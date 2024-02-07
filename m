Return-Path: <dmaengine+bounces-973-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C284C6A6
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FE5286181
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80922330;
	Wed,  7 Feb 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR2RhF4U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93820B34;
	Wed,  7 Feb 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295777; cv=none; b=jewKIbhNClJ/x/4U3LrtM4YAt80dFeUO9iowHPwKGSswu1mWWkg+lo2l7fgS/mYLWCspHdbq3naN8SkA2+i+eu36IITaGmWcXU6P5w/BftjBsPu3/RnwEgGL4Wa53IoeGLOFxPD/ifrDrU+QcqrK1sSBFY05JpsJ59BQSKV2T+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295777; c=relaxed/simple;
	bh=0AYl4WzV6WW2Nc8HtKxIxfT+OVe87yQ0wW8/JoMsF2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q9IWsT6ww8tLitEgoZMJvNvD9zNxomprb7YLnl8iqF9zcqRLVgSOQReC+vxMELIzORM2RZ+wcIYUZtY18t8YnGo1t2q9oFno1gQBGRsuhyZuMiG//Y8R01OF8O9AzJtrkvRVCpSAF8oR8cKqVgXQR+rKA4RQusC9P/9cuuQg5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR2RhF4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D47DC43399;
	Wed,  7 Feb 2024 08:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295776;
	bh=0AYl4WzV6WW2Nc8HtKxIxfT+OVe87yQ0wW8/JoMsF2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YR2RhF4UBlaRO6Nq0OJbSWLa+UpoVGGz/0b3tOvhySC7B4HVoG7kG99xVwU0CC/2P
	 Z80XVyLusx+aN/0lw7QjFjYQWf7ic/cZpc7SSoWU3hh6GhQQ02MO+zNR79AirEA1z3
	 3SoU+vWk+cGLAYCHD5ONWZ7eCV2OVezg2HHpWzO6bPpjRjal3avmQOiLSj4tCMyWGQ
	 jHrJogBd09TmRnmtTrfQAonYynrQtiCIUeRboQrGRin3pQgQ9tpgVyLe0qAuLcX/cU
	 ZTxa6BOtf2mMvGYe8DiLlkL0T8RG3pMu94rAdVCGiarjpiaO5pom5j1HHIrbZjBcKU
	 1N40p+g9ftTxw==
From: Vinod Koul <vkoul@kernel.org>
To: joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org, frank.li@nxp.com, 
 imx@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org, 
 linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org, 
 shenwei.wang@nxp.com
In-Reply-To: <20231221153528.1588049-1-Frank.Li@nxp.com>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v4 0/6] dmaengine: fsl-edma: integrate TCD64 support
 for 64bit physical address
Message-Id: <170729577399.88801.12960357287114595.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 09:49:33 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 21 Dec 2023 10:35:22 -0500, Frank Li wrote:
> Change from v3 to v4.
> Fixed tcd64 type as fsl_edma_hw_tcd64
> 
> Change from v2 to v3:
>  - fix sparse build warning
> 
> Change from v1 to v2:
> - fixed mcf-edma-main.c build error.
> - fixed readq build error. readq actually is not atomic read in imx95.
> So split to two ioread32\iowrite32.
>   It needs read at least twice to avoid lower 32 bit part wrap during read
> up 32bit part.
> 
> [...]

Applied, thanks!

[1/6] dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
      commit: 5dc604455dcf20bdca639bf6b8ea2ea60d39c022
[2/6] dmaengine: fsl-edma: fix spare build warning
      commit: 537df9ab2d72bb782926a7d263a9f0a101e60b2e
[3/6] dmaengine: fsl-edma: add address for channel mux register in fsl_edma_chan
      commit: e0a08ed25492b6437e366b347113db484037b9b9
[4/6] dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
      commit: b51dd7c8aac292396d038d0a9fb9c1589addb515
[5/6] dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
      commit: b7b8715b430ee4431bd675687c5bcda113e7ddd4
[6/6] dmaengine: fsl-edma: integrate TCD64 support for i.MX95
      commit: de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2

Best regards,
-- 
~Vinod



