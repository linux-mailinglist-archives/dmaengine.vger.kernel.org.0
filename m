Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C934017CDA6
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2020 11:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCGKct (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Mar 2020 05:32:49 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:6231
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbgCGKcs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 7 Mar 2020 05:32:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv0fvHoMQcMCiAubSNDV6vjfILhwTSSvXbILg12GjZtJx2a7a+230YB7rIxVMb2nrloOKW9XqJfdgO2bBWEZ5kz24qkSCTNhw1M5LeIFSa4VkygKhCEcwRFBXSgNd4PQGBHTqVM2JWPanhzKz8xkDzqpDBwzlZ5Hg9zSZrdOOTplA5ROu/w/jvV5gdHiCinASgiFmzqQEKE4hZufe6+Nfev/S9WJyKha7/mV7spIkIXRW5CbeoediXOkyE4rxQ4tIpTgGCqDaSjEiCjouFCPZgUCNx8i+Nj0sb0KWwYrTuJooRXzDkBpktdO8/X9Z1QRqjhles0R85B09gR7PdTdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEBuXWyv1XetsXi7ui67l+70cBo5wqeTypasg5rUfN8=;
 b=CyRKdRvtRicHmaxzf2zn/sTx2Kivamw9KNxZkVU6gEDjFUC4jC60Vfn0MZ8OOoLN3VOjutmz2ARsQq2W7AFmFSy9MjgFwHjMBA5qb/OSeiY9vWwUpZQbcNCAsK9YNIiAcvddYeUv4D4AcQz1j5IoGKcH2jAwZ8Xs7j606ZetAjhgIKVqCrH4/KGqJTXY5p/sfubMJSo4nfMW8OUXNfDVN7sddOLfo2gWouOqNKI77BDlOgXLv+YpJ55wtCW/Jzhc49PaiT/NgsRkCGYjrCIj7JiZCS6hHSjDZsc/8X1gmCYyvLD29vFsYCmQyiBJAlyKgd6qByP76Nbo2egmMXaB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEBuXWyv1XetsXi7ui67l+70cBo5wqeTypasg5rUfN8=;
 b=XGhfMvVckCBUg0wf7qZDC9zzs24pvLi+WRWebzFlNHzM63RW5f7kpeg01LDrrMWYMiy+XAX7o/3FLDqXGB0cSjTj1XXM+0Sy8Xo4kEpowCPPouUAKvALiRDBtXmazHfqiGTNRW17R+yVhdFsViFFuzIaLn5Ln0bW4UX22xPF3KQ=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB5757.eurprd04.prod.outlook.com (20.178.126.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Sat, 7 Mar 2020 10:32:43 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::10f0:dc6d:c9f9:edfc]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::10f0:dc6d:c9f9:edfc%5]) with mapi id 15.20.2793.013; Sat, 7 Mar 2020
 10:32:43 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma"
 compatible
Thread-Topic: [EXT] [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma"
 compatible
Thread-Index: AQHV8/lsXqSm1fChNEm1yZWBD/JxAKg8YRCggAB7y4CAABECAA==
Date:   Sat, 7 Mar 2020 10:32:43 +0000
Message-ID: <VI1PR04MB4431F901BEEF2EAB9AB1D7C6EDE00@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20200306205403.29881-1-michael@walle.cc>
 <20200306205403.29881-2-michael@walle.cc>
 <VI1PR04MB44312A940BC5BFC7F13A5706EDE00@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <e0be23f7d1307621151594dd66d2b8fd@walle.cc>
In-Reply-To: <e0be23f7d1307621151594dd66d2b8fd@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99d88eeb-fa39-41b4-c3a2-08d7c282ded0
x-ms-traffictypediagnostic: VI1PR04MB5757:|VI1PR04MB5757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB575704B571D4DDC6212C0747EDE00@VI1PR04MB5757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(64756008)(52536014)(8936002)(26005)(4326008)(186003)(6506007)(66556008)(53546011)(55016002)(9686003)(81166006)(8676002)(54906003)(66946007)(66446008)(66476007)(316002)(81156014)(6916009)(76116006)(2906002)(86362001)(44832011)(7696005)(33656002)(71200400001)(478600001)(5660300002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5757;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0QrTt2pwm2WfGGw4xs5jcp118PPVLvgPnI0KrltBKbZcbnPxvJ6X3J144gNkVVGdyKdPD855SHZZr8TZH06+Tfr29oYQHdSXLiEr4sSMA6/fYgoYQkwNritVagjRGkRSQcFdhFWRoi0nIEtkxLTuedb5yim4bgiC3zH5X+1ouKQGNe1qx1kJGEFaQRP+oy1btDZTyZAEPIPf7OTjUjPCftN9hb7EEh3io3IbRdI8NLrHS80W+MjaN7ByZrHdUBw2Ruw7nIFW9lJYJSYGJm0kaErQhlFGSix5oYUms7IyvNiSJLMjoq0is2Rnow9mWu6Oc+i/oXG0uJ8xjYeQ22ZbDblO3t+yuK3XVYBiLfbuvsWNFeWg2TI0dUnOrQ8+LDFGqx4MD6V9KACOxhNRK2sAZXIs6uSqIxfubKdWpLPwHsYHlm029y8TLrcpe1RpEOvbZeuCsN4hq52osN94/v4J/VTcKcP9PQkaPgcfQdqXAT7DRQ4unNVuQyUTNFEBLap
x-ms-exchange-antispam-messagedata: /SBy5y5zo0WTM2ySCm4nu29nQmnctYa0fBD24AwquAbidku+W6EgztfZl9CB6ZWYN8gJG0BaZtylnnyCBAPXJxpmIIvgmd9g7EDJfJqYA0KJpX4/wHyML4rY52sfUAN1mmWmDfTvz177KaAHSLj9fw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d88eeb-fa39-41b4-c3a2-08d7c282ded0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 10:32:43.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZOmheLom8v9lgIhK+XccrT10DvyFRQLtED6W/yobLq3bVTfYiKjeP+tMSRTwQ3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5757
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhZWwgV2FsbGUgPG1p
Y2hhZWxAd2FsbGUuY2M+DQo+U2VudDogMjAyMOW5tDPmnIg35pelIDE3OjI2DQo+VG86IFBlbmcg
TWEgPHBlbmcubWFAbnhwLmNvbT4NCj5DYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBWaW5vZCBLb3VsDQo+PHZrb3Vs
QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRs
YW5kDQo+PG1hcmsucnV0bGFuZEBhcm0uY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgTGVvIExpDQo+PGxlb3lhbmcubGlAbnhwLmNvbT4NCj5TdWJqZWN0OiBSZTogW0VYVF0g
W1BBVENIIDIvMl0gYXJtNjQ6IGR0czogbHMxMDI4YTogYWRkICJmc2wsdmY2MTAtZWRtYSINCj5j
b21wYXRpYmxlDQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+SGkgUGVuZywNCj4NCj5BbSAy
MDIwLTAzLTA3IDAzOjA5LCBzY2hyaWViIFBlbmcgTWE6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+PiBGcm9tOiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPj4+
IFNlbnQ6IDIwMjDlubQz5pyIN+aXpSA0OjU0DQo+Pj4gVG86IGRtYWVuZ2luZUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPj4+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4+IENj
OiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz47DQo+Pj4gTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNoYXdu
IEd1bw0KPjxzaGF3bmd1b0BrZXJuZWwub3JnPjsNCj4+PiBMZW8gTGkgPGxlb3lhbmcubGlAbnhw
LmNvbT47IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT47IE1pY2hhZWwgV2FsbGUNCj4+PiA8bWlj
aGFlbEB3YWxsZS5jYz4NCj4+PiBTdWJqZWN0OiBbRVhUXSBbUEFUQ0ggMi8yXSBhcm02NDogZHRz
OiBsczEwMjhhOiBhZGQgImZzbCx2ZjYxMC1lZG1hIg0KPj4+IGNvbXBhdGlibGUNCj4+Pg0KPj4+
IENhdXRpb246IEVYVCBFbWFpbA0KPj4+DQo+Pj4gVGhlIGJvb3Rsb2FkZXIgZG9lcyB0aGUgSU9N
TVUgZml4dXAgYW5kIGR5bmFtaWNhbGx5IGFkZHMgdGhlICJpb21tdXMiDQo+Pj4gcHJvcGVydHkg
dG8gZGV2aWNlcyBhY2NvcmRpbmcgdG8gaXRzIGNvbXBhdGlibGUgc3RyaW5nLiBJbiBjYXNlIG9m
DQo+Pj4gdGhlIGVETUEgY29udHJvbGxlciB0aGlzIHByb3BlcnR5IGlzIG1pc3NpbmcuIEFkZCBp
dC4gQWZ0ZXIgdGhhdCB0aGUNCj4+PiBJT01NVSB3aWxsIHdvcmsgd2l0aCB0aGUgZURNQSBjb3Jl
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5j
Yz4NCj4+PiAtLS0NCj4+PiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4
YS5kdHNpIHwgMiArLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1sczEwMjhhLmR0c2kNCj4+PiBpbmRleCBiMTUyZmE5MGNmNWMuLmFhNDY3YmZmMjIwOSAx
MDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4
YS5kdHNpDQo+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAy
OGEuZHRzaQ0KPj4+IEBAIC00NDcsNyArNDQ3LDcgQEANCj4+Pg0KPj4+ICAgICAgICAgICAgICAg
IGVkbWEwOiBkbWEtY29udHJvbGxlckAyMmMwMDAwIHsNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICNkbWEtY2VsbHMgPSA8Mj47DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJmc2wsbHMxMDI4YS1lZG1hIjsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gImZzbCxsczEwMjhhLWVkbWEiLA0KPj4+ICsgImZzbCx2ZjYxMC1lZG1hIjsN
Cj4+IEhpIE1pY2hhZWwsDQo+Pg0KPj4gWW91IHNob3VsZCBjaGFuZ2UgaXQgb24gYm9vdGxvYWRl
ciBpbnN0ZWFkIG9mIGtlcm5lbCwgU29tZSBSZWcgb2YNCj4+IExTMTAyOGEgaXMgZGlmZmVyZW50
IGZyb20gb3RoZXJzLCBTbyB3ZSB1c2VkIGNvbXBhdGlibGUNCj4+ICJmc2wsbHMxMDI4YS1lZG0i
IHRvIGRpc3Rpbmd1aXNoICINCj4+IGZzbCx2ZjYxMC1lZG1hIi4NCj4NCj5ZZXMgdGhpcyBtaWdo
dCBiZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uIFNvIHNpbmNlIGl0IGlzIE5YUHMgYm9vdGxvYWRl
ciBmZWVsIGZyZWUgdG8NCj5maXggdGhhdCA7KSBMb29raW5nIGF0IHRoZSB1LWJvb3QgY29kZSBy
aWdodCBub3csIEkgZG9uJ3QgZXZlbiBrbm93IGl0IHRoYXQgaXMgdGhlDQo+cmlnaHQgZml4IGF0
IGFsbC4gVGhlIGZpeHVwIGNvZGUgaW4gdS1ib290IGlzIFNvQyBpbmRlcGVuZGVudCAoaXRzIGlu
IGZzbF9pY2lkLmggYW5kIGlzDQo+ZW5hYmxlZCB3aXRoIENPTkZJR19MU0NIMywgaWUgeW91ciBj
aGFzc2lzIHZlcnNpb24pLiBGb3IgZXhhbXBsZSwgdGhlIHNkaGMNCj5maXh1cCB3aWxsIHNjYW4g
dGhlIG5vZGVzIGZvciAiY29tcGF0aWJsZSA9IGZzbCxlc2RoYyIsIHdoaWNoIGlzIGFsc28gdGhl
DQo+c2Vjb25kYXJ5IGNvbXBhdGlibGUgZm9yIHRoZSAibHMxMDI4YS1lc2RoYyIgY29tcGF0aWJs
ZS4NCj4NCj5BbmQgaGVyZSBpcyBhbm90aGVyIHJlYXNvbiB0byBoYXZlIGl0IHRoaXMgd2F5OiB3
ZSBuZWVkIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5LA0KPnRoZSBhcmUgYWxyZWFkeSBib2FyZHMg
b3V0IHRoZXJlIHdob3NlIGJvb3Rsb2FkZXIgd2lsbCBmaXgtdXAgdGhlICJvbGQiIG5vZGUuDQo+
VGh1cyBJIGRvbid0IHNlZSBhbnkgb3RoZXIgcG9zc2liaWx0eS4NCj4NCltQZW5nIE1hXSBPSywg
VGhlcmUgaXMgbm9uIGZpeGVkIG9uIHVib290Lg0KSSB3aWxsIGZpeCBpdCBvbiB1Ym9vdCwgaWYg
eW91IHdhbnQgdG8gdXNlIG5vdywgcGxlYXNlIGNoYW5nZSB0aGUgdWJvb3QgYXMgYmVsb3c6DQoN
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9jcHUvYXJtdjgvZnNsLWxheWVyc2NhcGUvbHMxMDI4X2lk
cy5jIGIvYXJjaC9hcm0vY3B1L2FybXY4L2ZzbC1sYXllcnNjYXBlL2xzMTAyOF9pZHMuYw0KaW5k
ZXggZDlkMTI1ZThiYS4uZGI5ZGQ2OTU0OCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2NwdS9hcm12
OC9mc2wtbGF5ZXJzY2FwZS9sczEwMjhfaWRzLmMNCisrKyBiL2FyY2gvYXJtL2NwdS9hcm12OC9m
c2wtbGF5ZXJzY2FwZS9sczEwMjhfaWRzLmMNCkBAIC0xNCw3ICsxNCw3IEBAIHN0cnVjdCBpY2lk
X2lkX3RhYmxlIGljaWRfdGJsW10gPSB7DQogICAgICAgIFNFVF9TREhDX0lDSUQoMSwgRlNMX1NE
TU1DX1NUUkVBTV9JRCksDQogICAgICAgIFNFVF9TREhDX0lDSUQoMiwgRlNMX1NETU1DMl9TVFJF
QU1fSUQpLA0KICAgICAgICBTRVRfU0FUQV9JQ0lEKDEsICJmc2wsbHMxMDI4YS1haGNpIiwgRlNM
X1NBVEExX1NUUkVBTV9JRCksDQotICAgICAgIFNFVF9FRE1BX0lDSUQoRlNMX0VETUFfU1RSRUFN
X0lEKSwNCisgICAgICAgU0VUX0VETUFfSUNJRF9MUzEwMjgoRlNMX0VETUFfU1RSRUFNX0lEKSwN
CiAgICAgICAgU0VUX1FETUFfSUNJRCgiZnNsLGxzMTAyOGEtcWRtYSIsIEZTTF9ETUFfU1RSRUFN
X0lEKSwNCiAgICAgICAgU0VUX0dQVV9JQ0lEKCJmc2wsbHMxMDI4YS1ncHUiLCBGU0xfR1BVX1NU
UkVBTV9JRCksDQogICAgICAgIFNFVF9ESVNQTEFZX0lDSUQoRlNMX0RJU1BMQVlfU1RSRUFNX0lE
KSwNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWZzbC1sYXllcnNjYXBl
L2ZzbF9pY2lkLmggYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWZzbC1sYXllcnNjYXBlL2Zz
bF9pY2lkLmgNCmluZGV4IDM3ZTJmZTRlNjYuLjE1ZDBiNjBkYmUgMTAwNjQ0DQotLS0gYS9hcmNo
L2FybS9pbmNsdWRlL2FzbS9hcmNoLWZzbC1sYXllcnNjYXBlL2ZzbF9pY2lkLmgNCisrKyBiL2Fy
Y2gvYXJtL2luY2x1ZGUvYXNtL2FyY2gtZnNsLWxheWVyc2NhcGUvZnNsX2ljaWQuaA0KQEAgLTE0
NCw2ICsxNDQsMTAgQEAgZXh0ZXJuIGludCBmbWFuX2ljaWRfdGJsX3N6Ow0KICAgICAgICBTRVRf
R1VSX0lDSUQoImZzbCx2ZjYxMC1lZG1hIiwgc3RyZWFtaWQsIHNwYXJlM19hbXFyLFwNCiAgICAg
ICAgICAgICAgICBFRE1BX0JBU0VfQUREUikNCiANCisjZGVmaW5lIFNFVF9FRE1BX0lDSURfTFMx
MDI4KHN0cmVhbWlkKSBcDQorICAgICAgIFNFVF9HVVJfSUNJRCgiZnNsLGxzMTAyOGEtZWRtYSIs
IHN0cmVhbWlkLCBzcGFyZTNfYW1xcixcDQorICAgICAgICAgICAgICAgRURNQV9CQVNFX0FERFIp
DQorDQogI2RlZmluZSBTRVRfR1BVX0lDSUQoY29tcGF0LCBzdHJlYW1pZCkgXA0KICAgICAgICBT
RVRfR1VSX0lDSUQoY29tcGF0LCBzdHJlYW1pZCwgbWlzYzFfYW1xcixcDQogICAgICAgICAgICAg
ICAgR1BVX0JBU0VfQUREUikNCg0KQlIsDQpQZW5nDQo+LW1pY2hhZWwNCj4NCj4+DQo+PiBUaGFu
a3MsDQo+PiBQZW5nDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MjJj
MDAwMCAweDAgMHgxMDAwMD4sDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgw
IDB4MjJkMDAwMCAweDAgMHgxMDAwMD4sDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA8MHgwIDB4MjJlMDAwMCAweDAgMHgxMDAwMD47DQo+Pj4gLS0NCj4+PiAyLjIwLjENCg==
