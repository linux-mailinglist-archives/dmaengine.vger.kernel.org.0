Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202185BFEEA
	for <lists+dmaengine@lfdr.de>; Wed, 21 Sep 2022 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiIUN0M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Sep 2022 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIUN0L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Sep 2022 09:26:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC97A539;
        Wed, 21 Sep 2022 06:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0418FB810AA;
        Wed, 21 Sep 2022 13:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29226C433D6;
        Wed, 21 Sep 2022 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663766767;
        bh=+wfYsp2xtCeuhYApN7yC7RNJT+HOL1bcyd1pFjfc0hc=;
        h=Date:From:To:Cc:Subject:From;
        b=aIdaEevZb/JningGmHtmM5dyWkBXCO9QospOTGcX4+1Rud8S4jUYvF4FUgK+4FVsT
         VS7bHFkSGoy/9B4Zv4Tn7SnwUPVmj2Et+Gydj8R2M9K5g3Q+wtmCQF+/FidBNeioI8
         4EzjpiOhGjhtUt8cDbno8wqyl1J/mL4dCK4vcKaHVThJpLMWRXvK5/AwAQKATv120M
         2UiMdLK3xS9MfKd5NnGgVyFmDctAZBKT93pCBYKUhV7rW+cnYDm5w2Q3gm9Jm7LFNj
         pu0iAf2jM283bNOsHHMRIXVy2o9C2np1g3QalSaWw6XfFpr1nK0sBpQCtAjSsXvxKA
         hZ5EoDiPCodfA==
Date:   Wed, 21 Sep 2022 18:56:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.0
Message-ID: <YysQ6+o7IqJUwTdY@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PT7C8PxsyWx/oBKW"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--PT7C8PxsyWx/oBKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to receive couple of small dmaengine driver fixes for v6.0.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.0

for you to fetch changes up to e0f1b21c504f050de83922dd49e6a425dad2d518:

  dmaengine: zynqmp_dma: Typecast with enum to fix the coverity warning (20=
22-09-05 11:54:50 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.0

Driver fixes for:
 - xilinx_dma: devm_platform_ioremap_resource error handling,
   dma_set_mask_and_coherent failure handling, dt property read cleanup
 - refcount leak fix for of_xudma_dev_get()
 - zynqmp_dma: coverity fix for enum typecast

----------------------------------------------------------------
Liang He (1):
      dmaengine: ti: k3-udma-private: Fix refcount leak bug in of_xudma_dev=
_get()

Shravya Kumbham (1):
      dmaengine: zynqmp_dma: Typecast with enum to fix the coverity warning

Swati Agarwal (3):
      dmaengine: xilinx_dma: Fix devm_platform_ioremap_resource error handl=
ing
      dmaengine: xilinx_dma: cleanup for fetching xlnx,num-fstores property
      dmaengine: xilinx_dma: Report error in case of dma_set_mask_and_coher=
ent API failure

 drivers/dma/ti/k3-udma-private.c |  6 +++---
 drivers/dma/xilinx/xilinx_dma.c  | 21 +++++++++++++--------
 drivers/dma/xilinx/zynqmp_dma.c  |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)


--=20
~Vinod

--PT7C8PxsyWx/oBKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmMrEOsACgkQfBQHDyUj
g0cMehAAl89JEbOA6sVbm/w9Px0JvaewHRhXR3auxfxzSXzHQlcuNcNJ/mlNZ9rX
i9WBt3jDu8/9eycvNsoDO2JfbDoVvQtpcpMkz2MPT2RGsIBdCR/0wI8h5aQalwgS
A8VCztJfuYnrdo+sBXZ3/0i9XkH4xhjrlMcOKwM3HBUDIY0OS/FmHKY6T4MZZkeU
VVN2d99hQH7sns/KU/llQbEZe3k5NWON+RZhXXTlW8ZhbARyvBMKbOKIofpPe+BJ
lOUJQlFKVh7MPUyST12MRwBLdJNSB/L5i1pkWQq/4XkLKG6P2RvkAIEC7KJzNkCW
v/jgxzxf6G1tBKu7E41I1C32n7RASK3WIgDtAXUO5HxvcP3cotrd1Qdx+O30xyDt
BnhHMNl+Y+npThJOS3jzGuSdVb8uAS3jT9VUezEyByHS39jzYodDiVhjCQSY2EC5
d65lM7UJVwuUJcfjW/MRpSQcekx8lLjnjGbLRQKG6ZObWAS+9EahRmEzPZmyJa8m
mriaWpD7EdFRlmZ43Bg0SwECAoBnYK+KWQV/9TEhDujJR1oLMqaMSFx6Z/O6VwKa
D53GV1cFjv2EIrzUpBTtKxwmVLu7rwHn7Q5lb0odvVhn6rdggAXybfW7zaiXkEyF
6Rdn0bzXXxjn4mU6XcpZR4Qw/PbPvIcbqnHU5gcE00KCops7ftQ=
=jc1h
-----END PGP SIGNATURE-----

--PT7C8PxsyWx/oBKW--
