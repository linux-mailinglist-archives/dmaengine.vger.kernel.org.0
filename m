Return-Path: <dmaengine+bounces-2042-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820948C78A1
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D638E28114E
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B514B952;
	Thu, 16 May 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jQ0XyfoG"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674226ACA;
	Thu, 16 May 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871001; cv=fail; b=AFKB1nVPQ0/BoozOb4rglMyXjPiD0SIzNeo0WD1dpM0uDcx/vU5iK0puU7a5IHDbnzKnEmS/eVQzCJLqCDMe9f3ut+2D88LFHKRpf8gGQJhLGevPdW+lkzdZi/usIQq4MMeo/CvhISOusV4GbE2258fvwsPQcDB5MrIAmBQU3Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871001; c=relaxed/simple;
	bh=YqjAuz8RrkJQ+li0gvY3P2ZJGRGB/ZyRVbavT75YWa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEfMzq4Nf1tp+cWS/EWBl6JGbLN0RrNBWgdNM2ODql5UIDuZFcT+SbvtxIvkw0Z1jg7sgms/uDuS8V5MKG3SMmV11wKkZhtBLpWLbG8ohvWKNZF16AC71lKjnWrmJ2K+wN+wMuUssJvqhprXlqnUrpwTtX6u/5XR0NmJa0eDa+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jQ0XyfoG; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXrhOB7t2Q47MOJZnUuTOZYfCDiJt0Xi0oPX/05elVZ9a+tbb5eiW86Fr+RXYMkXUtdBOVKBjvQ5BsthorFy9XOrAfqOkaKfdeJ3To2vpeDRC9HoyvDDVVQnkZJ6JQ5WQGXzh9JvZpdRqwWfedmymsG1cFySSJQ6p0ttTBXt0S5/MT1AbPXf0jW0GboIF/usXzsPWS2+BTNUKnqpcJ1A3ZbBg9jGOgPiUkPDFvScFC+oHdvhMD947DDRCitdjpPURJpplm9GxZzedwWH2OBJVHkX8lyyrHXXXqhpgXcKkKGELPHW9/QnllXJCvW8ZM9KFPIb+cfG965zGds1ku02Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV6MxNuXppvqWoIgQENXPPFl7kFIY0ubjCUz8U9zO4Y=;
 b=RMymznsT7R1sRCVXeqXP6oXGHbcdvea3rO9yROqHiXVUdtWWkA1ZGBbmSvZXWI3Se7PjEMycveBgxUWaDFE+BhIiGe+8JtQ8EsDAnReXVB6hbYB4U0Wvqk2iAUl91runb8bltx+05PsvWg6wfDtyG6R9e+rj/igcVe8bu3Uho9jtW1BLcgXg+GRxEu7V5ILjP6kKkc9zQK+ExI0npxDEmYygEMbFta2DAPaEZu+7RRXMYKuXgYsieSzSeNQmc573QKkD64g2hnOZRzHizuCPANMOSHsvtIoL6SMPePqTmc8GDEcQFdhxYyB0ZKzzR2RrPwB7urdbZP+Z3r0ywZhtTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV6MxNuXppvqWoIgQENXPPFl7kFIY0ubjCUz8U9zO4Y=;
 b=jQ0XyfoGVOfio1WP4KvtbSqiw8Uxrr6NZrJL9cfNFSljqHwmj6cfI2FWX+xow1kTYsKdWgkbhPGSrf+7pcPuuFiiQJ6nZmV3gtJMsqPPYRWwP61CqDX6rLRxr7lQRyCNrP4TvqV73Nf+464sJJ/hzAmrpLPtdUIdaD/kcP6apYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB7862.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 14:49:57 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 14:49:57 +0000
Date: Thu, 16 May 2024 10:49:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: linux@treblig.org
Cc: vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: remove unused struct 'gpi_desc'
Message-ID: <ZkYdDtoPMnYlGT/6@lizhi-Precision-Tower-5810>
References: <20240516133211.251205-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516133211.251205-1-linux@treblig.org>
X-ClientProxiedBy: BYAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::28) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: ca973929-c362-407c-9a29-08dc75b77485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V0cNWVWufCfIm1GexFLcRe7qcNbmrXzCUlmNnCJ20nrDDjJENAZ59UiVqQiU?=
 =?us-ascii?Q?dbK0aAUrhKj8Zuc65EKYkFvyYLULQ7y0itpTxTP+rYRJO2ppnz+XI106hOA0?=
 =?us-ascii?Q?Rv79CbRtDrek6GUV1tHOq7fiv9xdBQB50I67aaB4Ewbqr68IMxW1QhMGpP5z?=
 =?us-ascii?Q?JWbRFSypwTDK5cqqAbJu3rihdkZcF7R5pGo/uNNIKgupNDIMxkjyNQKbvxl6?=
 =?us-ascii?Q?vv08u7EaPfOPlPkj6T6yJqgVI3Lo2hNhW4S22TBrfOmTOsBvxNMbgF1N17+v?=
 =?us-ascii?Q?1VG9s1ooVmhtck19sRpgIX+QwPXauWtfbTRAZML9kamNqtOJ1Ij5BR8+oDpI?=
 =?us-ascii?Q?z8VmXtgCZO6gT57/p3W3zMIiIPKNdX7S3eTOOZ0qrX2BP7nTR4hj4R0DzX9G?=
 =?us-ascii?Q?hZxciahjOsgew49tlPT71oxNk2bpLisoj8zQ1ORkpUEcNJgS/7hM3vjRDu19?=
 =?us-ascii?Q?QmgfCtSaUFhGEHRXm9fUNRFuHL4tt9cKX2iPa3xrTtGFD7PyB1cOqCY3Razz?=
 =?us-ascii?Q?37U4jvbvMLvc+FnpwJs4dCUqfxOLOH+2i79tnGvrMZpoH273fnDkylXrWqaR?=
 =?us-ascii?Q?qJRH9mPkfvHwdGImOYrsIiEw8Awe57ukZPQe4d6sR/V0xCCZzb2N6YSZTvar?=
 =?us-ascii?Q?AKrx3FTyJD2C04tyahWysm6jggbrcZDvX7YS8pAWSPeBfBx4JikJiHd4Ah0c?=
 =?us-ascii?Q?oR/cJEGUl/gwLkZg/L2noc8VJB6i/0tPTNn6WZlvAC/faGzAB0fIald+AQZB?=
 =?us-ascii?Q?GZ8OEEWBw5XANfnmctwI+wdCnYhGjCVbTglOA+zh7mx0j1o1VrfQu+6J4EAj?=
 =?us-ascii?Q?A41lU6ifk/gd/V3qKvYzcL4debpRw3ozajH7o9bbgOjCZ9yNaa3S/LNnAHgC?=
 =?us-ascii?Q?0tRVAP9N03sWlCbNqkMHWIRGRMKaFVTcGy1QajFi1mtckJJpIdJgVYNxKhyY?=
 =?us-ascii?Q?BDuT5KBfIluG2VRokypLEnL6mnFu1ae+Sfupil+0VU6N3b6IE2eiSR8YsWLC?=
 =?us-ascii?Q?pKO/p0qh3C0/V0/cibv3zDg21Y1YlIyMe/8yGgv93pyXRsdtH8JJ5zXWhVQB?=
 =?us-ascii?Q?wA6Rx4wxXBPKkD5t7H67HYhzZ9KCNjC+Hc/Vbz3hpA6WxmoTLpoO5xiGTkYD?=
 =?us-ascii?Q?T+MzFhBKTCjQ/ZMFHoxTLYYgyt2RILzChVGTDlTOPZ6liX+dVINnjz0hUYSi?=
 =?us-ascii?Q?y+ty+ceFc/XReNgC8vhd3p72W79/wuLA4Xa4o7VFAsaQU9R1qpiM7rNhQEah?=
 =?us-ascii?Q?8E+aIn44Koet/uZg/uNmtNZ2nU5KITqQVS39xB+u1inv6TpDKZkhjb2qNMu2?=
 =?us-ascii?Q?9cCPBR94uiVedj7/FAUnEG10d/s0UTShJ7or3LdqGJJJcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zgoDohbwwe6ktFdmMVpe6YM5SB+R0ohHcmjjSymsVbZ+1aNDvHFuU/VddONx?=
 =?us-ascii?Q?9dOiwEsXU6I1dChgnQ2u96/LwsTm+rYYYpCcVJySu2HEatcSdjVpAX/q3jFI?=
 =?us-ascii?Q?qUZdOFdagaG6lPx1kbYVTqeD+To7I0rTvvagf+3b5edbcN6d/bYu66iKTF8S?=
 =?us-ascii?Q?USg/1ETODAG6sQywN81IfnNdNcLsq2h+Zvea234aIdZ4wUV/AaaJNNcYIPHA?=
 =?us-ascii?Q?8kPz8OCk0F1SYMjDfCmbTPzE5QmjOWl/dnkCz0cYUCM7Od6phVXBEaemWKf/?=
 =?us-ascii?Q?r+DVJ84iDH54hJPD6yb5408eNlzWG2FDTU7x9/QLKpuGOlsuVrdaMgBUOd8z?=
 =?us-ascii?Q?GX0H9KuK3y15YzFCIA3f2uA8HdJoozg9zi3uY/S6TDA5HY1tJuFAEGBHk6n0?=
 =?us-ascii?Q?ctPngKlpRFk2fZUPR+qxV90LrSqpuWUYdpjEmlEcDz3IzUSyQ8C8JOsc0gFJ?=
 =?us-ascii?Q?Ky8hKNKoCvRqArq2xKEG49OP44YZ2/PkTHCHosv/MhlYkD/rOnDHiGwlia/r?=
 =?us-ascii?Q?TS/sPJsSln0WR/5vVjf/QQnzAYdiBtV5udkq2zzaziF5XGduIx07+TbcydAZ?=
 =?us-ascii?Q?aticbuxyKuNiJbYr1p9lC4IL3BVfJpEG+mutHPOoa0u/YrVmu5dkzdtMFC7N?=
 =?us-ascii?Q?kXw6aX9rCixyg381KwTAQK56/WXLzniMApAqn5uXz+e4qRS+N8kBcZzK5Qc6?=
 =?us-ascii?Q?S4YAOVyMsHHg5VSazfBsenSQxpAGSlsjaN+k872RVEXw6B2RrZF3FN4MVLvC?=
 =?us-ascii?Q?Y2cVhZcajuRKRWqvYQjrokzj5YrCX3a5UUWDKF+JWoNGt58v8rdcMtueQ1fd?=
 =?us-ascii?Q?n1PQPZ6U/ngb4ifYcjGMUtW2Y3biA/2MRjGZV0wMhk82nWmHaSIONMpWO7bS?=
 =?us-ascii?Q?FhmtJ9k+sxmJ5ZExd1u9A3PrXK8i3vdL4SNAom2KUQW7xvwmXDYhmXZku1W1?=
 =?us-ascii?Q?1aUn49OgbieH6XqExnBF+8Zf40TyMO+A8vvAE0VZbImb5n8TcKHTzH9L7Bmk?=
 =?us-ascii?Q?hqWRrPDq/hdL2hokKDnsQi4MXDCFCU4ZP5s0eS59eqhXdKfoMe1d3V7k3zNW?=
 =?us-ascii?Q?7czZSgiwnCby/II+8v1+L0EXihIBWqHcweSqW2d9s2R+jcAnibSOrbD5xmP2?=
 =?us-ascii?Q?UugoIMfLH+4PJp9APJHPpVkJgk7es0L7wXFxCv5wCYalP44c7L+zDGkMaD6r?=
 =?us-ascii?Q?XB9RcC7qPbz0X1c/1U48j1/AmhBnM6HfkopTQ5Bl3kYk903TG+BY2Rc0+Vta?=
 =?us-ascii?Q?XZ1XB14IXcUEV4zhoxcCYbf4sPMle/pR9AkjrkMYBohD99lYomm7kJzhh/ib?=
 =?us-ascii?Q?tSCv20A1tGvrAW4S+pINqy5Y6gMbWmwmwgG969yYjNyaUkmotm9MKHecJteq?=
 =?us-ascii?Q?VxkLdskWc06i/TSw/Kbkaxe5p4c+K8eFVWiiA7XBelEHzRZCcrZEAZFbUURE?=
 =?us-ascii?Q?dpqN0KeySAtffH4U+2wphjX8Q9ZCVJN6bv8hfXLKXgNrWQwteWzZM3d3g+4a?=
 =?us-ascii?Q?ltcY6xdgX/fjKhNMHt5rXsIctjq4hg7f39k2STyPXcAJrQH1KbZyp17GPXZD?=
 =?us-ascii?Q?bVND92yxyNVCxKNJPAwwzgFDscbagarAqy204Lrq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca973929-c362-407c-9a29-08dc75b77485
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 14:49:57.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdsWCBpqENSlclmBQbHMVMJ9qxNET2pvYiyazLSFDyMmhsiAM44n6dnv6UlmjHNKopo+iykQ+K3fBBsxEslRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7862

On Thu, May 16, 2024 at 02:32:11PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'gpi_desc' seems like it was never used.
> Remove it.

code change show 'reg_info', not 'gpi_desc'. You need make sure that it
really is not used, not "seems like".

'struct reg_info' is never used, so remove it.

> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/dma/qcom/gpi.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 1c93864e0e4d..639ab304db9b 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -476,12 +476,6 @@ struct gpi_dev {
>  	struct gpii *gpiis;
>  };
>  
> -struct reg_info {
> -	char *name;
> -	u32 offset;
> -	u32 val;
> -};
> -
>  struct gchan {
>  	struct virt_dma_chan vc;
>  	u32 chid;
> -- 
> 2.45.0
> 

