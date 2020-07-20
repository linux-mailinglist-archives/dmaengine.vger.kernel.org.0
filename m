Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4179F225C47
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jul 2020 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGTKAi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jul 2020 06:00:38 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:36805 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgGTKAg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Jul 2020 06:00:36 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f156b410000>; Mon, 20 Jul 2020 18:00:33 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 03:00:33 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 20 Jul 2020 03:00:33 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 10:00:30 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 20 Jul 2020 10:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3X8yWCjm+TbPWmM2kPMq1M5TAnSWd+md+nhcOPkVX0iAccqQS4IsNso23Hm5dCG3z7LWQ5wz7ZHyaLi3rrquiunoiU8rUKX0SHIVNWh6Yw00+mmExW6ysl8KihVlbobawUpI1LeGORsmiSkYulNnJyK5tYBWfqVLERGME4a+5hi3O56wn/lPX1FCWxdGrCcLKu+gup60VT5/uw5iU4xskrXYg6i299zFb+rcXuSCTDcKiqqh1I4d1yxrcfd6clUAO8LWyMuSSkyiTQE/d3Vw8RMTkbPVUYcTKa/D9ra/IaR3n+9KjEYQJYYlen93Ir9hyrwpy+XlxTw6VHKEIH5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+Xl7IxRPXCe6p8C2L8H+NgH5xR1WuohURlOfMyZHhE=;
 b=LSmLg25DeliFBpDZUBevimtca41u5hmm99TyqUmAV1s8F+SQQLZpbBgKL/0nM7d1Y1b97iQDB950SuSEDmeSkSGZsck22L3gKWtm2LG1O4cpe8i6804saxf6fxaDVsVnOedaXWUiacIMRUE2HKMLauYHx4KMKg5ZnibL45Dp8gwfCEEq3R5ZrlSpHUPZKYbGG3dsi4JJs/Exv6dIGxpDDyCKgHIolSEr6jTizdAmrPmENnpXuQv3bQDKwmyKmVxwC+IsJigSaqO2Nd7jyrlllg8IW1b7ia2KUPkF9dt1R3hlZjcCagnFsvtJ/NQJdGigF0LHHloldQ8v1O/Vn9Qj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 by BL0PR12MB2499.namprd12.prod.outlook.com (2603:10b6:207:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 10:00:27 +0000
Received: from MN2PR12MB4143.namprd12.prod.outlook.com
 ([fe80::f4bb:15f4:c14a:bcfb]) by MN2PR12MB4143.namprd12.prod.outlook.com
 ([fe80::f4bb:15f4:c14a:bcfb%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 10:00:27 +0000
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: RE: [Patch v1 0/4] Add Nvidia Tegra GPC-DMA driver
Thread-Topic: [Patch v1 0/4] Add Nvidia Tegra GPC-DMA driver
Thread-Index: AQHWXl/XVHWEEQyh9kG1xltiGlBuI6kQMssAgAAJoYA=
Date:   Mon, 20 Jul 2020 10:00:27 +0000
Message-ID: <MN2PR12MB4143A3B01549E8243280CF30A27B0@MN2PR12MB4143.namprd12.prod.outlook.com>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
 <20200720092556.GA2141917@ulmo>
In-Reply-To: <20200720092556.GA2141917@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=rgumasta@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-20T10:00:23.9797381Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=14537489-7826-4626-9f3a-1ac2e0682c0c;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [183.83.66.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 454c7e22-0960-4648-92b5-08d82c93bab2
x-ms-traffictypediagnostic: BL0PR12MB2499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2499EC3555CEDBA97D559750A27B0@BL0PR12MB2499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnz8UdwRerfNkJITlWB6ZB0gMidENFab4FKsB3rRAcluKAX2iZQsgoZHiw3nJOOpvQI2bmdfzTATepdGC+iq6pZ3+t7pOGQz1E6c7MtqobdF48+KR4ci7nIyvxRDr0NbqbqD/reM//ceOaR3U9fjY5xyF0NVkU4N15doNnMUJ5BY3RD0u0BWdrP1dM7DYaG5JzJP+K4fOfS/cv7TeGrLmJf4GJMdUbwBe2fW/YcT1ATy/S9ITxHSAgF8LC4dDr4NhqpSJiellXO8/o8PdThja7bIC4hfiWW2mDP8PkjhyCEUe24+2ILUl0lKaSbXXYY7ksoARMo69Q71m1ni7GKzLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4143.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(6506007)(316002)(53546011)(2906002)(33656002)(8936002)(8676002)(86362001)(26005)(186003)(7696005)(54906003)(71200400001)(5660300002)(52536014)(478600001)(55016002)(83380400001)(9686003)(107886003)(4326008)(64756008)(66556008)(66476007)(6916009)(66946007)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NgJpeWHXselFwoXVwsAG39/XGe83Ww9e6i6S7/AqXYgLkPOTS6HuSc5M34FWAq8wVpe+MNpcrprcAKZOY7buVwFEeIhb38uN52NM05TaQNQmgOsS+Jy2ASqx7XEmQMAnhOnzw6xi+SzQVKYFqXnm2nsMJIBX3uOwtgmq1LJe3DKewoWq2eYevHfHhLqWAMaVW3w32ciswmkuVN8RM1erEjS9cMYqRlHj/AvjloCNJW4EtpLCShfZ7WYezyTieotALPZtm//L9UqRApNiTcsMuklouR0zZfGFYZM5UT86f6ToBkHe1uH6gbjL/p5MmhOtGQD2RkcRCU43bmF5MwtnipFVuJSW3VWf22Cg2oeUJHwxP/d5gYBIhTX6mJDlk/fOul0YCgjRoPBrJkfyP+C8pnlCitjaVec4668BhQnGCHUN8OCXIZq1yvBAcDT3NzMZbzP4ODZSjhQq0IhH6uMFfu1fVWlIK+q7D8ipEx+j2DQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4143.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454c7e22-0960-4648-92b5-08d82c93bab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 10:00:27.5616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfzUZjY72lHuyLZdrK75Yr0rUFRVseriHcVBKPP+fQqcJMmqx9lJByxwcTq9JqxwaUkXb6+MkruQSwdYp1UrHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2499
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595239233; bh=7+Xl7IxRPXCe6p8C2L8H+NgH5xR1WuohURlOfMyZHhE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         MIME-Version:X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=d4Y/4jz8dBHmqBl19KG+HVk/xuNmU+N83nj/OTH8lt4WgO/SUvQXGbek2xJduS+r1
         9tyPa3WOnC74YlPhZLqx8cRJ/h5ezGFY6b5wFKZ8k5/ou9TB6YDrRHLJRQsxhCxc3d
         wJnOLxNJJmX3TDHMxNbFFWRZwVPDs+/ZdlTJtD+O3jC+wB5S53KlLK1FVIAJjWfj1I
         9+ApY1uBD9O2L5V8/Pd4/S/cZi/JttqqCbtuWoq+fomsedNVPTyB4JHUC49ZnJqSqt
         5swyx5hBXHAIG6sU0sGd2x/nAzDlLRKDvCC/afHNhVP2DO9z/7UGtDOYdf2USVxM+2
         AZiinQ/HJdiYw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Monday, July 20, 2020 2:56 PM
> To: Rajesh Gumasta <rgumasta@nvidia.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>; Jonathan Hunter
> <jonathanh@nvidia.com>; vkoul@kernel.org; dan.j.williams@intel.com;
> p.zabel@pengutronix.de; dmaengine@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Krishna Yarlagadda
> <kyarlagadda@nvidia.com>
> Subject: Re: [Patch v1 0/4] Add Nvidia Tegra GPC-DMA driver
>=20
> On Mon, Jul 20, 2020 at 12:04:12PM +0530, Rajesh Gumasta wrote:
> > Add support for Nvida Tegra general purpose DMA driver for
> > Tegra186 and Tegra194 platform.
> >
> > Patch 1: Add dt-binding document for Tegra GPCDMA driver Patch 2: Add
> > Tegra GPCDMA driver Patch 3: Enable Tegra GPCDMA as module Patch 4:
> > Add GPCDMA DT node for Tegra186 and Tegra194
> >
> > Rajesh Gumasta (4):
> >   dt-bindings: dma: Add DT binding document
> >   dma: tegra: Adding Tegra GPC DMA controller driver
> >   arm64: configs: enable tegra gpc dma
> >   arm64: tegra: Add GPCDMA node in dt
> >
> >  .../bindings/dma/nvidia,tegra-gpc-dma.yaml         |   99 ++
> >  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    4 +
> >  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   46 +
> >  arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   44 +
> >  arch/arm64/configs/defconfig                       |    1 +
> >  drivers/dma/Kconfig                                |   12 +
> >  drivers/dma/Makefile                               |    1 +
> >  drivers/dma/tegra-gpc-dma.c                        | 1512 ++++++++++++=
++++++++
> >  8 files changed, 1719 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
> >  create mode 100644 drivers/dma/tegra-gpc-dma.c
>=20
> Hi Rajesh,
>=20
> can you provide instructions on how to test that this driver does what it=
's
> supposed to? I could probably figure out how to run this with the kernel'=
s built-in
> dmatest module, but if you could provide a set of parameters that you've =
used
> or other instructions on how to validate this it would greatly help.
>=20

I have used below parameter setting with kernel's built-in dmatest module t=
o test mem to mem copy =20
cd /sys/module/dmatest/parameters=20
echo 50000 > iterations
echo dma0chan20 > channel
echo 1 > run

> Thanks,
> Thierry
>=20
> >
> > --
> > 2.7.4
> >

Thanks
Rajesh Gumasta
