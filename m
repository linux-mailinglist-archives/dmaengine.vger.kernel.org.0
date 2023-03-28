Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B76CC796
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjC1QM3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjC1QM2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:12:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB5DBFF;
        Tue, 28 Mar 2023 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680019947; x=1711555947;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=f3W2k99ugrhZfz879CJs7D5zzXUdPgpcq+0Jxk3DQ9Y=;
  b=DpuJjBVH/E/IiYUbO9IyBu+xav1GTh6aMjhUiqbAc+HtgSDTjEEl0tiD
   2r4ViHaiD614eZ0D+dNAjlvuI/8YXzul2NuWe3LL+ylW7+30dMw9sq0Bm
   l1aKxeW5EadwTmpoj9yrWuXES82GEvmdfP13wp9tS1/krPymiea0hmTXT
   sC2OzVD97NO5C1kLKPQ552uPB/fEErBg1YywD+NjzUnmAYTKjKvXRcOqY
   +60kYgxUIioCCLb1k+B/rLGGWX9DT0YzvvlfAtxmiPRPFyAJKzZqz7vIs
   5HFtXuFJyDsavlab5QLb7xhhRI5Smo/EIMpAKZ8dVtfP4gh9dO2JLtZ13
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320265453"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="320265453"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:12:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="634100416"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="634100416"
Received: from sdwarak1-mobl.amr.corp.intel.com ([10.212.127.200])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:12:17 -0700
Message-ID: <7c2665ab7e8560f705eb9b6b21c5f6eeebd85eb8.camel@linux.intel.com>
Subject: Re: [PATCH v2 04/15] dmaengine: idxd: Export descriptor management
 functions
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Tue, 28 Mar 2023 11:12:16 -0500
In-Reply-To: <79d0618f-950c-f2f0-7286-41e199ba0edb@intel.com>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
         <20230328153535.126223-5-tom.zanussi@linux.intel.com>
         <79d0618f-950c-f2f0-7286-41e199ba0edb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dave,

On Tue, 2023-03-28 at 09:04 -0700, Dave Jiang wrote:
>=20
>=20
> On 3/28/23 8:35 AM, Tom Zanussi wrote:
> > To allow idxd sub-drivers to access the descriptor management
> > functions, export them.
> >=20
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> > =C2=A0 drivers/dma/idxd/submit.c | 3 +++
> > =C2=A0 1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> > index c01db23e3333..9d9ec0b76ccd 100644
> > --- a/drivers/dma/idxd/submit.c
> > +++ b/drivers/dma/idxd/submit.c
> > @@ -61,6 +61,7 @@ struct idxd_desc *idxd_alloc_desc(struct idxd_wq
> > *wq, enum idxd_op_type optype)
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __get_desc(wq, i=
dx, cpu);
> > =C2=A0 }
> > +EXPORT_SYMBOL_NS_GPL(idxd_alloc_desc, IDXD);
> > =C2=A0=20
> > =C2=A0 void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
> > =C2=A0 {
> > @@ -69,6 +70,7 @@ void idxd_free_desc(struct idxd_wq *wq, struct
> > idxd_desc *desc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc->cpu =3D -1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sbitmap_queue_clear(&wq=
->sbq, desc->id, cpu);
> > =C2=A0 }
> > +EXPORT_SYMBOL_NS_GPL(idxd_free_desc, IDXD);
> > =C2=A0=20
> > =C2=A0 static struct idxd_desc *list_abort_desc(struct idxd_wq *wq,
> > struct idxd_irq_entry *ie,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct idxd_desc *desc)
> > @@ -215,3 +217,4 @@ int idxd_submit_desc(struct idxd_wq *wq, struct
> > idxd_desc *desc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0percpu_ref_put(&wq->wq_=
active);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0 }
> > +EXPORT_SYMBOL_GPL(idxd_submit_desc);
>=20
> This one should use the EXPORT_SYMBOL_NS_GPL() as above?

Yeah, not sure how I missed that one ;-/

Thanks for pointing it out.

Tom

