Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0545ADEE8
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 07:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIFFY3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 01:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiIFFY1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 01:24:27 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10083.outbound.protection.outlook.com [40.107.1.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8875D9E;
        Mon,  5 Sep 2022 22:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhneDyoyScEWLF7m5DcTRxhxdAMc0nGfzF7BFMaJR0Y9dFbBR+xtxW3n3FmmhQOdMlniTuxjTKs/5biVV4MdW5dME1vhIXaMRO0LeMTLgyVxojKjyNqycGE+fcqWTaREqiY1bD4V6HDvdlJJRNfAHIE/x+e3Xu1Ehi+epV8v/HHqmKyanU/gXDH3bgtnR3xGkvq/dUcrv6roTsww/kLpgFxzFYmKHS9IwgOKxYM0Eu0a009kQXCeEu+SOUVWG6+lkxnEUA+D1UzdOUVV+W8SWL8pvTVz6csOlUzTtABlH0k2TrocjMb+7ndg3LNUnsc/lo7SvVqsPGCFcVaPevp1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fik7msnWjbaboy7mLAOQBDGf+ehdXLm8wA02/IZKdA=;
 b=nTBI/zc7ECbmsW4sOnDQUIiMRg8uk2YbBNwGNLETs8KgfFBKwnBPLjXk1jxoHjthQowicWtFMHPnuD1MYEsUEJiqY4zXOFSIzUEyTehdx0rZaww9Lsi1oqQ0GWkcg60Oey1otK8mXvGMX3EPENQdWBhJYtlm1iClDC3EuYv6mRmhHh0SJvEcxgjHkHtYBbcWiqQ866SOXzQLMZ6V5XtMKIsy332yz5CBGfaZYb12/HD0C3qrEW6IMpB6O6IS7Dlpotlz5l14egTc8xakUyEWviH/t4DmcrRbVx2tB1Z9BZKvYLeTODNHGZGub6BIBj9ws+kpTzsOGrMlTMACUw8hgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fik7msnWjbaboy7mLAOQBDGf+ehdXLm8wA02/IZKdA=;
 b=keJ9dkX12M/qEkeO8Gv7xPgEkS+RkZ63Q3w0J+zITaa2Uc2RB83aw7tA1DMj2sIwtqgKspy6hqnuVsFYd2z0LQw5RdjpbKv8xgefRi/cvXHUAGMYu4Je8wEn7rzc97Q2YQRJsHegcKnsMK9m/JV+JqVtIsXnY1+mL5+OWcn/cpc=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 05:24:22 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 05:24:22 +0000
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
Thread-Index: AQHYvaZ8O5GQjHuFO0+lJC0QJTvpyK3PeAEAgAD00fCAACIHgIAAAFNggAAjwYCAARb8EIAAGogAgAAAkPA=
Date:   Tue, 6 Sep 2022 05:24:21 +0000
Message-ID: <AM6PR04MB5925D381A2A627D07C5BABE6E17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220901020059.50099-1-joy.zou@nxp.com> <YxTPTnrJst9aNpsl@matsya>
 <AM6PR04MB59253DD6C91D41344C08C175E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <0d523880-9214-7b9b-ce1a-d06d4d5fbdf1@linaro.org>
 <AM6PR04MB59250C67D565B6E5E52621ACE17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <YxXXex775kSSmGin@matsya>
 <AM6PR04MB59255C66A2DEA7B0A8B3C22EE17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <YxbXxKyVkA4fwY0Z@matsya>
In-Reply-To: <YxbXxKyVkA4fwY0Z@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43f2276f-c4be-4dae-a24b-08da8fc80e21
x-ms-traffictypediagnostic: AS8PR04MB8979:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWXCFfh/pTPN2fLl0zq/IiY5DsPxPnZZlhI4KCCGGZCO5TXU5JBJWAXinJUDlyIKY+ykEleEfOB1AhxlcISpnleLBcXfBHLX/zQo2Ql6RPcOoNARyRPbQ4ldL/AL/7QH8KLtRW9AsVpXwZQw+YLUoAB8gSnT6m0tmlDOxs2i8uZ1N/rOveN6MUq0ro/RIJc5ZZlN4XBE8a5Uok7/RRxE9Y6j/4FrhiXosG+ULiuXzXtZJ0RaZZi/YGNMnwQN5yg07Myt4n1CD7kmM29B9NsyuaOLVJXv7F4H2xyLNfk58Pn83Dxh5ppEmd/lJ69LRYzJFHpTnjG3cTc1GCtntZGjg83UtxImip7wqiNEd1ZeJ3ZKfsye4Ej0+3uPbeO0Ob2aYC44OfS+w3LMqzNSD7N52QWDZhttKoWqWX5sMNtHESjZxmjAIwLX+ln3A3dxwACrdws5o64PadWOFh5Uc8XTxcA5H5PPHN5XaVAavBddPD6Id9XhIhUuWmq2855OQFOcSzf1cfnwcW2u+vuwPw1IM36rMDdKdyu3b/pHw+WyK3ZZqpSCsbOdI74RaQJWoKPM/lEM46uBuM7c8UYxEL5XUOrXR0vUmdfa5rQ9oJL5Agkh83psmcOasLJs10hRLX4u60o5SwvRldz7mLOls50OWR4SFAiqXfyRbxELoEJGeluAZsY1AmtpgMFm5Scl1rXcwW2LiB2sRvY3hPRtzQ1H0bQg1SC7/bdpjQrFVTerjlQnLDBxJYvPF12rDGyy8NkZyY+WVCCkIfwv+XLtyxKpyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(44832011)(2906002)(33656002)(316002)(186003)(66556008)(5660300002)(8936002)(52536014)(66446008)(66946007)(76116006)(8676002)(4326008)(64756008)(66476007)(6916009)(54906003)(41300700001)(71200400001)(6506007)(38100700002)(478600001)(53546011)(86362001)(9686003)(7696005)(26005)(38070700005)(83380400001)(55016003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjlubWpiZk9JOEd2Q2RSS1AyU2gvb3F4b0VuRGNmL1FTN1pjS215TWUrZEhv?=
 =?utf-8?B?QmtoOTg3ZzV6UWw1Q21KbHNLRmJmZVRNbG9FcmRuYjBtSHRIbVNFZ21STGJN?=
 =?utf-8?B?dFBpNE1TejZPSUY2NkMwditXaGNrMlJ5dXBqWWs1d1lCU3JjNC92d0xLRHdB?=
 =?utf-8?B?VXpjbHgvNXZxMDJ3ckpJRy9GL09QZnFHRUpZY2UxU1VCSWRvc3E3OFlraWN0?=
 =?utf-8?B?TFQyTE5HYUgyZHQwaTlaSzVLU09zd3RYMGFWR29YZGhxV05wRGtWdnc1OWhv?=
 =?utf-8?B?OUpLYTNQLzZsNGVOUGMyL2FxR1hNanB5d3JtVnFMNDN2djNrdWlOekJoNHNu?=
 =?utf-8?B?bGlvbVUzQ2p1TERuSTVXV0JTNytJYlNGd3RrUHRtVC9HK2o3QnYrUU1iNjJp?=
 =?utf-8?B?ZDEyWU85R3ArZTk1UDFUOUJUMTBIaEl5Vy8xdzN4K3NxVnZEN2x0K3FXUDNK?=
 =?utf-8?B?UTlIWUx0dGF4a094TUJucW1Oa1B4U2lvUGV0TGFNclhLT05XQmw0bTdJN0ly?=
 =?utf-8?B?dys4MW1TSVUyU1lnR09Ec1hmMGV2VmlVeE5qNnBHbTliNDJBZDJURGhDTmlU?=
 =?utf-8?B?UWxGVWNMYU56c05UeGltY1JyS3ZxZzVyczY2cFZlRlp4QmpZeXd5OTc2a3pm?=
 =?utf-8?B?eE9lUmwxWUdrckdxMmxIZjFxeEdjbEd4Y2VBNkNxRGpRc2FqY1FzSHk5eGFL?=
 =?utf-8?B?RzB6bWxZcXVteldaQk1INDFBYytLamF5WitpdCs4Yk9aVHFhcXE2U3h6cFBq?=
 =?utf-8?B?T3dWM2UwRGpZZmxqcTZ5N0ZHMDAzQmhhc3dreDdXd3FTS2tsaTRYZVRuRE1h?=
 =?utf-8?B?b2dxdFhEWlB3UHMxQzlkVzdQM21ycGc3eWtHQlFzY0ZhbHBtYTJBaHNUdmpI?=
 =?utf-8?B?T3ZET1ZNdndpS0Q3aTVQQTZURHVHUzU2RnZDL3VMZllncTJES2JKRnV4U0V3?=
 =?utf-8?B?dVAzQzNhVWFXZ284VkFDUllUbnRDVUxIUEFrZFJtWmpTUkhZeGlLUDNkWE9m?=
 =?utf-8?B?YWFhYncwY1phK0g1bmRCa0VRMmx2REhDMUJJN0h6Y2xpa1RyMlRnYUtRMXVm?=
 =?utf-8?B?SnpkV2Z5cjBBeUtHRy9BRlo1Mm5VVkVsNFE2QjEzT29WWjN2a1BjY3VqcFg4?=
 =?utf-8?B?ejlSS2RrY0dhanovaW1KcjdXQmNoajQvQ3NpRTdaMXdGcExZVDZDK2RKYWQz?=
 =?utf-8?B?VExmR2oxN2cyaTluNGFPTEFVNDcvRk42WW5oN2xoM1pPL3BEalJZN1o5MXZy?=
 =?utf-8?B?UFZ5UEpvUHM1Z0hxVE1KY29yTDhFZGZlQjdTOVBaaW82MDJMUHVscllaWFU5?=
 =?utf-8?B?VTlSeVRBcjN1QVRWbXBpcW9UVXRrakVxWUZ5clB6Vlh0WHJFTnhhclFVSkNB?=
 =?utf-8?B?VHJGN21wQnV0bGljNFhPZWszOG44cXNzVjJXSkVvWS9oOFNLVExObGVyVTZT?=
 =?utf-8?B?TkQ4Qi9LL0NOcTVCK1lNMjJwZFlxZURKa0ZzdUlPOENCWnNlQU5BQXE4K3Nu?=
 =?utf-8?B?N3ZNanhmWmk2NFhsMnQ3c2krT1MrMW45eFU5aTNOR1ZHZWo0TDNLNkdMVFV3?=
 =?utf-8?B?M2dGOHlnZE5VTFVWTDZRanhCT1lZeHEvenBJdGpiSG9hWkkwRTE1YnU0Rmov?=
 =?utf-8?B?NVQwNEZMZVBmb3c1WC9GNWNQeGVRVmNpZFlsaXpzbkFUOFUrUWM2QmYzN3oy?=
 =?utf-8?B?ZWExWmFCcTZLNEtZZXFkY1pYbGxPd0NpbGZacE9BZVRNME9ubjB4eXZxeFBn?=
 =?utf-8?B?U2s5STV6dUVRMXpETFNJU216WGR4QkxuNUJVNjl6RXBBZGdHVElFUW05TGZl?=
 =?utf-8?B?MnNiL00yaVFvL09aQnJycWNXR3lpUXowenlQbFlCNFBBV21BVzlJWERCZEla?=
 =?utf-8?B?b2M5aXRpSEJBY0lWaW0xeEFLNkNwN3Rwc3Qxc09OUjM5WFUvbzgxMXFHRkZL?=
 =?utf-8?B?eFplTHRDQnBQTzdBbXVNVTl0c3Z5TUhrMkxyMi9rdTk3RVZ3WUUxa1Z5TzRY?=
 =?utf-8?B?ZXFrakprZWVwSUhEWlNvQnIyREE3QzFPN0x2ZDVzd1owTmRZZlNUdnVYUno1?=
 =?utf-8?B?RDUrMkxsWDRDVkY1QkJqVXJtckliNjJ6Nm5LR21DK1NrN0dVUkhiZElxdFJQ?=
 =?utf-8?Q?L/18=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f2276f-c4be-4dae-a24b-08da8fc80e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 05:24:21.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DLZqimEaYAfjIISNkL708aoSoORaH9SMp3LdpvbrZ4xcD2Z440p2UGU/fRAHyBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8979
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
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLlubQ55pyINuaXpSAxMzoxNw0KPiBUbzogSm95IFpv
dSA8am95LnpvdUBueHAuY29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPjsgUy5KLiBXYW5nDQo+IDxzaGVuZ2ppdS53YW5nQG54cC5j
b20+OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCBWNCAyLzRdIGRtYWVuZ2luZTogaW14
LXNkbWE6IHN1cHBvcnQgaGRtaQ0KPiBhdWRpbw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+
IA0KPiBPbiAwNi0wOS0yMiwgMDU6MDQsIEpveSBab3Ugd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBrZXJu
ZWwub3JnPg0KPiA+ID4gU2VudDogMjAyMuW5tDnmnIg15pelIDE5OjAzDQo+ID4gPiBUbzogSm95
IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiA+ID4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz47IFMuSi4gV2FuZw0KPiA+ID4gPHNoZW5naml1
LndhbmdAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiBzLmhhdWVyQHBlbmd1
dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4g
PiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBkbWFlbmdpbmVAdmdlci5rZXJu
ZWwub3JnOw0KPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQ
QVRDSCBWNCAyLzRdIGRtYWVuZ2luZTogaW14LXNkbWE6IHN1cHBvcnQNCj4gPiA+IGhkbWkgYXVk
aW8NCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPiA+DQo+ID4gPiBPbiAwNS0w
OS0yMiwgMDk6MDcsIEpveSBab3Ugd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+ID4gPiA+ID4+IE9u
IDAxLTA5LTIyLCAxMDowMCwgSm95IFpvdSB3cm90ZToNCj4gPiA+ID4gPiA+Pj4gQWRkIGhkbWkg
YXVkaW8gc3VwcG9ydCBpbiBzZG1hLg0KPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPj4gUGxzIG1h
a2Ugc3VyZSB5b3UgdGhyZWFkIHlvdXIgcGF0Y2hlcyBwcm9wZXJseSEgVGhleSBhcmUNCj4gPiA+
ID4gPiA+PiBicm9rZW4NCj4gPiA+IHRocmVhZHMhDQo+ID4gPiA+ID4gPiBJIGFtIHRyeWluZyB0
byBzdXBwb3J0IGZvciBoZG1pIGF1ZGlvIGZlYXR1cmUgb24gY29tbXVuaXR5DQo+ID4gPiA+ID4g
PiBkcml2ZXINCj4gPiA+ID4gPiBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzLy4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMgZG9lcyBub3QgYW5zd2VyIHRvIHRoZSBwcm9ibGVtIHlv
dSBwYXRjaGVzIGRvIG5vdCBjb21wb3NlDQo+ID4gPiA+ID4gcHJvcGVyIHRocmVhZC4gdjUgd2hp
Y2ggeW91IHNlbnQgbm93IGlzIGFsc28gYnJva2VuLiBTdXBwb3J0aW5nDQo+ID4gPiA+ID4gSERN
SSBhdWRpbyBmZWF0dXJlIGRvZXMgbm90IHByZXZlbnQgeW91IHRvIHNlbmQgcGF0Y2hlcyBjb3Jy
ZWN0bHksDQo+IHJpZ2h0Pw0KPiA+ID4gPiBJIGFtIHRyeWluZyB0byBzdXBwb3J0IGZvciBoZG1p
IGF1ZGlvIGZlYXR1cmUgb24gY29tbXVuaXR5IGRyaXZlcg0KPiA+ID4gZHJpdmVycy9ncHUvZHJt
L2JyaWRnZS9zeW5vcHN5cy8uDQo+ID4gPiA+IEkgdGhpbmsgdGhlIGZlYXR1cmUgbWF5IHRha2Ug
c29tZSB0aW1lIGJlY2F1c2UgSSBhbSBub3QgYXVkaW8gZHJpdmVyDQo+IG93bmVyLg0KPiA+ID4g
SSBvbmx5IHdhbnQgdG8gdXBkYXRlIHRoZSBvdGhlcnMgcGF0Y2ggYXMgc29vbiBhcyBwb3NzaWJs
ZSwgc28gSQ0KPiA+ID4gc2VuZCB0aGUgcGF0Y2ggdjUuIEkgYW0gYWxzbyBzb2x2aW5nIHRoZSB0
aHJlYWQgcGF0Y2hlcyBwcm9wZXJseS4NCj4gPiA+DQo+ID4gPiBTb3JyeSB5b3UgaGF2ZSBub3Qh
DQo+ID4gPg0KPiA+ID4gSW4gbXkgaW5ib3gsIHY1IDEvMiBhbmQgMi8yIGRvIG5vdCBhcHBlYXIg
YXMgYSBzaW5nbGUgdGhyZWFkDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGZpeCB0aGUgd2F5IHlvdSBz
ZW5kIHRoZSBzZXJpZXMgYW5kIHNlbmQgdGhlbSB0b2dldGhlciwgaXQgaXMNCj4gPiA+IHZlcnkg
ZGlmZmljdWx0IHRvIHJldmlldyB3aGVuIHRoZXkgYXJlIGRpc2pvaW50DQo+ID4gPg0KPiA+ID4g
RldJVywgSSBjaGVja2VkIHRoZSB2NSAyLzIgYW5kIGl0IGRvZXMgbm90IGhhdmUgaW4tcmVwbHkt
dG8gc2V0LA0KPiA+ID4gd2hpY2ggc2hvdWxkIHBvaW50IHRvIDEvMi4uIElmIHlvdSBhcmUgdXNp
bmcgZ2l0IHNlbmQtZW1haWwsIHBvaW50DQo+ID4gPiBib3RoIHRoZSBwYXRjaGVzIHRvIGl0IHNv
IHRoYXQgaXQgd2lsbCBkbyB0aGF0IGNvcnJlY3RseSBmb3IgeW91DQo+ID4gSSBhbSB2ZXJ5IHNv
cnJ5LiBJIGZpbmQgdGhlIHJvb3QgY2F1c2UgdGhhdCB0aGUgcGF0Y2ggbm90IGFwcGVhciBhcyBh
DQo+ID4gc2luZ2xlIHRocmVhZC4gSSB1c2UgdGhlIGdpdCBzZW5kLW1haWwgdG8gc2VuZCBzZXBh
cmF0ZWx5LiBJIGFsc28ga25vdyB0aGUNCj4gcGF0Y2h3b3JrIGNhbiBjaGVjayBpdC4NCj4gDQo+
IE5vLCBwbGVhc2UgcG9pbnQgdGhlIHdob2xlIHNlcmllcyB0byBnaXQgc2VuZC1lbWFpbA0KPiAN
Cj4gRm9yIGV4YW1wbGU6DQo+ICQgbWtkaXIgdGVtcDsgY2QgdGVtcA0KPiAkIGdpdCBmb3JtYXQt
cGF0Y2ggLTIgLS1jb3Zlci1sZXR0ZXIgLXYgPHBhdGNoIHZlcnNpb24+ICQgPHVwZGF0ZSBjb3Zl
ciBsZXR0ZXI+DQo+ICQgPHJ1biBjaGVja3BhdGNoIGV0YyBhbmQgdmVyaWZ5IHBhdGNoZXMgYXJl
IGluIG9yZGVyPiAkIGdpdCBzZW5kLWVtYWlsICoNCj4gDQo+IFRoYXQgc2hvdWxkIGRvIGl0IGZv
ciB5b3UhDQpUaGFua3MgVmlub2QhIEkgYWxzbyBjb25zdWx0ZWQgbXkgY29sbGVhZ3Vlcy4gSSBh
bSBzb3JyeSBmb3IgdXNpbmcgc2VwYXJhdGVseSBnaXQgc2VuZC1tYWlsIHRvIHNlbmQNCnBhdGNo
IGNhdXNlIHBhdGNoIGRpc2pvaW50Lg0KQlINCkpveSBab3UNCj4gDQo+ID4gSSdtIHNvIHNvcnJ5
IHRvIHdhc3RlIHlvdXIgdGltZSBhbmQgZWZmb3J0LiBJIGFtIHZlcnkgZ3JhdGVmdWwgdG8geW91
cg0KPiBjb21tZW50cy4NCj4gPiBJIHdpbGwgY2hhbmdlIG5leHQgcGF0Y2guDQo+ID4gQlINCj4g
PiBKb3kgWm91DQo+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gflZpbm9kDQo+IA0KPiAtLQ0K
PiB+Vmlub2QNCg==
