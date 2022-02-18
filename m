Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF60C4BB120
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 06:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiBRFCp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 00:02:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiBRFCe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 00:02:34 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F49266A;
        Thu, 17 Feb 2022 21:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/oAaqW3bUh07dcTlDNcN/+y42UJ7PaxdakNAPAn4AQxX3tgmu5G8CAVLj+j2aLTGsE7mSM0p6LWXf4Sx84+DBN2g7nCiyVIOZNauvWk/voVYCZj2z8Ue5OPdYohOecoCgHAoNattvVAwxEIvP+jufw/Ssqq8tEkX/B/frnbIIe2CFR6Q0R/AxGdVRelr6+20uoKpQMBG0YY9ujXJOcLFSLhJhRKQUxSlOSx7xvsg6P+ZneyNQod5qiSpeEi1PfhUtEEx2X4HAacE7cAD9tzSmFaxBz6Yg5E79lGUBsYzFLnfASU1kbicsJqLmsH3Z3+2BXFNtgBn3xkIwVtfBdAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kpeKIqyxftSZHTlx1V/g8hGZu6mZYTo3Iy9q0o/bUI=;
 b=csnMBMxuyaSok0p6Vq0wpaOCn2bihYY2CBtfs7Vy6fHmwdZNvZp36rxZ0MDtwW1T8gYshGH6TwCaRvGLPdWeihiV0DJrTSp5svpfX41ilcG5W8ibhAm+xCT3c/tGJnl+Wg8yx051I+0KeQUnu6qnErwa5pXmomF2xAQA4ieAggVmONIbyjg3fPfdGbLops2ZGorZy4sYKssU4i6qraqqLb5Q15Ubt5SFLrWIm//Lnpyei2l7Jj8O1/EJa+v5C9aOMFA0SIA7AB9uNT11qcuYSKfT1fP1RumZhBMZMYUjTCD5emrgkwynJxTAFJx5HZvA+xW0gIJOMgm5Rb2TEp4jNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kpeKIqyxftSZHTlx1V/g8hGZu6mZYTo3Iy9q0o/bUI=;
 b=FUTzfqkslMJ4GYUeRjqp/BgXx1pZdBRRtr4ABzk3pvw8eV/2CA07JUeKNFH/LhjPHJgib9D3GCQcAQpxiABmjiSUq2ABdpZ/U45POlj9Nxrbyxe2r+5hzugTvxvGCu49CBJKHOmI8ET5Li7+l2S0FQ+fkZD/LE4jPSfk9OMTbWdJxozeLcRQ/SLnA/Rw2hEziAKBb5i9P+qGGg41i31PuDqt4LKQVKXLDZKUMPYJNccHRPfPp5ux3HFX/Ox+OSponBRRqka+9iuPr4rd7PupSakahpd4sB8jUfNP7dNBwGbV75XFXg7aGS3ChiImVcnwFO6ldCyKm8rFHviq5tyMbw==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 05:01:52 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 05:01:52 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        "vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [PATCH v19 0/4] Add NVIDIA Tegra GPC-DMA driver
Thread-Topic: [PATCH v19 0/4] Add NVIDIA Tegra GPC-DMA driver
Thread-Index: AQHYHDOhosviul8qH0O0gfnObfQ556yYz4vg
Date:   Fri, 18 Feb 2022 05:01:51 +0000
Message-ID: <DM5PR12MB1850AEFF5FA511525E25905EC0379@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
In-Reply-To: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0b09852-b58a-4e6b-a375-08d9f29bc6f5
x-ms-traffictypediagnostic: BYAPR12MB3333:EE_
x-microsoft-antispam-prvs: <BYAPR12MB333354FC08F30072A5A72CC2C0379@BYAPR12MB3333.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PEIyqNT+lAskp7DAZuA8gmSg8aaWWi+HvV9sc8SixfwoYQj2BiWkT4UIIxjHxucmK6ida8Kp7i0nig9AuObhlWAjZP8aGCzwxS71a4D36AvMLEHMzS9163yjXJuknFCU5wnrD3POMl52vg+vjzRzGfqezaZifw3nT+ixOcTCx0NbcF2GkyhUCLCbLaCFZDzTbJTWIWBW+/py8Kmasq2BSTI7QP9/CIwdhTUKqALOpw4NLUIT48Z+MHXawreJ2sUE8FDWpuzgdfIOaXSWIjHBxzGWJkVoMHe1qGuxFDqXH+P8n0gnKQZHmKJz7dyWKXoti/c/DWf72KzhDyLwPpLoB1UT3VeRCcOnhaczC/o6/HSyQB8x/boC5hYouL0pqWaFWqd3Z0UUG51qnMDAokHc+3chqZH6wnP9bWhf4K7xdunsm1wMQQ4ETnzhyDTMLOXhWb0KKcru3VaHWpWN0VaNZf9UJj3jKzNUXoFaM2O2JcHmbA3t6N0TTwqKHiWW9E0lNv5H/jXP0OSDpkKrWXZs6JbwU7a0ebqYU0VYTjiA/kpxZ2zCT5AyB2kmONqLNdckOUA0gmMY2kveYnRZspo1KQWMXYJLJpY6bgmDBdBeOVJL9pwgPii0F+g06TQNvhNFHaJhAuB31XoYu9CqECz3F5qKcdrLn/Y3037lXaikL3CtNUexPZB0CkSLa1cGMLcm2n+FX/py2ObviBAUpuj67mYnmwAiBxo6awTw1hzaM80Uu0yLWpbq1s/r3STtnjk+QndP8jE5dANiiAqsA6sf7r8ZT5zDR7SpTt+8ZPlPJqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(508600001)(86362001)(8676002)(64756008)(66446008)(66476007)(66556008)(966005)(71200400001)(316002)(110136005)(55016003)(66946007)(9686003)(7696005)(6506007)(2906002)(33656002)(8936002)(52536014)(38100700002)(122000001)(921005)(5660300002)(55236004)(186003)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?twDD1S+hiTL3qzNXxs/sVIu324ObKnrQLjEp4B3d3B8Cvp6h0lcrSnLVqoc8?=
 =?us-ascii?Q?/g/oR1BaeNaBNcGbTwvtrRpGEdFbPoIVvarEeGZwKHeD9oNzVvtM00i4U9V8?=
 =?us-ascii?Q?TJbo4xIE6r5GJQGdP+z7cdQmNnlJsUqeY+DCsTtk+r2Th2WzE32aCDul9/kJ?=
 =?us-ascii?Q?ErIWSOVfTcoW/1qOU/H85s3S92Dxx2hTPhTjrbR7UAQsC63nOs3W2n2uB1yj?=
 =?us-ascii?Q?2dM0KpK0VrIJ20w3fKD9A7VUUxlzTOH3hqEQw2JKC8ODu9KNy8uspzoCndjI?=
 =?us-ascii?Q?4eNjUO8kRR2b9TfVPPzpHqY3C6Cic6E5ltFukZkStBPY4fMl4WaI2EiZuKYX?=
 =?us-ascii?Q?1kgpBRZQKNavO5LVBAfiQhkdqSpHF7g4y4fnH3q47nr0KDL8QYFOLKaf7SdF?=
 =?us-ascii?Q?cLgzYfNBhjBp6DWkCK4nxELyoEW/CmosQKUuQz0x8rHwCsqB+qE0ham7EjWX?=
 =?us-ascii?Q?IMNaGaUdvReTw0ee/38qbudKc+GfNNDbBvLPEGy123NwnsE+2b1zHMPqYLkm?=
 =?us-ascii?Q?pI8sgoUMe/mM6RWGmUU8m/fFECCMJATbmZukPPex5VxlzamQ94NcaILz6Yy/?=
 =?us-ascii?Q?ykQt6xf6yBpBmpyauCSy7R+JBTVHtC7TLNAO+wq28WRpLotuFgfiBxNgEdNf?=
 =?us-ascii?Q?XzfL+mCNVNEhbu4lBUzK5t44htmtZg18BQnGh5O94WvaEMwUJeR1uw0beSQn?=
 =?us-ascii?Q?CjN4AONnCVrVIo5iZz4YBm+HBzhARtS7grVEPMhn+kvf0Vib+MaLI39jBr2g?=
 =?us-ascii?Q?JzGnzJ8GSJluUb4iYXcRKRkWeDGeoFImaDJiOdThJvmWrNqw/PK6qcjiicvG?=
 =?us-ascii?Q?C5EF4gqjN/iQq8rTXUxwmeQlH6YAMJwpxV54GpXC+h5DT0VL+DomVa6SPeJJ?=
 =?us-ascii?Q?FImwGE93TkdgPFCX+7l276Vx/iBHUBxuC2MUbyc94cdJLqiund78PTi0LD4M?=
 =?us-ascii?Q?+eHNRcdpkqAAbqcV99Lu9h/y0dQJ8o5niICMb9RDdx7TY6+oUEz7VKDnstlk?=
 =?us-ascii?Q?hJB7diaDJqFfHKkj7cEAf5dTOQi+WU1kgJW5HsuC/mXSK0KMY3VI5+5mqeRL?=
 =?us-ascii?Q?nFh/Aon2RwfJdhELQC44L30L2Iln4btDEo7/Dh/BEv3/WIWUZKdj05fpkYbb?=
 =?us-ascii?Q?mLYroE6wl3yBwmcxIWcEwbOmXeckiKOwHnWIsEZlGlQeNKtkpvfzV4LhtvjW?=
 =?us-ascii?Q?ORL3kGTK+GcG7zS4DSxdev0Wr78ys5GDA10njowQN+960iaAW/+4gq0p1j5f?=
 =?us-ascii?Q?Lbzw10SxhSTnDTzdhidbHPliz58WkcSgbkSIxKLmt4g6JKCKcJ+yqBPvonK2?=
 =?us-ascii?Q?LY2b6QM7imOTCMR6GxPwgw+ykGzO3oT+G8MEAQBH8S8Y/qQT4SfL0YyrenFp?=
 =?us-ascii?Q?kW5sxxWyTcQwfCub1zuozpudmjmYWKLLcl4lR3tfaeYXoCaLkEPMZyGYGcJT?=
 =?us-ascii?Q?BCyGl+tg4QM/4C2wXI+KKT/AcDPuBFndAPvE7mJGxXf1H+kYaVczWsKX7olP?=
 =?us-ascii?Q?/0Dp+uCIoZExNMI3DQSaMH7290LNfqQo1C81bmHLrVtBmxRWwbE773U10ABe?=
 =?us-ascii?Q?deWwGHE+eugNSw9qGaLODktVV15AsOP3kBh/6QQorxlwx74b8kr3iYIEmdmL?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b09852-b58a-4e6b-a375-08d9f29bc6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 05:01:52.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUWscUgtrXBqY2I/Tz4P2HtKmZqs+LIzZUqAilj8mtfJDrILGPm/nhMEj4a2pkybSucjmqskD4izU2xnFQ+MhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> Add support for NVIDIA Tegra general purpose DMA driver for
> Tegra186 and Tegra194 platform.
>=20
> v18 -> v19:
>   * Use function pointer to call pause/stop_client() in terminate_all()
>   * Remove unused arg in program_sid()
>=20
> v18 - https://lkml.org/lkml/2022/2/4/379
>=20
> Akhil R (4):
>   dt-bindings: dmaengine: Add doc for tegra gpcdma
>   dmaengine: tegra: Add tegra gpcdma driver
>   arm64: defconfig: tegra: Enable GPCDMA
>   arm64: tegra: Add GPCDMA node for tegra186 and tegra194
>=20
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  110 ++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   42 +
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   43 +
>  arch/arm64/configs/defconfig                       |    1 +
>  drivers/dma/Kconfig                                |   11 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/tegra186-gpc-dma.c                     | 1505 ++++++++++++++=
++++++
>  7 files changed, 1713 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
>  create mode 100644 drivers/dma/tegra186-gpc-dma.c

Please help to apply the patchset if there are no further concerns or sugge=
stions.

Thanks,
Akhil

