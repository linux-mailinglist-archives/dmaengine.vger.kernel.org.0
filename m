Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1279B3087C2
	for <lists+dmaengine@lfdr.de>; Fri, 29 Jan 2021 11:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhA2KSp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Jan 2021 05:18:45 -0500
Received: from mail-eopbgr1310129.outbound.protection.outlook.com ([40.107.131.129]:20787
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232210AbhA2KMS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 Jan 2021 05:12:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3m/kLttjIJCC65dm/FAsncauVp4c8ln1LCxDTIwiK0/bo2SLBKAS+6BUh2Zer/Pqgx+KUMAfFv7TqAV+wBd3dBd/8D+Yt6pBlixKPy7olLQQPsQRsb7jpI5wp+JpIyOjbHQ/kRv5V2dc7zXRYzcAsg2hlwgeYmOmehb9r9lwsL7d7+x6BOPn9PTJ7pkNkwYrGuu6EEKDHC/UfEQnn/TZMNnA+LGMBipADDLF0jZGXZiaF9Y1faE8hjA1PpyGIwQ4WdFgleNDLfe8jgL4QJvsDCdyiV785znX3+1qeFcJ5q1yxly2JPjyLhWeodHH2JKkEHqZNQvMbVD2IRBLHDfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG0MeaX754ylcBTMfCuw2wycvMGEtvqNuVaAUxY0QqU=;
 b=TswkJ9oH/T4vL2G1AP31+vWWm6TvbecicXQ0lU5JoPdL7lK2vVcYj2FFSykLZkpOV1wXTNPRN59iC4VFh0xoRi4Gw6zZGoxPOTII2PMI9P6Wr4s1/hI5QsZxFDEdNwKd24pYM63DBTEzmj52CSWJiYUnGxG3eIacdOpoT4+O1USHpC25nYvZnWwRm5WcXP2udwlcXfB49YAS/LTYO3Krc/4TGnuNHFCS4ZFNOLDfa8Nk6ZJMEEa52h9oK9dY9kksk6rJ0d+eQQvgLTRD7lTkxAD4qN185iE5iG5EzMtgbPOV4gp9Bl+4fo8rFo+7jMBYZrn8Sn0OUsd1DQkKnC+aqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG0MeaX754ylcBTMfCuw2wycvMGEtvqNuVaAUxY0QqU=;
 b=myuvguhp2mDLaaJX4mcGQxdto28/rpKf3sEsSO8/2np6mA8+JEqw333r35elXs3Z0mFX7pzcmI/BA46Ehkgm9MtX/jhHjF34/Ba4Bc3U/BvJV+sLv9vjovTZ9XyxK5hXsohGlBq4e8iX8SBBm4oXIFQqTxeCPibvCbm6TceWDZg=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB3292.jpnprd01.prod.outlook.com (2603:1096:404:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Fri, 29 Jan
 2021 08:40:07 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2023:7ed1:37c3:8037]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::2023:7ed1:37c3:8037%5]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 08:40:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Thread-Topic: [PATCH v3 0/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Thread-Index: AQHW9VHfqcNv1txhjU+jKY2vOCaCOKo+SYlg
Date:   Fri, 29 Jan 2021 08:40:07 +0000
Message-ID: <TY2PR01MB3692DFF3B6E414A901ABF30FD8B99@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210128084455.2237256-1-geert+renesas@glider.be>
In-Reply-To: <20210128084455.2237256-1-geert+renesas@glider.be>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: glider.be; dkim=none (message not signed)
 header.d=none;glider.be; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:e04a:64b2:db4e:d452]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc142555-f855-43b5-08bb-08d8c4317b74
x-ms-traffictypediagnostic: TY2PR01MB3292:
x-microsoft-antispam-prvs: <TY2PR01MB329246923D9F05A48B01035DD8B99@TY2PR01MB3292.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddSwKfAtx2tRjMdOGt9RI/Tra85cr08y0NQtGrz9SwpbjXgbwpYrw1bEbsg2c95E5MW4oi+zwwyx7tyiir9TiL5VCoVcgWuDsNqniGmQrFqkCdqqMAuUegp2zjJjukNb9hCVs/9YR+9YdZhYy0iCTbW32PU8OVCvqdEaaiUVdbJQzRE1lYDQBanyHPqJ4XOfi4B17OyyrtCljUMUZltF0dOsbLsY65FmuJJnkqHA3izzUgPuQYtOnqyAJZOpv+Dm1lS+EGgnvX4fPFeM5hLkmI9+YwzDd7PYWEkLvhlb04fw6Z+CTIVXy17tOFwGUL2dJiSCDFPGXeDDcqZV8T3GOzZLIf1mS1cC+6uqH4f1SxPfMUbHybj/Czq8VQJO0Yl91flkRPfBZnk6k5ngFxZdvsj01z4ezJOof5AVZQODty+g+mSluTwdvOD/0lUb0ZkAFiH/ew+xNZ+T9njfppSX0OYzI536Vlmp5fPIx3YuATOa3ljUnYvmpZtNGwW429dYjntnGH6gkw9ADMd4CAtENg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(5660300002)(52536014)(316002)(478600001)(71200400001)(54906003)(110136005)(8936002)(55016002)(33656002)(7696005)(83380400001)(66476007)(6506007)(86362001)(4326008)(9686003)(66946007)(76116006)(7416002)(66556008)(64756008)(186003)(66446008)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fhJbXLHgI/d8grC11v2P6jCw7UZ9nIBAvw2oEgRDhgBFXWrPO+gggfAC2e2V?=
 =?us-ascii?Q?wMZ3C0U1oVfn6UdTO1Ygi1sJhBUQM5xCQh3NwOsWhXvY8ablExjKonq4LJhY?=
 =?us-ascii?Q?mwBa5C5KQCaIFBb6CVUN1PvnNrEfLkvsVmpqWo8oR+Se0aVUlpf0mtvdW2DV?=
 =?us-ascii?Q?bJ7o/deXyMjt2zI3jR+Cl33BmIIZeozSa1l97IEBqnf1J5WIGSwWxzsb/hBQ?=
 =?us-ascii?Q?cnkbKF7Zj2W0l3l3NU3tRfJ0smrLrfC3hIoRzd4zkV6QPij5Bsa1ueALsKdB?=
 =?us-ascii?Q?nRI7O6Qw+N10Zyp2PDfTd8Uucgrr0FgpnMqgxSLRQl6MAiAOCOlq8FI+ADry?=
 =?us-ascii?Q?q199GrVYO0Lg+DvIn7/U8w+Rf0QP/uJOwxnR47v+hxcaKdEvKJjVdKAarH4A?=
 =?us-ascii?Q?KRj8/y8Jdkf5Yi1EypdsolnecQM/41cTCfQE2gE5RA3pOvcKVXWgYHSGEmzl?=
 =?us-ascii?Q?67cMywLx+24hWZUM3GFfKtnyYqjbAlpg4d/e4krjrDRXsfA0CTjMb2oTG1JV?=
 =?us-ascii?Q?ByxyvpygjzdifH9ysV5wiMsoH4R96WdDvvLuJ9XHEEHmDws97AJCNdRhcd6t?=
 =?us-ascii?Q?0KcS/WJHy986yciujM561QppmsTnyzyFLFYGxkAoMKO64AsOZZmhqo2N/u3w?=
 =?us-ascii?Q?ObQO0PQinIxe8z68O+br8CscqRyIqoDt6x80QU1FALZKlZnxxBx6lMT+aVnE?=
 =?us-ascii?Q?tqVvttonuGLS3hnTUorDmaEZfyxl86i70AMQjKP9xJqdjG+t+MH6E1NaxMTb?=
 =?us-ascii?Q?2AmYA45DadzYrOe0FO7GA2z62cPMVx8DfL8Y0Yh79uKKXEXVGIS0PSiASE6l?=
 =?us-ascii?Q?p68/IXZNcWsbaAFXAQXeUzt+VF6N/DfL5CBQ9f7Z1JPPMbPK1ie6MEqxxHog?=
 =?us-ascii?Q?rWlcAXjEGk0oEPTCocgCjbtKnCr/kAI5u1Mcl35T0v7MdWSqBIPrko4tJ9fy?=
 =?us-ascii?Q?3R8+v8q/pbuncfivKZwJ7HwICcOWoQAhZTUtn4+Zh+JcsZBEJ8ph+xgSMO0E?=
 =?us-ascii?Q?iiMQwJuoCgIa4e4bH6pDhbXUQb2XK+oVo4p6gsqD7JNMdroMvdzO4JIXDtDz?=
 =?us-ascii?Q?vr0yr8/4Rl7iPcLas2eom4VU7MFNyrIm6vYuK7Kk5tP2LkYlcbM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc142555-f855-43b5-08bb-08d8c4317b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 08:40:07.2840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGDGo/pA4T3EoHA/H0GXl6ZeM6FWwLYRS+8apzf87gZb/wlAiJw3R1p9wScglrzhNdY6+njHzEDLYVu58iKsSK4E/1myO58/M2kNdQqCv/0WZARhFzifc+YhcHGHLHMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3292
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Thursday, January 28, 2021 5:45 PM
>=20
> 	Hi Vinod,
>=20
> This patch series adds support for the Direct Memory Access Controller
> variant in the Renesas R-Car V3U (R8A779A0) SoC, to both DT bindings and
> driver.
>=20
> Changes compared to v2:
>   - Add Reviewed-by, Tested-by,
>   - Place iterator after container being iterated,
>   - Stop passing index to rcar_dmac_chan_probe().
>=20
> Changes compared to v1:
>   - Add Reviewed-by,
>   - Put the full loop control of for_each_rcar_dmac_chan() on a single
>     line, to improve readability,
>   - Use two separate named regions instead of array,
>   - Drop rcar_dmac_of_data.chan_reg_block, check for
>     !rcar_dmac_of_data.chan_offset_base instead,
>   - Precalculate chan_base in rcar_dmac_probe().
>=20
> This has been tested on the Renesas Falcon board, using external SPI
> loopback (spi-loopback-test) on MSIOF1 and MSIOF2.

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Also, I tested on H3 Salvator-XS and the Falcon board with dmatest driver.
So,

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

