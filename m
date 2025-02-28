Return-Path: <dmaengine+bounces-4620-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0CBA4A1D6
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 19:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14177175D08
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501E527CCDE;
	Fri, 28 Feb 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlsyN0Gd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789627CCD5;
	Fri, 28 Feb 2025 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768035; cv=none; b=ILufs0cIKqc0ghpXaVjC9QnSqcMgxpB3+yzN1/Yuv+LKS2w53ruzWIYr3mJEyALIHojWZDVz08Lb4GYrbnmKSEfE4xsSnKUEBB45ex6yvUMygtvBve62z7Yfqel+USBSeMV7bud48PoOabfpdW5EUUrWsfLbY2fXvAwDcKK9kyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768035; c=relaxed/simple;
	bh=UN+C1dvi8NPDnm7e95Fw0RuFjAgd/7yIbPdqu6pQdes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enftzsHusgL0xFKadw8SC+Bxv+1lpEg4icmP1AmdvZp5mBF5hfrcCvLVeZyK8wYhkv/YGcffLNAIdZvKJ2dY9cNBN+XRrrtygVToVdWjo2RdAUq2WPRASvxqZ2Xfv+9BLnL13uElrrf7cQllIvf9l0N4l8J4SFS7fp+oLap7fbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlsyN0Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857ABC4CED6;
	Fri, 28 Feb 2025 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740768034;
	bh=UN+C1dvi8NPDnm7e95Fw0RuFjAgd/7yIbPdqu6pQdes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlsyN0GduLxPitvaKl2R/lusE3nA7HIeKsZ5KfQ/NawT9RhyOuIgrEqTU9gJWbHxW
	 dUcQllQrSgJjWU3jH0drIt48Lq6O/m+kAnBI69Wzna91Xi2sPuL2IeQyBDadUYj2/2
	 YWxzrPMyRnhJP7DAsBA9wWBiqM5pSTzZgnzXLWbe+XcxTEfL9JOp1qmNyk1KuZ9H05
	 ims/Mdeqd9B5fTURzVBSQGjj4jMPTIC0yco3GwzhCtTRlu/sP0PX2SMp5iKrUIO6F/
	 ssSB8eIt6Fo8r8aqLF52N9EEONUcD86u3VzafS/3U7AuqkXJEZQfVowky8G1kjvWbU
	 eWf0j2Fea1Zvg==
Date: Fri, 28 Feb 2025 12:40:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Arm DMA-350
Message-ID: <174076803222.3434143.1291834928584726380.robh@kernel.org>
References: <cover.1740762136.git.robin.murphy@arm.com>
 <2918c3b4403f78b89f46e32f7572eace9f50ab93.1740762136.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2918c3b4403f78b89f46e32f7572eace9f50ab93.1740762136.git.robin.murphy@arm.com>


On Fri, 28 Feb 2025 17:26:32 +0000, Robin Murphy wrote:
> Arm CoreLink DMA-350 is a pleasantly straightforward DMA controller
> which, although highly configurable, lends itself to a simple binding
> thanks to plenty of self-describing ID registers.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  .../devicetree/bindings/dma/arm,dma-350.yaml  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


