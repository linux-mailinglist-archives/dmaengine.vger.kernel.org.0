Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43834210671
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGAIir (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 04:38:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53663 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728901AbgGAIiq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 04:38:46 -0400
X-UUID: 909b237288934fad852eebea1551cb94-20200701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=igFdgcx2s3gfCplnw7sG3p3l3ThRmpVgSyIt4O3OtUA=;
        b=KnjZVl3seTn9jlwAbyb4TuEP+i3aa03XcU4RhNuyDMJ0+AGVDlRo0QInm3VHNIN8KT6M5ulzWaw2YaIOumcD6BJPv3y6aA3aNk94NMaewDSJsc/e/+ENfJFDyVXHGjbG4u8avKdhxXZgy3lvtn28VZftcvq9HZ5FDrOr0zMb8/0=;
X-UUID: 909b237288934fad852eebea1551cb94-20200701
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 584458037; Wed, 01 Jul 2020 16:38:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Jul 2020 16:38:33 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Jul 2020 16:38:35 +0800
Message-ID: <1593592716.26931.1.camel@mtkswgap22>
Subject: Re: [PATCH v5 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
From:   EastL <EastL.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 1 Jul 2020 16:38:36 +0800
In-Reply-To: <4fc5f4b9-8f03-74b4-8bc9-bf86a6246ff0@gmail.com>
References: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
         <1592553902-30592-2-git-send-email-EastL.Lee@mediatek.com>
         <4fc5f4b9-8f03-74b4-8bc9-bf86a6246ff0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7D711C6660C810BC27EF666CFA21813D99FC0E271555793C3BE824F4B0A190992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gRnJpLCAyMDIwLTA2LTE5IGF0IDExOjM2ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTkvMDYvMjAyMCAxMDowNCwgRWFzdEwgd3JvdGU6DQo+ID4gRG9jdW1lbnQg
dGhlIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1BIGNv
bnRyb2xsZXINCj4gPiB3aGljaCBjb3VsZCBiZSBmb3VuZCBvbiBNVDY3NzkgU29DIG9yIG90aGVy
IHNpbWlsYXIgTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFYXN0TCA8
RWFzdEwuTGVlQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFN0aWxsIG1pc3NpbmcgdGhlIGZ1bGwgbmFt
ZS4NCg0KU29ycnkgSSB0aG91Z2h0IGl0IHdhcyBvbmx5IG5lZWRlZCBpbiB0aGUgeWFtbCBmaWxl
DQpJIHdpbGwgZml4IGluIG5leHQgdmVyc2lvbi4NCj4gDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFtbCAgICAgICAgIHwgMTE0ICsrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMoKykNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
bWEvbXRrLWNxZG1hLnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1hLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLmU2ZmRmMDUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFt
bA0KPiA+IEBAIC0wLDAgKzEsMTE0IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UNCj4gDQo+IFlvdSBtaXNzZWQgdGhlIGJyYWNr
ZXRzICgpLg0KT0sNCj4gDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9kbWEvbXRrLWNxZG1hLnlhbWwjDQo+ID4gKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsN
Cj4gPiArdGl0bGU6IE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1BIGNvbnRyb2xsZXIgRGV2aWNl
IFRyZWUgQmluZGluZw0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBFYXN0TCBM
ZWUgPEVhc3RMLkxlZUBtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4g
PiArICBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyIChDUURNQSkgb24gTWVk
aWF0ZWsgU29DDQo+ID4gKyAgaXMgZGVkaWNhdGVkIHRvIG1lbW9yeS10by1tZW1vcnkgdHJhbnNm
ZXIgdGhyb3VnaCBxdWV1ZSBiYXNlZA0KPiA+ICsgIGRlc2NyaXB0b3IgbWFuYWdlbWVudC4NCj4g
PiArDQo+ID4gK2FsbE9mOg0KPiA+ICsgIC0gJHJlZjogImRtYS1jb250cm9sbGVyLnlhbWwjIg0K
PiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICAiI2RtYS1jZWxscyI6DQo+ID4gKyAgICBt
aW5pbXVtOiAxDQo+ID4gKyAgICBtYXhpbXVtOiAyNTUNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0K
PiA+ICsgICAgICBVc2VkIHRvIHByb3ZpZGUgRE1BIGNvbnRyb2xsZXIgc3BlY2lmaWMgaW5mb3Jt
YXRpb24uDQo+ID4gKw0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4gPiAr
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssY29tbW9uLWNxZG1hDQo+IA0KPiBXaGF0IGlzIHRoZSBj
b21tb24tY3FkbWEgZm9yIGlmIHdlIGhhdmUgb25seSBvbmUgY29tcGF0aWJsZSBzcGVjaWZ5aW5n
IHRoZSBTb0MuDQo+IEFjdHVhbGx5IEknbSBub3QgYSBncmVhdCBmYW4gb2YgdGhlIGNvbW1vbi1j
cWRtYSB0aGluZy4gSSdkIHByZWZlciBhIGZhbGxiYWNrDQo+IGNvbXBhdGlibGUgdGhhdCBoYXMg
dGhlIG5hbWUgb2YgdGhlIGZpcnN0IFNvQyBpbXBsZW1lbnRpbmcgdGhlIHNhbWUgZGV2aWNlLg0K
PiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQpPSywgSSdsbCByZW1vdmUgY29tbW9uIGNv
bXBhdGlibGUuDQoNCj4gPiArICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ2NzY1LWNxZG1hDQo+
ID4gKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Njc3OS1jcWRtYQ0KPiA+ICsNCj4gPiArICBy
ZWc6DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDUNCj4gPiArICAg
IGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICAgIEEgYmFzZSBhZGRyZXNzIG9mIE1lZGlhVGVrIENv
bW1hbmQtUXVldWUgRE1BIGNvbnRyb2xsZXIsDQo+ID4gKyAgICAgICAgYSBjaGFubmVsIHdpbGwg
aGF2ZSBhIHNldCBvZiBiYXNlIGFkZHJlc3MuDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+
ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDUNCj4gPiArICAgIGRlc2Ny
aXB0aW9uOg0KPiA+ICsgICAgICAgIEEgaW50ZXJydXB0IG51bWJlciBvZiBNZWRpYVRlayBDb21t
YW5kLVF1ZXVlIERNQSBjb250cm9sbGVyLA0KPiA+ICsgICAgICAgIG9uZSBpbnRlcnJ1cHQgbnVt
YmVyIHBlciBkbWEtY2hhbm5lbHMuDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1h
eEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgY29uc3Q6IGNx
ZG1hDQo+ID4gKw0KPiA+ICsgIGRtYS1jaGFubmVsLW1hc2s6DQo+ID4gKyAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sI2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVzY3JpcHRpb246
DQo+ID4gKyAgICAgICBGb3IgRE1BIGNhcGFiaWxpdHksIFdlIHdpbGwga25vdyB0aGUgYWRkcmVz
c2luZyBjYXBhYmlsaXR5IG9mDQo+ID4gKyAgICAgICBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERN
QSBjb250cm9sbGVyIHRocm91Z2ggZG1hLWNoYW5uZWwtbWFzay4NCj4gPiArICAgIGl0ZW1zOg0K
PiA+ICsgICAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgICBtYXhJdGVtczogNjMNCj4gPiArDQo+
ID4gKyAgZG1hLWNoYW5uZWxzOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCNk
ZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBOdW1i
ZXIgb2YgRE1BIGNoYW5uZWxzIHN1cHBvcnRlZCBieSBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERN
QQ0KPiA+ICsgICAgICBjb250cm9sbGVyLCBzdXBwb3J0IHVwIHRvIGZpdmUuDQo+ID4gKyAgICBp
dGVtczoNCj4gPiArICAgICAgbWluSXRlbXM6IDENCj4gPiArICAgICAgbWF4SXRlbXM6IDUNCj4g
PiArDQo+ID4gKyAgZG1hLXJlcXVlc3RzOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCNkZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAg
ICBOdW1iZXIgb2YgRE1BIHJlcXVlc3QgKHZpcnR1YWwgY2hhbm5lbCkgc3VwcG9ydGVkIGJ5IE1l
ZGlhVGVrDQo+ID4gKyAgICAgIENvbW1hbmQtUXVldWUgRE1BIGNvbnRyb2xsZXIsIHN1cHBvcnQg
dXAgdG8gMzIuDQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgbWluSXRlbXM6IDENCj4gPiAr
ICAgICAgbWF4SXRlbXM6IDMyDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtICIjZG1h
LWNlbGxzIg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRl
cnJ1cHRzDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiArICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAgLSBk
bWEtY2hhbm5lbC1tYXNrDQo+ID4gKyAgLSBkbWEtY2hhbm5lbHMNCj4gPiArICAtIGRtYS1yZXF1
ZXN0cw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+
ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svbXQ2Nzc5LWNsay5oPg0KPiA+ICsgICAgY3FkbWE6IGRtYS1jb250cm9s
bGVyQDEwMjEyMDAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3
OS1jcWRtYSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MTAyMTIwMDAgMHg4MD4sDQo+ID4gKyAg
ICAgICAgICAgIDwweDEwMjEyMDgwIDB4ODA+LA0KPiA+ICsgICAgICAgICAgICA8MHgxMDIxMjEw
MCAweDgwPjsNCj4gPiArICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTM5IElSUV9UWVBF
X0xFVkVMX0xPVz4sDQo+ID4gKyAgICAgICAgICAgIDxHSUNfU1BJIDE0MCBJUlFfVFlQRV9MRVZF
TF9MT1c+LA0KPiA+ICsgICAgICAgICAgICA8R0lDX1NQSSAxNDEgSVJRX1RZUEVfTEVWRUxfTE9X
PjsNCj4gPiArICAgICAgICBjbG9ja3MgPSA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9DUV9ETUE+
Ow0KPiA+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gImNxZG1hIjsNCj4gPiArICAgICAgICBkbWEt
Y2hhbm5lbC1tYXNrID0gPDYzPjsNCj4gPiArICAgICAgICBkbWEtY2hhbm5lbHMgPSA8Mz47DQo+
ID4gKyAgICAgICAgZG1hLXJlcXVlc3RzID0gPDMyPjsNCj4gPiArICAgICAgICAjZG1hLWNlbGxz
ID0gPDE+Ow0KPiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKy4uLg0KPiA+IA0KDQo=

