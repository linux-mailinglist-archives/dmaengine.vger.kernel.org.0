Return-Path: <dmaengine+bounces-11187-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gnX9A226ImpRcwEAu9opvQ
	(envelope-from <dmaengine+bounces-11187-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 14:00:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDF4647E79
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 14:00:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=hsXISAS2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11187-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11187-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C3C3002120
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45061407CF2;
	Fri,  5 Jun 2026 11:53:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52352EEE70;
	Fri,  5 Jun 2026 11:53:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660395; cv=fail; b=kj49sZxc3mtmVPZMI6K0RU86Z74uqVS1Ha35SzvSMOE93VHZ69aNRwcHljQSPS2odRqA0OuklLZe5D31s01GDz6yscdy7tPZs4WQezDiFelaQmZy6bc8HKrofZFvqX8XDG1HYz5vxGw1IV7DwJBJYmo1GjM22F9kpKHZExDDxF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660395; c=relaxed/simple;
	bh=L/ro7svl/7hKsKWkZkg2XvCN0/19vMN+jQC2QM+pzPY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OB/ebV1YWgSQLLOie/tO3bLVISVK72mTMx4mkg4d2jbgp6IVqbVws+cXnccPkS2tlv0AYpWSaHi8YIR3h5NWaTsRE2D6igcsMv4Otvon7lKSDomfc+s3flf3sZQpILRw4YZVajGUm/EnKj3hQwrn7E5KEnoen0sYTZUrp6oflZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hsXISAS2; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6JZhjzg50olVcAyLWLTqwmRMdD+x+CmJnfIuRwyaq/laospRHqvtgRZ9VqlVJIEhC65zl7q1qAGnnQJdaLXWd4ZLlwVLMHcLJlEMVXZhPQpDyhHKNJ9j7actVGsEOnaByfRkz9N8Wzv9519FHCDkiV4rWqTCCLbZCdJXUsFAnXIKbE0DduBObVV/aN2hZDkDn2KRu6PBGTeQcCb3WkML1+61K0nfJKxEgaa9Vmb7i36/rnAl+Ugr7s9Dmn/euo/kyVkTvHbEVpXHhvqm8jLeO7uk4cEwc72lVCNhpPTnQK7t2ywqOgSRmWhnivGwJkYeEeCGiepjJrEROmuWwiPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Alkk5HJxFnQ35TNOaK2yBZ5cbEyycqp6O83XR8YHJoo=;
 b=N+J+sqlR0x+p3wjcqgX3xZ6cAmoB+ON40xjSYJlFIUjl3EqW7XCxwidPjZ3luD8RAGQOgSvfRft9934ngT3zthRqibdwG9kLoaXXtsk6FJld58sK1XwqA4NnkzoqCeN+i235BSGJWEVDPPL5QZ3FTfodBiXReBrgDFSz5cHQBSVImKfAGkjNTAKoJdIP/U/FZKx4IkSubPIV1UXWB1HwuLxALYaKVKXOrc5SaKCnUEfj8cBkfnEcvAP5I2ykh84FqckiVrhTxIjGGGFbt4ffLrqZjzAKDLt6q2bxlz1eOobJtYy2swhPCHy3CP3a4j2vVoRyyufDwFeDQL1CMwwklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alkk5HJxFnQ35TNOaK2yBZ5cbEyycqp6O83XR8YHJoo=;
 b=hsXISAS2Ulj8a0bnEFgNOF9cVtE/Vgtdc8Q7SsCzsQgVrUzoLyFBpCPCzzzipCjOSlvhblAVeH//VFaP4kHiqRa3/hHCt9FqrJuazpODkNPSRFjNUBC4k9/SnQDnTttA62GQb/04LP9S4TInWWOsXkJUgbh9HYoyiXDCKyO1jie9PFAapBWF/D5wwrcfJGzZSHRSmPiTmDqMDR34Iu+DyKcpKuiLpJZYBDYaVjE8tj1gfvhUgfIQ4FY8n1NaRx8qXloGWDXmPUYGNzcE/ocA+cRF8ocu8Z+e6BWy8FQhaA/HRIQcVwQJT/t2GAMo52602ohLRJjGAS4N2DYVmo6bcQ==
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 11:53:06 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 11:53:06 +0000
Message-ID: <eaac1f6e-90d2-4d8e-8238-30e7ea01c1c2@nvidia.com>
Date: Fri, 5 Jun 2026 12:53:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] dmaengine: tegra210-adma: Add error logging on failure
 paths
To: Sheetal <sheetal@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Frank Li <Frank.Li@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, Mohan Kumar
 <mkumard@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260517163045.363444-1-sheetal@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260517163045.363444-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: b3461e7f-4a22-451c-e941-08dec2f9017a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|3023799007|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	G3r6+FiJQS63G+W3Svxe1Z5at7AEos5EJWpNs8+c5RY240wVpBePvqyd7M4HJUumTrBjXA7PNcdKAq9ou53NVnm6udBCcOz8UKXpz7K7rwVzE++fqFLykV1+N6i06NLok9vSWvbHoi51ERNYkIsdoVaGdNQ83ux8Tl/QSRNgBJk6t/XZHkWY4GZ21m0JJdjv+kwquG+AFEgdH305QRsx97bUhfDCcV6Din+a0Ri4mSFXtQHGyMNIZChzYMrbp6vs4zvbjQJPtzflIrWVoodSCGPOHFP/MsuvBZtXp63MBE1KhD1iFW5PFgHmqS44n8aJZvMgD8T2LzO+6IiNeMUlkwxo/ilk+fjeg3K5vIhb4q7YTOsaN9ys/O3IGPe4osw649Vd7OKJ1zCBrBfM+SUG/HXtVGKyOmSH6gM+ZDyIOS3hKp9L7YrbW0n5coiVoj8wlRywLk81cPL1d6aTvUC11sFVBLapieFF3++n/CwOhUH6lX0yScSNg9JOE1/D7EFZTI7ZTGRrMXZUbfADXqTisec/b6jYgEBf5fp6yVJo4SuTDwoxZ4R8AfAMhhOBQYJI1eDjlgsUWsiroGg5pEggD2cq7XN+BpReF0Wttq3EK52JtADHeTYjmA+bB8Pvab7TxAkggAzfS+4B3ZWVBJQMjK/EZf/w3rEOD/vpu3Zl/YNnQH3bGRNCJUvoWJKKi4xh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(3023799007)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmwwaUpxbTFVYzJQeGFQL2w4Vk02d2plWGI2cGRxTEVtOGF6VUIwWWdWNFpy?=
 =?utf-8?B?a2wvT240THlWeGxuS0c5bkJURzBjVkFaU0VJYkNZcHFzei9wZUtmUGpwYXZt?=
 =?utf-8?B?dFVnd3hFVlBXQTRiUEtFQk1VNVRTUTJQL21NQktpdXhsa25mbC9WZG9ocXFt?=
 =?utf-8?B?QWQydnFNbHNVY0crR052NzFoYWJ4ZHdXYXd2YjFsZm9ZOG5oeWl5R1lTY002?=
 =?utf-8?B?WS9vamorUjFRdlBXMTlBYXhBWUFSYlhhamZ4R1VYc3lnZXpVUjUyQlJreklC?=
 =?utf-8?B?MldjdDFmWE9OaGJ3RlhNWE1KNCtHRGFCSmU3eFppVVV1anFCZ3FYbUNSWG9D?=
 =?utf-8?B?anZaUnVaelo5RTE5KzBJbzgxWkVKaXlyS3kveTdWQUlXNVFOeUNyVDB4MjY1?=
 =?utf-8?B?allJSUhwdExtZHNGeUI3Z2tRU3EzaGNOMG9hSlZ0dXJkZ2RXcWkveEFzQVo4?=
 =?utf-8?B?ZGJqRXNoQjNYVC9uNWdFUHl4SkhQSlBvc3dqaFRmYlJxUzNNOGYvUXdDU3NN?=
 =?utf-8?B?MjRHQ3FyUkVSMHNrbXZuUEMyN0Znemh0d0gvYWFCbWlJVmZDR3dJc0pjOWlG?=
 =?utf-8?B?UnQvWDljT01ncmlPVUdDRUtTanZKMjlaUThKTmVkSHlqdDlQaENOdW5nb2RV?=
 =?utf-8?B?VzlOemhoVU50d0FoQUVMbThnTm5sOVd4c3FkY0RXZVA3K2F3dVRMWFp4K2Er?=
 =?utf-8?B?QWhMRG9Pb3ZTaVZ5M0s0Y1BtR2xoNWowdjNFZVJmK0xGZmlmZHlCZGpSR3Mz?=
 =?utf-8?B?YXU1K2ppRURRaFZacCtEcEFWeHVhQTB2WjA0dWdLTUgyZC9RNmNYNnlTaE9w?=
 =?utf-8?B?WjFNRHJxZXYwazA1SlJRQW5aK2RaUDNpckJLRmx1ZTJUeVQxRk9Odjg4WVZj?=
 =?utf-8?B?MmwzNGUvSlpSc2g3RFBlSUFVeFJUMTZSVFE0VWt3TEo0anRxczlkWEg2azNE?=
 =?utf-8?B?VFhBTHhTMUVGYkh1QTJnRVVMWnBRSTMyY2RkcDI2cUlncHJieVY5bzZWWita?=
 =?utf-8?B?RUk1OFo1NE1kbmhUalgyWHNGa2NubFBUaHBGRThWdnFQcFRTc09aR1VtdnJZ?=
 =?utf-8?B?aEN1OWVlc0t2MXBaeE9ENXRCSUQ5bkxHQnpZUlFrODVEUkQyUXhJV3Y4VVJn?=
 =?utf-8?B?OGE0bnhmZ3ZEb3lleXRSZ2g0V2lKa0JoZlRmaDZaNmJKVXdDUXZmWS9rZmVF?=
 =?utf-8?B?TDBYUVcwVTRWU3BDMzZvTWV6Uk9TeFgvQmNQMm1IRGRzT29NNUk4T2trdkpi?=
 =?utf-8?B?OEZ4TER6ZXBhWitTVktlcEhXaFNXYzRYQ0lTUjJpbmVtTmtPbnpsZWZmQ0Ja?=
 =?utf-8?B?dFdoeUpHcmY0RFBEa04vSFZZK1pjL2sxdUtvODNud09ERTRKSW5KWEthbzM1?=
 =?utf-8?B?OEVrTmlWVkx5clZydDUrRkY4bkkzQ3FSRHZGU2pQa2UzTU9Lemp3RHY2QmxT?=
 =?utf-8?B?Ky94RGxTWGdidDFFWjBDWGtJUkpFNFEwcTR5NGhlTDJKSVl4RU5tbEVNeXVt?=
 =?utf-8?B?STdTbTh2RGVDNG50OEN1dGdWSHJHMDBFamJiYXl4TlhJUEJ4aUFnUllvK3V2?=
 =?utf-8?B?bWdCaXN5UXBlMEhyRzdUalNuSmR4N3p6TXVZdTJBRzdPU0o4aTNoMmFSczlE?=
 =?utf-8?B?ekZWNTFIejgwL2lTLy91ZlJtQnZjb2s3anZlc2NTQm0rdkFpd2swQTFob1FL?=
 =?utf-8?B?K292Mkc5MUxvaGwyWWJsaGlhOTA4cXVGUU1LYXdSLzBQZkhIVG1wV2wycW9Y?=
 =?utf-8?B?OFZNS0NMT2pLazhiMGNHdDVaUDdHSkxiQjNGc20vb0JrRWtzbi96Rm5BWWEw?=
 =?utf-8?B?ajN3WkJ2NWUvbkVlQTZNYytpWkN0bE5STWZWRHlLM0IxVFpxMDQ1b1h3LzRI?=
 =?utf-8?B?bis1Z1FWVXM0ZFo2akFoUVM0bERTOE5sMjBzNVdvN0Y4anFsdHdnYzZmTXF3?=
 =?utf-8?B?djlZbXIxbGtPaHFTcGlsQU1DVmgxc2dMbThTend3KzBrcm1DUWJTcnRGZVNr?=
 =?utf-8?B?L1Y5MFRTbFZJTG5neU5ycjZ0MkJPenFuTDlMVHVOc1ZNSHRpUWlBSDVXcmxl?=
 =?utf-8?B?RmpncXh6cG1vckdVMzlGRW83TUs4Lzd6ZGl4bjZFOWk1RmtxWFdnaTIwT3RJ?=
 =?utf-8?B?VHVEMTEzcy8xekt6YUdYYS9pK2lUR2dlczlXT0lYU1dvc0ttRFR6dTlaRkhq?=
 =?utf-8?B?SjZRNmF0UGQ2dUN1VmdSM3BYS1h0K2swYWtEdm9pbEJQTks4aENRekFXYVlm?=
 =?utf-8?B?T1haWTgrY3FPRkdkdlg0bVBvQU5QVkVuWnV2OTVWZ3k0L2xYcDJVNFN2aytW?=
 =?utf-8?B?Vnd2ZFFNamVTOGxnaVJaMEh4TmVKNndoWDltcmRDTVR0TVVJcDdJR0o3ZXc1?=
 =?utf-8?Q?s/LC+nK81ymuycUfVxHPTGb64nMO3oMui9M3ldxg4L+GN?=
X-MS-Exchange-AntiSpam-MessageData-1: m3DJbUJSfXhvaw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3461e7f-4a22-451c-e941-08dec2f9017a
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 11:53:06.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZyVKdkczM2qCOV62HLJ9zqIiXhndYscDtq6EWQ6gr4KllruxW28LbvNTEgdW2TUt7R9w+NxNQuvolzU0HItwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11187-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sheetal@nvidia.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:ldewangan@nvidia.com,m:thierry.reding@kernel.org,m:mkumard@nvidia.com,m:spujar@nvidia.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DDF4647E79


On 17/05/2026 17:30, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.
> 
> Use return dev_err_probe() pattern where no cleanup is required in the
> probe function. On error paths that need explicit unwind, store the
> dev_err_probe() return value in ret before jumping to the cleanup label.
> Also convert existing dev_err calls in probe to dev_err_probe for
> consistency, and use dev_err in non-probe functions.
> 
> Keep explicit runtime PM and DMA registration unwind instead of managed or
> scoped cleanup. The scoped runtime PM guard releases the usage count with
> pm_runtime_put(), while this probe error path needs pm_runtime_put_sync()
> before pm_runtime_disable(). The OF DMA registration failure path also
> needs to unregister the DMA engine before dropping the runtime PM reference.
> 
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---
> Changes in v7:
> - Keep explicit runtime PM unwind instead of using a scoped runtime PM guard
>    and devm_pm_runtime_enable(), because the guard releases with
>    pm_runtime_put() while this path needs pm_runtime_put_sync() before
>    pm_runtime_disable().
> - Keep manual DMA registration unwind instead of using
>    dmaenginem_async_device_register() so DMA unregister happens before the
>    runtime PM reference is dropped on OF DMA registration failure.
> - Restore the explicit IRQ cleanup path instead of using managed IRQ disposal.
> 
> ---
>   drivers/dma/tegra210-adma.c | 63 ++++++++++++++++++++++++++-----------
>   1 file changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 14e0c408ed1e..ceaee1e33e68 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -335,8 +335,16 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
>   	struct tegra_adma *tdma = tdc->tdma;
>   	unsigned int sreq_index = tdc->sreq_index;
>   
> -	if (tdc->sreq_reserved)
> -		return tdc->sreq_dir == direction ? 0 : -EINVAL;
> +	if (tdc->sreq_reserved) {
> +		if (tdc->sreq_dir != direction) {
> +			dev_err(tdma->dev,
> +				"DMA request direction mismatch: reserved=%s, requested=%s\n",
> +				dmaengine_get_direction_text(tdc->sreq_dir),
> +				dmaengine_get_direction_text(direction));
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
>   
>   	if (sreq_index > tdma->cdata->ch_req_max) {
>   		dev_err(tdma->dev, "invalid DMA request\n");
> @@ -665,8 +673,11 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>   	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
>   	unsigned int burst_size, adma_dir, fifo_size_shift;
>   
> -	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
> +	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS) {
> +		dev_err(tdc2dev(tdc), "invalid DMA periods %zu (max %u)\n",
> +			desc->num_periods, ADMA_CH_CONFIG_MAX_BUFS);
>   		return -EINVAL;
> +	}
>   
>   	switch (direction) {
>   	case DMA_MEM_TO_DEV:
> @@ -1029,8 +1040,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   	cdata = of_device_get_match_data(&pdev->dev);
>   	if (!cdata) {
> -		dev_err(&pdev->dev, "device match data not found\n");
> -		return -ENODEV;
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "device match data not found\n");
>   	}
>   
>   	tdma = devm_kzalloc(&pdev->dev,
> @@ -1056,7 +1067,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   			unsigned int ch_base_offset;
>   
>   			if (res_page->start < res_base->start)
> -				return -EINVAL;
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "invalid page/global resource order\n");
>   			page_offset = res_page->start - res_base->start;
>   			ch_base_offset = cdata->ch_base_offset;
>   			if (!ch_base_offset)
> @@ -1064,7 +1076,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   			page_no = div_u64(page_offset, ch_base_offset);
>   			if (!page_no || page_no > INT_MAX)
> -				return -EINVAL;
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "invalid page number %llu\n",
> +						     (unsigned long long)page_no);
>   
>   			tdma->ch_page_no = page_no - 1;
>   			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> @@ -1079,7 +1093,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   			if (IS_ERR(tdma->base_addr))
>   				return PTR_ERR(tdma->base_addr);
>   		} else {
> -			return -ENODEV;
> +			return dev_err_probe(&pdev->dev, -ENODEV,
> +					     "failed to get memory resource\n");
>   		}
>   
>   		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
> @@ -1087,8 +1102,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
>   	if (IS_ERR(tdma->ahub_clk)) {
> -		dev_err(&pdev->dev, "Error: Missing ahub controller clock\n");
> -		return PTR_ERR(tdma->ahub_clk);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->ahub_clk),
> +				     "failed to get ahub clock\n");
>   	}
>   
>   	tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
> @@ -1104,8 +1119,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   					 (u32 *)tdma->dma_chan_mask,
>   					 BITS_TO_U32(tdma->nr_channels));
>   	if (ret < 0 && (ret != -EINVAL)) {
> -		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "dma-channel-mask is not complete.\n");
>   	}
>   
>   	INIT_LIST_HEAD(&tdma->dma_dev.channels);
> @@ -1127,11 +1142,13 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   					cdata->global_ch_config_base + (4 * i);
>   		}
>   
> -		tdc->irq = of_irq_get(pdev->dev.of_node, i);
> -		if (tdc->irq <= 0) {
> -			ret = tdc->irq ?: -ENXIO;
> +		ret = of_irq_get(pdev->dev.of_node, i);
> +		if (ret <= 0) {
> +			ret = dev_err_probe(&pdev->dev, ret ?: -ENXIO,
> +					    "failed to get IRQ for channel %d\n", i);
>   			goto irq_dispose;
>   		}
> +		tdc->irq = ret;
>   
>   		vchan_init(&tdc->vc, &tdma->dma_dev);
>   		tdc->vc.desc_free = tegra_adma_desc_free;
> @@ -1141,12 +1158,18 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   	pm_runtime_enable(&pdev->dev);
>   
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		ret = dev_err_probe(&pdev->dev, ret,
> +				    "runtime PM resume failed\n");
>   		goto rpm_disable;
> +	}
>   
>   	ret = tegra_adma_init(tdma);
> -	if (ret)
> +	if (ret) {
> +		ret = dev_err_probe(&pdev->dev, ret,
> +				    "failed to initialize ADMA\n");
>   		goto rpm_put;
> +	}
>   
>   	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>   	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
> @@ -1172,14 +1195,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   	ret = dma_async_device_register(&tdma->dma_dev);
>   	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
> +		ret = dev_err_probe(&pdev->dev, ret,
> +				    "ADMA registration failed\n");
>   		goto rpm_put;
>   	}
>   
>   	ret = of_dma_controller_register(pdev->dev.of_node,
>   					 tegra_dma_of_xlate, tdma);
>   	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
> +		ret = dev_err_probe(&pdev->dev, ret,
> +				    "ADMA OF registration failed\n");
>   		goto dma_remove;
>   	}
>   

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


