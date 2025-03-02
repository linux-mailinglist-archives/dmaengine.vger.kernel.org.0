Return-Path: <dmaengine+bounces-4628-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3E6A4B3CC
	for <lists+dmaengine@lfdr.de>; Sun,  2 Mar 2025 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5771883464
	for <lists+dmaengine@lfdr.de>; Sun,  2 Mar 2025 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2161B6F30C;
	Sun,  2 Mar 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCezRRgr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7718EAB
	for <dmaengine@vger.kernel.org>; Sun,  2 Mar 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740936631; cv=none; b=QlbTiV4XwxWUxfMKuUcT/gsvvWEt2syuJzi7frtFj9oDY/4yokX6UP0XRlD1Ko2OnkCG5ZEpZDxB+kI4uwhmIqp00ySXVDNm8QmoEIXx/jWn7yRfOcmClqj5WkTDTETiS5wBlHowJAYrnMwPl8MH8xDeyfMwM/TBrweMqHBsElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740936631; c=relaxed/simple;
	bh=cd/PKLF644Rs83Ql9MGBPVOhlpw5lZPzlxkejHuxRf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G8btx6ZcyMDu19tTvIl1uScV4HDUB0xIdLf4JCw+X+vWkLw5ZUxwrh23X4z7vmxkjY9ajRrcuw3q+3FiwAeT0ROr4wztVYqxXsAY35oZK6EyLLTeIO6a16kqXOGtFG9x/rwSar91pMo2rpv/MR5OTjRxGFXGkAeY9B0Ibg35gOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCezRRgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CD4C4CED6;
	Sun,  2 Mar 2025 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740936630;
	bh=cd/PKLF644Rs83Ql9MGBPVOhlpw5lZPzlxkejHuxRf4=;
	h=Date:From:To:Cc:Subject:From;
	b=VCezRRgrCnJwEdXqg9eK58lbFvOQZx6ijxoi1iXAztzJlC5s4f3pB/PrL+SmKCXH4
	 GvKsEQOKdyDaa3zrNGOcx6Gh1MHhOhfEE4DKqxSL7hk0/fVyrQ8It/ClTASFLXHuzQ
	 XCGDJaEawNIf6Hq9G1a/JC8C+DMTxuHkhLSKSs6z/ehkl0H6iUQtUGSUPDEjQW0Haj
	 kpqZMwW+LN2G/YuVDqpYahx94vcyM7KwiuD23RlU2hdLpP6+NVvqJCj6hLPct10ioK
	 QIUVxiZQiNxxGPp5fyF0mm6Pp4dqRRVv4RpHHiFFp1t+pF43WzlheMSh6XqyIX+Fpj
	 X3FX8Ri96IIzQ==
Date: Sun, 2 Mar 2025 23:00:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dma <dmaengine@vger.kernel.org>
Subject: [GIT PULL]: Dmaengine subsystem fixes for v6.14
Message-ID: <Z8SVslyQKIe41xET@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZlibI7u8xkTFqHlV"
Content-Disposition: inline


--ZlibI7u8xkTFqHlV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive two fixes for tegra adma driver and revert of
one qcom patch causing regressions.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.14

for you to fetch changes up to e521f516716de7895acd1b5b7fac788214a390b9:

  dmaengine: Revert "dmaengine: qcom: bam_dma: Avoid writing unavailable re=
gister" (2025-02-27 13:29:15 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.14

Driver fixes for:
 - tegra210 adma div_u64 divison and max page fixes
 - Qualcomm Revert of unavailable register workaround which is causing
   regression, fixes have been proposed but still gaps are present so revert
   this for now

----------------------------------------------------------------
Caleb Connolly (1):
      dmaengine: Revert "dmaengine: qcom: bam_dma: Avoid writing unavailabl=
e register"

Mohan Kumar D (2):
      dmaengine: tegra210-adma: Use div_u64 for 64 bit division
      dmaengine: tegra210-adma: check for adma max page

 drivers/dma/qcom/bam_dma.c  | 24 ++++++++----------------
 drivers/dma/tegra210-adma.c | 20 ++++++++++++++++----
 2 files changed, 24 insertions(+), 20 deletions(-)

--=20
~Vinod

--ZlibI7u8xkTFqHlV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmfElbIACgkQfBQHDyUj
g0f/aRAArQfadrozBMn6Zeed4ItERRTBBo8vy+XySxG5zXDmiX1F7dQteCSM4SpW
awtcE7wVCo/hhYlj3dCUU8IWzjkZ4pfeUYHqJgyGu9qLspRrqTbosG+n57Ad1H3b
WOnO59mkxNjcWX/7461xOwziG1SOPIbeLLIqQisRmwC9QLgbvydMQJJC2lhote+i
RQ2f3uSH58imVtHq14heaDRcNyox3yNPnswS0XY91V8VDehkq+nWBocIsJ1Q/fIF
3eo5CCYdy+2Z9Bmfs8IuOhzO6anEU6IkT/TDVdDLx4jOtkyqvo51EQFE7xJZ9F7D
tEd8SW+gZtnDLC6mTDVIyB5j9ceFkFEkioAFQzhScLUknYwEQJl6MFYwfCRCxrvC
mi1m1j4G/pGEb83RuP7vbRJY/PD9YCAijOUkHr18eDW8DdQd5kuRXIhFS+XOw+wU
pFiwy55OGjWi8s5QELGJzMuwrR3wvnaxtX/eY0maOgmVwPRjyszxVl8k5DdHOCmi
lLy8TnhfIr6mH+7LHx/gs0CaKD7DjfWczvm0m3twpV507dva96WsJnHKV/iuWIlu
0PGvhGPKyT6hjR7fkoanCgcxkiXuek5+e1kUqZCeGOFENTq6oEUYU/qLZHZXAeqw
81mYorS1nUbajtNxUKYKbwRgB9XdkAvZsuWL8YIn1T39OiO1oTg=
=ppC5
-----END PGP SIGNATURE-----

--ZlibI7u8xkTFqHlV--

