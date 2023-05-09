Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDD6FCD90
	for <lists+dmaengine@lfdr.de>; Tue,  9 May 2023 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEISRf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 May 2023 14:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEISRe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 May 2023 14:17:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1BE56;
        Tue,  9 May 2023 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683656254; x=1715192254;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+zof/M4BrnkXcaqZnvlv0ayjo/OkY4a8oPbzI+2bvgw=;
  b=UDTMJIWGf1W1UyvCQljrRYawh5S2hiaz+TBGHbi66PHzYnEANYs2hH6F
   6xaEiQTkOndGuWl66DXX2hAdb5lyHl2J6gI9Xvvf5yfZUAObH6TtPGOW0
   3d7dPXWPzeL7idk3oI0vxxxNOP9ES01Lj9EHPmifFBdIy8Qz4mNhkKz5P
   r3hH05KSFvC50tO4F7jW0a57icCOtae+lM/Pmd5VnNGua7QEbTuCV882F
   0voERed0oS3stzmnrCQExRIi/oi5hdb1xX6TTpgt1sGc0J3uS5nuASgWl
   s605rWXhK1dm3OiUOzZr2+QBKo0mZGAT3HhnYNCHe5PHYzcPBw0WU128z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="348848993"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="348848993"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 11:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="763958071"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="763958071"
Received: from acyuen-mobl4.amr.corp.intel.com ([10.212.1.251])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 11:17:30 -0700
Message-ID: <16d1abf15c99929c794f32d750b358d1c0981c18.camel@linux.intel.com>
Subject: Re: [PATCH v4 01/15] dmaengine: idxd: add wq driver name support
 for accel-config user tool
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Date:   Tue, 09 May 2023 13:17:29 -0500
In-Reply-To: <d9bad7c2-14d7-7f06-da50-81069853babd@intel.com>
References: <cover.1683573703.git.zanussi@kernel.org>
         <a874741f266f57502d671843b9d4a9b563c372e3.1683573703.git.zanussi@kernel.org>
         <d9bad7c2-14d7-7f06-da50-81069853babd@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTA5IGF0IDEwOjQ4IC0wNzAwLCBGZW5naHVhIFl1IHdyb3RlOgo+IEhp
LCBUb20sCj4gCj4gT24gNS84LzIzIDEzOjA3LCBUb20gWmFudXNzaSB3cm90ZToKPiA+IEZyb206
IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPgo+ID4gCj4gPiBXaXRoIHRoZSBwb3Nz
aWJpbGl0eSBvZiBtdWx0aXBsZSB3cSBkcml2ZXJzIHRoYXQgY2FuIGJlIGJvdW5kIHRvCj4gPiB0
aGUgd3EsCj4gPiB0aGUgdXNlciBjb25maWcgdG9vbCBhY2NlbC1jb25maWcgbmVlZHMgYSB3YXkg
dG8ga25vdyB3aGljaCB3cQo+ID4gZHJpdmVyIHRvCj4gPiBiaW5kIHRvIHRoZSB3cS4gSW50cm9k
dWNlIHBlciB3cSBkcml2ZXJfbmFtZSBzeXNmcyBhdHRyaWJ1dGUgd2hlcmUKPiA+IHRoZSB1c2Vy
Cj4gPiBjYW4gaW5kaWNhdGUgdGhlIGRyaXZlciB0byBiZSBib3VuZCB0byB0aGUgd3EuIFRoaXMg
YWxsb3dzIGFjY2VsLQo+ID4gY29uZmlnIHRvCj4gPiBqdXN0IGJpbmQgdG8gdGhlIGRyaXZlciB1
c2luZyB3cS0+ZHJpdmVyX25hbWUuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IERhdmUgSmlhbmcg
PGRhdmUuamlhbmdAaW50ZWwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogVG9tIFphbnVzc2kgPHRv
bS56YW51c3NpQGxpbnV4LmludGVsLmNvbT4KPiA+IC0tLQo+ID4gwqAgLi4uL0FCSS9zdGFibGUv
c3lzZnMtZHJpdmVyLWRtYS1pZHhkwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKysKPiA+IMKg
IGRyaXZlcnMvZG1hL2lkeGQvY2Rldi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDggKysrKysrCj4gPiDCoCBkcml2ZXJzL2RtYS9pZHhkL2RtYS5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKysrCj4g
PiDCoCBkcml2ZXJzL2RtYS9pZHhkL2lkeGQuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA5ICsrKysrKwo+ID4gwqAgZHJpdmVycy9kbWEvaWR4ZC9zeXNm
cy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjgKPiA+ICsr
KysrKysrKysrKysrKysrKysKPiA+IMKgIGluY2x1ZGUvdWFwaS9saW51eC9pZHhkLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiA+IMKgIDYgZmlsZXMg
Y2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWRyaXZlci1kbWEtaWR4ZAo+ID4gYi9Eb2N1bWVudGF0aW9u
L0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLWRtYS1pZHhkCj4gPiBpbmRleCAzYmVjYzlhODJiZGYu
LmQ1ZGFhZTQ0MmZlNyAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9z
eXNmcy1kcml2ZXItZG1hLWlkeGQKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9z
eXNmcy1kcml2ZXItZG1hLWlkeGQKPiA+IEBAIC0yNDQsNiArMjQ0LDEyIEBAIERlc2NyaXB0aW9u
OsKgwqDCoMKgwqDCoMKgU2hvd3MgdGhlIG9wZXJhdGlvbgo+ID4gY2FwYWJpbGl0eSBiaXRzIGRp
c3BsYXllZCBpbiBiaXRtYXAgZm9ybWF0Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGNvcnJlbGF0ZXMgdG8gdGhlIG9wZXJhdGlvbnMgYWxsb3dlZC4gSXQncyB2aXNpYmxlCj4g
PiBvbmx5Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9uIHBsYXRmb3JtcyB0
aGF0IHN1cHBvcnQgdGhlIGNhcGFiaWxpdHkuCj4gPiDCoCAKPiA+ICtXaGF0OsKgwqDCoMKgwqDC
oMKgwqDCoMKgL3N5cy9idXMvZHNhL2RldmljZXMvd3E8bT4uPG4+L2RyaXZlcl9uYW1lCj4gPiAr
RGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoE1hciAyNywgMjAyMyA+ICtLZXJuZWxWZXJzaW9uOsKg
wqA2LjQuMAo+IAo+IE5lZWQgdG8gYmUgY2hhbmdlZCB0byA2LjUuMCBub3c6KQoKWWVzLCB3aWxs
IGNoYW5nZS4KCj4gCj4gQWZ0ZXIgZml4aW5nIHRoZSBLZXJuZWxWZXJzaW9uLAo+IAo+IFJldmll
d2VkLWJ5OiBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVsLmNvbT4KPiAKClRoYW5rcyBmb3Ig
eW91ciByZXZpZXcocykuCgpUb20KCj4gVGhhbmtzLgo+IAo+IC1GZW5naHVhCgo=

