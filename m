Return-Path: <dmaengine+bounces-12261-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id skA2Dp3NT2pJogIAu9opvQ
	(envelope-from <dmaengine+bounces-12261-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 18:34:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA9733824
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 18:34:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=5l9LqgI7;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12261-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12261-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB0463008D33
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7A23372C;
	Thu,  9 Jul 2026 16:28:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4091A683E
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 16:28:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614509; cv=fail; b=CBealdce/jnut21f+XP/aA09eVWPOIEVLfyrYf8l/52MDP3W6EvVHfvwJh7WgNO5iuUEA3n9kFZrirdFj3fYMWy1ofjB2fCqSz3P8AuGKSrxdHiB7uciC70H8g08yYa9AK5lMaBZHF7dBAitFe6oGlJ9JZsfylFPbHH9FqnQbIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614509; c=relaxed/simple;
	bh=HpGBP4dhjPLFtIzumuCaG8xy7bzargHiRvf7y155NeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+S5NW+VQ2cSExIOhfLq3EL3T7/m1pYLyzwUV5bvmBtTlwm2YqPHx+INaBvnnnOHZxnlWxJxy+cNGDRlZuCFAzpIqiaRMeAc9j7Pj7lPBDGrv4LXGiro+kSgRgaz9LGPZhVQ1L6jgTUtMpdf0Q4LHAJ/qZO/snjNZsQAN3Ah8As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5l9LqgI7; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8G9/eMZfcyRQB7pFm9hyB/THTyV1RVQmvro7pBeSmqeu2FVRKl1q79QxPK6lLP+hJv9YYJH+eEa4wC8OIPVHJjCH35domIglubwxnH+mxUzKsMJs7kv4ueuBggcEEdZPds1OLWVe/sDVhfTN6lQFdbfvg6pTEmyei81amTdqrowMUCliO8LO5Spxygp+dloArP9tH1NfpyhS16AyF20JY3AzT89GsMKVIN8S5lQukTA2x2cpVpfQ2G0qYVDwTL8asynOcF08y+XVqWB7S5m9JQXx8G/QPlNy4p1KhXptm4JvPRkN/jI+GOlU+ap7cTRZ481JCFKGqRweVBbbb0QTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMqAXhNaCDcvF1RkmUDESX2CkwH1OgneyOrVtJPOip4=;
 b=ehFDN/Jeep7mLxi+ynMe5chIeRwlexfvwYyPdB1LCRxO3qE8ijBat/Gj/56sN0RpbcmTO35ra+qy+gqs8HeLANMRPxHmh5Z0nOv0leJOHZ9zGKE8zG5ce6ofw5Jk/VZS8d3OEmWqePFYOnSMD1R6Uzc/pPjD2Cp76jwMwZNVOK70vhVxcaE+yxGglyjmb/S9o9GyMtXdkzOGb/eo8/cPwMn+E6ILIYuuphRRFM8RfzZbmRjLI9qSFynnp/GcIevxmDb+ZHmgFRgKEizfwQ+PKQWoj04EMcSWmflUoXyikD3fb+jPu1UAOzcIDQNPpM0NJW+vwqaqHh0qIUmapibG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMqAXhNaCDcvF1RkmUDESX2CkwH1OgneyOrVtJPOip4=;
 b=5l9LqgI79Vbld0qOOq/bCvxy85T2MqArlwLhG90yv97DignUg6i+Dc44cVb6ip1V9ifNSnPCSaoFtXs03yjkBXQf2RHUJOBj2TweWTMX0rAjhaq2BBKWMa6/5EmLGmE38n9qqdRVEgINHUoQ9++jKappiCa5cnBOoUZEcEgL+2E=
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 16:28:24 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 16:28:23 +0000
Message-ID: <4d4d27ac-a39f-4c5a-9880-d64bf72b60c8@amd.com>
Date: Thu, 9 Jul 2026 21:58:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] dmaengine: xilinx_dma: Extend metadata handling
 for AXI DMA and MCDMA
To: sashiko-reviews@lists.linux.dev, Srinivas Neeli <srinivas.neeli@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
 <20260708100652.603074-5-srinivas.neeli@amd.com>
 <20260709101124.AB3561F00A3E@smtp.kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260709101124.AB3561F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf8a504-1915-423f-ee0d-08deddd71849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	fB9lu521VksBU1/Ii+xW9pfcYzLuaS1s1OKIbltxrcNbIvDkQqF+NO1eX35DOOrVfXo0PR+y077pNtZTMC9IodO6QOePOxI6bI0ZAE5zRsw1revS9zVJnyViMkk6iVIqveX3wR62PA5jOcI1RlRVJHFM+BG+Sofc8fBecxnodyqbh59ZgJDlVh/mcnB+gJZb/HNkszYYYK7snpafpkIVCz+Kl5hUtKATPiDpZQbinsxNOXfYaT/kSwoQTSWzWWerur44v00cb9CFOVVqZS40ByjU4BFwBOOUFgfAJot94y6vtaJ+oIAHXXN55T1qRoeK3TUMfrwVL71UmI8SXzlFFvApDw5Py2kOt5HFGoHTLJ0QnFY+DfzsBL/PJBUhxUtctDne1K2rOrC6vu49cNka42DM+nPKkuRTTCJe5T+ru+0Jr9cva2G8h63DPnlAWDMBLIqpFITARVDmamWyLu4PheguWFWr7/w+bxV2YeZeCau9qrOtkK+SyG8sBjrgcrGmNg0kctWD6XLR1Q5K8SmRJvLmw3bnm3LHqYTemzeX3sOw8IJvjHiUEn6fxZCYsxmqDw8zHOJXG5yeQducwn+L5YsjjRgDxurmYym8mKYPZVvDLhQBlvtKZIWKaiT23YzGwAeZKFhb+jAAMFIb2vpOff9pG4/xdBEpCMmqwvEQZQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW9Vb0lER0FONWFpYWUzRGZ6aWNuWEhRNWlMQ1hYYmZlYVBpV0Y3WUVEaHE5?=
 =?utf-8?B?bVlVa29rK3BYbjE5QVlqSGlXTjlQb0ltOGtzTVFGajBhNDVSakZRVWpVdUxB?=
 =?utf-8?B?Y2dSckt6c2F1Z2hITy9oVWpZZnlua3g4MVQwUnUvOEI0akZCb3gwQ1lSV1BR?=
 =?utf-8?B?QmhJazdpcS9YT0dxNjhzWHhmQjRKekRGT1pGaDRYUVRtTGQxb09IWVJQZkJQ?=
 =?utf-8?B?N3lrRHJBdEFZQU9OajUxK0F6RGZyamI2eUtMQ3VOZ1F2OE5pd1VWaTVLSmRm?=
 =?utf-8?B?a2R0YlVsWEZBYlBWN0ZpbUJ3dXJGbjhsYldIc0ZjdU1hRGduYUtYTEpYaHpm?=
 =?utf-8?B?dXhPMDJXWkdob2F4ZnVrekdNdUJyNGdwRktIaW9ubXJrb2pHM0k4dzI5TDBz?=
 =?utf-8?B?RUtoSzdIVm5ROHN2emcvR3BMbWtLZE55WGZyV01YQTRDRzd0M1JYUnVrWmo5?=
 =?utf-8?B?dGY2TVEwcHZidXFxZkJnRFJxWkRjM3g4YmNMQWdMb29scWRXVE1MYW1ONU1D?=
 =?utf-8?B?ajlIUlY1R0pKUGlLWkk0OUFnN1oyU1pLbWpOUXo3MUNJaTNkbGJlYkRxUStX?=
 =?utf-8?B?cC9xeUl4ZzN3V0NHL2s4YUVFNUtGK05NeFFMTldEVzFqSUZxUmREYUU5a0V5?=
 =?utf-8?B?S2hYZFgxblQxYVduV2daQ2xjdVk2YjBYUmQ5aDdtS1FuWGxpTnU5Y29HcURy?=
 =?utf-8?B?S1RoeTJsMUFQOFhmV2N6Y2kycDV6QjlhWFpZMGhleHJQYVdTNEdqUW82eFIw?=
 =?utf-8?B?dWx3UjV1b2xQbW9mSm05MDZzZ3hTTkJlSjdhQmE5MUxvRi9ZK2FEM3IrNDR5?=
 =?utf-8?B?S0JJUnFLeEZCUGdVSjc1Z1JzQ2ZhYURsYmxHMEUycCtnSFRLU3JHMnZUU1RR?=
 =?utf-8?B?UVRzbVRPSktNSUhQZGQ3V29GMnNMODQ0Q0JIcUp1Vytic3JWbVZQOHBUbjBw?=
 =?utf-8?B?TGFydzZHVVdjdlhjejRZTjZrTmZQVXdYbzZTWHdpSmdEVWpYSXFpazlRNXhs?=
 =?utf-8?B?dU5SdWRnY2ZmemQyampBU09XSXRxNmo5U1drS3I0MDNlNE0xWUh6OTNkZitE?=
 =?utf-8?B?cVVpTHZ1SUc5MVJ2a3VoT3cxN2p4cHlOdGl4QWRBbEdUaCtJdzNMaGFMakNo?=
 =?utf-8?B?Y2VXSThpeFdrc2dlL1l2N2ZUYStUMDBWWFE3Qk5DVVd5eGlER1JIajFVNUdP?=
 =?utf-8?B?OTVHZjBRYTFVL1oxVDl4YzZwOHhQcVE5NGdpOVBPV2IrWkdubjFUMk40aDMv?=
 =?utf-8?B?ZmRjT0hKeHduTFd3TU5XSzdUVG50VTBHclU3MEZhV3gvUXoyQ1IxaU1SVDQ1?=
 =?utf-8?B?K0E4L1dnVC9ndHh1N3F3VmZ3TGRlbjR4TVUrRklNVy8xNWdaaTBiZVFVOWlM?=
 =?utf-8?B?OEw0M0RyK1JFa3JLVGRqRE1aKzUreXI4RnBUQ2RDYmo5c0tianQ5OFJKY0U0?=
 =?utf-8?B?eEk1NTZzb244N1FDTlNiLzFTOCtLVmx6Z0h2N1hvSkVTeFVXVndJUGRTTTl6?=
 =?utf-8?B?ZjJlNWdmQWcvcGIxMmZXL1hwQUVKbWErcmZoU3RwbUp6L1VyTHJCRVRpVExV?=
 =?utf-8?B?d1ZUQTh1aHlzUHV3TlI3WnpISVpVSjdzNmhkV201Nm8zMEZ1MGVrUHA0Yld1?=
 =?utf-8?B?amNzUEM0bjBKZ21JUzVSUnp1b1lzdUk0VElrbld2VEFlZ3d0UjhTbEQxb1gx?=
 =?utf-8?B?NTE3SGxISklqYnh2S2tpOXY0WUR5akdZd1pmWlBoNDhLSU1QaGdFMDJ6NDJX?=
 =?utf-8?B?czlHbmRIeHI0MVY1c3A3ZTAzVXA3VmhMRHNIZGJydWtkREY0V1ZvTkFRem5W?=
 =?utf-8?B?S2VkalJDKzhmWlBHZnBKZ0gxMVc0aUkzVUcyS1ZDRlc2Rm1MMEZqVVVJVCtB?=
 =?utf-8?B?ODZQM3kvb3FPRnRiTFExTjI3V1VhK2RocFMzQ2dyYWEzbGROODNZd2VvUHFR?=
 =?utf-8?B?Q3pWZEs1SFBEc3dyZDNuR2tta1pPTXJld0ZXYmhGS3ZGdmlkc3RNZUhIVENG?=
 =?utf-8?B?eUladjMxL0paS01hM1N2MVR6SWZQczFvaXJ1SDk4dk4vdk9CbVJwT0p3Z2pD?=
 =?utf-8?B?alI1WUgvbkZnQ2F2b3RtZEZ0TnpjZzQ2WWltM0NSSmJYRXdXMHZzdnRLaHM3?=
 =?utf-8?B?SlRXNUpadzJtS2d0ZmV4RU5kekJxUS9iR2dPQ20vK2dQNlo5VDJwNkd6N3dI?=
 =?utf-8?B?M1N6K09jMUhuSUFzWWpsNDlWaFUzaUcydHZuUGsrSmhOanlwNzVkUXcweUgx?=
 =?utf-8?B?S0pTRnc2VzZyTzZlRjg5L002eUVQUHBDM1pUQ0NheUZBaVpqZUg3TUFGbWU2?=
 =?utf-8?Q?XG7wIHagxLzZJg5uDp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf8a504-1915-423f-ee0d-08deddd71849
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 16:28:23.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh0Aufzl9GeUHpZERGM4DmwKDv8BL6FqAkufk5E2Y8Z4y65ChtaIYkmD2p77zBT1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12261-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:srinivas.neeli@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[srneeli@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srneeli@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8BA9733824

Hi,

On 7/9/2026 3:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Modifying `chan->free_seg_list` without holding `chan->lock` causes linked list corruption.
> --
>
> --- Patch [4]: [PATCH V3 4/4] dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA ---
> commit 7c1e9fcfa16f54b84c1fd0328dc790510cde97be
> Author: Suraj Gupta <suraj.gupta2@amd.com>
>
> dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA
>      
> This commit extends metadata handling for AXI DMA and MCDMA to expose
> status and sideband information. The metadata pointer now starts at the
> descriptor status word instead of the APP fields, and probe logic is
> updated to attach metadata_ops when an AXI Stream interface is present.
>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index 9b8b6f1acd4ea..03c45369086b8 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
> [ ... ]
>
>> @@ -2623,6 +2653,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>>   		segment->hw.control |= XILINX_MCDMA_BD_EOP;
>>   	}
>>   
>> +	if (chan->xdev->has_axistream_connected)
>> +		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
>> +
>>   	return &desc->async_tx;
>>   
>>   error:
>>   	xilinx_dma_free_tx_descriptor(chan, desc);
> [Severity: High]
> This isn't a bug introduced by this patch, but does this error path corrupt
> the channel's free segment list?
>
> When xilinx_mcdma_prep_slave_sg() encounters an error, it calls
> xilinx_dma_free_tx_descriptor() without holding chan->lock. This eventually
> cascades to xilinx_mcdma_free_tx_segment() and xilinx_dma_free_tx_segment(),
> which add the segment back to chan->free_seg_list:
>
> xilinx_mcdma_free_tx_segment()
>      list_add_tail(&segment->node, &chan->free_seg_list);
>
> If another CPU core concurrently calls xilinx_aximcdma_alloc_tx_segment(),
> which acquires chan->lock to remove items from this same list, could this
> unprotected modification lead to linked list corruption?
>
> This unprotected error path also appears to be present in
> xilinx_dma_tx_submit() when chan->cyclic is true.
The locking issue with free_seg_list modification is a valid 
pre-existing concern, not introduced by this patch.

   I'll address this in a separate patch series along with the other 
pre-existing issues identified in this review.

   Thanks,
   Neeli Srinivas

