Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696455A0676
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiHYBmh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 21:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiHYBly (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 21:41:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B169DB46;
        Wed, 24 Aug 2022 18:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpHLmHG/999Sn/MvhA+hUkGFeJCoWVIkK6dDaXOWiC+cFC37VcGA5qG+MNCJ5vTbbYEP7EwkBTQg9QR7y1D3ezfmc21+0DQjTJyR26aJZ2q/KxQcEMMNT8qr7doNwDGa4a2cNQfbFMPtpRTNYUdqMRHfcQwxn0BNxEokcHezhCEODxfMuKHFO+ViVKa+ZLLHJfpODZgELhaiggpth07rG6+gwTssVAFa8CjnTYaDTQDNdRDwS0bGlVGohI9ZOzv82etBmlCIaL2PwgEKVy3MC5DArr5qKtWlVDbIFRdCHFVDv2AG21UpCdiT1UWv0+l7D79bBXUDQ3tvoTRpruS0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R93olyQujYYNfxDrf4GYoWhwOFwZ+MSC4Bnnc8C7ujk=;
 b=TmMIZ9KcYkWKmlAl4CztgZ5oTAX2bqNj0X17hJ9f96upLdv53ReKCQU6x7G+OFiGfyZyGUFyTl77qCcSwiiy8l0GI4lh5K8nemRqXzS1KlnxyhGlRqRfgbutadP6bL1a+PMh7BCLp+tjKP/hidIrK2xppon/3EMlExzmAEFDoTp8F2mlZbMF+RhM24OhyBYpFfXB96QlB6PxYExOj3iAofYAmOm6uAZ1GynEDYk2vZei91HZjeAleUM0BHtKFoVMsi1MNtfVgrQtmKWyNvd7TfCcOEKtXpqLsUToMcgNDGjykfP593Boo1UG6YKodY5gCA5akhmd0P1Uk4uKiAZ+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R93olyQujYYNfxDrf4GYoWhwOFwZ+MSC4Bnnc8C7ujk=;
 b=UipU8/eE39ZRjMmF1ggsD+btf7loxkstjBvCApKwEqFCj58DXkLbJ63hc/OKvV3ZJwOKqbskwQgTHRqT81VaeI5hxK2wbRKnuSFYw3hHeTSPMc9nvZInSVxJ+hLufpvTn+bgiipnmxj2im0cWhiX2chSFFXDgU2LBv660gRO84s=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM6PR04MB5767.eurprd04.prod.outlook.com (2603:10a6:20b:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 01:38:43 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 01:38:42 +0000
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
Thread-Index: AQHYb0Sbzg3yRatDsU+sUlyHgY6zya2baFlwgCMCbCCAACKUgIAA14Fg
Date:   Thu, 25 Aug 2022 01:38:42 +0000
Message-ID: <AM6PR04MB592517755A711EE708C3CFFBE1729@AM6PR04MB5925.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: a156b8ff-aa98-4179-04cf-08da863a8af6
x-ms-traffictypediagnostic: AM6PR04MB5767:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZfNEn4seuhX7jn/A4q1mWeJzwEtK20MOScbvLdYaFNqr2Enhd/n8eWmuyBLkhnpWkqRSP4S63FRbv50qK1b9vv6bCkdna58F8LqjSTVue1WiBR6f/ZwfiPw3ENgWQhpd62EWF/p+x0/18jJiL5+kyi6CjN26+mN71xozqQ+RWhdy1OKgnsbyWfonyF3wq/Cr20aTy3IdJzR0+hLG4qnYxI7HFsvPX5NOUeoV6bw2coxPsqAHUYCDB5MyGsH2JykAN/NDyC5//QJLUOkLiqhst2nGuo1Kjije0UCi6wGkQiqKR9TqDlywl0mfBiyvirZyUH0iqsNkHpWcNEAUabDx+alE3guvyu201oija5dMCeDW/UBSQZd/kDXRjzknOAKwO7tpaYgV6FCsoMl3PfoRvdJLRxdIF2+h1szBlWTLJEGKK+AJWhX50uCmX4Yv5I7xgGX4zp/6U/np1Fn6xElfvZ+vVicjmQ99GQS8AHnYWnnPEd/UnVuN9j45cjbHiv4ENeXOCgYD5NxBTn3hzqxZOkjpUyf89PemHhmiwrNMqSGoQityiV6QFap9Pr4CAxz1uXEBoL5pM4oZKCydHl8TSeu3aBUtY6HL/cc2S3320TysnCrOxGkJ2ftAghJlwa+7SxieVNx4PYsCpr6yC1w4p4KTg/Aa/z281IxaOxNqRUJVBZ1E0kw9m6P6iLSWBImDJduZ9kUZeuozlXceYiuUVti8L+LEJGYnz6W0JL6jS8xrhA89DyxidPGBuNSw1S3DLTL5LDKR+hojEyCEpKZpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(7696005)(86362001)(122000001)(83380400001)(38100700002)(38070700005)(54906003)(316002)(66946007)(44832011)(76116006)(66446008)(7416002)(52536014)(66556008)(66476007)(64756008)(4326008)(8676002)(2906002)(55016003)(8936002)(6506007)(186003)(53546011)(478600001)(9686003)(26005)(110136005)(33656002)(5660300002)(41300700001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWpBb1lLZ2QzcTNzQWhiRGFkZEdjdmtIN3J0WjhuWjB5dXorUHV3V2QvRXE0?=
 =?utf-8?B?bEE2TzJaZ2dzVzlZVHZDYkFTUkxVdy95TlZZU1JSVkJGS1JoNVZDZzBiN0hx?=
 =?utf-8?B?bWlKRkd5MkYzMWkvMHpxMkFGbmRjR0JJK3BMQWNsKzFSUFRROTl0MEpobksr?=
 =?utf-8?B?OUMzRTRQcmd4Y1YvRkd6YU43eFBwR0lxU3RBNWdXSjZ3VmNuSWMxTjAvaGtL?=
 =?utf-8?B?V04vZHBKK3VyVC9ibmQwUlZyRXZXazV5Sm9DSDNBcDJYM20zRmczT0toUURN?=
 =?utf-8?B?Y21LajhsVWJjTEJvUjFFM0FPYkRQWWNUYXM3aFYveE4rQnEzRTkzYTBUQ1V2?=
 =?utf-8?B?MFN1TTJDSFdQK0R6d3o0Rkh4RTNaZDFqOUR6OC96NURsamVKZ2JiRjFsdnBq?=
 =?utf-8?B?RG5jNEd6ajlZK0VxMmRRWkVSTkQxU1VESUVHc1NPOU13OWxOS1IrWXg0N1N6?=
 =?utf-8?B?SU9MUHFLM3NOaEtaU1UyL3FBVjRQZ0JLVWVNRWZwYWJmZnY4NWNVNFlSdU1X?=
 =?utf-8?B?Y0RBRUlvLzQ0d1lYVERLSThFSE5GVWx6cWRyRXd3Z3B6WlBnajVjVVJldE42?=
 =?utf-8?B?T3VHUC94aUtLc0Q5NVVXZ2w0ekJ3ZVNObVpjQU83Q2c3MWMyaFNWcjVaMS9r?=
 =?utf-8?B?MnlDUlhYT01mcDY1ZkQ1YnZvTjJFZDdRNm1UQWFMWTk4aWtkRGZrY2l5TWlB?=
 =?utf-8?B?VEdsdVN1Ti9pbWxNQnJQaTc5RkZKbG43Z1J5czQ0aWdtdTJtYjV2NWx5cnBa?=
 =?utf-8?B?dHhtZlkxVHY2bW9OeHgzWkVUNjlSOWJwQ3UwYnJQR1p5d3BBRzBIY1Bta3NI?=
 =?utf-8?B?dEdjeFV2RWowSG9hdEswWkppb3RRUkZya0Mra2NodmRUV01wc1FIczRlVGRp?=
 =?utf-8?B?N2c3Z3NseFpqbUVINm5Kbkk2UHpBQ0lQdUdvNDN3Tjh6ZWx0YXVzb1ZGQUFj?=
 =?utf-8?B?cldTeEtoNFU5a2ZmTVZyZFJSQUhEakcyNHNCcGNnMG1jMWJrN0NGSHp3VWNa?=
 =?utf-8?B?eU5BUWF6dDNiMjByWDUyRkJjRlgwMDRseldDWmVTTldjUUR3cG9BVDlkaitq?=
 =?utf-8?B?MlVyV2lZNDY4bGttbXdxUzY2WnBKRXhwczZVRCsxcXBQUHRJbW5EcG9WdHQ5?=
 =?utf-8?B?eDRXYzdFbm8wVktYbXFlMnJvOTAyTFViWGt1N3FmdWJ5Z1RRNU5jOEgxazQ5?=
 =?utf-8?B?emFVcW5sZGVyQTF1cC9RL3BaUys0UUpib0FEOHA2dTdaUUV0Wkh1ZjFVQmpx?=
 =?utf-8?B?bmt4dGVyc1h5TDJaV3o3WExHYUVYK1hYUEY1N3JkU29JcW9NMzR5cDlkM01j?=
 =?utf-8?B?OFQwMWhZTkdKYnRFZHQwc1lTdzd3eDN5SUNmVEthZUpSenN4amYyVDRRTGgr?=
 =?utf-8?B?S1J4NGFPdHVDVmxqUXlxc1IrWVVQYU9aZVdDSC9hQUsrS1ZveUN1dEpwMFRO?=
 =?utf-8?B?Z0xzMnhSRmErbklxbGJXR05QeU5LemprZjZ0Ym1XNWVRQTBzVjF0VzBLSDVJ?=
 =?utf-8?B?ajEwbHNvOXV4VGMwNmN3V0wwRHZYT3RENVVxbEFydXMvRUl4Y2xPREFRVGFr?=
 =?utf-8?B?TkRiVGVHdzc3RmpqcktreFZYR1VkU0FRbVp6V0lTNXM3dFgzRXB6dU1JcHI3?=
 =?utf-8?B?TXVKUk9GYmNGcVJiLzY1RDJnNmFBU1NUeVBIdWI1OEdGVkZoLzBTMVl3alpo?=
 =?utf-8?B?Vzg0dFhaN201dlJZWmpuYUNzeDl3Wlhlbkc4MU92ZWRmdTU0aFJMdUNrejdB?=
 =?utf-8?B?MzNGdDY3d2dsUEhCYTIzdnhuZEFaTUVUYW4rYVZkT1cyVDJFcnF1OWxMWTZS?=
 =?utf-8?B?Qi9NL05SWC9KOXFRaXp2VUdONmZzNk4yQ0hoZE1XV1VOdEw3NG9WS01vdDZw?=
 =?utf-8?B?bEpwRm5pL0cxNjRaVmJyc2pkb2R5dmRPWkVxWXpzTW9YTko1OHFrdkc5VXFt?=
 =?utf-8?B?dmpvSk5vYkNRUzZiSThZZ0E4YmcrZXFVUEorQlNPaGZWL2t4U2hMaTFlR1pH?=
 =?utf-8?B?anVpVHpVSUY5SFMxQ2F3aE91amx0VTdRREQ5YzRyQ3hCeTdaOEEwbU1OVVV0?=
 =?utf-8?B?YzlGYWNHM1QwUDNEM3FOYXRSdVpuOElycHMvL1hRajROcG1CbksvTXdPckJU?=
 =?utf-8?Q?VCGA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a156b8ff-aa98-4179-04cf-08da863a8af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 01:38:42.3325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10/xu4bU7++ID9jd+k4KpGKqYr7MCZIEteQBV2FwqUCxPcLibTh386tYavckxTXz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCkJSDQpKb3kgWm91DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBT
ZW50OiAyMDIy5bm0OOaciDI05pelIDIwOjM1DQo+IFRvOiBKb3kgWm91IDxqb3kuem91QG54cC5j
b20+OyB2a291bEBrZXJuZWwub3JnDQo+IENjOiBTLkouIFdhbmcgPHNoZW5naml1LndhbmdAbnhw
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCBWMiAxLzJdIGJpbmRpbmdzOiBmc2wtaW14LXNkbWE6IERvY3VtZW50ICdIRE1JDQo+
IEF1ZGlvJyB0cmFuc2Zlcg0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAyNC8w
OC8yMDIyIDEzOjMxLCBKb3kgWm91IHdyb3RlOg0KPiA+IEdlbnRsZSBwaW5nLi4uDQo+ID4NCj4g
DQo+IFlvdSBwaW5nZWQgYWdhaW4gaW5zdGVhZCBvZiBpbXBsZW1lbnRpbmcgdGhlIHJldmlldy4u
LiBTZWNvbmQgcGluZyBpbnN0ZWFkIG9mDQo+IGRvaW5nIHdoYXQgd2UgYXNrZWQgeW91IHRvIGRv
LiBZb3UgYWxzbyBkaWQgbm90IHJlc3BvbmQgdG8gb3VyIGNvbW1lbnRzIG9uDQo+IHlvdXIgZmly
c3QgcGluZy4NCj4gDQo+IFRoaXMgaXMgbm90IGhvdyB5b3UgY29sbGFib3JhdGUgb3ZlciBlbWFp
bC4NCj4gDQpIaSBLcnp5c3p0b2YsDQogSSBhbSB2ZXJ5IHNvcnJ5LiBJIGRvbid0IGFkdmlzZWRs
eSBwaW5nIGFnYWluLiBJIGhhdmUgbm8gdXBzdHJlYW0gZXhwZXJpZW5jZS4gSSB0aGluayB3cm9u
Z2x5IHRoYXQgdGhlIGJpbmRpbmdzIHdpbGwgYmUgcmV2aWV3ZWQgYnkgdmtvdWwgYWdhaW4uIFNv
IEkgb25seSBjaGVjayB0aGUgdmtvdWwgbWFpbC4gSSBkb24ndCBhZHZpc2VkbHkgaWdub3JlIHlv
dXIgcmVzcG9uZCBhbmQgY29tbWVudHMsIFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgY29t
bWVudHMuIE15IGNvbGxlYWd1ZXMgcmVtaW5kIG1lIHVudGlsIEkgaGF2ZSBzZW5kIHNlY29uZCBw
aW5nLiANCkkgd2lsbCBub3RpY2UgbmV4dCB0aW1lLg0KIA0KPiA+IEJSDQo+ID4gSm95IFpvdQ0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBKb3kgWm91DQo+ID4+
IFNlbnQ6IDIwMjLlubQ45pyIMuaXpSAxMTo1OA0KPiA+PiBUbzogdmtvdWxAa2VybmVsLm9yZw0K
PiA+PiBDYzogUy5KLiBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+OyByb2JoK2R0QGtlcm5l
bC5vcmc7DQo+ID4+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgc2hhd25ndW9A
a2VybmVsLm9yZzsNCj4gPj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4+IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+OyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IEZXOiBbUEFUQ0gg
VjIgMS8yXSBiaW5kaW5nczogZnNsLWlteC1zZG1hOiBEb2N1bWVudCAnSERNSQ0KPiBBdWRpbycN
Cj4gPj4gdHJhbnNmZXINCj4gPj4NCj4gPj4gR2VudGxlIHBpbmcuLi4NCj4gPj4NCj4gDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
