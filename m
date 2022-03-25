Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1964E7571
	for <lists+dmaengine@lfdr.de>; Fri, 25 Mar 2022 15:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356877AbiCYOyc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356285AbiCYOyc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 10:54:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7735DA46;
        Fri, 25 Mar 2022 07:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/utftwVmswKK4LHNLFmAGVOo9PLQFuHPZtIN2HmSgmQhyFti1V1S0BEGEBat9pDY15Sg+erErag7uKGg781glnbRLb3wzOFDUSBo38SdILCT6HjYqZkOSZ3BXh9ynYm6KCvy08nNHPYhVuOLF7RGeUr2IztrWdUu5B1ZxkaGRiWFYSPuxZ9AWqvs6edFMjj6RqU2vJb/4LHqqTsQCgrrZX2iBA7KtlnrGj0B4kZnZMSz9c1UnMJ5qlse/BmDL68rF9wbwtrAgCb6BZi1NwGNCY9C1lVmRrYn5NZciFpQEN/co+xvZ7sVbWnfD2D7BxFEiIxK31g4oJyvXae/Wa3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x519u5Fp0VVtJAngNOEo1TGjXXh+HppSJkSaP0ieVkM=;
 b=aZTk92Uw0lOnKnqcyC8alkH/JALnZKvWPQaW6QeX67jDa/W92jRIpCN9KaovLMQtMGSJAOfbw+0tGjS+2dFxN9qaB7ACQTgqWn3ekmcAqpcRqQyNLbR6cGUW1fMW83z2fLg0204ZMjmIytouNy2qWO3YCXIwsRYXFSfXlVWBQ3GBS6pfrB7zLZ1uCmadLQWJWiXgs13VNp/yYAKNNEyTvI032Y6u4Z5+NcYpUt1Mlm0DARzWUUUq5mspTAh/mZFkRDTT6ASBL4pyYH8G0JN9bjcdIZbcVaHtBFkpqTHVZnuZnyXGoM4+RSTTMlrFrlxw/7yo2FNzisiL97QyCbugiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x519u5Fp0VVtJAngNOEo1TGjXXh+HppSJkSaP0ieVkM=;
 b=MZe5eDZNWc2nmO0280LfRtm53xEg+ksK6v3VKAVNLsq1zav0M0Ophaca3FHmnQIuI/+YnsX64qk1DhIkMfy25hxZH5Z8zIvJR1j+xOAuy9wot1n4AmQbMMwoun5hlnNr7KuH0zBUyklmVfIaLiwnWxZ5eWlSBoePyT3V/u2BpTE=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 14:52:54 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::bcbf:f029:4f34:1be1]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::bcbf:f029:4f34:1be1%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 14:52:54 +0000
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
Subject: RE: [PATCH 00/25] dmaengine: dw-edma: Add RP/EP local DMA controllers
 support
Thread-Topic: [PATCH 00/25] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Thread-Index: AdhAV8ZNQ5LiEBVAR7arpMVAC87NQQ==
Date:   Fri, 25 Mar 2022 14:52:53 +0000
Message-ID: <PAXPR04MB9186C220089D1480CD5C4826881A9@PAXPR04MB9186.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2a02f73-b848-4a51-ddea-08da0e6f245f
x-ms-traffictypediagnostic: AM9PR04MB7537:EE_
x-microsoft-antispam-prvs: <AM9PR04MB7537BEA500145C45F8388612881A9@AM9PR04MB7537.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJMyyrX1T+sn5mgvm1yu5wRaJ1WNmQQERcc53MgBISg9UXKX7w2LINP51ACqtC2+9LQ/eWAnIiQzZYj9ex1GBrrO8jdJhIAd3rNZisJStuN0O0mLZNNWOpbLd1JesmOKYdczvbuKTErgOAaCBaDNZyvoc43kiG4P3W5cFrSSpGqIbOQ9be7/g5X3yY9bCJxW5qapXs0YoxVYsIkN24m5LD02TX18jrBlrbypyfX1TRFR0nYR3qLwSB8szEXEDl/o1r318JHHI9ucexU9V1NbLVIL5ikawf/LCHZeFH4Qc3RSb31xwRLfnIEsZ+5Gc1OuLedRrocTdBed/bjzNzKQyPmkEH05uBkDJCsM9MuhboIJzlphWagJDi233joyURfysg+VL34XIcRyJtbgi+GDlhKhXoUJamYPUb73mRITlwZFlO19CNzeF9yBY7PkUVt6Ox+YP/heHP0Fgbif5UujPuUJpiJmrD7bpxF5my79l34zRO3Esx3pciKYQEsMjzq5tCcvmr4F11h6iZXwkZI/eDBq3cnxEicXQ5xb765qJzC/qT6BkyXY8VIdJh6QGRZE7wV/d6biP51ujWpRVvD7VanTiN/Mvf3jjJ/ZLK6m+z74JJiLosKkrVo1wGNRvMt8H0EbIDnAZhdDs9QRuh0yv6JNsclhoLqk3ynvj28giABh+niCLFhT4MbWHaN+NStFMGRV05g66DLGx83//vOf96/3CaWvmROiBPWnPShkpTC6osju64JoEOLxBDQ5Ov7Bx1Qil+NKbz/qXkppVovHD7ZmVtIJlfFPzmHS1B3r50Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(66574015)(7696005)(53546011)(6506007)(45080400002)(33656002)(26005)(45954011)(7416002)(55016003)(186003)(8936002)(122000001)(5660300002)(38100700002)(52536014)(38070700005)(9686003)(2906002)(83380400001)(508600001)(86362001)(54906003)(76116006)(66946007)(44832011)(316002)(19627235002)(71200400001)(8676002)(66556008)(66476007)(4326008)(66446008)(966005)(64756008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?ivxa6b6UO1UUfwPwvmGn9F5A+988fdiKLeaSMJakwXcKHSPn6YeWl0Kb/B?=
 =?iso-8859-2?Q?WnuKt8FOuiYa+nYsdT0KX4PJ1flIGlCt5Aj0CZlBDC6capjBPwq3xzXzCS?=
 =?iso-8859-2?Q?Nysqq8k4FWzH3f0208hW43n2ryCfM2LxP9f42jysBYptr8UNdHs8IJ0+F5?=
 =?iso-8859-2?Q?4c9jky9hqIiG2ZIl5jYSB9xhj6LvabJWrUBjYPmJqo0wv2zbMovAVL6lrv?=
 =?iso-8859-2?Q?uxk3LliSStIfQFRtQx7bbjBhgwW+rbjvBsEU2Ru8CBZs1nQieb3oKV2zXo?=
 =?iso-8859-2?Q?sIb1OAZXnq17EEAXQg7rYbaxEGuHghC90UA8Lf8Ry2Jtg8nchCr7ct0Ksb?=
 =?iso-8859-2?Q?bgx9h5syKUvOwCE8IkgihZNrjTL6Ksv7I8677zU5scQipqNKB+mUkHMage?=
 =?iso-8859-2?Q?cH4whteHzgIs9S5HKw4Ub0Ce2Xtw3TopHuFm19hSHDo4FDnAeH/GJy4rGO?=
 =?iso-8859-2?Q?+58G4HVPGmlFEer9vVsKmqG+/h0bDOue4yuAsmxAKj+lfl3p6YfX1JyzLf?=
 =?iso-8859-2?Q?aO6RA5iKjEXXp2vVeBxnncDP3SI3pmLZOizYjqqV74TV4K/vNBomV+sXcu?=
 =?iso-8859-2?Q?7p59xghWgKIsh/b1lZLfmq0EYGMw7zxW0tb6UaWykFJ2LKBjNVUHJoFK3g?=
 =?iso-8859-2?Q?WeKi6ua2RHjv+LOPNvXFymI2Ag+64mYd4Jnjnra5h6eB+70xHk0zk0CEYc?=
 =?iso-8859-2?Q?XO5U4RFfSEJkrks9p703MQ0ZOWESTdqzbaqZX/moZMHww6emYz3JF3lCfU?=
 =?iso-8859-2?Q?INPu7hUoZaZJPJwObXjyQlKmeJXrY4YpRFxLmUAV887UzekCrRnMG2gtVU?=
 =?iso-8859-2?Q?7K8Ri3AWvH+iFD4M9B8FIfGloUASQqqUaM442efdvbclGKkLHWHGJYZ4sz?=
 =?iso-8859-2?Q?3rhRYSlgG0c0ELtH/S5mPx3cAxi6/eMhrlbpmzlkc8sD4DObVp2qITNygO?=
 =?iso-8859-2?Q?eS4i27CspwvxbtK4s8BelZAX/SBLJOMjjGT5KKkitNnczHO3v+C1wO+h8g?=
 =?iso-8859-2?Q?yWeVgp5ok2w9knQ4vPvUcs+QugPInwG0oc05OW4SCAkvpQI3IhGmKudcqx?=
 =?iso-8859-2?Q?BVPQB2WJCTT0T2Z/mS6AHr1xvZ6Im88j8whC5Y73gkB0wXQvFVvDwy7W4z?=
 =?iso-8859-2?Q?iKXrKb+INC6kQgIuozAmoJqmkcCkt5ITD/C1cpGomM0Prcp+SV1F3oLrBq?=
 =?iso-8859-2?Q?dWt9WjPuAIB09Jn30oFOakwl76D1fMp4FZI8hR0sK/CFmUXMrpKFuLgcqw?=
 =?iso-8859-2?Q?xcXwcx30X5E18eG7VzbYv2yPdCprVV4oD29R/d+blAqI8Z+HpWInApayYY?=
 =?iso-8859-2?Q?3Omlv7ysxj79SYXsthsqgHC1ARmaLeTDEQ82tGNoIpFfNDpor+GyBGHqcc?=
 =?iso-8859-2?Q?mmFnHunVs5hi5Nj6LPJbCsZE1BAQaFVtp48FeiGZH2dGtKwlvovbWWefw/?=
 =?iso-8859-2?Q?vNHiknpfvvCJurE5kXbMNOM/kODneuOtmjjtxI0M5X8VzXc7BFvvW5Vcy0?=
 =?iso-8859-2?Q?wPSWw5rKrBmVdxaYFgW0vKO/FE+r/JP6TSHwGDhoCMUSHoFyVfkvI9g0aI?=
 =?iso-8859-2?Q?SKSxskyazGumw2P6N3Xn7yvr7G1q0e7iDV3dsk8qc3Clf5f2iMRKaA5rK3?=
 =?iso-8859-2?Q?fBGHwSe68Rx18ORI5QYr02C7w95SFjZB/EY+/MeVjvdXdKSrCHgsShghPc?=
 =?iso-8859-2?Q?XKpNiPapIwL9CfDRHv/mW+Wr/mlpq3hTHc6trxV0rIdIa9hXSM/9OF3yJj?=
 =?iso-8859-2?Q?GOwbPnVaw8+ypUNzsstdWxk4FqL0igjnPwNfkD3Q0mNN/cWzUk0fMTmpL4?=
 =?iso-8859-2?Q?9LtCTsPu7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a02f73-b848-4a51-ddea-08da0e6f245f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 14:52:53.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmbgMTh7HLZUCLKGJkHJbKVDhvqkYUps+WVevQSp6FPbXVpFXCUcHMAakRaUah6Sd2NcxyHWJSON5bY6RNJ7Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537
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
> Subject: [EXT] [PATCH 00/25] dmaengine: dw-edma: Add RP/EP local DMA
> controllers support
>=20
> Caution: EXT Email
>=20
> This is a final patchset in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
>=20
> [1: In-progress] clk: Baikal-T1 DDR/PCIe resets and some xGMAC fixes
> Link: --submitted--
> [2: In-progress] PCI: dwc: Various fixes and cleanups
> Link: --submitted--
> [3: In-progress] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
> Link: --submitted--
> [4: In-progress] dmaengine: dw-edma: Add RP/EP local DMA controllers
> support
> Link: --you are looking at it--
>=20
> Note it is recommended to merge the last patchset after the former ones i=
n
> order to prevent merge conflicts. @Bjorn could you merge in this patchset
> through your PCIe repo? After getting all the ack'es of course.
>=20
> Please note originally this series was self content, but due to Frank
> being a bit faster in his work submission I had to rebase my patchset ont=
o
> his one. So now this patchset turns to be dependent on the Frank' work:
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fdmaengine%2F20220310192457.3090-1-
> Frank.Li%40nxp.com%2F&amp;data=3D04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e4=
02d4
> 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63783683=
32
> 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
Ti
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D3wsUdFo2TpBCVe8haYoFMxPyY78D4=
yABM
> B%2Bz0QHkE3Q%3D&amp;reserved=3D0
> So please review and merge his series first before applying this one.
>=20
> @Frank, @Manivannan as we agreed here:
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fdmaengine%2F20220309211204.26050-6-
> Frank.Li%40nxp.com%2F&amp;data=3D04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e4=
02d4
> 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63783683=
32
> 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
Ti
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DUwV79KHJWWhHZ9dYuqrBP8%2B5n6x=
onLU
> bK5wqduuSg%2FM%3D&amp;reserved=3D0
> this series contains two patches with our joint work. Here they are:
> [PATCH 1/25] dmaengine: dw-edma: Drop dma_slave_config.direction field
> usage
> [PATCH 2/25] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-directio=
n
> semantics
> @Frank, could you please pick them up and add them to your series in plac=
e
> of the patches:
> [PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "directio=
n"
> member
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fdmaengine%2F20220310192457.3090-7-
> Frank.Li%40nxp.com%2F&amp;data=3D04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e4=
02d4
> 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63783683=
32
> 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
Ti
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DG2Q2BTfp4vt0yiyHbPnn9kKBDfOx6=
QBmE
> ypOREcWq4g%3D&amp;reserved=3D0
> [PATCH v5 5/9] dmaengine: dw-edma: Fix programming the source & dest
> addresses for ep
> Link:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fdmaengine%2F20220310192457.3090-6-
> Frank.Li%40nxp.com%2F&amp;data=3D04%7C01%7CFrank.Li%40nxp.com%7Cfc099c7e4=
02d4
> 556176e08da0d386b19%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63783683=
32
> 26917527%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
Ti
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DUppQMqEDobyEN2JU05MS6k%2FuXeS=
6%2B
> skrr%2BeN%2FeQzPk8%3D&amp;reserved=3D0
> respectively?
>=20
> @Frank please don't forget to fix your series so the chip->dw field is
> initialized after all the probe() initializations are done. For that sake
> you also need to make sure that the dw_edma_irq_request(),
> dw_edma_channel_setup() and dw_edma_v0_core_debugfs_on() methods take
> dw_edma structure pointer as a parameter.
>=20
> Here is a short summary regarding this patchset. The series starts with
> fixes patches. The very first two patches have been modified based on
> discussion with @Frank and @Manivannan as I noted in the previous
> paragraph. They concern fixing the Read/Write channels xfer semantics.
> See the patches description for more details. After that goes the fix of
> the dma_direct_map_resource() method, which turned out to be not working
> correctly for the case of having devive.dma_range_map being non-empty
> (non-empty dma-ranges DT property). Then we discovered that the
> dw-edma-pcie.c driver incorrectly initializes the LL/DT base addresses fo=
r
> the platforms with not matching CPU and PCIe memory spaces. It is fixed b=
y
> using the pci_bus_address() method to get a correct base address. After
> that you can find a series of interleaved xfers fixes. It turned out the
> interleaved transfers implementation didn't work quite correctly from the
> very beginning for instance missing src/dst addresses initialization, etc=
.
> In the framework of the next two patches we suggest to add a new
> platform-specific callback - pci_addrees() and use to convert the CPU
> address to the PCIe space address. It is at least required for the DW eDA=
M
> remote End-point setup on the platforms with not-matching address spaces.
> In case of the DW eDMA local RP/EP setup the conversion will be done
> automatically by the outbound iATU (if no DMA-bypass flag is specified fo=
r
> the corresponding iATU window). Then we introduce a set of patches to mak=
e
> the DebugFS part of the code supporting the multi-eDMA controllers
> platforms. It starts with several cleanup patches and is closed joining
> the Read/Write channels into a single DMA-device as they originally shoul=
d
> have been. After that you can find the patches with adding the non-atomic
> io-64 methods usage, dropping DT-region descriptors allocation, replacing
> chip IDs with device name. In addition to that in order to have the eDMA
> embedded into the DW PCIe RP/EP supported we need to bypass the
> dma-ranges-based memory ranges mapping since in case of the root port DT
> node it's applicable for the peripheral PCIe devices only. Finally at the
> series closure we introduce a generic DW eDMA controller support being
> available in the DW PCIe Host/End-point driver.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczy=F1ski" <kw@linux.com>
> Cc: linux-pci@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Serge Semin (25):
>   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
>   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
>     semantics
>   dma-direct: take dma-ranges/offsets into account in resource mapping
>   dmaengine: Fix dma_slave_config.dst_addr description
>   dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
>   dmaengine: dw-edma: Fix missing src/dst address of the interleaved
>     xfers
>   dmaengine: dw-edma: Don't permit non-inc interleaved xfers
>   dmaengine: dw-edma: Fix invalid interleaved xfers semantics
>   dmaengine: dw-edma: Add CPU to PCIe bus address translation
>   dmaengine: dw-edma: Add PCIe bus address getter to the remote EP
>     glue-driver
>   dmaengine: dw-edma: Drop chancnt initialization
>   dmaengine: dw-edma: Fix DebugFS reg entry type
>   dmaengine: dw-edma: Stop checking debugfs_create_*() return value
>   dmaengine: dw-edma: Add dw_edma prefix to the DebugFS nodes descriptor
>   dmaengine: dw-edma: Convert DebugFS descs to being kz-allocated
>   dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
>   dmaengine: dw-edma: Move eDMA data pointer to DebugFS node descriptor
>   dmaengine: dw-edma: Join Write/Read channels into a single device
>   dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
>   dmaengine: dw-edma: Use non-atomic io-64 methods
>   dmaengine: dw-edma: Drop DT-region allocation
>   dmaengine: dw-edma: Replace chip ID number with device name
>   dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
>   dmaengine: dw-edma: Skip cleanup procedure if no private data found
>   PCI: dwc: Add DW eDMA engine support

Why I can't see your patch in https://www.spinics.net/lists/linux-pci/
But there are Manivannan's reply in https://www.spinics.net/lists/linux-pci=
/

Best regards
Frank Li

>=20
>  drivers/dma/dw-edma/dw-edma-core.c            | 249 +++++++------
>  drivers/dma/dw-edma/dw-edma-core.h            |  10 +-
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  24 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  76 ++--
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   1 -
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      | 350 ++++++++----------
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   5 -
>  .../pci/controller/dwc/pcie-designware-ep.c   |   4 +
>  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 188 ++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  23 +-
>  include/linux/dma/edma.h                      |  18 +-
>  include/linux/dmaengine.h                     |   2 +-
>  kernel/dma/direct.c                           |   2 +-
>  14 files changed, 598 insertions(+), 367 deletions(-)
>=20
> --
> 2.35.1

