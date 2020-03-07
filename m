Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867FD17CAA6
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2020 03:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCGCJi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 21:09:38 -0500
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:57666
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgCGCJh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Mar 2020 21:09:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV1ZOdozDjml3HHLwcFKqV92KVucYunWkI3LAEwpjj+D2YuB3uFFFgYaoKXqCBxzFINnyXtEk+I91dVGCLzFAetKmeXzZuopTVJanaKRAutL/vzHBr8zKXX6eqq/g6w9793VmW69EtFRoqt3jIaYbhgWLStet+dLTXztByzfQilnfcOSQlfvOuBC5G0chDwkmXXJmLrqoNWWiK15r4z5p72m1avfK2VHaryGMub05VnrEkf41UZToEOb05CA0czmf5urPqW+8s3urQIGWVyZv8B5gyEGnrvkaMcE3+KOlabA87QT10lfeFv2I4kr1+EWZnTd4Z9xW8BeLSNxspXInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh8e5ReA7lxS3NA+fdZxDQL+LxaRTRiVPwRn5z2tWLE=;
 b=QPfatNdknzTBY7AU3Ko+zhMqmZcVTjadHC4ASlihebPqK74SCKJGodIuEMLlLZf8MwEEdK8cSC5F2638mAZXYLknUqRy+2WI6s/xLBT0/SsHIS9IUkxM79ZUyoShpwHpCqtP8Lm+4n3lZN83kwC9u6pTpAaX2ypARRVqW7zn0nFiB2hSUijpGNKzskDJGfQeNwsKzNpCvXAwpBZNpjGx2JGyy5/elTZCmhBCvUH/mb/t3MRt8/hAaqxE+x467y0iOH991mvCwbSR/J56LaWbRFqVp4iTSNYxdLG5es9qw95jMQY9SmEZtwpQmRDohkYAYn0CPJhAZUckeQNwrnPzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh8e5ReA7lxS3NA+fdZxDQL+LxaRTRiVPwRn5z2tWLE=;
 b=hafatfYx9cKrmaFLqPH9B4lL29aKfmKDmZvo3/Cijqq4tGN2xjnTAsWncx1a2JdsJ3xmn7dxW4jtdzKxll0pOfdiUTjGYiQ0FJbDcFc2Q3glbGz2FXQN/rAFknEpIBMwMcaiQmB4TTdMW6bwQvxo6uC7n2s37GQwzJDjF9U/hgM=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB4766.eurprd04.prod.outlook.com (20.177.49.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Sat, 7 Mar 2020 02:09:33 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::10f0:dc6d:c9f9:edfc]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::10f0:dc6d:c9f9:edfc%5]) with mapi id 15.20.2793.013; Sat, 7 Mar 2020
 02:09:33 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma"
 compatible
Thread-Topic: [EXT] [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma"
 compatible
Thread-Index: AQHV8/lsXqSm1fChNEm1yZWBD/JxAKg8YRCg
Date:   Sat, 7 Mar 2020 02:09:32 +0000
Message-ID: <VI1PR04MB44312A940BC5BFC7F13A5706EDE00@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20200306205403.29881-1-michael@walle.cc>
 <20200306205403.29881-2-michael@walle.cc>
In-Reply-To: <20200306205403.29881-2-michael@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c7a3f05-1c63-4008-e1cf-08d7c23c93ee
x-ms-traffictypediagnostic: VI1PR04MB4766:|VI1PR04MB4766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4766DAFCE1EDDEEC6026EAA1EDE00@VI1PR04MB4766.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(2906002)(110136005)(6506007)(54906003)(86362001)(316002)(64756008)(66476007)(66446008)(66556008)(44832011)(4326008)(26005)(71200400001)(52536014)(33656002)(5660300002)(76116006)(55016002)(9686003)(7696005)(8936002)(186003)(8676002)(81156014)(81166006)(66946007)(478600001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4766;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lk62mPr1XEUB/PrNDPmJbzSgEYBVYMW2AFCBi1KV9vHU5VClqtciiT2IWCibC29Fb0ih0Qep9ny6xeScZm7prNmX0s1c5yJ3T0rE2Ps/sg58cfp+OQeOq52Fv9aEzznj+nDgzQjzKsWJNRaFZGwyJ/9bC2qXKAx0XKZEqkDieNZ7D7Csqu5wzDunbv3wt/67/09PtmmOQ90p7Je1YzsLNQ4ONWY0DpWShuRsbcfp3SpH9K0+KUFoVxL2c3hlLHAKqWKBw/FBhHF0NNzgQIwC/NXy1H95ubLz2HHjpjBlEQBpyaxlKA+fnHkswZCcYH98uAqli7TeuNdIEOZn31qLNMuy2VoSgCXPiKRPqCLMKoWNsTpg9ynR6l4VMZ4QUPWavmy2lN8WnID+y1z9GQEk9Cz6XFL9B4VXmVNxh/Jzh0ytSRisffCGUbhnLnbj0NUDZgPStrpnc9lIRzEkAry7ELaJ1WTs+IjqPoBiiSFo5a2V0Ur0hAeD07EYKqaUFQSJ
x-ms-exchange-antispam-messagedata: dSza8f4qs8M50n8TyjOVuqgF7+F2pjtVhQgsnCq0a6vJKCxlDuICOkM/FOxpfz+c818leNhu+oFaTF5Ahs8WLNAMy6msjPbIzy/vnelBgSuA1IzvQ/BBnnAB42fRkbEj9/7WtNEHqtYpmJVIzBfLnQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7a3f05-1c63-4008-e1cf-08d7c23c93ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 02:09:33.1107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNtWcSR8AHB9N1ftdQIUtxlpVf5e44xxbkM4dDiWMLJhT5TDMWgrZl0idAUUZ29z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4766
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhZWwgV2FsbGUgPG1p
Y2hhZWxAd2FsbGUuY2M+DQo+U2VudDogMjAyMMTqM9TCN8jVIDQ6NTQNCj5UbzogZG1hZW5naW5l
QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+Q2M6IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgTWFyaw0KPlJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgU2hh
d24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTGVvIExpDQo+PGxlb3lhbmcubGlAbnhwLmNv
bT47IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT47IE1pY2hhZWwgV2FsbGUNCj48bWljaGFlbEB3
YWxsZS5jYz4NCj5TdWJqZWN0OiBbRVhUXSBbUEFUQ0ggMi8yXSBhcm02NDogZHRzOiBsczEwMjhh
OiBhZGQgImZzbCx2ZjYxMC1lZG1hIg0KPmNvbXBhdGlibGUNCj4NCj5DYXV0aW9uOiBFWFQgRW1h
aWwNCj4NCj5UaGUgYm9vdGxvYWRlciBkb2VzIHRoZSBJT01NVSBmaXh1cCBhbmQgZHluYW1pY2Fs
bHkgYWRkcyB0aGUgImlvbW11cyINCj5wcm9wZXJ0eSB0byBkZXZpY2VzIGFjY29yZGluZyB0byBp
dHMgY29tcGF0aWJsZSBzdHJpbmcuIEluIGNhc2Ugb2YgdGhlIGVETUENCj5jb250cm9sbGVyIHRo
aXMgcHJvcGVydHkgaXMgbWlzc2luZy4gQWRkIGl0LiBBZnRlciB0aGF0IHRoZSBJT01NVSB3aWxs
IHdvcmsgd2l0aA0KPnRoZSBlRE1BIGNvcmUuDQo+DQo+U2lnbmVkLW9mZi1ieTogTWljaGFlbCBX
YWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4tLS0NCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTAyOGEuZHRzaSB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj5iL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCj5pbmRleCBiMTUyZmE5MGNmNWMuLmFhNDY3YmZmMjIw
OSAxMDA2NDQNCj4tLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4
YS5kdHNpDQo+KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEu
ZHRzaQ0KPkBAIC00NDcsNyArNDQ3LDcgQEANCj4NCj4gICAgICAgICAgICAgICAgZWRtYTA6IGRt
YS1jb250cm9sbGVyQDIyYzAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICNkbWEtY2Vs
bHMgPSA8Mj47DQo+LSAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHMx
MDI4YS1lZG1hIjsNCj4rICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxs
czEwMjhhLWVkbWEiLA0KPisgImZzbCx2ZjYxMC1lZG1hIjsNCkhpIE1pY2hhZWwsDQoNCllvdSBz
aG91bGQgY2hhbmdlIGl0IG9uIGJvb3Rsb2FkZXIgaW5zdGVhZCBvZiBrZXJuZWwsIFNvbWUgUmVn
IG9mIExTMTAyOGEgaXMgZGlmZmVyZW50DQpmcm9tIG90aGVycywgU28gd2UgdXNlZCBjb21wYXRp
YmxlICJmc2wsbHMxMDI4YS1lZG0iIHRvIGRpc3Rpbmd1aXNoICIgZnNsLHZmNjEwLWVkbWEiLg0K
DQpUaGFua3MsDQpQZW5nDQo+ICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDIy
YzAwMDAgMHgwIDB4MTAwMDA+LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDAg
MHgyMmQwMDAwIDB4MCAweDEwMDAwPiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
MHgwIDB4MjJlMDAwMCAweDAgMHgxMDAwMD47DQo+LS0NCj4yLjIwLjENCg0K
