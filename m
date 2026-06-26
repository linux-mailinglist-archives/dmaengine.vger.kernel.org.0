Return-Path: <dmaengine+bounces-11815-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m7WABhJ8PmqIGwkAu9opvQ
	(envelope-from <dmaengine+bounces-11815-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:18:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2396CD5B8
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 15:18:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=lz2AXapL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11815-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11815-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB5930048D3
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18E3F65EF;
	Fri, 26 Jun 2026 13:16:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D73F65E8;
	Fri, 26 Jun 2026 13:16:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479786; cv=fail; b=ZyKtdHe5SEMtPYI97a0Ps2icTxZ47mjPo00kiYR3DjLFOtDZXsGCM2rZGP1wK5qPbFiSIo0Ib0eAo378hyhxVQfB1l9UCNgdlDn0pix309knMU5REoR+zPy67KA/0t76vItxlFXB3j4H6qgts0bQ4vHpYfUjDtxRrzpMJPXJCik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479786; c=relaxed/simple;
	bh=A+zVNgCrIxdROMb3jBPsqQILEH1kw6Sw5bv1sPOqtsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RTSUpgTkaHY44WfmcLN8yYHQ7n9WmiiZ1Vc1/R/ibl8+HHgI0p2kdDLU/+XfpcreMfBH7bhDgM3PBWzTqTgpkITNaeyHCZlMkUYcqToolk4ydcN4m6l55c0GWIPb+fGU6/yvzhnCwyxj16vV3h5Q9r7ECaMvuYeBzHcdtI685ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lz2AXapL; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eciu1eHBR2RVd59Nb11g37mHNrQDDmz5GLD5rdxzEpEJT85pHD2+7o8F0CGMXXnow1X6wdFevhBsLL4+I6+hpEEbkq+t//g0wyX//dUUb64Jbs1Tt2SYxDLJYE341MYEZBkn/kRFZMqDo7zDHx/oDSTPjUfmGZSLokwMkrin47RoAxMF5fExzPyDjQ2qBnbZivagD725bW/wMkOop71Lwn4ddvpI+0fJv1lx6MZb8ZOSIkW5g07cgLoboFQ6wfAefiHDv02OV3xChB65O+T0AVqbECSiMPhRsxV1xrpx0t5J6xI1ijSMGm2r3x42cw2Pb2/w7W+iM3vOUQ0NTchOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1HrctEqKrffFy/DlojrG7lTnrxpRYMfH5cVDTndB20=;
 b=UoGuufiXIjV8gVK4GMN8CX/pK5CS1s9VlZCPkScljEjUuTStoMBOC19lCJzY/1YMYhFQQ+vE/nCWHYfEQxwJEqmLKurF8J2ZTP4BRJT2QWhu+BmJeru2k8tDCUBY+W1NPCiioQQ80+TPGGaNVxjsxYOj3DyNbiLbQ3/+8HoTMfSoadByBcU4EtVPwPe53nwGqzWWIZeP1Na0MQeM90ZIIczy6J6v943bqlVKzZKfyD2bQ49Ls1grVhMS7dpK/IgsL6tIyxmlB7XQ+gsriUGs6aUKWoJOszvZXCH9Ir0Zn7jSPDfYAT9eL0ltQI8eDNbmuFPt6lJ+kACN7HjrcNRJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1HrctEqKrffFy/DlojrG7lTnrxpRYMfH5cVDTndB20=;
 b=lz2AXapL+GPExwKXMavyhbQVis+XhRaSMKj+1YREw9ZxmNwmS4hlz9cbpZYVWj+7nFaPRgu16zJYmPe6Lm+oOeQPI+qgI3ASyyf4cpKbq7rfP/hOn3SJgYOjssjktBfCUQY8CD+H/g6TxY+RK7YbKIlwfyXmVnAHGDXfFZkSzuE=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 13:16:19 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 13:16:19 +0000
Message-ID: <18960153-149c-42b4-aca5-9e266ee5ea87@amd.com>
Date: Fri, 26 Jun 2026 18:46:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: Frank Li <Frank.li@oss.nxp.com>, Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
 Frank.Li@kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 "Verma, Devendra" <Devendra.Verma@amd.com>
References: <20260623112647.3379581-1-devendra.verma@amd.com>
 <aj1PuyaxAHOILiwg@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <aj1PuyaxAHOILiwg@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0289.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::12) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: c06e2d80-f974-4d24-7a9b-08ded3851c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uSfa/DuafotDL4tPmCt++dnSb+ckkFaopHYr0KfTKPMUNEMAfnWUAdDXVjaJDuvEB+utpWGV2zrq1DyjvBOn8aCE378VwllY4DVqZpytkUkxvp/GyR6jrRXL68HcvPo9mx7BU8doJtUi75SWZw1/wUJFVqs3b/lYrZxvSgsWHy2z6D1+J8VHZ/Y4TcL39cfsN79WJ5ML0Oa6sUZvZa1q41ZXTOUCVsE+CihIj7FJDhd2NDPEbs5Q5Dxu0OhNaB364g2voZSIxO3N6fuXjY6PGZ/vJqLUKSuIICzbXhV+N709Q8ABcUPPDIUF0UZNEMyhcv84UMBZ8/KjZ3v9GxIkkJQ010Yz3i5R/uDJrbzq1IERqvEhmmnYu+mz4kYuI3GXm7+k7FcPeBuTueaBwP0RdIFY2v63cELIYsPfkIeMsv7Yrute6/vxKiSHzw/jJZ0oA9dW6hlpS2tjGCvlDwKfcSP0XgpUnk6+WhfFzcKEi7repPST+RSfCJx+jxQKdzjgZS+qiuuYJcsDSi9hiHCpZv4JCQy2MLwKpKA9svt+BScxOncPlnT9UzAchbsYqT2Uga99qLspiTZ4FPFwJWqIv7v3do6wbhFSYloXxH6rc8/ceYJfzBrj8RAHzSB43ANimdzWWdieVK8vbUM4vEgYALx1h+KGvDB9eNQUmQ7X+Do=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWN5cXZYYVVJSWMyNWg1NGVwU2F1WGZwdlJ0em9HWm9NdC8yVFRaNHNEcDNy?=
 =?utf-8?B?U294am1peUhiWWNWdCtiWU1ETzJRbDJLb0JFSUpBdkxiYi9hdFErSzFBYzhE?=
 =?utf-8?B?Z2dRSUhqMURvRkxTTE9qaTZiazRJUWZtZUJjeXVPQjJGQ216b1hySEF3eWww?=
 =?utf-8?B?OXJQWGhQMHdlRW92YUk4TnFaQXRwVDhWTHRVN1hJWCt0ZjJ1dnl5eEd6Tys0?=
 =?utf-8?B?TDlpdHVETjNJNEtoZlFibml3ZWJCR0dKblRtRHB4OWVyR29zNWQ5SUNVaFlI?=
 =?utf-8?B?QkFaMFhDVlJuMFFKT3dZUUh4MG14dXk2SDRsTWJIMHpRR3hVVnovZmJvMngv?=
 =?utf-8?B?QzNjT0VHbjhnSlc2azQ5OU1DYTE3d0NmUFRabUhOZUcrUHlVNk91QlFqZ0J2?=
 =?utf-8?B?anRrdHJ1TERsWld6eXh6MlR6U0wzU1dVWm8weU95NEJEYXNJdEdnQWhMY0th?=
 =?utf-8?B?b0ZKUVprS0gwdGo0ZzNHaHZITjlkb0tFUXF3alB4elV6OStJNkplbmVBSGt2?=
 =?utf-8?B?dTlLdklldFVIclVwc1FMNzdWZ0RsQXlEZTlrZkphUnU5QUUzSkdUK09yN25j?=
 =?utf-8?B?cmlvWjJIc3VTbkRqWmducUdMUitFb0MxNGxwWmkrcHE5SXdoQ2QwTHlwTXY3?=
 =?utf-8?B?ZkxXUlYyeHlqQy94ZGQwR1lMTEJVZHNFd2RCUU5UN3dpcEVuSGY1Y053b0JK?=
 =?utf-8?B?dlJGbnRNc1pZT2lwN05rbHV2cXFIVGovcjA3bUs3KzRQSDlsZ3BzaXkwMGhV?=
 =?utf-8?B?Y0tvc0kyOFlxblVqL255SXY3cndOMkhzTUFoMGMzbFZNd2FmYVU0eitMR3dB?=
 =?utf-8?B?YzdSVmtKUzFqZVMyMUordlEyMjNxRHM5Ky93RHBKbmpKaWdObWJyWmhoWERM?=
 =?utf-8?B?MTF0ZzBuTkFxQ2pxOEd4SjUxUVdlVTJIS3JlNGtrY3lWRWoyNEZxU0ZVejRD?=
 =?utf-8?B?MlZuUXFSSDFwUmd5eU5BaTBrMmhOQjIxNFN3N0NiUW9LU0g2ZWg3VFk1QVk1?=
 =?utf-8?B?ZDM1TDE0MDhLYXE0aGRScjZ5ckh4R0h4Rk4vZUh4QXQ1OU9Ma1pZc2x1aFN3?=
 =?utf-8?B?NlZaZUVFY0dvMEx0NHhYaDIyMjMzVXVscUdIOHZ0d0NoZEdBNElYakQ0blZV?=
 =?utf-8?B?WkFud3JJUjZKN0V2MlpuZHQ0K2Y2Z09PTllielg5NEpOSzYwOWkySmwvRjhY?=
 =?utf-8?B?ZjhEZFVaZ0NTcU41T1oraGJPUmNiYU45SXBiRC9hMjkra09rd2ZZaGFaekt1?=
 =?utf-8?B?bzJHOTdqTnVhSkFiWG94YUtaNWVzcU5nNm5xVWVBQXI2T3hsZWZEaWhlR1dC?=
 =?utf-8?B?bjFvSHFYMytJTHRSdlp5Wkh4Q3R0cEgwN0RqZDVON3pHZURZK1ZWUk1kc0VW?=
 =?utf-8?B?RUgwN2ZBcGV0Nm5FRjdKWVpqbTc0bk01SElnaUJiTU0yaVFiTXE5SExMSVRh?=
 =?utf-8?B?SnRFYitnZkdEMzFuRHVHQm9ZMXZnaWM0Mzd1VXJzWlVaOGN4aDZCaDRISUJ2?=
 =?utf-8?B?cUFJeTBRdmdYZjU2OWxvc00zb3hwc3NOcGJzcVVRVGJlZ3VlZmIvSW1kc3gw?=
 =?utf-8?B?M2Qzdit4NHZwRGM1ejhJblptVEJJcy9mREdiUmxCeGNTZGVjbDVkTXNaMGxk?=
 =?utf-8?B?VUcrOXArZ1BSNHBSb0JoRCtRc0g4QXpSdm8rd3RQZ2lDNnVqSDg5cUFmb0kx?=
 =?utf-8?B?YTB4SHVZeGljVm03eDBOTENyTzBxMWRxL2hWcGVLRE9NK0RUSTRlS2FSVDVa?=
 =?utf-8?B?K2tyZFVzSFJFYmFwYlA2S2VTK09rWmNhZzRjZUUyMDA3dTlJQzIramxRVjVw?=
 =?utf-8?B?Z1dlc3dNaHh5cjNvR2ZLYnpHdUtPUVhRUTJLRHVyWFhURXlIQVFQUzlOdVBM?=
 =?utf-8?B?RTVFV1VJVkpHRTk1SmRmQXdhUUhyUnJ6REdHYk4vdlF3VjVGUnNqS3BvbWdj?=
 =?utf-8?B?WFpCcGZlM09WR2xDK2I4dFdmTkc0QXR2c003RklRT0pHMk5ZTDhCZEdFSjVm?=
 =?utf-8?B?NHhmdTIyODdQWTQ1MTFUbVQvV3hOVzNmQ0hPb04rZnA0dmZIQ2o1RHgxU3F6?=
 =?utf-8?B?WE01ek9mZWhKcVZXTEVLRFhkbGNjSDdJbkV0TGlnQXdVN09tbU8yeUcwSUxO?=
 =?utf-8?B?MkFMUy9tNkdoemNOTGVZNnMxMXBqYW4vVWt3S2FySVdOeXVXOEV2YUdOSEF3?=
 =?utf-8?B?ai9sYitQUUVZMmtJcWN0WjQ3N0FsbWZKNkxWWm4xVEZpelBBcEM4MXR4VkNM?=
 =?utf-8?B?RE42OHZHUDM3OXRsMUhUYmQwenIzdEdiVHNTempjem5MMkZac0tFQmpJSnU5?=
 =?utf-8?B?K2VnSDZ4VDZTcFEvMm96NGxGTElTcDVFdVlET1lIU3J6ZjRkVVVaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06e2d80-f974-4d24-7a9b-08ded3851c28
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 13:16:19.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMZhg4KPGJKyWa5dcJYqz/2oQM9krvTlYTDYd9znif1E2Dcw3Nd+eXnpeY+fpKVOEgW2GiNaib1Xbmpk11UDZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11815-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A2396CD5B8



On 25-Jun-26 21:26, Frank Li wrote:
> On Tue, Jun 23, 2026 at 04:56:47PM +0530, Devendra K Verma wrote:
>> As per 'Designware Cores PCI Express Controller Databook',
>> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
>> channels. Current controller driver supports up to 8 read and
>> write channels only. In order to utilize all the channels the
>> controller driver need to have the channel related structs
>> and variables as per the number of channels supported by IP.
>> Following changes are made to enable 64 Read / 64 Write
>> channel support:
>>
>>   o Defined HDMA specific macros to reflect the channel count.
>>   o The count of ll_regions and dt_regions in dw_edma_chip and
>>     dw_edma_pcie_data shall be in accordance to number of read
>>     and write channels.
>>   o In dw_edma_probe() configure the channels as per the channels
>>     of the IP used.
>>   o Changed mask types to u64 for higher channel counts.
>>
>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
>> ---
> ...
>>
>> @@ -118,7 +129,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   	unsigned long total, pos, val;
>>   	irqreturn_t ret = IRQ_NONE;
>>   	struct dw_edma_chan *chan;
>> -	unsigned long off, mask;
>> +	unsigned long off;
>> +	u64 mask;
>>
>>   	if (dir == EDMA_DIR_WRITE) {
>>   		total = dw->wr_ch_cnt;
>> @@ -130,7 +142,11 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>>   		mask = dw_irq->rd_mask;
>>   	}
>>
>> -	for_each_set_bit(pos, &mask, total) {
>> +	while (mask) {
> 
> can you use  DECLARE_BITMAP(status_mask, 64); and keep original for_each_set_bit()
> ref:
> 
> https://lore.kernel.org/dmaengine/aj1JrufD1vIZH06s@lizhi-Precision-Tower-5810/T/#u
> 
> Frank
> 

Hi Frank, thank you for the suggestion!
This is also appreciation comment in the way you review and provide
example for the ease of reviewer and patch developers which helps
in speed up evaluation and implementation for that particular
suggestion.

I will push the changes in next review.

-Devendra


