Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0217B1ABA3C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439506AbgDPHrc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 03:47:32 -0400
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:51296
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439413AbgDPHr3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Apr 2020 03:47:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MciERkZz/9YRAr5XeIRCDux40ur0UeLT8grayums8TkdERqjM179k+Q57x8CqcwG0CT6rGEfQNuLCsPCrq6gg+xtMSoNEEt54lrN+KDL4IN8obt5hndGndAgMnPeIJRXQdIibjVj2JkjG/j2HBZSe3qkkyMppMqOoELpRqcPo7Wmi6F7RB0tJc+tqMwpHfUHwlJnFyKVtcY8Zj3qfT4L60340GYvFGV4aRMzDK4aTw4t5YpE1AAnKr0q7g27CsVU+CW2Q2yvnksFtfMuMa/3BeOUknxzkfykap+5UX3535psHFCIdUSF3V9I2LTskWMx5XE3yabMesG56P1Fjb3Anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHpHc4IRH6XjYGb4oICAeqFCRcgVZnm8yi5G4Norpec=;
 b=lyRmg7kH2Fr4QNNqGDrJ+XQI1cv9UgY6NraFajLqOsTy2oZ6FlXFgByQDWhJmeM9P8zx8E6lQaK5v8LF9FJwUP34Cn7+uteYZ4Qzx5PweDsEPjpsW2v7uL2ObNd2oc/02wSQ1FasV4vdiuEMVNSKEmRyGgDSR+tBWnEL8yzZ8pepDiXJxtvRsrL8BxOlOHjQVibg454JxPRwM6kVHyTp2IIkGH/ODnnCo8wBOCA6HXKbDRUwgTCwUtPSuFrSSnw1vRjjhkzpECYYA6EdKTQR+IO5PFkeIjcJdpumcUqxf+w43Ja3G2pH06i8Q6dTvwNFFyp+99rHNYdZCPx48e4v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHpHc4IRH6XjYGb4oICAeqFCRcgVZnm8yi5G4Norpec=;
 b=mRgeM9vvqsO059VHKOiJ0ol8WAMxtdNL+TkAdOHdDCzagstVwx/tNuRTjQj2DvkMWACfG8l4iTV5xKzqckN93pFDv4cf+lh1SjIFs9AZ9NCWyn3MI0bcfR/hdGEwkpGp0G4MwMhNh9YgPsD7ju3MWxb1LTPFj2i4p8Jg6qPbFPA=
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com (20.179.176.20) by
 OSAPR01MB4242.jpnprd01.prod.outlook.com (20.178.102.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Thu, 16 Apr 2020 07:47:22 +0000
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad]) by OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad%7]) with mapi id 15.20.2878.023; Thu, 16 Apr 2020
 07:47:22 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: dma: renesas,rcar-dmac: convert bindings
 to json-schema
Thread-Topic: [PATCH 1/2] dt-bindings: dma: renesas,rcar-dmac: convert
 bindings to json-schema
Thread-Index: AQHWDx8gfAei1qnt90WjEN4QnCOb0ah6MAqAgAE3OoA=
Date:   Thu, 16 Apr 2020 07:47:22 +0000
Message-ID: <OSAPR01MB45298EA0A9AC1EFD86B54FD5D8D80@OSAPR01MB4529.jpnprd01.prod.outlook.com>
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdULExMNnKJWsjAonR1sVeTyQCH0shwO--Wo6dLzrWV_tQ@mail.gmail.com>
In-Reply-To: <CAMuHMdULExMNnKJWsjAonR1sVeTyQCH0shwO--Wo6dLzrWV_tQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 468ccaf7-5adb-4c61-61b8-08d7e1da65df
x-ms-traffictypediagnostic: OSAPR01MB4242:
x-microsoft-antispam-prvs: <OSAPR01MB42427C77F14297E082D2E4C3D8D80@OSAPR01MB4242.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4529.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(55236004)(76116006)(55016002)(186003)(64756008)(7696005)(8676002)(66556008)(52536014)(81156014)(8936002)(6916009)(66476007)(6506007)(26005)(478600001)(5660300002)(66946007)(66446008)(966005)(9686003)(54906003)(86362001)(71200400001)(4326008)(33656002)(316002)(2906002)(142933001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3rav4FKayNkXQ/bBg4hXiw4SkOsBo+eVF9Nv5VDFpdcuTdiH1QjR49k6jdrg6qBPJzW65KrYC0BEy0Kl0LgvcLyskVfgboQzJ8/u/GF0P0+OLOFqhSWTSzXh9swCv+XKUTXhFL/MdQKSuCyC2ACzifB3gW8c6G58EU9+w5hr4B45puojdOCRCTaHaYNlwraxv9BNH+6UvLkBFMUVPFTvYRgUvFVppttbH8zfuD3DoZeIwkO2RnR6R+gBEIJBj3y+cKX3KUb22lmvBgQX5hYDFO+JqskZ7TsxEkqGQ9AFgYsk+hyyvexvm4/PLZtjuhVRbPUzu/fhMCVyOpw+x/bK12OD7hSRl5wo8x2b0m8kVEGutJmmZWI+R1HtOqORZCBC+peXUDy83jiA62hHxmv3jU0VwVwQZCCYdpY2p4TyaPbduEa9RF2OflWv4BdVOukRjQKOU8kXHVFro9dwl3pMZmUDprfxxDdrPPzxmNELdeb5a0ZKsdCMVxW9EgeVSc6ArJhBl2MwaPt2HKu/kSjjGe8lC0aTQcnW06+d+LTa42voau1R8+mzYikrPfHlTdb
x-ms-exchange-antispam-messagedata: erLxxpeC4KPa7SeDjKUEnt9j4PpE/2KW7wsbPFAqFFKA+onLHfHG5K7OjNbjxrA2yG3RpH88Xrm0XK9KNJioJv8LWUZRc/vpaF+YlaUo6GbGluE3Cte1enRI2Y78xcvIseJmvYvpO7+mJ0MgUuMMxA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468ccaf7-5adb-4c61-61b8-08d7e1da65df
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 07:47:22.2414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9QF9PzAgxW6+AB/KVz4tPnx94g4R35U+FQnE6e4b+8zHkCTET0HmoGt1DJp2vq6UjTGk+LRk1I9Z5Kjos2nGdnM5jjUPpHMWg1AGUT83xu12eB+gs2FtuJ34VY9VY04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4242
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEZyb206IEdl
ZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxNSwgMjAyMCAxMDoxMCBQ
TQ0KPHNuaXA+DQo+ID4gKyAgaW50ZXJydXB0LW5hbWVzOg0KPiA+ICsgICAgbWluSXRlbXM6IDkN
Cj4gPiArICAgIG1heEl0ZW1zOiAxNw0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29u
c3Q6IGVycm9yDQo+ID4gKyAgICAgIC0gcGF0dGVybjogIl5jaChbMC05XXwxWzAtNV0pJCINCj4g
PiArICAgICAgLSBwYXR0ZXJuOiAiXmNoKFswLTldfDFbMC01XSkkIg0KPiA+ICsgICAgICAtIHBh
dHRlcm46ICJeY2goWzAtOV18MVswLTVdKSQiDQo+ID4gKyAgICAgIC0gcGF0dGVybjogIl5jaChb
MC05XXwxWzAtNV0pJCINCj4gPiArICAgICAgLSBwYXR0ZXJuOiAiXmNoKFswLTldfDFbMC01XSkk
Ig0KPiA+ICsgICAgICAtIHBhdHRlcm46ICJeY2goWzAtOV18MVswLTVdKSQiDQo+ID4gKyAgICAg
IC0gcGF0dGVybjogIl5jaChbMC05XXwxWzAtNV0pJCINCj4gPiArICAgICAgLSBwYXR0ZXJuOiAi
XmNoKFswLTldfDFbMC01XSkkIg0KPiA+ICsgICAgICAtIHBhdHRlcm46ICJeY2goWzAtOV18MVsw
LTVdKSQiDQo+ID4gKyAgICAgIC0gcGF0dGVybjogIl5jaChbMC05XXwxWzAtNV0pJCINCj4gPiAr
ICAgICAgLSBwYXR0ZXJuOiAiXmNoKFswLTldfDFbMC01XSkkIg0KPiA+ICsgICAgICAtIHBhdHRl
cm46ICJeY2goWzAtOV18MVswLTVdKSQiDQo+ID4gKyAgICAgIC0gcGF0dGVybjogIl5jaChbMC05
XXwxWzAtNV0pJCINCj4gPiArICAgICAgLSBwYXR0ZXJuOiAiXmNoKFswLTldfDFbMC01XSkkIg0K
PiA+ICsgICAgICAtIHBhdHRlcm46ICJeY2goWzAtOV18MVswLTVdKSQiDQo+ID4gKyAgICAgIC0g
cGF0dGVybjogIl5jaChbMC05XXwxWzAtNV0pJCINCj4gDQo+IFdvdWxkIGl0IG1ha2Ugc2Vuc2Ug
dG8ganVzdCBwdXQgdGhlIGFjdHVhbCBuYW1lcyBoZXJlPw0KPiANCj4gICAgIC0gY29uc3Q6IGVy
cm9yDQo+ICAgICAtIGNvbnN0OiBjaDANCj4gICAgIC0gY29uc3Q6IGNoMQ0KPiAgICAgICBbLi4u
XQ0KPiAgICAgLSBjb25zdDogY2ggMTUNCg0KUm9iIHN1Z2dlc3RlZCB1c2luZyBwYXR0ZXJuIG9u
IG90aGVyIHBhdGNoOg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvMi8xOS83MjANCg0KU28s
IEknbSB0aGlua2luZyB1c2luZyBwYXR0ZXJuIGlzIGJldHRlci4NCg0KQmVzdCByZWdhcmRzLA0K
WW9zaGloaXJvIFNoaW1vZGENCg0K
