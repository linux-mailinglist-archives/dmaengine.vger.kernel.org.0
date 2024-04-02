Return-Path: <dmaengine+bounces-1713-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF6895BB2
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 20:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F8D1C21F22
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D9415AD9C;
	Tue,  2 Apr 2024 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk56H94v"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03915AD8A;
	Tue,  2 Apr 2024 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082329; cv=none; b=Ke/EmT19uE1nLcUiZA0X5iG+3YFhligOZdCj5n+76kYGJEaVC1a9XlAw2F1WNqdwNVbXdO84xs/eO+ZgzpPU+Rz9BEKryqd+1HUn5kTKaEZF9prVV85tAiHs820FZzBHFxl0gMfbh5jAV8Es5hevNd3MV6njldS0iVPCQf6Xz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082329; c=relaxed/simple;
	bh=The4umGKdB9OwhPGKIOCmIqrrOH/yzgx5az+WIgTM3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJB52xCvAJVdhs0hGKVbzkKVT0LaHoeiJsFyb3fhigTzT3Z2vyIBGwSYLbsi8B0bcwGEk2EOSadppX2JtnRDtLezga/Ezx1QJ5JksevC+8fQDccvx5+QB3Qwq0PJp62LFBpbv5mAw+q3QiaTWfolzsoCYZQehbXn2zaa7kb0X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk56H94v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67F9C433F1;
	Tue,  2 Apr 2024 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082328;
	bh=The4umGKdB9OwhPGKIOCmIqrrOH/yzgx5az+WIgTM3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uk56H94vCD8JGEyls6aZb4TXIkixCoZzeoUx1tbn8ew7Gb7wP2VRYJshPbsHYD1Pv
	 eD6zetOePJNQvYA57Xh8OzkChCoVmGED5Te8ViJzy2Q7ai4tiTsNH4gVdbicV3DkRQ
	 xNfe5MCHF0Ne/1gum+Eu1bqa4KBNfzcz/IkvpDow1I+8NLJV9QFUDD6mO3eCAx6fQB
	 +Y01yyA8ZAZ6xCqZi+3A57uusY3h5Lf2JWMMrzJ1up+nQexffwqHQVB4MaqtmlpF5b
	 j3TdopkbJxFjZ+5oF9JFCTQCsXVu4FiMYq6x6fOso/ExkgfXGZM5FYGM1Pbc3avge+
	 qYjdCNI0F/o3g==
Date: Tue, 2 Apr 2024 19:25:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: dma: snps,dma-spear1340: Fix
 data{-,_}width schema
Message-ID: <20240402-thermos-sedation-f7f3d19f6116@spud>
References: <20240401204354.1691845-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sjRbJLa+HB006QRg"
Content-Disposition: inline
In-Reply-To: <20240401204354.1691845-1-robh@kernel.org>


--sjRbJLa+HB006QRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 03:43:53PM -0500, Rob Herring wrote:
> 'data-width' and 'data_width' properties are defined as arrays, but the
> schema is defined as a matrix. That works currently since everything gets
> decoded in to matrices, but that is internal to dtschema and could change.
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--sjRbJLa+HB006QRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxNkwAKCRB4tDGHoIJi
0pAWAQDMzaD2qxka/pspIT5VYcEnSM1SVV+1l03/he0Tmnuj2gD1Ez3COkr0WOlH
dIRD54gOwFe1rIRChyrdriapo9rEBw==
=cQhE
-----END PGP SIGNATURE-----

--sjRbJLa+HB006QRg--

