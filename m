Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912432404F0
	for <lists+dmaengine@lfdr.de>; Mon, 10 Aug 2020 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgHJK5t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Aug 2020 06:57:49 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:64334
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgHJK5s (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Aug 2020 06:57:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI1vxZOfo8bVPn0p459ZTwjV2Qk5vbFPWqNyMWcj6+OMdnRnBwtXToy8z5dA0XRUSyeSflGT6NFQi6O/OrCtuJ7WYFCN9QMjaNnfBpe+yu7FUM6o45C/NCU38v4ZW6GYOPXSBAh26Cj2LA2+r20mqiLm7D4wodcUr6Cc7V4tG8ZEkC6GALNM6lv/E4SwQyzhovTPCb54vWgGnk5Naj8io+gfXZyS1q5TbzYuutc4PaXSbB94gqZ9DiG9hnLBmaXYcWyuoMdmuBiaWgx1hQz2Rk/o1NjrSQKWP38wMvIi2G41qjmOFUo+VwQr3A0pcYNyCRaa45vw79qac+FPVR+DFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UITveXB3IecJemRbOXRPmISdRN+7d717EyU+ydo3PDo=;
 b=W+3Zg2pJA4F1cpGftQ0xqGpI0rbk7Q9afvFZk0u5ONxeP/v+ttgCiAKWrpw+coFjbZslycb3arw/rSP+GF4SZZEevPucrVu8QfckU7Z6eBCS8DefBf4mbhxzFcNVOOM5JAejQS9jOWw8OPMQuSlwuXbldHMTCOdo9WWizieIzf6DPoKZRktBLrUpd/UHDJqXI9fVnGkbtMkw7jQhV0nLHO0m6EkGqTh7H8sbn2nWH+BDK1eq+ntepwwjOD/TpsgVSL9gQrAW8CLB4/SgmslZ0KGImJ1r9JX6vmz/KY6orlOHVLZZ0OkjCkN9BDdhfJDwyIfMrtQUGM6ol3dxE3GXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UITveXB3IecJemRbOXRPmISdRN+7d717EyU+ydo3PDo=;
 b=Z4dm7mSBaBwkvxLAExfkil6M5cczOuBj/LihGti4oHzpVs6dOzlUJZKEPJX7QJTLPZiRkBS4i+aeiayS68WMEOKBWdt7EbIu3HdhE+XZ048jtu66mySnianHcaAiN8xPsU4jMltOJQjsgX8R5RWsR2yrVkGPnqyi6SCh6LhHEFs=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 10:57:42 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 10:57:42 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v11 12/12] dmaengine: imx-sdma: add uart rom script
Thread-Topic: [PATCH v11 12/12] dmaengine: imx-sdma: add uart rom script
Thread-Index: AQHWYaaLudfuBadzJkOiFFLip7fdHqkxDZIAgAA3DiA=
Date:   Mon, 10 Aug 2020 10:57:42 +0000
Message-ID: <VE1PR04MB6638F057BC8F7F38E954316F89440@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
 <1595616685-9987-13-git-send-email-yibin.gong@nxp.com>
 <89946dc6-6c0f-b3d5-9c9a-517f1ed7b5e1@kontron.de>
In-Reply-To: <89946dc6-6c0f-b3d5-9c9a-517f1ed7b5e1@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb55b6dc-43e2-4a82-a3d0-08d83d1c34d9
x-ms-traffictypediagnostic: VE1PR04MB6702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB67029214CED716A19F51E42989440@VE1PR04MB6702.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AR1k3PmDnIbOkzT7h5+/hvofwFeB62A+mrm4tgme0/cOFExjn4pFX9Lu87/O7mZhskSvwkFpT5kzJFVSlkVSjhUHp0+TGikoO11PUj3nU2cA9LKSp74d00Q4Nkj/zhxiHtMuT4VmjYN5uUkj40bRM1e+MD51QCOpTmpk0cpAG93omybGnzuKYJBO6QJqDUZmhu6eCVRSDofF8eI8m/qXHrRQEqlJ7fmBj6jcQxHzQF0/iavUilmG2XOu++8734tk1wjiHCnuW5Xy9t13Z/IJAo28ppFq+2Z8/+gmP/BLnd9ZuKlKmDEwcaEnVT0dDCrxK837XJqqmhHrV3O4xX6f5Adn6xGbNbLEmHBs/ds3/t/shsKdIDSFzFH7jmygqT8z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(86362001)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(52536014)(5660300002)(2906002)(71200400001)(478600001)(54906003)(110136005)(186003)(33656002)(7416002)(26005)(316002)(9686003)(7696005)(55016002)(8676002)(53546011)(6506007)(8936002)(4326008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8V+Lh0dHriSmu4jKPiXLThyA85k5SJQP9TD+MoRhWQzesjXPLXoKbXpDKEWexH/jvb113TIQ29uYm1Q0Istm3wsM+bFdj0q9J783wdv752zNfXI2vEf854vRKvwTmYIpYoDkx5xr3kbWjiTYv6wDDcMYAXIADNkctzPQ5zkknYBdZXjSbPOy8YfS6CBT+p+SQNJyuxjeA/kw9LdNs2jhQA9NSB2Rz0LZTG0gwpkDPcE991elMWWTSIxlObviXqAV9aqd5/CqeNaqhApejabL+/yjd+TlPBfGNht4ZgsuCQXHQH1W2NNu/JLTf/kxonAIVC3M2jNLFXjAdT43oi+CXP1t9eH6cJ7DW0KG4zABHuYFv+YHCieNnBQvdKA5UBXWyXZXYXHF+a/TFGEvJz5sAf2nzVrwVmIcnhcF8MP4U8TdVEBv32hkQnfESR1k7gez5pdNGLZcDxQOpbrC1WWfWHCo7mEsdPDz3BVbEJC0uELjjGGCzqNPwttnoZEllGzl/G/gLvTwJ5LDnkLigaypP7wzlSdQeo18ICF1JIDY0GeoGAEEMcqKjuRwhWUERTNbWfAtqDJbIWwmqu7GKVW5ISSjizXL+7KplaAGmxgM0+FrM0JLYu9mvTZErwr2wRTkjZNtxxKa7Tu6cL8brRrz3w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb55b6dc-43e2-4a82-a3d0-08d83d1c34d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 10:57:42.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMv9ZoLEZhaZm45oVpUcS1psrYWjC2p1DqJO1g5WJ9X745/2NyWCIzRQO66gO2PF/R/8ozWxXgnE3tb2xsFYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wOC8xMCAxNTozMyBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+IHdyb3RlOg0KPiBIaSBSb2JpbiwNCj4gDQo+IFRoaXMgcGF0Y2ggc2VlbXMgdG8g
YnJlYWsgVUFSVCBETUEgaW4gY2FzZSB0aGUgUk9NIGZpcm13YXJlIGlzIHVzZWQuIEluIHRoYXQN
Cj4gY2FzZSBzZG1hLT5zY3JpcHRfbnVtYmVyIGlzIHNldCB0byBTRE1BX1NDUklQVF9BRERSU19B
UlJBWV9TSVpFX1YxLCBzbw0KPiB0aGUgUk9NIHNjcmlwdHMgYXQgdWFydF8yX21jdV9hZGRyIGFu
ZCB1YXJ0c2hfMl9tY3VfYWRkciB3aWxsIG5ldmVyIGJlDQo+IGFkZGVkIGluIHNkbWFfYWRkX3Nj
cmlwdHMoKSBhcyB0aGV5IGFyZSBub3cgbW92ZWQgYmV5b25kIHRoZSBWMSBtYXggaW5kZXguDQo+
IA0KPiBSZXZlcnRpbmcgdGhpcyBwYXRjaCBmaXhlcyBVQVJUIERNQSB3aXRoIFJPTSBmaXJtd2Fy
ZS4NCj4gQ2FuIHlvdSBwbGVhc2UgZmluZCBhIHdheSB0byBmaXggdGhpcyBvciBqdXN0IGRyb3Ag
dGhpcyBjaGFuZ2U/DQo+IA0KSGkgRnJpZWRlciwNCglUaGFua3MgZm9yIHlvdXIgcmVwb3J0LCBj
b3VsZCB5b3UgdHJ5IHdpdGggdGhlIGFkZGl0aW9uYWwgYmVsb3cgcGF0Y2g/DQpJZiB0aGF0IHdv
cmtzLCBJJ2xsIG1lcmdlIGl0IGludG8gbmV4dCB2ZXJzaW9uLg0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDU5MDBl
MzIuLjRkYjU1YjkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9k
cml2ZXJzL2RtYS9pbXgtc2RtYS5jDQpAQCAtMTc1NCw2ICsxNzU0LDE5IEBAIHN0YXRpYyB2b2lk
IHNkbWFfYWRkX3NjcmlwdHMoc3RydWN0IHNkbWFfZW5naW5lICpzZG1hLA0KICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgc2RtYS0+c2NyaXB0X251bWJlcjsgaSsrKQ0KICAgICAgICAgICAgICAgIGlm
IChhZGRyX2FycltpXSA+IDApDQogICAgICAgICAgICAgICAgICAgICAgICBzYWRkcl9hcnJbaV0g
PSBhZGRyX2FycltpXTsNCisNCisgICAgICAgLyoNCisgICAgICAgICogZ2V0IHVhcnRfMl9tY3Vf
YWRkci91YXJ0c2hfMl9tY3VfYWRkciByb20gc2NyaXB0IHNwZWNpYWxseSBiZWNhdXNlDQorICAg
ICAgICAqIHRoZXkgYXJlIG5vdyByZXBsYWNlZCBieSB1YXJ0XzJfbWN1X3JhbV9hZGRyL3VhcnRz
aF8yX21jdV9yYW1fYWRkcg0KKyAgICAgICAgKiB0byBiZSBjb21wYXRpYmxlIHdpdGggbGVnYWN5
IGZyZWVzY2FsL254cCBzZG1hIGZpcm13YXJlLCBhbmQgdGhleQ0KKyAgICAgICAgKiBhcmUgbG9j
YXRlZCBpbiB0aGUgYm90dG9tIHBhcnQgb2Ygc2RtYV9zY3JpcHRfc3RhcnRfYWRkcnMgd2hpY2gg
YXJlDQorICAgICAgICAqIGJleW9uZCB0aGUgU0RNQV9TQ1JJUFRfQUREUlNfQVJSQVlfU0laRV9W
MS4NCisgICAgICAgICovDQorICAgICAgIGlmIChhZGRyLT51YXJ0XzJfbWN1X2FkZHIpDQorICAg
ICAgICAgICAgICAgc2RtYS0+c2NyaXB0X2FkZHJzLT51YXJ0XzJfbWN1X2FkZHIgPSBhZGRyLT51
YXJ0XzJfbWN1X2FkZHI7DQorICAgICAgIGlmIChhZGRyLT51YXJ0c2hfMl9tY3VfYWRkcikNCisg
ICAgICAgICAgICAgICBzZG1hLT5zY3JpcHRfYWRkcnMtPnVhcnRzaF8yX21jdV9hZGRyID0gYWRk
ci0+dWFydHNoXzJfbWN1X2FkZHI7DQorDQogfQ0KDQoNCg==
