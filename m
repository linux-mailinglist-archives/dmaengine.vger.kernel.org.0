Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3B6BF0B2
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 19:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCQS3E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCQS3D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 14:29:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7983E6;
        Fri, 17 Mar 2023 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679077742; x=1710613742;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Lps3yZe65I+TdcwDf8TkYYOh2/7Yhn32SE/ftofaovg=;
  b=PXwvRJDLaU92Oqt6Ott8J0AX0pS9134dxTzshvz1fZjQ2h3WI+J+g6oF
   C7TYHFoxtyTqxB6LL3XOpE8elgbjV8cHbmrI4ngoTDTHuiuJeOmQgfEhv
   2qS+cth7qFdEC8B+nUC1T+5bbRQGN2g1oZ+0hSURXQu2Fpyff95hNFhLh
   Vz30foyhOAZVGprXR0PEE72OyaRlPrYYRmWDC62i9mdEXsQrVBhLI8QfQ
   UXUJRC4d9zdS3Fldf7OPqjPOxQax/M9bDd6dxZkAgJESNgZlffJO97GgX
   wqL9uNt/kkMP/igp2Jq2UqiEf9vZvSgW4AjOnIcYNy6+YbxQxrLI6nDmS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="424605050"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424605050"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 11:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="744641796"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="744641796"
Received: from rasmith3-mobl1.amr.corp.intel.com ([10.212.49.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 11:28:58 -0700
Message-ID: <472cf360819845616daea229e9884cf9febf06e9.camel@linux.intel.com>
Subject: Re: [PATCH 12/16] crypto: iaa - Add support for iaa_crypto deflate
 compression algorithm
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Fri, 17 Mar 2023 13:28:54 -0500
In-Reply-To: <ZBPVxDSESihZ12tD@gondor.apana.org.au>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
         <20230306185226.26483-13-tom.zanussi@linux.intel.com>
         <ZBPVxDSESihZ12tD@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
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

SGkgSGVyYmVydCwKCk9uIEZyaSwgMjAyMy0wMy0xNyBhdCAxMDo1MSArMDgwMCwgSGVyYmVydCBY
dSB3cm90ZToKPiBPbiBNb24sIE1hciAwNiwgMjAyMyBhdCAxMjo1MjoyMlBNIC0wNjAwLCBUb20g
WmFudXNzaSB3cm90ZToKPiA+IAo+ID4gK3N0YXRpYyBzdHJ1Y3QgY3J5cHRvX2FsZyBpYWFfY29t
cF9kZWZsYXRlID0gewo+ID4gK8KgwqDCoMKgwqDCoMKgLmNyYV9uYW1lwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgPSAiZGVmbGF0ZSIsCj4gPiArwqDCoMKgwqDCoMKgwqAuY3JhX2RyaXZl
cl9uYW1lwqDCoMKgwqDCoMKgwqDCoD0gImlhYV9jcnlwdG8iLAo+ID4gK8KgwqDCoMKgwqDCoMKg
LmNyYV9mbGFnc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9IENSWVBUT19BTEdfVFlQRV9D
T01QUkVTUywKPiA+ICvCoMKgwqDCoMKgwqDCoC5jcmFfcHJpb3JpdHnCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgPSBJQUFfQUxHX1BSSU9SSVRZLAo+ID4gK8KgwqDCoMKgwqDCoMKgLmNyYV9tb2R1bGXC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gVEhJU19NT0RVTEUsCj4gPiArwqDCoMKgwqDCoMKg
wqAuY3JhX3XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9IHsKPiA+ICvCoMKg
wqDCoMKgwqDCoC5jb21wcmVzcyA9IHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgLmNvYV9jb21wcmVzc8KgwqDCoD0gaWFhX2NvbXBfY29tcHJlc3Ms
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5jb2Ff
ZGVjb21wcmVzc8KgPSBpYWFfY29tcF9kZWNvbXByZXNzCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gK307Cj4gCj4gUGxlYXNlIGFk
ZCBhbnkgbmV3IGNvZGUgdXNpbmcgdGhlIGxlZ2FjeSBjb21wcmVzc2lvbiBpbnRlcmZhY2UuCj4g
V2UncmUgdHJ5aW5nIHRvIHBoYXNlIHRoZW0gb3V0Lgo+IAo+IElmIHlvdXIgdXNlciBpcyBzdGls
bCB1c2luZyB0aGUgbGVnYWN5IGludGVyZmFjZSwgdGhleSBzaG91bGQKPiBiZSBjb252ZXJ0ZWQg
aW5zdGVhZC4KPiAKCk9LLCBJJ2xsIGp1c3QgcmVtb3ZlIHRoaXMgaW50ZXJmYWNlLiAgSXQgd2Fz
IGFkZGVkIHNvIElBQSBjb3VsZCBiZSB1c2VkCndpdGggenJhbSwgd2hpY2ggc3RpbGwgdXNlcyB0
aGUgb2xkIGludGVyZmFjZS4KCkknbGwgcGxheSBhcm91bmQgd2l0aCBzZWVpbmcgd2hhdCBpdCB3
b3VsZCB0YWtlIHRvIGdldCB6cmFtIHRvIHVzZSB0aGUKYXN5bmMgaW50ZXJmYWNlIGFsYSB6c3dh
cCwgYnV0IEknbSBndWVzc2luZyB0aGVyZSBtYXkgYmUgYSByZWFzb24gaXQKaGFzbid0IGJlZW4g
Y29udmVydGVkIHlldC4uLgoKVGhhbmtzLAoKVG9tCgo+IFRoYW5rcywKCg==

