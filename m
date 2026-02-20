Return-Path: <dmaengine+bounces-9001-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IzwORPhmGmHNwMAu9opvQ
	(envelope-from <dmaengine+bounces-9001-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 23:32:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2A16B3EB
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 23:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948513037436
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5131064A;
	Fri, 20 Feb 2026 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3h/4uFO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9F30F539;
	Fri, 20 Feb 2026 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626541; cv=none; b=q7Yql+//4GKn6bqEINTn9FmWkNotMHg5DBwmcymH013UNzki5OoxL9brxDpbigI0uYou7tvYHmbAdMS+ikRCCIH3pSG6PM8mDdlqGcrKyS7+QtMrEWTOvzxEa1Jr6Vn/HSN2GSEm1aLui6y4SVASaPLXSxv1XookNYcJm7JyEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626541; c=relaxed/simple;
	bh=11otB+0C7jYVhaDxWBeram0e1X5fMU/f0Ln1ESpvEjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RePgH/I9j/eEsF9LpBCC1QViFK+Pd2gR0engCuERLokaNXYfvk6wPXLrOysUqjuhqYQaovualUOOKyFBuBM31ynUCb4i8SSIzSCFMKHd87Mm/sUsgDNia173BIk+asTJCoZSvWTtuI1JgTAY/Kb3+OFafC5SuYjUmmIM4SluLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3h/4uFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341BBC116C6;
	Fri, 20 Feb 2026 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771626540;
	bh=11otB+0C7jYVhaDxWBeram0e1X5fMU/f0Ln1ESpvEjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3h/4uFOa/J5BG0X4/6yM6a07SKXwLgiBv+QCvuuyf2FmME4xpAKnWETPBeSX/xed
	 UrSmCDomq8BlunEIKGC+u3se+LW/r9nxhn9ivo4onmKVsa5D9rO3QgBa0ixs0+7qdJ
	 XKwz382H/4jfyu3ojeABxVz6NKAQ+wXWUfdixU99s64YWJVn4YPqUp3sJ8pWjOQStI
	 n+9gmFJLQE070EdcdUR7Cvdwpl0kLgZ1kUAIwRFUnA2pwjwxXCspPWiXYP8KynT5SG
	 hwOxgyRsL5+MWR4N8IsD/t8R+d+R/LijnQDWuKKQ6hzivoKgxBiAlRKuuSdQxA9KYr
	 xHojA/+IIQ1HA==
Date: Fri, 20 Feb 2026 22:28:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Max Hsu <max.hsu@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Green Wan <green.wan@sifive.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Debbelt <palmer@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: dma: sifive,fu540-c000-pdma: add fu740
 support
Message-ID: <20260220-gonad-plutonium-60e1baddecec@spud>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
 <20260221-pdma-v1-4-838d929c2326@sifive.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4diucl4xuCXo0x14"
Content-Disposition: inline
In-Reply-To: <20260221-pdma-v1-4-838d929c2326@sifive.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9001-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CC2A16B3EB
X-Rspamd-Action: no action


--4diucl4xuCXo0x14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 03:43:56AM +0800, Max Hsu wrote:
> Add "sifive,fu740-c000-pdma" compatible string.
>=20
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma=
=2Eyaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> index 609e38901434..b6c49060bc6f 100644
> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -36,6 +36,7 @@ properties:
>            - enum:
>                - microchip,mpfs-pdma
>                - sifive,fu540-c000-pdma
> +              - sifive,fu740-c000-pdma

Based on the driver change and related discussion, I'm not sure that
this is the correct change to make.
This shouldn't be applied til the discussion on the driver is figured
out.

Cheers,
Conor.
pw-bot: not-applicable

>            - const: sifive,pdma0
>      description:
>        Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
>=20
> --=20
> 2.43.0
>=20

--4diucl4xuCXo0x14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZjgJgAKCRB4tDGHoIJi
0sF9AP46m1QKgFzFZtWRE8BffzPh9vx1iQM4ymKZBIOR3oErdQD/QJsiq/QotQMJ
wEpnHgIGg5SaNrX+xWsBYxthqnvQ9gE=
=Ni+J
-----END PGP SIGNATURE-----

--4diucl4xuCXo0x14--

