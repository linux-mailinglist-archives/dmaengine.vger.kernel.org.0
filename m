Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42CD0654
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 06:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfJIEJw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 00:09:52 -0400
Received: from mail-eopbgr1410107.outbound.protection.outlook.com ([40.107.141.107]:2236
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfJIEJw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Oct 2019 00:09:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQvpoZAr/2VcqUKbsory8f++FNhi238/VNykJ1yabhwp9lscexUo8UReMZFoatAcjXBYXXq2P1n9RKUQp6Bt7tsRypHSgBnuzFKTT0mpP10NtVCUJSbAt0EDtizj7Y4iumA9hbV1fhSmQstdGJIQ1kfv2jUGtQ5VlPXbCmRtGSK57Ma5L+rCBkmxTGHgNH1aWuR7WSh5cF8PF0SS6UpfmgynS7l3DJGR0m5P0A2gvc5j+ts4qigUn+tzZS50+w4abtKF2AAvgz+z5wOx3fDYFE7b/G3B3WOFZmf47ti1C+eOY36zT14mvqyfYebITHMqGK29oCQWF1WAXkQEuXXS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=l4tiyIb8Qiuwxi6v7XpX30VNXPorJN3PNX/uPfwsD0IEHnxZ4CnLCBlqwG6OVMfvLqbVMvCauI15TeCByoCH32Nrj9FJE+EKsH7uYdIHczVPzlv+VZXmwuB0J1hQ+xkgcQKv/oQlTVGO2Ha155H7Hi2L4rutljo5GMPtgzimU8DPD6iNlyDqqSedQZ30EVw0RXrqlsMNv/WYgQ7upPPNerlaXYDAWc9WQN1d7AR917w9I7shkU3EilkT9eogighMNTjck3XlzP1cFvsb7IPVD6f5vvTD9yx46ut9Nk2nvBVNcVk6efhv9G8P9qw1qd1QDeeTyH6iuQIYfDURTG36Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz3l2fM2QgycuiEQZxs/la0C6Ob2qDLFq2P+Kwr1DTs=;
 b=A/m1xoQQNRSwlXHFVaumRTkYN97wUZGYqLBzRK4Of+H2A8368SIt0S3cXtbkO9jzLg1O5ZJmDvuLwXAT7wp/FU5hAxq80j4UMobqRzOSNEVaWX66pUUDUqinpywUkInE6AKxz71P7gqqr+Xo21tv5oD8BE8DzdIgtncejldUFxQ=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2237.jpnprd01.prod.outlook.com (52.133.179.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 04:09:49 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 04:09:49 +0000
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
Subject: RE: [PATCH 05/10] dt-bindings: usb-xhci: Add r8a774b1 support
Thread-Topic: [PATCH 05/10] dt-bindings: usb-xhci: Add r8a774b1 support
Thread-Index: AQHVfcSwRLbwxwyZDU+veLzhgJkxSqdRstSA
Date:   Wed, 9 Oct 2019 04:09:49 +0000
Message-ID: <TYAPR01MB4544467450214C0A93307F14D8950@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570531132-21856-6-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1570531132-21856-6-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9e60e5f-0b80-4ab7-9f95-08d74c6e8705
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2237:|TYAPR01MB2237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB223703E571A3E2824DECC7FFD8950@TYAPR01MB2237.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(76176011)(6506007)(7696005)(6436002)(102836004)(229853002)(6116002)(74316002)(110136005)(186003)(3846002)(26005)(52536014)(99286004)(81156014)(81166006)(55016002)(8676002)(446003)(11346002)(66066001)(486006)(476003)(71190400001)(9686003)(8936002)(66556008)(6246003)(2906002)(558084003)(7416002)(86362001)(54906003)(64756008)(305945005)(66446008)(33656002)(478600001)(14454004)(25786009)(4326008)(5660300002)(7736002)(256004)(66476007)(316002)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2237;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RetRGqyW8i1yms3f1goIQUGfsAY/InAWQY4IfBlqrSgPrgFYZGCeN4ZqmPKnoyig6Ux55OKeAP+o8RwmJmYnkJ3b+zMe5SrdOOF3PHCRJqlp1++M4B4jNHn/SkHU1Iy9llBYSvUFTj65PY5YvAM1QPt2yQkBzsXzKKH0jWhErOtBwj8+BxP+G8tbVboeumbp/AI8K8nz0KVCaFMzVxKWTAmrMRVYSt0tZFq5Y3JwJKWGZiY0FviF2Uk5RDudwc0QgGCnes/aTeGklUf551m1c/br2e7Ugksgws33PC1sL1GO6tieI8CSlEvRDQpb1OGxeHDw5jXPmxH09VNFo4/gIqCIjEX8lAbQCrdc2FVFn1F0O+DfJUlDwT5CikXTmq1+LsE4lXA9qCGBircONPtsPjrBgf+Y+BzwEIoGvELMkIU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e60e5f-0b80-4ab7-9f95-08d74c6e8705
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 04:09:49.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZYnC4RUTDbhIbgHuvIxmym6WEc4zEJZVsvQqf50RpAw7Rh4L2DvGiMImoyro9XO6tfGpNH3qoZjJPMjMdjrBgGkm7ChTNsU1nqC2pk6O9Hb1uvmCoL0hPEbAsRh3qqJ
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

