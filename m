Return-Path: <dmaengine+bounces-3328-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6687998F7D
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 20:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32911C23EF1
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569651C9B93;
	Thu, 10 Oct 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkLoNcUh"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DBE1C9B64;
	Thu, 10 Oct 2024 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583884; cv=none; b=CN7iq0ef3nDp+CNstgCBJN393QALnCgmtfDRbt5+CpYaCZCCnPAqEq7pcEd1Cc7pBcj2/mDbZYBmU1uxAR8SHVXdvuvTbAxPM70OXm/c/hw3ScwifYOJVvvvFobx96MIYa2AmR4OOb0tF60Fx7HJCRKWnEhds4VJaZuev+M4oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583884; c=relaxed/simple;
	bh=9eB11WqtyHOt+MBm/RTQKveBaJUUL+c2eHCqHHpop84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt3YUou3oW9PZReLTdUJtdeMVqAg8U7d7amDlQs6UFRUWippvYS6nMcm6F75UOeU3zmePP6ePrV+0/W5y1NuZCRTap6CoviUDDTPGcwRU0HG9Tw1CrhmuJCpIuHdeAFVEo2iegP/gbYGOh8iv8T50t0cEk0QkCgaJsDJwxM8x0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkLoNcUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50672C4CEC5;
	Thu, 10 Oct 2024 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583883;
	bh=9eB11WqtyHOt+MBm/RTQKveBaJUUL+c2eHCqHHpop84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkLoNcUhN4Nhu8seaL5Sq3HThSd9JqrmwB8zT4kdzEx9wZC/Ao/cVGvsFyliBue6C
	 EMYHnrxHWWB90dzEd+iww7ivqMpPgHi6lbXY4GIX8ALUync3fsCvkCBmj/zxpW8qQY
	 Wbnkr50JnbaaALbFPhzd/VzAFQlNnXF+/NvnEPvcoM5oCtk9LnS/72lCZXObY5DANn
	 gN8/EwrvK5ZbAtaE0HGT7Iv9lcc98yrIp9nOW8RemMErjoxWJ/W7QX+B71ai8JRWdt
	 k1jlSHzlkurbAziPrUN0g/gadXnOJFv5haDAJUXQCBQteBCvLgslnYAor7EkpLsN7v
	 IZGiSvg1cu3Yw==
Date: Thu, 10 Oct 2024 13:11:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] dt-bindings: dma: stm32-dma3: prevent
 packing/unpacking mode
Message-ID: <172858388128.2107709.9101314940508767335.robh@kernel.org>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
 <20241010-dma3-mp25-updates-v1-1-adf0633981ea@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-dma3-mp25-updates-v1-1-adf0633981ea@foss.st.com>


On Thu, 10 Oct 2024 16:27:51 +0200, Amelie Delaunay wrote:
> When source data width/burst and destination data width/burst are
> different, data are packed or unpacked in DMA3 channel FIFO.
> Data are pushed out from DMA3 channel FIFO when the destination burst
> length (= data width * burst) is reached.
> If the channel is stopped before the transfer end, and if some bytes are
> packed/unpacked in the DMA3 channel FIFO, these bytes are lost.
> Indeed, DMA3 channel FIFO has no flush capability, only reset.
> To avoid potential bytes lost, pack/unpack must be prevented by setting
> memory data width/burst equal to peripheral data width/burst.
> Memory accesses will be penalized. But it is the only way to avoid bytes
> lost.
> 
> Some devices (e.g. cyclic RX like UART) need this, so add the possibility
> to prevent pack/unpack feature, by setting bit 16 of the 'DMA transfer
> requirements' bit mask.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


