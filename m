Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9165D4C22FC
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 05:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiBXEYC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 23:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBXEX7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 23:23:59 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D4199E1B;
        Wed, 23 Feb 2022 20:23:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne8P7j/RBZX22XPi+LLmuwZnD6Fr0McZpgcZbq70Ryaf+9JC/60iAhTYN2hraxj7cFeSY1wNy04xu8jPrDfBxcyCxpQDoRdVr4onG5kueHvLoqslegN0qwJIOflQfjCVHJ2P/GhR7ZrnzvxYXA9qHqSS+vMweYlGOTjufBiSM0Xb9EoVRUnTRtEP31tq5WNm8sT9S1z3HGTLGAR6SQYuh+IDWUZze49PUd0vVfcc9VSG5CxBbaEGBxLADWgF7qGbiujzxGvzwQWJrBtcPH+Xr1wsNLwTJNqABgRAVkWVVjmUnRYQgZwknw6JiyvMqUsIokLFVn5vuj3XDH9V7nB5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG+5mlpO97ToIcZdIm5T/5tgololblN4Rd9hErDo/Ww=;
 b=Gl9s/z6BT4KQU986xZ7lWerwEhCkaJQ/n4NvLrPobEfd5Z2TdcwZL/jlPoJOltLIsoiFtt8HZRibn1ya6MJ8SxDHwtfZQXFK7F17vmb/SE0S/9XyVnWpX6z0AaVyBnpxbHmtiUu/1xuPM2LtsQvf63hbER4YGkx+0Sov61y7IEw1huzOGRmgALVigIpRgtAIb9vK5aFguOEAk26xjGJCVNvGQBw1gFWk7OvJD4Hgq9DuNco2/noECyfLR312T1i31w7DUVWm/NbmGO5aKY88CFo5uU+K5cn0iIBYlmB4ASbotP4X8MqChAY5rSfeb+DvI1P87XUzspJyjyVvbWg8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG+5mlpO97ToIcZdIm5T/5tgololblN4Rd9hErDo/Ww=;
 b=qwMqfvsw7ixfsASWCJTENt/XztJBfE3ioWOmCySZ0A6Z1skhI74MWHPxsBWIpjGxiTUtk6ACusB3HZ1OhzbzFIdj0i1J+E3QYEiYUXakVKnXafoRVB2Ej/Y9slFvhqjpnfStsWdOQylhE/5bJ/O6F2zIL84JPuS0RIfCVOMcDAz36x0phVZTVPVwMb44hTDjIUwpZQ34H8hWmStd3i3YZoZ3w2tzI12aQwLDHfY0c33QBi6t+Qz0ZAGaRU1SDgdplEd/Sl5kXR6qm4Sma+gVW5cPTEFZnaWZwcQZjq3ipaFb2KKVaxe/uPmWmIVYaol2UTwf7B1usRKF+I9e7mmmdQ==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 04:23:28 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.5017.023; Thu, 24 Feb 2022
 04:23:28 +0000
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
Thread-Index: AQHYJzmonI6OEQo+/E6QhQV6hFw0nqyfs/OAgADMAkCAAPwtAIAAnSDA
Date:   Thu, 24 Feb 2022 04:23:27 +0000
Message-ID: <DM5PR12MB1850C245826D8229E63141A0C03D9@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <20220221153934.5226-1-akhilrajeev@nvidia.com>
 <20220221153934.5226-3-akhilrajeev@nvidia.com>
 <YhUBt20I471s9Bhv@dev-arch.archlinux-ax161>
 <DM5PR12MB1850EF14473F9F941FB12506C03C9@DM5PR12MB1850.namprd12.prod.outlook.com>
 <YhaAZNaav720xXXx@dev-arch.archlinux-ax161>
In-Reply-To: <YhaAZNaav720xXXx@dev-arch.archlinux-ax161>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3d898d-44c5-4340-30b8-08d9f74d6816
x-ms-traffictypediagnostic: BYAPR12MB4758:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4758C1554C6EDB04160EDC57C03D9@BYAPR12MB4758.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rhKEEpnrlrnSx6yEcfpE2iHsW8Re9QubmzrLJquRPgzk1WLgQwjtjdsYP+SimbzXYNSsgP3/xtTwoZandIwroAikRiKpX2Q92KinV2GAHuHNxcgGxVjhLs2cleE6TkID3Axa/ornd718f9caALBxYKWOwtckNM42PuOGOPpWL6jbOdHclOSj2zMRNaYmnXiv+ykq3cjPGNtYuKUEmWQNNUERZPSBZ6GidLIDqL4R7drMLMxOXbvt3i+Fh96tdoJAwG6MYKPG7SuhyUszizLG2mK0kPGqFMW/m5hw8Ik6mtrWaOrCK9CHXLeI1KO7aRiMQR8KAJtXMMg5C2w03BxKNhAFq0tMB4bVN+UzgjQ+vEVuTLLoTk7fT+MM7xe4uwzpwpyeJ3R9ITLo8xbatAwJeNDkt51dwzEr1gBmarRt+tMOCPysWtGRrQvk6dzqeW6uw/Ho5jdCRvmjx8cKNFqfXh8V0FETbQAD4x+8gICx65xNuecdaDrVoSdjETUG7DeGOVPOsMRTslkv+8TLUsXCFDI+GIoc0PScrZvNxkNOZ3s1BMTRLSPq6mEP+hVyJqY55eS3TIpZ1//qQVjDFz6S0/tI+jlIECzZyAOw2gHb5YSRbo8KLBgLnuArjd38YPB+/4DEktj+EgI952Vy4xv94Xd76WrbsqMqr6fCPQ/u2IWK1NHHHYAhuxJIFowHu69ejcnlwRY9QHRhPGH+C/zcBBzYOs+hhcgAXlh5498aDuAJiHaUVg52mVM0DUPClKeKddhaZpxlSPHGTdLTr2kcA/olskjRWT7+Dx/f5R1UyCcic6Op8nB6W/ZpM7XHaEZV4SmxGVyVHg7e9Ee+9rwIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(66476007)(66556008)(4326008)(8676002)(66946007)(64756008)(55016003)(76116006)(66446008)(2906002)(52536014)(38070700005)(122000001)(33656002)(38100700002)(508600001)(966005)(7696005)(6506007)(71200400001)(6916009)(54906003)(186003)(83380400001)(26005)(9686003)(316002)(107886003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ID6J7D7DkyGdmz+UNL09rxT5zraOQLt15lkJUJk5+rjinIy022SVaCBP2rc5?=
 =?us-ascii?Q?wnrmJ7pIj+wo93qiJO5PqUaq4KncTGoImCIeugz/uEcIL6qAfNPQvX6uqJI7?=
 =?us-ascii?Q?WsO9XUUOgElOxrTHbFGCIqBd5Ge8D7e0bYcTn1Pg/B8xh9riL8i5Z8ctFozx?=
 =?us-ascii?Q?DtgCvVA/NwBLvs5SZlCKiAi0IeSVlDtMZzVDAxVwyskIuC1T0suskHaG7MdZ?=
 =?us-ascii?Q?wgPlz71hakJupUdvlnNq0OYSPSXXPGlsY/RrOdMUl459ftQiJopZUEPGNit1?=
 =?us-ascii?Q?08PYOc4BLsoVxjVQABrb5rMlEhTmI4crFjFMDKJKdqSLqsC5tLzg93Hb0a6L?=
 =?us-ascii?Q?YxrZx0q8nbL4cX9SFUR1Bxb5VGka8nI6donvlfQ/OGg4hUaRdku0kldQgUtH?=
 =?us-ascii?Q?KFbTJsLSAs3H7w7xCWz1p23qwBmlWG3DzI/rnJ4yHjH2bzfFUpMiVzHBY/oF?=
 =?us-ascii?Q?pADimPtHsDXI3JampSLjkBfSJ6z/dbwVRSF2QUrfGrD0dlqgVZVLqYg1Z5q9?=
 =?us-ascii?Q?zIquUxpnGv0yL79raohE0HkPukSj7bF2W5l8XfGUWhu4CUP7Weed8ZdJgUeC?=
 =?us-ascii?Q?QZk/S+dcRYzkC0ZbIrwfMNZCgCFVbDIl4IF3WhcPS2FqkzMifIAV3YE5Kw/b?=
 =?us-ascii?Q?eDWVApRpfQ0BlK+FinH65je/o8kaOmSaWK5M7nU3HU+LT0h1kFjFs4qL/h5e?=
 =?us-ascii?Q?OnFVz7H9O/qs0H8LZlO3z779COJOF3tp1MS8B3In7taNc05Ch6ZaMnRWHNjs?=
 =?us-ascii?Q?L5Ykgz32QgwvpUJxGuhljrFKAIM9cdHU9j/DSl8VkMZKQj9xzIWnT4GnSBo7?=
 =?us-ascii?Q?GFJ1Le/41kHNcQD+Ful2txb09YPkr2q5kX4CYxNk5r1kMllRTB5vqp6wr6Bm?=
 =?us-ascii?Q?PgVu7iJNujT7GfaGlVtrhS9yfnsPnynrdpf1K41ubWB0etHjBazSIAQyBD+C?=
 =?us-ascii?Q?kJLwhOTY69JAlIn/wJ1fjhepiENdazOvOGYQZ9wtTgz1Ang2QkV+y8wniS3N?=
 =?us-ascii?Q?hc30RRoMHbLQtm/dUCO2nKWSOoGJOBRH+o4mObpuORMLX+67q7fsok2fhfYq?=
 =?us-ascii?Q?05k90v0WtCgZ9jVfwljlcyW/QL+kYbOFZFhIpaLkbNg40vhtYN6UzELxPTuq?=
 =?us-ascii?Q?FbuugWx2Iao4Yy8bmIJ1GNmzfBI8GG+D+Rt08W0iijmi5F5AtDdj9uymckDB?=
 =?us-ascii?Q?kWK87EKxnitT0xFB08qhYBu9RP4OfQ+eicdNHiZxahrs5SxRuuKN7UxOaTBl?=
 =?us-ascii?Q?gB+yKJAiny039LMefABaK5uStBaRuH9L8JfX0txVJC6GvG+EJm6eTNCVYYr2?=
 =?us-ascii?Q?24Qb528U4Ife+7LmnQP2SzPjQuEav04v6DwRuGeMVEFAzQRAVdsURX++ZoW7?=
 =?us-ascii?Q?FBIE9V+eicVkxghQZ9pw3KAegBanC+kQY0h+wmY6F9NoXqarbR8kUlglnvLc?=
 =?us-ascii?Q?11RrXubZBHuI8bfS4Fzz5PKrNoCO1zLYfZJYWbyhvWf69ss1W3MdYRY8sVrr?=
 =?us-ascii?Q?bUGnQK6xwoAVXC7wxnMNig/rE/QlV/2hdNE/3aQw5CyPeCOodnUDTr7yBw+I?=
 =?us-ascii?Q?TRWOYpPt/5veOzE6GiPec0dVQs2TvW6qwneLbLEv4MU0hF/acbXRL7pIImxN?=
 =?us-ascii?Q?eU2xEt8D81j14tLZa7MdBiU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d898d-44c5-4340-30b8-08d9f74d6816
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 04:23:27.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoqwRkyBkKg6ATGmeR50YpTUWc6/ayo4jts5MOQfeEUop+D8pAuwVuMzgc/UdnJtVFLaZG+HxuJMdG5pzIgtdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Wed, Feb 23, 2022 at 03:49:09AM +0000, Akhil R wrote:
> > > Hi Akhil,
> > >
> > > On Mon, Feb 21, 2022 at 09:09:34PM +0530, Akhil R wrote:
> > > > Adding GPC DMA controller driver for Tegra. The driver supports dma
> > > > transfers between memory to memory, IO peripheral to memory and
> memory
> > > > to IO peripheral.
> > > >
> > > > Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> > > > Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> > > > Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > > > Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > > > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > > > ---
> > > >  drivers/dma/Kconfig            |   11 +
> > > >  drivers/dma/Makefile           |    1 +
> > > >  drivers/dma/tegra186-gpc-dma.c | 1507
> > > > ++++++++++++++++++++++++++++++++
> > > >  3 files changed, 1519 insertions(+)
> > > >  create mode 100644 drivers/dma/tegra186-gpc-dma.c
> > >
> > > <snip>
> > >
> > > > +static const struct __maybe_unused dev_pm_ops
> tegra_dma_dev_pm_ops =3D
> > > > +{
> > >
> > > The __maybe_unused cannot split the type ("struct dev_pm_ops") otherw=
ise
> it
> > > causes a clang warning:
> > >
> > > https://lore.kernel.org/r/202202221207.lQ53BwKp-lkp@intel.com/
> > >
> > > static const struct dev_pm_ops tegra_dma_dev_pm_ops __maybe_unused =
=3D
> {
> > >
> > > would look a litle better I think. However, is this attribute even ne=
eded? The
> > > variable is unconditionally used below, so there should be no warning=
 about
> it
> > > being unused?
> > >
> > > Cheers,
> > > Nathan
> > >
> > > > +     SET_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend,
> > > > +tegra_dma_pm_resume) };
> > > > +
> > > > +static struct platform_driver tegra_dma_driver =3D {
> > > > +     .driver =3D {
> > > > +             .name   =3D "tegra-gpcdma",
> > > > +             .pm     =3D &tegra_dma_dev_pm_ops,
> > > > +             .of_match_table =3D tegra_dma_of_match,
> > > > +     },
> > > > +     .probe          =3D tegra_dma_probe,
> > > > +     .remove         =3D tegra_dma_remove,
> > > > +};
> > > > +
> > > > +module_platform_driver(tegra_dma_driver);
> > > > +
> > > > +MODULE_DESCRIPTION("NVIDIA Tegra GPC DMA Controller driver");
> > > > +MODULE_AUTHOR("Pavan Kunapuli <pkunapuli@nvidia.com>");
> > > > +MODULE_AUTHOR("Rajesh Gumasta <rgumasta@nvidia.com>");
> > > > +MODULE_LICENSE("GPL");
> > > > --
> > > > 2.17.1
> > > >
> > > >
> >
> > Hi Nathan,
> >
> > Thanks. Will update the same.
> >
> > I am getting notification for the below warning also.
> >
> > >> drivers/dma/tegra186-gpc-dma.c:898:53: warning: shift count >=3D wid=
th of
> type [-Wshift-count-overflow]
> >                            FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (=
dest >>
> 32));
> > https://lore.kernel.org/all/202202230559.bLOEMEUh-lkp@intel.com/
> >
> > I suppose, this is because it is compiled against a different ARCH othe=
r than
> arm64.
> > For arm64, the dma_addr_t is 64 bytes, and this warning does not occur.
> > Could this be ignored for now? If not, could you suggest a fix, if poss=
ible?
>=20
> I am not really familiar with the DMA API and dma_addr_t so I am not
> sure about a proper fix.
>=20
> You could cast dest to u64 to guarantee it is a type that can be shifted
> by 32 but that might not be right for CONFIG_PHYS_ADDR_T_64BIT=3Dn. If th=
e
> driver is not expected to run without CONFIG_PHYS_ADDR_T_64BIT, then
> this is probably fine.
>=20
> You could mark this driver 'depends on PHYS_ADDR_T_64BIT' if it cannot
> run with CONFIG_ARCH_TEGRA=3Dy + CONFIG_PHYS_ADDR_T_64BIT=3Dn but I do
> not
> see any other drivers that do that, which might mean that is not a
> proper fix.
>=20
> Please do not ignore the warning, as it will show up with ARCH=3Darm
> allmodconfig, which has -Werror enabled.
I see some drivers using 'depends on ARM64'. I guess probably we could
use that to avoid this warning. The driver is only supported for arm64 Tegr=
a
systems as of now.

Thanks,
Akhil
