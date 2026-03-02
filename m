Return-Path: <dmaengine+bounces-9194-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CCVH9MLpmkJJgAAu9opvQ
	(envelope-from <dmaengine+bounces-9194-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:14:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98771E510F
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55B80330BF30
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7439F17A;
	Mon,  2 Mar 2026 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jrO25vSc"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3E388E79;
	Mon,  2 Mar 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486080; cv=fail; b=YFISX1o5WveVC+AkeDxqfiwA+Bbb4S6O8lzBSSivhdkTIBuTiXEtSht3YyFFsQSgWg+TlEUbn8eoYWfioQ6R5EXS72Wsos3n2KB9yPIMOOjccR4p5LZ3JLmmQUqzlrW7TD72YQ9kEzSjtecjMRspnkOJLqppakGp+dnFuBx+Cak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486080; c=relaxed/simple;
	bh=m0ifbLyOY5oM351k4QIpRxIqFq0JEBeVpUsqYKMotNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJp0SeT0W7JGEbI2hl8oU2ID89zC2UcBhMz90jRmoliLgvwRd/hJd7o4lI/FaIYwc/mQba4HRjBoF26eHaVtqsrSi03wpVZNmenW6jH8ayC7XaW4i+bVH3MS9upgUeKAyiRwHg8VtVKI4RyzuSOh2oqOjrhNA3rr08OHMk3JCog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jrO25vSc; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brc5XszxH4peYVtNpZftDf6GTfAsrgmuUmUAO8yt0iz3pWemeh3kQfCtNO4fwGLZGpS8wZ196NycXxweGMPLOEAsZDzJsFGlsWLdgeoxNNMxYmKwqfGOwhOKp7MZpIFimYDB1Ml2G+qnWyzTy2G6sw/lC2HqC5MnLeZj+gWfuI2IqSSIthx21D0LLtRRwIcHurIKfT6YFXM3kkxDmaPu5vs8CPvaL0GGQJvRIe6O0gjjENU0RksaMuLBzovr4o46e6rDZdzES8Sl7H7xiPE+mrdrWAlVf1nbEhb3WH920HqJX+Ld5kckmGyHkBDeso11V5pvSTt22MQnMCZJ/fq0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AueXEUvfb8faKZk3L1uws7lstA96auNi1n2MgBR/xlc=;
 b=MyuLVhI1uYEa/uBSoZrQ/BJJFs3wdpxjkAfBsymlCi16wp2RGEhC74L1Hya5bSYgkT6duwk+Noe3RXy5pQ5K+ISstTT029jpwFHSyDIeBcSMb8ppFA5z5xrlyGaknw/nQag9qLn+iCk5ghHGuopF8x+poOOXDQk/yMtZ+EziDQhp29jlNBxy8m5FSDJK0RoEp5UEbfaXfVphDqp2lI/MmaHqaVoQ3iwlmYFETczCQCCjrP0N3CSrsl3EuL5Akjt6tI/Ht+aMhNVTOclcN2RHeypi1+ZEHRtdMHXroYAbVsegz+RhlLUPzMLjhNE74eB2d4fEonz/QCuJEDhoHNCD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AueXEUvfb8faKZk3L1uws7lstA96auNi1n2MgBR/xlc=;
 b=jrO25vScnAb2pKZSXgyl9PMiUHh7HceDVERUhjVFocIhUStZ2t1niFAKDI7a5T6DPmof78naufe20bTXuv/KK4qG0tjtHLn2EOtLxPnegYqiaBiRF73Cin1QkOi6IwBKljcO67R3Mxli/EBHGtGEYHjqb6l0guJUe1OGnbcMiqQ7wt/7r3cuEV+qtOwZjXmhYE0dUA2M9GU7VrASf4yylcIoyg/CzSykqFG2GKV7Kss2uV96ETepWesQ4RP/anWnOICYYEpgzk2Dg1k1UWuXkPI5cmi9U3zsFh4iehi4UudQ4JoILO5zrYc3glmKXrH6aFeKYDP+TuOrd0pcNJQKlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9889.eurprd04.prod.outlook.com (2603:10a6:10:4ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 21:14:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 21:14:34 +0000
Date: Mon, 2 Mar 2026 16:14:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] dmaengine: tegra: Support address width > 39 bits
Message-ID: <aaX9sfdDORWIqYos@lizhi-Precision-Tower-5810>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
 <20260302123239.68441-6-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302123239.68441-6-akhilrajeev@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4af5c2-8c7b-4823-8c61-08de78a0b3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	/2QVINHh9HLVVdCA4fi9fQhHzQ6NxDfzBLDHqA/vEVtxmNtkaHOuWMamSag7n8gb4ZTVQyqOMtvgoc7kauI8JRmSExoQUMW1P+F2QWK7r8JTlz3G3IdhmfZIq0P/pqIAZd2kv+p6q/vAchqpz4VVFRQLMSUdIc6UU3OhcfH7X1gWi8BUKDhlWWU0NYuURZxvBOLPn+OrbCg/+uzDOSU/jfy3CZA9TM+vbEUucVCmTUCqoH1I5FFJd8t0nmu+WfyzPSOtBJtrNvaFuH3FfbmqezWzbn+Gk6MszEwiDAhS72qOUGnUdMeSD0fMCeZItW0enCKTJssqqjnDqPm/XJdGjhx0qvL2BQ8ZsvFxLO+XhtFlOzbhJ93kPujm/O+H5KZ0jSyRnwDMFHdAfXwyZKe28Xvju5P3ALwJvbJe2tWZSlTOkZrE8EwBtOnVuCRLV8kzkgdUZeJ7yz+QL0ur0JZZfjdVFSMLaTSufxfr41gZEz4Lc01GKoBKX4oyCS/GtNc3DyPAaZ8SwwqEZfsBrw2uX9O9VLkUfYrEQ4GsWgV78DZonTDcX3r5SkYAABCc1HdVzyK1AuTPyJZ8LC7mfv1dx6G/NBbsOLgzUW6cPTsD2n8t43fEgNSpqBaOjhp1f3jCazIGI81DqJA+N3BwfPAeG9ODJofFFbdoepqUQKC6fdvwsvz3bjNX3lLJwd297pMFzBkRSHfMOJYjTpaUbIpRnWjPoytgSue09e2A0FemvAmgJ/s9lBb7+87G8FyoXiSYnDELuDtn7/hWxv9F6iOd7DqNCEdLAfB2vgD9ObG3lHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IazcVo2AHqp8jeyGSuB5yb189sggutYELVdNo6EALR2kAjpOv+6DLy2iDObV?=
 =?us-ascii?Q?7fZMJGv8ZY3uMOd5jiyYYU75tgC/QchsSDe/IHZKNE9C9dvt9ew2VXHnkFZt?=
 =?us-ascii?Q?hM0G6iKYV5CczFoyXyg+eHGP4U/gvnQsuV6hJjd31fyVct1hgl9S3gM5vnd4?=
 =?us-ascii?Q?bhlXv1K/pgZQRVINMdAjK0aAvqnPbzpYm4h1bGyBTnyZxE9OILWt/cdfSzbC?=
 =?us-ascii?Q?vP00v57KPV8GvOXmu5HLlcbF2LJiRVvljGEuI1NuTownM+EoTij0cG2jqszI?=
 =?us-ascii?Q?Lcqj728VNNT7Wcd1JkkHfiQnCPuuNELQ3MoUie2MNn/Tq49wz1qZCAvMmOrR?=
 =?us-ascii?Q?caiyPhhOsAzq6VY4t2PVCKBHAs/JCsYWu5O5O7evBzVY6kS+6+GuG23MymoI?=
 =?us-ascii?Q?j60HD1MArcclyBHN5MYY9OWc/v5GDXVW10f0jgceVlBxJ8+hWwdeGX5Atbwc?=
 =?us-ascii?Q?Iy3/t5VzWQ0M/v45LkfLMofPfDmEl5DdyTUnvRpGgCqgC3mEQ17VLD7BVvlc?=
 =?us-ascii?Q?de+8iNzyxDtfQfbe+PGOMKVTQo4tXKOLgzSNAuPFaZrBxFqglWk9h22TtrEY?=
 =?us-ascii?Q?3LpkkCd1f76duoxhL1rrVLjzWyCadNKfSBcLiugXfc7bDy9qdNPo7lqOal1o?=
 =?us-ascii?Q?RDA6mKErKolCg0bmO+v4HTDJTH7yOv9tCsLEAyASrnLUslZw4YN72vrZDDHD?=
 =?us-ascii?Q?Pit7IHrJ834rGLG0InkGpw/AEqi2P8jtPkcptaizzXhg7ZTI0dZJwWwIy43b?=
 =?us-ascii?Q?HHlJZxwUwjEKrKotN6Vo+n7GL0q0Jf9jGwMuWa4HaP22ff687n09tqr5Ekfs?=
 =?us-ascii?Q?IqBtmFkM3n+EvWyRIWyYbuxrk4DpjRC7f5JotWpiazI8tJ4pb1HTujI43g6V?=
 =?us-ascii?Q?HfnP2VvW7mJRI6JXpX6qjtL7Ug1afOAeFPW1KAJWR3YzUJwTHAmScZCoYWwZ?=
 =?us-ascii?Q?DTRjoJtpkBERGPK904y4JeCWVw2p5nVpPWPfciEu8Z70+wRDof1cTYpFS+aZ?=
 =?us-ascii?Q?e23xfwQe03SwAuc14wsotuQ16D7XzOcxPRytsw1EvhO0R9XyyB9TC8zELUmr?=
 =?us-ascii?Q?kccavHWTZn9SYgCzaQmljVWr4iNuKFGa6YF0UJwgB0SI/uMSKIrvLyxpV9Z8?=
 =?us-ascii?Q?uZKLqL6sKyXOelrH7XsQ9x3oXwZ0rrKacC1asP0tr/eGqVRozxFRjz6YAktu?=
 =?us-ascii?Q?OiTbmleDWB8ubZxmRxc9H2/LR1fDA9GtjYawNjG0gGiHIYyPcxenI5BtSxsg?=
 =?us-ascii?Q?tBTLh641xURNQA/LWJM0gOzlRdAdu9SS5w85fo0e6omNThaNYiaODdo6B6nN?=
 =?us-ascii?Q?/164Ge2kZVTzG7OCLyAkHmvZznMY0uoY/QvAjguzkvLSjlNlLTYnfRczD/BJ?=
 =?us-ascii?Q?xKDrFHA/IfeK8GVJ4ndE/Uj85pPj1JCoVAWXa8XAcYEhFENJMPOGEZRpek88?=
 =?us-ascii?Q?kT+2o5bHQXLktsVcIe7CREehz+4xeGnOnj19VFlEViU/+QEhPHfqfLxhf1yJ?=
 =?us-ascii?Q?cJpptGOeh9LiHD/DMWh2sTXSZwtyQaGqhoC6V/gH8Ipp4RaG16If6WNQqB4h?=
 =?us-ascii?Q?CgQnYvpBs3FGfEZfEQWq1U0ynwzZqhHsox0CZglsUbYHu447ByJ45q7KAhcS?=
 =?us-ascii?Q?O4jdG4NP6t+jgFw//cXVdjmSThUB1yvb/2+/vSjPFCJbJOx1He7E2Vu7V24h?=
 =?us-ascii?Q?3lAEjSalC3fx1DseJu85zTP1kaz6kJRXOvO2gdZE9T84SoI4Za9Y2eKjGbaA?=
 =?us-ascii?Q?xvSsfo7VaQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4af5c2-8c7b-4823-8c61-08de78a0b3f2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 21:14:34.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31jgh3mUrYLIIi20otQ2oS8T5NmYtRBL3WoC2SQsmSVuucg4rBRHqPjzOK8vFBIO7slZB1SU4SNqChVHMzO0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9889
X-Rspamd-Queue-Id: D98771E510F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9194-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:02:35PM +0530, Akhil R wrote:
> Tegra264 supports address width of 41 bits. Unlike older SoCs which use
> a common high_addr register for upper address bits, Tegra264 has separate
> src_high and dst_high registers to accommodate this wider address space.
>
> Add an addr_bits property to the device data structure to specify the
> number of address bits supported on each device and use that to program
> the appropriate registers.
>
> Update the sg_req struct to remove the high_addr field and use
> dma_addr_t for src and dst to store the complete addresses. Extract
> the high address bits only when programming the registers.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 87 ++++++++++++++++++++++------------
>  1 file changed, 56 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 09ba2755c06d..753e86d05a02 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -151,6 +151,7 @@ struct tegra_dma_channel;
>   */
>  struct tegra_dma_chip_data {
>  	bool hw_support_pause;
> +	unsigned int addr_bits;
>  	unsigned int nr_channels;
>  	unsigned int channel_reg_size;
>  	unsigned int max_dma_count;
> @@ -166,6 +167,8 @@ struct tegra_dma_channel_regs {
>  	u32 src;
>  	u32 dst;
>  	u32 high_addr;
> +	u32 src_high;
> +	u32 dst_high;
>  	u32 mc_seq;
>  	u32 mmio_seq;
>  	u32 wcount;
> @@ -186,10 +189,9 @@ struct tegra_dma_channel_regs {
>   */
>  struct tegra_dma_sg_req {
>  	unsigned int len;
> +	dma_addr_t src;
> +	dma_addr_t dst;
>  	u32 csr;
> -	u32 src;
> -	u32 dst;
> -	u32 high_addr;
>  	u32 mc_seq;
>  	u32 mmio_seq;
>  	u32 wcount;
> @@ -273,6 +275,25 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
>  	return tdc->vc.chan.device->dev;
>  }
>
> +static void tegra_dma_program_addr(struct tegra_dma_channel *tdc,
> +				   struct tegra_dma_sg_req *sg_req)
> +{
> +	tdc_write(tdc, tdc->regs->src, lower_32_bits(sg_req->src));
> +	tdc_write(tdc, tdc->regs->dst, lower_32_bits(sg_req->dst));
> +
> +	if (tdc->tdma->chip_data->addr_bits > 39) {
> +		tdc_write(tdc, tdc->regs->src_high, upper_32_bits(sg_req->src));
> +		tdc_write(tdc, tdc->regs->dst_high, upper_32_bits(sg_req->dst));
> +	} else {
> +		u32 src_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR,
> +					      upper_32_bits(sg_req->src));
> +		u32 dst_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR,
> +					      upper_32_bits(sg_req->dst));
> +
> +		tdc_write(tdc, tdc->regs->high_addr, src_high | dst_high);
> +	}
> +}
> +
>  static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
>  {
>  	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
> @@ -281,10 +302,20 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
>  		tdc_read(tdc, tdc->regs->csr),
>  		tdc_read(tdc, tdc->regs->status),
>  		tdc_read(tdc, tdc->regs->csre));
> -	dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
> -		tdc_read(tdc, tdc->regs->src),
> -		tdc_read(tdc, tdc->regs->dst),
> -		tdc_read(tdc, tdc->regs->high_addr));
> +
> +	if (tdc->tdma->chip_data->addr_bits > 39) {
> +		dev_dbg(tdc2dev(tdc), "SRC %x SRC HI %x DST %x DST HI %x\n",
> +			tdc_read(tdc, tdc->regs->src),
> +			tdc_read(tdc, tdc->regs->src_high),
> +			tdc_read(tdc, tdc->regs->dst),
> +			tdc_read(tdc, tdc->regs->dst_high));
> +	} else {
> +		dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
> +			tdc_read(tdc, tdc->regs->src),
> +			tdc_read(tdc, tdc->regs->dst),
> +			tdc_read(tdc, tdc->regs->high_addr));
> +	}
> +
>  	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x WSTA %x\n",
>  		tdc_read(tdc, tdc->regs->mc_seq),
>  		tdc_read(tdc, tdc->regs->mmio_seq),
> @@ -487,9 +518,7 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
>  	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
>
>  	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
> -	tdc_write(tdc, tdc->regs->src, sg_req->src);
> -	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
> -	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
> +	tegra_dma_program_addr(tdc, sg_req);
>
>  	/* Start DMA */
>  	tdc_write(tdc, tdc->regs->csr,
> @@ -517,11 +546,9 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
>
>  	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
>
> +	tegra_dma_program_addr(tdc, sg_req);
>  	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
>  	tdc_write(tdc, tdc->regs->csr, 0);
> -	tdc_write(tdc, tdc->regs->src, sg_req->src);
> -	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
> -	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
>  	tdc_write(tdc, tdc->regs->fixed_pattern, sg_req->fixed_pattern);
>  	tdc_write(tdc, tdc->regs->mmio_seq, sg_req->mmio_seq);
>  	tdc_write(tdc, tdc->regs->mc_seq, sg_req->mc_seq);
> @@ -826,7 +853,7 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
>
>  static int get_transfer_param(struct tegra_dma_channel *tdc,
>  			      enum dma_transfer_direction direction,
> -			      u32 *apb_addr,
> +			      dma_addr_t *apb_addr,
>  			      u32 *mmio_seq,
>  			      u32 *csr,
>  			      unsigned int *burst_size,
> @@ -904,11 +931,9 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
>  	dma_desc->bytes_req = len;
>  	dma_desc->sg_count = 1;
>  	sg_req = dma_desc->sg_req;
> -
>  	sg_req[0].src = 0;
>  	sg_req[0].dst = dest;
> -	sg_req[0].high_addr =
> -			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> +
>  	sg_req[0].fixed_pattern = value;
>  	/* Word count reg takes value as (N +1) words */
>  	sg_req[0].wcount = ((len - 4) >> 2);
> @@ -976,10 +1001,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
>
>  	sg_req[0].src = src;
>  	sg_req[0].dst = dest;
> -	sg_req[0].high_addr =
> -		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
> -	sg_req[0].high_addr |=
> -		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> +
>  	/* Word count reg takes value as (N +1) words */
>  	sg_req[0].wcount = ((len - 4) >> 2);
>  	sg_req[0].csr = csr;
> @@ -999,7 +1021,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
>  	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> -	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
> +	u32 csr, mc_seq, mmio_seq = 0;
> +	dma_addr_t apb_ptr = 0;
>  	struct tegra_dma_sg_req *sg_req;
>  	struct tegra_dma_desc *dma_desc;
>  	struct scatterlist *sg;
> @@ -1087,13 +1110,9 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  		if (direction == DMA_MEM_TO_DEV) {
>  			sg_req[i].src = mem;
>  			sg_req[i].dst = apb_ptr;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
>  		} else if (direction == DMA_DEV_TO_MEM) {
>  			sg_req[i].src = apb_ptr;
>  			sg_req[i].dst = mem;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
>  		}
>
>  		/*
> @@ -1117,7 +1136,8 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
>  			  unsigned long flags)
>  {
>  	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> -	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
> +	u32 csr, mc_seq, mmio_seq = 0, burst_size;
> +	dma_addr_t apb_ptr = 0;
>  	unsigned int max_dma_count, len, period_count, i;
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	struct tegra_dma_desc *dma_desc;
> @@ -1209,13 +1229,9 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
>  		if (direction == DMA_MEM_TO_DEV) {
>  			sg_req[i].src = mem;
>  			sg_req[i].dst = apb_ptr;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
>  		} else if (direction == DMA_DEV_TO_MEM) {
>  			sg_req[i].src = apb_ptr;
>  			sg_req[i].dst = mem;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
>  		}
>  		/*
>  		 * Word count register takes input in words. Writing a value
> @@ -1314,6 +1330,7 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
>
>  static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>  	.nr_channels = 32,
> +	.addr_bits = 39,
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = false,
> @@ -1323,6 +1340,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>
>  static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
>  	.nr_channels = 32,
> +	.addr_bits = 39,
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = true,
> @@ -1332,6 +1350,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
>
>  static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
>  	.nr_channels = 32,
> +	.addr_bits = 39,
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = true,
> @@ -1443,6 +1462,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		tdc->stream_id = stream_id;
>  	}
>
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));

when bit mask >= 32, dma_set_mask_and_coherent() never return failure. So
needn't check return value.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set DMA mask: %d\n", ret);
> +		return ret;
> +	}
> +
>  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
> --
> 2.50.1
>

