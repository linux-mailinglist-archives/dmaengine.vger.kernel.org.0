Return-Path: <dmaengine+bounces-11812-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id izrJJa5WPmpZEAkAu9opvQ
	(envelope-from <dmaengine+bounces-11812-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 12:38:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB926CC225
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 12:38:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=TFBGRsHe;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11812-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11812-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABEE7301DCD7
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B873B38A9;
	Fri, 26 Jun 2026 10:38:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86023E8C65;
	Fri, 26 Jun 2026 10:38:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470314; cv=fail; b=janPId94ZlatmWm6eaxsJYDvVW/5mM7bbbHUqmiF2lLdN+PO/xx2QJlcmXSmt3fcHt1nDgiO3tCac/K2OnjFX88c/Zrh+p6qKfytNxDy8L21oL2GvpExibzyQPxGAmHC7Glh8ucOHNySLdAkwB6kC0fP8N21TDEsm25S6lO+kgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470314; c=relaxed/simple;
	bh=tDLAxrieJFT5LpH9JYILFKIDsQH136M1Ho4WcCfZHdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JO+MScfwAAh/ANnLgk0ARWq13msMNq5lf85aDd4GqMy2NsaJEuyKOGRGnFr7mzkVrXcds5Gx8KQ5TYG2TiDzKC7kuzo9K+7pl+1i6qeZEDd3gWFTF795B2rVjKKaIOQiRmgiFx3YrvFz2tWn5+Kx+cUH64b2Kg8wgAwBgPc0OkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TFBGRsHe; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1MFBBekHFO3URg1P2jpqkYAXTFz1toxT73UZYRcMqjnv9lr9oKUI/G0bsQ+Jv1kKOimvevOkqbzx7Iq7eCz40O5XPxlgNkagdX09yZ+1yF8g9TF5YULCDYNbqI44kaH3zyFr+hi2COpz0drMjTFUlOVfluQJG4KQY4wKNdMehHd55GgJtdhyH5vyNOaRC4kCqBZYoTdj2OU1hQdIAq10hkAVm5n/9XP+mPaagBKW/nM4pbRxCZcSxDkR/7mPrpb8vG/jrmEYJMrCqdtLc5OfhMy2vpLoIto342nuKhj4iW+prnBMH42/qsL1wXDpa34gHXfzSfBHSvXhOhQLeCPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smoZ2ZVSvY3TDyMRCFYy976nHNmTjtXWC8kRX2GZ3tw=;
 b=jsj2d5Ve9t9amh4Y8J8LJ6c2qPyfpyYlBj1T+K47LQMYuVnUKqEmh1gNZw5+k3sNDeXeyI+ugZF6rO4FAP8030rGJ/H7Cccng4zjMEYFj+NONFZhOZ/GvhioDulpkaed0EpoKiu7oYRgvl+Nm3kuucWpbTlRIiJiXIjadf+TAbYeWbVj7yH08yIjRk69jnT014nqKSuUL+7asEGQ1jgZkcNKpP2sczyW+lEjNTA4+Hpmfr1UJ4JSVIDECKAWR7JcVKdXyreY6C7TBN0ly7QRinuL1+arXpX4sm+16ACIx4H2aaUe/Tu1R8hlExA0tyrHMm7ZtnyOUeLguv7B9xGndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smoZ2ZVSvY3TDyMRCFYy976nHNmTjtXWC8kRX2GZ3tw=;
 b=TFBGRsHexNh+d5PyUW7OK5pEVJdOpTGe52XwF2641JgSDfamcLWo/K1gQ27EtWtrFriSL5/yV6IpOOIudXAZt05eT8iAkx+A0VUbyTGitb01WJDAC69RLEDLjFJI7QIwgU1FtQIuTPc+F+AhR112YrKwh25qqMZ3CEUUWPJQiy4=
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 10:38:27 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 10:38:27 +0000
Message-ID: <6670dd3d-94b9-4e0b-ab51-91b146265d49@amd.com>
Date: Fri, 26 Jun 2026 16:08:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] dmaengine: zynqmp_dma: Guard IRQ handler against
 spurious interrupts
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
 dmaengine@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
 <20260618071056.2024286-4-nagendra.golla@amd.com>
 <20260618072615.5D3401F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <20260618072615.5D3401F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0344.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::10) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e32788-7f77-4283-2f57-08ded36f0e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	9zvjDUX652Kyt7ActyGra0CoUksXnZ8zF/eHCHQDfoaxITYwFGotO3sIG29cv9nIYPgqDXy3Vc5rbHXJQ3LtjnE7ZKT6/dln/Z9ofXZCMLmJlmVfmIMWbX93RSitte4+hS/SZAHFXMQBATerbJiXDc10a1QsJy6O7Ti3duE1GHzkYkDUgkfCmCOFitwvU8GxZBnzMk/9e6uTkJW1vDQpsFUisLC+AiB/nRupOyoq5objjvWlqOHN64sK1dx+c8ZD3TqleCpGd+NdDtimJ0gzpdssVB2WkRGKu1S4NHpp14JZOdPMYp+A6fKmIHYOhdY4ZCc5knuRWXF+aTZyUC61vsKk0f1RcyLTB5M9BdZ+4/Eo8UXhqhq6rp0M7sro9RYnzkInxS9hWa5e1enxykfFRzBd9K7uKBLjapqsnaNOND5hzGUt5T0ka1Z/Rng1yD9sJSlZCISr2sS/ZXGVKWFOvmYETChO2Nwh0YTyt/+dGiCCQJEWJMmZ72Pc9wEf9vyybM748+RPWck7gO6aZcY0nDb/ZnX4OweoZCTx6WsPkx+cjTmvTGmq4R5dJZhsFyXZTkRCWARCi+AtWcIr34dwapj1aoYfHEozZHcXE8J0+4mxz6dg2P62NyD1GYVfv1K1DV/abxKcwzBQeTqYyzeYPvj4C9sQt34VwYl9Jh0mat8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWNMY3RIT3hHVHhzakM4cHhaR3V2WFNuSmg0UWJuRnhMMlowYWsva1R6aEJX?=
 =?utf-8?B?bSsxV3lKVHFobWYwYXQ4K1p0WXhPdmFWNDU3WGxDWlNwTGxZRkJuQmZoN3Nv?=
 =?utf-8?B?MmlqNE9LUUErMHNCZ0s5U1A4bUVjMUdZYnZXdE9yZ0VXRDgwQ0R5RmNIN2x6?=
 =?utf-8?B?dC8wR2J4Y3JIMVFwWHNTdFczblF0TURnWDIyaVRMd1JVNlUyK3VmbEx1L2Fm?=
 =?utf-8?B?N0F4b3Z4WTlCYUt4ZnVsaU90S0NiRnU1dTdVN1lUVktJZy9FVmVpUFZNUEZ5?=
 =?utf-8?B?K2x3dWcybGZialZJQ1dlV2V5MGFLazdlUmlHU1RycmlpOHNQeDFjRkMzdjRq?=
 =?utf-8?B?WVcvcTJOSVlhejl0WFRhWWRZNlhVVncrNEsyK251eFlxSEEwSWtFZDY3Mnc0?=
 =?utf-8?B?R244VllFUjNRdFZXdlhIQ29iSTNFTmp6UkVoUjdlY3NYUnVVRFpLbDFaVi9I?=
 =?utf-8?B?bjNWN1VBMUhzUmF0anYvZ2cydUs1bWdkN1gyYjlRMERUM1A2VzJPeERlaDlO?=
 =?utf-8?B?VWZCZjU5N2U5Z0VuZjFLN1BPOEJINHZPYzZRYkxnM2NCZDkraW5hV1dMTVlY?=
 =?utf-8?B?SnhkSUNCZWw4L2NVcHJ1dlNqQVB1UExaQVhiQ016OTVQRmNRZVhpOTQ0aHIz?=
 =?utf-8?B?TjRBUHRLUU5Hdk0yS1pqaS9IcnFnSURWbExKUkhicEl4SUNhTmpNSlJxdXFP?=
 =?utf-8?B?NHQvejZGemhFd2FQdHp2VkszemIrTnVkcytkYzdFUisvcWprR3pwVnZhSlRG?=
 =?utf-8?B?ZlVmZDZoT0tobTNvaGh4MzNCOGZramdkSUVNV093bFovUzZhSVoybEpvWFNL?=
 =?utf-8?B?dUYzQkwwenlOam8rb3dtbFBpZ0JXU2VUcGxVQWliUGlEZk1GTEoyR0JXOHZy?=
 =?utf-8?B?TWNzVE1iTElGMnk0alh2aFRoUFZjRDZUSkxEMjlaNkVOclFuQ2NxSFVDSEhF?=
 =?utf-8?B?UnlGZm5LODhjd0VabkVVRHhKWWRGQ1ZIamtKN2NyMUl3eUNHZDBCclN5eHpS?=
 =?utf-8?B?dG5BR09kakkydkJHZUFmYVlOZWVMbTBVdm9yWlB1OUhsZHlUYnpjY3BKN3Nq?=
 =?utf-8?B?b29uMWx5OGtCQnk0SWxSZHNnZmhzYlNlT3pJTGZLRkkwM2RMM1hXNGR3ckR5?=
 =?utf-8?B?dXBpSnR1NjVteUkya3daWmlJRTk1cm1UYTVjRE1PeXZKeHVqTnZCNnZRTUpD?=
 =?utf-8?B?OS9PME1aYkY3bEVWOXcwbnpwNGpWVktsMWFFMldlcWlPeHFpNmQxL1IwNzJP?=
 =?utf-8?B?aUt2bVc0RFZBdkJFVlBZS0pUMVdMTU1ydThHcFVCUHpDbnUvbzlEV0FaVCt5?=
 =?utf-8?B?UVpYV1ExZi9ja2s3UVY2UW16bGZtWmU1MlhyQzE2WHBhWXJldi9Ybm5LNklQ?=
 =?utf-8?B?VGNTSkJvdkNpV1FOSld4TnF1WkpSZEJKY3dHUnVBeE9sSUZIV3czc2lxRTlh?=
 =?utf-8?B?QVBmeWlrbjdOTVZTUDRBbTkydlZoWVpQWHYvYU16RUcxOGV4S3BHdmFWV0Nr?=
 =?utf-8?B?S2lYZVFVRW9yTE16S3R1Y1NEdzlSR0JwZmlPczYwS0hXdWdRUlZRS2dLMVhL?=
 =?utf-8?B?TVU4cWk1bGp0ZEpZRlNUTmpSUU84emxKWitYellEd05Qc2NWM2U2VFovcDFr?=
 =?utf-8?B?cjFpRSt5d1dDQngzb2Q5STBvSTlUc1lGRmU0UVNvMzJEREZoUm4za1dsNnJR?=
 =?utf-8?B?Ymh6YWlUYTV1cXBubTcyNTZmQWRPemg4cGg4aHBTMHBzWnViK2xjZC8rL25E?=
 =?utf-8?B?QnkySXpaUTJ1bkdPb3NKUStvdlBEd2VWRjVYSmZFQkpmOVZPQk1DQlRlaFNw?=
 =?utf-8?B?V0FxMTZ1NWNMZHZaSlFYbEIweUxKVFNrUU50NjBmZThYZzU5WkoybnhhZlRu?=
 =?utf-8?B?MmpRWjVYc3JpVmV1bmhjQ1RvMTFxY1BORnNlVHVFWGdBNWRVSEMrRGxvODg1?=
 =?utf-8?B?Y1ByU2dWV3RPOGQ3ckpsVTg4ODM1ZWhCRTZQaFVqWVMzeTcwQjZJTjFFZzdn?=
 =?utf-8?B?WUdzbTlhS1NmbzRjSUUrL3FTbSs0cWZzY2RtSzRtMC9yRWxTUXNSZ3J5Q1Fj?=
 =?utf-8?B?VjE5R2E0OXk3aGtEbHJPSkV0ajZuRm9jRnV6aS9iVDhLTlc0d0w4eWVPeDh0?=
 =?utf-8?B?eDRpV2U5cnNIelZZc0FiWkVndG5VMHBrT2F5L0cxb2V1YzJHMFNXNCtaTzNv?=
 =?utf-8?B?UGwxdm44MUxYQkhFbWxobmVzMnMvMWs2dktkZlJQQk8vR21SY1ZvWGthc2lG?=
 =?utf-8?B?OXdXUWlPanJWeDNjc3hKLzYzeVVjUklFbkdBQXdCeThJaXBCWHNuRkdDRFhX?=
 =?utf-8?B?K3hkRXRISVNuNkNFN0VESHJpc05mL3UwZEN3SVpFa0RpQmhZTmJMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e32788-7f77-4283-2f57-08ded36f0e88
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:38:27.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POHxuVAf/ijoy1685wEMngVvC5YS4ygR3LHtuoy42Owv5qXdW69OwgezsBxuEEXl3wGSDzaWhd37HFKNZpRs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11812-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAB926CC225



On 6/18/2026 12:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The interrupt handler drops valid interrupts when CONFIG_PM is disabled.
> 
> Pre-existing issues:
> - [High] Memory and runtime PM reference leaks on error paths in zynqmp_dma_alloc_chan_resources().
> - [High] Missing synchronize_irq() before tasklet_kill() allows the tasklet to run after channel resources and PM references are freed.
> --
> 
> commit 62db01b8d81ad56c8fb04b0d8f2adecdae634703
> Author: Golla Nagendra <nagendra.golla@amd.com>
> 
> dmaengine: zynqmp_dma: Guard IRQ handler against spurious interrupts
> 
> This commit adds a pm_runtime_get_if_active() check in the
> zynqmp_dma_irq_handler() to safely handle spurious interrupts. It
> returns IRQ_NONE immediately if the device is not runtime-active,
> preventing potential synchronous external aborts.
> 
>> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
>> index a9dfec3c0ca3d..ce9163138be74 100644
>> --- a/drivers/dma/xilinx/zynqmp_dma.c
>> +++ b/drivers/dma/xilinx/zynqmp_dma.c
>> @@ -730,6 +730,9 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
>>   	u32 isr, imr, status;
>>   	irqreturn_t ret = IRQ_NONE;
>>   
>> +	if (pm_runtime_get_if_active(chan->dev) <= 0)
>> +		return IRQ_NONE;
> 
> [Severity: High]
> When CONFIG_PM is disabled, the pm_runtime_get_if_active() inline stub
> automatically returns -EINVAL. Does this check unconditionally drop valid
> interrupts in non-PM configurations?
> 
> Because -EINVAL is less than or equal to 0, the handler might always return
> IRQ_NONE. This could potentially lead to an unacknowledged interrupt storm
> or the kernel permanently disabling the IRQ line.
> 
> [ ... ]
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but do the error paths in
> zynqmp_dma_alloc_chan_resources() leak the runtime PM reference?
> 
> drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_alloc_chan_resources() {
>      ...
>      chan->sw_desc_pool = kzalloc_objs(*desc, ZYNQMP_DMA_NUM_DESCS);
>      if (!chan->sw_desc_pool)
>          return -ENOMEM;
>      ...
>      if (!chan->desc_pool_v)
>          return -ENOMEM;
>      ...
> }
> 
> If pm_runtime_resume_and_get() is called earlier, returning directly
> on memory allocation failures without calling pm_runtime_put() will
> leak the PM reference and previously allocated memory.
> 
> 
> [Severity: High]
> This is a pre-existing issue, but does zynqmp_dma_synchronize() miss
> a required IRQ serialization step?
> 
> drivers/dma/xilinx/zynqmp_dma.c:zynqmp_dma_synchronize() {
>          struct zynqmp_dma_chan *chan = to_chan(dchan);
> 
>          tasklet_kill(&chan->tasklet);
> }
> 
> If zynqmp_dma_irq_handler() is executing concurrently and gets preempted
> just before calling tasklet_schedule(), tasklet_kill() might see no
> scheduled tasklet and return immediately.
> 
> When the IRQ handler resumes and schedules the tasklet, could it execute
> asynchronously after channel resources and PM references are freed,
> potentially causing a synchronous external abort?
> 
> Would calling synchronize_irq() first resolve this?

Hi,

Thanks for catching, agreed and will fix in v3 along with other RCs from 
the maintainers.

Thanks,
Nagendra>


