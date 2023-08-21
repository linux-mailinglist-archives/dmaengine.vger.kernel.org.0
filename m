Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB67830B8
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHUTHF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHUTHE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 15:07:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33461A7;
        Mon, 21 Aug 2023 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692644819; x=1724180819;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AzYUF56KYLjDn+j3DUDhOX7zjcs5GRuZPf4C/b/5vDI=;
  b=Vf05S7kxGGe54+1o0TYEVNGbNrOKe9a4U8AO+oFNT6VAquYUeY84dAeb
   iHPj/Czn29zNTLE0HohUKEG8YCbTLt2NKsZUhF7QMkJ/sisy6UX0LXxlA
   zsc7d+EL9hALow2J4EHCLUtSK18nbsdmDS1q/VcFXcNPdXVi2LVCkuWKK
   1ChgzwI3iqOYmpbF3b69E7UC6rXq5jbxRk5VQNRUBIkc7A4cS4rvaszOZ
   cmhoL8EBV2ghCbBW5BSTwBD1djCEQSDBhUAoMW/i9XWChXs1lk47Yxifd
   E3ix16FzUxGGFBdoQzzr0jfbCNpDXh7yXyaStlpPGRG1hak2XNkiRkpEz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353985911"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353985911"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771067253"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="771067253"
Received: from puneetma-mobl.amr.corp.intel.com ([10.212.28.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:44:41 -0700
Message-ID: <2f80afbe7c586e7ee9a554787b5daf4f75e85aad.camel@linux.intel.com>
Subject: Re: [PATCH v8 08/14] crypto: iaa - Add IAA Compression Accelerator
 Documentation
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org, dave.jiang@intel.com,
        tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        vinodh.gopal@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Date:   Mon, 21 Aug 2023 13:44:33 -0500
In-Reply-To: <20230821172015.GB2227@bug>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
         <20230731212939.1391453-9-tom.zanussi@linux.intel.com>
         <20230821172015.GB2227@bug>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pavel,

On Mon, 2023-08-21 at 19:21 +0200, Pavel Machek wrote:
> Hi!
>=20
> > Because the IAA Compression Accelerator requires significant user
> > setup in order to be used properly, this adds documentation on the
> > iaa_crypto driver including setup, usage, and examples.
> >=20
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
>=20
>=20
> > +accel-config
> > +------------
> > +
> > +Unlike typical drivers, the iaa_crypto driver does not enable the
> > +device on driver load.=C2=A0 Due to complexity and configurability of
> > the
> > +accelerator devices, it was a design decision to have the user
> > +configure the device and manually enable the desired devices and
> > +workqueues.
>=20
> Is the driver really so special? Is it widely used besides of zswap?
> Could some kind of=20
> simple default configuration good enough for zswap be provided?

You're right, currently its main use is for zswap (though the original
submission also supported zram).

This idea of a simple default configuration makes sense and has come up
before. I'll try to come up with a good way to accomplish that in the
next revision.

>=20
> > +The userspace tool to help doing that is called accel-config.=C2=A0
> > Using
> > +accel-config to configure device or loading a previously saved
> > config
> > +is highly recommended.=C2=A0 The device can be controlled via sysfs
> > +directly but comes with the warning that do this ONLY if you know
> > +exactly what you are doing.=C2=A0 This document will not cover the
> > sysfs
> > +interface but assumes you will be using accel-config.
>=20
> Not covering the interface here is okay, but we really should have
> description somewhere,=20
> and there should be pointer to it here.

OK, yeah, that also makes sense - I'll add something for that too.

>=20
> > +++ b/Documentation/driver-api/crypto/iaa/index.rst
> > @@ -0,0 +1,20 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +IAA (Intel Analytics Accelerator)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +IAA provides hardware compression and decompression via the crypto
> > +API.
>=20
> Why is it called "analytics accelerator" when its main function is
> compression?
>=20

Well, the compression/decompression functions are only a part of what
the hardware provides, so I guess the designers used 'analytics
accelerator' as an umbrella term covering everything.

From the hardware documentation, the IAA hardware "provides very high
throughput compression and decompression combined with analytics
primitive functions. The analytic functions are commonly used for
filtering data during analytic query processing. It primarily targets
applications such as big-data and in-memory analytics databases, as
well as application-transparent usages such as memory page
compression."

Hope that helps explain the naming..

Tom


> Best regards,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 Pavel

