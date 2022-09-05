Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FF5ACE8D
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 11:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiIEJHV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 05:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiIEJHU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 05:07:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E34F6A6;
        Mon,  5 Sep 2022 02:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0PZ4h75KsoM6P5Bo24l1X0VAws2OYeC3rluYY2Fvjr4iudUApWs8Z1+F6a/U7N/4i+B6uJXdGsKvTYcVjMAl9ircvfuue3Zj+d3As8rDqjfnyKmIEZJe1kBW8djghxwpzNr1InH8vcV4yGRow/g+iDcHSr/T1y7vHFkZmhdCwjisBhn1qeh9dOtL4afhuoofmb8q4m5M2iqMExn5bx68ZAJjboS5mub5RDNfA5X4pcRkm4BG+VYkWSFw8BezPE0is23NRUFHakeKnKfxDXduoY1Bdn0WXgMDFfmeH6iQnulCrVczP7DXgZWpGJsfkQF12Bi/Vam1XSLm6sT3rC2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWj728wPpEGoigAoSNS1MYXRMNe4BoglzH0jh6/x4XY=;
 b=cHYK536msbZ94XR/wKAxZBHXsOgsJK1zkEXNXwTL5CXLzTRY9gGtHDQ1zLIY1pqgtszruXQdQna+sFAdTg2AjIxRko9Sq/Xcv+ld8UfSGfsdEnnT+ZKGGVQUIxlikgpXxhjdhtGGlhOKoV397hq40d39W209MlT+UX9r8rXs+dw8KyPe7CfGOiH8X/oLC+gE8z9DDnDs0SPqreAjS4KPFbFWehv8BfuCMZzs8uHDJDsd3vwtdS4KPSsAbAMwaI7/LALYPVoutN4NLlupQueRKCImNy0FcP+uNIoWjOLPebgHQQH/FXH34fHTuagEw5ZuLnrrlVea1xwSan/EW7ZF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWj728wPpEGoigAoSNS1MYXRMNe4BoglzH0jh6/x4XY=;
 b=BTt0//PW5cW3A9UbeBwLDD9ZcO7qnGlo/6aIiWZdUTMGYX23GvkWJEjHU7v5NxRk4tYbm6cl4WOnR9Qrv4nkRdAQUFTCxdtDbQpV8YIBCtsl8jSbfTPMjIbchkRPr/h0Ek/rUZb2I82n9SX5xY69ySMASSwDGu62cFmZp/+fLgE=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PAXPR04MB8093.eurprd04.prod.outlook.com (2603:10a6:102:1c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 09:07:15 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 09:07:15 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Topic: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Index: AQHYvaZ8O5GQjHuFO0+lJC0QJTvpyK3PeAEAgAD00fCAACIHgIAAAFNg
Date:   Mon, 5 Sep 2022 09:07:15 +0000
Message-ID: <AM6PR04MB59250C67D565B6E5E52621ACE17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220901020059.50099-1-joy.zou@nxp.com> <YxTPTnrJst9aNpsl@matsya>
 <AM6PR04MB59253DD6C91D41344C08C175E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <0d523880-9214-7b9b-ce1a-d06d4d5fbdf1@linaro.org>
In-Reply-To: <0d523880-9214-7b9b-ce1a-d06d4d5fbdf1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dcc04fc-f86c-4a6b-c86f-08da8f1e06ff
x-ms-traffictypediagnostic: PAXPR04MB8093:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fMbjij/NKFOPLmZ8flCCbrS3RZ7h9tquNPDc+ZkUMH2Ulo93BQrQyC9zpNIDpZUHSv79Ze750NeQAcBw/bH4BD4Pet1XSG51XXDzOIPYYpdHXzCiTDnUga/SC5LhmHFWRgWiz5JlyL6SVHsA5q5+wf4o0yqlX2TpKTQAH8BHjPiGQo6TFK7xjsuS6PsRXoE2brPrAl3QccVrNWeCcqgmfFUJBlAPx84OxgFRKal+aftWH/W2hSYKL7wS/HZULqI+Gm8AKZe+h9A77b1oiIkdm8Zk3ratKVRdEphE8g4QCW7JcseU+kx7e/qTF5vdeKjblAdHGx9BQh5rLYCbAobxHOWSJgwCj6Bf+lnGYWVu0CIQJMuWIdwPib0TzSwqAtIPDdo306pD8CPoS0V6/0ZJeo/rdtn8kiYLVNSjnejoVe6FzucLTjETb48Ia1BXCLJksjQaPsV1ALtAlmEBaOjH+O5J8l6t/uYeMv79Qa77nT3vUCamL9aqkMLIvejM1ZT/l/co2K959lGGgWAdwVWpSjwLNpN+/EaLFU+cpATvMTcc271+SHrLtt9bE8O4SUuc5XRRFYpaMoeRL8xlBqEg6NPaC9M2fl2TZAB+Ut4p4J+ZVTQcXCbte9AMWkrvW+R/S8NgdWVS5hJVnAXZAnDYltbs+kKigyleNoKdaX9vIkfb9vUKiQ2Zg3JJ2x8V87Fv5ilwBo14UmwEeMWIUW9ieKtxHWXuCDtcuRYdhmKWvxdyct0fwhG8kIEUhWkdBqUVXpgaEoKzcy+J6BzNEMBqTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(33656002)(76116006)(38070700005)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(478600001)(8676002)(2906002)(9686003)(26005)(186003)(8936002)(5660300002)(83380400001)(6506007)(7696005)(52536014)(41300700001)(86362001)(53546011)(122000001)(71200400001)(110136005)(54906003)(316002)(55016003)(44832011)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0N3Sy9qaS9VTG9pVlFlQVd3NUJzcVVYTENTVG1rT3lRV1dwb0x3Q1gzOEtz?=
 =?utf-8?B?WFk4ejZQYmZMS01PM2tlZG5STXV1ZDhXKzV5bVhNa2x6T25OeWw3VmhvL2NF?=
 =?utf-8?B?Z3lUaGRXMEFaTWxwVGFXc3VIOFBzb0FBa083MlB6dFJUalN6NWZJU0p3dURJ?=
 =?utf-8?B?cGI5b1UveHpnTG40ZmZoV2tXaGxyay84a2lYYXJua1VzSzRuRDROclcwTkZ3?=
 =?utf-8?B?ZTBJR1I1ZjNWcHpvUk01M3AyOHQrS1h1U0VKNno0dVE5bU4xZ3ZQME9IZ2k5?=
 =?utf-8?B?RDVuTjR5bHdSTGNCc21hZnVxekhKYW00anFmSVJmYXZwMGQ2V1ZXWWlVY0lX?=
 =?utf-8?B?akNyWnZ1MUJwa0JCNHZOQ0haajV5ZmRheUtvanVUdFovSFNRaCsrWVRzcmFJ?=
 =?utf-8?B?WVdrV1diNWlta1N2RlZWYzRYQXpEL3d1cVNpOVl3THZoVTB6V3VSNDFiVzRL?=
 =?utf-8?B?andqMGtES1UxMlVVQStndU5DejhwNURpT0lqSDc3aStHbjhlN3hhajA5cndT?=
 =?utf-8?B?TVVnVlJBM0E3QU9hVnBXc3RSbTJGNXI5STdQVHRMODZqZnBlakFITlJUUXgr?=
 =?utf-8?B?Y2FIaXBFdVRFdlBHcHdsdStMSDVNaDhyOERRejlYMHRMYWhvMGh1cS9RVmJ0?=
 =?utf-8?B?MGNpZjNyR0dOOG5RMklmTUJtMlNYd29GT0tzdCtJclI4YldkL0o4bjhneG13?=
 =?utf-8?B?akQzYmFFTUF6WkNaZVFCakpOQ0RULzIxd0w5REUzVVF0Sm4rcnFSSEtLcktV?=
 =?utf-8?B?bTVRNkwzRGdxZlJLRjZiK1FqU0xKMmcvUk53K0Y4VXhIdXlra2tPVjIwcitV?=
 =?utf-8?B?TUlrYnM1V05Edms4bDBSOE5UUzlrWWhPWmxmZEhzd2djNk4xVVZMRTBsNDhH?=
 =?utf-8?B?Yk4zUHlheHRQUWxoeVUxUmRqSGxFbFZLb0RpZWpjM3BsMFlWaXBZQ2VmMG84?=
 =?utf-8?B?YlVzRy9tWU84Mkx4c29Vb05vTU0wKy9iSzhWZXdWdW5NbStiTElxeHV5L0Vu?=
 =?utf-8?B?NnBLN3NPL2RETSswODRXK1duN281QkwwVlZHMVFybXpuZE1WUERRckcwYTd0?=
 =?utf-8?B?WjNTZDJhS1BxK0NxT1FrTndYY3ZTWWx0dmpNSVN0QSsxYnB4enBGM1RlQ25P?=
 =?utf-8?B?NDJpcmZSUHZpaWEwdG5pdDhWOThYdGtNcGFUQWF0V2ovTTNKekgxLy9LSTRz?=
 =?utf-8?B?RGVHVldjWHVwbEh4L1hsUkJpSUIyN1Y3TEJGdGJOQUppdzZENDhXM0hOR3FU?=
 =?utf-8?B?MHJPYVViUUp5VnIwVFd6ZTJLTjJ2N25zNHNOeURsOFUxQXNTU1RwMGZPNjhT?=
 =?utf-8?B?RDBvYkpSZzVTUitJczRvaGUzbkIrSXFlcDJtSUZudUhpakM0bnEvR3RQcnRz?=
 =?utf-8?B?Q1BoOEgxVEowWGl2NDRkaWsxN1FmRXh5S2FhN0x5VGJqaVFtaVFtNHdneGkz?=
 =?utf-8?B?UUdIMUtvTHM4ZVlaaUZISzladSsvdEVnc1U3dHBiWUtDcGc4b1VjNFRoQmNX?=
 =?utf-8?B?dytPZElUZmtUZDdzSTdHNFNNdW12SFNPSUJRUnVCUmVhT2xMdmh5NzlHRU80?=
 =?utf-8?B?ZitkKy9QMjB5Y2s3dkN5bHNudHVta285dlI5ME1NZFpwRVVQUGQ0NGIxV1pW?=
 =?utf-8?B?QmxjWi9hYmg3WVBiTW5jOVNEOWpQcXVMYS9tNVdybE1tUkdiMTUxenZUeWx4?=
 =?utf-8?B?WnFmbUd1ZmNjN0ZXVzdvcXVicW9Hd2V2SDJHeWlDVjFDR0hVa0VwVnZVcWtR?=
 =?utf-8?B?bHN5ZG1ITkFad3hFSVlYRHVuRjdiQzN5dkdiRzgrQUMydzFSaTVvTnVJU2tP?=
 =?utf-8?B?eU5BWFVad0VuWHBDRUJFbzRzUU5XU2hLVDdmVnpSd2FYSERvM2xRMnhTa2VH?=
 =?utf-8?B?YWo1anNvS2kyMUYvTlBYNjdSSlRVNGZqTVlhS3BkcTlFUy9ralpHVmlrL2V3?=
 =?utf-8?B?MmpLdjVTM3FQVEllcm5CMy9ZaEhyZVBiNW9NSGVWb0o1ME9Ib3l6ZGxZRDds?=
 =?utf-8?B?MGJTdEg5S1JIaVdkMVZUNGlRTEc5QkQ1SVQ0TWZRQmw4N3k5VUJwZi9XMFA0?=
 =?utf-8?B?K3gyMFdneko5M2tNNXNEcmJSNEVDdUpkM2dGdm8vQnlNaDFlTDVrcFZxVGpi?=
 =?utf-8?Q?cByw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcc04fc-f86c-4a6b-c86f-08da8f1e06ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 09:07:15.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixDbwxc2Pb7P/h9wHHwGSb+/m6G/uioDvNTptn5UpmEXEVoVwcDGr3lEPZPoAjIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8093
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMuW5tDnmnIg1
5pelIDE2OjU0DQo+IFRvOiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+OyBWaW5vZCBLb3VsIDx2
a291bEBrZXJuZWwub3JnPg0KPiBDYzogUy5KLiBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCBWNCAyLzRdIGRtYWVuZ2luZTogaW14LXNk
bWE6IHN1cHBvcnQgaGRtaQ0KPiBhdWRpbw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0K
PiBPbiAwNS8wOS8yMDIyIDA5OjAxLCBKb3kgWm91IHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5v
cmc+DQo+ID4+IFNlbnQ6IDIwMjLlubQ55pyINeaXpSAwOjE2DQo+ID4+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+ID4+IENjOiBrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc7
IFMuSi4gV2FuZw0KPiA+PiA8c2hlbmdqaXUud2FuZ0BueHAuY29tPjsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gPj4ga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA+PiA8bGludXgtaW14QG54
cC5jb20+OyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCBWNCAyLzRdIGRtYWVuZ2luZTogaW14LXNk
bWE6IHN1cHBvcnQgaGRtaQ0KPiA+PiBhdWRpbw0KPiA+Pg0KPiA+PiBDYXV0aW9uOiBFWFQgRW1h
aWwNCj4gPj4NCj4gPj4gT24gMDEtMDktMjIsIDEwOjAwLCBKb3kgWm91IHdyb3RlOg0KPiA+Pj4g
QWRkIGhkbWkgYXVkaW8gc3VwcG9ydCBpbiBzZG1hLg0KPiA+Pg0KPiA+PiBQbHMgbWFrZSBzdXJl
IHlvdSB0aHJlYWQgeW91ciBwYXRjaGVzIHByb3Blcmx5ISBUaGV5IGFyZSBicm9rZW4gdGhyZWFk
cyENCj4gPiBJIGFtIHRyeWluZyB0byBzdXBwb3J0IGZvciBoZG1pIGF1ZGlvIGZlYXR1cmUgb24g
Y29tbXVuaXR5IGRyaXZlcg0KPiBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzLy4NCj4g
DQo+IFRoaXMgZG9lcyBub3QgYW5zd2VyIHRvIHRoZSBwcm9ibGVtIHlvdSBwYXRjaGVzIGRvIG5v
dCBjb21wb3NlIHByb3Blcg0KPiB0aHJlYWQuIHY1IHdoaWNoIHlvdSBzZW50IG5vdyBpcyBhbHNv
IGJyb2tlbi4gU3VwcG9ydGluZyBIRE1JIGF1ZGlvIGZlYXR1cmUNCj4gZG9lcyBub3QgcHJldmVu
dCB5b3UgdG8gc2VuZCBwYXRjaGVzIGNvcnJlY3RseSwgcmlnaHQ/DQpJIGFtIHRyeWluZyB0byBz
dXBwb3J0IGZvciBoZG1pIGF1ZGlvIGZlYXR1cmUgb24gY29tbXVuaXR5IGRyaXZlciBkcml2ZXJz
L2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzLy4NCkkgdGhpbmsgdGhlIGZlYXR1cmUgbWF5IHRha2Ug
c29tZSB0aW1lIGJlY2F1c2UgSSBhbSBub3QgYXVkaW8gZHJpdmVyIG93bmVyLiBJIG9ubHkgd2Fu
dCB0byB1cGRhdGUgdGhlIG90aGVycyBwYXRjaCBhcyBzb29uIGFzIHBvc3NpYmxlLCBzbyBJIHNl
bmQgdGhlIHBhdGNoIHY1LiBJIGFtIGFsc28gc29sdmluZyB0aGUgdGhyZWFkIHBhdGNoZXMgcHJv
cGVybHkuDQpCUg0KSm95IFpvdQ0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
