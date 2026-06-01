Return-Path: <dmaengine+bounces-11111-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKpRDlAHHmq3ggkAu9opvQ
	(envelope-from <dmaengine+bounces-11111-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 00:27:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE261625EF1
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 00:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A9E3008227
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B93806AF;
	Mon,  1 Jun 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dw0VpObI"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDA37F010;
	Mon,  1 Jun 2026 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352841; cv=fail; b=ZnRgpYFI9/eNtx/CR+t94N/6k1KZbl9W+VoXY4lQG94AF8i9Rj12xoYYHEhtErFRAh/M3Ok4F/WgvqU8rXgyLo9eerk6dPaEv2kUchnac8vThnimwzLN/ttllSK+zmMHoiZkk9WCDC+n8y2QQ6pOM+szAZghYrHXEQhn9ZHI1vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352841; c=relaxed/simple;
	bh=NNKlDOelFnp8H2U3tfPrwFsBTMnQhwdJ7d/pxZTyt3Q=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tUGXBKH2c+RiNFpBD69Yc+xcBZ1poOqj72UXVJy/Qrxs9avNAbNfcjKFJ/Ip0frc/IRpeg5uwj7ab9i1ml/SfJJpHKkFXx9pKUajyb1gMAM05fT89IMhikc4Ha4/mBey+BdTxK4XunJIYO/wSclM2GfMFpFgr7rmvZWXZVNK1XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dw0VpObI; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezZyr3ah1eJQWjScdvyau7yiTQ+hCmVVQBuX9eI+AKArVVHM7ZS5mkfkWw9NxjQ0D6zTj49gsAuAulK65vow/LfdDfVRf5nYnqzUk26t4/D5TLrKbih65+fzy5I0iqn8pXZFdt92C8NoAYAeupAHN6QjTEdxLM5HTB0gAhFDBBes/ViRqsZL50PorSL2Ml1f4zC/kO0QfZQqSj0vQsxAHsAe0/Xy4kP9C6jNUAwIbHkdZfZvHF+96EuZp8viMxJ2z0i1HACnFcC9WluHk/ImIIOoNGwMMsoj53ok6hA9S2Fu3zhBfq55FLOYvfl5kkikgaqJ7CwZ9PlwVDwnTvZTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEhwZO2wArVAblzDcpSalYjNa31/YvTnVJyw77trvh0=;
 b=BZAtCk3oEnHyFqVLmPpykOMyhyhsNQ5PIvIGn0lliGKelSU5isE+IKEIfmlt/kBJkpy8eDJIDHXvw3hm5mu5UqZQoctQWbO6ivd+w6j40yEWp3icFtbhlkdqNlXojuvlgK5PY2lYHppHIyj161/45+GLL/GqhmdyWYwyVI2258ivwvgk1o8BM3M6p9eJ9aFHSdc6/xAnX1aDrtGk21guac9Z29kM+q6pQhl57RQmrwBPOvt41OQ1CQpMYDhKfz7NpwzThDfw7GBiRYrYgZrYrZE3GCM9/GBTruT7wUHyBffruSZSgij2cUXVqsVi57jX77NNGkrThEj4ZHJTi9mssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEhwZO2wArVAblzDcpSalYjNa31/YvTnVJyw77trvh0=;
 b=dw0VpObIEiedHSL3ZbaKjT1WiyZG137CnftDrSZ1BxA7YECGOwFNSjmBH4Jk3Izrkwn24uNImOBX9eHUiKVMXcklzGk6KEf+w1urKGddDASa3H+MXSOlCGSM49yEtuxsUn+/bKV/Hf+ZCp9/Fc1rkEUpX1hRT5AXV4yTLZZVaWlwnNcdhgyKTACg5h1FwGzuzjiqwejliDUPwnCGX7PxB441NH5mft0vMxFGEC2i/TuXYlo/cdoKpXmuiY9MUpYcJYAosHSDws9pT70chYcEwsiG1pZ8M62v7eYF4XlakycN65T7SpeqaazozEsRBd2PPcQDOCWzGvRdpusJ9L6PcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.17; Mon, 1 Jun 2026 22:27:14 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 22:27:14 +0000
Message-ID: <ff1025e9-e673-4c61-857a-4ddd0f218462@nvidia.com>
Date: Mon, 1 Jun 2026 23:27:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Add GPCDMA support in Tegra264
From: Jon Hunter <jonathanh@nvidia.com>
To: Akhil R <akhilrajeev@nvidia.com>, vkoul@kernel.org
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, ldewangan@nvidia.com,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 p.zabel@pengutronix.de, robh@kernel.org, thierry.reding@gmail.com
References: <d548278c-8bbd-4871-8fb6-e22db1688546@nvidia.com>
 <20260506034624.18782-1-akhilrajeev@nvidia.com>
 <b6e85871-8791-468e-8c32-087b8fef8800@nvidia.com>
Content-Language: en-US
In-Reply-To: <b6e85871-8791-468e-8c32-087b8fef8800@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0005F6C5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::651) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: a25cf750-05f2-4c77-618d-08dec02cee29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024|18002099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yzpYbmOu07MIUEGpaKGndXT3x3id3Fo+pAxbCJ9Qr8MrovwKlPpOjs0pTgjqx7WjJX8jSyEOjbZvjgJmPssIJNaTLOSt1v8ipnSFk6QIELyd6TVYXV3hhS8Qq+I2UAHYtojgzvpYUKg9YMEJDrQXY1xrn8vVFjxDeDLsr2UjF0qlzZo3YT9hEkEvVu1FevHsg3X+3LV9KTXqPTcazamqd+VJcOPEE7N1YByyMeiADLGk2cNJqIn7WKCYHvkhzvCwU3ZPtY7+szCUH2lfv6eb72fFydW0HUNOrlbVanyRnsF0VSZBFva4nCVHODykOxmrpEnuNQHZQj5HUjCxnF5UrWPdJO1rT8EOEJngwhDjnKXGXLju1me1FtE5b9VLaATZPRk8V+1foVKcwwJ9f3vJxFm6uEDuDZzlNDOIZcmjW9kQenOT/QYXULLxaXB3hkAefoMmL2qYJvk1Y+4MGIUipfV9PVdl5Qa1V8K32C4wO8YRP/3oqGy/ubxVKF/fDiUK8hOViGpP/e87r4BV/uY47RHAJLwiZwYojgVdb+3ijJaPCADquzvhmFggV7RKsCExrlVVGYCFHAmXKz3121R0efPheu1v1YQyFBNE41QS8cphdNW2D9j+BqjdHO+u9nRSwd1deXLUX+MQPP0Ro78cf2YmnfHKQm9926BuVvvrQoJFtPt1FVjOUrO3NdCB0x6O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajd4VEVWcU9ic0pFTHRXQTJrMU91WGZkRG5kTU9YNXp5alpEOUlzbFFqejdI?=
 =?utf-8?B?VzJ4Zmg1dUc1N0FGVnlpYjJsZUZwMldjdThDSjFnYjQ4K0RTaWJPWHBTTFBi?=
 =?utf-8?B?Sll6WEpTQ0Z6em9MYXA1OWF4MFU3aEV0TmUrQ21Qb0VEUS9CVHhoeXlkbkh2?=
 =?utf-8?B?YVQ0bGJaY3BVN1JjTkhhcTVkVTZ4Sml0RnI5SmdWMVZwYitIYS9XaWFmd0xR?=
 =?utf-8?B?M0NOSTJtWkhlVHVCZWtlUzdIWlFFamdPRmF2LzJmNlJtMmJHb3lwRjV0ZUhm?=
 =?utf-8?B?NUNUcTJaN2hJUkhyR0F2dHgwUmJpMDVJWmJPQTZlSGtibVF5WVhSMUp4VWdr?=
 =?utf-8?B?bFBtdGhTdXlZZWlsU2lDQVBlREF3bDJZcTRTRWtQSHdLWnJNd3JYNWxLSDYx?=
 =?utf-8?B?dVVhajJpRmt0cTl3VURxZ2d5UTJzWVlLeG9IM3d0WWM1di9QNmZoMUpLU3Rh?=
 =?utf-8?B?c2VscVR3YXlKeWFPenBrUjJ2V2ZJcHltOExNQzhDOENjRzlWVG93amFqRTZ0?=
 =?utf-8?B?MENRejR2YXdXeXlQaTJ1T3NRYmFpVGhpNTFXUXlTRHFCU3pLZVN2RXIzYnRu?=
 =?utf-8?B?RVY4WXBRaG1HS3d0RXJnc2UzM2dPSjZITjR2VXM4OTkrU09VbEI2WGYyNG53?=
 =?utf-8?B?a01wdEQ3RytWSFpGN3hKUGV6WEN2MHhyWlA5bjA2U2lrdlRSZXFBcWRGb0R0?=
 =?utf-8?B?V3E0SG1pbml6cXU2enFYZGdjdTRhRXNNYjZ1TnJsNHdyTHkrSml2UHZuOWdU?=
 =?utf-8?B?QzNVcE5ZRVVNMDh6NW5TbURGbGhwQng0amRGcmVPZ3dRZDg2UndpOHNwVGFB?=
 =?utf-8?B?NXAyNnN6cFlhOHp1NEVXYmpVckFubWdjbWVJejhDZFpCSm1oUng0UC9NWWJ3?=
 =?utf-8?B?VlJpRU5WdHAyUGhlOEw1c3lCMnZ5VmlJMmIzOHFvUWk5YlRiV1FuL3MxUEhm?=
 =?utf-8?B?MjJaQVpiVUh3c2Q3S2pTakN3cHNKVWFzMUdNbDBDa3FuZXVPOE5JU21Ickh3?=
 =?utf-8?B?dUdnSE8wVGhXUnJraEtad3RUVDlCdGx5WUgyaXZGUUN4RFdqYzR2c1gvb2Fu?=
 =?utf-8?B?a2xrUnRTaFlUU0YzaDhJRUpzaFQ1eHN0dVBrK2ZxeXg0RnRXMTdWUHA2QTJF?=
 =?utf-8?B?UUpwSldOOEtpbCt4bUY2ODRKUk5FZlpSNHNWd1dYRWhmRVQvSHU3S1YxcTFN?=
 =?utf-8?B?VHE5SVovcjdOeWlUU3B0TkxmaUlpU2hldXBtM3l0bStuQVNIU2hOZmdhNFhB?=
 =?utf-8?B?TVgvSExGNFZtS29SRzR1azM4OG9nUk9jWmVEcTRoRkRxTVJMWmUwOE1uSHFz?=
 =?utf-8?B?ZGRpN0x3Wm5iS1lNUW45Y3VBVFBndExVelhNUlFSNXFEZEVrY25tb2VrRHYv?=
 =?utf-8?B?cEw5NzRIbUowNnhXdUwybkZXK2dDQXVrMmtZZXk5ajlBRkdDVnFVUDN4VlZm?=
 =?utf-8?B?VUZ2KzNNbnBkNTdKZFFhYmJ1VW04d2szMWFRczZvVGZGMXNwWDFuTmFyQk5o?=
 =?utf-8?B?UkVlMmNLQTFpZ0NWMWpCVkJKeGI4RytWWGZYT2RUZFoxaXhJNWFKSnpxRVla?=
 =?utf-8?B?NDczZ0lwM1Nsa01DVkVVSnExY2R6SU91NEd6RDM2Q0FSVlo0R2pTVDU0cmhh?=
 =?utf-8?B?bnFUbnlvNm1zSEFYaGRNVE1hU255TVhPcC84Uk1pWmhqN1hINzJJTDV3R1NT?=
 =?utf-8?B?NCtoRWN4ZzFkWFM3a1pjT21ISXM2SGV3LzBrL0dmeFNSbW9wenFYamN6UThx?=
 =?utf-8?B?QzNIVy8zV0dwbmNaWU1sSzNzMXY5dFJ5c3Q1SDUvYUFPM0NJUkJ4cGdwUTRh?=
 =?utf-8?B?RVJnV0tLb1VTSTBXNmdKRzF4U2pxckw4a01mQnNWMEtwMGN5akpmcHNRWmd6?=
 =?utf-8?B?djVXUEFiK2lWVlVZZkdFZTRpSVRNaE03NCtQMGZlMm9LNEd4UXhqMVJpYmpU?=
 =?utf-8?B?ZUpOb0hVK3dHSTUyeTRiUTh4UXRHSEREN1BlMzJCdUR2em1vVitrc0FIanRM?=
 =?utf-8?B?ZDQ0T1dkUC9FUzdjOEc2OU9KQS9CbUZZY09pN0hrdmppQmVpWE9mQmtiKys3?=
 =?utf-8?B?NWg1ckEvU3QvcnNJQzFHSGZrZE55bnhkNFJjWiszTlZxaXVNYVhkQ1BvY0dp?=
 =?utf-8?B?ZkhtR1NzbzNZMWZqK3VxSCttOXR5YnFFNkJ2Q3cyYTM4cE9obnpjNERFeTR1?=
 =?utf-8?B?ZFlUU0tDSjdnQzZJVXhJdVM0ZDZuZXl6M24rK0hnY2daYTlLeHl1enBUMk02?=
 =?utf-8?B?eUpUWGE2QmxNc2JmRmxKUDR3VmR6b08zM2p1SFpBa2VDbGt5M0t2TVlyQmtZ?=
 =?utf-8?B?Q0xIRGMvMDBmVTNhUlo4MXNsSVk1NVZLekhtRVFpZmZ6RUIzeTMydVl4TERF?=
 =?utf-8?Q?R52EVvQfzN8X2mG2WUcD2sNx38xkvRkLT3wZugZgseOs4?=
X-MS-Exchange-AntiSpam-MessageData-1: aFaxIoGr18dv3A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25cf750-05f2-4c77-618d-08dec02cee29
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 22:27:14.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsvJqff8r6PmdcuzAJOH4B+ZGMZyE4/j2Zshw6o8M/LOC0OxONAd6m3+diTT0GS6ZC4fgAI+6QP4Qbr59CkMdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-11111-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,pengutronix.de,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: CE261625EF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinod,

On 21/05/2026 11:07, Jon Hunter wrote:
> Hi Vinod,
> 
> On 06/05/2026 04:46, Akhil R wrote:
>> On Fri, 10 Apr 2026 09:09:38 +0100, Jon Hunter wrote:
>>> On 31/03/2026 19:06, Jon Hunter wrote:
>>>>
>>>> On 31/03/2026 11:22, Akhil R wrote:
>>>>> This series adds support for GPCDMA in Tegra264 with additional
>>>>> support for separate stream ID for each channel. Tegra264 GPCDMA
>>>>> controller has changes in the register offsets and uses 41-bit
>>>>> addressing for memory. Add changes in the tegra186-gpc-dma driver
>>>>> to support these.
>>>>>
>>>>> v5->v6:
>>>>> - Replace dev_err() with dev_err_probe() in the probe function for 
>>>>> fixed
>>>>>     return values also.
>>>>> v4->v5:
>>>>> - Use dev_err_probe() when returning error from the probe function.
>>>>> - Remove tegra194 and tegra234 compatible from the reset 'if' 
>>>>> condition
>>>>>     in the bindings as suggested in v2 (which I missed).
>>>>> v3->v4:
>>>>> - Split device tree changes to two patches.
>>>>> - Reordered patches to have fixes first.
>>>>> - Added fixes tag to dt-bindings and device tree changes.
>>>>> v2->v3:
>>>>> - Add description for iommu-map property and update commit 
>>>>> descriptions.
>>>>> - Use enum for compatible string instead of const.
>>>>> - Remove unused registers from struct tegra_dma_channel_regs.
>>>>> - Use devm_of_dma_controller_register() to register the DMA 
>>>>> controller.
>>>>> - Remove return value check for mask setting in the driver as the 
>>>>> bitmask
>>>>>     value is always greater than 32.
>>>>> v1->v2:
>>>>> - Fix dt_bindings_check warnings
>>>>> - Drop fallback compatible "nvidia,tegra186-gpcdma" from Tegra264 DT
>>>>> - Use dma_addr_t for sg_req src/dst fields and drop separate high_add
>>>>>     variable and check for the addr_bits only when programming the
>>>>>     registers.
>>>>> - Update address width to 39 bits for Tegra234 and before since the 
>>>>> SMMU
>>>>>     supports only up to 39 bits till Tegra234.
>>>>> - Add a patch to do managed DMA controller registration.
>>>>> - Describe the second iteration in the probe.
>>>>> - Update commit descriptions.
>>>>>
>>>>> Akhil R (10):
>>>>>     dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
>>>>>     arm64: tegra: Remove fallback compatible for GPCDMA
>>>>>     dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
>>>>>     dmaengine: tegra: Make reset control optional
>>>>>     dmaengine: tegra: Use struct for register offsets
>>>>>     dmaengine: tegra: Support address width > 39 bits
>>>>>     dmaengine: tegra: Use managed DMA controller registration
>>>>>     dmaengine: tegra: Use iommu-map for stream ID
>>>>>     dmaengine: tegra: Add Tegra264 support
>>>>>     arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
>>>>>
>>>>>    .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  32 +-
>>>>>    .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
>>>>>    arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
>>>>>    drivers/dma/tegra186-gpc-dma.c                | 429 ++++++++++ 
>>>>> +-------
>>>>>    4 files changed, 284 insertions(+), 184 deletions(-)
>>>>>
>>>>
>>>> For the series ...
>>>>
>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>>
>>> I am not sure if it is too late to pick this up for v7.1, but we would
>>> like to get this into -next if you are happy with it.
>>
>> Hi Vinod,
>>
>> Just a gentle reminder on this series. Could you please take a look?
>> Please let me know if you see any concerns.
> 
> 
> These still apply cleanly on top of -next. Please can you pick these up 
> now?


Please can you respond to this? This still apply cleanly, so we would 
like to get these queued for v7.2 unless you have some objections.

Jon

-- 
nvpublic


