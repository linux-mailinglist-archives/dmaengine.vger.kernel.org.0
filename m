Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA35ACE8F
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiIEJM4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 05:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiIEJMy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 05:12:54 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10079.outbound.protection.outlook.com [40.107.1.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEE2CC9E;
        Mon,  5 Sep 2022 02:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFbmLQSaNZergeKcB2gZrRu1sA8MeAcvEAUtHqOnSiPstT57YnoO3OOrVa7L26wT1UvfCe0i0VlxjvSEBsYAK96ubyPjCPxgTeRtSkPuYr1IasVIVm079CSgW/AGACdtIrdig+Nu5MfqhY/nTyYz1A5NdwhBzqQKI5OeNrTyatwlZPMORiouE6i5M1e2xt3pFKkOFKP7WcM8UuzUr8qvl0odI9t3NoIZNzAT5URxS3t1gZxrFDXM5mpFKuehwoyMsmu1mxDMdTk9w5VOtX1uXChRW4LWfg6Y79XFoF88TLaEF5ndbdbeKP1q1u1Z/LbgJqDvJED+LVZqbxHiArhzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFp1YE/xJb3vVHTPE6V5d2VL53d7AYi6bB/LiLNHGB4=;
 b=dgel1NzgcNZqdtg9aY9lPycEf7QMcmH9wdlfpH8Vpnyb1vzO0Y5io48HVzMNNOgnUgTzY/p1QcvvJAdJMnEvS2BXAq0oBvJekIRYAH/qVCHNB7crFKXIyCrZX2g4qEOdG27gErpzAi80FimPHECECwRQz4CWxAi1VSDTu+UpLKBkfezoFYku4TkJylUthQq4ylw40UM+o9c+miD3WoJafrp6SMeYOOH3KrpV38gFPDXPWpF1Z9W+sMHq/S8/hiaz7pI5153Y1TsxKFdhzcM5zR7CO9Yd1ZdMCmK+gIlskkxB0c0EZd1t4mdBKwOOzlQlxMYixjH3adxw4+NPeRhxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFp1YE/xJb3vVHTPE6V5d2VL53d7AYi6bB/LiLNHGB4=;
 b=BaGJsYsuusKIu8JKyLjiAcwhP7q/9VmGdLKE5JN3nLIrGmhTKkS3zBzhoCdWia7w8yqFDlklDKNPA6kRWCIWd/hnzwiuXtLSVOZf0E2CiDp9thjOUy8gm40bs5rLGT5QWv1gQ+NKLZWZXVLqkluTkv+dvDu2B/wRtx/ksdJUdH0=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DB8PR04MB6987.eurprd04.prod.outlook.com (2603:10a6:10:118::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 09:12:51 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 09:12:51 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
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
Subject: RE: [EXT] Re: [PATCH V5 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Topic: [EXT] Re: [PATCH V5 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Index: AQHYwQIH+N7Nebr6OUCLs0qtusDuTa3Qhl4AgAABvwA=
Date:   Mon, 5 Sep 2022 09:12:51 +0000
Message-ID: <AM6PR04MB5925F1AAFD2387E1268790DEE17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220905083352.89583-1-joy.zou@nxp.com>
 <94a40049-ff71-1b34-53fe-eb94350315ec@linaro.org>
In-Reply-To: <94a40049-ff71-1b34-53fe-eb94350315ec@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54ca3ce3-7ff6-408b-b642-08da8f1ecf0f
x-ms-traffictypediagnostic: DB8PR04MB6987:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDwkR9l23DwiOyYZQ9MNNkQTQRJlJVpFRnhXJkwkZSUL8zkgO/IKO0mIivIsJ14TZOaK549jKGXE6JSYWo4s3mZjay1nKMUxq3+ztOxY2zgDJ1bAnXwPhLqaCReu1JzdIxsO7QYHjfVOcnHuSgJkoExSMl84GOfMFDEAyqkiGkmBZQn/9jIRd5hPY6zZ3hpFdFGjrghsryRFG80QjM+UUaFNbeeAUiyVjD+lkeoYXpK7miW+wpWI0RvrsNb61qHgiikt49Im8KBk/+IiMgY3082VdxFOcvUg26DdBrLHEGTLtD8hT7BFFtf6eEFlnS/rABk3LOZJA+vo6NETN7hmPtqEQVSgXNGwMNPP2dkSIackgDKPLPEPawMBnR3oXGYRwvPVbWlQwvSBlOj9Ecd6rUBX2K/Wz77FWorleVoL0XcFPrHQTEgNpoKo+eB1rlAb8RQH9sorfB9OLwnwxY8CdCTfEAC3jZkV0OTpIwEppvHA8xjTCJj4ps+s3BjWs0L0tbDqJP7HMx1/K6cFrSI4DqE6AaG6Npl1CZsKPZ4NveTyBqB5GgJPtXVtG+0fjH9s3xk4KxOmOVw2BCmg7Ms0rZN8I479E4qSRd4FWsQ6ucnPqYb/ivG5CiCJxlVDIBIuooRmBnyU8Orkj9pTUxdYD0rijO1zEazFAqyfH3aZrauR75HSv8i4Q0TqSE6YS1aiAodPfhHcLcoBP4KjJRAYpSAK9ko/39AY+3oQjTF4439PQfndibjzZLp+h291P3gvLGI9Ek90gwBxveCyIDQ+8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(66476007)(83380400001)(4326008)(33656002)(8676002)(64756008)(66446008)(76116006)(66946007)(8936002)(5660300002)(66556008)(52536014)(6506007)(478600001)(53546011)(7696005)(26005)(71200400001)(41300700001)(186003)(9686003)(316002)(54906003)(110136005)(86362001)(4744005)(55016003)(38100700002)(44832011)(2906002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVFGYUxBYXdDVVVTdHNKR1M3cDZhRFM0Tnh5ajJNVmFoYlVCbDZSdXNNK2ZR?=
 =?utf-8?B?N0hiOVR1ejNVb09qTUduZjNuZk9DWnRXdW5lZ29PTUl0RjBudzR2czRlRWxp?=
 =?utf-8?B?UCtXaGZMcXFZaU50cW1XcWZjMTRNTnBpdHk0WnREeUEwL040Z2pKdWpGREZC?=
 =?utf-8?B?UkVhRUxvMktreHNSaTh4OElTckhHSWdoVGNJUU1MMUV4NHhUQTVlVUhEbkFS?=
 =?utf-8?B?eS9ucHVpUEp2TWxXdnN4UWZlNC95OHBOMHhlL2pEME9TZ3JZVW9rMGxTcUll?=
 =?utf-8?B?bXlMenpCbFcyUnM1dlh0U3huZis2bWtNVUNFMjF1U0RxdGVjWTRXdko3dldO?=
 =?utf-8?B?OEYxZVI5S1lMYjdwV0ZjMnE2eFc1bk1UZG9OZXFkVlNkMUNGNld0SFdLNFNq?=
 =?utf-8?B?U0k2SHlXcC9JakJsRG5zUENselNxRUJQZmgwa3BQTXNwQUVuR2tDbVBnK0lp?=
 =?utf-8?B?TURHSitLdXZnbER1RnFIMkU0bk82UFJYdnFwanNUcnRhUUY3Ui92aDg1c2RZ?=
 =?utf-8?B?eDFzOG51aTRacHp4L2plK3RKSVdabjFiUkM3M0tnOWRrWjNDeFQ5cXh0cHVD?=
 =?utf-8?B?VlhBZjN6SmhmdUgxS2lDWktwRXcwRmlUNHdrSWgycWRwNEE0NnJzdWNPYklM?=
 =?utf-8?B?UEtVRzRBSVU3RE9QM0Z3YXVxQUEwOWpVaFE5dlVEQ2ZvTWFDWi9aQTBCRWtk?=
 =?utf-8?B?eUhBVkJIaFFWbElqaDQyV0dWbFBpMURxc2l2NnBSbWdHVENqa0I4TjFESEty?=
 =?utf-8?B?NHNraUtNSnoyNEFvcnIrKzM0eHUyUTdPTUlPcjRsdTd0ODZ2RTIzT3dYRGVW?=
 =?utf-8?B?OVZYaHVMU1EvRVl1cThNT2NaTWprTGZRUkhSRWhnaU1IakdSWmxOYkxSbnpa?=
 =?utf-8?B?UEh5VFlIL0Noa2ViOXpvMlhlN2txVENvTXFYdHJLWW14V0tzSG96RzZaRjhz?=
 =?utf-8?B?dU5RQ0JJZmJEeWVrcWtuSXR5S3RxNUlPMlJlV0hNTEM3MnU0R0l3WGtFVHF6?=
 =?utf-8?B?M0ZHVVhwTk1nTldkTFpvMGg5WFd5VWUreFFNMzU0bnM3eEtTY0dtOGNpN0FP?=
 =?utf-8?B?dUxpZUJOeXpTUDNrRU1pKzhNWkJFQ0gzcXY3SmVVOHVOOGpOZndmL2N1WUxR?=
 =?utf-8?B?aFNBSDBiZDJKcmgzeGhqTkh4djJYRlhLSkFObW8wU3hWa0lVa3FueHY5WW9R?=
 =?utf-8?B?emF6eDJTbS9UVTBrWjFweUllVTQwcHk5Ynhqb2thYXo5VUVhZEQ2WTRvSjZF?=
 =?utf-8?B?WVQvZldlTG4xaXFVT3BxaUY0WUtsa1ZkRFdjZitXUmxreFR6T3RhRjl3a0Rw?=
 =?utf-8?B?bGxOSVl0VUtibmkzWWxSbHg5bDNaanBCRzE0RUxyUUxFZkJ2cEgyRGR0MGE3?=
 =?utf-8?B?V3FPUG5yQlpoYTE5WjhPMFNHR2hSTmFyb21LS0U2Q2VVaG10Vk1wMUNMTTBI?=
 =?utf-8?B?dVB5V0tlZE1kYUMxSElRNTNpdTMzbUR6b0dNRUZla2lWelJkNFJBWlk2aHMr?=
 =?utf-8?B?ZkltTS9tQldIc0ZpV203b2JyWUd4TTV4QVFkMmFqVXFqZUpmUm9IaDNodGFy?=
 =?utf-8?B?TXV3Ymx6dXR2ajBtMUE0Y1llNm40WWx2WVhEcmFKWmw3ajhocmxOdDZNRFpH?=
 =?utf-8?B?T3VOWjB4THB2WUcxTU1KY3gvRFZrSHc3Ykd0a1lSWHJ6N2RMWnV1Tmc2d3Vp?=
 =?utf-8?B?NXc1VjRheTYzQzNBZUxKdUVzOWg0OVdwVHlZVWFSQkFjeHRFTUV5dmtaeUlh?=
 =?utf-8?B?dzZyUFpudVdZV0t4MDNRM0V5YjNDZUZKYkhEL3ZaemxhekI5TExPUHdKUHhL?=
 =?utf-8?B?Nyt0R2Y1Wlk0NG9DTm9EMW9ORWM2TU5lRm91QnZzSGxkam5FQ0g4bVYyZlp2?=
 =?utf-8?B?d1ZrRG5NZWZRdXFCU0h2d2VUUit5MG44Sk4yQnRYbWY5Unp5MWU1bllDZVlm?=
 =?utf-8?B?OS9NZDdzTzYyK2JuNmZTdWFjRWVVTHE0V09yNHJnZXQ2TlBQaEtrTGgyUHcx?=
 =?utf-8?B?dzMwSVpLNU13RWs4cEl0MUhLVDdlOE9yM1pweVhpdUZHWXREdnRpNlBUQzRD?=
 =?utf-8?B?VjZWNCt6dU4vMGN2aWU5aHdhR3QzZ0Jxa3JhM3U0dE5uWERON0d4Y2FLdUk3?=
 =?utf-8?Q?oFIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca3ce3-7ff6-408b-b642-08da8f1ecf0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 09:12:51.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AX7zxRf/ARg7rqxU4089MaOMx6LQDa0SzKIUy+6zegZl2MWYUEKLaJeYHYai9bhj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMuW5tDnmnIg1
5pelIDE2OjQ4DQo+IFRvOiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+OyB2a291bEBrZXJuZWwu
b3JnDQo+IENjOiBTLkouIFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNvbT47IHNoYXduZ3VvQGtl
cm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
PjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbUEFUQ0ggVjUgMi80XSBkbWFlbmdpbmU6IGlteC1zZG1hOiBzdXBwb3J0IGhkbWkg
YXVkaW8NCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMDUvMDkvMjAyMiAxMDoz
MywgSm95IFpvdSB3cm90ZToNCj4gPiBBZGQgaGRtaSBhdWRpbyBzdXBwb3J0IGluIHNkbWEuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+IA0KPiBU
aGlzIGlzIHN0aWxsIG5vdCBwcm9wZXJseSB0aHJlYWRlZC4NCkkgYW0gc29sdmluZyB0aGUgdGhy
ZWFkIHBhdGNoZXMgcHJvcGVybHkuIEl0IG1heSB0YWtlIHNvbWUgdGltZSwgSSB3aWxsIG1ha2Ug
YXMgc29vbiBhcyBwb3NzaWJsZS4NClRoYW5rIHlvdSB2ZXJ5IG11Y2ghDQpCUg0KSm95IFpvdQ0K
PiANCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
