Return-Path: <dmaengine+bounces-9000-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MFKH2PgmGlkNwMAu9opvQ
	(envelope-from <dmaengine+bounces-9000-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 23:29:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80E16B384
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C92303C84D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61D83101BD;
	Fri, 20 Feb 2026 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LELsAyP5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2830F539;
	Fri, 20 Feb 2026 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626481; cv=none; b=t7Zg+UbylgQ4s6UwSMX1lLFAT2GapaFa4Ub1R89LA/Wimx5W6PX4qPULNjV1Ji1MW0Sm7gWU3bQykK9LOT8ge2JzNPFmSO5eouNgWSpqrYr1aAutBj4XMTAmJz+NSmBwmq5y4PsjpWjGUWBNKR1PJyPqpkULwCfRNtrzCTJ91tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626481; c=relaxed/simple;
	bh=wE0q/7dkOqR1gW9ECzxwZTApOZqI/Y970y7z51cz0x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRv/kQUW2/kYRAb3IQw9oMr6J26Dva/cK0+utDROP0n15mvV3kuP/n0CEybbHWzHUt00M4mzwnd8MDdi7Hvt/FpAWitHA9XaYKRYVJupkPa6r+iub+911JXvA75RezRqwZ4/wrr0aZn3sPL5XERzhdbcRukL8NmIzFTOFaLDvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LELsAyP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7266C116C6;
	Fri, 20 Feb 2026 22:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771626481;
	bh=wE0q/7dkOqR1gW9ECzxwZTApOZqI/Y970y7z51cz0x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LELsAyP5zFERbgoJyfb6/3Jspc2YS9em7Ak2InKMdysOGPKJefGB22bdtnX970DA5
	 I7wiFwsT/yPn2+cjNanoMfmHI5CeZpsE+emmQT/hKQlW7HOjUXpxYXBiLDcIdmRZe9
	 asbNdn2KS3dFWbEdXfRFor/DzIUqmCT7UNg0a3umGYM5YKmRFx6nf7I7Xd/AbLFqt8
	 nnfkPC99V7o5oZEdmELPMFjuyTW9hpALr5UBkFsoOX9L+G+7UISXPOQnP5O/CGX0xD
	 9pOMRZ13MxCWQa9uXpD1Lq26U6expXd9Xi3Efg1oefBLBWNd84vRwvX2zovvuWWNfP
	 n5pBfm5r1MVUA==
Date: Fri, 20 Feb 2026 22:27:55 +0000
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
Subject: Re: [PATCH 5/5] riscv: dts: sifive: fu740: add PDMA device node
Message-ID: <20260220-trilogy-passerby-fc792af8a00a@spud>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
 <20260221-pdma-v1-5-838d929c2326@sifive.com>
 <aZjEegxkIH3tqBo-@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fcTsCJeLa/9CujzX"
Content-Disposition: inline
In-Reply-To: <aZjEegxkIH3tqBo-@lizhi-Precision-Tower-5810>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9000-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:email,0.45.198.192:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,e00000000:email,0.153.128.224:email]
X-Rspamd-Queue-Id: CF80E16B384
X-Rspamd-Action: no action


--fcTsCJeLa/9CujzX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 03:30:50PM -0500, Frank Li wrote:
> On Sat, Feb 21, 2026 at 03:43:57AM +0800, Max Hsu wrote:
> > The FU740 SoC includes a 4-channel Platform DMA (PDMA) controller.
> > Add the device node to enable DMA support.
> >
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/bo=
ot/dts/sifive/fu740-c000.dtsi
> > index 6150f3397bff..30d0d6837c57 100644
> > --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> > @@ -329,6 +329,15 @@ gpio: gpio@10060000 {
> >  			clocks =3D <&prci FU740_PRCI_CLK_PCLK>;
> >  			status =3D "disabled";
> >  		};
> > +		dma: dma-controller@3000000 {
>=20
> not sure sifive, generally require orderby hex address, and need empty
> line between child node.

Correct on the ordering front, but the latter appears to be the style in
the file at the moment so I don't care about that.

>=20
> Frank
> > +			compatible =3D "sifive,fu740-c000-pdma", "sifive,pdma0";
> > +			reg =3D <0x0 0x3000000 0x0 0x100000>;
> > +			interrupt-parent =3D <&plic0>;
> > +			interrupts =3D <11>, <12>, <13>, <14>, <15>, <16>, <17>, <18>;
> > +			dma-channels =3D <4>;
> > +			clocks =3D <&prci FU740_PRCI_CLK_PCLK>;
> > +			#dma-cells =3D <1>;
> > +		};
> >  		pcie@e00000000 {
> >  			compatible =3D "sifive,fu740-pcie";
> >  			#address-cells =3D <3>;
> >
> > --
> > 2.43.0
> >

--fcTsCJeLa/9CujzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZjf6wAKCRB4tDGHoIJi
0lEjAQDjgGPf3wvEr+LErvWPWwlnhitG9RybYY14S/6K35R3+QD9Estycm/22oj6
3d+6HADdHDeuruwB3TxblckrVngfsQQ=
=FSgS
-----END PGP SIGNATURE-----

--fcTsCJeLa/9CujzX--

