Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60B9FF07
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfH1KAe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 06:00:34 -0400
Received: from mail-eopbgr1410125.outbound.protection.outlook.com ([40.107.141.125]:21984
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfH1KAe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Aug 2019 06:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpEBk8sSOFui6uDeXIsuIafHo8mRqqH1X3+xhA0VZMaHqaxhFSzQUJfbraThgT5Bfodr/snWfsYRQTyhpnbH8P/cZzz103BFZBZT96LZ51+QWrqEPfCP8vYVAsaJeAM4aV8b+VOKJGcwbIvkjV1eJRilb9w1gznsaMEIfxxGSzmALXMdOA15xJ9ipll1QyXq923cm7KxMPkddRcXW72Z44T1nNz8HURzE2PAppXZlZdqn35n1PAmoNZT8o1xWjRTXwfifeK6w9bPN7Q8CtD7A9KneLW65gZhJ5R9hx5pg8DXu24WhrtH2hLSut7UAT6hpdAlrVfnGhWoxYMVBsxk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMZDd+a8jgk5BY+z4IQH0MTHKG5hA53d+SwpWEW6I40=;
 b=g5B+s0HQc6lqQu8hxuPS/HjMRJJRh9soyXZhwW31Qe4gOkCx9lk/6Vvbbfw+9MARmmRe5Mpzrf4RCdcRkKGqAXLNdNnd3DMiQ4g+Ncbr+cE5TamTUb8gQOFvvwC6yPbeMZcb/+9JuCXFqKhWRQdCcUudaMxzTetEmViRNZQgvRfJbTSbKWe7w3L/ribkCVNcFUdd3x8VxjlO2/mIuTrnUyMIHkoyZCPxkbb2PtrN9pZcD6ut5v+feTnYdWogzj9rQwsT+xTrLPdobeHYSDhkSEYN/Md+vxxvHgDad+/zeRUeVFRW6dGL6jYHu953GsC76uXGeGtlY1sr7xghbpub+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMZDd+a8jgk5BY+z4IQH0MTHKG5hA53d+SwpWEW6I40=;
 b=X7HvVSE7DqlDc8bPHXTw+g9/XGaoarIT5rmfgr2e58b6N34s8K1cFfHSzdDFFKrDPtWTeyRTW4fSalQytEOokwEeAG956YFE9C8JzegBbbOTEV/WQB5JqNTNA4AuI2LqOdssqwN1fjrQZLRT425wdS8bZEHsd8FwED5QEbLJdhY=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3328.jpnprd01.prod.outlook.com (20.178.136.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 10:00:31 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 10:00:31 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
Thread-Topic: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
Thread-Index: AQHVXWuY7BBEFyXtZE29P6wjBVSPHacQKKaAgAAX70CAAA1aAIAAAq2g
Date:   Wed, 28 Aug 2019 10:00:30 +0000
Message-ID: <TYAPR01MB45449A32980BD5A48D0FC2C0D8A30@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <eb823985-5cf6-0d83-8613-1baeeaf7d9c8@ti.com>
 <TYAPR01MB454400436713332F1075D424D8A30@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <3b06567c-8cfe-bfec-3973-c3e7cf71a18b@ti.com>
In-Reply-To: <3b06567c-8cfe-bfec-3973-c3e7cf71a18b@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10a96ed0-c0bc-4bce-115d-08d72b9e8fa3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB3328;
x-ms-traffictypediagnostic: TYAPR01MB3328:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TYAPR01MB3328979165AE4335E03A4087D8A30@TYAPR01MB3328.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(110136005)(54906003)(305945005)(33656002)(2501003)(99286004)(476003)(6436002)(316002)(66574012)(5660300002)(26005)(3846002)(66066001)(8936002)(55016002)(53936002)(14454004)(486006)(11346002)(446003)(7696005)(7736002)(76176011)(186003)(102836004)(86362001)(74316002)(966005)(6116002)(9686003)(25786009)(6306002)(478600001)(8676002)(14444005)(256004)(71200400001)(52536014)(6246003)(64756008)(76116006)(81166006)(81156014)(2906002)(66476007)(71190400001)(66556008)(229853002)(6506007)(4326008)(66946007)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3328;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L8vnMBGNnrjd0IPpmHhKshUEYMYS/g9Jqxar6v4aO3pPjRfRN+JTmJThFG9ajiPsm5CHM5Q4oW44EzIzqT2PTxUV53HD/865PPGCYu3gQ0j2C9pvWUvz6sOeBJU13BvIKCKiyX7s/pw1HUkwgZ4gB9ZgpKDPRTGbzY9bfbDdjqNh2nNLi59FcDMjNwAVEsJUmE3ORAg9PdKRbZ9x8/Rfr8N9c+2qgo1xJ9ccbzJ20j7hLe4lSSmF1OXSebz7IRq1smk4Mm5V9pdGdbkXZXpaw1NrMVp+GC1ht1j6Tyhz9BSpXnXFDda/Luoz6y5i7EVfpYNE0mhhrfcmxxSUbfXsWLqW1b1xufxpOx2U81u5m5+zP+PDiMk/x0dP2EreXRiXWUqJQze/7Q2xaHfT2RCaOMG5Vbd5sPRX29jfKygkSms=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a96ed0-c0bc-4bce-115d-08d72b9e8fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 10:00:30.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqE1Tu6csxQMbFXuK5+tubtTL+oEZc9vZPnT+dWstxYb+QnQT31zkARcEmViGna5mRZVHZkB/JFy5Y7sbkaF5g9Wdoe3MbATxDKL/UOsUznDz1bevxSugyDuHGk2TrgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3328
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgUGV0ZXItc2FuLA0KDQo+IEZyb206IFBldGVyIFVqZmFsdXNpLCBTZW50OiBXZWRuZXNkYXks
IEF1Z3VzdCAyOCwgMjAxOSA2OjM5IFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+IE9u
IDI4LzA4LzIwMTkgMTEuNTUsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEhpIFBldGVy
LA0KPiA+DQo+ID4+IEZyb206IFBldGVyIFVqZmFsdXNpLCBTZW50OiBXZWRuZXNkYXksIEF1Z3Vz
dCAyOCwgMjAxOSA0OjI1IFBNDQo+ID4+DQo+ID4+IE9uIDI4LzA4LzIwMTkgOS4zOSwgWW9zaGlo
aXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4+PiBUaGUgY29tbWl0IGIzN2UzNTM0YWM0MiAoImR0LWJp
bmRpbmdzOiBkbWFlbmdpbmU6IEFkZCBZQU1MIHNjaGVtYXMNCj4gPj4+IGZvciB0aGUgZ2VuZXJp
YyBETUEgYmluZGluZ3MiKSBjaGFuZ2VkIHRoZSBwcm9wZXJ0eSBmcm9tDQo+ID4+PiBkbWEtY2hh
bm5lbC1tYXNrIHRvIGRtYS1jaGFubmVsLW1hc2tzLiBTbywgdGhpcyBwYXRjaCByZXZpc2VzIGl0
Lg0KPiA+Pj4NCj4gPj4+IEZpeGVzOiBiMzdlMzUzNGFjNDIgKCJkdC1iaW5kaW5nczogZG1hZW5n
aW5lOiBBZGQgWUFNTCBzY2hlbWFzIGZvciB0aGUgZ2VuZXJpYyBETUEgYmluZGluZ3MiKQ0KPiA+
Pj4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVo
QHJlbmVzYXMuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RtYS9kbWEtY29tbW9uLnlhbWwgfCAyICstDQo+ID4+PiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZG1hLWNvbW1vbi55YW1s
DQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9kbWEtY29tbW9u
LnlhbWwNCj4gPj4+IGluZGV4IDAxNDFhZjAuLmVkMGE0OWEgMTAwNjQ0DQo+ID4+PiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2RtYS1jb21tb24ueWFtbA0KPiA+
Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9kbWEtY29tbW9u
LnlhbWwNCj4gPj4+IEBAIC0yNCw3ICsyNCw3IEBAIHByb3BlcnRpZXM6DQo+ID4+PiAgICAgIGRl
c2NyaXB0aW9uOg0KPiA+Pj4gICAgICAgIFVzZWQgdG8gcHJvdmlkZSBETUEgY29udHJvbGxlciBz
cGVjaWZpYyBpbmZvcm1hdGlvbi4NCj4gPj4+DQo+ID4+PiAtICBkbWEtY2hhbm5lbC1tYXNrczoN
Cj4gPj4+ICsgIGRtYS1jaGFubmVsLW1hc2s6DQo+ID4+PiAgICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjZGVmaW5pdGlvbnMvdWludDMyDQo+ID4+DQo+ID4+IEhvdyB0aGlzIG1hc2sgc3Vw
cG9zZWQgdG8gYmUgdXNlZCBmb3IgY29udHJvbGxlcnMgaGF2aW5nIG1vcmUgdGhhbiAzMg0KPiA+
PiBjaGFubmVscyAoNjQsIDMwMCspPw0KPiA+DQo+ID4gSSBmb3VuZCAiZG1hLWNoYW5uZWxzIiBw
cm9wZXJ0eSBhcyA0MCBpbiBhcmNoL2FybS9ib290L2R0cy9zdGUtdTMwMC5kdHMuDQo+ID4gSG93
ZXZlciwgc2luY2UgYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjYwLmR0c2kgYWxy
ZWFkeSBoYXMNCj4gPiB0aGUgZG1hLWNoYW5uZWwtbWFzayBwcm9wZXJ0eSwgSSB0aGluayB3ZSBz
aG91bGQgbm90IGNoYW5nZSB0aGUgcHJvcGVydHkgbmFtZS4NCj4gDQo+IEknbSBub3QgYXNraW5n
IGl0IHRvIGJlIGNoYW5nZWQsIEkganVzdCB3b25kZXJlZCBob3cgSSBjb3VsZCB1c2UgdGhpcw0K
PiBnZW5lcmljIHByb3BlcnR5IGZvciBETUEgY29udHJvbGxlcnMgaGF2aW5nIG1vcmUgY2hhbm5l
bHMgdGhhbiB1MzINCj4gYml0ZmllbGQgY291bGQgZGVzY3JpYmUuIEFuIGFycmF5IG9mIG11bHRp
cGxlIHUzMiB0byBjb3ZlciB0aGUgbnVtYmVyIG9mDQo+IGNoYW5uZWxzIHdvdWxkIHByb2JhYmx5
IHNvbWV0aGluZyB3aGljaCBjYW4gYmUgZG9uZSwgYnV0IGl0IHdvdWxkIG5lZWQNCj4gdXBkYXRl
IGZvciB0aGUgZG9jdW1lbnRhdGlvbiB0byBtYWtlIHN1cmUgdGhhdCBpdCBpcyB1c2VkIGNvbnNp
c3RlbnRseS4NCj4gDQo+IEknbSBhc2tpbmcgdGhpcyBiZWNhdXNlIG9mOiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzExMTExNjE5Lw0KDQpPb3BzLCBJJ20gc29ycnkgZm9yIG1p
c3VuZGVyc3RhbmRpbmcgeW91ciBxdWVzdGlvbi4NCg0KQXMgeW91IHNhaWQsIEkgYWxzbyB0aGlu
ayB0aGF0IHlvdSBjYW4gdXNlIHRoaXMgZ2VuZXJpYyBwcm9wZXJ0eSBpZiB3ZSB1cGRhdGUNCnRo
ZSBkb2N1bWVudCBmcm9tIHVpbnQzMiB0byB1aW50MzItYXJyYXkgbGlrZSBiZWxvdzoNCg0KLSAg
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjZGVmaW5pdGlvbnMvdWludDMyDQorICAgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzItYXJyYXkNCg0KQmVz
dCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0K
PiA+IFlvc2hpaGlybyBTaGltb2RhDQo+ID4NCj4gPj4+ICAgICAgZGVzY3JpcHRpb246DQo+ID4+
PiAgICAgICAgQml0bWFzayBvZiBhdmFpbGFibGUgRE1BIGNoYW5uZWxzIGluIGFzY2VuZGluZyBv
cmRlciB0aGF0IGFyZQ0KPiA+Pj4NCj4gPj4NCj4gPj4gLSBQw6l0ZXINCj4gPj4NCj4gPj4gVGV4
YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lu
a2kuDQo+ID4+IFktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9t
aWNpbGU6IEhlbHNpbmtpDQo+IA0KPiAtIFDDqXRlcg0KPiANCj4gVGV4YXMgSW5zdHJ1bWVudHMg
RmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuDQo+IFktdHVubnVz
L0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
