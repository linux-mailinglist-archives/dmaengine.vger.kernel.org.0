Return-Path: <dmaengine+bounces-11299-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kkHZMoScJmoAZwIAu9opvQ
	(envelope-from <dmaengine+bounces-11299-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:42:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4866553E0
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:42:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=uGbJI3Nb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11299-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11299-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBC55302E3E5
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0038E8D8;
	Mon,  8 Jun 2026 10:30:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20C385D61;
	Mon,  8 Jun 2026 10:30:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914640; cv=fail; b=tKm3VjayGv8ggonFkdnxgOxMXPVKPlo9B/SOrfQrFgsbihIoy9eNS2aogu9ffqJ6pjBljGlG+xgobYjVEoPPK5tR4su0P2VkI8F8mhfYoFJbRTD1RPi5S9G0I9u9iUgE/sjJHe4JodrC9Zx8xjBfWyWsOREzVkdH+LArP6qNaw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914640; c=relaxed/simple;
	bh=Ke9hnYbiU6w8+jBVLcU4mOwvCUNhXjLLQPWov04YErQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imX9G6tR2mMNAz1FS45sHCW1eQRZUJN1IAGKp10LBPbRAtSVcDNq/SpGcD3ryyGszNeEQ6S7T0BRQ+ZhgUCa5UYWwAO1WAadhkruYk2WyijnSu8t4KB38XBk/WQZDJCls5QAPXWLUoJ1lc7pBVKOHJtHs3Y9bJqK5sQJ/hyhXrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGbJI3Nb; arc=fail smtp.client-ip=52.101.57.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vywTyJPYmbJPBv11xVdjKnhHOjV7FLyrFgvdD31q0VM2zg6VcYMBaSXBNv4YfvhuNg1jC3sSy7i9JxO5MF4taA8m854K7r/LzpwBrjSP2MbFjxQQIoOljZar096+d4YYeF8RzrRTTISEAgVgiJPIJRa0RXdoBixeD6GqPvMCgrLWFUDqwP7Cu2+IfEk0ujQpvxfjQyVGgkNMmFQ5P2/WP/1otq/JgmollPApROcbByWqP78bDxDG8nsiwVU6aSWhBXsm0v2WYFSja799clS7XYQdAZOlUClVaEXx82urYx6AW10Zzxj3xCRDIOuVJJNbEeYSdekd+G5Qrt796nW+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KADHZkXJeKMEfv/yUQGL5jl3pVee8bEJ2VTCyYK3huo=;
 b=h0M4EtPBI9zluY1UpdGC8dFwnTyUxHP8zpPodxXC/9wNfg9UKlO+oA56D5lpND0fGUfGwC4NurENj8aWTUyp35/FQpZDjvxaFTn15QbHWtGLiG7rlNLxPM2fxGfC8KUe0pmfpwoSPVBtfisBLj83r/FReUWUJ0dFNM/xUtSxzMS87ga1JawXZuII7n/OeMp1TsNruFRJkZZcKnjTJ8+tn2uGglBX/82qmlnzqv0B/xYUSSK4eb/gcE9wptzI0gjXjlvemI0xzgxMGKO279TEEyhe6WpJfPeuIBI/bHvlV1htSutZFYbpWPjSJ5tzJv1JQ4z/xi1d8iqsCEzXXaP1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KADHZkXJeKMEfv/yUQGL5jl3pVee8bEJ2VTCyYK3huo=;
 b=uGbJI3Nb4jfdWjWOCZ3El/ZGZSg4hhUajJv4RLuf0137Y0a85K9jlDOE6kk/0ZBSLlQ5mOYb7IAX77nDBL4JQbQEIVu9QLq4mWqfnuuLjBcsK3VmhuCbRMPvXbdhRXnzbhJLk7dA192TVh1YgimuTzZFIWz7mg4yWRwJd4BuL1xemRIdpvREz3DOAuotCe8WU9xBRyhXVMzNAS87SMY6TaLABZvUThNerwfeA3kITJ8xRtdi6ezV6y+eXGf7gGh+tx1HeI/xi42hmBRuCeX9L5ufKdqvDpOiySOBIZvzcGK0jY0pavQ9X54H0pIvojaPd8i0onsJ0Afxngyk4vjMng==
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 10:30:36 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 10:30:36 +0000
Message-ID: <b88d0255-2089-49ad-bde6-5ee945ff4f10@nvidia.com>
Date: Mon, 8 Jun 2026 11:30:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] dmaengine: tegra210-adma: use
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260608045324.4980-1-rosenp@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260608045324.4980-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 29cf64a4-8454-472c-8cbf-08dec548fa52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/xmkksingRTnIfH0XABOQIE5JwRA8FxIenJ4QxJa3gvdZCJAh3whd9Q2etK3vKBgMkwb3GAYAJmhas/fkow+bKGbmd2ZUAAbsuFfzvhRKRynL0kzxEUflLgGPA0vVYqPUEiaFk1UJB+xBNAYulMAM2NsdfHG1GjsvRz/3Y4h9l/qmT6TSS+rWyWuu23AsqeVcF2HiK/u4dQWQA7SLMl3ubu60uNvYTJhSOGR+LrZ4nd9FmgpAVvIFF/CGHyfsXIQ9jmMFdcwQWJfDjXllcF4xJ5cjJJSR5SeXRtQiypAC20XIgssfmTnEC0sIZXkTireSkQpZUVTA5daxYShplFpsfAdUkK3t9nM28QZSZdg6XYEgzNGtxauMrSsmPJW/s/FpEi+lUHSBEaXgpDtzjq5PqoInbXypI+zY6KFTb6sZC/v0ixowv5Ra3zfL7wzqZM1lH0h2xMDb0GH0r19aZ0T7C135fkpmKH7+5GQ2cKzw0gOCZYnqjk/wYYfLYJFi+o1JCUT1BZptGdM0kr+8U53yxGTaZv8Ek7wLO8Up6h5Q0CcIhpnGesFgGzMwwYRAVuU2o610dhbyo5kAHfpCH2Jvr8NHleyRW2Jki5xt06Jdo5eoJwpgvfO9xmN5bH4EtQKVL7QW9TjXwVbKhoJeHTCyRauC4dJrbvut2WVRRc9hZn01A6bQTOkFu4A9x/GrV/iCq4q/NRLUA3SZDafjeMogA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEFsU0J5TUxpY1VrQ2JlaWdHRXNnZGNTeVF1bUpYenBkUXMxT3JXWDJXYmtH?=
 =?utf-8?B?MWd5RmlYSElPL0lwNHZVZUZvdnN1bU1NY3AwUytNNFdHRmNReVo1NCtyZXB0?=
 =?utf-8?B?SEE5UWpvZGdYa2RmVElPeDQ3VmRSQ3hDMjV5UWU3MklndHd5Qk45UjNZd1VJ?=
 =?utf-8?B?ZU5qQXVFSTZORVd6L2RJLzgrelJoY09xd1JMelJib0g3NS9uWFVLZXNPSm1G?=
 =?utf-8?B?Z0M0ZjV3OVZXcGRmWENkSzc2TkorYkpRandyVWJhL3Zqd1ZXWUdDcDEvcFBD?=
 =?utf-8?B?YjVDelpCVzJTNVNNZ00vSmExK3I1cCtBdTZXRzZhYmRQOG9EUU9LVkRWbzBU?=
 =?utf-8?B?djRMdU1QTkYxWUtubVV0bTdVSkwwSGpCOWxoWUYvaEh6S0QvNGd5WFBqTTVN?=
 =?utf-8?B?MXNMeWxUYW9QbGNLSUt6SUVoSG5IUkJzSG9qU3JKRWdsdnYrYUwzNmwreTd5?=
 =?utf-8?B?T3BJNThpSWlXUzZkQys5WkpmSXVXVXNYTGVLMUtWc2tZa3VwQXJtQ0dTUjJX?=
 =?utf-8?B?R1JKTVdqSHBSZUZMbEd0YjZYekVZRUZQMXJROTVvOEZTYzBIS0ppVk1tU3ZU?=
 =?utf-8?B?OWVndGQ4ZXZYWEJlMmE2MGlUKytGcTNveVROS3dXa2pSa2ZmRjlBVGVOdWt0?=
 =?utf-8?B?RW9wL0ZXdHVuRGh5aWFpaFR3OTlFL0JQOVh2bzduc2dBaERXNUJOUDZkcC9q?=
 =?utf-8?B?MUhWMlJyWDdPd083UjNvWkVaZWp2REEyWlJ5UDF3YkxnTXc3NXBEZy9DbWVE?=
 =?utf-8?B?aDhFeUpNQWl2R01CTzBjZlVBT1Iyam1zcEZIYityS0pjemJScGdKVnRVd2ho?=
 =?utf-8?B?UGw3MlZERmRYLy9xalkwaEoya1hJbVNsRytFSVdrSHNiaUpmWFF2WUxIZW1G?=
 =?utf-8?B?bkpJdnpwZmkxOXhRN3ZpL1Z2bXU0Z3Nlc2pMazU5RmNmOWRhQS9yeDdvWnE3?=
 =?utf-8?B?blU5a0syYjBKNmNNZklZYWdrSlk2TVJRVVFVMSsxOUVKcHFFbDVGK2dUZUxa?=
 =?utf-8?B?dCtOSVEzelM3VUJqc3pKdlM5K1hMejJsMjlSZkdsZXdHNHo0dUxUOWZ2N1Ji?=
 =?utf-8?B?bEdHY0h0Q0h0UUtMUXFUNzIwdWZiVnNKUno5cmRmK1VHUWxNeTZwbE9jMzBF?=
 =?utf-8?B?QWZ2T29uaGNwazkrUExTUTNTeS9hT2dIZUozOFdwREphQ2R2VXZaZXh4anlY?=
 =?utf-8?B?dTdQaUh1eVJmd255b25lbTlpdWNJVU1xTjBjR1dtMDUySWxrUEJ3ajR5ZzdR?=
 =?utf-8?B?QlU3NUFvRUdOd1F3NEpCQ09zemZnU0FFajg1cnJWd2NVc1FtcHIrQ1J6WEcz?=
 =?utf-8?B?TUV2QzN6bWNrV0RFRXBTK1FQSDZSQzZnQ1FlSjlrRkJYSURiMGNMOWtWRWJX?=
 =?utf-8?B?Vk5OMmJyc3hNOHVodWlLcGdOaWtLenZtRnlJNzRSR2FZNEtONEppSkJrRS94?=
 =?utf-8?B?djZNTUJnWWYwZmprOGpJSnRaWVNMb0puSC91QmJ2bzFKdjNOUkdHem5CbWFi?=
 =?utf-8?B?Y1JtbXhvdERyVDB2Mk9DbFZrbG82S1FIeXBWS2RpRGtRbGVjQitubDVVS3Bs?=
 =?utf-8?B?anFEOEdBSjdqLzQ4TjVVUzV0Mmx1bWV5SVptU1p6QTZPenNMbHNPK3FtU2Jp?=
 =?utf-8?B?RWZZNXBhNEh4Mnp6eVNSYUJhMmJGWmdkY1MxYlhPUERsMTR6L0FtbGdSMXBu?=
 =?utf-8?B?SGs0bTZ4T0FXc3VrNjhCenhEb0FsNStsRXZ1OTUwRWltQ1lLVEhtZEVXSWFZ?=
 =?utf-8?B?ekt5S240N1c0c1JaN1FpbGJtQ1hsaVZFYi9YeUo4aEVmL2p0blZ3bjl6a21P?=
 =?utf-8?B?Y3llbk5uSm1ndnplTzRQRTBaNjdOcFpFSVh5TEkxOHB5dWFTTDQ4YldnVkwz?=
 =?utf-8?B?c0lEMEVaSVY1eVVCVzlRK3RDem9pbUtqdmNzMnpzK3RxclZnbTVBczBvS25j?=
 =?utf-8?B?cm5rQjJKWkpnTjdQWGQzaFh0Nlg0QjJJNC9kVkE3VHFka0pjTDhBUnZFYUhm?=
 =?utf-8?B?VkRwV0x2Vk51QTdDajZBSHlWaU5iWTU2TlNoL2M3UGJYbXo3bFBocm04WUo1?=
 =?utf-8?B?bHE4T2h5blUwTHhDYjJvTXJRMjA5VlhrSVA3ZXF4TzJzR3UyenhZam9GK1g0?=
 =?utf-8?B?cnQ4aXRwRFQ5djdRZllCVlpGOUptQ0NYSXg2OHRSZUVCK3BDR2lFaFU4N1Iv?=
 =?utf-8?B?aStPRHhDRkd6aWRWS0srMFN4R2RIdnk3Tm83WUltaVF4bjh2dDNnbG5QTHhn?=
 =?utf-8?B?RnlsOXdPZERxOW5pYTBTMFZWZjV6TGNpVEVUTm9sWmR1SzlvMVZvSFZWUmZL?=
 =?utf-8?B?RCtvSHQ3ZUlHK3JQbUswSGJ1bG4rOFZNdjlzMHNzcFpsZVMrbUoxZXF6ajh3?=
 =?utf-8?Q?NQSOGRM81nLccCD0GKeBr+lnB5aAfi1K+OAqnrckHhnPU?=
X-MS-Exchange-AntiSpam-MessageData-1: bU1DJN74PWNaUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cf64a4-8454-472c-8cbf-08dec548fa52
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:30:36.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qcmmsi5mJy2uljFwkjgUZVFALGUPUdR+Q5uaHuPXMk/OamfMLrzj70KSYyZb5K8cpLAy9h0qntqXzvn3HHu5kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11299-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:ldewangan@nvidia.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED4866553E0



On 08/06/2026 05:53, Rosen Penev wrote:
> Simpler to call the proper function.

The existing functions are also proper, this is just a simplification.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v3: change subject

Subject looks incorrect.

>   v2: reword commit message
>   drivers/dma/tegra210-adma.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 14e0c408ed1e..be2ad6e28618 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -1073,14 +1073,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   		}
>   	} else {
>   		/* If no 'page' property found, then reg DT binding would be legacy */
> -		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (res_base) {
> -			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> -				return PTR_ERR(tdma->base_addr);
> -		} else {
> -			return -ENODEV;
> -		}
> +		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(tdma->base_addr))
> +			return PTR_ERR(tdma->base_addr);

This no longer applies cleanly on top of Sheetal's change [0] and so 
will need to be rebased.

Jon

[0] 
https://lore.kernel.org/linux-tegra/20260512092508.1406119-1-sheetal@nvidia.com/

-- 
nvpublic


