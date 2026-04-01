Return-Path: <dmaengine+bounces-9792-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEvfCvSrzGnNVAYAu9opvQ
	(envelope-from <dmaengine+bounces-9792-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 07:24:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8E374DF3
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 07:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 972143004606
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 05:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A935CBCB;
	Wed,  1 Apr 2026 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ePt7vatp"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB8329C67;
	Wed,  1 Apr 2026 05:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021023; cv=fail; b=OPZ5jK1jhWUE880vcs/nHHf82d7NE9vNIeN9FnEvLAw2q3xDzx3EIIahR0IyHp/ML3oDDNISGf4nMEGmowQMaj/b0rdX+AvKIDIYYaG0khkKARcUiNn3cSfclRCUd1pzZ2WIDrnrjyK/heCB/F18d2YZi5rzjiLLrLBqwe2cuHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021023; c=relaxed/simple;
	bh=xO9rHg9JhC1UiSV2eYckutblHFasvvQrUzTLFWHqfuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iSDtIvxscpuM0FdJxKDAjjRACXGQUuPuKfxTyPQhbkcWfAFaEMQg3GtUar8t0KV3J6+ejyho09tC5nJ6rXWaF2szqnaPDMNm8c8wE6Y1XgMqwihsnLAuMTO2Vb0ICjgfYYHknoeI2lukTXqU/5nZfKTxBing+GCyTsoQ6RBNRTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ePt7vatp; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBFRXl8yMhYrABx/9nWgOMiC2ztFkMPNTjaEcwRih7jvYftJQYbM+QDLF7hieequmHewDdn99AokKKIPYWCj9TCKlNZtVRa9MzA52sUIwx5gWvQi01EleX0Cz4YhoXgYwUejOegFshE+Xcxy2dhA9HSFnHAv91kGIF5E78Bexz6QlZ2ZG5XYmRF9mocprtBzzRI9f2X5l0ockqmLpbNDml9anB2LAil2nU7spSpXYfNchjsW7kJ09/KqQvbwR9eNfNui0qopZ9RFm12EijRtF636yS0G7wU0Ft72+cRP8kln+3AkTfwwj8HY7QMiFzCOdnIiwdt6z2X0PMTuoqWh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwBzC1rJSolNNb0WcV7HRYZ2eqJBWIe1/OMmdYLPSew=;
 b=RK3F8wXNgq7+Rvwv1XPAHECICqCYg7zGBxVxCP4Ai5tG1iJ4TVVv11T9ggYagiTUAxkyV3jLwSMCWOPLHwmP076/U7IJDdYlhovoPJKof1QoEDdQu9SZ+7iJ3yf+UYzmUtW/YbWVqFVoqdXzGowjEgAl+C8I0Oc1IUCKFh3B2nTU9/EoH02GlmrOuN+O9uO1mZVBcT7P6Oy0oXAmGu0vzYCwDCXnsXof/4/6Xo7fyINx8dMlhk+EJjvWSiqKG594imHOGRvxejkGAMDx2FL52Da7KWk5O8uUvQsRK3lZuTofhHcwJUBjAX79Bo2azitipSUI1g0p89ng58pvQVxYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwBzC1rJSolNNb0WcV7HRYZ2eqJBWIe1/OMmdYLPSew=;
 b=ePt7vatpkECpG1RWNyFwNNnZrQ8Jfxo81d+DyBud8hADleGcdt/Fw89p1WjngS/EPpMfeLUmIpPoBycf+PkSpshpjVswIL8x0Fu2GCg6ey3cCS6yV08PLuHJe4VMNaAozpmAuY6KqXdJPjSvHku8Qh36KC7fu5y+1id0VR3Zl1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 05:23:39 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 05:23:39 +0000
Message-ID: <833bb42a-65b8-4c93-8109-d2959f8b807f@amd.com>
Date: Wed, 1 Apr 2026 10:53:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix CPU stall in
 xilinx_dma_poll_timeout
To: Alex Bereza <alex@bereza.email>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260331-fix-atomic-poll-timeout-regression-v1-1-5b7bd96eaca0@bereza.email>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20260331-fix-atomic-poll-timeout-regression-v1-1-5b7bd96eaca0@bereza.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::30) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 85aa5261-9cd1-46b3-22d6-08de8faed4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VJlrzjKAszkrq7T/ilfAuDvIqCLlkGegXuDX52KJM8gRgi6icL/j9oalfBz6Ml5yi9zIAjL9dwKIifxJox3DNMhXLbil+Qm1+bwVempR7h8XtS7ns+axOGl6Kf4NW2MDxXfXOAnXs8AKTxsYeklsfQ6Ftz/UZ6a28lAyzSpFXkqNQWD2a8FAD63SBYzGyBiSYnu5UHrBjlbVLqu0xPpCqyOaoVk2xSMkxPbhB7/JhWHdiicc+PHKDZkc0YB+WW++aGScOFIjLM+mZpM5D92qLKQhu4IhUx53kuf6ar2R3tFINCkBlSQ4wiFZ1+8vW+g0szL8z4yep+tqXow+hrE6iZ33Ofecmzp2Bmr27GfYNmzvbHloR6/vZRaV8kXoZYt0XWnLRRtyeQK+BDXNgauSQ9ECR8yu6WAK3Ir3LmRhBUaDHeNIRhL6ElcGq1pR/UL7d0VWyMsLeU3BYHQp5SrBXPNJ5hJMfzCGJr65NdTUhw1wiTfnxWe3XX4tG3Djz6EJm0iVgjZpinBb8sxGM/SUicsMgClLlys1TV/ce4O9PLutZ6foIUn05uBPtkr1VanEcQYHxnt+mzjCt9IUsmHAWuSTdaRD+8BrRJsm+ycDElv/PI5W2zPVKnaTMA5ZpsqfpZ6muhYqpMrCDtoD46Uk2pC5IPOlSuMJqZNQms0LZjZG85XdTdutbGv6SqkNgTOpaVsF8+nFrJqP9k5KbzgK+pnPQu1K++N1nrw6opyuSHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDd3RVNRaVRzcDZvcmdHTGlHdEV1ejRxQ1QwTTRBZFN5M05JSnJQUTF0SUM1?=
 =?utf-8?B?YkFzZjhMR2pOeTVPa2llMXBSbTU2V3MwOFp5bWFnY0l0MXpwOWtPV1N2eFdM?=
 =?utf-8?B?YlR4NlhKMWVaRjNWcUNEbDUyYW1tSlNZUHpycldyRG9ERGNwb3NVZnpHRnBM?=
 =?utf-8?B?QkI4aHh1UGZ0ekJ6NTlLSC9xZkN6TGxxMDYyaURldFlmOVcydkdxd0xpcWlr?=
 =?utf-8?B?c01Vam1EZTRud2xHSkNoNXZqeEpwaUpFSzJaOXg3azUzVHJwckFOR0NxMkgz?=
 =?utf-8?B?T2trMFFMTExlR3lTWHk0em9xT1hnbWVCZm1LSlR2RnArQWk4eW90dFdsSDhm?=
 =?utf-8?B?OUltNmtmc2pSSXU2eDJTV0pSQ1lmdFBIOGFPZEt4MmlBdzNhTTBhVlNzcm0z?=
 =?utf-8?B?VjdQU1JodTZRRU4wdi8xZ21FTUM1UmcvVEw3WDI4R0xsdXZrV0d1cDdXa1R4?=
 =?utf-8?B?OTQ4bWd0U0ZIYlplYVE0VnowM2tNV0h3anlRRytKSVIweVg0UkpQYkFhdGxo?=
 =?utf-8?B?cEF4Qm9LTm1VRHNqcXdKbDRKdjBtMjBuT2VTSWNoUURSMnljaHorNy9mTGwy?=
 =?utf-8?B?MjV0cExqWVFSUHZjNWxpYTYvcEdwOGQ0TUlQb2pVZUlqNVlsam9XY0J3SHZw?=
 =?utf-8?B?a1NGK044eDRvbDVSaEVEeFhIc0lKUWp1MUJBZlJNeThtZUxYcjhWR0k5NUdF?=
 =?utf-8?B?TkZ2cG1ZZVlEdnhtUlAxeTNnN3UvdktvVUozRUxOUU9iTHdzVVNNb2NUVDUv?=
 =?utf-8?B?ejVMaGt2OWY3WnExU1dxYTJYMEtNZ0I5S2lqWnkyejFIVUdCZTJaVXpoY2pS?=
 =?utf-8?B?MjR5RWd0TmZwdlJNbWhrNUlLcEs3bjhFU0FlSkdZWlk0NHdQZjAxckNiVzBM?=
 =?utf-8?B?d1BEV2pqOUEvVnpFQnZ1dzhBZ0lyV2dsdkNtaVRkV0RIMThoQzVBbXpod3h2?=
 =?utf-8?B?MEF1dDRTeHkwUzg5NitiNk9QeUpVamM2SUhBdGFvNlpiYzMvenNUeFdvL3lU?=
 =?utf-8?B?NjZVVVQ0ZVlkUkVvZlRhOTBsOHFDTFpydnhkR0pxZDloTEFtVDE5U1UxODNt?=
 =?utf-8?B?YjMrOFl0elNNc3ZRdjZmdW1EZHBQRTMvRjZxYW01a3g1ZlEyMjlpSWJXQWpY?=
 =?utf-8?B?cFdmVkNiQjAvOXFBVVdsT25USEJ5cm9LODA1UXV3ZXQrRllUZkhpWHBubzNu?=
 =?utf-8?B?YlZ2bmNjR2VFcHBmY3YxL0JRQ00wMTZpZnQ4MlgzVG5GeUNBOVEyZVdXa2Jo?=
 =?utf-8?B?aFRnbk1OOU1SeXFKTExncVNLM1dDc3VNamsxdnQ4Zm1hcWJpclhsR3hCTHVx?=
 =?utf-8?B?YzFYTXJuMCtHT1poMG8yeGRTNzNOZHpPVHBWcXdIOW9PZlJIcG92eVYwY25k?=
 =?utf-8?B?RVpTNG5ZZ2s2RXBWTFNpNXFNd3RXSjNPUi8raStqSENMUUdsQkJpR1hoNlZ4?=
 =?utf-8?B?M3FaM2dVV3B4Vnl4ZEtvWkY4SG9tWkJlMXNIYXBEblhZcHgxZG1SRDA5dm5s?=
 =?utf-8?B?aCtEcDc1SmRZSDN5Mko5SE1tR2V1YnRQc2NROFlqelgvVW85QTNrazJlMTVl?=
 =?utf-8?B?QzVhVERvWHVuZ1U0VmpSVE9ocHA0WDkvOE5rb1psWkUzL2pxdnBQZStSaWll?=
 =?utf-8?B?V2EyeEt6VTUzU0F6dXlGemtFZXJXaFNabkwvWXR2UFhBNEpTTGJOYk81ZVJQ?=
 =?utf-8?B?RUo1TmNGZVU0LzBmWTVCZDU5enVncXpEb1pIa1lqK1lxNk1YL08yVnZVb0w3?=
 =?utf-8?B?NmNqcGtOOW8wNE1WdGhNaDc2aFlzTXhKd2xDbUNiNkVYRE11VkdqT3RUWEhz?=
 =?utf-8?B?N1QwajBtNDcwbjlqaFcrQkluNDZTQmNvNE55WGxodkxQN0pYNWpPQ203ejk2?=
 =?utf-8?B?Z0diZm5UaFpjdURtL1BXS0tzYVhnQS9ld25aQUVUYXY4MEZEbXY2ZGlkR3Va?=
 =?utf-8?B?R0I2VDJQRTZOZ3NlbzMzS3g0dXBRZFp4aFgrT1JNelVNalpNZ2xUVmZIaUxJ?=
 =?utf-8?B?RW5EWnJxQmFWY0YycWc5cmlOc3dUMHkxaUk3N1NQTjBsZVl3aDZscWdqbGsw?=
 =?utf-8?B?UUFzNEdvWXoyeDZvMGswaWhOYnAvb2lNbXRFYzVpTG9SRmI3QkhnckV4N0R5?=
 =?utf-8?B?MGliVDlSV05ybzc2VklyNGNBcTlzYUtpS3o0UFJZU2ZwQWE3U2R4c2NuaGlI?=
 =?utf-8?B?TXJsM0p4dnFhZUhQV1I1eEpzMkxkcnQ5NGgrV0huVitzS2pIVlZzd0psRFNl?=
 =?utf-8?B?WEpQTEp4VGVyMTQvTlBFeGxMSVY0ajVTWFpLeWRxbytXVndNWkEyaFBxWEFv?=
 =?utf-8?B?bFJ5VktHUytWditSZU1MK2NnMEF4aHV3bTVYZEIrM2lZM0tJek5Kdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aa5261-9cd1-46b3-22d6-08de8faed4a5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 05:23:39.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nH7iBkG1xXW3Ndej8WZVPGd8izQtoCHJQFAT/Mu9+1PXWnuQJKEX1l8xLuQeC5Y6vHe1Qq2ykVXjmnKuFTX3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9792-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BE8E374DF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/2026 10:14 PM, Alex Bereza wrote:
> [You don't often get email from alex@bereza.email. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Currently when calling xilinx_dma_poll_timeout with delay_us=0 and a
> condition that is never fulfilled, the CPU busy-waits for prolonged time
> and the timeout triggers only with a massive delay causing a CPU stall.
> 
> This happens due to a huge underestimation of wall clock time in
> poll_timeout_us_atomic. Commit 7349a69cf312 ("iopoll: Do not use
> timekeeping in read_poll_timeout_atomic()") changed the behavior to no
> longer use ktime_get at the expense of underestimation of wall clock
> time which appears to be very large for delay_us=0. Instead of timing
> out after approximately XILINX_DMA_LOOP_COUNT microseconds, the timeout
> takes XILINX_DMA_LOOP_COUNT * 1000 * (time that the overhead of the for
> loop in poll_timeout_us_atomic takes) which is in the range of several
> minutes for XILINX_DMA_LOOP_COUNT=1000000. Fix this by using a non-zero
> value for delay_us. Use delay_us=10 to keep the delay in the hot path of
> starting DMA transfers minimal but still avoid CPU stalls in case of
> unexpected hardware failures.
> 
> One-off measurement with delay_us=0 causes the cpu to busy wait around 7
> minutes in the timeout case. After applying this patch with delay_us=10
> the measured timeout was 1053428 microseconds which is roughly
> equivalent to the expected 1000000 microseconds specified in
> XILINX_DMA_POLL_TIMEOUT_US.
> 
> Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because the
> former is incorrect. It is a timeout value for polling various register
> bits in microseconds. It is not a loop count. Add a constant
> XILINX_DMA_POLL_DELAY_US for delay_us value.

Please split this change in a new patch.

> 
> Fixes: 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")

This patch doesn't fixes anything in iopoll, please use correct fixes tag.

> Signed-off-by: Alex Bereza <alex@bereza.email>
> ---
> Hi, in addition to this patch I also have a question: what is the point
> of atomically polling for the HALTED or IDLE bit in the stop_transfer
> functions? Does device_terminate_all really need to be callable from
> atomic context? If not, one could switch to polling non-atomically and
> avoid burning CPU cycles.
> 

dmaengine_terminate_async(), which directly calls device_terminate_all 
can be called from atomic context.

Regards,
Suraj

> As this is my first patch, please feel free to point me in the right
> direction if I am missing anything.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 02a05f215614..8556c357b665 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -165,8 +165,10 @@
>   #define XILINX_DMA_FLUSH_MM2S          2
>   #define XILINX_DMA_FLUSH_BOTH          1
> 
> -/* Delay loop counter to prevent hardware failure */
> -#define XILINX_DMA_LOOP_COUNT          1000000
> +/* Timeout for polling various registers */
> +#define XILINX_DMA_POLL_TIMEOUT_US             1000000
> +/* Delay between polls (avoid a delay of 0 to prevent CPU stalls) */
> +#define XILINX_DMA_POLL_DELAY_US               10
> 
>   /* AXI DMA Specific Registers/Offsets */
>   #define XILINX_DMA_REG_SRCDSTADDR      0x18
> @@ -1332,8 +1334,9 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
> 
>          /* Wait for the hardware to halt */
>          return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
> -                                      val & XILINX_DMA_DMASR_HALTED, 0,
> -                                      XILINX_DMA_LOOP_COUNT);
> +                                      val & XILINX_DMA_DMASR_HALTED,
> +                                      XILINX_DMA_POLL_DELAY_US,
> +                                      XILINX_DMA_POLL_TIMEOUT_US);
>   }
> 
>   /**
> @@ -1347,8 +1350,9 @@ static int xilinx_cdma_stop_transfer(struct xilinx_dma_chan *chan)
>          u32 val;
> 
>          return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
> -                                      val & XILINX_DMA_DMASR_IDLE, 0,
> -                                      XILINX_DMA_LOOP_COUNT);
> +                                      val & XILINX_DMA_DMASR_IDLE,
> +                                      XILINX_DMA_POLL_DELAY_US,
> +                                      XILINX_DMA_POLL_TIMEOUT_US);
>   }
> 
>   /**
> @@ -1364,8 +1368,9 @@ static void xilinx_dma_start(struct xilinx_dma_chan *chan)
> 
>          /* Wait for the hardware to start */
>          err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
> -                                     !(val & XILINX_DMA_DMASR_HALTED), 0,
> -                                     XILINX_DMA_LOOP_COUNT);
> +                                     !(val & XILINX_DMA_DMASR_HALTED),
> +                                     XILINX_DMA_POLL_DELAY_US,
> +                                     XILINX_DMA_POLL_TIMEOUT_US);
> 
>          if (err) {
>                  dev_err(chan->dev, "Cannot start channel %p: %x\n",
> @@ -1780,8 +1785,9 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
> 
>          /* Wait for the hardware to finish reset */
>          err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMACR, tmp,
> -                                     !(tmp & XILINX_DMA_DMACR_RESET), 0,
> -                                     XILINX_DMA_LOOP_COUNT);
> +                                     !(tmp & XILINX_DMA_DMACR_RESET),
> +                                     XILINX_DMA_POLL_DELAY_US,
> +                                     XILINX_DMA_POLL_TIMEOUT_US);
> 
>          if (err) {
>                  dev_err(chan->dev, "reset timeout, cr %x, sr %x\n",
> 
> ---
> base-commit: b7560798466a07d9c3fb011698e92c335ab28baf
> change-id: 20260330-fix-atomic-poll-timeout-regression-4f4e3baf3fd7
> 
> Best regards,
> --
> Alex Bereza <alex@bereza.email>
> 
> 


