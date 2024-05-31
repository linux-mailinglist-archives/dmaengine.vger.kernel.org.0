Return-Path: <dmaengine+bounces-2221-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8902A8D5DC1
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 11:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1645D1F22F89
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E6156F27;
	Fri, 31 May 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCX1WFAH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE19155CAF;
	Fri, 31 May 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146394; cv=none; b=cXEUIWDRQEB7RIukq4/DLr6nBzwRpXjVL8fwsmEmLXmO26xF6ekNiNH9EZmxey2YaN0vCl4QnP/MQ823NHn9q/N4VcBQCfngrLLKFJrwb30s0S8tsr9Uh7SbxD+MosB3mChNRFbY4Pnr9L2TSIsnipzGnFOLae/S5FgY65S5GRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146394; c=relaxed/simple;
	bh=Gj3TQ7n/cvAIqHTsVPgQF2pm5cUn5J8n7dtIOah86C4=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OMo0fsWwF5rItY2w+/uWBnEqwdcyjYk9FE+97oSH/YI9inrly3eDikWHY1cnSHconIb8kEuk4T6JzpETNuRljnc0uHJH3DbDxS3h3Y2BJCbz6FaB//AXQZSTXey1uOGpFdOz06iC8YNikzt76afnXbuw9NvFFVqd56CYoBQct/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCX1WFAH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc0472b7eso1722376f8f.2;
        Fri, 31 May 2024 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717146391; x=1717751191; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEEG0kHvZPm3wCKBvQt9pPqiOkgbjohL3p/fSyC44bk=;
        b=YCX1WFAH3Q2og7/ofs8rh0p2NuR43r7Upy3k1TQQp4MxlvQFDQPX9uoOLbfjq6ldWU
         1kNPs8d1fiAmxygsoyyLJ/4VCVEoOL4/d2kjL92iqHS0VIViCztU8uOiSEJiH+/TYo5X
         kNL6a8JM9w+oIKye9Ie5hVvqJCpCEoqDrqWZwiCHbtdfll8eU08qvK9MBVQlu0Bzl4y/
         0LkJRqJoZ4ngB4UXg8Y28DtRddcDqyjQEVbwctpmgczjq642ngJoUJUR2iWQMqqfvOJN
         KV8Tls/AUI5ui3a2HoubNr4HzWfvHQhLRNSY20bfamX2gcwVXL7ZsBMY7kQT7s93WH3N
         bb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717146391; x=1717751191;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEEG0kHvZPm3wCKBvQt9pPqiOkgbjohL3p/fSyC44bk=;
        b=DqND5HTHwipxsDUv9asm2Pq2El1hEb9tmO3vJq3ULYuVte1j3RR9edZpFAco3XYQdC
         hIc70EX6UII2uUr5LzPuePmxiAcugrAIvkOY/1zFLFwYjVKn6hHKRfEgl/EziPvHLQlW
         uzBDP1RLXuA/pqZnSDayQPAuwQHYTGBm99Nne4TzeL9wB8wcCsOlVqueurgAfrBDLHJw
         Yd/GY+qHGnaoGzQVX6Qo0JiEZpaCZsR8cMnctcs+mmsYcdo6YWY4nT8d5vAnZnc6nv/y
         U0ZJslSREO6SEAk84riQmZjWMkU9q/+2rrFUMoVwB0zfXj7eQrCv5e15f+GMZ/WxRZFY
         JZCA==
X-Forwarded-Encrypted: i=1; AJvYcCUj0bp9OgJj0JXTtirmpBQUnciKojCjrmSIjr2eSZ6vo1JJtR7i4YD6gd12IWO4uVZPA09UsS6kKVYU7KG01Q0625mEQs7X6YisO4nhlF3yPU5gb3tTF1rGc3Tx4hAzEpLhgicRXfTs12uTl5s48nYlpVYaX5dQm/IQuEtc3QPEffKngw==
X-Gm-Message-State: AOJu0Yz1wyR4SQcwNSHIhHJsCX3wW2FIldMmhe5doOces1AbHWfrB+aa
	KQpWQ1t7iWJ8bNgY7P6uW3Ygv5r9VabV5QikkYpmMJVdKbSclXf6tZx1qg==
X-Google-Smtp-Source: AGHT+IHHwPOJdlJH8BE2VfHsOd+HdUnmI82NkLvsu485EqNyNwO1IrCJ7YvRXISEME8ZUF3NMwqp9g==
X-Received: by 2002:adf:a1c5:0:b0:345:5f6a:cbf7 with SMTP id ffacd0b85a97d-35e0f28881cmr845064f8f.29.1717146390634;
        Fri, 31 May 2024 02:06:30 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d96f6sm1394627f8f.61.2024.05.31.02.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 02:06:30 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=5756bc5e83a6bad3a9f5eb4a93427ad8fb0c0c23d1457925c7710f966752;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 31 May 2024 11:06:29 +0200
Message-Id: <D1NPLD5J2YE2.3H93K6QYATI49@gmail.com>
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
 <D1MZOIQR9R4G.16O4LIDN6AN5Q@gmail.com>
 <18946269-8529-434e-bcef-85c74b7a81b7@kernel.org>
In-Reply-To: <18946269-8529-434e-bcef-85c74b7a81b7@kernel.org>

--5756bc5e83a6bad3a9f5eb4a93427ad8fb0c0c23d1457925c7710f966752
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri May 31, 2024 at 9:43 AM CEST, Krzysztof Kozlowski wrote:
> On 30/05/2024 14:48, Thierry Reding wrote:
> > On Tue May 28, 2024 at 8:48 AM CEST, Krzysztof Kozlowski wrote:
> >> On 24/05/2024 09:36, Thierry Reding wrote:
> >>> On Wed May 22, 2024 at 1:29 PM CEST, Krzysztof Kozlowski wrote:
> >>>> On 22/05/2024 09:43, Sameer Pujar wrote:
> >>>>>
> >>>>>
> >>>>> On 22-05-2024 12:17, Krzysztof Kozlowski wrote:
> >>>>>> On 22/05/2024 07:35, Sameer Pujar wrote:
> >>>>>>> On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
> >>>>>>>> On 21/05/2024 13:08, Sameer Pujar wrote:
> >>>>>>>>> From: Mohan Kumar <mkumard@nvidia.com>
> >>>>>>>>>
> >>>>>>>>> For Non-Hypervisor mode, Tegra ADMA driver requires the registe=
r
> >>>>>>>>> resource range to include both global and channel page in the r=
eg
> >>>>>>>>> entry. For Hypervisor more, Tegra ADMA driver requires only the
> >>>>>>>>> channel page and global page range is not allowed for access.
> >>>>>>>>>
> >>>>>>>>> Add reg-names DT binding for Hypervisor mode to help driver to
> >>>>>>>>> differentiate the config between Hypervisor and Non-Hypervisor
> >>>>>>>>> mode of execution.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> >>>>>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> >>>>>>>>> ---
> >>>>>>>>>    .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 =
++++++++++
> >>>>>>>>>    1 file changed, 10 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra=
210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.=
yaml
> >>>>>>>>> index 877147e95ecc..ede47f4a3eec 100644
> >>>>>>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adm=
a.yaml
> >>>>>>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adm=
a.yaml
> >>>>>>>>> @@ -29,8 +29,18 @@ properties:
> >>>>>>>>>              - const: nvidia,tegra186-adma
> >>>>>>>>>
> >>>>>>>>>      reg:
> >>>>>>>>> +    description: |
> >>>>>>>>> +      For hypervisor mode, the address range should include a
> >>>>>>>>> +      ADMA channel page address range, for non-hypervisor mode
> >>>>>>>>> +      it starts with ADMA base address covering Global and Cha=
nnel
> >>>>>>>>> +      page address range.
> >>>>>>>>>        maxItems: 1
> >>>>>>>>>
> >>>>>>>>> +  reg-names:
> >>>>>>>>> +    description: only required for Hypervisor mode.
> >>>>>>>> This does not work like that. I provide vm entry for non-hypervi=
sor mode
> >>>>>>>> and what? You claim it is virtualized?
> >>>>>>>>
> >>>>>>>> Drop property.
> >>>>>>> With 'vm' entry added for hypervisor mode, the 'reg' address rang=
e needs
> >>>>>>> to be updated to use channel specific region only. This is used t=
o
> >>>>>>> inform driver to skip global regions which is taken care by hyper=
visor.
> >>>>>>> This is expected to be used in the scenario where Linux acts as a
> >>>>>>> virtual machine (VM). May be the hypervisor mode gives a differen=
t
> >>>>>>> impression here? Sorry, I did not understand what dropping the pr=
operty
> >>>>>>> exactly means here.
> >>>>>> It was imperative. Drop it. Remove it. I provided explanation why.
> >>>>>
> >>>>> The driver doesn't know if it is operated in a native config or in =
the=20
> >>>>> hypervisor config based on the 'reg' address range alone. So 'vm' e=
ntry=20
> >>>>> with restricted 'reg' range is used to differentiate here for the=
=20
> >>>>> hypervisor config. Just adding 'vm' entry won't be enough, the 'reg=
'=20
> >>>>> region must be updated as well to have expected behavior. Not sure =
how=20
> >>>>> this dependency can be enforced in the schema.
> >>>>
> >>>> That's not a unusual problem, so please come with a solution for you=
r
> >>>> entire subarch. We've been discussing similar topic in terms of SCMI
> >>>> controlled resources (see talk on Linaro Connect a week ago:
> >>>> https://www.kitefor.events/events/linaro-connect-24/submissions/161 =
I
> >>>> don't know where is recording or slides, see also discussions on mai=
ling
> >>>> lists about it), which is not that far away from the problem here. O=
ther
> >>>> platforms and maybe nvidia had as well changes in IO space for
> >>>> virtualized configuration.
> >>>>
> >>>> Come with unified approach FOR ALL your devices, not only this one
> >>>> (that's kind of basic thing we keep repeating... don't solve only on=
e
> >>>> your problem), do not abuse the regular property, because as I said:
> >>>> reg-names will be provided as well in non-vm case and then your enti=
re
> >>>> logic is wrong. The purpose of reg-names is not to tell whether you =
have
> >>>> or have not virtualized environment.
> >>>
> >>> This isn't strictly about telling whether this is a virtualized
> >>> environment or not. Unfortunately the bindings don't make that very
> >>> clear, so let me try to give a bit more background.
> >>>
> >>> On Tegra devices the register regions associated with a device are
> >>> usually split up into 64 KiB chunks.
> >>
> >> So describing it as one IO region was incorrect from the start and you
> >> want to fix it by adding one more incorrect description: making first
> >> item meaning two different things. Sorry, that's not a correct way to
> >> fix things.
> >=20
> > Yes, describing this as one I/O region was incorrect, and in hindsight
> > it should have been done differently.
> >=20
> > However, I don't think it's correct to describe this as adding one more
> > incorrect description. Instead, what this does is add reg-names to
> > provide additional context so that the operating system can make the
> > necessary decisions as to what is allowed and what isn't.
> >=20
> > In the absence of a reg-names property the current definition of the DT
> > bindings applies, so it means the region represents the entirety of the
> > device's I/O register space. That's one particular use-case for this
> > device.
> >=20
> > For additional use-cases we can then use reg-names to differentiate
> > between what separate regions are and use them accordingly.
> >=20
> >> Items are defined, thus first item is always expected to be what the
> >> binding already said. Adding reg-names changes nothing, because (as
> >> repeated many times) xxx-names is just a helper. Items are already def=
ined.
> >=20
> > I don't understand what you're trying to say here. I suppose adding
> > reg-names alone indeed doesn't change anything. But the point is that
> > once added we can now use these properties, at which point of course
> > things change.
> >=20
> >>> One of these chunks, usually the first one, is a global region that
> >>> contains registers that configure the device as a whole. This is usua=
lly
> >>> privileged and accessible only to the hypervisor.
> >>>
> >>> Subsequent regions are meant to be assigned to individual VMs. Often =
the
> >>> regions take the form of "channels", so they are instances of the sam=
e
> >>> register block and control that separate slice of the hardware.
> >>>
> >>> What makes this a bit confusing is that for the sake of simplicity (a=
nd,
> >>> I guess, lack of foresight) the original bindings were written in a w=
ay
> >>> to encompass all registers without making that distinction. This work=
ed
> >>> fine because we've only ever run Linux as host OS where it has access=
 to
> >>> all those registers.
> >>>
> >>> However, when we move to virtualized environments that no longer work=
s.
> >>>
> >>> Given the above, we can't read any registers in order to probe whethe=
r
> >>> we run as a guest or not. Trying to access any of the global register=
s
> >>> from a VM simply won't work and may crash the system. None of the
> >>> "channel" registers contain information indicating host vs. guest
> >>> either.
> >>
> >> I don't understand how it differs from what I said - you want to
> >> indicate that you run in virtualized environment and not all resources
> >> are accessible.
> >>
> >> The device still has the first (global) address, just it is not
> >> available due to hypervisor.
> >=20
> > Yes, and that's a bad thing because there's no way for the device to
> > know that it can't access the registers. So it will just assume that it
> > can and try to access them, which would then result in a crash/error.
>
> Different compatible could note that or the global address would be
> removed from IO space, although then you need to rely on names and order
> is not fixed. I think Rob already proposed different compatible.
>
> This is also the way new Qcom platforms are going (older were using
> properties).
>
> However my earlier comment stays on: you will have for sure more cases
> like this, so please think upfront and pick unified approach for all
> future devices.

We already have. In fact we already have a few devices (host1x[0] and
MGBE[1]) where a similar path was chosen. Unification with those is why
we're proposing this.

This also applies to the memory controller SID bindings update that we
proposed a little while ago.

Thierry

[0]:
Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
[1]: Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml

--5756bc5e83a6bad3a9f5eb4a93427ad8fb0c0c23d1457925c7710f966752
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmZZkxYACgkQ3SOs138+
s6Gxsg/9FpCyMeDV4FlwtV47MwNWpVc45/xh+Jlu8zR6fnOUsBIIkDuCE6mQDOVg
O8bBg2SK2ja2ZgAYZ2++fuq78YI58aYFZdWZRaReVZmn9y+qs1lMhjomvkQh9M52
zAtAAfs0qEQlJQSFPeA3p/ZibxjvxVxEqR9aQod9mBfm8+6ll1BPl2nTGfnXhDnY
cgI/J/6rvmD/wq2Zf5M/JS2BedOcA1NZpmb8Kdxu/G4WPvBOiQccKpzUBfaDOCSV
J/F2MIOjgNwpR0fnuZZxY3J5hxACfemnR2w9QIq1u3ykALgm4bKXD3vj85NXPCsM
7RC9ehjzSBeolhcEiX7DwKMYgD19lYQQEicwyeHJ8WSm03B8wXQxqPP49KD0vOTC
I0140x6cqmlEyD0eUVe6PEdtbURhZUrKfh9V3DO7sMt/BUkpt+NDtyWs2prclJsx
efdNUl+IJ5bZrCU/TBTVdAQ6HlXTWtRot7jlPlgSbuooow1rfZWczA72WHg5DF4o
RXVRM5bmiqwpd7f3lXyI+lQNVl8/TOhAeJlgV4IrDXYkIH53j/80rJrhptF4Z0Nv
/ydOjcpOXMnXbTbdQYtw6BVs2Hfh9HHLE/5/coxMCOB+5L75ExisFAXuQB5I6I9B
BfM6y8DW5jNXIt39g97TdSkSr/ORk1vfbKMBV8ZgiZIIu7pcGyE=
=ViI5
-----END PGP SIGNATURE-----

--5756bc5e83a6bad3a9f5eb4a93427ad8fb0c0c23d1457925c7710f966752--

