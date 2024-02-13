Return-Path: <dmaengine+bounces-1011-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44850853A46
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 19:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52E11F24A48
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C210A37;
	Tue, 13 Feb 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7Z8QiWk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736110A1A;
	Tue, 13 Feb 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850326; cv=none; b=Qz6vWiJG2EpohNux3+vSl+/+BpSJ7RyJYUBD07wfBRUthiSWEejVgTmrvmTujmvaFBX5cg+1skd+zl5usqkwCj3rkhFRXgl4QRkWQA9+jbpVML2Lm13OJ12N4WJW51SXB3JSo44N0S/peQgbZFIbuG169sfZbPaTGfmMb20pTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850326; c=relaxed/simple;
	bh=xGBGp2KusBdHqpkbLi4LaLap+E1NX9EdzDd8gu2SmTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRF7N7EN1InWY38vKDYtlLKM4RHY4lQl2oRSBgiY1S1mIfZFVGG1svr3OfoyYvS98+hRymcesOgHzJoUWC23ckeNnzyxP8o++13tNZcnqzTfNHGKI3BOBJefzxLhrRTdYnaR8zFzUklSYrYRMx17gxeJ8fPX0Zg3tcrZjMzTmjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7Z8QiWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B245C433F1;
	Tue, 13 Feb 2024 18:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707850326;
	bh=xGBGp2KusBdHqpkbLi4LaLap+E1NX9EdzDd8gu2SmTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7Z8QiWk0+h2LOMo4nEXq0PRd3wd+/VTYxqc5/Ef7pM3yq3UC2DgGFntmINrSNDSG
	 M+PQq4HFiU4dUEm0wBQbCf+JHyjXc7wH3yAOkfIoKCQahUdTqvRLH8ke4G+7wvam16
	 1ahC4VQMc0/0TqzNuJ6u2nYylngS39s+2dxJCIafYz9Ch0neW8qalXPgAHg+xIP7BN
	 7duhEvOPlIEMDgGKF0KnqPjxZqgp87mtbGKA6fpMqURJ5QY7UQf8y+tHdr3HfThkRK
	 /C1F15CgY98ME9AO65lN8SPJEIDaYQW1JfhW8mrJ3XlftNWEyKwnvfYWvOChuH3XNp
	 Wo5Z89sqGlYYQ==
Date: Tue, 13 Feb 2024 18:52:01 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: dma: convert MediaTek High-Speed controller
 to the json-schema
Message-ID: <20240213-dandy-snowflake-1dabe0e88b3a@spud>
References: <20240213063919.20196-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qjC9HOLp6OBijnn1"
Content-Disposition: inline
In-Reply-To: <20240213063919.20196-1-zajec5@gmail.com>


--qjC9HOLp6OBijnn1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 07:39:19AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> +  "#dma-cells":
> +    description: Channel number

I think you can just remove this description if you end up doing a
resubmission for some reason, but this looks good to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--qjC9HOLp6OBijnn1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcu6UQAKCRB4tDGHoIJi
0qwfAQCsjz5wMsihMi/eDMkAKpOJlXsvSKeljSH3NgN3d+2jsgEA8lLln5Z/Wazx
tEcnartUmmlaaPue4Um+naT4WLBBvQU=
=4BX2
-----END PGP SIGNATURE-----

--qjC9HOLp6OBijnn1--

