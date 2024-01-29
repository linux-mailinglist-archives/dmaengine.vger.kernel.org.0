Return-Path: <dmaengine+bounces-858-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BAB840C87
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 17:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F55728A280
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jan 2024 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57015702C;
	Mon, 29 Jan 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay1FWscT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79551152E05;
	Mon, 29 Jan 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547322; cv=none; b=n+667skDTZjwNBQ+RADWa+rDlp2EQl4f1fP5FOQedaipdblgL/K2CKvXYPMcnnu8BbFMURL7g9XEks4ETk7yJXb01nGZxE3DIts9F7jSdmmjNfCklHjMerqsTs/EZ+vNyXGjRl835T0333X0yBY29z4ZmWFSuFeQD9dpV+5ln8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547322; c=relaxed/simple;
	bh=hR9jYGWhCgjIXuOxIH2AVMc3Vqraigi5qVyEese3aHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2YYH/Sr3ZfATkxit8yO80HvMJua4gbVhcCS4BCcZFbKmpbVfaTfQFQ5a824XEOPIKoXKxoNqFzX/gIfkD+TxaARfXRxwkh3wIqDTxP3igrXLGcqFJA2K8FMT3QT7S4DcfMG+M2ghzwlFdLstTaormhnPGl/+d1TOK6IkcL1Qds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay1FWscT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA806C433C7;
	Mon, 29 Jan 2024 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547322;
	bh=hR9jYGWhCgjIXuOxIH2AVMc3Vqraigi5qVyEese3aHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay1FWscTz6Za/JwPsFrt6sHJK48AKK1rXolTRSxu0+vC2pF2JBY7y0/UnAFWpwrD8
	 6lKOBnNOjIMvw4V8TtvzAUI/LA0keuXV58dWCy5HG5UVXxze/4Xn676vEfq/DjF1MC
	 2g4Ltq3iSsDdXRDF5DLZX4ly2avS9rHzBnYXAEHNiCPgJGOmZvogtt/bwkYR/5F5Kv
	 MFWi6y7z2mbEeUjDKMdFT8VSyZ6nnpNZAiy8o64oVyF0eZVbC8+5ry8gjRxnRVhktj
	 Go5Y+DiIHD5FOughSoHJVTLatKFpVV2muTIPdZ2lxMCUdgYrcRKF6TvVyFZDudNeJ2
	 lFuROlD1ekjRg==
Date: Mon, 29 Jan 2024 16:55:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] arm64: sun50i-h616: Add DMA and SPDIF controllers
Message-ID: <08953129-ade5-4b44-8d4f-4b9ec5c750b1@sirena.org.uk>
References: <20240127163247.384439-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DjUSIe2lhqm+shtr"
Content-Disposition: inline
In-Reply-To: <20240127163247.384439-1-wens@kernel.org>
X-Cookie: Jenkinson's Law:


--DjUSIe2lhqm+shtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 28, 2024 at 12:32:40AM +0800, Chen-Yu Tsai wrote:

> Chen-Yu Tsai (7):
>   dt-bindings: sound: sun4i-spdif: Fix requirements for H6
>   dt-bindings: sound: sun4i-spdif: Add Allwinner H616 compatible

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--DjUSIe2lhqm+shtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW32HIACgkQJNaLcl1U
h9CTTAf+NBj4Ah7hGuLaROTSDDDiz0BWk9pjww4elLlFi1AUBUBNvQWdDtAijaGu
C7W6zTydRgAbYyxvQtUXydQVBblXpZO9518kCmpkAiVzNX7shDL0jLVEnCuK0uzx
7h0Y9sIosdfwPVKv/jUovhp2EpsXMzl/5srlZLo+d6m24zuxstSyR/7I+9BWfk9d
wUD6iiUUtv+ZIFdcBoH9Fw44U/R/0aN8D0cz84J7dYGV0yCKTl4iEIXPBuBjUbex
e6kX3qicar6RtwyJpGd7y+L4wVzJSsgTLuf4OrgV8xx6aCCS76MzhjGnNi1CJzIC
OiZCWF4xwWdg73/Z4xIipYkxAGal7g==
=E9Pt
-----END PGP SIGNATURE-----

--DjUSIe2lhqm+shtr--

