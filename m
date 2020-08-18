Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C72247C6F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 05:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHRDEV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 23:04:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39191 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgHRDEM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Aug 2020 23:04:12 -0400
X-UUID: 816bf7f71a57467c86d99950ac5efbef-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=roRnSX8E3+IeHthgeU6GzNcLhz0+L2KYq1Vlp7FGKKo=;
        b=tKBJViBZ/mVr47fewUJCSOK4Q1mQN0aVpN0xv0z6UmGxv9mODLIYKs8VAJnU7oSiOw6mwXGpAEEXqzyCA6OL4yOLeokRST5Glg9W5dFE50EhjVPox8VN7mRYvpXmRl7p/VS29QpZZuAp5lWr04+xs764z2xr4wYKH9J8KEdg8B8=;
X-UUID: 816bf7f71a57467c86d99950ac5efbef-20200818
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1037151758; Tue, 18 Aug 2020 11:04:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 11:04:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 11:04:01 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v7 1/4] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller bindings
Date:   Tue, 18 Aug 2020 11:03:51 +0800
Message-ID: <1597719834-6675-2-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
References: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 81E63A3996A6462FB693D254C6DEDB144977A71D2905E5306BF2606615EBEA292000:8
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
bWEvbXRrLWNxZG1hLnlhbWwgICAgICAgICB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55YW1sDQoNCmRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL210ay1jcWRtYS55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9tdGstY3FkbWEueWFt
bA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLmZlMDMwODENCi0tLSAvZGV2
L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbXRrLWNx
ZG1hLnlhbWwNCkBAIC0wLDAgKzEsOTggQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2RtYS9tdGstY3FkbWEueWFtbCMNCiskc2NoZW1h
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRs
ZTogTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5k
aW5nDQorDQorbWFpbnRhaW5lcnM6DQorICAtIEVhc3RMIExlZSA8RWFzdEwuTGVlQG1lZGlhdGVr
LmNvbT4NCisNCitkZXNjcmlwdGlvbjoNCisgIE1lZGlhVGVrIENvbW1hbmQtUXVldWUgRE1BIGNv
bnRyb2xsZXIgKENRRE1BKSBvbiBNZWRpYXRlayBTb0MNCisgIGlzIGRlZGljYXRlZCB0byBtZW1v
cnktdG8tbWVtb3J5IHRyYW5zZmVyIHRocm91Z2ggcXVldWUgYmFzZWQNCisgIGRlc2NyaXB0b3Ig
bWFuYWdlbWVudC4NCisNCithbGxPZjoNCisgIC0gJHJlZjogImRtYS1jb250cm9sbGVyLnlhbWwj
Ig0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBvbmVPZjoNCisgICAgICAt
IGNvbnN0OiBtZWRpYXRlayxtdDY3NjUtY3FkbWENCisgICAgICAtIGNvbnN0OiBtZWRpYXRlayxt
dDY3NzktY3FkbWENCisNCisgIHJlZzoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6
IDUNCisgICAgZGVzY3JpcHRpb246DQorICAgICAgICBBIGJhc2UgYWRkcmVzcyBvZiBNZWRpYVRl
ayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVyLA0KKyAgICAgICAgYSBjaGFubmVsIHdpbGwg
aGF2ZSBhIHNldCBvZiBiYXNlIGFkZHJlc3MuDQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBtaW5J
dGVtczogMQ0KKyAgICBtYXhJdGVtczogNQ0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICAgIEEg
aW50ZXJydXB0IG51bWJlciBvZiBNZWRpYVRlayBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9sbGVy
LA0KKyAgICAgICAgb25lIGludGVycnVwdCBudW1iZXIgcGVyIGRtYS1jaGFubmVscy4NCisNCisg
IGNsb2NrczoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGNsb2NrLW5hbWVzOg0KKyAgICBjb25z
dDogY3FkbWENCisNCisgIGRtYS1jaGFubmVsczoNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCNkZWZpbml0aW9ucy91aW50MzINCisgICAgZGVzY3JpcHRpb246DQorICAgICAgTnVtYmVy
IG9mIERNQSBjaGFubmVscyBzdXBwb3J0ZWQgYnkgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEN
CisgICAgICBjb250cm9sbGVyLCBzdXBwb3J0IHVwIHRvIGZpdmUuDQorICAgIGl0ZW1zOg0KKyAg
ICAgIG1pbmltdW06IDENCisgICAgICBtYXhpbXVtOiA1DQorDQorICBkbWEtcmVxdWVzdHM6DQor
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjZGVmaW5pdGlvbnMvdWludDMyDQorICAgIGRl
c2NyaXB0aW9uOg0KKyAgICAgIE51bWJlciBvZiBETUEgcmVxdWVzdCAodmlydHVhbCBjaGFubmVs
KSBzdXBwb3J0ZWQgYnkgTWVkaWFUZWsNCisgICAgICBDb21tYW5kLVF1ZXVlIERNQSBjb250cm9s
bGVyLCBzdXBwb3J0IHVwIHRvIDMyLg0KKyAgICBpdGVtczoNCisgICAgICBtaW5pbXVtOiAxDQor
ICAgICAgbWF4aW11bTogMzINCisNCityZXF1aXJlZDoNCisgIC0gIiNkbWEtY2VsbHMiDQorICAt
IGNvbXBhdGlibGUNCisgIC0gcmVnDQorICAtIGludGVycnVwdHMNCisgIC0gY2xvY2tzDQorICAt
IGNsb2NrLW5hbWVzDQorICAtIGRtYS1jaGFubmVsLW1hc2sNCisgIC0gZG1hLWNoYW5uZWxzDQor
ICAtIGRtYS1yZXF1ZXN0cw0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4
YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9pcnEuaD4NCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL2FybS1naWMuaD4NCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210Njc3
OS1jbGsuaD4NCisgICAgY3FkbWE6IGRtYS1jb250cm9sbGVyQDEwMjEyMDAwIHsNCisgICAgICAg
IGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LWNxZG1hIjsNCisgICAgICAgIHJlZyA9IDww
eDEwMjEyMDAwIDB4ODA+LA0KKyAgICAgICAgICAgIDwweDEwMjEyMDgwIDB4ODA+LA0KKyAgICAg
ICAgICAgIDwweDEwMjEyMTAwIDB4ODA+Ow0KKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDEzOSBJUlFfVFlQRV9MRVZFTF9MT1c+LA0KKyAgICAgICAgICAgIDxHSUNfU1BJIDE0MCBJUlFf
VFlQRV9MRVZFTF9MT1c+LA0KKyAgICAgICAgICAgIDxHSUNfU1BJIDE0MSBJUlFfVFlQRV9MRVZF
TF9MT1c+Ow0KKyAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFfQ1FfRE1B
PjsNCisgICAgICAgIGNsb2NrLW5hbWVzID0gImNxZG1hIjsNCisgICAgICAgIGRtYS1jaGFubmVs
LW1hc2sgPSA8MHgzZj47DQorICAgICAgICBkbWEtY2hhbm5lbHMgPSA8Mz47DQorICAgICAgICBk
bWEtcmVxdWVzdHMgPSA8MzI+Ow0KKyAgICAgICAgI2RtYS1jZWxscyA9IDwxPjsNCisgICAgfTsN
CisNCisuLi4NCi0tIA0KMS45LjENCg==

