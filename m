Return-Path: <dmaengine+bounces-4271-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F041A2797A
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 19:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485417A47A9
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5F21765F;
	Tue,  4 Feb 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="peYZhZ9+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085E212D83
	for <dmaengine@vger.kernel.org>; Tue,  4 Feb 2025 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692770; cv=none; b=RwWWLzlM+czWYGzcmn131XK7hPF2JjxyQF+do6J/MI1EBjGK1SQWJ/MefUe2Kx2ZLfSMlaerD189EcGBA0sMnwL9sRniBiH4EqFR8JnhGob45qGitUz5Pbr3KhMnvXda6S6ji57SYQOtkfWA/hmmkKm4b7mDbDmurtayg2oVaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692770; c=relaxed/simple;
	bh=H4WCEkVwFS9vNlyOO7hV0Dr4vO8FBmOR28+tX69NlJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RZ/rcxHza9C1yNnh/wfVylfEPclFcZgvl8pFgQYoSAjw1szqug9O4Rc2sKE2zPJhQI7pUJeU4QKeZVUk/a7yXcIA6yp8E8v2jsoH3YD7+zNIkJJ5NXsX/yLsMAfJ8r8nzmOePIFp3ovGreuEz+yShZhs+hT1RrnMcbYli5ZqETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=peYZhZ9+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso50779876d6.0
        for <dmaengine@vger.kernel.org>; Tue, 04 Feb 2025 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1738692767; x=1739297567; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7FLDKP+B1KLmToqN0+wbXjgRxetp1/agS67Xma08wWo=;
        b=peYZhZ9+Py561TATXt4/G2QWgwOTZNIrd2UyqevWCM+N1gYD1zLXwVpDsula82y/Ui
         DbUVGwKBKlNakg9Fy87Qqsx5BHCnQmYlNHc0WSBZu2jLqqrs0HVC8W0bkkcvhmiquN6F
         KtOqJjH222sXGWiPOcsvWQ7HlnMxeT5DDqL77tDg07eRxEoObej6+/sN4SO47KRLj1gZ
         XjEGxbpKJgI+7k6gK8AmHS9wgxObIcbT1CR1zSj8bHSV/SQJJ7yYsnDBCkkryqmFB93Y
         Cv7H1+USsdq3GM9O/TmXsSExHnm9ts5uRiSkgs1E0csmMQZCUcVLeLZAOtrTayAnok1I
         7cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692767; x=1739297567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FLDKP+B1KLmToqN0+wbXjgRxetp1/agS67Xma08wWo=;
        b=WTQOzKdc58+zCO2nPA93oEsHOPYAl01lc+85d5SRJsdoIo61RXgUEhnyz/xHkaOHIV
         msPH7I1sF4kB2qh7LJs5G4h97xI8GmAHtnVwyJixNl/edfJghbzqL/NcfK9dEzY79h+5
         O+ishvUjAiH3YUxTR/caG5cZexE0MvTPC02TAhLcbSOBHyaqXQhm/T0AEvNxHLh1AzA6
         xTcHzpzrSd7iMSfMxTMqIfO2as3aeu5Sp/UVEPjtej0pvfymOsA0Kq2FpkwnJ6QJ8z21
         /aGnx4LRbFiiXlrRimnKymsOs68OIUbGcw9Rr2zsjw4P/4WMnPzt066xs13j0bfivVvd
         tntA==
X-Forwarded-Encrypted: i=1; AJvYcCWuFRvSAtniTw/QTYahBdXzt8Bq4jHIwljgzkh76+ReDGiL5mqa45qP4tl3ceIw/u52MER+kTL4+y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIu1t2thwmvjf2cRv+eOXZi3+qyBlDqlsWrsyLIg/XYdGTdMq
	zbiWQnSXRD7B+ApdlR6ohE4UytcEfR/P9CnG3YjRHEac6bIF7v1ux9JQm/Vaknc=
X-Gm-Gg: ASbGncvGt9cM9w9H4bOpsLwzc2CycMVRj82o/oZ5TCtqcctUvt59JIUg6D/ROb4JZkz
	GO/h+E+C6km6yz6feaa9wpo4+9gEGLgAQ4mmyWfk18k5jKE85bBxLi6+BkYcptE0FMRkuoL7G0g
	W12bjf0maeu5uJLkDL8MPFadx/vAJatNWB+g41+wl7E9UTZMgTYKjffaI+IM6Oh54/UcinXFcOd
	qFWJSN5PLSkvwOk6C6AXVqRkAgapKs5uvji1mNjvqVxS7TLZJVrSlHV9BSk5ad2h8TNizNYfQsw
	GbYP+KzCFxBKcGm2
X-Google-Smtp-Source: AGHT+IEUFtl7TqQiYVbLC5fRURyW+Ho5rjSwqMbAkbu0qwIuaYAMXRJbz+FDijkjOelVbHDYm/RAhg==
X-Received: by 2002:a05:6214:3291:b0:6e1:a4d6:185f with SMTP id 6a1803df08f44-6e243c9b8c2mr427636956d6.34.1738692766625;
        Tue, 04 Feb 2025 10:12:46 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:e976::7a9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2548143c4sm64370106d6.35.2025.02.04.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:12:46 -0800 (PST)
Message-ID: <b02711c901e8acf2bc47926919de7673a0cb0b98.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Florent Tomasin <florent.tomasin@arm.com>, Maxime Ripard
	 <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Boris
 Brezillon	 <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>,  Sumit Semwal <sumit.semwal@linaro.org>, Benjamin
 Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey	
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J .
 Mercier"	 <tjmercier@google.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong
 Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, nd@arm.com, Akash Goel
 <akash.goel@arm.com>
Date: Tue, 04 Feb 2025 13:12:44 -0500
In-Reply-To: <be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
	 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
	 <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
	 <be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Florent,

Le lundi 03 f=C3=A9vrier 2025 =C3=A0 13:36 +0000, Florent Tomasin a =C3=A9c=
rit=C2=A0:
>=20
> On 30/01/2025 13:28, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Thu, Jan 30, 2025 at 01:08:57PM +0000, Florent Tomasin wrote:
> > > Introduce a CMA Heap dt-binding allowing custom
> > > CMA heap registrations.
> > >=20
> > > * Note to the reviewers:
> > > The patch was used for the development of the protected mode

Just to avoid divergence in nomenclature, and because this is not a new sub=
ject,
perhaps you should also adhere to the name "restricted". Both Linaro and
Mediatek have moved from "secure" to that name in their proposal. As you ar=
e the
third proposing this (at least for the proposal that are CCed on linux-medi=
a), I
would have expected in your cover letter a summary of how the other require=
ment
have been blended in your proposal.

regards,
Nicolas

> > > feature in Panthor CSF kernel driver and is not initially thought
> > > to land in the Linux kernel. It is mostly relevant if someone
> > > wants to reproduce the environment of testing. Please, raise
> > > interest if you think the patch has value in the Linux kernel.
> > >=20
> > > Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
> > > ---
> > >  .../devicetree/bindings/dma/linux,cma.yml     | 43 +++++++++++++++++=
++
> > >  1 file changed, 43 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/linux,cma.y=
ml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/dma/linux,cma.yml b/Do=
cumentation/devicetree/bindings/dma/linux,cma.yml
> > > new file mode 100644
> > > index 000000000000..c532e016bbe5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/linux,cma.yml
> > > @@ -0,0 +1,43 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/linux-cma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Custom Linux CMA heap
> > > +
> > > +description:
> > > +  The custom Linux CMA heap device tree node allows registering
> > > +  of multiple CMA heaps.
> > > +
> > > +  The CMA heap name will match the node name of the "memory-region".
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - linux,cma
> > > +
> > > +  memory-region:
> > > +    maxItems: 1
> > > +    description: |
> > > +      Phandle to the reserved memory node associated with the CMA He=
ap.
> > > +      The reserved memory node must follow this binding convention:
> > > +       - Documentation/devicetree/bindings/reserved-memory/reserved-=
memory.txt
> > > +
> > > +examples:
> > > +  - |
> > > +    reserved-memory {
> > > +      #address-cells =3D <2>;
> > > +      #size-cells =3D <2>;
> > > +
> > > +      custom_cma_heap: custom-cma-heap {
> > > +        compatible =3D "shared-dma-pool";
> > > +        reg =3D <0x0 0x90600000 0x0 0x1000000>;
> > > +        reusable;
> > > +      };
> > > +    };
> > > +
> > > +    device_cma_heap: device-cma-heap {
> > > +      compatible =3D "linux,cma";
> > > +      memory-region =3D <&custom_cma_heap>;
> > > +    };
> >=20
> > Isn't it redundant with the linux,cma-default shared-dma-pool property
> > already?
> >=20
> > Maxime
>=20
> Hi Maxime,
>=20
> Please correct me if my understanding is wrong,
>=20
> The existing properties: linux,cma-default and shared-dma-pool, do not
> allow the creations of multiple standalone CMA heaps, those will create
> a single CMA heap: `dma_contiguous_default_area`? Other CMA heaps will
> be bound to a driver.
>=20
> I introduced the "linux,cma" to allow creating multiple standalone CMA
> heaps, with the intention of validating the protected mode support on
> Mali CSG GPUs. It was included in the RFC in there are interests in
> this approach.
>=20
> Since the Panthor CSF kernel driver does not own or manage a heap,
> I needed a way to create a standalone heap. The idea here is for the
> kernel driver to be an importer. I relied on a patch series to retrieve
> the heap and allocate a DMA buffer from it:
> - dma_heap_find()
> - dma_heap_buffer_alloc()
> - dma_heap_put()
>=20
> Ref:
> https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/=
#t
>=20
>=20
> Since the protected/secure memory management is integration specific,
> I needed a generic way for Panthor to allocate from such heap.
>=20
> In some scenarios it might be a carved-out memory, in others a FW will
> reside in the system (TEE) and require a secure heap driver to allocate
> memory (e.g: a similar approach is followd by MTK). Such driver would
> implement the allocation and free logic.
>=20
> Florent
>=20
>=20
>=20


