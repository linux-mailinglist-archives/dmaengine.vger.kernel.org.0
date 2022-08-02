Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E6358761C
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiHBD6K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Aug 2022 23:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiHBD6G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Aug 2022 23:58:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105CF1A385;
        Mon,  1 Aug 2022 20:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4uDRFy08cqnrTHXszfMt5nI3Eb1dz3jgbJobvpiOtqnCN4Q51NAMQJ2PmqH6nd9vPqly8N/2Ghv/YrZoHx86GfsEh4OX22qUnGsn+hcnYAe707mwPKQGc8RIV9wzy7ZZJ+VRvrgubnYWXUHUmKiup27Kf27CfjkHunUflFeOvczCkWuydKPJYd/O6G5HJHyZXJbe49V2SDvesApGZuEpyKbfRhpYsWlcTfJcJx7MpVWpeF3mKzn2dXHLq0nxKR8SHKB04zn6w1giGreJ8dZQvxSZr06kCIYGdHMxbk4tJ382pddqS/OHEb5QuGltotwwcFzucrFgkGNHYyQ8tjShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdssSPeRC31YzRKU7ZAeKX6rKONLoGWfto8fNFZPSnQ=;
 b=BOoXj6oPG9L1oCggdhtDHTCP61S7k6dGEBlyKJ5HDtSwDK3r/SVotj0tecKiz3qy9oRPfzW3aEUe2dxCZhUXwbIifCRhM5nuJl0p31B8gjS+cUVDm4A5EVH11rxheLQQGSIGFaSohipHRCp7GBsn/whn7H7uB4e/cwXwYw8r3+mmGCnOQeXqiaK0UXUM5sDn6S1lF4ojxHJh9a3uq8gw6a/k0QF/1WPvtpXhZHwxICmD7bfRiiboWdAbTPfNtK1fytX11luyevfjRFyY4cY8REi1pj+c9aME/mXhadH83iHoubCGx5JLaMHH37QiAOTrwNrggIdDC9PhMEXHMXbPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdssSPeRC31YzRKU7ZAeKX6rKONLoGWfto8fNFZPSnQ=;
 b=kE3aNyWplDmR9ZDcdb2jl2oebzQvwww3UT01HHnt2wMVHoce6pf7TcLNgPgX2I0NDRp/7QE0ZY3k4QhU1FZ5YKzeZ7SdgC9ERUBmevv+cSCz+mohvYGXsRotZcLviRjXGjRL+syA44hfPruRhMVMlsAXmZ6pmdzTamC61EYDb14=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 03:58:02 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::a88e:aa50:65d9:6206]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::a88e:aa50:65d9:6206%3]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 03:58:02 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
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
Subject: FW: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Thread-Topic: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio'
 transfer
Thread-Index: AQHYb0Sbzg3yRatDsU+sUlyHgY6zya2baFlw
Date:   Tue, 2 Aug 2022 03:58:02 +0000
Message-ID: <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220524080337.1322240-1-joy.zou@nxp.com>
In-Reply-To: <20220524080337.1322240-1-joy.zou@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5baaeada-075a-43b9-a625-08da743b326e
x-ms-traffictypediagnostic: DBAPR04MB7334:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ccqrWy1qmIBaaMJqf6BhUp81QzsU4EzdJHjUAwVtSIo0bfVesyICEU+jEE9Pdd8hwuJp8m1X4OHTJFW/attFSc7LQWNFw/2T1dMmb0Y5u9oMRUsrbQOEAl4bw/j6gVRo/mxa5UAqcHMurnoyQ2T/cITeg7ECbOmrwoJJlEoK+HRHbv+6b0waQ38MuSFfNwMGv3Hs24pR+5RJKTk1hmvoQ4v2kWkuw8BbH7xLVn2Xat6wIXqAbbWpRMBd9qZ3kNIG5L8ebdTn/xXQ++pCEBYUAgsNl6hXbVftiHMF+c2w4Z8BsnMsMiHtSsGcQOT1be2m/oryOojG819+EVMGSqMxat7OnzJ+0QEn7hr5Px52BPYrIydxC18mtycHTpCJWeinqYO/6INMfbvefAw8xsyNqKw0ObUa1aX744FYQqxGBsDM1TswYzbKCzdcQ9l3+7OarRYtDPR0cJq12ac/v69zWLPyDdpZMUlmYUVx/EtKjF+tsu6SpgPT/8pqgoAqFSyJBG3bRfIelzkpNl2yJ8f1IobgNiSK9fovb1tiFq8ztFh6WB781DYmTg2DWpjwz7mmpo6NPDjjkqVPg4W56L399LgeAE8xNXENI6jsf+ISxNZqjFoCfMo4tjpkL7/TOcSgvwDCpFK57eNSoVB6iHTKp9IPHEQDa7gRCjaCtWTaUQgqUI8n8QxE06whH8KUrlxCYjASjgtIz7AegNhG4bZfrOF3/fajjhUaBqL+pVbkvFSuR8IeVZJWqnz63n2RPr9nTumdb8Wml2DJFH/hnMYAALBpHTpJH7TDR4f/WZ/KYRlT5llRXzSpWuTxY5qWUp1qom6lD8sfrpjIHdOoN3xyMGDpDD3XJsy2SSmHlwKhhOMmMoqG5tFyjnCPrz7fMw/d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(86362001)(38070700005)(38100700002)(122000001)(8676002)(66446008)(64756008)(66556008)(66476007)(4326008)(76116006)(66946007)(6916009)(54906003)(316002)(5660300002)(52536014)(44832011)(7416002)(2906002)(8936002)(53546011)(6506007)(26005)(9686003)(186003)(83380400001)(71200400001)(41300700001)(7696005)(478600001)(55016003)(966005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eklFSE9ydDJDT0tjeVdQRHU5UWE1MTlEV0RJUE9jaDNEL0VVWkRHNitZZXVH?=
 =?gb2312?B?eWVtOUxPclc4bXpsdlNXWXgybCs4RXJsTlNYZVN5WG1tVk9BZmdPR1diZDZN?=
 =?gb2312?B?cDgwakpzMzFNZEo3V1cxMEMvUkNVWmRMa2l2dlFxZmYvUmlyaXVBbExzOFNo?=
 =?gb2312?B?UHM4dUd4WEh3TzRNancza04wSjFIb2o4REVqSExLZmRQVFYvamhVdXplaXhG?=
 =?gb2312?B?aVlnL0p4d09ZOEs0aDZwSm9aUEQrMnF5ckNnZFEvdis0QkJDdHFzb3R5RXVS?=
 =?gb2312?B?Qy9mbE4wWENoYjhtdGVNaEVKTkZzY2FtOTZZeWhIeHFScVlYOGNKVmx0cTl4?=
 =?gb2312?B?dDBEVzlYN3IxcEg3a3BWWkphWnB5K3FqR0c4M1Q5UmpPSzFneVdFcUhmWEhW?=
 =?gb2312?B?WXZEQmZSWkhmb3RzREpTSUowWlRzbkxzazBzTDgzTHFSSlh6eWU2MzByMkI3?=
 =?gb2312?B?Q1RmMkI1aXZ2OXRVMlNJYU5COGN5alN0WkpmNkd5aUh2UWdiM3FiTmZScFg3?=
 =?gb2312?B?MTYyOU9pRGY5YURWVWxwaDBxNWU4MXc3QkdzeEhYanVkY1Z4QTZFcDI5TnRm?=
 =?gb2312?B?Wmo2SHRCdVNEZVNGU2JjbzcyQ0tqU1dwdXNQa3NmaWpEd2hDNmlvdmNseHFL?=
 =?gb2312?B?Z2NrdU9MUGdYdEF3cmNqbkRWc2s2L0x5N1p4VXV3VVU4WHpiZzByd2tUVG03?=
 =?gb2312?B?a3ppMVdRTXZQNVYrQmowM1hEaUtvV0xiRGhlWlF0bzF5bjRsTUErbmlmckVO?=
 =?gb2312?B?czVUY3ZIUDZhaklpU2YxekRiRFFzczFPTjVHSzE1SWNyQ0xyVCs1UGRPNGtK?=
 =?gb2312?B?YVNhZTBDZk93a0tGSlhIcWh4eDlzWkxZVjBsRU0rNStjcVhyeldqWW91N2R0?=
 =?gb2312?B?T2Z1OVBVMmQvNlNaRC9veFNmK09PZXVEdldUYjhyQ1VQWWcyc2hiQXZ1TFY1?=
 =?gb2312?B?ekpRRFlZSzlqMFpVZDhEcktGc3BrMS9ZQnkwYjVKcHZZRmo3cEJOeGNWYWVQ?=
 =?gb2312?B?cElnTk9sQVdVZmtwUkZueXlGQmJiN2FKR1dhOUFBMzFmelFhajNmdDJMTkFq?=
 =?gb2312?B?ZVYvL1VWNmpuZHVFWXVXVGo1S1BTeklwM0VvbTI1dFNPR09vS1kyajUxaWJU?=
 =?gb2312?B?b3phMkNNbHFCM2M0cjlqQTJ4S0V2L0tTaWNPLzNXTzFweDNmdE9OMVE5WEZm?=
 =?gb2312?B?QzlQakNrSDVkQjBsclp3Q3JoUksvNStGYmtJdkRtU3dUSUIyMUM5RFNJNE1x?=
 =?gb2312?B?MTlTTjNIQmc1eVQ3MVpWSzR0Uis3UGRmYXJvRVJKenQ1OGtYQnJadnVYeXVh?=
 =?gb2312?B?RmczK21jbjBIQ1p1a3FiZUVpYVVFT1MzZ1VpR2JCRTFLc3lDQmRrUnd2TXhN?=
 =?gb2312?B?ajJVeVFrdVJ3eUVtSjB0WDU5NnpDUXpqK254YXhJQnNvM0NiZmJXOTBsTW90?=
 =?gb2312?B?QzRIVVdydTBVbnpsM1RoOHNlQVlqUEZBTnpOaGVVQUovUnlpZVJ6UHByaTZx?=
 =?gb2312?B?UE84SXJPUjhhenhkWGdTQ0FTd0N5MkdDc2RBR2s2OHVlNEcwVzZLR2ZycnNF?=
 =?gb2312?B?MGJZT1ZjbWZSK09LbDRIVEVFeWJEYmFwc3Y1c09WNllFZW50OTcxdnZnREgv?=
 =?gb2312?B?ZE1ETEc3anpzRG5ZNlhwM2Nmb0o3ZXk4Sisya01SMDlQWjEweTRDY0QyemFt?=
 =?gb2312?B?RDNuTkd6SHRJSjhKVVhrWG1IKzJ3TVFHcFp0ZnFpVzUwMmRWc3Jad0dSQVVY?=
 =?gb2312?B?Z3RPRzk1VUEvQW5RR3M0L2ZxZS9jR3pKVy9pVEdTa3k5bEN5dGdlZkxMSW9r?=
 =?gb2312?B?TklzZjhUbS9aWDFXd2dkUml2MnpnanlrcXFFUk83dlhPRnd1MGlERzFIU0M5?=
 =?gb2312?B?Wmk2ZVNacEkvSi9Wa2JqZXZmc1Ezai9jY3MxcjNhWEs0RjRXYTFTUGxwRDlz?=
 =?gb2312?B?MWJsS05Xc3FMYll4b00wcWprTlFJRFVtZGUxeXB1dDU0eUh3aW5BWldYUmtB?=
 =?gb2312?B?TjdCbHhYZVhRdUtXd25GSERxcHhjTk9VdUlkQU9rWkpuZ3hTWWYyRVpLUS93?=
 =?gb2312?B?VHIwaUdGeTdKNDJBbDMra2g4NDdHN0R6ZVM2MWpxdWNLOUpxajlVb0hMV29l?=
 =?gb2312?Q?W0ak=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baaeada-075a-43b9-a625-08da743b326e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 03:58:02.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iOlICAc1YVFXJoaeEZ2jUV02Jo8uKEOjhpZQztuOMhzwB1Evn6TFEDT5iJWnEOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KQlINCkpveSBab3UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEpveSBab3UgDQpTZW50OiAyMDIyxOo11MIyNMjVIDE2OjAyDQpUbzogdmtvdWxA
a2VybmVsLm9yZw0KQ2M6IFMuSi4gV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPjsgcm9iaCtk
dEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
ZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KU3ViamVjdDogW1BBVENIIFYyIDEvMl0gYmluZGluZ3M6IGZzbC1pbXgtc2RtYTog
RG9jdW1lbnQgJ0hETUkgQXVkaW8nIHRyYW5zZmVyDQoNCkFkZCBIRE1JIEF1ZGlvIHRyYW5zZmVy
IHR5cGUuDQoNCmNvbnZlcnQgdGhlIHNkbWEgYmluZGluZ3MgdHh0IGludG8geWFtbCBpbiB2Mi4N
Cg0KU2lnbmVkLW9mZi1ieTogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KLS0tDQpDaGFuZ2Vz
IHNpbmNlIHYxOg0KY29udmVydCB0aGUgc2RtYSBiaW5kaW5ncyB0eHQgaW50byB5YW1sIGluIHYy
Lg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS55YW1sIHwg
MTM1ICsrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygr
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZG1hL2ZzbC1pbXgtc2RtYS55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uNWI0ZjdhMDlhMzk1DQotLS0gL2Rldi9udWxsDQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbC1pbXgtc2RtYS55YW1s
DQpAQCAtMCwwICsxLDEzNSBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UgJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9kbWEvZnNsLWlteC1zZG1hLnlhbWwjDQorJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IEZyZWVz
Y2FsZSBTbWFydCBEaXJlY3QgTWVtb3J5IEFjY2VzcyAoU0RNQSkgQ29udHJvbGxlciBmb3IgaS5N
WA0KKw0KK21haW50YWluZXJzOg0KKyAgLSBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0K
Kw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAiZG1hLWNvbnRyb2xsZXIueWFtbCMiDQorDQorIyBFdmVy
eXRoaW5nIGVsc2UgaXMgZGVzY3JpYmVkIGluIHRoZSBjb21tb24gZmlsZQ0KKw0KK3Byb3BlcnRp
ZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBpdGVtczoNCisgICAgICAtIGVudW06DQorICAgICAg
ICAgIC0gZnNsLGlteDI1LXNkbWENCisgICAgICAgICAgLSBmc2wsaW14MzEtc2RtYQ0KKyAgICAg
ICAgICAtIGZzbCxpbXgzMS10bzEtc2RtYQ0KKyAgICAgICAgICAtIGZzbCxpbXgzMS10bzItc2Rt
YQ0KKyAgICAgICAgICAtIGZzbCxpbXgzNS10bzEtc2RtYQ0KKyAgICAgICAgICAtIGZzbCxpbXgz
NS10bzItc2RtYQ0KKyAgICAgICAgICAtIGZzbCxpbXg1MS1zZG1hDQorICAgICAgICAgIC0gZnNs
LGlteDUzLXNkbWENCisgICAgICAgICAgLSBmc2wsaW14NnEtc2RtYQ0KKyAgICAgICAgICAtIGZz
bCxpbXg3ZC1zZG1hDQorICAgICAgICAgIC0gZnNsLGlteDZzeC1zZG1hDQorICAgICAgICAgIC0g
ZnNsLGlteDZ1bC1zZG1hDQorICAgICAgICAgIC0gZnNsLGlteDhtbS1zZG1hDQorICAgICAgICAg
IC0gZnNsLGlteDhtbi1zZG1hDQorICAgICAgICAgIC0gZnNsLGlteDhtcC1zZG1hDQorICAgICAg
LSBlbnVtOg0KKyAgICAgICAgICAtIGZzbCxpbXgzNS1zZG1hDQorICAgICAgICAgIC0gZnNsLGlt
eDhtcS1zZG1hDQorDQorICByZWc6DQorICAgIGRlc2NyaXB0aW9uOiBTaG91bGQgY29udGFpbiBT
RE1BIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQorDQorICBpbnRlcnJ1cHRzOg0KKyAg
ICBkZXNjcmlwdGlvbjogU2hvdWxkIGNvbnRhaW4gU0RNQSBpbnRlcnJ1cHQNCisNCisgIGZzbCxz
ZG1hLXJhbS1zY3JpcHQtbmFtZToNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvc3RyaW5nDQorICAgIGRlc2NyaXB0aW9uOiBTaG91bGQgY29udGFpbiB0aGUgZnVs
bCBwYXRoIG9mIFNETUEgUkFNIHNjcmlwdHMgZmlybXdhcmUuDQorDQorICAiI2RtYS1jZWxscyI6
DQorICAgIGNvbnN0OiAzDQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgVGhlIGZpcnN0IGNl
bGw6IHJlcXVlc3QvZXZlbnQgSUQNCisNCisgICAgICBUaGUgc2Vjb25kIGNlbGw6IHBlcmlwaGVy
YWwgdHlwZXMgSUQNCisgICAgICAgIGVudW06DQorICAgICAgICAgIC0gTUNVIGRvbWFpbiBTU0k6
IDANCisgICAgICAgICAgLSBTaGFyZWQgU1NJOiAxDQorICAgICAgICAgIC0gTU1DOiAyDQorICAg
ICAgICAgIC0gU0RIQzogMw0KKyAgICAgICAgICAtIE1DVSBkb21haW4gVUFSVDogNA0KKyAgICAg
ICAgICAtIFNoYXJlZCBVQVJUOiA1DQorICAgICAgICAgIC0gRklSSTogNg0KKyAgICAgICAgICAt
IE1DVSBkb21haW4gQ1NQSTogNw0KKyAgICAgICAgICAtIFNoYXJlZCBDU1BJOiA4DQorICAgICAg
ICAgIC0gU0lNOiA5DQorICAgICAgICAgIC0gQVRBOiAxMA0KKyAgICAgICAgICAtIENDTTogMTEN
CisgICAgICAgICAgLSBFeHRlcm5hbCBwZXJpcGhlcmFsOiAxMg0KKyAgICAgICAgICAtIE1lbW9y
eSBTdGljayBIb3N0IENvbnRyb2xsZXI6IDEzDQorICAgICAgICAgIC0gU2hhcmVkIE1lbW9yeSBT
dGljayBIb3N0IENvbnRyb2xsZXI6IDE0DQorICAgICAgICAgIC0gRFNQOiAxNQ0KKyAgICAgICAg
ICAtIE1lbW9yeTogMTYNCisgICAgICAgICAgLSBGSUZPIHR5cGUgTWVtb3J5OiAxNw0KKyAgICAg
ICAgICAtIFNQRElGOiAxOA0KKyAgICAgICAgICAtIElQVSBNZW1vcnk6IDE5DQorICAgICAgICAg
IC0gQVNSQzogMjANCisgICAgICAgICAgLSBFU0FJOiAyMQ0KKyAgICAgICAgICAtIFNTSSBEdWFs
IEZJRk86IDIyDQorICAgICAgICAgICAgICBkZXNjcmlwdGlvbjogbmVlZHMgZmlybXdhcmUgbW9y
ZSB0aGFuIHZlciAyDQorICAgICAgICAgIC0gU2hhcmVkIEFTUkM6IDIzDQorICAgICAgICAgIC0g
U0FJOiAyNA0KKyAgICAgICAgICAtIEhETUkgQXVkaW86IDI1DQorDQorICAgICAgIFRoZSB0aGly
ZCBjZWxsOiB0cmFuc2ZlciBwcmlvcml0eSBJRA0KKyAgICAgICAgIGVudW06DQorICAgICAgICAg
ICAtIEhpZ2g6IDANCisgICAgICAgICAgIC0gTWVkaXVtOiAxDQorICAgICAgICAgICAtIExvdzog
Mg0KKw0KKyAgZ3ByOg0KKyAgICBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgdG8gdGhlIEdlbmVy
YWwgUHVycG9zZSBSZWdpc3RlciAoR1BSKSBub2RlDQorDQorICBmc2wsc2RtYS1ldmVudC1yZW1h
cDoNCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFy
cmF5DQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgUmVnaXN0ZXIgYml0cyBvZiBzZG1hIGV2
ZW50IHJlbWFwLCB0aGUgZm9ybWF0IGlzIDxyZWcgc2hpZnQgdmFsPi4NCisgICAgICAtIHJlZzog
dGhlIEdQUiByZWdpc3RlciBvZmZzZXQNCisgICAgICAtIHNoaWZ0OiB0aGUgYml0IHBvc2l0aW9u
IGluc2lkZSB0aGUgR1BSIHJlZ2lzdGVyDQorICAgICAgLSB2YWw6IHRoZSB2YWx1ZSBvZiB0aGUg
Yml0ICgwIG9yIDEpDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQor
ICAtIGludGVycnVwdHMNCisgIC0gZnNsLHNkbWEtcmFtLXNjcmlwdC1uYW1lDQorICAtICIjZG1h
LWNlbGxzIg0KKw0KK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoN
CisgIC0gfA0KKyAgICBzZG1hOiBkbWEtY29udHJvbGxlckA4M2ZiMDAwMCB7DQorICAgICAgY29t
cGF0aWJsZSA9ICJmc2wsaW14NTEtc2RtYSIsICJmc2wsaW14MzUtc2RtYSI7DQorICAgICAgcmVn
ID0gPDB4ODNmYjAwMDAgMHg0MDAwPjsNCisgICAgICBpbnRlcnJ1cHRzID0gPDY+Ow0KKyAgICAg
ICNkbWEtY2VsbHMgPSA8Mz47DQorICAgICAgZnNsLHNkbWEtcmFtLXNjcmlwdC1uYW1lID0gInNk
bWEtaW14NTEuYmluIjsNCisgICAgfTsNCisNCisjRE1BIGNsaWVudHMgY29ubmVjdGVkIHRvIHRo
ZSBpLk1YIFNETUEgY29udHJvbGxlciBtdXN0IHVzZSB0aGUgZm9ybWF0IA0KKyNkZXNjcmliZWQg
aW4gdGhlIGRtYS1jb250cm9sbGVyLnlhbWwgZmlsZS4NCisgIC0gfA0KKyAgICBzc2kyOiBzc2lA
NzAwMTQwMDAgew0KKyAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDUxLXNzaSIsICJmc2wsaW14
MjEtc3NpIjsNCisgICAgICByZWcgPSA8MHg3MDAxNDAwMCAweDQwMDA+Ow0KKyAgICAgIGludGVy
cnVwdHMgPSA8MzA+Ow0KKyAgICAgIGNsb2NrcyA9IDwmY2xrcyA0OT47DQorICAgICAgZG1hcyA9
IDwmc2RtYSAyNCAxIDA+LA0KKyAgICAgICAgICAgICA8JnNkbWEgMjUgMSAwPjsNCisgICAgICBk
bWEtbmFtZXMgPSAicngiLCAidHgiOw0KKyAgICAgIGZzbCxmaWZvLWRlcHRoID0gPDE1PjsNCisg
ICAgfTsNCisNCisuLi4NCi0tDQoyLjI1LjENCg0K
