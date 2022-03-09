Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15D4D2A4C
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 09:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiCIIEl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 03:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiCIIEk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 03:04:40 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B49611C19;
        Wed,  9 Mar 2022 00:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNM2R+bsKmPCgMnHFe1OKoQUKbsTVBLUGKFbsCGbucTKDGJtXnqB/vz720EwbPYrHxQ7f1u7l2vifYLE9F5EdUCeR+RMw6pZaiF627KMrAtNLFqIWjCPRAPYcLg/2M3BGQ063eLjVB2Jy98JKrlTtbuC7zwU5nzeLeATVRngzBzYUKIVgmSQdGXvnC1xMvXBoqLl2Fx/8cy8HY0w1VRlemox6lWn5Gyz24UuZC/tufwnDdOG+tCqPMa7zin/XgsNrVcc+lawYpE+zWvhyR1HJ9Mw6BrzkAZgwGXV9g0LKKZ/qpin7BMHP8cRi2gvq1QLtUU+GjvCCnWMwPZ6ms8TGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//C6P/1dZQ5q3dpZxoXPBJmh+nfI0jfd9XpqvFvITAw=;
 b=ZsoAM1GLUO8jb9ErxOPOQtcw+14dCA13zpLZl85Yniq4llWe/eQA8hdh1XJVog+0ZaZufLPmQkglYir1+F78m3pdrpxiQVdJOK4mX1hiyE90C/5Sa6u309khnhuoXG+xb7qXG6m692ZFhpcrwaNAvZmA6t2JBRVNpFxrgZObkvAXlvMjFpYi/wp1DEkGbEmGITlsZNOqLg+xFzCKdiqMiBQwl6BCdteQ64JaDv/K2sCrToR78zRyBvHU5W4g7ioiyKg1gCCjzvrSrWjwFnvBp6+1PhWwXDHuqSKGgnI6Gogstmz3L3xAqP9Qjep2yK8KRJZPQV+T1iDifmt0y3Q+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//C6P/1dZQ5q3dpZxoXPBJmh+nfI0jfd9XpqvFvITAw=;
 b=A/B++sRoPDx7yHzvCEAKPjeil4CVjOeJZCYYcg4gOqcix0RIMlDqxN/SZ8fgzRxaKuuNcHo7KtVBqra+DsZjDmybiiAAFN5Tkd75LyPJK/gFO4p026ExGqPt0Y5cDbtCfD6RBH9rERIp1gyMVr/cVymSWxBJN4x8yA3TkapgmCPJWGBr6gUb2/QN1gi/IHHvnniLMWmaQftobeOqlE8p4G65e6YC6FwN6Upyskd7OS9i77qXSTZJv/4vttehVXjlwJdov7Jix/FQOK4jkWDufZvw3pw0OX7nabzSfIfCK3d/RJ0fw4tCZhSZ7tcdjMCtsug5Q3jfX1zr7Q0B+151sA==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 08:03:38 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 08:03:38 +0000
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
        "nathan@kernel.org" <nathan@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [PATCH v22 2/2] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v22 2/2] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYKkq3sIgCtUkR0UaaISCM2siu9Ky2vhCQ
Date:   Wed, 9 Mar 2022 08:03:38 +0000
Message-ID: <DM5PR12MB1850D8FF27CCC948A2259FDFC00A9@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <20220225132044.14478-1-akhilrajeev@nvidia.com>
 <20220225132044.14478-3-akhilrajeev@nvidia.com>
In-Reply-To: <20220225132044.14478-3-akhilrajeev@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 390f29fd-f3f2-4f47-24e1-08da01a351a4
x-ms-traffictypediagnostic: PH7PR12MB5808:EE_
x-microsoft-antispam-prvs: <PH7PR12MB5808815C7AC6880347ACF250C00A9@PH7PR12MB5808.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vVf8tss6BiAOnqzntCmmENULFZl0SmRfx9qDQ8wLNd6EzMdqQv/a47pAVZ/rOEPig9J9LMLHEkcA8Ts95FjDPhZrsBGQYOSFEmNTKHvGvbSDefJb7tpW4kPN/ILW874umJWxWUE5ZsqvVLmAEkuH7KM8vTErwdG2qy0PFh5p632XCp5CBRSeB0a/+c3igdxGGH74yJxkBDqFfr0gEieOz55QGI1Hf8YWSF8WCmEbX9c7GcQnwYoRhJ+jgkMain1GV70iWUFEYnuvKSry/42pN15UwUu2ds5hJXbOr8zeb5PZ2U75PPEbl3WwzhAjtgY7LovEoiijSurtG/wIoe31H4V6BLCrWE6nxBx8qkSg4nouWlIBVsnVtOxsz3W4z6gQJW6yKyKTur61NhEg6PbVpEJWBrA5tDZou3q+4psObY4xa4cBE/3xEAocsHYiwJN7g9rjoBV7m+zzJqx2RTGl25bqdsAHaLd6mEH08ivFIcKXADr+oYbEOnFCBaT17mkC7yZTMBWztaM474sSs8DidQEMtIlaq2PSPpFNLA/QCpqHfxJqsghI557kCv+GKpthpNDEqO4U92No5gzvmlqe8Sbqn180V53lhWT5bGxCiYX+tF90v3z9IAypYNZk47oWdmzXHjHhdPGu1+XXTKLsUSmzLjCjEg2fpbHfTG6ev1Xan+6TgsssWeQyTKT8wOB5w2NC+Gg/heUcsMoiwiFhcinr6mKdnJde71JAj6hgop8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(55016003)(66446008)(66476007)(8676002)(4744005)(76116006)(508600001)(64756008)(38070700005)(66946007)(52536014)(9686003)(8936002)(2906002)(122000001)(71200400001)(5660300002)(86362001)(7696005)(6506007)(38100700002)(921005)(110136005)(316002)(33656002)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QWwbIecFYoRxpi1fvR72gQ/OERYp2VSdNZ8CDoqEas1jczR/shmt7Dpos1EE?=
 =?us-ascii?Q?soWR0cIPmM5RwSxOortNpJIAMrpPlhmsH6oSdJDKj1ikE1g24JWG2qnnhgPS?=
 =?us-ascii?Q?C76sCQvbL8lWz4SQOak6DOmiPihQvFL4/hj1T6UrMKPi5bAvWl+W/XGD6fkV?=
 =?us-ascii?Q?2WYqJvDCLueHaSkOlKhbAupY6YzpHPlim1QUqNFsDt5g4y+K0y9AhvhqQyWw?=
 =?us-ascii?Q?uYn5GYm7h/MnUgUf5PDSMjTi900IU2keddn12pLHxenC/kOplTykU1rhEBoB?=
 =?us-ascii?Q?ww38/+v4VF2MEoCMHz3d6T6GEdVNxJU4ggacsmcvdsP/am25hkwUWhOa3Qf8?=
 =?us-ascii?Q?dCkFX1bGXzKDL1uRgh2dPiGeCiizOqGEmxoLdFS9LoAcmyRVt9Js13qMtIlx?=
 =?us-ascii?Q?xbW+PLsN3Xi6Cj519RuxCdbL9XGYSFfpwpDNctt3+7HALHS2ZKfnumiIuLYm?=
 =?us-ascii?Q?IdHL0hotcohgVJx30Mh02ZiPxX5+pUxLq6IWvt9oVtCFvSMA4f9qrJJICeYO?=
 =?us-ascii?Q?Y5zOcEX9dOcq3DyPkaiK6zmZW6qs+5YzA9pSKZ1UOapUlhVV0bIGiMDsdB4R?=
 =?us-ascii?Q?TxVv+yJ2qMl/pCq1SCCxOjBIE8aBJiQsPOOgLz4IP2e+5IBDSzFxJX0J3ao2?=
 =?us-ascii?Q?nexL7nwxEpAhbrGRigdHT96ZOfPusoWTXIIw9nPjMuLv85yOAiAUFSyKy8cg?=
 =?us-ascii?Q?KbRGOaE+D/jZbtivYv5/RccsxtRcE71BStMDSb6P9XYcY8GWa1oVcZVVCkUj?=
 =?us-ascii?Q?S0WwXc+GKvTXg6JCv6+i5kSAi8Z3tTmtr5PJ0D6ygeCHTqugR/pfD9A0JzrD?=
 =?us-ascii?Q?+nsD9u4Ow3iXcpNrugBjp+LrhLHONLfFL+0kRRMqOzmGYRb5DP6BSeEL/wHi?=
 =?us-ascii?Q?Td95+vN0VdBuFq2ieN5Jc3nmS2aFcEUZxlg6ZckdyOG12cyzUdWarp6zFdM6?=
 =?us-ascii?Q?ly2ESSqvCeePD96WMFX+1q4tBjqythYVgdSmTaFqtOGCPnKJSSvpjbmj/ZAQ?=
 =?us-ascii?Q?CWpqgp1GLnpfjjPP0oZ1te9TBrRGQjHJXNqD4aEhe5H6/JxvHtuTIPoqhH/c?=
 =?us-ascii?Q?ZdEvJukU0jtxwx2exRlepkcEbWcmcCeHZLULZtmu2+VBVQ2FOsOQBbvNiDut?=
 =?us-ascii?Q?vps0GVJrlDX9rq+1xeSBtSsS288PyLTqOIekgmWdF0JXHjkibCMoRgECiihY?=
 =?us-ascii?Q?ha79ncUgWg0Eu0HnIdtyelC7fYm3/GwFKh45JtQkT6B64JeHtJsM5evPEWb0?=
 =?us-ascii?Q?w0ulr2P+UAbrLxrfM5oqL9K2LtuFyh+DFGdO03kHgfquNiefo8ZfR7Tpj6XM?=
 =?us-ascii?Q?wnoNsBrmiww2zDrAMPRQSO25mapEq5ELdInOu2cGIIjMY0CgB79ahqmNjNQh?=
 =?us-ascii?Q?xkBJzSdTdzY36gTFiFFftPmh/XeY3rgJ581EenFic2TJ9ILL4RTjgVbjKEOE?=
 =?us-ascii?Q?5M4iq0D/RilFfqxcLGqogF6LOZYrO80j7ZY2IQeRJL7GcpEkqJKXoZy+kHlD?=
 =?us-ascii?Q?xkJCuoCA+z++YUtpuvT+/QIvSp321REh6gp/Snl/w9OYVPO9OQd0oqEaSo6b?=
 =?us-ascii?Q?WHu0417XcwhEPaPKtIu7i4fIwzndtEe/vutd8vz1j6WmqJ/e3SjRXON+Mghe?=
 =?us-ascii?Q?UHkVnoWnE8XJLxKU7y2muIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390f29fd-f3f2-4f47-24e1-08da01a351a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 08:03:38.5636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvhiYGWBQrrk4j7Ybf6PwQp8q3hURfksbQuLBzFaZ7HXh+sDPKXR/2A6C8Q40bG2Z/+veRRua7bRWrBh7xbOEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

If there are no further concerns, could you please help apply this patch?

Thanks,
Akhil

> Adding GPC DMA controller driver for Tegra. The driver supports dma
> transfers between memory to memory, IO peripheral to memory and
> memory to IO peripheral.
>=20
> Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/dma/Kconfig            |   11 +
>  drivers/dma/Makefile           |    1 +
>  drivers/dma/tegra186-gpc-dma.c | 1507
> ++++++++++++++++++++++++++++++++
>  3 files changed, 1519 insertions(+)
>  create mode 100644 drivers/dma/tegra186-gpc-dma.c
