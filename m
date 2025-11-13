Return-Path: <dmaengine+bounces-7175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B47BC59C4D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 20:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8E4034C2AD
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085902FFF98;
	Thu, 13 Nov 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgehgEzI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0723596E7;
	Thu, 13 Nov 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062492; cv=none; b=CxKft+DMGm5YsDfp0x3qN1glOCY4XKN3lgJqgDaSsqy9vPqDjvN8RAA+fiii6Mu6dWxI5NcSLsBZYnWEQQ4enmLTw7j0ytoL0wZnEueXf/GcH6LeuEM3V/0rUlGtBNdH7mFerhuhIk1eO9I6b57vUBcD/3weqXFty1+8kE034Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062492; c=relaxed/simple;
	bh=nLccqOA4BPe5kgO4FUw1T9ppkHgLsCcr8VedH/8bpLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdZOsL5y8GkG/G+knOldKS3phyGoXmj0gFNgmf9RoIQfjuO9sIE7K2B7kynaaMESqwmh7ODMfGv31BeBdzPkY/UZoeF+CrVn6XY6P0PX8Mt1gP7yk3S2+FWpSTIKWnjbeBFHz4eicd9lQakwmWuLMRwBVQZnlZL+UBkQ/viIHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgehgEzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05FCC4CEF8;
	Thu, 13 Nov 2025 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062492;
	bh=nLccqOA4BPe5kgO4FUw1T9ppkHgLsCcr8VedH/8bpLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgehgEzIc+NUo3zs4tLr7re1tIDqsVuIe4+uhDhJo8p45rNyEUzHapZZL/Jlm9EpF
	 OrAMw5Y0M8XrjeXPL14t/+piOKeCGqv+DwX63eRyFRgphcT66Wu8ottWKQm7niLLa0
	 1l/f8kSX6RxRf+7gJi7kfgQSv4bzWiUoAnjGvgeQjXX3jb+hHO7UWjDp1PlyHMYDNF
	 j+2HjuIPgaoMQcHW8YJJVK/ybyRekT4+k6W/peRDH7tgArnSHO3iytql2GG72lodjX
	 VZOqiWsd+sTCgNRA8zYr7AXTaEuGBVjOZbZF94/82ex0/flBEaHVTsedRumY7zL4Mi
	 FAQ0vNNEgmsnQ==
Date: Thu, 13 Nov 2025 19:34:47 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dmaengine@vger.kernel.org, sean.wang@mediatek.com, vkoul@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, long.cheng@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 4/8] dmaengine: mediatek: uart-apdma: Get addressing bits
 from match data
Message-ID: <20251113-obituary-living-8e3cffbbd121@spud>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
 <20251113122229.23998-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X9B0kVAFeBMDC/X+"
Content-Disposition: inline
In-Reply-To: <20251113122229.23998-5-angelogioacchino.delregno@collabora.com>


--X9B0kVAFeBMDC/X+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2025 at 01:22:25PM +0100, AngeloGioacchino Del Regno wrote:
> The only SoC that declares mediatek,dma-33bits in its devicetree
> currently is MT6795, which obviously also declares a SoC-specific
> compatible string:

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--X9B0kVAFeBMDC/X+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRYy1wAKCRB4tDGHoIJi
0mflAP9dcdMB14OyfQ6CIyRKL+Tt3e/oY8hoCi4xCeO9hDn3igD9EHtbHzjlEqtL
hmYcc7JBKikQuSYCrOAtP32xTAEJ3A0=
=/Cxy
-----END PGP SIGNATURE-----

--X9B0kVAFeBMDC/X+--

