Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B51B952F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 04:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD0CxL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Apr 2020 22:53:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36177 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgD0CxK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Apr 2020 22:53:10 -0400
X-UUID: 1ba4c3b23d5b4af3909b369921f69c7f-20200427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8LWf1I8Bi1Ln+BLzpkqWL3VaHaWi3jnB2wOQ6Ts6Fl0=;
        b=izpe41QGBZWL9LwKTnlWeCg8Zp3ukAyaAXfN+o8wEQUjtcYUxP0B7Se6WPGk24wYHfBu25XwGwyBn++SH/TtWTL6MhDBgrugvsLRWgFt/KWvgC41UocNHwVXkCu9tx/gDZ6VYRkego7alKb2WKFpgeaaKCeREJkhJbcXnbB6Bn8=;
X-UUID: 1ba4c3b23d5b4af3909b369921f69c7f-20200427
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1661269913; Mon, 27 Apr 2020 10:53:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 10:53:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Apr 2020 10:53:02 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, EastL <EastL.Lee@mediatek.com>
Subject: [PATCH v3 1/2] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller bindings
Date:   Mon, 27 Apr 2020 10:52:56 +0800
Message-ID: <1587955977-17207-2-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587955977-17207-1-git-send-email-EastL.Lee@mediatek.com>
References: <1587955977-17207-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
dGstY3FkbWEueWFtbCAgICAgICAgIHwgOTggKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1hLnlhbWwNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1hLnlhbWwg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sDQpu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uY2QyNjVlOA0KLS0tIC9kZXYvbnVs
bA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEu
eWFtbA0KQEAgLTAsMCArMSw5OCBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L2RtYS9tdGstY3FkbWEueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBE
TUEgY29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5nDQorDQorbWFpbnRhaW5lcnM6DQorICAt
IEVhc3RMIDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAgTWVk
aWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciAoQ1FETUEpIG9uIE1lZGlhdGVrIFNv
Qw0KKyAgaXMgZGVkaWNhdGVkIHRvIG1lbW9yeS10by1tZW1vcnkgdHJhbnNmZXIgdGhyb3VnaCBx
dWV1ZSBiYXNlZA0KKyAgZGVzY3JpcHRvciBtYW5hZ2VtZW50Lg0KKw0KK3Byb3BlcnRpZXM6DQor
ICAiI2RtYS1jZWxscyI6DQorICAgIG1pbmltdW06IDENCisgICAgIyBTaG91bGQgYmUgZW5vdWdo
DQorICAgIG1heGltdW06IDI1NQ0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICBVc2VkIHRvIHBy
b3ZpZGUgRE1BIGNvbnRyb2xsZXIgc3BlY2lmaWMgaW5mb3JtYXRpb24uDQorDQorICBjb21wYXRp
YmxlOg0KKyAgICBjb25zdDogbWVkaWF0ZWssY3FkbWENCisNCisgIHJlZzoNCisgICAgbWF4SXRl
bXM6IDI1NQ0KKw0KKyAgaW50ZXJydXB0czoNCisgICAgbWF4SXRlbXM6IDI1NQ0KKw0KKyAgY2xv
Y2tzOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgY2xvY2stbmFtZXM6DQorICAgIGNvbnN0OiBj
cWRtYQ0KKw0KKyAgZG1hLWNoYW5uZWwtbWFzazoNCisgICAgZGVzY3JpcHRpb246DQorICAgICAg
Qml0bWFzayBvZiBhdmFpbGFibGUgRE1BIGNoYW5uZWxzIGluIGFzY2VuZGluZyBvcmRlciB0aGF0
IGFyZQ0KKyAgICAgIG5vdCByZXNlcnZlZCBieSBmaXJtd2FyZSBhbmQgYXJlIGF2YWlsYWJsZSB0
byB0aGUNCisgICAgICBrZXJuZWwuIGkuZS4gZmlyc3QgY2hhbm5lbCBjb3JyZXNwb25kcyB0byBM
U0IuDQorICAgICAgVGhlIGZpcnN0IGl0ZW0gaW4gdGhlIGFycmF5IGlzIGZvciBjaGFubmVscyAw
LTMxLCB0aGUgc2Vjb25kIGlzIGZvcg0KKyAgICAgIGNoYW5uZWxzIDMyLTYzLCBldGMuDQorICAg
IGFsbE9mOg0KKyAgICAgIC0gJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyLWFycmF5DQorICAgIGl0ZW1zOg0KKyAgICAgIG1pbkl0ZW1zOiAxDQorICAgICAgIyBT
aG91bGQgYmUgZW5vdWdoDQorICAgICAgbWF4SXRlbXM6IDI1NQ0KKw0KKyAgZG1hLWNoYW5uZWxz
Og0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sI2RlZmluaXRpb25zL3VpbnQzMg0KKyAg
ICBkZXNjcmlwdGlvbjoNCisgICAgICBOdW1iZXIgb2YgRE1BIGNoYW5uZWxzIHN1cHBvcnRlZCBi
eSB0aGUgY29udHJvbGxlci4NCisNCisgIGRtYS1yZXF1ZXN0czoNCisgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCNkZWZpbml0aW9ucy91aW50MzINCisgICAgZGVzY3JpcHRpb246DQorICAg
ICAgTnVtYmVyIG9mIERNQSByZXF1ZXN0IHNpZ25hbHMgc3VwcG9ydGVkIGJ5IHRoZSBjb250cm9s
bGVyLg0KKw0KK3JlcXVpcmVkOg0KKyAgLSAiI2RtYS1jZWxscyINCisgIC0gY29tcGF0aWJsZQ0K
KyAgLSByZWcNCisgIC0gaW50ZXJydXB0cw0KKyAgLSBjbG9ja3MNCisgIC0gY2xvY2stbmFtZXMN
CisgIC0gZG1hLWNoYW5uZWwtbWFzaw0KKyAgLSBkbWEtY2hhbm5lbHMNCisgIC0gZG1hLXJlcXVl
c3RzDQorDQorYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6DQorICAt
IHwNCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5o
Pg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdp
Yy5oPg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ2Nzc5LWNsay5oPg0KKyAg
ICBjcWRtYTogZG1hLWNvbnRyb2xsZXJAMTAyMTIwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxjcWRtYSI7DQorICAgICAgICByZWcgPSA8MCAweDEwMjEyMDAwIDAgMHg4MD4s
DQorICAgICAgICAgICAgPDAgMHgxMDIxMjA4MCAwIDB4ODA+LA0KKyAgICAgICAgICAgIDwwIDB4
MTAyMTIxMDAgMCAweDgwPjsNCisgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMzkgSVJR
X1RZUEVfTEVWRUxfTE9XPiwNCisgICAgICAgICAgICA8R0lDX1NQSSAxNDAgSVJRX1RZUEVfTEVW
RUxfTE9XPiwNCisgICAgICAgICAgICA8R0lDX1NQSSAxNDEgSVJRX1RZUEVfTEVWRUxfTE9XPjsN
CisgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0NRX0RNQT47DQorICAg
ICAgICBjbG9jay1uYW1lcyA9ICJjcWRtYSI7DQorICAgICAgICBkbWEtY2hhbm5lbC1tYXNrID0g
PDYzPjsNCisgICAgICAgIGRtYS1jaGFubmVscyA9IDwzPjsNCisgICAgICAgIGRtYS1yZXF1ZXN0
cyA9IDwzMj47DQorICAgICAgICAjZG1hLWNlbGxzID0gPDE+Ow0KKyAgICB9Ow0KKw0KKy4uLg0K
LS0gDQoxLjkuMQ0K

