Return-Path: <dmaengine+bounces-9617-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJvdG11twmmncwQAu9opvQ
	(envelope-from <dmaengine+bounces-9617-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 11:54:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35AE306CE5
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 11:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A9FA303ABFA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713723E5ECF;
	Tue, 24 Mar 2026 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="En1BNxMD"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0E3E6DE4;
	Tue, 24 Mar 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349206; cv=fail; b=KyGa3uEpx67GKGjCHklxFUXXkIoOjYl6na1JKMqSyigOLtzu+ye6/3udI5BqsfL1Q9qkSH6DhYnhIFV4Q12/D0fuZRWJCNsJh5KNP/lRSo8fXEqodvAXwUEX/9GRoTq/tRmPsCZCufKOQyu9P1voFI+CsKim6Ei+BUdoYATFNeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349206; c=relaxed/simple;
	bh=wIokt4ywa/YDLXH4rNMG41hA4KqbvYZds1Jp+DIuD6E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jC8zFfBTu1KS9NopZSJ3CRhE1V2vagH2Mgxa5aRZ7onx9QNNIv1iYRwjmyRQjmAisQr7UsePYyGc8RzID09GhZjfcEZAiyOmCacUMGDz8vqOQUXrZhkSD03b1tpZiuG7kacFt/k5r3srh1IF5tuWpflDuw2VKdjiRgQ4mNEzu6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=En1BNxMD; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khwhB4FseL3VioZnObW/suhV39KbPa9HGzvaPDFtrcHhfpYdH9L752+zSyBNIp9lZGCIeYxkeZksObA1GY9pOus4Qjkfm0/EGoU96WT3RmyMT3XEPgunnXiibRem3Kbum+YBWPz0XSwt2+umHHvROwEnFpE7T8QqFey0qqN7Ea3vdIZ0yloa78q3frP19uJMoWr4g+7xxPqUprjtGSYf1seUqbsr2lnecEFE/O8VQil0iIdlilYEFAZAwk0iLFSKVAwMGxYuJfh4IFNAsdUWyMkzSml3PNRQwWaXSt4ANcoYC8V/gItked+GBtjZi+5Hgxgn3Ay4g92vgrXY2o5MSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTOIQPGQ3G6IfAErTI8UTvP0bnD9xcBwd0Y2htmCQt4=;
 b=BiUXAOTLTl6HfPOd9568Pc64TPSOiS30BxBXtCSv6YkI+R8oGZrnxHBEYsgbP5FBuwLNXsQp/KIVjZD77euvqjqNInnBsOT9VSOkDBAHVkujUOjQnZYwb87djE+AKf7qaZcv7P4HOdHpjlmeQAeKqAhPOjmZFbHlLI8oyODRso7O6ih4a5m1sFVbzKNIvFNyymd48ZAIrnzC4+o1YEujxPeIeuDNUAY6c9pspQCmM0RaFJhCdLULBOAvddl9/lxHvpsJGW+NdCYnRsq0c2Ca4uxB9d2I9iPJN0rVPqywgmJ5iow7Qyl8FRxMO80I7n2hNu2kCwAewz1weiftOLGPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTOIQPGQ3G6IfAErTI8UTvP0bnD9xcBwd0Y2htmCQt4=;
 b=En1BNxMDXIf6VuiXXBS7f4pEqpjvPmQvtt0hLsQy3rEpPTASmsH2YLHSrSkHdH/Hnx5KKfEFXUX6TUj3S/FQUVkqGRXzKHwe8PCDu2BhmTSPTrpA4pMNycrP4d5YcicJA9qTun+jgGxqOo4UhA08FIBnxskXkLLx+c7Vo4zo6KLz5ZBE85ZikisDcN1TtpxphfJoNExI3+TIzW5SDqOFAeK7KD2WxOQVgyb3GNSg7dTpJBa1kzkhHn6RRyY9g30OS+G3UNG3BlBK9qU/2DEjZAU727cjQ6oECcu7WafpoMDE/aYHubQzePjLgdlSPScpgDRIgHcj7fNODacWgipJrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 10:46:37 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 10:46:37 +0000
Message-ID: <9d203e60-6aed-476b-b0f2-36adf7f8dc7c@nvidia.com>
Date: Tue, 24 Mar 2026 10:46:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] arm64: tegra: Enable GPCDMA and add iommu-map in
 Tegra264
To: Akhil R <akhilrajeev@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260316171823.61800-1-akhilrajeev@nvidia.com>
 <20260316171823.61800-10-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260316171823.61800-10-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::26) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ed26ae-a72f-43f7-71db-08de89929fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3w3CHzTHjVNalWWCYEKYM+GyjNLbx/Xv9ti6+wJClJ2YtdX8NZEyTyx5ZXpzMRt5G45M232GRg6bJbBWfmwMCCjwUmICN5V/B1s6Xd9sO6zfjpwLWOM0BRdLLVE46wfKIHgM+2w9/UampVRFT+te5T3adLWCtMoILMR5O2fmCT3MD+LDKH5bPx18rWxzklJ8aIgBgW3249f69Dj8lu1qG6ImWz6cE2Jh0qcuBgjUOaHlnpOf1djI+Ndz0G/M9jY1OGqfBpUSJq6TfEeM6q4k1H1eOR50sMou554Gwfa/9VCY9Y9oxQKFPJPoQZftsCmBq9tHSHNOpvAtcR2ViXa5tvh4gMbPMfUxLJvbmXLZ/sp/W9z7cC1dU44BOCyHnAwjyuuZbbOwzkAoTQk2OvEVOvwrNfOkpIYzf9kiIxrWFQ1dSTAnIPm16V7UaAJWp2NDsclVvdVWxrc5PHE+osvZ8y/HHeRrto8tnMBm+c+I5X2pmvGEYK2u26wUER7h0BszWccSTEdQAGUfOO09Yq2YiIPwvdcZEBtvARYqhSgVJZ1bBKln9Bt5F/gpiJnzzAKZd0YjjuZpVcfLA+nH++cw2YhuVrQTHVCyPAsjsQyHUMLrE2lhQUDvwLo7hmt79HwLWxCzzQBRURKvb6J7ZsSA70nYGQWyYi30E/m0PvUq3UpDSt8UtnScXRhKh6uct7rRLGzW7ao12YYKAOv60UrA4sf85OdxuTiblbIUj2c2BkiM2Ddawad2VmKc4LCZ+n4qGYJZUN7f06yG47T2EQsnmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmJsQVRIbDBLakRWZjlwRDhyUnN4ZGt5SFZsNUlVTGJuUzZaQ3VscEgrL0tu?=
 =?utf-8?B?R3ZtVWhBMGNHNUZ3ZlRwM2pCWEt6ZkNET1VTN01RWmlFeW1GSWRqYkFJOHN4?=
 =?utf-8?B?TXowZ3g0MkFreXNYWDU0RFJwVldVVGo5QzBCSkQ5a3lIVDBTU1lMRklvT1U3?=
 =?utf-8?B?L1hsNzlmQXprK0hlbmw4Y1haZ3Y0ZWlpTk42MmRBQUdsVURoYWV1VFF3MkZi?=
 =?utf-8?B?M1ZQS0gzUFJPcG5uK2lnUWRvMWpvZWFNYlBwTmtlYlRuMTladStQbnh4TExa?=
 =?utf-8?B?YmFBMDlhMXl1aXpyUE04M2hlNGZuQkRjT29ncmZyUFVzZ0gwYzV0RTVGNzZ6?=
 =?utf-8?B?Q3JJOHMrcWdUWFlTWE95bkZ6djRQQkorczR1V3V1STdieEoyRmF2Y0FieGxR?=
 =?utf-8?B?b2I1OVR6WjB1YXpIa1VrU2JTNEQ5UGpxekpJU0J0RXptY2FjTWRSNjNQSFhU?=
 =?utf-8?B?elhGUDRlZS9LTkEzbEN6c0tqVTlmRGoyaTdvS0ttZWNyRW1xWmVqUjdOT0Fn?=
 =?utf-8?B?RmJzOVJhdVhNcVlMR1RSZEFUUWVjQjF2blFXOTlHT3JnUzVmK1dLQnNLd2dG?=
 =?utf-8?B?NGJhWFp1VkRsQkI0WmRZcFpPOTVFa0pYYXdCQzBmVUVWaEtxdmhLcHkyRWl0?=
 =?utf-8?B?YU9ya3haV083QnBpcGUrVUtzK3NUY3d2NHZqSTRuR1hSZmNpVG1SRzVZaXRa?=
 =?utf-8?B?UmdvTHZ1K0Fyck9KSVRBTkhCazVNOUJSV1E4RHJpYnlZWlg5d2diR1BRMUZv?=
 =?utf-8?B?U3kyTE8zTmRyLzFvYld6Q3Q4b24xR2NGS3VLRmo5SFVQS1N1Q2RRb05zdmlu?=
 =?utf-8?B?T2s1a0ZzcTNHc3B5T3FWeXF6c01Da0h6RHhzNThpZ2U0OFJ6bms2Z0hVNzVY?=
 =?utf-8?B?USt5THRMMXdwTWwxNDRGYkdEZ0VFWWpFYjFQdTBWZkw2dDdqNnBSU21DaWFk?=
 =?utf-8?B?ZlFKV0gvN2twSUxxVWhkdFNNT1htSXhJWXdid3NkbzFKNi9aS2pBTFIwa1Nk?=
 =?utf-8?B?YTI1WVVBME1qWEZLdFFEMEFCcmdvdjJnQyszT2tpQW5ad3QwZTJ1cUFKT2R2?=
 =?utf-8?B?OFJtaXRNWi95OWdYZC8rZWV4ZTRnSi9WSitzUXpGYlc5U095TlNXR3hIQUlm?=
 =?utf-8?B?ZnhZdHVzNGpYT1BOczF2VzU4Zy9VenFKTXExN1pwMmI1dDNGbjZSRDZrUWt5?=
 =?utf-8?B?QzRmMlVka1FpUWtTRnM1b1FQLzA1dVc0aG1ycUZRazRKMEgyZDBHZkUvRXlt?=
 =?utf-8?B?MzgwbS83WmxkK3o2SHl2WWRvZzBqbEdCb1hZeDhYYk5iUCt5dTdLU2d3SnJX?=
 =?utf-8?B?eHBLUmFTRGJYbEpwbDhDU21yWmFyUHBaMzRZZTRJbEU4aTJualFaQ2tRYngw?=
 =?utf-8?B?VlFQZWFVTnNyVHRwdzB4YlViZUdYZlZ1NUxSZm9Nc1ZWNXlXRGVEYTZCYjZ3?=
 =?utf-8?B?NnlLcG51ZjJjdDdVQkZmdW5qclVJNm1zVDJWMUZlS1BuSS9aay9NU0dBUTJK?=
 =?utf-8?B?UFlhOFVYTlJFczNnKzVDUjVJcXR3NGluMkJ2cWRpSmVVMFVFOFZLaWR5ZFNr?=
 =?utf-8?B?MmlxQW8xYWE0SWpyNWY2N3R2TTBIdk00WnlYbm13UjNSbWtPbFhhb0ZYMTZL?=
 =?utf-8?B?WjViLzNTR013TVlvRXRNNDAxSWdZSHVRNDJySUhiaFRyWThqOHpaTnJhVDB5?=
 =?utf-8?B?NUZqenVQYXpuQkVoWmhrbDEzWXZjWDNzTjErTW41QkZLeUc0NFJsMUJTVHRq?=
 =?utf-8?B?M3VZdUhJb09CSTU1QVBvdDI5ZUtRMFJwQ1pUaXJXbFZJckRxRk5YZ1owQXNH?=
 =?utf-8?B?a3JPQm11MUVxbTNkNFFCVHpWVjkzTXRXaDRBS1BUY2pjOTVSWVpsN01XOE4r?=
 =?utf-8?B?bENsR0RwNm56ckZubno2enE3c1d2TE1PRy9mN1dEcEpQR3I1cnVXeHJKamIv?=
 =?utf-8?B?TE5SUk5hVk5vaWJtOFdkZ1pNUUw5ZmJMYm1WRlhybTF5RTlGVWRQa3RqajZQ?=
 =?utf-8?B?Y0lXaUh5RkZwdHNzVUE2aEpmcjkvM2xkUHRJb014OWZIVklWNXY0V2tWV2xG?=
 =?utf-8?B?NGZqWVFkclBPbXpWMnpScGtjcHNhcldrZ0ljMmpWeXVIUnphTnV2NytoOE9m?=
 =?utf-8?B?cVJrckZpbzVSeXNtV3ZuVHVZbjFCZk1EalFXS3FuOWN1S1pGSUV3TENMd09a?=
 =?utf-8?B?MGgzTEFjUnlVSytndGM4NVppNjRIZ3Rqby9YeXl2NkRvbWUrSkFwVzc0d3Ra?=
 =?utf-8?B?TC93cjlMdy9LamZoeW9NK3l6eWZzYUtIRFFuY2JRQkpESDBVRTNGNGxGRFlE?=
 =?utf-8?B?eG9iR01KQ2ExQk4rSEJoSTgyeGJBSHNrenJLYkJSanlEYmJsQWFQZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ed26ae-a72f-43f7-71db-08de89929fdd
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:46:37.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd959Xa4iuRjRLQtcZvtpxuFo1KWs7GCQJewujb35mciuGz3YzyV+iOvTrnkfcXBHYnprU+P0nclKG8q3QH88g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9617-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[226.204.49.0:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c4e0000:email,0.128.44.128:email,c5a0000:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: B35AE306CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 16/03/2026 17:18, Akhil R wrote:
> Remove the fallback compatible string "nvidia,tegra186-gpcdma" and
> enable GPCDMA in Tegra264. Tegra186 compatible cannot work on
> Tegra264 because of the register offset changes and absence of
> the reset property.
> 
> Also add the iommu-map property so that each channel uses a separate
> stream ID and gets its own IOMMU domain for memory.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi | 4 ++++
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi       | 3 ++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> index 7e2c3e66c2ab..c8beb616964a 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> @@ -16,6 +16,10 @@ serial@c4e0000 {
>   		serial@c5a0000 {
>   			status = "okay";
>   		};
> +
> +		dma-controller@8400000 {
> +			status = "okay";
> +		};
>   	};

We need to fix the ordering here, because we order these according to 
the address. Thierry may be able to fix this when applying.

>   
>   	bus@8100000000 {
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index 24cc2c51a272..b2f20d4b567a 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3208,7 +3208,7 @@ agic_page5: interrupt-controller@99b0000 {
>   		};
>   
>   		gpcdma: dma-controller@8400000 {
> -			compatible = "nvidia,tegra264-gpcdma", "nvidia,tegra186-gpcdma";
> +			compatible = "nvidia,tegra264-gpcdma";

Ideally this would be a separate patch with the appropriate fixes tag, 
however, there is a dependency on patch 2/9. Really patch 2/9 should be 
the first patch in the series as this is a fix and preparing for 
enabling Tegra264 support. And this part should probably be patch 2/9. 
Then this patch that enables this, the final one in the series.

>   			reg = <0x0 0x08400000 0x0 0x210000>;
>   			interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
> @@ -3244,6 +3244,7 @@ gpcdma: dma-controller@8400000 {
>   				     <GIC_SPI 615 IRQ_TYPE_LEVEL_HIGH>;
>   			#dma-cells = <1>;
>   			iommus = <&smmu1 0x00000800>;
> +			iommu-map = <1 &smmu1 0x801 31>;
>   			dma-coherent;
>   			dma-channel-mask = <0xfffffffe>;
>   			status = "disabled";

-- 
nvpublic


