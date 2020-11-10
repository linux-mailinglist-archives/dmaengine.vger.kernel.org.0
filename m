Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9709B2ADD1B
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 18:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKJRjY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 12:39:24 -0500
Received: from us-smtp-delivery-115.mimecast.com ([63.128.21.115]:39846 "EHLO
        us-smtp-delivery-115.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730299AbgKJRjX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 12:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1605029960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cao1PQKYMx34sw33B68Ng7SukB9kxnEiHUHTUe7CdeI=;
        b=ZOyYqixBGwe7gb2yFAfxxCCxkowcTJpWa6Y8lp/zEi6JjoVeX1BISD2vdZPr4F7P9QJf5Y
        CC79nMk4IuRwZcduu1HkTPITH29dEeKglt7XshVJA2aSqaIBtrx+6EGZB71eCoCf5/S1dE
        zg7i+jLBp16LHFoSjYtgf4pDXqvMTZI=
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-fGGN4SSePNW2qIvIRafx5Q-1; Tue, 10 Nov 2020 12:39:17 -0500
X-MC-Unique: fGGN4SSePNW2qIvIRafx5Q-1
Received: from DM6PR19MB3977.namprd19.prod.outlook.com (2603:10b6:5:248::14)
 by DM6PR19MB2235.namprd19.prod.outlook.com (2603:10b6:5:ca::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 17:39:16 +0000
Received: from DM6PR19MB3977.namprd19.prod.outlook.com
 ([fe80::79fe:a527:adc2:8b2f]) by DM6PR19MB3977.namprd19.prod.outlook.com
 ([fe80::79fe:a527:adc2:8b2f%6]) with mapi id 15.20.3541.021; Tue, 10 Nov 2020
 17:39:16 +0000
From:   Thomas Langer <tlanger@maxlinear.com>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "Kim, Cheol Yong" <Cheol.Yong.Kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "malliamireddy009@gmail.com" <malliamireddy009@gmail.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "Langer, Thomas" <thomas.langer@intel.com>
Subject: RE: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Thread-Topic: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Thread-Index: AQHWrDgs5Bf/aSZXOUa9iCmf1ZDADKmrsTbwgAlC9gCAAAB/kA==
Date:   Tue, 10 Nov 2020 17:39:15 +0000
Message-ID: <DM6PR19MB397705C898DE2FBA755B2D80BBE90@DM6PR19MB3977.namprd19.prod.outlook.com>
References: <cover.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <f298715ab197ae72ab9b33caee2a19cc3e8be3f5.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <DM6PR19MB3594E466A1B76229EC1395BABB160@DM6PR19MB3594.namprd19.prod.outlook.com>
 <9882db7a-755b-84c9-b132-1839dea5e6b8@linux.intel.com>
In-Reply-To: <9882db7a-755b-84c9-b132-1839dea5e6b8@linux.intel.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
x-originating-ip: [94.216.38.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfc287f9-db04-4821-70c8-08d8859f8b88
x-ms-traffictypediagnostic: DM6PR19MB2235:
x-microsoft-antispam-prvs: <DM6PR19MB22355E61E42C4CD582C43548BBE90@DM6PR19MB2235.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: FFPBaE1aR2ekdvKu5ERYoscs3QxIBOiU0byLLpgx0xVvMo+MrFZXAWhgAgUnPDpeuL99chq/B23TnoehE+pFmK3L5/3K3p9P0+AQewQ9rojByovDI3Pp6oJXgrWkhBYi9waupVXPUX/Lxq83fPkL8P+KL00ZUkjfaqxDym+m6g1EaH9TZV9veuUSl/xr4sMVJ+MX89NiPcy6YNcE+ww2aHTsBC7Wxr5ri0vm2KAgOpHqB8kE+fokCV60mu7L70WMx44eQj+XWIkhZHdYW+JO1oCxCGT09OjnHC2mZ3p68PKcWIr2YajLWA1gmBF1lmPOLV2JC0s+rVTe7/g7Lw8xENU/SCBNls/MQouY73I3uHOurRJ+dylTTTrlI4JzNzXZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB3977.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(346002)(136003)(376002)(366004)(66946007)(8676002)(5660300002)(2906002)(76116006)(83380400001)(55016002)(186003)(110136005)(316002)(8936002)(54906003)(7696005)(66446008)(64756008)(6506007)(26005)(66556008)(33656002)(53546011)(52536014)(9686003)(4326008)(66476007)(71200400001)(478600001)(86362001)(7416002)(473944003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata: YRXNB0eGJ5p3IGfMEn0NgzzDLnp1XkQNmFcQHwCcdXHs4sdQOr4PoQjmPYaHBw0i3rtyktpFavxsX4XBQqYW53eDQsQ/z1rAS5KYBxXofDqaNHNzA+onzFgF63r/SAqvcUM3LXIrf1b1+y8EXePIDG8SIT3rFXi0rbXJ+TzqZjlMZ+3BvGdaSffu64PaMuRC2fZ/uJ+YoE8FeJIJfcrf+w4qzh9FB9Fo7yxE0dO7j3SseNKexiRNWP6YlouoPXLWvHnzhnaYKDPqN3HdlnrOZqI1e+8QxOVgbI56LIVALmdmHL3XjkD5ksHRM/wsKXdutiwLkrY4ItrEo6knMb1HTq55diuISG1UXDGL+09O1wa9kseK6wt1b/UxFPCamEJRCfDc8Q0jVn4GZzIi79pewfOZ/CgihdNAo6tFUzJlx1Lm6ibdihfH2D08dBx5vyXF2t2TvBqMCHli8yCllQc9VjyaXdKdi3RQmTb3TktXMcTXnjiuIC9cMoBiefzJE1aH27aMupRRBwZEapo+qp5n/BmwM6IjrYDZ1Q86TSpa77AZLfJv6D7oQamF+03VWN48SpCK0kNs90ShDcORWmDkf68JCz5ZPqtiqfRmCnofhjNNix377hypXAGP9hJ9G2f0Ee0DZvnXAgy599fjBtyFvA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3977.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc287f9-db04-4821-70c8-08d8859f8b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 17:39:15.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4mXXX49DyVO38By/OBmynCe/xo/4scZmZBE/Yy5irY0NeqjOA5nLjgGj1eKBWss+EQeflyyIAXVJlTiphyFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2235
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA115A51 smtp.mailfrom=tlanger@maxlinear.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmVkZHksIE1hbGxpa2Fy
anVuYVggPG1hbGxpa2FyanVuYXgucmVkZHlAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb250
YWcsIDIuIE5vdmVtYmVyIDIwMjAgMTU6NDINCj4gVG86IFRob21hcyBMYW5nZXIgPHRsYW5nZXJA
bWF4bGluZWFyLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZrb3VsQGtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmcNCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNoZXZjaGVua28sIEFuZHJpeQ0KPiA8
YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgY2h1YW5odWEubGVpQGxpbnV4LmludGVsLmNv
bTsgS2ltLA0KPiBDaGVvbCBZb25nIDxDaGVvbC5Zb25nLktpbUBpbnRlbC5jb20+OyBXdSwgUWlt
aW5nIDxxaS0NCj4gbWluZy53dUBpbnRlbC5jb20+OyBtYWxsaWFtaXJlZGR5MDA5QGdtYWlsLmNv
bTsgcGV0ZXIudWpmYWx1c2lAdGkuY29tOw0KPiBMYW5nZXIsIFRob21hcyA8dGhvbWFzLmxhbmdl
ckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMS8yXSBkdC1iaW5kaW5nczog
ZG1hOiBBZGQgYmluZGluZ3MgZm9yIGludGVsDQo+IExHTSBTT0MNCj4gDQo+IFRoaXMgZW1haWwg
d2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIE1heExpbmVhci4NCj4gDQo+IA0KPiBIaSBUaG9tYXMs
DQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldywgbXkgY29tbWVudHMgaW5saW5lLg0KPiANCj4gT24g
MTAvMjgvMjAyMCAzOjI0IEFNLCBUaG9tYXMgTGFuZ2VyIHdyb3RlOg0KPiA+IEhlbGxvIFJlZGR5
LA0KPiA+DQo+ID4gSSB0aGluayAiSW50ZWwiIHNob3VsZCBhbHdheXMgYmUgd3JpdHRlbiB3aXRo
IGEgY2FwaXRhbCAiSSIgKGxpa2UgaW4NCj4gdGhlIFN1YmplY3QsIGJ1dCBleGNlcHQgaW4gdGhl
IGJpbmRpbmcgYmVsb3cpDQo+IE9LLg0KPiA+DQo+ID4+ICsgY29tcGF0aWJsZToNCj4gPj4gKyAg
b25lT2Y6DQo+ID4+ICsgICAtIGNvbnN0OiBpbnRlbCxsZ20tY2RtYQ0KPiA+PiArICAgLSBjb25z
dDogaW50ZWwsbGdtLWRtYTJ0eA0KPiA+PiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTFyeA0K
PiA+PiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTF0eA0KPiA+PiArICAgLSBjb25zdDogaW50
ZWwsbGdtLWRtYTB0eA0KPiA+PiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTMNCj4gPj4gKyAg
IC0gY29uc3Q6IGludGVsLGxnbS10b2UtZG1hMzANCj4gPj4gKyAgIC0gY29uc3Q6IGludGVsLGxn
bS10b2UtZG1hMzENCj4gPiBCaW5kaW5ncyBhcmUgbm9ybWFsbHkgbm90IHBlciBpbnN0YW5jZS4N
Cj4gPiBXaGF0IGlmIG5leHQgZ2VuZXJhdGlvbiBjaGlwIGdldHMgbW9yZSBETUEgbW9kdWxlcyBi
dXQgaGFzIG5vIG90aGVyDQo+IGNoYW5nZXMgaW4gdGhlIEhXIGJsb2NrPw0KPiA+IFdoYXQgaXMg
d3Jvbmcgd2l0aA0KPiA+ICAgIC0gY29uc3Q6IGludGVsLGxnbS1jZG1hDQo+ID4gICAgLSBjb25z
dDogaW50ZWwsbGdtLWhkbWENCj4gPiBhbmQgZXh0cmEgYXR0cmlidXRlcyB0byBkZWZpbmUgdGhl
IHJ4L3R4IHJlc3RyaWN0aW9uIChvciB3aGF0IGRvIGl0DQo+IG1lYW4/KT8NCj4gPiAgRnJvbSB0
aGUgZHJpdmVyIGNvZGUgSSBzYXcgdGhhdCAidG9lIiBpcyBhbHNvIGp1c3Qgb2YgdHlwZSAiaGRt
YSINCj4gYW5kIG5vIGZ1cnRoZXIgZGlmZmVyZW5jZXMgaW4gY29kZSBhcmUgZG9uZS4NCj4gV2Ug
aGFkIGEgZGlzY3Vzc2lvbiBvbiB0aGUgc2FtZSBpbiB0aGUgcHJldmlvdXMgcGF0Y2hlcyBhbmQg
Um9iDQo+IEhlcnJpbmcNCj4gc2FpZCBPa2F5IHVzaW5nIERpZmZlcmVudCBjb21wYXRpYmxlcy4N
Cj4gYmVsb3cgdGhlIHNuaXBwZXQuDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gKw0KPiAgPj4+ICsgY29t
cGF0aWJsZToNCj4gID4+PiArICBhbnlPZjoNCj4gID4+PiArICAgLSBjb25zdDogaW50ZWwsbGdt
LWNkbWENCj4gID4+PiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTJ0eA0KPiAgPj4+ICsgICAt
IGNvbnN0OiBpbnRlbCxsZ20tZG1hMXJ4DQo+ICA+Pj4gKyAgIC0gY29uc3Q6IGludGVsLGxnbS1k
bWExdHgNCj4gID4+PiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTB0eA0KPiAgPj4+ICsgICAt
IGNvbnN0OiBpbnRlbCxsZ20tZG1hMw0KPiAgPj4+ICsgICAtIGNvbnN0OiBpbnRlbCxsZ20tdG9l
LWRtYTMwDQo+ICA+Pj4gKyAgIC0gY29uc3Q6IGludGVsLGxnbS10b2UtZG1hMzENCj4gID4+IFBs
ZWFzZSBleHBsYWluIHdoeSB5b3UgbmVlZCBzbyBtYW55IGRpZmZlcmVudCBjb21wYXRpYmxlIHN0
cmluZ3MuDQo+ICA+IFRoaXMgaHcgZG1hIGhhcyA3IERNQSBpbnN0YW5jZXMuDQo+ICA+IFNvbWUg
Zm9yIGRhdGFwYXRoLCBzb21lIGZvciBtZW1jcHkgIGFuZCBzb21lIGZvciBUT0UuDQo+ICA+IFNv
bWUgZm9yIFRYIG9ubHksIHNvbWUgZm9yIFJYIG9ubHksIGFuZCBzb21lIGZvciBUWC9SWChtZW1j
cHkgYW5kDQo+IFRvRSkuDQo+ICA+DQo+ICA+IGRtYSBUWC9SWCB0eXBlIHdlIGNvbnNpZGVyZWQg
YXMgZHJpdmVyIHNwZWNpZmljIGRhdGEgb2YgZWFjaA0KPiBpbnN0YW5jZSBhbmQNCj4gID4gdXNl
ZCBkaWZmZXJlbnQgY29tcGF0aWJsZSBzdHJpbmdzIGZvciBlYWNoIGluc3RhbmNlLg0KPiAgPiBB
bmQgYWxzbyBpZGVhIGlzIGluIGZ1dHVyZSBpZiBhbnkgZHJpdmVyIHNwZWNpZmljIGRhdGEgb2Yg
YW55DQo+IHBhcnRpY3VsYXINCj4gID4gaW5zdGFuY2Ugd2UgY2FuIGhhbmRsZS4NCj4gID4NCj4g
ID4gSGVyZSBpZiBkbWEgbmFtZSBhbmQgdHlwZSh0eCBvciByeCkgd2lsbCBiZSBhY2NlcHRlZCBh
cyBkZXZpY2V0cmVlDQo+ICA+IGF0dHJpYnV0ZXMgdGhlbiB3ZSBjYW4gbW92ZSAubmFtZSA9ICJ0
b2VfZG1hMzEiLCAmIC50eXBlID0NCj4gRE1BX1RZUEVfTUNQWQ0KPiAgPiB0byBkZXZpY2V0cmVl
LiBTbyB0aGF0IHRoZSBjb21wYXRpYmxlIHN0cmluZ3MgY2FuIGJlIGxpbWl0ZWQgdG8NCj4gdHdv
Lg0KPiAgPiBpbnRlbCxsZ20tY2RtYSAmIGludGVsLGxnbS1oZG1hIC4NCj4gDQo+IFtSb2JdDQo+
IERpZmZlcmVudCBjb21wYXRpYmxlcyBhcmUgb2theSBpZiB0aGUgaW5zdGFuY2VzIGFyZSBkaWZm
ZXJlbnQgYW5kIHdlDQo+IGRvbid0IGhhdmUgcHJvcGVydGllcyB0byBkZXNjcmliZSB0aGUgZGlm
ZmVyZW5jZXMuDQoNCk9rYXksIGJ1dCB0aGVuIGV4cGxhaW4gd2hhdCB0aGUgZGlmZmVyZW5jZXMg
YXJlLCB0aGF0IGNhbm5vdCBiZSBkZXNjcmliZWQNCmJ5IG90aGVyIHByb3BlcnRpZXMvYXR0cmli
dXRlcy4gSW4gdGhlIGRyaXZlciBjb2RlIEkgY2Fubm90IHNlZSBhbnl0aGluZywNCmV4Y2VwdCB0
aGUgIm5hbWUiLiBCdXQgZm9yIHByaW50b3V0cyBpbiBkcml2ZXIsICJkcnZfZGJnIiBvciBzaW1p
bGFyIHdpbGwNCmp1c3QgdXNlIHRoZSBub2RlIHBhdGggZm9yIHRoZSBpbnN0YW5jZS4NCg0KPiAN
Cj4gRm9yIHNvbWUgb2Ygd2hhdCB5b3UgaGF2ZSBpbiB0aGlzIGJpbmRpbmcsIEkgdGhpbmsgaXQg
c2hvdWxkIGJlIHBhcnQNCj4gb2YNCj4gdGhlIGNvbnN1bWVyIGNlbGxzLg0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICsrDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gVGhvbWFzDQo+ID4NCg0K

