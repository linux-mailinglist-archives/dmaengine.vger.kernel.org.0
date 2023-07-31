Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594B5769A06
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjGaOt4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjGaOtz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 10:49:55 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F96DB;
        Mon, 31 Jul 2023 07:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LESSaq7aIHFdIjsKrn43KI8RWrEAtn6FGA/egeYtGlU6cefM2ahMXxqbC0+yQAkJ2FYdxXKD/tFlZZkLqp3ugK//sDR5ApjzhMN0DpPeqTjA85Nz4C2b/p+RLpR83OKLe54/94vq8bfP20lnowv3igh5j11/56BErD6HJEYSDoW1zjw69XucqSJYJywMvAmxD3S7SgNFOTsLz2EtpA+fLe7lcZ/2l1DJMMGYQ+3+WH59tFiyGvv3oGm0trQpLkp5+a8yRvqBWRB7Ev6NlDP4wHOuEsaXU3J1BYazlJ4iR3I/g3gIDkVjYMS9jN5b3eTXFpgoAQu7zkPKLS9Yxn0/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMz2ic80jKLUGFx02+nO9tYDqCExhxkXc8XH+8i7/LI=;
 b=d7+Q/C1+GGOqH1iWd0MBOd/gRivm2m7bf/uzppTXiMNoyqxtA61HjLaFzbbKCAvk5HNoGjnoAVO8HzXJS6NtYwYB/QN9LZgPZeXMH0c80YCa1xHW5LDvQu4qkfmmjUAxxTPKff4dmKzDBdpNIbISWg+rzAN1AO/Ww282GbgA66iWN0YV+ugrwO9QBBo2NplX4pkf6URzHqPu0q1izREmKZiGaGJm2K+AYRI27r6PMNDTcLkhKQU+RKQu8qBUVNur+yUjRfrYlWjSpjNoK55hONnHucLJyj/xdV1hc9+KgzBNa2UJhiDDC260t13ZBq/O4aMIaTJ7hCeksJOUCyi11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMz2ic80jKLUGFx02+nO9tYDqCExhxkXc8XH+8i7/LI=;
 b=hvSxZyplMTOW4KBT3o6KcRch3sdgnHcPUj9OsXbpkkxRBQmL5htZLVI0UQKmpCJHh3dnKzoWmcH93JLy4B1AvOSloqZjbWHdP40NAHS3BmcriAFPOjMQ3jRuhcEEyhFaaVXn0BcVHev/UtgrQwbhEx/49G0DMncz1xaJDAY2p6c=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 14:49:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 14:49:51 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Frank Li <frank.li@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Joy Zou <joy.zou@nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: Re: [PATCH v10 00/12] dmaengine: edma: add freescale edma v3 support
Thread-Topic: [PATCH v10 00/12] dmaengine: edma: add freescale edma v3 support
Thread-Index: AQHZsQVXM1FpPyzRF0Gwh5jsC8U2uq/BdBoAgBKmXmA=
Date:   Mon, 31 Jul 2023 14:49:51 +0000
Message-ID: <AM6PR04MB4838854FDD93B0DDCC541F3A8805A@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
 <ZLglBiSz0meJm5os@lizhi-Precision-Tower-5810>
In-Reply-To: <ZLglBiSz0meJm5os@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DB9PR04MB8329:EE_
x-ms-office365-filtering-correlation-id: 2598e100-9e5a-4c09-c3f4-08db91d5651a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwn0H0wLczzfGdanJ6qXR2YGhI06cJWDcXOzpgVrQU7apxm9EnpmGGqsjgU66Q/IY8rJdzyawlm657FiOlLBHKk/Cs0cpxrHoegSmy0XsQI3qFDfUb2Ytp/WSPgJEB1+EjKZxqm1ss3m7qcZlB1KW72XwRidcclSAG0R/f0laTEXeWBgwE7oCtedm1nIzR7H+k/TShwfhfOq6FHhoKFF4kO1ZX/m6CJQrvqgMc+cGMMzhh1HAW8fGeX/rTKjO5OrqIcz3Gwm+tHkYxNE1/lgpD5K0aNg3BL5Ot6myKaTJ9T9HWTFgOqk/XFc2TOYaEtoKgwjLZK3of+SwdNsh2C85MYWwyVzsWmhtarPT+ue6ylv2mVT5minSWnHnVbdSq34t3Z42g4pWjn6uN1ZovZtlcM5OXkHapRGoDj2DQfj2ElF/lA0OusZVm6Jo0VzAzRaAwJxu6qeGmeS26JQCIvF7CUL7a3KJS8Ya9cTEdGj8lpIxzXJuLhMIR9FrRXPZDsIVqthEckw0EcIcjfuEpDrmb5Q4uaU/PSO512MKKTKuSR21biqnm/1UXFYFMvBT3chbX4L0pCRsaV4wXDi55LJVxZiuYoGC80Jq/RZdY68tFPDz808qJbk+lMSi3GTCKXN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(9686003)(7696005)(55016003)(55236004)(26005)(6506007)(83380400001)(186003)(44832011)(33656002)(76116006)(66946007)(66556008)(52536014)(41300700001)(122000001)(54906003)(110136005)(38070700005)(86362001)(66476007)(316002)(4326008)(5660300002)(64756008)(66446008)(8676002)(8936002)(38100700002)(2906002)(71200400001)(478600001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B/wikKlvBae+lc7ef1tOCX0DO6llbUPCpTYy2dxwQRBvvVVH3RHD1Uq8tK4n?=
 =?us-ascii?Q?9KpyVU+Rr9+2QA8D4buEGXBWLDuV86Xb/dGkMu6VeT3a/cJvX/abbSOyVefO?=
 =?us-ascii?Q?J1/shPhRhtC3lWc03uP2nSA/wALpvbPeKK5SHjokZQNEXraBS+wXoPcVbMXw?=
 =?us-ascii?Q?W8AzvZ4MfPFmnf+fAnQlpoZtBrDRmW6ZRTEfe8QSbi2kmIa0e0svvoW4veei?=
 =?us-ascii?Q?ELIySL27BFy8RtzCdVEesk4ecZWDS/GD2jSd2d8zpBDM5sn1jiKJbaM813Pp?=
 =?us-ascii?Q?94tDdXdvwO5zzRdv20nncco/cbPMzUyz7fj3gatpm+o5VIY8dk2jOzVoBCBp?=
 =?us-ascii?Q?CxLD0nf6eXhxXLksAUDaiuRq1h6ZZJxQGhd87+7W+N/sMmyT6R0Yb3kwYrjv?=
 =?us-ascii?Q?tPk7JcHHMnz2xbjcWIjqsAC6e+QooXW01z/WzvaSmPtyUfMelpAqwc2lXK2X?=
 =?us-ascii?Q?cmfImh3tfhfCL1u0X9+bE+nrwzyrYOlx4b7O17nnDPeCk1q0zTcwfx4xQjo6?=
 =?us-ascii?Q?UjWoYH/9qnN8uNgps4gVlPwxgLB+Evi9Dqgz/PEJLT+vEWcsjcT4wpXr4M4F?=
 =?us-ascii?Q?eZVN3Xz7j0SnAL2M2YD/Cq8WDR1VvdPa95YtfO9zr2LVDRrMLkRQWoqFygzu?=
 =?us-ascii?Q?jfpAh++Zt+3meHVoXbxGPr6OPllzHNFZLGaM8q3PoIPnX4XujZePZYzY2p4w?=
 =?us-ascii?Q?L3GkNraBaERoiiAWLqDDikzXwpWZ+byL+r4twHgBmXniHEuKUzmEjmrqpTH9?=
 =?us-ascii?Q?TpOkyjkJ0aDqxAPvLTEI8prgZABBJz8LTwwFsKe6zwld85D+JMty5O4j+X2U?=
 =?us-ascii?Q?QYU397eLHTwKMS6f8AEQ2zyZ/xvioAvpac07InTFnXtOVZ+4+BoK1tYIyT/v?=
 =?us-ascii?Q?MogB1AHRzTSHcm4BO2wRAg2jBuXvkCud+m77HfBdzqK1ha84ou5bspJdRshA?=
 =?us-ascii?Q?ZGhjzOI2ruWnPvPTL8EZyYRGhXN3BHvqCoxBasLfGTPqQBt3ZVvWyoW2Mfzq?=
 =?us-ascii?Q?bb3XTAHDqhcsUPS7/YABLCMUoZpp8N5Yw+qfL7s3+ziNAitSChLMrFjwtMk+?=
 =?us-ascii?Q?EUlTfvSlRd7foB34MGb/ZnXOtyZqWQmQRUVljSGadu6PNGnsFJh0X2C42LgO?=
 =?us-ascii?Q?t2OX30xjmK3RMYgtnTR0O38qYgoA19B2UcgDfzyOJHu4s/Q2XtXGqum+NBkR?=
 =?us-ascii?Q?iKf3MTghOJpbyX3Be+XxcN1X59nRbjAHEY3lTvsnXxmdg4+LdkwYA0dSo1Dw?=
 =?us-ascii?Q?UGGNcwr5y11HLTkgqhvcdKYAwGH2CVb/R1tXO9mP8SKGtn5A9kl0Bc3f/o/5?=
 =?us-ascii?Q?17cz2GxhKndSe/UuZPpcmKlh2Q7ktaSAZYGyIw2VxsRrgcux8E+je1QD7+QK?=
 =?us-ascii?Q?WMS8JrtqyKd+jNlJXVB1l1wyERdYHRs4SqaZmU6BaHf9YdptBkAsuzRDPU5d?=
 =?us-ascii?Q?U4Y+nGpEjLKs5oVKywvuRYoq6kcW/6Cc+r440idPZarggcMKzgD7dajJhtCS?=
 =?us-ascii?Q?i7WBvYP9SsmJVLX4iwM+KvwjHgvCC5TqMQAGHCEdz36td0ZMHTkLXv97Bmuq?=
 =?us-ascii?Q?yWn5VrpQ0IqJNiPLNao=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2598e100-9e5a-4c09-c3f4-08db91d5651a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 14:49:51.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyKPDcmNNHFh/iQh/YFWINSDpYNMm2PUx0BqjskdUiCIatPqKqULrM9HYVExt7NZ5AMo3uzlssArc907C47bVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329
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
> From: Frank Li <Frank.li@nxp.com>
> On Fri, Jul 07, 2023 at 03:00:17PM -0400, Frank Li wrote:
> > This patch series introduces support for the eDMA version 3 from
> > Freescale. The eDMA v3 brings alterations in the register layout,
> > particularly, the separation of channel control registers into
> > different channels. The Transfer Control Descriptor (TCD) layout,
> > however, remains identical with only the offset being changed.
>=20
> @vkoul:
>   Do you have chance to check these patches again? I fixed all problem
> that you said.
>   All audio parts of i.MX8x and i.MX9 was dependent on these patches.
>=20

@vkoul
 	Ping

> Frank
>=20
> >

