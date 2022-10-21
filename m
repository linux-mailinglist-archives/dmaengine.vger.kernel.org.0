Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1B6071C9
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJUIKa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Oct 2022 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJUIK1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Oct 2022 04:10:27 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140081.outbound.protection.outlook.com [40.107.14.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FAB11F483;
        Fri, 21 Oct 2022 01:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH19+ocfvyZrLPFTR/DsdTkrwy9TeKfH1nDcWV19G8Uw62Pro4gro11A8dreL4uf2+CvY9+73mXAAfjl8qPwskG1MZi4KETazLAy0bBRmrWfM8H2g3dagQZRrHjRx97q+bii8GisVNxYw3+M/wDZztZDYcDYGdtz9i7XhEUgg43LWGG2wK9oJoPbP+rwZXvjTSTwF7o0ewVFSA4dRIeLF8JcA6qRwFUl43MKNQdvbs4FFGNmvMpPI7BKfHbsfu19FUk1Eh3vXQFIGTPN5xahLojeZlZhjVfng+H+AD0kueYhbGcjcsD1f9pO+MnLmqzfRObJNjVZCKmRJCs8Dd7mfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6iS/JcmXl+Y98S3MRNXGYWfERlMwbkQzyUtEIFBQZI=;
 b=oFLrd0riR2ZQhX3/yAGU5DhoN4vJv6kChUL2HosFhXG1MgDh50ckFtu1z1oqh6gR5jvRkgMebGuhB6nSxyO6fDQh3PtaACwGkurGpHBGJBlgtJJBkboJSo72yetNJ+6I7YC6LP1tflSv6hQmvS6qtesziPdGmZGW5CYTshHOMFXas9RpmH2x0xlzecqbr4q1h8ogHX6BwXyMiHekpWK5zR6qOCPSmrtMd/oDS6A3mzVWxCTYocwl9/i/J0fErWKe5VOucZOzzzKs+4GWWYSd/elFekLuSmNY0R6DJxLkEjmlpJNZQoZyLeHXRcPhSUFfia7KaQK2yTR7gbvmb1kKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6iS/JcmXl+Y98S3MRNXGYWfERlMwbkQzyUtEIFBQZI=;
 b=d5N0GH2v2Ss4H8lVKgVe0P4Qav3l4+QWw2ZYy3nbeQjJT+N+uGow5SpA/CHvoTEZQ/kN36621zciTM/2P+O4rw5vTWM0T2uzHTta9LAysTOqzv+eTrHbbPxOHqm1UE86R9X2WojKO3a5fwg6q6/xApyvLA6SguTWhD7S40bnXbg=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by DB9PR04MB8138.eurprd04.prod.outlook.com (2603:10a6:10:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 08:10:22 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5723.036; Fri, 21 Oct 2022
 08:10:22 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>, "david@ixit.cz" <david@ixit.cz>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Topic: [EXT] Re: [PATCH v7 1/2] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Thread-Index: AQHY5GzccQmLkJcvCUiJFUjVMGEDSa4XegGAgAD4iUA=
Date:   Fri, 21 Oct 2022 08:10:22 +0000
Message-ID: <AM6PR04MB5925C0AC7A4066AF52E2004CE12D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20221020101402.1856818-1-joy.zou@nxp.com>
 <20221020101402.1856818-2-joy.zou@nxp.com>
 <caae2af7-96ea-195f-6f33-05d9e79fa518@linaro.org>
In-Reply-To: <caae2af7-96ea-195f-6f33-05d9e79fa518@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5925:EE_|DB9PR04MB8138:EE_
x-ms-office365-filtering-correlation-id: 78edceca-cf82-44af-9cc4-08dab33bb3bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vybznDeeUCeI6HXMjLPbJpHvzgujQckXMt1DoXbaaa4Sq0p5BypAK6Has885GrlHsXHX9F6Gx6Bx9gxyn71QHEJP0/UYkMHu3XNVNFzd5n7KHcM06415jsz9XkC/Pagcl/uP8MtfIfzMQNoUByWEgjOV496uCJe8izy3BSu1fUZS3sWNLaYkrpbzRnosb8swR99Z2NsQA0/2hzgmasKXEspb0w1B7CIc4xzBC0kWi/UnJ7PDc8zq+BYQpubD3t1p+B2y/Zc8Hi1To8lgwR+QmgBSTO645EoqK1+QEUud8QusJZCYy9n3W5QxxoZ3tXkhHfw4PtPu3LiNNMferepfP1Zks3LQEsTi2itCwOhPhuHjeiF7S6X3gI3LpSJ7W4sikz5qG+rWzJg9UePNLERoCdWP/cg22P0YmUGqngyCw0Pz7oYDEpAO2y7hyMXicoWwU85Nv+uLepexgKvVTtQsED8N5CPG0LKeYvyzAb0eFwBC3VXoV2IFd6iE65UfVPoJKGWsiTDuNHtrL468nLT+qnmzTY+L4tTct0EtNqM0TyzuOshMcz64/pKywgai4A66Q2h4CaeXvmV8cyV0iBNS83kms/sVClgW1OKFNNoZht2tWDstkpVvCJZLnF0pDy7m0GCAZK//vIrtxiQuwlcBt0B+4njjN4oQfPJ8rAJGxTzXdsJFazoXJfZijnBKZCF3QqiZgSpaLcIdGAca3dI3usOkOCOhI3gcncMKNNbytg/Df+etlb0qdwE57TlTHDJne8YdjpS/KOEjsVDJ81COdufRA5dy9hh+AP/PvCzXTc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(76116006)(53546011)(6506007)(7696005)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(71200400001)(316002)(110136005)(66946007)(54906003)(44832011)(7416002)(55016003)(2906002)(186003)(83380400001)(86362001)(33656002)(9686003)(26005)(41300700001)(52536014)(5660300002)(8936002)(45080400002)(38070700005)(478600001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UEJQSlpDR292U1RyaWZuaTh4aTBsajNKY1JHV2tLRkIwSklpRkdBcE1MeVdR?=
 =?gb2312?B?ZGJkdkNzT0d6cHIyTzVHNEZRSk8zUXB5K2R1VDI2MWJXUUYrL3JIYVY1WU1Q?=
 =?gb2312?B?S1Z4THBxQ2NIU1VsZWRGTkY1b0srUXZyZ1l5ek1pK0ZLYUwwQXFLUUpnTFhk?=
 =?gb2312?B?VXR0c2VVZ1dkQmVRNHFsV0V0U1dIOVhsb01kTTlvSnhDREhkNDJMVUNNZHRO?=
 =?gb2312?B?RDB0Z1cvakNtWGpsSmw1b0tTYmFkSHZxdWw1SHNoOEdVR0VkY1lSWndwS0Z6?=
 =?gb2312?B?Ky94b3RnMUcrbVVzRFFoWUxIREkxZEg4b0xiMDNCSUliV0FsMzI4d0ovakZQ?=
 =?gb2312?B?TGZtWURMWWhYd2pZM2hZS3V4ZTdSTk8xYUJZdHlYK1dsa3oyQUdDYWt5VTRM?=
 =?gb2312?B?SkYxdDhGNmMva1BHUlhocWp0ZHhFZStxbWxmbjhMZFJlWjhhZ1c1NmJkVFdC?=
 =?gb2312?B?amJMbnhoRnJuRDdVa0sva2pISUtKbXJEMjAxS0ZjWFBjcWt0OXRpL05DT3N1?=
 =?gb2312?B?WUtSUFRCRUE3TVpjeHdhOW05Tkw3UXVKaHZvN1Q3YnZ3NmZ6RWRBV0xmZ3RH?=
 =?gb2312?B?cEpVMWRtMWVoYVBkSkhNeVoyZCsya1l6VnR0Vy80eTZCWkxTWm1RbkMxU3JZ?=
 =?gb2312?B?eUZKbkJ3VkVuQlN1anhQa2V5R3hEcUpOVWlJUXV4dDM2OWMwR1NRZHlKZ2tL?=
 =?gb2312?B?d25wSkNhanQwM05VNUZhKzVQNkpabDZDWjgyanM4ZWNTZjZnbFhNb1IyUWJ6?=
 =?gb2312?B?WVBYS3pZVUdVLzZsejBYUGJUNDZ4SWQ1Qnd4MVFiZ240UmtCNE4wYVFDWEo3?=
 =?gb2312?B?SHFVbzNxWHFZMUZxODZ4UVFYK2RrdERzSEtKTk96OXNKOS9QaFhOMHhIREND?=
 =?gb2312?B?ckh4Vk5Cbm9zZ0ZUdXpjT05NWjVhQVc5bXEvZ05WWTlKN25kQldNeFJHVEla?=
 =?gb2312?B?RzVQWGk0OWJtOEhwY1JLb2NpLzBDMUdVWGJPS3ZhSUsyUllvcXJBK05GS0tY?=
 =?gb2312?B?cWZZTkdhYTl6WVlDQUxyWU9jNU41UjFEZmthaXNtYU5Ga1hDM2NkSmlacEY0?=
 =?gb2312?B?UXBOdzJsUEJ0TEVEcVVJYjZhTGxrdkZXaHBwcGpwK1F4QlluZ25pYzU2NExi?=
 =?gb2312?B?Sys1TVh1UjQ4ZXR3ZXdvVDB1WG5CN1pIOU10SGFucmpKZ1BZUnVsOGsveTE0?=
 =?gb2312?B?RUtSUkVwem5GRCszd0NNLzVzdFVYSDU5aEtGVTNWMnFXVEtMWkpqMFY0bldU?=
 =?gb2312?B?MmF6M0xmODI0blJXUUZhNTJZbWJLWml0bUlYdU5lWm5nelJUNUJkWUhMZnBO?=
 =?gb2312?B?R0d3dnB4U01RODh1d0xxRjZDVDhEZ1hKNWhucWJpaTAzMmpRMUVkc3VFT2pt?=
 =?gb2312?B?aEQ2QlpQKzV1a0gyalNQTWRkYzhVQW1lcnliN2xUK1h3NEZGbHlsTVc4RXA0?=
 =?gb2312?B?Skd3NTNnUVc0bmViMFFmZjZJQmtJZXV1VGRXOWwzK0wyOGdGQUFlYmJUNTAx?=
 =?gb2312?B?SG92NGZLZ1NQZWRmM3NrQ0o4Ry9ZMUpCenhnOWZSOERQa3ZrTERkckxZUm9a?=
 =?gb2312?B?Qk5TZHBDVWdTK3ZqT1htZ3Q4aURkbEhmdDhwWEdZa0VwUXFQM1JUVytVdmFV?=
 =?gb2312?B?Uy9odnR6Ukl1NUVHUEN6bEZXMy9YV2Vqb0p3Z3lrbEUwOS8vZFZ4cC9Odml4?=
 =?gb2312?B?ZjRtakwxcHFiWm82QkM5T0J3REF4K0liOWhoYStyUEswcFBjQklHQ0Z4Uktu?=
 =?gb2312?B?cTJyRzZaaGdjTnJ0cTQxQWdxVTNKdlo4OUxNQ043MlRlcm5uRXpJTEhSUkZK?=
 =?gb2312?B?YWFnaHVoS2NQU2xiZlgzTlRTdTNObk5vUzQ2RzkxZHdrb2dQZTdPbWlNeVk1?=
 =?gb2312?B?SXZzNHRJc1pzV1NTZDhuMkNvWEJXMWp2TTc0MGR4SExMb01sRmhzRHQwamxi?=
 =?gb2312?B?d0E0K3VyT2RqenJyL3ptK0RCeEwvd21hSXVpZW9JV2Q2YWJneHV0Ky9OQmxk?=
 =?gb2312?B?ZTdPK0tnWDFMS0xTaTJaSi8zSnpwdHhVcERqd1k4Tm16VDhhZUhwSlM0RjNk?=
 =?gb2312?B?U1VOT0h0RWp0VnNlMk5uVTdLNk1JK1hGU2FmUkdqem1POWcrTitTeHRSMERh?=
 =?gb2312?Q?hqtY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78edceca-cf82-44af-9cc4-08dab33bb3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:10:22.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A70hFyHkRyvmKJBI4X+7JHPqWc1R5k0g4+5utxm925MzQvytevp3+3S+El1lL/OT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMsTqMTDUwjIx
yNUgMDozMg0KPiBUbzogSm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgdmtvdWxAa2VybmVsLm9y
Zzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBTLkouIFdhbmcgPHNo
ZW5naml1LndhbmdAbnhwLmNvbT47IG1hcnRpbmtAcG9zdGVvLmRlOw0KPiBkZXZAbHlueGV5ZS5k
ZTsgYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgUGVuZyBGYW4NCj4gPHBlbmcuZmFu
QG54cC5jb20+OyBkYXZpZEBpeGl0LmN6OyBhZm9yZDE3M0BnbWFpbC5jb207IEhvbmd4aW5nIFpo
dQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY3IDEvMl0g
ZHQtYmluZGluZ3M6IGZzbC1pbXgtc2RtYTogQ29udmVydCBpbXggc2RtYQ0KPiB0byBEVCBzY2hl
bWENCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gMjAvMTAvMjAyMiAwNjoxNCwg
Sm95IFpvdSB3cm90ZToNCj4gPiBDb252ZXJ0IHRoZSBpLk1YIFNETUEgYmluZGluZyB0byBEVCBz
Y2hlbWEgZm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hLg0KPiA+DQo+IA0KPiANCj4gPiAtLS0NCj4g
PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxpbXgtc2RtYS55YW1sIHwgMTQ3DQo+
ID4gKysrKysrKysrKysrKysrKysrICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlt
eC1zZG1hLnR4dCAgfA0KPiA+IDExOCAtLS0tLS0tLS0tLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE0NyBpbnNlcnRpb25zKCspLCAxMTggZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxpbXgtc2Rt
YS55YW1sDQo+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLGlteC1zZG1hLnlhbWwN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLGlteC1zZG1h
LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4u
M2RhNjVkM2VhNGFmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLGlteC1zZG1hLnlhbWwNCj4gPiBAQCAtMCwwICsx
LDE0NyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgT1Ig
QlNELTItQ2xhdXNlICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOg0KPiA+ICtodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
RmRldmkNCj4gPg0KPiArY2V0cmVlLm9yZyUyRnNjaGVtYXMlMkZkbWElMkZmc2wlMkNpbXgtc2Rt
YS55YW1sJTIzJmFtcDtkYXRhPTA1DQo+ICU3QzAxJQ0KPiA+DQo+ICs3Q2pveS56b3UlNDBueHAu
Y29tJTdDNDA1YmI0OTAyOGUzNDBhZmRjOTQwOGRhYjJiODkyNTElN0M2ODZlYQ0KPiAxZDNiYzJi
DQo+ID4NCj4gKzRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzgwMTg4MDMwNDI1ODAw
MzYlN0NVbmtub3duDQo+ICU3Q1RXRnBiR1oNCj4gPg0KPiArc2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNDQo+IG4wJQ0KPiA+
DQo+ICszRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPXRnTm5neFRsSUJPaElYdDBWWUpBQ05N
JTJGViUyRjANCj4gTFdDWHlUWVZyDQo+ID4gK3JaNVBmb1klM0QmYW1wO3Jlc2VydmVkPTANCj4g
PiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJlZS5vcmclMkZtZXRh
LXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2RhdGE9MDUlN0MwMSU3Q2pveS56DQo+IG91JTQN
Cj4gPg0KPiArMG54cC5jb20lN0M0MDViYjQ5MDI4ZTM0MGFmZGM5NDA4ZGFiMmI4OTI1MSU3QzY4
NmVhMWQzYmMyYjRjNg0KPiBmYTkyY2Q5OQ0KPiA+DQo+ICtjNWMzMDE2MzUlN0MwJTdDMCU3QzYz
ODAxODgwMzA0MjU4MDAzNiU3Q1Vua25vd24lN0NUV0ZwYkcNCj4gWnNiM2Q4ZXlKV0lqDQo+ID4N
Cj4gK29pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzMNCj4gMDAwJTcNCj4gPg0KPiArQyU3QyU3QyZhbXA7c2RhdGE9TU5sdEo3TXVP
cGFicGpZJTJGVGRpOElEYWd0Z2lGejF2Z1VDVWhzNjhDaFYNCj4gVSUzRCZhbQ0KPiA+ICtwO3Jl
c2VydmVkPTANCj4gPiArDQo+ID4gK3RpdGxlOiBGcmVlc2NhbGUgU21hcnQgRGlyZWN0IE1lbW9y
eSBBY2Nlc3MgKFNETUEpIENvbnRyb2xsZXIgZm9yDQo+ID4gK2kuTVgNCj4gPiArDQo+ID4gK21h
aW50YWluZXJzOg0KPiA+ICsgIC0gSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiA+ICsNCj4g
DQo+IFlvdSBuZWVkIHRvIHJlZmVyZW5jZSBkbWEtY29udHJvbGxlci55YW1sIHNjaGVtYS4NClRo
YW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgY29tbWVudHMuDQpJIHdpbGwgYWRkIHRoZSBkbWEt
Y29udHJvbGxlciBxdW90ZXMuDQpCUg0KSm95IFpvdQ0KPiANCj4gPiArcHJvcGVydGllczoNCj4g
PiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgb25lT2Y6DQo+IA0KPiANCj4gKC4uLikNCj4gDQo+
ID4gKw0KPiA+ICsgIGdwcjoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3BoYW5kbGUNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSB0byB0
aGUgR2VuZXJhbCBQdXJwb3NlIFJlZ2lzdGVyIChHUFIpDQo+ID4gKyBub2RlDQo+ID4gKw0KPiA+
ICsgIGZzbCxzZG1hLWV2ZW50LXJlbWFwOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLW1hdHJpeA0KPiA+ICsgICAgbWF4SXRlbXM6IDINCj4g
PiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICBpdGVtczoNCj4gPiArICAgICAgICAtIGRlc2NyaXB0
aW9uOiBHUFIgcmVnaXN0ZXIgb2Zmc2V0DQo+ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogR1BS
IHJlZ2lzdGVyIHNoaWZ0DQo+ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogR1BSIHJlZ2lzdGVy
IHZhbHVlDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBSZWdpc3RlciBiaXRz
IG9mIHNkbWEgZXZlbnQgcmVtYXAsIHRoZSBmb3JtYXQgaXMgPHJlZyBzaGlmdCB2YWw+Lg0KPiA+
ICsgICAgICBUaGUgb3JkZXIgaXMgPFJYPiwgPFRYPi4NCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0K
PiA+ICsgICAgbWF4SXRlbXM6IDINCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogaXBnDQo+ID4gKyAgICAgIC0gY29uc3Q6IGFo
Yg0KPiA+ICsNCj4gPiArICBpcmFtOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFt
bCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxl
IHRvIHRoZSBPbi1jaGlwIFJBTSAoT0NSQU0pIG5vZGUuDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoN
Cj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0K
PiA+ICsgIC0gZnNsLHNkbWEtcmFtLXNjcmlwdC1uYW1lDQo+ID4gKyAgLSAiI2RtYS1jZWxscyIN
Cj4gDQo+IGFuZCB0aGVuIHRoaXMgY2FuIG9uZSBiZSBkcm9wcGVkLg0KVGhhbmtzIHlvdXIgY29t
bWVudHMuDQpJIGhhdmUgdHJpZWQgdG8gZGVsZXRlIHRoZSBhZGRpdGlvbmFsUHJvcGVydGllcywg
YnV0IEkgcnVuIGR0YnNfY2hlY2suIFRoZSBsb2cgYXMgZm9sbG93Og0KJ29uZU9mJyBjb25kaXRp
b25hbCBmYWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVkOg0KCSd1bmV2YWx1YXRlZFByb3BlcnRpZXMn
IGlzIGEgcmVxdWlyZWQgcHJvcGVydHkNCgknYWRkaXRpb25hbFByb3BlcnRpZXMnIGlzIGEgcmVx
dWlyZWQgcHJvcGVydHkNClNvIEkgdGhpbmsgdGhlIHByb3BlcnR5IG1heSBub3QgYmUgZHJvcHBl
ZC4NCkJSDQpKb3kgWm91DQo+IA0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZh
bHNlDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
