Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC3BC8E3
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfIXN1m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 09:27:42 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:57810 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfIXN1m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Sep 2019 09:27:42 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 598D567A918;
        Tue, 24 Sep 2019 15:27:37 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Sep
 2019 15:27:36 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 24 Sep 2019 15:27:36 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "yibin.gong@nxp.com" <yibin.gong@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Topic: [PATCH v5 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Thread-Index: AQHVctvU4cuMSjzwIEqWCaN8EgDgaQ==
Date:   Tue, 24 Sep 2019 13:27:36 +0000
Message-ID: <29cf9f29-bdb4-94db-00b0-56ec36386f7a@kontron.de>
References: <20190610081753.11422-12-yibin.gong@nxp.com>
In-Reply-To: <20190610081753.11422-12-yibin.gong@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4390F60D119BB47AC69CC0E65ED73CB@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 598D567A918.AF6FA
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, vkoul@kernel.org, yibin.gong@nxp.com
X-Spam-Status: No
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgUm9iaW4sDQoNCj4gRnJvbTogUm9iaW4gR29uZyA8eWliaW4uZ29uZyBhdCBueHAuY29tPg0K
PiANCj4gQmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlz
IDAsIHRoZSBjb25kaXRpb24NCj4gY2hlY2sgaWdub3JlIHN1Y2ggc3BlY2lhbCBjYXNlIHdpdGhv
dXQgZG1hIGNoYW5uZWwgZW5hYmxlZCwgd2hpY2ggY2F1c2VkDQo+IGVjc3BpMSByeCB3b3JrcyBm
YWlsZWQuIEFjdHVhbGx5LCBubyBuZWVkIHRvIGNoZWNrIGV2ZW50X2lkMC9ldmVudF9pZDENCj4g
YW5kIHJlcGxhY2UgY2hlY2tpbmcgJ2V2ZW50X2lkMScgd2l0aCAnRE1BX0RFVl9UT19ERVYnLCBz
byB0aGF0IGNvbmZpZ3VyZQ0KPiBldmVudF9pZDEgb25seSBpbiBjYXNlIERFVl9UT19ERVYuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nIGF0IG54cC5jb20+DQo+
IEFja2VkLWJ5OiBWaW5vZCBLb3VsIDx2a291bCBhdCBrZXJuZWwub3JnPg0KDQpJIGhhdmUgYSBj
dXN0b20gYm9hcmQgd2l0aCBpLk1YOE1NIGFuZCBTUEkgZmxhc2ggb24gZWNzcGkxLiBJJ20gDQpj
dXJyZW50bHkgdGVzdGluZyB3aXRoIHY1LjMgYW5kIGFzIFNQSSBkaWRuJ3Qgd29yaywgSSB0cmll
ZCB0d28gDQpkaWZmZXJlbnQgdGhpbmdzOg0KDQoxLiBSZW1vdmluZyAnZG1hcycgYW5kICdkbWEt
bmFtZXMnIGZyb20gdGhlIGVjc3BpMSBub2RlIGluIGlteDhtbS5kdHNpLA0KICAgIHRvIHVzZSBQ
SU8gaW5zdGVhZCBvZiBETUEuIFRoaXMgd29ya3MgYXMgZXhwZWN0ZWQgYW5kIHRoZSBkcml2ZXIN
CiAgICBib290cyB3aXRoIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXM6DQoNCiAgICAgICAgc3BpX2lt
eCAzMDgyMDAwMC5zcGk6IGRtYSBzZXR1cCBlcnJvciAtMTksIHVzZSBwaW8NCiAgICAgICAgbTI1
cDgwIHNwaTAuMDogbXgyNXY4MDM1ZiAoMTAyNCBLYnl0ZXMpDQogICAgICAgIHNwaV9pbXggMzA4
MjAwMDAuc3BpOiBwcm9iZWQNCg0KMi4gQXBwbHlpbmcgeW91ciBwYXRjaHNldCBhbmQgdXNlIERN
QS4gSW4gdGhpcyBjYXNlLCB0aGUgZmxhc2ggYWxzbw0KICAgIHdvcmtzIGZpbmUsIGJ1dCB0aGVy
ZSBhcmUgc29tZSBlcnJvciBtZXNzYWdlcyBwcmludGVkIHdoaWxlIGJvb3Rpbmc6DQoNCiAgICAg
ICAgc3BpX21hc3RlciBzcGkwOiBJL08gRXJyb3IgaW4gRE1BIFJYDQogICAgICAgIG0yNXA4MCBz
cGkwLjA6IFNQSSB0cmFuc2ZlciBmYWlsZWQ6IC0xMTANCiAgICAgICAgc3BpX21hc3RlciBzcGkw
OiBmYWlsZWQgdG8gdHJhbnNmZXIgb25lIG1lc3NhZ2UgZnJvbSBxdWV1ZQ0KICAgICAgICBtMjVw
ODAgc3BpMC4wOiBteDI1djgwMzVmICgxMDI0IEtieXRlcykNCiAgICAgICAgc3BpX2lteCAzMDgy
MDAwMC5zcGk6IHByb2JlZA0KDQpJdCB3b3VsZCBiZSBncmVhdCB0byBnZXQgeW91ciBwYXRjaGVz
IG1lcmdlZCBhbmQgZml4IFNQSSArIERNQSwgYnV0IGZvciANCmkuTVg4TU0sIHdlIG5lZWQgdG8g
Z2V0IHJpZCBvZiB0aGUgZXJyb3IgbWVzc2FnZXMuIERvIHlvdSBoYXZlIGFuIGlkZWEsIA0Kd2hh
dCdzIHdyb25nPw0KDQpUaGFua3MsDQpGcmllZGVy
