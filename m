Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72839200343
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2020 10:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgFSIGc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jun 2020 04:06:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20115 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731184AbgFSIGM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Jun 2020 04:06:12 -0400
X-UUID: 62735648027b42f5a0a5a67ccf2d4aa7-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UtXQMNPiKcI1teux/iFeLY1Gk2pKVYDIwGiIqNOtybw=;
        b=jW5Z9Bx2K6HqBA/v9tHRhB2z80MJaXfvJG2L3I2TYpcXKA1I2gEIxYSVkYeBA6VDkIly2sPh5qsdDYmBpsJ9KtiMwPONUlL7CfrVHSDOF8J6WuQd9l/Oe8p2NL07e6PdzgFeLq4TJ6+9k5FRyvjyRS6i2c4dM4k0dZPRq5KVx8M=;
X-UUID: 62735648027b42f5a0a5a67ccf2d4aa7-20200619
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 972338632; Fri, 19 Jun 2020 16:06:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 16:05:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 16:05:06 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, EastL <EastL.Lee@mediatek.com>
Subject: [PATCH v5 1/4] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller bindings
Date:   Fri, 19 Jun 2020 16:04:59 +0800
Message-ID: <1592553902-30592-2-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
References: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 03BA4C7E34FC566C1EE83D711BB1655A4B129E4C11B45DF4651B520F2DD073182000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RG9jdW1lbnQgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1hbmQtUXVl
dWUgRE1BIGNvbnRyb2xsZXINCndoaWNoIGNvdWxkIGJlIGZvdW5kIG9uIE1UNjc3OSBTb0Mgb3Ig
b3RoZXIgc2ltaWxhciBNZWRpYXRlayBTb0NzLg0KDQpTaWduZWQtb2ZmLWJ5OiBFYXN0TCA8RWFz
dEwuTGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9t
dGstY3FkbWEueWFtbCAgICAgICAgIHwgMTE0ICsrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxMTQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sDQoNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFtbA0K
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLmU2ZmRmMDUNCi0tLSAvZGV2L251
bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1h
LnlhbWwNCkBAIC0wLDAgKzEsMTE0IEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvZG1hL210ay1jcWRtYS55YW1sIw0KKyRzY2hlbWE6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBN
ZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyIERldmljZSBUcmVlIEJpbmRpbmcN
CisNCittYWludGFpbmVyczoNCisgIC0gRWFzdEwgTGVlIDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29t
Pg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJv
bGxlciAoQ1FETUEpIG9uIE1lZGlhdGVrIFNvQw0KKyAgaXMgZGVkaWNhdGVkIHRvIG1lbW9yeS10
by1tZW1vcnkgdHJhbnNmZXIgdGhyb3VnaCBxdWV1ZSBiYXNlZA0KKyAgZGVzY3JpcHRvciBtYW5h
Z2VtZW50Lg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAiZG1hLWNvbnRyb2xsZXIueWFtbCMiDQor
DQorcHJvcGVydGllczoNCisgICIjZG1hLWNlbGxzIjoNCisgICAgbWluaW11bTogMQ0KKyAgICBt
YXhpbXVtOiAyNTUNCisgICAgZGVzY3JpcHRpb246DQorICAgICAgVXNlZCB0byBwcm92aWRlIERN
QSBjb250cm9sbGVyIHNwZWNpZmljIGluZm9ybWF0aW9uLg0KKw0KKyAgY29tcGF0aWJsZToNCisg
ICAgb25lT2Y6DQorICAgICAgLSBjb25zdDogbWVkaWF0ZWssY29tbW9uLWNxZG1hDQorICAgICAg
LSBjb25zdDogbWVkaWF0ZWssbXQ2NzY1LWNxZG1hDQorICAgICAgLSBjb25zdDogbWVkaWF0ZWss
bXQ2Nzc5LWNxZG1hDQorDQorICByZWc6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1z
OiA1DQorICAgIGRlc2NyaXB0aW9uOg0KKyAgICAgICAgQSBiYXNlIGFkZHJlc3Mgb2YgTWVkaWFU
ZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCisgICAgICAgIGEgY2hhbm5lbCB3aWxs
IGhhdmUgYSBzZXQgb2YgYmFzZSBhZGRyZXNzLg0KKw0KKyAgaW50ZXJydXB0czoNCisgICAgbWlu
SXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDUNCisgICAgZGVzY3JpcHRpb246DQorICAgICAgICBB
IGludGVycnVwdCBudW1iZXIgb2YgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxl
ciwNCisgICAgICAgIG9uZSBpbnRlcnJ1cHQgbnVtYmVyIHBlciBkbWEtY2hhbm5lbHMuDQorDQor
ICBjbG9ja3M6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBjbG9jay1uYW1lczoNCisgICAgY29u
c3Q6IGNxZG1hDQorDQorICBkbWEtY2hhbm5lbC1tYXNrOg0KKyAgICAkcmVmOiAvc2NoZW1hcy90
eXBlcy55YW1sI2RlZmluaXRpb25zL3VpbnQzMg0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICAg
Rm9yIERNQSBjYXBhYmlsaXR5LCBXZSB3aWxsIGtub3cgdGhlIGFkZHJlc3NpbmcgY2FwYWJpbGl0
eSBvZg0KKyAgICAgICBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyIHRocm91
Z2ggZG1hLWNoYW5uZWwtbWFzay4NCisgICAgaXRlbXM6DQorICAgICAgbWluSXRlbXM6IDENCisg
ICAgICBtYXhJdGVtczogNjMNCisNCisgIGRtYS1jaGFubmVsczoNCisgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzINCisgICAgZGVzY3JpcHRpb246DQorICAg
ICAgTnVtYmVyIG9mIERNQSBjaGFubmVscyBzdXBwb3J0ZWQgYnkgTWVkaWFUZWsgQ29tbWFuZC1R
dWV1ZSBETUENCisgICAgICBjb250cm9sbGVyLCBzdXBwb3J0IHVwIHRvIGZpdmUuDQorICAgIGl0
ZW1zOg0KKyAgICAgIG1pbkl0ZW1zOiAxDQorICAgICAgbWF4SXRlbXM6IDUNCisNCisgIGRtYS1y
ZXF1ZXN0czoNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50
MzINCisgICAgZGVzY3JpcHRpb246DQorICAgICAgTnVtYmVyIG9mIERNQSByZXF1ZXN0ICh2aXJ0
dWFsIGNoYW5uZWwpIHN1cHBvcnRlZCBieSBNZWRpYVRlaw0KKyAgICAgIENvbW1hbmQtUXVldWUg
RE1BIGNvbnRyb2xsZXIsIHN1cHBvcnQgdXAgdG8gMzIuDQorICAgIGl0ZW1zOg0KKyAgICAgIG1p
bkl0ZW1zOiAxDQorICAgICAgbWF4SXRlbXM6IDMyDQorDQorcmVxdWlyZWQ6DQorICAtICIjZG1h
LWNlbGxzIg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQorICAt
IGNsb2Nrcw0KKyAgLSBjbG9jay1uYW1lcw0KKyAgLSBkbWEtY2hhbm5lbC1tYXNrDQorICAtIGRt
YS1jaGFubmVscw0KKyAgLSBkbWEtcmVxdWVzdHMNCisNCithZGRpdGlvbmFsUHJvcGVydGllczog
ZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9jbG9jay9tdDY3NzktY2xrLmg+DQorICAgIGNxZG1hOiBkbWEtY29udHJvbGxlckAxMDIxMjAw
MCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1jcWRtYSI7DQorICAg
ICAgICByZWcgPSA8MHgxMDIxMjAwMCAweDgwPiwNCisgICAgICAgICAgICA8MHgxMDIxMjA4MCAw
eDgwPiwNCisgICAgICAgICAgICA8MHgxMDIxMjEwMCAweDgwPjsNCisgICAgICAgIGludGVycnVw
dHMgPSA8R0lDX1NQSSAxMzkgSVJRX1RZUEVfTEVWRUxfTE9XPiwNCisgICAgICAgICAgICA8R0lD
X1NQSSAxNDAgSVJRX1RZUEVfTEVWRUxfTE9XPiwNCisgICAgICAgICAgICA8R0lDX1NQSSAxNDEg
SVJRX1RZUEVfTEVWRUxfTE9XPjsNCisgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xL
X0lORlJBX0NRX0RNQT47DQorICAgICAgICBjbG9jay1uYW1lcyA9ICJjcWRtYSI7DQorICAgICAg
ICBkbWEtY2hhbm5lbC1tYXNrID0gPDYzPjsNCisgICAgICAgIGRtYS1jaGFubmVscyA9IDwzPjsN
CisgICAgICAgIGRtYS1yZXF1ZXN0cyA9IDwzMj47DQorICAgICAgICAjZG1hLWNlbGxzID0gPDE+
Ow0KKyAgICB9Ow0KKw0KKy4uLg0KLS0gDQoxLjkuMQ0K

