Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAAB3C3D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfIPOKW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 10:10:22 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:5955
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbfIPOKW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Sep 2019 10:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/fcLENGe1JlqiMGMi31KLcV1OMpzuMOazB7m6SV9zxA8cQvPqTmvje6bPssUQbdvb9XCBNjcBcrM298OcBUPe+cjj0OinHQWvFAcOD+lc/BCVfthb0F64YvL7BRKN/1x6K+H68DtyTJbhPOz4h5I4BtbdWQzTO2Xay+qTlTy6xb78YdDHIlpn7YGtFUkmkC23Mdp3d7xYpWz+VpKRPs510IyLi1lKQFST1K5JNhI6u82VLqNH2un78b8QlIOk1/aTO02FAfmYT4whFNyk5rWoEpP4oRBwnxTMuGfXchS3SShE4PsR+hdyE2/+ZbG3xNOs+DXZjVM3zNzmwBFwzgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPaLUiU5KaIQ2OGfxf4Qa3upo8wq8ZBalvB4QOKJ9AA=;
 b=cfEp59TtQ8jw7r2d1AtrSrjuNJi3sCzPEvGJ8QcHLFzkU0Y1iqPSFM0D6Ktx2tglQlILXRjYGdQ5lOEvAJBgopgvOy0Vo2bEBT7Sp2BcWdKRZVeV3oubD8yBFArPI+X0CnLql++5UKmS4rOERD7z0vHr+mZ1LEusKtSvx2Kbfhr+cBVfkSwKCPRg+hT45A9RzHSLrWnkc5WduB+4tWHU3XNS9gf4dhJ5SP2FS3xRHb1r0WKlzHuM2wtncceTdwl2+mx13mHJ69eTfJnMCObS0jSzguu0tOdzZN+MA7XMitiGEchQX8e5aJXwd+WGcCmEe0p2JVZ6rQpMEBRcZSSqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPaLUiU5KaIQ2OGfxf4Qa3upo8wq8ZBalvB4QOKJ9AA=;
 b=kRQ0DFuTPLUkV7LziUuz3rHtEKhyiWhfOYt+tDbZUX+mtBWcb4LnbCZcxfBJUetY96S4s5ultbc3Y/PvfxjX8mBNJtr7Cr/WqN9Zt+ExX4us/4G1VAjkGATFv6drLcdDMeqGuBR6ICADudVDvDKGooGNoLRBEwLVnoaTx//UU3Y=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3840.eurprd04.prod.outlook.com (52.134.16.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Mon, 16 Sep 2019 14:10:18 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::f919:a62a:998c:6e9a%6]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 14:10:18 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        Fabio Estevam <festevam@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 0/4] Fix UART DMA freezes for iMX6
Thread-Topic: [EXT] Re: [PATCH 0/4] Fix UART DMA freezes for iMX6
Thread-Index: AQHVaZcvm/+EXlr62U2kolBBt3UOQqcuWX8AgAADtDA=
Date:   Mon, 16 Sep 2019 14:10:18 +0000
Message-ID: <VI1PR0402MB3600FB067CC5FABCAB1EBBB6FF8C0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
 <CAOMZO5BKiZGF=iR071DaWLp-_7wTVJKLbOn3ihwPeVVSNF6nCg@mail.gmail.com>
 <2613a28d-d363-ee4e-679a-e7442e6fde48@emlix.com>
In-Reply-To: <2613a28d-d363-ee4e-679a-e7442e6fde48@emlix.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42c872ee-2147-4e0b-b55a-08d73aaf9aaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB3840;
x-ms-traffictypediagnostic: VI1PR0402MB3840:|VI1PR0402MB3840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3840051182A97F84F5DCD029FF8C0@VI1PR0402MB3840.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(51914003)(199004)(189003)(305945005)(6116002)(256004)(8676002)(4326008)(76176011)(81166006)(8936002)(6246003)(81156014)(55016002)(316002)(6506007)(53546011)(11346002)(99286004)(9686003)(186003)(446003)(54906003)(6436002)(102836004)(33656002)(2906002)(229853002)(476003)(14454004)(26005)(3846002)(7696005)(53936002)(71200400001)(74316002)(66446008)(7736002)(7416002)(110136005)(6636002)(64756008)(86362001)(66556008)(66946007)(486006)(76116006)(478600001)(5660300002)(66066001)(71190400001)(25786009)(66476007)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3840;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q5t1OnkCRZvxKzr6sJzmHXxDXg/01X0t9oiUkpQCjBuZj1gPAbwGuDfyz70nOT+KudfOeDJ+Gq+sBRMaEp2Mnmy772gbO5D8vGRTVQ0L7O2XLKZhVL0bGkg/3pafurZrDEESslzPR/rTMcM59kND+t4W7YA+r4Lh+YJLivYaHQ0D4HteqbzOtCNooJUFgIclk1PxBMto0SK5vN3GR9ilCXNBAXcFCmmFuTFNHsKyrXoO9Us+gR2Ahv/Gn3XuZk+Z4R741vQdyylcm3Ty3eJkCEJuAKSbD/Gg9zNHcSsONAb6ACRgxnAWvERsjiwd1EBZnh772EZ+fxt5PlNzs6lt8+/RT5GR8sXERR1Nb/LiId7zGqqaDM8oQVErFzdXPrC6GP+SAr756PewvcHS1EKqzI+dVh1V4Ig1bI47xPq4ahg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c872ee-2147-4e0b-b55a-08d73aaf9aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 14:10:18.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCXK2AputaCX9BUh4lM+rrOGZso3HOeHN1iEnJWh5QAliEqiNqSI1B4NgdPGXY9e2JftdF8SnAZ9zyECMbU68A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3840
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RnJvbTogUGhpbGlwcCBQdXNjaG1hbm4gPHBoaWxpcHAucHVzY2htYW5uQGVtbGl4LmNvbT4gU2Vu
dDogTW9uZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTkgOTo1NSBQTQ0KPiBIaSBGYWJpbywNCj4gDQo+
IEFtIDEyLjA5LjE5IHVtIDIwOjIzIHNjaHJpZWIgRmFiaW8gRXN0ZXZhbToNCj4gPiBIaSBQaGls
aXBwLA0KPiA+DQo+ID4gVGhhbmtzIGZvciBzdWJtaXR0aW5nIHRoZXNlIGZpeGVzLg0KPiA+DQo+
ID4gT24gV2VkLCBTZXAgMTEsIDIwMTkgYXQgMTE6NTAgQU0gUGhpbGlwcCBQdXNjaG1hbm4NCj4g
PiA8cGhpbGlwcC5wdXNjaG1hbm5AZW1saXguY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gRm9yIHNv
bWUgeWVhcnMgYW5kIHNpbmNlIG1hbnkga2VybmVsIHZlcnNpb25zIHRoZXJlIGFyZSByZXBvcnRz
IHRoYXQNCj4gPj4gUlggVUFSVCBETUEgY2hhbm5lbCBzdG9wcyB3b3JraW5nIGF0IG9uZSBwb2lu
dC4gU28gZmFyIHRoZSB1c3VhbA0KPiA+PiB3b3JrYXJvdW5kIHdhcyB0byBkaXNhYmxlIFJYIERN
QS4gVGhpcyBwYXRjaGVzIHRyeSB0byBmaXggdGhlIHVuZGVybHlpbmcNCj4gcHJvYmxlbS4NCj4g
Pj4NCj4gPj4gV2hlbiBhIHJ1bm5pbmcgc2RtYSBzY3JpcHQgZG9lcyBub3QgZmluZCBhbnkgdXNh
YmxlIGRlc3RpbmF0aW9uDQo+ID4+IGJ1ZmZlciB0byBwdXQgaXRzIGRhdGEgaW50byBpdCBqdXN0
IGxlYWRzIHRvIHN0b3BwaW5nIHRoZSBjaGFubmVsDQo+ID4+IGJlaW5nIHNjaGVkdWxlZCBhZ2Fp
bi4gQXMgc29sdXRpb24gd2Ugd2UgbWFudWFsbHkgcmV0cmlnZ2VyIHRoZSBzZG1hDQo+ID4+IHNj
cmlwdCBmb3IgdGhpcyBjaGFubmVsIGFuZCBieSB0aGlzIGRpc3NvbHZlIHRoZSBmcmVlemUuDQo+
ID4+DQo+ID4+IFdoaWxlIHRoaXMgc2VlbXMgdG8gd29yayBmaW5lIHNvIGZhciBhIGZ1cnRoZXIg
cGF0Y2ggaW4gdGhpcyBzZXJpZXMNCj4gPj4gaW5jcmVhc2VzIHRoZSBudW1iZXIgb2YgUlggRE1B
IHBlcmlvZHMgZm9yIFVBUlQgdG8gcmVkdWNlIHVzZSBjYXNlcw0KPiA+PiBydW5uaW5nIGludG8g
c3VjaCBhIHNpdHVhdGlvbi4NCj4gPj4NCj4gPj4gVGhpcyBwYXRjaCBzZXJpZXMgd2FzIHRlc3Rl
ZCB3aXRoIHRoZSBjdXJyZW50IGtlcm5lbCBhbmQgYmFja3BvcnRlZA0KPiA+PiB0byBrZXJuZWwg
NC4xNSB3aXRoIGEgc3BlY2lhbCB1c2UgY2FzZSB1c2luZyBhIFdMMTgzN01PRCB2aWEgVUFSVCBh
bmQNCj4gPj4gcHJvdm9raW5nIHRoZSBoYW5naW5nIG9mIFVBUlQgUlggRE1BIHdpdGhpbiBzZWNv
bmRzIGFmdGVyIHN0YXJ0aW5nIGEgdGVzdA0KPiBhcHBsaWNhdGlvbi4NCj4gPj4gSXQgcmVzdWx0
ZWQgaW4gd2VsbCBrbm93bg0KPiA+PiAgICJCbHVldG9vdGg6IGhjaTA6IGNvbW1hbmQgMHgwNDA4
IHR4IHRpbWVvdXQiDQo+ID4+IGVycm9ycyBhbmQgY29tcGxldGUgc3RvcCBvZiBVQVJUIGRhdGEg
cmVjZXB0aW9uLiBPdXIgQmx1ZXRvb3RoDQo+ID4+IHRyYWZmaWMgY29uc2lzdHMgb2YgbWFueSBp
bmRlcGVuZGVudCBzbWFsbCBwYWNrZXRzLCBtb3N0bHkgb25seSBhIGZldw0KPiA+PiBieXRlcywg
Y2F1c2luZyBoaWdoIHVzYWdlIG9mIHBlcmlvZHMuDQo+ID4+DQo+ID4+DQo+ID4+IFBoaWxpcHAg
UHVzY2htYW5uICg0KToNCj4gPj4gICBkbWFlbmdpbmU6IGlteC1zZG1hOiBmaXggYnVmZmVyIG93
bmVyc2hpcA0KPiA+PiAgIGRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBkbWEgZnJlZXplcw0KPiA+
PiAgIHNlcmlhbDogaW14OiBhZGFwdCByeCBidWZmZXIgYW5kIGRtYSBwZXJpb2RzDQo+ID4+ICAg
ZG1hZW5naW5lOiBpbXgtc2RtYTogZHJvcCByZWR1bmRhbnQgdmFyaWFibGUNCj4gPg0KPiA+IEkg
aGF2ZSBzb21lIHN1Z2dlc3Rpb25zOg0KPiA+DQo+ID4gMS4gUGxlYXNlIHNwbGl0IHRoaXMgaW4g
dHdvIHNlcmllczogb25lIGZvciBkbWFlbmdpbmUgYW5kIG90aGVyIG9uZQ0KPiA+IGZvciBzZXJp
YWwNCj4gPg0KPiA+IDIuIFBsZWFzZSBhZGQgRml4ZXMgdGFnIHdoZW4gYXBwcm9wcmlhdGUsIHNv
IHRoYXQgdGhlIGZpeGVzIGNhbiBiZQ0KPiA+IGJhY2twb3J0ZWQgdG8gc3RhYmxlIGtlcm5lbHMu
DQo+ID4NCj4gPiAzLiBQbGVhc2UgQ2MgUm9iaW4gYW5kIEFuZHkNCj4gPg0KPiA+IFRoYW5rcw0K
PiA+DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBoaW50cy4gSSB3aWxsIGFwcGx5IHRoZW0gaWYgdGhl
IGNvbnRlbnR1YWwgZmVlZGJhY2sgaXMgcG9zaXRpdmUuDQo+IA0KPiBwLnMuIERpZCB5b3UgZm9y
Z2V0IHRvIGFkZCBBbmR5PyBJIGRvbid0IHNlZSBhIEFuZHkgaW4gdGhlIHRvLSBhbmQgY2MtbGlz
dC4NCg0KRm9yIGRtYSBhbmQgdWFydCwgcGxlYXNlIHRvLSBtZSBhbmQgeWliaW4uZ29uZ0BueHAu
Y29tLCB0aGFua3MuDQoNCkFuZHkNCg==
