Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4934C0AB2
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 04:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiBWDtj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 22:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiBWDti (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 22:49:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB3A6540B;
        Tue, 22 Feb 2022 19:49:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/nzc4pImeyl/Lsr/0rDIMa3bhR8WQ9vrvliUmQmkbcJ0m3gA7Vs4hGqkYRsGEJr7PmYQy6IYpetEVqTx0h19SOqJ8I4NrhW9XCXOHFd/Dn5F2e7wJBsU18K+/AZ3toMxn8xcstFdd6lYubG4BXhEvShswJJOWwmSJkST8GktJzIH3uXcnnqbuDUhOoboMXJTYdShd5CjInfGW3yOm7lyUnoomt8TnA5tXaGRylv1xwjxHirj4TvJp5UVMp/1rK8MVtltNCAJfuGAsg2n0o2dG00PnkjibGkz6RJuRz+F7d68PebFE7qiR2hLm3Foc9LB//fVfnrl0ZqaMaqQtldBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L3XfGEPzSyWahH36xtQ/l4h9QhxF0e0DrmCOyOwQx0=;
 b=feVj5RaipxcpqK7v2Dxbn1tIy3qVI86dLxAmuqZhGyMogzeVN2CtPBiSsqIVmyrtkyh+HWRFvQ3pEybDsApYtr7J2h9fPH5jRaJolrfYrvE/kRNsmEADv/TSRC04Yty5Cp+D1BMsipY58mwq+CaAKxE+Zv21F6jvHr6uN1dYFlCYt0m4ieSiGMuEu5ZV1B3ExME4hT3xz4wTdl7Kttbi5jUP7g3epCOt8McJm5U/IGNgWJNbw0wkMTCaxcHyveP+4bXYLEt6l4V3yvN46MdCdCJ36DX6EawlyykaE8LWqWufh98cN4L8ZjnTcoJfvG2t63OF5SJuKFPVMVNyYnBCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L3XfGEPzSyWahH36xtQ/l4h9QhxF0e0DrmCOyOwQx0=;
 b=bgP/JP2tqviZGDT1KujGo9PAmxR8nzcrtN+3WarpREbCVWmFAFAYq3yPvL3cb4YikMM95tQ0F2ncBHeH/lHSuEfK+BEdFsZGTHxqWe0cugGNpWjX+ddbXY21DvOAy0b/4zVniWQdYMuA2nM1bXUU1gAOzTHvOq5nciFL25GqUIF7A0pUD8QJ/9x9IRnwrxNujvz/Ae60iLNQj9E28Dh0f08KJhmLoarWbvX3wiaFUVci8ejUa7Hp3wv+OXVP0hftpPnjw+ViURxngCLvPtNHWDfQ99qqgEOxnf6zqhT3N0792AV3FLvnk6cCMgJk/wsLtGHUnokt1yq727pT8OjCRw==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Wed, 23 Feb
 2022 03:49:09 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 03:49:09 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v20 2/2] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v20 2/2] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYJzmonI6OEQo+/E6QhQV6hFw0nqyfs/OAgADMAkA=
Date:   Wed, 23 Feb 2022 03:49:09 +0000
Message-ID: <DM5PR12MB1850EF14473F9F941FB12506C03C9@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <20220221153934.5226-1-akhilrajeev@nvidia.com>
 <20220221153934.5226-3-akhilrajeev@nvidia.com>
 <YhUBt20I471s9Bhv@dev-arch.archlinux-ax161>
In-Reply-To: <YhUBt20I471s9Bhv@dev-arch.archlinux-ax161>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69366039-8925-4b72-853d-08d9f67f7282
x-ms-traffictypediagnostic: DM6PR12MB2939:EE_
x-microsoft-antispam-prvs: <DM6PR12MB293979F8E35C2D042A03A6F5C03C9@DM6PR12MB2939.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l53S7LOX6RfKFm0uZYePuigsjX47GdApMQqUGBQE9t/+fHXzfakAAI3SrpfvImxtNamKdK4/mgHLtYo8DH8SZjmq3Xd3bM3jPJAZtyCzYxty7djM/xydgi08szxlR9bg863ZbxB4+vIi8ofjKSVN7hsrbvbeoVdS0eB5HIyGun8GdEn8rutS2phIhR1+j0733n3JWwrVWl9pZiGgF4/+Cj/4ZUvpKDWDzs7H+DRW9dW3sYbjJyxhVp9OM/eZ0pB7vQ8G0/C4SM9eWCxtXTqAWBOAfwclKJWeUJzWorC1sUXT4ebyGkV2bFybJglEUypoicUuDedDBxlA0WU/XR12vYIvtJ8PH0wtRgj+1Vo9YJtzWQWfkqMjgDy/rtlpwHk2ntZouO1qmvYMOojwP8qD54T1BStY/dS5u0+SHPsKY62nMSiyvaray+EZSJIIHYTqXH5y0NnJSbA06N5H+/j5ic1yD3ozZKy0JSlsqjQD3p7oDBLPIFHmwulfyzKZBTzFkdY0C0ecj/0y0gIqlWx9BQouJQX/Z4VBDS5psZJOsTd5DntB/z7zql+15DWLTJ6U7VBtavmzQyANv7TiO+fOkNLrmZJGNB+Ct8IpEUx5lDo/eGFIqLjJy4YljrQD6hwU2J9UVzkxMvK+GQI1J19kdf2iX4MiXrxJh/THEMHJ/7p6LoDcavQ/jphVUsdssCbiDDLao+kXg+KN9dk2UYKGfo3hmTVERBuuJq3LoqN6nqpqlTQq04paQ9srm80VM2BRJCGReO+LO1ZcVGaFuPmJN6XAIVOIRBt08Sj7ti9Lg3/3OmYGsfk/MlaGyCyenbhcZNjyDMqNQIn85uKLnxBmgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(4326008)(8676002)(26005)(66446008)(66946007)(76116006)(64756008)(66556008)(66476007)(966005)(107886003)(186003)(508600001)(122000001)(9686003)(33656002)(38100700002)(71200400001)(86362001)(316002)(2906002)(7696005)(83380400001)(55016003)(6506007)(8936002)(5660300002)(52536014)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t1zLf4aSTpWqxMHtFx/Lj6U337B7lYncprYXE4esYVkJ6cyP/qbQ2eQA+mJv?=
 =?us-ascii?Q?cQ9c4x3L/fDaFxdQZdXHK5yq4vvyhiDhjZXiMEiiCCIqZCSl++48lVwt15Kc?=
 =?us-ascii?Q?h/ul3TC7Rl74Y2L67wZOToTe7nQnXgKUYzZCWjdEiGFuFn+4ZvZL9uJSlJE0?=
 =?us-ascii?Q?pp5IcZBl/tRKW5U5KZ8mwS5gTeeuDHnKEhxpUe3mUGuKf+Ug38Qe7/nReBtz?=
 =?us-ascii?Q?mwiFqT7VOqZ77Ev3JmiXLv7f0pa9bN3vYegQGCvDx7A5xZC14HTxEOrDM3pD?=
 =?us-ascii?Q?k+a4hLYu5jQi8NrmxcT5mtU45n1m/w8PIMMKCYV+rBL8ayGNQfMNC1OkVyTX?=
 =?us-ascii?Q?dZTlApy1ABvJ2Goe5dT/QfyXaWE5Aa2HIPTDQs9QxwK96CRK7XvHX/8IJSme?=
 =?us-ascii?Q?FgNCYNG+iNb/RywGR4t6MWumjesXkyZzHsnsnplW8hRBl5Pc0TaTv1nuh0AQ?=
 =?us-ascii?Q?2/6Ecicksp7+Bd46A1k4w5Q8khVuoH2fhHYR8uzqHFHJHMom7Bpmu23tmlBQ?=
 =?us-ascii?Q?qJ6/7+HWtHgeeYWl+obiGX3JkwYNMdzSl69syZvhGi6OnU7ZC15zigOrC8Go?=
 =?us-ascii?Q?cAPWaBqypZnhdrihE1GXCbhw0GTuZwq8hsDHOfaDBLSDRXCzzt7hGbZ8Ww5M?=
 =?us-ascii?Q?pKqW/pm+4/5D8Xn1LzMX/MDWiXjheHFMtg6TlY/VVt6qKjPQMFQy21yLhsnN?=
 =?us-ascii?Q?OHDoI+GTzZ6zPi6DVAzs/pqFWxSeU0msdR1qPINgcxjWeM45na3PLySK+fth?=
 =?us-ascii?Q?ZTeXiy+num7pJFJdh3EOVONOZxhe2c9cCf3dvo9iRIlkBRGSx9t/Ki1avj/O?=
 =?us-ascii?Q?xQByveFR5OUdSWWpW9xCv8mgJ1lFq1nT3KC6IrWnotS2fjkSt1QZYX+0S1vl?=
 =?us-ascii?Q?6FmFLg3v0LmGe6w5+7YhEHMaGZJI40+u28JsHYPRGEPdEWvE1eISqgDpEDaN?=
 =?us-ascii?Q?OHqfe8TasCB7XguuCphxEQkvs5RU8xssdo5TLcIMpfoqtPEvbccQY/Qr+yUP?=
 =?us-ascii?Q?/veKnDgHiqIx8SBqkDjh6iONvGdBF+C6fHtaTpko3S83ZnIps0iqjYzjrRiZ?=
 =?us-ascii?Q?hosrzZ9SansuUF6WX+/+G1hFb9l0J1moUPqAZCxdWaEssaRY7+d4gR3hSd/w?=
 =?us-ascii?Q?YfRS1kqnF6K12h/Cmy1wDrWq7eGdqrmXslgKaVtgGS5I4ye1JV/nTokymGsf?=
 =?us-ascii?Q?qYew72WtjMSCcGE4nVMbWuAaUEq52KhTOCdPSe2IsD8eEA3WoZ9grwZB9DMu?=
 =?us-ascii?Q?6jTHFibJcFKf5QSX2Rw+sXOnmocxmkDRanwDDNG2WrjtmlL3jleLlOgDesNi?=
 =?us-ascii?Q?miBo+BJAjiddeevztfx5fvFEMuiDm4rpgosiGjSCjlF12JOaIvch30L08MsZ?=
 =?us-ascii?Q?sPFq+dpdU1hWiZA2MiV9MWf3BCoIYS+lVAf1Dbc3Ngj0n3aj7U0379EKRd6M?=
 =?us-ascii?Q?9/OcFVX9PUE18/IXnTYgnUqbgpPkIR7hQ3zQf7sN0jXHkVq6J28zN189lpDC?=
 =?us-ascii?Q?pSsBqsBYJbX7JFLIAgI37GHi6Ip+TD9gDidS17+tOmK6n20X0gNTYeYDJl3f?=
 =?us-ascii?Q?x4P7SL2QUAt5cEmgR2239OmZOnaW8bRYFIzVq8dyDRHcx/H5qfNg2W8TuZMp?=
 =?us-ascii?Q?tHylrAgpp+zLSSQu6GS57QQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69366039-8925-4b72-853d-08d9f67f7282
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 03:49:09.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvvbaOb7I4GqBkxRg18kIPqQ34u8kZ2/LpqCAcfJJB+qw9mvpO5qOY+dElWLHtrgxdj0K9V4Whsbxt7xw2effQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Hi Akhil,
>=20
> On Mon, Feb 21, 2022 at 09:09:34PM +0530, Akhil R wrote:
> > Adding GPC DMA controller driver for Tegra. The driver supports dma
> > transfers between memory to memory, IO peripheral to memory and memory
> > to IO peripheral.
> >
> > Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> > Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> > Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/dma/Kconfig            |   11 +
> >  drivers/dma/Makefile           |    1 +
> >  drivers/dma/tegra186-gpc-dma.c | 1507
> > ++++++++++++++++++++++++++++++++
> >  3 files changed, 1519 insertions(+)
> >  create mode 100644 drivers/dma/tegra186-gpc-dma.c
>=20
> <snip>
>=20
> > +static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops =3D
> > +{
>=20
> The __maybe_unused cannot split the type ("struct dev_pm_ops") otherwise =
it
> causes a clang warning:
>=20
> https://lore.kernel.org/r/202202221207.lQ53BwKp-lkp@intel.com/
>=20
> static const struct dev_pm_ops tegra_dma_dev_pm_ops __maybe_unused =3D {
>=20
> would look a litle better I think. However, is this attribute even needed=
? The
> variable is unconditionally used below, so there should be no warning abo=
ut it
> being unused?
>=20
> Cheers,
> Nathan
>=20
> > +     SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend,
> > +tegra_dma_pm_resume) };
> > +
> > +static struct platform_driver tegra_dma_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "tegra-gpcdma",
> > +             .pm     =3D &tegra_dma_dev_pm_ops,
> > +             .of_match_table =3D tegra_dma_of_match,
> > +     },
> > +     .probe          =3D tegra_dma_probe,
> > +     .remove         =3D tegra_dma_remove,
> > +};
> > +
> > +module_platform_driver(tegra_dma_driver);
> > +
> > +MODULE_DESCRIPTION("NVIDIA Tegra GPC DMA Controller driver");
> > +MODULE_AUTHOR("Pavan Kunapuli <pkunapuli@nvidia.com>");
> > +MODULE_AUTHOR("Rajesh Gumasta <rgumasta@nvidia.com>");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.17.1
> >
> >

Hi Nathan,

Thanks. Will update the same.

I am getting notification for the below warning also.

>> drivers/dma/tegra186-gpc-dma.c:898:53: warning: shift count >=3D width o=
f type [-Wshift-count-overflow]
                           FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest=
 >> 32));
https://lore.kernel.org/all/202202230559.bLOEMEUh-lkp@intel.com/

I suppose, this is because it is compiled against a different ARCH other th=
an arm64.
For arm64, the dma_addr_t is 64 bytes, and this warning does not occur.
Could this be ignored for now? If not, could you suggest a fix, if possible=
?

Thanks,
Akhil




