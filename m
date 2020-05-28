Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77DC1E5C80
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbgE1J5f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 05:57:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64347 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387432AbgE1J5c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 05:57:32 -0400
X-UUID: 6082f38dca5f47d18f7e22e002a5a49a-20200528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XQGLN6fdFutFHBD8vBepvTvkM1enLSGlXBe6T7pY8CE=;
        b=jrF79ihggdkpoiu/VgCPR50TEF95ya0hqkdPLqftGmSwGo1S5C3ngWHHUJPrT2anLOoudJZpEO2J/+xiNwBnsN1mKQUv4FqKyi3Z62LIlLFAoBG4eujSaIV00CCkXnrq467R11iIkUe6y4w63fmcR3knYIUQm6di77jN/8ZLodw=;
X-UUID: 6082f38dca5f47d18f7e22e002a5a49a-20200528
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1748239935; Thu, 28 May 2020 17:57:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 May 2020 17:57:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 May 2020 17:57:27 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, EastL <EastL.Lee@mediatek.com>
Subject: [PATCH v4 3/4] dmaengine: mediatek-cqdma: fix compatible
Date:   Thu, 28 May 2020 17:57:11 +0800
Message-ID: <1590659832-31476-4-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
References: <1590659832-31476-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyBtZWRpYXRlay1jcWRtYSBjb21wYXRpYmxlIHRvIGNvbW1vbi4NCg0K
U2lnbmVkLW9mZi1ieTogRWFzdEwgPEVhc3RMLkxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL21l
ZGlhdGVrL210ay1jcWRtYS5jIGIvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMNCmlu
ZGV4IDkwNWJiY2IuLmJjYTcxMTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9tZWRpYXRlay9t
dGstY3FkbWEuYw0KKysrIGIvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMNCkBAIC01
NDQsNyArNTQ0LDcgQEAgc3RhdGljIHZvaWQgbXRrX2NxZG1hX2h3X2RlaW5pdChzdHJ1Y3QgbXRr
X2NxZG1hX2RldmljZSAqY3FkbWEpDQogfQ0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIG10a19jcWRtYV9tYXRjaFtdID0gew0KLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10Njc2NS1jcWRtYSIgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxjcWRtYSIgfSwN
CiAJeyAvKiBzZW50aW5lbCAqLyB9DQogfTsNCiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtf
Y3FkbWFfbWF0Y2gpOw0KLS0gDQoxLjkuMQ0K

