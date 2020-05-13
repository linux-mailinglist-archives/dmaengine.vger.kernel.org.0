Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E251D19DE
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgEMPs2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 11:48:28 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:14786
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729604AbgEMPs1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 11:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1U34UP5M0MUn9oXy0j9QPFU/qbxOG6vXMCbZk0kdpH+RicRYVVT9TDy8sXEUbJroXhIUdxw1NCW0n07qgqiYiN3wlN6p6wSamW3qVKIXpjB4dQyACYSsc87lcr2Vh58v4liGo/KjY7bZEQzDF/V/PTpyDmEIs+YvT15+zMyuszd9TrOk+ih9+r+/5i+h8VL+XOxtAHMm3YyCiYIiENrTL8eHqGXhXy9qVnHKn86pFLl2PwW1MC5agPk3auuD+6L6UyWKv1fvORJEz5XCbl3okL8h1vuAqjuxSf/NfxjuclA7JO1JBVDERczNhi+SXET1jOgjPQB6FGEn4kLrBcO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJKWGi8K1AoaMsEqCEf3yLrQ4uYdt7gD+wRZoEs5tqU=;
 b=KLZhepLhrMFGS553lbusqf6/2d4xzGRUNOaoy8GsFmvV7mYVu62iwjwau+3hkzTRVOPs8+XUcXXabSG+6JNMzk94lNWGMHbhW/aYMBL0n973qfsA46gD0dfmhhz+LC70gAAXwgb1lEqWWmHeqwJ9oiE8i8OM2YXGy34eLNYU+J6XEaXDFa3VEJvRZVOYFaEKxNAzAEbkg/7iE71CG323W/ph3Vd/RFCCrX1GNs2Wz7EAJRWkhQ3t9Qrm4cCqqEfpPR3TRe3+gg99u/Lq6/aMzrl2PKwvdAgsmTNY/6gDuxmgaFF/y1XFHWW07Vmp+a6NFnSwdb3hF6+VZRvVQew4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJKWGi8K1AoaMsEqCEf3yLrQ4uYdt7gD+wRZoEs5tqU=;
 b=CwdKCPTLhR6bzTjSzF8ehFctl5KjWJ2KKeJ/il+8cRi2Y/CMc0DmvekCAForwriSY1LvFG4+GVxZSN4J5xKymP59LSTjvBEH5l4rw5nQ7v09U18/F2LcO3SCzzafafjM2aiiDScRRyiejMAOiFm7OLlIjTPetDvqbDOjfB9UkZ4=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6654.eurprd04.prod.outlook.com (2603:10a6:803:129::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 15:48:22 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 15:48:22 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v7 RESEND 07/13] spi: imx: fix ERR009165
Thread-Topic: [PATCH v7 RESEND 07/13] spi: imx: fix ERR009165
Thread-Index: AQHWJ3cnZ0DWmxBZKkqSbDLRijv4Zqiln1IAgAATtwCAAASDgIAAAJXwgAAIeACAAB4RQA==
Date:   Wed, 13 May 2020 15:48:22 +0000
Message-ID: <VE1PR04MB663876FA31A281A388F2BBEB89BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-8-git-send-email-yibin.gong@nxp.com>
 <20200513072132.GL5877@pengutronix.de>
 <VE1PR04MB6638F5096376BA0AF204C64189BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200513084815.GP5877@pengutronix.de>
 <VE1PR04MB6638857DD94A05DC7252E69589BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200513092038.GR5877@pengutronix.de>
In-Reply-To: <20200513092038.GR5877@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.237.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db82b458-7f95-496d-ad76-08d7f755111b
x-ms-traffictypediagnostic: VE1PR04MB6654:|VE1PR04MB6654:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6654F024D6DE898C9175AB6C89BF0@VE1PR04MB6654.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9SQOXlZSIUpGLuAmAE7x3FDiDFlMcrdZKhvSOl8Mxcc2HWLbkJ23uqaK3rmmiWDY9+BYoT6I74EXcwbe348WIUeKBhnGwnWQTIa04DnhrrQIB3fxHVEtG6KQPv9bNo6v2oWSgSnAGYUmw8oM4YrEXno3yiCbPaHInnyJ+Owihl7PYrdmWdqiJ96ZSiTTMfdYJFJ/PONiKtRbHLb356xALk5/IR6l51dcjy53uwZpGV5Bk4aM9uD8QMbdF76/xi0o+edHiDqAuJCo2E6qYp9jiCyVU2FFqo5TbSE983l4uJ8is+qkU7iTTFC32WZQZ5gnlil6XhoRO8ZVwHPK0Li4VpjoLZ032ADHYLYg15ZzyKsE1v2c/pD3Vh9KxQayIkCKPBOsd3Og3idHFQ/dQ6eKXRe0myK9q7NqBsg/koZXGKcDGps63Rgc/Fyzv0eN82oIzY4aIdarYXC5kpimMOfTGQPs1DiA1gIDgJ813cVOvWMh7mHa62tA8igQ0FHy0y/WLOoqE8E8aSogwttCcPv5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(33430700001)(316002)(8676002)(66476007)(8936002)(66446008)(2906002)(4326008)(6916009)(66556008)(64756008)(54906003)(186003)(66616009)(33656002)(478600001)(26005)(7696005)(33440700001)(4744005)(71200400001)(7416002)(55016002)(53546011)(6506007)(76116006)(99936003)(9686003)(66946007)(5660300002)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c3DzGH7tD7e+1nsm8kjAdusa7imUmzga/YOeHM4x6YyC9o4PD6/CKcSG69hQ6s6nP9OAfnz8N72F7LeZe6NdZ5rfruXK+98zYULWABdLpb+zueogOddb7GetNKbJ/FeMEA2vV/HdeVrWpRNc24PqzHrSOfdBAD5ri6XNR5N3AalPzPXPk8sVbOH1yOQt3AzfEjaFiAHm9dPsdDQxBBpgtsVrpzlmh4KymRbsNXXeRfqWomcDfQrCDMHc5YzKsvi1IoCt/dluyDCjEOnUiAYR8pcP0vcGkreFlydZohsbPWZC8rUCtOBGll1oLNVjqKBTdMdyhZdS3pog5dsaCnJ8yvLyel3hKa5UPYzZ/G9X56uFRBdYfgd4kVZaVsHsp65S5ujFJL/Jt/Hpvlvfh4jvUoK/er3s/bqTyon3vtXz94PF10kriYXOZIXI0K1kpgHoQAoCU8J/JBKajLAG/s2t0WY/wQfQeqFH2ggIK+k+1osHIqYAuGKhhyYJT42/BO/j
Content-Type: multipart/mixed;
        boundary="_002_VE1PR04MB663876FA31A281A388F2BBEB89BF0VE1PR04MB6638eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db82b458-7f95-496d-ad76-08d7f755111b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 15:48:22.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPscbgD7Sai+Gzc2L0g/wIjb1th/Eve8EkAFzzIRINg6IgJ+suSsTj8lrZsJfKIy1LKnyKCQ3a+OCLTkvtmlqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6654
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--_002_VE1PR04MB663876FA31A281A388F2BBEB89BF0VE1PR04MB6638eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 2020/05/13 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, May 13, 2020 at 08:52:39AM +0000, Robin Gong wrote:
> > On 2020/05/13 16:48 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > On Wed, May 13, 2020 at 08:38:26AM +0000, Robin Gong wrote:
> > > > On 2020/05/13 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > > > This patch is the one bisecting will end up with when somebody
> > > > > uses an older SDMA firmware or the ROM scripts. It should have a
> > > > > better description what happens and what should be done about it.
> > > > Emm..That's true. Timeout will be caught in such case, hence,
> > > > maybe we can
> > > fall back it to pio always.
> > >
> > > With my patch applied sdma_load_context() will fail. I don't know
> > > how exactly this hits into the SPI driver, but it won't be a timeout.
> > Thanks for your quick test, assume you use ROM firmware, right?
>=20
> Yes.
Would you please have a try with the attached patch which is based this pat=
ch set?

--_002_VE1PR04MB663876FA31A281A388F2BBEB89BF0VE1PR04MB6638eurp_
Content-Type: application/octet-stream;
	name="0014-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch"
Content-Description: 0014-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch
Content-Disposition: attachment;
	filename="0014-spi-imx-fallback-to-PIO-if-dma-setup-failure.patch";
	size=3274; creation-date="Wed, 13 May 2020 15:46:25 GMT";
	modification-date="Wed, 13 May 2020 15:46:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNGY5ODYwYmU4Y2M4Yjk2NzI2MjZiYWE2MmE0Y2VjODljZjI5ZTg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+CkRhdGU6
IFRodSwgMTQgTWF5IDIwMjAgMDc6MTg6MzMgKzA4MDAKU3ViamVjdDogW1BBVENIIHY3IFJFU0VO
RCAxNC8xNF0gc3BpOiBpbXg6IGZhbGxiYWNrIHRvIFBJTyBpZiBkbWEgc2V0dXAKIGZhaWx1cmUK
CkZhbGxiYWNrIHRvIFBJTyBpbiBjYXNlIGRtYSBzZXR1cCBmYWlsZWQuIEZvciBleGFtcGxlLCBz
ZG1hIGZpcm13YXJlIG5vdAp1cGRhdGVkIGJ1dCBFUlIwMDkxNjUgd29ya2Fyb3VkIGFkZGVkIGlu
IGtlcm5lbC4KClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4K
LS0tCiBkcml2ZXJzL3NwaS9zcGktaW14LmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktaW14LmMgYi9kcml2ZXJzL3NwaS9zcGktaW14
LmMKaW5kZXggYTU3ZWRjYi4uNTY1MDVjYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvc3BpLWlt
eC5jCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYwpAQCAtNzIsNiArNzIsNyBAQCBzdHJ1Y3Qg
c3BpX2lteF9kZXZ0eXBlX2RhdGEgewogCXZvaWQgKCpyZXNldCkoc3RydWN0IHNwaV9pbXhfZGF0
YSAqKTsKIAl2b2lkICgqc2V0dXBfd21sKShzdHJ1Y3Qgc3BpX2lteF9kYXRhICopOwogCXZvaWQg
KCpkaXNhYmxlKShzdHJ1Y3Qgc3BpX2lteF9kYXRhICopOworCXZvaWQgKCpkaXNhYmxlX2RtYSko
c3RydWN0IHNwaV9pbXhfZGF0YSAqKTsKIAlib29sIGhhc19kbWFtb2RlOwogCWJvb2wgaGFzX3Ns
YXZlbW9kZTsKIAl1bnNpZ25lZCBpbnQgZmlmb19zaXplOwpAQCAtNDk2LDYgKzQ5NywxMSBAQCBz
dGF0aWMgdm9pZCBteDUxX2Vjc3BpX3RyaWdnZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lt
eCkKIAl3cml0ZWwocmVnLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsKIH0KIAor
c3RhdGljIHZvaWQgbXg1MV9kaXNhYmxlX2RtYShzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14
KQoreworCXdyaXRlbCgwLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9ETUEpOworfQorCiBz
dGF0aWMgdm9pZCBteDUxX2Vjc3BpX2Rpc2FibGUoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lt
eCkKIHsKIAl1MzIgY3RybDsKQEAgLTEwMDgsNiArMTAxNCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc3Bp
X2lteF9kZXZ0eXBlX2RhdGEgaW14NTFfZWNzcGlfZGV2dHlwZV9kYXRhID0gewogCS5yeF9hdmFp
bGFibGUgPSBteDUxX2Vjc3BpX3J4X2F2YWlsYWJsZSwKIAkucmVzZXQgPSBteDUxX2Vjc3BpX3Jl
c2V0LAogCS5zZXR1cF93bWwgPSBteDUxX3NldHVwX3dtbCwKKwkuZGlzYWJsZV9kbWEgPSBteDUx
X2Rpc2FibGVfZG1hLAogCS5maWZvX3NpemUgPSA2NCwKIAkuaGFzX2RtYW1vZGUgPSB0cnVlLAog
CS5keW5hbWljX2J1cnN0ID0gdHJ1ZSwKQEAgLTEwMjIsNiArMTAyOSw3IEBAIHN0YXRpYyBzdHJ1
Y3Qgc3BpX2lteF9kZXZ0eXBlX2RhdGEgaW14NTNfZWNzcGlfZGV2dHlwZV9kYXRhID0gewogCS5w
cmVwYXJlX3RyYW5zZmVyID0gbXg1MV9lY3NwaV9wcmVwYXJlX3RyYW5zZmVyLAogCS50cmlnZ2Vy
ID0gbXg1MV9lY3NwaV90cmlnZ2VyLAogCS5yeF9hdmFpbGFibGUgPSBteDUxX2Vjc3BpX3J4X2F2
YWlsYWJsZSwKKwkuZGlzYWJsZV9kbWEgPSBteDUxX2Rpc2FibGVfZG1hLAogCS5yZXNldCA9IG14
NTFfZWNzcGlfcmVzZXQsCiAJLmZpZm9fc2l6ZSA9IDY0LAogCS5oYXNfZG1hbW9kZSA9IHRydWUs
CkBAIC0xNDMwLDYgKzE0MzgsNyBAQCBzdGF0aWMgaW50IHNwaV9pbXhfZG1hX3RyYW5zZmVyKHN0
cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgsCiAJCQkJRE1BX1BSRVBfSU5URVJSVVBUIHwgRE1B
X0NUUkxfQUNLKTsKIAlpZiAoIWRlc2NfdHgpIHsKIAkJZG1hZW5naW5lX3Rlcm1pbmF0ZV9hbGwo
bWFzdGVyLT5kbWFfdHgpOworCQlkbWFlbmdpbmVfdGVybWluYXRlX2FsbChtYXN0ZXItPmRtYV9y
eCk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KIApAQCAtMTU0Myw2ICsxNTUyLDcgQEAgc3RhdGlj
IGludCBzcGlfaW14X3RyYW5zZmVyKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksCiAJCQkJc3RydWN0
IHNwaV90cmFuc2ZlciAqdHJhbnNmZXIpCiB7CiAJc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lt
eCA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoc3BpLT5tYXN0ZXIpOworCWludCByZXQ7CiAKIAkv
KiBmbHVzaCByeGZpZm8gYmVmb3JlIHRyYW5zZmVyICovCiAJd2hpbGUgKHNwaV9pbXgtPmRldnR5
cGVfZGF0YS0+cnhfYXZhaWxhYmxlKHNwaV9pbXgpKQpAQCAtMTU1MSwxMCArMTU2MSwyMyBAQCBz
dGF0aWMgaW50IHNwaV9pbXhfdHJhbnNmZXIoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwKIAlpZiAo
c3BpX2lteC0+c2xhdmVfbW9kZSkKIAkJcmV0dXJuIHNwaV9pbXhfcGlvX3RyYW5zZmVyX3NsYXZl
KHNwaSwgdHJhbnNmZXIpOwogCi0JaWYgKHNwaV9pbXgtPnVzZWRtYSkKLQkJcmV0dXJuIHNwaV9p
bXhfZG1hX3RyYW5zZmVyKHNwaV9pbXgsIHRyYW5zZmVyKTsKLQllbHNlCi0JCXJldHVybiBzcGlf
aW14X3Bpb190cmFuc2ZlcihzcGksIHRyYW5zZmVyKTsKKwkvKgorCSAqIGZhbGxiYWNrIFBJTyBt
b2RlIGlmIGRtYSBzZXR1cCBlcnJvciBoYXBwZW4sIGZvciBleGFtcGxlIHNkbWEKKwkgKiBmaXJt
d2FyZSBtYXkgbm90IGJlIHVwZGF0ZWQgYXMgRVJSMDA5MTY1IHJlcXVpcmVkLgorCSAqLworCWlm
IChzcGlfaW14LT51c2VkbWEpIHsKKwkJcmV0ID0gc3BpX2lteF9kbWFfdHJhbnNmZXIoc3BpX2lt
eCwgdHJhbnNmZXIpOworCQlpZiAocmV0ICE9IC1FSU5WQUwpCisJCQlyZXR1cm4gcmV0OworCisJ
CXNwaV9pbXgtPmRldnR5cGVfZGF0YS0+ZGlzYWJsZV9kbWEoc3BpX2lteCk7CisKKwkJc3BpX2lt
eC0+dXNlZG1hID0gZmFsc2U7CisJCXNwaV9pbXgtPmR5bmFtaWNfYnVyc3QgPSBzcGlfaW14LT5k
ZXZ0eXBlX2RhdGEtPmR5bmFtaWNfYnVyc3Q7CisJCWRldl9pbmZvKCZzcGktPmRldiwgIkZhbGxi
YWNrIHRvIFBJTyBtb2RlXG4iKTsKKwl9CisKKwlyZXR1cm4gc3BpX2lteF9waW9fdHJhbnNmZXIo
c3BpLCB0cmFuc2Zlcik7CiB9CiAKIHN0YXRpYyBpbnQgc3BpX2lteF9zZXR1cChzdHJ1Y3Qgc3Bp
X2RldmljZSAqc3BpKQotLSAKMi43LjQKCg==

--_002_VE1PR04MB663876FA31A281A388F2BBEB89BF0VE1PR04MB6638eurp_--
