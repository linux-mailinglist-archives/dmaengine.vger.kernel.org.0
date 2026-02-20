Return-Path: <dmaengine+bounces-8999-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCNkAsLfmGlkNwMAu9opvQ
	(envelope-from <dmaengine+bounces-8999-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 23:27:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207116B2D8
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 23:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A1703027E38
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD33101BD;
	Fri, 20 Feb 2026 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQCYEsDd"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA231064A;
	Fri, 20 Feb 2026 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626417; cv=none; b=nAawHVK4mNHEQSlfSEyWvl7cHEQL6QI3JiqMeJ8RZrRI7SbM8e1O+4SfP+sTQUMechK0DMsMUDIgeCIbIhpISSMA5GrSEAY8hQDfJ+5y8KLazSNGONSFFWekhLKpnZXlLJSv6LaYZ87jtKZtKCTiSSX7e7EmAUKfj7q74qlDC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626417; c=relaxed/simple;
	bh=V3OWm83najdWDMMrySIRsb/XPcxnbfexYIsnMcMRUO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWTOnoKVsWT9EwGB+wWQpR2DoXSLAiak7sUE+CGsF8JUAnVS/2FSz/0kisRHL7Yy6vx1bE+1H/+8PkPzV+8mpb1uEqQ9nKfAJwglYuiVcGSFtVXxQaeP2X7zHpFLr+QwOr687RtueNE8/UG34k3JI1z2W1z6J/wM/JXOi1aNQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQCYEsDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C14FC19423;
	Fri, 20 Feb 2026 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771626413;
	bh=V3OWm83najdWDMMrySIRsb/XPcxnbfexYIsnMcMRUO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQCYEsDdoHIq3L4PuaJ3kgONXH0doh6BMxww+xY2Rsjw01KmxOdddhPxFWbLRhLIp
	 fpqgtQpHnET4LqokAL5+iU67DYcfuJDT3FXtL3Eo5zwAbN0IwwNWRUI6asCsubQvNU
	 6mUQy4I+Fq4uIFLXmmGboFpHvW9rSkOtFa0Cxr+5G8iVCFV5bjZmgQ0y5u7wof+HyY
	 +fFDHRbsYGOsJiVzfE7/7eeK2DWVq6WA9Ju2Wx6/vqw9Om4kq4BkIi2bTJA/CBU1wE
	 kUU7eh9AeKeAzlJvzZoLdicHpwglrVvgLojkcjs1JAAXbMkvDOxTlnzn5kl0nYIzHM
	 DvDhFKm0sEFrg==
Date: Fri, 20 Feb 2026 22:26:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Max Hsu <max.hsu@sifive.com>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Green Wan <green.wan@sifive.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Debbelt <palmer@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dmaengine: sf-pdma: add missing PDMA base offset to
 register calculations
Message-ID: <20260220-embargo-fretful-2db21a5c3c3c@spud>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
 <20260221-pdma-v1-1-838d929c2326@sifive.com>
 <aZi_xAe8o1dNTz3t@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SIz7zDW2+qG1pVVX"
Content-Disposition: inline
In-Reply-To: <aZi_xAe8o1dNTz3t@lizhi-Precision-Tower-5810>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8999-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sifive.com:url,sifive.com:email,0.45.198.192:email]
X-Rspamd-Queue-Id: 9207116B2D8
X-Rspamd-Action: no action


--SIz7zDW2+qG1pVVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 03:10:44PM -0500, Frank Li wrote:
> On Sat, Feb 21, 2026 at 03:43:53AM +0800, Max Hsu wrote:
> > The PDMA control registers start at offset 0x80000 from the PDMA base
> > address, according to the FU540-C000 v1p1 manual [1].
> >
> > The current SF_PDMA_REG_BASE macro is missing this offset:
> >     Current:  pdma->membase + (PDMA_CHAN_OFFSET * ch)
> >     Correct:  pdma->membase + 0x80000 + (PDMA_CHAN_OFFSET * ch)
>=20
> How it work at previous version? suppose it is tested when upstream this
> driver?

Yeah, it's been tested alright. I'm pretty sceptical about this patch
being correct even if it does match the documentation as both mpfs and
the fu540 have dt nodes that look like:
		dma: dma-controller@3000000 {
			compatible =3D "sifive,fu540-c000-pdma", "sifive,pdma0";
			reg =3D <0x0 0x3000000 0x0 0x8000>;
			interrupt-parent =3D <&plic0>;
			interrupts =3D <23>, <24>, <25>, <26>, <27>, <28>, <29>,
				     <30>;
			dma-channels =3D <4>;
			#dma-cells =3D <1>;
		};
and on at least mpfs the pdma works. In fact, adding 0x8_0000 to membase
would lead to accessing outside of the reg region described by the
property.
The docs for PolarFire SoC (that's mpfs) don't mention this 0x80000
offset - see 3.1.10.1 of https://ww1.microchip.com/downloads/aemDocuments/d=
ocuments/FPGA/ProductDocuments/ReferenceManuals/PolarFire_SoC_FPGA_MSS_Tech=
nical_Reference_Manual_VC.pdf

On the fu540 it may actually not work, I don't know as I have never
tried, but that's what the driver was originally written for. Given that
mpfs has the exact same setup I suspect it does work though...

The 0x8_0000 offset is very weird though, why offset like that and what's
in that region? The original documentation for the fu540 also doesn't
have the offset in it: https://pdos.csail.mit.edu/6.828/2025/readings/FU540=
-C000-v1.0.pdf
Why did this get changed? Should we also have changed this in our
documentation for mpfs and there are actually two interfaces for this IP
block, with the higher address being preferred?

Making this change blindly will break existing devicetrees, so it cannot
go in in this form.

If the fu740 requires this, then add a fu740 compatible and make this
offset fu740 specific. If it actually works with the current driver, I
vote for leaving this as-is with a comment explaining how it works.
For the fu540, could you test if the current driver and dts work? If
they don't, then we can consider more invasive changes.

mpfs works (and matches our docs), so I don't think we should make any
changes that affect it unless you can provide me with an explanation for
why the fu540 docs changed etc.

Cheers,
Conor.

>=20
> >
> > Fix by adding PDMA_BASE_OFFSET (0x80000) to the register address
> > calculation.
> >
> > Link: https://www.sifive.com/document-file/freedom-u540-c000-manual [1]
> > Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for =
HiFive Unleashed A00")
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  drivers/dma/sf-pdma/sf-pdma.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdm=
a.h
> > index 215e07183d7e..d33551eb2ee8 100644
> > --- a/drivers/dma/sf-pdma/sf-pdma.h
> > +++ b/drivers/dma/sf-pdma/sf-pdma.h
> > @@ -24,7 +24,7 @@
> >
> >  #define PDMA_MAX_NR_CH					4
> >
> > -#define PDMA_BASE_ADDR					0x3000000
>=20
> This change belong to cleanup, don't mix to fixes into fix patch.
>=20
> > +#define PDMA_BASE_OFFSET				0x80000
> >  #define PDMA_CHAN_OFFSET				0x1000
> >
> >  /* Register Offset */
> > @@ -54,7 +54,7 @@
> >  /* Error Recovery */
> >  #define MAX_RETRY					1
> >
> > -#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)=
))
> > +#define SF_PDMA_REG_BASE(ch)	(pdma->membase + PDMA_BASE_OFFSET + (PDMA=
_CHAN_OFFSET * (ch)))
>=20
> why not set membase to pdma->membase + PDMA_BASE_OFFSET directly? are the=
re
> registers between pdma->membase and pdma->membase + PDMA_BASE_OFFSET?
>=20
> Frank
>=20
> >
> >  struct pdma_regs {
> >  	/* read-write regs */
> >
> > --
> > 2.43.0
> >

--SIz7zDW2+qG1pVVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZjfpwAKCRB4tDGHoIJi
0jvHAQCh9xJEloyQ+M/OvhjpKjpXhZ0kah1uvtI2tyiD6+enVwEA0HuwetJ+1Cs6
6tfRZ0V8UH+Iz2B9qASmL3OATkx6FQw=
=C1Jl
-----END PGP SIGNATURE-----

--SIz7zDW2+qG1pVVX--

