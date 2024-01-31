Return-Path: <dmaengine+bounces-920-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7738445EC
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF04B1C24F26
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267C12CDB2;
	Wed, 31 Jan 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGMAA2FH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8312FF60;
	Wed, 31 Jan 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721540; cv=none; b=ZsjUD0DPXIeXLIEo7OXBjAsoQwN1Jr7iZNMRPZ+X739b3wVToYLT4pSfepvjMbrGuuu8GJD9j2QcWFfs8BVt7OtPOPx++FBtHc5eQBwgN0LZJS6wVySrLfmCqd0SrsyChUdYP4ItYhTVLiKjvxtkrjeqZt47NrHtuxojDq1fr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721540; c=relaxed/simple;
	bh=FZOebloMPKqD9PhoGIK6a0A3JsQT79DFjzcP89ICJNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhNsT9Qq0FgF+L4y+9S0ukyTH4g1pzszBxZmzIVeAsVJJ7MGIpvumq8eSNv7E5JULI2JKlpF+p0xqXrUiV8WXuoUOYJXDca6rIETOMTdI+VvxYcw+zQUkf7XjPP/4z4m+XMy499Ky8fpXvZu53c85ANTp3lj2CW5bnYaaPzwAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGMAA2FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4069C433F1;
	Wed, 31 Jan 2024 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706721540;
	bh=FZOebloMPKqD9PhoGIK6a0A3JsQT79DFjzcP89ICJNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGMAA2FHjpQXtjuRk8e6xfv27+wW8njNB9eQvHRFQTszAk0cT2WDLNXgnxquGFFPF
	 mWHZsfg4wjo4lS1ad/eQh5ojmxWaNQhmH7cbkdx4+BAgQoZUFR+rPl/duLCuqMdTjB
	 X+F/mP7XMadWhazWO/i6vK7MPN3yDQ1iqtNKvJhx/d20xUsysnV8L2siK0YF8NqXuo
	 F2r/4T2Q4u96BUEfCwzgWadibeL385a3viilOZgRZ1pW7kvjpLnoT2zqqtapMEenuT
	 HHaGzl3suBG81YAwMNjFSWIiq8DJx6faEMnk1iTZoPgWiLUe/I/Eq0GZratMSAfmyr
	 noAuwTT8SagJQ==
Date: Wed, 31 Jan 2024 11:18:57 -0600
From: Rob Herring <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmp-dma: convert to YAML
Message-ID: <20240131171857.GA1531631-robh@kernel.org>
References: <20240127-pxa-dma-yaml-v1-1-573bafe86454@skole.hr>
 <20240128-feminine-sulfite-8891c60ec123@spud>
 <2924724.e9J7NaK4W3@radijator>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2924724.e9J7NaK4W3@radijator>

On Sun, Jan 28, 2024 at 07:01:36PM +0100, Duje Mihanović wrote:
> On Sunday, January 28, 2024 6:28:03 PM CET Conor Dooley wrote:
> > On Sat, Jan 27, 2024 at 05:53:45PM +0100, Duje Mihanović wrote:
> > > +allOf:
> > > +  - $ref: dma-controller.yaml#
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - marvell,adma-1.0
> > > +              - marvell,pxa910-squ
> > > +    then:
> > > +      properties:
> > > +        asram:
> > > +          description:
> > > +            phandle to the SRAM pool
> > > +          minItems: 1
> > > +          maxItems: 1
> > > +        iram:
> > 
> > > +          maxItems:
> > These properties are not mentioned in the text binding, nor commit
> > message. Where did they come from?
> 
> Both of them can be found in arch/arm/boot/dts/marvell/mmp2.dtsi. There is one 
> major difference between the two: iram is not mentioned at all by the mmp_tdma 
> driver (on the other hand, asram is not only used but also required for a 
> successful probe), but I left it here as it's still found in the MMP2 dtsi. On 
> second thought it should probably be dropped both here and in the dtsi.
> 
> > That said, for properties that are only usable on some platforms, please
> > define them at the top level and conditionally permit/constrain them.
> 
> Could you please point me to how to do so if this if/then does not do it 
> properly?

Negate the if and then:

then:
  properties:
    asram: false

There are lots of examples in the tree.

> 
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  # Peripheral controller
> > > +  - |
> > > +    pdma0: dma-controller@d4000000 {
> > 
> > The label is not needed here or below.
> > In fact, I'd probably delete the second example as it shows nothing that
> > the first one does not.
> 
> I'd rather add the asram property in the second node (adding onto the above 
> comment, I now see that it shouldn't have even passed dt_binding_check because 
> of the missing asram, but it did).

It passed because 'required' is what checks for property presence and 
nowhere is asram required. It is missing a type definition which should 
have warned, but may not since it is under an 'if'.

Rob

