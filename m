Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D7F4CBADF
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 10:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiCCJ7n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 04:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiCCJ7n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 04:59:43 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD815D388;
        Thu,  3 Mar 2022 01:58:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL3TOWLClFUPLH1jInHQ9/JUu+XqL/77aUw1cGCWCASMe12hDLV2I5U7wa7a5cNOe/BoPTT3mP7qnRPqIpq+XdbP4XSR4g4ZQT4pl/MueCovRi+yGpei/MELDqnsrSKL+433Ir8Xgs9tdbFn6HB+T4ti9qca8BMKXTQTQ9VmSPIQY727gIi4kAwrBHOiFWhpqnX5AdGzurG/tNIVNwzOi9UR+1+8nhmf93Pz/xyoN0sLPLfZIGPuy4CtJx6qQRrR+mdwPcgTQiPnZAX/QSYSD0/G2J+GjTza/Rg0KojBSGQJ+9TsUeIE1aguUk+83QytWIr30v6hNkaUrT+Qur8K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV0k+RfrZK8C/eL2Lt4uXHAC4HN1zjezeqpM7sIi9pk=;
 b=GEaMVRwSEF1DPizZx53lud92ZM+mtdxkSWTV0qA5IJMPuQZ8N5OPdxvGnzImvYSPDCgXCh1JkeVDKRLpry00++22pQOBHDGG8WJjgR3m9BZXzrW2hBAzkYI+lP4E0TPF48iPYgz/DVVxSMc78YH5plLZ+rP0C8miwgpoZOx4H3GNkrnVmUi0+MljayRGmKyy6jR3/y8YfUwtdFsGc6NZpzQrgXUVKhI1qaKESLBh1mmUhAdH8E8QCW8csADxCQVzfmdUJRBFrt0K3J3G2lGIfJHieBQjwl6Bl31MjLjpAdso0Bd0TTpBH4E9RRP1a+D7rKxSnst3RE0xfbGYzBN6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV0k+RfrZK8C/eL2Lt4uXHAC4HN1zjezeqpM7sIi9pk=;
 b=AbtkLyBkDnHhGujSP1oI/lbxTOf3m3l7r+HqlWsE4xWeZLQ/MrXuJEqgMV6qPIZdeHpZe6ONYBr6lUy7CC1ITSy63BP9qFSC+AfRP9IPOOytJ+DFkxgUcofnl24hSjix9vI1zstP73eXc23BUd9gOIzkQxpZwIK1sOhepIU27qk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYXPR01MB1549.jpnprd01.prod.outlook.com (2603:1096:403:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:58:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::58d9:6a15:cebd:5500%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 09:58:54 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: dma: rz-dmac: Update compatible string for
 RZ/G2UL SoC
Thread-Topic: [PATCH] dt-bindings: dma: rz-dmac: Update compatible string for
 RZ/G2UL SoC
Thread-Index: AQHYLt1aDnM/todue0KDTBSeVt5L1qytXmYAgAANYQA=
Date:   Thu, 3 Mar 2022 09:58:54 +0000
Message-ID: <OS0PR01MB59221E953FD970E3877643D386049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220303090158.30834-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdUXXkoeAU7as+-t5AkWv4Y6ZW15wwDSozOeH+gZetD1YA@mail.gmail.com>
In-Reply-To: <CAMuHMdUXXkoeAU7as+-t5AkWv4Y6ZW15wwDSozOeH+gZetD1YA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5e0bb51-a3fd-4018-6f57-08d9fcfc6d70
x-ms-traffictypediagnostic: TYXPR01MB1549:EE_
x-microsoft-antispam-prvs: <TYXPR01MB1549B0F4E86E0D38571A59A286049@TYXPR01MB1549.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X19PK7MGuF2mILH7Kiu+ZMb/5zgZI2o8FAV5zcOFTQQtr2LF3VFcy2neADB+cQFEkShN03z2lBOENs/VISy+8wlqAlg97POcz6PopUb/f4ThdoxwmzSfymNAqnsHX9Xyl63kkG25Gl2xTRv3hQa8ZxnQm9pedHSh7BPHARNh3Q9P46Nhm3kgu9BPqCCmWABG3b5kR4zYoZhzfucAyQMFU6NQlC0R5mRfOwsScuRcbDpPaxxpkAxlS7CsGNsIZQyzCwFKNImIVboHbWSb8YEcBALF5vT25U1VTOoL4VyaRLplonoEvbrdd4I7gDrUdY21xjosJTet46KScXheQYZp0plSL5nwPtYlYfKcP6XjaMoQK0Lt5+G1ufZR7ltl7XJEIlyQhLUEJZNddU2IhAymXMGcbQKT+drGa7CK+T+8V3g0ylTmkuk8yDMpFpDFrm0zW9zTafIrT5ds9tD55jt0gBYqKP7T0FYf6ERpZxgy2ZyhMpznF+d+RWAjnNfNfi4YGM1r3bRXnWcSLFJiOecftsE+nuC0p767SKAhXqPdJAIEtdudzeU5dQks+lKDzTruQWVItcygFNw/MPdJ7PC7ohyVAl8oUPF79E1Nz/bkwixG/A6HflpTqy2bKVeWRsZsdFZiTK3g68LVLeS7Dt2w+DP3PlL/s3CGmRZ4HiYYk0q/cQcDktdODKrHEYfkyXoFZxsR9kBxR7vG0lqyhsUDkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(316002)(6916009)(66946007)(76116006)(66446008)(66556008)(64756008)(7696005)(71200400001)(6506007)(9686003)(66476007)(83380400001)(33656002)(26005)(53546011)(186003)(2906002)(122000001)(508600001)(54906003)(38070700005)(5660300002)(55016003)(52536014)(38100700002)(15650500001)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm9zeHpJdDh1UFVWSS9iQVJRVWpwazZpeXhLRlRNZy9YMmZCaTdSSFVqektr?=
 =?utf-8?B?UEE4ZjBPNGN5MzdxQzRtQ3VnRlUyOE5WczJNUmROQ1ZoME9PcXhjZmtQUXhr?=
 =?utf-8?B?T2VXN1ZJcXRuVC9CNm16M3VCYlNXcFVjamtGZG50VWk3a2hwcWN6UGFTK1Bs?=
 =?utf-8?B?TjM2eUxEMUQ4bUc1dVEvcGw2NnVPZWlDamNrSU1TOTlyM0VrZmtrVi9Na0lh?=
 =?utf-8?B?aVczcUNBMWtzblNXV0FxaVlEZTFwOHdtY0c0alUxVitoL25Qc2tSdFFkWktq?=
 =?utf-8?B?U1ozTkptWlVqN2VKYlJBZmJvRmVDT2dHSExvK2U1THdrRDk5dTRIMmtNa1NX?=
 =?utf-8?B?c2M1cEZWZkJ6eDZHRHVvMkJSOUFxaFNoMnlJNTZQejFRYjRnWWZJa3phLytn?=
 =?utf-8?B?WWdWSjdyeklhWnJEdThhU21LakpldjJwS1dESGJrV2g4b1p6eW1EMXNUWXhx?=
 =?utf-8?B?VW9vYWxDMUpsa0llems2OFArZytDMG1ER2hXZE9WVHBlSnh5bjdTWGtSdkNu?=
 =?utf-8?B?WVk3SnN6NUQvTzNmUWswUXlTVSt4Sm94QW42TVJPbEJBRkNzU1ZVbkRlV2Ex?=
 =?utf-8?B?WlN0RkZCVyszVUNSZXNPWUpyaU5LdTd1Vm9nMXhFczZMTEoyTDVrMmFHOVZZ?=
 =?utf-8?B?eCtpaEVNTmJZQWJVMEd0NDNCK1cyTUE4VlluZWZ1KzFmT0ZSTHRtYmtYVEh2?=
 =?utf-8?B?YnViUkdZZ1VxN1V5ZGxCd1NOS3pNN3hzVVpnNEdjTzJodW1rYkloRFNqd3pS?=
 =?utf-8?B?L3hLWWpzekJyNkNuaVhvY2VTSGRNZ2Jza0FvSzZLWlIvM1BXeXdyanNOMWwr?=
 =?utf-8?B?MmZWcnlqY1g4TDVTcWRXOERVaWpVU0RkZjZGbFB3Z21NckNMN3EySEJjUmkv?=
 =?utf-8?B?c24yQURHeHJIRHkrVG41ZVVRaTc4SjlHU2IzNTZocVpUS0d3c29EQ01WeDkv?=
 =?utf-8?B?eG96WmU3blR1TUM4cTkyRlNUWms5bmk1RGd5TFJtWjNObFkzbUpDV3hVUytP?=
 =?utf-8?B?ZURBeG85WWpmSVF4eGlDc3NrRWVYeFYvTmVvRXZnb2ordm52QnJ3czBvek9E?=
 =?utf-8?B?cDJDK1VqSnc4NmNwUkVmazJ2TTdURlc0eDBnU3Nwa3VyMVdHclZJVlpjN1di?=
 =?utf-8?B?cUkxbGhmZEU4Q1VUcVVMaC9jSWlYc0NFRlhiMnAvdFJsKzlGUWE3V2FyNzJS?=
 =?utf-8?B?Y2dpQVdUWXFyaFNBUnRqNVV0OHM0Tmpkc3dPTkFHTDAzSmx1Z0MzWS93enlD?=
 =?utf-8?B?V3hrVkFMZTAzR1VHdXVORTY3NmxGKzZWSXhGbUxSRXAzVmUxRy9CMjIyRzBp?=
 =?utf-8?B?L0dLY1c1VEFHNXJOdmZEc2p2bE9mY3pvNDdUTFNBdVJSUXFQckdHdTNubTJ3?=
 =?utf-8?B?MXN0aVpvbC8xMENUcTZaTTJsSDdNWlhkemVpZ2g5NzNmTUxWYmx5SWZHTTN6?=
 =?utf-8?B?MlJOTGFybEpGdm9RS1Nzd0x1OVp4SkJYSWdEM0tzY25uVHZWMUxJTm1oc1Z4?=
 =?utf-8?B?dHF5MFRFMVZJZU9CNkN5RnZDOVRveVdjdVRCT1cybFFUTGlpNWhMUDlnSFM3?=
 =?utf-8?B?RC9YTE5UQ1Rpc21Ja0dlbDQ5OFkyOW5xaGpIeUF3Z25xYkR0aXFXdFp3OFd6?=
 =?utf-8?B?d20xQ2o1RVJzZ0xLTHNpeDlEeDVkd21NRjA3M3pmSFNLWHByV21BWDFiUVVq?=
 =?utf-8?B?dTlyOFNBUVVFRHZQM0VITU82Q2Y5V1VhVHR4ZHkxc01iZEFPZG1pY1NqSWxj?=
 =?utf-8?B?S1A0SldKRE1VZ1pmMzd5UVVOcHY5OU9ZQlZtQ0o0MndKUkZJRjNOK3lkb2hZ?=
 =?utf-8?B?Uzh0bEtvTUpMZlVZVTk5QUtZc3hybXpGbkFSa1NKcWZ3czBFaEZEN0NVL1ll?=
 =?utf-8?B?YzFxd21paWlWSDZocXMrY2NxcWowb2NZTncwMGRCcHNUMVpLTzc2bDlRWTdy?=
 =?utf-8?B?SC9NYkRIcmlCL1lSNGNoMkMyTkE1SU9TYzNQTlh0ZTdWU3prekJvV3dJcUlZ?=
 =?utf-8?B?QzNEem9sYS9EemcxeG5VMWI2bm5od2VxQXhkZ1F4Wk9tMHBVcUYzUGFncE10?=
 =?utf-8?B?OTZ6M0Y3RXN5K1RPOVhEZ2NNUjc5YTRiQTRIcDhFL044Tys4KzRCM1lDbXRj?=
 =?utf-8?B?aHBndnk0bUZUUUN6czY1Y082dEd2RVBzT0hZRG0rMjhqWmoyU0k0MXRYZ1M1?=
 =?utf-8?B?aUMvcFVsYmwvNFFWU3M1L3VJTDhmbjRZWktzOHQxNGU2RzJPY1VCNTF1MVUv?=
 =?utf-8?B?d3NtQnZQRU5jYVpSdGtVNU16TFpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e0bb51-a3fd-4018-6f57-08d9fcfc6d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 09:58:54.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lnZ3R4mIknFsG2naJEtReM4Z6kTqAIsiUR5l6/eFAOZ/XYMrS2oBuqfhMvfFlMMwm1ArfayRFc+sdvsz38mE4lsclPLrtz5ZxhCQ/aNP50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1549
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGR0LWJpbmRpbmdzOiBkbWE6IHJ6LWRtYWM6IFVwZGF0ZSBjb21wYXRpYmxlIHN0cmlu
Zw0KPiBmb3IgUlovRzJVTCBTb0MNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBUaHUsIE1hciAz
LCAyMDIyIGF0IDEwOjAyIEFNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gd3JvdGU6DQo+ID4gQm90aCBSWi9HMlVMIGFuZCBSWi9GaXZlIFNvQydzIGhhdmUgU29DIElE
IHN0YXJ0aW5nIHdpdGggUjlBMDdHMDQzLg0KPiA+IFRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gdGhl
bSB1cGRhdGUgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHRvDQo+ID4gInJlbmVzYXMscjlhMDdnMDQz
dS1kbWFjIiBmb3IgUlovRzJVTCBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IExhZCBQcmFi
aGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRo
YW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJ6LWRtYWMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvcmVuZXNhcyxyei1kbWFjLnlhbWwNCj4gPiBA
QCAtMTYsOSArMTYsOSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gICAg
ICBpdGVtczoNCj4gPiAgICAgICAgLSBlbnVtOg0KPiA+IC0gICAgICAgICAgLSByZW5lc2FzLHI5
YTA3ZzA0My1kbWFjICMgUlovRzJVTA0KPiA+IC0gICAgICAgICAgLSByZW5lc2FzLHI5YTA3ZzA0
NC1kbWFjICMgUlovRzJ7TCxMQ30NCj4gPiAtICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cwNTQt
ZG1hYyAjIFJaL1YyTA0KPiA+ICsgICAgICAgICAgLSByZW5lc2FzLHI5YTA3ZzA0M3UtZG1hYyAj
IFJaL0cyVUwNCj4gDQo+IElzIHRoaXMgcmVhbGx5IG5lZWRlZD8gQXMgZmFyIGFzIHdlIGtub3cs
IFJaL0ZpdmUgYW5kIFJaL0cyVUwgZG8gdXNlIHRoZQ0KPiBzYW1lIEkvTyBibG9ja3M/DQoNCk9L
LCBKdXN0IHRob3VnaHQgdGhlaXIgREVWSUQgaXMgZGlmZmVyZW50IGFuZCB0aGV5IHVzZSBSSVND
LVYgaW5zdGVhZCBvZiBBUk02NA0KQW5kIGFsc28gdGhlIENQVSBjYWNoZXMgYXJlIGRpZmZlcmVu
dC4NCg0KSSBhZ3JlZSBpdCB1c2VzIGlkZW50aWNhbCBJUCBibG9ja3MuDQoNCk1heSBiZSBJIGNh
biBkcm9wIHRoaXMgcGF0Y2gsIGlmIGl0IGlzIG5vdCByZWFsbHkgbmVlZGVkLiBQbGVhc2UgbGV0
IG1lIGtub3cuDQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gPiArICAgICAgICAgIC0gcmVuZXNh
cyxyOWEwN2cwNDQtZG1hYyAgIyBSWi9HMntMLExDfQ0KPiA+ICsgICAgICAgICAgLSByZW5lc2Fz
LHI5YTA3ZzA1NC1kbWFjICAjIFJaL1YyTA0KPiA+ICAgICAgICAtIGNvbnN0OiByZW5lc2FzLHJ6
LWRtYWMNCj4gPg0KPiA+ICAgIHJlZzoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhv
ZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgt
DQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5p
Y2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4gQnV0IHdoZW4gSSdtIHRhbGtp
bmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nDQo+
IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBU
b3J2YWxkcw0K
