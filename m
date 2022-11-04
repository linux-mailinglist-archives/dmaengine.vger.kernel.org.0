Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130F8618FDE
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 06:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKDFKc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 01:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiKDFK1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 01:10:27 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63A27FEE;
        Thu,  3 Nov 2022 22:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHmRVXV/ydGyTkiHQu6pTmwiTwzczqtMTNZKRB7leLekVDQJuMk7pwRgeYrO+Dymit+/wFjEi1F+/sHe80r0vf54G9sc6raDO1meAPDjk64K/9IgpL2MtJ0oX1I73KK0muL1RXX6KHp1mpczfKmgjS1tpBtJuT/HQBJUuRbXoxPgzWsRqQavw0ku39namBD/53cV7HbZvqt358f6yQT3+3Gifgovnn1xyn7VdM83a2b5f/aRjZju/Hz84DIh2a1EyiMlw6qLLW3ePp6WO70BF2M7RQqDWD9AD/kBFLNnlNxcdUMyHvizCKqOqi7WTq9RZYLTAfk3FFMAyPtNLkTe6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzRHVUGnIw7FVaymkwchwZpkMMCp+baZKMiuP4fd5wU=;
 b=TmJSjfc6Xr1KJp54Oh8zMrp4hvaebBdazej6DvJTZPNr4t17JP7e1MknDOmj9cXC6dq/FllRevCpM/RBIDDg3tThCthZ1DZa1nIwAznF6J0Qgrgze1l4X/20Ke/rnxiiXsHawY3nY1505UFm0qmH7WSI78teYa8O1gRYGmTYIMNjyCv/iBg1Fx/LVIETnD4wQseN4vPrCZ12z2S369OOGDCvwc36UShRtUK4zW66ZgfMQZhjM0u1YWozAM0RAJQH54te9MVJs6ZQ4WP8GJh38EsGtZHukABk3mlOMEeHthHCEqjwbEy2RBMRzoxHtSMIfJ+pUAofBFrZalcZ6Ogl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzRHVUGnIw7FVaymkwchwZpkMMCp+baZKMiuP4fd5wU=;
 b=KrresTzdFJB1BZO4wLvkNg7Mw4cdPxAD/FvNVBChj2t3uDqZi7kS4/e7meXbogNsSqlQde9bi8hXWPM3uUYkXarjrhK8Y/e5GKO4/DSfvlprJWrDjed3DD9zw+W1nkidDAIXfX4nem4gfujnZfimg45sMKH1oPlgg3PAU23DoM0=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DU0PR04MB9396.eurprd04.prod.outlook.com (2603:10a6:10:35b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 05:10:22 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 05:10:22 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>, "david@ixit.cz" <david@ixit.cz>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v9 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Topic: [EXT] Re: [PATCH v9 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Index: AQHY7RZqQdLbizwgCUCgFNOXSUSr3q4tPTcAgADrGBA=
Date:   Fri, 4 Nov 2022 05:10:22 +0000
Message-ID: <AM6PR04MB5925DADA3EB1F118680698C5E13B9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20221031105028.598502-1-joy.zou@nxp.com>
 <20221031105028.598502-2-joy.zou@nxp.com>
 <a73e76b9-f186-a818-713b-3c14033f27cb@linaro.org>
In-Reply-To: <a73e76b9-f186-a818-713b-3c14033f27cb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|DU0PR04MB9396:EE_
x-ms-office365-filtering-correlation-id: faece0d8-230c-44be-9825-08dabe22e02b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oizDlZQDJ4TTSf3n5lilAP8KKy9VOSugde/ZOOTsRvji4mYhdZ6QWZr9d4F2eJ69u0FXeQFX8x348jNN1eSXPWLQOoJPkqjIR6u6G3MZDFpaA/iaZehqTU5nasTmS8oc7N04boUJ8aA/axKIGtAn78BlC061t/7Hm/2mnoQuW7CRoi5QM0IZ0FIk/mpQtGnUrfdWVeePNCwDkEb59yvUBMDBpPdTW9y8nGcXCJw0Dlg+C5gc8N0nwTWPAnImDan1LcRA4sDBoaBTMrPPVxZ1OyVPoDfZtgBFBplMQXkb99+xefkdWDr+A7bbzWBYAmKmgRVVA9Xg5o6wFMP8Pl/Y4WlGTgCigas7EBcfRrEWRXA9bec6vXk5YqVryrcOnRVePUop1r5RUG5mkjy5MUZ8dROfXEjyVtHAZAa1vGYF7pmWciPPbaNOcgrF+iKWdWMIWVfxf8aIlcrwvzsElQG+NKUTsLKdSRwz5eCrWEDhGasCwqv1ur2cRZfvmuDOtLbk6A00vU5xt0SOBL1LUCY7HJGS+fBefldwN5SWQQjLd29CCAtKiaDrYCqFUcfJ5tyfa9xGbQuzu8NrPNdYiHdatCtb0XX06/1ovuRso1xPDjwCSircwzGeUcG6qT1pVTAQ8mSpzfnGxN6Mau86dbd6YX+dtMJgsykF6v9djBOIVNt/Fx4ig6q7qcNTIOcWWEeQKt0R5Muz6Ih/Xdn1/tydBWlU1foqBq55OJZeW/GSt71+mnnswXeCOVFAlUWNJhmr6Vguq7TA+L/JJg9og8wyRh0rwoq5BJc00RpYm3VcgvU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(55016003)(122000001)(33656002)(83380400001)(38070700005)(38100700002)(86362001)(45080400002)(6506007)(478600001)(76116006)(316002)(66946007)(8676002)(44832011)(8936002)(110136005)(54906003)(2906002)(52536014)(5660300002)(7416002)(7696005)(66556008)(64756008)(26005)(53546011)(66446008)(4326008)(9686003)(71200400001)(186003)(41300700001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RzZUOEpPZEZ2Sys5RGZmR3V2Lzlva29NWC9EMzYrK0UyQnkwWjRkUUF2Skg0?=
 =?gb2312?B?REswUmhWdE9KV1R6MVQzd2IzV2x1emo1Sm9NTWxnU1QxV0tCV21tcnJxWkY0?=
 =?gb2312?B?K1NOWE9ydUdIRk5DbVpYc2ZCQkdOcUQ2NmZhTFdOUWJ0ejZCWVkxMS9JNE9B?=
 =?gb2312?B?TzVkbU9mMUwrbFpOVnQxY01RUDBXdDZlWGdqY1ljQXpsZlF5OTE0b0FJV1JX?=
 =?gb2312?B?bUJCckhVQXpxaEJGTERFRlVKQ1lReHFJQmtMZmF5akRWblNuWkFiTE9wT1pS?=
 =?gb2312?B?bUplNElEVTdMQi9HN2Vienhuejd2cTZzaG80bjlaaEM0MlNBVmVoOExNVUFh?=
 =?gb2312?B?M29zZDNubXlxQXZiaTVkUkoveEZNQjgyMXFJRlZqdDZvQU9zMmZ1UUR4R0h1?=
 =?gb2312?B?NXBkSzhhY0xJd09BckthSmdBVThqQ1NuTk11MDE5WXRiTkg4ekgraGkrcytG?=
 =?gb2312?B?NWQzVXoyVWZzRzU0YkpxZXQ5bFB4djc0YWJ4aE8yeVhIYk1qRW0zRnRUS0NP?=
 =?gb2312?B?WnhwdnNrMjc5eWoySEhmUmJEbmFvdDN2b1JXbFVzSXdZM2h6bnllYlRXQVJw?=
 =?gb2312?B?U1hFQUVMVWVrSHZPTDc1UWp6MnlKTldUczh1LzdZZHVHQmtxdU9lbVkzbjY4?=
 =?gb2312?B?UXdEbGVRaEZSSG9CQTk0T0luQWp0TnIyMG02K0U5dmExVlFTTFpybHd3WFhj?=
 =?gb2312?B?OGpmblR3ZHVKNXJUKzdMak1HNm13bHZPN3plN3VFQXBJbWI4dG1tL1lQWks4?=
 =?gb2312?B?alJOdndia1VBblZUQVByZ1FGUGVXQ01QRzd3N0hTWEthQ2hqVThLWWpidVdk?=
 =?gb2312?B?YVBZZHQ2YWpmRUd5UU5GeWZ3UXlSOE83RnZQWEt6OFpkSlBQalhkenFscEFk?=
 =?gb2312?B?K1QyOG56ekZOc3crd2dBQVk2SG5PdnNQa25Lb29tZ2kwOGJ5UTJRaHpkYS9q?=
 =?gb2312?B?YjVTUkMvcjFhZE9Bb0xuaG1KUmNVZzRuUHZyK2pQczg2bFVibGQvWlVvRnVV?=
 =?gb2312?B?UjRTclFsdDhWdVdBc0JmY1FSNU1jNU5jUkluaTIxR0pXNUVhQUJHUXlyVEpL?=
 =?gb2312?B?YjZhZmZvQXZ6Q2RReGxoaW9iak5SK25UOXRNT3UrdFMrR0NVcDZYU2RUKzMz?=
 =?gb2312?B?UkEvVlNKOUh3R0Q4RThsc1V5bjk5Y2t0QXJGa3RvcGExanJhUS9admxaUVNr?=
 =?gb2312?B?RHYvZ2RWTmwrVHBwNUdnSGVMSnd0ZlkydjRRQ3R0VlB1SEpBUC9xdzlSaCs4?=
 =?gb2312?B?ZmJXRkExdWJmejc4bXhMVnYrd0oxNTY4Y1dNZUdrMjljMUNFbWtNa0hRR3Rk?=
 =?gb2312?B?QnkyejRIVDFPazJtbE5NQThsbXliQXlKd1pSZktTTWxIUGxicEhnOHhMM2U4?=
 =?gb2312?B?VTY2NmdLZnNIdlJYdmovRFVXQTJPMHZoTWZrSEwvOUpYSmNLNy9na1VpWCtS?=
 =?gb2312?B?MjloMFVTRGVrUEpXUE94c2hMejNzMjdYaGFaMGdCenBjaU4vcWJmNitkWWtT?=
 =?gb2312?B?M2U4Sm9QOU5pSkR3K2E1bHI3NDJxQmg4WFJDVjFXT0FzclBGUkhZQ2g1U3Vx?=
 =?gb2312?B?NjBjYWtmb3o0d3Q0Q3VscWtrNXJRTW1jYi9zYzV2NS9zcXhQOWxIYTFIZ0Fx?=
 =?gb2312?B?OSt0bUpidnVLazUrTFd1ek1nRWU1aFRydWxBVXFjZUdNbXhDZ1Y1eWRwZG5l?=
 =?gb2312?B?VEFoVXRaRTA5aUtqZ2YraDhPbjRiM1NCZ3h0dlNXeDdlbmUyU3VOWDY5MEZ6?=
 =?gb2312?B?dUU0cUJpSDVhUTltanoyNnI2Z21uVXQyOGg4TWFJdmJJTU15b24yOU5xWFBF?=
 =?gb2312?B?VjhRUjlTNFpQeEhpc3psWlk3Mzk5QTZDQXpnOGRVMUtMMDg5T3AvQ2hpajF5?=
 =?gb2312?B?ODBRUG5FTjUvVEJvWEh5TDdEeGcxMU94T2gyYnphTGJpc1Q4WXF1dG15RU5D?=
 =?gb2312?B?bkFKTHhFWW9JVW10VFdhSm1JSWpkN3YyZTZOdXYzVjhOODJST1NKUkRYNjM1?=
 =?gb2312?B?S3M1QldabnJsYm9tYnFTbE5icEVrbTNhZUdYVk4xV0Mwa09UZ1N2UiswQVhG?=
 =?gb2312?B?b0hUM1RDVkhiZm1hTWkvTmVYWGZoUUx6ckUwRllIV2JLQWVyRDV2MC9BUmVx?=
 =?gb2312?Q?UUPo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faece0d8-230c-44be-9825-08dabe22e02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 05:10:22.5309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pg6mqmHlvFnbPtYmoOgJvb3RZwjU1l5v2UozzYnXS142YmWv5Ma+TlmgbMcYCwgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMsTqMTHUwjPI
1SAyMTo1NA0KPiBUbzogSm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgdmtvdWxAa2VybmVsLm9y
Zzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBTLkouIFdhbmcgPHNo
ZW5naml1LndhbmdAbnhwLmNvbT47IG1hcnRpbmtAcG9zdGVvLmRlOw0KPiBkZXZAbHlueGV5ZS5k
ZTsgYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgUGVuZyBGYW4NCj4gPHBlbmcuZmFu
QG54cC5jb20+OyBkYXZpZEBpeGl0LmN6OyBhZm9yZDE3M0BnbWFpbC5jb207IEhvbmd4aW5nIFpo
dQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY5IDEvMl0g
ZHQtYmluZGluZ3M6IGZzbC1pbXgtc2RtYTogQ29udmVydCBpbXggc2RtYQ0KPiB0byBEVCBzY2hl
bWENCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMzEvMTAvMjAyMiAwNjo1MCwg
Sm95IFpvdSB3cm90ZToNCj4gPiBDb252ZXJ0IHRoZSBpLk1YIFNETUEgYmluZGluZyB0byBEVCBz
Y2hlbWEgZm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hLg0KPiA+DQo+ID4gVGhlIGNvbXBhdGlibGVz
IGZzbCxpbXgzMS10bzEtc2RtYSwgZnNsLGlteDMxLXRvMi1zZG1hLA0KPiA+IGZzbCxpbXgzNS10
bzEtc2RtYSBhbmQgZnNsLGlteDM1LXRvMi1zZG1hIGFyZSBub3QgdXNlZC4gU28gbmVlZCB0bw0K
PiA+IGRlbGV0ZSBpdC4gVGhlIGNvbXBhdGlibGVzIGZzbCxpbXg1MC1zZG1hLCBmc2wsaW14NnNs
bC1zZG1hIGFuZA0KPiA+IGZzbCxpbXg2c2wtc2RtYSBhcmUgYWRkZWQuIFRoZSBvcmlnaW5hbCBi
aW5kaW5nIGRvbid0IGxpc3QgYWxsIGNvbXBhdGlibGUgdXNlZC4NCj4gPg0KPiA+IEluIGFkZGl0
aW9uLCBhZGQgbmV3IHBlcmlwaGVyYWwgdHlwZXMgSERNSSBBdWRpby4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2Vz
IGluIHY5Og0KPiA+IGFkZCB0aGUgZG1hLWNvbW1vbiBxdW90ZXMuDQo+ID4gZGVsZXRlIHRoZSBk
bWEtY29udHJvbGxlciBxdW90ZXMuDQo+IA0KPiBJIGhhdmUgbm8gY2x1ZSB3aGF0IHlvdSBhcmUg
ZG9pbmcgaGVyZS4uLiBEbyB5b3Uga25vdyB3aGF0IGFyZSAicXVvdGVzIj8NCj4gSSBsaW5rZWQg
bGFzdCB0aW1lIGV4cGxhbmF0aW9uIG9mICJxdW90ZXMiLCBzbyBkaWQgeW91IHJlYWQgaXQ/DQpU
aGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGNvbW1lbnRzLg0KSSBjb25mdXNlZCBxdW90ZSBh
bmQgcXVvdGVzLiBDb3VsZCBJIGNvbmZpcm0gbXkgdW5kZXJzdGFuZKO/DQpUaGUgcXVvdGUgbWVh
bnMgJHJlZjogPw0KVGhlIHF1b3RlcyBtZWFucyBhIHN5bWJvbCAiPw0KPiANCj4gDQo+ID4NCj4g
PiBDaGFuZ2VzIGluIHY4Og0KPiA+IGFkZCB0aGUgZG1hLWNvbnRyb2xsZXIgcXVvdGVzLg0KPiA+
IGRlbGV0ZSAjZG1hLWNlbGxzIGluIHJlcXVpcmVkLg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2NjoN
Cj4gPiBkZWxldGUgdGFnIEFja2VkLWJ5IGZyb20gY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiBD
aGFuZ2VzIGluIHY1Og0KPiA+IG1vZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2UgZnJvbWF0Lg0KPiA+
IGFkZCBhZGRpdGlvbmFsUHJvcGVydGllcywgYmVjYXVzZSBkZWxldGUgdGhlIHF1b3RlcyBpbiBw
YXRjaCB2NC4NCj4gPiBkZWxldGUgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzIGR1ZSB0byBzaW1pbGFy
IHRvIGFkZGl0aW9uYWxQcm9wZXJ0aWVzLg0KPiA+IG1vZGlmaWNhdGlvbiBmc2wsc2RtYS1ldmVu
dC1yZW1hcCBpdGVtcyBhbmQgZGVzY3JpcHRpb24uDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHY0Og0K
PiA+IG1vZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4gZGVsZXRlIHRoZSBxdW90ZXMgaW4g
cGF0Y2guDQo+ID4gbW9kaWZ5IHRoZSBjb21wYXRpYmxlIGluIHBhdGNoLg0KPiA+IGRlbGV0ZSBt
YXhpdGVtcyBhbmQgYWRkIGl0ZW1zIGZvciBjbG9jay1uYW1lcyBwcm9wZXJ0eS4NCj4gPiBhZGQg
aXJhbSBwcm9wZXJ0eS4NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gbW9kaWZ5IHRoZSBj
b21taXQgbWVzc2FnZS4NCj4gPiBtb2RpZnkgdGhlIGZpbGVuYW1lLg0KPiA+IG1vZGlmeSB0aGUg
bWFpbnRhaW5lci4NCj4gPiBkZWxldGUgdGhlIHVubmVjZXNzYXJ5IGNvbW1lbnQuDQo+ID4gbW9k
aWZ5IHRoZSBjb21wYXRpYmxlIGFuZCBydW4gZHRfYmluZGluZ19jaGVjayBhbmQgZHRic19jaGVj
ay4NCj4gPiBhZGQgY2xvY2tzIGFuZCBjbG9jay1uYW1lcyBwcm9wZXJ0eS4NCj4gPiBkZWxldGUg
dGhlIHJlZyBkZXNjcmlwdGlvbiBhbmQgYWRkIG1heEl0ZW1zLg0KPiA+IGRlbGV0ZSB0aGUgaW50
ZXJydXB0cyBkZXNjcmlwdGlvbiBhbmQgYWRkIG1heEl0ZW1zLg0KPiA+IGFkZCByZWYgZm9yIGdw
ciBwcm9wZXJ0eS4NCj4gPiBtb2RpZnkgdGhlIGZzbCxzZG1hLWV2ZW50LXJlbWFwIHJlZiB0eXBl
IGFuZCBhZGQgaXRlbXMuDQo+ID4gZGVsZXRlIGNvbnN1bWVyIGV4YW1wbGUuDQo+ID4NCj4gPiBD
aGFuZ2VzIGluIHYyOg0KPiA+IGNvbnZlcnQgaW14IHNkbWEgYmluZGluZ3MgdG8gRFQgc2NoZW1h
Lg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLGlteC1zZG1h
LnlhbWwgfCAxNDkNCj4gPiArKysrKysrKysrKysrKysrKysgIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2RtYS9mc2wtaW14LXNkbWEudHh0ICB8DQo+ID4gMTE4IC0tLS0tLS0tLS0tLS0tDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMTQ5IGluc2VydGlvbnMoKyksIDExOCBkZWxldGlvbnMoLSkgIGNy
ZWF0ZSBtb2RlDQo+ID4gMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
bWEvZnNsLGlteC1zZG1hLnlhbWwNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2ws
aW14LXNkbWEueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rt
YS9mc2wsaW14LXNkbWEueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi45NWQwMzkxYTFmMzkNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wsaW14LXNkbWEueWFtbA0K
PiA+IEBAIC0wLDAgKzEsMTQ5IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6
DQo+ID4gK2h0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwJTNBJTJGJTJGZGV2aQ0KPiA+DQo+ICtjZXRyZWUub3JnJTJGc2NoZW1hcyUyRmRtYSUy
RmZzbCUyQ2lteC1zZG1hLnlhbWwlMjMmYW1wO2RhdGE9MDUNCj4gJTdDMDElDQo+ID4NCj4gKzdD
am95LnpvdSU0MG54cC5jb20lN0NkOGY3ODVkMTFhYzA0MmViZDdkOTA4ZGFiZGEyZDc1MyU3QzY4
NmVhDQo+IDFkM2JjMmINCj4gPg0KPiArNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYz
ODAzMDgwNDM0MjEyNDE5MSU3Q1Vua25vd24NCj4gJTdDVFdGcGJHWg0KPiA+DQo+ICtzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk0NCj4gbjAlDQo+ID4NCj4gKzNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9M1hwS1VHdjc1
MW5hJTJCVjRPWURRRXZHUXhlZVQNCj4gNFViVzB3aXpRa00NCj4gPiAreWZ4NGslM0QmYW1wO3Jl
c2VydmVkPTANCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJl
ZS5vcmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2RhdGE9MDUlN0MwMSU3Q2pv
eS56DQo+IG91JTQNCj4gPg0KPiArMG54cC5jb20lN0NkOGY3ODVkMTFhYzA0MmViZDdkOTA4ZGFi
ZGEyZDc1MyU3QzY4NmVhMWQzYmMyYjRjNg0KPiBmYTkyY2Q5OQ0KPiA+DQo+ICtjNWMzMDE2MzUl
N0MwJTdDMCU3QzYzODAzMDgwNDM0MjEyNDE5MSU3Q1Vua25vd24lN0NUV0ZwYkcNCj4gWnNiM2Q4
ZXlKV0lqDQo+ID4NCj4gK29pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsx
aGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMNCj4gMDAwJTcNCj4gPg0KPiArQyU3QyU3QyZhbXA7c2Rh
dGE9bm5CWEs0YyUyRmlBMW5jb2hpYWs0Q1hFUUdicDV1aERxODM1Uks5JTJCDQo+IEJZZEp3JTNE
Jg0KPiA+ICthbXA7cmVzZXJ2ZWQ9MA0KPiA+ICsNCj4gPiArdGl0bGU6IEZyZWVzY2FsZSBTbWFy
dCBEaXJlY3QgTWVtb3J5IEFjY2VzcyAoU0RNQSkgQ29udHJvbGxlciBmb3INCj4gPiAraS5NWA0K
PiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBKb3kgWm91IDxqb3kuem91QG54cC5j
b20+DQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6IGRtYS1jb21tb24ueWFtbCMN
Cj4gDQo+IFRoYXQncyB3cm9uZy4gVGhpcyBzaG91bGQgYmUgZG1hLWNvbnRyb2xsZXIuIFdoeSB0
aGlzIHdhcyBjaGFuZ2VkPw0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBjb21tZW50cy4N
CkkgcmVtZW1iZXIgeW91ciBjb21tZW50cyBpbiBwYXRjaCB2Ni4NCiJUaGUgZGV2aWNlIHNjaGVt
YXMgZG8gbm90IG5lZWQgdG8gZW5mb3JjZSB0aGUgbmFtZS4gVGhlIGRtYS1jb250cm9sbGVyIHNj
aGVtYSBlbmZvcmNlcyBpdCwgc28gd2hhdCBpcyBtaXNzaW5nIGhlcmUgaXMgdG8gcmVmZXJlbmNl
IGl0LiINClNvIEkgY2hhbmdlIGl0Lg0KU2hvdWxkIEkgdXNlIGRtYS1jb250cm9sbGVyPw0KQlIN
CkpveSBab3UNCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
