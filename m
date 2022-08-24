Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E100459F7C3
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHXKbv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHXKbt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 06:31:49 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E580B7D;
        Wed, 24 Aug 2022 03:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/CvvUzJ6bhXM4S/j7F13mr+02pQQSYWrlY64UUMiiC0hEiY+r1dlN8uPWS83kQ/u1g+VVrGa1VX+8pmUMEvcCb5Gxc4/qNL7pnJUUdndGsJRQnkKAk7v5KtT8tIwzmFCWC/uupElNnT/+Igf9XurRw+jkwDiHeRe7ucmHys0FyNtRfeAkL0WRzn6GhhDAzp3jl09yR65H6R6/68mCBHD2U3h8mal3WmViLNqfC8xyz/1XQhisEB4HaZiwX3zQIi44OTUZbTePPObgJbLuSrvir1iPkYKN/YZj5EYkE3b0X82Fg32dd8eyeiJOdjgUZHeVm8aAcBHScKuWrzhb7guQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEEvu0XVwR5ANFw5yHSRtWUalw91eLqTAPTuqHXyI/Q=;
 b=GbXT/HZe4v8RVR+uIjkKEP9yBwuRTAdmN5551PaXSY721WKM+AMXUuOf8yROj/DgF0g2sdbnHnsJUmfoxEa2Q1IxrTxs+WwXvUXL+52cZClWE7m7EFReD1Bb6nhIxxzMgs7XP0Cs5b4K3ijKc5ehQVg68FZquVe8pjB6UT3VpBIwL6gyiEEl1/WbELvNVvqdcY2egFFygC1mPOJMVe/TnZLbWi/zfkgUTGB1WMU64+bvZxlW0X5RY/4n8wdxnsy/EH2ZTUDvEaFs2CsrVnCS+gF6MU7Tm5Gpv+PHcWgSfMmoUvT7MbqTcBF+muDATmQ9amm3ANzpXdNrDMsAGyYx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEEvu0XVwR5ANFw5yHSRtWUalw91eLqTAPTuqHXyI/Q=;
 b=o3AT21geSseA07UndHl8HDNgMSBlrEYGIGU880QxwnqZr7grYKgrYbP8F8KqggUKK3Qm4Bbqv4fMgEsgXg7mAqFHDdn44hIUy2bH//A1Tr0Ijx0iS1W8M24HIDKqc8wNqFmEA3N6D+sTfimx3/todEFELzH+tQ8z6aVaFNjD/Vs=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM9PR04MB8146.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 10:31:36 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663%7]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 10:31:36 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
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
Subject: RE: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Thread-Topic: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Thread-Index: AQHYb0Sbzg3yRatDsU+sUlyHgY6zya2baFlwgCMCbCA=
Date:   Wed, 24 Aug 2022 10:31:35 +0000
Message-ID: <AM6PR04MB5925CFC53026A11F57115D1FE1739@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220524080337.1322240-1-joy.zou@nxp.com>
 <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38614ed3-be6f-4877-46f4-08da85bbd24c
x-ms-traffictypediagnostic: AM9PR04MB8146:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +fxmPa4uxl11sSmKVq41c1srH0Fu9uDi+jqny6MSyzvJ3OwK4DdZwCktbUnETjdfgW43FepzBeSW/IWZXiyUmhFA+QNYKMqKN4Mw1BMyrS78AsiMngjnFA632S33FTEcJOurEgDDhZpwJCy8XQJ2r2US7tBUqznKCYxKbjNw3lLVufiNW0jXTsqsIlAkf3CE35fEGHwDjWAqwZt6lLAO3EQSRTeN7WTKv/vuZUVzLl3bxP/jAGr7UpQay/Y3Vj1D0v0M6ETOYOE8bj45bGm6r7PBZnulhOBoP7Awawb6aT7GhEAh355nte3c4P/5IXPhrneq+XGaePtuLYFBrHclflOrGQzkGGAgSeudATuZ2N+yAixzorIOgoJ4RW5hZmpE5laOGh3jNIjPTYxw446QK/aYbW75X8Io+le3k62I+DQtcUpEvCX8GtGI9M2c6IyLEdj+Ww81ALpTjo2Qp7e5QW+KKX9Oyx8xt0HGl3Jan2Z4gLJn8xuZ9e2HcEuS+AvuJcvTF71CqdeZeIkG3Xp+8Pt9HS6Padj73+BPB1zp4EIRBrfL1OvAnHk21Pv6oAEiz8W6OREygjyNdd+dc2QQJ36JwiU0xvPo4flvmSvvKpzcMvBpdjhOLeLoK22NOCxzHot4h078A7fWBS8KxoUut1ZDq/MWzh3nDSodBaIKFN+iOlFsf7SQSfumnkY4rJel4Pl/9SkG474PwU0Oo5PUqbKLeaib3NF/o5sOkSruUWTiDjLckLLsu+okkSwR4iKxdKWU0LpMWbMPkuenXBaPVxv3zwuz1lBsUZ6rcXo+L3o5d+EMi50Vmciv+ft10ntRbieK3OLMGXfkEkDH5CxZjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(7416002)(122000001)(38100700002)(55016003)(44832011)(54906003)(33656002)(7696005)(86362001)(53546011)(9686003)(66476007)(66446008)(66556008)(64756008)(66946007)(6506007)(8676002)(4326008)(41300700001)(76116006)(26005)(316002)(5660300002)(52536014)(38070700005)(6916009)(8936002)(83380400001)(2906002)(71200400001)(186003)(478600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y3NLVlZpRklqS0E4dEV6VWNrdGpSckM3YUdCRjZ4cDVsUVBOaDNmcHFMaVlR?=
 =?gb2312?B?RXBBcGhNOVMyVzZHMjJRMlcrZzFZRFI3WE1yVHlTUlRYVm5pTkgxSDJhZGVB?=
 =?gb2312?B?a01OVk92TzZRajNDdDNIczQvN3JXYTJieGhiNzdYTFgzb1FrUVVnMHIwdEYr?=
 =?gb2312?B?UVZDaW8xVUlQUm9ueHVqWGFzOXFXZHVTUFRldDE5OFVIaEdnOXVlUHA1Q2pH?=
 =?gb2312?B?QXZkc1F4MHRpWVVpRVlKa2d0dDlmU2ljcnhmZUlzVGFqMi9Za08rNzlIbTRD?=
 =?gb2312?B?cCtWYWVhM3RwN21WV1RkWHp0bThRY0xNTFhzQmQ0cDJPek9EL1kzbnlCcFlI?=
 =?gb2312?B?QUdhMWkvNUdRSkdaRXltRENUUFZibXZ5TkRlUGk5YWR3VExTbTdaRmY1cGlq?=
 =?gb2312?B?czc2cUxZcjBxTmY5U01kazVSUUJwdEh0cnBuT055OVZXcEZ0aWNZOFpuTWIw?=
 =?gb2312?B?ZXh3b3VaSEJoYjFFWXlnTEhOR3g5QnJMdlh4dlNWeHgyKzgxMndKQWl4MTAy?=
 =?gb2312?B?Q2k2eVpkSDFhdVZicTJrelV6MjFIbTNkd2s0SURla3Exam00NUVVb3RkZVEy?=
 =?gb2312?B?T3lZYWRkUytjSWJKcDU0TmVaTktLWGFKQ2JmVGFOVWR5eHpFMmhybXUzbEdU?=
 =?gb2312?B?clIrajdDcTZiL2RGWEFDbTdkdnZROEhibGpnTjM2anljU0VkcXZudUplaENJ?=
 =?gb2312?B?MVlBLzFPMGJTcGZ4bEFJVEhkTTdhYlJFUFA0ZWJVWjNOZnU5elR4bDI2Sk9i?=
 =?gb2312?B?QS9NTU83b3RYY1hOQnAySTRicjBJVkxCWU1MZEFrVWlwVnVnZjdhWmN0SFpW?=
 =?gb2312?B?d3VxUDhyOUkyYk8rZXg0cjQ0WEMxSEgyNWFKalZtS0VJek9EbWhSRlB0cFR5?=
 =?gb2312?B?REt1NWRPS1V2Z2FnT1ltM2RLR21KTjk0QW5iVHZZWmNpR1FKOXhYR1JhdnlD?=
 =?gb2312?B?STMzd0E4Q3IwMmZXYVNDRXNhR2diVGlyMUtMVEEvelpucE5VZXA2aFpFVVh3?=
 =?gb2312?B?NVZTQXdkWWhnN0RXOXJQdVVzOWN1YU9jNG12aHFZUVF1Y1RtdE1NQmFnQ3pW?=
 =?gb2312?B?N1BCN0Zua1d3M1grSXpUZUV6U2Z5YTI4Sms0TlhudlNja1NhYUdDMHJDR3cr?=
 =?gb2312?B?cVpDRDk3TTBGT0gwSThFSW4wbkk3c1oyQW1RU21IMFdDcGJTSDRHc0J1bkJu?=
 =?gb2312?B?aVlVTnIwbysybUtpTGJGRzdSMi93K3NvRCtlZWtJeTQwMHBWTHpVVjNHejkx?=
 =?gb2312?B?R0N2aDlxdDVwTmpzdGwxdithTWN5RFRLOGZrSHRQQ1BaV2hNbXhQVnF2bllE?=
 =?gb2312?B?NkwydmpXMFNjeXF0bDZYUFVUSS9vdm5rVlV2M2gwVnVGNlo4MmhnNXNTNjd6?=
 =?gb2312?B?Ynh0ekxqd2EySDZlSHBkVGJLbFFSZnd6QytLSjJtUVVNNCt4Zy9jblF1SjN2?=
 =?gb2312?B?cVVMRlVyejdXSXlrQzd0c0pCZDBGdG1od1hrMFBxVTZqN2RjcVZ4alp0bHF1?=
 =?gb2312?B?MVhTcFlMWE5JS3pRNGI2TmdvWFE5NFV3bkwvSkE0bk1DUnUvbW9ocnByUXNy?=
 =?gb2312?B?cEtTQm52MlpEWU5heHhRa1hmM0NjSVNhNnJUVW8xVFl0VUw2VFhza0V4Q0VC?=
 =?gb2312?B?Tm5LNytwZEh5MVBXMTVnZ0NJdHZaSFhCNnRmYldSazlYMDMvU3N4Z0llZlk3?=
 =?gb2312?B?YzFxdlBvQ3R0Y0cySkNvNmNOdGVraGZYc1NuK2VTbHNuZWpwemF2WlFvdmF1?=
 =?gb2312?B?WlVUdmc3ZTd0cHE0b0MvWDcvQ29LM3JaaGJzNGtYd05najllQXJPdTNma0tm?=
 =?gb2312?B?RDRvcS9wQmJDOTFUNW82YjhnYXVGODJhUEVRTU1sZ1gyRkNKdStkNE5rekoz?=
 =?gb2312?B?dWp2Z2R1d1F0RCtSSSsxSmhhZUFPQ216Q1Q3ekx5Y3c3aWNuV2w3a3dkcGlT?=
 =?gb2312?B?K0RuWHdHeGtrMGQxODJFSHpjc1c3WXg4bkJjaEtmNlJORExreWFuT0VzTXNH?=
 =?gb2312?B?NjJ2Tlp0Slh1ZzcwVHRpZ054YnBYNTNJKzRWYUEwbm1rWVVkWEUvSW9GVWRx?=
 =?gb2312?B?cjU5bi9GajBUOXg2R2UwdU11NTR0SlgySFRnQTZSaytZYXBJaW9xTCs0QUl0?=
 =?gb2312?Q?+pUI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38614ed3-be6f-4877-46f4-08da85bbd24c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 10:31:35.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tmNHIv2ee574rHOyW7t2ja2HE+afA5WjXriWtvXyUsUdOSZwMGHJ3OTVD0ecOTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KQlINCkpveSBab3UNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogSm95IFpvdQ0KPiBTZW50OiAyMDIyxOo41MIyyNUgMTE6NTgNCj4gVG86IHZr
b3VsQGtlcm5lbC5vcmcNCj4gQ2M6IFMuSi4gV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPjsg
cm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7
IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBw
ZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBGVzogW1BBVENIIFYyIDEv
Ml0gYmluZGluZ3M6IGZzbC1pbXgtc2RtYTogRG9jdW1lbnQgJ0hETUkgQXVkaW8nDQo+IHRyYW5z
ZmVyDQo+IA0KPiBHZW50bGUgcGluZy4uLg0KPiANCj4gQlINCj4gSm95IFpvdQ0KPiANCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm95IFpvdQ0KPiBTZW50OiAyMDIyxOo1
1MIyNMjVIDE2OjAyDQo+IFRvOiB2a291bEBrZXJuZWwub3JnDQo+IENjOiBTLkouIFdhbmcgPHNo
ZW5naml1LndhbmdAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIIFYyIDEvMl0gYmluZGluZ3M6IGZzbC1pbXgtc2RtYTogRG9jdW1lbnQgJ0hE
TUkgQXVkaW8nDQo+IHRyYW5zZmVyDQo+IA0KPiBBZGQgSERNSSBBdWRpbyB0cmFuc2ZlciB0eXBl
Lg0KPiANCj4gY29udmVydCB0aGUgc2RtYSBiaW5kaW5ncyB0eHQgaW50byB5YW1sIGluIHYyLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiAtLS0NCj4g
Q2hhbmdlcyBzaW5jZSB2MToNCj4gY29udmVydCB0aGUgc2RtYSBiaW5kaW5ncyB0eHQgaW50byB5
YW1sIGluIHYyLg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14
LXNkbWEueWFtbCB8IDEzNSArKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
MzUgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnlhbWwNCj4gDQo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS55
YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNk
bWEueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjVi
NGY3YTA5YTM5NQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnlhbWwNCj4gQEAgLTAsMCArMSwxMzUgQEAN
Cj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1
c2UgJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvZG1hL2ZzbC1pbXgtc2RtYS55YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBGcmVlc2NhbGUgU21h
cnQgRGlyZWN0IE1lbW9yeSBBY2Nlc3MgKFNETUEpIENvbnRyb2xsZXIgZm9yIGkuTVgNCj4gKw0K
PiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj4g
Kw0KPiArYWxsT2Y6DQo+ICsgIC0gJHJlZjogImRtYS1jb250cm9sbGVyLnlhbWwjIg0KPiArDQo+
ICsjIEV2ZXJ5dGhpbmcgZWxzZSBpcyBkZXNjcmliZWQgaW4gdGhlIGNvbW1vbiBmaWxlDQo+ICsN
Cj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgaXRlbXM6DQo+ICsgICAg
ICAtIGVudW06DQo+ICsgICAgICAgICAgLSBmc2wsaW14MjUtc2RtYQ0KPiArICAgICAgICAgIC0g
ZnNsLGlteDMxLXNkbWENCj4gKyAgICAgICAgICAtIGZzbCxpbXgzMS10bzEtc2RtYQ0KPiArICAg
ICAgICAgIC0gZnNsLGlteDMxLXRvMi1zZG1hDQo+ICsgICAgICAgICAgLSBmc2wsaW14MzUtdG8x
LXNkbWENCj4gKyAgICAgICAgICAtIGZzbCxpbXgzNS10bzItc2RtYQ0KPiArICAgICAgICAgIC0g
ZnNsLGlteDUxLXNkbWENCj4gKyAgICAgICAgICAtIGZzbCxpbXg1My1zZG1hDQo+ICsgICAgICAg
ICAgLSBmc2wsaW14NnEtc2RtYQ0KPiArICAgICAgICAgIC0gZnNsLGlteDdkLXNkbWENCj4gKyAg
ICAgICAgICAtIGZzbCxpbXg2c3gtc2RtYQ0KPiArICAgICAgICAgIC0gZnNsLGlteDZ1bC1zZG1h
DQo+ICsgICAgICAgICAgLSBmc2wsaW14OG1tLXNkbWENCj4gKyAgICAgICAgICAtIGZzbCxpbXg4
bW4tc2RtYQ0KPiArICAgICAgICAgIC0gZnNsLGlteDhtcC1zZG1hDQo+ICsgICAgICAtIGVudW06
DQo+ICsgICAgICAgICAgLSBmc2wsaW14MzUtc2RtYQ0KPiArICAgICAgICAgIC0gZnNsLGlteDht
cS1zZG1hDQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIGRlc2NyaXB0aW9uOiBTaG91bGQgY29udGFp
biBTRE1BIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+ICsNCj4gKyAgaW50ZXJydXB0
czoNCj4gKyAgICBkZXNjcmlwdGlvbjogU2hvdWxkIGNvbnRhaW4gU0RNQSBpbnRlcnJ1cHQNCj4g
Kw0KPiArICBmc2wsc2RtYS1yYW0tc2NyaXB0LW5hbWU6DQo+ICsgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvc3RyaW5nDQo+ICsgICAgZGVzY3JpcHRpb246IFNob3Vs
ZCBjb250YWluIHRoZSBmdWxsIHBhdGggb2YgU0RNQSBSQU0gc2NyaXB0cyBmaXJtd2FyZS4NCj4g
Kw0KPiArICAiI2RtYS1jZWxscyI6DQo+ICsgICAgY29uc3Q6IDMNCj4gKyAgICBkZXNjcmlwdGlv
bjogfA0KPiArICAgICAgVGhlIGZpcnN0IGNlbGw6IHJlcXVlc3QvZXZlbnQgSUQNCj4gKw0KPiAr
ICAgICAgVGhlIHNlY29uZCBjZWxsOiBwZXJpcGhlcmFsIHR5cGVzIElEDQo+ICsgICAgICAgIGVu
dW06DQo+ICsgICAgICAgICAgLSBNQ1UgZG9tYWluIFNTSTogMA0KPiArICAgICAgICAgIC0gU2hh
cmVkIFNTSTogMQ0KPiArICAgICAgICAgIC0gTU1DOiAyDQo+ICsgICAgICAgICAgLSBTREhDOiAz
DQo+ICsgICAgICAgICAgLSBNQ1UgZG9tYWluIFVBUlQ6IDQNCj4gKyAgICAgICAgICAtIFNoYXJl
ZCBVQVJUOiA1DQo+ICsgICAgICAgICAgLSBGSVJJOiA2DQo+ICsgICAgICAgICAgLSBNQ1UgZG9t
YWluIENTUEk6IDcNCj4gKyAgICAgICAgICAtIFNoYXJlZCBDU1BJOiA4DQo+ICsgICAgICAgICAg
LSBTSU06IDkNCj4gKyAgICAgICAgICAtIEFUQTogMTANCj4gKyAgICAgICAgICAtIENDTTogMTEN
Cj4gKyAgICAgICAgICAtIEV4dGVybmFsIHBlcmlwaGVyYWw6IDEyDQo+ICsgICAgICAgICAgLSBN
ZW1vcnkgU3RpY2sgSG9zdCBDb250cm9sbGVyOiAxMw0KPiArICAgICAgICAgIC0gU2hhcmVkIE1l
bW9yeSBTdGljayBIb3N0IENvbnRyb2xsZXI6IDE0DQo+ICsgICAgICAgICAgLSBEU1A6IDE1DQo+
ICsgICAgICAgICAgLSBNZW1vcnk6IDE2DQo+ICsgICAgICAgICAgLSBGSUZPIHR5cGUgTWVtb3J5
OiAxNw0KPiArICAgICAgICAgIC0gU1BESUY6IDE4DQo+ICsgICAgICAgICAgLSBJUFUgTWVtb3J5
OiAxOQ0KPiArICAgICAgICAgIC0gQVNSQzogMjANCj4gKyAgICAgICAgICAtIEVTQUk6IDIxDQo+
ICsgICAgICAgICAgLSBTU0kgRHVhbCBGSUZPOiAyMg0KPiArICAgICAgICAgICAgICBkZXNjcmlw
dGlvbjogbmVlZHMgZmlybXdhcmUgbW9yZSB0aGFuIHZlciAyDQo+ICsgICAgICAgICAgLSBTaGFy
ZWQgQVNSQzogMjMNCj4gKyAgICAgICAgICAtIFNBSTogMjQNCj4gKyAgICAgICAgICAtIEhETUkg
QXVkaW86IDI1DQo+ICsNCj4gKyAgICAgICBUaGUgdGhpcmQgY2VsbDogdHJhbnNmZXIgcHJpb3Jp
dHkgSUQNCj4gKyAgICAgICAgIGVudW06DQo+ICsgICAgICAgICAgIC0gSGlnaDogMA0KPiArICAg
ICAgICAgICAtIE1lZGl1bTogMQ0KPiArICAgICAgICAgICAtIExvdzogMg0KPiArDQo+ICsgIGdw
cjoNCj4gKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgdG8gdGhlIEdlbmVyYWwgUHVycG9z
ZSBSZWdpc3RlciAoR1BSKSBub2RlDQo+ICsNCj4gKyAgZnNsLHNkbWEtZXZlbnQtcmVtYXA6DQo+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5
DQo+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gKyAgICAgIFJlZ2lzdGVyIGJpdHMgb2Ygc2RtYSBl
dmVudCByZW1hcCwgdGhlIGZvcm1hdCBpcyA8cmVnIHNoaWZ0IHZhbD4uDQo+ICsgICAgICAtIHJl
ZzogdGhlIEdQUiByZWdpc3RlciBvZmZzZXQNCj4gKyAgICAgIC0gc2hpZnQ6IHRoZSBiaXQgcG9z
aXRpb24gaW5zaWRlIHRoZSBHUFIgcmVnaXN0ZXINCj4gKyAgICAgIC0gdmFsOiB0aGUgdmFsdWUg
b2YgdGhlIGJpdCAoMCBvciAxKQ0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAgLSBjb21wYXRpYmxl
DQo+ICsgIC0gcmVnDQo+ICsgIC0gaW50ZXJydXB0cw0KPiArICAtIGZzbCxzZG1hLXJhbS1zY3Jp
cHQtbmFtZQ0KPiArICAtICIjZG1hLWNlbGxzIg0KPiArDQo+ICt1bmV2YWx1YXRlZFByb3BlcnRp
ZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICBzZG1hOiBkbWEt
Y29udHJvbGxlckA4M2ZiMDAwMCB7DQo+ICsgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg1MS1z
ZG1hIiwgImZzbCxpbXgzNS1zZG1hIjsNCj4gKyAgICAgIHJlZyA9IDwweDgzZmIwMDAwIDB4NDAw
MD47DQo+ICsgICAgICBpbnRlcnJ1cHRzID0gPDY+Ow0KPiArICAgICAgI2RtYS1jZWxscyA9IDwz
PjsNCj4gKyAgICAgIGZzbCxzZG1hLXJhbS1zY3JpcHQtbmFtZSA9ICJzZG1hLWlteDUxLmJpbiI7
DQo+ICsgICAgfTsNCj4gKw0KPiArI0RNQSBjbGllbnRzIGNvbm5lY3RlZCB0byB0aGUgaS5NWCBT
RE1BIGNvbnRyb2xsZXIgbXVzdCB1c2UgdGhlIGZvcm1hdA0KPiArI2Rlc2NyaWJlZCBpbiB0aGUg
ZG1hLWNvbnRyb2xsZXIueWFtbCBmaWxlLg0KPiArICAtIHwNCj4gKyAgICBzc2kyOiBzc2lANzAw
MTQwMDAgew0KPiArICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14NTEtc3NpIiwgImZzbCxpbXgy
MS1zc2kiOw0KPiArICAgICAgcmVnID0gPDB4NzAwMTQwMDAgMHg0MDAwPjsNCj4gKyAgICAgIGlu
dGVycnVwdHMgPSA8MzA+Ow0KPiArICAgICAgY2xvY2tzID0gPCZjbGtzIDQ5PjsNCj4gKyAgICAg
IGRtYXMgPSA8JnNkbWEgMjQgMSAwPiwNCj4gKyAgICAgICAgICAgICA8JnNkbWEgMjUgMSAwPjsN
Cj4gKyAgICAgIGRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQo+ICsgICAgICBmc2wsZmlmby1kZXB0
aCA9IDwxNT47DQo+ICsgICAgfTsNCj4gKw0KPiArLi4uDQo+IC0tDQo+IDIuMjUuMQ0KDQo=
