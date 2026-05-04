Return-Path: <dmaengine+bounces-10213-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOzoOMjL+Gma0wIAu9opvQ
	(envelope-from <dmaengine+bounces-10213-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 18:39:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AEF4C184C
	for <lists+dmaengine@lfdr.de>; Mon, 04 May 2026 18:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D55303938A
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2026 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEED3E3146;
	Mon,  4 May 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XcRYG3kQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF33A2574
	for <dmaengine@vger.kernel.org>; Mon,  4 May 2026 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912737; cv=none; b=KuTbZtrFbzCNxGvuloBiZXILZjkP+Y0wFQVK05Wp23ilK9Ja6qnNLg1NtH5jrMCnOck55sQcV3e6Sa/Xbx6qv0Pjayn6q2+znA8Y9sQQWr2yVwI3MVZ21AQH8XKqHzbz5Re7N2cRXlqXICBIG8xtNC3U/U/RHjjyyZsA9xICpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912737; c=relaxed/simple;
	bh=ifDcycN4sxmMeP0jkCzmCvk6hKMxSu/AfQu/RMH4qdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTtfQGpCBuIlsBePfNHmaMXLXLgceAPqG8jFvMWG0FwltPw1ZyBNYVvrVFdy9NlsFW6Ws08B3wN6P2wY69ErDH8BFlLG2ik45wRjqLoHKN1W1vVLf8MBvr++4E69vBM6LIgVIH549w362DiOumJiRKkiOaqkFtHilD0dEadO3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=XcRYG3kQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so41101465e9.2
        for <dmaengine@vger.kernel.org>; Mon, 04 May 2026 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777912732; x=1778517532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzti5IfnmT+c5McxmlLM2AJ8DTzW4zuCbfFoVuxW04s=;
        b=XcRYG3kQdfhcLWnVKYUmd8UF+KP6b+cxcumrSVyLdoOktS1shXRAGnDaJXdg9kF4d8
         KGuODi40Q04e/qae5PzIkwQC1rUBnqe+z62B4aHFUvNPOmlpjLS/ogHnJ/7mbZX6U4Aa
         Qouz1iQ4fmyWHC3ZLQhr1Hc5gtz7IJUToAHLoC0VUqOLNL5kh/swF7fQNoCKn/aNfui8
         cJ9X7c9ZlkxSZH7mor7LgpH8ugo86Yg3CCEP2jP0hPI17V4hgGV6kUI+USJSD5h+sK1l
         oOVZyrvBi5pliQWpNW/p9Zs8iMZHMNKXCwqKi3r9scpHZKZblWeo5aMgrkyAF9SKNMsP
         GgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912732; x=1778517532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzti5IfnmT+c5McxmlLM2AJ8DTzW4zuCbfFoVuxW04s=;
        b=MZv8LmyOEK4GSxH3x5yOWJ6Z4ydZd5te6rYY1H2qjazS/anmdlojI5ikANroNmnfmk
         160urhN3KEqwkuD/NW2NUwsjTplh1UFefObf3vEvJPmwkhiLMJm8V5tt1G+Tk4+XnvNr
         /NXOLjcsz4RT/Fl3ap6Tue5fZne7Oj0x6yCVnsqTY7aOpPutAM+zzyon+ZTLKrCpw/Np
         0YS7P1dlbIoSpulxcIwce+jJwErn8qPJ1GiyxGbaB3PI3vUwU3XmDjtOAvSfVGhu77Uv
         TXzRSXlHVbjz25hT/UCIRBjeEn+3m5jW9St5/Sx4+359djSX/cCbwFdYH+K0gNirH5IW
         x1YQ==
X-Forwarded-Encrypted: i=1; AFNElJ82BdvA1+L0z67YYlYfeAa+I/J8UTXwuE2NA6IbvbfORzxcuO50Kx06jSlxBMBbu9UosB54iUStzb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+O1jhEIocT8sdEOLrzLpXG/h4LsUbsQcmOJmTJkxnYM40YSd
	hhHCiT1E8M21U8+D6/FirS2qm5TO3xUZNSqCt68pMp01Lmugf453WfS3OUsfK30Bvzw=
X-Gm-Gg: AeBDievYoeLCu60gWLN1nZGoFZZjBWHYYzN0yyu2N8WGBT/1Pjwo3TdXZD49gwD2B6t
	azDdSa9bdWyxH4sqql35zN1lGnztyjvqqZfa7aMPgx7WNOtRd5OaMewmfk/a68oHE2kAV8UCvNy
	aZ1aiDu2J5cLENav5g2Xmmrmiz5XVifAf0W6Rb1KbGF3c72w1bE1dk0EhJ8225s69VQzqZlCuMy
	RIyqLizs4RVDcXAJi6ZABK87xFtL78aZDlKbFxkUyH6hQI+10k+uz8e7DKWtViuXreZ6dwtAw9y
	SEih9SVpZ84e3Fr+nXiL64Z3LpJP/omPnYFF73B8R+XjCtNR8E+CcAaAwyLksy5dSQs3PHH14oF
	RBCilnZmhhNFFRvRSmb9NP+17d0v9Vli7uEmlMJv62hVLsoqDAIrS8BG3BiZQQAFspNoPWrQ8aS
	5s8i5gFG3qXO1SCh/ASsqwyXf5g8GALYBmw28ZnAU31zMiI0KV7Nh6mYocuUsUWtdiVlwTOFVka
	FweJS08Xw5qhRNPrcajt6LJMA==
X-Received: by 2002:a05:600c:c082:b0:48a:54fd:54ea with SMTP id 5b1f17b1804b1-48a98877b42mr117774355e9.12.1777912732469;
        Mon, 04 May 2026 09:38:52 -0700 (PDT)
Received: from localhost (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-44a8ef50e59sm26411276f8f.10.2026.05.04.09.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:38:51 -0700 (PDT)
Date: Mon, 4 May 2026 18:38:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Consistently define pci_device_ids using
 named initializers
Message-ID: <afjJ0YjzLgk-r9Nh@monoceros>
References: <20260504102008.1996139-2-u.kleine-koenig@baylibre.com>
 <afh0-BSmchvY-W-d@ashevche-desk.local>
 <afijNvdU6HPbjDCX@monoceros>
 <afioswWDnEbf53ay@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h7rxs4abwv7pbrlb"
Content-Disposition: inline
In-Reply-To: <afioswWDnEbf53ay@ashevche-desk.local>
X-Rspamd-Queue-Id: 46AEF4C184C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10213-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]


--h7rxs4abwv7pbrlb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dmaengine: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello Andy,

On Mon, May 04, 2026 at 05:09:55PM +0300, Andy Shevchenko wrote:
> On Mon, May 04, 2026 at 03:55:00PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > On Mon, May 04, 2026 at 01:29:12PM +0300, Andy Shevchenko wrote:
> > > On Mon, May 04, 2026 at 12:20:06PM +0200, Uwe Kleine-K=F6nig (The Cap=
able Hub) wrote:
> > > > The .driver_data member of the various struct pci_device_id arrays =
were
> > > > initialized by list expressions. This isn't easily readable if you'=
re
> > > > not into PCI. Using named initializers is more explicit and thus ea=
sier
> > > > to parse. Also skip explicit assignments of 0 (which the compiler t=
hen
> > > > takes care of).
> > > >=20
> > > > This change doesn't introduce changes to the compiled pci_device_id
> > > > arrays. Tested on x86 and arm64.
> > >=20
> > > HSU driver has different change ("Also" is a strong sign to the split=
 required).
> >=20
> > HSU is in the category "skip explicit assignments of 0", so I think
> > that's fine. I could be talked into splitting if that's what is wanted.
>=20
> Yes, please. I will Rb/Ack it immediately when standalone change.
>=20
> ...
>=20
> > > >  static const struct pci_device_id pch_dma_id_table[] =3D {
> > > > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), 8 },
> > > > -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), 4 },
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), 8}, /* UART V=
ideo */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), 8}, /* PCMIF =
SPI */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), 4}, /* FPGA */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), 12}, /* I2S =
*/
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), 4}, /* UART */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), 4}, /* Video =
SPI */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), 4}, /* Securi=
ty */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), 4}, /* FPGA */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), 8}, /* UART */
> > > > -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), 4}, /* SPI */
> > > > -	{ 0, },
> > > > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_8CH), .driver_da=
ta =3D 8 },
> > > > +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_da=
ta =3D 4 },
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA1_8CH), .driver_data =
=3D 8 },		/* UART Video */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA2_8CH), .driver_data =
=3D 8 },		/* PCMIF SPI */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA3_4CH), .driver_data =
=3D 4 },		/* FPGA */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_DMA4_12CH), .driver_data=
 =3D 12 },	/* I2S */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA1_4CH), .driver_data =
=3D 4 },		/* UART */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA2_4CH), .driver_data =
=3D 4 },		/* Video SPI */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA3_4CH), .driver_data =
=3D 4 },		/* Security */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_DMA4_4CH), .driver_data =
=3D 4 },		/* FPGA */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA1_8CH), .driver_data =
=3D 8 },		/* UART */
> > > > +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_DMA2_4CH), .driver_data =
=3D 4 },		/* SPI */
> > > > +	{ },
> > > >  };
> > >=20
> > > Use PCI_DEVICE_DATA() instead. Same may apply to DesignWare, but one =
needs to
> > > define the device IDs. I think I may help with that.
> >=20
> > I'm not a fan of PCI_DEVICE_DATA. While it could indeed be used to
> > shorten the assignments here, it's less readable in my opinion.
>=20
> I'm not fun of these long unreadable lines with tons of repetitions :-)

Seems to be subjective.

> > Compare
> >=20
> > 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH), .driver_data =
=3D 4 },
> >=20
> > with
> >=20
> > 	{ PCI_DEVICE_DATA(INTEL, PCI_DEVICE_ID_EG20T_PCH_DMA_4CH, 4) },
>=20
> First of all, with
>=20
> 	{ PCI_DEVICE_DATA(INTEL, EG20T_PCH_DMA_4CH, 4) },

Agreed. That doesn't considerably weaken my reasoning however.

> > . For someone who doesn't know what PCI_DEVICE_DATA does, the latter is
> > less understandable.
>=20
> Same applicable to many other macros. I don't consider this argument viab=
le.

Also agreed. But other bad macros don't justify using that (admittedly
subjectively) bad PCI_DEVICE_DATA macro that mixes device identity
(.vendor, .device, .subvendor and .subdevice) with a driver specific
struct member.

> > Also PCI_DEVICE_DATA has a cast which is something I want to get rid of.
>=20
> Yes, and you will get rid of in one place instead of tons of them.

This would require another (subjectively bad) macro PCI_DEVICE_DATAPTR.
I think I let someone else tackle that quest.

Best regards
Uwe

--h7rxs4abwv7pbrlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn4y5gACgkQj4D7WH0S
/k5j4gf7BzClYF7Qm/3avNqi1xld/TXdXt/woPDF/ZNusHkkGtBxNv2j7sUc14Ot
FUrhi4CbqErQIHIrykpwygL1qxm09eb6AVSh7JCreGwu7bwoJEzY/2RqkCuW6D2U
lS3ED8xga/xuLEVbqw2QowWU2oEHna6xZMMGp0oHr0/yGE16WxogPT5KUUHeBeaE
szDnd4aoJHOOeKu9kWI7Yzp5TaOfHnL0hz5SIj9c/Lc7I1iOKGsAF1Tn0MWZJpNZ
lt/WkfCNHIXwcFY9Hqzi2NuFmdaodD45c0VE5enZ6KNIPw5JSS43EEMZZFHnd+4V
B+Lntso7Qdp6z95Pzo+aBBLzFZcnsg==
=TGo4
-----END PGP SIGNATURE-----

--h7rxs4abwv7pbrlb--

