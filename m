Return-Path: <dmaengine+bounces-1820-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBA8A156A
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AE0B23D66
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359B714B088;
	Thu, 11 Apr 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UGfVhO9X"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449328FD;
	Thu, 11 Apr 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841702; cv=fail; b=eqhva0YGPlM8ld+yqJKRrMTr6pzJY8Hh8FhpaGfb5RBx0VWcLK23zjOYu7HBQHJrbJYNV7kJDaPUeXS9yWfutLaX+KChwPR+nqNOpDDpQAPmAmcxCJUMu9WjbvlHrzj7i8giITKdkXhWvUllgI4cNMY5gqJYD+v+JkKV+vW5zzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841702; c=relaxed/simple;
	bh=SZUITsHALiiyO0prs1mq53P7aIBdlYHxPPHY9cjLJKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j/2FWu1CDULI01/UVvF2i6r86+V21vjWka42qnUFZoogxAcJMxhhk08SguEijnMNDQGAesEHp4m72ve32mdiaT79ovK50z/musiRBkuNiPSgxxVCGWTR8Coim9HYES4QR/Qh/Ytb2PqD5dntsOHPfVRdKfIXSYr023doEXMgt6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UGfVhO9X; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chQeCnquwFfyjK+2SQk6KaqfSqysCKmUVSIdKG2BF3RF9lE/OfmMNFahPnkowcAODtuJWSyxm2pSy0oHneFxy3WhkZ/pN2DFQJu9PX6PlyrE56eXuRdj3lW72hvQ4a78xr/Ylc9kRCtEkOPt2kdozQxqV0RdSx/novU9AXU6D4mNYqSRQEA5vTakiJPnnjWZmTpNzVNbh9LuA4QtLCuTtXlPWUWELEyMAwJrtknt7nhdn5xJXQ3UAF/G8aBhUuaMJEQ/y8FW/msNfLX4Eea/rDjQruRkmgMTikHrlz/KkykK8eCVq7WA8vyAsGQ52/E64DxWawHhel7N9aeByHLHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8UIhPziIrwR9715mPCkp1/m8h39PR8rWsD9lJi1wXc=;
 b=oIHUx8LwwEFDNWBBSUZuA1CL+TQ11u9uMMwuRjvrINS6HKpza96+msbALms1T1UeRcn6XfTm4XoE489ekLE8FZeNIVdsVJkmgckhGsj9z9J7uQtETyTkU9ZKIAJtRecGwcmdO0SDSXlnxJ+WPumnFK1s1cY5B/KmMr9JJoZxxWkk+HFLuWY84B2WB6WA1F4RMVwGSDNqBhLtptc2NHJBw4P1olEzqTQLFiTtpSmnJkhChj7+aHOGgRT5SJ29PCx0A5boG+TaxML+B2fbFe0C7It5fbWT2uzAKv83hAtIGVdRCnJgBP0CJtT5pBJisrzO/52qyGql3FRbYwG9HbNtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8UIhPziIrwR9715mPCkp1/m8h39PR8rWsD9lJi1wXc=;
 b=UGfVhO9XOPlMx8KwhMnaTVRh53cCIRNDWVHZyV2vmjAtjhOuuBTHdgY/Ovm8e7oDNJ1VXOIFwXirHBBk20V6XfEv6djaR61uYdFMw7rAcODSckk8Bg6feqZlnP/VETgG6WSjbAqHllbr1T9YaM9EkAIYeY/wBROWr2WyN3cO1uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Thu, 11 Apr
 2024 13:21:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 13:21:36 +0000
Date: Thu, 11 Apr 2024 09:21:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Joy Zou <joy.zou@nxp.com>, peng.fan@nxp.com, vkoul@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dma: dt-bindings: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible stringg
Message-ID: <Zhfj2NH7PPqzz3nM@lizhi-Precision-Tower-5810>
References: <20240411074326.2462497-1-joy.zou@nxp.com>
 <20240411074326.2462497-3-joy.zou@nxp.com>
 <703311b6-ee3a-4131-ae11-57b8d765db5c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703311b6-ee3a-4131-ae11-57b8d765db5c@kernel.org>
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: dce86b74-a1a1-49f5-0144-08dc5a2a5049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	snabl6Zttz/JYP8P2kFVzCoSWKfVjt1+Ai236zArwUsimO+h6d/ZRVd43HRKovHdewlKcaxO6kGvYiquPTEZtgvnX+EecnGwIv4lVJAYKyZSD0UXIM+0Oe3V+QLDRoB69nZBor4eUctSVWDsZuFvdA5BaZr1g9oOuQcas0FxpDrYZ77vjxQCetJi5MaCR7MKb7L9J5dznOvkrta52OXKRw7VyDMYhwfzoRSH5T9+/IcGbwpCdj6EbIoGg+CCkOeS0M12JY53i4BwqWaotWf5C8FJ+7hvOsuq6RIKFqvARULMNUf/9nmlm4xHWPqYIwXZc0aMnySS5cYzFu4AKD+bF6LCPncGAoC+0j419tKA/7Pf6y99mJffkCA4wGrtb0rbSBkoedVuhmRjS7RMF0/QDjwpiapEwAiS9n3Z9ULj26qk9cZCCoSwG4z1hHl+9QmsmeNrQKsyQNSOdgUeTcM7poEMD1jQmBDBDyvCe/IxmP+Sd7i4Pu3Oc41GnrjVDzRkZTxpRm72jbJD6lOn4cODKT1ZY1LZoxGMoF/lCIEO6RWvTp3iFc9hnANXWgFYEqXblhTxUrqzZng3q+UO8S0hritS5yGp+r8GS5TtyaTO/L0lULzIO+duEZQGKJ7+DuDT4zClFVYyC5AVJ2Kb1JTdn2si1C69toJ0z9tIN1/T/8wcaY4RVKAP9sdB0vxaVuWApIKx8nMB11q1FFtufHeUjTdzAa42pb8B7uCebR0wIX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73XuZYfy2T8b5Jzh0q5G25KP6VtzAf4svvwDCg5wm46btcjcjePe6TioqDXF?=
 =?us-ascii?Q?YSDCLq2ofALsCWCn7MFUHbSse9uUoAw2PbmoVpkxscK2gnZoHmPWlrUYDOTM?=
 =?us-ascii?Q?Ts8iETKR939UxiAtnLzfMvfknDOcGHPpPtC9LHpnJovUwbvLF7xLVzT6DecS?=
 =?us-ascii?Q?GPTtIlMjX8DY731zPLnL+HYkJCZdzpge7BoDIMsa1hhsjQHetj9DzqgHS8ey?=
 =?us-ascii?Q?bJM9uHVmxEPUhctzPBw++E23xgEsOaEbWpyj5jM7jT0813kKPBtmkLraY5gP?=
 =?us-ascii?Q?CY07607hWrI1aLwoj84B8vj4+NpX4nkOnzXbONnpPGsCm5tjCggLgPvSEz7s?=
 =?us-ascii?Q?mlW0L2KBHjI4hSWEfvVKIi3AudGHsjrDrKluHPecE9VkTcBDWwqmgPz5Ac+N?=
 =?us-ascii?Q?2VA8CF8zwL7oPN4mmIrLwAYEGxCVLqMAtc6C2FCTOa7tNR3xZSdEGjXZqvx4?=
 =?us-ascii?Q?isL/pueuhLVRMFaZtG0gTA067MpSGQ0OcKgt8yYNfCKhLnjR384Fyh6bPbA+?=
 =?us-ascii?Q?2ruqt7Y2s776sK4Bik6TKweQ6MMcfALkW0mBfegDQAJ9cA8CGKEMIsqj/shT?=
 =?us-ascii?Q?26LhR1OxJHG2KwZLhkX5GLSYrPu2Op8qODWSX+HeKjP9wBst77Z+g6MER4YT?=
 =?us-ascii?Q?cWigc2CBVdhHMP2RTqhTfFGqT5EqTg1f22AGd2wn/lk7QbBE/2iYlUPbPJ/9?=
 =?us-ascii?Q?Abn2u5beorZnOPW62FWx1aOux8P0y4n964ZYwgVi17JvLxOzZeE7ASePghxf?=
 =?us-ascii?Q?zVRnmxgNWufgELbKE/08ZomYcngcPFuP48879esih5NKCi0QmnUdBSOUb0Ry?=
 =?us-ascii?Q?fC0+ZbJAVVo0JFqKb36m5DdpK+Xs1ojSR3fPvijrIQtKpjg9nK3N/esSfw7t?=
 =?us-ascii?Q?TDBg2JT3gmijBnKpciYIwhve0rfCKOLCJQ8b2mAvbh48DQkbcL+NovjHkkas?=
 =?us-ascii?Q?hCG1fxZf+BUcPEXxjtMEn2aVdtU6/oz/+BrU7hTJ9OsrPCaCN+6FjTaCj/vd?=
 =?us-ascii?Q?uBN2GkCYdsrrR3BDeHtGDlHOmLj+p1azP2enRfHR2UvTlMnOI7kPmW9SzFdo?=
 =?us-ascii?Q?OyRmOqS8xfCCH+9U7D1U9fgIbnnp9d820TvRMR8kNRPNC4cJo4gFIrf4qnXD?=
 =?us-ascii?Q?pOedd1FOw3yPE7dby2a7ZE3HoCGhIqk+qxfiJE1r7BlBlBQaRz4tQ2WqoOiU?=
 =?us-ascii?Q?Ib0VyyZYOutLsKaT15CfTfWvHF03teQDIA1egIkHiDsKG7uPFGXlIgVhJfPi?=
 =?us-ascii?Q?Nz/YyXWYPpmDSdGhUDbsdFaySc3BKib8FAWw3bJVIqhAwJ9/5QGfb0slvaLB?=
 =?us-ascii?Q?/Qv7RiOxegilw3QO7RvAkCL+ZXOhFVG7dio7OEjpAZis7skqH0D7eC4qyeZz?=
 =?us-ascii?Q?ocQylV5fEJmoAYV71taEXOBmlETzQl1DJqtrcq6kvaK18mvEg2yc2N2w6Gok?=
 =?us-ascii?Q?0SbVF4TzFbAZKjMMa/+/pW8oXyt34aSSTuBpvbMKrkKE4fnMEzA/Cot4xIeo?=
 =?us-ascii?Q?2XHosOHAaIBqbVUM1xjUElPQ2bo1WA8slZCG50dJjwNtxVChwHYWPpeiT+Ci?=
 =?us-ascii?Q?l0kwB08JKBNHAFtEa1ww0yQlnuX6bFpreXag9f4W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce86b74-a1a1-49f5-0144-08dc5a2a5049
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 13:21:36.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etZ14X4ugwYWe2KmQ6cybSas9zSVov/9Q9CowP8+I9BAszgIhI5xvcOKcvP3xKokyw5tHytodgPMYBPJVRS+AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171


It should be

dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible stringg


b7b8715b430ee dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
6eb439dff645a dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
10cafa2d45885 dt-bindings: dma: drop unneeded quotes
cfa1927f8468c dt-bindings: dma: fsl-edma: Convert to DT schema


On Thu, Apr 11, 2024 at 10:13:38AM +0200, Krzysztof Kozlowski wrote:
> On 11/04/2024 09:43, Joy Zou wrote:
> > The compatible string "fsl,imx8qm-adma" is unused.
> 
> Why? Commit must stand on its own.

Joy:
	You can copy patch2's comit
> 
> > 
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > ---
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> 
> >  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > index 825f4715499e..64fa27d0cd9b 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > @@ -21,7 +21,6 @@ properties:
> >        - enum:
> >            - fsl,vf610-edma
> >            - fsl,imx7ulp-edma
> > -          - fsl,imx8qm-adma
> 
> 
> I see more usages. One more trivial patch which is incorrect.
> 

Please clean up AllOf also.

allOf:                                                                     
  - $ref: dma-controller.yaml#                                             
  - if:                                                                    
      properties:                                                          
        compatible:                                                        
          contains:                                                        
            enum:                                                          
              - fsl,imx8qm-adma  
                           ^^^^                                          
              - fsl,imx8qm-edma  

> Did you implement the internal review?

Patch2 was internal reviewed. Patch1 is new. I know you are busy. Could
you please give me 1 days to review nxp's patches. You see patch always
ahead me if author and you are in similar time zone. 

I knew they are quite busy on heavy development work and all kinds
customer supports. 

Frank

> Best regards,
> Krzysztof
> 

