Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F166CC79C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjC1QN1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjC1QNZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 12:13:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1934EC58;
        Tue, 28 Mar 2023 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680020002; x=1711556002;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=h6IQc+GPCCBWGmCQX33CbJ7q86RgoAzJwDi0xEr2IyE=;
  b=IerDd9fJbIiNjpIXe2pN0tm1nafp1o885pLemZF4Q5CfnPtB/G4LZe6H
   vTI722h8zfJOCe82yB2ogIoqtPHDT5CbRyjlPsmabiLjyQqq2Q8JwkGSo
   5VkVyqcOl7PYqkWwrC7FM1sZoCzMdld5eNhXkKucNwySUGcTWsAPxVgTg
   Q+42mf4Y6UPXpKVI36qhnwYa5Exlf/xp+mcfmIka5D1cgAgDBoSLS6ymP
   pP1zQLC7FN6jk2oWmc/KEAjFRQVb+FbVk0Bvz8T03d7LLRF8iYriWqB85
   2/K46fJaRgwR8DRMXxrPZNoPn221JnlcV6J6xrDnmZF1ZX5UOpLWet46H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321015262"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="321015262"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="753212765"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="753212765"
Received: from sdwarak1-mobl.amr.corp.intel.com ([10.212.127.200])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 09:13:19 -0700
Message-ID: <556c167de09dd3c7bb470cde53660ae326126ad3.camel@linux.intel.com>
Subject: Re: [PATCH v2 06/15] dmaengine: idxd: Add private_data to struct
 idxd_wq
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org
Cc:     tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Tue, 28 Mar 2023 11:13:18 -0500
In-Reply-To: <c90984be-a426-7658-b128-67f90e4262da@intel.com>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
         <20230328153535.126223-7-tom.zanussi@linux.intel.com>
         <c90984be-a426-7658-b128-67f90e4262da@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 2023-03-28 at 09:06 -0700, Dave Jiang wrote:
>=20
>=20
> On 3/28/23 8:35 AM, Tom Zanussi wrote:
> > Add a void * to idxd_wqs for user-defined context data.
>=20
> I wonder if we should add accessor functions like get and set private
> data for the wq.
> >=20

Yeah, makes sense, will do that in v3.

Tom

> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> > =C2=A0 drivers/dma/idxd/idxd.h | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index 719f9f1662ad..e55213b5153e 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -216,6 +216,8 @@ struct idxd_wq {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 max_batch_size;
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char driver_name[WQ_NAM=
E_SIZE + 1];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *private_data;
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 struct idxd_engine {

