Return-Path: <dmaengine+bounces-9072-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDlYBYLcnmkTXgQAu9opvQ
	(envelope-from <dmaengine+bounces-9072-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:26:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9C196753
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 12:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F523023537
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18D3939AB;
	Wed, 25 Feb 2026 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubAtkEXZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C313A244;
	Wed, 25 Feb 2026 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018597; cv=fail; b=W63JugvDvvxdXL/RvOfsxyU1ZEZNTbqcJaIDq3Mrs4NaQfUakS5+I9dspvCopTgGkxvYphgnK6k0n1MLYQdxBchxx7SCUdVtI4QKNga6TAzdUpkCgdyiTtAQyMA5XHJJx/C6JEvSB2vpX64WAM8D9AipqXURacOn84vVLa6b520=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018597; c=relaxed/simple;
	bh=cRQ3F035Kqt4k/e6qCV6KwKiq+TIpK5vwIOnnmZKtvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AtMdxkPyZd2JtXhJnC9Q3kurddgzfhLjSP9WuOipaZuwThhkiDU+shFOW9gOUqWL5udXp81EuRjD2RZKxDxjxw8jwG+R5hN03ZE6LnVUQXvnAWwNxbO/6iMosVOVRnzegTEhQLCUarUVNeDWOYagdfdCT/RbhiCj0EHpqZ1P/4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubAtkEXZ; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9WRnGTxQmnkgOAcFvCv3Enl+nxAAcKXWYfD4jyI8hEsX7smpj3ZrZzdUic1ZtO5lgHIPko/xP8z1UIWaMNcz/H/rin7+FHEfhxYA0k8xXhD1utTusDpkp0qqDVfnNgNPADVFYMnj7VBxfYwOSe9M0GVGvooYoFQzvrRvHvIltouf0PjO71cvqiGKVdrtz6/1AA3U2x83ViTeuHQbCHE/TsZODNCNbRbo1C+hnXFGNBJsTfr8i6pOBR32WtZRhPC9wTDjQZDOykSJAyFp2kvn8B1aXQCSH295QRQ0eySluU70446Pf3uHGuihxzG+k1qtU3FPvhxg2bwydGv28uoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgJ8roaLOdK0j4GekEsps4fmZqm4B16YYhKMpTfSsTA=;
 b=jV5icolmYDkxI5b32QTVVHFCtjM8mNMZbS+DWYnad+lQxVmIhNWEWJcOCcUigOVt/OdE5FwyxtR+ZsjO/YQ3/6zdmoJwkbsCzES7lNXZT72/N0oLgqrPCXkIwS9DweumamT0htIQdu8V/lCxD5xjRYmzg3BWLE3HheR1xYIgP0VTiGLj6/mS4vAN5rWgjgtin8PuXSL5WMaT4rkP4EOXZTl2zYpjA+cj+tvbHYF7yAe61Njsp9Lnf75d/J3oCR1AfoK03bIMVw/XPDEDQUfS4CRGyEOb/7iVMJOd2vCq5MY1o7jhoiJgXAzNOz/iBtUSjBCDBGNbRRf76hOOVJw96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgJ8roaLOdK0j4GekEsps4fmZqm4B16YYhKMpTfSsTA=;
 b=ubAtkEXZ288jmG6o5/ZhUuWphakqFhAmcSUDT0NHEhyTQcAr+TmwRL4frksS+YWYzLoJXu1g3q0BbQrevJyvfKBNcyvI9OWgIOOJVym+6j0+L60B4267uLev16pgQKx08SQtGvbLBf5txYYHm9P/AJQLHmObWmOz+6uicRfivBarGh7xQQrQ3tbF8SW+3QA3FHsNS+LWi/nbIKBHgh+f1V3iPKc8XnAMhODIkxKO3MHPKmfa08txDzvIcOO28cAUigqzO3t3Y/7t9c1wtly8s8vSWtlIihRz/dfLWKsIHpixYzxoVShf9bU6isFYbYjJUCNG2AesZBTNtV9DkrWUag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 11:23:12 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:23:12 +0000
Message-ID: <ffbcc3e4-d116-4b23-a584-0e9fc864461f@nvidia.com>
Date: Wed, 25 Feb 2026 11:23:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
To: Akhil R <akhilrajeev@nvidia.com>, frank.li@nxp.com
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
 thierry.reding@gmail.com, vkoul@kernel.org
References: <aZ4fUGYouVOlYdL7@lizhi-Precision-Tower-5810>
 <20260225102745.47876-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260225102745.47876-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0292.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::9) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afc11fe-f88a-44eb-e00e-08de7460430d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	xaBW14gf0anc/5tMaDaaiipVghPMHFgPM/P30zxViGapXJX2J0TGKIB1C6nWBbasqNM+lMIPCiEAztkXWnPjaZYJe4oS6PUoOijrpOCB//+IVIM1XDsHG/1jK/EypYoQ1REWgOzDTeqF7g92VIr+of07DBcSEoAT/uKe0Al1jLmYbhCJqtcllURT0UzJ9YkgtjnEQ8TtjAQcvTo9QpN8dIrGxqU9D9DPrub+paopjCTVt4eT8FItGCfvr2U6Nb+LVW/bUXNzi4ESP5zSK6zROcFi9fzqG6riHmvp5SQtRqW/hr8vbuBBoRYV658sSYzaMGf9I7ureBlmzXq8uaIsM2FXQ8p1wfC69aqZK+o1X8Fyi3pqNZFaiAcbXfZiGS+lG4HueXuG+L0jihVdsU3kfbQR7xqS7xz5ogxXxniD0df7Z4j0YF0PR0XE1V0df2qL82jj+wHbKyx4s9DUAetWy/oB+AO7ML4IzWo2xCtWLDoFRzRpsLUZfN/H44hWopsNdGOGznxQg4dVPxhl8GvPtpBDshmlofHRpjccRiSNv3p9TKGRRE7MJkz1Vh5KtS6s3mH16yzsM1a+hFncTfy+MunxN2heHFu8Oj3Xw00rq3a3J8w2iMVeOUd32duO9ODjyrQPzeMdmqOUoL2kx1q1BxERkJ9rDqbB5OSOZlxbhborLA727KHB3xB4nhlDcDK1f+SPny3nsPTkqpTo3g/8ACjvMTnLZuz1G/hBDluAq6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU9GV3BmN3BKUmZVd082S2gwL2w1TVlTVmlCT3kwSS9EV0UweUJDaDF0dDBp?=
 =?utf-8?B?MlNTQ2hmR0tMRFBlMmxvb2xZc2JhR1hrZk14djQxR2taQndLeUpqQitNR3Zs?=
 =?utf-8?B?OFRoWXZReWtpQjBTU29BanpQMUxvOHJnVDgxVEZEeCtZcWoySHdIK1pNMUtC?=
 =?utf-8?B?bFQ4ZWVSNXZZT2g1b003OGVnRmhpWnp6a29Cb3crdkx4NnBkc1FRRnBpQ244?=
 =?utf-8?B?cHNPdFR3S3ZCVWt3c211a3JzWjlJNm1jTmFEbklKbFc0emZPNm5oYkxWUlNO?=
 =?utf-8?B?Ky9oU2xURkVCY2thOHhQL3ZDS3JvMW9ablk1VGxoUS9ocXcrMDVob0E5Z3Bq?=
 =?utf-8?B?cUFWR0Q5b0JqMVJtZlFJYkRMWDM0RTljZm5jQldFTjQ0bXB5Y3d5VUZ5VThU?=
 =?utf-8?B?ajRsV0lDTVdJdGNJckhFYUR3L1BlYTJrSDdrNmdqT2FsWjUyamFFOENGa2E5?=
 =?utf-8?B?SGI1YXlOd0RKT0tHMnI3Nk9qdVJ4cUpObVYyQlIzTlJQUWI2dS8xby81MzZP?=
 =?utf-8?B?TXBTZlRoZFRaSU8rMFhzbDIremVJSXRHVWI5eGpWTEhhWlI3L1dRak1iYkxv?=
 =?utf-8?B?ajZNdUNMTjd1Um5FK2ZrcG4wdkxwRW1ibWRFTlMzdkk5K0RpcHJ4UEovR28r?=
 =?utf-8?B?Rmt2OWY4RVIvVm1lU0JRZEVLcnZtWGJsQnNnOVFMSk43aWdCQzl4NlVkOTA0?=
 =?utf-8?B?Q2tWRFlWVm1JNGUrUVFBNEQ1bEZpemYrcVdrZzhjcUxlMDJPRGtib0V5SzAy?=
 =?utf-8?B?UlpSbzhDK05qdUkwRjJiLy8vM1h0SEJBOWQ4OW1qQTNRSDJxdWMzRkVzeE1K?=
 =?utf-8?B?NnBGQVIrQUJINHRpWnFIbGFGTkpJOU84Vjl4anV1WU5uQTBScmcrYzBQcmp4?=
 =?utf-8?B?QnozU2lWS1cxZWNqanRIV1c3M1Y1V3RLdER3MlU3QmZSaS9zMHpZTDBZWHE2?=
 =?utf-8?B?WW0rNElON2Ewa1ZvZkR5VkFrRjI4clQ3NEZMbUF5dDdXajc5Qjg1aXc4K3Zq?=
 =?utf-8?B?SHllZmpzMmZWNGw5elFkRGpVUzVMcmU5ZERWZlkyS3FId3F1cWtpaERCNld0?=
 =?utf-8?B?bnhpK21LQ00rUTRFQ2d0ck0rV2xXZE4wOVVJM1JncUdRVXR0ZnBnQ1ZqaUFJ?=
 =?utf-8?B?cTdranhQRERJZlZNOGZRakcxRTR6NUFwSFcwSG41b0xWNFRrbjkwcHJyV2xt?=
 =?utf-8?B?YjR6SW9waTdoQXdRNjd1eUFmdUdkOGtzdy9MVVVIOWNPckdUbDlrbkYxVGcv?=
 =?utf-8?B?Qmt3aWkwcjZNcWFhOGJZc2FjVmQ0bkJDY3BFdk9VbmltSXY5L0dtY1puTTNh?=
 =?utf-8?B?UTRFNEp1NUNUMkRkUFdlWWZGZ0E0d0RYaDNhVUErWStRcnVZcEd6TTA0dk5P?=
 =?utf-8?B?emwyU0pqWlNHRkdPa25sS0JaRUl0T2hXT29MZW5BQXVmcHR5ZlhickQwdTJr?=
 =?utf-8?B?T1lSQVl3eG9HbGQxVTJ6T2I5emZPNmJqZnRFTTFnQ0hLWkE0dk9rSFl6dDY3?=
 =?utf-8?B?cmpCbmM0N1ZXcys3aVBHQ0V1TktMZFMwUUF0MGFEVFNySjNHa2RScDJqa3lh?=
 =?utf-8?B?WU9MTTVsL2x4b1NvUVRmMDNST01UUmRxQTg4cnBtbW5oMG9xYURMMk5DcE80?=
 =?utf-8?B?Wmw0VHJJK3F6bVZLR1NLZTZwdFo1ZGhFdFhsQ3hUL1lmdVYzM2NzVUNCcW9z?=
 =?utf-8?B?R01IaFl2NXZtdVdNN0hIMXBaSEVCOHRqRDQ4Mk9rZis0R25PS1JzU0M2czBy?=
 =?utf-8?B?MXlTWG9FUC8zSjdNZVBEZDcvU1BSeVhjRHdqYzJuUXlnTmE0QzJnQWQ4WVJw?=
 =?utf-8?B?R3M4MUFKNXlBSFRrM3IwZVpkZnZPWU1YVWFDcFd5d0FoWGIvOFFOU0NyZVY1?=
 =?utf-8?B?SmpaNjNVVkxUeFFsbVY3aDlZOHdzNGQwRUIrYlhmN3IySVVraU9XWHFJMEZR?=
 =?utf-8?B?NUUyYlUxRlQ4L240SEJJeVlkOEZ6WGdrSzJLWldlODcxSHV4djdWVlNlajRB?=
 =?utf-8?B?NzNlSVVwcjU2WEQ1MG9ncm1PeEtRV0UvV3I1YVRWcURrYU1IVVdBTGdlQ0ps?=
 =?utf-8?B?YVJNa1RTK3pNWnhpSGIvTXZ1ZVBkY2lRaEtLVGp6NDRzc2loZWpvR0xGYWlu?=
 =?utf-8?B?WU9WMHllL1czazdVZmQ4QndvNGVnZXQ2Y1hMZzRzNHF0eVhBSjUvb0g4RDhs?=
 =?utf-8?B?TlVHdDhsbjV4TXhsZmFXaWthckZvc1Y3empaZ0VtdUdNM0NUNGtHVy9QWUY3?=
 =?utf-8?B?emtoSisrdVV1ZUE3MWFrUkNIQ3NZbHAvVlEzVVloK3Z4ekszVlFhVTNzUGdJ?=
 =?utf-8?B?ditsZGJHSFc0Yzd2UGhzSUdMb2h3Y3k0SDhNeHVabi9IK2dOQUJuNzIySWd0?=
 =?utf-8?Q?7wfTIDxxdKyWUYVMv+KiQbUPF38nX/0jMLl6bBJPW01sq?=
X-MS-Exchange-AntiSpam-MessageData-1: ediACYteS//SwA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afc11fe-f88a-44eb-e00e-08de7460430d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:23:12.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8fvKt34J0NMnk9QAh+JmiTXLhbqF1aXPNIQCghZq1IpM9+AXNS1AfBUMQpBpaqn9KpLBugnX3tKSst6WZN51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9072-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,pengutronix.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6C9C196753
X-Rspamd-Action: no action



On 25/02/2026 10:27, Akhil R wrote:
> On Tue, 24 Feb 2026 16:59:44 -0500 Frank Li wrote:
>> On Tue, Feb 24, 2026 at 11:55:43AM +0530, Akhil R wrote:
>>> On Tue, 17 Feb 2026 14:52:17 -0500, Frank Li wrote:
>>>> On Tue, Feb 17, 2026 at 11:04:55PM +0530, Akhil R wrote:
>>>>> Use iommu-map, when provided, to get the stream ID to be programmed
>>>>> for each channel. Register each channel separately for allowing it
>>>>> to use a separate IOMMU domain for the transfer.
>>>>>
>>>>> Channels will continue to use the same global stream ID if iommu-map
>>>>> property is not present in the device tree.
>>>>>
>>>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>>>> ---
>>>>>   drivers/dma/tegra186-gpc-dma.c | 62 +++++++++++++++++++++++++++-------
>>>>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>>>>> index ce3b1dd52bb3..b8ca269fa3ba 100644
>>>>> --- a/drivers/dma/tegra186-gpc-dma.c
>>>>> +++ b/drivers/dma/tegra186-gpc-dma.c
>>>>> @@ -15,6 +15,7 @@
>>>>>   #include <linux/module.h>
>>>>>   #include <linux/of.h>
>>>>>   #include <linux/of_dma.h>
>>>>> +#include <linux/of_device.h>
>>>>>   #include <linux/platform_device.h>
>>>>>   #include <linux/reset.h>
>>>>>   #include <linux/slab.h>
>>>>> @@ -1403,9 +1404,12 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>>>>>   static int tegra_dma_probe(struct platform_device *pdev)
>>>>>   {
>>>>>   	const struct tegra_dma_chip_data *cdata = NULL;
>>>>> +	struct tegra_dma_channel *tdc;
>>>>> +	struct tegra_dma *tdma;
>>>>> +	struct dma_chan *chan;
>>>>> +	bool use_iommu_map = false;
>>>>>   	unsigned int i;
>>>>>   	u32 stream_id;
>>>>> -	struct tegra_dma *tdma;
>>>>>   	int ret;
>>>>>
>>>>>   	cdata = of_device_get_match_data(&pdev->dev);
>>>>> @@ -1433,9 +1437,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>
>>>>>   	tdma->dma_dev.dev = &pdev->dev;
>>>>>
>>>>> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>>>>> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
>>>>> -		return -EINVAL;
>>>>> +	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
>>>>> +	if (!use_iommu_map) {
>>>>> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>>>>> +			dev_err(&pdev->dev, "Missing iommu stream-id\n");
>>>>> +			return -EINVAL;
>>>>> +		}
>>>>>   	}
>>>>>
>>>>>   	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
>>>>> @@ -1449,7 +1456,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>
>>>>>   	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>>>>>   	for (i = 0; i < cdata->nr_channels; i++) {
>>>>> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
>>>>> +		tdc = &tdma->channels[i];
>>>>>
>>>>>   		/* Check for channel mask */
>>>>>   		if (!(tdma->chan_mask & BIT(i)))
>>>>> @@ -1469,10 +1476,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>
>>>>>   		vchan_init(&tdc->vc, &tdma->dma_dev);
>>>>>   		tdc->vc.desc_free = tegra_dma_desc_free;
>>>>> -
>>>>> -		/* program stream-id for this channel */
>>>>> -		tegra_dma_program_sid(tdc, stream_id);
>>>>> -		tdc->stream_id = stream_id;
>>>>>   	}
>>>>>
>>>>>   	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
>>>>> @@ -1517,20 +1520,53 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>   		return ret;
>>>>>   	}
>>>>>
>>>>> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
>>>>> +		struct device *chdev = &chan->dev->device;
>>>>>
>>>> why no use
>>>> 	for (i = 0; i < cdata->nr_channels; i++) {
>>>> 		struct tegra_dma_channel *tdc = &tdma->channels[i];
>>>
>>> I thought this would ensure that we try to configure only the channels
>>> where the chan_dev and vchan are initialized. I understand that it is
>>> not probable in the current implementation that we will have channels
>>> which are uninitialized, but I felt this a better approach.
>>> Do you see any disadvantage in using the channels list?
>>
>> not big issue, just strange, previous code use
>> for (i = 0; i < cdata->nr_channels; i++) {
>> }
>>
>> why need enumerate it again and use difference method.
> 
> I think we will not get to use chan->dev->device before
> async_device_register() and thats why I added a separate loop to
> configure the channels.

I assume that this needs to be done after the async_device_register()? 
If so we should note that in the commit message to explain that we need 
a 2nd loop. Unless we can move the 1st loop after the 
async_device_register() and just have one loop?

> I can add a comment on why we need this loop. Do you suggest
> changing it to a for-loop itself? Let me know your thoughts.

If using the list avoids the following check, then probably good to keep 
as is, but yes explain why we do it this way.

  /* Check for channel mask */
  if (!(tdma->chan_mask & BIT(i)))
          continue;

Jon

-- 
nvpublic


