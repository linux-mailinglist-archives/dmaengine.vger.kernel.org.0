Return-Path: <dmaengine+bounces-375-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BE806090
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 22:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21411B2111E
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB26E599;
	Tue,  5 Dec 2023 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CE8MtzGk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08DA5;
	Tue,  5 Dec 2023 13:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811105; x=1733347105;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PkBerVl4dbb2PB7E3cusPFRah1wxFq0DwAavUWB2pBQ=;
  b=CE8MtzGkxcaVfxo6CKkeRJAdBA/6pFA50el2hdn2nydayzP+Cvs+A97h
   3GnK2i27KMzbQ43wZ8svqr+sECP5jCBpGcnjBj7xL3oog56KGjHFZ8HIq
   Oxh3PI263K6ZUNo+ksS3ubkTS3HCBlP8SBXzwdxXAYgJqjZIn4fT28Ee+
   Cvu0OsDKU/NOUlfboi0Ui1cy/DnDO16xtbzPILU27Q6Smhw8yAtkjAYzR
   8f8vxy0ZDXDtEWJOmCrEZ5WM+MPQsgSbW8WRlh3kwVKRuASTTLOr/Ihvp
   5GGqN1Dfe1POukz6C6XWwcm/+7Rbm9LDQTkRfAVf2pHZ17l65fAwOKi/6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7307864"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="7307864"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805407702"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="805407702"
Received: from jsamonte-mobl.amr.corp.intel.com ([10.212.71.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:18:21 -0800
Message-ID: <82bf4e15a8aa31a63d6bdb070b81d9e2dc2c7a78.camel@linux.intel.com>
Subject: Re: [PATCH v11 11/14] crypto: iaa - Add support for deflate-iaa
 compression algorithm
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Rex Zhang <rex.zhang@intel.com>
Cc: dave.jiang@intel.com, davem@davemloft.net, dmaengine@vger.kernel.org, 
 fenghua.yu@intel.com, giovanni.cabiddu@intel.com,
 herbert@gondor.apana.org.au,  james.guilford@intel.com,
 kanchana.p.sridhar@intel.com,  linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, pavel@ucw.cz,  tony.luck@intel.com,
 vinodh.gopal@intel.com, vkoul@kernel.org,  wajdi.k.feghali@intel.com
Date: Tue, 05 Dec 2023 15:18:20 -0600
In-Reply-To: <20231205022655.3616965-1-rex.zhang@intel.com>
References: <1a44f8396c6b7014de9b9bde4d5f5a4dbf0ef7a1.camel@linux.intel.com>
	 <20231205022655.3616965-1-rex.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUmV4LAoKT24gVHVlLCAyMDIzLTEyLTA1IGF0IDEwOjI2ICswODAwLCBSZXggWmhhbmcgd3Jv
dGU6Cj4gSGkgVG9tLAo+IAo+IE9uIDIwMjMtMTItMDQgYXQgMTU6NDE6NDYgLTA2MDAsIFRvbSBa
YW51c3NpIHdyb3RlOgo+ID4gSGkgUmV4LAo+ID4gCj4gPiBPbiBNb24sIDIwMjMtMTItMDQgYXQg
MjM6MDAgKzA4MDAsIFJleCBaaGFuZyB3cm90ZToKPiA+ID4gSGksIFRvbSwKPiA+ID4gCj4gPiA+
IE9uIDIwMjMtMTItMDEgYXQgMTQ6MTA6MzIgLTA2MDAsIFRvbSBaYW51c3NpIHdyb3RlOgo+ID4g
PiAKPiA+ID4gW3NuaXBdCj4gPiA+IAo+ID4gPiA+ICtzdGF0aWMgaW50IGlhYV93cV9wdXQoc3Ry
dWN0IGlkeGRfd3EgKndxKQo+ID4gPiA+ICt7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IGlkeGRfZGV2aWNlICppZHhkID0gd3EtPmlkeGQ7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3Ry
dWN0IGlhYV93cSAqaWFhX3dxOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGJvb2wgZnJlZSA9IGZh
bHNlOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGludCByZXQgPSAwOwo+ID4gPiA+ICsKPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqBzcGluX2xvY2soJmlkeGQtPmRldl9sb2NrKTsKPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqBpYWFfd3EgPSBpZHhkX3dxX2dldF9wcml2YXRlKHdxKTsKPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqBpZiAoaWFhX3dxKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlhYV93cS0+cmVmLS07Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmIChpYWFfd3EtPnJlZiA9PSAwICYmIGlhYV93cS0+cmVtb3ZlKSB7Cj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZyZWVfaWFhX3dx
KGlhYV93cSk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZHhkX3dxX3NldF9wcml2YXRlKHdxLCBOVUxMKTsKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZyZWUgPSB0cnVlOwo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlkeGRfd3FfcHV0KHdxKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB9
IGVsc2Ugewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAtRU5P
REVWOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBzcGlu
X3VubG9jaygmaWR4ZC0+ZGV2X2xvY2spOwo+ID4gPiBfX2ZyZWVfaWFhX3dxKCkgbWF5IGNhdXNl
IHNjaGVkdWxlLCB3aGV0aGVyIGl0IHNob3VsZCBiZSBtb3ZlIG91dAo+ID4gPiBvZgo+ID4gPiB0
aGUKPiA+ID4gY29udGV4dCBiZXR3ZWVuIHNwaW5fbG9jaygpIGFuZCBzcGluX3VubG9jaygpPwo+
ID4gCj4gPiBZZWFoLCBJIHN1cHBvc2UgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byBoYXZlIGl0IGJl
bG93IGFueXdheSwgd2lsbAo+ID4gbW92ZQo+ID4gaXQgdGhlcmUuCj4gPiAKPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqBpZiAoZnJlZSkKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKga2ZyZWUoaWFhX3dxKTsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
IHJldDsKPiA+ID4gPiArfQo+ID4gPiAKPiA+ID4gW3NuaXBdCj4gPiA+IAo+ID4gPiA+IEBAIC04
MDAsMTIgKzE3NjIsMzggQEAgc3RhdGljIHZvaWQgaWFhX2NyeXB0b19yZW1vdmUoc3RydWN0Cj4g
PiA+ID4gaWR4ZF9kZXYgKmlkeGRfZGV2KQo+ID4gPiA+IMKgCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoHJlbW92ZV9pYWFfd3Eod3EpOwo+ID4gPiA+IMKgCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
c3Bpbl9sb2NrKCZpZHhkLT5kZXZfbG9jayk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWFhX3dx
ID0gaWR4ZF93cV9nZXRfcHJpdmF0ZSh3cSk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFp
YWFfd3EpIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxv
Y2soJmlkeGQtPmRldl9sb2NrKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHJfZXJyKCIlczogbm8gaWFhX3dxIGF2YWlsYWJsZSB0byByZW1vdmVcbiIsCj4gPiA+ID4g
X19mdW5jX18pOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91
dDsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChpYWFfd3EtPnJlZikgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpYWFfd3EtPnJlbW92ZSA9IHRydWU7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNl
IHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd3EgPSBpYWFfd3EtPndx
Owo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZyZWVfaWFhX3dxKGlh
YV93cSk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlkeGRfd3Ffc2V0
X3ByaXZhdGUod3EsIE5VTEwpOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBmcmVlID0gdHJ1ZTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgc3Bpbl91bmxvY2soJmlkeGQtPmRldl9sb2NrKTsKPiA+ID4gX19mcmVlX2lhYV93cSgp
IG1heSBjYXVzZSBzY2hlZHVsZSwgd2hldGhlciBpdCBzaG91bGQgYmUgbW92ZSBvdXQKPiA+ID4g
b2YKPiA+ID4gdGhlCj4gPiA+IGNvbnRleHQgYmV0d2VlbiBzcGluX2xvY2soKSBhbmQgc3Bpbl91
bmxvY2soKT8KPiA+IAo+ID4gU2FtZS4KPiA+IAo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoZnJlZSkKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga2Zy
ZWUoaWFhX3dxKTsKPiA+ID4gPiArCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlkeGRfZHJ2X2Rp
c2FibGVfd3Eod3EpOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqByZWJhbGFuY2Vfd3FfdGFibGUo
KTsKPiA+ID4gPiDCoAo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChucl9pYWEgPT0gMCkKPiA+
ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAobnJfaWFhID09IDApIHsKPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWFhX2NyeXB0b19lbmFibGVkID0gZmFsc2U7Cj4gPiA+IElz
IGl0IG5lY2Vzc2FyeSB0byBhZGQgaWFhX3VucmVnaXN0ZXJfY29tcHJlc3Npb25fZGV2aWNlKCkg
aGVyZT8KPiA+ID4gQWxsIGlhYSBkZXZpY2VzIGFyZSBkaXNhYmxlZCBjYXVzZSB0aGUgdmFyaWFi
bGUgZmlyc3Rfd3Egd2lsbCBiZQo+ID4gPiB0cnVlLAo+ID4gPiBpZiBlbmFibGUgd3EsIGlhYV9y
ZWdpc3Rlcl9jb21wcmVzc2lvbl9kZXZpY2UoKSB3aWxsIGZhaWwgZHVlIHRvCj4gPiA+IHRoZQo+
ID4gPiBhbGdvcml0aG0gaXMgZXhpc3RlZC4KPiA+IAo+ID4gTm8sIHRoaXMgaXMgcmVxdWlyZWQg
YnkgcmV2aWV3IGlucHV0IGZyb20gYSBwcmV2aW91cyB2ZXJzaW9uIC0gdGhlCj4gPiBjb21wcmVz
c2lvbiBkZXZpY2UgY2FuIG9ubHkgYmUgdW5yZWdpc3RlcmVkIG9uIG1vZHVsZSBleGl0Lgo+IERv
IGl0IG1lYW4gZGlzYWJsaW5nIGFsbCBXUXMgZm9sbG93ZWQgYnkgZW5hYmxpbmcgV1EgaXMgdW5h
Y2NlcHRhYmxlPwo+IFVzZXIgbXVzdCBkbyAicm1tb2QgaWFhX2NyeXB0byIgYmVmb3JlIGVuYWJs
aW5nIFdRIGluIHRoaXMgY2FzZS4KPiAKClJpZ2h0LCBhcyBtZW50aW9uZWQgaW4gdGhlIGRvY3Vt
ZW50YXRpb246CgorSWYgYSBkaWZmZXJlbnQgY29uZmlndXJhdGlvbiBvciBzZXQgb2YgZHJpdmVy
IGF0dHJpYnV0ZXMgaXMgcmVxdWlyZWQsCit0aGUgdXNlciBtdXN0IGZpcnN0IGRpc2FibGUgdGhl
IElBQSBkZXZpY2VzIGFuZCB3b3JrcXVldWVzLCByZXNldCB0aGUKK2NvbmZpZ3VyYXRpb24sIGFu
ZCB0aGVuIHJlLXJlZ2lzdGVyIHRoZSBkZWZsYXRlLWlhYSBhbGdvcml0aG0gd2l0aCB0aGUKK2Ny
eXB0byBzdWJzeXN0ZW0gYnkgcmVtb3ZpbmcgYW5kIHJlaW5zZXJ0aW5nIHRoZSBpYWFfY3J5cHRv
IG1vZHVsZS4KClRoYW5rcywKClRvbQoKPiBUaGFua3MuCj4gPiAKPiA+IFRoYW5rcywKPiA+IAo+
ID4gVG9tCj4gPiAKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZyZWVf
d3FfdGFibGUoKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kdWxl
X3B1dChUSElTX01PRFVMRSk7Cj4gPiA+ID4gwqAKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcHJfaW5mbygiaWFhX2NyeXB0byBub3cgRElTQUJMRURcbiIpOwo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoH0KPiA+ID4gPiArb3V0Ogo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBt
dXRleF91bmxvY2soJmlhYV9kZXZpY2VzX2xvY2spOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBt
dXRleF91bmxvY2soJndxLT53cV9sb2NrKTsKPiA+ID4gPiDCoH0KPiA+ID4gCj4gPiA+IFtzbmlw
XQo+ID4gPiAKPiA+ID4gVGhhbmtzLAo+ID4gPiBSZXggWmhhbmcKPiA+ID4gPiAtLSAKPiA+ID4g
PiAyLjM0LjEKPiA+ID4gPiAKPiA+IAoK


