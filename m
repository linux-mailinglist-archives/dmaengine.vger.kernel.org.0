Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778C7568B2E
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiGFO2q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiGFO2p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 10:28:45 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20071.outbound.protection.outlook.com [40.107.2.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF821AF09;
        Wed,  6 Jul 2022 07:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikrjjBOC4CqF+RG84djj1jMpJUflMsgnJhd3eVURdy/zLyT9eIeSgQx2HWR0fQG+Sg80gw0dByerbiOM3agruVWCfl4BSni4zC8ytmnAmIumlgZB+noWhgEmo8QEUMRQ9CfhzNuzXQB1pddOz4oU37XgML5cB8qS+WzRwl17la+1uMGvebhcjRJsIUHR5CMpZRS0yz/8L1FikafvnH04j6TfK9sjsoHuX4bz+4BmUwiZiBFgNvcN6h3DhzpmJaVszQKxMJJuVdppeXfuZdv55E0XaSsxrlo6UMvfRGJKYo2ud8WiELQ9Y4xqCcufe95CHeI7SG/LQFUAsJV/gKYkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msEwO44cn3whtKQM1E8KdGnU90Mk1lt0i1k0U4E+2xI=;
 b=KnboCiLH5DDsIx9dkS0LJHy7Pvbkk6AVuDYXbwtSUj+fbmnyP53KAyB90TFnAXf/8poX7eRFZjSYy0xHbP8wpPnTfH5Ud3jjxdF/69PIDMr2IiQ7uyBcO0TPdYnQ5uxGDqfV/aWz9r5vdJiM6kGAPpCK4jLlh8SL4gLxMUnYqjQ9o9xuj1F6Hp71xFDbaOSAKCjxeGN8Tf7vd7IxwY3GcEfGgsD6dJx1JLF5LPWx71h45lY7znUJ/WK2LcifDIdbTUAC20E4WjhHjSWul5braPXh2Vm4ewDfNiKw96hnkKtWUvzWchKUoH4PaSJ9s5m/3yWhi7nsSFOdoaREew5eQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msEwO44cn3whtKQM1E8KdGnU90Mk1lt0i1k0U4E+2xI=;
 b=nSFrM/waaahGn3tjGWZWC/cQUr5EB4ous5j58Nwm1BEcOyP0Pk66OhlbUihEAvMje+0kkwlyGt9Kulll59NxEt/gmZy7QzHpXxmSHj9P4lsN6Tqqebl7oqxj+Nck0KTSFFzZwrJdILt3M/y5mkiXNfdJNteOobZPSO2G25Jl6vA=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM9PR04MB8842.eurprd04.prod.outlook.com (2603:10a6:20b:409::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 14:28:41 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e%6]) with mapi id 15.20.5395.020; Wed, 6 Jul 2022
 14:28:41 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: RE: [EXT] RE: [PATCH v3 19/24] dmaengine: dw-edma: Use non-atomic
 io-64 methods
Thread-Topic: [EXT] RE: [PATCH v3 19/24] dmaengine: dw-edma: Use non-atomic
 io-64 methods
Thread-Index: AQHYkPsz73Q9AgK9WEOSKJkbSlXaTK1xZxtg
Date:   Wed, 6 Jul 2022 14:28:41 +0000
Message-ID: <PAXPR04MB9186551C4A12F747C35784B288809@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <20220610091459.17612-20-Sergey.Semin@baikalelectronics.ru>
 <TYBPR01MB53418C1BC8791CB6D068A177D8809@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB53418C1BC8791CB6D068A177D8809@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7af5c55-83f7-4060-3429-08da5f5bd2fc
x-ms-traffictypediagnostic: AM9PR04MB8842:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S89dy0knfJcVQJyMZSGOeqyCqW9mJ2pSDSAIo59SUSz5tuA02OHgnVUooKjPq40aznikBgB93MCt8QdFGbqLGsgESDnV1wMEPm6Wp0Cio+Mx8lucCzfMruOqDbs+4WszCpeO4B2ZB27PgGHqogh30Np1Twmb/oGIQBHPf3YR213Q1+3mDnuU9tqLV5qLA+XIYb24fVWzlPcGwuCei6YP2Gu3NuJniAC8+Q/d2EkLFEyxSHudKs5GuoGY+En4Y6PFOU0xjlqIz8dbhMy9HBJfgGK0cix7eayK+DP/1j5O4h2Kz/3gZWAFi+sapAPpc3KzfvXhoNKQIM0KvfLXKm8R4eYBVsYBv/bgAQunRa10bS0KcXU/j0ddFUbkA0v76WAAyu0xMvQefGRWRG648ToUl4tJbd7Cmu1HebpUoXuEsB/3puqtAGBpKxDNPGAQETad2d6urhy/i0Rz0bPWA5DmxJcHWFiD/m3viXNgaR07uc+oi2qlMXyfYz41kSG/3rCsrGmLuJ1V/4aJzJ7QrBJnAZ8TLPrmHz5zrKJHDSYOfwHa6EDdVeU9ulq3IWKNCPQX3Uq2vcr2i6yWVO26VlSV8Ms/Is+ziDP6AUhgUU0x9hYySwCHhfqIUuD784y9MBE8lv3icFg3MKSIenPovPOM/tO1c7GAfYJEVcH18cI8Q8q6O4MzHnfbw0Kv673Hsd142pgCaIPP5Mjob0zrt9nGI6esU2ogmyk2KHYTTo0VZ/ywj+hmBBqR1iM/DBWPagJ0PXiQS5UdCCDCRn3OAVSF9uTwZiuSst/AycW8F+PeyZrWqE25BSna/jNZLF4Lt1W4S7VTbr/12S0vzEe4tL/8qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(110136005)(316002)(54906003)(122000001)(38070700005)(86362001)(4326008)(7416002)(44832011)(52536014)(5660300002)(55016003)(8936002)(38100700002)(64756008)(66446008)(66476007)(76116006)(66556008)(66946007)(8676002)(66574015)(6506007)(7696005)(83380400001)(53546011)(186003)(41300700001)(2906002)(9686003)(33656002)(26005)(45080400002)(478600001)(966005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?nJQIrIbADy1jqVjHEMa++0OGUxO5z/JoSBC7U8xG22vtJettJUWT86KnKt?=
 =?iso-8859-2?Q?B0125cUMlO01nxB9rjaWudz8eRi/pGBtdj0Izf6TttSPRtTmbRFKyxzdhp?=
 =?iso-8859-2?Q?UCE0xL6p0wvWx7tETLDD6zRqiC5fFHe9WtITQQVLxQCr+n4maxr7zmx7gX?=
 =?iso-8859-2?Q?rx/5pdqPJym88cF5uq2x/nb7oGUu2aTXb8eSeQlxuHLwhDhWr+QWt/ZYDL?=
 =?iso-8859-2?Q?nKEwPlBGw8BVOvRNG3xZDbK3X899QPuNVLD5z85E0GS7PGN5ExWImJteVe?=
 =?iso-8859-2?Q?bSqPpRXsriTuSYlZVZucA7Ns3+v7PavJHodO6xN683TTEU+tP0yFlGK/vk?=
 =?iso-8859-2?Q?G/HFpa71RFKIlaaqLWuUq1zJjavUn+eLnw+32UfoEFQqImKAp5HcEALqP9?=
 =?iso-8859-2?Q?w9PLHeWvFuotM4t+1vB99lacwSrhUFv0EFSg3yiI0wbLC/FxYCkiDz+p9K?=
 =?iso-8859-2?Q?or07A8Zwux+KFAT+O5m5iXGY1kKh775UZfEEo7dlL/U9MI1dqcaUGAdD83?=
 =?iso-8859-2?Q?MdItaZSjqTx91dM+Nu9SpGgM7UdB2Mk/oUEHADlqvGroYD0dalP/NfCus7?=
 =?iso-8859-2?Q?KIlXkBO7msKkbnnB1Pxgkzm4GEMm9OlnpAWeYMAtgKe9ZHXbT1PkAC22Hf?=
 =?iso-8859-2?Q?lVMu/h+AputIG6MZFblUpiqAsidwt9bz8YqEMeftCGncDywXZoJNHTcMx5?=
 =?iso-8859-2?Q?lmV8TAhZp63JwwphdnwCpx+Ij3kHD4NqJHVJ7LSdPDwlH+JRLTuuZqehdC?=
 =?iso-8859-2?Q?cWbpPJ5XfuuiUdKPwAjbmkzx2UXr63gH/FyQu8JcHZnqspuHtGbbXqsOf/?=
 =?iso-8859-2?Q?MvM37huXUIE52upT1s2JPKSOiODHTGgAPxgJVUN+iuRgPjHzItCNreV0P9?=
 =?iso-8859-2?Q?H78fRokkp3/lQltlHATpeGDikaMi1TGPLO94Xu9bUftgQ0vF0ZUQNzTNa/?=
 =?iso-8859-2?Q?ubrKu5XfliO5bvI2MB6x5FhOxQ38vVPyRKhP5YV6Rx2XHILUpFGvY+AmZG?=
 =?iso-8859-2?Q?r2P4DfwtIuqbdXfjVBLfo+LHEmnHPDQ5gn9U7fbA6j8a7awSmt32ocz2J5?=
 =?iso-8859-2?Q?UtwQDLhlSBKAtKdP9BAcwwv+YhDH524+YaZn+nvEKrNyEFX5tApkJm2VTr?=
 =?iso-8859-2?Q?miOPyyDoALcuB2ODqW8L47KIIYChal/qXbduXkiNQNIktLD8AQdKw+4OoD?=
 =?iso-8859-2?Q?RYeieginT6x4GwY9JPlaopYw+jhdaZ4N3GQ1HcMACbufWZCZ05ZuYIFcd4?=
 =?iso-8859-2?Q?VkFIiyWdImAZkmB7Wt3gFl95WBdfmBWNu5Ml68AOv3GUHOvKX6Tso4bN3l?=
 =?iso-8859-2?Q?k5ynH2KfiQ5nUf87pl8F/U6IXVtQ42ezW5R6VvSG+tcYP20/Uo4g0d8g/g?=
 =?iso-8859-2?Q?nV7HSLSEzJdMGCxHEYQBZtjmt9EtxDJz2eDsUWlzf0cHnNCQe43DQyCaWP?=
 =?iso-8859-2?Q?hdgsQwdEtGxqFAmbXAalXx7XhcI66UrwQfCXKzXZi8zi3mnI7H5sZYZlxi?=
 =?iso-8859-2?Q?L74eK/2efJKRuE4Ee39bNyyNHElPX12aJyEGToxNB5KDuxkni9+Pp611GS?=
 =?iso-8859-2?Q?0wV5rPUP1uEF4RxKD4kteBd6b35EHBBnJ6i3BfaQkLeRnNKipr3a5oCe93?=
 =?iso-8859-2?Q?12Cfh1jadWwTY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7af5c55-83f7-4060-3429-08da5f5bd2fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 14:28:41.2596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD6sRY4+v8i3KHq17Tkl2Bhsms3ghcOBAdgheVVU4cDLFEY2/W17S9XLH7QgA26MLGkfFl0ZIfmK6MbpuSVYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8842
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: Wednesday, July 6, 2022 12:43 AM
> To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Serge Semin <fancer.lancer@gmail.com>; Alexey Malahov
> <Alexey.Malahov@baikalelectronics.ru>; Pavel Parkhomenko
> <Pavel.Parkhomenko@baikalelectronics.ru>; Krzysztof Wilczy=F1ski
> <kw@linux.com>; linux-pci@vger.kernel.org; dmaengine@vger.kernel.org;
> linux-kernel@vger.kernel.org; Gustavo Pimentel
> <gustavo.pimentel@synopsys.com>; Vinod Koul <vkoul@kernel.org>; Rob
> Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Lorenzo
> Pieralisi <lorenzo.pieralisi@arm.com>; Jingoo Han <jingoohan1@gmail.com>;
> Frank Li <frank.li@nxp.com>; Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>
> Subject: [EXT] RE: [PATCH v3 19/24] dmaengine: dw-edma: Use non-atomic
> io-64 methods
>=20
> Caution: EXT Email
>=20
> Hi,
>=20
> > From: Serge Semin, Sent: Friday, June 10, 2022 6:15 PM
> >
> > Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> > possible to use an available set of the non-atomic readq/writeq methods
> > implemented exactly for such cases. They are defined in the dedicated
> > header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in cas=
e
> > if the 64-bits readq/writeq methods are unavailable on some platforms a=
t
> > consideration, the corresponding drivers can have any of these headers
> > included and stop locally re-implementing the 64-bits IO accessors taki=
ng
> > into account the non-atomic nature of the included methods. Let's do th=
at
> > in the DW eDMA driver too. Note by doing so we can discard the
> > CONFIG_64BIT config ifdefs from the code. Also note that if a platform
> > doesn't support 64-bit DBI IOs then the corresponding accessors will ju=
st
> > directly call the lo_hi_readq()/lo_hi_writeq() methods.
> >
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 71 +++++++++------------------
> >  1 file changed, 24 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-
> edma/dw-edma-v0-core.c
> > index e6d611176891..4348d2323125 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> <snip>
> > @@ -417,18 +404,8 @@ void dw_edma_v0_core_start(struct
> dw_edma_chunk *chunk, bool first)
> >               SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> >               /* Linked list */
> > -             if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
>=20
> I'm trying to use this patch series, but I could not apply this patch.
> I investigated why, and then IIUC the DW_EDMA_CHIP_32BIT_DBI flag
> doesn't
> exist on the following based patches:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Flinux-pci%2Fcover%2F20220624143947.8991-
> 1-
> Sergey.Semin%40baikalelectronics.ru%2F&amp;data=3D05%7C01%7CFrank.Li%
> 40nxp.com%7C44fc7f7d7f844fb10b4a08da5f125456%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C637926829585015681%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DnwJEnsQoej4RzpY9ZTDfOwh
> on%2BzjXz48Xx5Yz5WAR2w%3D&amp;reserved=3D0
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Flinux-
> dmaengine%2Fcover%2F20220524152159.2370739-1-
> Frank.Li%40nxp.com%2F&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C4
> 4fc7f7d7f844fb10b4a08da5f125456%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637926829585015681%7CUnknown%7CTWFpbGZsb3d8eyJWI
> joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000%7C%7C%7C&amp;sdata=3DrNV74hncfbxxb4crPA2PGfkeIW68GBOiv58Q1yC
> heUo%3D&amp;reserved=3D0
>=20
> According to the comment from Zhi Li [1], the flag can be skipped by the =
fixed
> patch [2].
> That's why the flag doesn't exist on the based patches.
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Flinux-
> dmaengine%2Fpatch%2F20220503005801.1714345-9-
> Frank.Li%40nxp.com%2F%2324844332&amp;data=3D05%7C01%7CFrank.Li%40
> nxp.com%7C44fc7f7d7f844fb10b4a08da5f125456%7C686ea1d3bc2b4c6fa92c
> d99c5c301635%7C0%7C0%7C637926829585015681%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DQ%2Bx5IxIaQyS1oVZEoNXEL2X4
> SAB0ffO2NjMrUT3MGho%3D&amp;reserved=3D0
> [2]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
er
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fvkoul%2Fdmaengine.git
> %2Fcommit%2F%3Fh%3Dfixes%26id%3D8fc5133d6d4da65cad6b73152fc714a
> d3d7f91c1&amp;data=3D05%7C01%7CFrank.Li%40nxp.com%7C44fc7f7d7f844f
> b10b4a08da5f125456%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C637926829585015681%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&amp;sdata=3DnGZetYm3da8Vj4adPAXZV7Rr0kXvcliW%2B0PlwOmsnsg%3
> D&amp;reserved=3D0
>=20
> Since both codes in #ifdef and #else are the same, we can just remove cod=
e
> of the #else part.
> But, what do you think?
> -----
>                 #ifdef CONFIG_64BIT
>                 /* llp is not aligned on 64bit -> keep 32bit accesses */
>                 SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>                           lower_32_bits(chunk->ll_region.paddr));
>                 SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>                           upper_32_bits(chunk->ll_region.paddr));
>                 #else /* CONFIG_64BIT */
>                 SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>                           lower_32_bits(chunk->ll_region.paddr));
>                 SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>                           upper_32_bits(chunk->ll_region.paddr));
>                 #endif /* CONFIG_64BIT */
> -----
>=20

Latest Linux-next code have removed CONFIG_64BIT.=20

Best regards
Frank Li

> Best regards,
> Yoshihiro Shimoda
>=20
> > -                 !IS_ENABLED(CONFIG_64BIT)) {
> > -                     SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> > -                               lower_32_bits(chunk->ll_region.paddr));
> > -                     SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> > -                               upper_32_bits(chunk->ll_region.paddr));
> > -             } else {
> > -             #ifdef CONFIG_64BIT
> > -                     SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > -                               chunk->ll_region.paddr);
> > -             #endif
> > -             }
> > +             SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > +                       chunk->ll_region.paddr);
> >       }
> >       /* Doorbell */
> >       SET_RW_32(dw, chan->dir, doorbell,
> > --
> > 2.35.1

