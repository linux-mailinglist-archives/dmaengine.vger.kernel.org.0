Return-Path: <dmaengine+bounces-7173-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E7FC59C41
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AD5C4E1A0E
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1D30B50B;
	Thu, 13 Nov 2025 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBqgS/2C"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110B27FD6E;
	Thu, 13 Nov 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062350; cv=none; b=ic8VeOWCGeSKRjtNsBltAYwu2VONZ94ySIUhrgaC0T4V6xwlXlsz446XE82Yz6pKWBTOEYyublE8C6y5fCSz/fDfU+LP4yNnX6vTWjvKQt2FuDP+qqZf/bdnXFc9t+Yz7Gc/1LqU8Bd8S3MYbOOiwmxf04aryjSBcCrchemXSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062350; c=relaxed/simple;
	bh=ISNCe7A+FUFRQrYWDzQXFgYmnv5S2HKSoaxxW+Wl/8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQAkxQx2OWXRznBlXW1J4cIo5GtmMApcoQmrQEIK/n1HIAX1W7lwAMq82z9ybUNffNnZJKZzKv/8Xj2dgBtrzNzOKofsit17U9zOJZMlWU5gqXYqzeEJC6fu/I0CoVm9kmbgKTDyPtb6SwjQKz1G0y3OM6s87Dz4cQ1ndDAoMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBqgS/2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D74C4CEF8;
	Thu, 13 Nov 2025 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062349;
	bh=ISNCe7A+FUFRQrYWDzQXFgYmnv5S2HKSoaxxW+Wl/8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBqgS/2Cjg6RLcB6X5aXeHLFuegJpxBvVmJ/mjs14PxXHikeSW3lbQR3khWvF3EQW
	 VNj9Xko9BqYUFse0+0HRKuSOOHL22Lr1mnDTohMn81e3sxMTpVdjBPN9S4Hhzkho4t
	 v9OJdMDPG9xi3RDBRvnEUvo4HGRDJUZT/DtpqRjQhIIYBf9srVbb0eKe/h8rguziy1
	 MBS27oTkCkKnL9hqU9O423zMRALevTaePYJL5DUH8DOZK89w+qZRUVeUAwW4LLQOvA
	 2Zg+Hgc918nK+VGdnab0YPU91XUiuVDPIqYETy+FfN/EZuqRj+hFXzmWnk7kU2KYXx
	 3SPHa01N7dBcw==
Date: Thu, 13 Nov 2025 19:32:24 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dmaengine@vger.kernel.org, sean.wang@mediatek.com, vkoul@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, long.cheng@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/8] dt-bindings: dma: mediatek,uart-dma: Allow MT6795
 single compatible
Message-ID: <20251113-reusable-possum-068bf281efec@spud>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
 <20251113122229.23998-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZxOFVMazaNEs56YG"
Content-Disposition: inline
In-Reply-To: <20251113122229.23998-2-angelogioacchino.delregno@collabora.com>


--ZxOFVMazaNEs56YG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZxOFVMazaNEs56YG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRYySAAKCRB4tDGHoIJi
0vA5AQDPZ8SkT+MGHGW10MCGgDFHOn76yQ+Xv1rPa5kB1xYp4AEA3wBhxsfGCMXK
2VK9p+6Z/lt2r+6wvn7kMd8dIzOr8wE=
=Khkl
-----END PGP SIGNATURE-----

--ZxOFVMazaNEs56YG--

