Return-Path: <dmaengine+bounces-1763-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4F89B0F4
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475F01F217C4
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E977374D2;
	Sun,  7 Apr 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbUwEcEe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118436AF2;
	Sun,  7 Apr 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495157; cv=none; b=KrBop4yPTAKOiQKhdqU7ydNnmV66zzD/4p5PH4quAsR3D5EKZ8qrt897U8LHUsIIa9qjEVgLc+SyMXlz5FeOuT9btmd7wvQuus9a0UjfYk9FQ4pJud1rfVruVAlybNUXU7mrlKoWI62ZNAWAnf0dM/hhNM5d0/9er11WsO2m0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495157; c=relaxed/simple;
	bh=rUQZhPXE7dgEiXf1PL9N6dUv53W10HMt4pavSzMy8Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCI7lI0tIog8fh95tBxBnvwyZU6YqT89G/Q7ATGPmPWWm2P5bAmHycUAC1m5CsLpkrp4jtfh9qVcV8ISOWv+acurhqY/RbBIACQM3BQrhFCoVa8LS5RqZRuzGTBa8FfOBtpExC6pUVUmRUTIAWV+DKH8aF3X/JVNAXBRYRZ+2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbUwEcEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239BBC433C7;
	Sun,  7 Apr 2024 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495157;
	bh=rUQZhPXE7dgEiXf1PL9N6dUv53W10HMt4pavSzMy8Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbUwEcEe8bVkf3nn3DuCP1fsDe4+fsNfUy8hQAZRh1zSgAgfKN2dBsx9fQlFYIFao
	 qFODa9otUh/ZmrOldyfBodpGOAATqqbhEs1ot3hRaqp2dhiyIcV/fyA/CBwP2Sl9p9
	 V2pyjcRMJUzcCI5qtKc3YlCS4at26I3c9o5cFqbUf7C+mLMqBmEeekBbd2r8KGOMsV
	 5kToOmx3X+spgS3o77M8eqnJxKSIFIYr9fwgcHkONJsO65z9xDt/cuupSeoowiUHSK
	 Aw2nGeOpvGt56HPLESrRW2a3VY4/hP/TIfrhWtKStAV9iZmnxHsMFsl8rZkCLo+o+c
	 AVVoDB8zdR8GA==
Date: Sun, 7 Apr 2024 18:35:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width
 schema
Message-ID: <ZhKaMALmkmS-G7lL@matsya>
References: <20240311222522.1939951-1-robh@kernel.org>
 <ZhKZwp4n7RYlprP-@matsya>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhKZwp4n7RYlprP-@matsya>

On 07-04-24, 18:34, Vinod Koul wrote:
> On 11-03-24, 16:25, Rob Herring wrote:
> > 'data-width' and 'data_width' properties are defined as arrays, but the
> > schema is defined as a matrix. That works currently since everything gets
> > decoded in to matrices, but that is internal to dtschema and could change.
> 
> This fails to apply on dmaengine/next.
> 
> Can you please rebase?

Never mind, the v2 worked just fine

-- 
~Vinod

