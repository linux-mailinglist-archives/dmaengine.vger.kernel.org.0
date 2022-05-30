Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86038537429
	for <lists+dmaengine@lfdr.de>; Mon, 30 May 2022 06:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiE3Evj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 May 2022 00:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiE3Evj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 May 2022 00:51:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1089264E;
        Sun, 29 May 2022 21:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75AD8B80B96;
        Mon, 30 May 2022 04:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE47C3411A;
        Mon, 30 May 2022 04:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653886293;
        bh=OdMcpP1QXzbmaMEOQHSg0tJb1SXeGCoI1kdc4bMVi4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=it2mwnYJ8xtr0uGlPMBw2MLgegWAeoDm2Q4JMrnPgbMdP17Ow0RJ2oGDJXBPvcKIs
         4T9gA0qvbqj5YW9yL6j1DtYN0WQEbWnDiaJcT1mBXHOtLbxyzO6EM0jb5s+8VFOOKW
         i5qhrOEoRI9UmySrxkPYgaNKzMR368AqvJuogmuupUlMOlN6Brmy7hzf0D+13y1d7I
         zGRmZcsQgRFYojZEJzkkTVInQOwHE036MNSHHxi70d48MEMTysI/FrmY3vpUhLOwRI
         glukqhXPH/sJ+QQT3wcxbx3ouqDtfM3WZ9ogd59UM2Ixc06bxFrISfU4OUa/5p3h8f
         b6plth18ZFkpQ==
Date:   Mon, 30 May 2022 10:21:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: dmaengine updates for v5.19-rc1
Message-ID: <YpRNUK+Fi/YAXZd+@matsya>
References: <YpOyb40/g5gIYigF@matsya>
 <CAHk-=wgZtj6A7ggq7Ak5ZFwnLriGwU52NzC_3db5u+yLGJDJfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3kqsFapICUiohUto"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZtj6A7ggq7Ak5ZFwnLriGwU52NzC_3db5u+yLGJDJfA@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--3kqsFapICUiohUto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29-05-22, 11:49, Linus Torvalds wrote:
> On Sun, May 29, 2022 at 10:50 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > Please pull to receive the dmaengine updates for this cycle. Nothing
> > special, this includes a couple of new device support and new driver
> > support and bunch of driver updates.
>=20
> Vinod, _please_ report it when it turns out that there are semantic
> merge issues in linux-next.
>=20
> The whole point of linux-next is to report and find problems, but that
> also means that if the issues found in linux-next are then completely
> ignored, the _point_ of being in linux-next goes away.
>=20
> In particular, there was a semantic drivers/dma/idxd/device.c that git
> was perfectly happy to merge one way, but that needed manual
> intervention to get the locking right. See
>=20
>    https://lore.kernel.org/all/a6df0b8a-dc42-51e4-4b7b-62d1d11c7800@intel=
=2Ecom/
>=20
> and this is exactly the kind of thing that should be mentioned in the
> pull request, because no, I do not track every single merge issue in
> linux-next.
>=20
> I only catch them when something makes me go "Hmm", and in this case
> it was a different conflict near-by that just happened to make me look
> closer (the same one that Stephen had noted).
>=20
> Stephen makes this clear in his notifications:
>=20
>  "This is now fixed as far as linux-next is concerned, but any non
>   trivial conflicts should be mentioned to your upstream maintainer when
>   your tree is submitted for merging"
>=20
> and yes, the original merge was indeed trivial and wouldn't have
> needed any further mention had it _stayed_ that way.
>=20
> But it didn't actually stay that way, as pointed out by Dave Jiang in
> that thread.
>=20
> The fact that I caught it this time doesn't mean that I will catch
> things like this in general. I'm pretty good at merging, but there
> really is a reason linux-next exists.

Hi Linus,

Sorry about missing it, am not sure why I didn't add it here, usually I
do add. Apologies again for missing this and will ensure it won't be
missed again.

Yes merge had conflicts and linux-next had an updated and correct
resolution which should have been mentioned by me as was done in the
past. Will take steps to ensure I dont miss them.

Thanks
--=20
~Vinod

--3kqsFapICUiohUto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmKUTVAACgkQfBQHDyUj
g0cyuw//VnI7CrFYGTFjH0kb6X6VY1A84hKejQOuen/jpGNgXjsJPS8X+Xg2A/RY
0FTJt8Ib2G1zpcEu1E02rIjX+5mAt1oqrI0Rc+WM7uNZ+IxtVGetNcQ14Kv6+glQ
HGszmNzjl+yRbtaGw2XpHZqxCH2iDOx8bE7AZJFAVKpO4CJe8Sp/Sxh7VgEjdksA
N+Wp4iN9aa+ZD7GMUgJAYUkTKFRh6xrG8ySfOIimh9ipTONdJnoBcgcceZcVLxNk
EL44B7lejQmvJAHxxpeRYXbRovQNM49yV6yE3zWBAMaOVjDXMKicuraZpdJxfuNe
AQSq0Uq1AeI/NAN6p0ILhsYxAeE34v+4CUcBMPJMfv60wi916K/svd09VMC7E0+U
2bNAEkYRMMowy05B8AcqEDZ25IuFKSvB7pHdFYn0TJeK/hdw9T3RR/bb5ePzs0yY
NaLVb/ZXTNiPJSmKulFhcngDE3DXJiWzasbd9kB1YmDJNFMmYpsoULlhCoSQDHOj
q0/A8utV2Tb9vVxCs/gc64XCknIur4o2Xn3uyKWda9oO3Byuv0M2ZcDfYLX2wWyA
0aCp4E7eayAiSE3FCvzanydQ5fzHsSYrgs71TQzJF5PaTc3aLxecx+KgPee49Ks2
TBkgVuUgej3fYSFa/E11IuZwSO5DWqV9D2xLyz+9NHpYU6FIeb4=
=FpGz
-----END PGP SIGNATURE-----

--3kqsFapICUiohUto--
