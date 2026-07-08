Return-Path: <dmaengine+bounces-12121-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YyE+I0B3TmpCNQIAu9opvQ
	(envelope-from <dmaengine+bounces-12121-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:13:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C198728867
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:13:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=PBaoe+9i;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12121-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12121-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EE12302E990
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D834C409268;
	Wed,  8 Jul 2026 15:51:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8053783C3;
	Wed,  8 Jul 2026 15:50:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525861; cv=fail; b=F7j+K8diyKadsxl/qMwQwFZf4KpDz4ceB91Xfkm1A1jcNzH0MuNQS+FSYXt7M17y24IJqwz/6NzM4H6J99Zin5GMMDEFaogeQWl3/WxXn17QKUcKn4OZWa0kgZVo67kuGD5se4zMw6Ew2oalr0/M1toNpBQEsW6JPPw/a7PuoU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525861; c=relaxed/simple;
	bh=5YS8hPbSwCa61xJFrYH9sCw9/fgzdSZQeiQM44APL9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJ5s1YhvbdzB8GHoTA4y0P7amAAUcX55mruDZ5vFQxsPrVoZ9m3rL2JibemahfpTLBRH2mm+yZhqqPEOp9Vjt98LIqeRrPsHeREnSBzwcOc+NusXiflwY94CxK9GRbwvGdJGThjjxbtWUgSxT/HN8v6yqkPZZ3mSq71+AC7Na2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PBaoe+9i; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljLKMxy83HS7g5WIUxkepVrT2kuPzeNBMWtPkniZmjy1Rw5ytN/WM7jriZY72evzbRDTqpzr6oxDp3UB1V1UlMz6afYBUPztf9BJ9WQjHfZv8ZPMB3cl7q403t9/q5n/bo5LRTiXcVcGP0TQk/w6DVhT2OFPzJqmAIdjGKqTAIrPifvWx5U9fFRXjOIrwLUiWaHmjNG3PPUOPxccAtyZrKlug0MGgxh1+W01Taf1I2CimEqDXPeEkm9D1u9qsM/wWfKQTvfWfBF5tPiWAjTO8xIzF37dTyc3ktbB91s80Uud3x/2EDiwAjriDfqO2gHt5NqxrhNhwxAdHBHi6/xiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9AsAfJ/15L6a2dM+4m1OFXGP7ystfy4wGzwCM6Gl6s=;
 b=otJ8Vn+an/+VTlSYElNrKx9I4yvrXVLeYvg8OoTApod1hRa2OV74wweDhI7u4raB8mpa8OmmkpHsXLN8cKpVVUyI4Urh900bRiXudg0EWbRCIQ9d82EzVzNdzlqrfslz71PXbWYGv7jIcoT1uykc7ElvQmzeEFvuD7bsBRBx4neD63axmj0YL1fwrQ9XpJX/gRsXA5DrHnt/YPUcVJB3GfG++6kAKoKNw1vyLdK76RGpyfWAeBbph2FfvCJzHe9EppRhPuv8Hjj5nhPl+bVTDbnuDXKUST+IFn0+s4eGJpcPHnBY9GWx25W/C5hhX1O0C+zESu8Mv27/bFm9sSzWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9AsAfJ/15L6a2dM+4m1OFXGP7ystfy4wGzwCM6Gl6s=;
 b=PBaoe+9i7b3xwLaNg+eTSP7cIpzS06Dz7ldg3SYMM9BUsP3XKUZdnqhj/5fGG0/6Ulmgi63+r9Gh3FmvOY+NkuQLjEBYNyIDT7BZOx/sG802LjXD7aiBBxkIL3aglp2ucqCl3OFx/Xcal2CI8lBX1u3WEQW3+sUe13dJoYhF7R8DiB4MAJyrBq0zu9kxmb4zIHDTki5/EE0vZ9hXJR1R3DTkI4ldBCz7QA4hV804tI7FavrIZEtSLQvz6DOxZRsMgCyUaE728XydaZS1OtySS+D2exI9n9UGTLV7Zb//fhW49k3rppOYzs9oK7OEBjl0PqXY5NkL46pdqbotwswxvg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10557.eurprd04.prod.outlook.com (2603:10a6:150:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 15:50:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 15:50:56 +0000
Date: Wed, 8 Jul 2026 11:50:49 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v7] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <ak5x2bk-ECXy9bbH@lizhi-Precision-Tower-5810>
References: <20260708134343.3806759-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708134343.3806759-1-devendra.verma@amd.com>
X-ClientProxiedBy: SA0PR11CA0197.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10557:EE_
X-MS-Office365-Filtering-Correlation-Id: de369ec5-8434-4d75-e740-08dedd08b2b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	etetDMBTHOnhJRqI+JF5kqSWOPsz8D3sXLeBAPVt9cAOZS7RXKJyFu28pznEB0B9rYedQpcfKzH1sp3MpNeVfbkCr2R+MAUGFKg2cRgQPgbIu/ID+NLDh8RbxARbLWyn7jAEPRDyzmWfL50KyQGYNSL9XvJbUR75hR1DKpqXj4PMhu4tIktIJsVHm1uUTBvc36LAAjZEcz0vHcGkJBPX5x19PfrVXotj7JAHVzeDw/umKckQNbplmirnPbBnp4olzCzVQXTqWc9OjhtmSrAgMk3elqomOFoU4+EUzuYmxb1vdfdsGdLljnpR8v4YzdsK1N1p1z5UarAbleFoEGFfSG5dtNEko/w9RUG1V6BsOCFciIIrNlAJgE1JXYQWrtt+tJDsg3nVNXG9CdV7yYFvmog4uLxrfJnF6WU+/EH2p7xicKUxgWqABYSRZhKJPougntxbFZXKTPnEIQ8mVN6Rs4+qSqikZmxo5g4/9+xh77TG2yOCYZ6M722Nyuwb2JRsw8dx9lOFTpBUd7KPS0DerJedW0FvMZtqq6Bu0i3n2i9iIGtMzPMI1t7xsM4AC/dIs0M0jHTSXZ1mya36xi/t27XO8ALp9yubBGKS2EH4XRU/24qoE7DNk2IEZQ+ruiFchJ3o7fEIddME+MC7aGGavKEjXrLNQtfocikr01YBZbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31nNu6X118vqIGnJTGAqAC7dMFzoD5nIQdVuf/gznNHRWZOw9inI1HOuD6JF?=
 =?us-ascii?Q?eDlEHqfbt+ckI5rZtwsC5JIcEjelW8bIKEglYyKhJzlYbo8bMohYrr7wY5b1?=
 =?us-ascii?Q?Zf2aJELgfcFTV7JmZdtkpWNtJZjj6NeLqqoxTsiVkblqGPskFsQvdpuv83BH?=
 =?us-ascii?Q?pgBO/RhbhMiZ3/bfRAi4RwqGG2h5NKu0VWGZTu7Vx1ArbOLEEnF9CDx0AmCN?=
 =?us-ascii?Q?NRNiTxAe1pXertATRUCamDBBCZSgaQpN/ECXRFBUAjCsplkIeRSnZpcOWbkC?=
 =?us-ascii?Q?XAcuvnY6MvalGT5NhsI3CCPoolyJmhRxxYybwTjgw7+31zCAhl84696gkYZO?=
 =?us-ascii?Q?CNAWU4YfarTVyEBf6NuPQ/qqx55HVgcEIVPoY+aZS1OuS554bfCFHX8oRIIH?=
 =?us-ascii?Q?R/rur7kbSr4Y4mPwbtQkHF4i50XmoEMa8Bjd4fUMoDes/Gxj4xJe3JAmpIfp?=
 =?us-ascii?Q?uKUuOcGLbEpFU3DfkP3pG85QcGtSg4yiC3PhGJZMCrqa+1g66f7zYaW2TNz/?=
 =?us-ascii?Q?kRBA4cQQLTA7ogfqWl6MXTuRKYK7AmK8olLf9mWk3C1vInPUCIyt7TMz7POF?=
 =?us-ascii?Q?8vKaQGGcUndaekb4XvR1bIGp9sjKIkNtQInENkOFu7aCAz3aGP24KchyDDQ2?=
 =?us-ascii?Q?uYAoJLdSbjIsNSOdJ0TA22eTzKmvIINSpJLZOfbYoi5qYBKlWVsIKtaVOjPO?=
 =?us-ascii?Q?5MpMsv9cz2oJQPSc8JcLEVT2lL5VAm90SPeig3hQV0uh3OxOJSFsJS8c0QuO?=
 =?us-ascii?Q?KU/uUo9xnuCdk3g78Qh+0v7Rz0tDGf3VBGBgWH2w5NGvczOpgZe3XgJprcyY?=
 =?us-ascii?Q?ckJV8bJ2TwD6TW9Vbs9hiXTNIYr/BE3Ljyiim9ExuRVBby3vSxJ6RV8JScX7?=
 =?us-ascii?Q?LgNzCTOdPh48A/GL1bXgssg1MyW3ULpwj3u7uadRVLEbZDZz417dFWE7vJas?=
 =?us-ascii?Q?gll5bor9AXPCNUrN13sCvLd7yiZ0oD57EE7JUcLFyh6kSGo/BADdeUu08WBt?=
 =?us-ascii?Q?SUp973VT69+zu7bzKrhLibbv/F9JIA99oqkxJTXeeXXsmeDwMxk0vLBW65B2?=
 =?us-ascii?Q?Dl6i9vcPztwEzJncNoDpZT9wOBme1j8jGbl7TrPcdquyOHwlSWdvvObTMA9x?=
 =?us-ascii?Q?DqF6IPw9AIJIipVsAFQEIFfyG+dJnx7yhSd3VA/vialqboisvwtxy5LB7XXE?=
 =?us-ascii?Q?DF9HUqMfJMvOuUV8m2xcqCsOdK+ccLt8ikh+mK2AcXGDdM+jZ1KWFrfmw/+j?=
 =?us-ascii?Q?dgiqAVj6fYFm/b3xKNVhIb0QaWj5cqC2NPakpLgggCLIctIPD43trWZejx88?=
 =?us-ascii?Q?EriZTyvzK6mPDLEo7PTK5AiXq+Ljm7VbiCXBU8YMoJ5p5LQ8RS9osRQTpDT6?=
 =?us-ascii?Q?2VIlS4Y7Ym/7c57eV0TU8NxxHoqmXAp4TgTXMcseJUa+DVaBq6Y96S+R5PtO?=
 =?us-ascii?Q?ZP8UH5lw34Go6NCQttSdhYj/qBw+Kk0UPTgJIut86NjWvdQTIbPsGzty9+zr?=
 =?us-ascii?Q?K4lkoYJDCOKvZ80Kv532T4ywNC1nxNOcCgWMLPQ/LJeIeIc6XkCWIR5O9Ehw?=
 =?us-ascii?Q?R/jwlsPjD5JEkqulE/6cDh2Sk1RI1VR+lbkCYJmZsEnKols7MDmrkZMm10Wu?=
 =?us-ascii?Q?yexu/zHjvZsZnghXF5AGkl6M3Q8YDmA+t5koIXkR8cZn3b9DwfyKUxnz4KRD?=
 =?us-ascii?Q?TmsbB0Ml7LNSK7QhMXPxfWWpVq7+MmYimP2EmnqcF/Q9z4TwDOEYUcycNfGO?=
 =?us-ascii?Q?6OWHfPiWUxG1YQqQfsJAAT1SYMb35y1ewzJ+D4Ok1GmBBFyYsR9a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de369ec5-8434-4d75-e740-08dedd08b2b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:50:56.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nSq0+G4OyyQWntBoW3r+ypZ+haXr0pQAevdlSi7bQYW+ozQmZBAzEds7FUts8viVgh7zA9JMzWj8B4orPOVU3ttPsA3rYZ89sYFGnj1atGkM7DDeqWBUSw858IZRikU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10557
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12121-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C198728867

On Wed, Jul 08, 2026 at 07:13:43PM +0530, Devendra K Verma wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   o In declaring bitmap variables wr/rd_mask, replaced constants
>     with the macros defined for max channel count.
>
> Changes in v5:
>   o Changed the {wr,rd}_mask type to BITMAP type for eDMA/HDMA
>     as per the review comment.
>   o Changed the 'mask' var type to pointer to ul.
>
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
>  drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++++------
>  drivers/dma/dw-edma/dw-edma-core.h    |  5 +++--
>  drivers/dma/dw-edma/dw-edma-pcie.c    |  8 ++++----
>  drivers/dma/dw-edma/dw-edma-v0-core.c |  6 +++---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 27 +++++++++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>  include/linux/dma/edma.h              | 10 ++++++----
>  7 files changed, 49 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..0eb24e707c9c 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		irq = &dw->irq[pos];
>
>  		if (chan->dir == EDMA_DIR_WRITE)
> -			irq->wr_mask |= BIT(chan->id);
> +			bitmap_set(irq->wr_mask, chan->id, 1);
>  		else
> -			irq->rd_mask |= BIT(chan->id);
> +			bitmap_set(irq->rd_mask, chan->id, 1);
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
> index 902574b1ba86..25a6e8a958ad 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -91,9 +91,10 @@ struct dw_edma_chan {
>
>  struct dw_edma_irq {
>  	struct msi_msg                  msi;
> -	u32				wr_mask;
> -	u32				rd_mask;
>  	struct dw_edma			*dw;
> +
> +	DECLARE_BITMAP(wr_mask, HDMA_MAX_WR_CH);
> +	DECLARE_BITMAP(rd_mask, HDMA_MAX_RD_CH);
>  };
>
>  struct dw_edma {
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..79f653da8e0f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -61,11 +61,11 @@ struct dw_edma_pcie_data {
>  	/* eDMA registers location */
>  	struct dw_edma_block		rg;
>  	/* eDMA memory linked list location */
> -	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		ll_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		ll_rd[HDMA_MAX_RD_CH];
>  	/* eDMA memory data location */
> -	struct dw_edma_block		dt_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		dt_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		dt_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		dt_rd[HDMA_MAX_RD_CH];
>  	/* Other */
>  	enum dw_edma_map_format		mf;
>  	u8				irqs;
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 69e8279adec8..3f4e82516d92 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -239,7 +239,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	irqreturn_t ret = IRQ_NONE;
>  	struct dw_edma_chan *chan;
>  	unsigned long off;
> -	u32 mask;
> +	unsigned long *mask;
>
>  	if (dir == EDMA_DIR_WRITE) {
>  		total = dw->wr_ch_cnt;
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
> +
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

