Return-Path: <dmaengine+bounces-6925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D520BFB6FA
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 12:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A5F1882242
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA705319879;
	Wed, 22 Oct 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9fP+N6D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF92BE03C;
	Wed, 22 Oct 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129729; cv=none; b=WkuBPtOfck9li2TRhma6Dcsy8WA86H6SINYQanIqrO9UuiDzUQec8ZuQllHHFIa7N+eU+LXjOiyfy3VdRCmf9bGGVfbBnlHtcwRQvesGRaO2CTQ2lPDjpx1adE4M/5qZrNygcbtNtNXRQLJeAXDcja0hff5kBw6dZPiOTw0Rdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129729; c=relaxed/simple;
	bh=fP5yx2bkDWUMYZyoqg2KA3bJxODxRSuv9A7iBDPTTNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMGsikRdozJ6ko5cWOXowSUGEoEhqRN5cBKRBe/+youV9fRavmI8z/cwkW8S34zoaudysxjiLbhzXZWmnnbu4n4/iuIzxnCvhBzE1i0MyM2FfFLs8dKnTrAgFQDgBIqQC8h4B5TYdT9nEffLlLUa7BHbaaAFblcBdFlA1uH96tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9fP+N6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3779EC4CEE7;
	Wed, 22 Oct 2025 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761129729;
	bh=fP5yx2bkDWUMYZyoqg2KA3bJxODxRSuv9A7iBDPTTNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9fP+N6DOJO7FFkNgQpdDLiuTOdU2VB0c2Sj91vdqmRqgKECbC9m9wwNvVYcYNXwl
	 fRqh+/uP7ez0/YLzTXHPO9nnsHG3+D8ryseTSClTw6OnVEkgwytElQYohPUx5jIe+L
	 vM6MjvjS2r8quPU45hgVl5GWpjDOcYf5CI+T4Mt/elWl72EzrT6SZ5WNln/+JGqPVS
	 CUbviADbZGoneEh+6K/Ws0LL3m2+MEEtx/g/izDWKrhRflxH7+YqibRC9iyu2CABJx
	 BQu8ow/WxcS2HVUwdnGtBYgcZf1g+r6nP2UdAg4QPj5EC8o30HuFChhX1e/EJcvUgy
	 EST+n41PqYujQ==
Date: Wed, 22 Oct 2025 11:42:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, quic_varada@quicinc.com
Subject: Re: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
Message-ID: <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
 <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yDD6QZe3iu15yXq9"
Content-Disposition: inline
In-Reply-To: <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
X-Cookie: Remember the... the... uhh.....


--yDD6QZe3iu15yXq9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:29:01PM +0530, Md Sadre Alam wrote:
> On 10/22/2025 12:39 AM, Mark Brown wrote:
> > On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
> > > IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same=
 as
> > > the one found in IPQ9574. So let's document the IPQ5424 compatible and
> > > use IPQ9574 as the fallback.

> > This doesn't apply against current code, please check and resend.

> Thank you for the feedback. I=E2=80=99d appreciate a bit more clarity on =
what
> =E2=80=9Cdoesn't apply against current code=E2=80=9D refers to in this co=
ntext. I=E2=80=99ve
> manually applied the patch against the latest mainline (torvalds/linux) a=
nd
> it applied cleanly without any conflicts. Please let me know if there=E2=
=80=99s a
> specific tree or integration point I should be checking against.

I tried to apply it to the spi tree

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.19

--yDD6QZe3iu15yXq9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj4tPkACgkQJNaLcl1U
h9BcKAf/Vuyo9/4fndX06ye8KTEa1FfUlq/YpJCWZJl8gAF5LG4YFmaz5flelTt2
rWWwJCsXj8q6sobLSsdBMwEEiqtuWkHoBfI3MDRxlnsh9cwoHhPecrtUwzy+SjA3
8uD77eS84VOHrFO5Oz7kdFkFkcRejx9oQvY7QzK+FaoaLG6DIEIVjcHBgLinfQ9n
Ser8cSWagEC+ocb0PokbMv1ySDo5J03kSoWFTPmOPA2PLspmQKh3VnZ59q2jXyjY
qJ8aLLBknoJ37V97AwgMrfFJH4pD7XD8tj34kk2ID2oBnKBzpBcxSxRCvpvet7cq
RizTaWS+Ol0c9aRW1hsFawxiEoEt7w==
=hYXk
-----END PGP SIGNATURE-----

--yDD6QZe3iu15yXq9--

