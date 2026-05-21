Return-Path: <dmaengine+bounces-10637-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPtpAqbaDmrmCgYAu9opvQ
	(envelope-from <dmaengine+bounces-10637-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 12:12:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C05A30AB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39A77303F232
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74437E2F9;
	Thu, 21 May 2026 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDfqs7Pv"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19B30F533;
	Thu, 21 May 2026 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358043; cv=fail; b=c5TXo5kSGDrK9hD9fVWT+nq/Uexdz5S2kNj4WK/xjew0AvzFoy3v0UksOuODU5XtuwqKV1JmrwPuZMC8CC4w7Qp46xN3+MwvW1NjsXPdtTtZGswExoiQCxDBM6Kl7N5N1SP7DMMd90HlSbRvnWoLmRMaS6vbBdGPfq62uKVKxqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358043; c=relaxed/simple;
	bh=1x5Z6vlM1DkKu/G8tBK8ID6w8r5UR8Pn+EKIGP9G49A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lk3+fMsG3e2Zc2uXxD/f45hpgkyFb6agovB3Ars0zTQKwXqo5aKXyBHEeOmD200QocqnAtUgb2n9jswtz6pC8r78u21fU9uQJeOY7zaLWkJsk26ageVR05MVUh6xkABne10jtKA+nIg90/B/wyRTPbKW0x6t/2i3uknlTvaZVR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDfqs7Pv; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVnAfyqvfzkM2kGc+WADH/5lUDBrDw7zeqDI3+MfUKSjxSYhPVMsjEz0tC/94DYG0StWesKr4U0waBkk8p3YqKBx/CZ08L/HQSM4srRsXk3pj5Vf/3+Za+9yJT/XttqP9KCH9s3Rmgg+rvzyHoGA/2Dryqpw1NjQAW9bemf2iAFSt458+fKGiO8weoOp48rJPzF2118nuz6vpOT+GkTQl9s41Qfvi5JhLefdVjQ/1BrV0l2czrf77zQclO6nYotEjRjhRQ15QC6wR7Hgx+xOqol7d41XH0EVACZ9fPtfzAH9EhMgcXzoJYN8DCpvNikEoIJCq5j5OconlOUEuKt+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+Gyl4s/ZFk2PvqjF4dE5stYHYrcOuWWC55cj1Nvnkk=;
 b=dVfU077w2BtC0SLl0NpYlJbM32I/cCmnD4LVFDfQ8msm4COhS2yVYguAlxkNZ4V01QWMfKSvrEP4kPHITwaASYH9tNd90Ufc527FJMiyGOHg4x0na7U9sKr9EyRWExpXauIw2d/7CLqkLUF/BEI1Z3aolneLZR6P/q8ciZyZZRiPdkIn0U/nAoa6nfWeP7uoq27TZp5XLrLl+EQ5zzQ8X2aWGzjm5JWQYtiZqYcvzCMz6NQ2GoNao2Onp9XWO2gUFbpSuJKChx+K5JQ+JHOsq6NLVKSg89WU8lzd1p8SpCorSSZT+6OEJHpwuwmzTbQvnJQwQGzQOEV3o4aLHGA0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+Gyl4s/ZFk2PvqjF4dE5stYHYrcOuWWC55cj1Nvnkk=;
 b=fDfqs7PviTKanNI8H1bxZXS5cnn+dya7992wnpHcDbFpo7/jJWgnqTEVzFx0IyUAJISCL2NBnTfAuPz3re6rN/wxYGo7doDiBSn1BGhPD1yECkkFTFcs9K6C5Ymu3UVE30B6QAOvYgRyLGVwsgvGjSls/K2H/J8v4/+JVryVMmjx3HLPXSOX1mAwMaC9qLYJcCQm5oAviMdUp1bdJebuj1tH/0RKTdPDpFqyFw9g2UXMJUO5tgutMbr/li91iN4MAUP9om5i+b9vNifjZa1B5qvgF5qP698hccumi1lzrhR1oSU+RRFv6glPfyM74nRXl2NZabG6WDzKwTpSsfjArA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 21 May
 2026 10:07:10 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 10:07:09 +0000
Message-ID: <b6e85871-8791-468e-8c32-087b8fef8800@nvidia.com>
Date: Thu, 21 May 2026 11:07:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Add GPCDMA support in Tegra264
To: Akhil R <akhilrajeev@nvidia.com>, vkoul@kernel.org
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, ldewangan@nvidia.com,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 p.zabel@pengutronix.de, robh@kernel.org, thierry.reding@gmail.com
References: <d548278c-8bbd-4871-8fb6-e22db1688546@nvidia.com>
 <20260506034624.18782-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260506034624.18782-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d15472-8ead-42a2-90a0-08deb720b899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|11063799006|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	UHXWoi+4Lp05rT2M0YONcptFpbU87FT+dksGnoXhB9XZhAfr/NYxrbi8uzsd0i0OCjkkhO2cFs8mIc9REZ7cGwOPZq5RPbdIs7/ImainnFdr+PO35bCBdVbGXfb21YMqYGPLyYA1g8f2UjwFo/r44S9oXH81OGk9b5uOg34Wy/Aw94OrxBdiYP0WRcK1lPwLWETJwketpQU9Ge0yNBekE5V16PPO+k8voabJBPyjDzWTyLcTdVeDTUEbksAoQllRgLW3HyB2Rr4nNikFUlAmalKuaiclWDTZffi3OEhcs4g/eQWRYoynvCVB2E5uiI+Gncnn7LVi0WODHD9MRhked7+9WcS5/dsf/UiN4uTXS3hjql/kKf0VEJaXDCNrVahNsLnuZgbKKAbc82OfWkt4TZHWWV+BSvDB2oR23JryjZ5ap/suzmQP9whCPnHbbVxqEaqZ6adyxImDYLwlDGvd9l6PvihEY27hSs/OF2tJNSvC/hX7iu44A+wC1htayeaTSQr67RLEvuwvvy0A7vN/HdBoPNR5UuRIDX9z5FGJOy6P1WbeEwJWnQbqeQWUjm2ZbQdM27Dw1b7Xlj5gEygUBYW47ctffRn9ET4vDbia5xeeLaLpUSvdBW23T5u8zynh7mR+VV/A+7/gSIv6IwKxrF8UIq/9aLGtSgc4+e9bNFlSWt/YMtqO2JQyOIclmW5J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(11063799006)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEZDaUhTZ1pnQ01mcXl5UkszVFQ4eC9ONkdqOXdlOFd4ZDRQVlFsL3lacno0?=
 =?utf-8?B?WlBiQVVLVWxta2RlNVpaYTljNFo3bXJMYld1eHhBOGZVN21uN2ZZaXdRbVdB?=
 =?utf-8?B?aElZeXlzRXA4OUd3Z0xwUVlEOGZmYVMzcjVlbnZ0ejZHbXdMdERsa0F4NFRX?=
 =?utf-8?B?R0EwTElzNE4rYnhhdGtMOGdDKyszK2d1ZGR3MmxBQkFnZVQyNDBFR0ZVeXZq?=
 =?utf-8?B?TmxlT0J5M2xhOVpyUWR5bWZiLzBhYzlkRGJGR2VMeTN1T2xGdlBJdHowK1Ex?=
 =?utf-8?B?cUIvUGRURHpZUDZIUUVtbm9tUnNlWlhMQXRhMDdWWGNKSjBNa1FnckorYkI5?=
 =?utf-8?B?MTdmUVA5dGxTQXY0dU1lcEROL2tBTGJRNm0vcEYrRmt3RFlkNFcrQVlITlVG?=
 =?utf-8?B?bXJueUdNZlpQY0NodGV1ODVSSlU0OTFlR1VKZWJuU2J2LzlqYXNDWVJYYTBT?=
 =?utf-8?B?Ymc5YjE1djlSZ1EyS3dNOFVRVjVLSjZxc0JMZTlWZ012OElMZGZsc2dWVk04?=
 =?utf-8?B?bUFvbXFQS1ZYb3lFWXg3NGZyMG9mTzQwS0pWT3p1bFFhR0FpMmVQazBUZWR5?=
 =?utf-8?B?NlJVdUN4MGZTdU9EeldqNmtuWFNkNjlacUVwZFlIOXZwQVBrQjZLUFdKeDI4?=
 =?utf-8?B?UzM3VVdqV2UwNkhTZjlwem5JMHdqSVVuVmh2TXFOUDMyV3NoQmxqUG1TRzk3?=
 =?utf-8?B?SWZXQndIVURqekwrMjZHNFZzNDNYUDR6MDVLUHc1cDVtNTJ4clVnenZ6Mm9k?=
 =?utf-8?B?bStSclpVUFNrWDVVazBlUnVWNmZyWUNzbXc4Wi9hbzduMk5INGZ6OW5mUG5L?=
 =?utf-8?B?MnhPc09DbjNFTWRLVHFLZjRkbVlSbmpaa25vNm85Wjlvb05YS2EwZEdZdlV3?=
 =?utf-8?B?SE1TbjFsL0k4bHp2L0owQjE5b2ZPZWJJVDRPNWI3WTVUdE1PQkZpY2g5elY4?=
 =?utf-8?B?eElPRHVyTWh3SHZQVk84aWNldVk5dUU3RDkvVEpEa1kvK3YrNkpqeWsxOHBt?=
 =?utf-8?B?TFVlZ2pGTmdBclorb3ZYd3V2UEgrcXVmaU5iN29sZi9zam5FSnY1Q3Rac1ZM?=
 =?utf-8?B?Rmt2WUNDbDNHU2c3SUZyNkkxR09QbzZEc1pMNnJWMDhHYWVQMXNhSVBLNnp3?=
 =?utf-8?B?LzkzWXVFRXlVQlJOM25wN056K0xvWUdtaU5NSkVobkN5TjlpMFNWWG9WajBo?=
 =?utf-8?B?T1RqQWJzV0RpUWRmVHk1L3d3RHYwWGpTTTdJd0UwRUpQOURVL2JzM05nKzZY?=
 =?utf-8?B?QUM1K3RTUkZGMGtBYTd3UHhQZmFPRlhNSnZhaVR0UUVSeEt1YzZGN2h4cFk1?=
 =?utf-8?B?Yi9YZFpnQXNWdHF0SEJqUG5VREtWTEVRajNJcTl0ZlhNb3VmRmZUc1BvQ3JI?=
 =?utf-8?B?Tk1SUWQ1VzBCVER4d2xmZ0hYUzFNMlJGT1BhVEYzMzFmNFpoUU5qaC9MNGE0?=
 =?utf-8?B?ZzcvUGNYdnZ2Ky82L3BCdDQyUVh4ek0zQ2luVDdKT2Q5R2NWMEpjQXN1Q05C?=
 =?utf-8?B?Q09EWndpRVpUVHhUSVpRZTdqa3FRVy8wSUlwWmpwUHpPMngyLy95b0toRDJl?=
 =?utf-8?B?WklFMVRqbHk3WHJJd3VnYkZsSXlrNDFvMXkvODRYd1pOajFsREw1NE83d2dz?=
 =?utf-8?B?SldYNXhSWXdsYm8xQ0Z2TzZsRXNYWXorRTFnd3NZYzBwOU9mK3ZEYUg3QzhQ?=
 =?utf-8?B?UnphbmVYU1UydCtPR092QVl5RzhkSFBZeUhPa0hodlJndVNBMzhhZHpmRnRn?=
 =?utf-8?B?YkhZWlJONHRLRTVNaFdKbWEreXo5TzFGa3RUNmR2eXpieDJoVmdSUllQRVpG?=
 =?utf-8?B?K1BSQytRQTZyU1hXVUFWcEJTYk5XNndRamtxd3lnU2c5am0zWUZBZDgxN1RD?=
 =?utf-8?B?Zmx0MXVLcG8zVFg5NEpERURjb3NyUXpvZEJMeGpQQ1dXRE8vRHZTWUhvRHRN?=
 =?utf-8?B?Rm5qMldWUlp6d3lZNWNUVUMzMXg1U214M3p0ejVHWFBheGFON0JKRy9iMEJG?=
 =?utf-8?B?WTBRblZGTEJ5ODBURlpycWRpNlBrZnZldERuOHo5dVgrMUxRb3lNazNFOHRS?=
 =?utf-8?B?emNtZGt5UUJZbnAyYWpkTDVmWEJ2dEpoQ0IwOFhFVU9qTFRma2w1UXRWY0Jv?=
 =?utf-8?B?aDJQRWdhTGMzd2YvYjBqV2lmMlZON2o3YTI5U3ZpdXVMc0tlL1dIRnd4algz?=
 =?utf-8?B?bU8yVXAzaDVRajg3L2ZJdnpMaHA2T1htWnY2Zzl0WkVvMlliTXgwU0t3UUdR?=
 =?utf-8?B?bVRDZE9hRE1CSkRuUlZaRFhSS0dER2RuR0JtcnhsSXgrRU9maWdIZkdxWXBN?=
 =?utf-8?B?dkhTeWdsNEh6bkpWb0xLRkE1U3RYWWRpNm5qY2NKc3l3cEZKZ3pmUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d15472-8ead-42a2-90a0-08deb720b899
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 10:07:09.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLIGOuXeMFpOQdFdP5saHEUFfI+cFNGAXZkX9ofk6ZPohDw+qh+VJ13Hb3Xp1uNM2Qf/afSBZVq1zb4N7Ydw0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-10637-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,pengutronix.de,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 9B0C05A30AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinod,

On 06/05/2026 04:46, Akhil R wrote:
> On Fri, 10 Apr 2026 09:09:38 +0100, Jon Hunter wrote:
>> On 31/03/2026 19:06, Jon Hunter wrote:
>>>
>>> On 31/03/2026 11:22, Akhil R wrote:
>>>> This series adds support for GPCDMA in Tegra264 with additional
>>>> support for separate stream ID for each channel. Tegra264 GPCDMA
>>>> controller has changes in the register offsets and uses 41-bit
>>>> addressing for memory. Add changes in the tegra186-gpc-dma driver
>>>> to support these.
>>>>
>>>> v5->v6:
>>>> - Replace dev_err() with dev_err_probe() in the probe function for fixed
>>>>     return values also.
>>>> v4->v5:
>>>> - Use dev_err_probe() when returning error from the probe function.
>>>> - Remove tegra194 and tegra234 compatible from the reset 'if' condition
>>>>     in the bindings as suggested in v2 (which I missed).
>>>> v3->v4:
>>>> - Split device tree changes to two patches.
>>>> - Reordered patches to have fixes first.
>>>> - Added fixes tag to dt-bindings and device tree changes.
>>>> v2->v3:
>>>> - Add description for iommu-map property and update commit descriptions.
>>>> - Use enum for compatible string instead of const.
>>>> - Remove unused registers from struct tegra_dma_channel_regs.
>>>> - Use devm_of_dma_controller_register() to register the DMA controller.
>>>> - Remove return value check for mask setting in the driver as the bitmask
>>>>     value is always greater than 32.
>>>> v1->v2:
>>>> - Fix dt_bindings_check warnings
>>>> - Drop fallback compatible "nvidia,tegra186-gpcdma" from Tegra264 DT
>>>> - Use dma_addr_t for sg_req src/dst fields and drop separate high_add
>>>>     variable and check for the addr_bits only when programming the
>>>>     registers.
>>>> - Update address width to 39 bits for Tegra234 and before since the SMMU
>>>>     supports only up to 39 bits till Tegra234.
>>>> - Add a patch to do managed DMA controller registration.
>>>> - Describe the second iteration in the probe.
>>>> - Update commit descriptions.
>>>>
>>>> Akhil R (10):
>>>>     dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
>>>>     arm64: tegra: Remove fallback compatible for GPCDMA
>>>>     dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
>>>>     dmaengine: tegra: Make reset control optional
>>>>     dmaengine: tegra: Use struct for register offsets
>>>>     dmaengine: tegra: Support address width > 39 bits
>>>>     dmaengine: tegra: Use managed DMA controller registration
>>>>     dmaengine: tegra: Use iommu-map for stream ID
>>>>     dmaengine: tegra: Add Tegra264 support
>>>>     arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
>>>>
>>>>    .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  32 +-
>>>>    .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
>>>>    arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
>>>>    drivers/dma/tegra186-gpc-dma.c                | 429 +++++++++++-------
>>>>    4 files changed, 284 insertions(+), 184 deletions(-)
>>>>
>>>
>>> For the series ...
>>>
>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> I am not sure if it is too late to pick this up for v7.1, but we would
>> like to get this into -next if you are happy with it.
> 
> Hi Vinod,
> 
> Just a gentle reminder on this series. Could you please take a look?
> Please let me know if you see any concerns.


These still apply cleanly on top of -next. Please can you pick these up now?

Jon

-- 
nvpublic


