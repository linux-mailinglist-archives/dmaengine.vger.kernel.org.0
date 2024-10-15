Return-Path: <dmaengine+bounces-3374-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57899FA12
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 23:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03211C23A4A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2024 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1AD1FE114;
	Tue, 15 Oct 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwZuXoGB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5551FE10C;
	Tue, 15 Oct 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027855; cv=none; b=ZgCLR0iKHZEhQv7LfnxkSxtWeQr4aVxXBGHr8z1ViOzAgyUWSXltHdEZ/MNenYtRkoUhU/Iq/PHjmPXtRY8cAsU8GVUHQdrztx5pe0D07A4ORQsaZzW5SHRy1+G6wEetsPHbm4IF4Dk2v+WEFCw3vNb1QyFBimKLTVA1kwSWO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027855; c=relaxed/simple;
	bh=U7XE5u0pRR0pjYvZzMuh+uJeZUztv2GjXrvRNqavzVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpILyWTA7b8k2q08HrVao/Dj9S+6QKLdiJ5FbZYPdEl7xAIRVPAl4jR/ghWR3MOUu/6tWOSYP+/18/MbRlKkSCYY60Obb5c2T2bgHfxrJMfRDcbvWmQUF9YXCLmgRNKpVXchTTCbHGuJJngz/pBsAZz06GIkSAv5A8NDBieTD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwZuXoGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E940C4CEC6;
	Tue, 15 Oct 2024 21:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729027854;
	bh=U7XE5u0pRR0pjYvZzMuh+uJeZUztv2GjXrvRNqavzVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwZuXoGBhtKmtnUGkO9xhM+OkaS9RCQXoW1EB2LgyL+yZks5KwPMA3TkdudxYKAT6
	 N7Fbp+l2LfaBB1gbBDmJZ3n97fnpu/SVZIDwSw02u+nA+/AxJiA7iv5EGQxutMkpNk
	 WfGRBQWhKzGlehhRjbyCfstJtjq48xsNR0DNnZA+L31+WSZRUwXioxeqHUlDRIZ76G
	 KA52D7nTrumkV9YhnLUtxGk3Dewd+LKyXFAt7l/2a78sk/4FWo9yYbtey2P0JR3vi8
	 wKqlN916tSBZdEamcVw3Xgt4t+EW4V6i/QpH3Ew1SKMWa4UmLnodB92b5KiWEys1cP
	 jSa/R3fVTwFng==
Date: Tue, 15 Oct 2024 16:30:53 -0500
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] dt-bindings: dma: stm32-dma3: prevent additional
 transfers
Message-ID: <20241015213053.GA1992090-robh@kernel.org>
References: <20241015-dma3-mp25-updates-v2-0-b63e21556ec8@foss.st.com>
 <20241015-dma3-mp25-updates-v2-4-b63e21556ec8@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-dma3-mp25-updates-v2-4-b63e21556ec8@foss.st.com>

On Tue, Oct 15, 2024 at 02:14:40PM +0200, Amelie Delaunay wrote:
> stm32-dma3 driver refactors the linked-list in order to address the memory
> with the highest possible data width.

You are still talking about driver...

> It means that it can introduce up to 2 linked-list items. One with a
> transfer length multiple of channel maximum burst length and so with the
> highest possible data width. And an extra one with the latest bytes, with
> lower data width.
> Some devices (e.g. FMC ECC) don't support having several transfers instead
> of only one.
> So add the possibility to prevent these additional transfers, by setting
> bit 17 of the 'DMA transfer requirements' bit mask.

Some devices require single transfers. That's about all you need to say.

> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v2:
> - Reword commit title/message/content as per Rob's suggestion.
> ---
>  Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> index 5484848735f8ac3d2050104bbab1d986e82ba6a7..36f9fe860eb990e6caccedd31460ee6993772a35 100644
> --- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> @@ -99,6 +99,9 @@ properties:
>          -bit 16: Prevent packing/unpacking mode
>            0x0: pack/unpack enabled when source data width/burst != destination data width/burst
>            0x1: memory data width/burst forced to peripheral data width/burst to prevent pack/unpack
> +        -bit 17: Prevent additional transfers due to linked-list refactoring
> +          0x0: don't prevent additional transfers for optimal performance
> +          0x1: prevent additional transfer to accommodate user constraints such as single transfer
>  
>  required:
>    - compatible
> 
> -- 
> 2.25.1
> 

