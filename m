Return-Path: <dmaengine+bounces-6611-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE6B81D34
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 22:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA70B7BB5AA
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3327E29A323;
	Wed, 17 Sep 2025 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqGs4Cbn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4118D656;
	Wed, 17 Sep 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142058; cv=none; b=aLzzVonZZhOKA83IgsrqhJH7p40Z6bIRzKr+6nF/h16zKnX6igClCgdtVewdt71O5ilPzrlruLLfaziPDxZ90KRZLeXPFrq732UhkXvuH7Jqzj0PV5Ujr3d3kO7hCMxdzfHW9cEJPejTujiNS/uVZj/Z78tvHrRnyKl7qWuX7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142058; c=relaxed/simple;
	bh=h7EbwWPtFVUiR5ohjPExsa3zm6rrMiaNEomibrJvyck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxtBxVXUw/+Yjy+FEgAj6mo+9n2b8TeliZf6Aj9KbXRCy224hsQvbtiWW7xYSlPYlVZpCyRdyqTHtfGBPgiahtbTwz4rH9gva9+rbkYWuDi2F/z2mNMe/F2BM1qBDakvkFTfrm0BNbNMSEtE9ENPDUv+d2Yl+FzjzQGedX/iMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqGs4Cbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89650C4CEE7;
	Wed, 17 Sep 2025 20:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758142057;
	bh=h7EbwWPtFVUiR5ohjPExsa3zm6rrMiaNEomibrJvyck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqGs4CbnpHy6Bt3gI8wx8EWawzsqwaeP2wz6vTB01vDIg7VHzLxAXkLqno9igTVGl
	 LC3H5PwwIV6kZCLoKA7vgy1BON2d6mY7kwY3m5OM8ZrN+Phm773G10ho2C9tMlU5UA
	 WOmk8dUuZdRobMexzQaqe84QSM0ARbUO8/RdzFsVsmiTp2ENKa0HqF9tPq60/hPpfs
	 ExGp3MpA6jHR013wvmRILUJVwxPkrcoplSsqa1uKnx6pnlujVxrCPPj+AZuzBT8F9D
	 MqxoB5qHSTYdMmLI7xOPexw1CfTw1UhnhPYzGf15/NRRLZ8t4p03J25OpSTI+nSaTy
	 ly7Ce/zdY/8aw==
Date: Wed, 17 Sep 2025 21:47:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 03/25] dt-bindings: gpio: rda: Make interrupts optional
Message-ID: <20250917-muskiness-broadside-d4084721444f@spud>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
 <20250917-rda8810pl-drivers-v1-3-74866def1fe3@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pdly0o93g8e34Y+L"
Content-Disposition: inline
In-Reply-To: <20250917-rda8810pl-drivers-v1-3-74866def1fe3@mainlining.org>


--pdly0o93g8e34Y+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--pdly0o93g8e34Y+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMseYgAKCRB4tDGHoIJi
0vmfAQDRxr0wpcgba117QZqX2neyCChoWuE/qC/DvDfBaKoUOAD5AbFsTT/TbEQD
tk3zzM+/PFL6bzxDTlnOOVsPOoZznAo=
=Ywgk
-----END PGP SIGNATURE-----

--pdly0o93g8e34Y+L--

