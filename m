Return-Path: <dmaengine+bounces-11766-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uBRDJmCcO2pQaQgAu9opvQ
	(envelope-from <dmaengine+bounces-11766-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 10:59:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151786BCBE3
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 10:59:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=nVBtEnoP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11766-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11766-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D844F30E251A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0295397E89;
	Wed, 24 Jun 2026 08:55:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521D39936D
	for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 08:55:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291312; cv=fail; b=Wfpal/ID8Z55/cJzFlojHN3YDYsWwFx3A+MjjrEaRBDCe+MieFPdoItsJev5aalKt/H5AB0PA9Rx+A5ninporOG1y1LSKo9K91KrIKBMFyGZIBHOIZV8YcQ7/rKugvuq2qziAETO8z5Kz/DEcyXdxCghBVesScGHj7haeBznUkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291312; c=relaxed/simple;
	bh=VHzPcDyYi+w+nPVD/dLkmTrPluk9N6cciC9PRce4RV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NfTcdcUx3YOzjmwYK4UzStkmeezlOxeC9z9J9GNVSuABpm7tq9ibyzFe2ZKzXPtbXRWk8M+89hWKe/VzarLeU1QWPOWihnNPlBLTzsrvfzSeAt7KxW2OneFg05bCyEbyF0extzdDoN2/GpWeKNQACDMD3l497vxD08nTcOiLuFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nVBtEnoP; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfhXsOgsYSHJNwfqqAWrBgw3RdDcZGoIxolF4bk9wTbWXdzmRiSVzNZ7IOFOxpS/LDwirI9DVMwEAHNhzg4ZCA5hNQoxlbyGrny6S2h4EwG2lwHRE8j5+o/crr3/+glFZMR++/A+MIx9LN8r4UizvBQM5DUH1ZWXwF7nJHmzdRFpU0JYg7sBmlnpLl62EfDhIPYMtbAjr6G4kudCz9RlovOh2QK5xdTTY83mHMgPJWkm7Ff+JYCbqXzvbrZs2RkMCJ5ElRFwHe8AW/PwEKKNuX3/j4lKjth10glUfambc136QJ3VPYVlTsuWDTNBHmnGH6qpBF4l0UCKxOnwyCA1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj79JUb56/+f/8NWwTGZENcSAsj/fu/B1J76jv8lBoY=;
 b=KgCtmqc3U3ryuTTbJ5tIAjXcc6MsK6RezZcyN751VEsHTGoS8AuFhZd5UYy/7OxLcan/fNBMGiXy0Mbdwq4ooB+mB0QAeH49XKCq2BiHt3vEZvXI2rj7FQB0cR9yHxYkMqbEDTM9/JfLO1Y8kM0WH8QeKCNW8jtrxKuTUDx60pxg7tkrRpXbJv6qrIoRfE+Zp2YxyCFlv5AA/Ttyww6hrsC6Cgd+x7WI57jhV7PCpRfqxkZIeHZvqr7iX1wsSd1D+5xNLK/+8TjweK6hIYRFd2QYQX3o2SG2aQmbLLUxZiZJvekN4hhVo2Vy8ySRLqkvNhX9jfyaAnrT2cUtCBt26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj79JUb56/+f/8NWwTGZENcSAsj/fu/B1J76jv8lBoY=;
 b=nVBtEnoPEdBppuKOfZkcF3ZXAokJjusFUiIB7sR+8otcwKkWJl0ojV6QzjUCkX5l2+D75xngkQsyfVqQaELC8qFRcBJN/x4qpxsTIF8WqRcr8575eOpQl+O2OYsDXYbzfJv8HwyZdIJm0rX9+aZH1w+YDXi8OFrIuyO+ilYv0rQ=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by DSVPR12MB999193.namprd12.prod.outlook.com (2603:10b6:8:496::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Wed, 24 Jun
 2026 08:55:09 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 08:55:09 +0000
Message-ID: <79b42933-5b74-406e-a0bc-6675ba86a02f@amd.com>
Date: Wed, 24 Jun 2026 14:25:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: sashiko-reviews@lists.linux.dev, Devendra K Verma <devendra.verma@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
References: <20260623112647.3379581-1-devendra.verma@amd.com>
 <20260623114159.2003E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260623114159.2003E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::9) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|DSVPR12MB999193:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fc36b4-02aa-49b1-b628-08ded1ce4b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	78ilUxXac3v5KoQekQdnS7nLr671nqivJGKLijvYxpq7tykBeBebWpBLOltcB+s78eSf3kkaJlpynWmTFYk+hHDi+IJxYUaQZYbfmLwnfJw7MGo35O1iDDHOntRFXIX+08kpm2O9TS/TCyKEaO9io8wtVvFw44cEObPDzQiWzTkHH8OqVLInPJSXkoGX34ElQxiq4tFWR0Zt54jtHk39NhwIXpB8lFh0gZq2bUFWqsz8Rew58b05YO6TDhcAaPFiFOvOnMnpdrZzAoX18rH+7V5A0W7wISZEQnvt8f/20jGTLWSIYnt8Nbkbts1tS8K+tCrLRPFi24eatraxPKH7yJXH9Bz+opeljPr0UAJH+1NxzNCbtqthWkT8BkoRwjI3GnQmXY7pjvFOzEBY8hNARolQzCDu+wLlBX1J7L/rZtwUA7D3BPfzySrWy45YGCLYn/hRLoZ8Gdgj9aCz/H7aBhz5Ok1g+/mP9xhWz0OB53vPpJ43DsPc1NvzJOsHf+9fe0nRk4jnwbfoywmxi7oCFwBjZm2T+H5YmO7h3q+BPpcGQFsaKKTaM/kMV9FdNfq7Utfq3HDA7a5YSJVNOUd3nVrONCRot5rZWqfRMupQoQ7vLNbYEDlulmg6HjT7d2zaG+03w+bQSXI3vrL31lMbC2F8m1zTs5nYjLp/qOTymHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW92Q05aa2tNQ2lvN3NoaHRadC9YQW9JdmdZazNxaWRNS05XR1B1Zjc5a1FN?=
 =?utf-8?B?Tk9TbUR0dkpSaG4rdUJRdVlBK0JoN2prdlFKb2VTK0t4RkxRaWg1c2JLQ3Vl?=
 =?utf-8?B?ZXREaE9pdzBhWFRkZGJ6L1BqWGRwUlhoSVQwQlJ0V054OVM5MFdhR2lYa0NU?=
 =?utf-8?B?Mlh1YXNtWHlzeUJnaVEzcEhoM2RKckxJSXowVHFJYzVMQ3k1SytnRnp0Y1lG?=
 =?utf-8?B?Rk0wWXd5bndGOWJIbFp6bnlPcUhjeTRpSytWN0hHbytKVFhZbFY1SWNONWFE?=
 =?utf-8?B?Rkp6QzdEOVRZVjNNVjJjbjV3VXZGOWJBV2RJa0VyWWNFTkN5VTNHQzczK0ZR?=
 =?utf-8?B?VEVwSTIvT2p0V2t6ckhSNEs2TXhiUURvejNjcUdoaDgrK0tnOUpmcEluZDRv?=
 =?utf-8?B?SzM1VUtKK3U5NlhlK0RFbW5hUG5kZ3laSXNKVG44VXZCZGFpeklXbFNPbnVU?=
 =?utf-8?B?RHpDR3ZJVEhMWGpFUVZiNzRBdTZEOWUrbWVDWFBVeHNiV1o0RnF2Y2ZOV1N3?=
 =?utf-8?B?Z3o2Y3FWc3N5Ui94WVBFMld0ako2bTBXVHFDQmRHdXZ3WExIZDFuWDhtTWFo?=
 =?utf-8?B?a3RQOHJmTnpJakpRVnp1YWNrZTN0L0Zpa1V3ZzFYRWY4bzFDSWx2RUNreHN2?=
 =?utf-8?B?czFuOW42T2lsWm45UW5hNnc5dW1EN3NISlZBbTRjSis1NEQ4TXhvWFRlbEZ5?=
 =?utf-8?B?S0JYUG1hdDVsWCsvaFQveFRUSTdnK0owaDdLU1lBOThIUU5ENDhhdzJBWjI3?=
 =?utf-8?B?WG9STjdMbC9tY2NNUTNOSEVsTGR6SW5nbUZnQUVKa1RlOE5uaktmbUZXbGcv?=
 =?utf-8?B?NzJFTmpqL2VmbTVEL2JuaVYxQ1JPUHVpUmYrZlRDYzNCd3VvOVlxSklPWWxq?=
 =?utf-8?B?QWdlTlUvUGcwUEQ2YVJGdnc4bkRsTys2MEF3Rk1oTHVidDZmVVZObHdwNWVq?=
 =?utf-8?B?SGw2N1MvaWpJdWwzZDVDeXd6VklIZEJXK3I3Tm54R3M0WUZkZEJzUjVydEdX?=
 =?utf-8?B?Q3ZmV3RqbVllV2Q0a0RzQ1VPQ3ErdGtldVZ2c0k1OGN1cFl5UzIzSTdKb2U0?=
 =?utf-8?B?S1FqMFZiUDFlbFpKMCsydGdoNm1LdmxudjFZSXFiaG8rZE42UjFTT3krME16?=
 =?utf-8?B?Nk1KWjVyeHdhNWhBYzd6OUFoVlV3blExZlErSHRrN1pqbE44UzZDMVI5ZFh4?=
 =?utf-8?B?bEVTSGVEdFpzbGpmZGh1QnlaRDkvUjM2a3I5QWpMSEdDY0h4blpOWEh5cEZu?=
 =?utf-8?B?ZUNnZ0k3UDFuK3J0R25ka001bFZUOTZHbXZwYS93VWZWMHRoSnVlZHNRSUNG?=
 =?utf-8?B?SzloajlFTUxLNnVZN0JJZUYvbFBNUitMVHhLeVRrRlY3elA1YlFYaXZHUzY1?=
 =?utf-8?B?RUYzVmRtbHoyM20wUEpQTnBiTTVtL3BibmtMY1g3N3Z0Y3p2cHI5NlFJMERp?=
 =?utf-8?B?N3dDTm1qMndKYmdHQjV5aDVrTXVGd2lDR0NrUGI5d3VoZEhBaUxDdTR4UGxz?=
 =?utf-8?B?VWJRVC9CNzlUZXdRcElEaGtWbWZqVmtDQkFqNlZodE9pT0pCL0hDVEI5UFdR?=
 =?utf-8?B?UUFXMlZPNEo0ZS9RY0RjbUtIZDh0YjBvd3NJZkJJM0FmbjJtMGNUYkpHK1Vl?=
 =?utf-8?B?b0dOTkRDWHllTjhvVVlpQVRLK1c2WUhOYmdLNEY3WWJMbXJaSWFhdWFnSTB3?=
 =?utf-8?B?YWtlUW1lSGg3YVlTbWpZemRET1ZkUWxKaU1pOEEraHlBdHlzVHlxVjd1Zi9h?=
 =?utf-8?B?QXZuV0tudVVaU0lYN2lndk1tUVhqQXZZaGYzdjVDMm0wb2c5amFLYWN5WWpS?=
 =?utf-8?B?bEVaVE9BclNQa21PVmtmZUFJaG9hNDgzVGplVmxqQWtaM3lST05KZThuNjFW?=
 =?utf-8?B?aWNYK2RJRVJRSVVIc0x1VUIrSnh6OHEyaTM3NmNRSXlCbW82UXl6QWNiSVR2?=
 =?utf-8?B?YjFMZWpOSU93N1BDcXgwSGVPMmVIM1pFcjd3ckl6VVVoRHowUWhwRFc0cmJ2?=
 =?utf-8?B?cmFZb0RhdFpQYklRZVVPblRHQ0RiMnFkT1N1d1VtMGJpckxXYUNKcTJWWWNp?=
 =?utf-8?B?NFp4aVQwb1Z0ZnRYZWxnelRSYzl4M094VjczdHgxQjFyZkZDN0JTTlh2dk5y?=
 =?utf-8?B?M1F0V0tocm8yQmZaeWpWbmFKcWJNN0psVW1mczVTRXVjS1R3WlFmMHVkZlNZ?=
 =?utf-8?B?NFhBVFNUaXJZTTVNUHdLeUNTZ2xCZWRmeGJyS25HYXFiWXFzdmFZMTJaQzUz?=
 =?utf-8?B?UlAxbGJhVUN0dnZIUEQxdldQRDZsZlhTek9lOEFBanVWYXNGQkZ5MHA3RStz?=
 =?utf-8?B?TGJ6aTU0SlBjTkVPTWJhVi9jSUlNZDRVc3BaYkkrWUpuRDFsZjExQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fc36b4-02aa-49b1-b628-08ded1ce4b3b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 08:55:08.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OZsIO34Kdf+to1GwePCLr/L7M6xWvURmzLKNyCCcdLgPoGYR3Gdqw8dL6k5P0E5AF66havAJDb3wsBgAnUpmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999193
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
	TAGGED_FROM(0.00)[bounces-11766-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devendra.verma@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 151786BCBE3

Hi

Please check my response inline.

regards,
Devendra

On 23-Jun-26 17:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The 64-channel HDMA feature is unreachable due to hardcoded legacy limits in the driver bindings.
> 
> Pre-existing issues:
> - [High] Potential NULL pointer dereference if a shared IRQ fires before `dw_irq->dw` is initialized.
> --
> 
> commit ae4f94060e0e6e5d4419cd4f95926541afa41dd0
> Author: Devendra K Verma <devendra.verma@amd.com>
> 
> dmaengine: dw-edma: Enable HDMA 64R/W Channels
> 
> This patch expands the designware eDMA driver to support up to 64 read and
> 64 write channels for the HDMA controller, aligning with the hardware
> databook. It introduces new macros for the HDMA channel counts, expands
> the layout of the channel-related structures, updates channel masks to 64-bit,
> and updates the probe sequence to configure the core based on the controller
> type.
> 
>> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
>> index c2feb3adc79fa..adf1b3939f96c 100644
>> --- a/drivers/dma/dw-edma/dw-edma-core.c
>> +++ b/drivers/dma/dw-edma/dw-edma-core.c
>> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>>   		irq = &dw->irq[pos];
>>   
>>   		if (chan->dir == EDMA_DIR_WRITE)
>> -			irq->wr_mask |= BIT(chan->id);
>> +			irq->wr_mask |= BIT_ULL(chan->id);
>>   		else
>> -			irq->rd_mask |= BIT(chan->id);
>> +			irq->rd_mask |= BIT_ULL(chan->id);
>>   
>>   		irq->dw = dw;
> 
> [Severity: High]
> This is a pre-existing issue, but could a shared interrupt fire before
> irq->dw is initialized here?
> 

As this is pre-existing issue it shall be taken in a separate patch
series.

> In dw_edma_probe(), dw_edma_irq_request() is called before
> dw_edma_channel_setup(). The IRQs are requested with IRQF_SHARED:
> 
> dw_edma_probe() {
>      ...
>      err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
>      ...
>      err = dw_edma_channel_setup(dw, wr_alloc, rd_alloc);
> }
> 
> If the shared IRQ fires immediately after registration, the interrupt handler
> might dereference a NULL dw_irq->dw:
> 
> dw_edma_interrupt_write()
>     dw_edma_core_handle_int()
>         return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
> 
> Should irq->dw be initialized prior to calling request_irq()?
> 
> [ ... ]

As the issue existed before any fix of this patch, it shall be taken
in a separate patch series.

> 
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e3153..da7a5cc93ad43 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -14,6 +14,8 @@
>>   
>>   #define EDMA_MAX_WR_CH                                  8
>>   #define EDMA_MAX_RD_CH                                  8
>> +#define HDMA_MAX_WR_CH                                  64
>> +#define HDMA_MAX_RD_CH                                  64
> 
> [Severity: Medium]
> Will these expanded 64-channel limits actually be reachable with the current
> driver bindings?
> 
> Looking at drivers/pci/controller/dwc/pcie-designware.c,
> dw_pcie_edma_find_channels() still explicitly enforces the legacy 8-channel
> limit and returns -EINVAL if the configuration exceeds it:
> 
>      if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
>          !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
>          return -EINVAL;
> 

This particular function targets non-HDMA platforms which suggests that
increasing the channel limit will not affect anything here.
This code shall be retained as is. It is not affected by increase in
limit for HDMA channels.

> Similarly, in drivers/dma/dw-edma/dw-edma-pcie.c, the Xilinx MDB HDMA data
> statically declares 8 channels and dw_edma_pcie_get_xilinx_dma_data() caps
> the write channels:
> 
>      pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>                     FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> 
> Do the hardcoded legacy limits in the driver bindings prevent the new
> 64-channel feature from being fully utilized?
> 

It depends on the user, how many channels it enables. If user wishes to
enable more that 8 channels, be it read/write, then the current code
limits the channels to a ceiling of 8 channels which is a case of
under-utilization of HDMA channels. This patch enables the code to
handle the max supported HDMA channels which is 64 Read/Write.
Thus, using any number of channels below <= 64 is fine when using this
patch. This patch would not create any issue for the existing use cases.


