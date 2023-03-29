Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5856CEC45
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjC2O6w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2O6v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 10:58:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED71A2113;
        Wed, 29 Mar 2023 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680101930; x=1711637930;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GN23CeAT5EHQB/8GlHtyJojqMc0q6OVj81+ZN6OvJJQ=;
  b=ZJ4gTLhHrB3HW+UnKQODjaISXRYwurbb+Ik73D1X67KvUTfAgqo1SGiU
   A4Hyk5RQW8q8ymMbAtSkpXQHLwYjVXk4gShiDkKqrSH6LCe5LPd3EMH/n
   GdTpDrH9GskFRrsQ/1KMpz6w7OCk/ltdKI4d7yOvLNzmGXR7qT2uD/tnf
   KQJLUW784t5j+3fNRvatfoz/UtJiPIGH1DRCkXQHJbYiK5AOHYdF28GZS
   0ZTkl/FZGSexY6GX3BiKPZELsCi50fyGmsunnCRuqG7WElMQfcmbhRBVZ
   iyGlcDDL6nt7XrpXGNML2ts3dwGrwD83rqw6PEboOaiQPb6id2xTd20Lh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368667517"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368667517"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="716908627"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="716908627"
Received: from allenhsi-mobl1.amr.corp.intel.com ([10.212.70.154])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:58:49 -0700
Message-ID: <e208af4cc343901ac5d9a0e5b4f21923623b266f.camel@linux.intel.com>
Subject: Re: [PATCH v2 10/15] crypto: iaa - Add per-cpu workqueue table with
 rebalancing
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     herbert@gondor.apana.org.au, fenghua.yu@intel.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Wed, 29 Mar 2023 09:58:48 -0500
In-Reply-To: <20230329075149.2736-1-hdanton@sina.com>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
         <20230329075149.2736-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgSGlsbGYsCgpPbiBXZWQsIDIwMjMtMDMtMjkgYXQgMTU6NTEgKzA4MDAsIEhpbGxmIERhbnRv
biB3cm90ZToKPiBPbiAyOCBNYXIgMjAyMyAxMDozNTozMCAtMDUwMCBUb20gWmFudXNzaQo+IDx0
b20uemFudXNzaUBsaW51eC5pbnRlbC5jb20+Cj4gPiArLyoKPiA+ICsgKiBHaXZlbiBhIGNwdSwg
ZmluZCB0aGUgY2xvc2VzdCBJQUEgaW5zdGFuY2UuwqAgVGhlIGlkZWEgaXMgdG8gdHJ5Cj4gPiB0
bwo+ID4gKyAqIGNob29zZSB0aGUgbW9zdCBhcHByb3ByaWF0ZSBJQUEgaW5zdGFuY2UgZm9yIGEg
Y2FsbGVyIGFuZAo+ID4gc3ByZWFkCj4gPiArICogYXZhaWxhYmxlIHdvcmtxdWV1ZXMgYXJvdW5k
IHRvIGNsaWVudHMuCj4gPiArICovCj4gPiArc3RhdGljIGlubGluZSBpbnQgY3B1X3RvX2lhYShp
bnQgY3B1KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoGludCBub2RlLCBuX2NwdXMgPSAwLCB0
ZXN0X2NwdSwgaWFhID0gMDsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCBucl9pYWFfcGVyX25vZGUs
IG5yX2NvcmVzX3Blcl9pYWE7Cj4gPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgY3B1bWFz
ayAqbm9kZV9jcHVzOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFucl9ub2RlcykKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoG5yX2lhYV9wZXJfbm9kZSA9IG5yX2lhYSAvIG5yX25vZGVzOwo+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKCFucl9pYWFfcGVyX25vZGUpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBucl9jb3Jlc19wZXJf
aWFhID0gbnJfY3B1c19wZXJfbm9kZSAvIG5yX2lhYV9wZXJfbm9kZTsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoGZvcl9lYWNoX29ubGluZV9ub2RlKG5vZGUpIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBub2RlX2NwdXMgPSBjcHVtYXNrX29mX25vZGUobm9kZSk7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFjcHVtYXNrX3Rlc3RfY3B1KGNwdSwg
bm9kZV9jcHVzKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY29udGludWU7Cj4gCj4gY3B1X3RvX25vZGUoY3B1KSB3b3JrcyBmb3IgeW91LgoKWWVz
LCB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0LgoKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF9jcHUodGVzdF9jcHUsIG5vZGVfY3B1cykgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKG5fY3B1
cyAlIG5yX2NwdXNfcGVyX25vZGUpID09IDApCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpYWEgPSBub2RlICogbnJfaWFh
X3Blcl9ub2RlOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAodGVzdF9jcHUgPT0gY3B1KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGlhYTsKPiAK
PiBHaXZlbiBucl9pYWFfcGVyX25vZGUsIHdoeSByb3VuZCByb2Jpbi1pbmcgZXZlcnkgaWFhIGlu
IHRoZSBub2RlIG5vdAo+IHdvcms/CgpUcnVlLCB3ZSBzaG91bGQgYmUgYWJsZSB0byBzaW1wbGlm
eSB0aGlzLCB3aWxsIGRvIGZvciB0aGUgbmV4dCB2ZXJzaW9uLgoKVGhhbmtzLAoKVG9tCgoKPiA+
ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbl9j
cHVzKys7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmICgobl9jcHVzICUgY3B1c19wZXJfaWFhKSA9PSAwKQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWFhKys7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKg
fQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIC0xOwo+ID4gK30KCg==

