Return-Path: <dmaengine+bounces-7172-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F0CC59C23
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 20:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AE324E4798
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 19:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B832FFF98;
	Thu, 13 Nov 2025 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy7YsIYU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14A31AF3E;
	Thu, 13 Nov 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062327; cv=none; b=Nwie1mnbOyQfk8fzsuSmZQT5UsLG+XOVLzefNFgLynic93VYAOG5V0i9m0mDkAEmCi2pHJXdnZivurCmGlon4UaNokow0nTiVtFOQACEvubuiNhkfjU4wHutIipArYjiSMKVa7O5OTz7p6jVODlgVvBgBHLXATs6s/CjuoUfW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062327; c=relaxed/simple;
	bh=BdDY2Y5ow7Akz/NswUqHtwC26DuJTuA8klDFKCsu6bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8u+bhw+d7qbZxm59EY8iQTVLNh9AmfNf2vGuUbF4SkuhGK577YpPNtxhE1rxSzdfSPDJISAEdPlEuf7ol/OwmkV/B8ff6lqV17pd91JsnbztjIjQZYKDco1bkibItri2DbV80UjInRichNmpuang7M0JhbyRzAT01vUoBzpdng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy7YsIYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355C7C4CEF1;
	Thu, 13 Nov 2025 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062326;
	bh=BdDY2Y5ow7Akz/NswUqHtwC26DuJTuA8klDFKCsu6bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uy7YsIYUwbfD94LDxhC+E1AO0Jct7f/fhEglYJwYFleowCtlA/IMcDFTzDsT5mdNR
	 90ClGTL254pzaXk5liK/9GO69m/TfSunxVbIo1dOsxIQze83+mEIUdV4saF6OP+jnF
	 i6RDdToSEzIjIDzYQ1+NhcWHguzJWr0Mjjn3dZIV4jJ4dC2soc7dWra+H6w74dJjVn
	 Q2+qW6xV1eU2ZdODQg42Oft52tUKba4r9YbZopZZP45URjd1LQzLxtRrxg+7I5SCNs
	 zIn1N2a19AGm1RAyAqtnmx0hdvSHaQxnW9gIbkmKzOZcWE9VXp8LKaLLUbkAA0e2HZ
	 fLZNJVSO/xA0Q==
Date: Thu, 13 Nov 2025 19:32:02 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dmaengine@vger.kernel.org, sean.wang@mediatek.com, vkoul@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, long.cheng@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 3/8] dt-bindings: dma: mediatek,uart-dma: Support all SoC
 generations
Message-ID: <20251113-moonbeam-untold-0a2e61bcc050@spud>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
 <20251113122229.23998-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZAXCNDRXne5IyPst"
Content-Disposition: inline
In-Reply-To: <20251113122229.23998-4-angelogioacchino.delregno@collabora.com>


--ZAXCNDRXne5IyPst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ZAXCNDRXne5IyPst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRYyMgAKCRB4tDGHoIJi
0iEzAP9KgDizT2iEVi7kgYlIdMoP0pAgOj0p0a6l2gVXD5W8tgEAj8XW5x+y5BnG
oUmwgkdJH4QQXxIvrbkB14RR2+EI7QY=
=hw3B
-----END PGP SIGNATURE-----

--ZAXCNDRXne5IyPst--

