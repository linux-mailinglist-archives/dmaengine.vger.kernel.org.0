Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715512CE88F
	for <lists+dmaengine@lfdr.de>; Fri,  4 Dec 2020 08:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgLDHSd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Dec 2020 02:18:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43030 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725550AbgLDHSd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Dec 2020 02:18:33 -0500
X-UUID: 18ebead3510e4169bf31eddb6578e6aa-20201204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MfX9eUXalM1ZT8YXJrCaneB0sCMHWJYVtYRI8EpgCfY=;
        b=VP3AtIDTy3R2ZVrb1p9hTf5SVSKrhNb3v/opr0cLcCgR2gGrajrokJvUgKybkGGYLRgifXd8SDXxWwUA2HMvFL0JJSjD3QojtD4T9G3ZSSR7byGYbSu+6bzkbC4zHjIs24iiH7WVKGdbG4CxkzH/IKmPVaDV4QC8LbO6NPGeLmA=;
X-UUID: 18ebead3510e4169bf31eddb6578e6aa-20201204
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 394253026; Fri, 04 Dec 2020 15:17:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 15:17:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 15:17:43 +0800
Message-ID: <1607066264.18639.3.camel@mtkswgap22>
Subject: Re: [PATCH v7 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
From:   EastL <EastL.Lee@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>
Date:   Fri, 4 Dec 2020 15:17:44 +0800
In-Reply-To: <20200818164718.GB3596085@bogus>
References: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
         <1597719834-6675-2-git-send-email-EastL.Lee@mediatek.com>
         <20200818164718.GB3596085@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

c29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLg0KDQpPbiBUdWUsIDIwMjAtMDgtMTggYXQg
MTA6NDcgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIEF1ZyAxOCwgMjAyMCBh
dCAxMTowMzo1MUFNICswODAwLCBFYXN0TCBMZWUgd3JvdGU6DQo+ID4gRG9jdW1lbnQgdGhlIGRl
dmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1BIGNvbnRyb2xs
ZXINCj4gPiB3aGljaCBjb3VsZCBiZSBmb3VuZCBvbiBNVDY3NzkgU29DIG9yIG90aGVyIHNpbWls
YXIgTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFYXN0TCBMZWUgPEVh
c3RMLkxlZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2RtYS9tdGstY3FkbWEueWFtbCAgICAgICAgIHwgOTggKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEu
eWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZG1hL210ay1jcWRtYS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2RtYS9tdGstY3FkbWEueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMC4uZmUwMzA4MQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sDQo+ID4gQEAgLTAs
MCArMSw5OCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5
IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2RtYS9tdGstY3FkbWEueWFtbCMNCj4gPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4g
Kw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciBEZXZp
Y2UgVHJlZSBCaW5kaW5nDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEVhc3RM
IExlZSA8RWFzdEwuTGVlQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0K
PiA+ICsgIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1BIGNvbnRyb2xsZXIgKENRRE1BKSBvbiBN
ZWRpYXRlayBTb0MNCj4gPiArICBpcyBkZWRpY2F0ZWQgdG8gbWVtb3J5LXRvLW1lbW9yeSB0cmFu
c2ZlciB0aHJvdWdoIHF1ZXVlIGJhc2VkDQo+ID4gKyAgZGVzY3JpcHRvciBtYW5hZ2VtZW50Lg0K
PiA+ICsNCj4gPiArYWxsT2Y6DQo+ID4gKyAgLSAkcmVmOiAiZG1hLWNvbnRyb2xsZXIueWFtbCMi
DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBv
bmVPZjoNCj4gPiArICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ2NzY1LWNxZG1hDQo+ID4gKyAg
ICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Njc3OS1jcWRtYQ0KPiANCj4gVXNlIGVudW0gaW5zdGVh
ZCBvZiBvbmVPZitjb25zdC4NCk9LDQo+IA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBt
aW5JdGVtczogMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDUNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+ICsgICAgICAgIEEgYmFzZSBhZGRyZXNzIG9mIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1B
IGNvbnRyb2xsZXIsDQo+ID4gKyAgICAgICAgYSBjaGFubmVsIHdpbGwgaGF2ZSBhIHNldCBvZiBi
YXNlIGFkZHJlc3MuDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBtaW5JdGVt
czogMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDUNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsg
ICAgICAgIEEgaW50ZXJydXB0IG51bWJlciBvZiBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBj
b250cm9sbGVyLA0KPiA+ICsgICAgICAgIG9uZSBpbnRlcnJ1cHQgbnVtYmVyIHBlciBkbWEtY2hh
bm5lbHMuDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4g
Kw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgY29uc3Q6IGNxZG1hDQo+ID4gKw0KPiA+
ICsgIGRtYS1jaGFubmVsczoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjZGVm
aW5pdGlvbnMvdWludDMyDQo+IA0KPiBDb21tb24gcHJvcGVydGllcyBhbHJlYWR5IGhhdmUgYSB0
eXBlIGRlZmluaXRpb24uDQpPSyBJJ2xsIHJlbW92ZQ0KPiANCj4gPiArICAgIGRlc2NyaXB0aW9u
Og0KPiA+ICsgICAgICBOdW1iZXIgb2YgRE1BIGNoYW5uZWxzIHN1cHBvcnRlZCBieSBNZWRpYVRl
ayBDb21tYW5kLVF1ZXVlIERNQQ0KPiA+ICsgICAgICBjb250cm9sbGVyLCBzdXBwb3J0IHVwIHRv
IGZpdmUuDQo+ID4gKyAgICBpdGVtczoNCj4gDQo+IE5vdCBhbiBhcnJheSwgc28gZHJvcCAnaXRl
bXMnLg0KT0sNCj4gDQo+ID4gKyAgICAgIG1pbmltdW06IDENCj4gPiArICAgICAgbWF4aW11bTog
NQ0KPiA+ICsNCj4gPiArICBkbWEtcmVxdWVzdHM6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90
eXBlcy55YW1sI2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4g
KyAgICAgIE51bWJlciBvZiBETUEgcmVxdWVzdCAodmlydHVhbCBjaGFubmVsKSBzdXBwb3J0ZWQg
YnkgTWVkaWFUZWsNCj4gPiArICAgICAgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwgc3Vw
cG9ydCB1cCB0byAzMi4NCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICBtaW5pbXVtOiAxDQo+
ID4gKyAgICAgIG1heGltdW06IDMyDQo+IA0KPiBTYW1lIGlzc3VlcyBoZXJlLg0KT0sNCj4gDQo+
ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtICIjZG1hLWNlbGxzIg0KPiA+ICsgIC0gY29t
cGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBjbG9j
a3MNCj4gPiArICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAgLSBkbWEtY2hhbm5lbC1tYXNrDQo+IA0K
PiBOZWVkIHRvIGxpc3QgaW4gcHJvcGVydGllcyB0byBmaXggdGhlIGNoZWNrIGVycm9yOg0KPiAN
Cj4gZG1hLWNoYW5uZWwtbWFzazogdHJ1ZQ0KDQpPSw0KPiANCj4gPiArICAtIGRtYS1jaGFubmVs
cw0KPiA+ICsgIC0gZG1hLXJlcXVlc3RzDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVydGll
czogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4g
PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQo+ID4gKyAg
ICBjcWRtYTogZG1hLWNvbnRyb2xsZXJAMTAyMTIwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ2Nzc5LWNxZG1hIjsNCj4gPiArICAgICAgICByZWcgPSA8MHgxMDIx
MjAwMCAweDgwPiwNCj4gPiArICAgICAgICAgICAgPDB4MTAyMTIwODAgMHg4MD4sDQo+ID4gKyAg
ICAgICAgICAgIDwweDEwMjEyMTAwIDB4ODA+Ow0KPiA+ICsgICAgICAgIGludGVycnVwdHMgPSA8
R0lDX1NQSSAxMzkgSVJRX1RZUEVfTEVWRUxfTE9XPiwNCj4gPiArICAgICAgICAgICAgPEdJQ19T
UEkgMTQwIElSUV9UWVBFX0xFVkVMX0xPVz4sDQo+ID4gKyAgICAgICAgICAgIDxHSUNfU1BJIDE0
MSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdf
YW8gQ0xLX0lORlJBX0NRX0RNQT47DQo+ID4gKyAgICAgICAgY2xvY2stbmFtZXMgPSAiY3FkbWEi
Ow0KPiA+ICsgICAgICAgIGRtYS1jaGFubmVsLW1hc2sgPSA8MHgzZj47DQo+ID4gKyAgICAgICAg
ZG1hLWNoYW5uZWxzID0gPDM+Ow0KPiA+ICsgICAgICAgIGRtYS1yZXF1ZXN0cyA9IDwzMj47DQo+
ID4gKyAgICAgICAgI2RtYS1jZWxscyA9IDwxPjsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsu
Li4NCj4gPiAtLSANCj4gPiAxLjkuMQ0KDQo=

