Return-Path: <dmaengine+bounces-6900-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861DBF2BD2
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E722C18A3FBA
	for <lists+dmaengine@lfdr.de>; Mon, 20 Oct 2025 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402231B10F;
	Mon, 20 Oct 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVkBH+w1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C13283FC3;
	Mon, 20 Oct 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981850; cv=none; b=deYOkUcKNisetqSyzTy2RZ28wULYiO3KdrgCDgFAh0VnkFvIHB04BxwXQwmSlf7J53FA/J5AIOihA6RGUeAkgZ2M0gpsWqAWQr+wYlr/pcCCbMjWl9O85n5ZJeJxDBhyCnHI5SqO1eR0s8fNuKOXBZIIryS4+WYrILSg8T6v6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981850; c=relaxed/simple;
	bh=xzTURFtPy3dzPi4sBnNAvBJIr7LYeKbmO3mMPxuwgq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtjTkyljlukWYNIc2rcDYSZ2opvtD93KRrdq6neRYMaY+/UIo6OmTDeg1a/3JG9eeQvWt8r6S7/1/6mYYclANhpjWPDe6VnoViS8AgxpkdNEtyebSBkpVn13wBrMu+s33qMEzvmdUCfrX/+ipDeXprZCH0zzsQ8khNpoJkGV+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVkBH+w1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D34C4CEF9;
	Mon, 20 Oct 2025 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981850;
	bh=xzTURFtPy3dzPi4sBnNAvBJIr7LYeKbmO3mMPxuwgq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVkBH+w1fTEx4moPwmvsaZPHd/pQBjIgBsR4HG4CBwAny4SdL/16DogGkAfE3wHoM
	 xztKTxM+IdtyzuT7kvBYuyVbV2th6ja3FArLJYeAhGtRo8Kt6eKL4cOp3EvYz8vcxo
	 2wpIljowvQB+YzjpRDNhGPqR8TCWvrbRw1hSsLLaD2UY07iXGerspqfRwdtdoNEWhr
	 RoeQJNGSWRKU0+fZQQiTRYTnY9INojc7E/xO6QomGquL7tLDPyDCAY+AiCuN+R4pyk
	 EwK5BdN7WAsDeURgbF5BosNRt/8yFmBgnhzfi3ZyTKpaU5FPzbL9drpCJR9eMNmZgR
	 WTktnvdL8RO0g==
Date: Mon, 20 Oct 2025 18:37:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: dma: allwinner,sun50i-a64-dma: Add
 compatibles for A523
Message-ID: <20251020-unviable-barometer-b32b5b4dd3ca@spud>
References: <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xq0vNRfTQ6DP6xaL"
Content-Disposition: inline
In-Reply-To: <20251020171059.2786070-2-wens@kernel.org>


--Xq0vNRfTQ6DP6xaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Xq0vNRfTQ6DP6xaL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZzVAAKCRB4tDGHoIJi
0m6ZAP4iu3Q03foC7HmRU3ggvY+2blVh8J/CJceLcdTKFy2W0AD/f9wPk9NUjSXW
z8j7PlblLCw8HPglqC+pskZiHoBQswk=
=OHda
-----END PGP SIGNATURE-----

--Xq0vNRfTQ6DP6xaL--

