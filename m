Return-Path: <dmaengine+bounces-1548-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B888D81B
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 08:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B91F23700
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF343250E0;
	Wed, 27 Mar 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkBIg02T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB3538A;
	Wed, 27 Mar 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526230; cv=none; b=Tq/P9ZamGTThFiF//GmvfHvwZTsOPLt+bWvMLQFASZjoPNQ6WFEruAIx+FtWvwBVduLjRY3l7gqBhK4ki+5EmdyRAkUX68I2u1FVjB54we/wZq8Eud2IS2fhPO9ygmX8EOuB26sijXVHhM99edtvCwGFaaKPfMH5fPALIwW5k8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526230; c=relaxed/simple;
	bh=hdLtt9vMMtYCiwLzVN4Kcfyk+wvEEROdprf2SlLd7aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/tlSVQFLbh+bJln0HzgqzPwEJebByyB9zi4S+BZ8Jq7gilzYMiIHO3hzUDJaH0javjRQa+gCHPlsJpsLpDTjr99MX9vqHOzW4W1qUsqH3iMw7Y7zSchnhrxCuBG9GcYy+4cNfFTwTma+ZAYU8cuKzFGqtZs2nXiH74YgMdmpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkBIg02T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CCAC433C7;
	Wed, 27 Mar 2024 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711526230;
	bh=hdLtt9vMMtYCiwLzVN4Kcfyk+wvEEROdprf2SlLd7aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkBIg02T2rSEhxEICFJPv5nHJmDM1zD6eyH5caXunPz2hixUWcqPrgkuaVriNvtFF
	 KKuv33AqkBK4Sb2nKpvt0IKPs17hN8pB24hZCVMrEXazq9BjS941SXF4vSmGWC3Vi1
	 Q8cTJ7UvJ/R1Y8+wccS/y34idUJgIiFGmiboM0z4QI+t4i4HQxLM8Y3HL3D3L8ek8V
	 lO8N9cNd5GKR52oUmU4SwcM2f9QTUID3lXxYVsoc/UkQesQRwewC9vfyQsM3J7V1dT
	 SB4aaGShaiSaP448htUV58/1b3aDNbuVRYdl2RjQXu+h78RHeIk7ADmqcIxWwesdSi
	 Tx8Dp/tDCuwuQ==
Date: Wed, 27 Mar 2024 07:57:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Tan Chun Hau <chunhau.tan@starfivetech.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
 support
Message-ID: <20240327-excusable-excretory-ab1255a7e9d1@spud>
References: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
 <20240327025126.229475-2-chunhau.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JEw4G6Qz6Avejc+7"
Content-Disposition: inline
In-Reply-To: <20240327025126.229475-2-chunhau.tan@starfivetech.com>


--JEw4G6Qz6Avejc+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 07:51:25PM -0700, Tan Chun Hau wrote:
> Add support for StarFive JH8100 SoC in Sysnopsys Designware AXI DMA
> controller.
>=20
> Both JH8100 and JH7110 require reset operation in device probe.
> However, JH8100 doesn't need to apply different configuration on
> CH_CFG registers.
>=20
> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--JEw4G6Qz6Avejc+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgPRUQAKCRB4tDGHoIJi
0nI+AP4lvXFanfkiUzc0JZlLOEC9nQTunQ4il9EnGzNENzIeBAD9H0jfY6g0fJB6
SvLKAyIWN7NA8/iJ9dRxctRxoyMQ8wM=
=i17J
-----END PGP SIGNATURE-----

--JEw4G6Qz6Avejc+7--

