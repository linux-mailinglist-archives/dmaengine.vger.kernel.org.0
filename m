Return-Path: <dmaengine+bounces-7358-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E8C89079
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C6D3B2F03
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F553164A9;
	Wed, 26 Nov 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH1bGdMA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E763019AA;
	Wed, 26 Nov 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150065; cv=none; b=irzjN7KYfyNR4llT73h/wkU4btUoXNg3KOk4McNGiogjlLoBjmAi5G0VlJEiRC+n9r9SOIdhi+XRHKVg93hEKrzDbGPEmeCV5tV9iphV+FPHh4KPYnspEAMopRaMgnLASM0/FKbFSiG7NW2sJsavtz66JbRidCZYJLIOESmgDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150065; c=relaxed/simple;
	bh=2A1+6ikQS2cFDqeaqbcWKjj8PkwHoghi5FBELNGe0aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAlkcL2vtf7LK7WmQ9iSd8AghIR5tlYM1JaXHvIwjmprIfN2qgquggqCy/uRiCca89pgxsYWzhRygYlAlxGsjdu7H1R8sse1gh4CNIC9EK8EY8jjVbukeBUxEaMuov9upj0nWYovW96XpL8oR+/IrboxHr4lOTCwXT58w3+njZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH1bGdMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A450EC113D0;
	Wed, 26 Nov 2025 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764150064;
	bh=2A1+6ikQS2cFDqeaqbcWKjj8PkwHoghi5FBELNGe0aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TH1bGdMACILrMX7gjEOo0oSzEZdkrQRdVCdJYv6T0aoNouFQv6xl6Rw8WQFO4gFpn
	 iY59VdF34z58rowyvqP6Vsip/oVwAF6f8NwLWcgxdAdIvNYCGoUWvwm5OXRA4Ubaol
	 hOcRK7MNsYzOv5G+Vr6LBH4VvfHwbbLBjps4/zi2OSp+55z5U1Uz416YTjze1bpkmu
	 hm1Ey+aCR0wm+AnvoKF0IEijnODqIdaiwFbZLnQLzcKG+Ad+FjU5rl5mQdNJu9dEK3
	 DHywWI68zkQlQMCkM+Vc9h0tf/uXtQbcw+w2WhbelVNO1Dcxie1qbaiF0MXMQ+MxuQ
	 4bFJPHGjBVjRg==
Date: Wed, 26 Nov 2025 10:41:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
Cc: Rob Herring <robh@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add compatible
 string for Agilex5
Message-ID: <20251126-frisky-puma-from-valhalla-e3ee05@kuoka>
References: <cover.1763598785.git.khairul.anuar.romli@altera.com>
 <bd19d05233cb095c097f0274a9c13159af34543b.1763598785.git.khairul.anuar.romli@altera.com>
 <20251120173608.GA1582568-robh@kernel.org>
 <e049a03a-49e3-4b00-a3e8-7560f63fa61a@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e049a03a-49e3-4b00-a3e8-7560f63fa61a@altera.com>

On Wed, Nov 26, 2025 at 07:43:42AM +0000, Romli, Khairul Anuar wrote:
> On 21/11/2025 1:36 am, Rob Herring wrote:
> > On Thu, Nov 20, 2025 at 07:31:10PM +0800, Khairul Anuar Romli wrote:
> >> The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
> >> will cause address truncation and translation faults. Hence introducing
> >> "altr,agilex5-axi-dma" to enable platform specific configuration to
> >> configure the dma addressable bit mask.
> > 
> > That's likely a bus limitation, not an IP limitation. So that should be
> > handled with dma-ranges.
> > 
> > However, adding a specific compatible is perfectly fine.
> > 
> Would it be okay if I rephrase and send the next version with a 
> correction in the commit message body as your comment in this version?

Yes and your DTS patch might need changes - include proper dma-ranges.

I also do not see how separate compatible without any driver change
solved your case. That's a no-op patch from Linux driver point of view.

See also submitting patches in DT dir about the process how patches are
grouped together.

Best regards,
Krzysztof


