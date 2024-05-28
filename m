Return-Path: <dmaengine+bounces-2196-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B728D207F
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADA81C235E9
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7D171088;
	Tue, 28 May 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9z0Wcbr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5D16F831;
	Tue, 28 May 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910517; cv=none; b=eIl+MD1GX5RwyIKb3x14ywR7h7Fmh/3lfhtkZ2cWMX+IIXzLxyv5gEjitZtFXVCUCCoT1wmTUEeCfhNcLMZkkzbgwH8vSvsYphsHO3GIa029dp6j9ARDuDKJfU75jrjzjHBR0D6+Pa1GJejoWTqfY4hRqhlQcuEuJ9cV8yL+8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910517; c=relaxed/simple;
	bh=/d0SaieC4RckvDgzT1t79V4R1OBnT1xYzZ9Ijss7wKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHgH6sltp7grpzuIqtFWAlDTLcekoesaGRydiFE4cccmOK6UUfts/PE/ckubEcE1fL8sTr+w8gBYMWii6O0vPZYBhtF6Uash2sWix01qvUSsfbnfboCysT7p5Xpl3reOmwVCl3NoZL+alff7Oc4WNg8jOYaJQztSUO4xmHbsc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9z0Wcbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7952C3277B;
	Tue, 28 May 2024 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716910516;
	bh=/d0SaieC4RckvDgzT1t79V4R1OBnT1xYzZ9Ijss7wKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9z0Wcbr7NxX2RATqwueT+oj6HvO1aCMipnvkQGMfErkhX9rTxq0I79srBLCnOMzA
	 NLJCGSpinYiTQjk3eTi4sPKV6cSg0ndYmrwMTs7h8WoivtfFV24oHMOHQ48SeqNfCC
	 vfPs3cHx4IoXoEgQsD1nUcdwobgEF8PZlJvtSJeeZRfz6DJ0A/N+z1blsmxb7/FF8w
	 4jSdWJxk4VX2gi/+AbvfZRurEyf3SAI2U3wzY5i5wS6ht3g0Qj/p2b+p86rMKrtOVt
	 LimHLPP8DAujFrTZxQgqPsBik67lR2gbb0SV8XG46GoMKVKYr7m8uXi81/F0hwQO1P
	 56FJPZd1vaCCA==
Date: Tue, 28 May 2024 10:35:15 -0500
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sameer Pujar <spujar@nvidia.com>,
	vkoul@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jonathanh@nvidia.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, ldewangan@nvidia.com,
	mkumard@nvidia.com
Subject: Re: [RESEND PATCH 1/2] dt-bindings: dma: Add reg-names to
 nvidia,tegra210-adma
Message-ID: <20240528153515.GA494766-robh@kernel.org>
References: <20240521110801.1692582-1-spujar@nvidia.com>
 <20240521110801.1692582-2-spujar@nvidia.com>
 <80b6e6e6-9805-4a85-97d5-38e1b2bf2dd0@kernel.org>
 <e6fab314-8d1e-4ed7-bb5a-025fd65e1494@nvidia.com>
 <56bf93ac-6c1e-48aa-89d0-7542ea707848@kernel.org>
 <f785f699-be50-4547-9411-d41a4e66a225@nvidia.com>
 <774df64c-56a1-461a-82fa-a0340732b779@kernel.org>
 <D1HPADDIQNIK.2F4AL70NLHQCY@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1HPADDIQNIK.2F4AL70NLHQCY@gmail.com>

On Fri, May 24, 2024 at 09:36:08AM +0200, Thierry Reding wrote:
> On Wed May 22, 2024 at 1:29 PM CEST, Krzysztof Kozlowski wrote:
> > On 22/05/2024 09:43, Sameer Pujar wrote:
> > > 
> > > 
> > > On 22-05-2024 12:17, Krzysztof Kozlowski wrote:
> > >> On 22/05/2024 07:35, Sameer Pujar wrote:
> > >>> On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
> > >>>> On 21/05/2024 13:08, Sameer Pujar wrote:
> > >>>>> From: Mohan Kumar <mkumard@nvidia.com>
> > >>>>>
> > >>>>> For Non-Hypervisor mode, Tegra ADMA driver requires the register
> > >>>>> resource range to include both global and channel page in the reg
> > >>>>> entry. For Hypervisor more, Tegra ADMA driver requires only the
> > >>>>> channel page and global page range is not allowed for access.
> > >>>>>
> > >>>>> Add reg-names DT binding for Hypervisor mode to help driver to
> > >>>>> differentiate the config between Hypervisor and Non-Hypervisor
> > >>>>> mode of execution.
> > >>>>>
> > >>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> > >>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > >>>>> ---
> > >>>>>    .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 ++++++++++
> > >>>>>    1 file changed, 10 insertions(+)
> > >>>>>
> > >>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> > >>>>> index 877147e95ecc..ede47f4a3eec 100644
> > >>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> > >>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> > >>>>> @@ -29,8 +29,18 @@ properties:
> > >>>>>              - const: nvidia,tegra186-adma
> > >>>>>
> > >>>>>      reg:
> > >>>>> +    description: |
> > >>>>> +      For hypervisor mode, the address range should include a
> > >>>>> +      ADMA channel page address range, for non-hypervisor mode
> > >>>>> +      it starts with ADMA base address covering Global and Channel
> > >>>>> +      page address range.
> > >>>>>        maxItems: 1
> > >>>>>
> > >>>>> +  reg-names:
> > >>>>> +    description: only required for Hypervisor mode.
> > >>>> This does not work like that. I provide vm entry for non-hypervisor mode
> > >>>> and what? You claim it is virtualized?
> > >>>>
> > >>>> Drop property.
> > >>> With 'vm' entry added for hypervisor mode, the 'reg' address range needs
> > >>> to be updated to use channel specific region only. This is used to
> > >>> inform driver to skip global regions which is taken care by hypervisor.
> > >>> This is expected to be used in the scenario where Linux acts as a
> > >>> virtual machine (VM). May be the hypervisor mode gives a different
> > >>> impression here? Sorry, I did not understand what dropping the property
> > >>> exactly means here.
> > >> It was imperative. Drop it. Remove it. I provided explanation why.
> > > 
> > > The driver doesn't know if it is operated in a native config or in the 
> > > hypervisor config based on the 'reg' address range alone. So 'vm' entry 
> > > with restricted 'reg' range is used to differentiate here for the 
> > > hypervisor config. Just adding 'vm' entry won't be enough, the 'reg' 
> > > region must be updated as well to have expected behavior. Not sure how 
> > > this dependency can be enforced in the schema.
> >
> > That's not a unusual problem, so please come with a solution for your
> > entire subarch. We've been discussing similar topic in terms of SCMI
> > controlled resources (see talk on Linaro Connect a week ago:
> > https://www.kitefor.events/events/linaro-connect-24/submissions/161 I
> > don't know where is recording or slides, see also discussions on mailing
> > lists about it), which is not that far away from the problem here. Other
> > platforms and maybe nvidia had as well changes in IO space for
> > virtualized configuration.
> >
> > Come with unified approach FOR ALL your devices, not only this one
> > (that's kind of basic thing we keep repeating... don't solve only one
> > your problem), do not abuse the regular property, because as I said:
> > reg-names will be provided as well in non-vm case and then your entire
> > logic is wrong. The purpose of reg-names is not to tell whether you have
> > or have not virtualized environment.
> 
> This isn't strictly about telling whether this is a virtualized
> environment or not. Unfortunately the bindings don't make that very
> clear, so let me try to give a bit more background.
> 
> On Tegra devices the register regions associated with a device are
> usually split up into 64 KiB chunks.
> 
> One of these chunks, usually the first one, is a global region that
> contains registers that configure the device as a whole. This is usually
> privileged and accessible only to the hypervisor.
> 
> Subsequent regions are meant to be assigned to individual VMs. Often the
> regions take the form of "channels", so they are instances of the same
> register block and control that separate slice of the hardware.
> 
> What makes this a bit confusing is that for the sake of simplicity (and,
> I guess, lack of foresight) the original bindings were written in a way
> to encompass all registers without making that distinction. This worked
> fine because we've only ever run Linux as host OS where it has access to
> all those registers.
> 
> However, when we move to virtualized environments that no longer works.
> 
> Given the above, we can't read any registers in order to probe whether
> we run as a guest or not. Trying to access any of the global registers
> from a VM simply won't work and may crash the system. None of the
> "channel" registers contain information indicating host vs. guest
> either.
> 
> In order to make this work we need to more fine-grainedly specify the
> register layout. I think the binding changes here aren't sufficient to
> do that, though.
> 
> Currently we have this for the ADMA controller:
> 
> 	dma-controller@2930000 {
> 		reg = <0x0 0x02930000 0x0 0x20000>;
> 	};
> 
> This contains the global registers (0x2930000-0x293ffff) and the first
> page/channel registers (0x2940000-0x294ffff) in one "reg" entry. Instead
> I think what we need is this:
> 
> 	dma-controller@2930000 {
> 		reg = <0x0 0x02930000 0x0 0x10000>,
> 		      <0x0 0x02940000 0x0 0x10000>,
> 		      <0x0 0x02950000 0x0 0x10000>,
> 		      <0x0 0x02960000 0x0 0x10000>,
> 		      <0x0 0x02970000 0x0 0x10000>;
> 		reg-names = "global", "page0", "page1", "page2",
> 		            "page3";
> 	};
> 
> That describes the device fully, but each of these entries is optional.
> If "global" is present it means we are a hypervisor (or host OS). If an
> additional "page" entry is present, we can also use those resources to
> stream audio data.
> 
> If "global" is not present, we know we are not a hypervisor and those
> registers cannot be accessed. This would be the typical case for a guest
> OS which has access only to the listed "page" entries.
> 
> For backwards-compatibility with the existing bindings we should be able
> to fallback to the singular register region and partition it up in the
> driver as necessary.
> 
> This is an approach that we've already implemented for certain devices
> such as host1x and Ethernet where a similar split exists. I suspect that
> we'll need to do this kind of split in a number of other bindings as
> well.

In a VM is a different (being a subset) programming model, so why not 
just a new compatible for virtualized case. That's what we'd do if 
actual h/w registers changed from one device to the next.

Rob

