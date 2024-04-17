Return-Path: <dmaengine+bounces-1876-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3488A8BA7
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 20:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C921C2195A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE24E1BF53;
	Wed, 17 Apr 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxEpOFV4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D8BE55;
	Wed, 17 Apr 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380035; cv=none; b=SIe6b7u1nlSI1RLU1n3edzkyw20fVRrtm11uuqlIsNsoVUsQgArBmnktLR03YjG17UD0IdfsWY/EQow/OC6HUQX9UYUwHNNOqng7+PuSMx5i/SwnG9uhcLoKrWLfuH3ChiSsrliLimBpX3m85fI1qnCdgZ1BquuYeVzZHkH4c20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380035; c=relaxed/simple;
	bh=DDeR74mS5DOOoMadoBx3ZbQGlf27ZzKZOa0om7KQJ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0emYvYaW/RMtPIn/UtzWLCHkIowynT6WtXXIQUBrTxUKEpTq2Zp9GCiChAaFk22r4GJ8NXKHOtACBr/taM0N+cktM82KccRj0lvssdWYdwXGqQO8WcV1pspGUJj2cYl4+DpFNuBEUw6mCicLVHD0XbQPq1eEOkL/p05lCc8wks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxEpOFV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9131C072AA;
	Wed, 17 Apr 2024 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713380035;
	bh=DDeR74mS5DOOoMadoBx3ZbQGlf27ZzKZOa0om7KQJ/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxEpOFV4BpdpKyEL9i/ywCy1U9Eb5aABJViZaxaimKZiK/AXh8aKsz98wu86KyKha
	 4jGLFaZVp8L4E1s0Bi/u9FnzHoBvR6efGQHGV3036NcIuHFY0Sli000i6t6br1wyO7
	 GOrSgeRuX0BE8LD/KQHo8YS2o8gqs7N92hMnYtoBXGuzKnAzx4n/0ERyL0HuSXxTbX
	 x3byMrVFrryUuJA4M8geZjs50XaEG8msZJ9aHnAo1y7fx8Lo6bwFC6iUPnV5Q9y4uC
	 ShUqrS+M7ky9FfUmkWKd6/CMN85hxRiN0aDpYYYv6C5mtTo5i5rIBCRxs+v9La4WlT
	 i5Df56bvDpoBw==
Date: Wed, 17 Apr 2024 13:53:52 -0500
From: Rob Herring <robh@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: frank.li@nxp.com, devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	imx@lists.linux.dev, vkoul@kernel.org, peng.fan@nxp.com,
	krzk+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: fsl-dma: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Message-ID: <171338001766.3087074.396640733918635003.robh@kernel.org>
References: <20240417032642.3178669-1-joy.zou@nxp.com>
 <20240417032642.3178669-3-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417032642.3178669-3-joy.zou@nxp.com>


On Wed, 17 Apr 2024 11:26:42 +0800, Joy Zou wrote:
> The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
> The compatible string "fsl,imx8qm-adma" is unused. So remove the
> workaround safely.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v4:
> 1. adjust the subject to keep consistent with existing patches.
> 
> Changes for v3:
> 1. modify the commit message.
> 2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


