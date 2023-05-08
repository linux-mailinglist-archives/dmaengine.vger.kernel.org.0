Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29436FB90B
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 22:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjEHU43 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjEHU41 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 16:56:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF986BD;
        Mon,  8 May 2023 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683579370; x=1715115370;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QFP9WhtbudiCSMqQuH58GiD4k9Fn38XJ8vfoggmT+YM=;
  b=V5MUXSN/n/e412Wxu9pnrAonkIJkS+DOcagxLBGTEvbbpQ1QaIPU0T2h
   yq/Yme2IAXBTqlEcGigLgBoeVOx3jb1hXJ+k/rncbV0o3GgHKGvLoeaT3
   Sz26fMAIwkGpKgewGhAK0azIfhuS03ykN4mbTCauwaMvWaVZi2pq29f5G
   t2dNRmijpqKa3UMNUc63uUQStBGOheKfaDvtHS/fAhtV3zIIDkG8b9FTe
   JldvZWLnPr/h+KlOzpvaCTPbZHSz/ro9Heg62TAt1TXz+dspEjWqD3l6p
   OgPJkEL2q0hxFsig4v1W1Mb0Jy32YPdENdy5iGPznsS5qKUJ5oU0P8i82
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="413017336"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="413017336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="872921730"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="872921730"
Received: from aadepoju-mobl1.amr.corp.intel.com ([10.212.34.185])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:55:56 -0700
Message-ID: <5c2f8cd03b03627ca726ca2782887e501827ea7b.camel@linux.intel.com>
Subject: Re: [PATCH v4 06/15] dmaengine: idxd: Add wq private data accessors
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Mon, 08 May 2023 15:55:55 -0500
In-Reply-To: <2618f557-01a5-f76b-ad09-6eb0871cdf00@intel.com>
References: <cover.1683573703.git.zanussi@kernel.org>
         <038db785a87dc59c0073989633eee0205958cb67.1683573703.git.zanussi@kernel.org>
         <2618f557-01a5-f76b-ad09-6eb0871cdf00@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 2023-05-08 at 13:43 -0700, Dave Jiang wrote:
>=20
>=20
> On 5/8/23 1:07 PM, Tom Zanussi wrote:
> > Add the accessors set_idxd_wq_private() and idxd_wq_private()
> > allowing
> > users to set and retrieve a private void * associated with an
> > idxd_wq.
> >=20
> > The private data is stored in the idxd_dev.conf_dev associated with
> > each idxd_wq.
> >=20
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> > =C2=A0 drivers/dma/idxd/idxd.h | 10 ++++++++++
> > =C2=A0 1 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index 193552dea224..71cd4ca7d27a 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -552,6 +552,16 @@ static inline int idxd_wq_refcount(struct
> > idxd_wq *wq)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return wq->client_count=
;
> > =C2=A0 };
> > =C2=A0=20
> > +static inline void set_idxd_wq_private(struct idxd_wq *wq, void
> > *private)
>=20
> I would go with the same kernel naming convention:
>=20
> idxd_wq_set_private() and idxd_wq_get_private()?


Yeah, makes sense, will change.

Thanks,

Tom

> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_set_drvdata(wq_confdev(w=
q), private);
> > +}
> > +
> > +static inline void *idxd_wq_private(struct idxd_wq *wq)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return dev_get_drvdata(wq_co=
nfdev(wq));
> > +}
> > +
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Intel IAA does not support batch processing.
> > =C2=A0=C2=A0 * The max batch size of device, max batch size of wq and

