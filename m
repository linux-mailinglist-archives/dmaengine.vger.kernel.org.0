Return-Path: <dmaengine+bounces-12059-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JAdSCLvKS2phaQEAu9opvQ
	(envelope-from <dmaengine+bounces-12059-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 17:33:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D36712A34
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 17:33:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="ZIa1G+/X";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12059-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12059-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60B3030A0531
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF838887D;
	Mon,  6 Jul 2026 15:21:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E772388385;
	Mon,  6 Jul 2026 15:21:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351301; cv=fail; b=RSS1KXVVKcKopT8zsru9qH/J9vhsIuSty7XZbPiKPL9/tdgM3rIHVpTCMaE3N+egW7uYk3kY7inrOEJXRDUe6FuXZPSoO0ShLprepSzWEAsb2wJLDkNdfRQYSXCwmAXsT/P1sQf378U08L1tc1BKHR3cVU1XGXk5fccl1IYJeeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351301; c=relaxed/simple;
	bh=dtan2THJRaVHAVjlrIboevtvAqVH4KpYymRz2GjAWBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UKJ5aIKh6Egq8pp11jlGSflJIjKbsdANCfgDqH7F6nZ7OkYu9y1giN/n/SRjoE99xfbOtaRKq4HxSXbTFm2CpK9ks0hUfstRu78lw1On23QLVd68PzZ2ccdUekf/gXgypDwpXaFRH/TPCrn7Zcql9EWLzLmGkoaRVSyKUOjLefs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZIa1G+/X; arc=fail smtp.client-ip=40.107.130.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8Xyt6pAgo6yntGI3CSY2A0uYsZsjuHDPuWio3PaM3OnTHE9TOox/bQ5YYupeM58Ky5Lh4TLSOZoCoIg1yeJZECBUTaaRa5oaYWnV5Pkg3duGaezCMsk+m5rcq3cVHi6ad92VosjkU8gRjjTu/AhlYGTewDT4hQnrlBrqsvEmg/bisKGfxpZeyvZcxvh7KVhVtXpCZhaa9Jbqsrw54NLcBC7R3e5aaGCZ43/f51P7DXd2mNR576BnuWZD1tLBWFBiCQ6dpBDZAws7iEojP6V3twqLYC/9dulyybO+yGm392L4wb8YrAvNNi0SB+QoSijR8+hl12hcWMFib8UNDzZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4/61JvbxvAgEmZIdxW1PGZwKFyESRIMuKC5A7fHXlQ=;
 b=URrk2oMMusrZ628FdVj9mAGtpL2yVHKDOVSbB0g6A3+IYBbdslgdg19Jm9xbGvZ4Ug4jCgjyI7f3/8W6ZTukebxRr40Vi6HYNsQjuie/rp7h05MwTgJdyZEJ/m8OLgt2Tvg62PT4LkcfPFYG+82CqJdgjsht8kc8fBg99GyQVcdJ43skqhwc2TVyDnAM1JB36R7DVcZNAFvLXezrckpfaNoum8Y2j+1qmPOyxsQOiJQl2equUNmXXklDqCMurFar8w7Ekj0gvJn7xfCuDMauNxrOA7L8J5s/6vrXCya7mLjrFkCBSpZLjZ8PXWro9rrbR6koE39uEt9R9KrWwNZZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4/61JvbxvAgEmZIdxW1PGZwKFyESRIMuKC5A7fHXlQ=;
 b=ZIa1G+/XDp9f0KLsidJHlBaY7AcmQDy/4H68vMbUrK2GJAuyQAFu/AbxkEnstXO4AO7IAEd8OGbRw949N3HmTD1hE2A+3aZtnvK6vsXtPcCkRC/i9Zk2E09bb4arDfKsp5jHd6+OJQIGDqz4fwApVahADyNe0Oi/DDUHZKdzlTuR/KS16LcMjjXBCiBPT64k1BMUroC3N8jIZTcEYMXq89vUQw0yQ2m6mencr1PlEOzE5a7+6lI9n2Qx9WwulNL5LuCCpE5Po5mLP0VCkY9ZdkwCIHousU8lnrMPWliLgnM68tzArr/GNj9oIgBdq3MuJGQJMYj6VXc91uxS0K69ag==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 15:21:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 6 Jul 2026
 15:21:33 +0000
Date: Mon, 6 Jul 2026 10:21:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v6] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <akvH9KrZL8iKs7hS@SMW015318>
References: <20260706123326.2023088-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706123326.2023088-1-devendra.verma@amd.com>
X-ClientProxiedBy: SA1PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: 9439f6f2-c016-4bd0-b4d6-08dedb7242d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	H/u/bWhrfMi9dYyRGVf47IB9NUdgrBgPYZCdPkTl+oASgBnwjc613RBCt7nN17BhT7VcLxz/GCrN431W8CH/Ke7anREdyszCnkFz2+HKViDconBImm0TLVZvEV1GokP3/8pQoVZlk1ZC4fDnwCEi2lK75VFBJL4s561DqJu6oCCGQhiZ8DxvURiIUWI3CACkYJZAJzKvZHEU/rAhQn0RgQuQcyYm7GixPQjrwBZ5BessscnGPX3J4XoJFwG40Pxtr9lrMswtooZwxTqphYBiPPVeGHpiuQhiSGEh+Z/x/oBke206vqWHnH3QRLodIg6dHyJLvfVVz4beZRNOg6ubcESrbot3ktICbi/J/9NCvmBD3owafnl46IgHFidBGbsc1NUg938SldbBomyHW4lhHLbZKnyrnaE/KUnb08ttAlFngWAjIP0emt8drFGzGEOVyjtbiyUVcYv9rLmlpotGx0djd4VbsoREMiaei1Mu5KJxUt8xHEH1s6n6HDcjJOGJbXQijJsXyXGlUQKokd+mfdCwQt+dsZuX/x8viY+tLCNLg1QTvOAYuproXXU0BYdWQ1vsQLH6n7hYD8bPOQzaJkhuigqIFieNeKIzfLvj7YJrbptwS0bkeQIFAKS2WEuDwqUUIFXPFrRiwEXB+MTaqD5x4xJfoULyi1FWnGzGMnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REGB7tNb5B2BfyS4TtzOQovBgfhdcasjAiT2hF90fcshnO9mFrIIYSyVoGe3?=
 =?us-ascii?Q?ETH/6byvoM4HZPw3KSO/4gLYyqeMG+gcDe/roBfCMH57ZqMmZsrl1AEl+Izg?=
 =?us-ascii?Q?xRCixnkjiDcMqBHgXkEhQg9B0xsBK35K7n56bBaWjF9INBZrjz4xfRGFFZ3+?=
 =?us-ascii?Q?fO3h+q/q7p7Z+A/Vby64Mk9vWSO36uTPMHeIcUh/nFMVVzJb6dwWoSiO5Z8q?=
 =?us-ascii?Q?m+n/84TiKvoPHNZAAZE14zJOKGKeac8GPH2ebXM8Zs5oqvSQ3x+OJozQ90Mz?=
 =?us-ascii?Q?gwXxN9A43skrYyJq53Egw75jHR7XIC8UTx40fezTVbXKJVLzdn60y5RFG9Io?=
 =?us-ascii?Q?0SInQGrq/ZiseEeuIhhm0ySmOCrHbUxnYPPkw6HlsRw8jol1V3Er/eFxqWr7?=
 =?us-ascii?Q?Be062eO7W6vxE90dCHIkj8XrejKdcc7AURpXdVSgbSpYNkDztMJfK1fDlStG?=
 =?us-ascii?Q?1daYNwTZ5aQ1iYDjn6b8Kj8aJTYQmIwXhKV8/NixxCRtHNb22DoKSVwhFWs/?=
 =?us-ascii?Q?jxSQ/43Cytpd6UEeKOCmHg56esU9WRsRq+vB98088z91C4k7DlU2vKAXfYqH?=
 =?us-ascii?Q?BYjOQRhgYF164wGpjY/gokbxLAhRdeWOhRGFVm0dd7mnbEyoaE1J284jvAzy?=
 =?us-ascii?Q?CubooMvCRNR3d9krL2yoc5eJ9lYvhtAdezWjExHZYokVtrid8niyKvfIhTSq?=
 =?us-ascii?Q?6kSyRdexuT2D5mlmuUUZ3IgKU0IOgvbKg1MHYxcMaDuyu74IQEPf/PRnaSeB?=
 =?us-ascii?Q?i1zi4ccPUuA2IsrtNPI3ANhocswZwkBe0W94ssQSIZI1PPpFJAtj0Lkr8cgO?=
 =?us-ascii?Q?QvdltB5duX43sjxmxsT6SzOWm7liT6tKdZu/8FWaQ73uPCCBD4UiZ1sFhTEf?=
 =?us-ascii?Q?XRGTOVOdqdxjN84Djc5FVrLDvhIXZew9zH5rSFgGUgATbTYQVh58UILS3bQC?=
 =?us-ascii?Q?cSQLLqi4DXoBUIaLKAfublb2azf+Zfy/X8qePPt4Kbh3mD7nsDTDCv40T/sj?=
 =?us-ascii?Q?NizVAa81EH7X/VapCFqyWFOxORVP6/fNiZncSnkMVsBJ4pv0dm5CPAWtK87b?=
 =?us-ascii?Q?uJIkUxQQ5hoWLpHs7AEiqp5iGi0QeCRJBTxh2Qr1guaTHX9Gof647B/EddEL?=
 =?us-ascii?Q?FHTyaBJ/mfg38tmEZiXH8VUP3OdMbLDem8liZM+lkZl5N50NEq+Pef4dG4pd?=
 =?us-ascii?Q?q2aX4UAP4trBlzJg0oZeE+nooL2v+AYczw56WO1vNVZls/SW5hmbc1f0ISCi?=
 =?us-ascii?Q?NbufTzF6QenpDgpCYv+1fIZxuSY5nMLVoZfAVT7kvZRSEpy/ritpJcg7YyNo?=
 =?us-ascii?Q?ftF9VbrnU/rHo5pcqF0hoGOl67F5SxNmpzBYGsPlFfEyPUuSHcnUlwanb9/n?=
 =?us-ascii?Q?weObxJ9+q+HTEzAJVtvPds23CnYrmC+FxRqzY07aUTo8vvDye3Ucfe4a9LiD?=
 =?us-ascii?Q?qSrnCnSTj6BzwFrCLHGNacaiR86jM2DHGb3evKhXOMmybtV7292iEQDhfiWk?=
 =?us-ascii?Q?LiKTLvxBIXBB5g5jZNYklMeZhZw8jXSIyRTCshWf7AMxyDK//tRP2Gx/PVQY?=
 =?us-ascii?Q?vZnDsuD2fhJWYiBcuqEqrewNZ8+ATUT8zLFuh6w/44c/4mmHRESdMaRofg2o?=
 =?us-ascii?Q?a8+SVHCiojuR8ufjU9RZiM/fJQ1sS7/qaZDCgznZt9tMoA6Ar82wW1Ct4V4y?=
 =?us-ascii?Q?eJkWDeuPInM9G+F4ogGO/l60jGOQ7y4uOxyEomtZ58w9alw6z+nNxhFf3Jbq?=
 =?us-ascii?Q?8oJI14vlS3FUmPoxYOr5qWdNH30F6/R2LWc0EhMdMk6kBocZT0fm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9439f6f2-c016-4bd0-b4d6-08dedb7242d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:21:33.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8ZW6WCe0YpStI51mgS12S9HWeacvOYxcdc5RbtPyxjULGOWOOCgkefMJDCBFs6q2fg4mJITI9kj/kTAyH7Ft2+0GU3md5d1j4yN/M3ChFMKIoXJ2Fa8fPzAKW6zuWtL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12059-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,amd.com:email,SMW015318:mid,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8D36712A34

On Mon, Jul 06, 2026 at 06:03:26PM +0530, Devendra K Verma wrote:
> As per 'Designware Cores PCI Express Controller Databook',
> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
> channels. Current controller driver supports up to 8 read and
> write channels only. In order to utilize all the channels the
> controller driver need to have the channel related structs
> and variables as per the number of channels supported by IP.
> Following changes are made to enable 64 Read / 64 Write
> channel support:
>
>  o Defined HDMA specific macros to reflect the channel count.
>  o The count of ll_regions and dt_regions in dw_edma_chip and
>    dw_edma_pcie_data shall be in accordance to number of read
>    and write channels.
>  o In dw_edma_probe() configure the channels as per the channels
>    of the IP used.
>  o Changed mask types to u64 for higher channel counts.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
...
>  struct dw_edma_irq {
>  	struct msi_msg                  msi;
> -	u32				wr_mask;
> -	u32				rd_mask;
>  	struct dw_edma			*dw;
> +
> +	DECLARE_BITMAP(wr_mask, 64);
> +	DECLARE_BITMAP(rd_mask, 64);

Nit: Please macro HDMA_MAX_RD_CH and HDMA_MAX_WD_CH

>  };
>
...
> @@ -252,7 +252,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	}
>
>  	val = dw_edma_v0_core_status_done_int(dw, dir);
> -	val &= mask;
> +	val &= *mask;
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> @@ -263,7 +263,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	}
>
>  	val = dw_edma_v0_core_status_abort_int(dw, dir);
> -	val &= mask;
> +	val &= *mask;

It should be fine if sparse don't report warning.

Frank

>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 632abb8b481c..0181bd276e22 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
>  	int id;
> +	enum dw_edma_dir dir;
> +/HDMA_MAX_RD_CH

> +	dir = EDMA_DIR_WRITE;
> +	for (id = 0; id < dw->wr_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, int_clear,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, ch_en, 0);
> +	}
>
> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> -		SET_BOTH_CH_32(dw, id, int_setup,
> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> -		SET_BOTH_CH_32(dw, id, int_clear,
> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> -		SET_BOTH_CH_32(dw, id, ch_en, 0);
> +	dir = EDMA_DIR_READ;
> +	for (id = 0; id < dw->rd_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, int_clear,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, ch_en, 0);
>  	}
>  }
>
> @@ -118,7 +129,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	unsigned long total, pos, val;
>  	irqreturn_t ret = IRQ_NONE;
>  	struct dw_edma_chan *chan;
> -	unsigned long off, mask;
> +	unsigned long off, *mask;
>
>  	if (dir == EDMA_DIR_WRITE) {
>  		total = dw->wr_ch_cnt;
> @@ -130,7 +141,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  		mask = dw_irq->rd_mask;
>  	}
>
> -	for_each_set_bit(pos, &mask, total) {
> +	for_each_set_bit(pos, mask, total) {
>  		chan = &dw->chan[pos + off];
>
>  		val = dw_hdma_v0_core_status_int(chan);
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index 7759ba9b4850..48e40efceb2e 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -11,7 +11,7 @@
>
>  #include <linux/dmaengine.h>
>
> -#define HDMA_V0_MAX_NR_CH			8
> +#define HDMA_V0_MAX_NR_CH			64
>  #define HDMA_V0_CH_EN				BIT(0)
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..da7a5cc93ad4 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,8 @@
>
>  #define EDMA_MAX_WR_CH                                  8
>  #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_WR_CH                                  64
> +#define HDMA_MAX_RD_CH                                  64
>
>  struct dw_edma;
>
> @@ -89,12 +91,12 @@ struct dw_edma_chip {
>  	u16			ll_wr_cnt;
>  	u16			ll_rd_cnt;
>  	/* link list address */
> -	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
>
>  	/* data region */
> -	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
>
>  	/* interrupt emulation */
>  	int			db_irq;
> --
> 2.43.0
>

