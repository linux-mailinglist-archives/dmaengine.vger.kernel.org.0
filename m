Return-Path: <dmaengine+bounces-768-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4C832DFE
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC821F25E93
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A0454FAC;
	Fri, 19 Jan 2024 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kQ1RoJ8V"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F25577B
	for <dmaengine@vger.kernel.org>; Fri, 19 Jan 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684725; cv=fail; b=YBoXxLEPV+jXLTI6X5qnEmrxxLhwvOSgYAWz6Jph2t3RHLlGSXwUOI0DO37wu86orUv83X6dwZU+AVpe6WYBREmdpYBLn+DpxWnt5WK0OGeiEajKyVOV0K1NPBVdMcIxdCpt7x4+pC0Kt8AB2YEdWYpPMqX8od1zBaSyhG4IUK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684725; c=relaxed/simple;
	bh=TC3Fyp3+1KyLCkn/qKcFsmSxNaH7G3CycIm9prZCAYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtCeXUuUd9RA5/dwN8VPgHE62WaNiQyP6bpCWfr/uXFp1o8blniF0vSobgO027/iZhJxMyUfXL1gROyiAda/P86Ev+P/unTP2xr9j8H/mKeWO8PZnjbSB+E0iVDkPxfPDPWGgnQk8h6FzNxK5mkQr2uWtnRTK3N65zaxVoKPBKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kQ1RoJ8V; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbmVCrGqEd5DQhHiiLC1CVzhhMqJrYsATMAVMQfqGHSJjQdvAl7BD+L0laEq9xJWPcAVfArqOqql6DKo1wno221U3DL1G3bMe8WxIpEIfJAoC7OZmcwigXoxmCvlydteZ8DQJ2W/J5gRUrNM2673lFDPfBqPJJjIB4hvQF7uAHonzOgPqMp0g7sxuDE0bMYyYUV0OCjHaoPBiWQpvKfL2OClvWTOjouhgUYZYzNonBkdlOBXhVmvOBP987I9V6SH9ntuRWqJxLpW+FJZsL3GiCdeMWr41RZPsjCQ5jIerXSVX6m0A6DrWGpA5AanWOp03TlqLMqE6RaogoGO+S+KHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCgrntwDncXqDUWm/tPYrzb4RGJXURxeWdve3L4P9gA=;
 b=IPoPLCqSn7SgxR0r8MrAaC53kopM6OtCDNfL/Z1wSeLZu1/McU4S7b1+yL/FLjo9ojeaZnUw8EWBTIr0ggLocGiwi/SzkSjUZx7nRItxHIMBdrwwM2FAeF2zsqznJdn68BOH2tmI0GFNtGU0CZg+109Tml1tGXUCcpulZnEz8aFcejfKVeE4YB6c6j7jEaLV/NomC0P68V6AMWWOUHhmhXvIRzXPVwsaU9YkfgLTYbtIU04U4Y8Uey85mvv7At6R1V8tjjTgA9NKbdCUXRNr7wivE4IzumGlD53THjyQ8mbB4WUZBjhNByi6Lz6g6VMO3uUzucOhG8ZUmjUtLlVK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCgrntwDncXqDUWm/tPYrzb4RGJXURxeWdve3L4P9gA=;
 b=kQ1RoJ8VpAurJjB6yX/On99zL1OgYziM5C2T2bK1jY4hNdaOI+y2iiOhja5b30rb5jInVSXPzPIHdDTVEpDUKrTL6hdwXRJIhE5V0vNnE7Z/UIOo71dCpv2FP9axsqVxAZsv+O/VQ81zMbkAnOQqyE4F6MMWQVln8DKrHkkDsM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9979.eurprd04.prod.outlook.com (2603:10a6:800:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:18:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:18:40 +0000
Date: Fri, 19 Jan 2024 12:18:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: fsl-qdma: increase size of 'irq_name'
Message-ID: <Zaqu6tr5WtvLZzXb@lizhi-Precision-Tower-5810>
References: <20240119124944.152562-1-vkoul@kernel.org>
 <20240119124944.152562-2-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119124944.152562-2-vkoul@kernel.org>
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a8356f-12a5-4581-4d3d-08dc1912ae36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0VkNretlmepLmFdzmoWW7e2hjoYLWvrDM/NV9nw17tt3GGwhR6JyTzIPdpy7LTzpicv7cZ0+6rBsleUZc5NzXRVcyvvn+aEkj6A4HUDgkLZ6+TFHYZrO4TjR2lymMqn5pWEZ6WlULILW0wY0n6B7ITQHdbz3v0frMExr7PSir22Po+TKfh3R4/YC0CQ6thO72KvunYTbVUPUFQ+do7MYqVH+jLWUsJunl0xeEfD6vBBoR8ikjnSfOKbqFQUiFCrX5Fnk6jv1aM7cwS1wHf9pw7xdlQ8w4iyXpZ94mCJFZwM3iGQAzZoWrFrUV3eMiOPxw9Cq01PGRpdtRnadJ96M0QE/8MyNs6qwJYt/KMVHsO/Y00GllAp686pDvbA9ralIQUKkokAH/R9w4zslmrMv6PVh3OXfYHk9+JRqImGMcV9q7SDX0qi1xPWpZLdUigETQEvzTyq98vlHkhbAegcbSC03eBf1Xr0vGN8VcVbM1APFwM3OOhViJGvXBCraNrnUhmC3oY2FhAF0CUd+sLBEOkv3SKZJrWW6Imz2TnNWIK61NA/Y9TsZcfHpJdYQhlmAJ94lBegr9rI2J+Ke5BcDOisw5qb6zDTcn+HyHPxIu8XqWQkVcSf2/zoVEAu3JOxQv7Iry651C1K7aV+6a9eXAd1M+hT2rTTbZz1wrWxWKmre8PqzvTSBzswVJ7uDnSSa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(396003)(366004)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(33716001)(86362001)(6512007)(9686003)(52116002)(6506007)(83380400001)(6666004)(66946007)(316002)(6916009)(66556008)(66476007)(8676002)(4326008)(6486002)(478600001)(26005)(8936002)(38100700002)(2906002)(38350700005)(5660300002)(106533001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHNTWHhFOWhKakVIc3FneTRKNHVUSGtCOHFBRnhPVTN4SFFnYkJjOVdaaCtY?=
 =?utf-8?B?UWhVUnNFYjNUS2d1TlRqNFBVV2s3cTZrbjJLcURVODBtQ0hvV0thTDJkRmtq?=
 =?utf-8?B?T1FVUkRjeVd6TnZvYWZ1eG1yd01LLzYwL2NSalVzUFQyZWd1Y0lFL3lmempn?=
 =?utf-8?B?L253TitEU2tiNlV4c3FhN2grNS81QTlseGZ2b1RNSDhRb1BEWlhEUndpNTUw?=
 =?utf-8?B?S0tKSml0RGNFd0h1bmZXdUd5VDhvd2ZrbWxhVUNSaDlhNkIzY2lJUGVZb0xG?=
 =?utf-8?B?M1UzRTZMOFVnYTRvQldrQ2VSMnhWTnUwcWJVME1maHN4WldUTWFxM1owL1R1?=
 =?utf-8?B?clpaR3ErSDFHN0FnY00yWE1iZ0NxNkZoV3JjcmpqdDVMa1NrYkwySGRFWkFm?=
 =?utf-8?B?Y3QvQkpQWnFrdXdYblpRYkJGQ05zMjBwUVptdSt5RnpsMldNMXIydU5WMzI4?=
 =?utf-8?B?ZGhQam5qRklmOS9NcU1YSGlxdmhRMzludXl4YnNDNndvYzJTT3JQOFNPWEZl?=
 =?utf-8?B?eklPMFlqN2t3NHc3c0pGUml3NkN4VGVHYUlNUktiNVRETzBBYVgwVkhpNy9C?=
 =?utf-8?B?WkxhM1hpanVka2krTk9nRzM0NzJVTTZMdm1ZNEUxOExXNFhEWTAzRDhNd3dI?=
 =?utf-8?B?RHB5WFFOT1JWUW1idVU5RXYxeDEzQldNb3NIV3BOdExCZWhXenhLNVo3WWJG?=
 =?utf-8?B?dGJhZExxeWc4Y3RWenlDZGZsZnQzNkpGNk9ncnNiRUlkcm5kMHZuUS8yR0ND?=
 =?utf-8?B?UXEya0RjU1ZsZW13SktFQnlESjF3aGJIUzdOS2puOUg5M0hFL08zMnRJUzJQ?=
 =?utf-8?B?QVJFNmIzTFFMd2JBZnRmWFh2bjBKYjI0YW9JcTBBazJ5Wm5UUmdId2RRU3BH?=
 =?utf-8?B?OHQ0clB1YTBoaE1Jck5PaUsxVll3SlA4YWZrQzdBeVJ3QUhOL3BETUxXN3NJ?=
 =?utf-8?B?RkRrUTNFUmNCYjVtTDIySUhlNkE3bGlhQ0dWN3JKOUg4OGhWRzdnd3BzYUgw?=
 =?utf-8?B?NUxkakFsOG1RZWpBc0FqQjlrd3M1RW8xamc0Z2NjcXZLQ3RLWlVVNzVkRUNy?=
 =?utf-8?B?a1E0YzdFcVlGTkFSNlVmVHlNMytnUzR6TTNDYklLM2QyUklyRXZtTUw0Nmtn?=
 =?utf-8?B?Y0k1TjRjOHpISHc4RFVLWXFLVEExa3lGU1lGZE9hcDFsMWRELzBwN21OTlE1?=
 =?utf-8?B?VVhxRGgwRkJCR2hKdDNnK2x4SzhjY042dk9QY2Z4YnZ1VWJ6VmhDeHpXTHJP?=
 =?utf-8?B?clRkUUk4TW05WG1ob2JVSDBIUE5EZ2pBTnNpOWFYVVZTbU9QbVpyVE9YcUVs?=
 =?utf-8?B?YWFMRFBXaTJFUlBMQklKQkhBbUdTVTlLY0hBL1J3SldFTm14UndSWDdzeDlN?=
 =?utf-8?B?SExKZEZjOFhkM3pRaHRBS1VjRVhLd2hvSzdPenJYNy95S292R0F2RHJBSmZY?=
 =?utf-8?B?T01TTWRraXhEUzJoRkNVSy9XYWVZQVptSzdQZnB2ZVRaQkhIaSttaFVxSmhQ?=
 =?utf-8?B?VElBcDFreVAxaDF5Qy9rUTlVYW5iMURiWkFxWUZaUktjWmY4R3VEcVdCeDdQ?=
 =?utf-8?B?N3RCQklrRHJ0elRwR1dCeU1jcG5vQ01CZ3d6cnk0UVRZREwza2N4bThWOGIv?=
 =?utf-8?B?MXJIQklJQ3NjZmt3VTA1N3JCRXA2NjU4OHpsNzUwNHowa1l3S0lyajVQY2pp?=
 =?utf-8?B?TFVRSHhFcXdYSEE5Q2VnbmVsSjljZEo5Vk5vTlQvdElUR2k4VFlDOGJhdG5m?=
 =?utf-8?B?cS9adU5HdklkbHdPMFo0cVpMMTNYVWFrcXAvWXd3NGxkb0NqTTFRNUFwRGt2?=
 =?utf-8?B?Ym9vU1JEUHpXLzYwdDFteTFpTVZwcWsvNk05MmFBMWtPQzYwVG5ZNFVSbG1j?=
 =?utf-8?B?ZUlhVXBGMTNSa05UVjVBY0E2bkZ5ZFVsWFNBVGt0QVduZjNGS0xDVEVrTmpz?=
 =?utf-8?B?TDNDUXZmSitRSzMzUlVtTXBYNG5yRDFRbHU0YlRXbitLL3oySGFFaGhQdGJ1?=
 =?utf-8?B?czhMWlVobzdGdnRjZkN5UExWWmtWMFZ6TnB3YmdNY215R0RXOTVnMEtsM3U2?=
 =?utf-8?B?cVNXZ3UvRzZWa1owWWp1dlgrWmpsWmJ0dDFRWDU2ZUVwS3J3SEUrZEpPODYx?=
 =?utf-8?Q?h0X6RsAdvpQiV5PvYAqXCDXCs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a8356f-12a5-4581-4d3d-08dc1912ae36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:18:40.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: De/qgoFvbxAhFHi7ntpoLBfeoy022/3kQX9/1wxxBJYtO25hgtYjQwXE9+Pp4QuM2dRLO2PULvUteBzwqziesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9979

On Fri, Jan 19, 2024 at 06:19:43PM +0530, Vinod Koul wrote:
> We seem to have hit warnings of 'output may be truncated' which is fixed
> by increasing the size of 'irq_name'
> 
> drivers/dma/fsl-qdma.c: In function ‘fsl_qdma_irq_init’:
> drivers/dma/fsl-qdma.c:824:46: error: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Werror=format-overflow=]
>   824 |                 sprintf(irq_name, "qdma-queue%d", i);
>       |                                              ^~
> drivers/dma/fsl-qdma.c:824:35: note: directive argument in the range [-2147483641, 2147483646]
>   824 |                 sprintf(irq_name, "qdma-queue%d", i);
>       |                                   ^~~~~~~~~~~~~~
> drivers/dma/fsl-qdma.c:824:17: note: ‘sprintf’ output between 12 and 22 bytes into a destination of size 20
>   824 |                 sprintf(irq_name, "qdma-queue%d", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-qdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index 47cb28468049..a1d0aa63142a 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -805,7 +805,7 @@ fsl_qdma_irq_init(struct platform_device *pdev,
>  	int i;
>  	int cpu;
>  	int ret;
> -	char irq_name[20];
> +	char irq_name[32];
>  
>  	fsl_qdma->error_irq =
>  		platform_get_irq_byname(pdev, "qdma-error");
> -- 
> 2.43.0
> 

