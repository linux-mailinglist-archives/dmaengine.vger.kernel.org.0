Return-Path: <dmaengine+bounces-6847-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353A8BDA6F7
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926453B56B0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8EB19DF8D;
	Tue, 14 Oct 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kWxTE5Ti"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78AB770FE
	for <dmaengine@vger.kernel.org>; Tue, 14 Oct 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456254; cv=fail; b=kiE08bylKQ0m7reYsXCjePaSq2yWpDCb8fTxWxeEmQ74c2DTxu7LdiNUpUwQAvi9wgkROnV9/xAWEWSh1+rHekZorIuywOrSqiX5UXfsntJZjNkOVZJiqQNeUCx5jn0G+ySSfgIPHc1npnoja2ZeMahs3MBOaS4Pn/0YlGUNhlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456254; c=relaxed/simple;
	bh=53luX+PU8OswWMA3j2ZCjK9cwo3ITQaThSm0gmlUnZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caA/nRrimdxJl5kVxgEOzXlb4j/fBBM9jF1ObMuZIooL/8WqLdsaLA/Lc5WeOvW95A8uz7VS3766Qyho0ZuV3Dgp4SyxMxu3fTk2iFl+hCFosTPTF7U/Km4VADWhn4OQIZX+oGkcKbh8SeZy4703YCzOVc9XT5vGOamW++hMUNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kWxTE5Ti; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZVqa7iIEjoqhZuoV4MAIshC5mIUSmG/FOutnQASMU8vZGLI3oLIyktPjVhDQdbJjQjMHE6z9nHuR4f0FllGMscG6Hr8WvpqjSnv12ew77f7mWLb+rG4BETteS2k/NZBphwRhaVHiIxKuhJNumoYFYsgLJ1zmHCy5jZJIF4izaJRNuJCinCwNYch5TQJqwfn59qsp6k9zzhupOiL2/j3hpkpsHMSHg8S4WXFf5Pl8x75QNMkKqCHA6Oh4Ey4L3Ivvfd+xRsV2sTUaA++Bp0+2lCWgPBErcOHLEL5lnQeX3bPo9+4VCyHPW64Ex/wPkYUUL6lnkqRBJiwR4OUXGqngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7sVu1lFpH/5raLJMy+84SQBbwB+LEXhp5ADTJVDrPI=;
 b=sw0V3pZr1zTIvmGggSpjWmCgM9zmD7RvsiXaEmLB7QsUbnpZoL572D1mzQaZX9K8KpWu+j8ndIqQOtvgwDyv9n5lh2ORve+wDTXqUpbbOH3kA4iIPC2Dfm9aRs0xWUsvCB2hgSPVmYwgs9t7pzLTOyFpG2hTMFcAjRSx+KiWzaPFsyH5g8bCM8xfi8zeD30sIEVtXedLu101R71rX2KeoVdqAAzHpkfFYNwJ9ahlgkWh7yrw7gNvg/6PGP4UVh5JRFCgEbvNkrBXFzCjyrUsaH7cue0yMGRCt4SvcrrW1j59bI0CidzpjYtQcrg025TdowBMgh4wlFfnY9/DIzDCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7sVu1lFpH/5raLJMy+84SQBbwB+LEXhp5ADTJVDrPI=;
 b=kWxTE5TiWQ09vfdmVmTPUHRsks/jqQm+tjf/8yUilnre4zf0qKQaJ9AFc0S+e17r4DejASM3mBz7lqpr0llcN46C/KF4p/L3yvWfQt3thuCDVEiL+YQIk6pWQJzR9UE32OUkUsSZa3ahHpmVuWWElFbo8x5a0b62WwBgQxui04SRstzAp4d1rUUC1FDelo4wHzwu+cguxu1YnSHIa1w9xOd6kSctcMnnaQgoijERMTkWTvUWal8498fAhBexKuvIKIy+jyGHi8jK5xXAEIJc+ZyKHLuCCBkOC/Zn30byG+NUzOwSFBG1sREn8PdBTxAq1gDfhq1Iy/fW11tdl7x58w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:37:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:37:29 +0000
Date: Tue, 14 Oct 2025 11:37:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: Remove redundant check in
 fsl_edma_free_chan_resources()
Message-ID: <aO5uM4g09zQ6kBni@lizhi-Precision-Tower-5810>
References: <20251014024730.751237-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014024730.751237-1-zhen.ni@easystack.cn>
X-ClientProxiedBy: PH7P220CA0099.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::23) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d89c30-bf9e-401b-8107-08de0b37956e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+udv0cTc7RlMU7Yxlgjt1FLaeZaSzsWbvwo/lI2/xzwx/m8ibLIsOogtaJz?=
 =?us-ascii?Q?bco8xfp5BGut23vgZC915zVCyyyQzgpvUGAPss3HFuRl54m6GOFLrRkxf47P?=
 =?us-ascii?Q?MNIKBk1QyC65G1LrtR7F4FdQjvFxyWbJBXdF3aaRQYkZ+HgXAmoCbxspJdx0?=
 =?us-ascii?Q?LisPPaJOFuMACxPBJKBJWOiVt3gjmNHd68d5mFifqlqlYA8ss4orcuSGmwwl?=
 =?us-ascii?Q?8H8d8YB33l8XaRwT+FkTOH8Q/tBBEpCIWKDKgwbDxa4vPSWPCIqL/5pbjrbi?=
 =?us-ascii?Q?nTlWliRerOBB31K+p+RlxyVEYsdxAhS2ClXyQzlVtKbqGAqK7JjCJheYXkgp?=
 =?us-ascii?Q?XDgRjiMEvKhL4jwbbl2NobcEOB9x2Vv8O5gjUDioVRoHQVscMkd+PBkwVd5H?=
 =?us-ascii?Q?+LQXLRzAVpnsh5mmRCV3hXWq4T8IWL5E0k3zISNdd2ypum89h9mLKFgSqiYP?=
 =?us-ascii?Q?kSFx3X6q1BJd12XpnWSkPg02ncjh/eqRVAlhlr8lRPNQrG1oKPUz7Shnk3A/?=
 =?us-ascii?Q?uO/rVlaMVWuHsAIby1cJpqOdb54NlEG6DkpZSXmXjlm0LgnMGmpxabtB5jxB?=
 =?us-ascii?Q?Ws2BPjqTH4/TjmvWXqH1lpSVKFoYIk7r711dPe6BNXt704me1zi4Xi9QJlt/?=
 =?us-ascii?Q?Rbjw/QMb5jbj4q+RM7knV66ypD9286cK9ymlhWxyAp6yb9BGRMUk8em0qaiD?=
 =?us-ascii?Q?fCLGEhjuKA9Wt2RFFJKK9HGaFIBOU8/A3CSCAFsvuxjzwEbUC1Ykt4PzPUQs?=
 =?us-ascii?Q?/MCmQjKgrJTVlXP3pDZ2D5cT2M68Je+RUv4RHW5zuBwia+MWoLOXgHT4QAFv?=
 =?us-ascii?Q?yL+v9TWMBsILNMswGEPUIzI1HgBsosD0rZg0DSmVPA6C8EPmcbnjOQ/p3Mja?=
 =?us-ascii?Q?mL/nOUN24Wqkv7TTh9X25WKA5moRHdnOO5k+BhvYPmK828dAnjpV8JdJ4bs7?=
 =?us-ascii?Q?R5W3/uHM/Ho/79SHOTXjHqc4NWpi9sSOAWR8HTyIxYatEtLVjrhJOi2zcDRO?=
 =?us-ascii?Q?VwjJv73zhJ9pRwDKFO9rC3v19yL6x2TFkFNZtKuprwOX6qZKObBQukbNxZam?=
 =?us-ascii?Q?0OCnlFqw8VtjD8j0+Yt7AuoXA1LSvMdi07tfNcuw59skcAlHx2V3jEpT7WHL?=
 =?us-ascii?Q?zQ3YRUl4dShcj/mSTogyrB3EO8BmDeW+V+bXpiu0uSKVwkQdA9fYf+2I/AuF?=
 =?us-ascii?Q?PeS3hchoRNO9Nz5gVyuuCJkr3/fL1cBjR5gDdH/GQcXIAqHMObLwMgxVquRd?=
 =?us-ascii?Q?C1j1iHEDz1Hp2L5vALwo3MiJYitTtlkN5t0+R3qDgnxal9O6c7W6+x9irVtI?=
 =?us-ascii?Q?AtqF3v8jl9lBIHXc/QOPjLRAJspt5sjS9hHFQAJ0HZhveNOWKn0sjrh7MW47?=
 =?us-ascii?Q?yKiTpjAB7tp1BcKJ0vSI+n+Oaoi55HubjRJlR5r4AlhNnf6tMbFwnbI3LcTW?=
 =?us-ascii?Q?2IbpY1SKXlgghHOXnPz8+OoF6I/v2O2vCn+Vz2i/1omDRHjbNpFfjrymMJbk?=
 =?us-ascii?Q?7HO7g9F0dKtNi6EXRRP8MCRUQmyskiSYMJEa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfwfW7EzcDkpxzWCtUwF2ND2ygoSKC7QJ78M5+BBB/TkkrVm5xVGqkBrfgUY?=
 =?us-ascii?Q?+6K1NtZhZFwU9eQqxDVsX/JMxu4W26hvcx3OoAkUB5B+ruJV/Aw6jUwxaSbt?=
 =?us-ascii?Q?/3Kt4E8WfjtBoCXTHaUZRWK7/Dia9Sfd0ThzDjsinQwEhgmjpyz42/Ggad7g?=
 =?us-ascii?Q?yLdj3y8bwkeYaiIlEtehBwQ86BISlZDOzTwBqctjeCtU14qP9NiJ81KmWq8p?=
 =?us-ascii?Q?FIbA5hMM7tQ6Q+hoHzU6Rtuj/Q3F3X2cwxf3qPbn+9yEBz3rsfmaMxTASdKF?=
 =?us-ascii?Q?ibUnwgBukNWLw35074b7eabfl/tS9twpkYn9FwSc4pCHTr0D7reag/T2kdR3?=
 =?us-ascii?Q?jFiA52VL0dRAyGPVJ4Uev04I6SuLL1QgS2I/Jq1WJk27MCcXdUwCSvPelodw?=
 =?us-ascii?Q?UhUXRbvVSV6kas8zi5ira+PwrxO4nBP9sCxNAOTm+LVJ6PXTWUN6wJVj7E71?=
 =?us-ascii?Q?T4qgQuDoTyp3dwf1PxpK4nB1X+aYywO/0fVz2Nm0kDY5FG/xeiYK+E+ND7Cr?=
 =?us-ascii?Q?1PCJ16A306rdRDrAi8Cxn/Ng5GmgVsTzrtIfNokwWbNGBJCkW4gdZQX/h367?=
 =?us-ascii?Q?Q+Us0k4TsAItWp0t+FaFJgAfQ7YL7gdRNYPsoNiyM0X1qoTz3fcoW2XE5OKt?=
 =?us-ascii?Q?X+3cUTr8aUS/siJgJaEWlQpamKwcFjBrnKFO3UEv84ke0I984ebrTkj/ZmeY?=
 =?us-ascii?Q?d0ufgdhGn49Z0n8AcqjonAqnyxKnT66YeuxuI49GJ8m33gH/EVwQo15o20qk?=
 =?us-ascii?Q?VCgT6QY2fL/PBS1AZsgk/j9VSlOc53rGePAUPEepqX9uY7lmZHk5O5eSVZAA?=
 =?us-ascii?Q?w6ut7KHZSP42M1F8A4PTP+A0Z8DVN4Yt1kpLxaUI/jqs9z9rR1mpj+hDvxuN?=
 =?us-ascii?Q?6OrElasJryh2m5FEPSGIKOSlSfsv7Stx+bT//w75pmjrIADqkcU+yEMbxn0H?=
 =?us-ascii?Q?CDq9LLMmtNi0ElSs4J+6Le4U6nxCvavgxOMLwa9MWstC7H7dlt+5sCQw9meR?=
 =?us-ascii?Q?0lPQblnwvkBMSJaXOa5tZPchQ8AFvsuWi1L6Y7e0v3UhF7zpL30AZ3lvibLc?=
 =?us-ascii?Q?qTy4hQA4hKjqQVyrw/vE601FuG6wypGmqZcKqwwhDbMR57qTtWXNPy8j28kt?=
 =?us-ascii?Q?jZWAoM/5ZsiAE+s9gMVWR8IcOhqzvvEs92odLcLvaLz2dUWXozgQm42fY/jE?=
 =?us-ascii?Q?krTrJZAPj+Hv75hrhhRLmeT9t8jLCbUlhPdoRyg96clLT32dhHCMtczvA9jL?=
 =?us-ascii?Q?b9H1hejk0mfEKlUtnROZpo+2CkiJITyDC4ccBvLB0/lDmfpbZr5q6SMqkx7G?=
 =?us-ascii?Q?v0FK8dJqz+h6VKX5m/OGWICO6rMAI7v/ZpRzp+f6uHAAY4a08/SEj/UmY+gm?=
 =?us-ascii?Q?OjVbkqaRRtdoeEaYo3C5M7hkqiSB1J/jR95cglxkettb3nSQ8miiN+bCaF0G?=
 =?us-ascii?Q?vTOilOBKnfk3EWOcxHDFxocvZStLJunNnGD4QiUwMc6obdPvDbkVwGpGrFtT?=
 =?us-ascii?Q?cz7KY8A7Zk9eHlBPcfAW15/iLbT+7XClXhM4Ja22wngHc7xHaI2J9R2NCvu6?=
 =?us-ascii?Q?RKufUtC5M89C2I1aYTp/2Bd4dxDpF9Dav1pa0kov?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d89c30-bf9e-401b-8107-08de0b37956e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:37:29.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUz3Yog7RdGDhtL0C27D2WJHTa4ig7Mao6WKSCIfaPNuEoCB4hzMjQtGS6pXYJEcvs7oNF3YiBIWz4Rz18UYIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

On Tue, Oct 14, 2025 at 10:47:30AM +0800, Zhen Ni wrote:
> clk_disable_unprepare() is safe to call with a NULL clk, the
> FSL_EDMA_DRV_HAS_CHCLK check is reduntante. Clean up redundant checks.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-edma-common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 11655dcc4d6c..3007d5b7db55 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -884,8 +884,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_chan->is_sw = false;
>  	fsl_chan->srcid = 0;
>  	fsl_chan->is_remote = false;
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> -		clk_disable_unprepare(fsl_chan->clk);
> +	clk_disable_unprepare(fsl_chan->clk);
>  }
>
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
> --
> 2.20.1
>

