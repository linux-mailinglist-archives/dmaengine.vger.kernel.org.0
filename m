Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485207162C2
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 15:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjE3N5j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjE3N5h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 09:57:37 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C5B2;
        Tue, 30 May 2023 06:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvKa9tOsxgHhfHK0R3EVmE3qi3Sof58JVp+7HOgeriImih9Gr4uVyzj3FWVVJTf0bUMg/df+VArqe4+ft/+HPmm+2LcLivNQVyKL3wrAPlgHWfa7sUYG6kv+LR3y8FpkBRflczQ5Qf0+MSAQnLCqXgO7PUmuv3o0EKRGzjVKVwD66RTwuCSnMHpTnnOt5nwTdG9csCWiobj88iuT6N1OEMu0dNV5+qswe5NN7oyU9iGOSjQhR4x3OhbVX/aZrMA4/LT7mBr1WhdVK/+XA76J5Ea4jlkDaJkQ/A/ABrGnUCpQKT5M4sll/jHNZeC8Z1lwJqxzE4UiTLXkzwlX/B1+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYtLD5sROeqTmgNGLhgoY//0q3FMZ+v6DFq1DkjnIl4=;
 b=ctoAqQkywDKD/LrdBsDQJuLbA+L6K2CcEfU629/Yk9zaLI0wfR9W5mvQNzCXJF5/MVYxHeU0yS468toVjDQONjsDVYNc8NN8O7zikGbCJa77l/SfztbMWPiPGryx5c8+wfsupUwV3UWwDw1Zb2Xd1cQwj2zWexYD1TT/5W0+E6GcCR0f5h152eLRuSsHe9PXnfIZd3eFH3EpBhEk10xZqkrsPidaKVXXrYO1aLDb71uvnwJlsA4w96SsCL5rpvr9cVKy5QTLgUqABXbSAaOlDLCBsunNQ59DFZouBaaqVQzO8T3ySnD04pd316tBSYoRpALWyf8uPtG5TcAB/O8oJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYtLD5sROeqTmgNGLhgoY//0q3FMZ+v6DFq1DkjnIl4=;
 b=qwLNiRB0Am0biQ7IlPITJ8DUcv7t7BynNDbdleA9GNW3ndPShSwPXEvGkgJabwD7F744wXGH8DqkaJ/w1vGjLtNk6j2iAYw4MRut62JniDZtIMrQHNvpa9sn4MmKeuLkHkSFKFuUnwLFoUFBzqgWS2g8qq121nzzokUONqC94B8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8652.eurprd04.prod.outlook.com (2603:10a6:20b:43f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:57:29 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:57:29 +0000
Date:   Tue, 30 May 2023 09:57:12 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, peng.fan@nxp.com,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        shenwei.wang@nxp.com
Subject: Re: [PATCH v2 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Message-ID: <ZHYAuOA6JHv6LYwl@lizhi-Precision-Tower-5810>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-13-Frank.Li@nxp.com>
 <65e7b6df-b83b-2d7c-5093-f5822050827a@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e7b6df-b83b-2d7c-5093-f5822050827a@linaro.org>
X-ClientProxiedBy: BY5PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:180::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb6adfd-fb76-4931-2818-08db6115ce74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELmtRYN8mrTUYiAU5xCPNKQYZy18r3xbJjsfeZ6HEzPK4zDqGLfWWLf6vbRQffi2IAJW9YTfKoiiWb8PFaAIkX7x/fA7g8bAeqqdQOC3EgUSNXnQxlZ7WyJMMqqScDbjGwV72pNb+iyzZEJogT9BljFtAm2f4uX7TMQYU5KLb82ObQuC/0+wtraJjA5CpleTLRF8zZ9gBHGTRTqiw4vWKRD04EE5fqkigR/x6N4rFvuNmV94KMP+Wi+qsEj1hzTQW30pGDgYAu+d7tQ6PtWKv6pY6mhHaviUZPiiUjUoCNrWQF5l0JeAaVSTXeO0/onIMNY/OL+ey0LpROxysrABI1JUyDUsm1C+ARY1wPGfkw4huNrjsj71r2R4mHoRGAmjpRXuoPn9Rwac9UVUEXq1uxbwBFEQgxQ5P21LtPbvQgNGUalR8ev8UKgMKk7Vjv//JH1kn0ROzNnOC4EEKBEOTTcKD9Z1oyc2SnuqegtATo0nvX4CbOiKXQoq/gAwnL5NfrDm8kJGJaM1QRdLBD6HJXDBwOraQcBxCArqqiN2af+TanCgOsSnjxfnA4FXwnU4G8JJcOwBsto4eC0l856XBAWLMHmIpyeDbORnC1vTVW/T+rs3yV0khRQSRhpFQP31
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(6916009)(66946007)(4326008)(66476007)(66556008)(5660300002)(86362001)(478600001)(6486002)(41300700001)(52116002)(8676002)(8936002)(6512007)(9686003)(6666004)(316002)(6506007)(26005)(33716001)(186003)(83380400001)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwsH/CAmg4ycG0O4x3H9z6h3rXIsjA5q6BaGmGryf+UZjbk3TwpOcB1GY4rP?=
 =?us-ascii?Q?NTrxNOZaQCSf0ikkfElALzCjgu0wbRO6LNyTgFF5wlT5BpCVxvJPJDhgQ9c4?=
 =?us-ascii?Q?qnzRBq7xGDegdlDys5HX1RDEx6Qn58lxpFiag1mCWwcEeGSUKXNDGD7TXnZi?=
 =?us-ascii?Q?SDTB2To9LEbAwWSkrMS2hmVqxR4YyIuSNt9XRvZIujE0IfHvi17I7lnXT3b9?=
 =?us-ascii?Q?6cgdb7VbyVhcvXqCrHLWK59CyI4AMXnnqglrRjT8w9H4/oCIReLuSMy6wKU3?=
 =?us-ascii?Q?gKI7YcCPhgN9z9gPtZeKsYo/tHpDMHQ3bF2WUJ1G/SxkjTs9cfUPhu+nAk6d?=
 =?us-ascii?Q?H7a2OUE6H0Cmjzbwu7mRNOzOx2fbUWU3pBL/iFOlE6l+xMoC9s3eHJwErLM8?=
 =?us-ascii?Q?TNqJaRwcbIkhD2V/hVHb8xTmFi2HkXM3tvu16IEknmqwhk00PaT8LU+yypm9?=
 =?us-ascii?Q?7JdfZUfnCpY0g5oe1QzUQLz5v0EHuEYM0OoEXAEbc57NSOSh8t0tKsLZZ3Io?=
 =?us-ascii?Q?zW9TKApAceBB4U4QVE4ZCQGk/SXsV7vu/G0M75i7hhd0/AZHuEaEU40TIcD6?=
 =?us-ascii?Q?5e4DP4+9oX9muSFGFW1xvYcxCYQxD36PYUDLQnrvPJTKqr25KuFIF5PJdU+w?=
 =?us-ascii?Q?xdben8vDZWzbkII+OSlqdDy8OVpmso8aAZ/ppXr/mncPbuRa4AMFY+qwmq63?=
 =?us-ascii?Q?pQBCa4fqFJOzhvIIO03vbqCvHBP2INiziYc5rA1s3QZNBBTT44Vk9lI+8WyT?=
 =?us-ascii?Q?JHYMIHvVyM0sqpn5Vc/GSA+717a+Cyj/uioUBDefoYE/uqhqSCaVUtDIQaQM?=
 =?us-ascii?Q?KalYuu3SS4t7eAWtj3SuSFcTy+AEnW6Gy2m9xpv5p9LQSWCXRAy9N/HG2AuU?=
 =?us-ascii?Q?q1bcCvxCABJtHgaMoQWb3UJP4lkj5UfaZs0JnCXlOACdWEcG7Z3EiO7Z5vko?=
 =?us-ascii?Q?ocpfX6XrkkTs5llMmUF3Z3KPSxAABt87BwXhNquvUcZfBPcEq/1ZD/tkZ/+d?=
 =?us-ascii?Q?inoNkIhR/sLwtXCNElNcr4xFfduSbiVVwPUlkAiPfupWe8UOAIpdsLdEqas2?=
 =?us-ascii?Q?LZyQccKWi+SjqdIVdzpUkow3QlF+Lyqa9OqZZ0kw+vof9aEruE9LeA4zvib0?=
 =?us-ascii?Q?3ssjaFRyfWUhAe7tN03bechL1ev+C7x/eJ48MVqxXEWKYpNEm2OIamYuMbqq?=
 =?us-ascii?Q?8zO3wkDWTV1qV3VnMijHaH3SehbiWIZdZtfmsdP8uJVpy0uYZk5XgHBQZFwM?=
 =?us-ascii?Q?KVVOXQdFvV8fHMQptPxOYYGJAgmTHa/clesJXqizJqewn3j/shLc7tCP0H/8?=
 =?us-ascii?Q?10kvNi8oFWbYGzi7Lwz/50W3e9PqhaHC7ltznFLjJ7fXfug7seRI9YzyeFjo?=
 =?us-ascii?Q?uMvcr69MJ5R+NeiyMXSWAKty/GV5GScubIGidtTrswvFA0B4ETqQjTtQe8fq?=
 =?us-ascii?Q?ZdRkdIF0Y/B8PzJTLAVGRLkR3kkg6mat2tVRBklzaiTqFtoL15vvmPfnZ7j5?=
 =?us-ascii?Q?LELzZCPUuIiZWlsjvo5+tnyA2ANCT0cbnBYxCdWwLsA0IWfYzfIY6A1Uz6dG?=
 =?us-ascii?Q?BThjVg8vcD3nOnhBsbJYbfemQvj1RxFZZnf1GV1R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb6adfd-fb76-4931-2818-08db6115ce74
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:57:29.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2cmhO7Srpk2KO4vhgvxOkloSmMr95MNkwzDXA6x7ER/LWN7xS0xzxcrsEHbuAOsGUHMSnblfPuELtcWqMUhRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8652
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 30, 2023 at 03:08:48PM +0200, Krzysztof Kozlowski wrote:
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > index 5fd8fc604261..eed12687b0c9 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > @@ -21,6 +21,10 @@ properties:
> >        - enum:
> >            - fsl,vf610-edma
> >            - fsl,imx7ulp-edma
> > +          - fsl,imx8qm-edma
> > +          - fsl,imx8qm-adma
> > +          - fsl,imx93-edma3
> > +          - fsl,imx93-edma4
> 
> What are these last two? What is "3" and "4"?

imx93 edma have two version, edma3(AHB) and edma4(AXI).
There are little bit difference at channel space size.

+static struct fsl_edma_drvdata imx93_data3 = {
+	.version = v3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK,
+	.chreg_space_sz = 0x10000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};
+
+static struct fsl_edma_drvdata imx93_data4 = {
+	.version = v4,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK,
+	.chreg_space_sz = 0x8000,
+	.chreg_off = 0x10000,
+	.setup_irq = fsl_edma3_irq_init,
+};

> 
> >        - items:
> >            - const: fsl,ls1028a-edma
> >            - const: fsl,vf610-edma
> > @@ -101,6 +105,22 @@ allOf:
> >          reg:
> >            maxItems: 2
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            anyOf:
> > +              - const: fsl,imx8qm-edma
> > +              - const: fsl,imx8qm-adma
> > +              - const: fsl,imx93-edma3
> > +              - const: fsl,imx93-edma4
> > +    then:
> > +      properties:
> > +        reg:
> > +          maxItems: 1
> > +        interrupts:
> > +          maxItems: 64
> 
> That's odd. What about the names? What about minItems? Anyway, this
> wasn't tested - you will have failures with dtbs_check.

It passed dtbs_check. interrupt-names is optional property, which
will no used after edma v3.

Planned dts look like:

+                       edma1: dma-controller@44000000{
+                               compatible = "fsl,imx93-edma3";
+                               reg = <0x44000000 0x200000>;
+                               #dma-cells = <3>;
+                               dma-channels = <31>;
+                               interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+                                            <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                                            <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
						....
+			};



> 
> 
> 
> Best regards,
> Krzysztof
> 
