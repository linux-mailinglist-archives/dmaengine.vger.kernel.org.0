Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5116AE394
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 16:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCGPAR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 10:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCGO7t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 09:59:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB05BCA6;
        Tue,  7 Mar 2023 06:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678200266; x=1709736266;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=09LMIokz3K3q/AO4AUPcJkr6kxNE/r9pVmpCyTLCgbA=;
  b=DCUiCTIIRYVfjijnfKrlXzC8+3qUKpXJwqNAQ8B4RHej2dhj9aQVzzyl
   6jHr1m48Krxcn+KuuP/axm0CDii1fHNYg39L20E68rRgKqsny17T2Riaz
   Rhjwq1vNzC8OBsnFqPHrocxpkFb+/DJmyHwt+iOXR7iHop8p2C9sFix9e
   NUNxnDZIOeTOKOTiPQR+ZqSztTMICj5KNlnbOgUhA6nXTRs7aqbidvRBW
   V96gdzQL0LHHmUweiGKqOHfs+C0mvmy+ETNakoayKUqWGQQuU5MkIXSS1
   IzX46K0sq+yPV2+xwXJnKzGs+liJ4zUmHXSpciyNMbetGSgLvGJgDtiD7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334578547"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334578547"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 06:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626561830"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="626561830"
Received: from suchetam-mobl.amr.corp.intel.com ([10.212.53.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 06:44:24 -0800
Message-ID: <c0db70d6d68b35dbb979cc1e8b6ea57c60be88f4.camel@linux.intel.com>
Subject: Re: [PATCH 00/16] crypto: Add Intel Analytics Accelerator (IAA)
 crypto compression driver
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Tue, 07 Mar 2023 08:44:22 -0600
In-Reply-To: <ZAa7lS/eS1wWuXYp@gondor.apana.org.au>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
         <ZAa7lS/eS1wWuXYp@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Herbert,

On Tue, 2023-03-07 at 12:20 +0800, Herbert Xu wrote:
> On Mon, Mar 06, 2023 at 12:52:10PM -0600, Tom Zanussi wrote:
> > This series adds Linux crypto algorithm support for Intel=C2=AE In-
> > memory
> > Analytics Accelerator (Intel IAA) [1] hardware compression and
> > decompression, which is available on Sapphire Rapids systems.
>=20
> I haven't reviewed the patches yet, but could you please create
> a drivers/crypto/intel directory and put this driver in it?

Sure, I'll respin and move it there.

Thanks,

Tom

>=20
> Thanks,

