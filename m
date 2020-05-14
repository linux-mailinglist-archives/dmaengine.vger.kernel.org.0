Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BEA1D24E2
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2020 03:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgENBp5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 21:45:57 -0400
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:14944
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbgENBp5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 21:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgPXSKxx74y2KvCkOmQQhMvPculjtWZvozpDjnNM65kWCp+HvM98Lx36cALRO4Trc9cED85zWzW0mCUJEkTcT4Nhx2oOp2NG+JgwPdHG6oPv0jQBUis8SI6ZJRdjlOSbc1cEdI6tNSVidSqfbnxzGW1Es4gFyr6sXm2k0nfvqkpfLHzW5MH2wfAIfTEXphVk0qJ70+2OG46xMRAcXSllGTvNpTxVkCkX6jR5PEpzjEgl8K64uBjIdjl4hmaO3RG2jvd+Gg7kqVSW6W8752TNiNqRn6ooKMpEPBWF1jzvnv88Bm33zmyBJAnGsbBBu/3mecU8HpFAicuM+93hOkXHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlESU/QjztXvmBVWcNV0YCutjNpSIPIkPZJot00HCnc=;
 b=nAtbI61lKruQupe10sLsZYeGL9n5dQCdOaolVgL6bLdeZlI2utSnD9Ff3Env+QsTN8pWeEg9II7HCPVsFlE8L5jOGMXcIto1NGy44UvmUR+otGYPXjuYdFdhUGHMVlaH8N8Axjmx/Pujntrd++tNf4HCZp29YX/8vBBYBeSakwNph7FArQHK/ejKCJmmJ2JQv0wLGMHHDxC5X564bJLFDVrT+ezaDs/NizexndX4Udb5j56HeCyEu8rH2A8Rx49QdAl2T2067FOvAvBshGmGj83CkHHCxWITaN/vigEMlXH57anvEl7uix9mxuN0R9PPn3zMNnE5wAEbzHNnl+fh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlESU/QjztXvmBVWcNV0YCutjNpSIPIkPZJot00HCnc=;
 b=q89hZoGXMFWQVJ3kGdTa8JHOVPXB1EWyK38EEYqvae2lLoy2Lr42UyvT5NRaUo0vu9/c6/seGpUWCYhj96uRUuuHDMjhXT6R8yRjQpHXOmpzYT2ZyLj2dWdnOHqNcD0I7xQZUdgLDZlZoKC8tszrJq71kQ8OyfzfkloTCtfBp9M=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6413.eurprd04.prod.outlook.com (2603:10a6:803:11a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 14 May
 2020 01:45:51 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 01:45:51 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Sascha Hauer <s.hauer@pengutronix.de>, Vinod <vkoul@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 RESEND 13/13] dmaengine: imx-sdma: add uart rom script
Thread-Topic: [PATCH v7 RESEND 13/13] dmaengine: imx-sdma: add uart rom script
Thread-Index: AQHWJ3c7z7ZHgVvFIUGSiBVcSGczHqimhdwAgABNxqA=
Date:   Thu, 14 May 2020 01:45:50 +0000
Message-ID: <VE1PR04MB66382D7B4ADB48FBF437CA1989BC0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-14-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5BB-bnKF6fQtw+1iGmojrmNHVQqeN3Fu8tHa_09ayjCgg@mail.gmail.com>
In-Reply-To: <CAOMZO5BB-bnKF6fQtw+1iGmojrmNHVQqeN3Fu8tHa_09ayjCgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80250c41-91ee-43ac-34bc-08d7f7a888aa
x-ms-traffictypediagnostic: VE1PR04MB6413:|VE1PR04MB6413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6413F9BAE4A3A08BBB57611E89BC0@VE1PR04MB6413.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7QFpTz0UB+X/Gpnn4iOxfM57Gt0F/HpKLh9O34dmw1iA6q3xbsihlA5aGeL/bbQ9tPyiBSGmLoh9LUhgFWiCnqiozvGGi9gcsxuQ32kipZT4zecEAtQEVtu7ZtekBByEA5e85ZvvO1tdzCMcOU91dZ4WTEO/rk8k+4ZAfGDByq50gr723hLaoXYRU30NXQupDaFKMJMt0yI2CZwoEwSX6WTTbeoLzfgftBfJC+HfqcY2fph85OiQQr+lezaDZExnYpgIjrfnXaWMegBaqFHbElmZ+KQpljmvNSyoR9iNav/bKW4rsI3jU/FLolDjgvohpSApk/1S2tSR8GT9irGIRM9D/0uHrm1ZwqERGxb8d1ek1hSbLcn7s91EjbuV8L16MiXcNz0XifPhQQcqcFlhkTwEuqg8CXALn97VT1mfXmtmOcjOEc4xvcbEb+4TZohBpUhWgqFRPm+O6nVvcH9j2BfIhMJxuVCuHr49SmHzFENnOKC+1huyjabOFkfRkY+E6KONpSP2Hc1k3XXPHcr1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(33656002)(53546011)(6916009)(66946007)(54906003)(316002)(64756008)(66446008)(83080400001)(86362001)(8936002)(4326008)(7416002)(7696005)(66556008)(66476007)(6506007)(9686003)(76116006)(52536014)(8676002)(55016002)(2906002)(45080400002)(478600001)(71200400001)(966005)(5660300002)(4744005)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SjoHd51kgvefUPbFCsyJZNhC8gWSuOukNNo0pVWQwtRSUkCktpnCq754XPAcSIw1sGL0WiItvEvKN3DBi/0yqCzS2hP1nn5C6SQoOSy5kyL9jM/CmBT0FHOA99F3ZT6G2Z2JzU9oJxYdegJ3AiCyt+r7PzpkpR5LcfDoXHcsCUwtsMaomCSEPAiKBHMNTRdyzD7hU81hVggzq8JJD7W/SgfW2QKZ6TH4x3EoQH2u1B8pSfJPLcdG6rS82foFfsWwld5tzbL25l4ZNQ1FjTJ5ly1KUM4NOyGxsis/zAhgGlDdwhUDeprS/zCCjMWJBR42VJLLxQmfY8uNiUgMCjkwQJuG+PJS0VcpZyh5XLKR7rv7JN6jY3HTOtu2Lxx6dY2nw0SKB4z/si5rSPHq58vdfzGQiRvACBCvmOrh8IZc5xfujx5T6PN82vLYJJtlsgX/ON1Limzfe/DSfO7+MNKZDpMU/aWn0urYfma+uoIjsIOrzYhCQuSaXnMZvtkOX7fi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80250c41-91ee-43ac-34bc-08d7f7a888aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 01:45:51.4627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBrhOpD3TkUA5tiSqfxyw7VmX2wi+ZKXwkEQ8VqvnZaQOK983Va/r01wP+E+SHKArha39u88mEfT4g1jBBAlmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6413
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wNS8xNCA1OjA3IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4gd3Jv
dGU6IA0KPiBIaSBSb2JpbiwNCj4gDQo+IE9uIE1vbiwgTWF5IDExLCAyMDIwIGF0IDY6MzMgQU0g
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gUGxlYXNlIGdl
dCBsYXRlc3Qgc2RtYSBmaXJtd2FyZSBmcm9tIHRoZSBiZWxvdyBhbmQgcHV0IHRoZW0gaW50byB0
aGUNCj4gPiBwYXRoDQo+ID4gKC9saWIvZmlybXdhcmUvaW14L3NkbWEvKToNCj4gPiBodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZnaXQuDQo+ID4NCj4ga2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJG
Z2l0JTJGZmlybXdhcmUlMkZsaW51eC1maXJtDQo+IHcNCj4gPg0KPiBhcmUuZ2l0JmFtcDtkYXRh
PTAyJTdDMDElN0N5aWJpbi5nb25nJTQwbnhwLmNvbSU3Q2MzOGUwZmMxZmRjNDQ1NTdhDQo+IGY4
ZQ0KPiA+DQo+IDA4ZDdmNzgxNWNhYyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1
JTdDMCU3QzElN0M2MzcyNTANCj4gMDA3MjkxDQo+ID4NCj4gNjcyOTgwJmFtcDtzZGF0YT1DbkFC
dGlUSUNUSWY0WlFRJTJGOHg5cVA2SEQ5bERiUkUlMkJ3WHFjUmhtS2NkDQo+IDAlM0QmYW0NCj4g
PiBwO3Jlc2VydmVkPTANCj4gPiAvdHJlZS9pbXgvc2RtYQ0KPiANCj4gImxhdGVzdCBzZG1hIGZp
cm13YXJlIiBpcyB0b28gdmFndWUuIEJldHRlciBzcGVjaWZ5IHRoZSBjb21taXQgSUQgb2YgdGhl
DQo+IGZpcm13YXJlIHdoZXJlIHRoaXMgaXMgdmFsaWQuDQpPa2F5LCB3aWxsIGFkZCBpdCBpbiB2
OC4NCg==
