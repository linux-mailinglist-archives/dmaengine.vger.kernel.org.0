Return-Path: <dmaengine+bounces-2819-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F694AECA
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 19:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6BD281315
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BADD13C8F0;
	Wed,  7 Aug 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdK4Icsv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439156BB4B;
	Wed,  7 Aug 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051385; cv=none; b=MXVjtGuZpi8hyT35dK2yeVBIggNepsVj0Eg8D/rFq4h1g3y3Y+iux3+eVdQha01ZPDlt3BhhxZvyvvu2eghCMSB1CEe287oF6ITkEmd1+3Kknrv8xYllIs6Efru0Xko39O1xkCUyxsKaX2rWGzZpqo/GnEGah5w222tW4tcpUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051385; c=relaxed/simple;
	bh=RJ0Zesv/SIpAdtJA0TFDSMko+4aT6tcCI2CctQwQIA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK01dKyrK06q2GzLHhP/6GUM/hZeckjd3Aj3AI9hZLlpB4HLYF85D++lPvCsEyaXV5ZZkTJw3wHQE8m+l5JM+BLhvwGgPNWeW+lE46IMkzv7bTfi2jk1e/yVazkg3zEwLkymar4KaI1o30pgjbBgsbbnc7wBLGhNRhTJMaVnEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdK4Icsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2CFC32781;
	Wed,  7 Aug 2024 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723051384;
	bh=RJ0Zesv/SIpAdtJA0TFDSMko+4aT6tcCI2CctQwQIA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdK4Icsv2/2pnfXPRi1T3yBDcNOiabPvr5WokVHvCdoqS6nCq73JdsLEvTRgL1aAI
	 GWxGqe3+fIRU8uC13nCYvzw2VKmfHogNMTU8pMRA38o610pU7KFRgQo0oPIoM6PzqN
	 Mw5k2ldGWuX6B7npIrzFL2lSsmVH9K05VHw7ZxeNY5Zf19UtO0WzloW0rAr9ysD4qN
	 6bb7RuKDdsEIqrQjLJUJZJ27smOlm9oplH6RTc2luKqLfBpFeopQ8MWOjzi4L+WxnH
	 +vHt84sq1VwEB9isOjRj9tNGMKinvMFvWEtw+mg5wd+BoYyqTYNuOXrY4maNeDMvFx
	 horuo+dXHiZzw==
Date: Wed, 7 Aug 2024 18:23:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2] dt-bindings: dma: fsl,imx-dma: Document the DMA clocks
Message-ID: <20240807-naming-sanction-b51edd2b7276@spud>
References: <20240807170517.64290-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IyEKhwbgMkTOPuJj"
Content-Disposition: inline
In-Reply-To: <20240807170517.64290-1-festevam@gmail.com>


--IyEKhwbgMkTOPuJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 02:05:17PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> Document the IPG and AHB clocks that are needed by the DMA hardware
> as required properties.
>=20
> It is not possible to have DMA functional without the DMA clocks
> being turned on.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Mark clock and clock-names as required properties (Conor).

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--IyEKhwbgMkTOPuJj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrOtdAAKCRB4tDGHoIJi
0g/gAQDJoQgydMhC3VsKgN+tXVmmO2AchAXP6z6Yhfoh/AFcPQD/V88+3Unydlmx
i/cTg2OwxvJsi+6Et6IMv03y5Qp0jgM=
=UAVL
-----END PGP SIGNATURE-----

--IyEKhwbgMkTOPuJj--

