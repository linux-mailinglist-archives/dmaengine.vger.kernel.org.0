Return-Path: <dmaengine+bounces-11904-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qwjFNYR6RGrnvQoAu9opvQ
	(envelope-from <dmaengine+bounces-11904-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:25:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082E6E93F0
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:25:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=dcaIvLQB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11904-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11904-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C99E83023320
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1FA32B132;
	Wed,  1 Jul 2026 02:25:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607138DD3;
	Wed,  1 Jul 2026 02:25:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872705; cv=fail; b=TxQweLPbCcpQq5SBHWsD/OnV24k4UQO34JPoZYHn0EckyG2KkaB3tmKbaC83tpImTNQqoW8KKACYPzvQgBHl8jKFc2R6Zy9mdohugL534PfQCpIt2x/shN5f2/GK4ITzUEFPojUN/bLGRrWyMXzOsIKciUxHNON32aFggVxD16g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872705; c=relaxed/simple;
	bh=cNjgLerm/zFCrLI29JsZ4pjsUqg0grZENpHKi3CqVAs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MLR0+0nRTm3KauvomCgTy7N2+h+duffEpgoQ+xqh05OxJ4hAKm1P0KF4V1ubSkuEAJW8kaLJGOHs/cX+F9PbF7LvfhuDuqqdnWSyM8i5/wZxkeHcg39lL1jGADp7SoDExo3gJ56O6mGhG5aZDpTV0RGo3IVrJaEfKsLP5T5gK2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dcaIvLQB; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2FCohJZep1HnwIBV+JrZNH3kFOdcxdma7ZQ8/hhwfHQ7Uc910txWt4bw02nPV4TlgEbI1Q1uewIfLInBtrlK8JZPUwIlm9O2a6d/16zYttRMCyjJzmm4I2A/c3knLOz8xgILCuHwC8B8oQxQvvMUHnO3xCSBWj9soB3/4b5kyp3ExzMyEnGhl30Cq5Vp7F6FCqRZjXYf3NUXoVEEX0EYNqBg8Kd90mwZQJ42qfLQAipb7L4WGknG3MdkWnEY0n0ZzRZ39hhLYkOAJU6Y+d9lfAlVML6LZOfMI5vML/qDJsqIu5QEGcpVq/Byei31o92xcba+yvPtixSKef/Mj5s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwODdWDLSWBXDGuLYH5Br35/taHzUk7Bp4uuxaMu9o8=;
 b=WQze1QVtiRfu/F7MuuSf1mlFo2PYILb6hq6KsRfBQJUVn7plBJ04wklckWgn8qTE0mDTyKZn74LA88mPXaKUNsEWLzqJ34QnHw+VoiyBARmLNvXWzkd9gytzDGSA6D50rEKFKMos6e/oLNSFRWC2Z5hbBpnYEsjOWl0oyQyBmZLjHJvPDz+suAxNqqKSoH9L39PmaBelk8jc+Yrz69FUV6MKJx76pzlGZ8CKB7maURcOdqslfchHWWBGXvL/P6SKyz8JSMYqzoO8iN6F7VHX08URfDAniHjiODlOmobfmjeFg39M3yKqrkEuJ2N66EbtjUlUFndjH+EfrbX91jI0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwODdWDLSWBXDGuLYH5Br35/taHzUk7Bp4uuxaMu9o8=;
 b=dcaIvLQBVtxanoiy0+cNqz1CfxBWvs7A56FdFtxIQyN4KtNLYymd0VGLMBua8p1mzqwyJJ476HmPONLWnT7dGkx0+G6KBo+T4v26G646WpZLmCVLNGpPh17ad66IIXfDo5Q9o3YApuIpgEDITyr6T4mpK83mLSNRkugd9i2HqouWrcj2m2d1Eg8a/t+sBA6pX4K8QNztO5EEE51s73MqtZqsKbXEyKWBBwm3ddDQ8nwkDvWw8K0G+Fn3fhAncDynp+8dczMxLEkkfRaOnEKyaKCihe/81o6DD4P/KmxvbUhfOGdW5JK8BJkEXtcoarINsVUp0Mn0fTjafez8d3Y1iA==
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DSVPR03MB485361.namprd03.prod.outlook.com (2603:10b6:8:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 02:25:02 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 02:25:02 +0000
Message-ID: <4af3a6c0-5b52-456f-ac31-6651162d15db@altera.com>
Date: Wed, 1 Jul 2026 10:24:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: altera-msgdma: replace maintainer
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: Stefan Roese <sr@denx.de>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <065e447dc41ea149c900338e64f047575ca6c348.1782279704.git.adrian.ho.yin.ng@altera.com>
 <aj4yodoqp-ZWQVEs@vaman> <akR4roTi60VyFWCo@olivier-manjaro>
Content-Language: en-US
From: "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@altera.com>
In-Reply-To: <akR4roTi60VyFWCo@olivier-manjaro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DSVPR03MB485361:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b03c43d-0394-4b31-e7a4-08ded717f4bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	rdMJix3SOi+ePIVeeGubXAHkqe+0BHB/oCl/+fnhbnA+jTryTX47pZ70xKtYmTWMiUhg6SrqL6RsyDf1QNY0LGk92AGbn13IQffNbbouFSCvBgm/2vaBuRJSccQPnDa91ygsgLKFz2dMHRxiA3K43pp8ldfhVbC9h8SAx/qFYnt1o7D1a+khHoyQi6kJdNQXMy5GFHnt2w+0gudKc25LKLq/MHJZwQZ8F87AsQP9c/7mUQd6a0pF/N3z5aej72GlUxFt7h1eJLEjg2nK03E8TUVREIfi/sIMc/XHsFm5c9Q9g2xBixDA1ivenuD1EkLfWMMiSPvGXMLngJaRYl+zo+9Xd6T0a85PPUsQmb+52AlgYEDkGT9otCmXurM34firEMpBHIi8lZhBlRXnCOwNKoefjUEkvGofV8QjuRh3E/StQhJoygMp/jWpRx12VfbdYIT81+Ni9Ik/oMzbYdapBIAM5cAX10IBfP9cJyf+1pP9ntfap1JFpRzU7ZgJnwiGXWTu6ibkKSDnZlIuTInMAz6jiT1tf6Z5a3wmMl8EGi6aG/ggMWTVrkoxNzAxD19xt0pLLKMJYSvweVfs4IsP2MbOV1w3uMeDnwFkNAyzAoRZTBWDwGnmzbI6gMSHRYnRINqOI5b2M90KvMfoQpqF0nwIi0rniq5Qj6SGljZbyZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDltQWErbDM3YW1nWDlLKzJCNFRINk9kZHEyeDcwNlMxUmdmRCtqOXdaQkpH?=
 =?utf-8?B?M09nOVRQM2JHMkw2U01WM09DZkFrczQ4ZU1KRGEvSzFJQzRHb0F0bkJDYXpK?=
 =?utf-8?B?WExXNTNwc21NYXVVSWp6b1lxczRZcndicXJDYWc1NktjN2t2S04yc1d0MVgy?=
 =?utf-8?B?MmMyb1NoRnZ1bjBpbDFXQ0hPMEFSdFp4V3pCa2ViaUx6cnloM0Y5UzBlaGVI?=
 =?utf-8?B?alU5VW1JZGFRenhWWlZUWWwxRnhETzc1NTM4S3cvT1cybGdCU0VNV2orT1Qy?=
 =?utf-8?B?ZlBUMzE2QUVMTlZRUVVWcFFzUHZjUVZUb2xQdG01Rm5KVTZFR2JmWlpIakJy?=
 =?utf-8?B?ck1JbHNhbXkzUEVSWkw1bStRUndzVDdjei9CaE16TjNlZ1RDUjgzbUxMcU9a?=
 =?utf-8?B?SVAwR1F6Vm1IckpnNW05MU9wdUpLYkJkYmRYNzNSTGJHTHZETGlFUkttSllH?=
 =?utf-8?B?RjZFL2hjRXZScGJXZkxDN3o0WXRQWkdYcVJhaFFWa05YZ1ljQWg4SGNlb2sy?=
 =?utf-8?B?L0JxbE5FbW1odDBuZ3BiZGxhYnlsQ0p1V2xQTC9PS0p2YUE2MGxMUG5ockdu?=
 =?utf-8?B?VmJEUTlSWkt6bE12dVlob3UzQUZSYnBzTm8rWGQ4TDlmbkl6T2VjTXE0M2dk?=
 =?utf-8?B?akxNc05Yd2J1L1lPZlVNQVUvT093WCtOeTV6WUxTMVFOY1Y0MGxvbERGSWZ5?=
 =?utf-8?B?MVJ1Qy9DbUN0UFFGQ1pQTjVFcVlqOS8xWHh1VHZWazdqajByclFOTkFMeE1s?=
 =?utf-8?B?TlRaMHl4ZjZsZElHa2thRU5Sa1pqMVU5WEtLZENMdko0Q2h4Wlk2QkNFaGVZ?=
 =?utf-8?B?c0tqSm8rOFJJTzR0UVNUcmJzTjlkaW1ab2JocmpucGMwUEhhaEEyVmlzU3A3?=
 =?utf-8?B?c3czc09TTWdOZ3laR2xsRHVNYUhwd0R0S09SUHBGRy9BSjJSVGZVRXk3Y3By?=
 =?utf-8?B?T1lmeWZOMVVmWCtBMTBpemZ2VmRadWo2K2NFdG9vMHJienkyRFk3VjFYWWJi?=
 =?utf-8?B?NjU1alBRbE5FVmhyeXpkQTFMZkhPOEhCSkw4RitFUHJ4ZVpRRGlDME5pM2po?=
 =?utf-8?B?Sklqd1Nva1M4eVA0a1Y1TEdacG04bDB5V3Vrakp6Y2FYeElrUXdNa0VsdGRP?=
 =?utf-8?B?STU0b0VaQ2xtSmNtQUFZK04rT1J4Unl5Y3ZYM1RockJ6ekk1QWFmb2xwSWJo?=
 =?utf-8?B?cUlkdDRocXptNWtLeTJMTENRYkdwdEY1dXMvN2owWDRFRmFZM1NBVnc0MC9W?=
 =?utf-8?B?aG5vQlNJNXNOV1BYQnIwdUJMME5vZTVUdUdkUXBGUmlmYjArb1dsWlk4TVFo?=
 =?utf-8?B?UEVVejZXdEJ5UHBoVWJvN0VBUVdia3MrN1h6aWl5NnlIY283M29TaG40aEZK?=
 =?utf-8?B?UFBjVytuNDF2N3lCUThhdUlDVlRNMHdvYVZRc2NtSnJ1MXFqUHZOT2tFNENZ?=
 =?utf-8?B?YUVHU0dGL1JVVlpoc3B6UHNqeVZSVE5ERlZmRmp3N2ovMWFXdUtZQVFoeVBj?=
 =?utf-8?B?R2t5d09nU3BlbEhWRDFiZytNcjRJM2JnVlNLV2hQNUhVaVJZYXNZaFNYbkdz?=
 =?utf-8?B?U2ZUS3I2SVloUGNRdjRGY0YxZlltTWFNajhvVVRoaVFmRzNScHNvRy9qai9w?=
 =?utf-8?B?SkNDR0xzeExXVldQcWRLUG1iYm9GRDFoeERRUTkvLzBST0pOT0tkK2hmWERp?=
 =?utf-8?B?cEIrM1d6ZWFEL1dtRU5EN1ArRXdOOHpZUDN1YXdOODJaeVlIMTAwR1RoeWJI?=
 =?utf-8?B?V1p2Q1QwQkE4OEFtZG52Mm5VeEhDTWlNWk4rL1cwQThycnM2ZWprTmhkai81?=
 =?utf-8?B?Q1NNK1dSNFhsT25rWE8weW80cEhlYkl1d2pORlB2aE9VaVl0R09PMnVkS0Nq?=
 =?utf-8?B?dmlScGtZVXo5cEdpdlBua1N1VTFMZXJBdmNBb1ZVb3N6b3hVcU5aNnFBUjdM?=
 =?utf-8?B?NnlwdzlTWnJqLzN2ZmRqOGtwbE8zVzRWTjFuYzJDMWFIRnJoRzdCMjF1TTZ1?=
 =?utf-8?B?c1ZlRm1xWDZOdEQ3KzJ5VE0zRFY2KzNLVU5yUTZ4RGFKd3RGcTcrQm8rTTg1?=
 =?utf-8?B?Y2hrMlI3SS83ZlVYWGxPazZjL2k1bitJRkp0aEdYMGJSQkJWNXlWQ3h0MU96?=
 =?utf-8?B?WUhRUHhGM0tBdVR5TmJLUUVmODZTS2FMcTk5WXN3SmpySTlQc2xIM3ZMNHZE?=
 =?utf-8?B?NnhNWUhkeGYzTGZRYmE5ajNsd0lXa2VQZThPNHNQSjg1WTlnQmQxKzBUMGtE?=
 =?utf-8?B?MFJhdXhjQ1lzTVYxTHZrd21LcjVaT2plcHdmTGdVdjVXdFpTK1k1VjNhcXNr?=
 =?utf-8?B?b0FqbFQ3MFN0aDlldTk5WUpML3pQQlJTT0dKUWpkSThzbVdlS1hSWW5IVUNi?=
 =?utf-8?Q?qwdux3PfvcLcujwU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b03c43d-0394-4b31-e7a4-08ded717f4bc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 02:25:02.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktQRMLSjER7pPPPZPKM7pVxq8JcmC9/8TrYI6pM80tfNEr627j1oSV2AkArwSlbEBjbLAplYFiYw5buEv38H/WTIpfo06jNQzIXUYW4y7X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB485361
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11904-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:olivierdautricourt@gmail.com,m:vkoul@kernel.org,m:sr@denx.de,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:dkim,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6082E6E93F0

On 7/1/2026 10:17 AM, Olivier Dautricourt wrote:
> On Fri, Jun 26, 2026 at 10:04:49AM +0200, Vinod Koul wrote:
>> On 24-06-26, 13:49, Adrian Ng Ho Yin wrote:
>>> Olivier Dautricourt has stepped down as maintainer of the Altera
>>> msgDMA driver as he no longer has access to the hardware. Add
>>> Adrian Ng Ho Yin as the new maintainer and update the status to
>>> Maintained.
>>
>> Olivier okay with this?
> 
> Vinod, still acking the change, but I just realized the maintainer change must be done
> in the dt-bindings aswell, not sure if i missed a patch.
> 
Hi Olivier,

I missed out the binding. I'll send a separate patch to update the binding.

Thank You
Adrian> Kr,
> Olivier


