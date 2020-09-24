Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C006276BC1
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgIXIZx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 04:25:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39274 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbgIXIZx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 04:25:53 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-95-VXUOEVhfMDqraFBgS_BjUQ-1; Thu, 24 Sep 2020 09:24:47 +0100
X-MC-Unique: VXUOEVhfMDqraFBgS_BjUQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 09:24:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 09:24:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Jiang' <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jing.lin@intel.com" <jing.lin@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Topic: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Index: AQHWkf7GVv/Eui5H70ijlKVH2OrKB6l3b2tw
Date:   Thu, 24 Sep 2020 08:24:46 +0000
Message-ID: <a8c81da06df2471296b663d40b186c92@AcuMS.aculab.com>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
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

RnJvbTogRGF2ZSBKaWFuZw0KPiBTZW50OiAyNCBTZXB0ZW1iZXIgMjAyMCAwMDoxMQ0KPg0KPiBU
aGUgTU9WRElSNjRCIGluc3RydWN0aW9uIGNhbiBiZSB1c2VkIGJ5IG90aGVyIHdyYXBwZXIgaW5z
dHJ1Y3Rpb25zLiBNb3ZlDQo+IHRoZSBhc20gY29kZSB0byBzcGVjaWFsX2luc25zLmggYW5kIGhh
dmUgaW9zdWJtaXRfY21kczUxMigpIGNhbGwgdGhlDQo+IGFzbSBmdW5jdGlvbi4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiBSZXZpZXdl
ZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2lvLmggICAgICAgICAgICB8ICAgMTcgKysrLS0tLS0tLS0tLS0tLS0NCj4g
IGFyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaCB8ICAgMTkgKysrKysrKysrKysr
KysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5oIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vaW8uaA0KPiBpbmRleCBlMWFhMTdhNDY4YTguLmQ3MjY0NTlkMDhl
NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vaW8uaA0KPiArKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9pby5oDQouLi4NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5z
bnMuaA0KPiBpbmRleCA1OWEzZTEzMjA0YzMuLjJhNWFiZDI3YmI4NiAxMDA2NDQNCj4gLS0tIGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vc3BlY2lhbF9pbnNucy5oDQo+ICsrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiBAQCAtMjM0LDYgKzIzNCwyNSBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgY2x3Yih2b2xhdGlsZSB2b2lkICpfX3ApDQo+IA0KPiAgI2RlZmluZSBub3Ao
KSBhc20gdm9sYXRpbGUgKCJub3AiKQ0KPiANCj4gKy8qIFRoZSBkc3QgcGFyYW1ldGVyIG11c3Qg
YmUgNjQtYnl0ZXMgYWxpZ25lZCAqLw0KPiArc3RhdGljIGlubGluZSB2b2lkIG1vdmRpcjY0Yih2
b2lkICpkc3QsIGNvbnN0IHZvaWQgKnNyYykNCj4gK3sNCj4gKwkvKg0KPiArCSAqIE5vdGUgdGhh
dCB0aGlzIGlzbid0IGFuICJvbi1zdGFjayBjb3B5IiwganVzdCBkZWZpbml0aW9uIG9mICJkc3Qi
DQo+ICsJICogYXMgYSBwb2ludGVyIHRvIDY0LWJ5dGVzIG9mIHN0dWZmIHRoYXQgaXMgZ29pbmcg
dG8gYmUgb3ZlcndyaXR0ZW4uDQo+ICsJICogSW4gdGhlIE1PVkRJUjY0QiBjYXNlIHRoYXQgbWF5
IGJlIG5lZWRlZCBhcyB5b3UgY2FuIHVzZSB0aGUNCj4gKwkgKiBNT1ZESVI2NEIgaW5zdHJ1Y3Rp
b24gdG8gY29weSBhcmJpdHJhcnkgbWVtb3J5IGFyb3VuZC4gVGhpcyB0cmljaw0KPiArCSAqIGxl
dHMgdGhlIGNvbXBpbGVyIGtub3cgaG93IG11Y2ggZ2V0cyBjbG9iYmVyZWQuDQo+ICsJICovDQo+
ICsJdm9sYXRpbGUgc3RydWN0IHsgY2hhciBfWzY0XTsgfSAqX19kc3QgPSBkc3Q7DQo+ICsNCj4g
KwkvKiBNT1ZESVI2NEIgW3JkeF0sIHJheCAqLw0KPiArCWFzbSB2b2xhdGlsZSgiLmJ5dGUgMHg2
NiwgMHgwZiwgMHgzOCwgMHhmOCwgMHgwMiINCj4gKwkJICAgICA6DQo+ICsJCSAgICAgOiAibSIg
KCooc3RydWN0IHsgY2hhciBfWzY0XTt9ICoqKXNyYyksICJhIiAoX19kc3QpDQo+ICsJCSAgICAg
OiAibWVtb3J5Iik7DQo+ICt9DQo+ICsNCj4gICNlbmRpZiAvKiBfX0tFUk5FTF9fICovDQoNCllv
dSd2ZSBsb3N0IHRoZSAiZCIgKHNyYykuDQpZb3UgZG9uJ3QgbmVlZCB0aGUgJ21lbW9yeScgY2xv
YmJlciwganVzdDoNCg0Kc3RhdGljIGlubGluZSB2b2lkIG1vdmRpcjY0Yih2b2lkICpkc3QsIGNv
bnN0IHZvaWQgKnNyYykNCnsNCgkvKg0KCSAqIDY0IGJ5dGVzIGZyb20gZHN0IGFyZSBtYXJrZWQg
YXMgbW9kaWZpZWQgZm9yIGNvbXBsZXRlbmVzcy4NCgkgKiBTaW5jZSB0aGUgd3JpdGVzIGJ5cGFz
cyB0aGUgY2FjaGUgbGF0ZXIgcmVhZHMgbWF5IHJldHVybg0KCSAqIG9sZCBkYXRhIGFueXdheS4N
CgkgKi8NCgkvKiBNT1ZESVI2NEIgW3JkeF0sIHJheCAqLw0KCWFzbSB2b2xhdGlsZSAoIi5ieXRl
IDB4NjYsIDB4MGYsIDB4MzgsIDB4ZjgsIDB4MDIiDQoJICAgICA6ICI9bSIgKChzdHJ1Y3QgeyBj
aGFyIF9bNjRdO30gKilkc3QpLA0KCSAgICAgOiAibSIgKChzdHJ1Y3QgeyBjaGFyIF9bNjRdO30g
KilzcmMpLCAiZCIgKHNyYyksICJhIiAoZHN0KSk7DQp9DQoNCkkndmUgY2hlY2tlZCB0aGF0IHRo
ZSAibSIgY29uc3RyYWludCBvbiBzcmMgZG9lcyBmb3JjZSAoYXQgbGVhc3Qgb25lDQp2ZXJzaW9u
IG9mKSBnY2MgdG8gYWN0dWFsbHkgd3JpdGUgdG8gdGhlIHN1cHBsaWVkIGJ1ZmZlci4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

