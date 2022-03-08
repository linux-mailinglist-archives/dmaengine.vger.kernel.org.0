Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9419B4D0EDA
	for <lists+dmaengine@lfdr.de>; Tue,  8 Mar 2022 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiCHEut (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 23:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiCHEus (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 23:50:48 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DCD366AD;
        Mon,  7 Mar 2022 20:49:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMpJD7nWNJQZ/f0ooEJ1OCbzyHLUv/kTLZIbsPF176Toa6lG+aKQFtlwYI+dAEiCqF9pEwAB8JuLOb0asER/49lDVJy87deKRahDvsmQr53IesUaokPxbCBnA+6tTsZpjH2La/aQWhs3e5deQRCN5r6+ihrLI7lR0gsD0t8BvE5zg+jkC0A5c0S36BbAiogv3/o2Hx1lURoe+vWS//SrxR7L6figR7ujK8DAt7VaSeQ7N5R/zIi24Q6o/UFE9Ug+mE4dCfghCMZzs6Tc1sNEs9ufJRExnveOQRg2GBAr/J4mXi+D/ULLZ+ORCj+Ml3lP3beB2uKuHdThjYshMilOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl2wgwRisPe3/ssr+RCLbajJ7b1qahd+uFXNhygD07w=;
 b=d2Xnfjfg9XsXM+XadarXHbYu8pqmNvewuWI1nnTmKnz2v/edmPgAOXRN6tJPhZArNo/ZgFhFwPJkQSpBK85RAszqohUOi5u2TE+oRajKR5Bzl8LNboaLdZvMuu2u+41fJrdb+MqZWZuDW9jEFPXrHgkehF6sU2a5CdE/v6tjoDBfbJIZZ3g7/LkLQlDkIFqd7YlmfOLg4Os3SpQO1VQi+oJAgQTT1icX8hxq/hhHIwTabk1ktMpxk26q2sooOb65ZVEOFr4311Dp+qr/P90BODXIO7hNyYd+Z0RdIzN3TJgoKBPLSwm7fix9jIXbXb+tIEVVI6lvzvtosDjQER/w1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl2wgwRisPe3/ssr+RCLbajJ7b1qahd+uFXNhygD07w=;
 b=fZqFi2QWIHGuY0yQ5xFBoWINRnciFLjxuRDyjXrnEGFK5d/2whhzcI4CotuwUql64oMlNRFaJmdPQpF0lAWeE3veDnxhdgQ8558PPtVY9TMFUvtM1vsgmO1B85GTDA3UFTQy8XFMxRgdSdEwbEGlBgW4RYDGUIThE9vphJezBxQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2180.jpnprd01.prod.outlook.com (2603:1096:603:19::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 04:49:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500%4]) with mapi id 15.20.5038.023; Tue, 8 Mar 2022
 04:49:49 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Colin Ian King <colin.king@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2] dmaengine: sh: rz-dmac: Fix dma_set_max_seg_size
Thread-Topic: [PATCH 2/2] dmaengine: sh: rz-dmac: Fix dma_set_max_seg_size
Thread-Index: AQHYMldFt4r83qjIHUene7FOIgelJqy06sFg
Date:   Tue, 8 Mar 2022 04:49:49 +0000
Message-ID: <OS0PR01MB59226C04EBC1D56E886F2AAA86099@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220307191211.12087-1-biju.das.jz@bp.renesas.com>
 <20220307191211.12087-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220307191211.12087-2-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23e6773d-a92b-4c20-b8f6-08da00bf13c3
x-ms-traffictypediagnostic: OSAPR01MB2180:EE_
x-microsoft-antispam-prvs: <OSAPR01MB21807C1A0A5F18C35628B68186099@OSAPR01MB2180.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+j9WqrUudhRPSIQmSyIIZ9OJm2rjjJLN94aL2VPpXqtaDxKhOI/QTUNhpcQwbLximmCctIrs0HWllUpcGJ0cae8mwfxpLNmbfM9LfL2keEoQiPZGPLJarLeAaAwc0TwDoQJFaWr1m2jCNxoST702QRBuDpl3rFwmkalWeotbwYfntXVS+0Hshtmv6A3FBKSxS4ghxAn6Rv2grq1WwDwqeb//Rzra3Tj2nqv/TcoqmEZYksR2qdccYJL3J+Z4sV+8vNkYx3FuPsWj8wxp5HeqfGxKrFE9Nq2pjzlk5mRgTYS9npOYZyce4SVCBooRDGvrM9PZQpFS1d/t87p+8TZSQddcqO3z6lMViJ7kErvReKzLTTi72nB+hRZlL+O3vLJOSVAF9aYTtpKBk+ZPGpfYNQw43oo5TII8qMvfau6t8X/Sg80Ca0qoiTeRff8IYRUYGX6HsygQGgrtFpPBRD/mRTMv12D/a1bsCMG3HAnpfdn3mqXPt9mE6triWHoCrt8OW01ZWT22B4mJjv0bhWGRZWz0z7esmtubtBx4HzlMl/RQvttHUvVt16PX2KFT62lm1qWVwttszp8tm3kLY9aCUV1idP0Q4kDiMB3bSgqGRgR2+/PzfnoqnhD6Pf49Qocc7GzjVdUZhkyxQK0WzUR+WUOcRsv0y2hl8lTUmfNdQs7HR7/65ex2aYTnl/GHPg6o2Gnz/C9Xv/Zgx5Bzm/Zrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(33656002)(2906002)(6506007)(83380400001)(7696005)(71200400001)(26005)(54906003)(110136005)(186003)(316002)(9686003)(86362001)(55016003)(122000001)(66946007)(66556008)(66476007)(64756008)(66446008)(4326008)(5660300002)(76116006)(8676002)(8936002)(52536014)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUxQaDFFNk0zMmswMzdyUkdadlVqMU81L0c1ZGFycmJNMWluSFJUeXVjR29u?=
 =?utf-8?B?WGl2bkVrSVZNY2ZzOUZxU0RtL3JoYis3OWZpTmhxNkpUZzBEUHpkd0wzNlYw?=
 =?utf-8?B?UHRKYUh2c2tWRDZSS0VyUlJnQXJIR0RsT3RSajhTS3NhUU5BUkZWbDRsckJZ?=
 =?utf-8?B?Zzl0MnVkd1IvKy9vQzNJM0RxRXUyMW9MaDBpeHU2aTBJNmlMRmJieFlZalRY?=
 =?utf-8?B?MjFySXFOQkt2bCsvMEs3Q3l2NW94dC9tV0xDL2lEUWkvdG1IZnlYR2NnbjRa?=
 =?utf-8?B?dWtpUVA3VTFTWXVvNDdXZmt6cmQ5a2JSRVNad0xsU0JoSk10UDQ1NVdBay9S?=
 =?utf-8?B?U2JaK3AzZGFVTVQ2eGpZOUVlcnZzblBqTkNndGx6KzRSTHVlNFd4VkpLOFY5?=
 =?utf-8?B?VG9nbVg2ajljbWZ4dFliUmRmWUJBb0ZaVXh1SEpaQkN6aUdVbEdLYnNTbUdE?=
 =?utf-8?B?b3J3WVBaRk0yK2p4Y0RLNGtDUUVPQ0dmaEl0WlFNeERyZXpibjBpcXZoaXRU?=
 =?utf-8?B?cDFFU04venJEcFBnaGE2VVp6dlNEYlJJVjRnSXByZ2t6ejR5WCtKdHBmaTh6?=
 =?utf-8?B?aG8xekdoeVpaZ1BYcm5XcmNHQktFbkIyRTdZYnpkaDE0bk5oUFdONTBLbHdv?=
 =?utf-8?B?eWdTMkVPVmJ6aTJZei84dDNYc0hZek9tUkxBbTQ4dDJrNDdmY3JQR0IyQjRV?=
 =?utf-8?B?WjJESzhaLzhKaDZvaUpPdHZGazNBZlhCWnFxK3RpbEhRcEM4amQxWE8vc2lE?=
 =?utf-8?B?RGNRZnk2bUxDQThxNkdEVDNnVHdwcG9LZ215S1FrYzJydkQ4VTJDam93cVhW?=
 =?utf-8?B?NDB3NmFaejFEZkpRZEpGV1JpWTVFU3BTSkx4SGNNcHF6TTg5ZGkyNC9Fc2J1?=
 =?utf-8?B?TlBvT0x2SDlXTXlxcHlwa01Pc045Smo0S09oV0dBaStHTk5kOG1majFJSU0v?=
 =?utf-8?B?bzB1MzlnU2JSV0I4TzQ3VnNqV2tUUnIzZ245cGdZbGJaL2plQ2d2ZWt5QVMw?=
 =?utf-8?B?K1p6MU1pZFZVampLSUYzbkxFUHVmU2s0RXcxc291amlMTm02QTBMZlRxTWg2?=
 =?utf-8?B?SER6MkZVN2g0WTNHWEpoY2JDSmNUSzBNdFRNbGxha1V5YWY0NXVrbHZJdGQ0?=
 =?utf-8?B?d3pZTG4zNFpPbEo0UTBBQlB5Ym05MXpPMStRWVhUNCs3ZHpOU2syclJxRCtO?=
 =?utf-8?B?MFJLeHhJbFd3b2lQSUZ6K2NNYUtrZVJNWVVIOS8zd09rZExNaXBNY0UrZFdF?=
 =?utf-8?B?dm5IbUUzYjJEUjNwNUdNWTdOZU5NMHhxRjdodHdabVN5V0J5OUpvZFF6bUdv?=
 =?utf-8?B?bkxpUGNLSTFZLzdLbW1YalRWbGl1N3VzcFpjbkNwMlo5WnJZNVkyYmR1T0Nz?=
 =?utf-8?B?bFdITm8yUDJvK1NFbGxmUTA2b0VnRWNBclF1R3NtbjFUWHZiZUtrQi8wSjRu?=
 =?utf-8?B?STIvMXNJRWlXL2JWMkdKTWhhcE1LenVJY2E0T20yTXFzUXJCU0ExVldKQ2RU?=
 =?utf-8?B?N0hURk1MUkV5RC9kZ2c2NmJZSVY3eFA2RSs1Q1dXdzVua0t2bi9mWklESE1r?=
 =?utf-8?B?M2FOLzBPazVMVTBoaWhPZ3g3WWdsd050eE1sc3NuQWI0UndpbnFOektWdjdP?=
 =?utf-8?B?eVBpL3hEbEd4N1RnSWhFQjc4aWFkR1NxMllhVUJHWXh2VGZ2OWRoNHJPMDZh?=
 =?utf-8?B?UjZqTEN2emlTeVZhOGlZU2JYcnRRSkIwOEhzaDZDMm5pUmM1NXBKN1ZIZXhv?=
 =?utf-8?B?TTJUZDJMdnFhTmpVUkVWaEJXTUlQUm9MdjIvY09kUjhRU0FKNXdZTEZOZ1ow?=
 =?utf-8?B?SUg1ZDhCUC8yL3ljajlOWlNMNXNtZHVGZTJFM3VNUHRsZm4vbFhHenF6RlVk?=
 =?utf-8?B?aTcrU1E1Z0llSmRQS2xMVU56eDNLWGluOWdTUU1SVG01ZDhrZ1B6Wlg1aHYz?=
 =?utf-8?B?ZHc4YmQ5ZDdTRWxhenNGaFFxbGIyV3JMbGpLM1U1cFhaOWl3a1oyTzNTL0kr?=
 =?utf-8?B?SHZCRUhmWVVmeHdNTW9OUlhOQlVWU3QvZVAvallTWjg3dnAzU3RnMVp2L2hM?=
 =?utf-8?B?eDZHSzV3cUhBS0kzUjBRWWZ5azBFN2MvcHdpUDE2T2tqVVhQYzR1WUhZV1Q4?=
 =?utf-8?B?TXo2WTlJTUd4cDF2TE9keHlPN1R6ckE0MXBXZXdDdkhtQVhVZTJwWEhSZmJP?=
 =?utf-8?B?aUVmNkZvdTFaM2lyL2UxU0U3UGpDSnBSQlQzckJOZjEwTHUzZjJuR0llNlhN?=
 =?utf-8?B?YnBwdzgxQi9vaGsrZCtCMFVPODhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6773d-a92b-4c20-b8f6-08da00bf13c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 04:49:49.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzZ1tgawU9zQ+wuhM7bImCLsH/n/OJRWxngxDTLcdhWIi7eeTEwZf1kxKX9HyLbIEfVqNLwn6lHfMt4KChNwHf0n0vrovs2Q2gYs1DoS+Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQpIaSBBbGwsDQoNCk9vcHMuIEkgd291bGQgbGlrZSB0byBkcm9wIHRoaXMgcGF0Y2ggYXMgMl4z
MiDiiJIgMSA9ICdVMzJfTUFYJy4NCg0KU29ycnkgZm9yIHRoZSBub2lzZS4NCg0KUmVnYXJkcywN
CkJpanUNCg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBG
aXggZG1hX3NldF9tYXhfc2VnX3NpemUNCj4gDQo+IEFzIHBlciBIYXJkd2FyZSBtYW51YWwsIG1h
eGltdW0gdHJhbnNmZXIgY291bnQgaXMgIDJeMzIg4oiSIDEgYnl0ZXMuDQo+IFRoaXMgcGF0Y2gg
Zml4ZXMgdGhpcyBpc3N1ZSBieSByZXBsYWNpbmcgJ1UzMl9NQVgnLT4nVTMyX01BWCAtIDEnLg0K
PiANCj4gRml4ZXM6IDUwMDBkMzcwNDJhNjFjYTU1ICgiZG1hZW5naW5lOiBzaDogQWRkIERNQUMg
ZHJpdmVyIGZvciBSWi9HMkwgU29DIikNCj4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBSZXZpZXdlZC1ieTogTGFkIFByYWJoYWthciA8cHJh
Ymhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
ZG1hL3NoL3J6LWRtYWMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3NoL3J6LWRt
YWMuYyBiL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYyBpbmRleA0KPiA1MmQ4MmY2N2QzZGQuLmIz
NWJlYTU2ZTQ3NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEvc2gvcnotZG1hYy5jDQo+ICsr
KyBiL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiBAQCAtOTEzLDcgKzkxMyw3IEBAIHN0YXRp
YyBpbnQgcnpfZG1hY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWVu
Z2luZS0+ZGV2aWNlX2lzc3VlX3BlbmRpbmcgPSByel9kbWFjX2lzc3VlX3BlbmRpbmc7DQo+IA0K
PiAgCWVuZ2luZS0+Y29weV9hbGlnbiA9IERNQUVOR0lORV9BTElHTl8xX0JZVEU7DQo+IC0JZG1h
X3NldF9tYXhfc2VnX3NpemUoZW5naW5lLT5kZXYsIFUzMl9NQVgpOw0KPiArCWRtYV9zZXRfbWF4
X3NlZ19zaXplKGVuZ2luZS0+ZGV2LCBVMzJfTUFYIC0gMSk7DQo+IA0KPiAgCXJldCA9IGRtYV9h
c3luY19kZXZpY2VfcmVnaXN0ZXIoZW5naW5lKTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAtLQ0K
PiAyLjE3LjENCg0K
