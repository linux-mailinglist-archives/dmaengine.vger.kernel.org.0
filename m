Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEFD6D9B06
	for <lists+dmaengine@lfdr.de>; Thu,  6 Apr 2023 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbjDFOrW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Apr 2023 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbjDFOrD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Apr 2023 10:47:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819FC8A5B;
        Thu,  6 Apr 2023 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680792342; x=1712328342;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wKLD3ul2fnQNnbci3vu7fUACYJnL7Pb0yr2YSwJ4YfE=;
  b=A2m8dlFAIZ8suroi3kz8QDGKbyYDtx6flW4MyIOO8hCnDi6IZcZAzOVr
   inEwSxAJf8yFsQGjOWAOlR2qtYXOeS86METfwccLwYoWY2NjyjV2V4nzA
   V5raNxMCCt1YiyBuYvL6k1e5y+tRCFlqVjuc7o4CG6FC5u9lOuoq8Vyt9
   f3DYh7lBx7ZmhIl7MUzwYNGFz72yJWP0OFUbquz7OTE59QsS+/etr4/cf
   xUQhnhOPSvRf5NDTZ+jPQZv3pLh4rPblHshJPOaNFrRl3jtqHb7Qk2V+s
   GGvrlu3zqb+zeHBnChL7G84Mu+Ncrf/ovd3G9DEeq0SkpL9UYhKF6o0TT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="326817273"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="326817273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 07:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861424812"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861424812"
Received: from akshayph-mobl.amr.corp.intel.com ([10.212.115.108])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 07:43:41 -0700
Message-ID: <0b95f8b723f50395ee325ff5475e5d5189776928.camel@linux.intel.com>
Subject: Re: [PATCH v2 12/15] crypto: iaa - Add support for iaa_crypto
 deflate compression algorithm
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Date:   Thu, 06 Apr 2023 09:43:40 -0500
In-Reply-To: <ZC58JggIXgpJ1tpD@gondor.apana.org.au>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
         <20230328153535.126223-13-tom.zanussi@linux.intel.com>
         <ZC58JggIXgpJ1tpD@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Herbert,

On Thu, 2023-04-06 at 16:00 +0800, Herbert Xu wrote:
> On Tue, Mar 28, 2023 at 10:35:32AM -0500, Tom Zanussi wrote:
> >=20
> > @@ -881,12 +1574,26 @@ static int iaa_crypto_probe(struct idxd_dev
> > *idxd_dev)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rebalance_wq_table();
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (first_wq) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0iaa_crypto_enabled =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D iaa_register_compression_device();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret !=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iaa_cr=
ypto_enabled =3D false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_db=
g(dev, "IAA compression device
> > registration failed\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto e=
rr_register;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_info("iaa_crypto now ENABLED\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
>=20
> Sorry for picking on your driver but I've got to start somewhere :)

No problem, thanks for reviewing the code. ;-)

>=20
> A long standing problem shared by almost all crypto drivers is that
> the hardware removal handling is completely broken.
>=20
> This is because hardware can be removed at any time, including during
> a crypto operatin.=C2=A0 So drivers must work carefully around that fact.
>=20
> Here is a recipe for dealing with this safely:
>=20
> 1) Never unregister your crypto algorithms, even after the last
> piece of hardware has been unplugged.=C2=A0 The algorithms should only
> be unregistered (if they have been registered through the first
> successful probe call) in the module unload function.
>=20
> 2) Never free any software state for your hardware without some form
> of synchronisation with oustanding operations.
>=20
> Any mechanism would do, for example, you could use a spinlock if the
> critical path isn't very long.=C2=A0 The operational path would take the
> lock, check the hardware state, and if present proceed with the
> operation (but still being prepared to cope if the hardware goes
> AWAL because even if the driver state is still present the actual
> hardware may be gone already).
>=20
> Then the removal path would simply take the spinlock, set a flag
> indicating the hardware is gone and then you could safely unlock
> and free your driver states.
>=20

OK, yeah, thanks for pointing this out along with the detailed
explanation and remedy.  Will take care of this in the next version.

Tom

> Thanks,

