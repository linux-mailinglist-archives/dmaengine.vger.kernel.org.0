Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959897B8261
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjJDOcu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjJDOcu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:32:50 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A66D9;
        Wed,  4 Oct 2023 07:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UshTWT9yaOtCfiyASVa8NiWZA6la7diCfFs6kDA3xLLYzqc/NYawDYIz5Of9UuA7+IHZrVG47RboWDeJ/1LJs1Oq+Khg7QKoRC6EdiSKiSPaef+LP7czi9LMTsawy5p3t/sh8C3iPsr23MqOg4XI36NJHcE5g8ryppu0CmVeUnrc3HFOdjcGtP2RBhkdDUP6pVDZeEmLBS0cPEjjqUYJl9Oqbu7bo3yuUVQvCa1Emjy0U1/iydv9EKJuMrGxoZiPgFhWVPQg6iYpkeNtEV2F8LOxB6EFsF4k84SQ2u5aI8GkW+h9weORNnYBBnoyI3ZqPSaoSMdX+c7jPFAMLl978Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtMbVCC5yLj8a4VFxJQxcn/HvYIutrRr0IZoF5e0RGw=;
 b=N+y+513bGIZkM0ptOqRbemTciR746N7Toqsqvt632VGj5Q+WVvLlh9FWs4f7iMxpXVtHYXIaK5zCHP3xuTipX7iaJdooqkHHqs5mTtY4Qjc4bIpW3ejwlfBrDsrWFTZjSg6ad2uEzIC122dRfqtVcTIslXB/nfgRQBYV9eEoxgSVHovLpyltVsJr52NdvNyYt6AQMUfNA6706NqnibpPMauErxLqtk66Yrvts/DQlxDnBP5TI5wXRN/CqInDSZ+kjE3n1Gl5iYiEFBiVwxtKJop0Gx20Ypnm/8uFqIZi8hO5T1SW4ySoXVe0uYuUk2JPAFE9S6C+NjZQmVyrKixpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtMbVCC5yLj8a4VFxJQxcn/HvYIutrRr0IZoF5e0RGw=;
 b=UunsFf/yJi8AvDx3Y0ujACM2MKNOyjI4gN1ytfKJPtSpZLQWCxgSlZiUxqHfRhE9pvj7FC1AtsTc5CeCdL4HF8jiRiI1pOKJwTnsTZAYmmdxHzTxqHWGLeZX8aAFadCLWRYLThX9OXZwp6FssG2vg0w+lmTwSUpIN5TUnIBSxu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9913.eurprd04.prod.outlook.com (2603:10a6:10:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 4 Oct
 2023 14:32:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Wed, 4 Oct 2023
 14:32:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        joy.zou@nxp.com, linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        rdunlap@infradead.org, shenwei.wang@nxp.com
Subject: [PATCH resent 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers
Date:   Wed,  4 Oct 2023 10:32:28 -0400
Message-Id: <20231004143228.839288-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9913:EE_
X-MS-Office365-Filtering-Correlation-Id: da58e961-cd4e-4a1b-6e33-08dbc4e6c4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +K8KYlD/9+ZMbb7zZgta/QlJuP+uxPKf3x7Rakqmaac5E7f2aHw6ojyu+m9oAV95B074eKFkTh94NkzBCB4p5jfkpg/yuaj5QKMCtMN83u0gzEWhFtf9fNp9lRF/4nBnfsvvFbzAmrL19WWSMX316cNOLi5gopK0jLmCsITq4BCOyap2gKOCdc6IRxpintz/4aVQYppfmvJXSokE/48rnDqsowjNw3Tm74S2UdfAgBE9H1d/rp+6yJGjptV9w11aXZCFnxuB7Xexw8G/SiKHEDjIdPkUnmM+HyIh10Ry1PnSrpZRhqnTD2wSWQuOk5BDYDT+i2YkNBJpgrsQKsQ+Ns3KlfxSAgdT1sI8jKJ+ChohNKtaPPRch0zMK4b1uuaY+9E1toLf7bPDbV04omzdf4l0adZZHgsBxRHD9JuDIW5Fz4yJ18fVmvSdcEnGtmBVjmRDxNHa4rl3Ra6kpI1B15nM4FtO2OPeSintrxC1z8/JUtLmdURrYZ/X92h0/+oNOWtzFsOLK/guCceec7XKcMW8oifb++39LcZNt6yjUt5EZt+ihf4rxKX29WwmOPfdwDIqtu8nvZIetzJ9HjuuneSzFBGY7Gwoo0yxLVJPoaIiczJ14O/tKhWVDY6cyClg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(52116002)(38350700002)(6666004)(6486002)(66946007)(86362001)(2616005)(41300700001)(66556008)(38100700002)(26005)(1076003)(83380400001)(8936002)(4326008)(4744005)(316002)(6916009)(2906002)(8676002)(6506007)(36756003)(478600001)(5660300002)(6512007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwfvi6j2C2+pB39c9CgNmgXBNlK309lwM7PVcRaY+3UIADEgN3E6pB/TZ3KE?=
 =?us-ascii?Q?Io9nMkXW/VbnJaIWY5TmpOfWyjoaZ0wprEXtiAdSL6Qhc4rmp8DifMFrtqHq?=
 =?us-ascii?Q?iqjb3ZBCRsedcw4batwUN5caCrrPowcgM6YeIX9HFHMS5cUE5rIlqbx+12gL?=
 =?us-ascii?Q?19Pn8nfNcJKqLORfN8I7R6hNQcsIFfUH/dAopAXbb/s9sbA657KdwpZmkeYw?=
 =?us-ascii?Q?hcZoxC4qio7s9JPc/Yqrg2jaVZGSqAoa+4C2bo01wUHLUe8lRVLCTPYmlxjf?=
 =?us-ascii?Q?BWuc6O6Am3oj5Rv3DqeooOGvOw98PNvYzUHwOneqe8bHAaI05lKoxkCPWYTD?=
 =?us-ascii?Q?qTn87A6dPY3T8B+E/rJhhj+301lTpIuXbGIsxOj88FCDmlOAtKrYcHkL/swk?=
 =?us-ascii?Q?e76OQTuSt51n3j7HgeSZHDh7mY9Fs08umN/apyvu5IgduGvFC8FZbCU1ywQV?=
 =?us-ascii?Q?ChauAUd5e/5Jac1EAuAY7j8Z1iAEJ7/y+KlHu1yRZmOm5g+xVrxMmrJAksGA?=
 =?us-ascii?Q?h5+z23nl70pyKN2H+jYhogzqXm2eFAHVuahFXG4iPoa4EU0z9ub+n6deUohg?=
 =?us-ascii?Q?KYrmRahGiSe1jzw/orDiZDbMn+fdxkgpID45eG6SeSKmEwvuPq3mNwbPf7JG?=
 =?us-ascii?Q?+nRfoIKck2S5I1JoQ3N6W/zOHwoqxOnyEwF2zX7Irv+oeuxs1dTZVeyLA1ev?=
 =?us-ascii?Q?MPEj0jcIt9mJVyOLT4H0XaRqsP2kwOMtV0pfT+tyH/CCBWBe2HgcsXBv7FMx?=
 =?us-ascii?Q?BKdZ2mnqfoMVjUoYpMFeDACm88W8QG0lh46R9kRdUeCLzQDyU1xU1kFPkoKT?=
 =?us-ascii?Q?RV/8BEH1MnatMurii0PJEWretnpmu2/qD1qaM5XEK032m80uywRKmVoHDYf2?=
 =?us-ascii?Q?aBWK8qHO9lv/J2MziU9BByovDd2j/bKXzdh1a51OBn30kPfElL/zlvnD57bu?=
 =?us-ascii?Q?f0DIg0M8o9KgPOWtsf8/Isry3/ynXWBE3KETwv4aJWqeJWzlZocVaISoq/NG?=
 =?us-ascii?Q?h8bVUlim1/fWNupAjl6C798fqg5bV5GiFqMwyabk1AkdvP1jXmiM2ymvXa0W?=
 =?us-ascii?Q?ycz4DDaMwBb92RiO/qICjILp98FzC0M9jiLisPsSc6+Of+BS4DGxmphRmCC2?=
 =?us-ascii?Q?szBVdkVxeXGKR+1TZHhx8Q1H2tDJeuPIldP6cC1XzFYmg8Z9H8qhRJBFe0Of?=
 =?us-ascii?Q?4n+2/IJW+NUH8JdX3Nc5FAoGAlcmQauCKHCA9Q6AwfklKP8AIA9IbC+aMDsS?=
 =?us-ascii?Q?GiPyC3yIYz3iqTF3tnXygFobThS4084/hf+2E0ZxcTJBP+e/Pief5lDHoI+w?=
 =?us-ascii?Q?qE6/tEoAS/Thov/uvqY8GO7pperuZR6XiWDE2QQmjwJfcgIaGpNSAPG95l+j?=
 =?us-ascii?Q?S+FqFKddRDX5rptCjBQD2EDuiVmln+jqEoegeyk4kx+ygum7LfCJVrdhbDOk?=
 =?us-ascii?Q?U6r6/qKjnnx/KzwKrSyI+o4R4FaJjgYoJ2SFDufCFh9q2zDXPQLL1NnOdUTC?=
 =?us-ascii?Q?4HA01X1ykVqpnER2Xe5jfOe3c8jo4rxP7XV7wF9Gb9Yf7dLZ3OGRXu6z0p3j?=
 =?us-ascii?Q?RpSys4oaDqeNrF9gBJI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da58e961-cd4e-4a1b-6e33-08dbc4e6c4cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:32:42.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDPyIqH13ro6pXsm6wOSbH4NYYATsvT4Cf7d/vV9Ra/enjeKaNxNKoC67kRyyJdOoa6VvYoqCca2xq1C2YguSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9913
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - Again, fixed order
    
    Change from v1 to v2
    - alphabetical order
    
    Change from v1 to v2
    - alphabetical order

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23eafda02056..c1c7a9ae244f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8236,6 +8236,14 @@ F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
 F:	drivers/spi/spi-fsl-dspi.c
 F:	include/linux/spi/spi-fsl-dspi.h
 
+FREESCALE eDMA DRIVER
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
+F:	drivers/dma/fsl-edma*.*
+
 FREESCALE ENETC ETHERNET DRIVERS
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
-- 
2.34.1

