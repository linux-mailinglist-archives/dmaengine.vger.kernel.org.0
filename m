Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF67F19C1C
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2019 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfEJLDx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 May 2019 07:03:53 -0400
Received: from mail-eopbgr1410127.outbound.protection.outlook.com ([40.107.141.127]:1920
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbfEJLDx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 May 2019 07:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpgyqCoWWbr2cLwzxZet4r+/xHiD+OLD9osbH0OFoNY=;
 b=IYquIlfqbrGEhOME/5iHmrnmbJ0ofbfTWkodItnfA53i7Lnm536q1++MmMPJ02C5s/+Yub54EmwHmH+SOGFfkOxpkvyyHN4vBV5W3i0IZyAlCI5lNK9t/PppFBPFoMbO7euDdz8iTp7u3+wp48ahaoGa5NmtnZdz4VJZY/t9dfs=
Received: from OSBPR01MB3174.jpnprd01.prod.outlook.com (20.176.240.146) by
 OSBPR01MB5047.jpnprd01.prod.outlook.com (20.179.183.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Fri, 10 May 2019 11:03:48 +0000
Received: from OSBPR01MB3174.jpnprd01.prod.outlook.com
 ([fe80::f873:6332:738d:7213]) by OSBPR01MB3174.jpnprd01.prod.outlook.com
 ([fe80::f873:6332:738d:7213%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 11:03:48 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund@ragnatech.se>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        HIROYUKI YOKOYAMA <hiroyuki.yokoyama.vx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: RE: [PATCH] dmaengine: rcar-dmac: Update copyright information
Thread-Topic: [PATCH] dmaengine: rcar-dmac: Update copyright information
Thread-Index: AQHU78smMz+XEEhstEycfA+c5SHoMqY2p2WAgABsgICAFD0tAIAA7a+AgAIvDYCAFH+QgIABcl6Q
Date:   Fri, 10 May 2019 11:03:48 +0000
Message-ID: <OSBPR01MB31747DA6369AD1C240972FBBD80C0@OSBPR01MB3174.jpnprd01.prod.outlook.com>
References: <20190410182657.23034-1-niklas.soderlund+renesas@ragnatech.se>
 <20190411084937.y5m6vzcwtkqqun7s@verge.net.au>
 <20190411151756.GC30887@bigcity.dyn.berto.se>
 <CAMuHMdXLM0hkUva4AukBpYy+=mRQ_tWT4XCGb=ZGbuT5nYMzjA@mail.gmail.com>
 <OSBPR01MB1733615712FC0F8271580D8BD83D0@OSBPR01MB1733.jpnprd01.prod.outlook.com>
 <20190426115343.GY28103@vkoul-mobl>
 <20190509125528.d7eryp5iv45yn2mp@verge.net.au>
In-Reply-To: <20190509125528.d7eryp5iv45yn2mp@verge.net.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0af8708f-2c9e-4055-f87a-08d6d5372dda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB5047;
x-ms-traffictypediagnostic: OSBPR01MB5047:
x-microsoft-antispam-prvs: <OSBPR01MB5047B76D37F967531DA120CCD80C0@OSBPR01MB5047.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(346002)(376002)(366004)(189003)(199004)(3846002)(2906002)(102836004)(6116002)(305945005)(6506007)(76176011)(7696005)(186003)(66066001)(99286004)(26005)(446003)(476003)(11346002)(71190400001)(71200400001)(7736002)(4744005)(486006)(52536014)(229853002)(6246003)(316002)(4326008)(5660300002)(74316002)(256004)(25786009)(6436002)(66476007)(66556008)(66446008)(64756008)(66946007)(73956011)(33656002)(54906003)(6916009)(76116006)(53936002)(81156014)(81166006)(8936002)(8676002)(478600001)(14454004)(55016002)(86362001)(9686003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB5047;H:OSBPR01MB3174.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pSgf+ishqjDnTfPwtOBotRIvGikj+zbDarSdKrrBSWcX4rwVfLw1F5of7jjP+V07Q1n+gzGGGlY3t3TW1zl2Ps8K6Mj7YGJcXsDnh2V/8IkTYy5hysstD6+oZ8+XPKsr+hoA5QjrkYPMwRWfwBD/iBE/7ZVq98tcJtpySSnoh4/KHGcqqLK6+rHiH4EpMxDi2qv0ThXpvs3X6wu4MelqGupXkF1HaT6v/0tilDdhdFjHwwxbyy1lLoHp20b+5A4dD12kp/+taImN4DcF+uFzOQFFyjG+VU5KW4RGY6WqJUb2IrIPIPv+pk4F+kMwVa65mL09nM2mFF6nsROGcc1GPa6+93K4tlwtm2qtx62RrNcyv7nwkhXopmsm3rHe4pyud8dxiKBa2K7md52/rrQrp0bG78saXPoHTbOfxWW66HM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af8708f-2c9e-4055-f87a-08d6d5372dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 11:03:48.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5047
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgU2ltb24tc2FuLA0KDQo+IEZyb206IFNpbW9uIEhvcm1hbiwgU2VudDogVGh1cnNkYXksIE1h
eSA5LCAyMDE5IDk6NTUgUE0NCj4gDQo8c25pcD4NCj4gU2hpbW9kYS1zYW4sIGNhbiB3ZSBnbyBm
dXJ0aGVyIGFuZCBhbHNvOg0KPiANCj4gMS4gUmVtb3ZlIHRoZSByOGE2NjU5Ny11ZGMgZHJpdmVy
LCB3aGljaCBhbHNvIHNlZW1zIHVudXNlZA0KPiAyLiBSZW1vdmUgKG1pbmltYWwpIHN1ZG1hYyBp
bnRlZ3JhdGlvbiBmcm9tIHVzYmhzID8NCg0KSSB0aGluayBzby4gSSdsbCBkbyBib3RoLg0KQWJv
dXQgdGhlIDIsIEknbGwgZG8gaXQgd2hlbiBhZGRpbmcgUlovQTIgc3VwcG9ydCBmcm9tIENocmlz
LXNhbiBpcyBhcHBsaWVkLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
