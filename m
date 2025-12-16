Return-Path: <dmaengine+bounces-7688-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E023ECC45F7
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E963056562
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F8C2EDD40;
	Tue, 16 Dec 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJpemtmI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF22E06EF;
	Tue, 16 Dec 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903133; cv=none; b=BG34H5qOeiFWkLTnEG6RZbv618u9TvT7m8PqnpIAuTrK+GLznDazbxhNWKGa7grViOZkUPmhw7gEicPvwXEh19o65rw2orVzR7DFbALNFltxXNhtzvaW22hXozWxQ6M50zZ6ckfXkHwYJm3MPj2al9RpP08t3HV4odPLgrM8DeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903133; c=relaxed/simple;
	bh=YORjPCca5peZWVj6CVOcw/8KWpP/pH7SpA6us1ULmiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCgN7fku+loTA4z1kKUvZX5Sr8QMmF2/9GeXqQw94zcJiUZ1AUpLDXzxz7Z6z+UkXVTgik1BNaLYh6zoDYFzMmxJKjmumI+MNzsEC/Wx3lCnKEXBzC4Y38UAfRq7lAoUk79dpkgzOKXTyNGOzIpk6YrRoFFkQ77SUSohG+H+eNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJpemtmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951B3C4CEF1;
	Tue, 16 Dec 2025 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903133;
	bh=YORjPCca5peZWVj6CVOcw/8KWpP/pH7SpA6us1ULmiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJpemtmIk2rMjnCn3v7nh69rKI9f12U5K2ce7K1SdvTH3K8V/XCAjGYqUooo1dsve
	 +UyVw2M0adaPV13tXJzfkeBbMgPJjBgHCPnQzu10PywY64IvX9480ctmR+xWE7e1Ya
	 xrEit1nRdKDse2nMppdXuD4T/1KZuNVXpdVt6V9g2fc/Erlse1yltwMPrqIQ7n6g7k
	 SWV6H5Ft3u3hvznJ8yHbOwpudHC7IVdEVoRqHz5+vDZtMHjJ46yOFMQ5SB7/aCEOcz
	 6tYakF8JzlBYJ6M33r5stI/UDX2jB3GeCO9uXJEGM2TVSCkbMLCB5JGzZuGaf5Lub9
	 90aO5EMg4uVVQ==
Date: Tue, 16 Dec 2025 16:38:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>,
	"Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B
 compatible
Message-ID: <20251216-alto-clasp-bc7077c5eea0@spud>
References: <20251214224601.598358-1-inochiama@gmail.com>
 <20251214224601.598358-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VEWkek89ZpqGU94g"
Content-Disposition: inline
In-Reply-To: <20251214224601.598358-2-inochiama@gmail.com>


--VEWkek89ZpqGU94g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VEWkek89ZpqGU94g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUGLFwAKCRB4tDGHoIJi
0nDOAP9vwQyYWU89RuSI7vTvOyK9H8grlJWln1QnEpgY2Xw2/wEA4SyvcrWu3DkE
u0H72/NgKCnlCeFE/XVZXkj6DahaRgo=
=Zrte
-----END PGP SIGNATURE-----

--VEWkek89ZpqGU94g--

