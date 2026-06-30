Return-Path: <dmaengine+bounces-11883-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bP9BN6ZwQ2rQYQoAu9opvQ
	(envelope-from <dmaengine+bounces-11883-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 09:30:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B766E129F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 09:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=E6jB4CgW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11883-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11883-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69657302EEE5
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8C539A048;
	Tue, 30 Jun 2026 07:28:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685C394797;
	Tue, 30 Jun 2026 07:28:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804535; cv=fail; b=N4VjMZrTyx93DGSJKaGIDdXJEgPzLSN/Jghi4p7ccPR8WT3R+lN69sJOfO2Ax5aas7Kpa4xqKafRxvSWBHQ4O18Q4QCPEXvGPmIlWxrnJlLJxVjEN+/zDrsEvVaPn2dwV5Gl9+Nm743fHdUxLbVrR28+YqxYWyiUtd2QgMQkoUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804535; c=relaxed/simple;
	bh=vZc9QZezLBe4ofRFu2YUMNatj7XLPiAhn/V0eOj/Nx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c68e9+uhWBrJ7KYI2N8vPBO6zMb5Zjfs4d1QjJNxLshqLarOkmIkeW/6V5XJziFAi2QLOwquLTnWlCYWWnWlOyOEAC7mFFLJhW5YrJ2uJrCc+SfMi0AkgP86EK3j/XgnP+/v1lW2VzhGyYLvQHYpEy8nySJIxFpDX1lsSuXhyzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E6jB4CgW; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9zDriMOWBU+FgVAPOB/FScCaw/JbrdbXDe/AhEv92m29hrl41tXxxYBHd3w1YKsiGRane7cEoQudLKiw3GmDKjMYmP820pbb7MmHyDVhxYuI6A/ygjbKKvf1bJ/PR9XuF0bqzk+qUgGm/u0PyQ3qUhoDAI64E2AMOFc/S7niJt4ExaNdnv11ziCftibGpQDxqeneuiY+aFbOTRxwtNpZk36cBKCLueiCjz+GUFFJJO7ZAQlE+VcB/fQL2tzQAs9ymBq+sS2ZVtOR8NCMs9HhdQnQrRV7KuaOq342sEDYiQCgnx+ffF1+80ogrDzGXqgg4PhzhXCrAbds01xAunKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVMUpXXrRzZ4nFpENyTUFcUQRrUbM9ZVKruk5kuzPkU=;
 b=Cvcb2FAd+xizEwvIQCQo7ZO7ono95tQZ7a0CuwS1ZwIzB1QVzWsM/o78gP+blqM2dWuwxuHY87jFKwxizALYBGFhgHvXYAe/pASZSUUqM3e3Ka0ay9SgN2DOTKwgjCjIvu0GWqQtLBhnEixSwARUvT2COsS2rmJUZbnQN8Bm2NXr52URTTPCkp8N3RnWlf8Ng8FHqAMYCTBB/aSsha+xl+fLO18wxGvzXpu7GQ/cazwQ3kwtMqQDulzK2Ea8YQCaTuokM48nE+TRX/R4+d1GzPMek7R0P9QffFLulfqD9pwRgaT9L1eayPdtAP2hzLtJDGd5GLyMsvbCtb/LNckW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVMUpXXrRzZ4nFpENyTUFcUQRrUbM9ZVKruk5kuzPkU=;
 b=E6jB4CgWi6bmSovni9EBU9m42HDmfRMjSFStZruDubH6JPREEreKixq3/fORO4unRmrif7XNOyzQphbMGeEny8eS0XlZDOjXPvs8D/jYwXiVSlBcvhyMrkTQmAygvqSXItYBBBczMlohMdNsO5NvZXU058tOta6S8Iru43nPFzM=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 07:28:47 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:28:47 +0000
Message-ID: <99d3ff5d-27d5-414c-b291-49426643e821@amd.com>
Date: Tue, 30 Jun 2026 12:58:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: zynqmp_dma: fix kernel doc for
 zynqmp_dma_remove()
To: Golla Nagendra <nagendra.golla@amd.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, michal.simek@amd.com, abin.joseph@amd.com,
 kees@kernel.org, ptsm@linux.microsoft.com, sakari.ailus@linux.intel.com,
 radhey.shyam.pandey@amd.com, u.kleine-koenig@pengutronix.de
Cc: git@amd.com, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630064844.705173-1-nagendra.golla@amd.com>
 <20260630064844.705173-3-nagendra.golla@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260630064844.705173-3-nagendra.golla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::10) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b5061a-a829-41f4-eed7-08ded6793904
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	UkzGurQHxM4hTgnjtySoohlcD3dkLcPqkw3Qp9DKMSo8YKcx3R/Z+Wd0DaW9DomuPvMwmRCAA5IoXqSy6Qt4YQ4Uq4IiGmqd3N49Bb89npVu/DQkl9JvTifLaVFDjcnbwtLwbyEcGTdpjr3uo2vs+oEnp/vu+ZcHcr1J+cEyX3v8qvE1rseSoMaV27C6qnUYbKVc2EPLUa7jyR7C5pCA1jt3sJN2U+jH0W2kvxVMXCqrS2WUiDeIfYqv/Thr2yGi7Z1KYIxkKfo6mEq93nJLU5bmSWL2sN/GiGXweBvpi8i3aO+sNl66eaW1HwCL69cwe9nPi6iEijnVsytTzF4f25M5H7kWfFnNKZS8WDndtyhBZ7qxGovBu2CtrVoOAFN8/cJCycNwilEbTM4tpPEcl92Q2uEG7VXQbF7dD3C08UBGU5inMntVIeskBfOLHMMlQK8SRBBfW6qLZHvpNhnPZ9NHelvMbBgMTWmlinhTBPWTPiNJWdGmNDo3DTELPEznCG21JgUdCNIx/0Vv4b6HVQkRzZrbFqWSpwtCIrJFN+s11qhml6hc1NaXLCA2T9jTCWL5kInCYb/bD3mxEPuV/ikMp4/zfPV25+IyB2gGlpU/1TsHMsyrIUghLs53kd39MP6SICvz1APU0+l3Vs+xLnUq252Z6cEDbJYiOSRQ3qZCm7WZV+LVqYYQAgh9XpbTq9zPYAITTVJOT8ltBuWtQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhTTVdRQkNVbVlNK0lzb25GVHF6VXdUMVZlTDhiYkxQMmoxMWFPK1RFQjdF?=
 =?utf-8?B?eUtEQmxHanVDSkRlbDAzZ1FHL1hpejVYZ3pSUVlZUUJwcEs2ZC9XSml3OXk3?=
 =?utf-8?B?c25JWmorS0ZtRkdSWW1Sa0x6eTFsNDdNWG4waGVzOWNIM2Vvc3V2NW1ydTZR?=
 =?utf-8?B?RzRXWjdzT0xpL2ZFNCtGTEVoKzlGZEJ0OXFIV0xkSXdGTzFHelZiSEFFS281?=
 =?utf-8?B?VHVPYWQrUWQxUDNwOWtuOS9ONnJiWGlQcGVTN2RmcnYxeXEwTlgvSjdGbU9z?=
 =?utf-8?B?M3ZTbnpoYVliamhtTEZneU85OG01SXVtbjQ5V2xrcks3ZWtVYTBkdVZKdDYx?=
 =?utf-8?B?eHpwMGtBQ3NRV1BZanlRUDhOcGVRWTJRdlRkdjYzUU43d0lqblFDZFJZbi9o?=
 =?utf-8?B?QS9XVG1BNTdyV2phbTVhbnI3cWFWQUxCdXRla0ZYYzZwZ1hzV2QxZkZoWUdK?=
 =?utf-8?B?cGFsa3pMYlN6bXlKaHNjYkkxelgzenpXQ05OZThGRmNBV3dtakR6cXAreC9k?=
 =?utf-8?B?UlV2TFJJZE9UUUhNKy9aVHJDV0ZPL0ExbkM4WGQ4NEpLdk4yVzJEUnMzbHd4?=
 =?utf-8?B?WUpZUm1TaVNQVCs5R0N5a0w5K0FvVnRMZzJoY1B5U3BwRm03MElldDdSWnQz?=
 =?utf-8?B?VDAvYzM4T2M0Smp0aDZhOWVxK0l6RTIwMnk4WmpWSHltQWpoU2ZKOE1HeWF4?=
 =?utf-8?B?K2ZpMFQ0enVhQXNZNU54Q0ZnYXNZTWpkN2tDSHk2TWFGeFZrUG93a2F1ZHZE?=
 =?utf-8?B?dUNETzdZcTQ2alRDa1pONXZMUTlNc1BTLzdwTDNONTlzdkJBUTJ6RDVtLzIz?=
 =?utf-8?B?YlhDR2xJOU9lOXBGbmNSVnBKZkREMUdManpwWFMyWTZ0eDgvQTU3U2t1Z2pj?=
 =?utf-8?B?Q2ZDdnU4VGV0ZlZRNS9XazJhbFNLS2dZeUVQeDFSYXFuSUVJZ0lVWlRaN1RM?=
 =?utf-8?B?TWs1SEU5N3I1eTNkREhnaGdCNnJkOHFmTGN1TWJhR2taV3dXeTAyQXUwQmVC?=
 =?utf-8?B?dzB2VG1XOUpjclpzdWdPM01OSi9rNllIbFkyVU5qQlpueTVCcHUrY1R0QWNk?=
 =?utf-8?B?d1lMdFdybFBWVVEwWmlkR2loRHZ3OVF2WEhoZ20yWnZLc3JPeU85Zks5c2w5?=
 =?utf-8?B?SFF0SWs3WjkxallEem81elVBVlgydnQzTVVvQlVURUs2eGNBeVJDdWhIL25N?=
 =?utf-8?B?Um9PbzdERkpaMzV6V2NBNXZYSUsrV29BR0Q1Smx5ZFVZWEdRS0RVSnJTYi9y?=
 =?utf-8?B?MlhDdDRHdTRBZUZSSU5GT2RnYlZ5djlUb2FzUTlyaXQrSUxXeThBazFDdmw1?=
 =?utf-8?B?SHNCNm1ySHl3d1pOS1lzMHVoMHBLbGlHNG1RbEJ5WEdpUCtvNGZIRElpSFZW?=
 =?utf-8?B?NmdUTGRVZW9saGl1QmdwUG9PWE15UkZydTdjMGVKaXd3cXlPZVUva1BUa212?=
 =?utf-8?B?em04SWIwZ1ZLV3hLVi82b1lQWm1tMTlyN1l4bjVLZVZLdlpTZzRzOTJhQlJl?=
 =?utf-8?B?TUNLUTlZNEd2dmpnQ09KYkxnTlpLVm5uams5MWlLZGlSNUxMNDlIRUJSVnRB?=
 =?utf-8?B?Q21JOTlhWDczdjRYaXU3UENPeW5hOG56K25UR2QrWkdVQ2NaazViZzl3WGI1?=
 =?utf-8?B?YXJwaVVMd21YK1RtSFJ0dE1wamsyQi9CQlJVUk9vU2ZaRkVrWkxYRnB1bXV4?=
 =?utf-8?B?VjF2NXFuMGtUZGVQQTgwM0ZkWm9ocTBXN3dhUjcwZGFOSENiWXI3N0ZsWndv?=
 =?utf-8?B?RDNYN2F1NEVlbTRWQ2RSTkhFS2M1VjJyRmZzZk1SdXJteXFHQWNOK1B0VDJG?=
 =?utf-8?B?TU9oTnhCcUh0SkpJeXhQTllUVmpaaTd0d1h5dGNKWDVZdEZaSVlsU2piN2xF?=
 =?utf-8?B?NCs0ZEVMcHVNa016UXEzdU5hVUxMLzZsSStsalNEL3Y5bUNFcUJYTytRZmwz?=
 =?utf-8?B?U3hqdU1SUmRsN3dFQzhobHpnNFFhSXIvRUx5QkZQZk9XNlgzRE4vc1lKY0xW?=
 =?utf-8?B?Um80Y3ZmRnJsRnZ2MWUwMVZvQ3c0dEFtRVluS3lRblhLS1NsVnZGSEcvOHVy?=
 =?utf-8?B?c21NQlBLeUo1YW1NN0F3NGRvTTh2VytWM0pHTGxGbm1HbTcrZmVuU0Z2b2tP?=
 =?utf-8?B?bitmZnBwamhmRFRJNFpISEMzZFNwb0VoNFcvN1l3d1Fkc2R1cWV4RDR6YXdU?=
 =?utf-8?B?VjVlSUZITzVtUlpWNzNKMHl3RlNFUGdQcHhiQ2FubWtFRUxZOTRqc1laOTQr?=
 =?utf-8?B?R2JieFY1RGdOVnMzRVJuR01DTm9YeW9PaXZWWThMcnh5MEUrZzJvRFFPWXNw?=
 =?utf-8?B?aGZSNVBvUkJNcjYvd3FVTFZhaG5KTDB6SU5wZzFGM0lzUVlWRCs1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b5061a-a829-41f4-eed7-08ded6793904
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:28:47.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIaVZTogzzfhCGjNJAbUCRZX5/3Bwd3UtOuc9jOzanXgKFxZr47TeML4a4zJ7eL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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
	TAGGED_FROM(0.00)[bounces-11883-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nagendra.golla@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:ptsm@linux.microsoft.com,m:sakari.ailus@linux.intel.com,m:radhey.shyam.pandey@amd.com,m:u.kleine-koenig@pengutronix.de,m:git@amd.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B766E129F

On 6/30/2026 12:18 PM, Golla Nagendra wrote:
> The zynqmp_dma_remove() function was converted from returning int to
> void, but the kernel doc comment was not updated to reflect this change.
> Remove the stale "Return: Always '0'" documentation that no longer
> applies to the void function.
> 
> Fixes: b1c50ac25425 ("dmaengine: xilinx: zynqmp_dma: Convert to platform remove callback returning void")
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

>   drivers/dma/xilinx/zynqmp_dma.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 26f097db593d..ba6604dd7153 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1177,8 +1177,6 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>   /**
>    * zynqmp_dma_remove - Driver remove function
>    * @pdev: Pointer to the platform_device structure
> - *
> - * Return: Always '0'
>    */
>   static void zynqmp_dma_remove(struct platform_device *pdev)
>   {


