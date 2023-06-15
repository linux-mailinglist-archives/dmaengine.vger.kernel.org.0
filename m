Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3452D731B78
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jun 2023 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjFOOhV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jun 2023 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbjFOOhV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Jun 2023 10:37:21 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5591A2;
        Thu, 15 Jun 2023 07:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQmtZ3se3XYsJO1pLWx5CmeMSKO6Dzmd6Kj/Nps4gE6lo7GTYEAB/m/07vMwmXbeqY+g5iXa9rHG1L1pAIU6LVu5PPt9aFmUAi5SsBOt7bOZ5zw1jZc4QiwFRxWMfIRi3RYAjvKd6ATnWxvZc1yW/TIhBO/XpjKlJ7F/aVWErijZfpfCEf+PcTfSqJguwgEM4SksCCFI1P6rwHRMX3TnxaCqdTbrTC8cdZKck6R/mPglhe2rjOP7ZukZU72rC3NSQDZOpdAVYnbUzLhpc7Jc8mQEOx3OtSVSuGvZ2FTVfe/NqxZjOXYKwpZwTvG5WbmOn37fCh8MrYnpyzOGD/AJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv+Q2r/Lh4ip6Z0qBGIMTwH/4j3eKpo2sBaTwhSpLeA=;
 b=FqQ2cc2R7qpBhTVWjp939ZcOocKOeynkC4Q0sisQRMFkLS4bW+bgSTeIm4uuSd4Ck0f+Rhgk1eR3qX0Xvdqa8HNBz7pQ9LcOkTLKzZkdIfv14/uIAk1smV6ZmYvWoOo8R3GaGrHV2Ix6ZUW89LEUYmX5o3ZZglWCc8kn/oaxIXGa/FMPXT+VnQu6SF7CyUXVfYeRBvGa2bNliLzjJoeayQzNiCoe2eJi0MDEMCPzr9WWZc4SOSRHP4p55KbNEaZPAWBlPKjJXLJTQ/SQed8vOdF+ASs+xIL+XXSQT6YIW9IXST8t4F+vAKATtF06EUGIAS6bCNsfC2FBew0lNhDtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv+Q2r/Lh4ip6Z0qBGIMTwH/4j3eKpo2sBaTwhSpLeA=;
 b=Gh4H/2a1R0yTvYzILvPZbOQsB5XhxPH0vDwaoZaAtYSv5EDSuqiFg9qmb8DfSiqisJ/p2iQBNf2SzdCyIxZnbGiiDZ7JkjAg6lh/hyo9UkzdH5MKVZQVhGAa0aINowi9GgM00ZslZRPELSEAWRkb41ix3IUB0lc6Hk7jL5w9uko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 14:37:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Thu, 15 Jun 2023
 14:37:17 +0000
Date:   Thu, 15 Jun 2023 10:37:04 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: Re: [PATCH v6 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Message-ID: <ZIsiEIhmpS7DSs6R@lizhi-Precision-Tower-5810>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
 <20230614193544.2114603-13-Frank.Li@nxp.com>
 <0cddd5e8-3de1-1b6a-b4b8-6304e4c674cf@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cddd5e8-3de1-1b6a-b4b8-6304e4c674cf@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: d05c5b48-095a-4617-a5f8-08db6dae0489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mspyX4v7qIgwVEj+P7nwmeWFXW8MyxIiKipmjje5155NrWeOGsyHigSp4MxRQzC7hNp6sCHoBZjuyZBa0T0Q5rOTqvjzBwq8+1RsjUucApQulPWWimnl7jawCVyuBOFWxsQgrPgVAT5ifb+KObQHKjvE3SRkDeZORMcgSSD1JyIBPZ+ficRQG1U3qRuutyFXawPXtqTZJ53X/EUMElNPYJuXnA4H5nT5umcAIHb/RJlCF/loGUQOPHHUhN8bcQfAehvOG1rOKgOtAUJq0IQvYX4MlmioJRy7s8VtKjPcYiizETzZjI5glbVgLepXAOsnIsuhY1TE5Vg0QWdKzrPTkaoGqY64VY2pWmX+Xr2HeAKeQX/j8z3096+yZk5xVySlMdDh01vPB4J+6CPaVseD/8qNTfyGKfVVyrNu/tgY4sBBeHb4enIW/zGqq8fbAGONC29Rk6zfIAKQEM5fEQNL0+jxo94klxc4LOuJPKzjFtyMITypUYrFqBZfS2CzH5BzzUaWrVQ4CXkAykz++DS0Tfj9d/n7HbFQLfM2ybgpIbkaQDjTF/QjenxBvZ1QNjJ7idWoUoyuR8LGug8B1qJBuIKa/0UKrwabVMQS5Q6pvYy+j3bK6tEVUS5GkdtEMwt2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(186003)(2906002)(83380400001)(6666004)(6916009)(66476007)(66946007)(66556008)(33716001)(52116002)(316002)(8936002)(41300700001)(8676002)(6486002)(86362001)(4326008)(478600001)(9686003)(26005)(6512007)(53546011)(6506007)(38100700002)(38350700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fYe+dr7A0BMcrFWNmC8xzzV4FsN69Dsqu3jiThsLDIJkKPRm6/eR2vsfT/B0?=
 =?us-ascii?Q?2dmj54TG7A5eYhW9X8yNvH75eHNzKv+PmvfMQJRJ9iM+z5Rlu0VD/uhm+NfG?=
 =?us-ascii?Q?iNPIH6mZtePIt4ebTRwLVfwsRTaG3IK5PzmTgqYoyw+IYKeRFt79A3lmBL+H?=
 =?us-ascii?Q?runRDBVHbbf1072lfQu8bGPFELsob6J+wJ0+WMlgZ2J2KCkWOF97Z0ICADNL?=
 =?us-ascii?Q?ymggfBSR9XDqLii+bv87iRQtwul1Tu3TUdoSjjX/zb7nxp5TffAFwJ2EVPxr?=
 =?us-ascii?Q?OpnXaFV2rB0bepvcv5PZwZiM2G7K45N9D2kCyuWigxzsD4PwfZVwTsDrRqm+?=
 =?us-ascii?Q?ZUOoOqrfNAuyBzZlqXVFhq3aI0JU0RrPoOCE8NPcUJvukrvsvBk47/fZBzH6?=
 =?us-ascii?Q?UFIG54NELECwIr15UuDTTozWecU0tTAej0yeBWtYdlMCxjWyjKLWQhDZLvua?=
 =?us-ascii?Q?uqQATj6iHojuY/51MfGRFDdWFrqy1+Jpc3ZpoPc9qkKDIyoEJoqWUhomGytK?=
 =?us-ascii?Q?lL83tp80+S4kqWCqp2NYZG1VciID1uO/QRLtb+utVfzNIeCRHeT4u1mLd8pZ?=
 =?us-ascii?Q?I4YrknuKIVwOhoUGa90/UC4VG48rJ4efVvbGf6Y8+qSBbsljHk/LQ3G1ikqf?=
 =?us-ascii?Q?OVjwyoOhDkyYUJIsfDHJI8vfK+PwRuZX+MsHdIXwMED5HXgx1oBWazGA4Unq?=
 =?us-ascii?Q?u4sBjBB4l4zS77bDtdeYrGmFOYrq/yzL+nB6JF8gB5khxgaedukveMPsYedJ?=
 =?us-ascii?Q?YFOCvKieYAUxXYCmxRETg/J2/PcW2OAInwRJSsWAt3aAmgdaJwp1vBJvXPlC?=
 =?us-ascii?Q?zEyXmGDDQHuIwUsq+evd0SDNubWfZXkxpCWMXAmGhod3bBNaz8pOsCa1mj82?=
 =?us-ascii?Q?oQq0Wl01cZKe2txPakN6FaWoUo7pPbRluu53zR3VP284vL+27nq0kieE1Ev6?=
 =?us-ascii?Q?zchjz9US7MM9Z4VE9qihpEWtqeSX0Pd0zsc5EjttBhUtZ1wawsWQxMLwCB3v?=
 =?us-ascii?Q?D3NvxCGP88cvmUbQH9aRFRhgqN+h8MJ3xkuV/PHC73Qjq0bbpbdY3Cmiajeb?=
 =?us-ascii?Q?cCHXSHrpwjr+QhwfT8PUEIO6Hs3v4Buak9KfGIvwkgO2QJRlsWFlAzJqPAXJ?=
 =?us-ascii?Q?SJ0uLxXnRz+6mVIqVKM5OLlpqQr0632vIoFr2l0dPHfH0EtsJVej6ZtKdcwG?=
 =?us-ascii?Q?Nci9pbDibuZZtDFwsBzmhLZL4/fJqQZZ1vx6ZfqA9BcSdZ0DrvZwhrqKyOJZ?=
 =?us-ascii?Q?FIFZFZxgs9u4vptl9a1A5gO1qAnElLl5+uRM09xJ3ksXWOqdC+8O6kaY2tXU?=
 =?us-ascii?Q?UPmDFXAzYmdywvN4xvzEAZnvstcNRqZ7cI/cEih+yL9kMCC136Q6XvSEgBw9?=
 =?us-ascii?Q?BPNnNj5kmUxons3KmilBoDySO8xVg2AklLLvkZjKQ4RsCB350Qvqm9xNd/30?=
 =?us-ascii?Q?ZYWnAIlken/p3Sk+Bgym+DSqXw7TWsWkAG+HscLtd+Ia3g1245EWTaiKWGf/?=
 =?us-ascii?Q?Rs/WmQCwkdA+90zu197q0J5v2GxwkFKaFPdY5oxroAIVp9WOg+3u7hmnQSf7?=
 =?us-ascii?Q?rZx93VeVHAmSonjcLAbqHCceLRlqoVUp93lEScBe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05c5b48-095a-4617-a5f8-08db6dae0489
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 14:37:17.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGLqIPRv4bCTWaU6fIVdUWkCmnUxOZqVjou5RvQw9/9fTOmO2r2fUNCc15L6NmgL+WIttTeB2VVrxVC49Zk+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 15, 2023 at 12:52:18PM +0200, Krzysztof Kozlowski wrote:
> On 14/06/2023 21:35, Frank Li wrote:
> > +        # It is not necessary to write the interrupt name for each channel.
> > +        # instead, you can simply maintain the sequential IRQ numbers as
> > +        # defined for the DMA channels.
> > +        interrupt-names: false
> > +        clock-names:
> 
> items:
>   - const: dma
> 
> clocks:
>   maxItems: 1
> 
> You do not allow more than one clock, right?

Yes, at least now. Only 1 clock needed.

> 
> > +          const: dma
> > +    else:
> 
> You already have two ifs, so you should not have else here, but rather
> make each if clause proper for your setup.
> 
> BTW, the amount of differences point to very complicated schema, so you
> should think whether it makes sense to keep binding growing in the first
> place.

Any good ways if don't growing binding at the first place?

> 
> > +      properties:
> > +        reg:
> > +          minItems: 2
> > +          maxItems: 3
> > +        interrupts:
> > +          minItems: 2
> > +          maxItems: 17
> 
> missing clocks restriction to minItems: 2
> 
> 
> > +        "#dma-cells":
> > +          const: 2
> > +        dma-channels:
> > +          const: 32
> > +
> 
> 
> 
> Best regards,
> Krzysztof
> 
