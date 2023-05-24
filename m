Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E570FB16
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbjEXQAQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjEXP75 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 11:59:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2661BF;
        Wed, 24 May 2023 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684943950; x=1716479950;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cPGYkaqYYFhks3L/ld61pl5BucXJLtMRX9m+oGps24g=;
  b=bJpGP8kMa8OsqWF4aTrsKrZUQTXUlRVxiQFzahQPEgZd6eiPuoBak/3V
   u0ibW1GnpyGEPnIgbDw1CQlYj2x8Xi6rd9Pf+bMVfDq4IH/ty3GNtTXCa
   qUHereCMFPazfFpUqpE68j9BED2JscMFH/UYwabVkJcSBbAJpvB3ixZ4v
   GxHbccr54VvZfAvdVkmDR+q6ZVZ0vYFEO/ud/EHZnAPEVOvQkoGZh4Yyc
   oIrOB+NfZQ7t1s+xaaqj3MO1b4gAFvRxiIYN/1Gozno8FnlcMcGRrYAMh
   Lr2meMkzudaQwb9j28YStWwCsUYcwQmpNvJKWbUb4VPj9kWboell4Qled
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="356838057"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="356838057"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 08:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="707587010"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="707587010"
Received: from kesims-mobl1.amr.corp.intel.com ([10.209.176.111])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 08:58:57 -0700
Message-ID: <fa90e73483b866a0622ad077f4af16978d1c1c8d.camel@linux.intel.com>
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
Date:   Wed, 24 May 2023 10:58:54 -0500
In-Reply-To: <ZG3dpbPlRXbF2ZxN@gondor.apana.org.au>
References: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
         <20230516215009.51794-14-tom.zanussi@linux.intel.com>
         <ZG3dpbPlRXbF2ZxN@gondor.apana.org.au>
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

Hi Herbert,

On Wed, 2023-05-24 at 17:49 +0800, Herbert Xu wrote:
> On Tue, May 16, 2023 at 04:50:07PM -0500, Tom Zanussi wrote:
> .
> > To choose 'fixed' mode:
> >=20
> > =C2=A0 echo "fixed" >=C2=A0 /sys/bus/dsa/drivers/crypto/compression_mod=
e
> >=20
> > To choose 'canned' mode:
> >=20
> > =C2=A0 echo "canned" >=C2=A0 /sys/bus/dsa/drivers/crypto/compression_mo=
de
>=20
> This seems to be a strange way to switch modes.=C2=A0 How about just
> registering both algorithms and then let the user decide which
> one to use throught the algorithm name?
>=20

Yes, I think you're right.  The reason we did it this way was that
we're expecting to add more modes, such as 'dynamic' and/or 'canned-
dynamic' etc.

But I don't see a reason we couldn't just register them all and have
the user choose using the algorithm names, especially if that's the way
crypto users expect things to work.

Thanks,

Tom=20


