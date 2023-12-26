Return-Path: <dmaengine+bounces-667-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E981EA3D
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 23:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B17B21F0D
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 22:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3E5231;
	Tue, 26 Dec 2023 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6nIaN5P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357E5226;
	Tue, 26 Dec 2023 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703628251; x=1735164251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=I9zkG0D8DsELGnzC//5KXTVJFDnTFMkoRzDTPM21iP0=;
  b=B6nIaN5P/ymQtRkY6SXefLdfLQ0QBm55o2OfnL+mqNf9El4FyPzFeLv2
   w+GmMicFwTJG6uXlLmhLyjCm2yPqO6d3YTXPHAI6jsWplmJ7TUJ4k8AkR
   pyvoGADYe8zZey7B8c7L0oZUrh2It75C9RIxO8ljWQdXEa2OR9+ilGQ3l
   o6iR9Byg8QJIYD+PUJcWpINOrEqndyJtkuAcq8TS+6moRa/FzBWpZWFUN
   wLyniVxX8iqXw2PfucQHnAF1morrZr9j+QlWfywq6DyJoLC8V3n89ozlD
   tvoDtCY8skmzQ5BnA22q/M9GBQEO8vk7LoDDb/b8ng7toD/Hts8ACRyPu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="396116661"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="396116661"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 14:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="754275163"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="754275163"
Received: from smorga5x-mobl.amr.corp.intel.com ([10.212.113.189])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 14:04:08 -0800
Message-ID: <62ec89d8633a9a6814d502eb0a9d44714659d06a.camel@linux.intel.com>
Subject: Re: [PATCH] crypto: iaa - Account for cpu-less numa nodes
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, herbert@gondor.apana.org.au, 
	davem@davemloft.net, fenghua.yu@intel.com
Cc: rex.zhang@intel.com, dave.jiang@intel.com, tony.luck@intel.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org
Date: Tue, 26 Dec 2023 16:04:07 -0600
In-Reply-To: <ba080e23-18b1-4ab5-baa8-62bc09a98e38@infradead.org>
References: <00e3eea06f5dde61734a53af797b190692060aab.camel@linux.intel.com>
	 <ba080e23-18b1-4ab5-baa8-62bc09a98e38@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUmFuZHksCgpPbiBUdWUsIDIwMjMtMTItMjYgYXQgMTM6MDkgLTA4MDAsIFJhbmR5IER1bmxh
cCB3cm90ZToKPiBIaS0tCj4gCj4gT24gMTIvMjYvMjMgMTI6NTMsIFRvbSBaYW51c3NpIHdyb3Rl
Ogo+ID4gSW4gc29tZSBjb25maWd1cmF0aW9ucyBlLmcuIHN5c3RlbXMgd2l0aCBDWEwsIGEgbnVt
YSBub2RlIGNhbiBoYXZlCj4gPiAwCj4gPiBjcHVzIGFuZCBjcHVtYXNrX250aCgpIHdpbGwgcmV0
dXJuIGEgY3B1IHZhbHVlIHRoYXQgZG9lc24ndCBleGlzdCwKPiA+IHdoaWNoIHdpbGwgcmVzdWx0
IGluIGFuIGF0dGVtcHQgdG8gYWRkIGFuIGVudHJ5IHRvIHRoZSB3cSB0YWJsZSBhdAo+ID4gYQo+
ID4gYmFkIGluZGV4Lgo+ID4gCj4gPiBUbyBmaXggdGhpcywgd2hlbiBpdGVyYXRpbmcgdGhlIGNw
dXMgZm9yIGEgbm9kZSwgc2tpcCBhbnkgbm9kZSB0aGF0Cj4gPiBkb2Vzbid0IGhhdmUgY3B1cy4K
PiA+IAo+ID4gQWxzbywgYXMgYSBwcmVjYXV0aW9uLCBhZGQgYSB3YXJuaW5nIGFuZCBiYWlsIGlm
IGNwdW1hc2tfbnRoKCkKPiA+IHJldHVybnMKPiA+IGEgbm9uZXhpc3RlbnQgY3B1Lgo+ID4gCj4g
PiBSZXBvcnRlZC1ieTogWmhhbmcsIFJleCA8cmV4LnpoYW5nQGludGVsLmNvbT4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFRvbSBaYW51c3NpIDx0b20uemFudXNzaUBsaW51eC5pbnRlbC5jb20+Cj4gPiAt
LS0KPiA+IMKgZHJpdmVycy9jcnlwdG8vaW50ZWwvaWFhL2lhYV9jcnlwdG9fbWFpbi5jIHwgMTQg
KysrKysrKysrKystLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9pbnRlbC9p
YWEvaWFhX2NyeXB0b19tYWluLmMKPiA+IGIvZHJpdmVycy9jcnlwdG8vaW50ZWwvaWFhL2lhYV9j
cnlwdG9fbWFpbi5jCj4gPiBpbmRleCA1MDkzMzYxYjAxMDcuLjc4MjE1N2E3NDA0MyAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2ludGVsL2lhYS9pYWFfY3J5cHRvX21haW4uYwo+ID4g
KysrIGIvZHJpdmVycy9jcnlwdG8vaW50ZWwvaWFhL2lhYV9jcnlwdG9fbWFpbi5jCj4gPiBAQCAt
MTAxNywxMiArMTAxNywxNyBAQCBzdGF0aWMgdm9pZCByZWJhbGFuY2Vfd3FfdGFibGUodm9pZCkK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoH0KPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF9vbmxpbmVfbm9kZShu
b2RlKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF9ub2RlX3dpdGhfY3B1cyhub2RlKSB7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5vZGVfY3B1cyA9IGNwdW1hc2tf
b2Zfbm9kZShub2RlKTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGZvciAoY3B1ID0gMDsgY3B1IDwgbnJfY3B1c19wZXJfbm9kZTsgY3B1KyspIHsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBub2RlX2NwdSA9
IGNwdW1hc2tfbnRoKGNwdSwgbm9kZV9jcHVzKTsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChXQVJOX09OKG5vZGVfY3B1ID49IG5y
X2NwdV9pZHMpKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9kZWJ1Zygibm9kZV9jcHUgJWQgZG9lc24ndAo+ID4g
ZXhpc3QhXG4iLCBub2RlX2NwdSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgoY3B1ICUgY3B1c19wZXJf
aWFhKSA9PSAwKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlhYSsrOwo+ID4gwqAKPiA+IEBAIC0yMDk1LDEwICsyMTAw
LDEzIEBAIHN0YXRpYyBzdHJ1Y3QgaWR4ZF9kZXZpY2VfZHJpdmVyCj4gPiBpYWFfY3J5cHRvX2Ry
aXZlciA9IHsKPiA+IMKgc3RhdGljIGludCBfX2luaXQgaWFhX2NyeXB0b19pbml0X21vZHVsZSh2
b2lkKQo+ID4gwqB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaW50IHJldCA9IDA7Cj4gPiArwqDCoMKg
wqDCoMKgwqBpbnQgbm9kZTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgbnJfY3B1cyA9IG51
bV9vbmxpbmVfY3B1cygpOwo+ID4gLcKgwqDCoMKgwqDCoMKgbnJfbm9kZXMgPSBudW1fb25saW5l
X25vZGVzKCk7Cj4gPiAtwqDCoMKgwqDCoMKgwqBucl9jcHVzX3Blcl9ub2RlID0gbnJfY3B1cyAv
IG5yX25vZGVzOwo+ID4gK8KgwqDCoMKgwqDCoMKgZm9yX2VhY2hfbm9kZV93aXRoX2NwdXMobm9k
ZSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBucl9ub2RlcysrOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKG5yX25vZGVzKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG5yX2NwdXNfcGVyX25vZGUgPSBucl9jcHVzIC8gbnJfbm9kZXM7Cj4gCj4gSWYgbnJfbm9k
ZXMgPT0gMCwgbnJfY3B1c19wZXJfbm9kZSBpcyBub3QgaW5pdGlhbGl6ZWQgaGVyZS4KPiBJcyBp
dCBpbml0aWFsaXplZCBzb21ld2hlcmUgZWxzZSwgb3IganVzdCBub3QgdXNlZCBpZiBucl9ub2Rl
cyBpcyAwPwo+IAoKbnJfY3B1c19wZXJfbm9kZSBpcyBpbml0aWFsaXplZCB0byAwIGVsc2V3aGVy
ZSAoYXMgYSBzdGF0aWMgZ2xvYmFsKS4KCkl0IHNlZW1zIHRvIG1lIG5yX25vZGVzIHNob3VsZCBh
bHdheXMgYmUgYXQgbGVhc3QgMS4gIEZyb20gbXkgdGVzdGluZwp3aXRoICFDT05GSUdfTlVNQSwg
bnJfbm9kZXMgaXMgc2V0IHRvIDEgaW4gdGhhdCBjYXNlOyBub3Qgc3VyZSBob3cgeW91CmNhbiBn
ZXQgYWN0dWFsbHkgZ2V0IG5yX25vZGVzID09IDAgaWYgeW91IGhhdmUgYW55IGNwdXMgd29ya2lu
Zy4gIFRoZQpjaGVjayBpcyB0aGVyZSB0byBhdm9pZCBkaXZpZGluZyBieSAwIGJ1dCBtYXliZSB0
aGUgcmlnaHQgdGhpbmcgdG8gaXMKQlVHX09OKCFucl9ub2RlcykgYW5kIHJldHVybiBhbiBlcnJv
ciwgYW5kIHJlbW92ZSB0aGF0IGNoZWNrLi4uCgpUaGFua3MsCgpUb20KCj4gPiDCoAo+ID4gwqDC
oMKgwqDCoMKgwqDCoGlmIChjcnlwdG9faGFzX2NvbXAoImRlZmxhdGUtZ2VuZXJpYyIsIDAsIDAp
KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZWZsYXRlX2dlbmVyaWNfdGZt
ID0gY3J5cHRvX2FsbG9jX2NvbXAoImRlZmxhdGUtCj4gPiBnZW5lcmljIiwgMCwgMCk7Cj4gCgot
LSAKVG9tIFphbnVzc2kgPHRvbS56YW51c3NpQGxpbnV4LmludGVsLmNvbT4K


