Return-Path: <dmaengine+bounces-8410-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MV2BSjyb2m+UQAAu9opvQ
	(envelope-from <dmaengine+bounces-8410-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 22:22:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA24C2C4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 22:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCC638C5561
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4C3A35B0;
	Tue, 20 Jan 2026 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etOmffJ+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA125395DA8;
	Tue, 20 Jan 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938706; cv=none; b=I5n+xfgYuAKz0RFRAqMYeepC/aiXd1l9GfmguCuNjZgbek1YLdhnDwTaFH5R1jQM4eYBI2MCrAyy7HMRctsLVDx7gN7tWnHAZGJiAhpSf/x45XccwZodFxAUwHhEfbdXjpqs4e/eNgySpcboXr5Z16Xp0VBIKJgZrgc5jlmpfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938706; c=relaxed/simple;
	bh=UNHe+aiWB2Wxq5EK4k/+7zuZwWN7DAoEXui1Bmp14k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCnI7JJxI9/v2jq0HOXdtzbMIZzJKtRMfeKSy3OPR2aWWBdwffgkVulQ3/JDq5LOJ1bisyGp9whU/SjLzvhZsTbeFqE9s7EjcIWXURULjM1NZYxOV3YLqXTlG+dx7x4zi6wDxB0bxwoCS5Nidi7ewEXYbE/jfLnaGsqTFVw9wFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etOmffJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2D2C16AAE;
	Tue, 20 Jan 2026 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768938706;
	bh=UNHe+aiWB2Wxq5EK4k/+7zuZwWN7DAoEXui1Bmp14k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etOmffJ+VAT4k86pTXNDiyO5x6tdB5mptsNUk6wwLJhqFtVHxlNlf9e4YHnvVSrv7
	 b5KTt1lVFczTBjbsmiwf2OzH+t1EjmMNxkpzieMDCBuaYSCNvPF1kZzUpbryyug30W
	 IPUFepfSJSR7BQKHHq6Be8hN/mHVV90jEt4zZl36WCePPyKvB0mwNwZYJLLFXqhdRt
	 PQ4gs/voJ6exKUb2ldGsDiVFWKr48EZnR5OpTnxQZzhmO0TdQT65vWogBeQDou62hk
	 +xikX8gSqwNopwmXWu/xH+Luj4xr6tWLm+ao9GM1dE5buITD3BCqE+JHmdTHnAwSfK
	 HZSMfFOhr3Vvg==
Date: Tue, 20 Jan 2026 19:51:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 02/12] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
Message-ID: <20260120-bazooka-morality-32154a74026b@spud>
References: <20260120125232.349708-1-biju.das.jz@bp.renesas.com>
 <20260120125232.349708-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g9U/sCk/7kZ35DhN"
Content-Disposition: inline
In-Reply-To: <20260120125232.349708-3-biju.das.jz@bp.renesas.com>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-8410-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,bp.renesas.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[dmaengine,dt,renesas];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C3FA24C2C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--g9U/sCk/7kZ35DhN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--g9U/sCk/7kZ35DhN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaW/czQAKCRB4tDGHoIJi
0g5kAQDbQMpDFxk4nrseOV0Ef/lRbWLUAEz31Y57wneuqMa+ewD+JOp5cxtHbQj1
yDvF9CtPmaEXnzl0EcHJgz7KucJHOAU=
=TBjl
-----END PGP SIGNATURE-----

--g9U/sCk/7kZ35DhN--

