Return-Path: <dmaengine+bounces-6917-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD17FBF832D
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 21:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E95F3A5E2B
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697034A762;
	Tue, 21 Oct 2025 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9A8QkA/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8234D925;
	Tue, 21 Oct 2025 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073771; cv=none; b=R6XeXo+B+nsbak4YR5xp/cKOWHNwFI3Ibfwc10OSpPGW2PF1r1H/8PLyG8kj8eK/1kYu/vG0gzqDW5zPDfNj0xuTXhGfK6qYLTH3Lq4eS+zeacgqeqtxNifDNWssW0/XRGelayK2yeb6aVJJLPFZP5Lj6ck+8l090UIj1sD7gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073771; c=relaxed/simple;
	bh=1ZpcLoZSoXJDjtDxiz4gSdpEpIyYXDeKX6uMtMztT3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT+mFTafvzg9n7gh3IKZWlxPabFrQVwv69U3vt46yuTfMZeF9PEL6VlaL6rHt9kBirOi7DslRNxjP7rNcWmFp8PePntkKfbfcrUx2TY80SXzkrGh+hnhkwSzxOXxAQVy7NGzMvvcGBfRbtB+9q7XtXMDbw0Ez3RIkrgS9GUxIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9A8QkA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6358AC4CEF1;
	Tue, 21 Oct 2025 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761073771;
	bh=1ZpcLoZSoXJDjtDxiz4gSdpEpIyYXDeKX6uMtMztT3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9A8QkA/fi8WFDL5y8ml8FomW8Szdae1zj92V3zhedoVafs/nqeWyM/0kg87QxAvh
	 la/IdHu9noB90BsVX37QLs78hySHUu4b/wnIEo5NSVTkJPQI6TRhGpNxPjcpMTIuOK
	 8IP5aRKRg6ahrDtaKJpH5Bt8xrH7/sLhSFLqdkudKciv3Q8k92iTsK/ZB+HImcGNGF
	 i/jFJEMmqOs6sfl+gwhMCs4S018gQpV0C8FeNs/uspKxkcexccabl3xGaqqUb4a5VW
	 SXA8nsyEnonVj4eLt4Jk5cejK9R26uGQbA+iQcwaaYFDqwtezLJymHvzLWWtfmOmbc
	 1wjVI8kEQX11A==
Date: Tue, 21 Oct 2025 20:09:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, quic_varada@quicinc.com
Subject: Re: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
Message-ID: <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5HMXsR3PIyPFDxBq"
Content-Disposition: inline
In-Reply-To: <20251014110534.480518-2-quic_mdalam@quicinc.com>
X-Cookie: Absinthe makes the tart grow fonder.


--5HMXsR3PIyPFDxBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
> the one found in IPQ9574. So let's document the IPQ5424 compatible and
> use IPQ9574 as the fallback.

This doesn't apply against current code, please check and resend.

--5HMXsR3PIyPFDxBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj32mQACgkQJNaLcl1U
h9C/uQf+PdpQR2TcWPjk1rtRwSf5/3CwqidMjRkxczfM3UFPW6a0lrsv4BqmhyAC
SxDdB3eCjgn4UkFQ/NiOtKAykJuusvUr9Aa2gGFzzojWSAFNC7B7KpP+geiv5UUP
zSJtiuvEVadVj6UjiEv48nWI+BxlFOQi331kCRQJKYXMIqWc/EurvOUI3EnZyOey
LtWy/vwXKilPCy5/idM4MzAHk1nsyG8xpt3/Tepj2dOWUYQiJmzEsqEP+0bDn7Ta
CJwxQrcPzPSvJI4oTox2aa3op7mJzkAzAiM8C9VTxSqFSy0ez1gcBkKgONr69r5I
zJKvUPjAVYto+P0uVFzrNN1TbPAMxg==
=EPX2
-----END PGP SIGNATURE-----

--5HMXsR3PIyPFDxBq--

