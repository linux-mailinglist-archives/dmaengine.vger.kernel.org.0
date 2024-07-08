Return-Path: <dmaengine+bounces-2658-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1042392A539
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC8F1C213E6
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729A1419B5;
	Mon,  8 Jul 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMldzcZ/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547178C75;
	Mon,  8 Jul 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450665; cv=none; b=he3/YyRLNvSjNaYFifJiOqUlAoYBfZS+yNpEcCZmSaNvfP5e3LFVxyaV6sJllf65BVlqRLPskRwu90sNzjSJaRfyxF7rD5Ph+cpluz2TImtCtxt9RLHBYyQ7LsyeYU/+Q0OrnjacYx9F5Jqmbo0ZiX3dM1n/f9BdrGObs0r6i0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450665; c=relaxed/simple;
	bh=t3OYkYjix8IJpow3wMwPk0XM9j379SyIv7bnbNi/g90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDOnjKi02NRwouMSF7XWSUijHo5n4Ku+9qFlWOfCSB01sLO5XVeIm8eM1SoIFVg+ng7mIkuaSbAnpaBffNcZnO6fAv2OuDFjfbVZSKP1RLVGiDW/PuQ7zqEZGKboWgMDijZzBMiX4bagGSE+7+c66CtTQ79lU55Dz4RSaEkkXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMldzcZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F4CC116B1;
	Mon,  8 Jul 2024 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450664;
	bh=t3OYkYjix8IJpow3wMwPk0XM9j379SyIv7bnbNi/g90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMldzcZ/H9dwnzPc9QU8rcGzldgs2atBLuD8xwB9HdUzNUBsB2VyQA8q3/bBGzCS+
	 ZPw5SrKZbSGUYzigeHmmID/ZwOGkphjgURZlzgoTLSIYMdStNzC5n338WNhR5+3Sym
	 35/+8elaMfacqmWnDrH300NMfSg4SuseWn0NDgsNgb71TDEBrcPhv8yMcWMcV5aq7n
	 OzPHo/RCC5uBwrZrGBYbwAtoGN1z1TPk5dkMK/FQSHutL+s74IeJZ8ePzC+IlbgeVi
	 117MsJb0E0p5SxmcG5l+0JME3bIt7OvFoWm3eeGoG5+BNRSiKcO8sIZvFe/zXtK015
	 aK3CAYv3M9waw==
Date: Mon, 8 Jul 2024 08:57:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: fsl-qdma: fix interrupts 'if' check
 logic
Message-ID: <172045066129.3180056.14093408400794143570.robh@kernel.org>
References: <20240701195717.1843041-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195717.1843041-1-Frank.Li@nxp.com>


On Mon, 01 Jul 2024 15:57:16 -0400, Frank Li wrote:
> All compatible string include 'fsl,ls1021a-qdma'. Previous if check are
> always true.
> 
> if:
>   properties:
>     compatible:
>       contains:
>        enum:
>          - fsl,ls1021a-qdma
> 
> Change to check other compatible strings to get correct logic and fix
> below CHECK_DTB warnings.
> 
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb:
> dma-controller@8380000: interrupts: [[0, 43, 4], [0, 251, 4], [0, 252, 4], [0, 253, 4], [0, 254, 4]] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - Change  maxItems: 5 to minItems: 5. because maxItems: 5 already restrict
> at top
> 
> interrupts:
>     minItems: 2
>     maxItems: 5
> ---
>  Documentation/devicetree/bindings/dma/fsl-qdma.yaml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


