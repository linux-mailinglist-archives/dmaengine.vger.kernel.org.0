Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663E4247C66
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 05:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHRDEN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 23:04:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42987 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgHRDEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Aug 2020 23:04:11 -0400
X-UUID: 105bf3c2538f4840a8358350a7e1071c-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ahbWRcPcWQCgNbqrlq91xsX5/hkLrfZyOxN384yVm+I=;
        b=qP61zNLvFgfdN7yrjoLUecdRhb+3Dy7uLGoU5BzbKPt+dgWycMaELUTLXDeQ/Q0pYNGUA0BKDkkcV0eeYELe2TCA7v1ymTLM7LaZ02lOemn7C4036V73d6bN331Nj47IvnVs1CUqZTD9j0BcBrrC4k2S2GPq1nHYFxoqV6d7L3M=;
X-UUID: 105bf3c2538f4840a8358350a7e1071c-20200818
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2066810986; Tue, 18 Aug 2020 11:04:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 11:04:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 11:04:02 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v7 3/4] dmaengine: mediatek-cqdma: add dma mask for capability
Date:   Tue, 18 Aug 2020 11:03:53 +0800
Message-ID: <1597719834-6675-4-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
References: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgZG1hIG1hc2sgZm9yIGNhcGFiaWxpdHkuDQoNClNpZ25lZC1vZmYtYnk6
IEVhc3RMIExlZSA8RWFzdEwuTGVlQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBNYXR0aGlh
cyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KLS0tDQogZHJpdmVycy9kbWEvbWVk
aWF0ZWsvbXRrLWNxZG1hLmMgfCAxNyArKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9tZWRpYXRlay9t
dGstY3FkbWEuYyBiL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRtYS5jDQppbmRleCA5MDVi
YmNiLi4xNjEwNjMyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1h
LmMNCisrKyBiL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRtYS5jDQpAQCAtMTE3LDYgKzEx
Nyw3IEBAIHN0cnVjdCBtdGtfY3FkbWFfdmNoYW4gew0KICAqIEBjbGs6ICAgICAgICAgICAgICAg
ICAgICBUaGUgY2xvY2sgdGhhdCBkZXZpY2UgaW50ZXJuYWwgaXMgdXNpbmcNCiAgKiBAZG1hX3Jl
cXVlc3RzOiAgICAgICAgICAgVGhlIG51bWJlciBvZiBWQ3MgdGhlIGRldmljZSBzdXBwb3J0cyB0
bw0KICAqIEBkbWFfY2hhbm5lbHM6ICAgICAgICAgICBUaGUgbnVtYmVyIG9mIFBDcyB0aGUgZGV2
aWNlIHN1cHBvcnRzIHRvDQorICogQGRtYV9tYXNrOiAgICAgICAgICAgICAgIEEgbWFzayBmb3Ig
RE1BIGNhcGFiaWxpdHkNCiAgKiBAdmM6ICAgICAgICAgICAgICAgICAgICAgVGhlIHBvaW50ZXIg
dG8gYWxsIGF2YWlsYWJsZSBWQ3MNCiAgKiBAcGM6ICAgICAgICAgICAgICAgICAgICAgVGhlIHBv
aW50ZXIgdG8gYWxsIHRoZSB1bmRlcmx5aW5nIFBDcw0KICAqLw0KQEAgLTEyNiw2ICsxMjcsNyBA
QCBzdHJ1Y3QgbXRrX2NxZG1hX2RldmljZSB7DQogDQogCXUzMiBkbWFfcmVxdWVzdHM7DQogCXUz
MiBkbWFfY2hhbm5lbHM7DQorCXUzMiBkbWFfbWFzazsNCiAJc3RydWN0IG10a19jcWRtYV92Y2hh
biAqdmM7DQogCXN0cnVjdCBtdGtfY3FkbWFfcGNoYW4gKipwYzsNCiB9Ow0KQEAgLTYwNyw2ICs2
MDksMjEgQEAgc3RhdGljIGludCBtdGtfY3FkbWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCiAJCWNxZG1hLT5kbWFfY2hhbm5lbHMgPSBNVEtfQ1FETUFfTlJfUENIQU5TOw0K
IAl9DQogDQorCWlmIChwZGV2LT5kZXYub2Zfbm9kZSkNCisJCWVyciA9IG9mX3Byb3BlcnR5X3Jl
YWRfdTMyKHBkZXYtPmRldi5vZl9ub2RlLA0KKwkJCQkJICAgImRtYS1jaGFubmVsLW1hc2siLA0K
KwkJCQkJICAgJmNxZG1hLT5kbWFfbWFzayk7DQorCWlmIChlcnIpIHsNCisJCWRldl93YXJuKCZw
ZGV2LT5kZXYsDQorCQkJICJVc2luZyAwIGFzIG1pc3NpbmcgZG1hLWNoYW5uZWwtbWFzayBwcm9w
ZXJ0eVxuIik7DQorCQljcWRtYS0+ZG1hX21hc2sgPSAwOw0KKwl9DQorDQorCWlmIChkbWFfc2V0
X21hc2soJnBkZXYtPmRldiwgRE1BX0JJVF9NQVNLKGNxZG1hLT5kbWFfbWFzaykpKSB7DQorCQlk
ZXZfd2FybigmcGRldi0+ZGV2LCAiRE1BIHNldCBtYXNrIGZhaWxlZFxuIik7DQorCQlyZXR1cm4g
LUVJTlZBTDsNCisJfQ0KKw0KIAljcWRtYS0+cGMgPSBkZXZtX2tjYWxsb2MoJnBkZXYtPmRldiwg
Y3FkbWEtPmRtYV9jaGFubmVscywNCiAJCQkJIHNpemVvZigqY3FkbWEtPnBjKSwgR0ZQX0tFUk5F
TCk7DQogCWlmICghY3FkbWEtPnBjKQ0KLS0gDQoxLjkuMQ0K

