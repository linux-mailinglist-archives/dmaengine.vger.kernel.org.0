Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987B7D063C
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 06:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbfJIEJd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 00:09:33 -0400
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:22688
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfJIEJd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Oct 2019 00:09:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtJr+rymjHjUTZ6siolz3DkYIhH/F2cgsVame1ae5M/kibnVrcbiWWn+NadLNujB8C5LBrgi0W+pDsuAFFoRYUkcJhkuMJPetWC41pKpPZa5wzVtowtIuvxJYYR78lYWQUAgbl2+VJeKz3BQ0QpKyejKZJBGBHw2Uudzody/vQI3E1hGBU0Ua0GOLK8ZC6806vk2n7nS96eMtSnIAdC/xKp9VLKN0NSlps3PWpO63L6mzE2R95c8p8bFgIwR8HynTZuJ+rta5QGs/GHlI0PJAUpm9smaP4makp4nLx+51yDxBXEeFLkX1D7FT1Ahkh+vdAMYVk6llCl42hKej6bMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwiOPyrEhBKq7IB9tEuieRNt1GZrhZgE1br/VXwx8Vo=;
 b=RTVaZXAiBOeXwVxBM17XOZlLamkhEPmrxdSkzLMLVk0LLrXe1q117bVoI+O6eYDQn21Lxa1lLB3EbQzdT+z5E3KeoEPqqOCP/cR88cUlUpyU4yRZUxz+iN4pbxkc94opvhYeSLd6r0w/fv9E9Z5hGOx7BFOAtqbUTrVHAZ0Jp99/9u9mXd74fB+FG7ASxL9SH+U7RczaZBQU1pX2jcJIFBCE3qFVdNCU50FwYHaXMfq/LJCN+RZsv2PF/I9EBtKpAm7IgoawvrZ5Vwaq01pJjFSuRfEzcqtX8fCStFNqNvfQQUpLwKp6UrPlYbmeM0813iiKAfEpyKAlhEaNM/MyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwiOPyrEhBKq7IB9tEuieRNt1GZrhZgE1br/VXwx8Vo=;
 b=Q4IIZiwPEAWZVHN8G3YF4GYq5qzYGHtlm3NSog8dxplwYfjuqL6n8mZcE2nwTSHO6FbuIyatyFC1UxkdkZzA8s7pw2F7mIbvhtekOYjPDBdfG19OatLYW5QFTuc9QZZjNAt6wxtFXwqSTgsXo56nGlJ6G3atblUqKxGGW6pVFv0=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2237.jpnprd01.prod.outlook.com (52.133.179.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 04:09:28 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 04:09:28 +0000
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
Subject: RE: [PATCH 01/10] dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1
 support
Thread-Topic: [PATCH 01/10] dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1
 support
Thread-Index: AQHVfcSiLMY4E/HyTUKK19o335ogFqdRsZfA
Date:   Wed, 9 Oct 2019 04:09:28 +0000
Message-ID: <TYAPR01MB45446960D3BB80ADF3D90941D8950@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-2-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15ebd193-edd9-425c-1e2f-08d74c6e7a9f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2237:|TYAPR01MB2237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB2237F8E330DF2AB3100A956DD8950@TYAPR01MB2237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(76176011)(6506007)(7696005)(6436002)(102836004)(229853002)(6116002)(74316002)(110136005)(186003)(3846002)(26005)(52536014)(99286004)(81156014)(81166006)(55016002)(8676002)(446003)(11346002)(66066001)(486006)(476003)(71190400001)(9686003)(8936002)(66556008)(6246003)(2906002)(558084003)(7416002)(86362001)(54906003)(64756008)(305945005)(66446008)(33656002)(478600001)(14454004)(25786009)(4326008)(5660300002)(7736002)(256004)(66476007)(316002)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2237;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkIwPeEhwnbHR/043ztWrT9E6yrn/UBBCMRTtwovcQIJbfxOq1rqLk2Ad0TvMB7bPK6pUFTiOzSGeKpogSWW4pXxhDpOANiSc+PUlpI3CoPOY1s55C+v74VWr2Ew/B2WQ45j/gQq0Jm+a5mS/YvG7gUvPSEh76Ipcxrqsy8qL3zG2AdVsLHUumSDCukeKxB7DveqTtjbJdDFTMEeSyWnmNJeztcaGXt28QSk/yNpJYa1D+a/St/OIgZcb7GujM5xJMJPAUahQ1ehNpUSg06dFAF4kl6BHg7JSqIEtd+rUVVL2k8GPMH3e6feXDuY2Z5S1ZOgGuZxMg0bKYuma8py7XsMiQGSWWYF+DktpoKNq50UiBv9QylLy7NJLsHndcPmS3G+YAItaHrUKUEJNC4MPRZ/PWKKpN0Fl67XS5vN72o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ebd193-edd9-425c-1e2f-08d74c6e7a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 04:09:28.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlM2rjHEG3H60m25vf/tXWW8xNpj1aIVE0PTBHfkwJcQWd0+xMvUbJslyyonqEwAsUKrWifKWcUqJuxuLnND+r8atcZvtWW6TJ9q1W+CF9LCKL8NtLi39Noqv8q7j0dy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2237
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Fabrizio-san,

> From: Fabrizio Castro, Sent: Tuesday, October 8, 2019 7:39 PM
> Document RZ/G2N (R8A774B1) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

