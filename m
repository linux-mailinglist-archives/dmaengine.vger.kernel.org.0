Return-Path: <dmaengine+bounces-9219-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCS7MBvfpmlkYAAAu9opvQ
	(envelope-from <dmaengine+bounces-9219-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 14:16:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C51F00AE
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 14:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4EE3029AF6
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E8735F185;
	Tue,  3 Mar 2026 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sh2KGdwg"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EDE347C6;
	Tue,  3 Mar 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543357; cv=fail; b=PQVAt/XWe/WKQwuXCoR2YqfGYlrv5DCOakanzllj6YZtCrRAQ6g2U7w1xDFx4accdrbeOHuodKGRf/pbp75p+zx32Mx2GYf+yFyD3cellypV49ySSdlnSbHBl1G43Rw6EuHqaJUQV3VBeM2Ab2AdVsL/VGUE5i+afrojbA3jI44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543357; c=relaxed/simple;
	bh=Mjpz0STxMBXccWYCWxdnwD+WIWKzanuKtnHeD19lUMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VsyYgM8NjzaWBFK5j4k12I1BkNfI3FQLldu09CJSqwq7jrQaXyuu5HgEoBg+FohKrcy9VzLzXPKON1C3g/cQGmRFe0DMMdTtwjt6FR3GEEJ5ZfkdNvHtDBO2helyRppSd3gW+g9nuFHBgkr3jv9PaThbx3Z550VWBmu8h2oQaB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sh2KGdwg; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKllf2ZoobfLsBCLA3AFYAQASox1/81wRsOC/9NeixRnnGWWwUe6p1cxNBgRw9QlueP0bzmIJIddFB3H45yPOUiC+uc2BECehqrHvrssLITKTCcc+tTQrp46HvMqONFRP/q96ALs/ECS85VPVeIrgZF73/rYvKTJXeALzw0MoavuzDoJHRtPzGFCQsZL+YDGULVNgfOjPopIzkQ++JDrZ6f4nxuZiBUj7qxVtJ4SNy8ewHKoOnQ2/DZGD/Ti9bT1OHtQTum1nxPfh1pyTlwD9BjqnyrkEO2QLHYI1eVnmDdPEgZaR/H0MdXBA5/pqF0C2yyCfDkbH4MRKxLV/zvugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SkoWZ/AhEMJtQK0h+F/SxCbo4ofjqIRHDxXYY+Sccs=;
 b=rh/l6L8h14S1TjnVFATjRP81KbwIbcLs9r8BS4fpwLSLTQliWHdcku7COf7Z3sootEGmbdxGNer3h6Y5rmkeGp1RfViiRWfVH3fFyIdf1nTD9Q5cbnJFelLHuFzkSKMHSZ7Q157+lbEi2NRDH+EhGgmqDQ9FgBpezqZOF1Ir70PO2vzTfvDnvY6WS3IE+a6/f4kA3Q0f+4H/2vhRWqaITdhTrLMBJMx5N4bIDk3UTacMr0LlRqkScuAloLxRArEjdTW1Wu/rW9He8Xj0QXhj2BQEpGTWf59DKshBLBcAkZVYISHE9fRtT11kQVM/ktjWFMdrve06GKFAHytij/bVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SkoWZ/AhEMJtQK0h+F/SxCbo4ofjqIRHDxXYY+Sccs=;
 b=sh2KGdwguYthdHpCS57G5s6EinLJ/HsizlztOCs1N2kjj9VjCi1A0MbZpqtusmAJ0+bycMI0VkwpiUQn8aSBajOCqFfxIKQX5q1nD7EWxa4Nh5xQzpGPl5uVLZVlajHE+JAFswmKUl9YmumrRn4oXYKxZS18BhqWOs8KtmmVcnYduizaCW91qn187e5EPvDejAXrL72zTYgg4zZYJW1eJjMtjnVAtcnNj0uQaBXB0/yzzHy49fie5DjOVyytG8x92UsfcXzv6Y4FczNQr4VvW3b30pyMhCdinA60kpv2sQxSFBwqXXdp2sndvXYmBb8tEXAr8PcmoS1rVeFjT2NNBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:09:06 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:09:05 +0000
Message-ID: <28c731aa-970c-4ca4-93b5-e2cc57b0c119@nvidia.com>
Date: Tue, 3 Mar 2026 13:09:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
To: Akhil R <akhilrajeev@nvidia.com>, krzk@kernel.org
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, ldewangan@nvidia.com,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 p.zabel@pengutronix.de, robh@kernel.org, thierry.reding@kernel.org,
 vkoul@kernel.org
References: <20260303-famous-fearless-asp-1240cb@quoll>
 <20260303084005.57114-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260303084005.57114-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::32) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: a2825f95-9f8f-45d0-6269-08de79260c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	O1FKi8YEgI/ZHQI2kzws16KHHwM0A5jljgfOOrXVO4VBnUPI/xK3VR8kFZ6Xxu0P851PsGTt1GcvizzhGj607PtAIsW1PP6RB4kbI2FxQQR4JVKpWmLMHIEp/uOwkYK0k4cneUiUWGx+ESwgvlNwwQ7hXdDY6w5kwfRiOIF5mL5H7OuYNv0ZMozII1SNCwMBA1N5kmTtQuCKJBWDrk9Suyn1DF2ls6ArmBtV/CVCmkAPU9KMpux8IDqaZyenkKlFdkkcs5HBMuNlMCi4wdz7fGuHVkE01JRGOvunQKlvQXcNZryvAToIr5AaAgJc7HjhXFGsEgofuJZotYOqUap7j0OtfOrMZpOCdr4D/XXY/f+FxVFoJVo+zqU7qfzl3USsMPZpOs7JglMYOV0c9hI4rElYWRa7gAoDe9wcMAAlPiNH2ES7F/l1CrYi9Sj61FgJSjdpJeEFE1zH4EnbJUcCP2qFSadKBZzQNTpC5lJd8oOxeK+LFM5Ed7OHAWvPbeI4Pp9+F5txBSS6EqB25Szi/9VSa1Km9E8wzUGTYHTkP8gOd4G45p8N0tjsb3JkaS8zhlpO+JIJOOmw1zRkPWZyyzf5QnjKotZaO1JjO61c9ERg1y5K21E+Y8uOXUGQPiMlJ8Erc1eeROCIC1BVZvrC7JNEo9SJmXYnXkT7wLhi2QFpfU0KXymBq3RMOVkXZMZmTxTy5m0o74xPw29pXrrZpnr4hUeswHEjSMVXsU3necQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlkyOXpzWWgwUGUvZ0dnSy9iM0xVQ3d1ZUx6TUF0eUJVbkhFWXFIN2NVb2E0?=
 =?utf-8?B?UzFIcytUai9MYUU5R0FEUVg0ekkrRXNuZ29VRWVCUnZwSDg1Y01oT2YvN1ZM?=
 =?utf-8?B?VjVMWTNsb1YrNXFaV1gvQjhCejk4aVJPWitnRnU2dmVNa0RiRVNLQWdTYk1j?=
 =?utf-8?B?ejgxUk9ZOU9TWlgzY29RU2gxdStjQTdiRks5THRkQTc1NStaUm94bEgrUlpi?=
 =?utf-8?B?MVVVcHJZNVRYVW5CalJDQjFTaTdDZlNsaVlCd1hia0dJYmFBWDBpalJTTSsx?=
 =?utf-8?B?RGtMbFp4U3hHdXJoZzFzTEFBV0w5VzhyL1VQMUxFMVNPdlk2MEg5QW9wYUxy?=
 =?utf-8?B?bmM1K3d0TDIwNk91Qno1QlQ2anJrS1JkbDJoYmo1MjF5VFlNUGhGbk14M0w3?=
 =?utf-8?B?MmdNU0lLM3M4KzRWTEFIcnpIVllsOW1KNDhseVVLM1JPWnhDWmdMS0pUNHY1?=
 =?utf-8?B?dmg4U2x1WVh5cithYTZlKytwMC9kallzSW9YR3Y4RzhrVzR0RmdWYzM3SVBi?=
 =?utf-8?B?L0FpSlJoN1pIWldqaVduNE0wSXFyQXYrOStJRmJtY3kxYTBHaTRYb3hOWDVn?=
 =?utf-8?B?Y0d6WmNQK1dEbHZzRU9BMXhWR29LRC9mUFlGQ0xYQ3VUOCsxNzRCR3pBakln?=
 =?utf-8?B?UzkrWmJPcmNsYWVyZW1Ra01WWUFoc0MyamV2NHF6SFVNc2N5K2tJWHR6U0dB?=
 =?utf-8?B?elNWUi9VYmk5UFpmOS9lOTJzZXZQNXovQTdaTWczY1RxSXpMUkFuc2ZZa0RN?=
 =?utf-8?B?YjVDUUJkYnNSSzFQOTlubFZJRm10SXQyaWF0UG1wNnBIQW4rVEZHZ003OXlJ?=
 =?utf-8?B?OFhmWEdHVjQvUXZ3alZ6ZGErOWFWMjJIVDRQTHFSTi9MYmF3amhtZlROS0dv?=
 =?utf-8?B?NTVPbUdzeEdPUTBuL0o5Nk8wWFZaOXU3NlFtSGdRcmwzbFB2NGRRMWYyODhG?=
 =?utf-8?B?S0JQOHhacGkrV0FpKytnVzlTdUhoOHA3S3pkZlpyTkFDVnV6bUNDYkQzaGZG?=
 =?utf-8?B?aGRMN1B6c2tpMitVcTJyMUl1NitTZ0NNU3JmWWFjRnRNblpCT0diVlpKQS85?=
 =?utf-8?B?dW5Wc2QwNjdSWWlvSzF5TTRMMWozc05CVFM2M2NOSk9BQUJVYzVpbndjZS9M?=
 =?utf-8?B?OW1GQ3E3QU9oNUFQUVg2Z3RKRDZyVEJIbE1TMFNVUVJRb2Z3Y1hKUWE4Ui9y?=
 =?utf-8?B?cjZGUXV0OEhMSUlLNUh2QWZidng3RmYxUWdOa0NzeXFOR0ZrRzMrTVRuRWt6?=
 =?utf-8?B?eW94ZGlaRWJrUEY4NUpZOWRQS043VmExY3BjZG5LUllEbm5yN0dJNW5iK0k3?=
 =?utf-8?B?MnNFbkMrby9KS1lVZjZWMThqY1IwZ1dTaFF5OXI3RVhBZGhhV3BCK05mNWRE?=
 =?utf-8?B?aHUvWkxObW5ubS9Wc1dmU3FJbGZnU1hmUjN2R3BubDIvWTltamxWSjlJYzRH?=
 =?utf-8?B?K3ZhVnNKaFJsVUI2dnpuUWN6UFBUWlVTQlVIT3VsczZIazdiODB2K05oSHlF?=
 =?utf-8?B?S3JjbGNCYzAxcHN1ZHg3YXNUUmZ1M0xJYmtFT3A4b0J3c3l1RUJ3dHlLRmI0?=
 =?utf-8?B?T0ltM3BQbkFZSndiaFhaVy9VZ1VOSDF1RG1LZXdkMkRwVkpEdC9xUXBDTERZ?=
 =?utf-8?B?aHFsUFh5STUvSTVLeEFjNmg1Z3dWQTZFaVZhajQxV2FjamJlamRpZmYrZDhN?=
 =?utf-8?B?dHp2TnFsby9IMDh3aXkrSjVZNloxMEhNSTJLRXY2UFVPTDE2S29ZMDRYQmU0?=
 =?utf-8?B?MjRzNGxDYmZJelZ2ZjZXZE50U1lSZTlxVEZwaUZKblBkU1FkUEhIMEI4Y3I3?=
 =?utf-8?B?aExZVHNIT0svU2Fqbm0xV1lCMWd6YlZWMlFMTHV0WW0zNUZPSWsrakdtTU4z?=
 =?utf-8?B?UTRYaktlbnVRWnAxSWlXM3dGNmZ4eG9PZnp3dlg0aHc2QWg1cHlqaFJoSGpY?=
 =?utf-8?B?c3kxZGxERjljZjNocFUzZm9NY08zMC9kclgrWDJFSktWajQyS0RLdjNyTVpB?=
 =?utf-8?B?OGYvNUcySkxCdG9vUDNlRzA2RE1HUVdzU05yd1dselorRXFLQlFwT3FPRkZM?=
 =?utf-8?B?d1ptQlhFL0JRdFQvaStyUlNxakVpMFpIQkI4aklFM0hSS1hqcTFZU3RUSXdy?=
 =?utf-8?B?ckJrTnNEWERXN29rOEllaGdUWWJpNHFxcnBDR2Zjb24zZ25GTm1jNVNYbTR3?=
 =?utf-8?B?RG9Ga1pNaC9jSjR3akUyMEFSNG0wYjZmTHZBbnBOaEFlSWU3RDBaZyt6aU9G?=
 =?utf-8?B?WlVpd1c4emNqenNVaERVY2FFZWdmOGc0YzRmOXJKeGJCQm9DL21CdThPdEhC?=
 =?utf-8?B?am1wYXIvdm0vZnJDaUFJVjFyQkxLeHNyejZlSXhnOTNJdkRHcVZHZXU0aWJz?=
 =?utf-8?Q?Nu++FXK0yJOmZXFg+vnXAv2TQehktUgCmQVWRqgfW1T8E?=
X-MS-Exchange-AntiSpam-MessageData-1: JAAtpvR87gSwIw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2825f95-9f8f-45d0-6269-08de79260c5f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:09:05.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agv3fQhHVgzECx23lnU3yz9cXq74jP5PRZewuwR/96y1tMPQBDuz4NA2Ac3qk17HP7klsy2IhqIHPIGcFvAx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
X-Rspamd-Queue-Id: 297C51F00AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9219-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 03/03/2026 08:40, Akhil R wrote:

...

>> Why is this flexible? If it is, means usually items are distinctive, so
>> I would expect defining/listing them. If they are not distinctive,
>> commit msg is incorrect. If the list is as simple as 1-to-1 channel
>> mapping, just add it in the description how they are ordered.
> 
> Yes, it is a 1-to-1 channel mapping to an IOMMU ID. The intent of making
> it flexible is to allow non-consecutive IOMMU ID assignments as well.
> This is particularly needed in virtualised environments where the
> hypervisor may reserve certain stream IDs, and the guest VM can map only
> the permitted ones. Shall I add a description here mentioning this
> use-case?

Isn't this already handled by the 'dma-channel-mask' property? The 
driver will skip over any channels that are not in specified by the mask.

Jon

-- 
nvpublic


