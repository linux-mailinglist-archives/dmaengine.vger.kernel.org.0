Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F48A52B4
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2019 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfIBJXe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Sep 2019 05:23:34 -0400
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:65440
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729801AbfIBJXe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Sep 2019 05:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTDtBUP5MOSiLzKS2LmKSegY4FGkPTztaTZ5I08K6qSeofpWQXRWrpUgf768fsvlFVtfOEjTXnVtVuz4prKQtabt0y/WKRSTd5nf9YRWrIcsQ4/8X4eyjvU+cJ2y9hmOnSOtPnSA2lKB9OalxvWjlBpG39xhQwf5R2+YzeHmenlzT071Ur6131pmrnoYr8CFwFuJVL4whzzoEsvJdr9vyZ6OppKuk2vkBWVmMVgzOuubHnVOgOs4y8ibnzFweV/51390BQYEs86xnGHoG0ms9/3hwg1xE6TX/2WeAxyxkLFBlW717FOZ36Vbo/L7LVv2sak+3KDd1kfNxp7gfeJtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQaOon1xfDpyDL9DFtJpiyKihMmDUfCErxbgAu2QNmA=;
 b=AnIBAcWqJaz+UiZZ7USvmI0TN9fQyhIH/PUR+Dg/QhxPr8S8tU3gMd5TefNLGV5skq5Bu1+DwuSg2+hLxtIj9xmvawL/vHE61kRmN++35av0rgW665GWFwX7auwGrvcthhLSACfnmrl+BioOa8UaDni7Uc+eAoz+R6gV6qk2kAEDLwPThduyasF40CiQi0w5KHsZP7AjHHQ8xUJZAwC4NsA4QtkqB+N04zhYbxUhWBVKPASk2//iiZ4RB8/cr+/tacl/esL3bbve4bDL9ssgMv48MES8x/xrCSO/hJzpbk25s5LBAXqd9F3LD2Y+ZdJ9Lx/5OSEwj17XMHgDxnFpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQaOon1xfDpyDL9DFtJpiyKihMmDUfCErxbgAu2QNmA=;
 b=oSNlveAdzUG9KgbF4y3+CzrTelIJd9FjYu7PkQQtxM6T3AM1QEGPwb31hL0PU3KmMaO9GRKTXGfsDWjOuVcG2KgrjWkN+eQVLVReG/rsDFK4Gl93bAgvfLQecTs1RqeXJXa9JnS5lxK/HjZ5rD6xUAgCSJw/B53ttAQI4gJL+So=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5040.jpnprd01.prod.outlook.com (20.179.186.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 09:21:50 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2220.022; Mon, 2 Sep 2019
 09:21:50 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1
 if iommu is mapped
Thread-Topic: [PATCH 1/2] dmaengine: rcar-dmac: Don't set DMACHCLR bit 0 to 1
 if iommu is mapped
Thread-Index: AQHVXZHsInhhy3gzVUOxBjefYznvOKcYF8KAgAAJgkA=
Date:   Mon, 2 Sep 2019 09:21:50 +0000
Message-ID: <TYAPR01MB4544C653A1E784F014650AFFD8BE0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1566990835-27028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdUF4pgad0CWE6h4CQijy+-0Cif40C91TRVzH_OBO2tRPg@mail.gmail.com>
In-Reply-To: <CAMuHMdUF4pgad0CWE6h4CQijy+-0Cif40C91TRVzH_OBO2tRPg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16c7ba03-e754-4f44-684c-08d72f86fca5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB5040;
x-ms-traffictypediagnostic: TYAPR01MB5040:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <TYAPR01MB5040C87DA4756CA61E10DB86D8BE0@TYAPR01MB5040.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(9686003)(81156014)(81166006)(8676002)(99286004)(316002)(6306002)(53936002)(26005)(186003)(3846002)(6116002)(55016002)(14454004)(2906002)(6246003)(74316002)(66066001)(102836004)(966005)(6436002)(54906003)(478600001)(7696005)(76176011)(256004)(71200400001)(66946007)(66476007)(33656002)(86362001)(6506007)(53546011)(305945005)(6916009)(229853002)(11346002)(64756008)(52536014)(5660300002)(476003)(486006)(446003)(14444005)(66446008)(8936002)(66556008)(25786009)(7736002)(76116006)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB5040;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SXRitoY80S6C8Dd5E6NgT3mzXs3fPyPJo55IW+FBbIRssCC0gCAzwl+9SXZsSUq9qi2oZX5gQoZVZntSygQjqbbJvLWwNoOd0F2VX0ZSTc94jjWRTgRRnRyYECfFuuPlRopLkCAA9ZG8EByoK6gyFVKR+3efl59Ezl4bTVERDnhdWSGk/BhafBTp5eF7CanUGsAqHEh8WNHFVHr/cKvuh6lAKcdAPrdPOQPYX721laWpsCD5lHSWD7koxLz1VwCrQtSYBKSGqF216P+JyMYkdzoD40IWPHfamVYJxYTIgnrEn0mu49rXn8RCf741EXjQoDku5F9bJxSjHsor15LFiOKnPuum0VoRuWsLswXs11PnYfF2iPqKHmlJ1RRAUPWekYGvfWyCmZ/0fNjdK2KHbnlIgXwQfr7yQBErtqkhXPg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c7ba03-e754-4f44-684c-08d72f86fca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 09:21:50.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHszu56lB0GvoKO8jwhWdEyoiboBDNY9iwi6T46D/PyT5KPloe2sn7h0QwmF8hE5ct9VZrxwK+W9qpG8PMZrfoD5hcICGp8MAHh4UfKl8pUgWvvE1vHheGx5PnJUJPKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5040
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogTW9uZGF5
LCBTZXB0ZW1iZXIgMiwgMjAxOSA1OjM2IFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+
IE9uIFdlZCwgQXVnIDI4LCAyMDE5IGF0IDE6MTUgUE0gWW9zaGloaXJvIFNoaW1vZGENCj4gPHlv
c2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBUaGUgY29tbWl0IDIw
YzE2OWFjZWI0NSAoImRtYWVuZ2luZTogcmNhci1kbWFjOiBjbGVhciBwZXJ0aW5lbmNlDQo+ID4g
bnVtYmVyIG9mIGNoYW5uZWxzIikgYWx3YXlzIHNldCB0aGUgRE1BQ0hDTFIgYml0IDAgdG8gMSwg
YnV0IGlmDQo+ID4gaW9tbXUgaXMgbWFwcGVkIHRvIHRoZSBkZXZpY2UsIHRoaXMgZHJpdmVyIGRv
ZXNuJ3QgbmVlZCB0byBjbGVhciBpdC4NCj4gPiBTbywgdGhpcyBwYXRjaCB0YWtlcyBjYXJlIG9m
IGl0IGJ5IHVzaW5nICJjaGFubmVsc19tYXNrIiBiaXRmaWVsZC4NCj4gDQo+IFRoYW5rcyBmb3Ig
eW91ciBwYXRjaCENCj4gDQo+ID4gTm90ZSB0aGF0LCB0aGlzIHBhdGNoIGRvZXNuJ3QgaGF2ZSBh
ICJGaXhlczoiIHRhZyBiZWNhdXNlIHRoZSBkcml2ZXINCj4gPiBkb2Vzbid0IG1hbmFnZSB0aGUg
Y2hhbm5lbCAwIGFueXdheSBzbyB0aGF0IHRoZSBiZWhhdmlvciBvZg0KPiA+IHRoZSBjaGFubmVs
IGlzIG5vdCBjaGFuZ2VkLg0KPiANCj4gVGhpcyBwYXRjaCBkb2VzIGZpeCBhIGJ1ZywgYXMgR0VO
TUFTSyhkbWFjLT5uX2NoYW5uZWxzIC0gMSwgMCkgZG9lc24ndA0KPiB0YWtlIGludG8gYWNjb3Vu
dCBjaGFubmVsc19vZmZzZXQuICBIZW5jZSBpdCBub3Qgb25seSBjbGVhcnMgY2hhbm5lbCAwLA0K
PiBhcyB5b3UgbWVudGlvbmVkLCBidXQgYWxzbyBmb3JnZXRzIHRvIGNsZWFyIHRoZSBsYXN0IGNo
YW5uZWwsIHdoaWNoDQo+IGlzIGEgcmVhbCBidWcuDQoNCkluZGVlZC4NCg0KPiBTbyBJIHRoaW5r
IHRoaXMgZG9lcyB3YXJyYW50IGENCj4gRml4ZXM6IDIwYzE2OWFjZWI0NTk1NzUgKCJkbWFlbmdp
bmU6IHJjYXItZG1hYzogY2xlYXIgcGVydGluZW5jZQ0KPiBudW1iZXIgb2YgY2hhbm5lbHMiKQ0K
PiANCj4gT3IgcGVyaGFwcyB0aGUgYWN0dWFsIGJ1ZyBzaG91bGQgYmUgZml4ZWQgZmlyc3QgaW4g
YSBzZXBhcmF0ZSBwYXRjaD8NCg0KSSB0aGluayBzby4gU28sIG5vdyBJIGhhZCBhbHJlYWR5IHN1
Ym1pdHRlZCB0d28gc2VyaWVzIGxpa2UgYmVsb3csIGJ1dA0KSSdsbCBmaXggdGhpcyBhdCBmaXJz
dC4NCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJlbmVzYXMt
c29jL2xpc3QvP3Nlcmllcz0xNjU4ODENCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1yZW5lc2FzLXNvYy9saXN0Lz9zZXJpZXM9MTY2NDU3DQoNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5j
b20+DQo+IA0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2Fz
QGdsaWRlci5iZT4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyENCg0KPiA+IC0tLSBhL2Ry
aXZlcnMvZG1hL3NoL3JjYXItZG1hYy5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvc2gvcmNhci1k
bWFjLmMNCj4gDQo+ID4gQEAgLTQ0Niw3ICs0NDgsNyBAQCBzdGF0aWMgaW50IHJjYXJfZG1hY19p
bml0KHN0cnVjdCByY2FyX2RtYWMgKmRtYWMpDQo+ID4gICAgICAgICB1MTYgZG1hb3I7DQo+ID4N
Cj4gPiAgICAgICAgIC8qIENsZWFyIGFsbCBjaGFubmVscyBhbmQgZW5hYmxlIHRoZSBETUFDIGds
b2JhbGx5LiAqLw0KPiA+IC0gICAgICAgcmNhcl9kbWFjX3dyaXRlKGRtYWMsIFJDQVJfRE1BQ0hD
TFIsIEdFTk1BU0soZG1hYy0+bl9jaGFubmVscyAtIDEsIDApKTsNCj4gPiArICAgICAgIHJjYXJf
ZG1hY193cml0ZShkbWFjLCBSQ0FSX0RNQUNIQ0xSLCBkbWFjLT5jaGFubmVsc19tYXNrKTsNCj4g
PiAgICAgICAgIHJjYXJfZG1hY193cml0ZShkbWFjLCBSQ0FSX0RNQU9SLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIFJDQVJfRE1BT1JfUFJJX0ZJWEVEIHwgUkNBUl9ETUFPUl9ETUUpOw0K
PiA+DQo+ID4gQEAgLTgyMiw2ICs4MjQsOSBAQCBzdGF0aWMgdm9pZCByY2FyX2RtYWNfc3RvcF9h
bGxfY2hhbihzdHJ1Y3QgcmNhcl9kbWFjICpkbWFjKQ0KPiA+ICAgICAgICAgZm9yIChpID0gMDsg
aSA8IGRtYWMtPm5fY2hhbm5lbHM7ICsraSkgew0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
cmNhcl9kbWFjX2NoYW4gKmNoYW4gPSAmZG1hYy0+Y2hhbm5lbHNbaV07DQo+ID4NCj4gPiArICAg
ICAgICAgICAgICAgaWYgKCEoZG1hYy0+Y2hhbm5lbHNfbWFzayAmIEJJVChpKSkpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAg
ICAvKiBTdG9wIGFuZCByZWluaXRpYWxpemUgdGhlIGNoYW5uZWwuICovDQo+ID4gICAgICAgICAg
ICAgICAgIHNwaW5fbG9ja19pcnEoJmNoYW4tPmxvY2spOw0KPiA+ICAgICAgICAgICAgICAgICBy
Y2FyX2RtYWNfY2hhbl9oYWx0KGNoYW4pOw0KPiA+IEBAIC0xODAxLDYgKzE4MDYsOCBAQCBzdGF0
aWMgaW50IHJjYXJfZG1hY19wYXJzZV9vZihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCByY2Fy
X2RtYWMgKmRtYWMpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICAg
ICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBkbWFjLT5jaGFubmVsc19tYXNrID0gR0VOTUFTSyhk
bWFjLT5uX2NoYW5uZWxzIC0gMSwgMCk7DQo+IA0KPiBZb3UncmUgYXdhcmUgZG1hYy0+bl9jaGFu
bmVscyBjYW4gYmUgOTksIGFzIHBlciB0aGUgY2hlY2sgYWJvdmUsIGp1dCBvdXQgb2YNCj4gY29u
dGV4dD8gOy0pDQo+IA0KPiBQcm9iYWJseSB0aGF0IGNoZWNrIHNob3VsZCBiZSBjaGFuZ2VkIHRv
IHJlamVjdCA+PSAzMiwgYXMgdGhlIGhhcmR3YXJlDQo+IGFuZCBkcml2ZXIgZG9uJ3Qgc3VwcG9y
dCBtb3JlIHRoYW4gMzIgYml0cyBpbiBDSENMUiBhbnl3YXkuDQoNCkkgZ290IGl0LiBTbywgSSds
bCBmaXggdGhlIHJjYXJfZG1hY19wYXJzZV9vZigpIGFzIG9uZSBtb3JlIGEgc2VwYXJhdGUgcGF0
Y2guDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gPiArDQo+ID4gICAg
ICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTE4MTAsNyArMTgxNyw2IEBAIHN0
YXRpYyBpbnQgcmNhcl9kbWFjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gICAgICAgICAgICAgICAgIERNQV9TTEFWRV9CVVNXSURUSF8yX0JZVEVTIHwgRE1BX1NMQVZF
X0JVU1dJRFRIXzRfQllURVMgfA0KPiA+ICAgICAgICAgICAgICAgICBETUFfU0xBVkVfQlVTV0lE
VEhfOF9CWVRFUyB8IERNQV9TTEFWRV9CVVNXSURUSF8xNl9CWVRFUyB8DQo+ID4gICAgICAgICAg
ICAgICAgIERNQV9TTEFWRV9CVVNXSURUSF8zMl9CWVRFUyB8IERNQV9TTEFWRV9CVVNXSURUSF82
NF9CWVRFUzsNCj4gPiAtICAgICAgIHVuc2lnbmVkIGludCBjaGFubmVsc19vZmZzZXQgPSAwOw0K
PiA+ICAgICAgICAgc3RydWN0IGRtYV9kZXZpY2UgKmVuZ2luZTsNCj4gPiAgICAgICAgIHN0cnVj
dCByY2FyX2RtYWMgKmRtYWM7DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgcmNhcl9kbWFjX29m
X2RhdGEgKmRhdGE7DQo+ID4gQEAgLTE4NDMsMTAgKzE4NDksOCBAQCBzdGF0aWMgaW50IHJjYXJf
ZG1hY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgICog
bGV2ZWwgd2UgY2FuJ3QgZGlzYWJsZSBpdCBzZWxlY3RpdmVseSwgc28gaWdub3JlIGNoYW5uZWwg
MCBmb3Igbm93IGlmDQo+ID4gICAgICAgICAgKiB0aGUgZGV2aWNlIGlzIHBhcnQgb2YgYW4gSU9N
TVUgZ3JvdXAuDQo+ID4gICAgICAgICAgKi8NCj4gPiAtICAgICAgIGlmIChkZXZpY2VfaW9tbXVf
bWFwcGVkKCZwZGV2LT5kZXYpKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGRtYWMtPm5fY2hhbm5l
bHMtLTsNCj4gPiAtICAgICAgICAgICAgICAgY2hhbm5lbHNfb2Zmc2V0ID0gMTsNCj4gPiAtICAg
ICAgIH0NCj4gPiArICAgICAgIGlmIChkZXZpY2VfaW9tbXVfbWFwcGVkKCZwZGV2LT5kZXYpKQ0K
PiA+ICsgICAgICAgICAgICAgICBkbWFjLT5jaGFubmVsc19tYXNrICY9IH5CSVQoMCk7DQo+ID4N
Cj4gPiAgICAgICAgIGRtYWMtPmNoYW5uZWxzID0gZGV2bV9rY2FsbG9jKCZwZGV2LT5kZXYsIGRt
YWMtPm5fY2hhbm5lbHMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzaXplb2YoKmRtYWMtPmNoYW5uZWxzKSwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBHcntvZXRqZSxl
ZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0K
PiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMy
IC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25z
IHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdo
ZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Ig
c29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
LSBMaW51cyBUb3J2YWxkcw0K
