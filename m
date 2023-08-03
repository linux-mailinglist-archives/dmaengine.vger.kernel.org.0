Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E876EC6B
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjHCOYi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbjHCOYY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 10:24:24 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C31724;
        Thu,  3 Aug 2023 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691072649; x=1722608649;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tFRYw8Q+81mVSTT6bgKjSWb+VfkhT+VSxAFYnR2CoDY=;
  b=OW3Zt+AvPgQT5EircoHwrGsFwzHK+GtsHfIOQCLLYhYzsCysQPkvxW1p
   +hrWQ9JyW4/+yc1Z5t4bsoVyS8Za7G0/yWIjyBcLWuTDyiRWufF3B7JIM
   a2TZF7TRxH//K2SdX6BvE7nQdLQxbJ7YKgMXSCUZUYVGS0IxaVWubViWQ
   KZxIEg0A5iNqs5HFd244V4HenKltVqzmQPqlPp4kx9oWJ+325wH5lCXwJ
   NdXzdTmFIWHVbdUzhG5m3n8Ou4oAtePaX/2hrbmfIbR0NsTriwG6GN3CZ
   y8miGYB/opV1KJeoaNnXXvCJTKzwRwFSqyhFEu+nbLVlZ8+YQCcE+3A12
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456262474"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="456262474"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="794996736"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="794996736"
Received: from jrobe13x-mobl1.amr.corp.intel.com ([10.209.135.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:24:07 -0700
Message-ID: <89596072f7fee8a877e08e01cf937136c4a39003.camel@linux.intel.com>
Subject: Re: [PATCH v8 03/14] dmaengine: idxd: Export drv_enable/disable and
 related functions
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Thu, 03 Aug 2023 09:24:07 -0500
In-Reply-To: <ZMuoi8FycD28v084@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
         <20230731212939.1391453-4-tom.zanussi@linux.intel.com>
         <ZMuoi8FycD28v084@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Thu, 2023-08-03 at 18:45 +0530, Vinod Koul wrote:
> On 31-07-23, 16:29, Tom Zanussi wrote:
> > To allow idxd sub-drivers to enable and disable wqs, export them.
> >=20
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> > =C2=A0drivers/dma/idxd/device.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> > index 5abbcc61c528..87ad95fa3f98 100644
> > --- a/drivers/dma/idxd/device.c
> > +++ b/drivers/dma/idxd/device.c
> > @@ -1505,6 +1505,7 @@ int drv_enable_wq(struct idxd_wq *wq)
> > =C2=A0err:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(drv_enable_wq, IDXD);
>=20
> Sorry this is a very generic symbol, pls dont export it. I would make
> it
> idxd_drv_enable_wq()

Yeah, good point, I'll do that for the next version.  And thanks for
all your Acks!

Tom

>=20
> > =C2=A0
> > =C2=A0void drv_disable_wq(struct idxd_wq *wq)
> > =C2=A0{
> > @@ -1526,6 +1527,7 @@ void drv_disable_wq(struct idxd_wq *wq)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq->type =3D IDXD_WQT_N=
ONE;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wq->client_count =3D 0;
> > =C2=A0}
> > +EXPORT_SYMBOL_NS_GPL(drv_disable_wq, IDXD);
> > =C2=A0
> > =C2=A0int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
> > =C2=A0{
> > --=20
> > 2.34.1
>=20

