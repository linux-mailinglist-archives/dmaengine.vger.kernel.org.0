Return-Path: <dmaengine+bounces-10209-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGBaOHGl+GnQxQIAu9opvQ
	(envelope-from <dmaengine+bounces-10209-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 15:56:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697A74BE22E
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D9FB301060F
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2026 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF73DBD7F;
	Mon,  4 May 2026 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aQiKKv2v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529633DD53E
	for <dmaengine@vger.kernel.org>; Mon,  4 May 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902906; cv=none; b=vFrrxrH1jy2EyQn4KEF8y7j5AjYyMp5R3eygzYpJG1zdypvNXwtuot10tS7C094T7stNz7KSa6SThLLpRd2+Evvpdxhx0+Y0FFMSPmexAKnVI1W7cV9vMx5jhu8o+IImQxgmPuQ93QrVee+GchBh4MYEJ4/7pyWWPInjPMpjqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902906; c=relaxed/simple;
	bh=bOPfveR5SWntqqKowAn0D9LMMHj7n+8HdW2KpvzZmqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk2vq4f02Xy2d6AcObbXKka9KUu0aj96fYglT397Ulhnjf/z4Ec3jzbKybJAAvMNIRF9ubl09I8uShzyMyu/K/60wEh7j7Q3HfFUTNiLZfRJtA/Gdpi7t0islMhQjtn6fepEtpgS3LsevUUeqDNIQs13K/LazBlMT1jAMmYwDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=aQiKKv2v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0046078so33550975e9.1
        for <dmaengine@vger.kernel.org>; Mon, 04 May 2026 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777902902; x=1778507702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtOd9wIvmtizVVlUV0Z3G/eI46M4pQxdkiteSTykGQo=;
        b=aQiKKv2vHMBdXqlu377+NQdeiBIp4QIsmUpw4IliMuW23cfCJHfCSpb63wPOABXNEy
         Y+b94CR6viLA9LjrVQZ7d24tKGtykwiFMgKVkDm4CQaiOR9KstwioqtrmcinjFAM00Cd
         EyV8W+02ttujQ45lPEq1uwSRZkpQSfLnR7LPCgH/dcUBT9jyyXB2huskSsXzD/4cQYgL
         JFmqLoYUIubYh6Rpnn7bZIXx3y/6zZSOQshOw/Ri1QjnREbYrV+4BTRj+ulFdG+/67Z6
         4mVJoHC9FFMQ15jlfrlnYjeGtxamQQ737g6f/MIUZwnBhwZ+PTAVQ9rBOevF8W0MvNWa
         K7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902902; x=1778507702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtOd9wIvmtizVVlUV0Z3G/eI46M4pQxdkiteSTykGQo=;
        b=Mmaq2Ja/WUcW/NhE0E1wguyPHQZT7FvAHjTHR6atKZAFxiJ5fg/mfMgfrykYSli5KZ
         gWsX0rci63VKCQCIELi8Jr+BZE3mRTmXJWO+nJBGisCDTta88TbLCW8fiaiPiH9t3CLh
         856FOQR4/hE4XzxWPKnbBRI7KzqFf7BfF3Qs6wRgD+sknm7mAYhFASlVXfvLGqdKQpoo
         XD8/Hp2aOP+IBnzL1YBjqSPAp2toVha2eZ19WqiCtdSum3pLRr08PgCORx3K/YaZw2gH
         LIZ2NCV0E6iFCWQkaGYHDuCLjR03QXe7aYbj/rISCqHHeKp1wKQMIZzj46MZW31am33D
         uXNw==
X-Forwarded-Encrypted: i=1; AFNElJ+RxhjMIiQ+UVAhhPjZPWYhd+yy81dHi3Ds3Jc2l6gYM7bAq1XMyRMGnVLHUpCSLhy/z3/Ftxf8mgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWLrhTnAaWkpYr75Mo/Wne6q1C4/cnictmONeG5QXQx8F7/+nj
	jkKDFtBFJaDvj/HZshvVwRfUd9ZvoegnENQneOskdEomc54IKiz/BL1dNDyo2zi4kag=
X-Gm-Gg: AeBDiesGXHIcNe30po+NyH3lg3ufrotBYckvS9Y2m2h5W/3hY1WM/iHk7A9GHztk7W0
	xYmlV7py8tgw/3xD/hmVdMLxuwoPi7Q+lxwBvjdYB2YZpM3dWc1Knc+0gcXEfTr/5StzU/+ytZu
	CWQ5+x8085RR5bO+3VjtaF2ImOCrFBrvzid1QPth5DAImMsB28ka6TL3k9/mI4uJxpQTTdP26rB
	8MXvOadKkYZO+ELEOMp/N2YELp/7wdLJl9Sjucak6rJ2UM+SjtHBXPqXUbxpscYL6aTi+TrbhPu
	zBx8JYAMDsdfACvmY8axVx+k0LoX8/2R6o9BiLMOPZ6FRUAUkRsQRVMthGEjdD/A4JyvAV65tDn
	DvVvbzhtl6c+TsNr2hkAGswFzVYGCcklhB5xIp1txJXK5IscSSjMIhhafI6JjWbQKEmMXoIaE0/
	pVJ/rlro3R3SfDngceoEndaSnJqh119qj8gQlEr4ysRRE5DYErJkI14yxQPboJpfomLrKlgBc05
	Sa6gzyJ5b8nzlRMlx8pZL8jyA==
X-Received: by 2002:a05:600c:c058:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-48a9866f1f4mr119701105e9.25.1777902901738;
        Mon, 04 May 2026 06:55:01 -0700 (PDT)
Received: from localhost (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a82307f7csm339654125e9.12.2026.05.04.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:55:01 -0700 (PDT)
Date: Mon, 4 May 2026 15:55:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Consistently define pci_device_ids using
 named initializers
Message-ID: <afijNvdU6HPbjDCX@monoceros>
References: <20260504102008.1996139-2-u.kleine-koenig@baylibre.com>
 <afh0-BSmchvY-W-d@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57vfqru4zafo4xdr"
Content-Disposition: inline
In-Reply-To: <afh0-BSmchvY-W-d@ashevche-desk.local>
X-Rspamd-Queue-Id: 697A74BE22E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-10209-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]


--57vfqru4zafo4xdr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dmaengine: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

On Mon, May 04, 2026 at 01:29:12PM +0300, Andy Shevchenko wrote:
> On Mon, May 04, 2026 at 12:20:06PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > The .driver_data member of the various struct pci_device_id arrays were
> > initialized by list expressions. This isn't easily readable if you're
> > not into PCI. Using named initializers is more explicit and thus easier
> > to parse. Also skip explicit assignments of 0 (which the compiler then
> > takes care of).
> >=20
> > This change doesn't introduce changes to the compiled pci_device_id
> > arrays. Tested on x86 and arm64.
>=20
> HSU driver has different change ("Also" is a strong sign to the split req=
uired).

HSU is in the category "skip explicit assignments of 0", so I think
that's fine. I could be talked into splitting if that's what is wanted.
=20
> ...
>=20
> >  static const struct pci_device_id pch_dma_id_table[] =3D {
> > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), 8 },
> > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), 4 },
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), 8}, /* UART Video=
 */
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), 8}, /* PCMIF SPI =
*/
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), 4}, /* FPGA */
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), 12}, /* I2S */
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), 4}, /* UART */
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), 4}, /* Video SPI =
*/
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), 4}, /* Security */
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), 4}, /* FPGA */
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), 8}, /* UART */
> > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
> > -	{ 0, },
> > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), .driver_data =
=3D 8 },
> > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data =
=3D 4 },
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), .driver_data =3D =
8 },		/* UART Video */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), .driver_data =3D =
8 },		/* PCMIF SPI */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), .driver_data =3D =
4 },		/* FPGA */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), .driver_data =3D=
 12 },	/* I2S */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), .driver_data =3D =
4 },		/* UART */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), .driver_data =3D =
4 },		/* Video SPI */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), .driver_data =3D =
4 },		/* Security */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), .driver_data =3D =
4 },		/* FPGA */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), .driver_data =3D =
8 },		/* UART */
> > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), .driver_data =3D =
4 },		/* SPI */
> > +	{ },
> >  };
>=20
> Use PCI_DEVICE_DATA() instead. Same may apply to DesignWare, but one need=
s to
> define the device IDs. I think I may help with that.

I'm not a fan of PCI_DEVICE_DATA. While it could indeed be used to
shorten the assignments here, it's less readable in my opinion.

Compare

	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data =3D 4 =
},

with

	{ PCI_DEVICE_DATA(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH, 4) },

=2E For someone who doesn't know what PCI_DEVICE_DATA does, the latter is
less understandable.

Also PCI_DEVICE_DATA has a cast which is something I want to get rid of.

Best regards
Uwe

--57vfqru4zafo4xdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn4pTEACgkQj4D7WH0S
/k7zkQgApz70lV3E3UNybsOon9YUHk8ggPuHinq/44naNQ41FCWRSeFT4rZPL6LF
i26D2z/Q9lyHS8jRIvPvMZtT5V3uCEjbDE1cz4Tze5pUEHW9DDqh8fAqI1ujNRu7
ZYSTSAwZeSR74vaR5Tgg6uKkjbF1U9dtvQE07hS1IzAX4auNBpG/2gNmqAR2648q
0BNPhyxPWNzmIIcqLE69p8ApN9MrjjMVUwhNj8rhVW8dGgLBE0njEvNGEX38pifb
XVw/ebOzzxJLk8yURMLs1PHTqMVRczZp0R1Ax0I3azZ3T/XwC1pqkTmiWJb8U/qz
/8/Uyk6n9hpW8OXhNHnhboUgrnYymA==
=7ieQ
-----END PGP SIGNATURE-----

--57vfqru4zafo4xdr--

