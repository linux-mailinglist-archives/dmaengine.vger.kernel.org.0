Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8E57813F7
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 21:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbjHRT6E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Aug 2023 15:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377351AbjHRT5g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Aug 2023 15:57:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E891706;
        Fri, 18 Aug 2023 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692388655; x=1723924655;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=V4WpW+rF1CDAGv0xoSmYLLBjIk4md8XlrKmIlkSmnMA=;
  b=eGNXFKWSQHjVQV3IFjctfDLlSXXiELSR9HWz/LYQXAdhmkdNmXFGXZsj
   k5PMYFsz1yLGVdiAqiAScENeqOLJ81WU86b4mAfXGUwWoNLwlHqD8TINy
   LtwhdeZUGpJIpZ0RGNLHaVWP2XXJQRDKmX1yCXzqH26OvuzrCrbml69hN
   CkIjTnPVHz4ZsGliC4KuzK1V7dHsQQCcZTIu7ghY2faT4/mVz9fOhv8dx
   gCm9RHbcD+l11NQaiH4zj2PEBEkw6g0YvVLD8u7+perknNFfjfQdwjjTc
   YC1K4wH8YCH1oqhysV0y2r5Kr4TpBq/cPzp28PEkoyB5MVbkIP3u86HVC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="358161871"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="358161871"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 12:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="825260926"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="825260926"
Received: from ttkhuong-mobl5.amr.corp.intel.com ([10.212.75.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 12:56:53 -0700
Message-ID: <cbdaea86776bae824f34e3f81193a3e0a4d84270.camel@linux.intel.com>
Subject: Re: [PATCH v9 00/14] crypto: Add Intel Analytics Accelerator (IAA)
 crypto compression driver
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Fri, 18 Aug 2023 14:56:43 -0500
In-Reply-To: <ZN8yujTWN42vd2cF@gondor.apana.org.au>
References: <20230807203726.1682123-1-tom.zanussi@linux.intel.com>
         <ZN8yujTWN42vd2cF@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Herbert,

On Fri, 2023-08-18 at 16:58 +0800, Herbert Xu wrote:
> On Mon, Aug 07, 2023 at 03:37:12PM -0500, Tom Zanussi wrote:
> > Hi, this is v9 of the IAA crypto driver, incorporating feedback from
> > v8.
> >=20
> > v9 changes:
> >=20
> > =C2=A0 - Renamed drv_enable/disable_wq() to idxd_drv_enable/disable_wq(=
)
> > =C2=A0=C2=A0=C2=A0 and exported it, changing all existing callers as we=
ll as the
> > =C2=A0=C2=A0=C2=A0 iaa_crypto driver.
> >=20
> > =C2=A0 - While testing, ran into a use-after-free bug in the irq suppor=
t
> > =C2=A0=C2=A0=C2=A0 flagged by KASAN so fixed that up in iaa_compress() =
(added missing
> > =C2=A0=C2=A0=C2=A0 disable_async check).
> >=20
> > =C2=A0 - Also, while fixing the use-after-free bug, rearranged the out:
> > =C2=A0=C2=A0=C2=A0 part of iaa_desc_complete() to make it cleaner.
> >=20
> > =C2=A0 - Also for the verify cases, reversed the dma mapping by adding =
and
> > =C2=A0=C2=A0=C2=A0 calling a new iaa_remap_for_verify() function, since=
 verify
> > =C2=A0=C2=A0=C2=A0 basically does a decompress after reversing the src =
and dst
> > =C2=A0=C2=A0=C2=A0 buffers.
> >=20
> > =C2=A0 - Added new Acked-by and Reviewed-by tags.
>=20
> This adds a bunch of warnings for me:
>=20
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:2090:5: warning: no previou=
s prototype for =E2=80=98wq_stats_show=E2=80=99 [-Wmissing-prototypes]
> =C2=A02090 | int wq_stats_show(struct seq_file *m, void *v)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:2106:5: warning: no previou=
s prototype for =E2=80=98iaa_crypto_stats_reset=E2=80=99 [-Wmissing-prototy=
pes]
> =C2=A02106 | int iaa_crypto_stats_reset(void *data, u64 value)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~=
~~~~~~
>=20
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:38: warning: incorrect =
type in argument 1 (different base types)
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:38:=C2=A0=C2=A0=C2=A0 e=
xpected unsigned long [usertype] size
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:38:=C2=A0=C2=A0=C2=A0 g=
ot restricted gfp_t
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:58: warning: incorrect =
type in argument 2 (different base types)
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:58:=C2=A0=C2=A0=C2=A0 e=
xpected restricted gfp_t [usertype] flags
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:58:=C2=A0=C2=A0=C2=A0 g=
ot unsigned long
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:2090:5: warning: symbol 'wq=
_stats_show' was not declared. Should it be static?
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:2106:5: warning: symbol 'ia=
a_crypto_stats_reset' was not declared. Should it be static?
> ../drivers/crypto/intel/iaa/iaa_crypto_main.c:2028:13: warning: context i=
mbalance in 'iaa_crypto_remove' - different lock contexts for basic block
>=20
> ../drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c:10:11: warning: symbo=
l 'fixed_ll_sym' was not declared. Should it be static?
> ../drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c:49:11: warning: symbo=
l 'fixed_d_sym' was not declared. Should it be static?
>=20
> Please fix before resubmitting.
>=20
> Thanks,

OK, yeah, looks like I needed to do a make W=3D1 C=3D1 at least to catch th=
ese.
Will resubmit after doing that...

Thanks,

Tom=20
