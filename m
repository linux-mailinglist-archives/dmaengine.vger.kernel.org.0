Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267F716E04
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 21:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjE3TuI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 15:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjE3TuH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 15:50:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9328CE8;
        Tue, 30 May 2023 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685476206; x=1717012206;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0n3ZEj8ND8L8MlrI41iz7g/Mm8JdRRHHjctjs0qDPKc=;
  b=C2dF7ZOlWju8cBZoVUZf1kXy62BABJi9lyae/Ad48QYgkFalYs+3X+R0
   vPEmbyD/afOZEjj/cZg7CRMr4w6AmzA2xdMhI/YH55eIayneqHQAvhxVP
   ynR5dlU/3bRBEDqLaat/8iuJK1N7JAfBTSWJhgOdxkEyQLwHXgLAOymjz
   c32Z2slxsmQ0k0foEOeaeNPAmxGAWqz511EXAUnbFvcdMw41UgMsa/Qqe
   nB9CO4NfmImqiLIV1jzNB9U9Togvj14Y7mKpgU4SwzTQ67TNL4TPSEBAc
   wuU2VgBw4VUGyrAVovwq2THYvV25YWl5Lb5c2ao6HcsagXN15KzdaRXmv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="352528600"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="352528600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 12:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="771691794"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="771691794"
Received: from lleonram-mobl.amr.corp.intel.com ([10.212.50.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 12:50:04 -0700
Message-ID: <1709001c3cba07ab058b602d628edff5ab72ada4.camel@linux.intel.com>
Subject: Re: [PATCH v5 13/15] crypto: iaa - Add support for default IAA
 'canned' compression mode
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Date:   Tue, 30 May 2023 14:50:03 -0500
In-Reply-To: <ZG6tun6TOYKr1nxK@gondor.apana.org.au>
References: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
         <20230516215009.51794-14-tom.zanussi@linux.intel.com>
         <ZG3dpbPlRXbF2ZxN@gondor.apana.org.au>
         <fa90e73483b866a0622ad077f4af16978d1c1c8d.camel@linux.intel.com>
         <ZG6tun6TOYKr1nxK@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Herbert,

On Thu, 2023-05-25 at 08:37 +0800, Herbert Xu wrote:
> On Wed, May 24, 2023 at 10:58:54AM -0500, Tom Zanussi wrote:
> >=20
> > Yes, I think you're right.=C2=A0 The reason we did it this way was that
> > we're expecting to add more modes, such as 'dynamic' and/or
> > 'canned-
> > dynamic' etc.
> >=20
> > But I don't see a reason we couldn't just register them all and
> > have
> > the user choose using the algorithm names, especially if that's the
> > way
> > crypto users expect things to work.
>=20
> Are these modes compatible with the deflate algorithm, that is,
> can the generic deflate uncompress the output of these modes and
> vice versa, can these modes uncompress the output of the generic
> algorithm?
>=20
> If they're all compatible, then you should just use the "deflate"
> algorithm name and use different driver names to differentiate them.
> But if they're not compatible then the modes should have distinct
> algorithm names.

Canned mode is not compatible with generic deflate.  Fixed mode is, but
due to history-window limitations in the hardware, only for buffers <=3D
4k, or that have been compressed using a <=3D 4k history window.

So it sounds like we need to use distinct algorithm names, which I'll
add in the next version.

Thanks,

Tom=20


>=20
> Cheers,

