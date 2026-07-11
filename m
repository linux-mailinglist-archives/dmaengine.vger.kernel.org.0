Return-Path: <dmaengine+bounces-12350-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/OHD/hWUmoqOgMAu9opvQ
	(envelope-from <dmaengine+bounces-12350-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:45:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81234741D1A
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 16:45:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=kNBuwyso;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12350-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12350-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A738300DF62
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jul 2026 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65C28850E;
	Sat, 11 Jul 2026 14:45:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F72D9EFF;
	Sat, 11 Jul 2026 14:45:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783781109; cv=fail; b=rv1VtaETex7qjZVi2EkBFZtzzOYeG9gGHhjuXuc35QGblR1n7MNY6LnxTkqbFZi5WznfeVeZofbqVKgzSx9PA6perp623qvo/XFU/TrnDyLwIYi0+oo3Bb0zHsxA6o5Y0dc+3xQn9L1ynRic2YulREKpsHDDHTYVhBVr2wjDhuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783781109; c=relaxed/simple;
	bh=cVotlYg08HyuVeJK35z/uf/OJ6Jl8mS+DPTxpdnZR+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZiBvqHhq2VbjlNP7aRyeVo2Yto5mw4xrs2zVuRmsUhG2B/VtUGv5srXpmZOtW5ILALDajOibKyDIYc+OO20r1BzcjSKcnnJ6p/PfyY2eTL9f0aRTWE5EZwqLt5f4KgcxHZhJQ9WQyO6dC09/ue6enuRAft8GeykNVd7wBGMSyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kNBuwyso; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKgQh4fEgZMyOD9JpoahBwu2HSN9Q7mPbDD0DoCknClyN8aXee8mqq8I3wymzLx/954KhFZ8e9DbIU7FhkOgbV0sAFK9gr49VG5IIBK5AKLQMkaUws8ioBKH0WAH4MA1NI9Os6sjbt+8iyfbzlf3pK8L/QnejLmTRrXkUbWoC25fmkiDiqeXCV8xIY0DryQ20f3frJ7Qo/mBKHwRSIIQB/xOR/9xaiXoCDpKLb4bLLqz6kKpmcs3o//PZrgxKiHoYDMf4dfRpdxi0vBmm5Iq8X6zX23PSYZByMRxd1EuhVL0Tyw0EMUR9lr2QnZ0oC4Pyx9DZLieUIhHoWp3AUbUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5hX5JqbQFctyXBy0oMPmEuedrRU+NcbkvekAAaE2Iw=;
 b=f5zUuAC1N3S/WGXIosZPN1g4IxFcCmOplPcJXdPMH5fhXMfnzCQ4DIEv45l2PRJZ5TXkp0VSzFig0DLgcRmXiHKa14CuK3bJbfUiQFDpqBaBotE1hPV1whhWRvqBYEjiTnSJ+l8PW4pzaVDfRP8l5x6BMIJqlilFjGLxZZa/tH/zIQIH3qiVRzqAysvvsAP8DETk5XSsh+YNXd3UglV6NH3b/CMz/ffd9QAP25nW8D0pCu2bCrcoTVS1LsMAjNFLcWTFoZKHmQ72HfADQ+tlKfUPm8DyRox7ILIDIa1/GMydXIg3nxmH8VWE/fncN/VgFZIhDjNUEqOKpnqh+eLpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5hX5JqbQFctyXBy0oMPmEuedrRU+NcbkvekAAaE2Iw=;
 b=kNBuwysoK7nJwzGz/fmx/7CrxLkdIuxWzIwgNGenEIGCipwxq2/DoSlaLqW6z8kGQrvR79DtR4TYT5t9OqUeLjFm+mf9a7pBJSrZQ3iv96gbrGojzzMyQ7UeTKIfjEA12zdSzRgtYLxoddnNaHWqdNROnraVn1Ico5nX3l8vQ7EC1rONMyIsO2Vd4r7+ELosw4jnQarig9HQchBX5QpTqomC4STTnt6dUJrN/DUVzLeaBF48YXWqR9ynle+0d+AwdB3muz4SDB6L0r90GAy2MqWrZm5V2f3E8JGXIthEafVF+04qne6xqCKXCaaVC226rnERIxn0ePb4LjAYTICAcQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sat, 11 Jul
 2026 14:45:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Sat, 11 Jul 2026
 14:45:03 +0000
Date: Sat, 11 Jul 2026 09:44:54 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dmaengine: dw-edma: Snapshot the v0 interrupt status
 once per handler pass
Message-ID: <alJW5hjfWklqPgzf@SMW015318>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080903.2392888-7-den@valinux.co.jp>
X-ClientProxiedBy: SA9PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:21::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d8f93c-c2b1-46bd-7caa-08dedf5afdfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	h1oM//A/Q+cQtNjXe7MtGNF0eQl9Voi47lF5nGmxuyLEMpvewdZqdJwrGzTHOrXv/MSHb641+pi9hXFc5yoeh0WAxdWbu2uGqHJj6EHTR16jyWk0dFXMgPjN57g/RXFF3M53w+GBF3l/aTctkYAo90L7o31au0ymW+gopSc7PyOvz4hhEikpzqtLq6GbxL27LyGzDc6emZgjzYseXL3rjihxjFWC0tV9UwrJ/9X5Uzhwla+uI6Px1hzC4EjZoPCv+5E+Nfk12d3zY+/g1YG3/Gh1g+Y5R+gbguNG+O2lvy8MJcxX3i6k4qbmdSzHun+TF1Bc9Yaca2p+FATR0jFAJ/gwaXSmeJHPEhRC/T1ZqvbZBIimYsEbKuikPeZK3XD2dFDGp5yWc0/hqabciBtx36lrj507O48T3W8wVDOsuJVa/ePTTt/zf4TGpi7JznPsCU6k0+g/6NW8+Du4krPBqceKnGAPIeZamtPOj/t4z9Vik2EHeaxEgyelDkClyjc6ViajZSlo5/223PP+4HNw+Z03o1sw3NBeQC5laZz2Uu4splrzB5e3XuDk9lT9DoV2l12djcDmCnn9d1aBvQepEjG0gP64HmxuwviVpBhmLftntjX8iAMoy4UH9rS1nAU1Z5aQ0cctyNOGr9UyBLlq1GXysnmTbXleL9r7EI654DI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1SI6xCX4voaLBrThmQ3gKRTpW1JIDSCgz/RywIH/qAd7Jg62Qx3GI/N6MLBB?=
 =?us-ascii?Q?X/WO7yhKO6Hd/HeYfKvieArWqQTwDX73wBBC3NWSG9mjpa5Ba8fCheGbyqBv?=
 =?us-ascii?Q?bE4V+L1vXy2kldHGCw9jkNO7ntlpfnljmZnXqL8AQbfcZfyZyNWZyKoSi1xp?=
 =?us-ascii?Q?5FsjL4KulhC2sI31B2hsMLUfeOltAhkxKDNx+2+cygisjGFCIf/6gioAPHIX?=
 =?us-ascii?Q?AM00Wpqwq0KK+boDp/CdtvIj6E1S3Yw6i6GMEzbik1VPAZ4bMtDz8a74p142?=
 =?us-ascii?Q?1LzB1Z0+X2Emg8LWbk4Wu4SdjYQt3cyvuopGYn7tcJLJZljLQjQuRFH+EFfE?=
 =?us-ascii?Q?seo8kJzvXxB89g3dmPbQAuZ9+Vd0R4KplLAYyPE61oR5CQktNtAvRBSFJVzL?=
 =?us-ascii?Q?mip1H15AMjHjFBpGhu/1Fz+k6lbtFkc/T5s+cKMlqdiuoTPDBan7qfU621al?=
 =?us-ascii?Q?NtmLNtoVTmiIlF+0L0yBIG52uMYDjVkIM9JOSeyzz0LsZDYRT09yZk7DlsVg?=
 =?us-ascii?Q?Nzw7QkLwoyAgHVxF8PJly84p2535lpUL/m5Rv27C1DYOCTEuwesk0nprMWk2?=
 =?us-ascii?Q?VD70LSu8YvTfCPmXSiY0JubqwO4NjbtykZudChYU/sQuIVg4ikgelkTofQnF?=
 =?us-ascii?Q?B0Y2sx7l87z5TimT10Ao2VerqX9I4Olaauv8sJntZxvc7+ITSSldjBF2BrpN?=
 =?us-ascii?Q?8kg5WVOmZv8DOTVmjGPkMu/r/7QDUia043eZ6/mNB3iI6kTE0qi6y8cuYvBs?=
 =?us-ascii?Q?hqBLka1gc571aiVWdii7S6QVthVi53JW10gJlJ9ZE3isdjaORMIt0+8FQYHc?=
 =?us-ascii?Q?TVVnhhhWTv9hiJPHNLGr/iLNjME5Mu0i+BkwOQSrKn57bcqDTELCW3yq/8L+?=
 =?us-ascii?Q?qa6fV3YkudWAVB7jsve41COAkhJYdS5trsBVvjJ7nKu0Gw/a4OKzTSkNvbXa?=
 =?us-ascii?Q?JW9FMx9bv1mQh70O5magMvgpoEbxygk6e0P60qVqLJGnWdJ+DR70IWUPFmUa?=
 =?us-ascii?Q?r+27k/nkSlWK/NU0qh5SXJaftEiz5GLgKlB33SVOxe/EW6u9v+rlzPL9JDsQ?=
 =?us-ascii?Q?qsdSYTsTGGVo0CfEJgdpNo9qI+hRIInWgfq+x1JAc1N/bBdOST3Ctq7uBrFZ?=
 =?us-ascii?Q?LLCx7OdJ/eQDU4YYaVbNlhWVToskEUXrxw32S0E08t7eGA8L4YKCWJpZ9HzT?=
 =?us-ascii?Q?Y1LdKzLearXak9WP+zjzCB2Un4GZR72h6By/FyXXpFnwM51vVCELOTTUG1PU?=
 =?us-ascii?Q?RvtJK+WyLHeft0k6X079b6fDhMGqXJhnuXcj4U+5f8Rqwh88CkF08As/50Sr?=
 =?us-ascii?Q?D0bUwzhmkp3pLedHgWrM6I9ddwi1WTFE8axTfPdeHYCcSBT3wxkvq/OLcW48?=
 =?us-ascii?Q?CChOIogrcNjb/GkAsWY7C/nbV1z/R/N69NuSK3tLoKlfJkukg6B+GW+rQ+Ep?=
 =?us-ascii?Q?6uMOZTi6YdnDU+cGvqEb5g2h8314HH9pV5/KnFRR04nt8/AseLEIFzEjRc6N?=
 =?us-ascii?Q?0E7kwvKnv34ajhFjCqbm4WlGzCOjfD8IdYx4bJQnPc5ENMEftSenrHP+1CA2?=
 =?us-ascii?Q?636s10l3ZyNBmqKIFIUl52RJXI3z8pwlRwpFNT7Gl16dAIzMU5PWME3AcfwX?=
 =?us-ascii?Q?ptBuFCSrYHe8dZCBy6L9CWvxN+sLCalW3QhjXhIjH12XIqxKNkhl87cnZMoQ?=
 =?us-ascii?Q?qY1Q2TTvqYcQgOOWb8s/gCVYEdSoQ9P7I5E0RaVIP5fMgBPRsmvsTlmpLuVM?=
 =?us-ascii?Q?gpk7tvAwzMgsNknhi3Onu62KiaqTgabiVOwi3QsM49TRjZVXaX7d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d8f93c-c2b1-46bd-7caa-08dedf5afdfd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 14:45:03.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvDZLjPN8Al7yskrsvoDABZaUs4zElfsLl/4wjCjhmBAhcHSTmXCIrr7Tr59vyMJH+ips6uHBYn92LKJ0x3bUSdqjznjBCVfgrw2cFA+gQaweV92oRYLD/FofaIpNppv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12350-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com,amd.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81234741D1A

On Fri, Jul 10, 2026 at 05:09:02PM +0900, Koichiro Den wrote:
> The v0 interrupt handler reads the interrupt status register twice per
> invocation, once through the DONE accessor and once through the ABORT
> accessor, although both fields live in the same 32-bit register. On
> remote setups (dw-edma-pcie) each read is a non-posted round trip across
> the PCIe link costing on the order of a microsecond, and with one
> completion interrupt per element the duplicate adds up. As an example,
> profiling the R-Car S4 remote path put the handler at ~7us per
> invocation, dominated by such reads.
>
> Read the register once and derive the DONE and ABORT views from the
> snapshot. No abort is lost to this because the pass only clears status
> bits it observed, so an abort raised after the snapshot keeps its status
> and its own interrupt delivery brings it to the next pass. A second
> abort on an observed channel cannot race the clear either, as an aborted
> channel stays halted until software restarts it, and any restart follows
> the abort() handling, which comes after
> dw_edma_v0_core_clear_abort_int().
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - New patch in v2, posted as part of this preparation series.
>
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 28 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index cfdd6463252e..377812eaa110 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -218,18 +218,6 @@ static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
>  		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
>  }
>
> -static u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
> -{
> -	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
> -			 GET_RW_32(dw, dir, int_status));
> -}
> -
> -static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
> -{
> -	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
> -			 GET_RW_32(dw, dir, int_status));
> -}
> -
>  static irqreturn_t
>  dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  			   dw_edma_handler_t done, dw_edma_handler_t abort)
> @@ -239,7 +227,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	irqreturn_t ret = IRQ_NONE;
>  	struct dw_edma_chan *chan;
>  	unsigned long off;
> -	u32 mask;
> +	u32 mask, sts;
>
>  	if (dir == EDMA_DIR_WRITE) {
>  		total = dw->wr_ch_cnt;
> @@ -251,7 +239,17 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  		mask = dw_irq->rd_mask;
>  	}
>
> -	val = dw_edma_v0_core_status_done_int(dw, dir);
> +	/*
> +	 * DONE and ABORT status share one register, and on remote setups
> +	 * every read is a non-posted round trip across the PCIe link. Take
> +	 * one snapshot and derive both views from it. An abort raised
> +	 * after the snapshot is deferred, not lost: only bits observed in
> +	 * the snapshot are ever cleared below, so its status survives for
> +	 * the next invocation, which its own interrupt delivery triggers.
> +	 */
> +	sts = GET_RW_32(dw, dir, int_status);
> +
> +	val = FIELD_GET(EDMA_V0_DONE_INT_MASK, sts);
>  	val &= mask;
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
> @@ -262,7 +260,7 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  		ret = IRQ_HANDLED;
>  	}
>
> -	val = dw_edma_v0_core_status_abort_int(dw, dir);
> +	val = FIELD_GET(EDMA_V0_ABORT_INT_MASK, sts);
>  	val &= mask;
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
> --
> 2.51.0
>

