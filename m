Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B06F1FF5
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 23:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjD1VHK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjD1VHJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 17:07:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0D10CF;
        Fri, 28 Apr 2023 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682716025; x=1714252025;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=j5yjbkrUnLbhgf5RqgvDiK85j0zR1x8IzFncQZH7CJE=;
  b=jRQEfN/LkUvD3iHkmSrfthV6Q78l9pyhTzSJAJxppUxJOFJupNz32sSe
   eem725bRH3ep0CqjPOYYVCrukFqgovI+X4iMLFLOirLnQpTuUB0gi8Cte
   KLvnVNNhSEewaytntzMZX2XFm7uFIcEX8lIjaec5mPpdiEt7pylqxQMd5
   ItZ/k248li2gY0Ld+gqNXeABmnK+26krkhd8aBqqFcivpzqEw1p6qLvXm
   ZPSa3sb76ukOPY2LStqxyQeanvHpOaBgotdMEafhZY71pW2NK2Qp+4F07
   looAAtEVxVo6+UD7UE5h+4fhNvubfaMz2UX+xsKtv3/V7rLV1abS7lhXi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="434151426"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="434151426"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 14:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="672330648"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="672330648"
Received: from sheilalo-mobl.amr.corp.intel.com (HELO ykaur1-mobl2.amr.corp.intel.com) ([10.209.181.29])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 14:07:02 -0700
Message-ID: <374d40f829001d0ea737e776f5f9dca8b311fffd.camel@linux.intel.com>
Subject: Re: [PATCH v3 15/15] crypto: iaa - Add IAA Compression Accelerator
 stats
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, herbert@gondor.apana.org.au,
        davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Fri, 28 Apr 2023 16:06:50 -0500
In-Reply-To: <7f257119-339b-1d42-4252-181f9666d78e@infradead.org>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
         <20230428205539.113902-16-tom.zanussi@linux.intel.com>
         <7f257119-339b-1d42-4252-181f9666d78e@infradead.org>
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

Hi Randy,

On Fri, 2023-04-28 at 14:00 -0700, Randy Dunlap wrote:
> Hi--
>=20
> On 4/28/23 13:55, Tom Zanussi wrote:
> > diff --git a/drivers/crypto/intel/iaa/Kconfig
> > b/drivers/crypto/intel/iaa/Kconfig
> > index fcccb6ff7e29..cffb3a4359fc 100644
> > --- a/drivers/crypto/intel/iaa/Kconfig
> > +++ b/drivers/crypto/intel/iaa/Kconfig
> > @@ -8,3 +8,12 @@ config CRYPTO_DEV_IAA_CRYPTO
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decompression wi=
th the Intel Analytics Accelerator (IAA)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hardware using t=
he cryptographic API.=C2=A0 If you choose 'M'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 here, the module=
 will be called iaa_crypto.
> > +
> > +config CRYPTO_DEV_IAA_CRYPTO_STATS
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Enable Intel(R) IAA Co=
mpression Accelerator
> > Statistics"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on CRYPTO_DEV_IAA_CR=
YPTO
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enable statisti=
cs for the IAA compression accelerator.
>=20
> The line above should use one tab + 2 spaces for indentation
> instead of bunch-of-spaces.

Yep, so much for consistency, will fix.  Thanks for pointing it out.

Tom

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 These include per-dev=
ice and per-workqueue statistics in
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addition to global dr=
iver statistics.
>=20
> Thanks.

