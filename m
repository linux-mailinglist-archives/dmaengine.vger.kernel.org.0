Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC27AD0656
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 06:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfJIEJ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 00:09:57 -0400
Received: from mail-eopbgr1410113.outbound.protection.outlook.com ([40.107.141.113]:38341
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfJIEJ4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Oct 2019 00:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpk2lJufoqiDdTktcNrefJRmpVOZ15fTlEHStPavrG9IP/Z1jQ0cXCaX1L6RFyDT89rH5Rm5Vc4qGHWsTZYjwIJF7ZHfd5r9TboZv/eNx4QSICfTNZWkS7GaA89DEdccU4F8ES0DtBzmV+eDWmTImvTg5MYZZqovuKe4IqsU5EmhTLfR1JVKjrlTzHx07FXi7AJDLYyABbnTEJCRJ4u5PxfjQRzAR0ayi/gxEpYMFBahnjG5Ftz993lnqEhtDSTqbakCWjX3KuKjw572PtQVHib67JAEWppq2WP7pcIOn8G90+u2944ZeKRIah+PH2f1lMWLuw8kH2OyLjXbbhO24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=ZWT7qHVvviQM5JKJL+hZp3qvcW+l9U3P1FPlZQfI+mUTdKH3cuG9dj17LbdE2rAV1nxaIKD8BMv8R0A9o5x+9/cZNOTbIqMmY4dlsq77ojpCkhf/tLg1YbtBotiYwIProeCNhevrbvY2hFNNTJ+WK0R1XeF+fT2SJR+fCotbrPu/d6coFWT4nqfCsf2JP2uIR1OLGxgxM+tTXXTMVMSBgfmQvR/D8yEVKhrNksxnoSky/7/E1U2fioIYfkYerwj1UY3Y0XHCD1WHW8wIT1tapp2ZI+pUgtmD6Q0Z3tUTk8o11nlRU3g/6tmnXu9FruZB8xxkqbsYE+sfblDeH1hG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=az7YaK0gn/ULVPm/RaxliMzug/3j9gf7Naz6jShzlLGKZBJhSnobCg9XAqYJqns4eg2Id0dG9H8BRkUB5dUZbX1WQqYab+aJ32bhPJxIFGeiiTNjN4c6/zDUjRqUFLuoaosvF0AacPH3mUPNYnAHAB1MbVN789/d8Sx7IJsM+P4=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2237.jpnprd01.prod.outlook.com (52.133.179.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 04:09:53 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 04:09:53 +0000
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
Subject: RE: [PATCH 06/10] dt-bindings: usb: renesas_usb3: Document r8a774b1
 support
Thread-Topic: [PATCH 06/10] dt-bindings: usb: renesas_usb3: Document r8a774b1
 support
Thread-Index: AQHVfcTCct8OG+iTDEqU+YRjWkAxSqdRsvFQ
Date:   Wed, 9 Oct 2019 04:09:53 +0000
Message-ID: <TYAPR01MB45441AF12A4539B145539856D8950@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-7-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-7-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ef780c1-69f9-4ea7-8ca5-08d74c6e897f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2237:|TYAPR01MB2237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2237C3A03F3051C89F009753D8950@TYAPR01MB2237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(76176011)(6506007)(7696005)(6436002)(102836004)(229853002)(6116002)(74316002)(110136005)(186003)(3846002)(26005)(52536014)(99286004)(81156014)(81166006)(55016002)(8676002)(446003)(11346002)(66066001)(486006)(476003)(71190400001)(9686003)(8936002)(66556008)(6246003)(2906002)(558084003)(7416002)(86362001)(54906003)(64756008)(305945005)(66446008)(33656002)(478600001)(14454004)(25786009)(4326008)(5660300002)(7736002)(256004)(66476007)(316002)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2237;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fn7ZRWyLsuO/aqA0K2jboJs1ly//3bFNd2CMA6st+O0+QHAFGKyy20bUJtFMO/CwLjhJFL3CdFGBs5IlNN83tUD01bageNHyzsl3ennAlW2BmMk+2fZw1BiVlGCh7TSjLK6B+ZPz+fy77g4Vkhh9QhHsHJcsAcK4X2kSw0S7tHttw4goN0ibzTd9Z5545cd8g4nSH6K/131Xaa1e0N1MPBIGcvJI8M1ba1U7zhH3iasb2NhxfU8HiyIC1oAA9tEdz/EJOXPyrp2IisgNc0YEHY2gOKfmDzquv06babw2dpHOxXN2DgcpoDD5QXk/7VTxZ2ky/toXzRRYZePSu2VxU1UAx4m4O8BCLv5K9H8uoC7H1Mw39d51TnP+NvqAryNF/zdwbJZN/IGOMoj5/LxmMHIGAz4HBEG0PKTl9MUVL4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef780c1-69f9-4ea7-8ca5-08d74c6e897f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 04:09:53.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0bzcilbmYA4STIXHQG3ib3UgJNSeyj8TJg+fYC0ZYw9zILg3bZtj7X7aZPYq93rg6dY/bVUwiwvlrjItycXrkWm+z3OMCYtYB/PNSy5RbkU3FhpFFUeEtGYK4/XESJG
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

