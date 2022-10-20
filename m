Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA65C605C1C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJTKVU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJTKUh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 06:20:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818D80513;
        Thu, 20 Oct 2022 03:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElT5LnrkhkJ9FE7RPJBihvzEGSJJlYUa+1+obyntYlNo1l88a5LAmTp2xNHNISx+5rXmgLU1F6jCABNE+0rIQfHNIBzzPJeh8qzKfMNPWohIu3W0UaTIfRDfp4j+1Hp+JxmYA9gD6+XcV48ATe79oAmVwouYYk91OTiSrC/bqQkVeDaq6RL1BywnXJMjYDu9Z6wOSviLIf+1gHWvGjUu+IFD04Hpa1Fg9ShtoeI4Lvk9PrUzEWBKJVCaeCJByuTTNqgKICE7nYZA4yv603qQnO6QJ9Husln1NINhGQ53RvON4EvULhbTvvVvFhYYPbWKakDhy+vkkPVrbT/kOJuZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eodU7E2maER1+H4yvFnrYG/yKMkUsPKXcm+Gg/fpLjo=;
 b=l6yfK/1KN3/S7/3x5Bpc/wKiFsOt9lVxDI701FPm2SqcOnKwqTfrL6CvSnPoSWA42FXros4xZ8e3xL/NW8CJfKpENkeGwDw2gmhJF2zDRnMUe01s/wZ0lMOtQ+f1TGgTDGnDrrEq/6JN49+9QPtAg50GBed2Bh8lQoza7s19j8ruQUjPWBtPlu6+h2G5q23Hj/cVZumOEiZmLZD+JxR5m+cAreDrTQjohcBkM+b/ey85SRnvLvwRCNLNGF4U/pfbz8zxaL9CJPQBKlH+653WG+Go3IkCBq6p3TEkCiRZ3qaoeIvLzla4hdmWWs54rsozwzHq5IGqJMvPDcr+pZLFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eodU7E2maER1+H4yvFnrYG/yKMkUsPKXcm+Gg/fpLjo=;
 b=MNrGxdVLnpdgCueFff+QhAyTh1uFuHqjHimQgkTylkHkDXUqPceC/qpshswmMi8wgwglUcrzECISVAtkSl+Xq8gZzpNWcobwwpOcKzB7Ep+QxS0QWvPDo1VrRNgYU/DrofWRcnCzrctItwdoICFEqJS2IxE2cAU/4g1ka2NHArA=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 10:19:55 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 10:19:54 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
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
Subject: RE: [EXT] Re: [PATCH v6 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Topic: [EXT] Re: [PATCH v6 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Index: AQHYwdXKtDB/LdvwzEuo2/pm8/aqza4WCXCAgAEHq7A=
Date:   Thu, 20 Oct 2022 10:19:54 +0000
Message-ID: <AM6PR04MB5925A75D013D9BB854BA03FEE12A9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220906094256.3787384-1-joy.zou@nxp.com>
 <20220906094256.3787384-3-joy.zou@nxp.com> <Y1AIte+S1sHw2qju@matsya>
In-Reply-To: <Y1AIte+S1sHw2qju@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|PAXPR04MB8476:EE_
x-ms-office365-filtering-correlation-id: 83471c52-2ace-4868-c4bf-08dab284a1eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oI4p5KQMjaxhxFR922637nmFc1EX0wom5yGz8D9tlIsYPxeMvPGwqCZcz/yeXEcRawrG3nZsIXaZdRNGi1D8lVubKEgBVhybCjZHLYEiyh0L9EYOhf5iPDND5REYtRRbaNCOjo/qqC2RW02AjDoMO9yDkw1+MVn00pUquQqpOrmrhdcftCGFHQS/K4iLeNVRuutLQrJREliVO2/TeeJDWM7IRZW/WrdpzaVwLbTPlUKBQ/RmLJ6tVdVUejFgBXCVIm5wbYrntlnTmPmJyG1hM2uMdRCHkD5mk1Wl2eqZOa/OOFSlBqvypaDqgv1/RcttiTryY4mOheu1Il7KZa55dbilpPuMTQkxFoC4qxxbgQRLkWfACluIljZg/H3eye1r1DAP8mm1rZoPfv3hXPodHTHY2i5ujC2lzpuFRbH8WBehPIex7NyE6QEqMX2nb8M1CcTN+AEBBwu9zW7wEChXA2PAEAMyqJKtyolPOzObISHlDi0nGbuZhDSpEmYIomwzLWNLsDB9yTMg4NL1lnVuQIA4x3YPoAPxj62lbWD6wvnqbyU8B6MqwZLy8XGlGnR/mObxGaxr5lyMp+SsXQChKRselJCdp5pk5EnL6IInCyclfyqJw/aYgOR5cC1I3DzHGisvjFZ1iWvcO3U6/8lYJF4LX2IjRm0vC4dhsCUfXC2xwaP+B5SnP9/W/YJWAwUE6zT4OWD6HM+asjQXWPAF+6agr+gE3S54DVsTz7l+dkyr1rXYQU+03rlwHDm6fm3SBrTdghdo6OHmARm6+0pJ2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(54906003)(186003)(44832011)(38070700005)(83380400001)(7416002)(86362001)(71200400001)(5660300002)(122000001)(2906002)(38100700002)(478600001)(53546011)(8936002)(4326008)(55016003)(52536014)(64756008)(8676002)(41300700001)(6506007)(7696005)(316002)(9686003)(66476007)(76116006)(26005)(66556008)(66446008)(66946007)(6916009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RHBaLzhzcEJ3amYxL2x6d2RtWGZWT0p3cmx3LytzbTkzR3hrakg2TFMyWW8r?=
 =?gb2312?B?Z2VJVW9KWGUzdHBtbmlWSEViaFhKSURJekFRMVhNVWEyTjNuM2hoQlpzN3FS?=
 =?gb2312?B?ejVVNU5RN2F1S2dHWmlNK3N3VEI4OUFZb0FvNXZhb3hBNWIwdUJtdDZVc0Y3?=
 =?gb2312?B?aFZJNXZLT3NRNFNUdEJ5Q1YxY05yUDVmMllFd3Z4UFhydGxQQW1QQVpsUmgy?=
 =?gb2312?B?WFdFTzF1dXFxMHJYWiswNjBNOTdnNUhnQTVSWDdJREhDMGFWNWd4ZUZEdHk4?=
 =?gb2312?B?cEUyeStkc0FmT211N0VxQmdwTGVKb3VMQ0p5cjlrcmZSQXNodG14aTluTzFl?=
 =?gb2312?B?ZmhoZVRIMEwyZzlaZjl1UHFIL2I0aWtSWnB3U29LQVFuZ01PUkZjK1NYN1RD?=
 =?gb2312?B?R2QxVzRSQ0lBNjltejVtSGRERktWQWphc1dkRExPMm5LS1JsZGZraHgwemNX?=
 =?gb2312?B?YjlPQWRaWWFlVHpiQVRlSFJIRkEzaHZjbXcrK0FhT3pkQkE1VG41YVZsa0I2?=
 =?gb2312?B?NmV1V281STh0T3FjZnQzV3NjU2grUkFlNWhFV2x5STBoV25RdE4zMEJIb0Jl?=
 =?gb2312?B?Smk0QkxqVUNkOHRVSUZydWRvVUN5Y3UyVDZQNGw5VTBGTDFaQUdLTEQ1MmlY?=
 =?gb2312?B?Mjh1MVp4clN2RXRhUXR1S0pJRk92VUF0cnVyWFAybEpsRkJWQU8vMFkxKzl5?=
 =?gb2312?B?YTl6OFVWWWI5Vml0SXVtQWtDYmZvbC9tNkwrK3M4YVBuL2hEZjFNTlVoZkRJ?=
 =?gb2312?B?YVkwNkVMbnNMS3FtWDZtR0FhaDBZUE9BbE5LL3RnaXplMTFjRWlJL0pwcFNi?=
 =?gb2312?B?a2JkcnRvUGhDK21ZS3JYcERHc09DNjdvbVpveVVKMmhaTU0vUk1NOUl2YjJo?=
 =?gb2312?B?RXlmTjlaeUpJT2RCTE5sZGlRVUdoSzJFVXhCWEJOdUwzOU5hSDRCR2llQzZz?=
 =?gb2312?B?eVNxMDZzdEZuZ1E2RDE3bHNjUDd4SkRVN1B3OUZpNHJvMUJwb0ZiMkhQZVpB?=
 =?gb2312?B?dFdwVnFVNk5iTXdLM1o2clRSeFA1ZkYzcnBRalVJcHRFeDdNZ3hNc1NVQld0?=
 =?gb2312?B?VE5RVVpub1lnalVxU3FEcUtaTTdWczBVYWZ1eCtITmRzMklVNFliNUVCOGNv?=
 =?gb2312?B?dnNMeUwrWjdpU0ZBeTdoNnlwTjk3UEE5UjRpTTA4QjlvL3FlUVVVRkM5YnNE?=
 =?gb2312?B?am1aZ1RYSCtnR1loN0dRRzRHUmhZMEdpWTBtQVBmR1ptcTJ2c3RvM3ZWdmgv?=
 =?gb2312?B?ZGs3KzhpZC9FZyt0VE9ydStXUzBpVVZZMFlNR1oyKzRmS2lJM2p6My9mU0N5?=
 =?gb2312?B?OEorNHRuaGNkc1VjK2swTU8rdEh4SHN0R21wMmZTSjVOM2tSeW40TmZUNGRY?=
 =?gb2312?B?QnIzNEMvOTZqaGU0aEZUZ05vRXJTRmRuZ2lBOURhM0RBN0pFenUyL2VVelJT?=
 =?gb2312?B?SldPSHBJWlBMbXYxZTVmclFXY1U2NmdMTk5xSVYwYy84UkZ0Mi8wVDJmYjVI?=
 =?gb2312?B?WmxIRzcwTDY2VUFqdmw2NkZXVVJlVG1GaHYyY0Yvc0tjS3Rkbi9sZFJiQjF1?=
 =?gb2312?B?QjVWTnhvUTlBYllTSzBBZHdtN3lGK0pTcUU1aEQ3cTFDUTJpcTF0MFAvbjhB?=
 =?gb2312?B?ZjZ6UzA4NkxrT3pSVDNhazRhcWYrRUdTYnJpWk5QTkJiNmNBdGdzOXJiWW5B?=
 =?gb2312?B?TDNsdXFGNTM1cFdoNXZJTEU4MVVqMUJ5NUI0TjkwZWY5bGRkZXFVR25GT3NC?=
 =?gb2312?B?KytJVE1SdzM3M2NPOGdIOHcvYkM5bUZWOUJFbE1rL0RSVWhGZlZ4aHhXQTFl?=
 =?gb2312?B?ZzUyQUloSy94cThqa3B1UXNFcGdSQ1hYcitkcTRpalZpVXhkVFUybjkveFFr?=
 =?gb2312?B?Y1pnc2JFOHdTaXdVVVBtb3Q0UG9NU0pvSURoZU5LNHhWaFp1TktHd0NBMmNV?=
 =?gb2312?B?M2phbWVRTjYwMDZneUE2M3VxLzEvdjRodUNBRldUS1RPS1QxWXZ3YlFXelRq?=
 =?gb2312?B?d1BLVGlZZ0FWOHUzVDFCM2FSbllpMUV0UzBrV2ppZHkrVVhOQjkxdUxYUmht?=
 =?gb2312?B?Y25paUF3bVVxaENleWM5K2tmNFVvZ0t0R29DRXl6NlhHRXJ0OE9qUnY3M3RP?=
 =?gb2312?Q?4xtQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83471c52-2ace-4868-c4bf-08dab284a1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 10:19:54.7731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB6KoiY4WRWIdlXotfkegeYb2ZrOJ7fyJf8I2wNziJewja8auE2xiCZW/b3vzQlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jEw1MIxOcjVIDIyOjI1DQo+IFRvOiBKb3kgWm91
IDxqb3kuem91QG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5j
b207IFMuSi4gV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPjsNCj4gbWFydGlua0Bwb3N0ZW8u
ZGU7IGRldkBseW54ZXllLmRlOyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOw0KPiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IGRhdmlkQGl4aXQuY3o7IGFmb3JkMTczQGdtYWls
LmNvbTsNCj4gSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0ggdjYgMi80XSBkbWFlbmdpbmU6IGlteC1zZG1hOiBzdXBwb3J0IGhkbWkgYXVkaW8N
Cj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMDYtMDktMjIsIDE3OjQyLCBKb3kg
Wm91IHdyb3RlOg0KPiA+IEFkZCBoZG1pIGF1ZGlvIHN1cHBvcnQgaW4gc2RtYS4NCj4gDQo+IFBs
cyBhZGQgZGVzY3JpcHRpb24gaW4gY2hhbmdlbG9nIGFib3V0IHdoYXQgaXQgdGFrZXMgdG8gZW5h
YmxlZCBoZG1pIChjeWNsaWMNCj4gc3VwcG9ydCBldGMpDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZv
ciB5b3VyIGNvbW1lbnRzLg0KSSBoYXZlIGNoYW5nZWQgY29tbWl0IG1lc3NhZ2UgaW4gcGF0Y2gg
djcuDQpCUg0KSm95IFpvdQ0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpveSBab3UgPGpv
eS56b3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kbWEvaW14LXNkbWEuYyAgICAg
IHwgMzgNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiA+ICBpbmNs
dWRlL2xpbnV4L2RtYS9pbXgtZG1hLmggfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzEg
aW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBpbmRleA0KPiA+IGZi
ZWE1ZjYyZGQ5OC4uYWI4NzdjZWVhYzNmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2lt
eC1zZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+ID4gQEAgLTk1NCw3
ICs5NTQsMTAgQEAgc3RhdGljIGlycXJldHVybl90IHNkbWFfaW50X2hhbmRsZXIoaW50IGlycSwg
dm9pZA0KPiAqZGV2X2lkKQ0KPiA+ICAgICAgICAgICAgICAgZGVzYyA9IHNkbWFjLT5kZXNjOw0K
PiA+ICAgICAgICAgICAgICAgaWYgKGRlc2MpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHNkbWFjLT5mbGFncyAmIElNWF9ETUFfU0dfTE9PUCkgew0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNkbWFfdXBkYXRlX2NoYW5uZWxfbG9vcChzZG1hYyk7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNkbWFjLT5wZXJpcGhlcmFsX3R5cGUgIT0N
Cj4gSU1YX0RNQVRZUEVfSERNSSkNCj4gPiArDQo+IHNkbWFfdXBkYXRlX2NoYW5uZWxfbG9vcChz
ZG1hYyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsNCj4g
PiArIHZjaGFuX2N5Y2xpY19jYWxsYmFjaygmZGVzYy0+dmQpOw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICB9IGVsc2Ugew0KPiA+DQo+IG14Y19zZG1hX2hhbmRsZV9jaGFubmVsX25vcm1hbChz
ZG1hYyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmNoYW5fY29va2llX2Nv
bXBsZXRlKCZkZXNjLT52ZCk7DQo+IEBADQo+ID4gLTEwNzQsNiArMTA3NywxMCBAQCBzdGF0aWMg
aW50IHNkbWFfZ2V0X3BjKHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjLA0KPiA+ICAgICAgICAg
ICAgICAgcGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5zYWlfMl9tY3VfYWRkcjsNCj4g
PiAgICAgICAgICAgICAgIGVtaV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+bWN1XzJfc2Fp
X2FkZHI7DQo+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICBjYXNlIElNWF9ETUFU
WVBFX0hETUk6DQo+ID4gKyAgICAgICAgICAgICBlbWlfMl9wZXIgPSBzZG1hLT5zY3JpcHRfYWRk
cnMtPmhkbWlfZG1hX2FkZHI7DQo+ID4gKyAgICAgICAgICAgICBzZG1hYy0+aXNfcmFtX3Njcmlw
dCA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICBkZWZhdWx0Og0K
PiA+ICAgICAgICAgICAgICAgZGV2X2VycihzZG1hLT5kZXYsICJVbnN1cHBvcnRlZCB0cmFuc2Zl
ciB0eXBlICVkXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBwZXJpcGhlcmFsX3R5cGUp
OyBAQCAtMTEyNSwxMSArMTEzMiwxNiBAQA0KPiBzdGF0aWMNCj4gPiBpbnQgc2RtYV9sb2FkX2Nv
bnRleHQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMpDQo+ID4gICAgICAgLyogU2VuZCBieSBj
b250ZXh0IHRoZSBldmVudCBtYXNrLGJhc2UgYWRkcmVzcyBmb3IgcGVyaXBoZXJhbA0KPiA+ICAg
ICAgICAqIGFuZCB3YXRlcm1hcmsgbGV2ZWwNCj4gPiAgICAgICAgKi8NCj4gPiAtICAgICBjb250
ZXh0LT5nUmVnWzBdID0gc2RtYWMtPmV2ZW50X21hc2tbMV07DQo+ID4gLSAgICAgY29udGV4dC0+
Z1JlZ1sxXSA9IHNkbWFjLT5ldmVudF9tYXNrWzBdOw0KPiA+IC0gICAgIGNvbnRleHQtPmdSZWdb
Ml0gPSBzZG1hYy0+cGVyX2FkZHI7DQo+ID4gLSAgICAgY29udGV4dC0+Z1JlZ1s2XSA9IHNkbWFj
LT5zaHBfYWRkcjsNCj4gPiAtICAgICBjb250ZXh0LT5nUmVnWzddID0gc2RtYWMtPndhdGVybWFy
a19sZXZlbDsNCj4gPiArICAgICBpZiAoc2RtYWMtPnBlcmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1B
VFlQRV9IRE1JKSB7DQo+ID4gKyAgICAgICAgICAgICBjb250ZXh0LT5nUmVnWzRdID0gc2RtYWMt
PnBlcl9hZGRyOw0KPiA+ICsgICAgICAgICAgICAgY29udGV4dC0+Z1JlZ1s2XSA9IHNkbWFjLT5z
aHBfYWRkcjsNCj4gPiArICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgY29udGV4dC0+
Z1JlZ1swXSA9IHNkbWFjLT5ldmVudF9tYXNrWzFdOw0KPiA+ICsgICAgICAgICAgICAgY29udGV4
dC0+Z1JlZ1sxXSA9IHNkbWFjLT5ldmVudF9tYXNrWzBdOw0KPiA+ICsgICAgICAgICAgICAgY29u
dGV4dC0+Z1JlZ1syXSA9IHNkbWFjLT5wZXJfYWRkcjsNCj4gPiArICAgICAgICAgICAgIGNvbnRl
eHQtPmdSZWdbNl0gPSBzZG1hYy0+c2hwX2FkZHI7DQo+ID4gKyAgICAgICAgICAgICBjb250ZXh0
LT5nUmVnWzddID0gc2RtYWMtPndhdGVybWFya19sZXZlbDsNCj4gPiArICAgICB9DQo+ID4NCj4g
PiAgICAgICBiZDAtPm1vZGUuY29tbWFuZCA9IEMwX1NFVERNOw0KPiA+ICAgICAgIGJkMC0+bW9k
ZS5zdGF0dXMgPSBCRF9ET05FIHwgQkRfV1JBUCB8IEJEX0VYVEQ7IEBAIC0xNTEzLDcNCj4gPiAr
MTUyNSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RtYV9kZXNjICpzZG1hX3RyYW5zZmVyX2luaXQoc3Ry
dWN0DQo+IHNkbWFfY2hhbm5lbCAqc2RtYWMsDQo+ID4gICAgICAgZGVzYy0+c2RtYWMgPSBzZG1h
YzsNCj4gPiAgICAgICBkZXNjLT5udW1fYmQgPSBiZHM7DQo+ID4NCj4gPiAtICAgICBpZiAoc2Rt
YV9hbGxvY19iZChkZXNjKSkNCj4gPiArICAgICBpZiAoYmRzICYmIHNkbWFfYWxsb2NfYmQoZGVz
YykpDQo+ID4gICAgICAgICAgICAgICBnb3RvIGVycl9kZXNjX291dDsNCj4gPg0KPiA+ICAgICAg
IC8qIE5vIHNsYXZlX2NvbmZpZyBjYWxsZWQgaW4gTUVNQ1BZIGNhc2UsIHNvIGRvIGhlcmUgKi8g
QEANCj4gPiAtMTY3OCwxMyArMTY5MCwxNiBAQCBzdGF0aWMgc3RydWN0IGRtYV9hc3luY190eF9k
ZXNjcmlwdG9yDQo+ID4gKnNkbWFfcHJlcF9kbWFfY3ljbGljKCAgew0KPiA+ICAgICAgIHN0cnVj
dCBzZG1hX2NoYW5uZWwgKnNkbWFjID0gdG9fc2RtYV9jaGFuKGNoYW4pOw0KPiA+ICAgICAgIHN0
cnVjdCBzZG1hX2VuZ2luZSAqc2RtYSA9IHNkbWFjLT5zZG1hOw0KPiA+IC0gICAgIGludCBudW1f
cGVyaW9kcyA9IGJ1Zl9sZW4gLyBwZXJpb2RfbGVuOw0KPiA+ICsgICAgIGludCBudW1fcGVyaW9k
cyA9IDA7DQo+ID4gICAgICAgaW50IGNoYW5uZWwgPSBzZG1hYy0+Y2hhbm5lbDsNCj4gPiAgICAg
ICBpbnQgaSA9IDAsIGJ1ZiA9IDA7DQo+ID4gICAgICAgc3RydWN0IHNkbWFfZGVzYyAqZGVzYzsN
Cj4gPg0KPiA+ICAgICAgIGRldl9kYmcoc2RtYS0+ZGV2LCAiJXMgY2hhbm5lbDogJWRcbiIsIF9f
ZnVuY19fLCBjaGFubmVsKTsNCj4gPg0KPiA+ICsgICAgIGlmIChzZG1hYy0+cGVyaXBoZXJhbF90
eXBlICE9IElNWF9ETUFUWVBFX0hETUkpDQo+ID4gKyAgICAgICAgICAgICBudW1fcGVyaW9kcyA9
IGJ1Zl9sZW4gLyBwZXJpb2RfbGVuOw0KPiA+ICsNCj4gPiAgICAgICBzZG1hX2NvbmZpZ193cml0
ZShjaGFuLCAmc2RtYWMtPnNsYXZlX2NvbmZpZywgZGlyZWN0aW9uKTsNCj4gPg0KPiA+ICAgICAg
IGRlc2MgPSBzZG1hX3RyYW5zZmVyX2luaXQoc2RtYWMsIGRpcmVjdGlvbiwgbnVtX3BlcmlvZHMp
OyBAQA0KPiA+IC0xNzAxLDYgKzE3MTYsOSBAQCBzdGF0aWMgc3RydWN0IGRtYV9hc3luY190eF9k
ZXNjcmlwdG9yDQo+ICpzZG1hX3ByZXBfZG1hX2N5Y2xpYygNCj4gPiAgICAgICAgICAgICAgIGdv
dG8gZXJyX2JkX291dDsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAgICBpZiAoc2RtYWMtPnBl
cmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1BVFlQRV9IRE1JKQ0KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIHZjaGFuX3R4X3ByZXAoJnNkbWFjLT52YywgJmRlc2MtPnZkLCBmbGFncyk7DQo+ID4gKw0K
PiA+ICAgICAgIHdoaWxlIChidWYgPCBidWZfbGVuKSB7DQo+ID4gICAgICAgICAgICAgICBzdHJ1
Y3Qgc2RtYV9idWZmZXJfZGVzY3JpcHRvciAqYmQgPSAmZGVzYy0+YmRbaV07DQo+ID4gICAgICAg
ICAgICAgICBpbnQgcGFyYW07DQo+ID4gQEAgLTE3NjEsNiArMTc3OSwxMCBAQCBzdGF0aWMgaW50
IHNkbWFfY29uZmlnX3dyaXRlKHN0cnVjdCBkbWFfY2hhbg0KPiAqY2hhbiwNCj4gPiAgICAgICAg
ICAgICAgIHNkbWFjLT53YXRlcm1hcmtfbGV2ZWwgfD0gKGRtYWVuZ2luZV9jZmctPmRzdF9tYXhi
dXJzdA0KPiA8PCAxNikgJg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBTRE1BX1dBVEVSTUFS
S19MRVZFTF9IV01MOw0KPiA+ICAgICAgICAgICAgICAgc2RtYWMtPndvcmRfc2l6ZSA9IGRtYWVu
Z2luZV9jZmctPmRzdF9hZGRyX3dpZHRoOw0KPiA+ICsgICAgIH0gZWxzZSBpZiAoc2RtYWMtPnBl
cmlwaGVyYWxfdHlwZSA9PSBJTVhfRE1BVFlQRV9IRE1JKSB7DQo+ID4gKyAgICAgICAgICAgICBz
ZG1hYy0+cGVyX2FkZHJlc3MgPSBkbWFlbmdpbmVfY2ZnLT5kc3RfYWRkcjsNCj4gPiArICAgICAg
ICAgICAgIHNkbWFjLT5wZXJfYWRkcmVzczIgPSBkbWFlbmdpbmVfY2ZnLT5zcmNfYWRkcjsNCj4g
PiArICAgICAgICAgICAgIHNkbWFjLT53YXRlcm1hcmtfbGV2ZWwgPSAwOw0KPiA+ICAgICAgIH0g
ZWxzZSB7DQo+ID4gICAgICAgICAgICAgICBzZG1hYy0+cGVyX2FkZHJlc3MgPSBkbWFlbmdpbmVf
Y2ZnLT5kc3RfYWRkcjsNCj4gPiAgICAgICAgICAgICAgIHNkbWFjLT53YXRlcm1hcmtfbGV2ZWwg
PSBkbWFlbmdpbmVfY2ZnLT5kc3RfbWF4YnVyc3QgKg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2RtYS9pbXgtZG1hLmggYi9pbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmgNCj4gPiBp
bmRleCBmNDg3YTRmYTEwM2EuLmNmZWM1Zjk0NmUyMyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2RtYS9pbXgtZG1hLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1h
LmgNCj4gPiBAQCAtNDAsNiArNDAsNyBAQCBlbnVtIHNkbWFfcGVyaXBoZXJhbF90eXBlIHsNCj4g
PiAgICAgICBJTVhfRE1BVFlQRV9BU1JDX1NQLCAgICAvKiBTaGFyZWQgQVNSQyAqLw0KPiA+ICAg
ICAgIElNWF9ETUFUWVBFX1NBSSwgICAgICAgIC8qIFNBSSAqLw0KPiA+ICAgICAgIElNWF9ETUFU
WVBFX01VTFRJX1NBSSwgIC8qIE1VTFRJIEZJRk9zIEZvciBBdWRpbyAqLw0KPiA+ICsgICAgIElN
WF9ETUFUWVBFX0hETUksICAgICAgIC8qIEhETUkgQXVkaW8gKi8NCj4gPiAgfTsNCj4gPg0KPiA+
ICBlbnVtIGlteF9kbWFfcHJpbyB7DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gDQo+IC0tDQo+IH5W
aW5vZA0K
