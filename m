Return-Path: <dmaengine+bounces-7038-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43FC1C85F
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 18:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D41F3ACDB9
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FFA34AAE6;
	Wed, 29 Oct 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6YO3QiO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA686347BB7;
	Wed, 29 Oct 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759367; cv=none; b=rs6DxMBMqKWX4YyefiSl0/8onuf7bF9xpidSwEEAVx6WZoT1jIxh3Rpf5ePWKtT3OJs/C2dxVT+mW1ZOxe4jU2rlzy9+BE3Er2F9zwgo4T7zx/tGCCVLjLMj6MYlU6WLetashe/ycM48ojrz/w2hyZzgjLXwsob7pqalVQHdeLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759367; c=relaxed/simple;
	bh=dIO5blnKzz9hBt/+HHwGfwDS/IJQ/tx25gX55zjAV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nubLhHshet5ZKQc3/Linm0c07QyhrVZEca27O1MZ4rjqkfd+R6jIIjNI7ZZtBjnGc+miPVABgJPJCIrXOMNgKDEJo8PyGzcviY2aLwOapwF5VCdPWIVzAS3uT9uacUTg/aQEXlweUE27eegP+2gRUR4xS/V1WfL+slAaWQhh/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6YO3QiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B77C4CEF7;
	Wed, 29 Oct 2025 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759364;
	bh=dIO5blnKzz9hBt/+HHwGfwDS/IJQ/tx25gX55zjAV9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6YO3QiO0a04yixqh/WA91Z0BHQIztcaxxkezYeysmJM/GNRJIdfPl777fFGiBTzB
	 BNZqs4HwEtdFoKM9kdXoqv+uyHVOgdKPS71J3cnC97a4YlwUgMxOuAdWRS3+Rr3Pyk
	 sW3OntwaMPLmQ7FqXvFezpT126dgvwNos7tHzuPG91ff2KvqW55Bq9MzuzIfr2IbAG
	 mx+exnTb4DIaLY8eP/e0oq68S72JbFwkqrPfzCs6u7neWssczqgg5v8XfG0JkeRMNR
	 vPNzQdx/QdV/Xu8Jt3DCsAdAgc+xixzd0jVHHJ3HxYy93tZ+bQbr5p0ocOFV1Rt32T
	 bfU4pwgxObcEg==
Date: Wed, 29 Oct 2025 17:35:59 +0000
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH V2 1/2] dt-bindings: dmaengine: Add support for
 ATCDMAC300 DMA engine
Message-ID: <20251029-marbles-referee-69f718ea8396@spud>
References: <20251029142621.4170368-1-cl634@andestech.com>
 <20251029142621.4170368-2-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pLO2qm/+eYKKuH1u"
Content-Disposition: inline
In-Reply-To: <20251029142621.4170368-2-cl634@andestech.com>


--pLO2qm/+eYKKuH1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:26:20PM +0800, CL Wang wrote:
> Document devicetree bindings for Andes ATCDMAC300 DMA engine
>=20
> Signed-off-by: CL Wang <cl634@andestech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--pLO2qm/+eYKKuH1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJQfwAKCRB4tDGHoIJi
0sNeAQDC1q3rlaQpFZBlKlkpkVDLHDX5tgCVRPR6nkg39snodgEAkSzMO7qJHk3R
mwRu7nz++QnhQGTuY4s/eNZMMCOK7wk=
=0XpX
-----END PGP SIGNATURE-----

--pLO2qm/+eYKKuH1u--

