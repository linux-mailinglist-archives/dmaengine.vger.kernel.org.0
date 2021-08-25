Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803573F7787
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbhHYOjA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 10:39:00 -0400
Received: from mail-eopbgr1400139.outbound.protection.outlook.com ([40.107.140.139]:41748
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240098AbhHYOi7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 10:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCpwqfNOUBpcl9JxHqAdBXYAZh4UDBOGS/ryP8n1DM6B9pibI322+0Q4ug7+zgdmpJsf3lFVAXaUMc8bkkiXORxyEbAxKr/P0dJB5NlvISu9SnO7SxqcfFm43Ts2IR0kYpnq1u3NX53OpctVgMoGbobjzPvkE8QsBas2XuBSr0Hic+sL7pwQ8k7FaQI9n3gXarn/1kZj++BWZREPG65lDH0+yKsGrRb8yKEGQD11Teo8cTOIJWGNKzIyjjyE04+p6/6dsUllb73hu8WAWD8SLD0YG3TXdKbx2GQksIzsCyZML7xlpt1KH+Xd6ZjM6cjCxLgSfwuRpCd5wUKpgDedGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVdRS/+BdOVVR2v98DMEKQBhXa95fjjSQYQd+xDBPz4=;
 b=kzQ1d7nXvugAyg1cMm0wPMWK/im13wkhmWW9K6KxEDIgeJthJDt16rhjoh8bB6/MtIGcv0MDV9HH181VAlr5AZUadKbRzoC73GfTuOs9f34Js+AWMy96Dry7vvh/QEvBj/gV+r48Sz7i/dLSnjGdJYbPupiNa5LtR0K+is1HJ+dLlFy72dGejya9lyE8nmhavvzOYaTDYIiYNY/E/zoaVVxTW2DXu/eGKsjt7kkaVJC2ES9CJs2iOTMVFM+ET5NMVX6dfTMP8lisJA+O2q8DSYhFGoxgS3qRW2FwnnTd5fL3qB6vS4442fz/uDQp7xdPKfXuIy9R75mFbUJCDYAOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVdRS/+BdOVVR2v98DMEKQBhXa95fjjSQYQd+xDBPz4=;
 b=Co/cAPHtI8xR3vKySW4BmonMFSzi17YR8ClgVkU84rozHK2ZGGV9yNJzP6WxaM0lgrhLbt3m+dyB0vd9Iy0G5f4P+4vLFmwuGcSgutxNdmSxli9kIATSBcI7K33HeCx/mUvOLVyrAnCzBbn+HXCQST6kjhEgqsWeN85vCmUNFF8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB6180.jpnprd01.prod.outlook.com (2603:1096:604:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 14:38:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e111:61:43af:3b98]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e111:61:43af:3b98%3]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 14:38:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 0/3] Add RZ/G2L DMAC support
Thread-Topic: [PATCH v7 0/3] Add RZ/G2L DMAC support
Thread-Index: AQHXiqjo2NLXibA+ZEa2KdTQORKkVKuEZrCAgAABaWA=
Date:   Wed, 25 Aug 2021 14:38:04 +0000
Message-ID: <OS0PR01MB5922372693F3B827DD95815186C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210806095322.2326-1-biju.das.jz@bp.renesas.com>
 <YSZUcanmMRPG7ODQ@matsya>
In-Reply-To: <YSZUcanmMRPG7ODQ@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930e2b7d-00b1-40c7-40ea-08d967d5f2fc
x-ms-traffictypediagnostic: OS0PR01MB6180:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB6180116A2B3E486D5CB8BD7D86C69@OS0PR01MB6180.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2oMhU4fA8ZUawlyjF9ge1wZG08zCWqy1UOHDqCRJTSg5zLlWv/4XsXVDUSWOJwZ5nk0PUH56RX4kMa+46Yt4ToE/4n3MMTO9Y2fJJgRihlzjLbPpnDpXFekFzZW7DBUZTTGI4hCjpmbxUL7P/yLJ/DhuHtFnxWXIX32izZ0s3/neYWArW/Sc21uy31VT0hRG9z3WbozMBqeF6DkpZYxHcxLffPAujmyzC8L5qX+6AjXTRcDzMf3dC7cOuNqtP2xJuDAMveWPJfloypFqqnUsMeLwOBm7nKUuj3dOrDKGpNJhGXiJcCtRrxJjzB5jjU5k7b7hZDLyFIs/vLR+57qniibe8Vxgvu2GJkcimLuz0CAuiaTgY0fC2A+uL7nkx6CA4Pwo/u3UxsZ+k8wScaiA3JlkcCjnoenK72oJ5mZq+O6XajcA3z0IrZdy3Bh+TqCQ1RV6eY9g88urAaxKR6GVZFeSa3mdf1mR3/l6Q9ax5frdZH5QV9fNRYyoVV+iUa8gW5QbE0K12AjEwU8j4Zipz84TP9KSPrmkugJrrSxpHCGfjwg77+jKEPF8jJYES3a1RXXkc4hhU92STVNrqujH5BwYqk82vu6zwLcQbRQlqPyLHZIVmP7s/xQnz5tHOcoTNAuw+X7NF3LiQXZefz6V243ZCAsqdbPeiOjGh+dMcWlvMQzTXV1+r0iSv+VFAVk+6N0ihumcvZRLLR8ncJD3pA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(5660300002)(9686003)(38100700002)(66476007)(66556008)(66946007)(38070700005)(53546011)(66446008)(122000001)(64756008)(8676002)(54906003)(33656002)(76116006)(52536014)(71200400001)(55016002)(26005)(6506007)(2906002)(186003)(478600001)(6916009)(7696005)(4744005)(8936002)(86362001)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vkg1RHpGQVFTVFN6c3I2aGVsM3RDNDFISzh1VERwTWxJZ3Z2UVNVek9DNG0x?=
 =?utf-8?B?TU9TejhZS3hLT0Uxb2ZXK2t0Z0lVc2VPVzE4V25wYXlaaHUvR0hBNjF5M3pK?=
 =?utf-8?B?eEJkZWxtZ0VWWEwzOWFESk8vNDBkRWU3OExoTHE4VDBreE5mdjU5aGJyYncr?=
 =?utf-8?B?VUZZdTVVSkxqSnBtYThvUDJFVHlYTVRsdFpnZ1VIbFk5SHNwUXJteHRGOGJo?=
 =?utf-8?B?NjcvUEczRFNCVTFSajIwQmFFZUIxRldBQ0RpSmJ4UHR4akluSHlrZXBTdktx?=
 =?utf-8?B?V0hWb2tQM3FpUXJwNGh5dm1vOVZ3OGcyK2d3akRZQkFuaXl3c0o2cmh1WG94?=
 =?utf-8?B?T1l6eU5OQi9vMW1KYS9rMlVDWnhpd2N5dDkvVlEvTytIb2MrR0NVSHFqeGJR?=
 =?utf-8?B?aE5NMGFrdklUc2lnUGlZeTVES2dTakJqeWJCR1pzbnBaZHRGWGVMU2xnbG0y?=
 =?utf-8?B?WDFrRFNrT0Z5U2lhNmdYTk5YVHJ6U2NQekhHZVM5YlhtNVErV2cvbDlxZ0dw?=
 =?utf-8?B?TjNJL3UzZW1WSXBqRkRHS3ZGeEdNNWtiRnNRUDQwRFZ1Z3BQRE15clJRYUV5?=
 =?utf-8?B?aXIwV0szdEpnRTRCNmZhazZwOCtlNnVVc0g3N1lkK0FxMlNCZDdHenp4LytE?=
 =?utf-8?B?N1d6ajBydUxuV3IrVjVQZ2RNd3Z6Vm5Xb0E5TjJ6S1hYQWtVRVR2ZmoyZjFB?=
 =?utf-8?B?VllZa0FyR1pET3ZnYlFYRE5RZDA3Z0x5Qk9ydHprc2ROWGdUTHRZZ0VOR0pK?=
 =?utf-8?B?OUJxNUhoaEE1eFBEZ1oyZGh1RUFZQTJpb1k3YXpSUTJTVlVQcHhWa0diT2xU?=
 =?utf-8?B?Ny9CdHRtVVBaWWZuVjkyOTdtTndCdnNaZkpna3NUR2ozcG12NUwyTjRkRmdC?=
 =?utf-8?B?QkplQWE2aGwzM3liRHM1UVVaekhvMForemIzL080QVNwNzJRclI2ejJZZ2NO?=
 =?utf-8?B?NWFEQUFqVVBlZHFTRjBPdll2YU5WYVliUTJTdE41NXJBcUgxZk5xL2E0U1VZ?=
 =?utf-8?B?b2h5eFlJQmVPejlldXZyODZHd3BnWERUaURDdTh2NGNKc2Iyd2dXVnEyQ0FX?=
 =?utf-8?B?U1crYVdqQ0tmMDBiL2s0alg4NU1IN1BLdm02NXBFYXJOZWhSZHZRbmRRTERB?=
 =?utf-8?B?T0p4ZDVQV0E1NGlOekFuYVBsWHVmL3pwMzNxQXl6aVNKaFhDZTlqazcxUUpl?=
 =?utf-8?B?aGtMa1paRzByUFRoZGlzZ05pTzdRalg3Y01GN01UdzdzVnVzclNNd0FZMUFJ?=
 =?utf-8?B?amc0a0UrUmN2dHBiamFmZjdVVzJNRmxESGl6aTBISVhsTkVkL3JIZnhQQkFR?=
 =?utf-8?B?VGl5cjk4NkJGUEZnSlNmUmhveFRsWndiMDNsM29wR1Q1ZFdvTm5VMjBrUWhs?=
 =?utf-8?B?NVhqWkhRS3BtSzBIYVRreVo5RUtHSDFENk05NHR2TjQ0emtDZ2VaamxZOHlH?=
 =?utf-8?B?NWJ0RHhTM1FWTzV0RVROMVpnczF3WlhIbHhGUk5XRnEwck43N01uNHJETGg5?=
 =?utf-8?B?U0Q1QTNsNWZ6QzV2ejFWYWowSHZRdCtvbHFmaDhpMzVBR1RYd0crdW92Zy9j?=
 =?utf-8?B?SGMxQXJaQXZiQkd2QW82R0x5SnpOczdmSFRUcHN4QjNYRHdveHptNzAxWWZP?=
 =?utf-8?B?d2tyeHZ1M29oMlM4d0xQdUZ3dXZXclQrZ3A2YStQSy9UUU9abWhiL0pFT1F2?=
 =?utf-8?B?VDlNdkVoVlFWY0thNUJsQVFCQzVWa28ycnJLQUF1YWpsZFdSbkg0ZkJ5Z3o1?=
 =?utf-8?Q?h63UjC+kZg3rp75chU5slIICN1QuZhjFknv3chf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930e2b7d-00b1-40c7-40ea-08d967d5f2fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 14:38:04.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/I4mqIAsoJkU+WkS187xVR2/XCcgNG7E5wetFThaYH48mBa5mu5zCkjUCbig7qihIqmlL+kZoUqbgvbirTUh8YfzVKl242L/A44nxw1AGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDAvM10gQWRkIFJaL0cyTCBETUFDIHN1cHBvcnQNCj4g
DQo+IE9uIDA2LTA4LTIxLCAxMDo1MywgQmlqdSBEYXMgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBz
ZXJpZXMgYWltcyB0byBhZGQgRE1BQyBzdXBwb3J0IG9uIFJaL0cyTCBTb0Mncy4NCj4gPg0KPiA+
IEl0IGlzIGJhc2VkIG9uIHRoZSB3b3JrIGRvbmUgYnkgQ2hyaXMgQnJhbmR0IGZvciBSWi9BIERN
QSBkcml2ZXIuDQo+IA0KPiBBcHBsaWVkIGFsbCBhZnRlciBmaXhpbmcgdGhlIHN1YnN5c3RlbSB0
YWcgZm9yIHBhdGNoIDMhDQoNClRoYW5rcyBWaW5vZC4NCg0KUmVnYXJkcywNCkJpanUoMjEwIPCf
mIopDQo=
