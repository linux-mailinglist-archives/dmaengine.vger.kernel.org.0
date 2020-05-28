Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E753B1E5C82
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 11:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgE1J5k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 05:57:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29687 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387629AbgE1J5f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 05:57:35 -0400
X-UUID: 7aad5b26800d4fc391914dab168756f1-20200528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qNLHaRDt92Fy5R0FyEm9iP9GROfWqd9LmF7e4CqwFP0=;
        b=XU5BUltNIun+r3mRjeUxy9HDmgTHIXjk2c53rPThGHdCW1dsA413P0uDwuiE7UbHpKnHJUOQwCrj7nOuggYhMhIsm3YYpkywYlWKqyA91aiF+AvES24DX1vRpa6rAhO66WeJZ3q2AVkFcasePYdgasiT9Hu74YMIp3Rh44U3faY=;
X-UUID: 7aad5b26800d4fc391914dab168756f1-20200528
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 141802822; Thu, 28 May 2020 17:57:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 May 2020 17:57:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 May 2020 17:57:19 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, EastL <EastL.Lee@mediatek.com>
Subject: [PATCH v4 1/4] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller bindings
Date:   Thu, 28 May 2020 17:57:09 +0800
Message-ID: <1590659832-31476-2-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
References: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6D5D9921259AA598827C15891D3DFD3FA6561D05860E5A426B9F9233B9394F702000:8
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
dGstY3FkbWEueWFtbCAgICAgICAgIHwgMTAwICsrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sDQoNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFtbA0K
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjA0NWFhMGMNCi0tLSAvZGV2L251
bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNxZG1h
LnlhbWwNCkBAIC0wLDAgKzEsMTAwIEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMA0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvZG1hL210ay1jcWRtYS55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBNZWRpYVRlayBDb21tYW5kLVF1ZXVl
IERNQSBjb250cm9sbGVyIERldmljZSBUcmVlIEJpbmRpbmcNCisNCittYWludGFpbmVyczoNCisg
IC0gRWFzdEwgPEVhc3RMLkxlZUBtZWRpYXRlay5jb20+DQorDQorZGVzY3JpcHRpb246DQorICBN
ZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyIChDUURNQSkgb24gTWVkaWF0ZWsg
U29DDQorICBpcyBkZWRpY2F0ZWQgdG8gbWVtb3J5LXRvLW1lbW9yeSB0cmFuc2ZlciB0aHJvdWdo
IHF1ZXVlIGJhc2VkDQorICBkZXNjcmlwdG9yIG1hbmFnZW1lbnQuDQorDQorcHJvcGVydGllczoN
CisgICIjZG1hLWNlbGxzIjoNCisgICAgbWluaW11bTogMQ0KKyAgICAjIFNob3VsZCBiZSBlbm91
Z2gNCisgICAgbWF4aW11bTogMjU1DQorICAgIGRlc2NyaXB0aW9uOg0KKyAgICAgIFVzZWQgdG8g
cHJvdmlkZSBETUEgY29udHJvbGxlciBzcGVjaWZpYyBpbmZvcm1hdGlvbi4NCisNCisgIGNvbXBh
dGlibGU6DQorICAgIGNvbnN0OiBtZWRpYXRlayxjcWRtYQ0KKw0KKyAgcmVnOg0KKyAgICBtaW5J
dGVtczogMQ0KKyAgICBtYXhJdGVtczogMjU1DQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBtaW5J
dGVtczogMQ0KKyAgICBtYXhJdGVtczogMjU1DQorDQorICBjbG9ja3M6DQorICAgIG1heEl0ZW1z
OiAxDQorDQorICBjbG9jay1uYW1lczoNCisgICAgY29uc3Q6IGNxZG1hDQorDQorICBkbWEtY2hh
bm5lbC1tYXNrOg0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICBCaXRtYXNrIG9mIGF2YWlsYWJs
ZSBETUEgY2hhbm5lbHMgaW4gYXNjZW5kaW5nIG9yZGVyIHRoYXQgYXJlDQorICAgICAgbm90IHJl
c2VydmVkIGJ5IGZpcm13YXJlIGFuZCBhcmUgYXZhaWxhYmxlIHRvIHRoZQ0KKyAgICAgIGtlcm5l
bC4gaS5lLiBmaXJzdCBjaGFubmVsIGNvcnJlc3BvbmRzIHRvIExTQi4NCisgICAgICBUaGUgZmly
c3QgaXRlbSBpbiB0aGUgYXJyYXkgaXMgZm9yIGNoYW5uZWxzIDAtMzEsIHRoZSBzZWNvbmQgaXMg
Zm9yDQorICAgICAgY2hhbm5lbHMgMzItNjMsIGV0Yy4NCisgICAgYWxsT2Y6DQorICAgICAgLSAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzItYXJyYXkNCisgICAg
aXRlbXM6DQorICAgICAgbWluSXRlbXM6IDENCisgICAgICAjIFNob3VsZCBiZSBlbm91Z2gNCisg
ICAgICBtYXhJdGVtczogMjU1DQorDQorICBkbWEtY2hhbm5lbHM6DQorICAgICRyZWY6IC9zY2hl
bWFzL3R5cGVzLnlhbWwjZGVmaW5pdGlvbnMvdWludDMyDQorICAgIGRlc2NyaXB0aW9uOg0KKyAg
ICAgIE51bWJlciBvZiBETUEgY2hhbm5lbHMgc3VwcG9ydGVkIGJ5IHRoZSBjb250cm9sbGVyLg0K
Kw0KKyAgZG1hLXJlcXVlc3RzOg0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sI2RlZmlu
aXRpb25zL3VpbnQzMg0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICBOdW1iZXIgb2YgRE1BIHJl
cXVlc3Qgc2lnbmFscyBzdXBwb3J0ZWQgYnkgdGhlIGNvbnRyb2xsZXIuDQorDQorcmVxdWlyZWQ6
DQorICAtICIjZG1hLWNlbGxzIg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBpbnRl
cnJ1cHRzDQorICAtIGNsb2Nrcw0KKyAgLSBjbG9jay1uYW1lcw0KKyAgLSBkbWEtY2hhbm5lbC1t
YXNrDQorICAtIGRtYS1jaGFubmVscw0KKyAgLSBkbWEtcmVxdWVzdHMNCisNCithZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQorICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQorICAgIGNxZG1hOiBkbWEtY29udHJv
bGxlckAxMDIxMjAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLGNxZG1hIjsN
CisgICAgICAgIHJlZyA9IDwwIDB4MTAyMTIwMDAgMCAweDgwPiwNCisgICAgICAgICAgICA8MCAw
eDEwMjEyMDgwIDAgMHg4MD4sDQorICAgICAgICAgICAgPDAgMHgxMDIxMjEwMCAwIDB4ODA+Ow0K
KyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEzOSBJUlFfVFlQRV9MRVZFTF9MT1c+LA0K
KyAgICAgICAgICAgIDxHSUNfU1BJIDE0MCBJUlFfVFlQRV9MRVZFTF9MT1c+LA0KKyAgICAgICAg
ICAgIDxHSUNfU1BJIDE0MSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKyAgICAgICAgY2xvY2tzID0g
PCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfQ1FfRE1BPjsNCisgICAgICAgIGNsb2NrLW5hbWVzID0g
ImNxZG1hIjsNCisgICAgICAgIGRtYS1jaGFubmVsLW1hc2sgPSA8NjM+Ow0KKyAgICAgICAgZG1h
LWNoYW5uZWxzID0gPDM+Ow0KKyAgICAgICAgZG1hLXJlcXVlc3RzID0gPDMyPjsNCisgICAgICAg
ICNkbWEtY2VsbHMgPSA8MT47DQorICAgIH07DQorDQorLi4uDQotLSANCjEuOS4xDQo=

