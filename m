Return-Path: <dmaengine+bounces-10114-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCahF6il62mrPwAAu9opvQ
	(envelope-from <dmaengine+bounces-10114-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:17:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A7461C68
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D165E3057604
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AA33F5B6;
	Fri, 24 Apr 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpugPL49"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219033F5A5;
	Fri, 24 Apr 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050235; cv=none; b=aQkH9qSNTyX1UIAcoO9Uw9Mzbl2DKS/+PN/Ko2wwSaDSZAJBUqRoLBqJV+YNGNkSN8Kv1tnFuWUju3Ez4t253dmU7P7cE5W0hueEwLxizPOkmyJM16xrR1DfYQdeTsMUqwZZaoL+PV0asUayqsThCSTtMSA8a6u7b6LumVTVgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050235; c=relaxed/simple;
	bh=vpzvilq6KjAFWPzsZTe/h1k59Km6tBvjeHIMJU1XgVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaZT7ekBetI1ZIV6YtHml/fC7DTBlBiIW6oxRr1do3G+houJQj4ZFH+t7d+3as4RSqRjOs0RvciPIyroCJS4wkw5ILepWoOdnFVuleC1+k8Jsdc/3bxaeFedu7rQlN4SENHkl5PgI82IkW4lAK4TF9nW/5CWumMlaQSI5aoCaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpugPL49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBB8C19425;
	Fri, 24 Apr 2026 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050235;
	bh=vpzvilq6KjAFWPzsZTe/h1k59Km6tBvjeHIMJU1XgVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpugPL49eT4rknt5I79qcZe3fYCzBUMSyILi/UbhYrpOpoDXJilS3IwNftdeMohl0
	 r2v1HMKoXASRE/RWS1+TEW2XtBCaGY5Zddy1REBKsHeDsEzlPyFt4njYIAUJZC7/pI
	 YlZ08TtSOsv1pN2mhbws/nv6oP28HANjH8LIatOLOnzUBBbmXwr9CLTEQYNDM6izek
	 Bv0F1uJ3sUqnvIEq8bQVdJ7A88BNJOHIfkGxwge+/M2mPYOJu1+jmUF5X5yz335kIi
	 cw1ei+fsew6EHR/N/bKn6eD2ISFWlMJkMTYjRjAAVef0+mnZRyiFe+h2gTv2mzCkxJ
	 7pC5x8SS72STA==
Date: Fri, 24 Apr 2026 18:03:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Guodong Xu <guodong@riscstar.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 compatible string
Message-ID: <20260424-collector-zone-26410e4707a7@spud>
References: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com>
 <20260424-k3-pdma-v3-1-efdf2e414a08@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJVvYi+3HKEojWVf"
Content-Disposition: inline
In-Reply-To: <20260424-k3-pdma-v3-1-efdf2e414a08@linux.spacemit.com>
X-Rspamd-Queue-Id: 0D4A7461C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10114-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]


--FJVvYi+3HKEojWVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 04:20:29PM +0800, Troy Mitchell wrote:
> From: Guodong Xu <guodong@riscstar.com>
>=20
> Add the "spacemit,k3-pdma" compatible string for the SpacemiT K3 SoC.
>=20
> While the K3 PDMA IP reuses most of the design found on the earlier
> K1 SoC, a new compatible string is required because the DRCMR
> (DMA Request/Command Register) base address for extended DMA request
> numbers (>=3D 64) differs from the K1 implementation.
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--FJVvYi+3HKEojWVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeuidQAKCRB4tDGHoIJi
0t/CAQCIAOQN4TYlpXK82vNLDwwODSFHT7GsOjh3smrUC7w+mwEA8RlB1ObCy1Og
Sg0d01zgcYTCnZq0zfzrc83Psv/L+w8=
=xIIX
-----END PGP SIGNATURE-----

--FJVvYi+3HKEojWVf--

