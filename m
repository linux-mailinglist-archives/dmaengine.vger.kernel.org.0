Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA39211C64
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgGBHGT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 03:06:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10269 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726092AbgGBHGS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jul 2020 03:06:18 -0400
X-UUID: 636801d9dbf547d8b99a1bd777189e02-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n0+3nalOnCe5kMDaPoGslleQoLkeFnp/IEmHOyucpjg=;
        b=GW/3TiTtQBGR+W0bPTqqRJ8354WU+piTOHrka2NBgnXNzLt4uXWZ0oaFJHcbC3kAZi2awj1Itb+HldkgETDiM+ENIEFAgqCD3uE8tahKHn0xybX0SG5AiVLM2RSr2bulqMe4bNmoDWIBXkZx+Upn1Oeo9T6NC2KmEYD2XHhr8ZY=;
X-UUID: 636801d9dbf547d8b99a1bd777189e02-20200702
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1323588874; Thu, 02 Jul 2020 15:06:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 15:06:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 15:06:08 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v6 1/4] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller bindings
Date:   Thu, 2 Jul 2020 15:06:01 +0800
Message-ID: <1593673564-4425-2-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F3A085BAD89C115B095C1B7865FA2C326AC77083018D7895F5C7BDECC91F38FB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RG9jdW1lbnQgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQtUXVl
dWUgRE1BIGNvbnRyb2xsZXINCndoaWNoIGNvdWxkIGJlIGZvdW5kIG9uIE1UNjc3OSBTb0Mgb3Ig
b3RoZXIgc2ltaWxhciBNZWRpYXRlayBTb0NzLg0KDQpTaWduZWQtb2ZmLWJ5OiBFYXN0TCBMZWUg
PEVhc3RMLkxlZUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9k
bWEvbXRrLWNxZG1hLnlhbWwgICAgICAgICB8IDExMyArKysrKysrKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMTEzIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFtbA0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1hLnlh
bWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi44M2VkNzQyDQotLS0gL2Rl
di9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1j
cWRtYS55YW1sDQpAQCAtMCwwICsxLDExMyBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDog
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZG1hL210ay1jcWRtYS55YW1sIw0KKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3Rp
dGxlOiBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyIERldmljZSBUcmVlIEJp
bmRpbmcNCisNCittYWludGFpbmVyczoNCisgIC0gRWFzdEwgTGVlIDxFYXN0TC5MZWVAbWVkaWF0
ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEg
Y29udHJvbGxlciAoQ1FETUEpIG9uIE1lZGlhdGVrIFNvQw0KKyAgaXMgZGVkaWNhdGVkIHRvIG1l
bW9yeS10by1tZW1vcnkgdHJhbnNmZXIgdGhyb3VnaCBxdWV1ZSBiYXNlZA0KKyAgZGVzY3JpcHRv
ciBtYW5hZ2VtZW50Lg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAiZG1hLWNvbnRyb2xsZXIueWFt
bCMiDQorDQorcHJvcGVydGllczoNCisgICIjZG1hLWNlbGxzIjoNCisgICAgbWluaW11bTogMQ0K
KyAgICBtYXhpbXVtOiAyNTUNCisgICAgZGVzY3JpcHRpb246DQorICAgICAgVXNlZCB0byBwcm92
aWRlIERNQSBjb250cm9sbGVyIHNwZWNpZmljIGluZm9ybWF0aW9uLg0KKw0KKyAgY29tcGF0aWJs
ZToNCisgICAgb25lT2Y6DQorICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ2NzY1LWNxZG1hDQor
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ2Nzc5LWNxZG1hDQorDQorICByZWc6DQorICAgIG1p
bkl0ZW1zOiAxDQorICAgIG1heEl0ZW1zOiA1DQorICAgIGRlc2NyaXB0aW9uOg0KKyAgICAgICAg
QSBiYXNlIGFkZHJlc3Mgb2YgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwN
CisgICAgICAgIGEgY2hhbm5lbCB3aWxsIGhhdmUgYSBzZXQgb2YgYmFzZSBhZGRyZXNzLg0KKw0K
KyAgaW50ZXJydXB0czoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDUNCisgICAg
ZGVzY3JpcHRpb246DQorICAgICAgICBBIGludGVycnVwdCBudW1iZXIgb2YgTWVkaWFUZWsgQ29t
bWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCisgICAgICAgIG9uZSBpbnRlcnJ1cHQgbnVtYmVy
IHBlciBkbWEtY2hhbm5lbHMuDQorDQorICBjbG9ja3M6DQorICAgIG1heEl0ZW1zOiAxDQorDQor
ICBjbG9jay1uYW1lczoNCisgICAgY29uc3Q6IGNxZG1hDQorDQorICBkbWEtY2hhbm5lbC1tYXNr
Og0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sI2RlZmluaXRpb25zL3VpbnQzMg0KKyAg
ICBkZXNjcmlwdGlvbjoNCisgICAgICAgRm9yIERNQSBjYXBhYmlsaXR5LCBXZSB3aWxsIGtub3cg
dGhlIGFkZHJlc3NpbmcgY2FwYWJpbGl0eSBvZg0KKyAgICAgICBNZWRpYVRlayBDb21tYW5kLVF1
ZXVlIERNQSBjb250cm9sbGVyIHRocm91Z2ggZG1hLWNoYW5uZWwtbWFzay4NCisgICAgaXRlbXM6
DQorICAgICAgbWluSXRlbXM6IDENCisgICAgICBtYXhJdGVtczogNjMNCisNCisgIGRtYS1jaGFu
bmVsczoNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzIN
CisgICAgZGVzY3JpcHRpb246DQorICAgICAgTnVtYmVyIG9mIERNQSBjaGFubmVscyBzdXBwb3J0
ZWQgYnkgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUENCisgICAgICBjb250cm9sbGVyLCBzdXBw
b3J0IHVwIHRvIGZpdmUuDQorICAgIGl0ZW1zOg0KKyAgICAgIG1pbkl0ZW1zOiAxDQorICAgICAg
bWF4SXRlbXM6IDUNCisNCisgIGRtYS1yZXF1ZXN0czoNCisgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzINCisgICAgZGVzY3JpcHRpb246DQorICAgICAgTnVt
YmVyIG9mIERNQSByZXF1ZXN0ICh2aXJ0dWFsIGNoYW5uZWwpIHN1cHBvcnRlZCBieSBNZWRpYVRl
aw0KKyAgICAgIENvbW1hbmQtUXVldWUgRE1BIGNvbnRyb2xsZXIsIHN1cHBvcnQgdXAgdG8gMzIu
DQorICAgIGl0ZW1zOg0KKyAgICAgIG1pbkl0ZW1zOiAxDQorICAgICAgbWF4SXRlbXM6IDMyDQor
DQorcmVxdWlyZWQ6DQorICAtICIjZG1hLWNlbGxzIg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJl
Zw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0KKyAgLSBjbG9jay1uYW1lcw0KKyAgLSBk
bWEtY2hhbm5lbC1tYXNrDQorICAtIGRtYS1jaGFubmVscw0KKyAgLSBkbWEtcmVxdWVzdHMNCisN
CithZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAg
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQorICAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQor
ICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQorICAgIGNxZG1h
OiBkbWEtY29udHJvbGxlckAxMDIxMjAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10Njc3OS1jcWRtYSI7DQorICAgICAgICByZWcgPSA8MHgxMDIxMjAwMCAweDgwPiwNCisg
ICAgICAgICAgICA8MHgxMDIxMjA4MCAweDgwPiwNCisgICAgICAgICAgICA8MHgxMDIxMjEwMCAw
eDgwPjsNCisgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMzkgSVJRX1RZUEVfTEVWRUxf
TE9XPiwNCisgICAgICAgICAgICA8R0lDX1NQSSAxNDAgSVJRX1RZUEVfTEVWRUxfTE9XPiwNCisg
ICAgICAgICAgICA8R0lDX1NQSSAxNDEgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisgICAgICAgIGNs
b2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0NRX0RNQT47DQorICAgICAgICBjbG9jay1u
YW1lcyA9ICJjcWRtYSI7DQorICAgICAgICBkbWEtY2hhbm5lbC1tYXNrID0gPDYzPjsNCisgICAg
ICAgIGRtYS1jaGFubmVscyA9IDwzPjsNCisgICAgICAgIGRtYS1yZXF1ZXN0cyA9IDwzMj47DQor
ICAgICAgICAjZG1hLWNlbGxzID0gPDE+Ow0KKyAgICB9Ow0KKw0KKy4uLg0KLS0gDQoxLjkuMQ0K

