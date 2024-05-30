Return-Path: <dmaengine+bounces-2214-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8777F8D4BAD
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80AB1C2085C
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777E183066;
	Thu, 30 May 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujz3atNS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C6183060;
	Thu, 30 May 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072166; cv=none; b=YGclrQrlkQ55EaVS5GMSYFCsqUjB4JDMz6VMiyyAf4QePoIbAGapbvESsyhUjaRi8FuVumJQbt5jDMsGd5v8FWMZ2B13dHk4CaQ+/WBbfRdcsK/ESq4WycOE20wFgI/unuGaXdOmMlkq/o+ojgkSZvJCW3pOZdXawVh7HU25OLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072166; c=relaxed/simple;
	bh=gNfFplsNvIUq4HI/9fNip5lI9t+V6A1CmXFui9DN3ow=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s0qANMVK1wYfAhjnHAsIY2QwpcMdqeL4dPzJ7f+t6oP1nnystwhdI67iBdxrpYgSRsOxAyMgotKzkszaz02DK5r0JIDYj2HXS5wdlIC9GVNcrQFv8EoUhDOAA75Nei+SXpWFLReQargn9lhfPSzvgMbN0k9s/tJPoeNS1cfybAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujz3atNS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4211249fbafso8169005e9.3;
        Thu, 30 May 2024 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717072162; x=1717676962; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xca9/oO3h3lcxAli3Z9nWq8I6i0rHJ9Q7gwezwYPuHw=;
        b=Ujz3atNSisW+Sa15YBggTEBMW2m2TvQPRisMUoaFHSNAJF5wqR6eFMpmbsjz+RUJeJ
         JNioPObJJSArN5MUw/2FMT22EUoHG6g2KvP4hV/vF5fy+5j11dvvryF9MLlCtJdVG10u
         BR7us5rx3vF0ns9tfWDXuXTHfFkyWQR7TNuG47MZT8vtiAh6V1KzcpCjyG8xP/H6Ao5o
         Lyl5+Z47qi/99ou3EaEJIpvDmpz8es6emNwZZXQYiS9g6AL98Q+VRz5xqGtcg7ki5r68
         PLxob2lA6+LZD5fOPpe9EBTTzgkTR2CHbVMvCZbnusqtJ1s270zJqkYcqx7wWcpOOrDg
         PMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717072162; x=1717676962;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xca9/oO3h3lcxAli3Z9nWq8I6i0rHJ9Q7gwezwYPuHw=;
        b=KfnhfGgipCiAvY5Wct4I3h0c3qAV2uiTkr6Up296Tb0YhS96ljHwZDjNfLtVBGbUXq
         RCDoJdmh7z2D1+0qsRKSmTsqfXDz8SFZSLVIfKrTNwXQUQiwk6u9PwBkKHIzCzEmvBhf
         HTfFyVad2mRYicc+edaRvvYkKfVqUwvKX4qW3KhZIUd/PJMHpZrecOYB7nHGfGuHU6Jr
         7XQeDS+TTb1F3l+uwK8GDqD0UXtPPYsgcuZg0QYD8qUsGE/FKvkxcJdY8TM6f4GPcTgs
         26tA/9aXIRRAF64qxluXN7vPtmWUzU6x4V9nKxNCo1UAUl4IvI+XnMPBu/tQar40QaEg
         naDg==
X-Forwarded-Encrypted: i=1; AJvYcCXLWyp/rbC7L4V7bCkOEM8x+qUb8NiM1kb1FNs0Ik8bqQYGpRGhS9i0wqYt6HcLSyyjHx1NLCnkQiy+6jwOolbZDtut8UdVbdpyM35rXbsEywsnQYZ8B68S8rqpyLS6iSDR0DYurpEjR0tMPPaBX7ftNw8zvclnjem3hFbBEVXmYIngSHVZXCVRZSmKYvAdwKvCTvlKelfbAYtS+7gJpk/h
X-Gm-Message-State: AOJu0YxACCbAB7dcSA0dsvBWUFi8v4ixE35OpSIFE6hJv1X+qv5ZRQvC
	rVTktEQMEAXqPLaWZFN402Hs4SHVYa2uBr3jcGMPb9h0394ttU8+
X-Google-Smtp-Source: AGHT+IHM1SCfAYeFqGC11JzDGeTwJIYiCsr4O9q5/l6Qn9Ofg2XePRNpDLx4nygeSLLAxLHTmWoVSA==
X-Received: by 2002:a05:600c:220c:b0:41e:db33:9a4e with SMTP id 5b1f17b1804b1-4212793618emr18197565e9.39.1717072162026;
        Thu, 30 May 2024 05:29:22 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270553c9sm24063135e9.8.2024.05.30.05.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 05:29:21 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=18b5eda1971989d3bd86ef330308219832c5e098e1ae8551d8b462fb8510;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 30 May 2024 14:29:20 +0200
Message-Id: <D1MZA5060M8I.NZ33UKFQ1S6I@gmail.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Sameer Pujar"
 <spujar@nvidia.com>, <vkoul@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ldewangan@nvidia.com>,
 <mkumard@nvidia.com>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: dma: Add reg-names to
 nvidia,tegra210-adma
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240521110801.1692582-1-spujar@nvidia.com>
 <20240521110801.1692582-2-spujar@nvidia.com>
 <80b6e6e6-9805-4a85-97d5-38e1b2bf2dd0@kernel.org>
 <e6fab314-8d1e-4ed7-bb5a-025fd65e1494@nvidia.com>
 <56bf93ac-6c1e-48aa-89d0-7542ea707848@kernel.org>
 <f785f699-be50-4547-9411-d41a4e66a225@nvidia.com>
 <774df64c-56a1-461a-82fa-a0340732b779@kernel.org>
 <D1HPADDIQNIK.2F4AL70NLHQCY@gmail.com>
 <20240528153515.GA494766-robh@kernel.org>
In-Reply-To: <20240528153515.GA494766-robh@kernel.org>

--18b5eda1971989d3bd86ef330308219832c5e098e1ae8551d8b462fb8510
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue May 28, 2024 at 5:35 PM CEST, Rob Herring wrote:
> On Fri, May 24, 2024 at 09:36:08AM +0200, Thierry Reding wrote:
> > On Wed May 22, 2024 at 1:29 PM CEST, Krzysztof Kozlowski wrote:
> > > On 22/05/2024 09:43, Sameer Pujar wrote:
> > > >=20
> > > >=20
> > > > On 22-05-2024 12:17, Krzysztof Kozlowski wrote:
> > > >> On 22/05/2024 07:35, Sameer Pujar wrote:
> > > >>> On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
> > > >>>> On 21/05/2024 13:08, Sameer Pujar wrote:
> > > >>>>> From: Mohan Kumar <mkumard@nvidia.com>
> > > >>>>>
> > > >>>>> For Non-Hypervisor mode, Tegra ADMA driver requires the registe=
r
> > > >>>>> resource range to include both global and channel page in the r=
eg
> > > >>>>> entry. For Hypervisor more, Tegra ADMA driver requires only the
> > > >>>>> channel page and global page range is not allowed for access.
> > > >>>>>
> > > >>>>> Add reg-names DT binding for Hypervisor mode to help driver to
> > > >>>>> differentiate the config between Hypervisor and Non-Hypervisor
> > > >>>>> mode of execution.
> > > >>>>>
> > > >>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> > > >>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > > >>>>> ---
> > > >>>>>    .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 =
++++++++++
> > > >>>>>    1 file changed, 10 insertions(+)
> > > >>>>>
> > > >>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra=
210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.=
yaml
> > > >>>>> index 877147e95ecc..ede47f4a3eec 100644
> > > >>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adm=
a.yaml
> > > >>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adm=
a.yaml
> > > >>>>> @@ -29,8 +29,18 @@ properties:
> > > >>>>>              - const: nvidia,tegra186-adma
> > > >>>>>
> > > >>>>>      reg:
> > > >>>>> +    description: |
> > > >>>>> +      For hypervisor mode, the address range should include a
> > > >>>>> +      ADMA channel page address range, for non-hypervisor mode
> > > >>>>> +      it starts with ADMA base address covering Global and Cha=
nnel
> > > >>>>> +      page address range.
> > > >>>>>        maxItems: 1
> > > >>>>>
> > > >>>>> +  reg-names:
> > > >>>>> +    description: only required for Hypervisor mode.
> > > >>>> This does not work like that. I provide vm entry for non-hypervi=
sor mode
> > > >>>> and what? You claim it is virtualized?
> > > >>>>
> > > >>>> Drop property.
> > > >>> With 'vm' entry added for hypervisor mode, the 'reg' address rang=
e needs
> > > >>> to be updated to use channel specific region only. This is used t=
o
> > > >>> inform driver to skip global regions which is taken care by hyper=
visor.
> > > >>> This is expected to be used in the scenario where Linux acts as a
> > > >>> virtual machine (VM). May be the hypervisor mode gives a differen=
t
> > > >>> impression here? Sorry, I did not understand what dropping the pr=
operty
> > > >>> exactly means here.
> > > >> It was imperative. Drop it. Remove it. I provided explanation why.
> > > >=20
> > > > The driver doesn't know if it is operated in a native config or in =
the=20
> > > > hypervisor config based on the 'reg' address range alone. So 'vm' e=
ntry=20
> > > > with restricted 'reg' range is used to differentiate here for the=
=20
> > > > hypervisor config. Just adding 'vm' entry won't be enough, the 'reg=
'=20
> > > > region must be updated as well to have expected behavior. Not sure =
how=20
> > > > this dependency can be enforced in the schema.
> > >
> > > That's not a unusual problem, so please come with a solution for your
> > > entire subarch. We've been discussing similar topic in terms of SCMI
> > > controlled resources (see talk on Linaro Connect a week ago:
> > > https://www.kitefor.events/events/linaro-connect-24/submissions/161 I
> > > don't know where is recording or slides, see also discussions on mail=
ing
> > > lists about it), which is not that far away from the problem here. Ot=
her
> > > platforms and maybe nvidia had as well changes in IO space for
> > > virtualized configuration.
> > >
> > > Come with unified approach FOR ALL your devices, not only this one
> > > (that's kind of basic thing we keep repeating... don't solve only one
> > > your problem), do not abuse the regular property, because as I said:
> > > reg-names will be provided as well in non-vm case and then your entir=
e
> > > logic is wrong. The purpose of reg-names is not to tell whether you h=
ave
> > > or have not virtualized environment.
> >=20
> > This isn't strictly about telling whether this is a virtualized
> > environment or not. Unfortunately the bindings don't make that very
> > clear, so let me try to give a bit more background.
> >=20
> > On Tegra devices the register regions associated with a device are
> > usually split up into 64 KiB chunks.
> >=20
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
> >=20
> > In order to make this work we need to more fine-grainedly specify the
> > register layout. I think the binding changes here aren't sufficient to
> > do that, though.
> >=20
> > Currently we have this for the ADMA controller:
> >=20
> > 	dma-controller@2930000 {
> > 		reg =3D <0x0 0x02930000 0x0 0x20000>;
> > 	};
> >=20
> > This contains the global registers (0x2930000-0x293ffff) and the first
> > page/channel registers (0x2940000-0x294ffff) in one "reg" entry. Instea=
d
> > I think what we need is this:
> >=20
> > 	dma-controller@2930000 {
> > 		reg =3D <0x0 0x02930000 0x0 0x10000>,
> > 		      <0x0 0x02940000 0x0 0x10000>,
> > 		      <0x0 0x02950000 0x0 0x10000>,
> > 		      <0x0 0x02960000 0x0 0x10000>,
> > 		      <0x0 0x02970000 0x0 0x10000>;
> > 		reg-names =3D "global", "page0", "page1", "page2",
> > 		            "page3";
> > 	};
> >=20
> > That describes the device fully, but each of these entries is optional.
> > If "global" is present it means we are a hypervisor (or host OS). If an
> > additional "page" entry is present, we can also use those resources to
> > stream audio data.
> >=20
> > If "global" is not present, we know we are not a hypervisor and those
> > registers cannot be accessed. This would be the typical case for a gues=
t
> > OS which has access only to the listed "page" entries.
> >=20
> > For backwards-compatibility with the existing bindings we should be abl=
e
> > to fallback to the singular register region and partition it up in the
> > driver as necessary.
> >=20
> > This is an approach that we've already implemented for certain devices
> > such as host1x and Ethernet where a similar split exists. I suspect tha=
t
> > we'll need to do this kind of split in a number of other bindings as
> > well.
>
> In a VM is a different (being a subset) programming model, so why not=20
> just a new compatible for virtualized case. That's what we'd do if=20
> actual h/w registers changed from one device to the next.

I suppose you could argue that way. However, the devices are identical
whether we use them in host or guest mode. The only difference is which
registers we can access. And obviously that in the case where we can
access the "global" registers that we also will access them.

But I don't see that as being a different programming model. We've got a
bunch of parameterization elsewhere in the kernel where we don't resort
to new compatible strings. If you really wanted to you could argue that
adding an interrupt GPIO to a device causes the programming model to be
different from a case where you would otherwise do polling. But we don't
and instead make the GPIO optional so that it can be used if available
and we fall back to polling otherwise.

That's very similar to what we want to do here.

There's also the complication that we'd technically need a third
compatible string for the hypervisor. So instead of one compatible
string paired with reg/reg-names to cover all these cases, we'd end up
with three compatible strings just so we can stick with the single reg
entry. And that's not counting any use-cases we don't know of yet.

So what we really need to resolve here is different use-cases of the
same hardware. A compatible string doesn't seem like the right option
for that. Parameterization is a much better solution to that problem.

Thierry

--18b5eda1971989d3bd86ef330308219832c5e098e1ae8551d8b462fb8510
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmZYcSEACgkQ3SOs138+
s6H6jA//UsySIdJTYm2D4kENlcYNkTrBzTb2oya3Tgj6tQ1qe9x++2eQq0cJfZCh
2t3WYNh2+r68ng8RcN1M7pKTKAbs/AOX291lPw4+5uYvXFXrNWF+ZArsPdd1ZYuh
B3veX11mtSMk708Pn6hhJTAfQpEla0zOpRG1/YwlMVrRl7VCXoeIVnhLQ4oKtV4U
WxxG7qdx2mTMMFJqNQpZS3N+rjKfcqG1L9ZPrtrFcTky9QqH/OEJhel8M/jcqOcw
P3gyEGv8/Pqj730XlxouATzZj/uaH9gK4E0PNYYbR09P2UIvLB2Dg+LGIkJnPg9o
8HTuHxS6OUIDOVEJYQFl6H91mADH3F4ULvYwdrOkmxQAZFnvpsx10ImkHDCdgyLB
TpD4/BN+7IH/1rpklzf8g+YfJBhHcj8otzwlE1hZzs0X7OLjp77bI11BuhkWXT9i
lIKu9LE+ahvcdD1IxONuJK/wevu1Nca7wfROzZD8ioCJKp15S3OwGhXYQh5Yj+GW
HcVJir7Pd7bzPE5Iut5/elRubfheTxTOgkwM8nJ+bvBjM/gybjYxKTHjxysLyjhg
Zz2s90DzfBiYKT9SXgxky4jY26IdSxvLrqi8JRQz+nwuq6BSOIXeHvYfQZIoYpG0
B1C+JHxJpoJi00+WwS0zibjwIwlPIGfzEPdyh0RFFYD0oxAWqI4=
=sYXC
-----END PGP SIGNATURE-----

--18b5eda1971989d3bd86ef330308219832c5e098e1ae8551d8b462fb8510--

