Return-Path: <dmaengine+bounces-11877-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V3sbB7dOQ2o7WwoAu9opvQ
	(envelope-from <dmaengine+bounces-11877-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 07:05:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E26E06D7
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 07:05:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amlogic.com header.s=selector1 header.b=sHs+C+lo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11877-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11877-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amlogic.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0A973008C3F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 05:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCCF3CDBBF;
	Tue, 30 Jun 2026 05:05:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022102.outbound.protection.outlook.com [52.101.126.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64073397695;
	Tue, 30 Jun 2026 05:05:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795955; cv=fail; b=G9HS3ALd8f19VRBkWVm/smNinI6nOybw7+T04CSQYrveCmH3J+kD6d7Pw0sNqXylNfiFDoIMho2X6op2ABX+YebwsvkNOZBET/ehUlYT0L+2S7ul+/mFptNU/YRdlSmnak4zWq4MJ12VJarOpk94V1ChaEBKhr/QbncRuiK4jMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795955; c=relaxed/simple;
	bh=zYDGikP9Dqc1xsPKKjjt7WsdXUz6xix/ev8Fi5aoNF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcRxtgv9d0IZQk0IgECjuU1VKnwEOQ7EIGjZwhqNoFqZiCUP97wv8SbLqQryf9hpA9Alfe7H0qAccB/WpwYJbHX2Z1cqe8GdRsGFK1hiS7hm7WQcPs/FsuIHI5c/Qw1poDAM96wCiMQmE7yb2cySJBAn330H8lQOc+baDLcw4C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=sHs+C+lo; arc=fail smtp.client-ip=52.101.126.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=me09H6YOhuzgiYDF58cX47ZC66puEz8pf7pJwMc+2JXF5bCAJ1swZpVSC9q3vBjlHk72eBBkTjDCSolpK8TbUK0ifbxLe6ytvOFPE21uka83OX8J4lddCzx/PhmH8jZtBY5pX2CnQVSfAw/kiQiWErxas2ni7woqw96qs8LoWwyy44nAC+ggkan/aHwVvdLrb3xGg8WKDMQvoZOdO1Xcx3PS2U8XYpmidIlDc17QhOkU0nJwIuiSSGHMxpW1x84Cvr5YwgPLNCNPi1J6F9Xxs698esIzpiGI7Ix+ITjPF7XdrngSmc9SHnCFJSYgTi7SRwg/cP4lXkQqfTqcz+HxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ7C16HrP2j1mthSLx1Eg1bsSs41WNDPL6XB8fKpEpY=;
 b=NdEwZS+TnciiL4UgdYsYtYViZ4WWQxPaReNGmTmM/jy363bHoHFi2y4dpEYmgIWLuGq6uQGZRFLY+9yDHN2IS0V6Yd/uMXy9RsYSKPnItOyqgMZtwykmZxf9IiJB4/OVaXCcnY1EsolnIE4so9sAdOLtY3SiDiVt7r66BsO1YX9iozhBUfknq0N0WXo+sWRedJLKFDOpSgJF2Br5Ov6PHMitxYv/2MfpvA29UEVhOvMpEH3SAYJhZ3vG+GytQMp5Pr085Dz2Dofs2ZbaaPeFy63EzIK93xDJRxUvDvB5ewsLjHGIIE2kxvB43/IKI4gQ7SxySYJHMvBonIc3CGOaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ7C16HrP2j1mthSLx1Eg1bsSs41WNDPL6XB8fKpEpY=;
 b=sHs+C+loHZggHMQ3UaSLf+Ax9K7GGeBc+eD1Ngk4yHCuYJgnEw8a63gpu9smmxtcw8SG3epiO1i01IwbfDZX9nojohl8cpdL20z/fJnaZrH8Zrzpqmhl5RU5Vfkn2oWohe6HCd8iIIqRKSRJhHGKs5wMXGpYkt73SdJXAFYqf/nB3TvaqNAH1xDQXkuYS1eGr+QV3Q5Hf088mC7qJGZgh+yd3YMddcakwDoO7UBbrFhanX0x4fZ9TpCBH7x8jdzyXqYZd9q2NZE4En56CFAva2pMT/WpdqTlLi6vr9CfDPeQOsOKeK7iLB4e6cS0C7O2LIW/nxNWxhAaj3afDu1hjw==
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KUXPR03MB9667.apcprd03.prod.outlook.com (2603:1096:d10:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 05:05:49 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 05:05:49 +0000
Message-ID: <dfa55ecd-f86a-4452-851d-8138b250912f@amlogic.com>
Date: Tue, 30 Jun 2026 13:05:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Frank.Li@kernel.org, robh@kernel.org, neil.armstrong@linaro.org,
 conor+dt@kernel.org, vkoul@kernel.org, linux-amlogic@lists.infradead.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
 <20260626-amlogic-dma-v9-1-558d672c4a95@amlogic.com>
 <20260626055033.061BD1F000E9@smtp.kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260626055033.061BD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:295::12) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KUXPR03MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: dee818d5-6a65-4e93-07ec-08ded6654012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BezhAcUsM0lK0g1eAl3AofRfcCwy2kvFHpCrdZYER80ZOxkAFHi6QKwHCp1fq4IThODX2aTGpb2MTKs8vJTMAjs9UXzKPWfW8uijOMwL1qSxfoLAQNBdz6YA/4R21p5MIsByY1KSJeLAma31YZGgy7lt14b3iMyUwxbNunrt4WlVOz9cFIWdpoLS+DYrMIF5bu91IOS5jykRatdLLF8bwu2xQz1BL75m6h3bPxzZke4gpRUrKYp0Y+PfTTb3ITqXd1k0znNk/5oVa2v94lDr3VmkAK1P3laUE+S8+8FbxfFkzcz25XkDDa3rbEkCt0KfUa5Xuz3LwAcNqJXMnaGAvRtMwtSIkxdkUphrXItxXFVNVDUNbF1s3r06SUmpUqTtlHBmpG2YPHKL7bAixQsOqEjSfG6jjqFwnKKC/tNPysC0sr2MLZ9t6F7nWgge4PSNycTAEAInTWh6Cx5/CvfWbs4QlE9pUskzexdbRWgZZsxlP+I1kdqiKAslcgjQz8NS0KW6iaokGBZ3Itv8BX9QtiGIsJTeQkobTWYT+FfhnJOGZUATrEhqejDUqi/wlmPwLmhN06NolGbMFXIEEOeacqrmhbeI+rEKjrgpjkCYJpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JiNTBxMXJOK1E5MWhrVFc5c3ZSbW9oT1VKRXhUTzI0M3JSRHl1ZUNkNmcx?=
 =?utf-8?B?d1VEZ2RkZVlNRWxhdXJzaWYvUHdYTk1MSUlaQ0dPLythWDFXY0NzcUpKNDRk?=
 =?utf-8?B?Qk8rQmJjZjI0eVhqNkxVSmI4ZlN2NWZBSlBlM2JNYi9zQ3FlTkNHeGtOSUFi?=
 =?utf-8?B?OGRkUnJjbmhQVVl5azJpcTNsWlh6b05rNHZVL3Z1VDVNbzRnaTlBc2tyVUZV?=
 =?utf-8?B?Z2pPS1BIVSszM0JJZmFmV0hpMHJvUmhKMEl5c0c4YUJ6Tms0Zm5ZV0FtYUFR?=
 =?utf-8?B?bVYrZ1VTWlJ5aWVTNjZHR0xWcU5nRkRZbnEvenFRM1g4S0o0VjNNU0JpblR0?=
 =?utf-8?B?dFRKR3FVVjJrL1NhdkxObnNhUlZQTHZrL0c4Tmh0aXpqR0FON1hoTHJucHgx?=
 =?utf-8?B?Qnc5Z3lYbXE0eGJWVnVGUW51RjRFdHlkdEhqdFdVMktMMFBrUTRzLzcycjYw?=
 =?utf-8?B?T3FvRWVGdEljVkhRWDJOWi9nKzRacmdZVW1pSzY1ZUdObW1DV1BHQjZmREx5?=
 =?utf-8?B?TnRrL3B2N2Y5czgraE4yRjA3bHM1WWRieWlObEhnOWN0eDE3ZEZNbmg1SHhV?=
 =?utf-8?B?K3cvZ2JSSVkzdUxVOE4yVEl2WnBHL0ExYzhjNFI2N0g1N212bzdNaUg4Y1Jq?=
 =?utf-8?B?WEl3R1ZudXNIQ0liL3lTdklnV3BQS1Q0L1BQeE95NHBySjhXN2ZJUlltaFF1?=
 =?utf-8?B?dFFldGRCa1FBdW0xT2N4aldManRqS3FCaUlsWFBhWTVLcjh2TTlqbkx0TWxG?=
 =?utf-8?B?RWVwZjNoYTJaS2trYUVOS0V3M3FNVjNxcnQxZGlycktrK2NWQmNvNHZiaXY4?=
 =?utf-8?B?VlV0RmZXTEFiTVpDbFI5TlBWbVNISERPQzE3Mm5HOVVJdS9mZkpxSTFrN3ZM?=
 =?utf-8?B?OG54TUNXdElubjI2WjdUOGFZcU12TjBUMzdqaitzeU5PcWVTWGxyUXh0cjcx?=
 =?utf-8?B?b1VJSVNNYU9DMVZsZ1VrMGZudDA4ZW51RUd2OGh0dWFTei8wOEJldStwREo4?=
 =?utf-8?B?dkJkZCtZVEtJY3UrMGM5RVdyU0hIbHJWRWhHV0xVYW8vdWhIQXZ6QlE2WFJZ?=
 =?utf-8?B?RjRUckxsTnUwQm5DSW9Rby9IZUhKZTRzek9YUnZLVXhxbWRxTlBaNmpvQkdP?=
 =?utf-8?B?WWlTRmRkWXA0Y294T1Y0dC9sdjFXR1hqTDJwbjZRQUd5YXVZc3hyelVxOG1Y?=
 =?utf-8?B?QnlGR05TV1JVUk5rUzZzT0hCVjVJY0pGMmlRYTJOSjM5dXpWbSsyeElyNFYx?=
 =?utf-8?B?NXYxK2VBbUxCWlZ5bGt3VGxLRm5PVTBzYkFVeW5xODB2bjBraldBcmhZMlI0?=
 =?utf-8?B?eU9ZTlpIV1V2VTUwUDZPK21pVVhQb1dhY1U3alI3RjFaTWxZQ21YSEZUMGVY?=
 =?utf-8?B?Q0FjV2dqSDl4OUw1MVcxUm1xUk51UkNIcWd2UHpRYi9NMWwvZ01iRHdXZDBj?=
 =?utf-8?B?amx1d1hWUmFBT2JNTHErbDJzZExKc0ZNTjRmUlNVR1ZOZ0l2d1N2V2lRRllS?=
 =?utf-8?B?ZVRKMU00OEdjSUtjaGxQelJodFMwbDRTN051QVgvQVlsVDFQUWhnZ2FsVk9P?=
 =?utf-8?B?bmtXamRqeG9lb1IrTEFSYlhSakUxb1FGcEtJeDJ6bnNEcEdKREkzRmszOW93?=
 =?utf-8?B?ZUgzQithVndlbkJ6RlFnRHMxT01TWnR4N29IT05NRzBjLzNZNE9pMTVDZGQ4?=
 =?utf-8?B?eE5ENVVNVjhkcDVnVWtPTVFHbzY5WmRUbjg3MEU0OTZCNnhYZER0b204bHg5?=
 =?utf-8?B?RlpHVmRJVjk2cXVzdkZZbEF2UXc5Y0xsUlpRM240L3ZKYkg3SjkvcDJRMEE1?=
 =?utf-8?B?MzZQNmVoQjlXNUdzWEtRb3Y4Uzl3OUJWbFZmMjdaNHNYSHU0bFZyQ2gwUlRR?=
 =?utf-8?B?REdKM21UOUZWTXdoQzdubG9tZHRIaERzRVJ3anBjU2RUbjh2WE1NdC9zNEJB?=
 =?utf-8?B?dUpocUsrQ0F2SlJhQmE0c0c1bjQ5ZEs5R0wrSUluem1OZ1FwTWlUS3I1RU40?=
 =?utf-8?B?NUFjZ3VVTldody9XY3NYaVJrUFdZZXRRS3JCcFVja2g4bFlmcHdaZHQzOW5u?=
 =?utf-8?B?NlJhTXRLVnNtTFlwaHVtcjRvUGZna25RbjhhblpiK28yNHJjS2Rnd1ZnSW42?=
 =?utf-8?B?WGJvaW1FaWNaWlNXbmVqdkE4aHd3YzA5Tm9SSEtQTUpmSUJjR3RWSng0YytO?=
 =?utf-8?B?UklCb2htOTVHT25TY25aa2lWeUFOWnhpY2RjSVdiaUlTb2hZWDUyZlZjblBv?=
 =?utf-8?B?bmFhS05tR01SQTBvUExUcGRQSDgwajRkR3RzTVNnNnhXNVBtYSsxMzl4TlZR?=
 =?utf-8?B?L2ZYUEc4aTlqd3FxNE9qRmN0a2dVOCtadWx1M1RsRzEyY3BBREhsdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee818d5-6a65-4e93-07ec-08ded6654012
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 05:05:48.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fOTSvxBR3849hP+kpwOYf91s3JEUQZrGq6PK4oqLLBBLiu5NguWty0RjjghGMBfupQ/BWu4fGwT1tCBwKrDs7laGvnWkydWcv/YD54Ptvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9667
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11877-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devnull+xianwei.zhao.amlogic.com@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:neil.armstrong@linaro.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:devnull@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,xianwei.zhao.amlogic.com,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 979E26E06D7



On 2026/6/26 13:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Low] Global dt-binding header defines generic 'DMA_TX' and 'DMA_RX' macros, risking namespace collisions.
> - [Low] The `#dma-cells` property lacks a description explaining the layout and purpose of its 2 cells.
> - [Low] Missing space before the opening brace in the device tree example node.
> --
> 
> commit a7b4f5e4e6207e7134f0b399abc853db92908381
> Author: Xianwei Zhao<xianwei.zhao@amlogic.com>
> 
> dt-bindings: dma: Add Amlogic A9 SoC DMA
> 
> This commit adds device tree binding documentation for the Amlogic A9 SoC
> general-purpose DMA controller. It also introduces a new header file containing
> specific property values for this controller.
> 
>> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
>> new file mode 100644
>> index 0000000000000..efd7b2602c336
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> [ ... ]
> 
>> @@ -0,0 +1,65 @@
>> +properties:
>> +  compatible:
>> +    const: amlogic,a9-dma
> [ ... ]
> 
>> +  clock-names:
>> +    const: sys
>> +
>> +  '#dma-cells':
>> +    const: 2
> [Severity: Low]
> Is a description needed for this `#dma-cells` property to explain the layout
> and purpose of its 2 cells? Without it, device tree writers won't have
> documentation clarifying which cell represents the channel ID and which
> represents the direction.
> 
Will add it.
>> +
>> +  dma-channels:
>> +    maximum: 64
> [ ... ]
> 
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    dma-controller@fe400000{
> [Severity: Low]
> This isn't a bug, but should there be a space before the opening brace here?
> Normally it is formatted as `dma-controller@fe400000 {`.
> 
Will add space.
>> +        compatible = "amlogic,a9-dma";
>> +        reg = <0xfe400000 0x4000>;
>> +        interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
>> +        clocks = <&clkc 45>;
>> +        #dma-cells = <2>;
>> +        dma-channels = <28>;
>> +    };
>> diff --git a/include/dt-bindings/dma/amlogic,a9-dma.h b/include/dt-bindings/dma/amlogic,a9-dma.h
>> new file mode 100644
>> index 0000000000000..c59c2fd4b9561
>> --- /dev/null
>> +++ b/include/dt-bindings/dma/amlogic,a9-dma.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +
>> +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>> +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>> +
>> +#define DMA_TX                       0
>> +#define DMA_RX                       1
> [Severity: Low]
> Could these macro names lead to namespace collisions since they lack a vendor
> or SoC prefix? These names are already widely used across the kernel, and
> defining them generically in a global dt-bindings header might cause
> preprocessor collisions and build failures for any driver or DTS file that
> includes this header.
> 
NO, the maintainer prefers no prefix.

>> +#endif /* __DT_BINDINGS_DMA_AMLOGIC_DMA_H__ */
> --
> Sashiko AI review ·https://sashiko.dev/#/patchset/20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com?part=1

