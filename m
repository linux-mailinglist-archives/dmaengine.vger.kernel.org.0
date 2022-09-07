Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5725AFCCC
	for <lists+dmaengine@lfdr.de>; Wed,  7 Sep 2022 08:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiIGGsp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Sep 2022 02:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIGGsZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Sep 2022 02:48:25 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A9832E5;
        Tue,  6 Sep 2022 23:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjhPq9okXjMx+w2xrN0IFud6SgAnGH/som5sn9RMJyA9HdqzT2N1fXk6NIoAo+WO6Zqmf5UJhSj48VH+rVhKdhfPp0N456Oa2pJakl9Cw8s7NZA9zbJhn8KFp5brie1bWnUgq7rPnIn1WOFP8KoMzwTbiJ35P8RaTgHwgvIaX90Ztu0VReJT8ga62nsqJdO6OD6VRGm/Ed2zaY96+DB5NQEeVfpRLZ0vi5PtDg0ZfaAmm5PyBlQytAis6skSm7K6/fhamn/uMbWSbuQ2f5CN0n5ZH5YLzGu3j3JYQ1jPYJTTMmXTa/ZVjo8+O/bHSgHkcnZ7x509qOrmVhLNXSYwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cclxaKBt11VgfCTqbfVmnAs0a/Fsmh5OPy7QmvQ7xvE=;
 b=cMe0JCSF6SItePj1T0vxXSL8+04SruF3Ks5wnp5RNNwz17H0A68vRHxwhMYrI/D2PF2hlbSQQRMgwUw21o5VWEzFhNI3QjJE/Ugydy2pupTaDnLVehmQJb5sFpP030x1hxQ+i9uj10GnmTzDZBYQBVtMX3gGwBtgXIZ41+wSGXbWcL3LhvmIyNdSmp2tU1b7LUX8W7zrTmeT9T1gMUByPBw/aHrCFd1dTEEslvOw5ZN8oUdY0nJnDz7wckoj0zMpIx3aJ4yORglccZAGixHUttDE/aepmoJ80loN/3HqiA2ZuOQI0xy3vo8kfmOOZQAYZ91CmD+XJSGqXShmUyGN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cclxaKBt11VgfCTqbfVmnAs0a/Fsmh5OPy7QmvQ7xvE=;
 b=SgcdQ596LVYN3fY+dxsZStpW3EJIOxG9ILUsNGVam1uPMXqifegqmzW8OWEs6nmE5eCGlwv6ji9Ok1MwtWqKS3FQPB01tYNbtsIa3YmsJ6Au124OIVYJgLsiUioTMrOF3VRloApW2Fu9z97p4Owakx8P02eeu6bUDCN3UHSbZrI=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AS8PR04MB8149.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 06:48:17 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 06:48:16 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "dev@lynxeye.de" <dev@lynxeye.de>, Peng Fan <peng.fan@nxp.com>,
        "david@ixit.cz" <david@ixit.cz>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v6 1/4] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Topic: [EXT] Re: [PATCH v6 1/4] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Index: AQHYwdXGRcsso9Efq0uTyDVTXTO63K3SOpoAgAACwACAAFmigIAA7tmA
Date:   Wed, 7 Sep 2022 06:48:16 +0000
Message-ID: <AM6PR04MB5925901132A9C35E47AE3F02E1419@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220906094256.3787384-1-joy.zou@nxp.com>
 <20220906094256.3787384-2-joy.zou@nxp.com> <4743969.GXAFRqVoOG@steina-w>
 <AM6PR04MB59257DD8A94B63D419737756E17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <20220906162551.GA636621-robh@kernel.org>
In-Reply-To: <20220906162551.GA636621-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9889d66f-b0f3-4491-7920-08da909cf169
x-ms-traffictypediagnostic: AS8PR04MB8149:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6MqQMShzmz6KNqq2qlDsJtXmcc23yFfA3gMuDABFVscLeE8JHc/HZg/J1vwy2eSxtNtAU+j2CPPW3npDJVabVd+r/Wa2+JcjiWtezmQbNRzqO7ZJDAKNBmDjSS8frh4edQXJc0pMZ3CIZnddsq/84SBSGQjGskWg2BrMre0EEtt7/f7hoU7Qn7zLQrYXMJ7scuuXscEu416u+N7H11vRH+i68KZC6CZqLHpNUnGc6e7ky76RhCYbKAnb+aKH+kMzzehEJZDaK6+obsge2hKjYjAihyyfuV0zvIO6AFJ3R9+J47r3vFzJjdop7Zi3AAvPolmBJhO5uEMuOQIOsoDG15B73qoH9Bq0EjoQdf2hyE/+V4RJjFvErPt5TEBuISUniFPPlyFIa9NiAFJ8TrHsl5qIOlEAlON0FOLF7ZX8lpLRrac8afTpRAV4DGXhHrw56IjPPmDLWV52U3kEdt5RLgA+Lcr4NTfjCFgTXwqZY48RZ+Qod8UlNdtmBJxcQMSc6lZMXYfyAGtiJsKS6U1jsCbKS3dWcBqlB2486mQu7BMsXqQDCwUFpRfOosNIIPIAJwFYFxSDUOEnmi5j5S70pBJKpEcYuKfm0PHtN1prsBNXmMvX5tT8e5N/HhVij2fMAHRroWIxmz3pap33LmUzWvtJYz3BbebFLmUApP6NEjr2r9yw/SPiI7oLfx2FXlNsKtVTn6Tb620Pawks43+hKlH2DLrakZ9K4jh6qaBf7Y103sD84adgdnKSQMmIFmZCmdiKoiOf0Ou5UxBVsHpLMrC30sZqHRQXK0dgUtvNfw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(54906003)(66446008)(66946007)(83380400001)(33656002)(66476007)(186003)(64756008)(8936002)(8676002)(66556008)(5660300002)(7416002)(76116006)(52536014)(4326008)(26005)(6506007)(53546011)(7696005)(478600001)(71200400001)(41300700001)(45080400002)(316002)(6916009)(86362001)(9686003)(44832011)(38100700002)(55016003)(2906002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Rm9iOE1NWUJ3amhhUitveUxjYmpuRFp6TzYvWHh5NzZCVSthUXhHQlh0cW50?=
 =?gb2312?B?NGpGMG8xd1FFSnVqZittRnR3OERPWEdvL3FSRGtSUUU4TWxwOEpJa3h6YmNE?=
 =?gb2312?B?SG5TTFNOS1dTY1Z5V3hOamRzTEd5YThIVE01QlVKNVRZRndTbWZzSi9Jb3hk?=
 =?gb2312?B?VERwdk1BVjdSYUZXVlgwWU1TdFpXaFJXVHUveGxOSXhGcjVIa1Mrbi9jb3pB?=
 =?gb2312?B?SW8rMTJheTZvclZhTHQ0T1IzOWtqU094cjM1NjNwbFY0R29TNnN2TVlFbm5t?=
 =?gb2312?B?SmdQYVhTZ3Q4Qzh6NWZhd1pZWTl6TzFLRERweW9GdE9oWDdNclQ2T09tU24y?=
 =?gb2312?B?eFRsRGZjUGQ3dnRjZ21lYldIZTBRTWFTOUFpRUFITUdzRjhyRzMzQlIrZldi?=
 =?gb2312?B?Z3psai9aMU9NK1pzMk5OVkJwc2FLeTlDTFo3UE00NDFObitYWUlSUk9IbzNx?=
 =?gb2312?B?bzJWTWVrWVVhQXN6UWpWRHJlZ3BEbkphdXZvM3NIVTJYRGdaZGx1bHM1VWVi?=
 =?gb2312?B?ZThBbm95Q3FOYVJxSFlrWUF2dUFPN0xYajl6eDl0a0xwL24zYmNFMmhvd28w?=
 =?gb2312?B?N0NqS0M3YnJMTGdTckczUVppUGJiRG53d285QmhPS1BFUEtVM2ErUS82UFMw?=
 =?gb2312?B?RUdJTFh2eURreHI2SythNXJ5SGlFODgycElBNHRsUk1hMG9uV2I5Vm1MUXhQ?=
 =?gb2312?B?MEEza1E1Tzc5YTJQRUo5SEtpY1B6VHh6ZTBobDJjeXBxNWdzdGdMdkFYRkZ3?=
 =?gb2312?B?WFc0a2VmbytMejRZb0ttZ00ySzNkZDk2bHpoVTlmaUFYbll4aHppaWtPdUNR?=
 =?gb2312?B?YmV2K2k2Uk1Za2JwUm9CQnNxbFhBaW83TGtrb0RFTGdFd05kQzJHSDB1c01x?=
 =?gb2312?B?Z3JlK2g2UnJiSTZGT0MwMnNSSE9wcm1PdE5HQlpsN3IwNmpvTFlqalM2YWI5?=
 =?gb2312?B?WHRmVXNxQzAxbEg0TWVYNlppQXBzWUdpMEE3TGFQMVRTSzkrMENnQ0J1WVVs?=
 =?gb2312?B?amdId1AxSFltSi9DSS9aNVhrVVdvejlRSWE2M25ObFIvZEdFQXNYNTF6QXdI?=
 =?gb2312?B?NVpxVzNrVzkveWNwVngydXRjS2hQbndWdWlBSEJKMDg2OTcwaG1ZREdPMXdj?=
 =?gb2312?B?dis0ZndnWXgyRUZRZ0FLQXRjUU5iSlYzSEZPV2d3dk1ZUURYd01aNmtVN1Bh?=
 =?gb2312?B?LzdIZ0hMUHVaQy9ZRUdWQXg2eW9sTzg1WTdGaWJqem03cjdWamxUU29CM0p4?=
 =?gb2312?B?MlJJYVZKSzkyYkNHY2FWTUxzeWZ5UUQ5azlmdTBFd1FxV3k4cXJJVWNMcGF0?=
 =?gb2312?B?TG9KMk1odW9vYjNFRzdoVzVoSk9hZGJhTkI3Wk5wU2ZJYTYxdU84NHAvL2o3?=
 =?gb2312?B?Q0pHS0VrWlJWNjRnLzd4bDlvR1hrc2NkOHZobXF3RDdLRkl2bG9zcC9QZ0sx?=
 =?gb2312?B?ei9CL1ZBeU1BT2NBczl0TThmRmMzVmNIUk93eEJ2SC9mRmhQWkRUb2N3R0FE?=
 =?gb2312?B?RHhPVTNFMXAwL3ZlcU1iejZCem4xMGg5RlhpbXRMdDZETkJEZDhMNTJ6N0lh?=
 =?gb2312?B?K0twNVVYSTBmYWs1WVBreWZoTGR2Qlk5c2tSQjBxQ1B1aEdKc0l2Q09nanpT?=
 =?gb2312?B?dkZ6MDY3TmdEbVpiSHN6YzZRWW15L2IzdmFmU0Fxb2grYVZJTmhWaUcrbWti?=
 =?gb2312?B?TVZDVzhJVXp0R0UrL1RPT1Y1RmRVb1dIRFQ0MXV5Q2ZKK2ZJbUZ3bElZMnY0?=
 =?gb2312?B?Yk50K0MrSkx4L2VEQnl1aHc0UlhNajEzTEdmazhxU3YwRUVraDVVc3BxRXU1?=
 =?gb2312?B?eGlCUld3YjRlNngyYTV0OTdJRFl3ZU9aNU5lMG8rVzlFV2pCUTVzRi93UWR5?=
 =?gb2312?B?SnlqNytGOVg5bXN0UTdybVB5NDVzUzRxb0Nvc3hRMzRUWDU5aWhkL1Q3YVFw?=
 =?gb2312?B?aldOM3Y2T0ZEWjF6QlNoNDZhUy9zcW1WRWZ3Q0VTRmpRWWFaRzEyQ2U4WUow?=
 =?gb2312?B?M0RZK25SSFVNbndzaDFHcXJTRUkwZUd3TXgvNW50VVRWWFRDTTFTVUVobFZP?=
 =?gb2312?B?d3h4dWlIRnl1aDU3bWp4QjZ3MDlpY3hOQ1ltbXBkaXpqcHdLZjZnQnVZSkQ2?=
 =?gb2312?Q?TjDc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9889d66f-b0f3-4491-7920-08da909cf169
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 06:48:16.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vd99ysBAr9XIFc5RfgE6ghQUuHujrRuj4ec0ktByPM7QR37AP5r7L+kcINF6zV8J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jnUwjfI1SAwOjI2DQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhhbmRlci5zdGVpbkBl
dy50cS1ncm91cC5jb20+OyB2a291bEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tp
K2R0QGxpbmFyby5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBTLkouDQo+
IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT47IG1hcnRpbmtAcG9zdGVvLmRlOyBkZXZAbHlu
eGV5ZS5kZTsgUGVuZw0KPiBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBkYXZpZEBpeGl0LmN6OyBh
Zm9yZDE3M0BnbWFpbC5jb207IEhvbmd4aW5nIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+
OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gZG1hZW5naW5lQHZnZXIua2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2NiAxLzRdIGR0LWJpbmRpbmdzOiBmc2wtaW14LXNk
bWE6IENvbnZlcnQgaW14DQo+IHNkbWEgdG8gRFQgc2NoZW1hDQo+IA0KPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4gDQo+IE9uIFR1ZSwgU2VwIDA2LCAyMDIyIGF0IDExOjEzOjQxQU0gKzAwMDAsIEpv
eSBab3Ugd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+
DQo+ID4gPiBTZW50OiAyMDIyxOo51MI2yNUgMTg6NTUNCj4gPiA+IFRvOiBKb3kgWm91IDxqb3ku
em91QG54cC5jb20+DQo+ID4gPiBDYzogdmtvdWxAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwu
b3JnOw0KPiA+ID4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiA+ID4gc2hh
d25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJv
bml4LmRlOw0KPiA+ID4gZmVzdGV2YW1AZ21haWwuY29tOyBTLkouIFdhbmcgPHNoZW5naml1Lndh
bmdAbnhwLmNvbT47DQo+ID4gPiBtYXJ0aW5rQHBvc3Rlby5kZTsgZGV2QGx5bnhleWUuZGU7IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gPiA+IGRhdmlkQGl4aXQuY3o7IGFmb3JkMTcz
QGdtYWlsLmNvbTsgSG9uZ3hpbmcgWmh1DQo+ID4gPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBk
bC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gPiA+IGRtYWVuZ2luZUB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiA+ID4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NiAxLzRdIGR0LWJpbmRpbmdz
OiBmc2wtaW14LXNkbWE6IENvbnZlcnQNCj4gPiA+IGlteCBzZG1hIHRvIERUIHNjaGVtYQ0KPiA+
ID4NCj4gPiA+IENhdXRpb246IEVYVCBFbWFpbA0KPiA+ID4NCj4gPiA+IEhpLA0KPiA+ID4NCj4g
PiA+IHRoYW5rcyBmb3IgdGhlIFlBTUwgY29udmVyc2lvbiBwYXRjaC4NCj4gPiA+DQo+ID4gPiBB
bSBEaWVuc3RhZywgNi4gU2VwdGVtYmVyIDIwMjIsIDExOjQyOjUzIENFU1Qgc2NocmllYiBKb3kg
Wm91Og0KPiA+ID4gPiBDb252ZXJ0IHRoZSBpLk1YIFNETUEgYmluZGluZyB0byBEVCBzY2hlbWEg
Zm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgY29tcGF0aWJs
ZXMgZnNsLGlteDMxLXRvMS1zZG1hLCBmc2wsaW14MzEtdG8yLXNkbWEsDQo+ID4gPiA+IGZzbCxp
bXgzNS10bzEtc2RtYSBhbmQgZnNsLGlteDM1LXRvMi1zZG1hIGFyZSBub3QgdXNlZC4gU28gbmVl
ZCB0bw0KPiA+ID4gPiBkZWxldGUgaXQuIFRoZSBjb21wYXRpYmxlcyBmc2wsaW14NTAtc2RtYSwg
ZnNsLGlteDZzbGwtc2RtYSBhbmQNCj4gPiA+ID4gZnNsLGlteDZzbC1zZG1hIGFyZSBhZGRlZC4g
VGhlIG9yaWdpbmFsIGJpbmRpbmcgZG9uJ3QgbGlzdCBhbGwgY29tcGF0aWJsZQ0KPiB1c2VkLg0K
PiA+ID4gPg0KPiA+ID4gPiBJbiBhZGRpdGlvbiwgYWRkIG5ldyBwZXJpcGhlcmFsIHR5cGVzIEhE
TUkgQXVkaW8uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpveSBab3UgPGpveS56
b3VAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IENoYW5nZXMgaW4gdjY6DQo+ID4gPiA+
IGRlbGV0ZSB0YWcgQWNrZWQtYnkgZnJvbSBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4NCj4gPiA+
ID4gQ2hhbmdlcyBpbiB2NToNCj4gPiA+ID4gbW9kaWZ5IHRoZSBjb21taXQgbWVzc2FnZSBmcm9t
YXQuDQo+ID4gPiA+IGFkZCBhZGRpdGlvbmFsUHJvcGVydGllcywgYmVjYXVzZSBkZWxldGUgdGhl
IHF1b3RlcyBpbiBwYXRjaCB2NC4NCj4gPiA+ID4gZGVsZXRlIHVuZXZhbHVhdGVkUHJvcGVydGll
cyBkdWUgdG8gc2ltaWxhciB0byBhZGRpdGlvbmFsUHJvcGVydGllcy4NCj4gPiA+ID4gbW9kaWZp
Y2F0aW9uIGZzbCxzZG1hLWV2ZW50LXJlbWFwIGl0ZW1zIGFuZCBkZXNjcmlwdGlvbi4NCj4gPiA+
ID4NCj4gPiA+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiA+ID4gbW9kaWZ5IHRoZSBjb21taXQgbWVz
c2FnZS4NCj4gPiA+ID4gZGVsZXRlIHRoZSBxdW90ZXMgaW4gcGF0Y2guDQo+ID4gPiA+IG1vZGlm
eSB0aGUgY29tcGF0aWJsZSBpbiBwYXRjaC4NCj4gPiA+ID4gZGVsZXRlIG1heGl0ZW1zIGFuZCBh
ZGQgaXRlbXMgZm9yIGNsb2NrLW5hbWVzIHByb3BlcnR5Lg0KPiA+ID4gPiBhZGQgaXJhbSBwcm9w
ZXJ0eS4NCj4gPiA+ID4NCj4gPiA+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiA+ID4gbW9kaWZ5IHRo
ZSBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4gbW9kaWZ5IHRoZSBmaWxlbmFtZS4NCj4gPiA+ID4g
bW9kaWZ5IHRoZSBtYWludGFpbmVyLg0KPiA+ID4gPiBkZWxldGUgdGhlIHVubmVjZXNzYXJ5IGNv
bW1lbnQuDQo+ID4gPiA+IG1vZGlmeSB0aGUgY29tcGF0aWJsZSBhbmQgcnVuIGR0X2JpbmRpbmdf
Y2hlY2sgYW5kIGR0YnNfY2hlY2suDQo+ID4gPiA+IGFkZCBjbG9ja3MgYW5kIGNsb2NrLW5hbWVz
IHByb3BlcnR5Lg0KPiA+ID4gPiBkZWxldGUgdGhlIHJlZyBkZXNjcmlwdGlvbiBhbmQgYWRkIG1h
eEl0ZW1zLg0KPiA+ID4gPiBkZWxldGUgdGhlIGludGVycnVwdHMgZGVzY3JpcHRpb24gYW5kIGFk
ZCBtYXhJdGVtcy4NCj4gPiA+ID4gYWRkIHJlZiBmb3IgZ3ByIHByb3BlcnR5Lg0KPiA+ID4gPiBt
b2RpZnkgdGhlIGZzbCxzZG1hLWV2ZW50LXJlbWFwIHJlZiB0eXBlIGFuZCBhZGQgaXRlbXMuDQo+
ID4gPiA+IGRlbGV0ZSBjb25zdW1lciBleGFtcGxlLg0KPiA+ID4gPg0KPiA+ID4gPiBDaGFuZ2Vz
IGluIHYyOg0KPiA+ID4gPiBjb252ZXJ0IGlteCBzZG1hIGJpbmRpbmdzIHRvIERUIHNjaGVtYS4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLGlt
eC1zZG1hLnlhbWwgfCAxNDcNCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dA0KPiA+ID4gPiArKysrKysrKysrKysr
KysrKysgfA0KPiA+ID4gPiAxMTggLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgMTQ3IGluc2VydGlvbnMoKyksIDExOCBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+
ID4gPiA+IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxp
bXgtc2RtYS55YW1sDQo+ID4gPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQo+ID4gPiA+
DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZG1hL2ZzbCxpbXgtc2RtYS55YW1sDQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wsaW14LXNkbWEueWFtbCBuZXcgZmlsZQ0KPiA+ID4g
PiBtb2RlDQo+ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjNkYTY1
ZDNlYTRhZg0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLGlteC1zZG1hLnlhbWwNCj4gPiA+ID4gQEAg
LTAsMCArMSwxNDcgQEANCj4gPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seSBPUiBCU0QtMi1DbGF1c2UgJVlBTUwgMS4yDQo+ID4gPiA+ICstLS0NCj4gPiA+ID4g
KyRpZDoNCj4gPiA+ID4gK2h0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwJTNBJTJGJTJGDQo+ID4gPiA+ICtkZXZpDQo+ID4gPiA+DQo+ID4gPg0K
PiArY2V0cmVlLm9yZyUyRnNjaGVtYXMlMkZkbWElMkZmc2wlMkNpbXgtc2RtYS55YW1sJTIzJmFt
cDtkYXRhPTA1DQo+ID4gPiAlN0MwMSUNCj4gPiA+ID4NCj4gPiA+DQo+ICs3Q2pveS56b3UlNDBu
eHAuY29tJTdDYzdhODQwOWVlNTI0NDcxMjZiMjkwOGRhOGZmNjQ5ZGIlN0M2ODZlYQ0KPiA+ID4g
MWQzYmMyYg0KPiA+ID4gPg0KPiA+ID4NCj4gKzRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAl
N0M2Mzc5ODA1ODUyMTk4NDUxMTIlN0NVbmtub3duDQo+ID4gPiAlN0NUV0ZwYkdaDQo+ID4gPiA+
DQo+ID4gPg0KPiArc2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNDQo+ID4gPiBuMCUNCj4gPiA+ID4NCj4gPiA+DQo+ICszRCU3
QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPVhIUnBxJTJCaVpwWGRCN1l3NGdaUk9OZ1dNbjcNCj4g
PiA+IEtpU3hNOXlCRVM3Ug0KPiA+ID4gPiArSDBpTmMlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+
ID4gKyRzY2hlbWE6DQo+ID4gPiA+ICtodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRg0KPiA+ID4gPiArZGV2aQ0KPiA+ID4gPg0K
PiA+ID4NCj4gK2NldHJlZS5vcmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2Rh
dGE9MDUlN0MwMSU3Q2pveS56DQo+ID4gPiBvdSU0DQo+ID4gPiA+DQo+ID4gPg0KPiArMG54cC5j
b20lN0NjN2E4NDA5ZWU1MjQ0NzEyNmIyOTA4ZGE4ZmY2NDlkYiU3QzY4NmVhMWQzYmMyYjRjNmYN
Cj4gPiA+IGE5MmNkOTkNCj4gPiA+ID4NCj4gPiA+DQo+ICtjNWMzMDE2MzUlN0MwJTdDMCU3QzYz
Nzk4MDU4NTIyMDAwMTM1MCU3Q1Vua25vd24lN0NUV0ZwYkcNCj4gPiA+IFpzYjNkOGV5SldJag0K
PiA+ID4gPg0KPiA+ID4NCj4gK29pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2
SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMNCj4gPiA+IDAwMCU3DQo+ID4gPiA+DQo+ID4gPg0K
PiArQyU3QyU3QyZhbXA7c2RhdGE9NmFsYk1TT1Y3ZHNnYUh1RGswNVpVdEFpTVRsd1lYNlF5SHJm
WFd6NyUyDQo+ID4gPiBCbVklM0QmYW0NCj4gPiA+ID4gK3A7cmVzZXJ2ZWQ9MA0KPiA+ID4gPiAr
DQo+ID4gPiA+ICt0aXRsZTogRnJlZXNjYWxlIFNtYXJ0IERpcmVjdCBNZW1vcnkgQWNjZXNzIChT
RE1BKSBDb250cm9sbGVyIGZvcg0KPiA+ID4gPiAraS5NWA0KPiA+ID4gPiArDQo+ID4gPiA+ICtt
YWludGFpbmVyczoNCj4gPiA+ID4gKyAgLSBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4g
PiA+ICsNCj4gPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPg0KPiA+ID4gSXMgaXQgc2Vuc2libGUg
dG8gYWRkIHNvbWV0aGluZyBsaWtlIHRoaXM/DQo+ID4gPg0KPiA+ID4gICAkbm9kZW5hbWU6DQo+
ID4gPiAgICAgcGF0dGVybjogIl5kbWEtY29udHJvbGxlcihALiopPyQiDQo+ID4gPg0KPiA+ID4g
WW91IGFyZSBjaGFuZ2luZyB0aGUgbm9kZSBuYW1lcyBpbiBwYXRjaCAzIGFueXdheS4NCj4gPiBZ
ZXMsIGl0IGlzIHNlbnNpYmxlIHRvIGFkZCAkbm9kZW5hbWUuIEJlY2F1c2UgSSBoYXZlIGRlbGV0
ZWQgdGhlDQo+IGRtYS1jb250cm9sbGVyIHF1b3Rlcy4NCj4gPiBJIGZvbGxvdyB0aGUgZG1hLWNv
bnRyb2xsZXIgJG5vZGVuYW1lLiBJIHRoaW5rIGl0IGlzIGdlbmVyYWwuIFNvIGNoYW5naW5nIHRo
ZQ0KPiBub2RlIG5hbWUuDQo+ID4gSSB3aWxsIGFkZCBpdCBuZXh0IHZlcnNpb24uDQo+ID4gVGhh
bmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KPiANCj4gSW5zdGVhZCwganVzdCBhZGQ6DQo+IA0KPiBh
bGxPZjoNCj4gICAtICRyZWY6IGRtYS1jb250cm9sbGVyLnlhbWwjDQpJIHdpbGwgYWRkIHRoZSBx
dW90ZXMgaW4gbmV4dCB2ZXJzaW9uLg0KVGhhbmsgeW91IHZlcnkgbXVjaCENCkJSDQpKb3kgWm91
DQo+IA0KPiANCj4gVGhhdCB3aWxsIGRvIHRoZSBzYW1lIHRoaW5nLg0KPiANCj4gV2l0aCB0aGF0
LA0KPiANCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IA0K
PiBSb2INCg==
