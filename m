Return-Path: <dmaengine+bounces-5019-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C86A9A08A
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 07:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588B73B3128
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 05:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6C91B392B;
	Thu, 24 Apr 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL2/vmrB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A91AA1D8;
	Thu, 24 Apr 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473023; cv=none; b=lz0O3lmZWv+tn62tNKER5je5+gkbget+OY+FtN/bzEfpPnTKeSEzWGtlSJD0an70PO3Kv+cG1nkDCfYW2GhSCVnQAL+fWY9yCPEMXAYNrq226cMxypBCAgawh0ZEgevQ7RUz7iGyPsZiz5NQRHPSb61UZzWVMoFhYlGCZVFj70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473023; c=relaxed/simple;
	bh=Zhj03Wn3IByVJPKb+sDHS8tWFv0G8C9m6nuaATcy4Dc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AMHJVvZQG4AwK69QYp9+3QMpwXvYVo2RtfWsHNi6sIep9EFSGbO8GdgakWtC0zvONms/v4ALFVsB2QlwIN/3S6Z+JNYa+dHrwyL/O1RpHihCQYEwr4rZ12HDlCrGeONplaaLYr8NhPNTvSXEB/9YOuEAVPd4RJvEo1tOVpT7+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL2/vmrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EC4C4CEE3;
	Thu, 24 Apr 2025 05:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745473023;
	bh=Zhj03Wn3IByVJPKb+sDHS8tWFv0G8C9m6nuaATcy4Dc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HL2/vmrBvRRHlyZtjtWum1nvAq0wmELn/TrhD7WRkGVkh62nm+N2MHWzJjlsfdszB
	 UT/IHnD5UjmoRpxrpcGPMDooAQ7MY7bUEjBFucJHe2DNJUhHgu4oAzCzGwCeA7ziUI
	 DnFRJqBh1/pAOEf9Hg3s5DcVgZ2EQ1Y0V+4bLNbbEd9pA+C4zs7ARewKW8ApSsNrMB
	 mcg9hvJd1z2XzZP81iEriS+KOb00ne7yXXEpAQ5M3pba46D6kp3+azdONiWT0avJqJ
	 5bZYJ+zjEVoQ2GbTC5VMkrmf4b/A+ZTkQxi7uIqdHqMji8+GnjFOmwAupJ8v4D3NeN
	 dO6dLVYmX9dWQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Joy Zou <joy.zou@nxp.com>
In-Reply-To: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
References: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
Subject: Re: (subset) [PATCH v2 0/3] dmaengine: fsl-edma: add error irq to
 help debug problem
Message-Id: <174547301902.316124.419798258552986948.b4-ty@kernel.org>
Date: Thu, 24 Apr 2025 11:06:59 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Apr 2025 12:46:34 -0400, Frank Li wrote:
> Change binding to support optional error irq.
> Add error irq handle for fsl-edma drivers.
> imx93 dts add dma error irq interupt.
> 
> 

Applied, thanks!

[1/3] dt-bindings: dma: fsl-edma: increase maxItems of interrupts and interrupt-names
      commit: a9ea01f28408169431dd3e6464ed2e48539f4280
[2/3] dmaegnine: fsl-edma: add edma error interrupt handler
      commit: d175222f5e90b7e1f23713378823c338fabb3258

Best regards,
-- 
~Vinod



