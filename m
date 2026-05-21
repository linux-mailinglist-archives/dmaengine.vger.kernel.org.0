Return-Path: <dmaengine+bounces-10695-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHFaAxc6D2otIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10695-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:00:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55C5A9C4D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5CE3062624
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1035F612;
	Thu, 21 May 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cb1YuhLz"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AEF28FFF6;
	Thu, 21 May 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379971; cv=fail; b=E4lcCVtvQnRTyzuFCYUy/5eETCRtATAZNFoKyyY6G6tZUpS53qPUjeBY8hFKBpH3tOCh+t6K+p6mczBDt3gT+eR2zWUbDtbnFD2mmSn4jPA1nqqC4VKIKRAKNT8/iTSCQ6ZURO1/mVSs/P77U6PZT8a+1FU+4uMjSFixtPK0o8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379971; c=relaxed/simple;
	bh=4IYiqPclHkFv5C5eZ+pS4Bb1StKD19mJzl9UbMx+zgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bDYZwOHQU8ITwqjqcihSoHDr1tW2Fbw3p32FnQR5qTt/U9OZE5riuXnlrC4vbtdFJZXxQdguUqrYI/mmmxiARDP1YV27RyulVhfPdsqWLHnXhqmrz1HoyIfjY/7GNKb56S0xrxuGT6KnenVxyiskNcKg73Uj3VpNMS6qsLVjPEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cb1YuhLz; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfHauGz9rgCh0xCBHIOqgicnmiZkBcTBMP1VRcjzji16JX5lcF0w1gydM3rlqXdEa2IwC1pZwjzA7/rxKLHS8/Es9BWQ+aSUm9OnvCR1kfOBnG0exC+EFygNkm5Kz4Hr/QlUIc5giA6af/+sEYs58XP06H9Px7Uq83UGHbNA3faHH60QwanGhyDO4uMwRA9BALJcBqZApq2eR+Lo/t25FPMGZJTuC0H/G8AA+guRZWkJVg3O8rabBVexX9uML7qEUilWdOnIW+n6CHWmTFxKLfuVQC75FgnmiIkxitJuH2jp1/hkQhN3qtv6P8XmOZ5sSn1cCh6/aB1LkcQ2HH4dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chY4knIpJqfO0kLsDGVKWC3G5gRwJGxUswRSSjO6IVA=;
 b=NvsDlzv4ciDJiSSD4is376HpnmUrpFoc64ALF9QbfFO4+uatoC32YVVUvQbsYKoRP9GhmPiFHDucrhNqqS1AxU+YRos7XdrMY4PgkIuyt2q4FZ2CwbUKSrN0peZ2Se/xo8Gri8y/50PPtxL/eNSFNSVZJbVowmy8aa7b3koESqW7cAxoWS+hR0h4ZsgJU89TVoW893y4/9upIDUlG66mrRRZMBv3KO/0gGTZCWVy1lx0v6Ck7nV6Z34d4KG8Ftg0lslUBSJdSbRAsjddSUkKk/wZGabLxIOKVqgWDcIMqP5uB/BiPyFyneJlGllIa3IBPeeLdE5E9qMCZXUX7rPyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chY4knIpJqfO0kLsDGVKWC3G5gRwJGxUswRSSjO6IVA=;
 b=cb1YuhLzmDEYrrrlqDB+I9DuDL7fAQohXVBLenjY62NHSwgGvsVjLUbPoGhV9IJU7Q9s0T6tBaQ2LUZWHQkdIItegTSTU+vGbntrzMtR1d4uiGtZJZNYIEVs5rzg0cdlOAZNcbYG2RueNRBseEC6lN4ef7sbcgZP8jEpb0sBVGxbHK3mlbDPUDVKdQGeQoEdNtlKPoYGkhFlKVlrcIym08X2KdwkD/cW44I12SNSJSuPAw9EO910IJMYdX/UDlHWREZ3AuhEA5oR64N31CwALPjHztVO0u7jns3JAhKdiCfioN7zdKRhlA/a/qGgpHDURkc6LLWm1W+E6yXnELJxXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:12:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:12:37 +0000
Date: Thu, 21 May 2026 12:12:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] dmaengine: dw-edma-pcie: Add default IRQ match data
Message-ID: <ag8u762OGN8bV1Vh@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-8-den@valinux.co.jp>
X-ClientProxiedBy: SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4759f848-73cb-43e7-4043-08deb753c643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|11063799006|4143699003|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	3ihqvGROug4ltL4d/9wfKcdTIJUwzv02Dw6SZE7L0hpmV0EV6rptowfdP/vTCvUluDBYwGSO9XymtAUigHBHt3nE0Ngt/CJPfPhtjjEym1JoGy/Wd++41xnntW8ZqMuNn9HulDgxd8qhzORfK8C4543f7Qri5v2Zs2eWAJiTzdm5uBq7SsZBeOoAgxx2OItqJb8qX8L9j8gy2jZiSt3yFgsvcWZKwLhxsgRfU0Dv/bBf+uR0/2vUoJxi0hwj2yITLMPfiKIl7PW3UamnsabLoosDOQMNUoLod4kM0RQdWbEW/GKY6CxG1bfmzAq6Smpgk1ecSSU45fTgI66+6O2SpunlBI9Tb4pyEqLk17AJgq/w2iqz8P8TZrCoebdzLXlnEu9w+9QhtIi1mfo+SyBHrZYtm/X/CWKdo4V6Q4mjeYkHF1MEGMU6BYTLOM/6fMGYy2a6tKl6Ce50rRH7wchCFr9/Jk7Yk8ZHcjsNUKKSZ311w/lB/QqRAjV404ZvYEoTUPaTUPv3znUpkl2GV6U8p+ftfemQ6ZP7KeYMEf30LMJ31lcEiptks33e0PQzr6Dhh1RzLuiJXEYY4OixZfyQkxgTdT2CjQOsrsj9q5fnmp4DsJlybc1zgI2y71uErcFVHQ4C4RH+gajDEq59rCVgnwijOvHiRIU9tqg5HamQgv3bwn5YjQDLRSa0DDVZvuTZc7OKmd0jpxc3paGijx0zCKMBWOPfyC4x18f33nlkH4+tLZTfz8tT6NV+/dVbLwOS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/mNlekOMHe29jZbYI1q/YtPxNdZIPPUYP77VY83HXZ7TAsUP4pMlxOBRKNgd?=
 =?us-ascii?Q?4rfHruPWKzlRjRIXO5p3OqAR7rC8KUXA0xg+HZSqPm02NnNJhA1fHFb0muhK?=
 =?us-ascii?Q?+p6mkVytVUJeawokqzQBFLbzsE44U1aXOzTcjQxlwpzroYNx5lMSNFMjT5cu?=
 =?us-ascii?Q?HEnCZj/GnCakDXTSZ7gBIyvrycj7ALzWDIXsZCm1VzRm1zgX1h6vq+0ZNk+X?=
 =?us-ascii?Q?ca0InPnrBoy802UBJHygUhloU/OKWKNhYOzFKC6d1BonR47D5UCKp2f5G/uC?=
 =?us-ascii?Q?d8aOesuSs8tfm1DItKgY9kMg52HMqudX/rIBNg+olOPuFafK/2ELDXqtrXCn?=
 =?us-ascii?Q?JeMm5BGJOmfLs3Ja31TF/uUPXUVJpIJ4VKLNzoSARHR48C8018arUBPvvalw?=
 =?us-ascii?Q?mDRPSMALeQiaBHQ++IRukdr5v7Kg7KRwA03CEaoEXmqIklRtIwYRSqivy7gF?=
 =?us-ascii?Q?C5JkvPKUnusNF5IwLTdSC9KF3+/tjBonURRvyI0CKwgPmFotN+4nn3J3NU5f?=
 =?us-ascii?Q?qGUa+Xpyg+u7mPD1GnQsQBXW4SMUeKXrWFux4dF6EEPodqlVHrjZWIrnB7cX?=
 =?us-ascii?Q?nvR5s2oecvya4yhlPmHv6MayFqublXBlzcQT36DZ7PyfWXn79HA9Ic0p6Cn9?=
 =?us-ascii?Q?P+o1JozkOf58/Sp+uGgkYO8OQWuMYIRO2BCSNOE1y/ptHDKdx7MUXXENRB3A?=
 =?us-ascii?Q?FvpXUVm2xYBudBQg6jQyx7kU2gzQX7EyIjlXADeVqY7KPSrJfr1mJixqorNF?=
 =?us-ascii?Q?tT5S58bfv3uIVsInA0OBIes3ACZWgDWvlNVycrSzS4mRDXxLaR21JXBYAwh2?=
 =?us-ascii?Q?+fcGo8RxX0CVQjqhWD7JxpyPa/4rB0q5+tteYbkBTKiEZoEZszRk1Un4CBqH?=
 =?us-ascii?Q?wcFCiP0QNl+cOzpsp218UkQyou6clVcHFY1HM2v7etLP0ABGi9PL/drZlOZQ?=
 =?us-ascii?Q?grLnYHFu/4z8N/NKwTtXjS8J68NjeBWIe3xRfKputf8rVtdnkv0IAwk6jfHw?=
 =?us-ascii?Q?0IYwqTXhuLqYtg7H7U7jH6/eKwiI4cvPeMBh51ZKoytrX4SJl7kkFGUBLVhZ?=
 =?us-ascii?Q?JlDdd2fmSIqFuIOHPAuwikfMDLIaSntxOeJ8ft6dHvTO15Ro5hzYhqkqDYpM?=
 =?us-ascii?Q?wigEPnNXdNPDQsDr7s+j1HrltDxSBx3iFcjVgDidKZ5r3sUbYe+10aw7aQz8?=
 =?us-ascii?Q?+wbhXlFnwQOn4RvB8BvaKMbA+ri7AUl/7cAnF8MGNSz8nZq384K9Ld9T0XK6?=
 =?us-ascii?Q?kzuwLg1AjikoL39PJbKY2vlmab+7vOeNPwifoNuHj0Jl+pevNap+M7beuM4k?=
 =?us-ascii?Q?CyEbPQyD8pazQs6M47NcRhf378iGBZyXZq4r1akefi0Ok1vjs/V8AuksBbSt?=
 =?us-ascii?Q?PJFpuVM7/hnKY2DqcuHwq7jtRwjL/b/fyVE+NYfzVYqNs6jR2JvW/QJBoTog?=
 =?us-ascii?Q?UvRrmFtUyXvcZaUI+xuD8f85eMPPpgsuzrdnLz6zCXC8KfjpsOCACuwhFdwy?=
 =?us-ascii?Q?/FRGRj/f47RkOyYZ2e2G+h/kcrwoRXXaIorwDtnxiAXrHs1CQW6e8f1bN6Mf?=
 =?us-ascii?Q?gwCM+PmlgVWwCg9NN0C1nu4HbsuMIK72oU4jKIAh4R/h9XuuGwC6eCwY1rS2?=
 =?us-ascii?Q?tzoEJ3Xcmq62VrT4sZJjnQgOSPhG7RrG91UjV44kMe42v3sTm4Tku7Zzqlci?=
 =?us-ascii?Q?1mx8nm1lxELJUhS51ac3AwAzA+jPPkUeZWJOs/zKkG6KjvA1Xc/cyVpGuJbv?=
 =?us-ascii?Q?m8pN8dtq0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4759f848-73cb-43e7-4043-08deb753c643
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:12:37.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYpR9aj6NPFPnF2eKz0bq1DZrDzTV8td+rgZ2vLrBz8uCdV1dEcv78GExWOH73X/997BaNRac/j52W6QbdCzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10695-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,valinux.co.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5A55C5A9C4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:10PM +0900, Koichiro Den wrote:
> Store the default per-channel interrupt routing mode in dw-edma-pcie
> match data and copy it into dw_edma_chip during probe.
>
> No functional change intended. Existing Synopsys EDDA and AMD/Xilinx MDB
> matches leave the field zero, which is DW_EDMA_CH_IRQ_DEFAULT.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 8ae164169c7e..cf2f09f1891c 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -83,6 +83,7 @@ struct dw_edma_pcie_match_data {
>  	int (*parse_caps)(struct pci_dev *pdev,
>  			  struct dw_edma_pcie_data *pdata, bool *non_ll);
>  	unsigned long flags;
> +	enum dw_edma_ch_irq_mode default_irq_mode;
>  };
>
>  #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
> @@ -432,6 +433,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dev = dev;
>
>  	chip->mf = dma_data->mf;
> +	chip->default_irq_mode = match->default_irq_mode;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll = non_ll;
> --
> 2.51.0
>

