Return-Path: <dmaengine+bounces-371-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAC280410F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 22:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A9A1C2089B
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE373364A9;
	Mon,  4 Dec 2023 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZarKMOo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF8CD;
	Mon,  4 Dec 2023 13:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701726112; x=1733262112;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LmkQ/GVzARR4KIazKM+AGTrOdRG5DNS4B+7VUdZwYh8=;
  b=gZarKMOobacdQrlJm5k2VFyWcixdeiVjt4EBbHG6ugBQqWYEOlCgvQV7
   h6BVZuCcBGEuyxQw2VUWuw74U2cegDKD3FFK4IZota+6NcpA41/1zoNS+
   oxa+ZNWrLSWvMIL3no9bRj3jcrX8oRzrJ7WH6hGKAzbZaQTidDRNV1/6M
   TfxfpdOOEqPu1TgTq3NjQd1Foi72kpOn/KFQVZ6PUieDnU644h1JB/2GS
   hh7U3cANmlAxQy0rFDNsD2h/2NwFPOlgfXVm6cQ7Rg6PPxf36ouDdkO59
   9AOT5kfLrS/tEdLZgOgRnqekXsQ1Xcl3fLekK5xMrcGAITe6fjJp196un
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378828969"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="378828969"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841205531"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="841205531"
Received: from jabboud-mobl1.amr.corp.intel.com ([10.212.85.103])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:41:47 -0800
Message-ID: <1a44f8396c6b7014de9b9bde4d5f5a4dbf0ef7a1.camel@linux.intel.com>
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
Date: Mon, 04 Dec 2023 15:41:46 -0600
In-Reply-To: <20231204150028.3544490-1-rex.zhang@intel.com>
References: <20231201201035.172465-12-tom.zanussi@linux.intel.com>
	 <20231204150028.3544490-1-rex.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUmV4LAoKT24gTW9uLCAyMDIzLTEyLTA0IGF0IDIzOjAwICswODAwLCBSZXggWmhhbmcgd3Jv
dGU6Cj4gSGksIFRvbSwKPiAKPiBPbiAyMDIzLTEyLTAxIGF0IDE0OjEwOjMyIC0wNjAwLCBUb20g
WmFudXNzaSB3cm90ZToKPiAKPiBbc25pcF0KPiAKPiA+ICtzdGF0aWMgaW50IGlhYV93cV9wdXQo
c3RydWN0IGlkeGRfd3EgKndxKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBpZHhk
X2RldmljZSAqaWR4ZCA9IHdxLT5pZHhkOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGlhYV93
cSAqaWFhX3dxOwo+ID4gK8KgwqDCoMKgwqDCoMKgYm9vbCBmcmVlID0gZmFsc2U7Cj4gPiArwqDC
oMKgwqDCoMKgwqBpbnQgcmV0ID0gMDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHNwaW5fbG9j
aygmaWR4ZC0+ZGV2X2xvY2spOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWFhX3dxID0gaWR4ZF93cV9n
ZXRfcHJpdmF0ZSh3cSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoaWFhX3dxKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWFhX3dxLT5yZWYtLTsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaWFhX3dxLT5yZWYgPT0gMCAmJiBpYWFfd3EtPnJlbW92
ZSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBf
X2ZyZWVfaWFhX3dxKGlhYV93cSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlkeGRfd3Ffc2V0X3ByaXZhdGUod3EsIE5VTEwpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcmVlID0gdHJ1ZTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWR4ZF93cV9wdXQod3EpOwo+ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAtRU5PREVWOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2soJmlkeGQtPmRldl9s
b2NrKTsKPiBfX2ZyZWVfaWFhX3dxKCkgbWF5IGNhdXNlIHNjaGVkdWxlLCB3aGV0aGVyIGl0IHNo
b3VsZCBiZSBtb3ZlIG91dCBvZgo+IHRoZQo+IGNvbnRleHQgYmV0d2VlbiBzcGluX2xvY2soKSBh
bmQgc3Bpbl91bmxvY2soKT8KClllYWgsIEkgc3VwcG9zZSBpdCBtYWtlcyBtb3JlIHNlbnNlIHRv
IGhhdmUgaXQgYmVsb3cgYW55d2F5LCB3aWxsIG1vdmUKaXQgdGhlcmUuCgo+ID4gK8KgwqDCoMKg
wqDCoMKgaWYgKGZyZWUpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga2ZyZWUo
aWFhX3dxKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gPiArfQo+IAo+
IFtzbmlwXQo+IAo+ID4gQEAgLTgwMCwxMiArMTc2MiwzOCBAQCBzdGF0aWMgdm9pZCBpYWFfY3J5
cHRvX3JlbW92ZShzdHJ1Y3QKPiA+IGlkeGRfZGV2ICppZHhkX2RldikKPiA+IMKgCj4gPiDCoMKg
wqDCoMKgwqDCoMKgcmVtb3ZlX2lhYV93cSh3cSk7Cj4gPiDCoAo+ID4gK8KgwqDCoMKgwqDCoMKg
c3Bpbl9sb2NrKCZpZHhkLT5kZXZfbG9jayk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpYWFfd3EgPSBp
ZHhkX3dxX2dldF9wcml2YXRlKHdxKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghaWFhX3dxKSB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2soJmlkeGQtPmRl
dl9sb2NrKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnIoIiVzOiBu
byBpYWFfd3EgYXZhaWxhYmxlIHRvIHJlbW92ZVxuIiwKPiA+IF9fZnVuY19fKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiA+ICvCoMKgwqDCoMKgwqDCoH0K
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChpYWFfd3EtPnJlZikgewo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlhYV93cS0+cmVtb3ZlID0gdHJ1ZTsKPiA+ICvCoMKgwqDC
oMKgwqDCoH0gZWxzZSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd3EgPSBp
YWFfd3EtPndxOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZnJlZV9pYWFf
d3EoaWFhX3dxKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZHhkX3dxX3Nl
dF9wcml2YXRlKHdxLCBOVUxMKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBm
cmVlID0gdHJ1ZTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoHNwaW5f
dW5sb2NrKCZpZHhkLT5kZXZfbG9jayk7Cj4gX19mcmVlX2lhYV93cSgpIG1heSBjYXVzZSBzY2hl
ZHVsZSwgd2hldGhlciBpdCBzaG91bGQgYmUgbW92ZSBvdXQgb2YKPiB0aGUKPiBjb250ZXh0IGJl
dHdlZW4gc3Bpbl9sb2NrKCkgYW5kIHNwaW5fdW5sb2NrKCk/CgpTYW1lLgoKPiA+ICsKPiA+ICvC
oMKgwqDCoMKgwqDCoGlmIChmcmVlKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGtmcmVlKGlhYV93cSk7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWR4ZF9kcnZfZGlzYWJs
ZV93cSh3cSk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgcmViYWxhbmNlX3dxX3RhYmxlKCk7Cj4gPiDC
oAo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKG5yX2lhYSA9PSAwKQo+ID4gK8KgwqDCoMKgwqDCoMKg
aWYgKG5yX2lhYSA9PSAwKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWFh
X2NyeXB0b19lbmFibGVkID0gZmFsc2U7Cj4gSXMgaXQgbmVjZXNzYXJ5IHRvIGFkZCBpYWFfdW5y
ZWdpc3Rlcl9jb21wcmVzc2lvbl9kZXZpY2UoKSBoZXJlPwo+IEFsbCBpYWEgZGV2aWNlcyBhcmUg
ZGlzYWJsZWQgY2F1c2UgdGhlIHZhcmlhYmxlIGZpcnN0X3dxIHdpbGwgYmUKPiB0cnVlLAo+IGlm
IGVuYWJsZSB3cSwgaWFhX3JlZ2lzdGVyX2NvbXByZXNzaW9uX2RldmljZSgpIHdpbGwgZmFpbCBk
dWUgdG8gdGhlCj4gYWxnb3JpdGhtIGlzIGV4aXN0ZWQuCgpObywgdGhpcyBpcyByZXF1aXJlZCBi
eSByZXZpZXcgaW5wdXQgZnJvbSBhIHByZXZpb3VzIHZlcnNpb24gLSB0aGUKY29tcHJlc3Npb24g
ZGV2aWNlIGNhbiBvbmx5IGJlIHVucmVnaXN0ZXJlZCBvbiBtb2R1bGUgZXhpdC4KClRoYW5rcywK
ClRvbQoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnJlZV93cV90YWJsZSgp
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vZHVsZV9wdXQoVEhJU19NT0RV
TEUpOwo+ID4gwqAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9pbmZvKCJp
YWFfY3J5cHRvIG5vdyBESVNBQkxFRFxuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArb3V0
Ogo+ID4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmaWFhX2RldmljZXNfbG9jayk7Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfdW5sb2NrKCZ3cS0+d3FfbG9jayk7Cj4gPiDCoH0KPiAK
PiBbc25pcF0KPiAKPiBUaGFua3MsCj4gUmV4IFpoYW5nCj4gPiAtLSAKPiA+IDIuMzQuMQo+ID4g
Cgo=


