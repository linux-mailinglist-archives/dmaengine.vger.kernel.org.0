Return-Path: <dmaengine+bounces-4930-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A069A95C55
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 04:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5B31886C95
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B521645;
	Tue, 22 Apr 2025 02:49:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60F1531E9
	for <dmaengine@vger.kernel.org>; Tue, 22 Apr 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745290196; cv=none; b=mTmloo739kgNMcOV/SZ1Os5zVJLNKLUMagCKiKG1r7s0mdZ7Qu3U33jgNwk4QCoX8cGjrr1DXwCEhQiTmm8qttOCfJ+96BfOmUcXzd/Cl1SKipWqWW45VQB1h0KK1OxbzTtKiRfuyFvlQH9YMbIOuY4d3N6+jbR33Q1YGKNR+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745290196; c=relaxed/simple;
	bh=xYYP3tYhRP+JX4hNQNmmXMiWv8XMH4tFKOYL6r+tr2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qlKVyZIay0kZKHQLjSNudCoAmFT2jHu9JvaEYT9Eie5dHLYHBmS553yRph+ZrIVJyVtE8Va9Q2DjMKqnPgpDMNt1MW8CMF94M+2ZXI+Knbju92p9hsUySzJSbiHkXcCY0AnVpajbId7KwtY+XhZVxY/0cgvd99Uv0MLqKQlZ/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 22:49:49 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: dmaengine@vger.kernel.org
Cc: Zhang Wei <zw@zh-kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Message-ID: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
Mail-Followup-To: dmaengine@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufg4z4oabgkqbv5p"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--ufg4z4oabgkqbv5p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] fsldma: Support 40 bit DMA addresses where capable
MIME-Version: 1.0

On 64-bit QorIQ platforms like T4240, the CPU supports 40-bit addressing
and memory configurations > 64GiB. The fsldma driver is limiting itself
to only 64GiB in all Elo configurations.

Setup fsldma driver to make use of the full 40-bit addressing space,
specifically on the e5500 and e6500 CPUs.

Signed-off-by: Ben Collins <bcollins@kernel.org>
Cc: Zhang Wei <zw@zh-kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/fsldma.c | 2 +-
 drivers/dma/fsldma.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b5e7d18b97669..8c01963ad47d8 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1254,7 +1254,7 @@ static int fsldma_of_probe(struct platform_device *op)
 	fdev->common.directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	fdev->common.residue_granularity =3D DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
=20
-	dma_set_mask(&(op->dev), DMA_BIT_MASK(36));
+	dma_set_mask(&(op->dev), DMA_BIT_MASK(ELO_MAX_PHYS_BITS));
=20
 	platform_set_drvdata(op, fdev);
=20
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 308bed0a560ac..1e7bd37208412 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -13,6 +13,13 @@
 #include <linux/dmapool.h>
 #include <linux/dmaengine.h>
=20
+/* Physical addressing capability */
+#if defined(CONFIG_E6500_CPU) || defined(CONFIG_E5500_CPU)
+#define ELO_MAX_PHYS_BITS	40
+#else
+#define ELO_MAX_PHYS_BITS	36
+#endif
+
 /* Define data structures needed by Freescale
  * MPC8540 and MPC8349 DMA controller.
  */
--=20
2.49.0


--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--ufg4z4oabgkqbv5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmgHA80ACgkQXVpXxyQr
Is9JeQ/8Dko2O5Urq432buc/7ynFHW0W1g3CqE4IA+G6+v1Cxo9qzCL4+vprFp/m
zXuzz+9pWxlM/rwuq/YWe0ZaAaaqas/501/G8E9hxnIuPrtnzLhu5vJlRy2pvcvI
ArbCZR+oz8fxPu/DspUMMJ1L4yQBKWxzHBnwP/R//iHNQYnyTftf8baSk5A+u0Z+
L/SFJUDDuMEY/4duUNciKLSUVSdCOcQJoiBemG0ZcSXAAweiJCKYTuqYDbcd3tNB
8k/Qq8MOE5+5Y6lxmACRM4rRz80x21MomBcJSkoQYdiHF2jQcJtAr8GNSCYKXqJt
Zu93agKXbjCyPuc+GQwtFbVVE5VPqHgPoEiCTi6OVGBejkFJ9W+IctpSNrRm7ufv
UMWq2oXbu1h8lXp23WhV1Up03oMAaaQ9EQlu1bsMwfnS0tc8OJyXo2GcqSbAP/C8
bM86k0NWYnUDdFUbwfhyVAtcjGmukL0uqe5RLpQULmM7U3kNpm8QQirJpIKZBlJ3
UWYCRlxSO3ol15bQFMhIOVvHwl4Z7Zlm8WP4beTwicy8diA2j7Ij6JTTbMxP+5Qi
wbma1y2UqUyfq/QaRhOvqpYlxXaGDiohYziTrHPph2rlWYsaM/70VdwJT9CUKXmP
6tZu38Fj3IT5Ozhu9pnfXpjfNiBEXMu4gED/bfMoBFN2UHKdbF8=
=KEhy
-----END PGP SIGNATURE-----

--ufg4z4oabgkqbv5p--

