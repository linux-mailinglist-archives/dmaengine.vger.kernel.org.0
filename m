Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B16275CCA
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIWQHF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 12:07:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:43470 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIWQHF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Sep 2020 12:07:05 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 12:07:04 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-114-3SPCxjhGNz6_8Sdv3LtuFg-1; Wed, 23 Sep 2020 17:00:46 +0100
X-MC-Unique: 3SPCxjhGNz6_8Sdv3LtuFg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 23 Sep 2020 17:00:45 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 23 Sep 2020 17:00:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Jiang' <dave.jiang@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jing.lin@intel.com" <jing.lin@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] x86/asm: move the raw asm in iosubmit_cmds512() to
 special_insns.h
Thread-Topic: [PATCH v4 1/5] x86/asm: move the raw asm in iosubmit_cmds512()
 to special_insns.h
Thread-Index: AQHWkcBDYYZeKoT2o0iUR23vst8hAql2Xrlg
Date:   Wed, 23 Sep 2020 16:00:45 +0000
Message-ID: <da596c9c5a4c4368b887ac171db952eb@AcuMS.aculab.com>
References: <160037680630.3777.16356270178889649944.stgit@djiang5-desk3.ch.intel.com>
 <160037731654.3777.18071122574577972463.stgit@djiang5-desk3.ch.intel.com>
 <20200923104158.GG28545@zn.tnic>
 <c38406b7-f1d1-35d8-8015-bacce7a52226@intel.com>
In-Reply-To: <c38406b7-f1d1-35d8-8015-bacce7a52226@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RnJvbTogRGF2ZSBKaWFuZw0KPiBTZW50OiAyMyBTZXB0ZW1iZXIgMjAyMCAxNjo0Mw0KLi4uDQo+
ID4NCj4gPiBPbiBUaHUsIFNlcCAxNywgMjAyMCBhdCAwMjoxNToxNlBNIC0wNzAwLCBEYXZlIEpp
YW5nIHdyb3RlOg0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc3BlY2lh
bF9pbnNucy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vc3BlY2lhbF9pbnNucy5oDQo+ID4+IGlu
ZGV4IDU5YTNlMTMyMDRjMy4uN2JjOGU3MTRmMzdlIDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmgNCj4gPj4gKysrIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vc3BlY2lhbF9pbnNucy5oDQo+ID4+IEBAIC0yMzQsNiArMjM0LDIzIEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBjbHdiKHZvbGF0aWxlIHZvaWQgKl9fcCkNCj4gPj4NCj4gPj4gICAjZGVmaW5l
IG5vcCgpIGFzbSB2b2xhdGlsZSAoIm5vcCIpDQo+ID4+DQo+ID4+ICtzdGF0aWMgaW5saW5lIHZv
aWQgbW92ZGlyNjRiKHZvaWQgKl9fZHN0LCBjb25zdCB2b2lkICpzcmMpDQo+ID4NCj4gPiBNYWtl
IF9fZHN0IGJlIHRoZSBmdW5jdGlvbiBsb2NhbCB2YXJpYWJsZSBuYW1lIGFuZCBrZWVwICJkc3Qi
LCBpLmUuLA0KPiA+IHdpdGhvdXQgdGhlIHVuZGVyc2NvcmVzLCB0aGUgZnVuY3Rpb24gcGFyYW1l
dGVyIG5hbWUuDQo+IA0KPiBPayB3aWxsIGZpeA0KPiANCj4gPg0KPiA+PiArCS8qDQo+ID4+ICsJ
ICogTm90ZSB0aGF0IHRoaXMgaXNuJ3QgYW4gIm9uLXN0YWNrIGNvcHkiLCBqdXN0IGRlZmluaXRp
b24gb2YgImRzdCINCj4gPj4gKwkgKiBhcyBhIHBvaW50ZXIgdG8gNjQtYnl0ZXMgb2Ygc3R1ZmYg
dGhhdCBpcyBnb2luZyB0byBiZSBvdmVyd3JpdHRlbi4NCj4gPj4gKwkgKiBJbiB0aGUgTU9WRElS
NjRCIGNhc2UgdGhhdCBtYXkgYmUgbmVlZGVkIGFzIHlvdSBjYW4gdXNlIHRoZQ0KPiA+PiArCSAq
IE1PVkRJUjY0QiBpbnN0cnVjdGlvbiB0byBjb3B5IGFyYml0cmFyeSBtZW1vcnkgYXJvdW5kLiBU
aGlzIHRyaWNrDQo+ID4+ICsJICogbGV0cyB0aGUgY29tcGlsZXIga25vdyBob3cgbXVjaCBnZXRz
IGNsb2JiZXJlZC4NCj4gPj4gKwkgKi8NCj4gPj4gKwl2b2xhdGlsZSBzdHJ1Y3QgeyBjaGFyIF9b
NjRdOyB9ICpkc3QgPSBfX2RzdDsNCj4gPj4gKw0KPiA+PiArCS8qIE1PVkRJUjY0QiBbcmR4XSwg
cmF4ICovDQo+ID4+ICsJYXNtIHZvbGF0aWxlKCIuYnl0ZSAweDY2LCAweDBmLCAweDM4LCAweGY4
LCAweDAyIg0KPiA+PiArCQkgICAgIDogIj1tIiAoZHN0KQ0KPiA+PiArCQkgICAgIDogImQiIChz
cmMpLCAiYSIgKGRzdCkpOw0KPiA+PiArfQ0KDQpTaW5jZSAnZHN0JyBuZWVkcyB0byBiZSA2NGJ5
dGUgYWxpZ25lZCBpdCBpc24ndCBjbGVhciB0aGF0ICd2b2lkIConDQppcyB0aGUgcmlnaHQgdHlw
ZSBmb3IgJ2RzdCcuDQpBdCBsZWFzdCBhZGQgYSBjb21tZW50Lg0KDQpZb3VyIGFzbSBjb25zdHJh
aW50cyBhcmUgYWxzbyBqdXN0IHdyb25nLg0KDQpUaGVyZSBpcyBubyByZWFsIHBvaW50IHNwZWNp
ZnlpbmcgIj1tIiAoZHN0KSBhcyBhbiBvdXRwdXQuDQpUaGUgd3JpdGUgcmF0aGVyIGJ5cGFzc2Vz
IHRoZSBjYWNoZSBhbmQgdGhlIGNhbGxlciBiZXR0ZXINCmtub3cgd2hhdCB0aGV5IGFyZSBkb2lu
Zy4NCg0KT1RPSCB5b3UnZCBiZXR0ZXIgYWRkICJtIiAoKHN0cnVjdCB7IGNoYXIgX1s2NF07fSAq
KXNyYykgYXMNCmFuIGlucHV0IGNvbnN0cmFpbnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

