Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82C5A6221
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiH3Lid (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Aug 2022 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiH3Lh6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Aug 2022 07:37:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B9FE066;
        Tue, 30 Aug 2022 04:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRnsX+1E7nTj0PTf9xGyaVVvz8RcZB1DLmMX8jxzeQ1DimefLATCr8rSBOm9R5lX/GIRtGOfqCJSCJLzaqhJ8TfT1GRxXyOjnvXG0M9+sKNZOdYlOLa6X37uZtXi3WxDzPNHcr98U+Z53mdXqChjjN+kJhCeimRvhgDfgv+m8kn4vbiTRhJyKoIQUUgDnZ/6IZLmA4Q6i15qj0WDlTuCT3psM1XLPll4Inxi7rTlXDVLoGENYdZSEdOhby0ge9QZceGkRTUtAn7fJgv/LjQHGro8dnvpZWxPiq8N/CslCJOCbYO9Vr5PqJ9Zv2/bQeQkT+JBnSUahf5/N12KvySF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5feuEoczvo1uHipowuxq2fDGs7asPBnle1zyAkRZi+0=;
 b=Qd8ht7pJJ2xApWda+MVlEJsrw4g0+LM8peVe+6JfhowmZwLtoollpYmXlaFAdpKEW4w89S/v6t5Y7s1OBi6Ya5xIqmbyNJ1R4wjgG/l+UTEregrIyFBq2Y1bzSGkvaqUmyJPE/o336THerVReInL8xsOybeGXrtOOBzBS4k/y8flNRq5DGwgU/MBrnOlGFLF+K7/uNexAYxq2Ql4J5iXYIT9rLV1QcwPe2rJTIsPis69lkJ3JP8+kWGnxSHhxm8IoUL8/dzMVXUPL0PjeNV/nB2pwuaJKRhXyeR9NkZnZyu5DQxJS1j9j3MfS0P4kko4By8t/OubJK69Ez7jSkMHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5feuEoczvo1uHipowuxq2fDGs7asPBnle1zyAkRZi+0=;
 b=mUVgYqFRYDNE1g9Gv6bF8BeCUAi1prVxXEotMD/eOxM544eJ1n8HLAz/+mWv5yt3VwgAxJVkDsj5iX51wIx4Dad/va1jfBHe/2v/CR9F0BUarYiMZLPlGhMM9Sn4NwWSaUWZeX5qNV+S1n8DKRE75+zNZV8zwhLfGMjJAO6NeQU=
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com (2603:10a6:803:e1::18)
 by HE1PR04MB3306.eurprd04.prod.outlook.com (2603:10a6:7:21::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 11:36:12 +0000
Received: from VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::41bc:4ee:98cf:efcb]) by VI1PR04MB5936.eurprd04.prod.outlook.com
 ([fe80::41bc:4ee:98cf:efcb%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 11:36:12 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
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
Subject: RE: [EXT] Re: [PATCH V3 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Topic: [EXT] Re: [PATCH V3 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Index: AQHYvEjz1baghX1eNEKa9OmRAFCJ9q3HJHqAgAAQuQA=
Date:   Tue, 30 Aug 2022 11:36:11 +0000
Message-ID: <VI1PR04MB593604DC9942CAE351D621EEE1799@VI1PR04MB5936.eurprd04.prod.outlook.com>
References: <20220830081839.1201720-1-joy.zou@nxp.com>
 <40577a34-6046-a10b-e444-4fb36d13e8e6@linaro.org>
In-Reply-To: <40577a34-6046-a10b-e444-4fb36d13e8e6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd955a50-27f7-4509-8288-08da8a7bd70c
x-ms-traffictypediagnostic: HE1PR04MB3306:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6gmiWKfzIHldiDGH3StBzOZjwadlRr+skSvhd/HVADG2bs21p5NiqIVe6MzHtiqb9tS54VM5pGiLDAEZq/LuGWJzXb21lSeWZwMfDnS6FVGx00wwddWQECrq2tMNkRKsMr1oFk8P85eVhP7nUWPAsBo24tus+OhvGSH+LcpeoLb9CA+ItwC6N12srU0jYvQ7QTFzqjJcc0vnQvyjxN0smIF5b6kLyzx/19U0LAhF9KXySrlLylO2+3Bqp55vg43+NB7i27eAmHYesxwSFA476STpCF4BDJq30n5yO0Y8mWG4S41xr6Qx8/SUITPWOshlWMsd+BOw2OVX+eUPb6K3UICmd38N/jHm0nlSYNoJ90N5DPQc7I3zfL+7ZnoCkwvCR/9iIXytkhr+Re0AmGyh1OmStmqjXkMhlr40Dm9W7+KKoZNa5J+hmfL8I0DdLmjo80zDY+GZyZfnDsm2UgaMfiE8Ebaul7jGUulzmkQhlzmiuOoZmTViOBC80UufVqK6SwY7ySBiMlI0sekmZbrAEAKduoOkpNcfiN1fs21Cswxm0628sIn6DXhJGRDtRbX1pNILPBqna2NA2WXrndrDN8g0yHGN1ayJWCC3HcYW0Z6Ew/aRiEp7U1oPOd2PIBuFX7x44yisASw0cw07gVDXJ1MQUWgDtHzCwg3pv+KlQwRbgGyMF30B/J6kgw2kZlxViycMCalnIDDf0tc/JUCEbp46Ven+bn6x4ceZxAd0frETEN4gym9ATtlwjOv87uGgO2vebyrsRUmui78M/qWTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5936.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(38070700005)(6916009)(316002)(71200400001)(186003)(38100700002)(86362001)(54906003)(122000001)(64756008)(83380400001)(2906002)(53546011)(55016003)(76116006)(41300700001)(66556008)(8676002)(4326008)(66476007)(66446008)(33656002)(478600001)(66946007)(7416002)(52536014)(44832011)(6506007)(5660300002)(9686003)(7696005)(8936002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlVRNzhIcHdZRXBMSmJxZWZrSnlkWlVFK0VCQ2dTd0xwZzJqRjVGTHY4eG1i?=
 =?utf-8?B?WFc2RGplRlFWVHovcSswakdxbCtaQ1ZIUHdEL0hZdXNEME9DNVdvbWFVWmlM?=
 =?utf-8?B?YmVnVEJJWTArNFQrajd4VEN3QjRsS1ErUm5FVHk4bHhhSmJ5VEkzc2xOaDlL?=
 =?utf-8?B?WUtkZHRRc28zblkzQklKUWJLVEo5SnpmUEVkcGJEVG5kNzgyWkVNRVV0MER1?=
 =?utf-8?B?eFB0ME16ZU1nYUZiU1RwZ0V5bTJyN2dnZjRxTXFaaW1iemNjWTVFUVg5anlu?=
 =?utf-8?B?dVg3YkNJZDZNcFJGWG9rdFFITysxTHV1NWVrZmtWQkFXb0NDcGVzNWQ2bXJj?=
 =?utf-8?B?RldVT0o4dkU1cWxFQm9wa0NTWFJvbjllUVJLbmhLUFc0K3RGKzYxQnJmcVFW?=
 =?utf-8?B?SUVGNG5xTlhFMERQSm1BckhLaFpxU2FpV1NveFpZc28xMWY4aDlMMXdBU2pl?=
 =?utf-8?B?RG5oY2ZwejBJc0NreDF3M2k4bTdKZW05bmFCaFNxcjZ4T2RoNEdIdzdjaWRi?=
 =?utf-8?B?S1Zuekg2dWVtUFFCYXloKzVzTk01ek1La05HdE9HWDNvSmcvb1l6TE14Zy9Y?=
 =?utf-8?B?NWlGUS9zajVYc0l3dEN2eXVtUE1GYllVc1FicU1RTFByV0F3T2VkSk1EQTBV?=
 =?utf-8?B?cGthYXhMRWsvM28zZER5QnBWTHlrSDB3aHRPNjlvMFhEc1RkWGRSK1U2R2s0?=
 =?utf-8?B?TWttajU0VHE3aStrNzh4dzQzNE8ybjZacDQ3cEpXdjBZUlFoYXBPZmhTUUxB?=
 =?utf-8?B?c2UxZkswQWpYdFpLQUxlV0V0cS82UVNPbFdjWW4vdWNKZW5Xb1dMOS8yQzJO?=
 =?utf-8?B?d3pwMnVmbWtOTHJwb3lsMCtyUjV0bWZncTZTa2dIV2hjSGhlb1BlTUdBZGht?=
 =?utf-8?B?UTlEaHZWTnYzbzNDeHM0VGJJWnJxYVpHbmFKSHpFbFRQaHM3V2F1RWZwdHBQ?=
 =?utf-8?B?Zi9LdHRtU3drZGJWRmlQNEZVaDZDUG90aC8xMHA3QU5uTWRiNW53c2UxR3VZ?=
 =?utf-8?B?aGFkdXNKSjhkU05jNVBDZTY4N0NxMlZGUGh6TEhUc0lGdWJXRlhuNU03MzNI?=
 =?utf-8?B?VmFpMWxtRzR4ZFkvUldrSEtpTklTTHZLamNQMThkOGxBWFgwdURTOFVNTlMz?=
 =?utf-8?B?MzBEZ2NTOEhpRTRHSE0ybml1c2tvT3d2eFY0V2ViV1RiTWJxVWtremRFUEUy?=
 =?utf-8?B?ZE1OSHlUdHBnVldsQjVmS2kyMTZqVTFWN3ExSWllMkdwaTVDUzY5RjY2WEF0?=
 =?utf-8?B?eWJVUVErNHl1U0IyemhYVFVQSTV2NHFHdmIrblpLeG8vOGdoaHdrRTBuczBm?=
 =?utf-8?B?OXE0NXV3MlhTb2hZRUE0UHJjcitRUmE0cDdjMlliVTNzWThXL0FkVUJ0NTcv?=
 =?utf-8?B?RUswVk8yUXRLUGVOZjZtRGZWWS9JU2xhZFlsSmFqbHRXaW02TXhGSTBtUlB5?=
 =?utf-8?B?ZlpyQW9UL0xkeDUvM1l1WVU1ZDdEZWsrWEVnd3lFZGN4RHBKUjRhMVJNTWM0?=
 =?utf-8?B?UHkxemtDS0lRMnZYdjB6LzQ5b3N2RHdIdHN5NVlKWWEwVWZNcDJ4WmszRlVQ?=
 =?utf-8?B?aFZaMmNMUm1iT3JPbk02dGlvNlRyRUgwQU9UUFYwYmVYQWZ4NVBzU2tsZHhl?=
 =?utf-8?B?ckZEeVpYUGFHNk1aWjVlRTJsNVgwNE8vRFFkVGpGWnJHUFBBVVc0cGcxSXYy?=
 =?utf-8?B?dE5OalJrZVFqeTBvV01ab1U5M3Vkb0F5ellQcU5tL2s3dUMzRGFvbzczVGxS?=
 =?utf-8?B?cXlQOGxXR1JZOE5wckxYVkRxWVppbmdwM0FBcjQ0VkEzeG91T0Roa3BZYXdB?=
 =?utf-8?B?RWd3aWV6cHJ3S0RvNjdLT3JrcE1yNi9manI4Nlo0VlB1cFJ1aS9WUzlibW9S?=
 =?utf-8?B?YlBwNTNYNUxtemY0QXo4dmlDOCt2TG9paVNSQW1kaGd4MGtrU1UzY2dhdFpO?=
 =?utf-8?B?M3dmWlRwcTFHSklPV1MvTVhhSng4eDZ6d2N1MDJuVk1TcEE4QXdoZ1hyeVlN?=
 =?utf-8?B?MVNHamtITFpGMnR4dzhQcE5NRzJUUHhaZENZVStDbjJDdTZZSm0zN21QRnBN?=
 =?utf-8?B?U0JZUVdqdEFIS3F5SlRmR2k0cXYwSXJ0MkN3bjRONVVEOXBVY1JOMklFMVFF?=
 =?utf-8?Q?wDRM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5936.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd955a50-27f7-4509-8288-08da8a7bd70c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 11:36:11.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szJqBPo0suldUmsbwIyLzEq4vslr60sz7SifW7/8PT+8yt2+B5E/vwcXoihDuhRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3306
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMuW5tDjmnIgz
MOaXpSAxNjo1Nw0KPiBUbzogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiBDYzogUy5KLiBX
YW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+OyB2a291bEBrZXJuZWwub3JnOw0KPiByb2JoK2R0
QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gc2hhd25n
dW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4
LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+Ow0KPiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggVjMgMS8yXSBk
dC1iaW5kaW5nczogZnNsLWlteC1zZG1hOiBDb252ZXJ0IGlteCBzZG1hDQo+IHRvIERUIHNjaGVt
YQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAzMC8wOC8yMDIyIDExOjE4LCBK
b3kgWm91IHdyb3RlOg0KPiA+IENvbnZlcnQgdGhlIGkuTVggU0RNQSBiaW5kaW5nIHRvIERUIHNj
aGVtYSBmb3JtYXQgdXNpbmcganNvbi1zY2hlbWEuDQo+ID4gSW4gYWRkaXRpb24sIGFkZCBuZXcg
cGVyaXBoZXJhbCB0eXBlcyBIRE1JIEF1ZGlvLg0KPiA+DQo+ID4gd2hlbiBydW4gZHRic19jaGVj
ayB3aWxsIG9jY3VyIG5vZGVuYW1lIG5vdCBtYXRjaCBpc3N1ZSBiZWNhdXNlIHRoZQ0KPiA+IG9s
ZCBkdHMgbm9kZW5hbWUgY2FuJ3QgbWF0Y2ggbmV3IHJ1bGUuIEkgaGF2ZSBtb2RpZmllZCB0aG9l
cyBvbGQgZHRzLA0KPiA+IGFuZCB3aWxsIHVwc3RyZWFtIGluIHRoZSBuZWFyIGZ1dHVyZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIHNpbmNlIChpbXBsaWNpdCkgdjI6DQo+ID4gbW9kaWZ5IHRoZSBjb21taXQg
bWVzc2FnZSBpbiBwYXRjaCB2My4NCj4gPiBtb2RpZnkgdGhlIGZpbGVuYW1lIGluIHBhdGNoIHYz
Lg0KPiA+IG1vZGlmeSB0aGUgbWFpbnRhaW5lciBpbiBwYXRjaCB2My4NCj4gPiBkZWxldGUgdGhl
IHVubmVjZXNzYXJ5IGNvbW1lbnQgaW4gcGF0Y2ggdjMuDQo+ID4gbW9kaWZ5IHRoZSBjb21wYXRp
YmxlIGFuZCBydW4gZHRfYmluZGluZ19jaGVjayBhbmQgZHRic19jaGVjayBpbiBwYXRjaA0KPiA+
IHYzLg0KPiA+IGFkZCBjbG9ja3MgYW5kIGNsb2NrLW5hbWVzIHByb3BlcnR5IGluIHBhdGNoIHYz
Lg0KPiA+IGRlbGV0ZSB0aGUgcmVnIGRlc2NyaXB0aW9uIGFuZCBhZGQgbWF4SXRlbXMgaW4gcGF0
Y2ggdjMuDQo+ID4gZGVsZXRlIHRoZSBpbnRlcnJ1cHRzIGRlc2NyaXB0aW9uIGFuZCBhZGQgbWF4
SXRlbXMgaW4gcGF0Y2ggdjMuDQo+ID4gYWRkIHJlZiBmb3IgZ3ByIHByb3BlcnR5Lg0KPiA+IG1v
ZGlmeSB0aGUgZnNsLHNkbWEtZXZlbnQtcmVtYXAgcmVmIHR5cGUgYW5kIGFkZCBpdGVtcyBpbiBw
YXRjaCB2My4NCj4gPiBkZWxldGUgY29uc3VtZXIgZXhhbXBsZSBpbiBwYXRjaCB2My4NCj4gDQo+
IFRoaXMgaXMgcGF0Y2ggMS8yLiBXaGVyZSBpcyAyLzI/DQpJIGFtIHNvcnJ5LiBJIGhhdmUgcmVz
ZW5kIHRoZSBwYXRjaCB2MyAyLzIuIFRoZSBwYXRjaCB2MyAyLzIgaGF2ZSBubyBjaGFuZ2UgY29t
cGFyZWQgd2l0aCBwYXRjaCB2MiAyLzIuDQpUaGFua3MhDQpCUg0KSm95IFpvdQ0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
