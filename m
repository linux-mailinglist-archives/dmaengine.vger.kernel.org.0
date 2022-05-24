Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C444A532491
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 09:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiEXH54 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 03:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiEXH4O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 03:56:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696E511A00;
        Tue, 24 May 2022 00:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9Jp+ZBJpZAfhPVo+l/cWkJ4F3FXFpWgBzxGs05ZvWxu3pHSVehx4A4i7RJtC61wQw/1z+D9NirSK1l31Pnh3LjlDR1Q52qX7qZ1n+JBpm1xAO9ELD+h/6vtfIedE02luAYJyVLyB4so+FiFaver4JKX37hZOnwJT33bRZisjGfx9Eeit/P1eN+7MJFAE6YocVQwTiwJiTEms31AOLgpYVJf4XWyELXWs9Mx1BYn3tbwgSiF3sKF5ZdHun08AB4Su5sSlfxmPHzP9pMrntR2h3IgWUcqATIJvoLRgOl9EMu4Tv3sCW7UKcyOzqaGOoY9iEdmWVcG7rY7qnMpZ0bCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5pLiTsL0oaK/LRA9xgYRbss+N9Tv2l5b8lZkKUkrnY=;
 b=QPtUwyQGR+H8pQWeLnZ5xdvfdqOcic4zA6lxFm2nWWWSRrLs0g5Yhy1uU3RbOCrejnnjWbgjfgw/ARaD2c8YI9Two1t9TcAIr0PZFePYpJq4GHoudVHLKuFzDWBu2KNEBwANu5zAAxm+p2xz9kGzJHQaddrDa4P1z2crAOpdIxQ/JaeIbEts3UHFZ3mGve7u+v2VQXKfvt8z6Hi+J0Gh79yWQhAf3UckOlfDdsr9huz1TjXoqlw+CD0sxJH5vZeIr4ULrCATCtX+LH1TTxcE+AjGE35w6CHUI7voe0+LWsIVIdm59oYsvI3NB24rutc2Jo+XS26uySyOvmGXVtpXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5pLiTsL0oaK/LRA9xgYRbss+N9Tv2l5b8lZkKUkrnY=;
 b=a87dcEyY+pt7IcoPlvrt4pmU3FZzW7ROTgL3EIaUguYYB1xLxiHo2GKkLPPODLpWju2it16EN9BqozLe1u/tjNywj5hZz/3CkwkObBRjjo6VdAjMuixo9JyzDInxNyy7bICRZFXlKus4DRduGPoJLE2iN3YfBI32AOSdMsTlXEw=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by HE1PR0402MB3388.eurprd04.prod.outlook.com (2603:10a6:7:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 07:56:07 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c%3]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 07:56:07 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
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
Subject: RE: [EXT] Re: [PATCH 2/2] dmaengine: imx-sdma: support hdmi audio
Thread-Topic: [EXT] Re: [PATCH 2/2] dmaengine: imx-sdma: support hdmi audio
Thread-Index: AQHXxjriSlv/1ppQykKghYS2natqHqvjKY+AgQz4OuCACZHGAIAqw2Ag
Date:   Tue, 24 May 2022 07:56:07 +0000
Message-ID: <AM6PR04MB59253A826743156A3D61A3A1E1D79@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20211021051611.3155385-1-joy.zou@nxp.com>
 <YXY2M0td08eDCi+9@matsya>
 <AM9PR04MB88757229F10CBB693F90E486E1F39@AM9PR04MB8875.eurprd04.prod.outlook.com>
 <Yl/eAomzpAyDSDjW@matsya>
In-Reply-To: <Yl/eAomzpAyDSDjW@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 025b2ec3-6a2c-454a-83e7-08da3d5adc25
x-ms-traffictypediagnostic: HE1PR0402MB3388:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB33886CFA598D9A56AFF232CEE1D79@HE1PR0402MB3388.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Nv9mEjm2zCbJMh/a68DScBOmfnsr9K6mQyFfbM5wg5A1l95Rr39kAlgU7Ztarfvt4F7D8tHNC8/xmS8UxOW8eh/8NrGXrwUPrNmDJgseItp71ec1OX1zNtUxrJQ3s0om27DIUuTUSNG1Kbkuybi4akNgFJOWSTY30NkwtVXwhY0RleigTyumJYb+oyhkMn4oJGVkaKXax8m89LvP5cXA+QKZHXYF9NPAQqLNaHO6VCvDhLfhoSNzH0+2CE+0vJOnIER//btHxkJg0J+GL+4wrL2Q6fW3gruoI2RLP7tDob6GSsdpJfNVkY/zprBHaTeEwWmDNStg5Pc+BJIKh2XOmTs0D+L2VjcWbCr8sv1UE1jqOqV1uC1eYFWf4Kr+N7jCg11N8YoHZC3Aj7sE1V33mRY8EqYX9STtU0Uyet+DCrvD9x5j/zBtP8qYEajvgWxI8+5u1zx2fTMu7JKlhFG4nqNS7iJZxiYGTCIq0CI2Bcx4WEFUXL6GkBt6uJi0ZugXFJ7Cw1nsyoEARumzMVwzWLLKe1PdI4d9xC51ZXssedGBliwZ9w130Sg26alG8VoVQw00Ytz0vKkbzaFtlfRRdRHUo++/5PFlHewswb9I9c4N9TgsJ5KR3mcMMUA5/WdonGEcCsbJjxBWgVqsi9rGChDwN8uJ7+UCY0AAhK5Fga2ZSYL04Nle/NpsplLK7bLyYB/mhktcSX0WhN6AcuHcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(55016003)(86362001)(508600001)(38070700005)(26005)(71200400001)(53546011)(7696005)(6506007)(9686003)(122000001)(38100700002)(186003)(83380400001)(5660300002)(76116006)(4326008)(66446008)(66476007)(64756008)(8676002)(66556008)(33656002)(316002)(44832011)(52536014)(66946007)(6916009)(54906003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MmFucFVnaWhBTVJLUWY4aGR5aTRFT3VaenoxSEgxVnhYcDVZcUg1SVhjWVcw?=
 =?gb2312?B?WGsxbkVrcjFtSWJhd1ZWU0JSUXBWSjZ0NG0wNGlRN29SZW9TekNKWlI4K2pP?=
 =?gb2312?B?cUxjelA3OVYvSjhGYkUwdnFQZ2hYb1ZzYit6cWdZVXQwbms2UVhGbDdOd05t?=
 =?gb2312?B?NkppdDVWVFlmRXdlUk5DcURLS0tPZ3VrZWt3M0FHaUJHcHpMRHdnT3FQajEz?=
 =?gb2312?B?YWFCY09jZ1pRMlpOTEQ3UTJueC9DS1lJK0lPMGxSeWxqSkh0TmlaWXJJQmRS?=
 =?gb2312?B?Ykdta1hRTmZNL3I5TWtnakxLOGhhc0JmaGV1OVE5amtoUGRXKzVjaFoxK0xv?=
 =?gb2312?B?SE9vUmI2UjVoSEhmeXEzRjVGWUZJQ29xYUFhdWlPN0hHNWxVMFBlOHNXK01V?=
 =?gb2312?B?QWV6OGI5Sm1Tb1VGaXJjSk9peWdkRFB0MmpubmdlZU9rSHNpaXZoK2gxN2pP?=
 =?gb2312?B?aEdpUkhFSmNoL1lYaldJMVZocTAxUmRzQ2w1T3dEZ2RIeXFVY1J3TU8rNk1G?=
 =?gb2312?B?RjI4cDhkak9BcnFhQ01Ga3VweUhHV2ZBd1RsUElRWXlLbEowS2VaQklIbHVM?=
 =?gb2312?B?cncvWk9tb2tXMHRMTFhwRFhSUDlNbkZhMmtpbTl0RzZqVXBOdUxlRXMrc3I5?=
 =?gb2312?B?V29xV1NsMEtOZjczMU5rNGo2b0EyU2ZRNHVqZ20zdGdsZkRQMXF3UXFnb1Vs?=
 =?gb2312?B?elYycWpMYXFFeDJtK0FDMFZaYmdKMTZoSnREejhKZWQzSXpwUTRmT1VQdDBq?=
 =?gb2312?B?cVdReXhDS0l4VUhsQWFIdDRaTjg1UFZQVnMvTXBWenFScHhnSzdzNU9UT1Fv?=
 =?gb2312?B?OFNBRGRRMTFLeXF4ZXNxYllYNnlsMWljU3doenZDYll2ZkNwVlcxeTFNWXll?=
 =?gb2312?B?N0tzRU0yRUg4MVh5dmc4Vy9xcWNsTGdMTXowVUJjNDh4RXV4M0ZPcWEwYmVv?=
 =?gb2312?B?NXhxR0Rsc1hNOVBDRTR4b0tIUEU0NEN1a1RYcjJSRlJpaUxydHhOMEVwS0Jl?=
 =?gb2312?B?VjNFNVYvRzd5NFRMQmV5TDk5c1hIQXFuYml1U0dZdG5QMXlTM1hVcjB1M2xy?=
 =?gb2312?B?MHYzVGNiVG1rOExqK2VZRG9qUzBZalkraVhoaUpkOGFaNEtzZEQ2UUpRck5C?=
 =?gb2312?B?R2ZSd2d0Q2NxWXVIQnZyV2MzbzYzWmRTNndIYy92TlA0ZWNhancwMzNpc3dX?=
 =?gb2312?B?dFdRZmtpa2JLOHJVbDZwdDdqMTBHaHBxSnJlQUk0NGxmV3F5akRxTW1CeVFJ?=
 =?gb2312?B?SStML0Nsd2EvOUlpR1p1WSsvSmQ2aHRhYWdGUG51OFAxc2xZQ1JPdFRVRFpD?=
 =?gb2312?B?aDZzQkZidmE1K0twWmhCYWg1L1ZxMWp3TGhzbEJBc2xFdzlJcERzcTMzOUEy?=
 =?gb2312?B?SjZ3d0xtZjhkRjdjdk94K1cyR0NZUFRvK1BWd1JpOElGbUtwR3JYSUpqTzZU?=
 =?gb2312?B?akEyM0R0Wnd4dEV5OHd4eHhmcU0yS1dXUktIM3Q2ckNxVnMwU3UvODZpYXNt?=
 =?gb2312?B?dXI2S285ZHFXWDZ4cVdNeWM2dHRFRDJDc05NdFBBd25oWFpGUEl3Y2IxbmU3?=
 =?gb2312?B?RFZVVzRORXg3QXY4RUpMZTMvWjhiNnFDb2hnOHUyRXhIRjEySjNDNkxEU0N2?=
 =?gb2312?B?THhIUWJ5RTZlOVBpRlpkOTEyeTE3bWhjTFhyaGtpMlVNenAvRXo4dkRCSlB6?=
 =?gb2312?B?MFNVMlFneHN5b2wvK1A5OVlvNFRpTXhkVC80eXVKbEdJMmtuOEFkUTNjMWJa?=
 =?gb2312?B?YmtEQ1l3VlNNZE5mNy85UlcrUytKbm1WMHJkdFdQbFJadm5FY1BXN3U2NUFE?=
 =?gb2312?B?OHpxSXhtWDdMdmsyR0wvU29NYlcwNHFGMWV6VHlha0crSTMwbTdTdmgvUWZh?=
 =?gb2312?B?Ti85by9HTlpLUlhxaVZ2MVA1cWJZaFF5dGVETzRoM2VqQ2dvS0g3VTdsN3BC?=
 =?gb2312?B?Vm9sUWRqZGFjM2ZkVWR2UDNsSWlZMnAwWi8yZmpUM2JzSm80U1grbzFyQmVX?=
 =?gb2312?B?NUp6RkdhdnZ1K0czQU1HZUFoQzlHUDVic1pIYlBxcGdUN05EYUVnQm1QVnAv?=
 =?gb2312?B?QmhNNHRLZjU0elBDY2FObTZCWVI5eTErOCtJTTJ5dklGM2xsZWpuRlV3bFhZ?=
 =?gb2312?B?WEZEM1RjWlpoVzd2aDkwZGlwcW13VE5mZ0Y4Q2JCcVo1MXMxUmhjbGZzRGZM?=
 =?gb2312?B?d0lmTXVCeS9ZS2N3YkNtME1ZZXRBWkNrQmllKzgvWWFVeTlLV0Voc2w1bGxB?=
 =?gb2312?B?ZFZxcmYxeGpCNkVnakVTQVNYVkV1ZzlSbGlWVVV3ZTBIUUhJSUFGbkowV255?=
 =?gb2312?Q?HVQip4m2XfqOXXx7tP?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025b2ec3-6a2c-454a-83e7-08da3d5adc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 07:56:07.5674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jCj9leF3CXCEJIKXmVd7qnOTy6MCtzntWaxVz/9r+n2p7pM789WZTN8mO8k8WCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jTUwjIwyNUgMTg6MTkNCj4gVG86IEpveSBab3Ug
PGpveS56b3VAbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29t
OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gZG1hZW5naW5lQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIDIv
Ml0gZG1hZW5naW5lOiBpbXgtc2RtYTogc3VwcG9ydCBoZG1pIGF1ZGlvDQo+IA0KPiANCj4gT24g
MTgtMDQtMjIsIDA0OjA2LCBKb3kgWm91IHdyb3RlOg0KPiA+IEhpIFZpbm9kLA0KPiA+DQo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPg0KPiA+IFNlbnQ6IDIwMjHE6jEw1MIyNcjVIDEyOjQ1DQo+ID4gVG86IEpveSBa
b3UgPGpveS56b3VAbnhwLmNvbT4NCj4gPiBDYzogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAu
Y29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj4gPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDIvMl0gZG1hZW5naW5lOiBp
bXgtc2RtYTogc3VwcG9ydCBoZG1pIGF1ZGlvDQo+ID4NCj4gPg0KPiA+IE9uIDIxLTEwLTIxLCAx
MzoxNiwgSm95IFpvdSB3cm90ZToNCj4gPiA+IEFkZCBoZG1pIGF1ZGlvIHN1cHBvcnQgaW4gc2Rt
YS4NCj4gPg0KPiA+IFBscyBzZW5kIGEgc2VyaWVzIHRvZ2V0aGVyIGFuZCBjaGFpbmVkLiBUaGV5
IGFwcGVhciBoZXJlIGFzIGRpc2pvaW50DQo+ID4gcGF0Y2hlcw0KPiA+DQo+ID4gVGhlIGF1ZGlv
IGFuZCBkbWEgcGF0Y2hlcyBhbHdheXMgYXJlIHNlcGFyYXRlLiBUaGUgYXVkaW8gZHJpdmVyIG93
bmVyDQo+ID4gd2lsbCBzZW5kIGF1ZGlvIHBhdGNoZXMgYWZ0ZXIgdGhlIGRtYSBwYXRjaGVzIGFy
ZSBhY2NlcHRlZC4NCj4gDQo+IFBsZWFzZSB1c2UgdGhlIHByb3BlciBmb3JtYXRpbmcgd2hpbGUg
cmVwbHlpbmcsIHRoaXMgbWFrZXMgaXQgX2hhcmRfIGZvciBwZW9wbGUNCj4gdG8gdW5kZXJzdGFu
ZCENCj4gDQo+IE5leHQsIHRoZSB3aG9sZSBwYXRjaCBzZXJpZXMgd2FzIG5vdCB0aHJlYWRlZCwg
dGhleSBhcHBlYXJlZCBhcyBkaXNqb2ludA0KPiBwYXRjaGVzIGluIG15IG1haWxib3guIEEgc2Vy
aWVzIHNob3VsZCBhcHBlYXIgYXMgYSBzaW5nbGUgdGhyZWFkLi4uDQo+IA0KPiBQbGVhc2UgZml4
IHRoYXQgaW4gbmV4dCBwb3N0DQogSSBhbSBzb3JyeSwgbXkgbWFpbGJveCBjb25maWcgd2FzIHdy
b25nLiBJIGhhdmUgY29ycmVjdGVkLiANCiBCUg0KIEpveSBab3UNCj4gLS0NCj4gflZpbm9kDQo=
