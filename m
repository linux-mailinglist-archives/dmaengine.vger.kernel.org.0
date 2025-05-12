Return-Path: <dmaengine+bounces-5144-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6385AB3D4F
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9152164133
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9125487B;
	Mon, 12 May 2025 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMumuf1f"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DC2512F7;
	Mon, 12 May 2025 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066532; cv=none; b=cFoLLAZx5vOcj3+6duZbaYrCN7LyeDXnkKLErB27++E0ncFl7WOuEbHJ20QiYtrM2i3Z6Mk6DyJ3gRJlASksy/gIh34rf8LW50iG1t0DyocRqE0uL7KI/fWWXShwfE626FOdZb3lRztfKflnJ8NAHFx1AgqkT7/oRBeToPgRHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066532; c=relaxed/simple;
	bh=Q36OXvwzuW54iqDLyYNH6PqzQwvoWLmXEDu9aHSwUeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+NNevA7Z0HHMzLtehMMa51O5wiuQ+CE4031RPBtfaZS3OkMsLCBH2JHggm8HJOan7o4y85AFuKTS911/x6uS68BjfrubDO/GX2QUEfs9elWVF5dbFltSApiufqPw35ujiXrLmRzYEGnqDUhlnLj4QWz7fET3VvBkXfhFGmmGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMumuf1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED0CC4CEE7;
	Mon, 12 May 2025 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747066531;
	bh=Q36OXvwzuW54iqDLyYNH6PqzQwvoWLmXEDu9aHSwUeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMumuf1fuj/rbQ6mArroJOZXERVX2mqe6K+2BIU5aA6VpjvVzH/R+KZMDzLdmlNFu
	 7lVZL153dMPP++MSKRNzZftZF09NRcuVMJB/EZii/aFqBslJBn50e+Bo/8d/DgLO9y
	 6CQG4JwR3YM10yjvjxpoY2H1PVXRku2fQI4ctBY/qPnf9oYfw+MMKm85ctv7hbH4qp
	 5yrFxZX9iIiN110PUuEg5BnGeZyc8kQSET3XCMGi7UNZC1v2sUehWDpeoutO5E4Wsz
	 XlyLs2By4cWwC9pLS7NNDmgQ4avKnozFStop2tu1fM7KolHqMQh/LbZE2TSIevB19n
	 wdWXe9gBHKcTw==
Date: Mon, 12 May 2025 17:15:27 +0100
From: Conor Dooley <conor@kernel.org>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	ldewangan@nvidia.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: Document Tegra264 ADMA support
Message-ID: <20250512-default-ninja-01455d36e14f@spud>
References: <20250512050010.1025259-1-sheetal@nvidia.com>
 <20250512050010.1025259-2-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uM1xOrZY5Fq5Lc7j"
Content-Disposition: inline
In-Reply-To: <20250512050010.1025259-2-sheetal@nvidia.com>


--uM1xOrZY5Fq5Lc7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 05:00:09AM +0000, Sheetal . wrote:
> From: Sheetal <sheetal@nvidia.com>
>=20
> Add Tegra264 ADMA support to the device tree bindings documentation.
> The Tegra264 ADMA hardware supports 64 DMA channels and requires
> specific register configurations.
>=20
> Signed-off-by: Sheetal <sheetal@nvidia.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--uM1xOrZY5Fq5Lc7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCIenwAKCRB4tDGHoIJi
0lX2AQD9H99iiPiDs9XOd4gc6siPEsvj0OvXUzRvIAaSiCtdAwEAicOztjwIpfSs
AzHcj3tUaw3P5EVeYTj2aWLFzyZm2ws=
=UcFi
-----END PGP SIGNATURE-----

--uM1xOrZY5Fq5Lc7j--

