Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DCD0647
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 06:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfJIEJm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 00:09:42 -0400
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:30956
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfJIEJm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Oct 2019 00:09:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS59mB5buoMRab0VCj9PBWMpmzXvgDKLyayG4s+P4lVB3R+VNPfwPm4ZBuwdvzTFi38R7QGyhOHxpoysQVLf38lkQW0r5mdtK4vdJTrC3DEllD4gt4dYMtSCqPaH7FTNRmAyhuAmdsj60guKOEZ8AtEkN4B8/fab8atSI8oG3WUnTCfgU9OuwohowLTPiTTTrAuZyFsFbOt1QpWYZI46X4DxslCDC1zVjboV9dQnTSHvdMMnJw+tq6wyfdrt+sApGp+na6nsMWuOCImcXFCtfXeUp+f9aF11G3VUH1ti7qO6obJpn/050IcqMMw4P0lAhVsHsVsPfyvKUU2hhGN9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=SJLPknlO3BMDutm0OwUfzCTRdG9rbmBzlWMdFiiCaLKkt5eBwSd7kI2DPw8/YXuGCHcgNnMQIWBDpiOzZb7NjeFdW1KLvas/s5aIWby7mgy4/8N8AuIgDM02TTEoaeIAEZxQxARP+b4UMKAJAT68dkgbFuCEbIaj2znfxJNL8JBa6lJ8NHRo0ePyS5msHQfM+kOXxV+lNvz+Tx4QIUlNhMQkXU8wCLKkd7/WPZWpx438BvRmYDYJg7sxXYFsfYGFWYg3xEYOVQxiUgOneaVhdUEK6+37rY4IzOz7rr68rpg9/1HnujbTcDCXaEm/x2FF7D219occgXWOR3h9l3VLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=Un/Vs57GTNNVfsIf/TocKw5Ow7H50v72DJcQiR9zgXtIAssh5qE0YXCNEiIvrY7B3Wr/WP9/xCuMznoN4OzYKQihkWWsnSiIhrmxXemR6Sora+lraYz+IbQJtl7uE6V5TlIT59W1Eq+Vvy/NNS6hXzTG4upm2liknwK+llTDXe4=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2237.jpnprd01.prod.outlook.com (52.133.179.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 04:09:39 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 04:09:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: RE: [PATCH 03/10] dt-bindings: usb: renesas_usbhs: Add r8a774b1
 support
Thread-Topic: [PATCH 03/10] dt-bindings: usb: renesas_usbhs: Add r8a774b1
 support
Thread-Index: AQHVfcSlVgQDELh9SE2jWCM0wJyF0qdRsj+w
Date:   Wed, 9 Oct 2019 04:09:38 +0000
Message-ID: <TYAPR01MB454435F23CF8E76F537B55D9D8950@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-4-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-4-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06d3f30b-9f37-419e-c502-08d74c6e8104
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2237:|TYAPR01MB2237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB22378C970336799FF2EFEBF4D8950@TYAPR01MB2237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(76176011)(6506007)(7696005)(6436002)(102836004)(229853002)(6116002)(74316002)(110136005)(186003)(3846002)(26005)(52536014)(99286004)(81156014)(81166006)(55016002)(8676002)(446003)(11346002)(66066001)(486006)(476003)(71190400001)(9686003)(8936002)(66556008)(6246003)(2906002)(558084003)(7416002)(86362001)(54906003)(64756008)(305945005)(66446008)(33656002)(478600001)(14454004)(25786009)(4326008)(5660300002)(7736002)(256004)(66476007)(316002)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2237;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2TEvCFhJ0SYuI4mEi+voKS+gJsEGNNlsNfIEKYFuhSM/CwuOZ46P7ga2A3yaIM6x29A82ESZHEI2ZWpVMc8HaR0YoI8PgAHolB40UE4ffdzrMIPVv/ZThOuV675P9wABkkdK1pxSRjsLEnQnFEo0dKUBMsLi3lXjAOtRrVk0lNw1QbshLQLd//Qw+/o3PU99ttrR/U0JSc4BN1ysN4N3aESW4GQ+nMKiGmzaOm28GFY+6+o9xpRxWP+xbce3J7ECKNjVDP5Ya4wsvBqwhO8RgrS2hYGBRtLEEsE+VA9qNX3LGMFA8Z8huf0H7siLyXXbUnblnVro8aBn2Cc5Q0ZlOdxV8xxFEtbj4k0SbIt1KWZsk/qrVw1tshSTU6D6ysYR319KYGEiA+3D9XIb/b1WerSGX6a0dYl4B8GTDNzhd4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d3f30b-9f37-419e-c502-08d74c6e8104
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 04:09:38.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Mw77bEcQLUfnsSfnQeiH1I8UZI2JhopH+PAcm6kGJ9fcVLZR/KLhjZ543KSisIGwUsiatM8yGulgj2WM+d7si88hVq9W4eossDb52k77bTSHoYrJo06fG52aXxEjAkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2237
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fabrizio-san,

> From: Fabrizio Castro, Sent: Tuesday, October 8, 2019 7:39 PM
>=20
> Document RZ/G2N (R8A774B1) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

