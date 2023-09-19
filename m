Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD87A5865
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 06:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjISEbc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 00:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjISEba (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 00:31:30 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB5111;
        Mon, 18 Sep 2023 21:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzxXZNdZ5B7jjKzcIc8KjmNW6ZiJFlqx+oif5p39lT+d/2PYLZyVsphfjPoeNhLmnILHRQj42SU9lTe/gjOiTyPusCA07fEW2gdhn0QsZeuDzuQuCJz/VBTOXEUAmbDpMW/BIUpm68W+zhsOUOxRyO+R4TVkKfIjlqBfjsHGqFFGHrrxlzFNiuyMnrv8FpbGeNR3GIVcXr572VHZFv5q1YNRLLNU8oEfnwm8t4vXlRrDF4nblH60y8v29V8rNmSOooTveQ8t6X7wuC9V109+fZOMc8fGOXZqg7PUjcbirLNUkmap37YYOd7VSASfdbNHws2UtPTue9b9qeF9sl6ygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvoL18q2kGjzfKnPWTbaaS+dIdB0reU7G6nRILWZz4k=;
 b=is/vs7fLcPmlYZWuU4aRJuNnxUuIGMMPipTPWbSmGpH4n2wW0GezeJfz2iWsp4ks+pkEhfTQdUgb+YmFVBB1JMmF818bu2h6W6dq8Ne0BwmqTCA6qbNsau+WobOf7tS7Hwmy9wB6Ns/mL32Z3UpGqllP0DANzdzOFAWoJ2f6/Y1oi90U4joLUTQo9lLU54yAQIkHKQQmdkjV+Ldz97Lwj0iJ3Opv/gw8I3+yfkGXfVDDCF2iMpN48L1KH0l70O7yoIPjM3fBkhJEKtMXdeb1yYVzSYPUTqHWcuueiBBisQMPiQYL5iCg+proLkYk9Wu0pYPcY8OFFFf1ZPXnQxPUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvoL18q2kGjzfKnPWTbaaS+dIdB0reU7G6nRILWZz4k=;
 b=e5lr6L0Yt3IDZyTc0v00RQR5iY1+cRF/OyjCiabQwrSO8e+VqP4Lt+5hQjOsp7wIqEMYm2wvSW5YXTTv3TUIftN4zaFC698d2iiHzjV8paGsL0gKs0IqXDXoE3rCyVCHKiQw+lBJf4QacNVNXXabbIRO4wJsutpqTi4uOhMqj2A=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:31:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:31:22 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Joy Zou <joy.zou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: RE: [PATCH 1/1] dmaengine: fsl-edma: fix edma4 channel enable failure
 on second attempt
Thread-Topic: [PATCH 1/1] dmaengine: fsl-edma: fix edma4 channel enable
 failure on second attempt
Thread-Index: AQHZ1e9mmza5A/RDR0WvWihDLR0nlrAhuAZQ
Date:   Tue, 19 Sep 2023 04:31:22 +0000
Message-ID: <AM6PR04MB4838EC7BBD1125F60A3F389D88FAA@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230823182635.2618118-1-Frank.Li@nxp.com>
In-Reply-To: <20230823182635.2618118-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB8640:EE_
x-ms-office365-filtering-correlation-id: 328e03cb-99bd-4e57-076a-08dbb8c9470b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bQ2UL1QgCPp9bU1Cgw/f9EqXG92c5xXstFEHGkpBo2cgOa7Dpx9tVqO8sVv5New81EQqk/K8j2KI4rX9tnM0M0jVm7lpRjonMdc3eeWsuDWSjoxHxESeHtESZ+HWYd8Z8VBdSe+HOU2k8AHsEDH0kUC4GammB/RrGrFUtmYgJUKzDKr/jZLTgNE/fGYR5ysL+B7alkbXyeDOvv3CLskQdxTVBEXPk4+I21qbsN51aKocFRpTRQWlF2eTUmE7yBYBU8VEruKtHGFEaH69A4lzU2LazPmCfTfAGEL4Q0r/k04elKXCG27GJNVOgy0d4aJxyibs4Zak1P7PmPONryrJmT8vVSLclrJVAyHJ8t7lSw3Pq8kuTo+F4JClvdhUfKkCeXyTR+/anpsR+CBy9KM/I/1RQfcVFaVQelE2AGiiPWK2piapz1kigVz5oXu4cFTWBMCl58jVzh0WOldh9BHTx02rWEB1SN7IouDQIvyzWahj7b9szPUBdfXX6Jq3TnOuuktULU2dgWFV7iP0aCwFL513J9EsP11+wv+TWCC3HIG9B+gMc8/18Lg8zpz2T7jBDpizxi0emMApyFbb8Ur51lhy18SfWt66w9NT2oMr6Yux+G5LNUB1tCna0vTEGXr2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(1800799009)(186009)(451199024)(122000001)(38100700002)(38070700005)(33656002)(55016003)(86362001)(2906002)(44832011)(55236004)(53546011)(478600001)(6506007)(66946007)(66476007)(66446008)(76116006)(64756008)(4326008)(52536014)(66556008)(71200400001)(8936002)(8676002)(7696005)(54906003)(9686003)(83380400001)(5660300002)(41300700001)(316002)(6916009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qtoq6K1vP2SXaYaUMOLU5IXxoNaPinYlcTJuxH5HG+uv6KTClVxSpoW9EVSk?=
 =?us-ascii?Q?Zdd1nZMq49HE3uan/3MIVji362dJM6F6u2xeygUUgQqo0oZ8LfUYCSut2KNO?=
 =?us-ascii?Q?4qWPZlFNkOq7OGD8fMXW+tBhVSSWg/VcjDa8i3vtjdxp09rBwYEyMBK28MeO?=
 =?us-ascii?Q?nozuISh+S7YZrSo63M6AH4r34UP4RePAPciiNBLGs0DtLA/lcXlg5mwvM0gF?=
 =?us-ascii?Q?sJFNqhtpwRwKzk+vHxRFZ5Imis6mTu4O5RFhDBN3I8a4M90N7lAx+LEJZnZX?=
 =?us-ascii?Q?J9UhOTxlbf5s47L6uWnuOqDZrce2MnclJLJgNpSS/qyY+6GqCxOXyik7Qu8D?=
 =?us-ascii?Q?/8Qd3mPQ1GOTAb8ab6t3GpRdWBMlnc17ESrXE+pZowBH/YBLefOGn1lfavCF?=
 =?us-ascii?Q?8fATcNjvB+WyOIWb7Bg4pZOw1PwQTa2waOO8zRa++tTrPjmsQgowevp1Qmpw?=
 =?us-ascii?Q?/U2XzzqkTHSsUk9Y8/efgj7yiAABVasEatgBcqeeWMaY4PV/U2GvNxMziJQY?=
 =?us-ascii?Q?3p6O98pbHjHnpcuJl7KaMs7MNZ7eivs43myU7h4ZGF3GNCjOyHlmTuFxGFSq?=
 =?us-ascii?Q?Oz6enrgKrZ25uzGfDOPHAmHZnFH453uNPbH6SrEVcXdWVfcyVC8gWVPW8/q3?=
 =?us-ascii?Q?dJVw45jZlT0QcgNJQWH/5xDglULGamfH6ADU8TuOxOTqu0EVhb1YYxAtlA62?=
 =?us-ascii?Q?eZspdv4SJ8JmR2ANTvxHOSeXUk9zWJHuqS9fPQJjevokHwgTyhOXF/ulA3HI?=
 =?us-ascii?Q?6qhbi3bqMnFKTMn/lF2aZVBjGTka53VJgmXw9T89WhXkeO22XTcE1bP8cZ8I?=
 =?us-ascii?Q?KEI9m574zGsdlaoFl+LtR7LbXZwhYLzP4ZyOx10vkPujQvWoPDZtkQs9wAfb?=
 =?us-ascii?Q?M36HKwyiouBjPSkxws2GZhtBT64KdCel/CNB11IcSWhpzanh0TtRWefN/01H?=
 =?us-ascii?Q?ePUQpqncI5zpRUfltik8zAz8VAYe8x8/qu+5r1yBG3rBfb9WBDFwb1CYDHXu?=
 =?us-ascii?Q?vwSSIPTnN8dCZGqiGaCCe/YB1tw3YGXdia3Es9p09BJqu9grNoi6v0vo/Xcl?=
 =?us-ascii?Q?xhU5LshAFlWCXRMQuma8+W4ySh4wFoGgtPVxWWkPLyw+MkkjoKh0biVWV0ip?=
 =?us-ascii?Q?rnMG+pR65Fu9o+jvG9kNyPlqOToKHPmXhnTklZoSTZZIT5veoHviY/fCBZrc?=
 =?us-ascii?Q?0WBRqlN2B+VBfEZOLscQQrE8qrQX+OJiMIxdI+VNi62HNoVn/fGqJJ7cM7vj?=
 =?us-ascii?Q?B2hC+2nvgrFDcm5HkXGyUr+2dpvK4CnFa3Y9F6Gy0a2URc3BwXjfc2nt+fvU?=
 =?us-ascii?Q?qpa8V56lK3tWxLJRLaQelaSrr2+EEsb4/eXb0tSmmEe8TujXQqd+PluQtiDk?=
 =?us-ascii?Q?qaHB7vIDgEHAUFRIA+6ARr6xT5fdLfmmXo1eE3Yaoc2KypRS5mrmXLHns+Jq?=
 =?us-ascii?Q?2srCfK1xoTGD85y4SRDfc9rYB0I2qqjjOZbx2/ywB+ySJgQZe89WScpS/g4f?=
 =?us-ascii?Q?jUWflxCeS1X4c+duvdyQWJHzzBxkKXVqf4u8OQd7ri1qHamNSuLoCP2HK2N3?=
 =?us-ascii?Q?ExKA/FOi8+3swYdnJ1A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328e03cb-99bd-4e57-076a-08dbb8c9470b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 04:31:22.2894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKTf7cOWyMuMJxWdTX6SBLzv+OQ9au+K1rAIgN0q4f4a29JA4MSvOo5PunvCnGtsd1wYq/7ovymzJAa3EF1xRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Wednesday, August 23, 2023 1:27 PM
> To: vkoul@kernel.org
> Cc: devicetree@vger.kernel.org; dmaengine@vger.kernel.org; Frank Li
> <frank.li@nxp.com>; imx@lists.linux.dev; Joy Zou <joy.zou@nxp.com>;
> krzysztof.kozlowski+dt@linaro.org; linux-kernel@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; robh+dt@kernel.org; Shenwei Wang
> <shenwei.wang@nxp.com>
> Subject: [PATCH 1/1] dmaengine: fsl-edma: fix edma4 channel enable failur=
e
> on second attempt
>=20
> When attempting to start DMA for the second time using
> fsl_edma3_enable_request(), channel never start.
>=20
> CHn_MUX must have a unique value when selecting a peripheral slot in the
> channel mux configuration. The only value that may overlap is source 0.
> If there is an attempt to write a mux configuration value that is already
> consumed by another channel, a mux configuration of 0 (SRC =3D 0) will be
> written.
>=20
> Check CHn_MUX before writing in fsl_edma3_enable_request().
>=20
> Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

@vinod:=20
	ping=20

>  drivers/dma/fsl-edma-common.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-
> common.c
> index a0f5741abcc4..edb92fa93315 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -92,8 +92,14 @@ static void fsl_edma3_enable_request(struct
> fsl_edma_chan *fsl_chan)
>=20
>  	edma_writel_chreg(fsl_chan, val, ch_sbr);
>=20
> -	if (flags & FSL_EDMA_DRV_HAS_CHMUX)
> -		edma_writel_chreg(fsl_chan, fsl_chan->srcid, ch_mux);
> +	if (flags & FSL_EDMA_DRV_HAS_CHMUX) {
> +		/*
> +		 * ch_mux: With the exception of 0, attempts to write a value
> +		 * already in use will be forced to 0.
> +		 */
> +		if (!edma_readl_chreg(fsl_chan, ch_mux))
> +			edma_writel_chreg(fsl_chan, fsl_chan->srcid,
> ch_mux);
> +	}
>=20
>  	val =3D edma_readl_chreg(fsl_chan, ch_csr);
>  	val |=3D EDMA_V3_CH_CSR_ERQ;
> --
> 2.34.1

