Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8220276EEE
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIXKmY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 06:42:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53667 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgIXKmY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 06:42:24 -0400
X-Greylist: delayed 8250 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 06:42:20 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-251-oDx4imxBPRKMP6yJH6_8Vw-1; Thu, 24 Sep 2020 11:42:17 +0100
X-MC-Unique: oDx4imxBPRKMP6yJH6_8Vw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 11:42:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 11:42:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Michael Matz <matz@suse.de>
CC:     'Dave Jiang' <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
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
Subject: RE: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Topic: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
Thread-Index: AQHWkf7GVv/Eui5H70ijlKVH2OrKB6l3b2twgAAS+QCAABEoMA==
Date:   Thu, 24 Sep 2020 10:42:16 +0000
Message-ID: <40f740d814764019ac2306800a6b68e4@AcuMS.aculab.com>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com>
 <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com>
 <a8c81da06df2471296b663d40b186c92@AcuMS.aculab.com>
 <20200924101506.GD5030@zn.tnic>
In-Reply-To: <20200924101506.GD5030@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDIwIDExOjE1DQo+
IE9uIFRodSwgU2VwIDI0LCAyMDIwIGF0IDA4OjI0OjQ2QU0gKzAwMDAsIERhdmlkIExhaWdodCB3
cm90ZToNCj4gPiBzdGF0aWMgaW5saW5lIHZvaWQgbW92ZGlyNjRiKHZvaWQgKmRzdCwgY29uc3Qg
dm9pZCAqc3JjKQ0KPiA+IHsNCj4gPiAJLyoNCj4gPiAJICogNjQgYnl0ZXMgZnJvbSBkc3QgYXJl
IG1hcmtlZCBhcyBtb2RpZmllZCBmb3IgY29tcGxldGVuZXNzLg0KPiA+IAkgKiBTaW5jZSB0aGUg
d3JpdGVzIGJ5cGFzcyB0aGUgY2FjaGUgbGF0ZXIgcmVhZHMgbWF5IHJldHVybg0KPiA+IAkgKiBv
bGQgZGF0YSBhbnl3YXkuDQo+ID4gCSAqLw0KPiA+IAkvKiBNT1ZESVI2NEIgW3JkeF0sIHJheCAq
Lw0KPiA+IAlhc20gdm9sYXRpbGUgKCIuYnl0ZSAweDY2LCAweDBmLCAweDM4LCAweGY4LCAweDAy
Ig0KPiA+IAkgICAgIDogIj1tIiAoKHN0cnVjdCB7IGNoYXIgX1s2NF07fSAqKWRzdCksDQo+ID4g
CSAgICAgOiAibSIgKChzdHJ1Y3QgeyBjaGFyIF9bNjRdO30gKilzcmMpLCAiZCIgKHNyYyksICJh
IiAoZHN0KSk7DQo+IA0KPiBOb3cgc2luY2UgeW91J3JlIHNvIGdlbmVyb3VzIHdpdGggeW91ciBh
ZHZpY2Ugb24gcmFuZG9tIHRocmVhZHMsIHBsZWFzZQ0KPiBleHBsYWluIHdoYXQgeW91J3JlIGFk
dmlzaW5nIGhlcmU/DQo+IA0KPiBUaGUgZGVzdGluYXRpb24gb3BlcmFuZCAtIGluIHRoaXMgY2Fz
ZSBpbiAlcmF4IC0gaXMgImRlc3RpbmF0aW9uIG1lbW9yeQ0KPiBhZGRyZXNzIHNwZWNpZmllZCBh
cyBvZmZzZXQgdG8gRVMgc2VnbWVudCBpbiB0aGUgcmVnaXN0ZXIgb3BlcmFuZC4iDQoNClRoZSBt
b3ZkaXI2NGIgaW5zdHJ1Y3Rpb24gZG9lcyBhICdub3JtYWwnIHJlYWQgb2YgNjQgYnl0ZXMgKGNh
biBiZSBtaXNhbGlnbmVkKQ0KVGhlbiBhIGNhY2hlLWJ5cGFzc2luZyAocHJvYmFibHkpIHdyaXRl
LWNvbWJpbmluZyBzaW5nbGUgNjRieXRlIHdyaXRlIHRvDQphbiBhZGRyZXNzIHRoYXQgbXVzdCBi
ZSBhbGlnbmVkLg0KQW55IHJlZmVyZW5jZSB0byBzZWdtZW50IHJlZ2lzdGVycyBpcyBsYXJnZWx5
IGlycmVsZXZhbnQgc2luY2Ugd2UgYXJlDQpub3QgaW4gcmVhbCBtb2RlLg0KDQoNCj4gU28gd2hh
dCBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuOg0KPiANCj4gCS4uLih2b2lkICpkc3QsIC4uLiAp
DQo+IA0KPiAJdm9sYXRpbGUgc3RydWN0IHsgY2hhciBfWzY0XTsgfSAqX19kc3QgPSBkc3Q7DQo+
IAkuLi4NCj4gCTogIj1tIiAoX19kc3QpDQo+IAk6ICJhIiAoX19kc3QpDQo+IA0KPiBhbmQNCj4g
DQo+IAkuLi4odm9pZCAqZHN0LCAuLi4gKQ0KPiAJLi4uDQo+IAk6ICI9bSIgKChzdHJ1Y3QgeyBj
aGFyIF9bNjRdO30gKilkc3QpDQo+IAk6ICJhIiAoX19kc3QpDQo+IA0KPiBhbmQgd2h5Pw0KPiAN
Cj4gUG9pbnQgbWUgdG8gdGhlIGdjYyBkb2N1bWVudGF0aW9uIHdoZXJlIHRoaXMgaXMgZXhwbGFp
bmVkLg0KDQpNYWlubHkgbGVzcyBsaW5lcyBvZiBjb2RlIHRvIGxvb2sgYXQuDQoNCj4gVG8gY3V0
IHRvIHRoZSBjaGFzZSwgSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBkbyB0aGF0LCBvdGhlcndp
c2UgY2x3YigpDQo+IHdvdWxkIGJlIGJyb2tlbiB0b28gYnV0IHBlcmhhcHMgeW91IGtub3cgc29t
ZXRoaW5nIEkgZG9uJ3QuDQo+IA0KPiBMb29raW5nIGF0IGNsd2IoKSwgSSBiZWxpZXZlIHRoZSBw
cm9wZXIgc3BlY2lmaWNhdGlvbiBzaG91bGQgYmU6DQo+IA0KPiAJdm9sYXRpbGUgc3RydWN0IHsg
Y2hhciBfWzY0XTsgfSAqX19kc3QgPSBkc3Q7DQo+IA0KPiAJLi4uDQo+IA0KPiAJOiAiK20iIChf
X2RzdCkNCj4gCTogImEiIChfX2RzdCkNCg0KTm8gaWRlYSB3aGF0IGNsd2IoKSBpcyBkb2luZy4N
CkJ1dCB0aGUgIittIiAoZHN0KSB0ZWxscyBnY2MgaXQgZGVwZW5kcyBvbiwgYW5kIG1vZGlmaWVz
IHRoZSA2NCBieXRlcw0KYXQgKmRzdC4NCg0KSSBiZWxpZXZlIHRoZSAndm9sYXRpbGUnIGlzIHBv
aW50bGVzcy4NCg0KPiBBbmQgaWYgYW55dGhpbmcsIHRoZSBzb3VyY2Ugc3BlY2lmaWNhdGlvbiBz
aG91bGQgYmUgc29tZXRoaW5nIGxpa2UgdGhhdDoNCj4gDQo+IAl2b2xhdGlsZSBzdHJ1Y3QgeyBj
aGFyIHhbNjRdOyB9ICpfX3NyYyA9IHNyYzsNCj4gDQo+IAkuLi4NCj4gDQo+IA0KPiAJImQiIChf
X3NyYykNCj4gDQo+IGJlY2F1c2UgdGhpcyB0ZWxscyBnY2MgdGhhdCB0aGUgc291cmNlIG9wZXJh
bmQgd291bGQgcmVhZCA2NCBieXRlcw0KPiB0aHJvdWdoIHRoZSBwb2ludGVyIGluIHRoZSAlcmR4
IHJlZy4NCg0KTm8sIHRoYXQganVzdCBzYXlzIHRoZSBhc20gdXNlcyB0aGUgdmFsdWUgb2YgdGhl
IHBvaW50ZXIuDQpOb3Qgd2hhdCBpdCBwb2ludHMgdG8uDQoNCj4gU28gdGhpcyBlbmRzIHVwIGNs
b3NlIHRvIHdoYXQgeW91J3JlIHNheWluZyBidXQgaXQgaXMgdXNpbmcgbG9jYWwNCj4gdmFyaWFi
bGVzIHRvIG1ha2UgdGhlIGFzbSBhY3R1YWxseSByZWFkYWJsZS4NCj4gDQo+IExlbW1lIGFkZCBN
aWNoYSB0byBDYyBmb3Igc2FuaXR5LWNoZWNraW5nOg0KPiANCj4gTWljaGEsIHRoZSBpbnN0cnVj
dGlvbiBpczoNCj4gDQo+IE1PVkRJUjY0QiAlKHJkeCksIHJheA0KPiANCj4gIk1vdmUgNjQtYnl0
ZXMgYXMgZGlyZWN0LXN0b3JlIHdpdGggZ3VhcmFudGVlZCA2NC1ieXRlIHdyaXRlIGF0b21pY2l0
eQ0KPiBmcm9tIHRoZSBzb3VyY2UgbWVtb3J5IG9wZXJhbmQgYWRkcmVzcyB0byBkZXN0aW5hdGlv
biBtZW1vcnkgYWRkcmVzcw0KPiBzcGVjaWZpZWQgYXMgb2Zmc2V0IHRvIEVTIHNlZ21lbnQgaW4g
dGhlIHJlZ2lzdGVyIG9wZXJhbmQuIg0KPiANCj4gRG8gSSBuZWVkIHRvIHRlbGwgZ2NjIHRoYXQg
Ym90aCBvcGVyYW5kcyBhcmUgcmVmZXJlbmNpbmcgNjQgYnl0ZXMsDQo+IHNvdXJjZSBvcGVyYW5k
IGlzIGEgbWVtb3J5IHJlZmVyZW5jZSwgZGVzdGluYXRpb24gb3BlcmFuZCBpcyBhbiBhZGRyZXNz
DQo+IHNwZWNpZmllZCBpbiBhIHJlZ2lzdGVyPw0KPiANCj4gV2hhdCB3ZSBoYXZlIGN1cnJlbnRs
eSBpczoNCj4gDQo+IAkJdm9sYXRpbGUgc3RydWN0IHsgY2hhciBfWzY0XTsgfSAqZHN0ID0gX19k
c3Q7DQo+IA0KPiAgICAgICAgICAgICAgICAgLyogTU9WRElSNjRCIFtyZHhdLCByYXggKi8NCj4g
ICAgICAgICAgICAgICAgIGFzbSB2b2xhdGlsZSgiLmJ5dGUgMHg2NiwgMHgwZiwgMHgzOCwgMHhm
OCwgMHgwMiINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6ICI9bSIgKGRzdCkNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6ICJkIiAoZnJvbSksICJhIiAoZHN0KSk7DQoN
ClRoYXQgaXMgd3JvbmcuDQpGZWVkIHRoaXMgaW50byBjYyAtUyAtTzIgYW5kIGxvb2sgYXQgdGhl
IC5zIGZpbGUNCg0Kc3RhdGljIGlubGluZSB2b2lkIG1vdmRpcjY0Yih2b2lkICpkc3QsIGNvbnN0
IHZvaWQgKnNyYykNCnsNCiAgICAgICBhc20gdm9sYXRpbGUoIi5ieXRlIDB4NjYsIDB4MGYsIDB4
MzgsIDB4ZjgsIDB4MDIiDQogICAgICAgICAgICAgICAgICAgIDoNCiAgICAgICAgICAgICAgICAg
ICAgOiAvKiJtIiAoKHN0cnVjdCB7IGNoYXIgX1s2NF07fSAqKXNyYyksKi8gImQiIChzcmMpLCAi
YSIgKGRzdCkNCiAgICAgICAgICAgICAgICAgICAgKTsNCg0Kdm9pZCBmb28odm9pZCAqZHN0LCBp
bnQgdmFsKQ0Kew0KICAgICAgICBsb25nIGI2NFs4XSA9IHsgMCB9Ow0KDQogICAgICAgIGI2NFsw
XSA9IHZhbDsNCiAgICAgICAgbW92ZGlyNjRiKGRzdCwgYjY0KTsNCn0NCg0KTm90ZSB0aGF0IGFs
bCB0byBjb2RlIHRoYXQgd3JpdGVzIGludG8gYjY0W10gaXMgb3B0aW1pc2VkIGF3YXkuDQpSZXBl
YXQgYWZ0ZXIgdW5jb21tZW50aW5nIHRoZSAibSIgY29uc3RyYWludCBhbmQgc3BvdCB0aGUgZGlm
ZmVyZW5jZS4NCg0KVGhlICI9bSIgKGRzdCkgY29uc3RyYWludCBpcyBtdWNoIGxlc3MgaW1wb3J0
YW50IGhlcmUuDQpUaGUgd3JpdGUgaXRzZWxmIHdpbGwgYWx3YXlzIGhhcHBlbi4NClNvIGRvIHdl
IG5lZWQgdG8gdGVsbCBnY2Mgd2UgZGlkIGl0Pw0KRG9pbmcgc28ganVzdCBlbnN1cmVzIGdjYyBk
b2Vzbid0IG1vdmUgYW55IGluc3RydWN0aW9ucyB0aGF0IGl0IGtub3dzDQphY2Nlc3MgdGhlIHNh
bWUgbWVtb3J5IGFib3ZlIHRoZSBtb3ZkaXI2NGIgaW5zdHJ1Y3Rpb24uDQpCdXQsIGJlY2F1c2Ug
dGhpcyBpcyBhIGNhY2hlIGJ5cGFzc2luZyB3cml0ZSB0aGV5IGFyZSBnb2luZw0KdG8gYmUgaW52
YWxpZCBhbnl3YXkgLSB3aXRob3V0IGV4dHJhIHN0cm9uZyBiYXJyaWVycy4NClNvIGl0IGlzIGZh
aXJseSBzYWZlIHRvIG1pc3MgaXQgb3V0Lg0KT1RPSCBwdXR0aW5nIGl0IGluIGRvZXMgbm8gaGFy
bSBhbmQgaGVscHMgYW5ub3RhdGUgd2hhdCB0aGUNCmluc3RydWN0aW9uIGlzIGRvaW5nLg0KDQpJ
IGp1c3QgZmFpbGVkIHRvIHNwb3QgYW4gZXhhbXBsZSBvZiBhICdtZW1vcnkgc2l6ZScgY2FzdCBp
biB0aGUNCmtlcm5lbCBzb3VyY2UgdHJlZSAtIEknbSBzdXJlIHRoZXJlIGlzIGFuIGV4YW1wbGUg
c29tZXdoZXJlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

