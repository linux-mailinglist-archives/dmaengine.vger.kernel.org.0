Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90A76D470
	for <lists+dmaengine@lfdr.de>; Wed,  2 Aug 2023 18:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHBQ7O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Aug 2023 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjHBQ7N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Aug 2023 12:59:13 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF31722;
        Wed,  2 Aug 2023 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690995552; x=1722531552;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PnEihLouVgEQF6fr1tXUyVnK2kwSa30L/oV+sw+DLmQ=;
  b=cWuxsg6Zep+a2VLdB0Vpq8cc0EwwCJ1fWhwv/0RKgeXFsz87+nrSQL/L
   Jcnfffbs96Ld9sR/G9JBSTUJEsUz5kZcuO77GnNNc2M1jy6zAJL04Ay9f
   FBFHw/elAn89xPUiic0+4gOtWp24R4hWiGrxPmhUxq4qwP8uLH66Z7jxU
   ZUi4U5qm0Oyua6kuBINlDKE4/ya6kxMd7iWI5VFPoOD95EnSxv78dd3QT
   a81xrOaIFsrTq7SZyd8CO/e45BaioJ/eCHNai5IW9FmvzLI8467yJ4o7O
   ncP30grTIQPtPekscSWZRjHQRY25d/cQFlv0oHa3GayC5JFJy18bZWXo2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359679861"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="359679861"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819289330"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="819289330"
Received: from blambach-mobl1.amr.corp.intel.com ([10.212.70.249])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:59:01 -0700
Message-ID: <e6a9cf300a9e70cb25c10fbfb7136309eb142db7.camel@linux.intel.com>
Subject: Re: [PATCH v8 01/14] dmaengine: idxd: add wq driver name support
 for accel-config user tool
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Wed, 02 Aug 2023 11:58:48 -0500
In-Reply-To: <ee824cb3-ad6a-01d0-90a5-aebc9fb4b12e@intel.com>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
         <20230731212939.1391453-2-tom.zanussi@linux.intel.com>
         <ee824cb3-ad6a-01d0-90a5-aebc9fb4b12e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 2023-08-02 at 08:17 -0700, Fenghua Yu wrote:
>=20
>=20
> On 7/31/23 14:29, Tom Zanussi wrote:
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
>=20
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>=20
> Thanks.
>=20
> -Fenghua

Thanks for all your reviews, Fenghua.

Tom
