Return-Path: <dmaengine+bounces-4557-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11407A3FDC2
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2CC189AFF4
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15A250BF4;
	Fri, 21 Feb 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPOf5sim"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD61250BE4;
	Fri, 21 Feb 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159893; cv=none; b=ESlZZil+1ZD8+unfPgAe/XUFN3XMMxqHasz2AX/nOqS7hEapApNptyVPGO548IKstSlZ+4I1VimZ2jytYBoofTaM39HdR58vZMyurogxfK7rYhEh6jJmQSPUBy3snY/MPgEUo1ImD0e7ihI0THDrZwo2BZgpFnHDb33fJW4qimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159893; c=relaxed/simple;
	bh=QPNHx/gCu6fp/YFqDUM4iahi/PpuN0Fxs/mtMVW1iKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc8ZyPyAEsZz2sEEqzZuKdZT3GZTShmIn0iAnUrCZgzg7SrXkIYl+3dLlPvjnT6h2TWz1a8vycdr8wSOSUWMJnXlvaSCfizM4nuKYiNE08KJFhJgh2AC3YLED/ewGXHhCBgdoGqIYnYbx5SDPsocWI7ConZhJE3j/G2I+u9I2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPOf5sim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0556C4CED6;
	Fri, 21 Feb 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740159893;
	bh=QPNHx/gCu6fp/YFqDUM4iahi/PpuN0Fxs/mtMVW1iKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPOf5simgMKFdYrvDdlqMHPgoRcq3ZMhiAg1d7mDKLxIFej5774p75tSx7qY8f8Ee
	 aEHKDApLvO7ORyVHvk/zJBGbzdTyinrw8SuGM5Xfj+kr+6GET/KqZM8COGsBcmeNQH
	 dzT5FFjEyeO+z5dQsslqawuiAHRl3F094Nge1lPuPV5HAZRf8nbmohl7zKnKLfpulK
	 47di3YIg1LDjsxsY/m/Il0RdQmOScABsaSLflYVaW7xesFRXxV3/fQQ7Ld8Iz558ba
	 +S/pujWeuxyu1wH1mOnKMtyvhu+QO/fKVywv/sv4rbOX2MHtG5l0PNSAy55v6wQIQp
	 rMTaX2U8taHZw==
Date: Fri, 21 Feb 2025 17:44:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Message-ID: <20250221-facing-irk-e81537b74318@spud>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/EEPdWrb1pzJ6kc4"
Content-Disposition: inline
In-Reply-To: <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>


--/EEPdWrb1pzJ6kc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 03:01:06PM +0000, Fabrizio Castro wrote:
> Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> Renesas RZ/G2L family of SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ NO/ACK NO
> * It is connected to the Interrupt Control Unit (ICU)
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/EEPdWrb1pzJ6kc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7i7kAAKCRB4tDGHoIJi
0kGtAQDAv6PvDXuy1DRsUbcFwv/HIDd5S2cZytEFuVRd8/LSrAEA0KU/NrdmlLB3
PiIKz/q6WUNpQtHH2ocN6H4WtNECgQA=
=TqZi
-----END PGP SIGNATURE-----

--/EEPdWrb1pzJ6kc4--

