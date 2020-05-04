Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCABC1C3247
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 07:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEDFd2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 01:33:28 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:51649
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgEDFd1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 01:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjTnhhIEbvwPtomfz5GP9cap0nr1YYz7v5VsZha/KCAB6hpq5YFt9NT4ySx6wLc52TYnkCgrEe9NJ1XEvddCxuMoUqmNxq2xi2XBAC8Lv2CDoemZ3LvIGyGTbs6/WQFvRJd9tjorXo8fDsuMRui6mUYaaSDNTe/6o7V9KXmT5gH6FjWB+GPQfe1gIfwvVwUyp5mND36CgXqDD5azvHtnsqiOabx3CL5Sxyuy3JaH35Qls1QuJ31r6UwyeHTxH3tsLKRgtFesAJ7vKjO6J5xn/nlTOMniDbX+zZaMfAXH4jLiVwaS/Tw98GINJkczCUrDIlerhNbjdeqi3WQFIe1Dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP8Kyysck3MsnrxBGCrXqV6Fpld7ru/tP73MSc98urs=;
 b=flfoMzzPVwT1yk86fxe6p0TjD1rFtv5x0/t2ggKqlBegJZaKFWDUUCALYDYsJkIRuHRH+tfnsAHnKG3T5w6YTtEdtvSpZq6cCL48SI/JC2wD6t1+mEWKcbirl96gzI8MEs9dxRmj1OUGMz9fBewtDHtxWxyzpXti+o04RfB4z/Im5MfLwT7OCFKjFJEYF/RXxdtBCccJRXZWcLo9MhS4xKdwTa41xjF6kBFuapoYCOfHrcO6silYHYioQ50LBBl7Q22FWbdswjwgK3NSA1bNwcTjvAwqBxMfu3nkikTgulB2j3O3oGEKuos/ioKz2PnwnuvC/ZHq9c/gwCeoROCnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP8Kyysck3MsnrxBGCrXqV6Fpld7ru/tP73MSc98urs=;
 b=WcrIr47eVIdOAIJhDaOlCpvlc9xTCtjOOBGsrMpEssxKJPNDx9YGe27363rSTAWfoybReHVPlTBVpcTlGI0iWirRsJi6ea0uCP5HWEmDC0bVdR/YphIXmVsaiV0933mA5j8JdRkfO2hJbWYkVUfW5GrE0ygKra8khvGgqpPZnzo=
Received: from MW2PR02MB3770.namprd02.prod.outlook.com (2603:10b6:907:4::15)
 by MW2PR02MB3755.namprd02.prod.outlook.com (2603:10b6:907:8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Mon, 4 May
 2020 05:33:22 +0000
Received: from MW2PR02MB3770.namprd02.prod.outlook.com
 ([fe80::a473:190d:a1c2:11a7]) by MW2PR02MB3770.namprd02.prod.outlook.com
 ([fe80::a473:190d:a1c2:11a7%6]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 05:33:22 +0000
From:   Harini Katakam <harinik@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>,
        =?utf-8?B?UmFmYcWCIEhpYm5lcg==?= <rafal.hibner@secom.com.pl>
CC:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma: zynqmp_dma: Initialize descriptor list after freeing
 during reset
Thread-Topic: [PATCH] dma: zynqmp_dma: Initialize descriptor list after
 freeing during reset
Thread-Index: AQHWHWogREHlzyCJGEyKjQo9nPVsTqiUwLcAgAAHqACAAqMagIAAAiDg
Date:   Mon, 4 May 2020 05:33:22 +0000
Message-ID: <MW2PR02MB37705416E18413689BFFC7C3C9A60@MW2PR02MB3770.namprd02.prod.outlook.com>
References: <20200428143225.3357-1-rafal.hibner@secom.com.pl>
 <20200502123242.GB1375924@vkoul-mobl>
 <1330934e-342e-1e16-6451-d8952463119c@secom.com.pl>
 <20200504051623.GE1375924@vkoul-mobl>
In-Reply-To: <20200504051623.GE1375924@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec84ecbf-9ae5-42fd-051f-08d7efeca8f1
x-ms-traffictypediagnostic: MW2PR02MB3755:|MW2PR02MB3755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR02MB37551DA5BECE4B24EC3C2043C9A60@MW2PR02MB3755.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0bW7D6Sy2BcM4r4KuSnZYla9RrAxbyVs2/VqjXSDE7vMT/ERYSRx9kPhxpQnLvAwg9sQqfWqTl1YHZv9efEQ6sw/Of3IaPKdPRpOgeneJWuVejY9PTU2h7O9R6YdcR06Peo1SQXrK4PZ/l02Qhohf5N96kvBIvJsNvOOJPsyJF0iYLMy7UIzon4a4sFDHShfJUZ1n1bhi7IQRKu0mxkKP0lyx5IXiIj17i/4gUgAEU3vTS4WwoMdJfJIzgblK2th+zMBto9H2Lm4IMEa+IS1OB3OqzsED5ofN9xaNe/0zWSHCixt9FrduZ9n5wmVC8Y5gd1DYbcXGlmkw3FUTFVje3OBDuEM5y1M9PfFopN/BzAwHPPTYRtR+a0p5IOJ26Qdyizz7PW9axtrOkp8Uy649i2c5RsyWPOf8HsDszykEnyenhS4g2V2IXz4fTkErOj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR02MB3770.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(39850400004)(136003)(346002)(71200400001)(33656002)(66556008)(66476007)(4326008)(8936002)(110136005)(54906003)(5660300002)(66446008)(478600001)(316002)(86362001)(8676002)(64756008)(76116006)(53546011)(6506007)(186003)(9686003)(66946007)(2906002)(7696005)(55016002)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: l6/IE7DIEiJS3rsPeTyk8L7zEABxYRl2BnvsYJhCvhUXm0nLNslPvxp+3YYGtT3i/ygyaqxAqU0aVtG+q4xCqKsmFHE6Ix2Um5TxjVo3JFWa6Oz/bZfQ7iDR9G7LSGy+qUX0RWk+z0nSkwUy98MEjlRU6Htl7x1b8mbYQEiHHbiLHCbUVKxIyRUVf6//R4aRcbzGnyHZckho4fI20MUAUaF8cw170V1yQVyDk54MJu2JTgwKm+IEFj+7mhY0vKUDwOPTBFC3+vADeGjHlIubwk8wuVGlie0iBvUQ/f688S6f1Vom5ojIn7wVygzA53AFBMcJ+Zh0dHTXIuyPyvK3y8Vh5Veooe7QiS3R4VilNVIiL/75f3UpJ0SfVO2PTRHoOi7DRB5H/kFpsAGopimf0PNwC5cKYsfnLT1xVzly2mSEIxcrEAnOg6M+i920M4w7ZQWnX1hEzoA1H4nxSdOQJEOEGWU+uGCFvw27tMLt0WPMKenD2ZRbvjp/POtYc916PnuKTtTxQ3y3ObOgnZAMDLW0N4+vCdpwvB3R+og6TGmU9xh9waCLdGUwNIw65FVO7a1mKAdhZIoWg+Pt0MJ+BMaerMO/MLrno06CEs5X+iTSBhzCp50Hulz2pWf5sbCT233F5zJqQJ16DfdPfyzcN8OKZAB0neBO8wrEfjyeiB1lMiYuAsmmWTtQVxKrxWHbUbyVbZTFl0O6BCnJZAIIMWh/sGyIPnWKG7T5C8kYINn2AfZrpwSL8vZFeWy6ZYBFlUs3izROFfi6fL8GNwzgz1UU0gBNHebYQOESVujSbA4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec84ecbf-9ae5-42fd-051f-08d7efeca8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 05:33:22.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIPe3JU+gu0r+0y1G5ipflxWRUVmnxlkze9dUKP2lF2LZSyyQ6LLiodQttxtsCRtLqZJKXPg2KiK1TecL9fLUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3755
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlub2Qg
S291bCBbbWFpbHRvOnZrb3VsQGtlcm5lbC5vcmddDQo+IFNlbnQ6IE1vbmRheSwgTWF5IDQsIDIw
MjAgMTA6NDYgQU0NCj4gVG86IFJhZmHFgiBIaWJuZXIgPHJhZmFsLmhpYm5lckBzZWNvbS5jb20u
cGw+DQo+IENjOiBBcHBhbmEgRHVyZ2EgS2VkYXJlc3dhcmEgUmFvIDxhcHBhbmFkQHhpbGlueC5j
b20+OyBSYWRoZXkgU2h5YW0NCj4gUGFuZGV5IDxyYWRoZXlzQHhpbGlueC5jb20+OyBIYXJpbmkg
S2F0YWthbSA8aGFyaW5pa0B4aWxpbnguY29tPjsgRGFuDQo+IFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IG9wZW4N
Cj4gbGlzdDpETUEgR0VORVJJQyBPRkZMT0FEIEVOR0lORSBTVUJTWVNURU0NCj4gPGRtYWVuZ2lu
ZUB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vWllOUSBBUkNISVRFQ1RVUkUN
Cj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IG9wZW4gbGlzdCA8bGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRt
YTogenlucW1wX2RtYTogSW5pdGlhbGl6ZSBkZXNjcmlwdG9yIGxpc3QgYWZ0ZXIgZnJlZWluZw0K
PiBkdXJpbmcgcmVzZXQNCj4gDQo+IE9uIDAyLTA1LTIwLCAxNTowMCwgUmFmYcWCIEhpYm5lciB3
cm90ZToNCj4gPiBIZWxsbyBWaW5vZCwNCj4gPg0KPiA+IE9uIDAyLjA1LjIwMjAgMTQ6MzIsIFZp
bm9kIEtvdWwgd3JvdGU6DQo+ID4gPiBXb3VsZCBpdCBub3QgYmUgYmV0dGVyIHRvIHVzZSBsaXN0
X2RlbF9pbml0KCkgd2hlcmUgd2UgZGVsZXRlIGl0DQo+ID4gPiByYXRoZXIgdGhhbiBkbyB0aGUg
aW5pdCBoZXJlPw0KPiA+ID4NCj4gPg0KPiA+IEl0IGlzIG5vdCBhIHByb2JsZW0gb2YgbGlzdCBl
bGVtZW50IGl0c2VsZiBub3QgYmVpbmcgaW5pdGlhbGl6ZWQuDQo+ID4gVGhlIHByb2JsZW0gaXMg
dGhhdCBkdXJpbmcgZmF1bHQgY29uZGl0aW9ucyAoenlucW1wX2RtYV9yZXNldCkgYWxsDQo+ID4g
ZWxlbWVudHMgYXJlIG1vdmVkIHRvIGZyZWUgbGlzdC4gTGlzdCBoZWFkIGhvd2V2ZXIgaXMgbm90
IHJlaW5pdGlhbGl6ZWQuDQo+ID4NCj4gPiBJbiBub3JtYWwgZmxvdyBlbGVtZW50cyBhcmUgcmVt
b3ZlZCBieSBsaXN0X2RlbCBhbmQgcmVzdWJtaXR0ZWQgdG8NCj4gPiBmcmVlIGxpc3Qgd2l0aCB6
eW5xbXBfZG1hX2ZyZWVfZGVzY3JpcHRvci4NCj4gPg0KPiA+IHN0YXRpYyB2b2lkIHp5bnFtcF9k
bWFfY2hhbl9kZXNjX2NsZWFudXAoc3RydWN0IHp5bnFtcF9kbWFfY2hhbiAqY2hhbikNCj4gPiB7
DQo+ID4gwqDCoMKgIC4uLg0KPiA+IMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZGVz
YywgbmV4dCwgJmNoYW4tPmRvbmVfbGlzdCwgbm9kZSkgew0KPiA+IMKgwqDCoMKgwqDCoMKgIC4u
Lg0KPiA+IMKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsKCZkZXNjLT5ub2RlKTsNCj4gPiDCoMKgwqDC
oMKgwqDCoCAuLi4NCj4gPiDCoMKgwqDCoMKgwqDCoCB6eW5xbXBfZG1hX2ZyZWVfZGVzY3JpcHRv
cihjaGFuLCBkZXNjKTsNCj4gPiDCoMKgwqAgfQ0KPiA+IH0NCj4gPg0KPiA+IFRoZSB6eW5xbXBf
ZG1hX2ZyZWVfZGVzY3JpcHRvciBkb2VzIG5vdCBkZWxldGUgZWxlbWVudHMgZnJvbSB0aGUgbGlz
dA0KPiA+IGJ5IGl0c2VsZi4NCj4gPiBJIGFtIG5vdCBoZSBhdXRob3Igb2YgdGhpcyBkcml2ZXIg
c28gSSBmaXhlZCBpdCBieSBkb2luZyBub24gaW50cnVzaXZlDQo+ID4gY2hhbmdlcy4NCj4gPg0K
PiA+IEFueXdheXMsIEkgZG8gbm90IHNlZSBob3cgdXNpbmcgbGlzdF9kZWxfaW5pdCB3b3VsZCBm
aXggdGhlIGJ1Zy4NCj4gDQo+IExvb2tpbmcgYXQgdGhpcywgaSB0aGluayBpdCB3b3VsZCBtYWtl
IHNlbnNlIHRvIGRvIGxpc3Rfc3BsaWNlX2luaXQoKSBiZWZvcmUgd2UNCj4gc2VuZCB0aGUgbGlz
dCB0byBiZSBmcmVlZC4NCj4gDQo+IFJhZGhleS9BcHBhbmEgYXJlIGNjZWQsIHRoZXkgc2hvdWxk
IHRlc3QgdGhpcy4NCg0KSSB0ZXN0ZWQgdGhpcyBwYXRjaCAoSSB0b29rIG92ZXIgZnJvbSBBcHBh
bmEgS2VkYXIpLg0KT25jZSB0aGlzIGRpc2N1c3Npb24gY29uY2x1ZGVzIGFuZCBSYWZhbCBzZW5k
cyBhIHYyLCBJJ2xsIHRlc3QgYWdhaW4gYW5kIGFkZCBteSB0YWcuDQoNClJlZ2FyZHMsDQpIYXJp
bmkNCg==
