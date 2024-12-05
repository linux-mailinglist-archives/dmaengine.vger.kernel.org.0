Return-Path: <dmaengine+bounces-3915-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8109E5D2F
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 18:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95D91624F1
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A891226ED4;
	Thu,  5 Dec 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiT7KgEI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0A226ECC;
	Thu,  5 Dec 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419981; cv=none; b=j4JWhyx3UCuyDYqSGbR08bOVM1OpMyv4HT+FN1Toe/X5bGKdejDCS0hjMl8oxexY/FOhlO238pgEk/hn/fC7omFHgLoAiVevT1VAnmbpG55nUBwzrrZ+SKAWz0EmjMsDkKKSu9vlViVC6zlebChTiw5HLlFRmEF5RUdB1o/RH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419981; c=relaxed/simple;
	bh=A4HKlLGP6RuuEleImAaXneXIJLzkRN3tyzYIhdCc+Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m62zsZEw9y/zhYdSQdE3JxJWHMfjlIKOUIr2XLYzyuhQnkxO0fV/QWmLWsC+AsfsdJXJqihqkOEWaC6oBN7tEeCgeQ++8GxQp2W/kEP/rnCxXAwBSeLccnE78Jbd8/0vRebykVET335MuJZs1iZS3UvtSaqXKYObFexJMsOPHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiT7KgEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D5FC4CEE1;
	Thu,  5 Dec 2024 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733419979;
	bh=A4HKlLGP6RuuEleImAaXneXIJLzkRN3tyzYIhdCc+Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiT7KgEIA6zYesoTXQs1I50aE1CdHjoz/pSjFaMcX9Rt0GnslQzQeWvJtS20Wjy8c
	 sebQo4CNXtZdTPUG11bB+mLPN88zlA3b47N30dE/55w8RxNLm5JQweKcTJyvcbOAW7
	 +XNZpoTpYEtj3rTffILW+LZNuuAmvRZCAW4YKQ0LRGc3Wj5ewwqrtSYkwpavwl9NOh
	 CtJ5V1Gi0Z5pAKIW1T2hBxJzOkeRNIFFN07foLyx/GqgxW2y4dnseGncww5f72qxGw
	 q852tvP6nhRnaoUDXvJsxFgdEi9kC5rs/RqVWXlbTh2DMm+d7cwtyHssxflhXsw13C
	 B9LMQzsOo769w==
Date: Thu, 5 Dec 2024 17:32:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: atmel: Convert to json schema
Message-ID: <20241205-silt-legwork-8cfe9a41bb2e@spud>
References: <20241205-xdma-v1-1-76a4a44670b5@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ScQk4iEEumBXrCPc"
Content-Disposition: inline
In-Reply-To: <20241205-xdma-v1-1-76a4a44670b5@microchip.com>


--ScQk4iEEumBXrCPc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 03:26:18PM +0530, Charan Pedumuru wrote:
> Convert old text based binding to json schema.
> Changes during conversion:
> - Add the required properties `clock` and `clock-names`, which were
>   missing in the original binding.
> - Add a fallback for `microchip,sam9x7-dma` and `microchip,sam9x60-dma`
>   as they are compatible with the dma IP core on `atmel,sama5d4-dma`.
> - Update examples and include appropriate file directives to resolve
>   errors identified by `dt_binding_check` and `dtbs_check`.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ScQk4iEEumBXrCPc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HjxwAKCRB4tDGHoIJi
0vQFAQCykQ0pcZXNpjHqd6IymSH2h4phZPWh5G8QohuQFfFThgD/WTDUDFfxBKTn
OnP8Z6iBbruK5JlxwD3g8+4iMSnZDwc=
=f8hZ
-----END PGP SIGNATURE-----

--ScQk4iEEumBXrCPc--

