Return-Path: <dmaengine+bounces-4619-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD224A4A140
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 19:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9340E3BC7DD
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52BC1EEE0;
	Fri, 28 Feb 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4WzT/G2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F51F4C97;
	Fri, 28 Feb 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766660; cv=none; b=Lc9ba+4J0uuwMfgfrA/sB9sPUK2HpEfDMpYvN1kjCDUfraXvcZkQqsH9LWNSzHaAfNE+MQr82t5uLDqkn+B5fdpA5Mtfz9V56FWhJEE7cz/F+DSFj0/NdnCSUATy49QAwfgEQJ76oPwRNH8ohXECsJs4jrz/pMazgAp2co7kvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766660; c=relaxed/simple;
	bh=a/UMFY3PmG/1uLNOqdYStwAd4uZGvoG8DB49sRcvT7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbCviRo5ANKGBA7P863P08Jpbf88m/UreoCbhWWHArGSyguKaxI3FH8+nj5u1NcLmMvrs2IZIdmq+ahfod6dmO5Gz0j+i7OIvewetONdTY7QOjXfGcae+zkXo926stoo1qv1IVu/iBiaig5+UjKaG9SD+1PMEm8mhvrmG0hb63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4WzT/G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2017CC4CED6;
	Fri, 28 Feb 2025 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740766659;
	bh=a/UMFY3PmG/1uLNOqdYStwAd4uZGvoG8DB49sRcvT7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4WzT/G2oAFp+dNhWfYKlm79abS+NcpyQZ6eqyRwjYZ4EPAb0WBkJoTAYhTfQXByR
	 y6rm7XHSuoIOh9RpAt4GyGZQ7SxOXAko6BPndWwD4CieeqLaSwomU4O9NsoQl8360l
	 0mdhllvDDzddzU881slMEqFz7HdCuxBV9y+NyuoSkW6fGKQeZd9sEK4zvtbRwTsW/t
	 d/wJK//J+vfSHdknARu+bnfB9jrrTh/0ZJejmCmWWXixeXO1pizGB+VDSEnnfz7I5x
	 6HCMJuBpkd6gnm4BrtWF1NilRbb3MuEHHPkBya05AV0BdMIdrmUHtWD+eS1eha53t2
	 1qtZwd/tajQUw==
Date: Fri, 28 Feb 2025 18:17:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, wim@linux-watchdog.org,
	linux@roeck-us.net, vkoul@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: sama5d4-wdt: Add
 sama7d65-wdt
Message-ID: <20250228-quaking-yoga-3ca96e2bd3c6@spud>
References: <cover.1740675317.git.Ryan.Wanner@microchip.com>
 <15d6f901e64dd36d25a62e27601252c59708275a.1740675317.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OwNJr0RVbE/sS7Fv"
Content-Disposition: inline
In-Reply-To: <15d6f901e64dd36d25a62e27601252c59708275a.1740675317.git.Ryan.Wanner@microchip.com>


--OwNJr0RVbE/sS7Fv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 08:24:10AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>=20
> Add microchip,sama7d65-wdt compatible string to the dt-binding documentat=
ion.
>=20
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--OwNJr0RVbE/sS7Fv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8H9vgAKCRB4tDGHoIJi
0lJcAP9u9Uvx/4C75KIMdUEVO/h+wPDo8Rq2c+a08bA/fz8CEAEAl7uhrUKbEPRt
rrGARi737735dX3i+yX85Af/e9nLrQI=
=P3hd
-----END PGP SIGNATURE-----

--OwNJr0RVbE/sS7Fv--

