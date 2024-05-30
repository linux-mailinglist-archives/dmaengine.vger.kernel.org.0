Return-Path: <dmaengine+bounces-2215-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61028D4BF5
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 14:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0993E1C22B2F
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A917F4E3;
	Thu, 30 May 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+P5rLHO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C71E521;
	Thu, 30 May 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073292; cv=none; b=i0KssecpLYpcDC8LZkUGU5ayQyweIss3sCx0PQ3bRqoZjM+UTeIITQZwUI1oBpt1IIsKeAX4yHOcAVtBDe7ftyGmZfpwSikySbnEZmiyrrtTBvaHYAkgPzpOVverNjMnbKOUxsec5jPp0Qd7RDXhOFu2I9ZI5Fu4QTkDLLSBUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073292; c=relaxed/simple;
	bh=r6254Ll0VwLlCjjp+UVjhwYhElgCx9+iVeZEYYEmdFM=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DXaGYoJNR3aGuysTcfhTzu0hFTaGriXuP67ZLjeq4RW3PN16SweMHlMj7drQBuCG0+mD2rDPkOeTvPWnVy5wHwzzt4tDvM6v/0MF5X4CyIKkAQC8y6nXg2vYr9zsOSv9r7NeiG/J6PXxrnw2o0NVHE3NHzme6ILBtjAkORiHeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+P5rLHO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso75298866b.2;
        Thu, 30 May 2024 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717073289; x=1717678089; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nehXVYPjt+tadQWfEhHE67jtHxRKaEFlK7gSdj/6Ibw=;
        b=P+P5rLHOtRF+JRTR+WerCxcahM/QYExqqn8c10Uh8XnsvvjTtwMLFoIOr/M2wJlZLY
         huFmp4PKvkYoF+4EP6vhFruiWthKtoCbzmf50wpS0aevaCgNlz/tnv4+wCvGGcQpSCwd
         Nt0z6rZjEFwadYbeY9iNWhKyBDIbuKEuFUelJ8TOoOB/nAfFPvugWHU2wNvEZZ6nJ+IN
         uupLwlYkyQxyU6DhxApHpSPCnU0zmbO7jkXJMzwKvJ3uGPs14O2j/6UfFq1boIl0lPja
         ITU4mq52hGmaK2xPBFu6M8yC1ixoK03GVG+MfQ6n1/zHHfBgKgKUakDU6ySKDG8ReK4v
         q11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717073289; x=1717678089;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nehXVYPjt+tadQWfEhHE67jtHxRKaEFlK7gSdj/6Ibw=;
        b=Yzi/SwgxrhVIOBLovtATtmQ7pbNCCN1W+ayANVFaoYQztkAkdst6Kkid2wDQflb8jR
         2qUnhmDhqwJkjw5ppmrbFv87r+K03jns74MYzFlQ44OVNNVrDlIaHc7BCBqlEmX8AxlD
         JIqQj2hp7HWRmLtO5z63wF5/dobQ2fLGQXoC9xGRV6ndLsN+LJ0hhj8imzFF8814O7V8
         ItSEApDF6v+cPQuopm/iVV2N7UTm/KfDg+enCuBxu56zihloWIur5Ye510RjMd19FHoe
         utMAibu6eAPNgDo2MfmkVCYNVlqCj7Tg3LkKADw2pAoYc/wBqQ/tPuJ2tbcperTVatP1
         V1dw==
X-Forwarded-Encrypted: i=1; AJvYcCU113t9HXDxhOguStXLem98sgFQWX7WxIOOy/+DNfcmhSMZqGiQc5X6B/0rMQQEZiZQcoFR6aIPqj+nqp9CvrsTjSWW4/h7q6SR5JtPoWR6CSXchY+GMSt86Ox7z2NRV0PiVYDtOHS5Mm9xfNxMa66lX5u4fLspw+OQH4w58rT776btMQ==
X-Gm-Message-State: AOJu0YxTFMFqjqP3Af+wYvfDQaGFIWUuV1nt6A6ARBx28CtJBpkct1v5
	9fxEvjGG6zJtJR8VWzKg8dth//HT4FeXDTTPeqWzu/FAXX0eSCrq
X-Google-Smtp-Source: AGHT+IHOwilrTIdfuhNE8BKpScZoSiBgPHcw2LZUKdeBcXbVlEQJdrNSL6LkHIXE0sK7oUk5n9Pdcg==
X-Received: by 2002:a17:907:100b:b0:a63:3c69:ec4 with SMTP id a640c23a62f3a-a65e8e43053mr145338366b.23.1717073288884;
        Thu, 30 May 2024 05:48:08 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a662b43a010sm44015066b.110.2024.05.30.05.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 05:48:08 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=ac5239eee89eef8167849c5ee3fad8881c9fbf6bf4cf350a574975beacc1;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 30 May 2024 14:48:07 +0200
Message-Id: <D1MZOIQR9R4G.16O4LIDN6AN5Q@gmail.com>
Cc: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ldewangan@nvidia.com>, <mkumard@nvidia.com>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: dma: Add reg-names to
 nvidia,tegra210-adma
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Sameer Pujar"
 <spujar@nvidia.com>, <vkoul@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jonathanh@nvidia.com>,
 <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240521110801.1692582-1-spujar@nvidia.com>
 <20240521110801.1692582-2-spujar@nvidia.com>
 <80b6e6e6-9805-4a85-97d5-38e1b2bf2dd0@kernel.org>
 <e6fab314-8d1e-4ed7-bb5a-025fd65e1494@nvidia.com>
 <56bf93ac-6c1e-48aa-89d0-7542ea707848@kernel.org>
 <f785f699-be50-4547-9411-d41a4e66a225@nvidia.com>
 <774df64c-56a1-461a-82fa-a0340732b779@kernel.org>
 <D1HPADDIQNIK.2F4AL70NLHQCY@gmail.com>
 <819d7180-db8c-438c-afed-463fe495bfc5@kernel.org>
In-Reply-To: <819d7180-db8c-438c-afed-463fe495bfc5@kernel.org>

--ac5239eee89eef8167849c5ee3fad8881c9fbf6bf4cf350a574975beacc1
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue May 28, 2024 at 8:48 AM CEST, Krzysztof Kozlowski wrote:
> On 24/05/2024 09:36, Thierry Reding wrote:
> > On Wed May 22, 2024 at 1:29 PM CEST, Krzysztof Kozlowski wrote:
> >> On 22/05/2024 09:43, Sameer Pujar wrote:
> >>>
> >>>
> >>> On 22-05-2024 12:17, Krzysztof Kozlowski wrote:
> >>>> On 22/05/2024 07:35, Sameer Pujar wrote:
> >>>>> On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
> >>>>>> On 21/05/2024 13:08, Sameer Pujar wrote:
> >>>>>>> From: Mohan Kumar <mkumard@nvidia.com>
> >>>>>>>
> >>>>>>> For Non-Hypervisor mode, Tegra ADMA driver requires the register
> >>>>>>> resource range to include both global and channel page in the reg
> >>>>>>> entry. For Hypervisor more, Tegra ADMA driver requires only the
> >>>>>>> channel page and global page range is not allowed for access.
> >>>>>>>
> >>>>>>> Add reg-names DT binding for Hypervisor mode to help driver to
> >>>>>>> differentiate the config between Hypervisor and Non-Hypervisor
> >>>>>>> mode of execution.
> >>>>>>>
> >>>>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> >>>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> >>>>>>> ---
> >>>>>>>    .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 ++=
++++++++
> >>>>>>>    1 file changed, 10 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra21=
0-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.ya=
ml
> >>>>>>> index 877147e95ecc..ede47f4a3eec 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.=
yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.=
yaml
> >>>>>>> @@ -29,8 +29,18 @@ properties:
> >>>>>>>              - const: nvidia,tegra186-adma
> >>>>>>>
> >>>>>>>      reg:
> >>>>>>> +    description: |
> >>>>>>> +      For hypervisor mode, the address range should include a
> >>>>>>> +      ADMA channel page address range, for non-hypervisor mode
> >>>>>>> +      it starts with ADMA base address covering Global and Chann=
el
> >>>>>>> +      page address range.
> >>>>>>>        maxItems: 1
> >>>>>>>
> >>>>>>> +  reg-names:
> >>>>>>> +    description: only required for Hypervisor mode.
> >>>>>> This does not work like that. I provide vm entry for non-hyperviso=
r mode
> >>>>>> and what? You claim it is virtualized?
> >>>>>>
> >>>>>> Drop property.
> >>>>> With 'vm' entry added for hypervisor mode, the 'reg' address range =
needs
> >>>>> to be updated to use channel specific region only. This is used to
> >>>>> inform driver to skip global regions which is taken care by hypervi=
sor.
> >>>>> This is expected to be used in the scenario where Linux acts as a
> >>>>> virtual machine (VM). May be the hypervisor mode gives a different
> >>>>> impression here? Sorry, I did not understand what dropping the prop=
erty
> >>>>> exactly means here.
> >>>> It was imperative. Drop it. Remove it. I provided explanation why.
> >>>
> >>> The driver doesn't know if it is operated in a native config or in th=
e=20
> >>> hypervisor config based on the 'reg' address range alone. So 'vm' ent=
ry=20
> >>> with restricted 'reg' range is used to differentiate here for the=20
> >>> hypervisor config. Just adding 'vm' entry won't be enough, the 'reg'=
=20
> >>> region must be updated as well to have expected behavior. Not sure ho=
w=20
> >>> this dependency can be enforced in the schema.
> >>
> >> That's not a unusual problem, so please come with a solution for your
> >> entire subarch. We've been discussing similar topic in terms of SCMI
> >> controlled resources (see talk on Linaro Connect a week ago:
> >> https://www.kitefor.events/events/linaro-connect-24/submissions/161 I
> >> don't know where is recording or slides, see also discussions on maili=
ng
> >> lists about it), which is not that far away from the problem here. Oth=
er
> >> platforms and maybe nvidia had as well changes in IO space for
> >> virtualized configuration.
> >>
> >> Come with unified approach FOR ALL your devices, not only this one
> >> (that's kind of basic thing we keep repeating... don't solve only one
> >> your problem), do not abuse the regular property, because as I said:
> >> reg-names will be provided as well in non-vm case and then your entire
> >> logic is wrong. The purpose of reg-names is not to tell whether you ha=
ve
> >> or have not virtualized environment.
> >=20
> > This isn't strictly about telling whether this is a virtualized
> > environment or not. Unfortunately the bindings don't make that very
> > clear, so let me try to give a bit more background.
> >=20
> > On Tegra devices the register regions associated with a device are
> > usually split up into 64 KiB chunks.
>
> So describing it as one IO region was incorrect from the start and you
> want to fix it by adding one more incorrect description: making first
> item meaning two different things. Sorry, that's not a correct way to
> fix things.

Yes, describing this as one I/O region was incorrect, and in hindsight
it should have been done differently.

However, I don't think it's correct to describe this as adding one more
incorrect description. Instead, what this does is add reg-names to
provide additional context so that the operating system can make the
necessary decisions as to what is allowed and what isn't.

In the absence of a reg-names property the current definition of the DT
bindings applies, so it means the region represents the entirety of the
device's I/O register space. That's one particular use-case for this
device.

For additional use-cases we can then use reg-names to differentiate
between what separate regions are and use them accordingly.

> Items are defined, thus first item is always expected to be what the
> binding already said. Adding reg-names changes nothing, because (as
> repeated many times) xxx-names is just a helper. Items are already define=
d.

I don't understand what you're trying to say here. I suppose adding
reg-names alone indeed doesn't change anything. But the point is that
once added we can now use these properties, at which point of course
things change.

> > One of these chunks, usually the first one, is a global region that
> > contains registers that configure the device as a whole. This is usuall=
y
> > privileged and accessible only to the hypervisor.
> >=20
> > Subsequent regions are meant to be assigned to individual VMs. Often th=
e
> > regions take the form of "channels", so they are instances of the same
> > register block and control that separate slice of the hardware.
> >=20
> > What makes this a bit confusing is that for the sake of simplicity (and=
,
> > I guess, lack of foresight) the original bindings were written in a way
> > to encompass all registers without making that distinction. This worked
> > fine because we've only ever run Linux as host OS where it has access t=
o
> > all those registers.
> >=20
> > However, when we move to virtualized environments that no longer works.
> >=20
> > Given the above, we can't read any registers in order to probe whether
> > we run as a guest or not. Trying to access any of the global registers
> > from a VM simply won't work and may crash the system. None of the
> > "channel" registers contain information indicating host vs. guest
> > either.
>
> I don't understand how it differs from what I said - you want to
> indicate that you run in virtualized environment and not all resources
> are accessible.
>
> The device still has the first (global) address, just it is not
> available due to hypervisor.

Yes, and that's a bad thing because there's no way for the device to
know that it can't access the registers. So it will just assume that it
can and try to access them, which would then result in a crash/error.

Thierry

--ac5239eee89eef8167849c5ee3fad8881c9fbf6bf4cf350a574975beacc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmZYdYgACgkQ3SOs138+
s6FIBA//afkWB6Vob9QbMRD7saZNewxk8vuBbdTpJmw/gbg52qbrpN0dtzUXD583
yfNYtqNdjwgdJYbSqHCs+arzpB6Lbf7A8S4aOTrovjUpnfV4nTjHYSkB4u2wjEZK
Q3ML4SlVtRN/Kddv7L4YXyGdPOB7QgXebsLNLy4z6E8IN8YARlR6m60YIuCOvtHx
YR+bTb3D3D2egFP2PTubdmtzMWL6NBxfgZhjIye1pgxR4znrXxB3Tgg4ZSUnNGVn
IRNvQO27WAcaNBkmu/wiLxZbsgpWGcuxt5Fmxm60PyJGFoJui01l9Kr3isSrOnRE
e+X8F5Xo0dixgdnPdEcub/O5UW1GCMZ64t1Gka0X/xh0TISPItG9TEH/P8JjvYxx
R99Uil42n7cMHzLpfysOylPlsHv/zwGy/fIMQda18cyJB1kWoTSKS1WXlyCwFfD6
BUlBomgPqXSmGpVACdOVAwuXxL1T+ItWBbTpgslZVq2h/vZH7cC0A4OE5siUbH0r
PHfuwU/TPSxWIwWcCWD24brHYSWL2eR297PPG1ZWIC4L0gd3bZTuVmx13CAkzhQM
1fIvAmzWFWoMTz9c6W5RPx0Wi9f3AwnZeCpjmww01YUL6HwTLlvma4nnmpaPC7wT
UstnOjsN1lJCHSzPnS3GXDPskTPSCzXKjig43Zb9zsN5/PhYqBg=
=Vn5+
-----END PGP SIGNATURE-----

--ac5239eee89eef8167849c5ee3fad8881c9fbf6bf4cf350a574975beacc1--

