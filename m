Return-Path: <dmaengine+bounces-8411-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDGeGiHwb2m+UQAAu9opvQ
	(envelope-from <dmaengine+bounces-8411-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 22:14:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6654C107
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A6FA4CEB1A
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE743D51C;
	Tue, 20 Jan 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg55ZUl7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95112328B69;
	Tue, 20 Jan 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939016; cv=none; b=C+Bs/YXfwQJj9QZuf47tZnqCZisyn/JIDAgk4v4M1DsvHoaxG3ztnOHI10e/VxlPHItTThRCE4oBaW971ZHwRutLnxy4NYekjuV5kRQGxxnmtckOcWyEiuVBIpyhPJpqjJGOYtKZ2UT8nCH+UJzljZu0aD0qty2aWvzcxzNrOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939016; c=relaxed/simple;
	bh=QeFUYFz3aozyXSi/U4D3QgIEainC2J2D25fpMJBvUZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea4NggNMCVJ4IBSq4O1rqAb1QbMSnt+reiveB7RM0D3VaBppkDpncHHtZFq1+uvxHPbDVI8vLg5fqMCTOWnItjoer9ibRrqW8u0xs9HvAMrdQQy5FxR0TuhFsfTZ1xO7PBxWEW66NyNMjNa+yaI9uxuHjOlvmgWWM+oJ+SOLBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg55ZUl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCE3C16AAE;
	Tue, 20 Jan 2026 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768939016;
	bh=QeFUYFz3aozyXSi/U4D3QgIEainC2J2D25fpMJBvUZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qg55ZUl7PCwOKIJroJWinVWMECWA3yD4zu2Cn9R8ihsgSyb7HPDZ/nwBx9gUbwHmL
	 FFE/4srXmvOS1mq6CIegrdFIf3vaqq8Ums4uXDAIhNEKfxRuOD+qfsBFgfgBOhr3wd
	 9egU1PSGbmoiksrwoqxmwtt9JDz0xYDbFpjEpqOw13FhHpUqioV5ZCbDhjg0mbozdO
	 y+o2CA9hf/y+Lo1wtdY4AryLUbgs61V+4Tfpr+XsYVofj0ttWZasXpKREOuLtZcaox
	 NbdBLdVTtjlydzUx3R8fiYQbkhQkgQtrfD2atGTsl6oX8a0/aRhJL1w8OaUdiExiYm
	 IFx+/M+4GYMbQ==
Date: Tue, 20 Jan 2026 19:56:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B
 compatible
Message-ID: <20260120-stalemate-storm-6d9349600936@spud>
References: <20260120013706.436742-1-inochiama@gmail.com>
 <20260120013706.436742-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fvA7/4Tf/YdW8VS"
Content-Disposition: inline
In-Reply-To: <20260120013706.436742-2-inochiama@gmail.com>
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8411-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn,vger.kernel.org,lists.linux.dev,lists.infradead.org,gentoo.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,microchip.com:email]
X-Rspamd-Queue-Id: 2A6654C107
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--2fvA7/4Tf/YdW8VS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--2fvA7/4Tf/YdW8VS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaW/eAgAKCRB4tDGHoIJi
0lazAQCRt2lidCPRTllfO2VCKHegNgvFU2GNEZ2JMATcN9aC2wEApUBxlN+9o/jn
2DZBjLRSmlBy9UfONFhsGaoQKAlqEgs=
=SZSn
-----END PGP SIGNATURE-----

--2fvA7/4Tf/YdW8VS--

