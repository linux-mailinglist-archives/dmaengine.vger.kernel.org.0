Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D94672D4E
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jan 2023 01:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjASAU0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 19:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASAUZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 19:20:25 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2112.outbound.protection.outlook.com [40.107.113.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CAE2F790;
        Wed, 18 Jan 2023 16:20:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0GHS5ln3gEz6Dy5bCmkYvEq3kTp7m6OGDeI8hhqXt4ISgYqVhe5ZOXqg18u04iETt+sV9yRH2pWhdFhG2+zrVPKWCFRZCJTdm7HLZljn1gsGXZa2gXtZalWAdEPabJHM3tmEiEkbvUtvZ1lsLHNKNpIZukdx9100UjbWLGxYjtXj3RrBk46BnhPJb1ZSYxyCDe6FDW0LCiv92EDcFfIkQ6CUfflx39zkUfHb0bNGD+4kumpa3UohetqOM5vbDUR736bh/T7HNKKBtxSoRd9w24tp0hAYOSoG+B5C/0wK/mewDcafgj9p6Yq3qRWeZjFb2HEJE2lIhREs44/sQZ+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8+zoBjPTpSQAOfnoP8CjHTvnKrNbnV9iCVv4Y3NZLM=;
 b=IdJCWR/sNpJq26xFCb0RrUvqfuLM0mHm4KdIT5YXL191epgWqAIJ/uF5EyIJNdM8DaN1Z2HaqjUP/Qj1E+bhlXiLOx9dk4/4aG4TSssZgr2k3qcx8Ik41whHlSa3mFcB6dtvW97lJTYpUmIPG8XG/g716Ummd/FIxOueyPC83w7OtHfFxf+WUbJzRJVdJrtkFFdvEK/E1d1TrciV9E4OFzUmb3ZoPQJVx18gtdrjW+cNnpLzgXY47LkD/FGrEoeGRnCelwyLyh6Cql/zoifeXh2vY6/ZGE6y3apX1z+sSDsFTzdiKbWgdfDuCSJZseJzejSjtGgWeby97l1O2Kyg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8+zoBjPTpSQAOfnoP8CjHTvnKrNbnV9iCVv4Y3NZLM=;
 b=ErazuAj1mnl3EbI0+5+Wststrm7fKg5amUFeJyJVTVhpvBU0gsGRmHEYjUgvapAWGiTuv9rnZIt61PYhcv2InPYfTgT+/wP7EdDLYU3sxJ0uvqbcv8baYB6+O/CHvF65w1Yj/nOZqsyC5Bm23w7NzxM5VaYzH4Y/McxHvZ0mODY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9416.jpnprd01.prod.outlook.com
 (2603:1096:400:195::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 00:20:19 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::3e61:3792:227e:5f18]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::3e61:3792:227e:5f18%9]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 00:20:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Olivier Dautricourt <olivierdautricourt@gmail.com>,
        Stefan Roese <sr@denx.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Green Wan <green.wan@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?utf-8?B?77+9ZXI=?= <povik+lin@cutebit.org>,
        Peng Fan <peng.fan@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        "chuanhua.lei@intel.com" <chuanhua.lei@intel.com>,
        Long Cheng <long.cheng@mediatek.com>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Palmer Debbelt <palmer@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 1/2] dt-bindings: dma: drop unneeded quotes
Thread-Topic: [PATCH 1/2] dt-bindings: dma: drop unneeded quotes
Thread-Index: AQHZK2bx+wbgQBZnFUOyXLlmQqTCV66k359Q
Date:   Thu, 19 Jan 2023 00:20:19 +0000
Message-ID: <TYBPR01MB53419CC109B1EF98CE9D63D8D8C49@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9416:EE_
x-ms-office365-filtering-correlation-id: 6eb5d05e-6c4d-48c9-a636-08daf9b2f2b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrk2AcTusQsg9+Szbk0shh9Fw/0Gq/M6rXFXcKPl64OK10OzNRU4a1Dz+v0fqWxxBGgJ9czI2UfScFhMxSsg4vcM8Y+Fdvb9ku8TlD/6Ab7EtTR7+j321BpFfpnAyLUP8KPeRAluQCkoG05dni+ak4kZH1gVGkggH8m4bSWJLOqRVIzVyJb3WIb1flanRHAEgpteShosIb4k+Cx0klEz/6IV5Gk44rIyPW13WG/aLf1ApIbUsGmBimdZhg/aPHH3y6T6JXCTBcCTgUWovn2DeRt+CVdDp/V9hrz+FMVxmx7xrW0yZWD634GcC5DOEF5M2taW4J/DkfogQqNDsVLqSDvOwSby3welGHi3QTMR+9AocL74+QPEizgeXp8/lMN6vqlxNneTpUwwiufC3NhgEBZtMLwf0btlH/3NN0B9ZDOCVT/1rE3NsKUcbebqzOega76xeHup7EePAl8S6MIUYP4CBPTRLwSkywHbLbO2PTjb9jRUjSc/hHn0TR0ziC/GcAX9ia1rCbdWU7mCVGWAADGvtmcIAHcXaDUvJ0TJZYczb6KoQxRAGTKo+QDJEUedLcfpuJ4SOS7L8sgNeyWc82kVHBLIRi/isI46ODggRLObMCKpGXJcRocRUEG/dYu33IqWt16+k8xJnxHvGYMpfX34DDIuPSymAcmJF7lJ+FRRwCYl3p1zghOLSm4XmkrVqFkohA2DTKeID28yJVlYEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(9686003)(6506007)(478600001)(186003)(7696005)(71200400001)(33656002)(122000001)(7416002)(316002)(64756008)(4326008)(6916009)(66446008)(8676002)(54906003)(8936002)(41300700001)(52536014)(2906002)(76116006)(55016003)(66476007)(4744005)(66946007)(66556008)(7406005)(7366002)(38070700005)(86362001)(5660300002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTFFdEp3TXZQQW1OQTdXQnRPS2s0YXdxZTFIZWQrY05Idmtlc1lTR3dYQm9V?=
 =?utf-8?B?Wk16NmNTMkg5TE1STzdLN2NsM3g2UVliSTZ2Tm1PNkxac1hLM2QzSlcrV1Zq?=
 =?utf-8?B?Y0ZiTEc3Y0ZveFd6ekFjZEMrZ3QwSnM2dXZ2THZWT1d5ZktWcXJmRkxTUG8x?=
 =?utf-8?B?UU9YTzdGUThxdTNlR2hZWjN6UkpXZm5vVWY4clVEK1V6WExnUTI4L3Q0N2xl?=
 =?utf-8?B?bWdQQW9rVnZKT1c1cWxYQ0pCZndUbmN5VU9iMTd1Y3dncmFkSW43Qmxwb3NC?=
 =?utf-8?B?ZExuQ3lJRmtFWHd5VW9YVlpmV0NUUlFaK2k3VXVDeFBHTTVtMUZQWEIzVm1S?=
 =?utf-8?B?S3BCSDBrcjhNZGswM0szbWV2LzFzWCsxbGgrYUZ5bGdjKzdhRkdBcWkxUU9T?=
 =?utf-8?B?K0NROERIQTkzN1djSHdFd0dUeHJKNWVmZFMxUUd4YnZHbDNlTkIrSmhic2FS?=
 =?utf-8?B?VVpxNE5mSm5SUnpkQkx5MzRsNGRyR21QK0k0b3NCWDBXamcwVy9CUXk0YjEv?=
 =?utf-8?B?QTlqV3ByMlBnazU4MjVFbStUbUFuMWw2aWl1WDNhalNIdWtMZkNxRUdXZmNj?=
 =?utf-8?B?U05WakdncGlTT3Jka2JJaGpoeW1RR2ZCS2VXR2tiem5sbjZ4WmJocUh3MGp4?=
 =?utf-8?B?WjFrMkgyY1B6OG9qcWZxWmg4Y2dISEJ3d3RlT3ZZU280akJSQmQwQkxacFFp?=
 =?utf-8?B?a3ZjNWd6SERPQ1B1cDV3aE1wQkFJLzZTb1dMd0dFN0JJaW83ZzZpZ1g0VE9B?=
 =?utf-8?B?TS9KSlllbkZ1VEtmL0ZSTWM4TnpJMWFDa2IyOWRPSUNMSmJrME81L1BBb1pS?=
 =?utf-8?B?N24rMzRoZU5yTjl2R1dPWEVMVTluMDg2ZEVHVDM1bnNMY3NZdksrZm9RZlQ3?=
 =?utf-8?B?WTl5OG1LS0VNZlhjaUJwTVJGN0I5dDZVcVdIcHRJSjJFcEV3REcyMEFBZ2Jq?=
 =?utf-8?B?RXM0bTY0dkozYXgzMUhDemVYZTJWb1NWRXZSV0d2bW50QmVnbTV0cE9rcEJR?=
 =?utf-8?B?aS9yc2xkRkhLa29aZXo0bEcyOFEwYm9HaVdWdWxDWTYrNW53Q2pDcE9uTzBn?=
 =?utf-8?B?bEV2blpKb2ZsRHh0V1haUG05YkZZZFQzUnNMVGJQclFacDBSVnpKMXVpT1dn?=
 =?utf-8?B?TzFYY0t3U2VjdklvMFY3Z1J2cEZpd0pWbHhGQzZwcW9jQk5WTk5xNHdSOVNG?=
 =?utf-8?B?NEhwNm95MVUwNlFod2FGSFJJa0JLQUFoQVdPSG5BNmZKeXRPVGNObE1oRkUw?=
 =?utf-8?B?YktiZUZnRmVJUDdoRks5L0NybzFmam54dWcwUHpLTzZPRzVIZnZqZ1pUYzBl?=
 =?utf-8?B?U2YrN1VaSndGVHpEWHBtNTBkRlpQKzg3RDNMemN2TnFpbjFQdjRlZS9UdDVY?=
 =?utf-8?B?d01TTTNyalJwc3ROcmQwbHBNR2tnaHNQMzIxRVJLd3JNdGErMVlkekhrRVQ3?=
 =?utf-8?B?WHQwYTJCYmE5RGwvKzBROWIvdmV3d1NaaXNZckpVaHBYMVNsRDFKb2Nhc0xW?=
 =?utf-8?B?WEJyRDhBVjBwRHFNNWw5L0tXYm5zUldnMHp1SUhqYzFFNnNMTEppclhTYTEx?=
 =?utf-8?B?SmJsaWpHbVhVdnNNeGZIN3Y1VW5meTM3RWhDek1xNTgvTXlnSzJoOElOOU1l?=
 =?utf-8?B?M240RU5DTUdNdG9JNlB0V3NQV3V1dUxDOHNZSURxUHJmYXdLUitZVWpySUkr?=
 =?utf-8?B?cjNiOFFSTjUvL0dlN0x4WUR0UmkxazlwcmIzMTJDc005UUxOMzhEOHVOU01h?=
 =?utf-8?B?L1lvNnZialIvQmRJM2FlNG43TUxRWmVHWDNCbEllZ3NFejgvekJUZkg5c2Ez?=
 =?utf-8?B?N0tGbWdXc3ZHaHlGMTBvMVpPcitzUzNDdlFwME9KbW1VemRBNVd4aXFNWnNT?=
 =?utf-8?B?TGxaWW1NbDdUSWw2dTFZZFVzb1dtVHhsOWtKVjlnTmdDY1V6UXVOSHBNSHor?=
 =?utf-8?B?NHdtRnJRU0hoZnA3MzdvTTB4SFI2MWxVMy90dG1xeDFrcDBCQ1dlczFMaGN5?=
 =?utf-8?B?VnZhOTVtbnU5VlQ5ZE9sWk9OQTBiTmFyeVQ0WVlpY29KWFdQSWZGWi9mTTdm?=
 =?utf-8?B?MkFuaEVGYVpSWS9Nell1NlhTUXFOV1dtcTVBNnNOOG5ybkdZWnN4ZkI0ZEtq?=
 =?utf-8?B?R1h0UzA2MVpZTlg0WVNMeWY4MC8xMjNxM3pheHJJTnA1WWd2YXJVa3NCVC9J?=
 =?utf-8?B?U3BpaVAvSy9MREYxMlluRVc5N09zRldBVnNIazBPQ1oxY0EraEc2M3EzRk8z?=
 =?utf-8?B?RzVGVjc1MlNGcWRZY0lEVU5OTWhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb5d05e-6c4d-48c9-a636-08daf9b2f2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 00:20:19.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuGkk5WkX4mL1sJRML/EYGsUikCHH0/qpH4ndjU1J3n2orNEPpFEdhAtaVa/LVqnJA60jK2EnnjB+bzw4MA2ec5vrS6agdgfI5WgU/PT1NUOsQuoAbDuWFpZplR2sk0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpLCBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxOSwg
MjAyMyAzOjAyIEFNDQo+IA0KPiBDbGVhbnVwIGJ5IHJlbW92aW5nIHVubmVlZGVkIHF1b3RlcyBm
cm9tIHJlZnMgYW5kIHJlZHVuZGFudCBibGFuayBsaW5lcy4NCj4gTm8gZnVuY3Rpb25hbCBpbXBh
Y3QgZXhjZXB0IGFkanVzdGluZyB0byBwcmVmZXJyZWQgY29kaW5nIHN0eWxlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPg0KPiAtLS0NCi4uLg0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2RtYS9yZW5lc2FzLHJjYXItZG1hYy55YW1sICAgIHwgMiArLQ0KPiAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJ6LWRtYWMueWFtbCAgICAgIHwgMiArLQ0K
PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJ6bjEtZG1h
bXV4LnlhbWwgIHwgMiArLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rt
YS9yZW5lc2FzLHVzYi1kbWFjLnlhbWwgICAgIHwgMiArLQ0KDQpBYm91dCByZW5lc2FzIHJlbGF0
ZWQgZmlsZXM6DQoNClJldmlld2VkLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNo
aW1vZGEudWhAcmVuZXNhcy5jb20+DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2Rh
DQoNCg==
