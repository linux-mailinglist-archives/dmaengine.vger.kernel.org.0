Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5164759F7CB
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiHXKcI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 06:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiHXKcC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 06:32:02 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E07FF92;
        Wed, 24 Aug 2022 03:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk4U5WZEyA3yOA1OLkyIyawTuN9/ye6LK12zVWfjRWBe7jmTbMJ+QZtq0+JinWpGwZ67QsXw+tW+ld0SwWiv1heEbwJuGaUKu0VTAynvXFHOWkd1cWziYzmvQ2J7fyMy15aIGC0FauALR16uI6yKyhYK+GHK80hMwK3SAZ843ctyWF21DJk5KmsOBvBoKdKI4dlsLKSokfJ9WOLV47iMjOB1npVkNrOlnE24KfpIXCn2FekzxJm07xC8a2rpegBC7XZ4ShdYUwMcdLDPVZQt2UaEsvL2CxB9hspLvbQnagaDh/JIMrE+GyaH/p4q3tr5uaQWE/fDY9W+NXfJ6Kl4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1tvXeq3cVnIRkdYhimmNN05WYJT1drAQPtA9tbFR/U=;
 b=knfkhBbnrxvqJToxSWg3YhDRx01YJPAmgWxLovyPt+j6t7zoR9xW5Z0EPa3XmkdaTokHviS+fTzxWvfmqxH8Aq5oy/Kjne7Y9SKm2bqMQEXvjnJFmlA/if1aWhnG5CAI5FiVKu4vmc4WgC7OsqZ9mtlAQWZvVARSPCogYKn32LygKwrcmo6KmhsKau5dsmz1zKe9fZAcbe88GdyHD8jd4drs6Nj0cwTqoOzUWrLGegCsclpqUi6D6RCdjnIZf4ovq4F2wLvvaOdG5MFTmXsjEToo5qq5RSKt8EQKzE8B7habWf4aGPJu9DOb4oZ2/gUK8FKvRHvTgkQX6RelYcT9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1tvXeq3cVnIRkdYhimmNN05WYJT1drAQPtA9tbFR/U=;
 b=NhlGPLMds6gEJDvYQmZSFwtK6HgKX8RP4qjJ4KHJP+D+QwrwGp7UhKzguit+Jbg2uSgO+I/csdaAvjRIhvPXgdI3NZIuGXkciz9ph+cFdCGANz6gPDhYekjKuDHrkiRA62Ym7VzHoiF8TIDexYvve0bmN9bpk9HCgHYWHV4JQvk=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM9PR04MB8146.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 10:31:48 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::687b:4526:6b08:a663%7]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 10:31:48 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
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
Subject: RE: [PATCH V2 2/2] dmaengine: imx-sdma: support hdmi audio
Thread-Topic: [PATCH V2 2/2] dmaengine: imx-sdma: support hdmi audio
Thread-Index: AQHYb0UDxQBEoTyE4k+etryTbMWZ662baA4QgCMCywA=
Date:   Wed, 24 Aug 2022 10:31:48 +0000
Message-ID: <AM6PR04MB5925609280F3D1DF8D331CDCE1739@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220524080640.1322388-1-joy.zou@nxp.com>
 <AM6PR04MB592554C5B222B1AF221C5E2FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB592554C5B222B1AF221C5E2FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37d8a89b-e42b-4990-5c35-08da85bbd999
x-ms-traffictypediagnostic: AM9PR04MB8146:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvV3mC+Q7X5EvyA94MUx0JN/+e0IVN0wnm9UukQtwHTyhXBcm//76zRCS5A1Y9wHQ2MLl6BlnwXxuXwCqAzZK9Ie2bUEqaA7o7WecRVrpwjMSWggbxeTVBU9yq8CREQWcZl1JgjkBX7veC8yP0IxfcUrJmtq0YKC/3EypDSHrgmUZgkiqBYKEEdlL0AHcrhsC/2qmnKuMn4BprTZNAA0PTkuKhiOECgJZh463//IBgcrZOGmJOOye605DXV2IWPuJXW/zuGvFbs/LeIMasaVV6M0mvk+2cUnhAVLp+/tHSknmayfKOxEcG4mvJdbupIVKaEbg3rzKVAxoAc176Q1RFX/hofAYtMOGkfIc1nqPcIp68RrOz+qb8Zl8PgFSZU85jSBjPJbU27SgP8iJ20Dca9dHF7ISzJNDo1ILmgJ6niS/VDchFhmCVlcXEOIyb8krOKhXtlCEqlNstFXLb4foHYO6c0oYT9SUdiMtpoZmPT4ciHJlcZ+Ck/9A4sP2bysw4kx75KMh6MQGZ7P9Azdl1b6nDBGkR7y/WPvpz8NVMwYRRvrbBU7/2MEEhDl/pk9qnkluTtWl2SC8UZuwV1QwVY8ybGbs15riPB8CI3umvGgOjj1QaOYcb6OxrlYOL1XUdARyGnR0pWatKVAgcCDSHe9Qigo2k+Neb2CP3xZue8SzJhYXfwholLZMH3Aqp+iNmHEO/YYCPk7GcOlJVJWQOJQoXjbe23ck3Lr+SSg5RqpPqbwn/xnZ1mH+wzT0dNAovjeZnz2hRvtyaZp0T8P8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(122000001)(38100700002)(55016003)(44832011)(54906003)(33656002)(7696005)(86362001)(53546011)(9686003)(66476007)(66446008)(66556008)(64756008)(66946007)(6506007)(8676002)(4326008)(41300700001)(76116006)(26005)(316002)(5660300002)(52536014)(38070700005)(6916009)(8936002)(83380400001)(2906002)(71200400001)(186003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WHpsUUhvZEQ1WUhhdGd5dUJNZGV1YW9QZGV4eENabHJ5UGZpaEVSRmE2V3lP?=
 =?gb2312?B?emcrdE9rUm5sWENrMDgwUkNKbTZkTFJIRHRJZDQ5MEVTZURzbnpzMTVuWXVP?=
 =?gb2312?B?a0xtKzMzRnNTQXVxbVNjMHNnQVhMaTJheHBQNFNVOHF0UHQ5ZVpwdGtBTWI3?=
 =?gb2312?B?aFZBU1ZGQVQvRDYzU0xsODRFRkJOSldTbjA4YVR5aXNzK0JvdEdML1lIMVhk?=
 =?gb2312?B?UGZQQzVjYUxDQUZvMlMvL3FnNkJBUTFGM1ZWb2JJU04yVVN2T2tvNHBIVnZX?=
 =?gb2312?B?Zi9QWktvK0FlVkFycmZ4L3dhNkl0bTcvQjd5dnRDbGZmMS8wZVJqd1JrcGdK?=
 =?gb2312?B?TTVQQWxlV0piZUcwREZPcWJHM0wxME9INnpXWXNDWFR3ZHpOMUtpNFBUb0h2?=
 =?gb2312?B?YXk5VTJ1TkFrUzAzNVR5czA1WWxHUFNFZ0xOR3Y5TmlXZmpreXI5dm5qb2Mw?=
 =?gb2312?B?UWJzRE44K1U3cFJrNm1Fbm9nTUEzVE5ncFA3VE52ZEdFa1ozV09qeGE1a1hz?=
 =?gb2312?B?Yk95ZnNkUGRVZDBTdVQ2TW42a2tVT1JpaG1scDZaUDZpUHliam1MK1RNOTdD?=
 =?gb2312?B?Z0s0U1UyVm9uM1lhUU5ENE55ZG5zNHp6WlhjbmlMZkY2dUFqelcza1Iya2c2?=
 =?gb2312?B?OG94NC9IaFhlcndXYTB0S1pKWk5udFR0RWFHQjU4cEtQTHlmRUY2WU9Oa05N?=
 =?gb2312?B?SHcvNmpsNHdWMzN4VGluY1hUSElDNlhjOVFxaHRQNzBzQldURFBqMHF4V29G?=
 =?gb2312?B?bDlJNTJuNzNheXU3eXlxR2MvQmdEbyswRkNzZXZmMVQ1N3Fqa2Y4YmQ4MTRp?=
 =?gb2312?B?N0UvUHdQUFRWRFV4RFBKa2RTc24vUzNlNE9MQXY4UnFjbkduUTlvUE1nT3N1?=
 =?gb2312?B?UnZVRkxGSnhZQWh5ZVhET1VLaGtaWWI1TkxycnV4MW01Umx5Q256UGsxci82?=
 =?gb2312?B?bVA0aDRuWHB6dmdwUEk0OVJVYnlIWG90Q2RkMUVsd0MzSFVjajZ0cDE0cEVF?=
 =?gb2312?B?SDZVVm5HdE9CMGEzT05QSnkzZ0hBb1djeTMrc3pOQnBIVmpFT1BtQmpOai8r?=
 =?gb2312?B?V0Z2eWwyYWJQbVE1VVhvNm9od2tiQWV5RW1VYW5lRUI0Zm1DN2dGbGRGR08x?=
 =?gb2312?B?allWR2lvMUI3L1h4TmhqaHg1Y0RnU01sK29iOTllU0ExQ0NMMCtxMnZpZkQ4?=
 =?gb2312?B?T1N6TDJ3OGxneGVLSFJ4WTlkQ2FJRWlISjdPK1lQSU4xWnJnRXo1K3VhSjVN?=
 =?gb2312?B?SkFNdU0zVEUwbEhCODd5RGwxSUFWR3RpWXQyZXJaSUk2M1dGRmI4RS9TeDVX?=
 =?gb2312?B?OWV4b1BUb01pRnVUZFE1Ym5WRk0zQWJ6Z1RMejBmV0YyT2tHSFpBcFVjdCto?=
 =?gb2312?B?VkN6NHQzL2o5OXVOblZRT3d3SmZIL1hxZmpITlN6c1poeW5LYWR1U3lTZ3gy?=
 =?gb2312?B?cG9ETlJWaVBadjhsZnZQSXlaazM0ZWRncGV1MkpVWjROR1VxdEV3QXRFTUM0?=
 =?gb2312?B?YmV0Ym5tTlBSV3B4L1R6Vm8rN0ZuRUx2ZWRlaTJWbW1lakNJK0RHejNjYTVS?=
 =?gb2312?B?UnEzK2ozUkoyQ0tGQnFDS1gwRjI0Ty9QM0NBZzB2czFWRWhiT0paZGl5c1JI?=
 =?gb2312?B?SzhXQ3FkUUxFSjZzVXlkaVI1R0hZTE9hVUY3WDJJTWVQT3dJNUhPUElJOXBj?=
 =?gb2312?B?RUwyOTFsWWlRdVdGV3FBcmFmbktFdGVDclY1ZG1kamYxZ29QSHkwbEhLamZX?=
 =?gb2312?B?dzIyNS9ZV0I5bVZWSCswVzA1aWtJcEozaW9hOXBHSWpzdTJLTHJJcEZaQVhI?=
 =?gb2312?B?T2hSTUc5RUIyZit2aUVDTGNSMllaaHpLM24yNEI0MjdvMUlheEtmUDVPTWJC?=
 =?gb2312?B?aWdONmNuZCtsSTJGUFB1UFZ0dXhTMjRHVDhuRVlGanlMVGdtMDdrWDYrMjdV?=
 =?gb2312?B?UnViS0lFZitwS24vdzRVVGhqNUplaCtaZWt3NUtEUUkxVjhRSzNFQlhIQ2ZS?=
 =?gb2312?B?emtMTVFQNDFQRnhwQjZUWXhpZ2F0NGxFWWRhc3NPRkZpZCs5cEZyWkhvU0NI?=
 =?gb2312?B?SzRpSXpkR2JTWVdScGl5VDdTQjRuZDNzckwrWitSanV1dHhrVFNzYVZBS3NO?=
 =?gb2312?Q?P1Dk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d8a89b-e42b-4990-5c35-08da85bbd999
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 10:31:48.1962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFcCYsg4Xe5dc3DJJjpFi+OXEVAPpF8bAuvkdQpB0mAXn5xmJEixWuQx7uB1QJeA
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
c2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGRsLWxpbnV4LWlteCA8bGludXgt
aW14QG54cC5jb20+OyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogRlc6IFtQQVRDSCBWMiAyLzJdIGRtYWVuZ2luZTogaW14LXNkbWE6IHN1cHBvcnQg
aGRtaSBhdWRpbw0KPiANCj4gR2VudGxlIHBpbmcuLi4NCj4gDQo+IEJSDQo+IEpveSBab3UNCj4g
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpveSBab3UNCj4gU2VudDog
MjAyMsTqNdTCMjTI1SAxNjowNQ0KPiBUbzogdmtvdWxAa2VybmVsLm9yZw0KPiBDYzogUy5KLiBX
YW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+OyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWls
LmNvbTsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggVjIgMi8yXSBkbWFl
bmdpbmU6IGlteC1zZG1hOiBzdXBwb3J0IGhkbWkgYXVkaW8NCj4gDQo+IEFkZCBoZG1pIGF1ZGlv
IHN1cHBvcnQgaW4gc2RtYS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpveSBab3UgPGpveS56b3VA
bnhwLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IG1vdmVkIGRhdGEgdHlwZSB0
byBpbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmgNCj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9pbXgt
c2RtYS5jICAgICAgfCAzOA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
DQo+ICBpbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmggfCAgMSArDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgaW5kZXgNCj4g
ODUzNTAxOGVlN2EyLi5lOWI4YjJlOWY3YzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2lt
eC1zZG1hLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiBAQCAtOTQxLDcgKzk0
MSwxMCBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qgc2RtYV9pbnRfaGFuZGxlcihpbnQgaXJxLCB2b2lk
DQo+ICpkZXZfaWQpDQo+ICAJCWRlc2MgPSBzZG1hYy0+ZGVzYzsNCj4gIAkJaWYgKGRlc2MpIHsN
Cj4gIAkJCWlmIChzZG1hYy0+ZmxhZ3MgJiBJTVhfRE1BX1NHX0xPT1ApIHsNCj4gLQkJCQlzZG1h
X3VwZGF0ZV9jaGFubmVsX2xvb3Aoc2RtYWMpOw0KPiArCQkJCWlmIChzZG1hYy0+cGVyaXBoZXJh
bF90eXBlICE9IElNWF9ETUFUWVBFX0hETUkpDQo+ICsJCQkJCXNkbWFfdXBkYXRlX2NoYW5uZWxf
bG9vcChzZG1hYyk7DQo+ICsJCQkJZWxzZQ0KPiArCQkJCQl2Y2hhbl9jeWNsaWNfY2FsbGJhY2so
JmRlc2MtPnZkKTsNCj4gIAkJCX0gZWxzZSB7DQo+ICAJCQkJbXhjX3NkbWFfaGFuZGxlX2NoYW5u
ZWxfbm9ybWFsKHNkbWFjKTsNCj4gIAkJCQl2Y2hhbl9jb29raWVfY29tcGxldGUoJmRlc2MtPnZk
KTsNCj4gQEAgLTEwNjEsNiArMTA2NCwxMCBAQCBzdGF0aWMgaW50IHNkbWFfZ2V0X3BjKHN0cnVj
dCBzZG1hX2NoYW5uZWwNCj4gKnNkbWFjLA0KPiAgCQlwZXJfMl9lbWkgPSBzZG1hLT5zY3JpcHRf
YWRkcnMtPnNhaV8yX21jdV9hZGRyOw0KPiAgCQllbWlfMl9wZXIgPSBzZG1hLT5zY3JpcHRfYWRk
cnMtPm1jdV8yX3NhaV9hZGRyOw0KPiAgCQlicmVhazsNCj4gKwljYXNlIElNWF9ETUFUWVBFX0hE
TUk6DQo+ICsJCWVtaV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+aGRtaV9kbWFfYWRkcjsN
Cj4gKwkJc2RtYWMtPmlzX3JhbV9zY3JpcHQgPSB0cnVlOw0KPiArCQlicmVhazsNCj4gIAlkZWZh
dWx0Og0KPiAgCQlkZXZfZXJyKHNkbWEtPmRldiwgIlVuc3VwcG9ydGVkIHRyYW5zZmVyIHR5cGUg
JWRcbiIsDQo+ICAJCQlwZXJpcGhlcmFsX3R5cGUpOw0KPiBAQCAtMTExMiwxMSArMTExOSwxNiBA
QCBzdGF0aWMgaW50IHNkbWFfbG9hZF9jb250ZXh0KHN0cnVjdA0KPiBzZG1hX2NoYW5uZWwgKnNk
bWFjKQ0KPiAgCS8qIFNlbmQgYnkgY29udGV4dCB0aGUgZXZlbnQgbWFzayxiYXNlIGFkZHJlc3Mg
Zm9yIHBlcmlwaGVyYWwNCj4gIAkgKiBhbmQgd2F0ZXJtYXJrIGxldmVsDQo+ICAJICovDQo+IC0J
Y29udGV4dC0+Z1JlZ1swXSA9IHNkbWFjLT5ldmVudF9tYXNrWzFdOw0KPiAtCWNvbnRleHQtPmdS
ZWdbMV0gPSBzZG1hYy0+ZXZlbnRfbWFza1swXTsNCj4gLQljb250ZXh0LT5nUmVnWzJdID0gc2Rt
YWMtPnBlcl9hZGRyOw0KPiAtCWNvbnRleHQtPmdSZWdbNl0gPSBzZG1hYy0+c2hwX2FkZHI7DQo+
IC0JY29udGV4dC0+Z1JlZ1s3XSA9IHNkbWFjLT53YXRlcm1hcmtfbGV2ZWw7DQo+ICsJaWYgKHNk
bWFjLT5wZXJpcGhlcmFsX3R5cGUgPT0gSU1YX0RNQVRZUEVfSERNSSkgew0KPiArCQljb250ZXh0
LT5nUmVnWzRdID0gc2RtYWMtPnBlcl9hZGRyOw0KPiArCQljb250ZXh0LT5nUmVnWzZdID0gc2Rt
YWMtPnNocF9hZGRyOw0KPiArCX0gZWxzZSB7DQo+ICsJCWNvbnRleHQtPmdSZWdbMF0gPSBzZG1h
Yy0+ZXZlbnRfbWFza1sxXTsNCj4gKwkJY29udGV4dC0+Z1JlZ1sxXSA9IHNkbWFjLT5ldmVudF9t
YXNrWzBdOw0KPiArCQljb250ZXh0LT5nUmVnWzJdID0gc2RtYWMtPnBlcl9hZGRyOw0KPiArCQlj
b250ZXh0LT5nUmVnWzZdID0gc2RtYWMtPnNocF9hZGRyOw0KPiArCQljb250ZXh0LT5nUmVnWzdd
ID0gc2RtYWMtPndhdGVybWFya19sZXZlbDsNCj4gKwl9DQo+IA0KPiAgCWJkMC0+bW9kZS5jb21t
YW5kID0gQzBfU0VURE07DQo+ICAJYmQwLT5tb2RlLnN0YXR1cyA9IEJEX0RPTkUgfCBCRF9XUkFQ
IHwgQkRfRVhURDsgQEAgLTE0ODgsNw0KPiArMTUwMCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RtYV9k
ZXNjICpzZG1hX3RyYW5zZmVyX2luaXQoc3RydWN0DQo+IHNkbWFfY2hhbm5lbCAqc2RtYWMsDQo+
ICAJZGVzYy0+c2RtYWMgPSBzZG1hYzsNCj4gIAlkZXNjLT5udW1fYmQgPSBiZHM7DQo+IA0KPiAt
CWlmIChzZG1hX2FsbG9jX2JkKGRlc2MpKQ0KPiArCWlmIChiZHMgJiYgc2RtYV9hbGxvY19iZChk
ZXNjKSkNCj4gIAkJZ290byBlcnJfZGVzY19vdXQ7DQo+IA0KPiAgCS8qIE5vIHNsYXZlX2NvbmZp
ZyBjYWxsZWQgaW4gTUVNQ1BZIGNhc2UsIHNvIGRvIGhlcmUgKi8gQEAgLTE2NTMsMTMNCj4gKzE2
NjUsMTYgQEAgc3RhdGljIHN0cnVjdCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvcg0KPiAqc2RtYV9w
cmVwX2RtYV9jeWNsaWMoICB7DQo+ICAJc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMgPSB0b19z
ZG1hX2NoYW4oY2hhbik7DQo+ICAJc3RydWN0IHNkbWFfZW5naW5lICpzZG1hID0gc2RtYWMtPnNk
bWE7DQo+IC0JaW50IG51bV9wZXJpb2RzID0gYnVmX2xlbiAvIHBlcmlvZF9sZW47DQo+ICsJaW50
IG51bV9wZXJpb2RzID0gMDsNCj4gIAlpbnQgY2hhbm5lbCA9IHNkbWFjLT5jaGFubmVsOw0KPiAg
CWludCBpID0gMCwgYnVmID0gMDsNCj4gIAlzdHJ1Y3Qgc2RtYV9kZXNjICpkZXNjOw0KPiANCj4g
IAlkZXZfZGJnKHNkbWEtPmRldiwgIiVzIGNoYW5uZWw6ICVkXG4iLCBfX2Z1bmNfXywgY2hhbm5l
bCk7DQo+IA0KPiArCWlmIChzZG1hYy0+cGVyaXBoZXJhbF90eXBlICE9IElNWF9ETUFUWVBFX0hE
TUkpDQo+ICsJCW51bV9wZXJpb2RzID0gYnVmX2xlbiAvIHBlcmlvZF9sZW47DQo+ICsNCj4gIAlz
ZG1hX2NvbmZpZ193cml0ZShjaGFuLCAmc2RtYWMtPnNsYXZlX2NvbmZpZywgZGlyZWN0aW9uKTsN
Cj4gDQo+ICAJZGVzYyA9IHNkbWFfdHJhbnNmZXJfaW5pdChzZG1hYywgZGlyZWN0aW9uLCBudW1f
cGVyaW9kcyk7IEBAIC0xNjc2LDYNCj4gKzE2OTEsOSBAQCBzdGF0aWMgc3RydWN0IGRtYV9hc3lu
Y190eF9kZXNjcmlwdG9yICpzZG1hX3ByZXBfZG1hX2N5Y2xpYygNCj4gIAkJZ290byBlcnJfYmRf
b3V0Ow0KPiAgCX0NCj4gDQo+ICsJaWYgKHNkbWFjLT5wZXJpcGhlcmFsX3R5cGUgPT0gSU1YX0RN
QVRZUEVfSERNSSkNCj4gKwkJcmV0dXJuIHZjaGFuX3R4X3ByZXAoJnNkbWFjLT52YywgJmRlc2Mt
PnZkLCBmbGFncyk7DQo+ICsNCj4gIAl3aGlsZSAoYnVmIDwgYnVmX2xlbikgew0KPiAgCQlzdHJ1
Y3Qgc2RtYV9idWZmZXJfZGVzY3JpcHRvciAqYmQgPSAmZGVzYy0+YmRbaV07DQo+ICAJCWludCBw
YXJhbTsNCj4gQEAgLTE3MzYsNiArMTc1NCwxMCBAQCBzdGF0aWMgaW50IHNkbWFfY29uZmlnX3dy
aXRlKHN0cnVjdCBkbWFfY2hhbg0KPiAqY2hhbiwNCj4gIAkJc2RtYWMtPndhdGVybWFya19sZXZl
bCB8PSAoZG1hZW5naW5lX2NmZy0+ZHN0X21heGJ1cnN0IDw8IDE2KSAmDQo+ICAJCQlTRE1BX1dB
VEVSTUFSS19MRVZFTF9IV01MOw0KPiAgCQlzZG1hYy0+d29yZF9zaXplID0gZG1hZW5naW5lX2Nm
Zy0+ZHN0X2FkZHJfd2lkdGg7DQo+ICsJfSBlbHNlIGlmIChzZG1hYy0+cGVyaXBoZXJhbF90eXBl
ID09IElNWF9ETUFUWVBFX0hETUkpIHsNCj4gKwkJc2RtYWMtPnBlcl9hZGRyZXNzID0gZG1hZW5n
aW5lX2NmZy0+ZHN0X2FkZHI7DQo+ICsJCXNkbWFjLT5wZXJfYWRkcmVzczIgPSBkbWFlbmdpbmVf
Y2ZnLT5zcmNfYWRkcjsNCj4gKwkJc2RtYWMtPndhdGVybWFya19sZXZlbCA9IDA7DQo+ICAJfSBl
bHNlIHsNCj4gIAkJc2RtYWMtPnBlcl9hZGRyZXNzID0gZG1hZW5naW5lX2NmZy0+ZHN0X2FkZHI7
DQo+ICAJCXNkbWFjLT53YXRlcm1hcmtfbGV2ZWwgPSBkbWFlbmdpbmVfY2ZnLT5kc3RfbWF4YnVy
c3QgKiBkaWZmIC0tZ2l0DQo+IGEvaW5jbHVkZS9saW51eC9kbWEvaW14LWRtYS5oIGIvaW5jbHVk
ZS9saW51eC9kbWEvaW14LWRtYS5oIGluZGV4DQo+IDg4ODc3NjIzNjBkNC4uZWY3MmUwMGZiNTVl
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC9kbWEvaW14LWRtYS5oDQo+IEBAIC00MCw2ICs0MCw3IEBAIGVudW0gc2RtYV9w
ZXJpcGhlcmFsX3R5cGUgew0KPiAgCUlNWF9ETUFUWVBFX0FTUkNfU1AsCS8qIFNoYXJlZCBBU1JD
ICovDQo+ICAJSU1YX0RNQVRZUEVfU0FJLAkvKiBTQUkgKi8NCj4gIAlJTVhfRE1BVFlQRV9NVUxU
SV9TQUksCS8qIE1VTFRJIEZJRk9zIEZvciBBdWRpbyAqLw0KPiArCUlNWF9ETUFUWVBFX0hETUks
ICAgICAgIC8qIEhETUkgQXVkaW8gKi8NCj4gIH07DQo+IA0KPiAgZW51bSBpbXhfZG1hX3ByaW8g
ew0KPiAtLQ0KPiAyLjI1LjENCg0K
