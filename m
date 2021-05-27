Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E2393416
	for <lists+dmaengine@lfdr.de>; Thu, 27 May 2021 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhE0Qhd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 May 2021 12:37:33 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:59938
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234779AbhE0Qhc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 27 May 2021 12:37:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiJ9DMWeny1Y1SgxIdJ0RCZgSnSdFvbaaprQLUvI1oLEgv6m2KSlKoiqmCtB6JOxPes19y1HhXGPlsSEaky7bQd8YAnwRUd63C8vPBrG5n8AM8xBg+8wnxB9OyZFUzqCdhZBlexzwmfVkiaKmKASFMYOf0j3oCpecjk7pUvn+T5pyN0vuPiqp4XYxutoDDdeWurzgB7IkGTCIhOwYZZrVjfMDVM2tIC0S7yFb1CpY3FvmaarNy+eYAig1t4pAIuhHYq6ZY88V3a8YT1lrixesK5qfjzymyQc7HmBCK86tlokCDRN/ZcMie1pBY9AHJG3luC9fqHyVNjam6A1u+d4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpbbRXJxikposfpW9roHLFX2Zscqs3BECYDHkm08EV8=;
 b=HLZZ6TiHfXknIAJeOYnUUCK/kH28/ElzzPOHdA/dhtTiBlRRAnaoxIK1oG2xAjqi7W0HnO6m7DSFIHk+rb6N+hulLIHU73Wn1qzi20q3BGcnZFKA/mHBMO8A+/JIDD4LYbE/wlos1l490daeGvLIQTYNYGxZpDgK0gd+HpSoA4W+e9v11mXQ9mEZedWE1dlUOCQpKsMF2Z6MTpXN3NZF29YbL8HUMRbQQE+6sLIq58HE+6Wwc58knhvjGjfZsSwHYnmMO2ozlzFkMLcW7OrxxC3qIEPcs8j/6stw0KGkZfUano8fNGFWH/MCI6l+FTcczxqzC+f+o0v0u72ddEWUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpbbRXJxikposfpW9roHLFX2Zscqs3BECYDHkm08EV8=;
 b=AheWQsRkZpNTRmc50Te8h4S4LGSw60igCawyoSFN15ZeKlQlt63iswoWKTITaagLkkqLlYzG4bkDlScdh9KKqmHsIm5Xsziaozv/LTAmIS6YyPrUyANx1asncwVerXtvCCmaJfPSurYYH9HO6HBergiATPbMfE7NJtGFRzeyhwo=
Received: from BYAPR02MB4535.namprd02.prod.outlook.com (2603:10b6:a03:14::16)
 by BY5PR02MB6834.namprd02.prod.outlook.com (2603:10b6:a03:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 16:35:57 +0000
Received: from BYAPR02MB4535.namprd02.prod.outlook.com
 ([fe80::798a:95d4:7245:7bd8]) by BYAPR02MB4535.namprd02.prod.outlook.com
 ([fe80::798a:95d4:7245:7bd8%7]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 16:35:57 +0000
From:   Jianqiang Chen <jianqian@xilinx.com>
To:     'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/4] dmaengine: xilinx: dpdma: Fix freeze after 64k frames
Thread-Topic: [PATCH 0/4] dmaengine: xilinx: dpdma: Fix freeze after 64k
 frames
Thread-Index: AQHXTYw5rPfZt2ti3E+ZF2FpqblCjar3kXIw
Date:   Thu, 27 May 2021 16:35:57 +0000
Message-ID: <BYAPR02MB45350CAC4266729C0678CCB3AC239@BYAPR02MB4535.namprd02.prod.outlook.com>
References: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a70a5d-baa3-43dc-b8c1-08d9212d8180
x-ms-traffictypediagnostic: BY5PR02MB6834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6834EC0A1C6699E0F5C947D2AC239@BY5PR02MB6834.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3atMQUrdwMzucSahipkbKFgJToNG00hH7MlgXFpOY2uuBCdNc6D2rgArjOiKYmTHmZb/ybmSmoN0CzNiVcXS3TmCi/Drz6IvBSq3SdWptYXu7YuIeuh3D6f2d1QgitJd6KRFvGPC6fR5Ka66gqNxX+NIl6zsKQ4zWKK8aXc30HHACP4tq82NwJyidMda2ExMhz/jW/0fPGq7bbMBmVGWK9J3xsV1lxavjvab74RMSLCEzScRYXWyzPPpf/vpxiiphgwCdAdUevUwXlzrcd+yPMqkhQ6Rv3bj+wjPGr+6VP1S/IGpxS1rFmhTkDg9ksd4kY5bjsB628Wh62JXioeE1rrKkJZpQ6gZejnnftlmcJCZeEmI3rQhoYB7ZhiD3++FHUrKwGeeujNXqHQZtQt75Busa5LBIAx/9bvpeSW2Ghl3trERJvMYJd+Cij7VQdiRXdlHswx79dQU+6GmhbGCwBWeVIF1QTtz9mw45JXhMy+YcOFVijZ/LAXkeAguINHv9zQ/IavCF6fA0ilAZAlki5l0w5Bpxuk2QsQLwQa21+hR3QfO/I/pvOATV2eBDLIjxAto0j4nt+/xt5wLjaFYA467+5p6js6CXwPJNxJezgQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4535.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(26005)(66446008)(33656002)(71200400001)(6506007)(186003)(53546011)(9686003)(8676002)(7696005)(66556008)(64756008)(478600001)(5660300002)(86362001)(66476007)(52536014)(2906002)(55016002)(66946007)(4326008)(38100700002)(8936002)(122000001)(76116006)(316002)(110136005)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hgGvYq2on5XI66AIu+mhGLJmDxB80xZAPa0X98sSDRhvNumWtw/leOjRX2E6?=
 =?us-ascii?Q?r/WOkZidotpq9Y7d2etbcc8Ofz2KWwhBXMh8kmxs9FPpQWpxUqeOlfvVvCYx?=
 =?us-ascii?Q?hBNKd/SY6XzaJilR5jC0zxZSEWeBa4YNzFHswINNkPfa3dTZJQZ27Jhot6gN?=
 =?us-ascii?Q?bquCuly4nc8gR7x3wKO/3m6LCMR4GadVaJD++lPWwRa/RynnrICfvOjbZJk7?=
 =?us-ascii?Q?0xuLBF0PR3jJSu+v1Y5QXngq63otxd6mY0PynUMdbIldXesbD61Q97Oc6fUj?=
 =?us-ascii?Q?szMnohuMgefssv2ynFchFxdphjyMnUCHr07VvUVh+dPYWTSe5iGGiNp1B6ll?=
 =?us-ascii?Q?BF5zy0cTUk37Ehqqx1GjpN2YyTOZAeER+0nbC1CAN61V0+q92otRvc6Fv7AA?=
 =?us-ascii?Q?acuM6XwaI7TEUlbiU3Mfc6gZJNTe+zui9BJMLQT3hAJo6ae2lYYwo+yHyd1V?=
 =?us-ascii?Q?41CozHLm4XeaRX7uNg20FYyAPHlsKuzbVMWACen0kZQxTLeDOC10YsC2MYoB?=
 =?us-ascii?Q?2WDfjmAZPlJdj9Pk6dxGzXu6GhIL0DThtgGKYkApkqH2ZwhUPezK82x7hC+6?=
 =?us-ascii?Q?XkR3hdCIhFkAyk1BQ1h8OBeDFqgfqZBm0KnC2HzGe0mbH4SVke6kgKaV7V/y?=
 =?us-ascii?Q?xG5YbkEjkGFr6tS3+Ocn7ROeA5JzliJN5Oa0wnmkswpJ1Y0/YKss0WCI7X/e?=
 =?us-ascii?Q?w42cCPntC946Ps/KQ9CkrL2frUltDuLyjwoBH4vxjZ9KuEojrZmOlxOwR/L5?=
 =?us-ascii?Q?ojH7yLrU/PewtBC3DiqAGCpcLXMgVNfH8gMO/fGcwcuL+IB9+mUS6p6lGm+o?=
 =?us-ascii?Q?q3QMzTaAGqhnOUU/y90VYeG/K+9HMwCscCguUvLekNmT35xeG4rxUwGUIhdq?=
 =?us-ascii?Q?WSe7ssvO5dbdu6IWwu/hM0o5ksFRHGSD1M/yBfIC9Um+ahyk1BRUAreSj6mF?=
 =?us-ascii?Q?itMysqtyooTcLm9Hosl4cnKflAuN5ySNNhxswovE?=
x-ms-exchange-antispam-messagedata-1: IFmpwR+LtLLvd1KWVdY0iXgwAFDMsYfP8gD8KCmopgja+KaJpMp0DI5ePUiPuN46pZ5qQBlGyafFccgmNL5QC2/QwpFGxx6Q37XW+du/+QE4Bs4aD1rEUh/bjSJ3FNDJGqEWh/7uoM6ObdNBt0f9JwRV7x2DDjv3fAhW0Na8FklBm+fDH411u8v3mjuj5GT4jRLjxjlXifqAYeRKYqzRv4QqZxsYsQoPkKaqGWgVwy/yWxR067B9M2i66zV6uA10m9eqPOMAxaSLaIJxk7RYL89XL4f6izvEQ/vPunVqIXPLlqsAoybMnbmIxvfhOS1tqDUQmJ57LTrQgmOzpY+4ABSd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4535.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a70a5d-baa3-43dc-b8c1-08d9212d8180
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 16:35:57.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xogL/uj4jipWKhSc6F7+jHXjMxU3WLIAoPq+dlr0TWhRTN33g0ynrsHHsLgCEGH8tmpHs4Qg7LH7poKrERdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6834
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tested-by: Jianqiang Chen <jianqiang.chen@xilinx.com>
Reviewed-by: Jianqiang Chen <jianqiang.chen@xilinx.com>

Thanks,
Jason

> -----Original Message-----
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Sent: Thursday, May 20, 2021 8:24 AM
> To: dmaengine@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>; Michal Simek <michals@xilinx.com>;
> Jianqiang Chen <jianqian@xilinx.com>; linux-arm-kernel@lists.infradead.or=
g
> Subject: [PATCH 0/4] dmaengine: xilinx: dpdma: Fix freeze after 64k frame=
s
>=20
> Hello,
>=20
> This patch series addresses an issue in the Xilixn ZynqMP DPDMA driver th=
at
> causes a display freeze after 65536 frames. The first three patches inclu=
de a
> small compilation breakage issue (1/4) and enhancements to the messages
> logged by the driver (2/4 and 3/4). The last patch fixes the freeze bug. =
Please
> see individual patches for details.
>=20
> Laurent Pinchart (4):
>   dmaengine: xilinx: dpdma: Add missing dependencies to Kconfig
>   dmaengine: xilinx: dpdma: Print channel number in kernel log messages
>   dmaengine: xilinx: dpdma: Print debug message when losing vsync race
>   dmaengine: xilinx: dpdma: Limit descriptor IDs to 16 bits
>=20
>  drivers/dma/Kconfig               |  1 +
>  drivers/dma/xilinx/xilinx_dpdma.c | 45 ++++++++++++++++++++-----------
>  2 files changed, 31 insertions(+), 15 deletions(-)
>=20
> --
> Regards,
>=20
> Laurent Pinchart

