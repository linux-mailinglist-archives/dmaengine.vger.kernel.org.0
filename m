Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C355ADEC0
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 07:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiIFFFA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 01:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiIFFE7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 01:04:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A35513DF6;
        Mon,  5 Sep 2022 22:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVWmbR475HL6OE5TDGz+lWCFrQY/RHGKxAh56bH8ukjbNIV/3Yn1GD4slm9VyqDyjS0meS8137eRTGxXExBMaW5RuABPXvS55UNz3m3UXDJ6QhKYbvfNoBWTGzLXuMgh1XI7+IjBmM/xuAtlqe48ZG4/tbbESLQDhMQxNpYau0oYnhElh7niftetc9AASBtKpJDPEdMefcYq7Wt7eq177dPaUuGVkGGyaD0wT3TKf6xSUJfv/WC1ewtpGNZ3tU1+VYIxEeSUphdmn4TNUC0XmCetvdVSTXEj6MVMIUGc46v5r85z9zLKP329QLUnHfmz1kA66VUhw0F1Mt+U4HK5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHg4+kBJQ5GkbuKIxAniGNdZ5xZKK7pwnk1hpw/u8TA=;
 b=LM8ALu42mFDtgoRCEI4D6YDQ/RtxwMeLPnHLRFSiwBDssYnRDs4hWEL9pqIcQhK24TaSJgDsXwQZ9Q/JIfSygT967AG2X7GQKocCohjsIfcz3vABOXW7PveIhlwAcapDAYpzyT0yx6g/7SrVE2EI1lN+BxzalUm/uEZPZDYZm6Ido4AtDQUso+zEqaMZyAW/g5n/HmLxNbNLz1fxPcxkNOsVC+Ntz5t1KVqeIwgRk36KGVfLhpWgiOGGSzUpgcFtpJMkl+VIYrtE0d5uunTiiupiiTNywEdfx67hyDeNT9IsSJsR6giZ0wTAZ9VDAx1EoHVGOv+4C4uAEpSCqeq78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHg4+kBJQ5GkbuKIxAniGNdZ5xZKK7pwnk1hpw/u8TA=;
 b=nYUoipZl6MHxUuf0aYbTtdWDzVD/qqVHBzPD2oy1yrgNtbdDrHxcbBs6ufrMbzyamMa9wzGfWcr0cywnnjw7fW8xTkte24XaDaQUhVwWDvFFA7+yaz+mHVrMbQ4TUV0G5ZXn41BXnpbh9jvVlzQC9osf2ND7XjSIzjEAXT/1LoM=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DU2PR04MB8758.eurprd04.prod.outlook.com (2603:10a6:10:2e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 05:04:54 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 05:04:54 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Topic: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Thread-Index: AQHYvaZ8O5GQjHuFO0+lJC0QJTvpyK3PeAEAgAD00fCAACIHgIAAAFNggAAjwYCAARb8EA==
Date:   Tue, 6 Sep 2022 05:04:53 +0000
Message-ID: <AM6PR04MB59255C66A2DEA7B0A8B3C22EE17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220901020059.50099-1-joy.zou@nxp.com> <YxTPTnrJst9aNpsl@matsya>
 <AM6PR04MB59253DD6C91D41344C08C175E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <0d523880-9214-7b9b-ce1a-d06d4d5fbdf1@linaro.org>
 <AM6PR04MB59250C67D565B6E5E52621ACE17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <YxXXex775kSSmGin@matsya>
In-Reply-To: <YxXXex775kSSmGin@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34800c35-e43b-4f18-7ff8-08da8fc555fa
x-ms-traffictypediagnostic: DU2PR04MB8758:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dRIZ8iAGyDLpFB1AxaPqW3B7BBVL5K9fY4yCVeWJbim5BQFl4235yxDGTBUG2b7xKTY50Jdccdm7fr5sOXwjO3SC8+8YyD9hzC6DCXCNSmphAKymfiY4cNquugyvq5OF/k5uuENGZUs52EjPrUYEXlc1nBccYjlu5/lrn8I9SN1GVmfOOUa+Ks0DCNAxmWLTPtYygbiMokbtLjmYifpj44913MkqS8LFIrumbvUGwrgyKX5uOA0CgvqSv+Ua/eiqZacq4vi9qmc5xLmv2399Io05xN0F6FJjX83rmVjGOFKnKKjNBEHc9rJtMSOUS5MADRvThrE7a1uLksxE7ahRfHvkIg4WwnbFngfIdz4702cI5LPs2bOnV92SYqO1UknMEsZ2YBcTrJa/AeLKh+cqG9b53Ch+aB3HEtIlXgAOSdNW7YQGC2OkaCYFcIzVGh9gjeJwYjVwbnyqiF48jEI8wPWHJ/ySdG27bzePLVJqPXGTcmCWfsSJ+c7md6fLZr2HOvC78HBNZ9Oft7R/9gXUM2PiJljLoGA9MeRqLWbWnx9Dp1MJUfizL/3eEJxnRE473Wd6NdWGtvhP5hIRcqhd7IW7irXFhoiUcNHN/H1SMDMX2kYyEQknTQmIPdS9TOJHLoHekNV9gNti6ibipitwSraN/r26a9IRhfYkUufZ8JfFkgMzBCCXjgzzmy4TRBOQHzg0ko9+l7UP80OsuqhiMdu1M/A/sZjxL1YbS+a3yV6ZO2ujYFiujs+7VA/uC5hBBXxc5Ctp3+aPHIJ7nxqRaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(52536014)(9686003)(41300700001)(26005)(8936002)(122000001)(2906002)(33656002)(478600001)(44832011)(66556008)(38100700002)(66946007)(76116006)(66476007)(86362001)(64756008)(66446008)(6506007)(8676002)(4326008)(53546011)(7696005)(5660300002)(38070700005)(54906003)(6916009)(186003)(316002)(55016003)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dmRYTWE0eU9mdmNYYW4zYWplSHhuanhvb2hpMmNCRlJGTlA5R21mRzFsTEty?=
 =?gb2312?B?T0V4Mlc1TjN3RUxRREszM3Vwemp4OXUwTDExaU82WGFvUnJBalRrSGs2TjdH?=
 =?gb2312?B?T0RqRnE2dEkwM2d2NUNiRE1OamwwdFg2L2NKUGZSalMyT3RTeUFyOS9COUpL?=
 =?gb2312?B?OC9hNm5NVVFzWExwSUlZV0FZZ3Z0NU5iM2x3QmowTklhNTVrMnJOUEp3aWJo?=
 =?gb2312?B?MS9zQ29SaDY0R1VycjdJVkt4YzB1dXlMQUpjd2RYaUpyUHVrK25Ubzl5OEN4?=
 =?gb2312?B?dm45TW9CZnlhVkZ4VTU2dlhLRXR2UXFwSlFSVVcxNXRIcFNRUDYxd1dsWEl3?=
 =?gb2312?B?OG55RHExb3RNREk3a2RCOXZkR29NcndrYmo2VVRrdlVUUjRXWkI3dVBvY2Yw?=
 =?gb2312?B?RU1Td05zTzVzWUUrWm9BTHhrcUtiQkxiRnRiQm42UGRreG9TamxSa0Y0b3RT?=
 =?gb2312?B?L0YyTnFWZ3RKZTk2OVY4cmlPcENFcTdVUWxRT0JTZGdici9kVVQ3NTgxelN0?=
 =?gb2312?B?bDZZUm9waG4rOXVoK2F5eFZzckprcXBpanBtM2NBZk4wZlFoWXRuLzl4RXVx?=
 =?gb2312?B?Z3c3d0RtdzZUZTd3Z2FqUjNPNzZISVR4Y0puYUVBRGxvamNxUVZGNlJxOHY2?=
 =?gb2312?B?WHVHc0NSOU8rb3ZIZ0tSWExrUjdHRlpiVUtSM0ZOdzlLTGVjTWJYNnB0OWFJ?=
 =?gb2312?B?alhieU1GcHpheENKMDFIZ0poUEdpbWNheC9FbnBCMVJyUGlKenQrNk0xZVdn?=
 =?gb2312?B?ZUNDWWJsZ2MvUWowUnY0WkRGTWJQMFp4cWlnODZ6cHYwWDlWTk1aVWFFbWJE?=
 =?gb2312?B?bTAxTGw0NEw0RDdqNkVWaGhwWFl1cG9nRWFtNld2RmVsTk9SSUE2WURVd0oy?=
 =?gb2312?B?RnVPUkdLNnlvenBXS21iZ2JvQTN3b3duak54YlVYZW0zK2Y5emxQcUZYNmJN?=
 =?gb2312?B?cDl1ZHYrQjFqNEk1M29ORSswNlFvbWZZbnRpN3lCdmNCOEkyMkV1Y3p2Q2h3?=
 =?gb2312?B?VGJUcjVEOGNibEx4dGhJQ1dsTitPS0ZHNWF3UE9nbHdFY3NodzFjVXpPV3hB?=
 =?gb2312?B?M0VtZXg1L3J3QUhoQTRvWHJabDdGaUJXaFRpcW9qT1JKdHRVZC8zbGExbTN5?=
 =?gb2312?B?akE3UVJaNGhZbE1EakpOV1N1VlV1YWNrVGdpSTJBTzNGVGRmK204RnZYOVo5?=
 =?gb2312?B?U1luRTdnSkxQRzQ0dk1wVEk2SWxZZFJGYzlXR25lUU9QSG1neTVxTERwU0ox?=
 =?gb2312?B?aDNuUVlGMGYxQThxNDFWOFYzWHdaRHlPMjhkVDRoSXM2Ky90UkFKNFFvaXhW?=
 =?gb2312?B?SDJlelptd2lpQXpWcFNvNjJtUWJNVkJIRENIQnBMUlZlNktpS2ZiWXhSNEN3?=
 =?gb2312?B?Uk9LNmVVYjJoMWg0Z0wrWk5UckQ5dkt6cVJxUGMvakNKVzJNNE5mSlFUQjNW?=
 =?gb2312?B?M3pTK2FvY0JXNlNQYU1aVGtqL3crMU5NRWZ1QU9hQWFXNVJKR1hsa0dXRHp2?=
 =?gb2312?B?NHVoSnV3N2dMVHYwSW5zelgvb1dxQUp5UWtGdWhJNGFXZVBGMnBhTjhzZWlH?=
 =?gb2312?B?NUppa3liL0FBSnFXM0VsaG5IZlFVc0ZzdGtUckFpM244OW81Q001UllxL1BX?=
 =?gb2312?B?Y1I0MmlmcDY3TUVTVEVuQXRyUHloMTZrSjdtYnl0aGdkckVoU3d1d0NXOHcr?=
 =?gb2312?B?di82cmFwS3AyMGsyODU0NUN0Qm9tYUVYZlRXenhQRmVoR1ptSWNXRE9vRURa?=
 =?gb2312?B?bXREMmFrZjQwZ01QZTI1b3lOWkRTejRPMEtsM01aQkVBZENaNnV2cnpjS3ZO?=
 =?gb2312?B?eURxanlhZFFGNUNXSnNJM1RDVWdoTjNheE1XaUQ4eFJKZkVqekUwN1RPcHJ0?=
 =?gb2312?B?SlE2R3VaUkdVOStDWGRTUWFMc3JGQjVHaE1QekNvb0RNWU0yaG1obUROQ1Jt?=
 =?gb2312?B?L1dnZjhKVy9IajdTVW1oYTBBMmh4U1BXbzVzdFluNnFGRHZTVHJwUkRHUnQx?=
 =?gb2312?B?cFNmQzVwOWdSRHdhVnFVWElHRno1ZUR4Y0NoZEZsVThOVXgyYmQ1RkNIRjYr?=
 =?gb2312?B?Zm1jaEd5Q0pkMzhyWWc2L2xRbHBMVys3NWhKZ0h5TXovT0Y2ZHR2WFl2M1Bj?=
 =?gb2312?Q?TcqQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34800c35-e43b-4f18-7ff8-08da8fc555fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 05:04:53.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1qhYaQHeeeFt/N0mB2CTwQ6p7057FZK3ot1A5yJRMg/+qudHSkAgKVctrDONJ4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8758
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
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jnUwjXI1SAxOTowMw0KPiBUbzogSm95IFpvdSA8
am95LnpvdUBueHAuY29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraUBsaW5hcm8ub3JnPjsgUy5KLiBXYW5nDQo+IDxzaGVuZ2ppdS53YW5nQG54cC5jb20+
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxsaW51
eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCBWNCAyLzRdIGRtYWVuZ2luZTogaW14LXNk
bWE6IHN1cHBvcnQgaGRtaQ0KPiBhdWRpbw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0K
PiBPbiAwNS0wOS0yMiwgMDk6MDcsIEpveSBab3Ugd3JvdGU6DQo+ID4gPiBGcm9tOiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gPiA+PiBP
biAwMS0wOS0yMiwgMTA6MDAsIEpveSBab3Ugd3JvdGU6DQo+ID4gPiA+Pj4gQWRkIGhkbWkgYXVk
aW8gc3VwcG9ydCBpbiBzZG1hLg0KPiA+ID4gPj4NCj4gPiA+ID4+IFBscyBtYWtlIHN1cmUgeW91
IHRocmVhZCB5b3VyIHBhdGNoZXMgcHJvcGVybHkhIFRoZXkgYXJlIGJyb2tlbg0KPiB0aHJlYWRz
IQ0KPiA+ID4gPiBJIGFtIHRyeWluZyB0byBzdXBwb3J0IGZvciBoZG1pIGF1ZGlvIGZlYXR1cmUg
b24gY29tbXVuaXR5IGRyaXZlcg0KPiA+ID4gZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5
cy8uDQo+ID4gPg0KPiA+ID4gVGhpcyBkb2VzIG5vdCBhbnN3ZXIgdG8gdGhlIHByb2JsZW0geW91
IHBhdGNoZXMgZG8gbm90IGNvbXBvc2UNCj4gPiA+IHByb3BlciB0aHJlYWQuIHY1IHdoaWNoIHlv
dSBzZW50IG5vdyBpcyBhbHNvIGJyb2tlbi4gU3VwcG9ydGluZyBIRE1JDQo+ID4gPiBhdWRpbyBm
ZWF0dXJlIGRvZXMgbm90IHByZXZlbnQgeW91IHRvIHNlbmQgcGF0Y2hlcyBjb3JyZWN0bHksIHJp
Z2h0Pw0KPiA+IEkgYW0gdHJ5aW5nIHRvIHN1cHBvcnQgZm9yIGhkbWkgYXVkaW8gZmVhdHVyZSBv
biBjb21tdW5pdHkgZHJpdmVyDQo+IGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvLg0K
PiA+IEkgdGhpbmsgdGhlIGZlYXR1cmUgbWF5IHRha2Ugc29tZSB0aW1lIGJlY2F1c2UgSSBhbSBu
b3QgYXVkaW8gZHJpdmVyIG93bmVyLg0KPiBJIG9ubHkgd2FudCB0byB1cGRhdGUgdGhlIG90aGVy
cyBwYXRjaCBhcyBzb29uIGFzIHBvc3NpYmxlLCBzbyBJIHNlbmQgdGhlIHBhdGNoDQo+IHY1LiBJ
IGFtIGFsc28gc29sdmluZyB0aGUgdGhyZWFkIHBhdGNoZXMgcHJvcGVybHkuDQo+IA0KPiBTb3Jy
eSB5b3UgaGF2ZSBub3QhDQo+IA0KPiBJbiBteSBpbmJveCwgdjUgMS8yIGFuZCAyLzIgZG8gbm90
IGFwcGVhciBhcyBhIHNpbmdsZSB0aHJlYWQNCj4gDQo+IFBsZWFzZSBmaXggdGhlIHdheSB5b3Ug
c2VuZCB0aGUgc2VyaWVzIGFuZCBzZW5kIHRoZW0gdG9nZXRoZXIsIGl0IGlzIHZlcnkNCj4gZGlm
ZmljdWx0IHRvIHJldmlldyB3aGVuIHRoZXkgYXJlIGRpc2pvaW50DQo+IA0KPiBGV0lXLCBJIGNo
ZWNrZWQgdGhlIHY1IDIvMiBhbmQgaXQgZG9lcyBub3QgaGF2ZSBpbi1yZXBseS10byBzZXQsIHdo
aWNoIHNob3VsZA0KPiBwb2ludCB0byAxLzIuLiBJZiB5b3UgYXJlIHVzaW5nIGdpdCBzZW5kLWVt
YWlsLCBwb2ludCBib3RoIHRoZSBwYXRjaGVzIHRvIGl0IHNvDQo+IHRoYXQgaXQgd2lsbCBkbyB0
aGF0IGNvcnJlY3RseSBmb3IgeW91DQpJIGFtIHZlcnkgc29ycnkuIEkgZmluZCB0aGUgcm9vdCBj
YXVzZSB0aGF0IHRoZSBwYXRjaCBub3QgYXBwZWFyIGFzIGEgc2luZ2xlIHRocmVhZC4gSSB1c2Ug
dGhlDQpnaXQgc2VuZC1tYWlsIHRvIHNlbmQgc2VwYXJhdGVseS4gSSBhbHNvIGtub3cgdGhlIHBh
dGNod29yayBjYW4gY2hlY2sgaXQuDQpJJ20gc28gc29ycnkgdG8gd2FzdGUgeW91ciB0aW1lIGFu
ZCBlZmZvcnQuIEkgYW0gdmVyeSBncmF0ZWZ1bCB0byB5b3VyIGNvbW1lbnRzLg0KSSB3aWxsIGNo
YW5nZSBuZXh0IHBhdGNoLg0KQlINCkpveSBab3UNCg0KPiANCj4gLS0NCj4gflZpbm9kDQo=
