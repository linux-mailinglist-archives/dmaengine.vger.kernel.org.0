Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E887D61340B
	for <lists+dmaengine@lfdr.de>; Mon, 31 Oct 2022 11:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJaKzO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Oct 2022 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJaKzM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Oct 2022 06:55:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE3A616F;
        Mon, 31 Oct 2022 03:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvgypT4YIwb5AsKc75/YccONQp6Omp9/ePaQM6qFSUVmbb5exq8rMhjJnURAfbq1hsG8oNTwq0lfCNU3dzvefsq3oMb5Oo2Y0OIeZkcR3XauiLMCwXZx92D/OZBVxCUcbwMBI3Kl74BisAHKfqP234/eF1IYh8L8ycSOYFF+bRhi832MVQmCbUP7IUkJUZn/qr9lBpMA8IQBPd1qSZX3Z7oB2gxsTYzScSkC4Q9aGsnyvGntPMhlULanFzW2gEMBmc/XeJcOdWoENadMLv3ZLcijyBAiBgJbjS59w4HR7gS9VnXHLNL/hL2AprlhOIbPsaBRdiGyFYyOq+HPrylM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptO4+vvRCGd+B7lrr5ALoc/h4KSUD93hCPe8gJ/fw6A=;
 b=XCJmfR3GC5t3NdQXGantCQbjzxiabBOLytcmPx8+OTiIRtefp7iF3L3YJAm5i0shgE1/LE1/O23ShK6LvUHdqTAEP/SM5xGd/2Up3rMnU7VWMuU1+rNaIUljPb/ev+uPL0tMChBe5a92KvNJ2E1B7Fy6l2av13vew7yCgGOGyRcgaXG6bqZbtjmBNW+zEK8sd3+7T48jgN3Xt1A2W0Tr289ChQLaUJW2Ch4yTYlk25KxYnqRk8YvGc8ZYxxTs5ALYgkdvw4/B5hDfs9YClkXpQQWvNKw4/KO1CNi1BjCdq0/cq3W20hWkSXs/B5rlsVRbS7ShhcMdoWnviNosBbptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptO4+vvRCGd+B7lrr5ALoc/h4KSUD93hCPe8gJ/fw6A=;
 b=fp14hLVLsn3I4mqBVTQx4zOHThYc9jOZeyZqOPLD6qVi/x/56X+mel1YyTzVUdvj9ozQTd9pBwViqr/AgMqhYNMg6pbSg3C8V+PggU9CFEx8jyuKLly48vhfrLdkJmLl7k3c8GeJQyNVRQkRwONXNn/PG6BC885P1fwb1X5/vyQ=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AS4PR04MB9267.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 10:55:07 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:55:07 +0000
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
Subject: RE: [EXT] Re: [PATCH v8 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Topic: [EXT] Re: [PATCH v8 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Index: AQHY6EyxpTiasLn3LEuxZxcLxXRE4q4gxluAgACyUXCAAZkAgIAFSq5A
Date:   Mon, 31 Oct 2022 10:55:07 +0000
Message-ID: <AM6PR04MB5925F9A7B8E075C4F9762D30E1379@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20221025083609.2129260-1-joy.zou@nxp.com>
 <20221025083609.2129260-2-joy.zou@nxp.com>
 <133f27f4-d92c-ef8d-4fc9-32387518e4c0@linaro.org>
 <AM6PR04MB5925157A3A6F8ADB80371082E1339@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <49f504a1-e7c3-ade7-b4b4-e7571125b992@linaro.org>
In-Reply-To: <49f504a1-e7c3-ade7-b4b4-e7571125b992@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|AS4PR04MB9267:EE_
x-ms-office365-filtering-correlation-id: dc730e26-5d20-4d53-5d47-08dabb2e5fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NTd2YLO6118vfIPdBszluSrx+vDGiE+jySVjh+1pmqncjgvzg5HYGOTAWY0tXhZi4hqQQCKy3jmoi+f6ecG1SiwIkJH4mT4zjb9f3nsmI6CcU/dLdUTyFz2ikjHeng7ougqryvSGPwhP61F5C01s0ore2YgQxSjLghGJP99mzEbZAIaoqN/2rPPfgrC+aNiYnr6sY91YGH42LibXKs27WiEAx5VemGM3uiie+vdMwkZG4ORFIS/8foSQwlO4ez240sufLxQ1E2S1FXa9WyTXYAQudetFEL/WAo/zZQ9T70J8eRCfVnJwYmk+7a2WQ0VzkfLSIsNaG53VSoEGgG2ylvb+0jlLRVp/zE714CM86ReqcbXkAJS+I6QHCGbhxZJwIRBhKCL3ztnPCtgoX4+urR40ttU1Q70akL+W4ToAEVt+EddrFjYLxrbRSigeaWf5k53XA5dx0D4pvUCVBSJC9ALKAF597xfUir+CVvRVIgAxW2RzbqRV/Mt0uDcihheM7MvNh5+zFFMsDLczSngBTyShDUw6SqUWlgAqbM/XDidrfhrAN74zoTXOfdbPZXliwoEAMR+q36Y0yBEICuvqETCz49FCrWFK0lzq1MW2FK/ESTr5QNnO+ZcO0hqnR/wNlsg34EQPCklNNi5jB6vT+ehbHg1jf7LCj7wMkf677ftkYFm2r5WRkko4Z77go896JtDw8vwk4BlGrP/y7twjKBsoIn0VUPWssHEfg7mnvYqg3IQ4r811hxpVCCTJHkA1Ph+OhuqX3RuNM1HK45h6ON6o2vg+2JyR83WLkzsyCHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(71200400001)(38100700002)(86362001)(122000001)(110136005)(33656002)(38070700005)(55016003)(54906003)(316002)(478600001)(45080400002)(966005)(66556008)(44832011)(41300700001)(8676002)(8936002)(7416002)(76116006)(64756008)(52536014)(66476007)(2906002)(4326008)(66946007)(83380400001)(26005)(5660300002)(66446008)(186003)(53546011)(6506007)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?LzdrTUNLU3VXRGlPNFBtK3NJWGdRWHhSV3FqT3Vpa2VpRG1uSnZwdkFZRjha?=
 =?gb2312?B?K2dUU3Q1OGcweWxHaW8wd0xxQUU5cGs2V0RaSStsMlhRNHB5c3lRWHh6MmhG?=
 =?gb2312?B?ZG5oYkxSMnBEUDFxN2ZaSkFMRmpSSm03bUdoTnA5QnFTbE5iV2NBcEpPa1Fq?=
 =?gb2312?B?QWJsM0dKZVZnaFFFWm44a2pkcHlhSllTZ0lOZDNjL2JLUlh4SlJIZXRrd0o0?=
 =?gb2312?B?QmFJMFVRZ3BvZmh0eVFzTmpPK1NMSVlZckYzd3l1N3JPRWdDdFFaSkZMRkRO?=
 =?gb2312?B?aGxNSUxRclEwQ2pEcDV4UWFxT0dLN2J5RWpQSWZ3NWU5eDdyV3lJMUFwSisx?=
 =?gb2312?B?WDFqSnhOODZvc25NR3VjWjBWWnBXS3M0Y2hUTzYzYWt0dHJPZThSaDYzOXpT?=
 =?gb2312?B?Y3hCcGJaWWRWS3pCRGxTNzRhTmVNSTR0Q2ZRQVkwSkpuMkx3UnBmdW1ES1Nv?=
 =?gb2312?B?Ri80cHErTkxuT2o2WkpJRDg3S3hzalFYWXIxdElzZDJwbGlQOEhmSUUwSHhl?=
 =?gb2312?B?NmQwRkdVTE9tUnlyS1R5VzhTbjF2cG1qZ3BEK3JuR3VLTlpSSnlmODk1cWMr?=
 =?gb2312?B?elRaOU4zUkZvKzFUNklDemdGRFVpSzRucmRkQmNwQ0E2L0V5Rk9LUENJckxO?=
 =?gb2312?B?REpnbE85N1Y0YmlaMlQxaTVHNmFjZEJOMDZrdXIzL2hSeksrajhOa014RVpI?=
 =?gb2312?B?VDZiSHJnL2hqN2czOVZoYjk2M2w5VUg1dHlINUppMjVPcHhZMGRkMWdhSlZX?=
 =?gb2312?B?bXdrMDhHQVdnWWhaUHdaMGFCZ1FLRjg4b1o1K1ljdzVPdnZxVlBXR2piT1RP?=
 =?gb2312?B?TjZhYnlIai8wR3d2SlNma204U2g3MDNQamFYa2gxQkRZMXQ3R1AzT2pkMlRM?=
 =?gb2312?B?Qm9KM3VSZVdHdGFQSmZtMDk4VGVMb1VGZGdJQW9LSm5LdEF1cWdXVnB0SVNG?=
 =?gb2312?B?d3JhQkVzSXhLVTYvT3cvTy81b1J0QjNtZ2ZaOTdWRy8zanpuZlUzcENMcFFu?=
 =?gb2312?B?cEc4UHQ0bmFpZnk0V2VVNnVRNjNqNnhwakMxeGkyOGc0SVFtZk5SNVliUUF2?=
 =?gb2312?B?dVRpR3BnOTh4R09WTzlXTkRDMHZnakxTVFd1dE8zRjhRYmFzODV6a0F4MDEz?=
 =?gb2312?B?SDJZYzlVRXFHdEdoSDBmeHpscEtIY0RhT3JGaDUwYTI4eDBxazc1MzByKzRy?=
 =?gb2312?B?V2NsME9Uc3lNajlROVEwejV1L0IxbnNoS1dtM21CUzdnckJ3U2ZMZG5BbXhL?=
 =?gb2312?B?Uk1aSFhvWkFzMk92WkZIZmhVYUlpUTZNZ1REeS81dnN0b1Q3TXJUb3BiMlVK?=
 =?gb2312?B?UWtFWkhMZTRaZllSQnpHLzhybHpxc3BvTkxYZmRuV0RpWm9NYkhYYWhyWGpk?=
 =?gb2312?B?a2NuU3ZmWHJUYTJlcUFkUzNwbE52a0FGMHlwZjhVNUY4TkhGam92T2xDZUF3?=
 =?gb2312?B?a2pzNE5lWUJxR0tvSnF3RUdLWWh1dmxYRmQ1NXpyb2pnQ0FwQVFGS1N5TUhG?=
 =?gb2312?B?Wnd5QmMyR3FYTzhEY3VaWnZkS3ZuN2ZkbWcxTWxoSHpJQzFmSy8vMHNvZDVu?=
 =?gb2312?B?M1BtTmNqelFDaG5aQ2F6UlpUZ0VtczVGOGF5cjhRMmpzOHNMei8zektuUlRH?=
 =?gb2312?B?L0h4dW9ObVBDOWF0cFBqaU9CZGVpZFJpRmFCM0Z6NjE2UU50aGh4WjZ3cjln?=
 =?gb2312?B?SWplWnhpM0V1WDRWNkhxRm1EYUlYNE9uZnoyMGh3a1MxLzhPekZGek1aUGVu?=
 =?gb2312?B?TWJJV242Qlh0NlZsTmtvNWQxZ3FOVkpWOHgzM1pEZzN0ZUd0NThiNnFxeXJk?=
 =?gb2312?B?T3FhVURLM0txYjQyOFhpYkZhQnBxaUVvUmVZa0Z4cEovWG5zMWh5SGdEU3RM?=
 =?gb2312?B?THVFZUM4WVlULzM2dHptK1BsRG9CdjN6MndZM3Ara1NEcGlrRkFYTzRIdXVq?=
 =?gb2312?B?ck52NGZnSjNXZWJ1aFZZaWZtd3BNcUdhQTlHbmt5anByY01NR1JMU1k2UGZz?=
 =?gb2312?B?WC80MFJHOEpVc2dnbkp1eG1SakYzM3lVdmV6engzNm53QVR4ekk0eUxBS0ZE?=
 =?gb2312?B?ZFBOQWFOc3M3Q0VuN2Y4Q2d6S1ZYWCs1b0tYRlMrcUpKSXRydmlwVENvUGpS?=
 =?gb2312?Q?n7zU=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc730e26-5d20-4d53-5d47-08dabb2e5fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 10:55:07.6691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/ojquKteUvU2ta4PYIU8CNvGrIpgeRtT/nWJ3pw8IFtldk8sxbgvMzJDbSzbcjD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9267
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
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMsTqMTDUwjI4
yNUgMTA6MDENCj4gVG86IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogUy5KLiBXYW5nIDxz
aGVuZ2ppdS53YW5nQG54cC5jb20+OyBtYXJ0aW5rQHBvc3Rlby5kZTsNCj4gZGV2QGx5bnhleWUu
ZGU7IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IFBlbmcgRmFuDQo+IDxwZW5nLmZh
bkBueHAuY29tPjsgZGF2aWRAaXhpdC5jejsgYWZvcmQxNzNAZ21haWwuY29tOyBIb25neGluZyBa
aHUNCj4gPGhvbmd4aW5nLnpodUBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT47DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjgg
MS8yXSBkdC1iaW5kaW5nczogZnNsLWlteC1zZG1hOiBDb252ZXJ0IGlteA0KPiBzZG1hIHRvIERU
IHNjaGVtYQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAyNi8xMC8yMDIyIDIz
OjAxLCBKb3kgWm91IHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4NCj4gPj4gU2VudDogMjAyMsTqMTDUwjI2yNUgMjI6NTkNCj4gPj4gVG86IEpveSBa
b3UgPGpveS56b3VAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9y
ZzsNCj4gPj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBzaGF3bmd1b0BrZXJu
ZWwub3JnOw0KPiA+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiA+PiBDYzogUy5KLiBXYW5nIDxzaGVuZ2ppdS53YW5n
QG54cC5jb20+OyBtYXJ0aW5rQHBvc3Rlby5kZTsNCj4gPj4gZGV2QGx5bnhleWUuZGU7IGFsZXhh
bmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IFBlbmcgRmFuDQo+ID4+IDxwZW5nLmZhbkBueHAu
Y29tPjsgZGF2aWRAaXhpdC5jejsgYWZvcmQxNzNAZ21haWwuY29tOyBIb25neGluZyBaaHUNCj4g
Pj4gPGhvbmd4aW5nLnpodUBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNv
bT47DQo+ID4+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiA+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2
OCAxLzJdIGR0LWJpbmRpbmdzOiBmc2wtaW14LXNkbWE6IENvbnZlcnQNCj4gPj4gaW14IHNkbWEg
dG8gRFQgc2NoZW1hDQo+ID4+DQo+ID4+IENhdXRpb246IEVYVCBFbWFpbA0KPiA+Pg0KPiA+PiBP
biAyNS8xMC8yMDIyIDA0OjM2LCBKb3kgWm91IHdyb3RlOg0KPiA+Pj4gQ29udmVydCB0aGUgaS5N
WCBTRE1BIGJpbmRpbmcgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4g
Pj4+DQo+ID4+PiBUaGUgY29tcGF0aWJsZXMgZnNsLGlteDMxLXRvMS1zZG1hLCBmc2wsaW14MzEt
dG8yLXNkbWEsDQo+ID4+PiBmc2wsaW14MzUtdG8xLXNkbWEgYW5kIGZzbCxpbXgzNS10bzItc2Rt
YSBhcmUgbm90IHVzZWQuIFNvIG5lZWQgdG8NCj4gPj4+IGRlbGV0ZSBpdC4gVGhlIGNvbXBhdGli
bGVzIGZzbCxpbXg1MC1zZG1hLCBmc2wsaW14NnNsbC1zZG1hIGFuZA0KPiA+Pj4gZnNsLGlteDZz
bC1zZG1hIGFyZSBhZGRlZC4gVGhlIG9yaWdpbmFsIGJpbmRpbmcgZG9uJ3QgbGlzdCBhbGwgY29t
cGF0aWJsZQ0KPiB1c2VkLg0KPiA+Pj4NCj4gPj4+IEluIGFkZGl0aW9uLCBhZGQgbmV3IHBlcmlw
aGVyYWwgdHlwZXMgSERNSSBBdWRpby4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBKb3kg
Wm91IDxqb3kuem91QG54cC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IENoYW5nZXMgaW4gdjg6DQo+
ID4+PiBhZGQgdGhlIGRtYS1jb250cm9sbGVyIHF1b3Rlcy4NCj4gPj4NCj4gPj4gV2h5IGFkZGlu
ZyBxdW90ZXM/DQo+ID4gSSByZWZlciB0byB5b3VyIGNvbW1lbnRzIGluIHBhdGNoIHY3LzEuIFRo
ZSBjb21tZW50IGFzIGZvbGxvdzoNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBKb3kgWm91
IDxqb3kuem91QG54cC5jb20+DQo+ID4gKw0KPiA+IFlvdSBuZWVkIHRvIHJlZmVyZW5jZSBkbWEt
Y29udHJvbGxlci55YW1sIHNjaGVtYS4NCj4gDQo+IFllcywgeW91IG5lZWQgdG8gcmVmZXJlbmNl
IGRtYS1jb250cm9sbGVyLnlhbWwuIE5vdGhpbmcgYWJvdXQgcXVvdGVzLg0KPiBSZWZlcmVuY2Ug
aXMgIiRyZWY6IC4uLi4ueWFtbCINCj4gDQo+IA0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBvbmUgb2Y6DQo+ID4gSSBtaXN1bmRlcnN0YW5kIHRoYXQgYWRk
IHRoZSBkbWEtY29udHJvbGxlci55YW1sIHF1b3Rlcy4NCj4gDQo+IFRoZXJlIHdhcyBub3RoaW5n
IGFib3V0IHF1b3RlcyAtICIuDQo+IA0KPiA+IFNvIEkgYW0gYSBsaXR0bGUgY29uZnVzZWQuIE5v
dywgSSBzZWUuDQo+ID4gc2hvdWxkIEkgYWRkIGRtYS1jb21tb24ueWFtbCBxdW90ZXMgYnV0IG5v
dCB0aGUgZG1hLWNvbnRyb2xsZXI/DQo+IA0KPiBKdXN0IGRyb3AgIg0KVGhhbmsgeW91IHZlcnkg
bXVjaCBmb3IgeW91ciBjb21tZW50cy4NCkkgaGF2ZSBjaGFuZ2VkIGluIHBhdGNoIHY5Lg0KQlIN
CkpveSBab3UNCj4gDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmVuLndpa2kNCj4gcGVkaWEub3JnJTJGd2lraSUyRlF1
b3RhdGlvbl9tYXJrJmFtcDtkYXRhPTA1JTdDMDElN0Nqb3kuem91JTQwbngNCj4gcC5jb20lN0Mw
MWE4ZjFkZjYxOGU0ODExZGVjMjA4ZGFiODg4NDg2MCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjDQo+
IGQ5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MDI1MTkyNzEzODQyNzk4JTdDVW5rbm93biU3Q1RX
RnANCj4gYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSQ0KPiA2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9VVRx
Mzc4eENhJTJCaTR1ajBJS3hPMWxESHBmDQo+IFluS0NvbFdUMzNPVlYwVDN6RSUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
