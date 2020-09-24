Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1F277221
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgIXN1j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 09:27:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59341 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727533AbgIXN1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 09:27:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-255-ZLceJdGGNuuBxR1ZkO_HfQ-1; Thu, 24 Sep 2020 14:27:34 +0100
X-MC-Unique: ZLceJdGGNuuBxR1ZkO_HfQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 14:27:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 14:27:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Matz <matz@suse.de>
Subject: RE: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Topic: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Index: AQHWknOyVv/Eui5H70ijlKVH2OrKB6l3x79A
Date:   Thu, 24 Sep 2020 13:27:33 +0000
Message-ID: <f9fb5f02ffe74118934d6cf08a1cc9f0@AcuMS.aculab.com>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
 <20200924130746.GF5030@zn.tnic>
In-Reply-To: <20200924130746.GF5030@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDIwIDE0OjA4DQo+
IA0KPiBPbiBXZWQsIFNlcCAyMywgMjAyMCBhdCAwNDoxMDo0M1BNIC0wNzAwLCBEYXZlIEppYW5n
IHdyb3RlOg0KPiA+ICsvKiBUaGUgZHN0IHBhcmFtZXRlciBtdXN0IGJlIDY0LWJ5dGVzIGFsaWdu
ZWQgKi8NCj4gPiArc3RhdGljIGlubGluZSB2b2lkIG1vdmRpcjY0Yih2b2lkICpkc3QsIGNvbnN0
IHZvaWQgKnNyYykNCj4gPiArew0KPiA+ICsJLyoNCj4gPiArCSAqIE5vdGUgdGhhdCB0aGlzIGlz
bid0IGFuICJvbi1zdGFjayBjb3B5IiwganVzdCBkZWZpbml0aW9uIG9mICJkc3QiDQo+ID4gKwkg
KiBhcyBhIHBvaW50ZXIgdG8gNjQtYnl0ZXMgb2Ygc3R1ZmYgdGhhdCBpcyBnb2luZyB0byBiZSBv
dmVyd3JpdHRlbi4NCj4gPiArCSAqIEluIHRoZSBNT1ZESVI2NEIgY2FzZSB0aGF0IG1heSBiZSBu
ZWVkZWQgYXMgeW91IGNhbiB1c2UgdGhlDQo+ID4gKwkgKiBNT1ZESVI2NEIgaW5zdHJ1Y3Rpb24g
dG8gY29weSBhcmJpdHJhcnkgbWVtb3J5IGFyb3VuZC4gVGhpcyB0cmljaw0KPiA+ICsJICogbGV0
cyB0aGUgY29tcGlsZXIga25vdyBob3cgbXVjaCBnZXRzIGNsb2JiZXJlZC4NCj4gPiArCSAqLw0K
PiA+ICsJdm9sYXRpbGUgc3RydWN0IHsgY2hhciBfWzY0XTsgfSAqX19kc3QgPSBkc3Q7DQo+ID4g
Kw0KPiA+ICsJLyogTU9WRElSNjRCIFtyZHhdLCByYXggKi8NCj4gPiArCWFzbSB2b2xhdGlsZSgi
LmJ5dGUgMHg2NiwgMHgwZiwgMHgzOCwgMHhmOCwgMHgwMiINCj4gPiArCQkgICAgIDoNCj4gPiAr
CQkgICAgIDogIm0iICgqKHN0cnVjdCB7IGNoYXIgX1s2NF07fSAqKilzcmMpLCAiYSIgKF9fZHN0
KQ0KPiA+ICsJCSAgICAgOiAibWVtb3J5Iik7DQo+ID4gK30NCj4gDQo+IE9rLCBNaWNoYSBhbmQg
SSBoYXNoZWQgaXQgb3V0IG9uIElSQywgaGVyZSdzIHdoYXQgeW91IGRvLiBQbGVhc2Uga2VlcA0K
PiB0aGUgY29tbWVudHMgdG9vIGJlY2F1c2Ugd2Ugd2lsbCBmb3JnZXQgc29vbiBhZ2Fpbi4NCj4g
DQo+IHN0YXRpYyBpbmxpbmUgdm9pZCBtb3ZkaXI2NGIodm9pZCAqX19kc3QsIGNvbnN0IHZvaWQg
KnNyYykNCj4gew0KPiAJc3RydWN0IHsgY2hhciBfWzY0XTsgfSAqX19zcmMgPSBzcmM7DQo+IAlz
dHJ1Y3QgeyBjaGFyIF9bNjRdOyB9ICpfX2RzdCA9IGRzdDsNCj4gDQo+IAkvKg0KPiAJICogTU9W
RElSNjRCICUocmR4KSwgcmF4Lg0KPiAJICoNCj4gCSAqIEJvdGggX19zcmMgYW5kIF9fZHN0IG11
c3QgYmUgbWVtb3J5IGNvbnN0cmFpbnRzIGluIG9yZGVyIHRvIHRlbGwgdGhlDQo+IAkgKiBjb21w
aWxlciB0aGF0IG5vIG90aGVyIG1lbW9yeSBhY2Nlc3NlcyBzaG91bGQgYmUgcmVvcmRlcmVkIGFy
b3VuZA0KPiAJICogdGhpcyBvbmUuDQo+IAkgKg0KPiAJICogQWxzbywgYm90aCBtdXN0IGJlIHN1
cHBsaWVkIGFzIGx2YWx1ZXMgYmVjYXVzZSB0aGlzIHRlbGxzDQo+IAkgKiB0aGUgY29tcGlsZXIg
d2hhdCB0aGUgb2JqZWN0IGlzIChpdHMgc2l6ZSkgdGhlIGluc3RydWN0aW9uIGFjY2Vzc2VzLg0K
PiAJICogSS5lLiwgbm90IHRoZSBwb2ludGVycyBidXQgd2hhdCB0aGV5IHBvaW50LCB0aHVzIHRo
ZSBkZXJlZidpbmcgJyonLg0KPiAJICovDQo+IAlhc20gdm9sYXRpbGUoIi5ieXRlIDB4NjYsIDB4
MGYsIDB4MzgsIDB4ZjgsIDB4MDIiDQo+IAkJICAgICA6ICIrbSIgKCpfX2RzdCkNCj4gCQkgICAg
IDogICJtIiAoKl9fc3JjKSwgImEiIChfX2RzdCksICJkIiAoX19zcmMpKTsNCj4gfQ0KDQpEb2Vz
bid0IGxvb2sgd3Jvbmcgbm93Lg0KSSdkIHN0aWxsIHBhaW50IGl0IGEgc2xpZ2h0bHkgZGlmZmVy
ZW50IGNvbG91ciA6LSkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

