Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E56F31BA
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjEAOBL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjEAOBJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 10:01:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A21510FC;
        Mon,  1 May 2023 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682949668; x=1714485668;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZgJxwxQNUm3eiCKrax81lV+9lJby3eUeSvSu4Z4cWpw=;
  b=bTtX8I7Tlpzl4k3uXnTdOwgZUSKI60cvVj52tzHc5x1Xe/EaJ7aFQCLj
   Q4XHRvRvhK59iomNJ7FgQO56DrhBXCb3PlC72qLC6Rro5mClo9gEzysLb
   MvM8QlcPX4iv+zsa/cwodFIkwQOtp4Z9u4NN2xII0qXEl0voVioTJ2Dj6
   DfjCSinZ//ryG1ExNezoWq6aCLQdXQVUIBWJycU78upFyd/yj+Mc2dfp8
   0dYjs5vYCJ9w5zm9VYUKY5omXtY3m1Zyt4SbblGLVpkPUTAiXchliNFhF
   2Etb3zRRsLMdWuo91VkBdDryfctq93qSEhu3zE24RxZi51vh/IAD2Pah9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="413582120"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="413582120"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="942045094"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="942045094"
Received: from jplee-mobl1.amr.corp.intel.com ([10.213.190.187])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 07:01:05 -0700
Message-ID: <6835178f8f58f6fce7797953f64c3f4c959d6ade.camel@linux.intel.com>
Subject: Re: [PATCH v3 01/15] dmaengine: idxd: add wq driver name support
 for accel-config user tool
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Mon, 01 May 2023 09:01:04 -0500
In-Reply-To: <d886d1dd-51c8-d2e6-940b-9e5041707c6e@intel.com>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
         <20230428205539.113902-2-tom.zanussi@linux.intel.com>
         <d886d1dd-51c8-d2e6-940b-9e5041707c6e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fenghua,

On Fri, 2023-04-28 at 17:14 -0700, Fenghua Yu wrote:
> Hi, Tom,
>=20
> On 4/28/23 13:55, Tom Zanussi wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> >=20
> > With the possibility of multiple wq drivers that can be bound to
> > the wq,
> > the user config tool accel-config needs a way to know which wq
> > driver to
> > bind to the wq. Introduce per wq driver_name sysfs attribute where
> > the user
> > can indicate the driver to be bound to the wq. This allows accel-
> > config to
> > just bind to the driver using wq->driver_name.
> >=20
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
>=20
> ...
>=20
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index 7ced8d283d98..505118fc19de 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -214,6 +214,8 @@ struct idxd_wq {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char name[WQ_NAME_SIZE =
+ 1];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 max_xfer_bytes;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 max_batch_size;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char driver_name[WQ_NAME_SIZ=
E + 1];
>=20
> It's confused to use "WQ_NAME_SIZE" for driver name size.
> Maybe it's better to have a new definition "DRIVER_NAME_SIZE"?
> BTW, WQ_NAME_SIZE is 1024 which is unnecessary big for storing=20
> driver_name[] in the structure. It would be better to have a smaller=20
> size (e.g. 128) in DRIVER_NAME_SIZE.

Yes, that makes sense - I'll add an IAA_DRIVER_NAME_SIZE of 128 and use
that instead.

Thanks,

Tom

>=20
> Thanks.
>=20
> -Fenghua

