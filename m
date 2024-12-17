Return-Path: <dmaengine+bounces-4014-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065469F55FC
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DDD7A042A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059B1F76C4;
	Tue, 17 Dec 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ0mqIgv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3E1EEE0;
	Tue, 17 Dec 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459739; cv=none; b=pME6tuNSUcW9LDuEv7l47VqngZ5Xy6F12Qq0DtjYVEdQQ7/RIVc1EqBT9xB3zCxfqeMNnhlR+F1HArcn38v3uq11noodxb5oJ21aV+6q0KNpJRgK5Pf2k6QjSQKwXZF3hyBCkncMR0Mf+DrAOE+INP00pgQfnGER9QAyoYNwiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459739; c=relaxed/simple;
	bh=2P9lRz+X9ysJoY3Z0POj161iz4jlESzdjLZAlJxgNb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj3Jqom9NC7Ai77k4tIVwtanGC3oO5MdEgEu1NS9C41ATMKEEgaKlxXgO5vM0w+t99zMHa2Bsem4zV18IDzyZ8bJea7X5sNR4mpxv6CGYXAo7VbkQzt1T9VdYpzJFfVH+IUQGJ103pNAFVhlLsYp88XVc9D9j9vTrrACBv3r7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ0mqIgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49989C4CED3;
	Tue, 17 Dec 2024 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459738;
	bh=2P9lRz+X9ysJoY3Z0POj161iz4jlESzdjLZAlJxgNb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZ0mqIgv9ecvN+XF9LE5Fjt8JO7UKfGsS+id0MOMPD8gIi00iXXoBysPwj9/KqXsP
	 qyV07dT4fl0PMpyehMfMEWXffETHSQYKhCRQVVaA+Qd+HO/c2C9IgWMlv7h6qmnyy6
	 Lj0vwBkRNWgYib7tjiwScdlQUPJMwoRZ1oZYG9jfi+B0mbKtlSd2IBtJx0qjgOv9XH
	 zjYrbF9S3p3KW5/hRb2IljarhfIa4U2NwFVM31vCnyCYQes2hDyWMgYQL39HGfu7K0
	 3fu3++FPVTPqe+GJ6/ofWrI4S9BRwaUPxqlS9F7GbU7PlLvd4FkCoVsv4J31xanjmn
	 C8MmK5BUV1yBw==
Date: Tue, 17 Dec 2024 18:22:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, spujar@nvidia.com
Subject: Re: [PATCH v2 RESEND 1/2] dt-bindings: dma: Support channel page to
 nvidia,tegra210-adma
Message-ID: <20241217-stamina-starting-d39f3795d85a@spud>
References: <20241217074358.340180-1-mkumard@nvidia.com>
 <20241217074358.340180-2-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kBsqXjaDGNP7JibP"
Content-Disposition: inline
In-Reply-To: <20241217074358.340180-2-mkumard@nvidia.com>


--kBsqXjaDGNP7JibP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 01:13:57PM +0530, Mohan Kumar D wrote:
> Multiple ADMA Channel page hardware support has been added from
> TEGRA186 and onwards. Update the DT binding to use any of the
> ADMA channel page address space region.
>=20
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--kBsqXjaDGNP7JibP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HBVQAKCRB4tDGHoIJi
0rNMAQCNyyoTOpHxpr5GguE2VK2cZLlCSzZqPVcZD9Uj84zATQEA/H98btCbnXda
tz2JSt3Pjtpk5p2MbU73HfIHupP7ogM=
=0vlB
-----END PGP SIGNATURE-----

--kBsqXjaDGNP7JibP--

