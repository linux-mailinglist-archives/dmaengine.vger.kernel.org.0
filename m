Return-Path: <dmaengine+bounces-11571-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 21r7E+gRMmpwuQUAu9opvQ
	(envelope-from <dmaengine+bounces-11571-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 05:18:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A5696454
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 05:17:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=rcY+UlwK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11571-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11571-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F767301B1C4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75830B501;
	Wed, 17 Jun 2026 03:17:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB12E6CC7;
	Wed, 17 Jun 2026 03:17:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666250; cv=fail; b=hHTrwafW8GDPfuFU2m+gGRvp/cBO/WA5Lb3uqGOvxfM2Rd1d3MC/T0S525OnEq02cJ2S1Ep+K/VyL7G1YQyfZgSd1SU3Iz9gcvYI8AA6uEUCEcQut4741xYI/QRiv4BwQY588GxyEr0DhX/ZIQf/iDOzauvEy/7HtiMhYH1VzsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666250; c=relaxed/simple;
	bh=kwUwtDhGda+B1xocXWsPXTRCZt3vg8o6oXt5VA6vMvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f6TxpdhPcUnT7EksawAJPDH5HOYgBy3PfEkxrWZuya8kPQ0WLz8Dn3eBo/6Hm4COsgRwnrcY8/DSeMtvqxidzC31vlGxrTpoey4SXeT1hMShq5nqZO2pXt3rmgpfhq3Z2hw0DW5Xb0SSIqADalAf3SWMMao+kM8ltmm0i3Fv9nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rcY+UlwK; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbpdBzQSbvtvZQVmZhOuFfoohVxj78THLPebWfzCUmE7t8Jm8T+qk0SU8CV79oyR3cBKcW7z5AlvF8AYmA74ugMWf+l0HbV+ylPn3n0o2KXNc41DtM3U+kHloHvCaTlWxu2a0bwzkB+FLQdosVEy8zYIeTxMrjsClS5GamULi2zwBROQqUZl6Ld67kdCxm45qgsXW3MsqKmTUKJGIvxDBR6LLwRjvfWbrWpQHoLo29jaNZYjPEHc3RZ+QFsCL91be6ROfqrAOzXlZMsYrcvk/Hib0vgYdZZKX4UOtJgUuOIb/wimpliYoz9sP1dh3ocHbTRf8gSbVjKx0jGL8SUniQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd9BDnZ064aBcvMz/v8WfeBS8uXzZjyUMK9Tr3rFy5M=;
 b=ShHSqTb3m9a4yepL9Oc/efdcfuMzv1RtdRyAKGsbFToOXLgBi/vZdqbBtlcWkDEpOW008BbuBFIZ3DOGEgg6Etpanx05vsE8or8e3KD/GPix5kjV4iQzgMbRRH3LuAAja0pCTQEpee1SsvqIoZI+Ugwf197u1WFAv6RDFQffcnEeZ1QSlkoaA4D+6V+F23RkrKD9b1xVvZow/G65OjeITv7gQMfTSmaqusXv00kbk5TL2lRD0dG+tf7qZZOuzQBlKTW4spn0DeH3uhIsG5FPxAAqa3bxj5i7qMRwuoavx3I5HEREIc63hwggkykRjKV2D9aMHS6kGKGVO4GPHgMMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd9BDnZ064aBcvMz/v8WfeBS8uXzZjyUMK9Tr3rFy5M=;
 b=rcY+UlwKNM60hJWBnjjqkI/zJo7WNiNwyHPj4+c+UluJzKtbVJxi8SIvaU6ZopkJhgTsLx9SKIZYKv0vsb17MGWXj8/+hj3Kn8oLV16MxWboY9OMWrgXRxkUho9oASj0VxCKJUcrzcfHxwn9UAEk0ED2glkL0oX1YZB83I9rnL8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2518.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 03:17:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 03:17:25 +0000
Date: Wed, 17 Jun 2026 12:17:23 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: Frank.Li@kernel.org, bhelgaas@google.com, mani@kernel.org, 
	vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v15 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <zhpsuwq5agslelgebbtvrg4uks4xweov7ywhmkxdngq7lzajip@e4umiii6kzko>
References: <20260318070403.1634706-1-devendra.verma@amd.com>
 <20260318070403.1634706-3-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318070403.1634706-3-devendra.verma@amd.com>
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2518:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc2a569-43f9-4d16-4300-08decc1ef3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|10070799003|1800799024|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mRNTeZ64sxkVjHBnfl4qMTiAdhk0qy1bGL3eTKUvYLKXnjSuWkG2RES+mV9yXWzDbM+C9wvpkTkCOZV+8Fi0c+b9alUHaAyMWDqzB3DbNynEzi0BgH0tzrupBMJ1gAwE5wY/2xcfH231mPchOq5VE40HIz8DzI7sDTt53m1R7Sn6xrUEHsf6A10pISYAl3dyQjji2hWCrn1rBbigQZUDkTfDAt63nL5AQ5cZrrrEvzQwJmIIZDuTsZX+ZDzG+t6se3PYbWrc+/wslSddVqlCXO2zJir+l4Wlnf96iwd525U9GDc7CsKLLFYEMyPt2t4PJH0dhpJ+64M5s5q14lDIECic1dZ2G5r1ShgLFqRK+gkpfS+6ouz9WuAooyITNF7+vvd9eVn1/H9KE+xS53ekVrNqJi49Nan5xliUB1jjwUQFb0N/Mt4nKNzbBcUIYRKAEsU/gDhsBsi/uHEWDpcDEVqPjoB9bj7P/rOstXImPJx+Bx2myhHikvIV+vzCdN6jqf3jlD1XDeblWJ/Lojty+UBBqvCEaqnbbNlcqL8ur+NKVUkdBxRbPtk41qJy072xfXfwH6u117SAlTrOi68CuHYiQ8AokkBDhkzZNx2EQcJgLd3AgUXFE4Px3WEbKvZFVd8peU5SWh9bRlvpkKPqU8zPSHF2xPP+i4hCKr6xCjm1fdEBLmKQqpUk9aHwhLpFnEUQaB+45h30eE78pV48fA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(10070799003)(1800799024)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pzh6Ybe4bzH6mBILuTJQgh5cb8ZC1OBTaHRDBup7QEe9vnZ4uoZUFNK5wYdu?=
 =?us-ascii?Q?S4Gjv0mvcPIbSbYsRcFktSMulV+GBy4lMBZn5NiOEdAxw5QIVSAgG6hplJHd?=
 =?us-ascii?Q?enki+2naCv8/LnpC2ffgtUruLrF3aiAjwfnn+KrCGVDqHfY8Aa0IVtZIVjFp?=
 =?us-ascii?Q?IQkxixRltoODFlttTukN0iepL0I8KkR+YRNK37NWR5ruazXgHbjsjByAvKdw?=
 =?us-ascii?Q?x9K/niVe5904Yb2mVo8umYPx5ZYqStJ/HSGpniD4ilw90L+kIfPf8WlET0+3?=
 =?us-ascii?Q?2mBRCB+7XvbYdmM8olmK66Evco750dG6Bj0e5bRomvgHwm0OAIrlN3jfUFih?=
 =?us-ascii?Q?yx7FU9HowyJabYOnAyH5ApM4ug1OBmsJDt4OwKzcAoG9DzsyHxzuU35JODCS?=
 =?us-ascii?Q?Vkq3SxVBqKCs1TD5DrFBVF27Gkmvahd/7wlbRPCaqT3jznLl86MMNEl+c3aL?=
 =?us-ascii?Q?DugT2IYD0OC06NZv5DnIESEe22P8ncWe9p6DukhYjJeozMaOUEfYcI/npugj?=
 =?us-ascii?Q?zLIh3epkJgo4KbIt8VbYuViSK42FSWlQBheyk6Kz19YUFAPwQ8I8lSBWfUpI?=
 =?us-ascii?Q?U5o6VifD/L+leKzfIZ2guwZy0Qq37vrTe/9EnGLndI8agIVmTGVyDmKwezz5?=
 =?us-ascii?Q?MpApHAuS5WHJgxDdlABi0UVBtenwkYAj1F6Ivf0WUMdzbku4+FzXsb3q0UW/?=
 =?us-ascii?Q?dHmNCJRPuIfTxwHiU7velBiSGciBdkFdKb2tIMIIvSuVwOqoVZLav37nnW79?=
 =?us-ascii?Q?FVd7HB0P2GqXHuK61COzbf7O96elbuxMZWoSujAC/OmxYaIvGH6/legpL39R?=
 =?us-ascii?Q?KDKQGglgMzFu8q00Sk/xUdQ37rdNu2pVt7oHrrhOYUoT6OLo9nDTv2eccqx2?=
 =?us-ascii?Q?IyidIoioK+r/X8kL1YIwozIVdZ9y79WJPvbhO7L2N6H39aC2MDNEQlfG0FYk?=
 =?us-ascii?Q?+qy4luwjSyRPQ0hOuPzhDXX1T+F51E3ysuTLmeMnn56Bb5JBakLk9kNUgN8R?=
 =?us-ascii?Q?XYrTYbFW6CdOpPq17twq0Zst1sgazkE12FedhvSuZk+FP6EPlsQQVLT7i0qa?=
 =?us-ascii?Q?sD72UVrBXHI6ol0hCqvuQosv5dMotbDVIsoqAcnJxb3GyGgGVyXjpcKwuMJC?=
 =?us-ascii?Q?A+Um39SHbm/JpjeppW0LpTj6vEgLqY+C+FE5y48atFpYW2ENVbhFd0/thBzP?=
 =?us-ascii?Q?22p1XEiZ5yejJSPtSSY61lqRDdTYYltw8oAQRqhtS//D8ebe/Suikd9zpvOH?=
 =?us-ascii?Q?IiX1JwFeDBY4NKvtQnuabjViEwIAO2r672iWI4HhYJfo0sl2kY8oyP5RF+Mw?=
 =?us-ascii?Q?4Td4Uad4SeuGEjSUfUOxHF8idpZ/aCOLNASVWWMxXQz4B3tdbezXOufK3v5b?=
 =?us-ascii?Q?BwM0P2SM7WbLrzIpC7zlCmln6yo7XC3PMlwwAgo8sFhEZXru9MzzGprCt7V+?=
 =?us-ascii?Q?QPadk+9LWJ74oM1OrZzaEpydVmeCbV44/2I4eOK59lK4uVBQXZ9rufwWTUjE?=
 =?us-ascii?Q?cPiwwj7s9bVShH5hofyGHC3Wal4eeWR4WPcVPG/9dY7hvmYahmfwn8ECb3qs?=
 =?us-ascii?Q?fmJXbfBMA0sEt6x/uVB7tO9f9qPwYtMCVGnCaeIE/sGicmSg93Xpc6LtHgEi?=
 =?us-ascii?Q?qBnGEMYbL6wfhab4ibXpm2b6Ux2GDEU+CDnfRHczeRs1IFQHHalEI3l076jc?=
 =?us-ascii?Q?9gpjX/nxOZkONX5Wdta+vlCmrfVCKj0C0Icg+AMIa+ChQtSY8UyuQqRIMAYE?=
 =?us-ascii?Q?1G61BsUDgMaOwC6VeDwUCk5SfAnuKJo5r0/mO2drKpqLMOZw37VZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc2a569-43f9-4d16-4300-08decc1ef3fa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 03:17:24.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS7JBJADGgvDW0zqLxKPi10mBzls9jbtWs6IJL2fYak8CPm/Ur66u6NSm3SSbZIioML7gMudZZ66tiV3RIrhcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2518
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11571-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:email,nxp.com:email,e4umiii6kzko:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B1A5696454

On Wed, Mar 18, 2026 at 12:34:03PM +0530, Devendra K Verma wrote:
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - For the AMD (Xilinx) only, when a valid physical base address of
>   the device side DDR is not configured, then the IP can still be
>   used in non-LL mode. For all the channels DMA transactions will
>   be using the non-LL mode only. This, the default non-LL mode,
>   is not applicable for Synopsys IP with the current code addition.
> 
> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>   and if user wants to use non-LL mode then user can do so via
>   configuring the peripheral_config param of dma_slave_config.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v15
>    Rebased the branch
> 
[snip]
> +
> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +
> +	if (chan->non_ll)

Hi Devendra (cc: Frank),

Sorry for dropping a comment now that this has already landed.

I'm wondering about the lifetime of chan->non_ll. This patch lets a client
select non-LL mode through dma_slave_config.peripheral_config for a transfer,
but the state is stored on the channel.

We use chan->non_ll in prep to choose bursts_max, then read it again later in
dw_hdma_v0_core_start() to choose the LL vs non-LL start path. If the channel is
reconfigured between prep and start, or before a later chunk is started from the
interrupt path, couldn't we start a descriptor in a different mode from the one
it was prepared for?

(Note: Frank's not-yet-merged dma_prep_config v7 series [1] also looks at
potential races around config+prep on the same channel from multiple process
contexts, as I understand it. But this seems like a separate issue, since the
state is read again at transfer start time.)

Should non_ll be snapshotted into the descriptor/chunk, maybe as
dw_edma_desc.non_ll, or is the rule that clients must not reconfigure the
channel while anything is pending/running?

Or was this already discussed, and there is some implicit restriction that
clients must not mix LL and temporary non-LL requests from multiple contexts on
the same channel?

[1] https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/

Thanks,
Koichiro

> +		dw_hdma_v0_core_non_ll_start(chunk);
> +	else
> +		dw_hdma_v0_core_ll_start(chunk, first);
> +}
> +
>  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index eab5fd7177e5..7759ba9b4850 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -12,6 +12,7 @@
>  #include <linux/dmaengine.h>
>  
>  #define HDMA_V0_MAX_NR_CH			8
> +#define HDMA_V0_CH_EN				BIT(0)
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 270b5458aecf..61d6064fcfed 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -97,6 +97,7 @@ struct dw_edma_chip {
>  	enum dw_edma_map_format	mf;
>  
>  	struct dw_edma		*dw;
> +	bool			cfg_non_ll;
>  };
>  
>  /* Export to the platform drivers */
> -- 
> 2.43.0
> 

