Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354060EE3D
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 05:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiJ0DBZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Oct 2022 23:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiJ0DBX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Oct 2022 23:01:23 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20040.outbound.protection.outlook.com [40.107.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A925144087;
        Wed, 26 Oct 2022 20:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TexGuk3ZQWelhjnmLPK/A7GmOgSuvPvhRffFg2Z7NcNagjascSzK2ExLxuh7ucaKM1K9HabV9xNEBFFAgoH76d68nAF6ZdtntvhnN9/ENcPp33yUeUiPiLCEPXWC5SNM02OJYX0YaJKCaalbJBH4CpYUWCAppVIHeoWT2tB9nceW4lsxnY33jU7ueZFz6OKyzjbxbOjP1OW695eH0kBp375kJtn97tnFIQ4y/fBv36EigmVbMNdn8huLf2ePINyzNOK0ubPUFZMzLclffdO5GQc9e1zzBqNRWZS9CizJ8EdSGXaSrWPcdP/BDs1SSs6SEJXhp21cboQzgiikVM+8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn+1V9g6TBoRPnrP0WWCl3CL2jViMtWeWVlnQiMY5lE=;
 b=H2eiQNSo6XR/Xslbdxncyd5H/Qt4nYPWMryY06SUUYPwXFmj4lvNRWXFGkGQkwMuk+a/d4I4ye9r57z3U6Sp4quylMDI+K6jhFGCNkW6MgsXtoFJSk81DjWNxPEZ8/QtvGRiMh11lmTpwhF2WWv5ld/eAQWBdbydUHjq1XioSWfRGGTrrtttsKRUsQiu2fNgyzCZVd97i1/nvMqO/WR1DEJA2GTC/HjVcBRrpBcll85PLDefh3J1hTkweHldZ+7l6lrZ+DRcfKchlN3jUvGGCP3aANHyvhldAwxktqftRzseKKzgGYFOtZhe31PIjOpJufezixn+O3UGuRbvPc9pFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn+1V9g6TBoRPnrP0WWCl3CL2jViMtWeWVlnQiMY5lE=;
 b=paDhe6uRh81xRaSNoKHNFQui8po7+GLQOffbEXrJlPD3X8t7+sjC6utVd21Ab6PpLJBfnz2SpAVfHyZ/vA6ADe09ie/vNXp3oMkS4EQ4x8jR6QxzkORJu1h1wBuzdMn2rzX6ZIiKCJJaJK8orTXs2H4MVoXpf1meyp2MgMxDJJQ=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 03:01:18 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 03:01:18 +0000
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
Thread-Index: AQHY6EyxpTiasLn3LEuxZxcLxXRE4q4gxluAgACyUXA=
Date:   Thu, 27 Oct 2022 03:01:18 +0000
Message-ID: <AM6PR04MB5925157A3A6F8ADB80371082E1339@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20221025083609.2129260-1-joy.zou@nxp.com>
 <20221025083609.2129260-2-joy.zou@nxp.com>
 <133f27f4-d92c-ef8d-4fc9-32387518e4c0@linaro.org>
In-Reply-To: <133f27f4-d92c-ef8d-4fc9-32387518e4c0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|PAXPR04MB8960:EE_
x-ms-office365-filtering-correlation-id: 8dc3187c-f4df-40c8-121e-08dab7c7851d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSafD6PxFj413oDuGuFZuupKRiu01evO53McKnCHG3FsoJeakcokMPfnMefr+TLrFvz9QATAxwuMavlLAq8wSFu9gNzH1kzb1c4SLTp5Y9L0Qoa+B8SlxA+BMibGOgs59rmaO82XjCgdwWzLz7jd828VtZQmpCh5Otsx+7X/LnhCuY4mI/StpHq86mRlpy53ZOsmx4sIfWgS74NTiCaxtdw5z7pHKAQHlDpJkv1w07y//n2jXRvpov9IMlaRTSLxp3cVHz9cGxvr0D1WFUi1su7Yb1+kPevZz0ikon0HAUoWkO9rjI3qPxObCBp3lkvi+3BbqAwtX5RLgWdAzVnGmqyUSS3Uu3xQl5rX4t41ifxRYUs86W6ROqbT3VAijwcyuHEyzcWArDA7Q4QLI0NiQxaZStwKk4lpD+e7ZB3Z06d8RrTbUxhAfRjMX2mj9U7LEvq8vCE6UW9Ek41aY8iaLkicJwiaaJZYLxBCdJnU2fP7YDcnY6kmCj7qZwbdSjX334esda+mvWtBOp9ioDmc9Pri8Ykg9sFZiBHtvgE3W49U5nPj6EPuyTFGH9BErlMD8+p03Btp/kAQLME+BgdJK3g5KbdN4qIyyzdh3jk/fXixk10TaU5Q6BObskHm+bNAxk3htCJr9B73uph3EAKKkRCuhBawQDOwD+FO+MuGMhGdimYLu1by4Ja9aPkR/mBtOZASrU+cQlHA5BB84/2wch93V7oDUO2LuwVRpsr6KefXng9W8XZxvDtAv6AfMSDOGAjaDuaXQJJ4yz60oByc7ajdcnmIrY1AZN0b6CIfpQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(26005)(8676002)(4326008)(6506007)(7696005)(66476007)(41300700001)(38100700002)(33656002)(478600001)(9686003)(64756008)(53546011)(44832011)(122000001)(2906002)(7416002)(186003)(66446008)(8936002)(38070700005)(86362001)(83380400001)(5660300002)(54906003)(52536014)(110136005)(66556008)(316002)(45080400002)(76116006)(71200400001)(55016003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?a3VBd1E0bEdEcXVoZHA0bGdOQnJRcytUWncrb3NNQ2RGQUtDL1VPYkkvU0pS?=
 =?gb2312?B?c09pSFp1bCs0QXhWOFN2elBoSCs4U0Z4dWh3dnY5TzV3YWlYcHNrV0FncWVB?=
 =?gb2312?B?SUlJbXZxMlJDZE9nOGRmczRiWnE1Y3VSNEREcU1VU0xIbElMVmIxNVpUb1Iz?=
 =?gb2312?B?QWNEOWtRSkVLQVcxSVBTWXdndTVxVk4wY3JWSWh6dVJhVjdWQUs2MlpWQ0N1?=
 =?gb2312?B?eXJoZHNnVnNFWFdmdUlMSDIyK0ZZTmFMTHJaU2QrMDVyTGV1RTUxTWRpaVEw?=
 =?gb2312?B?OTVEYjZmRGxiR3J2d1BIUzJKdmMxeklaaDk0VFJzUUMzV2F0KytsZ2sxNWpF?=
 =?gb2312?B?clpPZ2MxUDJBUU1vd0JkRmZpd3pNd2N6QTBoTnA0bVJkcG8rWlhwangza0lw?=
 =?gb2312?B?MWtjMm8rVGhpVkpjSTFOUjlBSzVCMkZxQlk2aEE0ZWs1UE5TZ3A2dnBCYnoz?=
 =?gb2312?B?Y1NJNnA0eUROOHNDaTNyZi9xU0N6M2VobTBiQ2g2VnZ3OWp0TWxWQjhDdXZ3?=
 =?gb2312?B?cFVFVzFYRXpCNzJ3QzdsOHcwR1Q3SVRVdVVUK2hvQUFZV1lreG0zR1RmU29h?=
 =?gb2312?B?Sk9KazhObC9OWDQxR2xyN3YrMmJLQ2JJaGdKV1h1WUt2Q2lwTHZtSW1yZkN5?=
 =?gb2312?B?bGpTS2VSSFBpQy8xaERCa3JwWlV5S3BUOUg5YnFrMW40MXlPUzBJUzJsZGc1?=
 =?gb2312?B?RHRNYVFpMWdtUEk2VElsY1ZJYzRKZFRRVzMyS0NSK0I2TGdPNXV4a2UyMDh0?=
 =?gb2312?B?QU9iM0hTcTA5eHVUY3FjZStTSHg4WTJYK3VQN2xwYlQ0Um5QZlFNRXg0aFVp?=
 =?gb2312?B?bWtvdTNheEhEV2VqYkVzYTExVmpmbFkzUEtQZjcvT1pRZ20wbGhBb3JGVXdC?=
 =?gb2312?B?ZERzSHM5RlQ3a2dmZmpTbkFwQ0xESThXNTRRZGQ4Vm5qQ04wdVZ5ZHp5ZUY3?=
 =?gb2312?B?UE14M0ZMZWcySzRPZVJ5ZTR0Mks4VEJ2cENYVlR2WUFSVUEyMFM3YXhCSnZz?=
 =?gb2312?B?OVB2TUZUN2cvRGtieFRmUVlBNWQwamZOWFZsQUdDWlUwTitaVlRRVUFHbENo?=
 =?gb2312?B?V05qV0pBTjRhTTZaRytwek5ZYS9rbnN5Rm43dlJtQldneFFUdGoyQkhPVUlK?=
 =?gb2312?B?bGMxUENmT215TGZNUitqdkpzdTFpSVB2UTE0M0RnMU9Pb0M1aFFjemtxWk53?=
 =?gb2312?B?ZE5lSXVjTWFSeitSZmc4a1l5Ym1KVVQ1RG5DcUpKNENxQVJIcnI0K2N1VmJB?=
 =?gb2312?B?US9rUVpJY053UE5sS3FMeUJ2OWZSRUFqWXQvNzRVWW12RmVRa3ozbnoxd3FG?=
 =?gb2312?B?b3BBOVFNdzNYRDdLNVJlZXZxeHVxNHJkdGhNL2ZndUpIV0R2b3YrY21zQVV6?=
 =?gb2312?B?Q0xSVW4xdExCU1lDeGZPVnBHQ0RNN3ZEMnVTc0RVYzQ5Y01SdzJYa0p1VjE4?=
 =?gb2312?B?SGllbEpRQnB2NDZEaGs3SExlTEdZTlM4Z2NJMCtNSlNpbkVtbGo0VnordzFG?=
 =?gb2312?B?SjZSckswWXgyTDd6dml5dVBDcEhPRmVrUXMyM3lmM252Z2FSeFpXZzQwdE1l?=
 =?gb2312?B?SnhSMUdEOWkzeFNoSUtTa2trcEhOVlIvdU83YjQ2QWszSjBpSGFjMTV6czBx?=
 =?gb2312?B?a0FwenZsTWNhbkNxWmRTQzlqbWhOVzBkRHE5cGgxQkg2VFE5aGhDUGRqRm9p?=
 =?gb2312?B?ZFE4N1p6TVlmSUt3UVBCTFlzejZMTVdITHdGdDNHYi9ycXdFbXhIZzkycml3?=
 =?gb2312?B?cFFSanJUeWJZeFFpaUNNdWNwc2hLTUxRUUxTb085UUkvZ05ZMDczRjRMaHV6?=
 =?gb2312?B?dE5Yd2xQYjJOYldCeVV0MlhDWGFtK1Q2L0JkRklyTDhhOEQ4QkxsYmh4dmZo?=
 =?gb2312?B?THU0d1dKVG4wRU9DcFhzeFNNUjdDQmhpcWhNcGNiR2pNZUxGVjk4QVFLZ1Yx?=
 =?gb2312?B?WmRiOW4wcE1ySGs4ZDVUZU90SVVHZjJqUy9WRVc0dnhjbTkrMW5QRGRBM3RK?=
 =?gb2312?B?ZzRBZkNoVWV1bzFjK0FsNzM1dVZoUXZLN3paUFFmYkUzL1pOQ2JFeHNMZm1s?=
 =?gb2312?B?SkRXc2w4ZFhtb2lHNmdCSHZxUEdKNXk2Wi8ySDRxSW9oYTk5WDBhQVlwSDRl?=
 =?gb2312?Q?cYgE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc3187c-f4df-40c8-121e-08dab7c7851d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 03:01:18.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SEB2vsw2C1R0fQvBb98iaGHykuiQXVPSpukJoa6COSDb18haXqoeQgJLfT6D06Gl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960
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
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMsTqMTDUwjI2
yNUgMjI6NTkNCj4gVG86IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogUy5KLiBXYW5nIDxz
aGVuZ2ppdS53YW5nQG54cC5jb20+OyBtYXJ0aW5rQHBvc3Rlby5kZTsNCj4gZGV2QGx5bnhleWUu
ZGU7IGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb207IFBlbmcgRmFuDQo+IDxwZW5nLmZh
bkBueHAuY29tPjsgZGF2aWRAaXhpdC5jejsgYWZvcmQxNzNAZ21haWwuY29tOyBIb25neGluZyBa
aHUNCj4gPGhvbmd4aW5nLnpodUBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT47DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2OCAxLzJd
IGR0LWJpbmRpbmdzOiBmc2wtaW14LXNkbWE6IENvbnZlcnQgaW14IHNkbWENCj4gdG8gRFQgc2No
ZW1hDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDI1LzEwLzIwMjIgMDQ6MzYs
IEpveSBab3Ugd3JvdGU6DQo+ID4gQ29udmVydCB0aGUgaS5NWCBTRE1BIGJpbmRpbmcgdG8gRFQg
c2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gPg0KPiA+IFRoZSBjb21wYXRpYmxl
cyBmc2wsaW14MzEtdG8xLXNkbWEsIGZzbCxpbXgzMS10bzItc2RtYSwNCj4gPiBmc2wsaW14MzUt
dG8xLXNkbWEgYW5kIGZzbCxpbXgzNS10bzItc2RtYSBhcmUgbm90IHVzZWQuIFNvIG5lZWQgdG8N
Cj4gPiBkZWxldGUgaXQuIFRoZSBjb21wYXRpYmxlcyBmc2wsaW14NTAtc2RtYSwgZnNsLGlteDZz
bGwtc2RtYSBhbmQNCj4gPiBmc2wsaW14NnNsLXNkbWEgYXJlIGFkZGVkLiBUaGUgb3JpZ2luYWwg
YmluZGluZyBkb24ndCBsaXN0IGFsbCBjb21wYXRpYmxlIHVzZWQuDQo+ID4NCj4gPiBJbiBhZGRp
dGlvbiwgYWRkIG5ldyBwZXJpcGhlcmFsIHR5cGVzIEhETUkgQXVkaW8uDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdl
cyBpbiB2ODoNCj4gPiBhZGQgdGhlIGRtYS1jb250cm9sbGVyIHF1b3Rlcy4NCj4gDQo+IFdoeSBh
ZGRpbmcgcXVvdGVzPw0KSSByZWZlciB0byB5b3VyIGNvbW1lbnRzIGluIHBhdGNoIHY3LzEuIFRo
ZSBjb21tZW50IGFzIGZvbGxvdzoNCittYWludGFpbmVyczoNCisgIC0gSm95IFpvdSA8am95Lnpv
dUBueHAuY29tPg0KKw0KWW91IG5lZWQgdG8gcmVmZXJlbmNlIGRtYS1jb250cm9sbGVyLnlhbWwg
c2NoZW1hLg0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBvbmUgb2Y6DQpJIG1p
c3VuZGVyc3RhbmQgdGhhdCBhZGQgdGhlIGRtYS1jb250cm9sbGVyLnlhbWwgcXVvdGVzLiBTbyBJ
IGFtIGEgbGl0dGxlIGNvbmZ1c2VkLiBOb3csIEkgc2VlLg0Kc2hvdWxkIEkgYWRkIGRtYS1jb21t
b24ueWFtbCBxdW90ZXMgYnV0IG5vdCB0aGUgZG1hLWNvbnRyb2xsZXI/IA0KVGhhbmsgeW91IHZl
cnkgbXVjaCB5b3VyIGNvbW1lbnRzLg0KQlINCkpveSBab3UNCj4gDQo+ID4gZGVsZXRlICNkbWEt
Y2VsbHMgaW4gcmVxdWlyZWQuDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHY2Og0KPiA+IGRlbGV0ZSB0
YWcgQWNrZWQtYnkgZnJvbSBjb21taXQgbWVzc2FnZS4NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjU6
DQo+ID4gbW9kaWZ5IHRoZSBjb21taXQgbWVzc2FnZSBmcm9tYXQuDQo+ID4gYWRkIGFkZGl0aW9u
YWxQcm9wZXJ0aWVzLCBiZWNhdXNlIGRlbGV0ZSB0aGUgcXVvdGVzIGluIHBhdGNoIHY0Lg0KPiA+
IGRlbGV0ZSB1bmV2YWx1YXRlZFByb3BlcnRpZXMgZHVlIHRvIHNpbWlsYXIgdG8gYWRkaXRpb25h
bFByb3BlcnRpZXMuDQo+ID4gbW9kaWZpY2F0aW9uIGZzbCxzZG1hLWV2ZW50LXJlbWFwIGl0ZW1z
IGFuZCBkZXNjcmlwdGlvbi4NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gbW9kaWZ5IHRo
ZSBjb21taXQgbWVzc2FnZS4NCj4gPiBkZWxldGUgdGhlIHF1b3RlcyBpbiBwYXRjaC4NCj4gPiBt
b2RpZnkgdGhlIGNvbXBhdGlibGUgaW4gcGF0Y2guDQo+ID4gZGVsZXRlIG1heGl0ZW1zIGFuZCBh
ZGQgaXRlbXMgZm9yIGNsb2NrLW5hbWVzIHByb3BlcnR5Lg0KPiA+IGFkZCBpcmFtIHByb3BlcnR5
Lg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiBtb2RpZnkgdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KPiA+IG1vZGlmeSB0aGUgZmlsZW5hbWUuDQo+ID4gbW9kaWZ5IHRoZSBtYWludGFpbmVyLg0K
PiA+IGRlbGV0ZSB0aGUgdW5uZWNlc3NhcnkgY29tbWVudC4NCj4gPiBtb2RpZnkgdGhlIGNvbXBh
dGlibGUgYW5kIHJ1biBkdF9iaW5kaW5nX2NoZWNrIGFuZCBkdGJzX2NoZWNrLg0KPiA+IGFkZCBj
bG9ja3MgYW5kIGNsb2NrLW5hbWVzIHByb3BlcnR5Lg0KPiA+IGRlbGV0ZSB0aGUgcmVnIGRlc2Ny
aXB0aW9uIGFuZCBhZGQgbWF4SXRlbXMuDQo+ID4gZGVsZXRlIHRoZSBpbnRlcnJ1cHRzIGRlc2Ny
aXB0aW9uIGFuZCBhZGQgbWF4SXRlbXMuDQo+ID4gYWRkIHJlZiBmb3IgZ3ByIHByb3BlcnR5Lg0K
PiA+IG1vZGlmeSB0aGUgZnNsLHNkbWEtZXZlbnQtcmVtYXAgcmVmIHR5cGUgYW5kIGFkZCBpdGVt
cy4NCj4gPiBkZWxldGUgY29uc3VtZXIgZXhhbXBsZS4NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjI6
DQo+ID4gY29udmVydCBpbXggc2RtYSBiaW5kaW5ncyB0byBEVCBzY2hlbWEuDQo+ID4gLS0tDQo+
ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wsaW14LXNkbWEueWFtbCB8IDE0OQ0K
PiA+ICsrKysrKysrKysrKysrKysrKyAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1p
bXgtc2RtYS50eHQgIHwNCj4gPiAxMTggLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAxNDkgaW5zZXJ0aW9ucygrKSwgMTE4IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4g
PiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wsaW14LXNk
bWEueWFtbA0KPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxpbXgtc2RtYS55YW1s
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxpbXgtc2Rt
YS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LmZlNTI3ZDMyY2RiNg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxpbXgtc2RtYS55YW1sDQo+ID4gQEAgLTAsMCAr
MSwxNDkgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiAraHR0cHM6
Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYl
MkZkZXZpDQo+ID4NCj4gK2NldHJlZS5vcmclMkZzY2hlbWFzJTJGZG1hJTJGZnNsJTJDaW14LXNk
bWEueWFtbCUyMyZhbXA7ZGF0YT0wNQ0KPiAlN0MwMSUNCj4gPg0KPiArN0Nqb3kuem91JTQwbnhw
LmNvbSU3QzY1ODYxZWZkOWYxYjQ1ZTFlMjg3MDhkYWI3NjI5ZjA3JTdDNjg2ZWExDQo+IGQzYmMy
Yg0KPiA+DQo+ICs0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4MDIzOTMxNDQ1OTMw
MTgzJTdDVW5rbm93bg0KPiAlN0NUV0ZwYkdaDQo+ID4NCj4gK3NiM2Q4ZXlKV0lqb2lNQzR3TGpB
d01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TQ0KPiBuMCUNCj4g
Pg0KPiArM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT12a0l3cHYlMkZiJTJGQTduV0dHVEV5
WjdtYSUyQg0KPiBBbHFMNW8lMkZ6RQ0KPiA+ICtJSkR2MjNTTjNQbyUzRCZhbXA7cmVzZXJ2ZWQ9
MA0KPiA+ICskc2NoZW1hOg0KPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUy
Rm1ldGEtc2NoZW1hcyUyRmNvcmUueWFtbCUyMyZhbXA7ZGF0YT0wNSU3QzAxJTdDam95LnoNCj4g
b3UlNA0KPiA+DQo+ICswbnhwLmNvbSU3QzY1ODYxZWZkOWYxYjQ1ZTFlMjg3MDhkYWI3NjI5ZjA3
JTdDNjg2ZWExZDNiYzJiNGM2Zg0KPiBhOTJjZDk5DQo+ID4NCj4gK2M1YzMwMTYzNSU3QzAlN0Mw
JTdDNjM4MDIzOTMxNDQ1OTMwMTgzJTdDVW5rbm93biU3Q1RXRnBiRw0KPiBac2IzZDhleUpXSWoN
Cj4gPg0KPiArb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxD
SlhWQ0k2TW4wJTNEJTdDMw0KPiAwMDAlNw0KPiA+DQo+ICtDJTdDJTdDJmFtcDtzZGF0YT1aV2F1
Z3FtVm1RQnZUJTJCNTBFU04xTHNMUEpDUmhQbDQwUlBhakdrWDENCj4gbUpZJTNEJmFtDQo+ID4g
K3A7cmVzZXJ2ZWQ9MA0KPiA+ICsNCj4gPiArdGl0bGU6IEZyZWVzY2FsZSBTbWFydCBEaXJlY3Qg
TWVtb3J5IEFjY2VzcyAoU0RNQSkgQ29udHJvbGxlciBmb3INCj4gPiAraS5NWA0KPiA+ICsNCj4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4g
Kw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6ICJkbWEtY29udHJvbGxlci55YW1sIyINCj4g
DQo+IERyb3AgcXVvdGVzLg0KPiANCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29t
cGF0aWJsZToNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
