Return-Path: <dmaengine+bounces-3293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E999325B
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 18:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA87C1C22B1D
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CE1D959B;
	Mon,  7 Oct 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eVFAOOvk"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2411D9323;
	Mon,  7 Oct 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316898; cv=fail; b=rqOhqOTh+zHhqJ0fe6fnZ1RbUZ+cYT7+AM8zLmUdFo1PYhoQtVRAXELcIRnKl3HbGtxyV8/+2D4/+3QstTJ4fpeWviqPo2KwONVkmGkArQif217xIN0s6pFov3H5EKRlrPPsX+pKKO8tOv6xK+GSh0DVDZ0jFDshA3g+7rFRJ24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316898; c=relaxed/simple;
	bh=g/DEDOUfBtRrh9lopOhj9LdeFdWj/X5d0SYwAbXuHGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DlOkPSnx35mgwuq409T53nTABWNa/Z2QvzfcJtwPZ9qHzXYuburr1i+cmjVJLTBDroCgdHSV3D9ajeQ7j6+G3F9oGNtPvvSxV+Bm8Kwrh975Vhuk9m75nh2Q6d1Nxmj1iYdj78Cl+i+8dCF9MuKTFLySgIO95UVMzCQ0L7NEbE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eVFAOOvk; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChzM6fuiTkAuGVTi5NmBDaDrT8+jz+I62Zjor3jhr7bt/Lv3WyKbEiB76ETg1opzmNjRTyMVrITFClQ64us2voo211aKwcEo+RrgR1GE+g+b1b9fnwZJnb5GzHyvqcW4lRnxN3YxxWU3I7wLm63P/q34o6J2m5kHVdR7svpDUuzVvUPvfiRYp5XwZgGz6LPMX8IpNZ2AtSj76mNw6LrkOZalhL1R22H1E2skKZ0vtfxtTL7+UDMvQ1nC+b3TpR+B5ENBJchw8rseoFGjamV6divhkAWO0Y9eCxVgbDuTh6hOVDWnmlBqoEkpKlo+SanITsAlqZnN4dhfHSMDEgjNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95/0/jnE+8xJ2bJxIceRk+e6IJK5DelcdmEqqR6jxWU=;
 b=yoeT7qLIWhsXf4Z4uN5tmIjIuNYgTlu1H/vL3wX3BAFAy14OlvfBjNVwCUoWrrdOlMqzicoRinLJgM4WuWDh8Rgl3TOKFVEj5mKeXUPXuLMDvizJg7DPXC2LBSYd/Nf8BE6mx+qS4l6ryubu2hWRNTsobLtUBDOmp/KgQl+7q3X8DNaNcbBwTzn7UuO2RdCaTE+fyr1cjyCI2QvmsE8fGvFLRQv24Z4S6P5LjyxavX8xmkEIRta1/2VtA5gJde4kdZd2kBOuLaAEn7T1GMSjWC1deztOBXRrY+M4TqUsq3oYT4xu2aMG71YZfjjL7hMykDFvjoXcOM5MY+vHvDhQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95/0/jnE+8xJ2bJxIceRk+e6IJK5DelcdmEqqR6jxWU=;
 b=eVFAOOvkFYBvaDcbjciq/sm1XB+jhU5E1zlBHVCV3ekbJPAHDx3x36XHe+vWs0hoLVYOPdUrtSNBut3Ojw/ILz5uBiEqMRxNA4kqTkHo8WhKYkX5383HDd7Sn32kNwdMVHZSXjN4pqL9MlNAUm4F1vuMUt63x9fBZQq0GrNsMwJ4ZApZxqvBMfuZJKyhO3O0904mBkZ0ZypCPYPzGWzgvDfYlLqjQktpLN2O1b7JMKkq1tYquoT4ssP9gW9UqzNFIyQTW3Qub9rKyzLI1GU35GNQyLYER8nqDKdF0pDuUsPjapwl9TpApDEhqBHAsjEpSoCtrAl/7Rv5MhZEeJ0j/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Mon, 7 Oct
 2024 16:01:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 16:01:30 +0000
Date: Mon, 7 Oct 2024 12:01:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 2/4] dmaengine: Use dma_request_channel() instead of
 __dma_request_channel()
Message-ID: <ZwQF0skPo0zJ7Uzd@lizhi-Precision-Tower-5810>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
 <20241007150852.2183722-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007150852.2183722-3-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9774fe-68d0-4136-a32d-08dce6e94e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y1Z/PvbJ8NZjnyDclF3NA4H6E6bZZgyT2o2GY6QQkBl24lPE6f3BWn/E2Xuv?=
 =?us-ascii?Q?N3x9NFzk9MmDygzgwIY2q+4/XjqkwumELU3YC0cjBhXYAQRvOJ1KMEalpf7e?=
 =?us-ascii?Q?caX5CwCl/21kSC83P3kGmm8tIji/eYhoNI47xge4PX7KRpLg9kIZdahi3yhy?=
 =?us-ascii?Q?obweQ6KLU/KlCXjCoS0lLlRFVM2/DrahMl9u4/g5LLLr/LXO+N1tWycpeLkm?=
 =?us-ascii?Q?AkMYhsOPOCySYvCjCu3s57s4bAL7D3OEq+25doAaJHpwvV8d+tqvzZhCBGbI?=
 =?us-ascii?Q?9+zHrcr9VDEobYflVQ4gTWhGJWwCimALE7gwFHvPKnkMIEcytTU/l0gVaFX+?=
 =?us-ascii?Q?Ah1Ier+KKB6MFzcxk2uHZV+l1z6owoj2sGzQekI0MipTbYHyV0Q07fPt89Lp?=
 =?us-ascii?Q?+Qy5xY/smd/FhJ2MW7TwySWvy9ua2DlJ6gwLBPni6BaBOOWd60QDAl8W/9xg?=
 =?us-ascii?Q?xT7Iy+RXI2zqeMvvhV8eOCm77ZBAanSIbFYaWJQysAIMRQ018iHyGQondy1n?=
 =?us-ascii?Q?YU2t8FcyZTukga6q3UoxU8iT9/WIuDu36ss/vhzwYmQRrk9G9Qe5AOuLP/o8?=
 =?us-ascii?Q?Tjl4i0FS1VPamUlaUUEqbF7pCR28ekMxOqAfOV4MhsP5punkJWxbvI8b3MYn?=
 =?us-ascii?Q?yQUZpklXW+/9Sgan7xD8+EjeW+J6PdXhuSxohIV9b5txwfCTertsACejVvH3?=
 =?us-ascii?Q?k+QtfBsccMadDVHGV1hKLAZ2mkwJYV+KPhZowbzayQNfX+OLwQIMIc8v7WdK?=
 =?us-ascii?Q?8uS37nfqgc+BAxPXcfzMIYLk7udAkV/ql4s0u0T6SGK7YHyfwganQtOneBy8?=
 =?us-ascii?Q?27dbcokA2CqaQhsZNtHFdWiZjVDkaBkoX1cYAPI7plp3criQsNJVXuytVJM7?=
 =?us-ascii?Q?1CLmhRLMDgw+vbLJEViI+zgaLdXOQSeiY2bhiDumfZ7b8yCfM34MXRvrBZBP?=
 =?us-ascii?Q?28c19JHqwDJPbllV0B4sO7X3+Hkt4TIj6MgkVA8P8KL+/5jN94SDiIPrXNqN?=
 =?us-ascii?Q?iy7+qBw69mlp7cIdNYZ7AzEWYW9xZCeIQUtYnnMSGtP7Uq/+ekdsrNFEbWTO?=
 =?us-ascii?Q?qX6JQAQ7Pz8I2IHS7MFQVRTX/QpqHLd1QHV34m7ScwdK0663HQiHDckRv9zC?=
 =?us-ascii?Q?hOrnIl7ESV6eb5Cudi6oZfEGyd4PRPU7c61gpI6GHfLJVt9SJc6Txz/USqsr?=
 =?us-ascii?Q?6VYFlcaZP3NS2gU8X2mFe3A4tM+rsEEEdwZZ2GHgKSdzB3tYVvAq0chiKhzh?=
 =?us-ascii?Q?nOHRyEU+U6lo4xUyBuo1lMqDGsKMSWjMt2OKuzzq0l11uCQ/Kbmq4ZQM06fL?=
 =?us-ascii?Q?UpTRgnuVtwZLhF/gkU0iGdAnnfRijo3OIP1Ka59Iuwx4sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1banZOOcu7ym1ToMsFW5Mi1GRmQ8nJZMZhbGQgWiqGT5DJqWH8vS+nM32HfT?=
 =?us-ascii?Q?j3XPfRc+brpAk9ccqvUwpX9568F+V+f/dyrGCIBZeN4jKjogpPP9J2ZMsdpa?=
 =?us-ascii?Q?iyGe0sabG1roTOvZPXPs4cSdLx+usvIPaT4Nk31K/M9Ar/dTViBXy7OynP2c?=
 =?us-ascii?Q?LIs1krkn8UpnCzv0+TXdMFJnNtBHeO4Nvs1a4SiUEnMic21E88kj582y9uY+?=
 =?us-ascii?Q?u+W4RbGqmHMQ4gXHC7ivBm1eApM7MVDQgT5GDrMjmGX1onSc+hla0Lp9iX9b?=
 =?us-ascii?Q?cCL7dYq7OaClPkg27NOtci7IUSj6nnXpET/gCyBjla+o+2E1yEfrv3ljOW33?=
 =?us-ascii?Q?xeKfwWPb7awlc5MrST5bW3mpLVETHVvqsR9wdYwq+aNCFixqiq+oC0TImdJ8?=
 =?us-ascii?Q?Jn6lXUt0bX7BuSmrqp5kykkenBHe9XlD3v0uMh/IF0J3wsNmqAmPYT40R1XV?=
 =?us-ascii?Q?zqOjX74Y66PsS0WKpR3rsyqjR7NisO6htSTgw91qQAQV1YPCQJxMhN5t4oQR?=
 =?us-ascii?Q?2QUkoHvNgqvvFp1tpa6fRjhjNPNMhd/IEnf0NAJkv9U5DxFm5EGl0xMYolmt?=
 =?us-ascii?Q?diJlWhndn0Wl1jIZyWg8EKURAmtP5pIZK/tyJiuDXm+q4xJmD0AmeHeOWmkn?=
 =?us-ascii?Q?lkZxWVsNeNlG833fuuwPMucFbKfDq1oQZdOy1CaN/8KxGtfQWcq6V2AYO4UT?=
 =?us-ascii?Q?qVjRARjkZcSdWr7nGvrcH5yZlRFG6Uupe8KKpnwUDwwIt0KB0V+G27DAGOgT?=
 =?us-ascii?Q?cIFTKXw4Mm30ejCVu1WbUVT/P7eBLZLxM+1RiRVX7zRk+igveJmoofANkhit?=
 =?us-ascii?Q?g6to1lovg+mXizwnmdmD8sIiZ63kWYNGFYWig7BQV6u0cj8aY3GHF2A4jkUC?=
 =?us-ascii?Q?FQl6rARP6TRq2xAwJOpmGFgceQEzsSyl26TMxo/a/VZC2IJ1YhjbhiyAMwxm?=
 =?us-ascii?Q?rR0Asu5YpuK9wQzZk9G4Um4RtiWYcmkP1tsU5JNs9pIt/FsoEN2EXNip9YoK?=
 =?us-ascii?Q?JAM7ZlSdhXn08wIT5idbZJEQSQMdtbYJwGdDZCtbYZa9AcYLvAQPhNLQepgr?=
 =?us-ascii?Q?cKopWWizrpk5tPhYZ3yY0pR//uy/1qwOG+FdBPlTYCz8jxQBw5q+5PF9d1Fl?=
 =?us-ascii?Q?R4NYzMuCTfCwnrXiR0Rd4dcC7HVBgV+6IeC0Q5F8WDOT/dqxKm+DyQ5FZ29B?=
 =?us-ascii?Q?Dj6A6CXAvYi7+88a3OsXF3oo8kGIrf6DIyprSYK3s6eJn9vseu0U6k73ZbO0?=
 =?us-ascii?Q?xOH+KMqfT/hE4DQHyEsrq6jOdbdXpm78ts6fEe2BbFDAWC5ObaSkzPtZQmpm?=
 =?us-ascii?Q?KF5i7HTTo5/1kAVtKeTELhtupb1gqjI42QYDD85/gKoaqPShENtF5d0StYCz?=
 =?us-ascii?Q?ABEljOwJKqCLi3sOgvnLG1TSVhvCy8OqqWXqQbUCJUbxHWeHgdB/Q4phT76w?=
 =?us-ascii?Q?rDVmTz7COu+aUSplb/zLTejhMO59jgIXNRUSy1a5mtcSF4nQ7XcD+fouYCaJ?=
 =?us-ascii?Q?9FgFwcVUJipRfJbfJaR7Zs34rOKCn1uj4yfVQUI2R059qYlC7ByII3it9IYj?=
 =?us-ascii?Q?Vyas12mhqW9g6JWuPojGG3oVtnV07hpm3bOK51pX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9774fe-68d0-4136-a32d-08dce6e94e9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:01:30.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXYdN6l5s2ZzSQwWUeTDRjMSDsQp8IelnNY32eWLepD1qQHuqJCWGff+/KJZmSLU5fvjSkrSpoZDVLDJv+Fw0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912

On Mon, Oct 07, 2024 at 06:06:46PM +0300, Andy Shevchenko wrote:
> Let's reduce the surface of the use of __dma_request_channel().
> Hopefully we can make it internall to the DMA drivers or kill for good
> completely.

Suggest:

Reduce use internal __dma_request_channel() function in public
dmaengine.h

I think this change is okay, but I hope the following patches, which make
__dma_request_channel() as internal only. otherwise, it looks not necessary.

Frank

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b4e6de892d34..2f46056096d6 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1639,7 +1639,7 @@ static inline struct dma_chan
>  	if (!fn || !fn_param)
>  		return NULL;
>
> -	return __dma_request_channel(&mask, fn, fn_param, NULL);
> +	return dma_request_channel(mask, fn, fn_param);
>  }
>
>  static inline char *
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

