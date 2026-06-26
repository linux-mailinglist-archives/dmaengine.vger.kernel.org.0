Return-Path: <dmaengine+bounces-11821-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9zmBmylPmo7JgkAu9opvQ
	(envelope-from <dmaengine+bounces-11821-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 18:14:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6C6CED8F
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 18:14:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="U/sZgzgz";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11821-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11821-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BE5930F9D4B
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80A3FBB6B;
	Fri, 26 Jun 2026 16:10:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D218481B1;
	Fri, 26 Jun 2026 16:10:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490217; cv=fail; b=tZHV6/2XqyFsNgt2Nwe7j0l2r0LXzWL9vF7b1fmvPk9UtPRrAzj7E56UGA2I38juW63xIGKJEo7tTviJIdUKieEtMz7wjgU2M8pvirkiJuhwsgVuKNQxSq+zDdmeiSZD2SEsUQXSB8z7ypg1rXXGmdGnd9V46UIZrtOhztpvid4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490217; c=relaxed/simple;
	bh=eFYSClSegdQ0bzYp98gR2ei/q+I8WPKsNW7GMp0KvY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TOP0T2dofXQZ+l21JYeavSK9SBE+GcKehMTpRuIEoy/XtNrG/rEg0cQ7DmiN566ScQ4qsUJ253vtfAJpQbtKDYS5c/ok5YU2twAPMqfGJVk7v/DF+4jGckjlftkwtsu70/nT88ghUM/47d6NOHgB1xYh5v92D0QOPUpLkmLZTno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U/sZgzgz; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl6eEVglDMuo9KwjED/urak2gPefQy0y1GdWrZNColGZvk5jJicGBx/iTynnUd7c9BKDSMMH20x5zOFsQJJcnBnyOBURYw3iZtlBf9BNyowDHjp0pK6+C7rfuMTQa0+MM6yYhH1e531TfLTUn1dwZqK1Sgq1M0gLYXHfhCOC8TzlEQpFC8C21aR70PbSIaZi2HrKamwO3ivepVYuBFfjU9ojXXLdMhnvkMYOIMQkwX2N4HEVU+gmc6Nq+bfjl3M5UWYAiLbBNmOy23eu5CsdlaMyj792bhqZz8AthXnDVY9KuKBdc5nU6OkiVU86Ie28sS5O+DOjF1ucg9PGyTTI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8gNCcJGUlM4UbR8mf7ZsUrkE6OhG+XkLpq429FrrHQ=;
 b=yLNBjwiCCbhQSQM0lBs/HbjIjIXT+S+TQOBmoQB8IJ52nN2YngRXdVVAX+E3JqA3JFp4gkK5Ju+w0IpFZCXsVJhFbPJW6pq6DMM+uTQgD0NxYG5zklHeSeRlP+9L9Fkb/SptsnEJPLLLe4el0eyBm+XBBSKs02ESABPGCBXFF3Xo/l3vtuGNlJ2MZQ8UmUl3fwZN6dm2BXSyPYeO20kkrcCnM04l/Ld63BEsvToG6ojM0XUicaVAzqA+dIDDiPj8anIW2QDYO3/jePrEFLVnIOIvr8hzGkwMsy3qm3lUSQQAiLeyGG7gj5SrUEZVSqPzHBVftJ9/RMaeT5+OURkh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8gNCcJGUlM4UbR8mf7ZsUrkE6OhG+XkLpq429FrrHQ=;
 b=U/sZgzgzmM8jLZxN9syUnmPn9jAqtTLeZlxokdSSdQ+19h5XEyHBk4Vnh9amq3FQvO+rsZgD4OVDtAWyvQWUwKh6quPIMuiQB/DwD/CL0cRsnx21e9uYTiBEx2ww6Rneyyc1rFmVOZgCk5Lw6hOLIIosjybv6z08VU24NkTwRHl/VMs305Q8Y3+curTV4jkDjVDshUJbrF7wjCoIOyT4KkmSKy2dPM2qTC4t+AlnoTxSFJwqruaZStCPOPK5PBzz4cCKYif+AhVLjPVDIaU8NjddSc01vetFfOrK1KId3sD005vnOjFnBiVlV5RvpkcoHoQ5Ii5p8bSZqLy2fRczCA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB7042.eurprd04.prod.outlook.com (2603:10a6:208:1a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:10:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 16:10:07 +0000
Date: Fri, 26 Jun 2026 11:10:00 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <aj6kWCMbzyYC8Nh8@SMW015318>
References: <20260626132151.1875965-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626132151.1875965-1-devendra.verma@amd.com>
X-ClientProxiedBy: SA9PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:806:23::32) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 217fe0d2-b00e-467b-b5bb-08ded39d63f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JQ9pFtu/9JcJ0AiKIeAxHTAXypXuGV5HNJnOR+IPYuVV234U1F6G80fpbymiSyK33W0deyzHc73+/2DzB9V9GRUWzGOqRrP1zclk5KzPQS8O+28R3KJpW9pHrRONLRi8EEa7DKAcxXKxeeHghJNxD3TPMSiL1jNm3eJaE60wyBGrxMQx3JgvdKkceDr95ST5lBAcMKITe3ZBTIFZSp3Tl1ZZbH2cJu/R97yUv5U7uXGzPcoeOoIuqS6nN3nfKmEnPYoGBy36JTbxmyTsQAK1/q+lII70g694H7lgEGlTn+yojbgHEtTWntkJPyyEgXwRPAH/SoiAD21GSYjJBjxZOvAkSFOycHqyAiwKZ0BkxgGQw9AROEej3zMwn02mJgDAdDDKMhObSnONKE1ISpMgZrcG3Xv6+p0+/88hh9LSxx0L2YI3qWFqzgImoNIWBiMJ7aLQhUfkmspoZrP6l8G6VgewBh/pKz0uluFJ898KqOO0g7PfxRs14VQ4U3uL6nvCpuGDLjpx7g2ZZoVPOLIBIeXvNN6eDtJ459suPMMyT6D6jPtse/CJTN4dpQw7ft0+Q443O2VBCrpX4+9nChLeIvlUiR11XMIS2E3veybtyaiZ3G+D2zf8Vjxj6p4UnSUIqnDatC8jhbQvfSRgX+vB440K0fNUmRW9jkOnLs8AfrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/wZXHhUdTzJWrGpsc5Ai+nLYUdfwmjf7eKPM+7OelFd3wr5POUBcpwjxFgaH?=
 =?us-ascii?Q?9TnXV577O7ifHC0WVJpbWlHc39Y36LjG0pIpkbNFmORVs3/zy0q4s3Z9WBYp?=
 =?us-ascii?Q?VadlTujXbpGdT7QQ1oBbb8vdYDsBLg8jxTcOphxhDFqFdD3P3Lo0zT3KJNTv?=
 =?us-ascii?Q?czbLCLMahBcCo6uRfsTGuOeVdnH7AGgZRLphn5SJ0zvgFf1U77Lr4hjEDqXd?=
 =?us-ascii?Q?KoTyUUZ6MtJJrYddeYFkFFepa7H/lNcmPKsr3z69BDBIxmeRTxDXuY0e31a8?=
 =?us-ascii?Q?+QmAC0WGCjkF7XT7eyMEOr+Usr6UsTEjDwY73WUitPweA1v66u7/0OHTcPRq?=
 =?us-ascii?Q?qsr/iJtjbbzVtUE6TSJ80aFpRNLmk0/cK7UpdpJLyOdsBBu0Igv/fS8kKRgX?=
 =?us-ascii?Q?aJCLGvL2L55xVm2PLb0+WB+Ip+ud3CURHxIPP4sv+mbCuqJnm15qFYrFp4jY?=
 =?us-ascii?Q?76DDzDh04PypH+C0O6IejOSQNuV8uRdeIodYdgt0xwglDW7+bVsJWydPxKdQ?=
 =?us-ascii?Q?aoaROU4dHprJBWkRLTKFUinfFZSoo+85HaxaQHT2sJgUCpXyy46idSF6FjCw?=
 =?us-ascii?Q?L6yvPhv+QSu0YH+zM5JYXQco+5DmfL74hZOBuoeO/ahlwOYXYym80X91/37l?=
 =?us-ascii?Q?BqY6jNcGUfgvLghwXFo6rw6jA1O4gYomOomAIuLvI1T4G6/Dk0mUwmcfXjTu?=
 =?us-ascii?Q?+SHq50dtelQH168/XjDRNmMmgSx7/1wGuISPgNl5Ne/YbqLcueB0b4bZkrAL?=
 =?us-ascii?Q?5DRVlUN5zCgRuZnOb2wgPajOX+GAYP9OARp2RSFKP9X68mi8AkG+wq2JU0rq?=
 =?us-ascii?Q?mb9GAf+urukl2/5L9AoSWuRzevS0ki5/VkaH7rxLK+zW9lNStBgRzlkHpAwa?=
 =?us-ascii?Q?2ICxixw7lrWJv1Q/1sI6b34hacAaM9ds7oZlGm0DrDYcTCaNI/8qKecpr5LB?=
 =?us-ascii?Q?hRkYKMAhevgWadALfyXtAgAImb0ILhEym/Mk/EqQdiJXJ8L+Ea4Y19sc89Rd?=
 =?us-ascii?Q?K+S/MZUhof+Ii53e4BsQRPQon5GNEt6nffQ75FNAd0u8NyC5tNdM61F3JKI9?=
 =?us-ascii?Q?hKDiklM85vj5AWogQbz1XPsCGp2ywvSEhfz+nkli04YTYHbfq4EJpiqYErUz?=
 =?us-ascii?Q?IcdaFfD2xxa+6INMpT0cAGRgKX5M5uVlDsv9dHSDBixef9tarCh0rskL0lKB?=
 =?us-ascii?Q?OpoRbuZv62RK7buZcIHVaWIwbC+jbHmSgS8oUsMSNTccdtl24NYSF2b4PGPx?=
 =?us-ascii?Q?Uh9hKAJooxGAQptR0Vhuiwb52yF6eBLZxtc3iQ3yOagCyyNDE0ouBs0yPfEk?=
 =?us-ascii?Q?8QzGkWz+a+Or2CyXW1leHO5ZJgpAvEk/FB/cPC06fcGGzNdPXYnUowHCQz2e?=
 =?us-ascii?Q?vkjk4Kg6tIWi9y8o+TFuZXJgN+gc/WB6gC2AVJ3GM7rBhx3eitapAIVhkhSQ?=
 =?us-ascii?Q?6BC5T960jl1NGI28k/kuA4V6+dZF+LySHZWNG4RP3TV8RbnVoVjCPKUO3suR?=
 =?us-ascii?Q?WDas+JYoqxGF5Z1yHZP1LQBjrPHXeepzMn7nyMaXvZRAF7nmSWO53z9NOPRs?=
 =?us-ascii?Q?8AvJUYdboOmT3qDwfo9BwLVROkIk4lkouiMfENCzO2oH3e4eb+i+0+huQVLv?=
 =?us-ascii?Q?jYPrDU5YhaFyqmDtHqMrL15dy3JjJ2+GH8sLoOuyEAt/glW3za8g1/HicFiU?=
 =?us-ascii?Q?D3X+P2b4LmHaIhz16al9BDfJdDFGD5bsSmCgbP6tCeQyJC63w9qoNC3kkqmM?=
 =?us-ascii?Q?xtzzXa2ffJbURgNaDDpVzoAzjNjIyMxherq4fV7RqtNNU8Il9Jpy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217fe0d2-b00e-467b-b5bb-08ded39d63f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:10:07.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83M1KHP26PfEjJpiDabSP13i1hEHi3SiFggujDajkAOlnYK1HvXT3wSkr9pvYL+vEpOCXReLA9mIs9PGB9XUfh7Otk1ElulIvDmCHbPkbcDTGeuWuxhCf/EdZrM0TNDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11821-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SMW015318:mid,amd.com:email,vger.kernel.org:from_smtp,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61F6C6CED8F

On Fri, Jun 26, 2026 at 06:51:51PM +0530, Devendra K Verma wrote:
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
> Changes in v4:
>   o Changed 'mask' variable to a bitmap type as per the
>     review comment.
>
> Changes in v3:
>   o Reverted the FIX for AI reported GET_CH_32() issue, as
>     per the recommendation of reviewers, need to create
>     separate patch for it.
>
> Changes in v2:
>   o Fixed the pre-existing bug related to GET_CH_32
>     interchanging the channel direction and id.
>     This bug was not caused by any version of this patch.
>   o Fixed the issue when using for_each_set_bit() for mask
>     of u64 type.
>
> Changes in v1:
>   o On review recommendation of sashiko bot, in the function
>     dw_hdma_v0_core_off(), the loop iterates over registers
>     as per the number of channels enabled and not on total
>     number of channels supported.
>   o Changed mask types to u64 for higher channel counts.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++-----
>  drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
>  drivers/dma/dw-edma/dw-edma-pcie.c    |  8 +++----
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 32 ++++++++++++++++++---------
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>  include/linux/dma/edma.h              | 10 +++++----
>  6 files changed, 48 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..adf1b3939f96 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		irq = &dw->irq[pos];
>
>  		if (chan->dir == EDMA_DIR_WRITE)
> -			irq->wr_mask |= BIT(chan->id);
> +			irq->wr_mask |= BIT_ULL(chan->id);
>  		else
> -			irq->rd_mask |= BIT(chan->id);
> +			irq->rd_mask |= BIT_ULL(chan->id);
>
>  		irq->dw = dw;
>  		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
> @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	struct dw_edma *dw;
>  	u32 wr_alloc = 0;
>  	u32 rd_alloc = 0;
> +	u16 max_wr_cnt;
> +	u16 max_rd_cnt;
>  	int i, err;
>
>  	if (!chip)
> @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>
>  	dw->chip = chip;
>
> -	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
>  		dw_hdma_v0_core_register(dw);
> -	else
> +		max_wr_cnt = HDMA_MAX_WR_CH;
> +		max_rd_cnt = HDMA_MAX_RD_CH;
> +	} else {
>  		dw_edma_v0_core_register(dw);
> +		max_wr_cnt = EDMA_MAX_WR_CH;
> +		max_rd_cnt = EDMA_MAX_RD_CH;
> +	}
>
>  	raw_spin_lock_init(&dw->lock);
>
>  	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
>  			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
>
>  	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
>  			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
>
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>  		return -EINVAL;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 902574b1ba86..d12fefbf3952 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -91,8 +91,8 @@ struct dw_edma_chan {
>
>  struct dw_edma_irq {
>  	struct msi_msg                  msi;
> -	u32				wr_mask;
> -	u32				rd_mask;
> +	u64				wr_mask;
> +	u64				rd_mask;

Can you direct use DECLARE_BITMAP(rd_mask, 64) here?

>  	struct dw_edma			*dw;
>  };
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..79f653da8e0f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
...
>  	}
>  }
>
> @@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	unsigned long total, pos, val;
>  	irqreturn_t ret = IRQ_NONE;
>  	struct dw_edma_chan *chan;
> -	unsigned long off, mask;

after change wr_mask to BITMAP

	mask -> *mask

So needn't change this code if support more channel in future.

Frank

> +	DECLARE_BITMAP(mask, 64);
> +	unsigned long off;
>
>  	if (dir == EDMA_DIR_WRITE) {
>  		total = dw->wr_ch_cnt;
>  		off = 0;
> -		mask = dw_irq->wr_mask;
> +		bitmap_from_u64(mask, dw_irq->wr_mask);
>  	} else {
>  		total = dw->rd_ch_cnt;
>  		off = dw->wr_ch_cnt;
> -		mask = dw_irq->rd_mask;
> +		bitmap_from_u64(mask, dw_irq->rd_mask);
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

