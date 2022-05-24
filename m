Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46A532498
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiEXH6B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 03:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiEXH4t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 03:56:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A41B2495A;
        Tue, 24 May 2022 00:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEi6n7mNJKhR5As3FkyNoRrAqgcda+WVWTGLTRgg+QXZkmQi3j/M75lP644wQMVCRSHmhfmGOcriq/4oAZJ3Axc21nGhlyK2f5jzdBSo2rpVAvpT4s1lburQOKC3UtldJuAd7aZa1sz+oOFdrZlAWI9AXbf+vRNk2LWe2p8WwfFbd/nWi07usyMkeQjo/B2qY7HSvN6TLlzfUKwNKcDnYzEoV8i6L3sY10YBJ+JZduRHbF+agbbwmsrK+mK87z770KpiCQo4gwYayP9eO23Zx/Phf+F1FnXJ6M7Wj6zLWZQnDhWfizt4yA4sbIWoOQAjg7T529v9ot/w3gfjdMS+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbAk9i4TilxZCexbFiNqC9cmmjP1WQEioxz+wDpNWdw=;
 b=IT9vyQGgvSo3N9W+83ifnyVSoTl6l84yXLRSW2V+ftoqpdGUSMYzzmiD7iNbIxYLnndL6gTjJilvsKrdzfkuSP7VDtW9Hzqb/Ht4NW8DWlvpztxOB+/RCDpg5LBJ2sRKAccYa3Dsyj0ciIKv0pyvQkChG+89+miSD5Vb7O1nRns5BV0qztoTPuq0Xh22FGFJUkGLrQrFtvVbkpu6M2je1TNY0tqxcroJhKmUWXMLctXNQauZ7CJVWk+KmWR8s5Tk600sogdcnGpXTX2aDzKpwWNvylovUgTqgUyS6xpR1TdYeMHkq/86XWryh4M+1HC8KsNdnvC1pTPQOhU0c7rVlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbAk9i4TilxZCexbFiNqC9cmmjP1WQEioxz+wDpNWdw=;
 b=ZXhc3jfPmG/R7+psGlUe8A1rAZShya6MOKKpasreNPfsZfZJtE/fiFV6pColl30bnZylOxY/9qywrEMz7n6eSFLoVLKEHMglXX5I0yxyIsrFFAq9FtEhtqJUe/I78Exr+XNyymbGOEUoDIdnEQJcJtfl4wrR0gvFehWszJ2fkVU=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DB3PR0402MB3867.eurprd04.prod.outlook.com (2603:10a6:8:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 07:56:31 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::5062:4c9c:e6b9:d72c%3]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 07:56:31 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
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
Subject: RE: [EXT] Re: [PATCH 1/2] bindings: fsl-imx-sdma: Document 'HDMI
 Audio' transfer
Thread-Topic: [EXT] Re: [PATCH 1/2] bindings: fsl-imx-sdma: Document 'HDMI
 Audio' transfer
Thread-Index: AQHXxjt/4hXSLYx6/UOgXKyNm58zh6vjKaOAgUIARiA=
Date:   Tue, 24 May 2022 07:56:31 +0000
Message-ID: <AM6PR04MB592542FDF9B773ECC5239EB7E1D79@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20211021052030.3155471-1-joy.zou@nxp.com>
 <YXY2Ra+/j1apuRpZ@matsya>
In-Reply-To: <YXY2Ra+/j1apuRpZ@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be90dbe3-0ede-4bb4-60f5-08da3d5aea54
x-ms-traffictypediagnostic: DB3PR0402MB3867:EE_
x-microsoft-antispam-prvs: <DB3PR0402MB38670627D8F17DADF3BE99A1E1D79@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Tymj+9fKOOKqHcO943pyIX355RO/Y/SrQ+A0McaKyfzMsx1x567D1A1ulD+79ZJiiE+XExDUL11FVy8w3ZIDjePpKoEmxX17Z4gOCGzj66PX46tzm1o8zFLS0f8LTjaXsv6YVIXeow3igkp71WTq/lt3ijNgYg2PGoi55BXp1tYlNRYLob4efUlj3ONMDL5P/l16vHaltCmsvUdBkGFn2rrr5uHPHzhTv0MY8vgqZBoax+s3pJnoDO403b3B2UF07s5c1YFB/BIiE+98nNLJtHPBZa8MTFfLzldZF3TVLL30WvakCpWKB4CUCCt5kvxIBdQwZCsOQ6nwo/SXG6pYJDHxQq/3MKvZ4+RA/5ADRTqICz+ttlxtgfniUPdXqtvEQXoRwOJ4Ic/gt41aubCI+eaDuAry35xhfeolUyf2pTdEbfn8/iuj5Ya32/YLIe/UWQPGwBG156KdfCOEaKuZN0/8Q8r2BVcQSfxRAsUA489CrG2PUJK1BkwDrkVSI79b9T31A8o+XT8V66v4w1DY6GvGi94RSKRDw6/e4/NKtkMuhABViL7YTYXIdx504SfJej1tapnbdFVp8ADn9OmHYBTYKeRmeAHbl6WHMVGWjQPKCsGAj0F1rSGPZ3+sGqEdy9N4sQIWv89nJ/yvazr7VTPj+67voD5NMl2PXjG5+MMImPnnfyT2K2h78+VfKPxlfpw+o76QlgKPzJRyxUvdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(7696005)(6916009)(6506007)(5660300002)(4326008)(122000001)(8936002)(38070700005)(44832011)(55016003)(26005)(53546011)(33656002)(54906003)(508600001)(9686003)(316002)(186003)(71200400001)(83380400001)(76116006)(86362001)(52536014)(64756008)(66446008)(66556008)(8676002)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c05qVm4xMUVsRmV1eWk4Y2t4UkN3Z3RqVkdQNFBsT2grWCtmNWR2NUhHTW4w?=
 =?gb2312?B?S2NtRG1uOUJQeDNPdWQwQUJDY29wNSs0Z0JIYXlINC9xMnQ4bklvUUpaZG1N?=
 =?gb2312?B?a3Q0cFJTK1J3Mm1hWVYyNVNRUXpOVXU1OFR0SzJOeUtlaWJDa3lKUG5LRkJM?=
 =?gb2312?B?R2ZiTVdBakhXcUhFMmJEeEhudWZHZjAvVDhCSHRJcXBUV1czSnVHbnR2WDdJ?=
 =?gb2312?B?NnVlclh1MzI3bk9qWVpEK3BzUkMxMlJyS0tsbExBSFJtY0ZsWUxtUXk2eGd5?=
 =?gb2312?B?TlJBeHRZNWZ1bkpDZys5YTVzRjFTck5hc282Yjk3WlpBRmRSdktJZ2tSYUhI?=
 =?gb2312?B?T1hBVUZvZXoxVVhsZzc5eUtUejY5L0hGMFJDeFpBUWdYUVB2RENhUkpLNXhl?=
 =?gb2312?B?V1B5d1EyZ0ZYbHg5SjFhb0hVQi9mTHhnV1pCWXM1QTN4b3Z6aWZ1dEtsVFUr?=
 =?gb2312?B?ZjJwNUFCcWVGbVMvRFVTUE1jK1ZOVFN0M1hCeVFGTUNLTVkyQXNpbGF2ajV3?=
 =?gb2312?B?V0V5VDlZVWY5b2d5alJNZlZOVVV4aVFPOUdtQks4dHRKUnhzSmprU0NRdWdQ?=
 =?gb2312?B?SGl0THdVWWtVbTN0SnU4eVN6WmdJVlp2MVpoSXZTZTdMeWZ0YU9KTUhMRWhD?=
 =?gb2312?B?N2JrVGJKNStsNlc4VjRpcFRYWisycG80SDNwWlhreTNINVNsOUVSTVBrU1RE?=
 =?gb2312?B?bXduSER4RVRyckRIMlBZWGNDSjVLNWRDV2R2R3FkNDY1R2tPeldiblFRZFE0?=
 =?gb2312?B?ejduUEY3M1R6N29ma0hnZ1BOMjg1WFBSUnB6dHZPVFpHUmpSb3VKR1UwUE5o?=
 =?gb2312?B?NnVZR0pQM01aeVVDQ2pPS0JJa1k4dkpPeE5pdU15Tkw2MlphNzgvMjR1UUZN?=
 =?gb2312?B?ZHdLRGx0VU1aZGhyNEhaVjhtRkV2eVhnMjh5ejlCVXgvYlVJOW8ydWxxK3BG?=
 =?gb2312?B?Si9HM1VNbjMvWFdQVnB3UGdFT0dLVXFaVG9tNDhabTZRb3pkWmZDSnpvUitO?=
 =?gb2312?B?UWJVQTVnT3Y2UEE5T1NhaVFxWmhmcGpzSE02SDgxNzRmeFd3UHROSko5TVZJ?=
 =?gb2312?B?Z0R6bDd0dVRzT2dpWjJLZUhpK0trK1V4VFo4R2h1TlRPSkFOY1RjOUprM3FV?=
 =?gb2312?B?RVdoKzlGTnV6Rm5obmQ2RDl2Szk0aWxtNFJpMlA1aXJsNlJQRnR1cU14THVV?=
 =?gb2312?B?bHRrVk00T2h1ZmlKMm83cUNacjR4ZTUwbnNoaUMyc3Y2dnBiVWpBMnZqTmJo?=
 =?gb2312?B?M1V5ZjVXYkdFSFZUYmF3WUhDV0Jpcy9ZVUdObkNMTUkvcXdiRzVDTkFuSWdS?=
 =?gb2312?B?L0YvN0xpUXJNUG1VOEJSK2U2eVF6ZW90SmpIOFZrRllNRXJoam9Kc0dXMm16?=
 =?gb2312?B?NmRESWJBZ0NGck1rSW5qSDBxZGs4bHVVTmc0SEhuOUJKWlBiMU13QWxNUDZJ?=
 =?gb2312?B?SEZmNXo0THZSeWJYRkNrOFNSUHRPSkNVeksxKzZJb3dJNE1pLzVJUXg4WVk0?=
 =?gb2312?B?c1UrTGRuVU5ueXBqMnVWV2UrTGV2NGZETVRvSk0zZStsVjBBeXFjZklaSXB5?=
 =?gb2312?B?WTNIUXhFVmNpZFFtM0JUa3A0cC9Tb2dNMXRMVmZKVVZUVWpPRTdrQy90M2dN?=
 =?gb2312?B?dFAwcEgwMmRXV3Q3am8rTjFyQUxDZzZsdVVUUVU4K1pYSEZSSFpmRTVtYTNZ?=
 =?gb2312?B?My96ZXdRU3l3TXloc0hKZlZpOUxPbmwxV29ieCt4dWx4K0hDWDZ3elJWU2ZO?=
 =?gb2312?B?SUNpaEpBRnBwSkhqSDM2c2k0Ykx0NEJOUHJvUXM2SmtnTWIrck0yY0JRdW1h?=
 =?gb2312?B?T2JYSTZYQjgxeStlY0Q3cVo3TnljK1NEQ2IxNUdZNGZZYjlldEx6MG1DbEpQ?=
 =?gb2312?B?aURTa1NhamRLaXpRcXJxRktNVG5yMmJmRUQ5dDJSTmhxNE5odFdWdDZEdEg5?=
 =?gb2312?B?aCtZUmlFUWd3ajdLWEVmbTRmU3M3cDdhcFBmRVhFNUF1UnJnWDBYYXE2T2c3?=
 =?gb2312?B?NEQ0OHlpTVF1Y2VqaTJYYjRINS9KWHMyeWY1Y3N3VWhVR3BtZXZpM3dtb052?=
 =?gb2312?B?WW92ZTFyR3dub3pCbGtzcjdSMEhrZ2pEeDQvaFpNemVjRitqYUt2ZnJ6eWVO?=
 =?gb2312?B?R2NtTHRlYWtaUUhna24zK2M2dDBGcjQ3UERUN3UxdnFYS2xJazZCR1hseXEw?=
 =?gb2312?B?QXpEL2ZzU2NEWFdpUU5mWVBwK25tbkpuaG4zK1AzMGduZlhsa0VkWEpDSmhT?=
 =?gb2312?B?RG9kK1kwSGo1MVR2MHV4dUdWVUZZUjRTSjNCQWF6QXlKMGZXWkVrOVJObm9u?=
 =?gb2312?Q?m2Jq1XqwsjATHtmpVX?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be90dbe3-0ede-4bb4-60f5-08da3d5aea54
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 07:56:31.3627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZMDZX4TG3CGwHW18Vf3V/OMAXdynhWmf6CVdU1WkNzNBckTnGDc4qC4zSXx142I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
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
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjHE6jEw1MIyNcjVIDEyOjQ1DQo+IFRvOiBKb3kgWm91
IDxqb3kuem91QG54cC5jb20+DQo+IENjOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+
OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SCAxLzJdIGJpbmRpbmdzOiBmc2wtaW14LXNkbWE6IERvY3VtZW50ICdIRE1JIEF1ZGlvJw0KPiB0
cmFuc2Zlcg0KPiANCj4gDQo+IE9uIDIxLTEwLTIxLCAxMzoyMCwgSm95IFpvdSB3cm90ZToNCj4g
PiBBZGQgSERNSSBBdWRpbyB0cmFuc2ZlciB0eXBlLg0KPiANCj4gQ29udmVydCB0byB5YW1sPw0K
V2lsbCBiZSBjb252ZXJ0ZWQgaW4gdjIuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm95
IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS50eHQgfCAxICsNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQo+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQo+ID4gaW5kZXgg
MTJjMzE2ZmY0ODM0Li5mZmE2MTI2NGEyMTQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0DQo+ID4g
QEAgLTU1LDYgKzU1LDcgQEAgVGhlIGZ1bGwgSUQgb2YgcGVyaXBoZXJhbCB0eXBlcyBjYW4gYmUg
Zm91bmQgYmVsb3cuDQo+ID4gICAgICAgMjIgICAgICBTU0kgRHVhbCBGSUZPICAgKG5lZWRzIGZp
cm13YXJlIHZlciA+PSAyKQ0KPiA+ICAgICAgIDIzICAgICAgU2hhcmVkIEFTUkMNCj4gPiAgICAg
ICAyNCAgICAgIFNBSQ0KPiA+ICsgICAgIDI1ICAgICAgSERNSSBBdWRpbw0KPiA+DQo+ID4gIFRo
ZSB0aGlyZCBjZWxsIHNwZWNpZmllcyB0aGUgdHJhbnNmZXIgcHJpb3JpdHkgYXMgYmVsb3cuDQo+
ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiANCj4gLS0NCj4gflZpbm9kDQo=
