Return-Path: <dmaengine+bounces-3194-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429A97D306
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 10:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E3AB21473
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC57FBA2;
	Fri, 20 Sep 2024 08:53:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailfilter02-out21.webhostingserver.nl (mailfilter02-out21.webhostingserver.nl [141.138.168.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14892B9BC
	for <dmaengine@vger.kernel.org>; Fri, 20 Sep 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=141.138.168.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822411; cv=pass; b=NTlfA+y8aDNjT3yGkRbr0lP4dG1+/RUwXl9fIHRSehr/nt8fvFsbawtHqpqo22OlPvMJYjuVgsVRvU42BOqJXQItICB0Eij5hjFkadOJrJwLHlYn/WoWZF3EAeQcL0J4SbdqBZXtY2UFbGz5mSBipU8R25QlakVYF1G7wZF9r+g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822411; c=relaxed/simple;
	bh=aWE098Eh+hKoVJ1x4B7cc4FweM0bu5M/qDTQ3MebZVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NepLDD+yxHa45mzliWiH5ErHCaWf9xi+ZvUKJpKYaDKnIz0f0ilPFtEdFAJIq5O1GkJmnVhuj2jsiW6HNzdvV5blkQgolctVIVmVWgufRdKy+urJxNmgEeSMTF4vo4W4wFnwJe6zIAq4VCipgQAr4XBgnajfOEzdDJHPiWwPVwg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=141.138.168.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1726822333; cv=pass;
	d=webhostingserver.nl; s=whs1;
	b=jTSqi77J5tdx2uMLZ5XrUhc+JeGcQ+5lGpQ5xzoL3ucVji5YDoYDjUaY/xAGvAm/8GayDIy8V98r7
	 zwL9Ax2sK8JDp14H6TaixMR9OoGqcHlMiZL9TpdrOegwfuJoQUYqUx37mqTNzHxeG8FsRqjJBeOgPv
	 jXd781drOWq6P+pC0J7rKXoeutl43DyYf9w0GKfyTcjpjQ+a4lTDkUCch7A5Slhj1KMytw3MP7mA+F
	 wKQQ8goPEF7imNjlT8LBCaOpSaejOOUrnEcNmcQFHZTlqHlulFgx39kLwys9yGJpSbncEutglTBsCB
	 6dBBuY6S5DD9W0l561cWgXpFhXytmIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
	d=webhostingserver.nl; s=whs1;
	h=content-type:mime-version:references:in-reply-to:message-id:date:subject:cc:
	 to:from:from;
	bh=1jspWOWybiap7NHajr/2gavctJVMXp/EyJLgmVHcn5U=;
	b=FMXSPdqsF1yIWW2o3n55iVY3fHyLnnhYTtEazrQAFTOgc8dPqrMYAq6TnD6TJPVSEs+PRSHNb5zSF
	 ko1VX0iZrE2q2nYPmmMX7xSGvnf6k+6O6q4eTo/GwPJj/8vfSE6sBevLZYxtlfmX2icCyW8Z3Mcmc3
	 JSatwzXTYSuHNoW8NzaeBB7fP4TnGDaJAVBxgPKA3AA5vEmxG03yW1ggYsGJZXhmBk3lXFWAoCWox7
	 MKaeCxZiQYxZhBk/JT9PbzFE1TP4TbfF+oy+1MDnZr8k+UwgcPPXQ3N4i/M3W1GxRLjUoShXjFUanR
	 I5xOFvdBJADvdBwTPVIuO7h+aM2YShQ==
ARC-Authentication-Results: i=2; mailfilter02.webhostingserver.nl;
	spf=softfail smtp.mailfrom=gmail.com smtp.remote-ip=141.138.168.154;
	dmarc=fail header.from=gmail.com;
	arc=pass header.oldest-pass=0;
X-Halon-ID: a060b686-772d-11ef-b705-001a4a4cb922
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
	by mailfilter02.webhostingserver.nl (Halon) with ESMTPSA
	id a060b686-772d-11ef-b705-001a4a4cb922;
	Fri, 20 Sep 2024 10:52:12 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=webhostingserver.nl; s=whs1; t=1726822338;
	 b=iVXUWHt+iFGLvBFJttO9IerVYAbSgtOH+q2DCI+q3FNFiO2C0P0isu0+z0MqmZSwO0ariKlSrh
	  qbtCQeSgKYgO/tYH/b7PLfSMWimzw3DkShX4QBQFdLubWG++Ya0rZIqmAucn/Ro58EjVK945ki
	  IRS1Ih117NX57350n+UM63n7gu93mpTfMkwfpBC4R/UVqHV52EMD7R2xLA7yiIlRU6Lmeokb3p
	  Brhf5FvJ0sHvVqTZW6czNGa5BkMxipZi9ZUrZOEjGFsNhwm0u0JnmZSUlBtGolGwkiTHQxhfdx
	  GOAtahnwhFDKQLMplAebz94ZPUfzCJ3L/5eNq4+90BFtRQ==;
ARC-Authentication-Results: i=1; webhostingserver.nl; smtp.remote-ip=178.250.146.69;
	iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=gmail.com;
	dmarc=skipped header.from=gmail.com;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=webhostingserver.nl; s=whs1; t=1726822338;
	bh=aWE098Eh+hKoVJ1x4B7cc4FweM0bu5M/qDTQ3MebZVM=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	  To:From;
	b=w0Tni9uJKRBvosbIv6XePlr0noqxZcfc/DPZQZZxw62MoXTLVWWYewAoU2H6zyZnawKvhqYjAD
	  tDC45GAkpFcR7jWmHtTRZTHDc2xwmDwnuzeatTdVrMEBF8Vl8vL1e88NuWDjql9nONqFhrCv0K
	  SDfL0Pbed77qrS3dowlq1w+xpbUvCE8WFPmyJvG0K/LxZIfBNZ1zxCFM3lX0VrI+CikqJ3jy2Y
	  iVr5XKrA7tuojNjhR4dKyyhpajEvdfvh+1KeLCCD3uugVnTzjtR2LMIpVhkThr1D6FbzB5aKVq
	  SapAx4Yi6j75yOpabMoWoGE7i3ugEprmkmZeixPUoOOtqQ==;
Authentication-Results: webhostingserver.nl;
	iprev=pass (cust-178-250-146-69.breedbanddelft.nl) smtp.remote-ip=178.250.146.69;
	auth=pass (PLAIN) smtp.auth=ferry.toth@elsinga.info;
	spf=softfail smtp.mailfrom=gmail.com;
	dmarc=skipped header.from=gmail.com;
	arc=none
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=smtp)
	by s198.webhostingserver.nl with esmtpa (Exim 4.98)
	(envelope-from <fntoth@gmail.com>)
	id 1srZNC-0000000ATGh-39pO;
	Fri, 20 Sep 2024 10:52:18 +0200
From: Ferry Toth <fntoth@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH v2] dmaengine: dw: Select only supported masters for ACPI devices
Date: Fri, 20 Sep 2024 10:52:18 +0200
Message-ID: <2627811.Lt9SDvczpP@ferry-quad>
In-Reply-To: <ZuyEQOIztvUrO0gO@smile.fi.intel.com>
References:
 <20240919135854.16124-1-fancer.lancer@gmail.com>
 <20240919185151.7331-1-fancer.lancer@gmail.com>
 <ZuyEQOIztvUrO0gO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2210023.Mh6RI2rZIc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-ACL-Warn: Sender domain ( gmail.com ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info ).
X-ACL-Warn: From-header domain ( gmail.com} ) must match your domain name used in authenticated email user ( ferry.toth@elsinga.info )
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

--nextPart2210023.Mh6RI2rZIc
Content-Type: multipart/alternative; boundary="nextPart4379146.ejJDZkT8p0";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Ferry Toth <fntoth@gmail.com>
Date: Fri, 20 Sep 2024 10:52:18 +0200
Message-ID: <2627811.Lt9SDvczpP@ferry-quad>
In-Reply-To: <ZuyEQOIztvUrO0gO@smile.fi.intel.com>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart4379146.ejJDZkT8p0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi,

Op donderdag 19 september 2024 22:06:24 CEST schreef Andy Shevchenko:
> On Thu, Sep 19, 2024 at 09:51:48PM +0300, Serge Semin wrote:
> > The recently submitted fix-commit revealed a problem in the iDMA32
> > platform code. Even though the controller supported only a single master
> > the dw_dma_acpi_filter() method hard-coded two master interfaces with I=
Ds
> > 0 and 1. As a result the sanity check implemented in the commit
> > b336268dde75 ("dmaengine: dw: Add peripheral bus width verification") g=
ot
> > incorrect interface data width and thus prevented the client drivers
> > from configuring the DMA-channel with the EINVAL error returned. E.g. t=
he
> > next error was printed for the PXA2xx SPI controller driver trying to
> > configure the requested channels:
> >=20
> > > [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> > > [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX desc=
riptor
> > > [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
> >=20
> > The problem would have been spotted much earlier if the iDMA32 controll=
er
> > supported more than one master interfaces. But since it supports just a
> > single master and the iDMA32-specific code just ignores the master IDs =
in
> > the CTLLO preparation method, the issue has been gone unnoticed so far.
> >=20
> > Fix the problem by specifying a single master ID for both memory and
> > peripheral devices on the ACPI-based platforms if there is only one mas=
ter
> > available on the controller. Thus the issue noticed for the iDMA32
> > controllers will be eliminated and the ACPI-probed DW DMA controllers w=
ill
> > be configured with the correct master ID by default.
>=20
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Seems this fixes the bug I have seen.
> Ferry, can you confirm?
I was testing something else and broke my setup :-(  I=E2=80=99ll fix that =
and test this patch this weekend.




--nextPart4379146.ejJDZkT8p0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<html>
<head>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8">
</head>
<body><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Hi,</p>
<br /><p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0=
;">Op donderdag 19 september 2024 22:06:24 CEST schreef Andy Shevchenko:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; On Thu, Sep 19, 2024 at 09:51:48PM +0300, Serge Semin wrote:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; The recently submitted fix-commit revealed a problem in the iDMA32</=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; platform code. Even though the controller supported only a single ma=
ster</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; the dw_dma_acpi_filter() method hard-coded two master interfaces wit=
h IDs</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; 0 and 1. As a result the sanity check implemented in the commit</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; b336268dde75 (&quot;dmaengine: dw: Add peripheral bus width verifica=
tion&quot;) got</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; incorrect interface data width and thus prevented the client drivers=
</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; from configuring the DMA-channel with the EINVAL error returned. E.g=
=2E the</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; next error was printed for the PXA2xx SPI controller driver trying t=
o</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; configure the requested channels:</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; &gt; [&nbsp; 164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave conf=
ig failed</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; &gt; [&nbsp; 164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get =
DMA TX descriptor</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; &gt; [&nbsp; 164.543213] spidev spi-SPT0001:00: SPI transfer failed:=
 -16</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; The problem would have been spotted much earlier if the iDMA32 contr=
oller</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; supported more than one master interfaces. But since it supports jus=
t a</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; single master and the iDMA32-specific code just ignores the master I=
Ds in</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; the CTLLO preparation method, the issue has been gone unnoticed so f=
ar.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; Fix the problem by specifying a single master ID for both memory and=
</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; peripheral devices on the ACPI-based platforms if there is only one =
master</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; available on the controller. Thus the issue noticed for the iDMA32</=
p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; controllers will be eliminated and the ACPI-probed DW DMA controller=
s will</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; &gt; be configured with the correct master ID by default.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; </p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Tested-by: Andy Shevchenko &lt;andriy.shevchenko@linux.intel.com&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Seems this fixes the bug I have seen.</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt=
; Ferry, can you confirm?</p>
<p style=3D"margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I w=
as testing something else and broke my setup :-(&nbsp; I=E2=80=99ll fix tha=
t and test this patch this weekend.</p>
<br /><br /><br /></body>
</html>
--nextPart4379146.ejJDZkT8p0--

--nextPart2210023.Mh6RI2rZIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEqR7zuEuxfQFO1Tt5OB30JY3rOi0FAmbtN8IACgkQOB30JY3r
Oi3CSgf/WUaXPJIZCCq3g+7MCEgr2r3JyOEWbBfReYAe3gHeff2OBf1/W+tRiVhB
knThJaD7vXiHzZ5USwUU5JB86pFmNFmNf+H4KNmszAohnpc2zXDOmNobBmYb2qDd
kQcdmHJ2h0oGzs6bWZQseNjg+MIRUhj6tf6r1+vzDjAQgXqMt22hUa2UfmJOuT6V
syQHtEi1IuHEnzerIkeppCDcJqJ6Y4gvcRQzmTmMXc6GXJKZs2IPzoWGkZvXeUrf
Oq1D/83Xvra1kuo93c2o7urYHRf3TQHwVvgz/HgDiQ5hhdROmU2lnoX8dW6jGv5V
fOOkWL8f8DJBGYvCGDnYybGcie8gIw==
=KL4q
-----END PGP SIGNATURE-----

--nextPart2210023.Mh6RI2rZIc--




