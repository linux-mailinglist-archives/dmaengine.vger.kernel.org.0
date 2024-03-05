Return-Path: <dmaengine+bounces-1271-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD02D8722FB
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8483D2875FE
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03B1272D8;
	Tue,  5 Mar 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mzalVkeo"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DA85944;
	Tue,  5 Mar 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653163; cv=fail; b=oaL7d6aZQTn+WjbgXfjDmRO8xcxZRxpwgrvhKdnycCqDGeWz41IOWMNFjbcpzka0tuXf9IoFkR+Y6gURAsiu/joc7bn6Mt8/aCm0Jnq4/Bos4mEdZCLGlarqCvaFzHpP3R/paSQhHnmm/wOjUbUEtyu6Hlc7fTXzDMLe94/K79k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653163; c=relaxed/simple;
	bh=j/ChCXyVFr4RIVvBPzkLM2JGra98kgCvHD8XhmiVTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=duBkBLR9cC1SF4mM+3yuwFXGyyJH2eC9NpgdCr3mgph/1bckyL+ozao1TsrxBcCBr6n+nAVxPuTpD2qlNj+xnyFqIIJtnjwFPHtVaZwXS1i6xCpGJ5zVBQSBsrg8kxXuHzWJ9OKvHzxhco1TBOLstd93tkAj8CHW9foN8WqJQ0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mzalVkeo; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJjtq7+pmjJznbcKQVN1M/v3I+tCO+UyWLMXW1EWASv/AHuTEzRY3J1bytpEKUCA1BsRm5I4aLewsUzgRxLgk3LAb5zw6caER/gqVOXosVpeBajqaH0S8b6GJ2UKy94v75kD40eERCGzXZZGmCPmmGU8gVI6/WV4i2Fzore0gi7bW1bROw6iFZaHJtPg7/CU2dV8IxuTnhiCgDrnh8EiOtK2/Azt9+JcwkhZR2zj14llB/LpQSFEXeFz/onoq1S+vZHisA38zdbBcK/V7/zzTe9g2ltJ40E/zVDNEJ3Kd1eXeOVLAUCBWjIA+rPeZEh2ScHHsAj/JZ95ofDHD63vZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/fS+w0aDVz3NdQTbvJcR/qOCVunNidjAiXwekZ/vys=;
 b=OEAAqzO4Y0K3+xvNN6/55wf8veSgchGrNZSee5Z8jcEOps8DrEKH2ECcnZMOk3sWOHn/V/5glQl+KkcMiIi1YcdolDYOe1RYejMo58IMuR+Qk11BCeYQpxoHzV+S6YwYSUf9oCwi881sdilT7lvf7IgSA3U+gTSIyu76Q1kBGd+Y2T5t8WecCd/UCpni69BioWXuw0Dsa9qQXNZOw3ky2BqQluX/TrNxOyhvm7PEurIoS4kZWUEckD7r6belw0vZ2AlZxubeUy4ZRUU5yQ7sGNRRtNS0Mq9cxDId9WBxN1YEsRZc8lacDdMmh2axGJkDQK9b+yXj+gtMXtr7WyTJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/fS+w0aDVz3NdQTbvJcR/qOCVunNidjAiXwekZ/vys=;
 b=mzalVkeo+at2zMtDSB+J70WAo8z3z4nku5waUCMVI4rdizt7f4acZd8Cc0qK8Q3clHcl45FOj5ywSBujSiOCvYssIXIaEovb00zz0JBCm6WuMro+FXSGtMhiLFDCAN9FNgWCBSFHM8sN7TJgr2JPBQbxRPVWpV9vaES+GKINt4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:39:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:39:17 +0000
Date: Tue, 5 Mar 2024 10:39:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Robin Gong <yibin.gong@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 4/4] dmaengine: imx-sdma: Add i2c dma support
Message-ID: <Zec8nYk6gzx9IxOS@lizhi-Precision-Tower-5810>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
 <20240303-sdma_upstream-v1-4-869cd0165b09@nxp.com>
 <CAOMZO5A60zG+1u0NYPFaLsAgCxcF1RxxybVeatovTGj07oxqBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5A60zG+1u0NYPFaLsAgCxcF1RxxybVeatovTGj07oxqBA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 043733e1-ee1c-4128-710b-08dc3d2a6b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9DKP2dofwyX9NPnm3b73UU33/3a2pgwSCUFnDmiuQQllkqt31Ea9o1pnz8/ERytqudrpyldluEOtB5U4H+yLeWFZw7SGnjE4wjAmJ9vDNsNBYnacwcNCRd3Wqm5fO5BYTw5+Xh7YisYNtTvE3m2/qANVydM+l4f4V53S38U2tjrgODVV1pCo/8AqD874cDkF83IC9hqSSx93WMoDhdk1+5pCvtqK1r96P+vdPxZyxPpGzScRSQmkrM8cJcCjkHnbQRpgmsJNGkwoR4Gg7BEDvzTKcPuGAolnBw/fxFfkfSyX9W42YmvYxb2cppwrFhkU7HO+B/RTu66T4ejnnmkPMKKWqd3TdRTBZnit5gpznrcwxPNJz4JfusJC0CeQmvK0pnAcX6FJ2qAyLYQ3l+XQMnt7nBra7XSzKsvU0qkIgp5F8yWQEYsqCcEz87wdQGY1ScxRIw9l4ezpYdrK9D7L2alinv9R35a0ET27olev8Rwx3Wa6GH7nxqxwWQDOIKxjY5O5X4t88TTDsUSs/ftTxiSdzds7UbakhyOcDEJK8Tn67R5YFb6XwjxgdU9AGMHe/9+L/iOEKuyekBz7g51jt6IyoTSHkjLZjfpY9lENY25sDWf62IbweRA8D/dq8MNpEGMvhfobUCT1/0ep9HZpuxhblJlnEsH3XEWwO40umbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU9xc0lZSVF3czR3SWdXR09PODdoV3ZsRWsrQlBLZkVHYThMY0o0UFhEelRr?=
 =?utf-8?B?Y1I4VkVUSzV0ekh1c2dyRWtRdzc2TEU3dURKY0svWEdHQWoybWlEWGo4L0do?=
 =?utf-8?B?Rjh6dmhIczVkVlh1bXg0SFJJQXovQi9MZXMvR2s2V0NodGZQN0ZaaTJudDN2?=
 =?utf-8?B?TEJuWGcxcm92YVBmaEVjZm5UY2pPVFZ5eC9mczJFR2dobHN5NW5yUm9iYmVZ?=
 =?utf-8?B?d2xSSksrdWV2a3I4RW1hV2hJY2crRnh0NFVjWkRUWjJldmpaVTU5R1JZQzhS?=
 =?utf-8?B?YlNRSG1sSGQ1R0FWZjhJQlpwZDVVSUJLMFRDVVEyNnhGQ005UXYybkRqQzNL?=
 =?utf-8?B?amhEMWZUMno2WWZiNWFoeEtsZ25yWDdzVFp0VHJPSi9qL3Z1REhvT0p5K1FY?=
 =?utf-8?B?cDJYb1NUeDZLdnU0QzNXeWFraUhHczlGYjAxdzYwYTFPZW56ZVhTbjlDdzcx?=
 =?utf-8?B?UVoyVDFMMndnaitBdGRRbytKR2dtbi82TUhLcERYdzZuZ3ZCckJxWjBCTGhu?=
 =?utf-8?B?S3Iva2w5SVdPMk1HNDBEekw2R1F6b2x0S2FkdThYRVUzU1FrOFdvSXloZTdM?=
 =?utf-8?B?SGVzbXJFc2xmR2VMSnRBaWhvT1dJdEhHV1dCSDB5blBwcWdxUDg3RGZaNkV3?=
 =?utf-8?B?bk1FVnFKT3RtbEFXUXo4U25rb09Oc1hYZHdCVDE5Tkg3QUpEYnQrZytpc0cv?=
 =?utf-8?B?RjNsWHoyTTRoQ0RQb3NuUmlrdlFJVDdybU5KL1Y0U3pTazBUdkd0Sit0K3Fm?=
 =?utf-8?B?aGhoQWpnT296UjlaVzRNSExkd1ArbnhZUzBXMmYyZGVBWEJsdHhwYzVMa0Zh?=
 =?utf-8?B?YWhsMlZqNmxXaFZQOHdLcjdxdVNsaUR5VzU3VDZwbCtJelBiRlEzcTA2Yktk?=
 =?utf-8?B?VDJsK2s3cVBoTWVSSTB4Z0JDdlVoeFRKcktRN3pJeExZR1JwRklPcUs4aFhP?=
 =?utf-8?B?bjRnZExtTUpGS3ZRckllQ3dWTXZpeDRpYmloSjlveU51V0txRnR5TUIwRjBO?=
 =?utf-8?B?TUViRUk1b2ZJVGtaYW1oM2x2b2puVlhYQWhEVVBMTlhESlpkQ0JHNDcwc2RV?=
 =?utf-8?B?aTJNNTZkdEg1dVFSanJ6RzRiM21na29KbSsrMElraDFqUzJ5Z2U2T3kwNUdu?=
 =?utf-8?B?M1JmTnVOUksweDRIUWlDRDVqYTFsZFYrWVkxWEVoUjlkODczYmtEUUlXZklV?=
 =?utf-8?B?Uk9NMFlZZ3NCRzgrM3BTRHVHL0pmMjluZE93Y2xwcTcwSnRqMXRHUVdhUC9M?=
 =?utf-8?B?NWc2TmdaUjJXY1pLS3VHRGRkMTdXRE9DaURUcGlCNGFPa3BTa2NxaFE5T2E1?=
 =?utf-8?B?T3FXK3ZjRjQrZ1JPMGVVT0NjME10LzVGcFRNeE1udmpiTEhwL0NVVTdPSURG?=
 =?utf-8?B?cVlQVUJERkd1ZnhXME9CNWlZVk00Z0VXWjF6Z0FzZ0Z0RUpMZkRWZjV4Tkps?=
 =?utf-8?B?c3V2OUl1aFhaekwrRExTYjVnZ0FDWko0NDVmRHQ4UU1nNVRQWmhXSy8ra0pF?=
 =?utf-8?B?NThtcU5qVTBzdVZBS1hGNXMwdDBqOXdKRktBeXdKM2lMNHZvSEJacTdYOXZr?=
 =?utf-8?B?U2tnTDRNbW1CTmJ6cHU4K2ZhVWplUzlQeDRGR0lpb0lXWDI3N3cvKzdnWnBX?=
 =?utf-8?B?d0RZamNSM1pLUzNBUkF2WW5QSzZpU1BEUmcrM2dQRTQ0SXJmUzFRRmpmYXQ2?=
 =?utf-8?B?dUszaFRRbFBBU29XTCtHcytrdG1Bb2dBNmhYVUIyNHY2ekx0VGdURThENUht?=
 =?utf-8?B?Q0ZmeHBPcURaQ3lsbjFOU01BS0NlMENaWkdDMXYxZlNXbGU4MUlhS3dhaVJh?=
 =?utf-8?B?RHNDUDdtZzNaQUhBS3JiNGhUNkhrZ3FvbFVsL1JKZGIxSzN5clA3L3E5aThL?=
 =?utf-8?B?Zjk5V2I1OUZ6bUY1VkF6Y2Z6b1cyUVdxODlBaXMwSzJjVEg1ZmNQT2V3eFAy?=
 =?utf-8?B?ZnJhOXFUK3NJVW45ZFhuUndSWFJKUks1RU44Y1FuUDYrQ0h5TzdPQjBBNDY1?=
 =?utf-8?B?blBoV25vY0tDMHZVYXZLQ0krd1RDSzRsQUFUS2ZNY2lTR1U2b3U0VWhwNkdQ?=
 =?utf-8?B?YTNhL1U5eElaeVFDY0VNVmh1OElBZVhpRi9MSTdjNlFwYkpLd0phNCt4U2FC?=
 =?utf-8?Q?JwtOkKjNvRga6x7MI6RPSJpfd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043733e1-ee1c-4128-710b-08dc3d2a6b19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:39:17.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6ZsUNSATpLmx/B0O13ETduTxbeOB4gMLxnLCbAKizIRc18tyPoag77inFl6EO/SLtG0CcLkkU5/wj6TeRGPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

On Mon, Mar 04, 2024 at 08:12:09AM -0300, Fabio Estevam wrote:
> On Mon, Mar 4, 2024 at 1:33 AM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > From: Robin Gong <yibin.gong@nxp.com>
> >
> > New sdma script support i2c. So add I2C dma support.
> 
> What is the SDMA firmware version that corresponds to this "new SDMA script"?

sdma-6q: v3.5
sdma-7d: v4.5

> 
> In which SoC has this been tested?
> 

imx8mp and imx6ull.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

