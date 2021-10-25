Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E86439442
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhJYK5M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 06:57:12 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:18637
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232987AbhJYK5L (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 06:57:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6pcHrn5Voj0vpPLCqUBf+8BKMmU9NlH52Nq+Gj0Um7wKA1X3MQfNeUbZGd/tAyR2QivQuFedK5Wu6ZGawGEztK2aIaO9MR/XMk72ipT4ri2GJ9HPzFik7t9k2dzFat0lYjvRN5q120qa98V9o+bJ5EubpgF386Vaoe6yEqdUeSFC3MVL5dkkwNGzVsMoKBhG4ycbbmOtlZ8diWyU0WJNFVimy4yc5/CKSMB7sk2P4a+J4n3n2BC2pN1JPE44DHB0i2BN14Ni9N00sX1QxFzyLqIXY3RC0KrgWobFweD4XdSnqFWuD+zR1XCTwp4PIndhxLcYYjH5pBEpWjN/nfC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1FtCuBf1cKJ8WBUXLo86WfT5EGN2o+uCV+zRIx9Bns=;
 b=RzcE89zDkNbNv6WVkcCSbofcW6VugrLMMWjkvgDwEPSmVgtZKkl9mUuBJYbhHcfkI6+lKOzmQL0cDFcLVkF0W+/Kx6ljDiT+gQt+jmjiRgOALlnnj4y9tNMow/L3C5ck7RhwQj1jfTsW0MsSjkScIfNjvK2jB+kg2zOGwRGXz+SCA5ociDBAB9rPowSFwWAsR8BtM3hfLt150ikghUpvOASKrcuyTp59aXn6vTFXbJHb0iNQOHy5fVIrlFU7iPaEZgbo3oOMivBXw9x1JIkPrPpJa5Lo+f4VVT9Php2Oh5nAJ1Jm4HBOsoQUHUTcLwHQLQ68NRIeNL58b7a40F4keQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1FtCuBf1cKJ8WBUXLo86WfT5EGN2o+uCV+zRIx9Bns=;
 b=h5hLVmf9ObviGsfrLgEX60H4N2o0TPP7sv7exthZefIizEGw8gzY2h6899QNx2ma2MrO+bpcHSRMjCj6T5p0coknjtwsvgQaaCpBVH4HRVI7Ey5v8ZtiGcEreVUl4IBvi2wMFiiwk133bbTyE3IpDMCw8JE1362fLp8iUet1EVU=
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
 by AM0PR04MB4276.eurprd04.prod.outlook.com (2603:10a6:208:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 10:54:45 +0000
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e]) by AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 10:54:45 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Robin Gong <yibin.gong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/2] bindings: fsl-imx-sdma: Document 'HDMI
 Audio' transfer
Thread-Topic: [EXT] Re: [PATCH 1/2] bindings: fsl-imx-sdma: Document 'HDMI
 Audio' transfer
Thread-Index: AQHXxjt/4hXSLYx6/UOgXKyNm58zh6vjKaOAgABnNiA=
Date:   Mon, 25 Oct 2021 10:54:45 +0000
Message-ID: <AM8PR04MB7444FE3C9863E4230091080EE1839@AM8PR04MB7444.eurprd04.prod.outlook.com>
References: <20211021052030.3155471-1-joy.zou@nxp.com>
 <YXY2Ra+/j1apuRpZ@matsya>
In-Reply-To: <YXY2Ra+/j1apuRpZ@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdd8d98b-3568-451c-8e9e-08d997a5db57
x-ms-traffictypediagnostic: AM0PR04MB4276:
x-microsoft-antispam-prvs: <AM0PR04MB42766F961BF549B41F415885E1839@AM0PR04MB4276.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kk5BUq/Eb83NEpHbvADYH0OG1ExGwdANaMyS0lqHVbelbaId1Jt+v3xbPxUgCUfpv1GKJ1RV8umSB/b+q1cGoJdgZ02e+yUTT2zyh0EAEg4qOJuhR/0hgKYCW0kawsWVNcGxLfMtV8kdNpk4YYWTCbL9VrS7rPaNmixEwKJsAYAoSNuFNYvm2pGtXAYDycL7RNUHT0mhVVx82aejrix65KAEp9QHlSeQKxP29Dd6hyCeX8q4MgDnLJZBpdKNJPWDlGDcjLLHg50cPju8KaSDql5vJJT6H5Eot7tYdN5KjJhISf3kWQse5WYPYL7Wi6TeYGup9UqHa7lOsaHvF365LrEYBQdOYw0M/GsjbDInbfUuB/1rJ67o7Q+MlGfhzBEMQjA9DNhR3gBEQb82V3br96hCTmF0zXocr9YW6yWSYfb8bNajUSNHGdYF0fiytFYtwd09Etv44uAjmUQ8w9lIHYaAHkWqd8NQt3NuWhDYspCZy/cMlD+GUjdCJ50XG0vGGEnb58yle2RiyX2S/jE9OOowkl4Zcqg6ArfRr5GRg/gxi3gisMRbeFASo+i0iGaVw0uq1rJLE2FoVNInBbtOs3F4RpbFfIy7gR1le+MrqLV0ipwSfgWS/kNQo1tyRuGpBp+5v7fYjtIo2yw3EfpkGSCEl2OH1mJey8s9UTR2r8EGmN0UoULiOY98mAYoSMClQWsVWGLDAzMqmiXG+IYLqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(26005)(54906003)(122000001)(52536014)(8676002)(186003)(316002)(7696005)(6916009)(44832011)(64756008)(5660300002)(2906002)(9686003)(38070700005)(6506007)(66476007)(76116006)(71200400001)(55016002)(4326008)(66946007)(66446008)(508600001)(8936002)(38100700002)(86362001)(83380400001)(33656002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eG1qVG9JZHNjSGZHVmNtb0l1eUdnc09hcW41TTRqaG4zZml2K3p1NE4rR0hU?=
 =?gb2312?B?dHZGck9NalhLRGxqcHNTeWR0Kys4Y0pGMitGNDZMdzNOazMwOGVCSkpvK0E1?=
 =?gb2312?B?UjUvallmT1R6YTU1NUNJS014SUYzYWJrb2J1aWY2ZkNkNy9QdkpIQWJia2Yv?=
 =?gb2312?B?cFN6bHprcUF4VDlScHVGNW1pRzYzK0YwdUhmdGFycEtWMGNFbUxvTTdMcXJI?=
 =?gb2312?B?bjFaNUYwYkJUWFJpSjcxSStyNjdhU2g4TThhajZFaWdNLzY2cS9BTkppSkhU?=
 =?gb2312?B?YkZCZS9GVGZvZGxHTmpncEx5Mjd2Tm5tN0lNNWhUSTRYWDY0MWpJU1VmMi9B?=
 =?gb2312?B?cnh6UGxLNStYMzVyWDVBSEhzcjJkVlZyMkhFQVhWYk8xL01QVnI3YjRiWW1t?=
 =?gb2312?B?eVorVlJHYmZxYVNVWVpqZnM4UWt1UUxwckN0aTYzY0g3alpoVkhSY09McnhO?=
 =?gb2312?B?M1dxS1pOUm42VVoxMkJZcDIwTlVETC9ydW02cXZTSG1ZZU1FajdoUXJrWCsr?=
 =?gb2312?B?QlEyNVlUQ0JFbUY4Tkh6VmpmL1ptZm45aE9wUXp1bVU2ZHhvUksvYjRwbjdq?=
 =?gb2312?B?bDMvS2VKcmxtSnZWcW5lL0J6RHhFZTNOTkZycHpBNHU0Y2tETXF1d3JpckxS?=
 =?gb2312?B?MzV2TGtKYkVwTDNialkxdXBhTm9PTitVY1NSMlJiQjhZZWVVaGcvYXA1RTMy?=
 =?gb2312?B?MkY5cUNSQm56WWx2WnpQaXVBRTl4cVJESXFvWmx4aUV6NnVkdnFLTnVseTlF?=
 =?gb2312?B?bU0zRklIYjdrYzMrRWMxRm5CZ1o5elZxVU9FdHIzT0lxQlQ3Y096bnVKYWFy?=
 =?gb2312?B?RmZxd2NVT0lQWTM4dTM5dk83N1g0bEk3aENYSDJZSmh1UVBLREh5U0FwS2tG?=
 =?gb2312?B?NUxoa2N5bHphOVhWMDZMbkp2SWh0dTRhaXdBaXQrQkl6a0FWa3pOOWVpMWZP?=
 =?gb2312?B?VGlEaDBOQUlsbFdybldPSkw3eTlsL2h0N0dDTVZjMlYreGpYclc2ak02VUdQ?=
 =?gb2312?B?alR6bUVGYXgxVWpRUTg0NUwvcjVjT05DbUZGVzB5dmVVcGF3aXFkUUZVR1NS?=
 =?gb2312?B?ODlBTThsWmxOcVVheGlmTXlKQXhxVlBhYjg0RWx1VWlmVllMRDVsc213YUFz?=
 =?gb2312?B?ckJUM01sK3A4Unh2VE1Nc2UvTTErSnRVOWFNN0Nucms4SDVMRFQrR2dGckZM?=
 =?gb2312?B?RjlLSVZzTlVCMEpkSUFGLzJCYXNjOTEyTDJqalBPd1JibU5jV0dHcUdaOG0r?=
 =?gb2312?B?NTA1dGZheWs3Z0VpY204OTR6T1VUWHNEZTZuSjZ1TkRrTmQzNDJHQ0lNS1k2?=
 =?gb2312?B?SStaTUZJKzdQNFFWM2FMeHpDbzk3ZzFmdHBZcUpnaHFQcmRlRGJmV0tUQnE4?=
 =?gb2312?B?WEc4WUdSc1Z5elFDVDRnbnQ2OStJMzNUVi81SStwaUdhUXUzK2NZNG1Objln?=
 =?gb2312?B?STFXUHd2cExSMmdqbm5jRFZhMzNVR0tvcXRpbjYyUkU2U2xKRjc1VS93b2hE?=
 =?gb2312?B?ckdHaDdSM1JqU25GQTQzbjU5cXg3WHg5MlFuT05KRmFuSE1NOFlJUDNDWVRz?=
 =?gb2312?B?ZHo1ZFY4eUx1eTJhYitLMi94TUlJSlhKNUE4Y3d2bkFEZU82NTBDdTk2YUc2?=
 =?gb2312?B?dUh1MGVNMU1OdmZwZmMvbzY3dHVSOFdNTWl0L2REQ0ZJVW1yK0NjY2d0RTlX?=
 =?gb2312?B?Mzl1MVFaVlhHYjBvdW8zYU1ESTEzTlVQems0TVE2NS83ZTV0WUtOc1VxUk41?=
 =?gb2312?B?QlE4R2orTGhNVFczRDN0TGg2VDJkU0lHTHpqdlN1WEpaNFMxYWQxeExBeG5M?=
 =?gb2312?B?NVVydDRvN3lpVnMwL08xMXN2MTVRSXF4VHk0VEhvNEZlcDJYOUVIL2hWVjQ5?=
 =?gb2312?B?OHJlWDU2cHpEdGlFKzhNSVViQUVXeEpKRE1lbnRMSEF2VGZQc0RMOWwwZlpT?=
 =?gb2312?B?ak1pUy9QMHRlRHNLSzREY2FWTEdFNklUMTFjQWYwTTR4TmZoMk9CZ0I3Y01Z?=
 =?gb2312?B?cnJtMTBPUDY0TDFqdi9ZWW93RTViZ00veUgrNDZwMEk4U0d5UEp0N0FVM0Zi?=
 =?gb2312?B?UlJUQVBCMVdxZDFTNTViZU5Yc0dSeHc5Z2dxdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd8d98b-3568-451c-8e9e-08d997a5db57
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 10:54:45.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCORV89R+j2OxzDkhfjiuHKp2w3+Vaoez3t2ie1WAFEgRtAw1Rutw4j6AWXT0G9j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4276
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPiANClNlbnQ6IDIwMjHE6jEw1MIyNcjVIDEyOjQ1DQpUbzogSm95IFpvdSA8am95
LnpvdUBueHAuY29tPg0KQ2M6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
PjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCAxLzJdIGJpbmRpbmdzOiBmc2wt
aW14LXNkbWE6IERvY3VtZW50ICdIRE1JIEF1ZGlvJyB0cmFuc2Zlcg0KDQpDYXV0aW9uOiBFWFQg
RW1haWwNCg0KT24gMjEtMTAtMjEsIDEzOjIwLCBKb3kgWm91IHdyb3RlOg0KPiBBZGQgSERNSSBB
dWRpbyB0cmFuc2ZlciB0eXBlLg0KDQpDb252ZXJ0IHRvIHlhbWw/DQpXaWxsIGJlIGNvbnZlcnRl
ZCBpbiB2Mi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0K
PiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1z
ZG1hLnR4dCB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgt
c2RtYS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgt
c2RtYS50eHQNCj4gaW5kZXggMTJjMzE2ZmY0ODM0Li5mZmE2MTI2NGEyMTQgMTAwNjQ0DQo+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4
dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgt
c2RtYS50eHQNCj4gQEAgLTU1LDYgKzU1LDcgQEAgVGhlIGZ1bGwgSUQgb2YgcGVyaXBoZXJhbCB0
eXBlcyBjYW4gYmUgZm91bmQgYmVsb3cuDQo+ICAgICAgIDIyICAgICAgU1NJIER1YWwgRklGTyAg
IChuZWVkcyBmaXJtd2FyZSB2ZXIgPj0gMikNCj4gICAgICAgMjMgICAgICBTaGFyZWQgQVNSQw0K
PiAgICAgICAyNCAgICAgIFNBSQ0KPiArICAgICAyNSAgICAgIEhETUkgQXVkaW8NCj4NCj4gIFRo
ZSB0aGlyZCBjZWxsIHNwZWNpZmllcyB0aGUgdHJhbnNmZXIgcHJpb3JpdHkgYXMgYmVsb3cuDQo+
DQo+IC0tDQo+IDIuMjUuMQ0KDQotLQ0KflZpbm9kDQo=
