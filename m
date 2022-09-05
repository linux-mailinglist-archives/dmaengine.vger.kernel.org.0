Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01E5ACBB0
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 09:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiIEHBY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiIEHBX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 03:01:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE803DF1B;
        Mon,  5 Sep 2022 00:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpVF+Aw7OfQlUb3GJao39vrRIJkNsAe1Ukafxi6/0OYV6oTYKKLYZIxVaK1vzPkaAiuqnaz1E+oKGjH2/B5tZiIsQ9pb9j2QhapzF3KjOir+0BLUxxr4Jm9QkVfKsari64jWqX30wu+8niWeI67BpQf2xgldPmzvlp64lHv6f3nQtSYZxMhSJmieaF9j2pCQXlhLsFtZA6O+JuHqr+n+kiX+Nl+WqapHxmD8mdrHKrjMkzpOCpRo56wBKX0WNpJD7uvoNUjDolDjx4RGhxpk38tLXHUJgWjk3djW5qQLZu0e2clGG3IvnVAlXVuvx1KgEHvXEUJPM5hCdBvX9FXxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gGjrQ0F9iSMdugnpDahD4N/uC2b9kB25bdJU5kOwlc=;
 b=dF8LyR/JNsTVNz7oCGK8Y2J4TQuylnwCZXvsbbPY643PBKK1vX0K+lK1nUnJhnySiNZupmTbP/u4j4JsZqLaAJEKuQhXcDdhZvMf5f2bt24jkW+5XQj6t7g1cgs46VxgxbwjhkJdDVa3p3HnYF+J63IKgLRoviQNhsKpT7fQcUkL5OZZ83HlM/0iXvxND6Vvcb0rWNaeOsoC3sxxsUBMQxHhBEYzpoXJrUDzM5NCdZ6xPnLMXj+0PXEKc6CYfyOcRrM+kau625J0znViRpAwKMSXXX3k9S9emwFiabFtWDY7YppkdCDtL4sugd8FyhPELOOi7pHXWEsWceZ9kWOE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gGjrQ0F9iSMdugnpDahD4N/uC2b9kB25bdJU5kOwlc=;
 b=Dwszw6yyaa2o9N70qqcvA0a6smhhXygt+/0zRhlAZUdXsVUdpKJ9Z73oxlkvTjzWViIvq7rUtGcUTpTudYvLkYz8sNzp9CwN1RZAWG0ZOcFlYlYimZW5jNQo3KG1OokQAHzIPsfB4gwVgWF6qMElXJ+QwJqRYCVpgij2X2BngWo=
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by GV1PR04MB9214.eurprd04.prod.outlook.com (2603:10a6:150:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 07:01:04 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 07:01:04 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
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
Thread-Index: AQHYvaZ8O5GQjHuFO0+lJC0QJTvpyK3PeAEAgAD00fA=
Date:   Mon, 5 Sep 2022 07:01:04 +0000
Message-ID: <AM6PR04MB59253DD6C91D41344C08C175E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
References: <20220901020059.50099-1-joy.zou@nxp.com> <YxTPTnrJst9aNpsl@matsya>
In-Reply-To: <YxTPTnrJst9aNpsl@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ccbc6a2-39dc-49be-47b2-08da8f0c6664
x-ms-traffictypediagnostic: GV1PR04MB9214:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5sWxNJQVDtpxewTKEIkPJZMw8wVfheEyU/z6qf3hsPwF6CC1OLKWYgGB9L8a+QvtmgjO40PwVvGV4lK8ipiieoSlMLVGibCD8A+OsO0o3E64uNdXZnb9UufDI6KgUox7mQHjC++Ztn0wvTOjed+IaN88lOYI3HR6AhyO/6TCrm0fv+uwgCRWiDmUOKt68MrGrMMmx/opVB6f3vhu4AcUIaZzsv89RvRoJ3jxJHQeuwfRCEaDnfm3SqUoU72M1galSOUORx3OPxmQE05Zm+WHwoX5uxQredOyywHPB3d+tlASdwLc+nM/LVpkgx03s2fH3VoCRLRJmqlg+mzZj29DtfzDFh0e/g3rTXhGfFMsy8wbe9zm4xGIitutmEiaxh4b4yeQHWH7AZkkbs/jTI1A0ILDX61vMTpsNSQ3GgyiMAnVrbGB+zFquVfAhPiENgcYphoUQ8n+xm7P+1fCj1fF0qgebF4rj2cMlhN7yyvKJ3qN5Yusn8PGjJrq085r6lHpZvDTAWh84VsvNfiZ/kn94CAY9spZj+M8DisqdQaxUKYYPyCmyD6B01nzSznmARG4JfRP8OxwVnag3cXPLAf4z9ZrloFRLzXK9u6D3WMhruig4zaaGs/khw2cUD3l/rmooLrXb7dPU3p6QaFuu1QqowsenqIJfyFG9J75mNgRXAxYAnEm4x7/bAAJKCK8bpqckkfaYH9BQQY4cYBjDafDk73ePnmJauDTsPBm3O8+hKSLJxAIv32Qrn/NyTpEpA2rxYUGoMx83UbSjuJtzLrvNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(71200400001)(41300700001)(4326008)(66446008)(66476007)(66556008)(38100700002)(26005)(76116006)(64756008)(66946007)(83380400001)(7696005)(8676002)(6506007)(54906003)(6916009)(316002)(122000001)(478600001)(9686003)(55016003)(186003)(38070700005)(2906002)(52536014)(8936002)(86362001)(53546011)(44832011)(33656002)(5660300002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bTB1cElRVkpZNVNBdkttbFlOV0dWdXJNSjhYK0todVdPTXlNNzY1aWhZT3dn?=
 =?gb2312?B?VEFWU3o0YlFsNUJHaTJ1UXBCUVZvdk53Wm5JQkFOekQ5TFBxOVF5KytCRm50?=
 =?gb2312?B?Y3F3K0wrSkpsUzEzQ3dsa1Zmc1dYSUpwUkZiSUE2SWpaaHM2ZU9YU2ErZFBs?=
 =?gb2312?B?Z3UweWRDVDR2aWRTSUVQRWZ0WklWZFF2eFRQK212d0xkQ0JGQjk4M2kyN0pp?=
 =?gb2312?B?ODFxNXZkVlZ5NXp5NGVXSUEwZ3lyeHF4YW5WKzhTR0Yzd2VTNkR1ajVhdjBx?=
 =?gb2312?B?ZzZzYTg0T1FqczlhL1pMa0V3amdMNmdoU1RSdTVqVnhkbER1QS84LzNGbENp?=
 =?gb2312?B?R1hiYzFsRllqeDc2Rk1IdEJsUWhQdnRreTFURUNMdVZ1dkFzdnY5L21aakMw?=
 =?gb2312?B?OHNpWFZySlBUa3ZWS0p2aDZLZlMwcnJFZ25rOTkyUzI3SWZHdnllS1dINTBU?=
 =?gb2312?B?MmJ2NEJrMTVBUlVXVjFtK3hieUpOZUhZTlpSNnpHYTY2TWJsSkF6dW1JQ3ov?=
 =?gb2312?B?Qm1iVUlnVDh3RU8xMis1ejY0SUxROUNXSmRXQzFGTnBranZGa2RaZzJra2hI?=
 =?gb2312?B?ejBvd0Vaak9Bd1o5c2VHYndSWDVVZzJ5L1J0dlNBZGZ5NkViZS91b0pLaEtX?=
 =?gb2312?B?eXJNUGtmY2pyYUFXcUFPRUs1YnZuNkx3VTZ4a0RMVy90Zi9OdU1oWmJ4c0hy?=
 =?gb2312?B?dWx6MFRhY0VSUUx6Q0l4V0JkMVcrdzRjcmFURFZwN0xHQXVRMXZsOUlTT0JB?=
 =?gb2312?B?dHJUNFYyZi9zeGZtR09ocS9QWGpvK0dpb0VrWDVoWVcvVmFKc3V3OWI3MEEx?=
 =?gb2312?B?NUE1eWRVdXZUK2ZhNFNiVE5xRCsyM3dmUUg4bk5VVUFiRldmRlRuU0E1eWNT?=
 =?gb2312?B?RGFXNzVFZkJXdFFZUUtXcS9kc2dkNlJSMXJuTzY3akk0TXA2TG9Cd003RE93?=
 =?gb2312?B?anh4OE1hcnpnUDVqbVBidW1Tc3RUa1VJK0RQaitTemNoVk5VRzd6K25meGJK?=
 =?gb2312?B?Y3NFL3lCUllzTlM3djlmZjUvaXllQkxYbUFDVVE2dWZmSHlNQmp1bTdpNEd3?=
 =?gb2312?B?Ulo0NDhHVnJrUXg4bDQ1MDhoWlltYWh6SFlUYkVNcjV2WkJsTUtya210Wkpt?=
 =?gb2312?B?YkdXRis0bGRBd0pKL1FHMGdITmdCZUtqSDVVeFJ6dS9yUXVMcW5Ma0toalBR?=
 =?gb2312?B?YmQzNDR0RWUzbVpoMFZWdENGOUZ6dWRPZDFuUWoxRENmSGY5aVQyanljQTcr?=
 =?gb2312?B?TGQ5YjNTVjFJcndKU28zS2pCOFRKNFlnWW9QMllBOTRzekNKcTBTVjU1YnlL?=
 =?gb2312?B?by9lVXVwclc1dHpob0hlcTk4ekJWbEsvcmpFT01LYVk2S2RCRjVUMEJEMkFI?=
 =?gb2312?B?SGdZdENhQ3hNWFNRTjVNMlozeU01Vjg0a3FFV0ZkT1FOYXBHUDI0ZTRYa2hY?=
 =?gb2312?B?WEJ2RU13TkROdys1dW5aU04rMmE3cFdlbGNTcXlOSXdwWnNUM1FNUTNmZkRx?=
 =?gb2312?B?Qk84eE1CQXZraWQ4Ykx2V1ZxMkJsdzNhMmNEaG1DN2hMN1NlY3U5emozZENp?=
 =?gb2312?B?K1JiWlBxWngvZWdIdlBML0ZyclcrVEc3MUoxbnZFdTl2TmJjZmVYdWJyU0pJ?=
 =?gb2312?B?dnEyRWk1OUVibXN6ZGFHQ1F0R1NYdzBDM2JLQ0JwK1UxeUhMRGxYT0VtOGpX?=
 =?gb2312?B?aUd5Ykd0VytDbVpWZEFaeHdhbUNHcFdreUZ5ZGkwM0R5K25nb0lUUjFOdmxK?=
 =?gb2312?B?ZEJOeFM2Wm1kNm9yZlRWRHl0RUdkY0s5WG4zOEVCRjA4emZyNXdPcm9TL0Vo?=
 =?gb2312?B?ODQ5bk5pSjBRV1ZzTHIyMFRnamdhVmRXa3JyeisyR242Wjc0TWRTNGtDcWJE?=
 =?gb2312?B?UmtpVDdpZXhpSyttd01Vek4vSUhoSjJxa2p3dEpaazdPbDQ1UDdPUm14NkNj?=
 =?gb2312?B?QkhTTW8rcTRQRzdsT2VPL0Z0ZTdSakFzU1hmN3JqVm5MbVh6Q2xXVTVqa1J3?=
 =?gb2312?B?cHJKSytpSTN5VHNnWW5OQkh6bmZEL2RMd0cwYjBYTkppa3J0eWtVTDhtaTBT?=
 =?gb2312?B?My9nYnhBajVUZVRRaElZL0RnWDZ0ZXNZa3IwamtEQVc2OVozYkpGeGpmS0Ft?=
 =?gb2312?Q?T/80=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccbc6a2-39dc-49be-47b2-08da8f0c6664
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 07:01:04.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yNP1yacnfuqdVhziptWxRH8+Lv3wKHvtgIx3rRTq/ehgjtEyqK4Gzt5qXwPOLyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9214
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
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jnUwjXI1SAwOjE2DQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc7IFMu
Si4gV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPjsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsg
cy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZh
bUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBkbWFlbmdp
bmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQ
QVRDSCBWNCAyLzRdIGRtYWVuZ2luZTogaW14LXNkbWE6IHN1cHBvcnQgaGRtaSBhdWRpbw0KPiAN
Cj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiAwMS0wOS0yMiwgMTA6MDAsIEpveSBab3Ug
d3JvdGU6DQo+ID4gQWRkIGhkbWkgYXVkaW8gc3VwcG9ydCBpbiBzZG1hLg0KPiANCj4gUGxzIG1h
a2Ugc3VyZSB5b3UgdGhyZWFkIHlvdXIgcGF0Y2hlcyBwcm9wZXJseSEgVGhleSBhcmUgYnJva2Vu
IHRocmVhZHMhDQpJIGFtIHRyeWluZyB0byBzdXBwb3J0IGZvciBoZG1pIGF1ZGlvIGZlYXR1cmUg
b24gY29tbXVuaXR5IGRyaXZlciBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzLy4NClRo
YW5rIHlvdSB2ZXJ5IG11Y2ghDQpCUg0KSm95IFpvdQ0KPiANCj4gLS0NCj4gflZpbm9kDQo=
