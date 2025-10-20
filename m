Return-Path: <dmaengine+bounces-6901-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4FDBF2C26
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD7034FB7B7
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6063321D8;
	Mon, 20 Oct 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGxH2N+s"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D131D618C;
	Mon, 20 Oct 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981903; cv=none; b=DeUf9YYEL+et9ZigsXgWQvkxVIxXs/cE/REgokFcqZU2lyCAWIEvdyR3S6XzpG+gn8tdkP3Nr3WBK3eTP2HuRPQvLUQ5tOUWLdY9LFfI53xsVKWN5PO3VVh+/UgbH1rPCZwgQA1wAJgymxpRtxNZ5uyDVBIwsXRQ5fIzZOBQUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981903; c=relaxed/simple;
	bh=DO9vb9JHUkMOObYe4kyYX1yi7stoKPV827Hln6R4Jpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W43NDTtnt+Opd70ZO3LgyjVmlfw4inbtQUmBdQATvhxYXd5Vuc4e2SlRHFoznYJzTDeVq3lg4V7saF7EhpRrF8hzMY7cpQanw5OdNyAjanSyKc/Yb3PIp8baD5kncRuAqPIcec8DICo+6QaAcK1JEDgDrekmlEKCmZXLMBgjhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGxH2N+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEF5C4CEF9;
	Mon, 20 Oct 2025 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981903;
	bh=DO9vb9JHUkMOObYe4kyYX1yi7stoKPV827Hln6R4Jpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGxH2N+suxXuL9fBx7XnLDj/IcO3ZbTHlsjED0IRBjk07PMAlLffjvZhMm6dXqi+w
	 GTkph3skkvZNYDkbbUt+U1TTPvVJcbjQPvSmGjxQ1zjUDqp+hl6Xbb0I8HxMxVHOa5
	 /rETmwErJtmJvFMKV0J1/OpjWHkrlkE1z6ofXgvngqZhWZh2qeB2mOgTrNcxclByha
	 gYk0320WvhlyT6kp2AIKcSxSpM+dUp0NqFK9X+SPXVVrYaof1CHhbeyu4PH5n4Xq0N
	 h3inVKGz2prhrznhzoJVL4TTJXF5YQ7jnHu3eTIsuFp3eBJKhzDlE2GJXCGhN1pQID
	 Z6UTb79QchYDQ==
Date: Mon, 20 Oct 2025 18:38:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] ASoC: dt-bindings: allwinner,sun4i-a10-spdif: Add
 compatible for A523
Message-ID: <20251020-thumping-duress-db0b28c24168@spud>
References: <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-4-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4MvR5AwICKXo3P2G"
Content-Disposition: inline
In-Reply-To: <20251020171059.2786070-4-wens@kernel.org>


--4MvR5AwICKXo3P2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--4MvR5AwICKXo3P2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZzigAKCRB4tDGHoIJi
0iuEAP9QykgOk8Xg7M8d/Z/Zjb6hbjKdEh/OWt8jFxy8X82VJAD9GmQOn2UpVy6O
yGOHvmmxySCFUg/oyxUWEhZw74wFIAw=
=5qTw
-----END PGP SIGNATURE-----

--4MvR5AwICKXo3P2G--

