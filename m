Return-Path: <dmaengine+bounces-10264-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG3vDe2U/Gn3RQAAu9opvQ
	(envelope-from <dmaengine+bounces-10264-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 15:34:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 936434E950E
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5561D3036D51
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2127C3939C8;
	Thu,  7 May 2026 13:31:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F233F5AB
	for <dmaengine@vger.kernel.org>; Thu,  7 May 2026 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160668; cv=none; b=Ou+0IjXEKVkw721/eJabrQLPURhFpF/e0YtjhDL1JU6sLSG84OC1YkZLCwrFixC2fGL5eMZxuxiFBYDF8sZ5ewUup0wEa8ExJoSerSHx3LiKayYLH5auFaBMxf8/j7hEsVW+IPPXBT7MZ2y3wrgHVwGnNc++kY6YZGGRtxs9yH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160668; c=relaxed/simple;
	bh=0r6hk/aWmDACR5dNtufyI9Sz3ggteObbzx6/5TofXE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDJRs4v4I9xiWYI+s4gCxxCLbBHQGUCSdFT1sW2MtcDWmbwLmhix8orY/w2SH6gh52lcT2i/HS3omNFn7GB8wwx1ADB64JoBCEadW1YeYBf0TV7gCB8XE2WZGKgAErHw+RxFtuLQPtIuVN74w2mH0DJ39QGzQ5hUU8yh5TzzgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKyoT-0007GM-N6; Thu, 07 May 2026 15:30:49 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKyoS-000viD-1I;
	Thu, 07 May 2026 15:30:48 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8C2725305FF;
	Thu, 07 May 2026 13:30:48 +0000 (UTC)
Date: Thu, 7 May 2026 15:30:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Greg Ungerer <gerg@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	arnd@kernel.org, Greg Ungerer <gerg@linux-m68k.org>, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com, 
	adureghello@baylibre.com
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
Message-ID: <20260507-masterful-pegasus-of-science-c408e0-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wannj6m2lemejz2p"
Content-Disposition: inline
In-Reply-To: <20260506142644.3234270-8-gerg@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Rspamd-Queue-Id: 936434E950E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,kernel.org,linux-m68k.org,gmail.com,baylibre.com];
	TAGGED_FROM(0.00)[bounces-10264-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,pengutronix.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--wannj6m2lemejz2p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
MIME-Version: 1.0

On 07.05.2026 00:26:48, Greg Ungerer wrote:
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503f..a682f02d2c43 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -296,6 +296,7 @@ static_assert(sizeof(struct flexcan_regs) =3D=3D  0x4=
 * 18 + 0xfb8);
>  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_BROKEN_PERR_STATE |

Nitpick:
Can you move it here, so that the quirks stay sorted?

		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |

>  		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
> +		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
>  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
>  		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
>  };

With that change:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for drivers/net/can/flex=
can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wannj6m2lemejz2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafyUBQAKCRDMOmT6rpmt
0h1/AQD8fPQ9qBfBV4KsyZ2O2YslluG3RnplOxiorG4vbWXGngD/dQ7s6kWp1KKP
rLIS55PAZs60zOx+c7AxCJhLScFIvAw=
=fD+P
-----END PGP SIGNATURE-----

--wannj6m2lemejz2p--

