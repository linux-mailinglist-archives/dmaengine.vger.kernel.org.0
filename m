Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB861A2A
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2019 06:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfGHEyZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jul 2019 00:54:25 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:57409
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727312AbfGHEyY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Jul 2019 00:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HT+3hK9QoquQwfLDQ4V6QD6rdTPaulURFr4zoRup6I=;
 b=HdBubdb6K4ZXJqTI1RfJwlwMI/9ekLRbGUygIA0YnBZP1dxvcs9WoSwmjFdIbyGkZmPOzxdGGXORobORXWrWCo/rR5VTJqAUUirZwF3gZkdALK6CclmDnp19l9TiQ8Bl3gNqZ2FZlSV5D0cRF4sC9U4Gf8Y4/vxco5mj9sZd52o=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6637.eurprd04.prod.outlook.com (20.179.235.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Mon, 8 Jul 2019 04:54:20 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 04:54:20 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     dma <dmaengine@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: RE: linux-next: build failure after merge of the slave-dma tree
Thread-Topic: linux-next: build failure after merge of the slave-dma tree
Thread-Index: AQHVMjqAoCw3ift/eE+RdAWMvGtRgabAD+XYgAATwQCAAAjO8A==
Date:   Mon, 8 Jul 2019 04:54:20 +0000
Message-ID: <VE1PR04MB66380EEE86E385AF332A580089F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190704173108.0646eef8@canb.auug.org.au>
 <VE1PR04MB6638080C43EC68EFF9F7B38A89F60@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <58c9b815-9bfc-449c-6017-c6da582dffc5@linaro.org>
 <20190708041728.GK2911@vkoul-mobl>
In-Reply-To: <20190708041728.GK2911@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9f75f1e-ce21-44f4-bf08-08d703605714
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6637;
x-ms-traffictypediagnostic: VE1PR04MB6637:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1PR04MB66375254498F76933C06DE5489F60@VE1PR04MB6637.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(3846002)(486006)(316002)(25786009)(54906003)(476003)(33656002)(6116002)(229853002)(5660300002)(446003)(11346002)(4326008)(102836004)(26005)(186003)(6916009)(76176011)(7696005)(53546011)(6506007)(99286004)(71200400001)(66946007)(8936002)(2906002)(68736007)(66066001)(81166006)(66476007)(66556008)(64756008)(66446008)(52536014)(7736002)(86362001)(76116006)(73956011)(71190400001)(45080400002)(74316002)(6436002)(81156014)(256004)(6306002)(4744005)(14454004)(8676002)(305945005)(9686003)(478600001)(966005)(53936002)(6246003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6637;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qUtsmb73MVrCPjx2Q6tFxE8aEDqxKDAPn4gfAY888E9YnDVershOEquRtzsUTbV7IVYiI8KQYu7WX9fBJnVRPYnR3Z8YkkQG1EVQmlPNQ4BHoffxTr6vhReDszv159mtmXY7QGScwPtsnPxm1z3tAIUU6FC0p0WFHYaOpwj64WRvELeeQ7lHWQNT0jiZExumsZ3dJ21f388d5mKFsMZUmIaaYcqUnx/JSlBzqQPFgThoFfWv6BpKvYvy1Ce15FtDWqKTgOwS3pa+/wafKahd5X6ot1QuOsto6mkMsx6ZVFTDxhnz7tukT4yOXUNL6+zG43/qjzmd3yU09wGq4ZNSXs2Yg7pyX23yRqAGV09W7siCqy06gcSXHW6hMUR3D07e5fCNNZ45AZnefZwjJuD2KX00niScFYrwjGSzIZnRp8w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f75f1e-ce21-44f4-bf08-08d703605714
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 04:54:20.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6637
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAxOS83LzggMTI6MTcgVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+
IE9uIDA4LTA3LTE5LCAxMTowNiwgemhhbmdmZWkgd3JvdGU6DQo+ID4gSGksIFJvYmluDQo+ID4N
Cj4gPiBPbiAyMDE5LzcvOCDkuIrljYg5OjIyLCBSb2JpbiBHb25nIHdyb3RlOg0KPiA+ID4gSGkg
U3RlcGhlbiwNCj4gPiA+IAlUaGF0J3MgY2F1c2VkIGJ5ICdvZl9pcnFfY291bnQnIE5PVCBleHBv
cnQgdG8gZ2xvYmFsIHN5bWJvbCwgYW5kDQo+ID4gPiBJJ20gY3VyaW91cyB3aHkgaXQgaGFzIGJl
ZW4gaGVyZSBmb3Igc28gbG9uZyBzaW5jZSBaaGFuZ2ZlaSBmb3VuZCBpdA0KPiA+ID4gaW4gMjAx
NS4NCj4gPiBJIHJlbWVtYmVyZWQgUm9iIHN1Z2dlc3RlZCB1cyBub3QgdXNpbmcgb2ZfaXJxX2Nv
dW50IGFuZCB1c2UNCj4gPiBwbGF0Zm9ybV9nZXRfaXJxIGV0Yy4NCj4gPiBodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21s
DQo+ID4gLm9yZyUyRmxrbWwlMkYyMDE1JTJGMTElMkYxOCUyRjQ2NiZhbXA7ZGF0YT0wMiU3QzAx
JTdDeWliaW4uZ28NCj4gbmclNDBueHANCj4gPiAuY29tJTdDYjZkODRhNjk3NmQ3NDU3ZGMzNDQw
OGQ3MDM1YmFhZjUlN0M2ODZlYTFkM2JjMmI0YzZmYTkyDQo+IGNkOTljNWMzMA0KPiA+DQo+IDE2
MzUlN0MwJTdDMCU3QzYzNjk4MTU2NDU1NzE0MzUzNyZhbXA7c2RhdGE9akVnRm5CM1lOa1Z0c2ln
ZmJONg0KPiBYR0pvamxiDQo+ID4gSkF5T2k4a2lHZDVKSEpFY00lM0QmYW1wO3Jlc2VydmVkPTAN
Cj4gDQo+IFRoZSBleHBsYW5hdGlvbiBsb29rcyBzYW5lIHRvIG1lLCBzbyBpdCBtYWtlcyBzZW5z
ZSB0byByZXZlcnQgdGhlIGNvbW1pdCBmb3INCj4gbm93LiBSZXZlcnRlZCBub3cNCk9rLCBJIHdp
bGwgc2VuZCB2NiB3aXRoIHRoZSBmaXguDQo=
