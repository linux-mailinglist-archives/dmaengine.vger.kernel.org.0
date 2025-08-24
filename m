Return-Path: <dmaengine+bounces-6184-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C055B32EE8
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF694E1DA6
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521D255F39;
	Sun, 24 Aug 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5KrAY3H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B931F17E8;
	Sun, 24 Aug 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029979; cv=none; b=aRGAC2+wi7jJy7tD7fZisQ4DXNVa5hVtGUl7fh5uvYlLQhUZ8Ztzq5HKxjSZRnAUPlJpQgX+kHZDsKO81FWXD3UcPHZ7v15NrbjTukEbNaTwtZ6If63GxkDakhkEh9mNL6jmsJxxTkGxski8L/B+ymU9mjRS5E1u4BgVT6vBCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029979; c=relaxed/simple;
	bh=4mLEnNFd4EpeNGIxEHBP3OJwfgbd05akBDpKZWI1BRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5DHe26iSOtUKV6tm0HVEfw9Fh6xk2wpL+kTS2LNmBxBnjPNKwH/Q6BNbVBcVnJaSxw7KvraVGeOyqsISMFn1+Bm7cNQqfskxzkS32J/Cqk4NVPyzpgKAkH+CzR5yCgLFe7T8SHJvWLWOiDSa5NxxH2k7kF/lFsEunhuENW/4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5KrAY3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC38C4CEEB;
	Sun, 24 Aug 2025 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756029979;
	bh=4mLEnNFd4EpeNGIxEHBP3OJwfgbd05akBDpKZWI1BRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5KrAY3H3VYZfk4OirfR4BXFGb3RpS6zQHISuwoVfNVzo+5MKvN9xZE4zleXOz5zu
	 RHX+Q8nULuVT/zJGW4fpEep4COFtxWreZaAQj1gPf2jf5wE4M/H5Lyru6zNDdLBITf
	 XTamOG/eRZHQVGVZFg1KSYxVVMGq2khK+7IAHwZdWBntR9HDLHu9azBmnlQpbtnYf0
	 FoMNBFdODr2s96MMlBlv+5w8qZq2n1QmMkaN+iuKGBzvPREQZVacClkvytsJ4jk54f
	 lvODxSdgPmIpXkiiEYk5PnIyQ9/SlIdcv3pcIPAMpvgd/CZtKfuVl/8tDXuWL6Z1km
	 5323e9P9lgh8w==
Date: Sun, 24 Aug 2025 17:49:01 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] dt-bindings: dma: dma350: Document interrupt-names
Message-ID: <aKrgDVaynJxnmR9r@xhacker>
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-9-jszhang@kernel.org>
 <eda79403-375b-4d49-9fec-12bc98bf9e47@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eda79403-375b-4d49-9fec-12bc98bf9e47@kernel.org>

On Sat, Aug 23, 2025 at 06:09:22PM +0200, Krzysztof Kozlowski wrote:
> On 23/08/2025 17:40, Jisheng Zhang wrote:
> > Currently, the dma350 driver assumes all channels are available to
> > linux, this may not be true on some platforms, so it's possible no
> > irq(s) for the unavailable channel(s). What's more, the available
> > channels may not be continuous. To handle this case, we'd better
> > get the irq of each channel by name.
> 
> You did not solve the actual problem - binding still lists the
> interrupts in specific order.
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/dma/arm,dma-350.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> > index 429f682f15d8..94752516e51a 100644
> > --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> > +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> > @@ -32,6 +32,10 @@ properties:
> >        - description: Channel 6 interrupt
> >        - description: Channel 7 interrupt
> >  
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 8
> 
> You need to list the items.

I found in current dt-bindings, not all doc list the items. So is it
changed now?

> 
> 
> > +
> >    "#dma-cells":
> >      const: 1
> >      description: The cell is the trigger input number
> > @@ -40,5 +44,6 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > +  - interrupt-names
> 
> That's ABI break, so no.

If there's no users of arm-dma350 in upstream so far, is ABI break
allowed? The reason is simple: to simplify the driver to parse
the irq.

Thanks

