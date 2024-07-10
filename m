Return-Path: <dmaengine+bounces-2665-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720DD92CF03
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46EB1C23094
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C2191490;
	Wed, 10 Jul 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaqEGtMu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2618FC7C;
	Wed, 10 Jul 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606500; cv=none; b=R7X4H4WfZONphN/JaReLLpnFMbRdRx2gesHYuRF2HAea3D/5iXYpwihtjHLQUyxeWlQhevMejS6/T+Jr+gMUgVX/UdBLpGD9JTimJxhM06a/JHDJQPWL3nMqF21R9ZsB/GPu34D0/wUA3T0ZmSOU36uxhK+W7oXR44MCQ1X94yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606500; c=relaxed/simple;
	bh=d5VoCxN+gY8ansm1s+zZwfALpEKjp7Ag+ea5aujGdi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HdZT5B+P0y8aelBUpQJm369O+JIOnl9J+/v4PrEwR7c4tk16y01HzUF4TAMJJthro0hbvcncHJKlggke7wXXWK+0Iyck8QgRTS7Xqp5Q7NiBxmxQwOjr0nT/LgicwlEMGrt4RMSz97Eofnz1PKnTxNcnyi8YGE+EDjcwcPuJyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaqEGtMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A84BC32781;
	Wed, 10 Jul 2024 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720606500;
	bh=d5VoCxN+gY8ansm1s+zZwfALpEKjp7Ag+ea5aujGdi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZaqEGtMuheIcEBlWTutHUIU3OadfMjVZ41jSPnTw7bi9J8X6ltCnODZYpmh/WfPN7
	 w4QS+0Bps8kJD9Plp+CGR2sdRC46N1nh5WenV6nu9Cf5EQ1uuj4yZHecjVCZvHCwnT
	 Xy22WHFpAbzjMjTjs8ST1vCzKRNJdjlGRjN92cw8Xgvgkb85BJdzIkK1gtPjnAsJFq
	 oglnAWKvhsYKWxq7E+xfeClCjTgNPSHaJcN7chzItJ79a8aS2COQinEL35tTcsr+fw
	 rTm8/qKJ0lraiLV9sfZmuO75qNYUBaVnPMV1eDvGwky17hfbiNulO0MicQE1D1dynw
	 uufLW/bMzwtVQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <Zob1+kGW1xeBKehA@standask-GA-A55M-S2HP>
References: <Zob1+kGW1xeBKehA@standask-GA-A55M-S2HP>
Subject: Re: [PATCH v2] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
Message-Id: <172060649710.379904.12694701156645770094.b4-ty@kernel.org>
Date: Wed, 10 Jul 2024 15:44:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 04 Jul 2024 21:20:26 +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 DMA bindings to DT schema.
> 
> Changes during conversion:
>   - rename file to match compatible
>   - make interrupts optional, the AGCP DMA controller doesn't need it
>   - describe the optional ashb_eb clock for the AGCP DMA controller
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
      commit: 5bcf62748f37b81fb41b112cc87c2788c8ddd972

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


