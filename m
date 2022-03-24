Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6494B4E655D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351059AbiCXOhS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351053AbiCXOhR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 10:37:17 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20045.outbound.protection.outlook.com [40.107.2.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06540B5F;
        Thu, 24 Mar 2022 07:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6QTwJgVwnFqnAor2wJgnKdGcduSzGEY28YPF3TNJf1p9Pfn5zhui25SZe5bl9+VdLrC/HmP9YkbI9lNmrWuEAtjZ/bVI36mY0cRPnBhVq5G03NjTzdKs2HCLVdoiQYjlpnNyubf+H6XnDN4HBX5t4B5hMG5ehFLEAmMEPm3gxySsOHuXIsy0KYB+8zFN7ii/XbnxAgAVxyNfG0acRIjisvIjinxm6tLKXJ4ZmS3a8gcuqzusnspAnY4W2QgxGzt8d4Aw6UtnFwqLC6QM/rkGPQKnb6eLALERbfprd1zl7zsn2MmXHY+ZlLwsVb1o7uSSsbYVDrt4ygKSeSlwKX94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ2sEWB74BPqbeT5jvXs+01zKssANX2LSoP2T1W0iSk=;
 b=XLl52QDuVBIU4QhzKVc+3gPJjb0SZ1fuvqTbh9cpmymMTwsCTFfJbkJoGe0aDbfoabZNV/KcMrjr6VcBh7QDyf0P34SWDcDW6Co4/3BAf/1IWKRhZNUKQlcd9IlApbS74k5SNQtOWX7z5XOhr24rEM/pfAwSQ/21f45LEtDUa9qvURlAD32vTHUnqioJGfHeTn2jwUqH0zhLXhRY4IAxUrojDMHvnIyu9kZUkq+EIJ672J7Hs2xiybcMLenVjncWEWzCijcmAj4dNao0BjDnDzPq6iADD35EGXuMxs/iEPVVxTK5nYcpXXLyqFU2/v1+NmjlZ03ldWDTwECCUyoX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ2sEWB74BPqbeT5jvXs+01zKssANX2LSoP2T1W0iSk=;
 b=FTUxBjAbKDH4tj+XY9xXPXp1viP7ayL1UsVAYUw3GLJd9FGM6dWOrk4VuLRy5o84sD9hMvn4lscGToWHTimU4mllOqkfveo/VC6UynJvFnsASlPPJSOIaqXdQmqhJRcjO6ny5IkiCWkMSrN2myOmeSVPD/4xAKFrmZqtsrdJAfI=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR0402MB3764.eurprd04.prod.outlook.com (2603:10a6:208:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 14:35:42 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::bcbf:f029:4f34:1be1]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::bcbf:f029:4f34:1be1%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:35:42 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/25] dmaengine: dw-edma: Drop dma_slave_config.direction
 field usage
Thread-Topic: [PATCH 01/25] dmaengine: dw-edma: Drop
 dma_slave_config.direction field usage
Thread-Index: Adg/jC7s1tot06cvQ3KYPrTBiXTrlg==
Date:   Thu, 24 Mar 2022 14:35:42 +0000
Message-ID: <PAXPR04MB9186A02D1A0753A6E1000A0188199@PAXPR04MB9186.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a48e2ab-8154-4496-9f30-08da0da39303
x-ms-traffictypediagnostic: AM0PR0402MB3764:EE_
x-microsoft-antispam-prvs: <AM0PR0402MB3764DA75393E4CE0671912D188199@AM0PR0402MB3764.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eF3qbKuq9L9kdbPIfget8FGcQigKWXv1NKhLU7pjd5tsL8EThvNNda5wX4i14X2paIftOjUcj4Ky7TH2V1ZDsIu2H53serv9JFTKnJGTJwI7RFXypEsc5OMZXNa9fHlLEulLJlLlmiInN0W3QmQ0evsdSTN8uKB4/nZDywRJwp7GIz93PYCyssQI5qCYubMT8Jcsp49Q+JI3iovuvrrS93znSjY4dU0MfzF6c7c4GN+5iF5t0CXPi4cDameTMQ9e6kt1Z/zNVUT5delTVyXeqPAE/mbunWWeWA9VA2SHRq9mksSEgZCbIBIaSZPIPFSLNhhdEgmUG24S4aHI3n894im69HOs8mMa58drrqU2stZabRh1ayrqdAd4ckVVOwOEg3Buehk0PMOc4M3cbdUGjV9tGvt0efvjLcK9YND550LNkL+boL+0ng6/oGG1kuD0O2ZVPiqNz13C/dlYJvCX04qTiBtS4MkFNyLq+dc3YSolU6Mm94ezymL8JQOYyjNkTgSk8agcjUUXgbuoewtuFzgcQcIWhoTkSk9rOMr05JjrR6PWub+IU0h7R+lh37VPYvXBFymx+kQ43xW4Oh43ywQPmtbyVlflp6ug6JWKWXhIlkbFJUym0Od5h9UHeAwXE8qOGWFpdNXgzUw0DXt4kElbp9sNXYinNlTuVQ5BoTYCJ1cBYwaHNdALmkYKJ7+Uk5Ds2NLf/S8RKrVlJVlsyAV3fZMGJ5cw6C6QO+b2F2pAuTcLZRdKDqZguMzMblil30GXp8gdqeoqxPr03qCz/ptQyzA1nmmyA9VhCFlZunA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(66574015)(6506007)(186003)(55236004)(53546011)(9686003)(26005)(83380400001)(4326008)(5660300002)(8676002)(52536014)(7416002)(44832011)(8936002)(2906002)(966005)(71200400001)(45080400002)(508600001)(110136005)(76116006)(64756008)(66476007)(55016003)(66556008)(66446008)(66946007)(54906003)(122000001)(316002)(38100700002)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?9P9Jlc5KTQnj1pLa+HnfWYQY3tLAP9J1Y28xBCpsdR/C6pazOcorzYlUIe?=
 =?iso-8859-2?Q?eSZUp0y5OimS+kH0/BKrwp2o3kSTk6phYhZH1a15IU4Yxx0LaUeHlyP2to?=
 =?iso-8859-2?Q?07EqzbWYFG/PFUPiMvdy5fNfOXVlLDZYh7D0OV1hOx/AfTWL+e+RSSxDMY?=
 =?iso-8859-2?Q?pQThGXh0p79mMqr4QEzOKFNd/nkADDjbrqB1+Gkdf28zxx51PMtulc3wNi?=
 =?iso-8859-2?Q?OQt9Qar179+/xvtdGP5bnA6fKxOHJ+Z6495a53U2YEdi4mUA6YKssLcs7u?=
 =?iso-8859-2?Q?eEmnJ/NpXB0dVXSTInj2AjLE/+pOb5OMJMdJV0Sa0ITjsX8cSn2ffUZuaU?=
 =?iso-8859-2?Q?cdUUG/6ZWmnYv+kOoqBKDkR0efrLd6mV+4BsDKDN1ZPO7repL812ZOP8qy?=
 =?iso-8859-2?Q?sGkzPeBqmFMG62U8Mq/RswTQ1ywgMPHTsK0RfnxNsiqOxWz1AbkoBIGEvD?=
 =?iso-8859-2?Q?s1+0lnCvGR/pxXOxREVffbwoNpND1zt9s6NPS7eW+xcvQt2cx0E4k0bfrS?=
 =?iso-8859-2?Q?ZO3NhoP5Uck3rjkaJGIUUFaRDkRkewstV/hp42/zJYrFzpnr5ef/jneEQO?=
 =?iso-8859-2?Q?+BuJTHoU9VXiYzinPV+u2XcaEVrpiqsqcIe9uyW/vjCZjRtE314jn+6t3p?=
 =?iso-8859-2?Q?LjhdrbYcF4gbK0gewV3TklbpI6+Rk3965M3C6IHqLNpQSU2myaRr3JISPD?=
 =?iso-8859-2?Q?IlQ6BaFKb4pIsZQopV1aqXdgFFt8mRQDJY78/mFWMoKCgrzKr5wtSH7t5B?=
 =?iso-8859-2?Q?0dOZBrE0xDE8mGxHCkjIxOqj9tatblueHUkPLC+935NwDV+6pVk387mfJF?=
 =?iso-8859-2?Q?gE6IbtT0lQ1uNsZ7wW8eTjekB1eo7+xNrLyK2kB1nGvbZJU+EoFKOzg/Hg?=
 =?iso-8859-2?Q?rle7jyT1jCVUrYyoEjUe6svtAX3TFTn5PK6ctETBxA7OjQj8p33a1nDjUh?=
 =?iso-8859-2?Q?XrB9BZdFfdozYHDWhNhx4/HjPUKvP/QmzV7QfLq8287dzrGrs5llUtXkA0?=
 =?iso-8859-2?Q?ZaxXp+tVE39x6xWzhLTj+a5MYHPDsoacOBf47FDSQZ0oYhGJ7wt7prh8G5?=
 =?iso-8859-2?Q?A9dD0Ub20yBikvWG2+s+R7cVWlHEEU+WDHRfP/RC3FRf6TcwPdsUzuvtyJ?=
 =?iso-8859-2?Q?JtXh4hd/MC7Qq1cr51PU2hAbv9I8Qc3ZxehmxlQnS3YnCHRb+peRjZmAgo?=
 =?iso-8859-2?Q?9JhV4mS2G18STrIynPiyMtNbSFQQj7OpkXgO7bUJy4NSmput0JaNQX1qKV?=
 =?iso-8859-2?Q?QsXPZjOWWuZbC1oQSQsvzvHKHH5z6mjRtz0yOrg5dKNomeGQj4kCt4i1/n?=
 =?iso-8859-2?Q?JmtoNNaCVUlD0yUC3Qa4uH5L04KGv4wss3oshlqWGIbVzSPD/+1tdrDVWQ?=
 =?iso-8859-2?Q?E2CYSQNmf0Q1xok0Ys8/y279trgivEsfhfRKdaad2+Yn04yOwsgghcVWHF?=
 =?iso-8859-2?Q?zcV5k6Agm/2LJ3o7s326OTCL+b6gVPNhno/GkkEO6oJchhbZ4XnvGGTVjp?=
 =?iso-8859-2?Q?wM8rXx3E9GKLoA0dwNIhn/0eNedr/xmrXslQ7P1sunts8o7DXtt2QDACFQ?=
 =?iso-8859-2?Q?+FseUWcC/66OyIK/fQvsHYltcgElzwqkvNhPRS3fiLjIJG5dY6zy9mwsA9?=
 =?iso-8859-2?Q?vxhnVw9FGbZ8SxaBFcZKSFduLAciyei9iuRjlBSXOw9/IDktn5k2uu6BMt?=
 =?iso-8859-2?Q?jIhalrmwRI8BxvavxlLB+o62jp32mPiHrSUy9Xgd+sH0S2/5MoHFqFaUR0?=
 =?iso-8859-2?Q?6NUmq6zrjdVnSNrYbQVH53hKkGQ7vYDZ97ehZcHtNjfwYfQnNUwOLd+VXL?=
 =?iso-8859-2?Q?/OmkuJ3Tyg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a48e2ab-8154-4496-9f30-08da0da39303
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 14:35:42.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mveSLIR7JbFklfPrFd29Jr4cjlgGb6h1SKyVnz7XXnJFlkgUtWQqGl9aBkalEblqRfPIh6wT11NMDCqNbsP9qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3764
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Sent: Wednesday, March 23, 2022 8:48 PM
> To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>; Vinod Koul
> <vkoul@kernel.org>; Jingoo Han <jingoohan1@gmail.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Frank Li <frank.li@nxp.com>; Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; Serge Semin
> <fancer.lancer@gmail.com>; Alexey Malahov
> <Alexey.Malahov@baikalelectronics.ru>; Pavel Parkhomenko
> <Pavel.Parkhomenko@baikalelectronics.ru>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Wilczy=F1ski <kw@linux.com>; linux-pci@vger.kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] [PATCH 01/25] dmaengine: dw-edma: Drop
> dma_slave_config.direction field usage
>=20
> Caution: EXT Email
>=20
> The dma_slave_config.direction field usage in the DW eDMA driver has been
> introduced in the commit bd96f1b2f43a ("dmaengine: dw-edma: support local
> dma device transfer semantics"). Mainly the change introduced there was
> correct (indeed DEV_TO_MEM means using RD-channel and MEM_TO_DEV -
> WR-channel for the case of having eDMA accessed locally from
> CPU/Application side), but providing an additional
> MEM_TO_MEM/DEV_TO_DEV-based semantics was quite redundant if not to say
> potentially harmful (when it comes to removing the denoted field). First
> of all since the dma_slave_config.direction field has been marked as
> obsolete (see [1] and the structure dc [2]) and will be discarded in
> future, using it especially in a non-standard way is discouraged. Secondl=
y
> in accordance with the commit denoted above the default
> dw_edma_device_transfer() semantics has been changed despite what it's
> message said. So claiming that the method was left backward compatible wa=
s
> wrong.
>=20
> Anyway let's fix the problems denoted above and simplify the
> dw_edma_device_transfer() method by dropping the parsing of the
> DMA-channel direction field. Instead of having that implicit
> dma_slave_config.direction field semantic we can use the recently added
> DW_EDMA_CHIP_LOCAL flag to distinguish between the local and remote DW
> eDMA setups thus preserving both cases support. In addition to that an
> ASCII-figure has been added to clarify the complication out.
>=20
> [1] Documentation/driver-api/dmaengine/provider.rst
> [2] include/linux/dmaengine.h: dma_slave_config.direction
>=20
> Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>=20
> ---
>=20
> In accordance with agreement with Frank and Manivannan this patch is
> supposed to be moved to the series:
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fdmaengine%2F20220310192457.3090-1-
> Frank.Li%40nxp.com%2F&amp;data=3D04%7C01%7CFrank.Li%40nxp.com%7C4918ae854=
5e94
> ab137dc08da0d386b3f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63783683=
32
> 30354384%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
Ti
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DejkihPy4A5spPj%2BcCgZgheZXdWd=
nvRQ
> 52SOE0wtDqMI%3D&amp;reserved=3D0
> in place of the patch:
> [PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "directio=
n"
> member
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fdmaengine%2F20220310192457.3090-7-
> Frank.Li%40nxp.com%2F&amp;data=3D04%7C01%7CFrank.Li%40nxp.com%7C4918ae854=
5e94
> ab137dc08da0d386b3f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63783683=
32
> 30354384%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
Ti
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DqedpXrMGAR9frJWydd9Q63hZDHTYf=
%2BE
> ScsHfIx9019M%3D&amp;reserved=3D0
> ---

Did you have extern git, so I can pull patch from it. Our Email server
change patch's format, which cause git am failure and https://patchwork.ker=
nel.org/ still
have not this patches yet, or send two patches as attachment to me .=20

Best regards
Frank Li

>  drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-
> edma-core.c
> index 5be8a5944714..e9e32ed74aa9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -339,21 +339,40 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er)
>         if (!chan->configured)
>                 return NULL;
>=20
> -       switch (chan->config.direction) {
> -       case DMA_DEV_TO_MEM: /* local DMA */
> -               if (dir =3D=3D DMA_DEV_TO_MEM && chan->dir =3D=3D EDMA_DI=
R_READ)
> -                       break;
> -               return NULL;
> -       case DMA_MEM_TO_DEV: /* local DMA */
> -               if (dir =3D=3D DMA_MEM_TO_DEV && chan->dir =3D=3D EDMA_DI=
R_WRITE)
> -                       break;
> -               return NULL;
> -       default: /* remote DMA */
> -               if (dir =3D=3D DMA_MEM_TO_DEV && chan->dir =3D=3D EDMA_DI=
R_READ)
> -                       break;
> -               if (dir =3D=3D DMA_DEV_TO_MEM && chan->dir =3D=3D EDMA_DI=
R_WRITE)
> -                       break;
> -               return NULL;
> +       /*
> +        * Local Root Port/End-point              Remote End-point
> +        * +-----------------------+ PCIe bus +----------------------+
> +        * |                       |    +-+   |                      |
> +        * |    DEV_TO_MEM   Rx Ch <----+ +---+ Tx Ch  DEV_TO_MEM    |
> +        * |                       |    | |   |                      |
> +        * |    MEM_TO_DEV   Tx Ch +----+ +---> Rx Ch  MEM_TO_DEV    |
> +        * |                       |    +-+   |                      |
> +        * +-----------------------+          +----------------------+
> +        *
> +        * 1. Normal logic:
> +        * If eDMA is embedded into the DW PCIe RP/EP and controlled from
> the
> +        * CPU/Application side, the Rx channel (EDMA_DIR_READ) will be
> used
> +        * for the device read operations (DEV_TO_MEM) and the Tx channel
> +        * (EDMA_DIR_WRITE) - for the write operations (MEM_TO_DEV).
> +        *
> +        * 2. Inverted logic:
> +        * If eDMA is embedded into a Remote PCIe EP and is controlled by
> the
> +        * MWr/MRd TLPs sent from the CPU's PCIe host controller, the Tx
> +        * channel (EDMA_DIR_WRITE) will be used for the device read
> operations
> +        * (DEV_TO_MEM) and the Rx channel (EDMA_DIR_READ) - for the writ=
e
> +        * operations (MEM_TO_DEV).
> +        *
> +        * It is the client driver responsibility to choose a proper
> channel
> +        * for the DMA transfers.
> +        */
> +       if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
> +               if ((chan->dir =3D=3D EDMA_DIR_READ && dir !=3D DMA_DEV_T=
O_MEM)
> ||
> +                   (chan->dir =3D=3D EDMA_DIR_WRITE && dir !=3D DMA_MEM_=
TO_DEV))
> +                       return NULL;
> +       } else {
> +               if ((chan->dir =3D=3D EDMA_DIR_WRITE && dir !=3D DMA_DEV_=
TO_MEM)
> ||
> +                   (chan->dir =3D=3D EDMA_DIR_READ && dir !=3D DMA_MEM_T=
O_DEV))
> +                       return NULL;
>         }
>=20
>         if (xfer->type =3D=3D EDMA_XFER_CYCLIC) {
> --
> 2.35.1

