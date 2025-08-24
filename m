Return-Path: <dmaengine+bounces-6188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099CB33021
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88C0441F8B
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBFE26CE3B;
	Sun, 24 Aug 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRvm6Mx6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AD20A5DD;
	Sun, 24 Aug 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042603; cv=none; b=FDbIprVjsixANaQo0XpPW0s7qMmBN1zG3ontSwiK0DYfz73PLPw+1QUvUHiMbeyXCB1Uu5JP+2ETvFs0Zmc7SArbiHk7gGlew5k+u1g6NRybhP2zq8YhZajAYraPNf3/emw308lEDHg5psmVn+3DG0R2yb4x4N6q8xxddv68zsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042603; c=relaxed/simple;
	bh=fcGUraZ1oJA1YVuwW6DMgYgjKRehssHsmjbx5Lc2lTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUX5ugdfiWaO9EPZ81Od1p7fKPKqegiQZkK4jZozvxXXkU5vdXwYGHnNgHDdebaMz/08XwQUMlzotx1BgfuVEEw0t4AmFN34JAFQpAKGLHabxvaPMbZzFUvp2mlh/Q0W9/cBpe3A+ZBqNoLyVxN7nfQxzPOCfkn78nWg5YZmgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRvm6Mx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DDAC4CEEB;
	Sun, 24 Aug 2025 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756042601;
	bh=fcGUraZ1oJA1YVuwW6DMgYgjKRehssHsmjbx5Lc2lTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRvm6Mx6/1ockfTRhz2Brx4DLmpJLHOJtJ/PnG98dNVAZYvrbljdn1zikb2icUpg3
	 LWt140p3aamp9WlXVIUR8glS29TnUO94Yy7rTfd+6zOU6D9IpeODBMr/O1kUc8VDg5
	 4n8AQTW06jZmGZON8IeXFK27Nb61HA9QEJEph6lB9QjEwDim+7nycfh+ORLouqHMvd
	 T6RdqzFY+BhwcUixTeE9UGIlHTd8Q44pa3g9KJEKp0tVmAIMlevzKESkpqp3++TQiV
	 2wkh6PphmZLyAuhV0c8Z9ZJ6QI0XCC7MTp1X0ZkGayDTLTXWcgUqk17I1T0b9fkBHM
	 xXcP9pEXmgGOw==
Date: Sun, 24 Aug 2025 21:19:24 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] dt-bindings: dma: dma350: Document interrupt-names
Message-ID: <aKsRXFZ8h08w-vbf@xhacker>
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-9-jszhang@kernel.org>
 <eda79403-375b-4d49-9fec-12bc98bf9e47@kernel.org>
 <aKrgDVaynJxnmR9r@xhacker>
 <f28fd898-83f2-46af-9f5d-b98be4518520@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f28fd898-83f2-46af-9f5d-b98be4518520@kernel.org>

On Sun, Aug 24, 2025 at 12:30:40PM +0200, Krzysztof Kozlowski wrote:
> On 24/08/2025 11:49, Jisheng Zhang wrote:
> > On Sat, Aug 23, 2025 at 06:09:22PM +0200, Krzysztof Kozlowski wrote:
> >> On 23/08/2025 17:40, Jisheng Zhang wrote:
> >>> Currently, the dma350 driver assumes all channels are available to
> >>> linux, this may not be true on some platforms, so it's possible no
> >>> irq(s) for the unavailable channel(s). What's more, the available
> >>> channels may not be continuous. To handle this case, we'd better
> >>> get the irq of each channel by name.
> >>
> >> You did not solve the actual problem - binding still lists the
> >> interrupts in specific order.
> >>
> >>>
> >>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >>> ---
> >>>  Documentation/devicetree/bindings/dma/arm,dma-350.yaml | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> >>> index 429f682f15d8..94752516e51a 100644
> >>> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> >>> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> >>> @@ -32,6 +32,10 @@ properties:
> >>>        - description: Channel 6 interrupt
> >>>        - description: Channel 7 interrupt
> >>>  
> >>> +  interrupt-names:
> >>> +    minItems: 1
> >>> +    maxItems: 8
> >>
> >> You need to list the items.
> > 
> > I found in current dt-bindings, not all doc list the items. So is it
> > changed now?
> 
> Close to impossible... :) But even if you found 1% of bindings with
> mistake, please kindly take 99% of bindings as the example. Not 1%.
> 
> Which bindings were these with undefined names?
> 
> > 
> >>
> >>
> >>> +
> >>>    "#dma-cells":
> >>>      const: 1
> >>>      description: The cell is the trigger input number
> >>> @@ -40,5 +44,6 @@ required:
> >>>    - compatible
> >>>    - reg
> >>>    - interrupts
> >>> +  - interrupt-names
> >>
> >> That's ABI break, so no.
> > 
> > If there's no users of arm-dma350 in upstream so far, is ABI break
> > allowed? The reason is simple: to simplify the driver to parse
> > the irq.
> 
> You can try to make your case - see writing bindings. But what about all
> out of tree users? All other open source projects? All other kernels? I

make sense! I will address your comments in v2. Before that, let me collect
some review comments, especially from dmaengine maintainer and Robin.

Thanks

> really do not ask about anything new here - that's a policy since long time.

