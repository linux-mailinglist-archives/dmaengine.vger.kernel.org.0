Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ECB5A071D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 04:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiHYCGi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 22:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiHYCGf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 22:06:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEA179A5A;
        Wed, 24 Aug 2022 19:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9dOS4+Mn29sHlqFmjD82x0HdfovPFdqfPTDkcZ3NIap0xq1MwLIamsOGFyFfy24t+6VimPweTeJEjbF+zhbHR6z5kSLq6Irsn1jl8YPIUbnNSpdLO7ceE9KAjxWhZmsgHGcJjOeCx5mLabpHkq12K3QslhrvoNr+Kxa4UZP4pKgC1Qp9WttNouPzxPxfzr7gZtKsWJPWT39oy5qwcLb+1MctJXGf+c9oHECb0XKesuiW4M48mNrHy03hNS5rjZ8stDRVfggTQNRSl4Z+R3FAReB2djBlu7QNqNSfNJuEkKdHkZ5oKsHH/LrUSiGMw6+ZjcXP9QJBC/HPjdsYQAgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2UBZALzZm9CD7tGdu9mWw19sfbL87kkOTdYJpZ7QFc=;
 b=P8sLbs7/biHkuyQ0JBDEiWo0ENaCpqRx70EVjsxwY+lRjIeVQzWHpwXnZkrNwXVMsbB7+YvUVioo+kGMN9H4MBNiQ9gM4jfgnHvqQJincGhmHE1Vk753ZpsHMF72PmNKd/ESqcmHpSdhzzLv4ZB+05I0wJwD3F0CGlCuQZRR7jDNbJMINlnAHPW/qpxsIrVe997etnu0elRXaBlxesrX78CCEv03sYgN7vTlWN+ckeOX2SPaU+pjKMXHhn1wjY9z/ETb/TycviSIgKdfsMWZvXG8400oI5M59hrFVxDGiGrEIciOF3VI98iPjNDXJ/0AJhEEhiklhcYN4W+64LYqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2UBZALzZm9CD7tGdu9mWw19sfbL87kkOTdYJpZ7QFc=;
 b=S14UcKgekxc8kd0JEHUVFtnPf0QPzFZfaFQiWbgK7jqsqyxALlAl5oMjgE4KFG8cunH8yTRvU10SVKnavI2qKq4jgu+2TrjRtuZ8eVe740mjHK2HrTPFYypJlCAxYyn60+Wl7jZR+CLnRbOcWt+p5/K+wta1RpYDfggneUxGMow=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM0PR04MB4289.eurprd04.prod.outlook.com (2603:10a6:208:62::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 02:06:29 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 02:06:29 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: RE: [EXT] Re: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI
 Audio' transfer
Thread-Topic: [EXT] Re: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI
 Audio' transfer
Thread-Index: AQHYb0Sbzg3yRatDsU+sUlyHgY6zya2baFlwgCMCbCCAACKUgIAA4mgA
Date:   Thu, 25 Aug 2022 02:06:29 +0000
Message-ID: <AM6PR04MB5925A518D046AFA66E153B9CE1729@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220524080337.1322240-1-joy.zou@nxp.com>
 <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <AM6PR04MB5925CFC53026A11F57115D1FE1739@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <3237265e-9f1f-d5cf-c37c-ee39bce2eabf@linaro.org>
In-Reply-To: <3237265e-9f1f-d5cf-c37c-ee39bce2eabf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bde98d4c-ca28-4a55-4e02-08da863e6cbc
x-ms-traffictypediagnostic: AM0PR04MB4289:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WcVp1ujABzyZvCyjr/yxg3PqzqsHcedkqbwQCzs5HX3xhyvIXt+aniYznvLrtrRrndu++lMzbMHtg2S9++rpPccQATbu9zPpegzfUf4cT9sv1B621cVSoxNnii4F6ny2OJOKRyD2WC/IUQSV18tVHhPgRNq8pNQHQC5wlTteOeUSvgafRGuc2dTw1vAQN7r84gh2YGqXlds6ztHQJNwzRimnlPaNPad4oBDBj+mr8KJgIw2JHsJ61o7I0NK3PW26T5Ql684L+y/tAfcwImGdIYqL2Q1llxUjvYT6vtL2prOGvc1meieb8twRhzJeUvyMHt2Q0jPjmZyfeNB2WjAi0i24sQ6qtgmSYH5uHIYSqBlINmpV88I7qHCzHO8RvRsRgVkULwNlcLKEJdw9QIEkfOEC6vR1X4wx7eeItLlzmbcJp6dmE/8115hPhzbDPhI/JRlNfmjk2Wjl7Q/mn5zcRKu3XRJRcZcOPupPl10e2WoSrmuecBPuJwSPvXRhYNnfy9GHrztwB7Cr/D//VtM5E6Y9AeWFCOResh3c0SyBhp4DzQoT6LQYP7f2hjGJ7iQu1storUZOvH8Pqxhs0R4cSnHcjfM0tiLiLV/ctkMoUg8fd1YVJSDVViSSrrBK2gKXimnrR/Ck3laAmG0S+XvzEnonuKjrNPV/hOD4StTS6/IXLK4VdfHfuGYCt7hBaaa2P5YkuMJJ0ybxYVUczVvz16yGFUXqCBTy0b1Ma2Hna7uJBtbaGIjBdup0YSl8bat/TTeTqLo2mFVqplX5ZFlrmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(38100700002)(83380400001)(54906003)(316002)(122000001)(110136005)(53546011)(6506007)(7696005)(2906002)(41300700001)(66946007)(44832011)(33656002)(66446008)(4326008)(8676002)(66556008)(76116006)(86362001)(8936002)(5660300002)(7416002)(66476007)(38070700005)(64756008)(186003)(26005)(52536014)(55016003)(9686003)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFN1UVZhbHVOTU5yYmRlaWRydjQ1eXYrbjUvR1lLZVNQVWg5WEMwZEJGZGdR?=
 =?utf-8?B?cXJwNzUrRHVENDhHUGYzcWRGcmg0bGhha2l5VWpLUXo5dmh0MWIwamhmQUkw?=
 =?utf-8?B?L29LVjNTN1UxK3NRanZvbEdZQkhiU25MYTF1U1gxRUxaZTcyRFFxRnhlRmM2?=
 =?utf-8?B?UE5odjFrUm9uMnhBRCtmeS9pTjk5MFdLZGpPRHVxZFBFMXBuT0JYZnlnVGlk?=
 =?utf-8?B?VVJZbk5zM2F0eHU5L2I4K2RtNHlXSHdUNWwwNzk5L0JLWGorZGNrZ0FOMkx0?=
 =?utf-8?B?ZG9KYisyVDcwdnZwZFZwU3lTbnY5ejZtNGJqaUQwM1VTTkM5bkFWM29mL1cw?=
 =?utf-8?B?Y3hiWnpBMWVIalFmS3NpUVQ3d3lURkhlbVhFSUk0b0RpNFBxOUZsemtLV0Zx?=
 =?utf-8?B?bVZPMVdpemNYeThicy9IaTBqVGZ2UEpmZldheHk5dktOTFFnU1l2UTRzR1ht?=
 =?utf-8?B?RHlLb3BHa2JvdXFOcTZCRFhBWjZlUThpUkI2QlRXeXkvcDFTd1RwVlovUjAv?=
 =?utf-8?B?OEdBYThBVlRVWDFYcXd3bXpiOWxYR2NZU0hwSDFLZmttNGp0YzdIMnJTcmVW?=
 =?utf-8?B?OTdoK3BRQlF3dkZhazBvRk1lcGV1VXAvYWdtN2JqQzVpZmFuSzhPSXI3UWtU?=
 =?utf-8?B?cDFCRHVIVnd4S2VERjRTeHlUNkZ1N1RjaTFoVjFBL2x5SkQxOEtWZGVoYVJ4?=
 =?utf-8?B?WlZta1hxZkR2Z2hoSnFBMWpGdVQ2RVNvRGtlY25GcDhQcXpSWExKQmVKdWx5?=
 =?utf-8?B?MVVHdE1sQldEUVNOYTd4MzA5WUltWnBKeTAveTVlallFZnpDK0VzUlJoUkQ4?=
 =?utf-8?B?bWpXdy9vTDRrNW44WVJadDZHMGJUUHRobk1qL1BNZEJqVkd6SGpqZnVkakVN?=
 =?utf-8?B?ZzMrQjd6WDFmUGQwSWIyQWdwN3ZpRDVQbVNPeEhEdVVzc1BnYkVQdTBtbnJ0?=
 =?utf-8?B?dWc1R01OcC84emVZK0RwOW5LTC9EOUN4cGp6MjF2b3BYYVc1UFFuYzBaUkdx?=
 =?utf-8?B?RllXUWxsM2F2NXkwUG9qbUJUMkkxTzZqaU0zSlFheXdSSzg3em83NnNudUNq?=
 =?utf-8?B?SFozR2hOR0VCeUwzVkkzWTEwdTBQMGhPSU1lcHJYNHQxUHh2RjVGS0kvSGg4?=
 =?utf-8?B?Qlpjd0E4ay9XTkhTS3ZhbStLUzUyM0hJL1UwQWNzaXVqaTFoNDMxNlFBanpN?=
 =?utf-8?B?bXErUFJXM3pvV25JYmZDckRlWmxiSHZBOGxqalBuNDRRUmZyRlVvbXlzbTJX?=
 =?utf-8?B?NmhhNHdXTk42anhLdU96clk4VUREZHFENEZQUUMzV29LcUtzaENnOW1peGVq?=
 =?utf-8?B?MVdqWlFpa0xnNG1ya2I2QTRPc2tHVXdWSm44RnZpUjZTTjZaWjBwcGJUTU5q?=
 =?utf-8?B?WjI1bnUyK2FPNXhSV2J3OFJpWDNuajBUeUs2NVpFZ3pNQk1zNGMxWE5JUVJw?=
 =?utf-8?B?RnBoaSs1RlpSdktWTW8rR25MWnBlbWZ2MUdzQVRvYkdVV0xCU3JxalFsa0k0?=
 =?utf-8?B?SjluUG9BL0V5bHhjSDd5NGJQT2Fia3pJdHhBZ2tzeTFXeGowcjZRMnptc0h2?=
 =?utf-8?B?dFFBRkdpeU5zcGM1czlvTk1DK2VPajk2a09kbUMyV0F3dEV0V3dJczBYUWEz?=
 =?utf-8?B?eTNRVllDbWJydzZhbTVZWDZTQUpzS2lEaktFZVJKc2VLZ0U3cFVia1hEdUN5?=
 =?utf-8?B?QSsvaWVKQWxCZG81R043Tk1sQ3dlUzJkNFFoak9PelZXRHhpMzgyMlNpQnV5?=
 =?utf-8?B?enFhUFdaRW14b1NrRzZySnc5WEFIUHNjcTdzTGlPRENFVXNmdnl5VzRGeXl1?=
 =?utf-8?B?R3pvYTlrVmdWdHNIWWdoT2dmdDFUSWxoREFLWCtMS1NRQzBEL3lnWXlEMjFp?=
 =?utf-8?B?MEVmQk9nbHh5M3JZK0c5YnhDZGIvRTlXNkoxYWRRRlZ2M1p5cjFlYWxzT2Ew?=
 =?utf-8?B?WXY3dysrZkVrN2xzL1hudjQ0dnZKaGk4c2RwbjJ3Z1VyVTJwa0d1RWpCeXl3?=
 =?utf-8?B?eHZTRk56azRkVUdhNGIybDVlWVk2cHUxZHRpK2RsWXhETHBCRU4ycHVYb2pZ?=
 =?utf-8?B?MlRSVEZrWW9EdmprbzNlQ3JlbVJNaHFDUWZjU2I1YXFONWhMUVZCdGFndXNo?=
 =?utf-8?Q?k/+A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde98d4c-ca28-4a55-4e02-08da863e6cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 02:06:29.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWeYJAXTfNExTHKBBKnLxw54hL9HoyeqOW6sB5burow4cqm1EoyHXl+/HUtsJU+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQoJSSBleHBsYWluIGFnYWluLCBJIGhhdmUgcmVhbGl6ZWQgZGVlcGx5
IG15IHdyb25nIGJlaGF2aW9yLiBJIGFtIHZlcnkgc29ycnkuIEkgYWxzbyBmaW5kIHRoZSByb290
IGNhdXNlIHRoYXQgSSBmaWx0ZXIgdGhlIG1haWwgbWV0aG9kIGlzIHdyb25nLiBJIG9ubHkgZmls
dGVyIGJ5IG1haWwgbmFtZS4gSXQgbWF5IHdpbGwgbWlzcyBpbXBvcnRhbnQgbWFpbC4gSSB3aWxs
IG5vdGljZSBhbmQgbWFrZSBtb3JlIGNoZWNrIG5leHQgdGltZS4NCglUaGFua3MhDQoNCkJSDQpK
b3kgWm91DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIy
5bm0OOaciDI05pelIDIwOjM1DQo+IFRvOiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+OyB2a291
bEBrZXJuZWwub3JnDQo+IENjOiBTLkouIFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT47IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBz
aGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCBW
MiAxLzJdIGJpbmRpbmdzOiBmc2wtaW14LXNkbWE6IERvY3VtZW50ICdIRE1JDQo+IEF1ZGlvJyB0
cmFuc2Zlcg0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAyNC8wOC8yMDIyIDEz
OjMxLCBKb3kgWm91IHdyb3RlOg0KPiA+IEdlbnRsZSBwaW5nLi4uDQo+ID4NCj4gDQo+IFlvdSBw
aW5nZWQgYWdhaW4gaW5zdGVhZCBvZiBpbXBsZW1lbnRpbmcgdGhlIHJldmlldy4uLiBTZWNvbmQg
cGluZyBpbnN0ZWFkIG9mDQo+IGRvaW5nIHdoYXQgd2UgYXNrZWQgeW91IHRvIGRvLiBZb3UgYWxz
byBkaWQgbm90IHJlc3BvbmQgdG8gb3VyIGNvbW1lbnRzIG9uDQo+IHlvdXIgZmlyc3QgcGluZy4N
Cj4gDQo+IFRoaXMgaXMgbm90IGhvdyB5b3UgY29sbGFib3JhdGUgb3ZlciBlbWFpbC4NCj4gDQo+
ID4gQlINCj4gPiBKb3kgWm91DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IEpveSBab3UNCj4gPj4gU2VudDogMjAyMuW5tDjmnIgy5pelIDExOjU4DQo+ID4+IFRv
OiB2a291bEBrZXJuZWwub3JnDQo+ID4+IENjOiBTLkouIFdhbmcgPHNoZW5naml1LndhbmdAbnhw
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+PiBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPj4gZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4g
U3ViamVjdDogRlc6IFtQQVRDSCBWMiAxLzJdIGJpbmRpbmdzOiBmc2wtaW14LXNkbWE6IERvY3Vt
ZW50ICdIRE1JDQo+IEF1ZGlvJw0KPiA+PiB0cmFuc2Zlcg0KPiA+Pg0KPiA+PiBHZW50bGUgcGlu
Zy4uLg0KPiA+Pg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
