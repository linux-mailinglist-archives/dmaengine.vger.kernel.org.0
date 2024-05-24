Return-Path: <dmaengine+bounces-2147-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1768CE18D
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557091F21D90
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EED82C7D;
	Fri, 24 May 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG5BVHL2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A659475;
	Fri, 24 May 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536174; cv=none; b=cSpjok4tfH7xUbLeLXfcYjC11vAZ3qNftDfdAuZZPFYL464M5J0jYT7NG91CXTOsBmo8db+/hNUeAUtVChcdJdnQUo48Nm3QLIcKvOFzELvxrV9uQerDku8cO7cbwjs0FysuV57/GaGdJDVb1nJmGy05r5YlXZd/ujHUo49zhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536174; c=relaxed/simple;
	bh=iFeUPp1SfaDfq7194bNhtU7qs7dZCL4EeIn73RIt7NY=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BxhR07NVPiYXuAx21cTLu3QMBrcNDVzf9N45rMAiSqVpiSuJ+MrXEEOzCzTlwBuL9BOhkRKww6e9x6Eb6MODo09DkASx20HqUN6f0qfexPl7TfbwEzIC+/x5SirstZJcQ3hCjjAJufutgSYQPRqzlKCBVeBTFKH+Q5QtEBbnsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG5BVHL2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354b722fe81so2790156f8f.3;
        Fri, 24 May 2024 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716536171; x=1717140971; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+YLWLtjTN4/gFvEaggrTQYu5CmLGDzlDkA/t9KMtO4=;
        b=MG5BVHL2pgk/V9SiGGrfVlaSG2F0c2WrVQsDsWGES7Pi4VfHFkyPnW14bfwsbiOyR6
         dt/ppOrURGdxx9hbmGV6mGPCVQl53Dk6whbAOVHl/GL+PI3ufe5BSEonajTgi+wJF8NJ
         3PYIeE58ayl5GkLq8vUtP9ugk94JVwNEbEsjWJFJGmy8JJnsqjtxOr5T2/D6NPah7j/7
         WjqKw2P/CW6xPysYqxatV3jXdNEtf7Cx2mSNvbg9iVc+qXn+pc8OBUFuEa0HHH2/JNaj
         K6/SBrdmUXCTz0By3RRq0G3OBOuH18dxhe6O90jXEaZ29JchEgB+x+zorpMPojvCdWqM
         LkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536171; x=1717140971;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+YLWLtjTN4/gFvEaggrTQYu5CmLGDzlDkA/t9KMtO4=;
        b=N+sZpOrkkyuM9aj3ma2GgvIyZhTuGDA1t9jj6CfE+esQZhy3b87OamhihBDG//kLvd
         8rYJE2lKONwKzEOPBfH+ZuVUkB6hYTZUSNB8rcihQaexJr6MXlKU6zBPyfEmQqpF48Rm
         KAF20UZ1Jwf7jIXCo1nRJHVkmk3Nipoknv60PdSdbTqioEQD956tjFYY7ZwktZHkWBrS
         vjx8nGn+NecOEXXB92viVTE0PD+OsJPnbmA7rsf7Qqwfv4ospkF4XOVVSrIUWbz514BF
         ry1wsyXhgp9hMl3WKvcC9TMKaUQUf6HSe2nw0Z+HsQje7a7LJFcNSjjpp66fLA06xyfP
         RBcg==
X-Forwarded-Encrypted: i=1; AJvYcCWIy99w96twRlOQD7XhmOp17Jt5uVE2vF/XOrP+m0gTwnqU9Nui40MYW+G+ShaY3gEj5lVxtIrksJDzOAnxCXJdBycONgIOKcel8pIgvx+K9QkrvzJaYPPNFlKy35HEYaBv19+wARQ4edI+wYi6SPKXhtOAzhGcnJmYd0M6rjXdrKQy7w==
X-Gm-Message-State: AOJu0Yy7ECODq5xX+x5bNJg07zdQL7u5zRPQXNhp580ePJtS1ETy/gL2
	q2tGcS7YXCG3eChl/GrrMEHvO/KrXzem9aekHsZjJdAP9OXWtptn2wpTIA==
X-Google-Smtp-Source: AGHT+IGmJH4OvFh5XxksisBloLpEXCTM8mZT6EczfE8wJlQtH8dwQUUe1SEXKAzxwNXPUwCF+pREhA==
X-Received: by 2002:adf:f204:0:b0:354:db70:c7aa with SMTP id ffacd0b85a97d-35526c5579amr888184f8f.34.1716536170499;
        Fri, 24 May 2024 00:36:10 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf06dcsm915751f8f.106.2024.05.24.00.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 00:36:09 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=241f40d966fda302b1ed7261f8b84a75d760329ffac395a974a47e552be9;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 24 May 2024 09:36:08 +0200
Message-Id: <D1HPADDIQNIK.2F4AL70NLHQCY@gmail.com>
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
In-Reply-To: <774df64c-56a1-461a-82fa-a0340732b779@kernel.org>

--241f40d966fda302b1ed7261f8b84a75d760329ffac395a974a47e552be9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed May 22, 2024 at 1:29 PM CEST, Krzysztof Kozlowski wrote:
> On 22/05/2024 09:43, Sameer Pujar wrote:
> >=20
> >=20
> > On 22-05-2024 12:17, Krzysztof Kozlowski wrote:
> >> On 22/05/2024 07:35, Sameer Pujar wrote:
> >>> On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
> >>>> On 21/05/2024 13:08, Sameer Pujar wrote:
> >>>>> From: Mohan Kumar <mkumard@nvidia.com>
> >>>>>
> >>>>> For Non-Hypervisor mode, Tegra ADMA driver requires the register
> >>>>> resource range to include both global and channel page in the reg
> >>>>> entry. For Hypervisor more, Tegra ADMA driver requires only the
> >>>>> channel page and global page range is not allowed for access.
> >>>>>
> >>>>> Add reg-names DT binding for Hypervisor mode to help driver to
> >>>>> differentiate the config between Hypervisor and Non-Hypervisor
> >>>>> mode of execution.
> >>>>>
> >>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> >>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> >>>>> ---
> >>>>>    .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 ++++=
++++++
> >>>>>    1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-=
adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> >>>>> index 877147e95ecc..ede47f4a3eec 100644
> >>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.ya=
ml
> >>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.ya=
ml
> >>>>> @@ -29,8 +29,18 @@ properties:
> >>>>>              - const: nvidia,tegra186-adma
> >>>>>
> >>>>>      reg:
> >>>>> +    description: |
> >>>>> +      For hypervisor mode, the address range should include a
> >>>>> +      ADMA channel page address range, for non-hypervisor mode
> >>>>> +      it starts with ADMA base address covering Global and Channel
> >>>>> +      page address range.
> >>>>>        maxItems: 1
> >>>>>
> >>>>> +  reg-names:
> >>>>> +    description: only required for Hypervisor mode.
> >>>> This does not work like that. I provide vm entry for non-hypervisor =
mode
> >>>> and what? You claim it is virtualized?
> >>>>
> >>>> Drop property.
> >>> With 'vm' entry added for hypervisor mode, the 'reg' address range ne=
eds
> >>> to be updated to use channel specific region only. This is used to
> >>> inform driver to skip global regions which is taken care by hyperviso=
r.
> >>> This is expected to be used in the scenario where Linux acts as a
> >>> virtual machine (VM). May be the hypervisor mode gives a different
> >>> impression here? Sorry, I did not understand what dropping the proper=
ty
> >>> exactly means here.
> >> It was imperative. Drop it. Remove it. I provided explanation why.
> >=20
> > The driver doesn't know if it is operated in a native config or in the=
=20
> > hypervisor config based on the 'reg' address range alone. So 'vm' entry=
=20
> > with restricted 'reg' range is used to differentiate here for the=20
> > hypervisor config. Just adding 'vm' entry won't be enough, the 'reg'=20
> > region must be updated as well to have expected behavior. Not sure how=
=20
> > this dependency can be enforced in the schema.
>
> That's not a unusual problem, so please come with a solution for your
> entire subarch. We've been discussing similar topic in terms of SCMI
> controlled resources (see talk on Linaro Connect a week ago:
> https://www.kitefor.events/events/linaro-connect-24/submissions/161 I
> don't know where is recording or slides, see also discussions on mailing
> lists about it), which is not that far away from the problem here. Other
> platforms and maybe nvidia had as well changes in IO space for
> virtualized configuration.
>
> Come with unified approach FOR ALL your devices, not only this one
> (that's kind of basic thing we keep repeating... don't solve only one
> your problem), do not abuse the regular property, because as I said:
> reg-names will be provided as well in non-vm case and then your entire
> logic is wrong. The purpose of reg-names is not to tell whether you have
> or have not virtualized environment.

This isn't strictly about telling whether this is a virtualized
environment or not. Unfortunately the bindings don't make that very
clear, so let me try to give a bit more background.

On Tegra devices the register regions associated with a device are
usually split up into 64 KiB chunks.

One of these chunks, usually the first one, is a global region that
contains registers that configure the device as a whole. This is usually
privileged and accessible only to the hypervisor.

Subsequent regions are meant to be assigned to individual VMs. Often the
regions take the form of "channels", so they are instances of the same
register block and control that separate slice of the hardware.

What makes this a bit confusing is that for the sake of simplicity (and,
I guess, lack of foresight) the original bindings were written in a way
to encompass all registers without making that distinction. This worked
fine because we've only ever run Linux as host OS where it has access to
all those registers.

However, when we move to virtualized environments that no longer works.

Given the above, we can't read any registers in order to probe whether
we run as a guest or not. Trying to access any of the global registers
from a VM simply won't work and may crash the system. None of the
"channel" registers contain information indicating host vs. guest
either.

In order to make this work we need to more fine-grainedly specify the
register layout. I think the binding changes here aren't sufficient to
do that, though.

Currently we have this for the ADMA controller:

	dma-controller@2930000 {
		reg =3D <0x0 0x02930000 0x0 0x20000>;
	};

This contains the global registers (0x2930000-0x293ffff) and the first
page/channel registers (0x2940000-0x294ffff) in one "reg" entry. Instead
I think what we need is this:

	dma-controller@2930000 {
		reg =3D <0x0 0x02930000 0x0 0x10000>,
		      <0x0 0x02940000 0x0 0x10000>,
		      <0x0 0x02950000 0x0 0x10000>,
		      <0x0 0x02960000 0x0 0x10000>,
		      <0x0 0x02970000 0x0 0x10000>;
		reg-names =3D "global", "page0", "page1", "page2",
		            "page3";
	};

That describes the device fully, but each of these entries is optional.
If "global" is present it means we are a hypervisor (or host OS). If an
additional "page" entry is present, we can also use those resources to
stream audio data.

If "global" is not present, we know we are not a hypervisor and those
registers cannot be accessed. This would be the typical case for a guest
OS which has access only to the listed "page" entries.

For backwards-compatibility with the existing bindings we should be able
to fallback to the singular register region and partition it up in the
driver as necessary.

This is an approach that we've already implemented for certain devices
such as host1x and Ethernet where a similar split exists. I suspect that
we'll need to do this kind of split in a number of other bindings as
well.

Thierry

--241f40d966fda302b1ed7261f8b84a75d760329ffac395a974a47e552be9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmZQQ2kACgkQ3SOs138+
s6FLQhAAu6fN/z6ZJsNi5c0zEsv0oAaIvlCVuXEzkNAKzSNpu00vm+mUaDi+whGV
8mjdwDnc/2zMd0K56qC+Hi276K0YSheyarVv6TTfI0iRu0eHiqnvL7PEg/x37bF4
bkDgE4MdW/lM6yaosTSJXam/HDk3ttc0bFHMxdxUhTaoQcDHDdvMYQMHhQDbLPRY
02RV/dKhiGCFsrGwssh1MdfhrZZ4pqSnUzOXee6HXmdbD7tKn1WuJYdy28VcWBLj
ZB0K+jMBMvvSzYioMdD3874GXjyFNswfJy87vFOodsdmJ0n2P2mGTsa4yv346W3h
u9cBM7pxNGJWi7jlTVUVsqLPEvF347M3RNibKelK3+/2gfvp4EFoEu4NiV78yv7U
qGvca8nM2d91V+YFAyH2c1N7Hsbr+5DbZUqBiw8xtmzcGrHwXaRxPLZpXqo72YW5
q+em6Etw2JM9oJFBFyDjlxrCcvi9B0zRp1hKccG6mwtykZUciT2JAAzDRUdQUF69
ay3cDejxathVTI2BRsBMuzsIok5haac1VGrl8bXtt6bGNQ/EzCzqMxKXMmoYDH+g
eEilda619+zI40igcWZnLJQp4H32fq98CiFSqkesMksabXlpXjQAQS/uhiHiVWfk
HRmZEqExwX6Yt57+yqSMy5mLzsi0eLLHIZpDJE1mfeGaTZHwkO0=
=NmGE
-----END PGP SIGNATURE-----

--241f40d966fda302b1ed7261f8b84a75d760329ffac395a974a47e552be9--

