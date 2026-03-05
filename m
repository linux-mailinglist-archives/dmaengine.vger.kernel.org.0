Return-Path: <dmaengine+bounces-9264-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKQeLm37qGnVzwAAu9opvQ
	(envelope-from <dmaengine+bounces-9264-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 04:41:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E80120AA3D
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 04:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B15730FBB16
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205026D4C7;
	Thu,  5 Mar 2026 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5cShMN7"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC7279346;
	Thu,  5 Mar 2026 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681842; cv=fail; b=Gml10wbf5uq6ohMFhh+yVlz8UTpnNxSp1DigR0hermYAOq1QcDeZyf0HPk+mpw4mJD5NQJFssbBT+ZPnldajwmVysb15/cmbhcZJ/362DRZ13W77mw0DtKAmMHmJvb46ZOIcMD6jqDcS099eUlIHbw58gJGST3YX11c4ye8bTkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681842; c=relaxed/simple;
	bh=98ZtZOITDVFscIawBX6k9HTQU79HoOa4gcCCVViUhkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q87SDp/2la8oA19FvlPEvYdxQLvqmluAVjEswi55WdRsKQki3KzkrIBuGlHMwWrvgeasCu79zkO1UclPdtkgLxyN0f5l92VW7mmOPEFeUOmU+7ge2X8TAsvWhPvsfuSxmts9bKE6XlVxeVSdFkEJr3EdlBbyER6LTNHtzmnfv3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j5cShMN7 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWGZJte37AYIevgrLv6EAcjgYijkZ9jcQOawH1qd/Jkb7XvDNvpj1938dudzwC4aHsXTkQEPmyaXirgH07NgKuYMZKouVSkxF6CyNRmvulHquBzjQxM6IO+xRcfRHJxFQGkFt85o7kq5BQvGsYn8TOaQqVw7/xXnByBaB2o1CvUhAOV8aKyFDEENo3lIRnFtELZgBGVSGHdFNrnMCCpLYODwf6CBJe43IGEbBY7rbIs0Df3M3s2gJR/6By/CChYExqylPCpiGcSii5wrdnv131z56ZgO3JKiYYrBmvdtEOeFItOuQnF0SMF0vFNqqzwrRY5EXF3ALrsLk1iaSnVuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TexNCgcD+nWSLeC4OsLSwZgBpMJg4RfBG8VUP16umAI=;
 b=YlpnWvUNnZhajp6aPXZOdlKc4q7JAKbyD6fCjSWuB8r5+0dMGAeCn6hXPtPWHLT9+xyCyEdzbka6qPy1nNSFULHFTdBhHHwbPn9K5KwQz2utFbhUCHBHUv7ss1JQcHri8VxVfgk+brU6SsXMOJebTQA9xtkbxzjKn5kAYr7DLEWABrwaPBkpyPRGf4O5vrPyIY1A1jBeW0UNhX+YSL8XOReZnByFimFhX/gQc8ZJBqOzaUf2X1iqcRqhH11dzZD5zvtwziowgHdVyPO3/s3HdmrC6npThpP7/kuhDeLEnVK6swu7FrlhCBObutSOF6R/cL4w/aUT+31vjHe5SDLKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TexNCgcD+nWSLeC4OsLSwZgBpMJg4RfBG8VUP16umAI=;
 b=j5cShMN7W4iJfBXepDFfXpcNMb6w7nruL4bdNGaPQbUaCb5I9puV6daY6+XazI9Brn32GgTo2r2w+0hpMqsVEy4EGXeQGkOeoPBG4Jp+m8BQ3Cfdk41O93/BMKC5Q0yRdtvi5nt6hu1Tru8+dPZ8FbmbSgmQv8WCJ2V3qqDOvezQ1ozqGtyVMJ+0uhLwHtisiQ/Xo6ZPWpLTI6/W3lFXZnwUqbIZc7dqpz6soDe3u9gItOm53rDo0t9Ikht7RCRT92BkkqXsSS9rwj/Wrqr/teGU1V1SPm7BMyqq6bYEUlW78Q4YyFp/Cm+5+eIbbAvoT6CnmX65WCcKybnQA2wv4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8541.eurprd04.prod.outlook.com (2603:10a6:102:214::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:37:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 03:37:18 +0000
Date: Wed, 4 Mar 2026 22:37:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/4] dmaengine: ioatdma: move sysfs entry definition
 out of header
Message-ID: <aaj6ZywG7BMS953B@lizhi-Precision-Tower-5810>
References: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
 <20260304-sysfs-const-ioat-v2-2-b9b82651219b@weissschuh.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304-sysfs-const-ioat-v2-2-b9b82651219b@weissschuh.net>
X-ClientProxiedBy: PH8PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: a567fbe6-4d46-4262-f620-08de7a688043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	Gn3pC0iyQQICYeZ/X8872mxhR9I44MLyqwYqTZzmlJjYsYljMpXohM6fq1vdElTVH55g1+yR/Y0D9bvEvcgDqR6oCz6R1xSGF/Grk8aKu4ER+XEI3fXG8E43grvefjJT9/EfcNscwrm3E/C1SwQvxirNa5xp6YQ36p2Dl2oJcRsn2HSVdyfmR0Zq0suXesGQIHyEuhNWqNleanLanUpD/GndupcgQrCheGoGYDmrwOwJL3geQK+Md3fDKhjxCiOcY9r3ODO5bi55QFSbL15sVhXmiA17aQ1ILJUoFf5IMbKp4cHv5Uqp8SyvSPJiqq/Qtjn06ZkoUq27lGpSL9z9OEXm2K5+bAWppGvrc7CGLm7UHQFfGvhQ+tY1fmAIYDFhPOqdw/eeZVBa5RCybVZ4GVZozNpMQN0NEZx3mT7prORIgIFFUiRNSOJKdp2zxfG0oiKLi6yY5rBQ4fHN5Y6teXX4FHIRP1CV66kWzJvceyQv7z9gxbhzKOO20NjoE0lfV0MM6cxKZ2mhyN49Mxoo7Ivyk3SnP5IXomXf1LC4TOmc3ZURSNO2DnWePB+4Id8Wlca3/stnr8f3o3OZH73qQgiXZOaDY4EqTvMkjmsG2VoCC/rivVUFdvC2hl5qxB8RL2LzVS09d1FXMgioag6d8I42+Kik+jL39c3BxEgISJwgkfv1QGTJt5t9GHKu4Sfzw7zJD595z/uqL2AzFsB1c5H+DLeW0zDOvcYyytW1jHqybEjND1BFhZAUlm5PIZICY0jDWobjRsAt8Z3oJdbe+WTYxeQo/4TplfKkt7slDQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+6coegquT3dc0tXyp6oLdhHVGMeNCAtrU5SKSWhiXMiB++qRQpA3eg1ERg?=
 =?iso-8859-1?Q?/Kf3sp2mtb/FMSqRqD0wsFzh7TBr/LIpohQdOng5rDwRYAmq7nwbIAg4nQ?=
 =?iso-8859-1?Q?Ymh8dY/FJCRIOdJzolCwPSK1AcwmfNF6stPTMBJR3SF8Np+6n7wl47C3//?=
 =?iso-8859-1?Q?+YbdEAL8dGqW84ObQNIlrI6GxQayDqeGsJvVWkWwFHKsooVmjymMKVpMVl?=
 =?iso-8859-1?Q?F6cYjirwvfu+QpLk6tGyeEgcgO6GhWtc9M4+m3JjzIVOsUl/A16JEXocXF?=
 =?iso-8859-1?Q?2JfxmJPnHbyCZ108xAlz8UombIzyyVNa3osN+r/keEl/kAz4kudX9vhHaU?=
 =?iso-8859-1?Q?Gym38CVATbPMfTcRfeNFJQlLxGOSFY7c3LqUiLU4p29GczuW5V4NRRA3L7?=
 =?iso-8859-1?Q?/SlwXwkbjtk/5G2VkzJrcQGfiKSNewojNoEJjqyqXFEo3o1/dh1Rr0IoFF?=
 =?iso-8859-1?Q?lt32rr/5TTQLBP8Jgpgnp8zF5wKzy2oqilIiyOnWcIYjft397G5I+LfAIe?=
 =?iso-8859-1?Q?WuG1NzgA0U5yiQLOqPhB3l4o2wZEHIRwqIyyHnNo+gn1oHvqeidcpZc/ke?=
 =?iso-8859-1?Q?+Fve0a0YzhGnIO4g63rcPSdXkvnM3lYUs/2ffPdzK7tk4v2pmx3LHdXp9N?=
 =?iso-8859-1?Q?MnYjhsppffTzDD1Odm8rtqCHGJTfuhDnbqYX40TQcZhEtE0Kan11whDFSM?=
 =?iso-8859-1?Q?mOR/TYmjc8gWs209i881p7VyVforxzex2LGhcjdrQcpgdBEG56sUqHPSo9?=
 =?iso-8859-1?Q?KPqubZJFs8Yz8ANJ8kb/Dzmf/wXb7XhAIJRAA5dRDQEK3uD6vr2nX4TrJP?=
 =?iso-8859-1?Q?yU6jnDzVWuj0/kgG0zrrpZwLH9q1FZMPHXrElft9gf9wJkyqtiZbvC2cTG?=
 =?iso-8859-1?Q?xlqRnBva1rI2wjiDQTtL4KSuoNMjRlzkAiHuyD3WsOn7CBGoCXWAtcz+Kz?=
 =?iso-8859-1?Q?qGdYqD15UMvj023k6DLlXSASWklj9OzOrYG6BbW+jSYxSgYY2CScYwjm09?=
 =?iso-8859-1?Q?IheSG/AjMxAzPqwYN59Erbi8V62naygnNqvIRazl6r+bJweteHpDSZUmD1?=
 =?iso-8859-1?Q?/0WaUdwb77XZqbOi8zPFMPjAjrwvEkHZBTZaMCtU09V40hMMP3aSGWH1fc?=
 =?iso-8859-1?Q?VqDQa9Hgr+7vp2BlIeuwc+7/z7j0I3DWiEVxnFYJvAZIsYvAYInQXOf4xD?=
 =?iso-8859-1?Q?IvSfuETvyZmbvGYf5J67lQYRZlifyxkGDb8NYCWS9ksGbpkcXia0Vz3yp+?=
 =?iso-8859-1?Q?pVBX0uK9mQOQbdEjETLo27Jkxor4ffIBY9YkauON2WdNVsLLdyRJSYaNdN?=
 =?iso-8859-1?Q?dP1X3UX1mQs9XvCGTPFYin7G47NWSrS0FQ1RVmDK8z4QTd95JwvbsHyDaN?=
 =?iso-8859-1?Q?t3RK2t2Yr3crHuLl48gWdmkthOwVOG1aDOYhx/kgsZ8ObWwKeg+8FQPCID?=
 =?iso-8859-1?Q?123LQDjDIfCdXmzq9YVXo6HgjYt10OCyD6/LnKnUSz3kqVts5WvHmvLqQ7?=
 =?iso-8859-1?Q?FKzxGMHsseCRxnC8qeBRwKSURaFCrivuBpPNYk6VB0SNDql1umCQcOZuS0?=
 =?iso-8859-1?Q?DTlB6bAyGsI/Zf+nD8E+bECxz/oCt7TzgsZRia1rMEg0D/aRfRgVc0FNNR?=
 =?iso-8859-1?Q?FW7zJpShwhWMOOTiSWYf0OXbatatbuvnc9ZrRYRUWevln5uVKZbEPkX3Tt?=
 =?iso-8859-1?Q?lr1QImQNe0DTUJxUMa0Oec2z6md34CRQzODxVgA6XWAHtMuSp8EGVNGREt?=
 =?iso-8859-1?Q?USdKStz9wxi5t4mjWgjZ3X5QtSA9lPjbAy0DDCCpJUTeMd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a567fbe6-4d46-4262-f620-08de7a688043
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:37:18.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTmMhssw0s1FI3aBQnCtgTwZIBgJemc0UtUj0COg8++kdL4cDw9vqJJmQMYTUTafgEz3nwCzgZJZAfIwMpVkVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8541
X-Rspamd-Queue-Id: 3E80120AA3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9264-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.144];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,weissschuh.net:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:44:38PM +0100, Thomas Weiﬂschuh wrote:
> Move struct ioat_sysfs_entry into sysfs.c because it is only used in it.
>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/ioat/dma.h   | 6 ------
>  drivers/dma/ioat/sysfs.c | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 27d2b411853f..e187f3a7e968 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -140,12 +140,6 @@ struct ioatdma_chan {
>  	int prev_intr_coalesce;
>  };
>
> -struct ioat_sysfs_entry {
> -	struct attribute attr;
> -	ssize_t (*show)(struct dma_chan *, char *);
> -	ssize_t (*store)(struct dma_chan *, const char *, size_t);
> -};
> -
>  /**
>   * struct ioat_sed_ent - wrapper around super extended hardware descriptor
>   * @hw: hardware SED
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index 5da9b0a7b2bb..709d672bae51 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -14,6 +14,12 @@
>
>  #include "../dmaengine.h"
>
> +struct ioat_sysfs_entry {
> +	struct attribute attr;
> +	ssize_t (*show)(struct dma_chan *, char *);
> +	ssize_t (*store)(struct dma_chan *, const char *, size_t);
> +};
> +
>  static ssize_t cap_show(struct dma_chan *c, char *page)
>  {
>  	struct dma_device *dma = c->device;
>
> --
> 2.53.0
>

