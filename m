Return-Path: <dmaengine+bounces-7174-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF4C59C2C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 20:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 087DC34F6E6
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 19:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC1311941;
	Thu, 13 Nov 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNMf4Zyp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DD27FD6E;
	Thu, 13 Nov 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062372; cv=none; b=Ajre1R+5woedmLl73oWUgn8GHduPpn0nG5OSNRcK+2QffWihTjjRWzMRZTZGX81WT+eFxVm+GGtZlsk08ta7rC3tBKjsCnoYIJW9f+6e8VGlIvMFRBb1fCcGHZKAYI6vIsiotoXBpTgCNCRpxq7gDqvXI9kA/FnkYQFCNk3lou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062372; c=relaxed/simple;
	bh=3vv64cd8SFupwFJKr3VBCTmOwr/u3q9lkm1htCLlUAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0ZPk1YHMl46fxqVDVPoT4IiRZ9ZcvPUoOS48XhEGH+zWf8Jz3i6cXJfYgBikiA/m9LZ9dUUAq8FIR8HXebrfEyMUeKdqln170w9IkESWqFwq9/X7+4pbRTJj42dUzok2mszG7dgertMJnvxpaIS1KZFz2sb0aojTZyhd6e+jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNMf4Zyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C864C2BC86;
	Thu, 13 Nov 2025 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763062372;
	bh=3vv64cd8SFupwFJKr3VBCTmOwr/u3q9lkm1htCLlUAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNMf4ZypLQh+Fsr5mhzocSGw0Gu6sA8b+vnK7Whe5oIf8lPKTCfK57Wr3Bw5bb0ro
	 2Nl0vgNcSVDchF5hO4oD8gUXKXgNPWK78JM3kHjDli1F8p8m1Rb5zmONzmrVQFfjT4
	 TTiF/O/8+DpK0WuZ/ycYZ1y4naJHUIZfH7uqecoUIw6D1KQVPWK9FZ5c7v5tVRNT++
	 d/FDKP13+Mf743dJAys5hbrdNc2TkLwY/vzblXsVieK4NoKGlBNy8Cg8PIlXyqcOPu
	 dby1YhYI/Hnpm/APYoSyblkpUA1f2Ap72KWjg2BoyVhLfkxhSq/x1EAFyzyBP71/wF
	 Kxdf0S6GH2b+A==
Date: Thu, 13 Nov 2025 19:32:47 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dmaengine@vger.kernel.org, sean.wang@mediatek.com, vkoul@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, long.cheng@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/8] dt-bindings: dma: mediatek,uart-dma: Deprecate
 mediatek,dma-33bits
Message-ID: <20251113-consoling-footprint-b0e973dfa43b@spud>
References: <20251113122229.23998-1-angelogioacchino.delregno@collabora.com>
 <20251113122229.23998-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LYAF0Q9LqRdx+kPX"
Content-Disposition: inline
In-Reply-To: <20251113122229.23998-3-angelogioacchino.delregno@collabora.com>


--LYAF0Q9LqRdx+kPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--LYAF0Q9LqRdx+kPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRYyXwAKCRB4tDGHoIJi
0gE7APsEtqK4GXeGyZLPaN983rSnnZc0g7pcx03yHX2KSrOmmAEAvhnPZOC+Lolj
VoozhY9jDuDBsJeppDefVHWStpF+3wQ=
=9foT
-----END PGP SIGNATURE-----

--LYAF0Q9LqRdx+kPX--

