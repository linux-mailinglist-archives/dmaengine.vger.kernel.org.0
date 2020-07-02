Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11643211C60
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgGBHGR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 03:06:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56498 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726733AbgGBHGR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Jul 2020 03:06:17 -0400
X-UUID: 8e5f5d2f0e8945e2a7224e2164eb2a93-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GxrmFz7Pchk0LDKgF6ZwoVEc2QOYVFPDOOWLPzi5ts0=;
        b=WQ74p2S6bsQEc0ZqyOknh0W/UT58QGuJ1Vflfnnx8nmrqy3Mv8IWG9+QW6S19RxbqrbBw7AgztXIPlj/oH8Yd5C+7ahk5XVXF7DQb/Q9tRf0DMockMsljZBDcJW6xCGuVe+1gTUn0JTOSqhy4BdrKQnskl8zNc/FtptPoEDWscI=;
X-UUID: 8e5f5d2f0e8945e2a7224e2164eb2a93-20200702
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 579252762; Thu, 02 Jul 2020 15:06:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 15:06:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 15:06:07 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>
Subject: [PATCH v6] dmaengine: mediatek-cqdma: add dt-bindings and remove redundant queue
Date:   Thu, 2 Jul 2020 15:06:00 +0800
Message-ID: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

VGhpcyBwYXRjaCBzZXQgYWRkcyBkb2N1bWVudCB0aGUgZGV2aWNldHJlZSBiaW5kaW5ncyBmb3Ig
TWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCmFuZCByZW1vdmUgcmVkdW5k
YW50IHF1ZXVlIHN0cnVjdHVyZS4NCg0KaGFuZ2VzIHNpbmNlIHY1Og0KLSBmaXggZnVsbCBuYW1l
DQoNCmhhbmdlcyBzaW5jZSB2NDoNCi0gZml4IHlhbWwgJiBkbWEtbWFzayBjb2RlIGZsb3cNCg0K
aGFuZ2VzIHNpbmNlIHYzOg0KLSBmaXggZHRfYmluZGluZ19jaGVjayBlcnJvcnMNCg0KQ2hhbmdl
cyBzaW5jZSB2MjoNCi0gYWRkIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIENvbW1h
bmQtUXVldWUgRE1BIGNvbnRyb2xsZXINCg0KQ2hhbmdlcyBzaW5jZSB2MToNCi0gcmVtb3ZlIHJl
ZHVuZGFudCBxdWV1ZSBzdHJ1Y3R1cmUNCi0gZml4IHdyb25nIGRlc2NyaXB0aW9uIGFuZCB0YWdz
IGluIHRoZSBlYXJsaWVyIHBhdGNoDQotIGFkZCBkbWEtY2hhbm5lbC1tYXNrIGZvciBETUEgY2Fw
YWJpbGl0eQ0KLSBmaXggY29tcGF0aWJsZSBmb3IgY29tbW9uDQo=

