Return-Path: <dmaengine+bounces-9890-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNuLIhiU02lpjQcAu9opvQ
	(envelope-from <dmaengine+bounces-9890-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 13:08:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28D3A305E
	for <lists+dmaengine@lfdr.de>; Mon, 06 Apr 2026 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C8193013AB8
	for <lists+dmaengine@lfdr.de>; Mon,  6 Apr 2026 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF0330337;
	Mon,  6 Apr 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7XovE/9"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CD32B9B6;
	Mon,  6 Apr 2026 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473647; cv=fail; b=qJwuWNbl1fyh35Z+HKJOQwo5nhviPTXWcxx+5LYlwwDJlIK87s8WGg7seTNx0VzaqiAeGrrxCtG++HipzouDcOQFN2WA13YI0/rilUaSGkI6f66agU8yLqyE6pBMqZ6rWlEiHfobIG1CoBR80jNGefvRcL0y2pl7//nbQ1XPlOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473647; c=relaxed/simple;
	bh=7N0alp6EplKasq7OJDu06cIf/3B7OXexYeUvccRfgFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Soacrdqx/nTWvM9fuVswhaHlOY0ZQv/eN0f64VZGabQdZHcKCFoVYYmWQ1xqHgYO42yivSQw4AF8z2nRzldujw2z9EEolPPSkn8HZKsYL3XXIcMiCts/gn9UjPDuERPtr2WH+gwJ+jYmZdM7dikOq1tQw8avuKoYZHsCuwTt1mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q7XovE/9; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YddpnAqqi48G5eCEW1HDwmq3WlZus0Ix3AhJwR+XqtrIekOF7BOhi6JPljftgg3mIZtERYxmmtOjBC96lZ3nZJ5wa58b3W/7t3FAsH5BTH+r8WN1uxH16PdmM3Dp1hEYA5jkC+6dg+5FXfHnmY+pq3X2wfIkhzUBqOStPZTjkYa7mbKGOXSxt8V+KVt0dDojcZuCLvdQuFdwhDXF1Y+4ZdaZwmUu2FMXVAkHB4SJgffNozsrcbCGfgLeaz3EmEEzsemoAUCjwZnMRqpS58mEoN8b2P//tphMYhOobU2iPDE9sVX/N/wQXBI1+OeD3GdwTtdWtNt4ePv8FJmRFUkG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHH1KvDLHbQsikRImtoxQBR2SUSeJ3d1XrVGZ62Y+Hw=;
 b=j51ZhQ9c7A/JqtrcFindOTideOq7v493HiKRgJ04xPfF4u2yDGBE6YUaNCJbjwjijs0JhUi7NDnBCucRnUn5D/XCw1AvV8BLMa/hYRwmiyNbk0bh2S3vX1RgHcIWxwcQ0Nzefp8N1jlKDeAzOot+sxLR1ImlSi+QepM+pQQsxrVJcpJ4c+Gf3jzqLkWOljp9C2GIRpWcOb/qyC3U2VwcNce5eFNBMyZnNl3sdks/cmD6R++3r7Tt/1GfUzFQvaxAfpsf58woOoEwfPvgNWIwouMEjmc5FEB05vUPAfm7/SL0f5kb6zwt4VAfaGkwLnCeuslSxGt8Nqon6sKkwqTcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHH1KvDLHbQsikRImtoxQBR2SUSeJ3d1XrVGZ62Y+Hw=;
 b=q7XovE/9y6q450VK/wDgUSC5XCRL5BAvGBxVHqTPFKQ5dwUPDVYd6yGfuhQ7rIx16Nn1o6RlXE0YR9Amu+ykZmtJQF7WMu0TfJFuFO0SeVs/pM06vIbNm1gIcCvBkva/J27tQ46YsSPDJUMe57gLMII3KoUv5HnSE4DMkU/Lo1wACccTC6mQU0Wm7vm0QWk3PN1ki1w7I2pp60a0jB2g7auPw+robYqHK5steLOoNHNH8PMkfOtfG3ZOkUgVEW95B2jY3rvRfyY9ikrC5N0djrnfMYi/O5vlRzs3MJ2XqWmRiyzEbTIfaCjXBl4ztvBzUyyNuXEPD86erAV3eWZGJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11)
 by SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 11:07:22 +0000
Received: from DSSPR12MB999212.namprd12.prod.outlook.com
 ([fe80::5e39:8f96:935a:87ba]) by DSSPR12MB999212.namprd12.prod.outlook.com
 ([fe80::5e39:8f96:935a:87ba%3]) with mapi id 15.20.9769.015; Mon, 6 Apr 2026
 11:07:22 +0000
Message-ID: <8f404754-7950-442f-afb2-e716bbe0d21a@nvidia.com>
Date: Mon, 6 Apr 2026 16:37:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: tegra210-adma: Add error logging on failure
 paths
To: Frank Li <Frank.li@nxp.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
 Mohan Kumar <mkumard@nvidia.com>, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323083858.2777285-1-sheetal@nvidia.com>
 <ac8uBTemDHCr4T6V@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Sheetal ." <sheetal@nvidia.com>
In-Reply-To: <ac8uBTemDHCr4T6V@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::12) To DSSPR12MB999212.namprd12.prod.outlook.com
 (2603:10b6:8:376::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999212:EE_|SA5PPFD911547FB:EE_
X-MS-Office365-Filtering-Correlation-Id: 000df46b-e360-4fc2-32e9-08de93ccad20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dCmajagwtJHRh3vjybXvRxpsVION+JWu1zqFrTW7L9mV2pF5eI3ayCQf7B+NFWzF5gKBwO0FoYIVjUIgbjlzSsfTdOWC87/OPczpiHN3u6D4jWJi74dfSnr82YyswRD1LwNvQVf1a1m/vmTQkEUMH7goFaNGxehVjZCEiP+o56zgHFpRDK12sLCkjWqT1Deui/cmr2bfiH7OI2W89WYkx+C4m8uCrWXH/MuXK2chVqfua+NT6Zj5zYH1rDbZagiBW4JeDiU4+BqYd2bS+JZmiyNRHIpXy+9sdvhc0aUyXF/l18QKuF2hNv3rheHmJh2kh2KQ2nIq2xS/k1RZ449FRLE1E3NVXw1bMOdVrnUb3VHEqL/BfeWSoHhPUaJnvizGj2OpOSOlHxxEl8MXNgReRFIQhGQfsGICBu5ns7aNksEqn33VIY+4qnE1R2wGIIo8eD1X5/C2XhkmcoswaSwenT13qV+9/QsSRv3Yhj7HiyNQUdUelOGH7MpMxTycGFOW0E6VC+qLUkfZCIsvxkckvIxXUZGrPgaXEQt7+dNP2ioHkxluSie1BQr2q7zt1wDi1OVbDK8JS69lzF1rSUdn0k4pLT2OzdGazn+BoHkW6QajAfYYr9ruLTe95wLtV1qTiz8lLSUFVKf1RB3+6a1+89DTbRFnx9JkQjseNqMVk2y+QbtQBBeyli/hhbTjC/TN0LuQW8P8hX9RI5qCwu1yRnFsfNwFPVgQaEVH7sQfwME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999212.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUdSRVhKNWIzaEloYmRuSkY1WUx4eUFZZTBXQ0ZEWklwV2h2SFIyR29NUGh4?=
 =?utf-8?B?TlEyZjZrd29LeGhOdldIUWtqUnBpbXBJU3F1eE1hMjRrL2NzTEhqckRvWTUw?=
 =?utf-8?B?ZVNxN2RQcVplUjNMcHRMNWhsSkNoYS9QcUVJWVhWb0syZnRVRk81Y0p5Tkhz?=
 =?utf-8?B?VUhvOWYvdlFhNmYwR3kvcnlqdHdKTmFjM0JOdDBQQU5aZWc3bVNzbWY3Zzh2?=
 =?utf-8?B?MDZ5cS9aOVU0aUh5b1h1RGtZajJ6QVJHbzg3ZWNRWU9pZGk3bkcrU2hDSnpi?=
 =?utf-8?B?MG5jWWtxUXdUSFJ3MElCRU5WcUlyb0lLMGhOWXpBZ1EzUHVyTEVRempHOXU5?=
 =?utf-8?B?aUNnQVJwQzlYKzVlYWE3eHk5bnc2NTNaSnJuUFM4cEdzV1ZUT2xhOU1aTnVU?=
 =?utf-8?B?VFoxd2ZWc0RPc3cra2dvbjRVVHJwYUxmZjhOdFJxLy96WkpnbU9vdTRwdTI1?=
 =?utf-8?B?cHlHOUJhY0RtVEdkRHRvZDN2WEZEOFROdHh4UGJiKzhETVhDanEwZUk2TkVT?=
 =?utf-8?B?ekNybFozS3BOOGNab3AzVTMzQkNWWmtWeldyc2JobWEzZVRRdTI0NnN2a0ZD?=
 =?utf-8?B?VStycStnZ0N1TExOQVBhQTJ4RHp1R1J2YjQ2WFozSmR6cDRSRU1VanRISlBG?=
 =?utf-8?B?VHlTaW9TaFp0ZTFLTGsrRzI5SGJyeSsyNkdLaDZsWEFwb0VXNTlWSkZ5dVlM?=
 =?utf-8?B?bkNhWnJLa25hMmFqQmRtNlBoVExwajAzeWhwM2lpWHBzQ3A2RjlQOTVFdkR6?=
 =?utf-8?B?K1dtNTd6TVlyMkxJNWdyTXFRSnFpSUhpYjdUS0RBUXF4cWxoaVl0OG5CWTla?=
 =?utf-8?B?RkJVZU90YTA0RmovbXl6OHRJUkN4Q1o4SkZmOG05eDdLMTVlb3cray9oa3Nu?=
 =?utf-8?B?L3MrSzJTbjQ1WDJXSkswY09MUWFNblJjN0FDUjFYck5aREZsdzBNWkplWmx3?=
 =?utf-8?B?ZkR1TnlQVEo2MlJycVVTbmlpc3VlVklCbUVyUUc3SXBIc29SWi9MZWN1NmdZ?=
 =?utf-8?B?K3ZJaEdxTW1zZW9COUV5UVpjaHUxUFN5WUFnVHlMU0V4SE1ESEFqYTBucE1S?=
 =?utf-8?B?MEdrdDI1dVNXVXVUR0ZPdW9YT0RrazNubWZsdFlRN015TkNYQ3hHR09Ob0k4?=
 =?utf-8?B?NUFibnNwMDlhd1Z1MVp6QnVuVGtnY2hmMDJrK2tZUGxDZUoraEpScHMvOUty?=
 =?utf-8?B?TkVHS2wzTDc0WUJHTVV0d3MrRU5iMVBRR2JVd3QycVRxbVZVaDBaV2RuWE9v?=
 =?utf-8?B?VW5uR1BTUmI3WDZKTHU5SkVkT2t1QWZpbmZWaEpKK3RpcXg0cDRZM3R3T1kz?=
 =?utf-8?B?ZFBUWEprYVJWVGxBZVdmaUtlZVg2MlFKL2ZjNTZaK1RsY0pzT1JBRkVFUS9P?=
 =?utf-8?B?SGUyQk42SlhRa3lERDBrR2o5NjNJckhzR0ptOHhlU1NKSCtnZmI0V3RJZWtC?=
 =?utf-8?B?eGhsb1MrcUl0ZEpkRDhmSXdjS1U5dlQzamdycFR4UjRaaWZMVU9QcEZpcnda?=
 =?utf-8?B?dkc3dHZVZjMzODdza2xPeldQd3BWY244Z0ZZMVhaV0RLMVRlckdIczdhc3FU?=
 =?utf-8?B?cTBjNXVqTU5hRjFPR05MYjdRTVJVbkozK21xb0FpbmROT0xpcSszRmJHazBn?=
 =?utf-8?B?OWRiS3lyYlIxTGlwcmdaSklwdEV5a0JxSjA3R2NKTFY4TFFSbFIrQzFGUTBG?=
 =?utf-8?B?dzdMOUNlYURYUk1tVGtxeWtqdEltdWlLejdkamV3RTdaY21tcnlMUnlBQzdG?=
 =?utf-8?B?R0pJY3duRHptVkRMOTRRWmc3aXh3R1hUaUV0Z0kzeDNZSGRjbTBMQ1hhUm5s?=
 =?utf-8?B?T1llQm10dmRERUlIQU4wRXlVSEYrWnhWTmtvZE1taWdiTmI4cUFMZUhPd2t5?=
 =?utf-8?B?cFRDSE1yS2ltT3FoS1BKQjgrWVlsbHB0K2c5OGtRbExWTDdyN0ZxamlGbWlq?=
 =?utf-8?B?QmRSMXFzZnNsaExZVTRpWVRGVW5DZWswMUt1NnZxZHl4c3N1R3ZHTmRMdFRh?=
 =?utf-8?B?NlczWmRCSXJROXBZZzBtRkRhdThqTks1N0t3WWJxVGFlV2poNWtFVVFkQnlR?=
 =?utf-8?B?Qzh4eFo4SjF0MFZ1UEJQandYc3hMU0h5c3VNbGhJQ0NFcFlMTzVqVDNZVSs3?=
 =?utf-8?B?N0EzZ1QzVHllTG84c2Qrb04xbSszTVRRK2NVR3QwTUpjdHNBQ3BERjgzQnFD?=
 =?utf-8?B?YTcyQXNub1F3R3I5RUJnT2NFMndzMDlYbDZtTEkveTBJNzErdGNmZ1lObmZT?=
 =?utf-8?B?SFNYYTB2MjV5Z1hyVDNUNjJHSnNrSTR6ZGN4ZVBGelFmdFlNNFNBb21BMFh4?=
 =?utf-8?B?ejU5REdVL2dCLzV0UHRsZ3FNK0hHbTV1ZFY4bS9wZ1hyZlNucXdkQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000df46b-e360-4fc2-32e9-08de93ccad20
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 11:07:22.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ItACsDa0u+VTC7cRMu1rUR9k1CXqBtl0CxTAgVzI/rKrRxGeCyuHC9qEH0S/v7FT1EFHBQf2MGDWu9q12cR+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9890-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheetal@nvidia.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F28D3A305E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 03-04-2026 08:33, Frank Li wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Mar 23, 2026 at 08:38:58AM +0000, Sheetal wrote:
>> Add dev_err/dev_err_probe logging across failure paths to improve
>> debuggability of DMA errors during runtime and probe.
>>
>> Signed-off-by: Sheetal <sheetal@nvidia.com>
>> ---
>> Changes in v3:
>> - Cast page_no to (unsigned long long) for %llu to fix -Wformat
>>    warning on 32-bit builds where resource_size_t is unsigned int
>> - Remove redundant dev_err for devm_ioremap_resource failures since
>>    the API already logs errors internally.
>>
>> Changes in v2:
>> - Fix format specifier for size_t: use %zu instead of %u for
>>    desc->num_periods to resolve -Wformat warning with W=1
>>
>>   drivers/dma/tegra210-adma.c | 37 +++++++++++++++++++++++++++-------
>>   1 file changed, 30 insertions(+), 7 deletions(-)
>>
> ...
>> @@ -1047,38 +1058,45 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>        res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
>>        if (res_page) {
>>                tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
>>                if (IS_ERR(tdma->ch_base_addr))
>>                        return PTR_ERR(tdma->ch_base_addr);
>>
>>                res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>>                if (res_base) {
>>                        resource_size_t page_offset, page_no;
>>                        unsigned int ch_base_offset;
>>
>> -                     if (res_page->start < res_base->start)
>> +                     if (res_page->start < res_base->start) {
>> +                             dev_err(&pdev->dev, "invalid page/global resource order\n");
>>                                return -EINVAL;
> 
> It is in probe function, return dev_err_probe(, -EINVAL, ...);
> check other place

ACK

> 
>> +                     }
>> +
>>                        page_offset = res_page->start - res_base->start;
>>                        ch_base_offset = cdata->ch_base_offset;
>>                        if (!ch_base_offset)
>>                                return -EINVAL;
>>
>>                        page_no = div_u64(page_offset, ch_base_offset);
>> -                     if (!page_no || page_no > INT_MAX)
>> +                     if (!page_no || page_no > INT_MAX) {
>> +                             dev_err(&pdev->dev, "invalid page number %llu\n",
>> +                                     (unsigned long long)page_no);
>>                                return -EINVAL;
>> +                     }
>>
>>                        tdma->ch_page_no = page_no - 1;
>>                        tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>>                        if (IS_ERR(tdma->base_addr))
>>                                return PTR_ERR(tdma->base_addr);
>>                }
>>        } else {
>>                /* If no 'page' property found, then reg DT binding would be legacy */
>>                res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>                if (res_base) {
>>                        tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>>                        if (IS_ERR(tdma->base_addr))
>>                                return PTR_ERR(tdma->base_addr);
>>                } else {
>> +                     dev_err(&pdev->dev, "failed to get memory resource\n");
>>                        return -ENODEV;
>>                }
>>
>> @@ -1130,6 +1147,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>                tdc->irq = of_irq_get(pdev->dev.of_node, i);
>>                if (tdc->irq <= 0) {
>>                        ret = tdc->irq ?: -ENXIO;
>> +                     dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
>>                        goto irq_dispose;
>>                }
>>
>> @@ -1141,12 +1159,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>        pm_runtime_enable(&pdev->dev);
>>
>>        ret = pm_runtime_resume_and_get(&pdev->dev);
>> -     if (ret < 0)
>> +     if (ret < 0) {
>> +             dev_err_probe(&pdev->dev, ret, "runtime PM resume failed\n");
>>                goto rpm_disable;
> 
> can you change to use devm_ firtly to elimiate goto first, then change to
> use
>          return dev_err_probe() pattern
> 


Thanks for the review, Frank.

For the devm_ conversion, it doesn't seem straightforward as the goto 
cleanup paths handle multiple resources. I'd like to send that as a 
separate follow-up patch.


> 
> Frank
> 
>> +     }
>>
>>        ret = tegra_adma_init(tdma);
>> -     if (ret)
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "failed to initialize ADMA: %d\n", ret);
>>                goto rpm_put;
>> +     }
>>
>>        dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>>        dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
>> --
>> 2.17.1
>>


