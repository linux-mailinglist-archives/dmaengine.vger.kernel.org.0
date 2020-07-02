Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E97211C68
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGBHGZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 03:06:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57893 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727016AbgGBHGV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jul 2020 03:06:21 -0400
X-UUID: d6f753b21deb476b9fcd800fd475d515-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=z5va3/AjR9BOKysLPqHUxTjjVWjXMnzJGleraFtyTOA=;
        b=jS/zaYTuSwEvykbYduS/AgreawYnnkxhIYe99Gt8MrILpo9aYFPugiW2cSQC7WqTIPmNpmfF6hoMifhsSFYFpVq8tfw9JbUB1364LYpC9c/rW57Z37K6tovXF9Q6XjHTDRJyQbqxpfWm0U4Tsd3GqipLY/7lpJgWHtoaUS+4SMg=;
X-UUID: d6f753b21deb476b9fcd800fd475d515-20200702
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 672093118; Thu, 02 Jul 2020 15:06:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 15:06:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 15:06:17 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v6 4/4] dmaengine: mediatek-cqdma: fix compatible
Date:   Thu, 2 Jul 2020 15:06:04 +0800
Message-ID: <1593673564-4425-5-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIG10Njc3OSBjb21wYXRpYmxlLg0KDQpTaWduZWQtb2ZmLWJ5OiBFYXN0
TCBMZWUgPEVhc3RMLkxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9tZWRpYXRl
ay9tdGstY3FkbWEuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMgYi9kcml2ZXJzL2Rt
YS9tZWRpYXRlay9tdGstY3FkbWEuYw0KaW5kZXggMTYxMDYzMi4uMTdiM2FiOSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9t
ZWRpYXRlay9tdGstY3FkbWEuYw0KQEAgLTU0Nyw2ICs1NDcsNyBAQCBzdGF0aWMgdm9pZCBtdGtf
Y3FkbWFfaHdfZGVpbml0KHN0cnVjdCBtdGtfY3FkbWFfZGV2aWNlICpjcWRtYSkNCiANCiBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfY3FkbWFfbWF0Y2hbXSA9IHsNCiAJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NjUtY3FkbWEiIH0sDQorCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ2Nzc5LWNxZG1hIiB9LA0KIAl7IC8qIHNlbnRpbmVsICovIH0NCiB9Ow0K
IE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10a19jcWRtYV9tYXRjaCk7DQotLSANCjEuOS4xDQo=

