Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9633B5ACE90
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiIEJLH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiIEJLG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 05:11:06 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B390F2CC8F;
        Mon,  5 Sep 2022 02:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BphXt0+r+3x3BKY8ypy46nf8ZJiSZOXreisi083CB5QjBHbnXM2uaXtH1Gt59QE0jfkMCGfty+5jtgWwKvbeHu7aJAWq0cpcj/g5aHn0NMSG58Z92DpEfOHnLaw4Vc+sHkYm3KLMTH2mWYf1193NX2RHJsofH9QYeu6ys3SrNqvKcMrHiV7aQSRBPkK5+L0Dv+Zf3EYtwgcZxVUNJcKwsa/ShhLy/caMkhlEmEaagJCYAm3E3f9yqXOXSB51V7orfrKJ0qHLDbvgise/R1CcxIVz8BWVy1GToGtx6oERzF3LGsIDUADH3Tm7nxM/yE5Z4AKPQdpryRwSFAa1idfHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3/liNgVzuHxqXPsAuz32UpYDmoN6yd3iza8niwvI9I=;
 b=frJKRwEBAxAG1W+7rK06V4fqprY1LMAaEVUjA05my5Xt4838Nj4PTu/hSFwaQ19Ai06kJc/9xoMmltN+/wRPW/Ko14zAxAzK4sKCN9MwPuEZGr4Vz35hDmhhfL+p6taepTkWtpSvmb+m3z6pgYJgpNKZt+E0+dyM5Znq788lHiRJkl0ONsVaRkprjg/5KNXzTPG/W8P/TYRomfjSaOD6SpheglF671K/gm2yYMEjiPWh4MaGUZWBfzlKhemUy5fvqRJkuaZEttfKVNcZVgvX2DmXeVlMEZ9SsdYV47fMY7u//5PQmzO1Ea2symWNZVG71eSCAUyjol2EOfWVzpUmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3/liNgVzuHxqXPsAuz32UpYDmoN6yd3iza8niwvI9I=;
 b=ieLiXNqxkMnkYwcG2IFlGDdYoe3lM7/1TbNxC1131jmlRq24CXXQOYa1kXXLwp+GThSn+p0cOqPtCrtZg9wUQldS3JbG6JFfPT1ErSPOm1kmRlBxbRWAHlYwj/ZILW+T2QU0DYsorgeyaMwkRvYPI9DR2JxtwIEMDTZhbAd5Iu0=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DB8PR04MB6987.eurprd04.prod.outlook.com (2603:10a6:10:118::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 09:11:02 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 09:11:02 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
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
Subject: RE: [EXT] Re: [PATCH V5 1/4] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Topic: [EXT] Re: [PATCH V5 1/4] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Index: AQHYwQGsTaW7FmHeI02X4cx3pDet6a3QhjWAgAAF4BA=
Date:   Mon, 5 Sep 2022 09:11:02 +0000
Message-ID: <AM6PR04MB5925CCF730E88FCF915EBEA3E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220905083102.89531-1-joy.zou@nxp.com>
 <2df5b170-1fbc-bf63-5d8c-ece7bbfc1568@linaro.org>
In-Reply-To: <2df5b170-1fbc-bf63-5d8c-ece7bbfc1568@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5650185c-534e-442b-38ba-08da8f1e8e6c
x-ms-traffictypediagnostic: DB8PR04MB6987:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFv83k6e14n2lrsQ/KZWyGPv/2zfU+QAQpl8/pPyk20qf1i8UosVbsd43H8v/RkgHgos0GFxcm+M8D5AiAl2wpquZqPoTDT1Ik4qxwspT5xOPzsQyeD+hP1MlPOpn7y9vYY0c7VhnQy7yZygz8ilxuU55gNkza8AF+71ZHVCjE0r+tEJllO1Ae/RLovVsnHHYE/26aZYEpSFd7JWJShRFcO04Q571z5w1Vr2j27kM9rzpqDY6ObKK/hmbhCnaSpoxXlLKZ9x36w9V90XOn9uW1Njp8g4yELaO2DA4AzrmbKjrzL8xyNCeH0+WN96WP10x8cqcr99eh5MW8tWVVwoYnojvTiqxbFBK9nl6ZLDqS6ORohhSYSuENcTq1BU50syQjlyEKwxUdl2KnF0qYLkGmCgx8MKudnjrtkLaylWTpQJyBX5PT/t1yHaypgvozE7P2W6qYsd9uWYtCNVzXmvs4meHWSShpLsFU1Lsj1mQtn1jt0pPdlfjUN28QPv/BAuLU7Za+0U4dtUjuVmHyoWut5lFhYhaH27AlBgYWbmSw0ZhKPp4B340kFkUtqebLUQtOdBCXA0wZ+SHGCgXkf3kz/d3hX0T7k/iQq2qmObbHHMnJAOqUbpk+VWflaS+dKgudmP4Ump8Y+SRHjJfJkgH3PYlkQCDVNHAClHM0mIua88Mk4EMJCqZNa+HzkD+gyF+T7Lq3ZQauOHkeMB+8hM15AE0B8apfH15sJY7IaTNFm8yvcDxTJIoMJY1n0ypGSzk31mPyAJ2TxCfr+ZGWPBHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(66476007)(83380400001)(4326008)(33656002)(8676002)(64756008)(66446008)(76116006)(66946007)(8936002)(7416002)(5660300002)(66556008)(52536014)(6506007)(478600001)(53546011)(7696005)(26005)(71200400001)(41300700001)(186003)(9686003)(316002)(54906003)(110136005)(86362001)(55016003)(38100700002)(44832011)(2906002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHlyamtKcXVnaVNVdWp0eTh2ZGVMbDFINDV3eitvZVp0WmR4TDhTME9DQWFo?=
 =?utf-8?B?RjMwdkU4SzBNSzVTdUxPWDdKSytyaGxOY29RWSsvSCsrVGIwNFVNNjlNSmNu?=
 =?utf-8?B?ZVFrSkQrcmlQd2luWVRxcHV6VThBdTdES0pyVVVrVm1DT3lDekRYVi9iRGFH?=
 =?utf-8?B?MWd2bS9tV0lGMndpZlNEZ1JzbFdlTmE3QUsxNlJmcll2SERpZUo4ekxFcWsx?=
 =?utf-8?B?RFE3WXJhUlQxeTVuVWExckhRdE5NS2piTkduWDE3QTFYSHYzeFZ4Z1VteWFE?=
 =?utf-8?B?L2lIQkNIMzhwT1VzOXMrdG9nc0pndVhCRDdiM3RNMldpY0NVc3hVTmVaNS9t?=
 =?utf-8?B?K0VXOXJScEM1Qkp2dGZnNHZZdFFXMmdaRVBVcno2b0JLdS9YOVBNTHV4ZG16?=
 =?utf-8?B?SHRDWjlOQTcxSU9BYmFQZEJNM25NTVdCK1VNbVd3Q0JVSjZhRndaZmZjdHJp?=
 =?utf-8?B?TTIrZ0pHeURtcEJzdUdsaU11S1gwZ2MwTktkRTRUYkhCczVTbVhHSjkvOFZm?=
 =?utf-8?B?U2JwQnc4M05CcEs4M0FML3pYT3ROS2Z3ektZbXAzc1NFbEpQdjlYV1JiV0pa?=
 =?utf-8?B?SVIwTkUvQmdpMUszRWpMVEJReVo3SEsxK1JlQkJtNTRoTW4wWU9vMXZsMTFP?=
 =?utf-8?B?ZG40NHV2UkF0VHdsSWFuZUI1TDY0Ry80N1lnY2tzenVOS3NlbnU5VDFwdUVM?=
 =?utf-8?B?ZVYzbjVSK3Jzd0drTHVrMlZONnl3QW40aENMaUFOUWVFUytIaTkvRUl6ajlx?=
 =?utf-8?B?YWNQOGJPQndKS3Z4VXVJMForbmk2U01pMjVkOWRlalVBbzhpSWFaYzZoekNr?=
 =?utf-8?B?Sk5xWkRRcE1ISFBpSVJRKzFUbmxNdmtiK1VaTER2cmhBeHFhcWs0K0pzQzNq?=
 =?utf-8?B?dmE4UEUrTFZqWmdBVUtEWGxxWDd5bWttc1lTUHBhL2MrbWV6WjVWSGdaWjdl?=
 =?utf-8?B?cEQxNkZ4TElRV1dTOTNsNzVZLzNWR0lVeXoxMUVTWWZDYnhxMmpIL1lrT0JX?=
 =?utf-8?B?dk54UzIzQVBybmpBUmQ3REljN013ZDltZmt6enZMZCtjZG1zUHdhdjUxM3lE?=
 =?utf-8?B?Q1ZMSHJ0OWlsanlocmNFci9zVlg0c0k5TGJVaWVFaU13V01mSDI1ZkROZEVw?=
 =?utf-8?B?dGtHamIrSm5LSXVwRjBjaU5DcEwxNW1nOFhCQ3UwQXdJZHdUYXdvMy9mUnVR?=
 =?utf-8?B?SVZ6d2VYMUxlbVdVZm5zOGUwekxDZnZaVEZOUmgrdU1LOXBZMVZidDduN2hu?=
 =?utf-8?B?Ujl6VUllSTlUWGtmaVhjb0RBK01FSFVyNkt0NmFmNjNYanRQZ2M2cFgwVEln?=
 =?utf-8?B?eWFkL09GLzM3ekF0TlZvYm5QZ1FSQktxR2JxaFZUekgrcmpPdGVOeHNMSjJ6?=
 =?utf-8?B?S3phMGc2NmxDbVdwOFM1OHF0WlpVd25XNS9mbzZTYjZKTkJqNUtYaFRId2ZY?=
 =?utf-8?B?Yjhtakd6TzdsNks3Mm5NY3ZZaGpxeTBQc2RET3NTOEY1N01rV3lOK0syT242?=
 =?utf-8?B?K0FmMDJRZjRDV1dEOWhRK2FtTlBwNDF0ekJYM3hQOVRwSG5zeitVMnZSZWFY?=
 =?utf-8?B?ZVN4eG5WdktWcE4raEIwckwvS0VqdnJvQXBBZHRUY1p2MENhZ2ltRVg1Uzd3?=
 =?utf-8?B?WDlmdFB6Q3ZjQTJacGF4QVh3S2NnQUNOMU8vNWtyVW9ObmRQdysycWFzQ0VQ?=
 =?utf-8?B?LzFSTFIvcGZkU0pWTEtCU1RIODN6QWlXQnBOTGl6SmpEN2k2VlZMamZQdWRj?=
 =?utf-8?B?dDF4eFF5U3o5NDZoQ05LR001c1JhVkNmanhGbmtrWnhhMVAxM1hjZVhFV0cw?=
 =?utf-8?B?N2lmZGdWWGtYZXFodjd4VzBvb3dSaE5sK2ROZStVUVVpeXVxWjNmczBzRWZo?=
 =?utf-8?B?WEcxbXhMUnBrY2JPMW4zTk5QQnVzNDEvZDdlZkk0OHBmUG9uZFNhcWdxWlJQ?=
 =?utf-8?B?TjdTd1RLUjB3dTBrWi9kRUV1L1JmYTFBeU43aW95Ym5SVG9DcTk4RUwwT3JS?=
 =?utf-8?B?Nm1jOWpNVCtYTE9FQnhTNUFYRjdwckZLZEJjMWo1YWJZd2c3NzdYcWtvTG8w?=
 =?utf-8?B?bktxU2llVFBSd2xOVU43T0pDamNyMWVGNkQyZjd2ZWZNczgzcW9oQkgvMm9Q?=
 =?utf-8?Q?SH3A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5650185c-534e-442b-38ba-08da8f1e8e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 09:11:02.7438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMc6c6KzSiuvT9ID0v+mZC2pHcW/TO0GZen8gmokzeMKRPNsmxyrSpCJbRiqSdDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6987
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMuW5tDnmnIg1
5pelIDE2OjQ3DQo+IFRvOiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+OyByb2JoK2R0QGtlcm5l
bC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgdmtvdWxAa2VybmVs
Lm9yZw0KPiBDYzogUy5KLiBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+OyBzaGF3bmd1b0Br
ZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNv
bT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCBWNSAxLzRdIGR0
LWJpbmRpbmdzOiBmc2wtaW14LXNkbWE6IENvbnZlcnQgaW14IHNkbWENCj4gdG8gRFQgc2NoZW1h
DQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDA1LzA5LzIwMjIgMTA6MzEsIEpv
eSBab3Ugd3JvdGU6DQo+ID4gQ29udmVydCB0aGUgaS5NWCBTRE1BIGJpbmRpbmcgdG8gRFQgc2No
ZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gPg0KPiA+IFRoZSBjb21wYXRpYmxlcyBm
c2wsaW14MzEtdG8xLXNkbWEsIGZzbCxpbXgzMS10bzItc2RtYSwNCj4gPiBmc2wsaW14MzUtdG8x
LXNkbWEgYW5kIGZzbCxpbXgzNS10bzItc2RtYSBhcmUgbm90IHVzZWQuIFNvIG5lZWQgdG8NCj4g
PiBkZWxldGUgaXQuIFRoZSBjb21wYXRpYmxlcyBmc2wsaW14NTAtc2RtYSwgZnNsLGlteDZzbGwt
c2RtYSBhbmQNCj4gPiBmc2wsaW14NnNsLXNkbWEgYXJlIGFkZGVkLiBUaGUgb3JpZ2luYWwgYmlu
ZGluZyBkb24ndCBsaXN0IGFsbCBjb21wYXRpYmxlIHVzZWQuDQo+ID4NCj4gPiBJbiBhZGRpdGlv
biwgYWRkIG5ldyBwZXJpcGhlcmFsIHR5cGVzIEhETUkgQXVkaW8uDQo+ID4NCj4gPiBBY2tlZC1i
eTogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4NCj4gPiBBY2tlZC1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+IEFja2Vk
LWJ5OiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KPiANCj4gV2hhdD8gSG93IGRpZCB5
b3UgZ2V0IHRoZW0/DQo+IA0KPiBQbGVhc2UgcG9pbnQgdG8gZXhhY3QgZW1haWxzIHdoaWNoIGdh
dmUgeW91IHRoZXNlIHRhZ3MuDQo+IA0KPiBGcm9tIG15IHNpZGUgdGhpcyBpcyB1bnJldmlld2Vk
IGFuZCBpdCBsb29rcyBsaWtlIHNvbWUgdGFncyB3ZXJlIGFkZGVkIHRvDQo+IHNraXAvcGFzcyBv
dXIgcmV2aWV3Lg0KPiANCkkgYW0gc29ycnkuIEkgdW5kZXJzdGFuZCB3cm9uZ2x5IHRoaXMgQWNr
ZWQtYnksIEkgd2lsbCBkZWxldGUgaXQgaW4gbmV4dCBwYXRjaC4NClRoYW5rcyB2ZXJ5IG11Y2gh
DQpCUg0KSm95IFpvdQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
