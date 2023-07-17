Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7B756EF7
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jul 2023 23:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGQVfy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jul 2023 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGQVfx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jul 2023 17:35:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8B136;
        Mon, 17 Jul 2023 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689629752; x=1721165752;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/X3yf/fgnUoNZLjdw4lAL7DnzoCEqFem7VCwiUrXYp4=;
  b=PsaK8EW7j/NyZL4itkqlfLYyyO61OmblyVm49ngSY1xlHF5SQlLInI4f
   imRx2E1ezKWdjjwrqjwzJrTsxmMqK6wfWEh+iuiFIPhyZEHy/kcx4ijZC
   o9O3O8TSdjJpVr1Dr6RdL1CToPD3IH6Bfyme2Bat9wmhL3jWWAZnk1Lnr
   AwQPATDJHJjTlHBo7ndGWLRl0z+jZWFmXZuYy2NqDtHozeuBcnGV9ekcN
   NH/OAE8ny5rK219RSLUIgGuA/85PMFcnyCnUyggXIA7R/kz40Yht5ufM3
   gHGdojXqBdGzyMmuNyHR9xIXAWSbEMnWDV3vCJMAkeupP/OLPFrw9uqse
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452420991"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452420991"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 14:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723352048"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723352048"
Received: from pakella-mobl.amr.corp.intel.com ([10.212.74.90])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 14:35:50 -0700
Message-ID: <79989c1537c66a90eca5339028ed447b3805e906.camel@linux.intel.com>
Subject: Re: [PATCH v7 12/14] crypto: iaa - Add support for deflate-iaa
 compression algorithm
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Rex Zhang <rex.zhang@intel.com>
Cc:     dave.jiang@intel.com, davem@davemloft.net,
        dmaengine@vger.kernel.org, fenghua.yu@intel.com,
        giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, vinodh.gopal@intel.com, vkoul@kernel.org,
        wajdi.k.feghali@intel.com
Date:   Mon, 17 Jul 2023 16:35:39 -0500
In-Reply-To: <20230717021203.3541437-1-rex.zhang@intel.com>
References: <20230710190654.299639-13-tom.zanussi@linux.intel.com>
         <20230717021203.3541437-1-rex.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
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

SGkgUmV4LAoKT24gTW9uLCAyMDIzLTA3LTE3IGF0IDEwOjEyICswODAwLCBSZXggWmhhbmcgd3Jv
dGU6Cj4gSGksIFRvbSwKPiAKCltzbmlwXQoKPiA+ICsKPiA+ICtzdGF0aWMgaW50IGlhYV9jb21w
X2Fjb21wcmVzcyhzdHJ1Y3QgYWNvbXBfcmVxICpyZXEpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDC
oMKgc3RydWN0IGlhYV9jb21wcmVzc2lvbl9jdHggKmNvbXByZXNzaW9uX2N0eDsKPiA+ICvCoMKg
wqDCoMKgwqDCoHN0cnVjdCBjcnlwdG9fdGZtICp0Zm0gPSByZXEtPmJhc2UudGZtOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgZG1hX2FkZHJfdCBzcmNfYWRkciwgZHN0X2FkZHI7Cj4gPiArwqDCoMKgwqDC
oMKgwqBpbnQgbnJfc2dzLCBjcHUsIHJldCA9IDA7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
aWFhX3dxICppYWFfd3E7Cj4gPiArwqDCoMKgwqDCoMKgwqB1MzIgY29tcHJlc3Npb25fY3JjOwo+
ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGlkeGRfd3EgKndxOwo+ID4gK8KgwqDCoMKgwqDCoMKg
c3RydWN0IGRldmljZSAqZGV2Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgY29tcHJlc3Npb25f
Y3R4ID0gY3J5cHRvX3RmbV9jdHgodGZtKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICgh
aWFhX2NyeXB0b19lbmFibGVkKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cHJfZGVidWcoImlhYV9jcnlwdG8gZGlzYWJsZWQsIG5vdCBjb21wcmVzc2luZ1xuIik7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9ERVY7Cj4gPiArwqDCoMKg
wqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXJlcS0+c3JjIHx8ICFyZXEt
PnNsZW4pIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9kZWJ1ZygiaW52
YWxpZCBzcmMsIG5vdCBjb21wcmVzc2luZ1xuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiAr
wqDCoMKgwqDCoMKgwqBjcHUgPSBnZXRfY3B1KCk7Cj4gPiArwqDCoMKgwqDCoMKgwqB3cSA9IHdx
X3RhYmxlX25leHRfd3EoY3B1KTsKPiA+ICvCoMKgwqDCoMKgwqDCoHB1dF9jcHUoKTsKPiA+ICvC
oMKgwqDCoMKgwqDCoGlmICghd3EpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwcl9kZWJ1Zygibm8gd3EgY29uZmlndXJlZCBmb3IgY3B1PSVkXG4iLCBjcHUpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOwo+ID4gK8KgwqDCoMKg
wqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gaWFhX3dxX2dldCh3cSk7Cj4g
PiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcHJfZGVidWcoIm5vIHdxIGF2YWlsYWJsZSBmb3IgY3B1PSVkXG4iLCBjcHUpOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOwo+ID4gK8KgwqDC
oMKgwqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgaWFhX3dxID0gaWR4ZF93cV9nZXRf
cHJpdmF0ZSh3cSk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXJlcS0+ZHN0KSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ2ZwX3QgZmxhZ3MgPSByZXEtPmZsYWdz
ICYgQ1JZUFRPX1RGTV9SRVFfTUFZX1NMRUVQID8gR0ZQX0tFUk5FTCA6IEdGUF9BVE9NSUM7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogaW5jb21wcmVzc2libGUgZGF0YSB3
aWxsIGFsd2F5cyBiZSA8IDIgKiBzbGVuICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmVxLT5kbGVuID0gMiAqIHJlcS0+c2xlbjsKPiAyICogcmVxLT5zbGVuIGlzIGFuIGVz
dGltYXRlZCBzaXplIGZvciBkc3QgYnVmLiBXaGVuIHNsZW4gaXMgZ3JlYXRlcgo+IHRoYW4gMjA0
OCBieXRlcywgZGxlbiBpcyBncmVhdGVyIHRoYW4gNDA5NiBieXRlcy4KClJpZ2h0LCBzbyB5b3Un
cmUgc2F5aW5nIHRoYXQgYmVjYXVzZSBzZ2xfYWxsb2MgdXNlcyBvcmRlciAwLCB0aGlzIGNvdWxk
CnJlc3VsdCBpbiBucl9zZ3MgPiAxLiAgQ291bGQgYWxzbyBqdXN0IGNoYW5nZSB0aGlzIHRvIHNn
X2luaXRfb25lIGxpa2UKYWxsIHRoZSBvdGhlciBjYWxsZXJzLgoKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXEtPmRzdCA9IHNnbF9hbGxvYyhyZXEtPmRsZW4sIGZsYWdzLCBO
VUxMKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJlcS0+ZHN0KSB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9
IC1FTk9NRU07Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gb3V0Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvC
oMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGRldiA9ICZ3cS0+aWR4ZC0+
cGRldi0+ZGV2Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgbnJfc2dzID0gZG1hX21hcF9zZyhk
ZXYsIHJlcS0+c3JjLCBzZ19uZW50cyhyZXEtPnNyYyksIERNQV9UT19ERVZJQ0UpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKG5yX3NncyA8PSAwIHx8IG5yX3NncyA+IDEpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZGJnKGRldiwgImNvdWxkbid0IG1hcCBzcmMgc2cg
Zm9yIGlhYSBkZXZpY2UgJWQsIgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAiIHdxICVkOiByZXQ9JWRcbiIsIGlhYV93cS0+aWFhX2RldmljZS0+aWR4
ZC0+aWQsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlhYV93cS0+d3EtPmlkLCByZXQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldCA9IC1FSU87Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7
Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqBzcmNfYWRkciA9IHNnX2Rt
YV9hZGRyZXNzKHJlcS0+c3JjKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGRldl9kYmcoZGV2LCAiZG1h
X21hcF9zZywgc3JjX2FkZHIgJWxseCwgbnJfc2dzICVkLCByZXEtPnNyYyAlcCwiCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIiByZXEtPnNsZW4gJWQsIHNnX2RtYV9sZW4oc2cp
ICVkXG4iLCBzcmNfYWRkciwgbnJfc2dzLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJlcS0+c3JjLCByZXEtPnNsZW4sIHNnX2RtYV9sZW4ocmVxLT5zcmMpKTsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoG5yX3NncyA9IGRtYV9tYXBfc2coZGV2LCByZXEtPmRzdCwgc2dfbmVu
dHMocmVxLT5kc3QpLCBETUFfRlJPTV9ERVZJQ0UpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKG5y
X3NncyA8PSAwIHx8IG5yX3NncyA+IDEpIHsKPiB3aGVuIGRsZW4gaXMgZ3JlYXRlciB0aGFuIDQw
OTYgYnl0ZXMsIG5yX3NncyBtYXliZSBncmVhdGVyIHRoYW4gMSwKPiBidXQgdGhlIGFjdHVhbCBv
dXRwdXQgc2l6ZSBtYXliZSBsZXNzIHRoYW4gNDA5NiBieXRlcy4KPiBJbiBvdGhlciB3b3Jkcywg
dGhlIGNvbmRpdGlvbiBucl9zZ3MgPiAxIG1heSBibG9jayBhIGNhc2Ugd2hpY2ggY291bGQKPiBo
YXZlIGJlZW4gZG9uZS4KCkN1cnJlbnRseSBhbGwgZXhpc3RpbmcgY2FsbGVycyB1c2Ugc2dfaW5p
dF9vbmUoKSwgc28gbnJfc2dzIGlzIG5ldmVyID4KMS4gIEJ1dCB5ZXMsIHdlIHNob3VsZCBhZGQg
Y29kZSB0byBiZSBhYmxlIHRvIGhhbmRsZSA+IDEsIEkgYWdyZWUuCgpUaGFua3MsCgpUb20KCgo=

