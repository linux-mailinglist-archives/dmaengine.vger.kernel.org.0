Return-Path: <dmaengine+bounces-11290-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e8XONwpgJmpiVgIAu9opvQ
	(envelope-from <dmaengine+bounces-11290-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 08:24:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F3B65318F
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 08:24:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rpbDuBir;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11290-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11290-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F99301A913
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB40838655B;
	Mon,  8 Jun 2026 06:22:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F632E141;
	Mon,  8 Jun 2026 06:22:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899777; cv=fail; b=hg7D/MOPEZXzinsxyvTCGEEVV1BsFXnogd5y35p5wfj9bomPbk5k1VPsFyhuCGyeokvXODcL1bLQM/wvedQR+xGh1Huwe1nEf/VV8pcZHqIUcrDv5tx2gfXhLh/oP5UIYh3N4vAnukxsobuQBBKYG/9Ueeiz9C9OPf0vhPMbcns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899777; c=relaxed/simple;
	bh=sQODGCiPd6R/QscWdcBeVrXombIX7+w0qmvO5dSEq0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPYkiTas17YJ5jWPMs0hV1aSDdg+7hiIgPhgVYujsYD0ybgDHU7VPtrl+pbNYpxNmJym098TiY8in3Ur7ORwV9WLv2tBkePRKp/gwjnm/l2mu2D54x0iQkuiBYf6FBnNb16S+tPbJB7i3ok9oTf8hxRnuows/Jzg64pYu1hXUn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpbDuBir; arc=fail smtp.client-ip=40.107.209.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR+A5QMSNB2MHnYX1Mo4d2qdVV516avJbL5fD/daIK/+ETSD5Y/3EymESJm4LjgX7dTlKJg7kXnuu2jkT9u+vwqeNGRKkHIHfCiPInjPygGbHxA0oIp7RivNHWsxp2M3DCwxqS/6nBdAPTa8dWzWJD655PKd1wZTgjJuBxbn0jE8mDbUX3qctlVxRfxsB156gNvj3lIpOyoukO5NcD0FBhEzgbvhnaJJ/k/XK89BP7juJW10z9znGE0VbuQO4LCV1xAt0rgnJwhRX08f1+pj15NiGeEUCNP7xDctDXsVVfmPg1r4kMf8296TWMmQfCSYDMOnZdsWPznhUwNVv7L+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGO5so+YKolFmLuzh3j1apkGLr7fgWppK/Ax4uy7cTw=;
 b=RMp7kBxITrVInAH0ymZbZIul1PbTD3V6CEpVjDPrBrA2v3ICEabiaxRBVwN5ycvVgSUWLTM9XcTR55th9HKmKvhyn6ZW95sU/94e1vMzafGYqPuPf2JJpfL1+wTw191qERG9jy5a6HYtB6nc1o5TZnnrU+7/KSQm9BoY7Jtq8eESExPTzYEH4O2mmlsQVjrybzQUneHBbfIiAq/2PgO7yVCcwS9wrK/n48sj1lNz72Pc8QPHyN6afkIlz5B4o3uAP7QnsqBCF90e3o2WEq52qQqjT6L59E4pxcyY5fE2jtRT04PmQm91wtj13us7/XuLIRF57Jozf1+VwYTwyed/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGO5so+YKolFmLuzh3j1apkGLr7fgWppK/Ax4uy7cTw=;
 b=rpbDuBirrG04YhgSEEAa7NVEgwKmCww9rOWBEZvQ/j+/Fa3UZKZhRyx86Yf3TkYDahgwzT+DTpG9bjHbLS1q6ljPkj5qCoErrG8lWEcklureS8A/vTSOads+nZ4qAWyQyjdFQVYzwhLIPI7AHPDBTB0fDJuCnCloDlEnXjSoVY77g01ccvENqRZ9pgH3eESpyglH+S34ZNUpS61Au3vjYcQstKOsavhh+g/3acvCkZ8RONGEoaHLafH2mk6kpwwVtF+FaMgz3rZoHZ8gpP8Dm/P9aXENswzfzX5OCpGmbSefbvMKj3hJm0SAbCyqXpsxLq0zlT4K8fUXPMF7rXvyMA==
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 06:22:52 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 06:22:52 +0000
Message-ID: <7665c837-ee07-4ec9-bf4f-4b8731a3f31c@nvidia.com>
Date: Mon, 8 Jun 2026 11:52:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] dmaengine: tegra: Fix burst size calculation
To: vkoul@kernel.org
Cc: stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, Frank.Li@kernel.org,
 thierry.reding@kernel.org, digetx@gmail.com, pkunapuli@nvidia.com,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 ldewangan@nvidia.com, akhilrajeev@nvidia.com
References: <20260422064134.1323610-1-kkartik@nvidia.com>
 <98255b77-dcef-40c8-8851-91e723b82ea1@nvidia.com>
Content-Language: en-US
From: Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <98255b77-dcef-40c8-8851-91e723b82ea1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::19) To MN0PR12MB5716.namprd12.prod.outlook.com
 (2603:10b6:208:373::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 37676440-c3cb-439f-e414-08dec5265e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8gQK2i/j8YxLQcWFp3GyrWeSPk2n273xGvPvKgi2aX61bXdjVXuFVbjLGWWnmxxia6OciJB5SaQdH3viUzzmDMEiZnbGiClTQiwZbiUGA8lazUjPcDR3DcQc81yDsmCP+WH+DaG/xoDeCE+BAlSisnxuaz4EPWRjSpcbdS0qMVYkxIqQsNcnBrqzfI08iMJxq/AdlwHDkTSgR/AeOr87dJt1LyouJkp65HA2dbDt8NdirB2csZALSeTm4N6oMFCG85qVbR0JWQuiJjYAry5v8ak/IHkS0/PpzQzijnGVWDpY22/1LfyriPtyqVbZIYENYJi6WKHb+v5iARHmF5Ud0oEAhv+eHzgVcqzdEyTP7dlNWkRgIuQkkKq/d+MTnq9SXYRNdp58Uleo7Rk639Rg72ZPx1Tcix6zSg1r8k3D7OiDuSNy3mqczFOe6tvcZ69t3d++D3BI1cFLRuCO4degKTkVxZVW/FZbNnp+SeDn0BvPPpmc9VAgtCGkLUdC6dyFnCUdzS5EzCtfWSIgOtJXuuW4BrUx6ph1Feu/Hxsyi/EkY8F0rrpJYZzvhvJyz8eLt5yl52kKnpeifNIjnhBNXnMO8ji9ue/wrBYq/ZIxYv0v2+3KV7ZrcD2Q+zh5dNdLoI9uQ1xVrDfWq9Zu0hHNB1vV/Q9YKhj0opY22vq9oMHsUWWSig+yDbDHW4zuOtpkzY8cNtsAkt4APFUMa0BYOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFJMZGtYMEFhK1R6L1NhQ2Qra2tPSUVNQUZ5SjZUVllSYUI3S0oyT0JLU1hu?=
 =?utf-8?B?VXV6bW9GRUdodDROYm1rTHRMTlZnbEVQSHJjbGxORGlhRHByKy9MVUw0Z2gr?=
 =?utf-8?B?eTVEd0FBMHA3ZFFJQjd4RjA0VWY1Q3lHNVo4NG1uMXlwdjNOdTFkdHk1Q296?=
 =?utf-8?B?MkFpdmlwR3MrQW9zSU1lRGQyUzFVRDc5c1NqN0Z1SDBuQnU3QU5PbUMrOFpo?=
 =?utf-8?B?eWJCL0lxN2V6TDV3a0owVGUzRDZKcUNqS0ttNnFydjZSaWgwMXdzdDN4cTV4?=
 =?utf-8?B?VFRFUWJuZjlPc1preXhOd09uZHlqOVJ4ZkJlT1VJcWhEa0E1RmpvTUZpRm9N?=
 =?utf-8?B?K0hNTUpXQWxlVitzb0RIUkltZDVxRWJ6bzRlVWNEYXFoTTZsTUZmQWtQengz?=
 =?utf-8?B?RmQ4djdINjNYeHR5Z081YmJQL1kzZ0N5NGwxdUYyWDZLS0NoUW5OQmNiMnBs?=
 =?utf-8?B?cmE4Mnc1SnVxRkY0U3hmdVFHSWtBR0hoNi9xQnNZTDFvcUJYSWVncDBBOVd1?=
 =?utf-8?B?RXg0NGJmcEREbGJNNGxLcURDcVhYbUYxd253S3NLMld1eXRuNlkwQVMvdEZ0?=
 =?utf-8?B?OTdsWWJlN3J4ajhzQmw3MmdLTFR6VGwzQnNya1EybDFSa0FwczJjMWRlR1dT?=
 =?utf-8?B?Sk9nUnd2cXZIb3NHR1JwdzkyemlCbVE2L21HRkhCcDlsbEhGem9KSG1ib0Zu?=
 =?utf-8?B?eXJaK3Yvb3U3MENpN0FBMldINVFDWGk4NGNLakFWS1FwZHVIRFdPUFo4bk5i?=
 =?utf-8?B?TGhVREVVTlZhZFNuOVB1bHg3R3hZQWw1RTg3UFowUm4wdEVVcnJHVThJWmxT?=
 =?utf-8?B?UUpjQnNmUkdmM1BGOWpFb2RaNXJ6UXlLK2RuSjgwR3pkc2RncDllNEZhb3Uz?=
 =?utf-8?B?R1JWZ0tIRW16OUxNRXNMR1hESmlyTTJEY2FmY1hJTzVQUkNqdnJoeWFuUHVG?=
 =?utf-8?B?NHE3cllPemRSbkZQT1laKzhlVEJsN0oxLzVDMGU5a0RWUUJIb2RKbExHZGUx?=
 =?utf-8?B?N3RVWGlEQktxd0lWa2ZrcEVTOVQ2RzBvTVc0RjF6QmJtcHhwcmdKcjZzRVFk?=
 =?utf-8?B?TFcrSFZYa3I3UkNKMy9VQXFVNWpKRUQ2V1dXS1ppZWp4azVrSCtHVktKY1VX?=
 =?utf-8?B?aCtHUGtXeXdXNUlsUGpGK2JtTy9NU1ROTzRwMnN3blNJT2JwMVBNWHUwc25O?=
 =?utf-8?B?SUlZU0w4eGx0U2svT1BPT0xhcFQvMi9ZaXlnb1NiMktGaDJPMGNkMHdpTWt4?=
 =?utf-8?B?aHVEMmRUUUN5a0d6RjF2TUlKU1RVeHFYS2ltcTBiL0hlZUI4VC9rbGZuRG0y?=
 =?utf-8?B?aXkrQVRPSmd2bGR5T1hPV01DU1UyVzY0WEFhRk1NcjA2Uy9za25aQUFJdXZy?=
 =?utf-8?B?U1VaR25VRjNFcEpYRE5HYXdzOGV5dWMyeWE3Q1hqSmQ5NGsxS3hZQVhxZGhi?=
 =?utf-8?B?YjdJK3YyRWxFdUxmdGpCeGlwZDQyN1RScU5jYXowalFNMjhteVdNN1JDZlds?=
 =?utf-8?B?SlZpSGRMKzhNMmhhOTc0VEhvMW9lNVkwZHpwM1ljNGlqaEZrdCthdFcxb1Bw?=
 =?utf-8?B?Qis3aVd1QUUyQXA2U0paZkRTMHBGS0w4alkyLzBJRm4rSTRKWi9HakNWM2Z1?=
 =?utf-8?B?Y090MmpmMklMcENSanhpcmpXS3NYQldURjBjenhsK2xwcDlCQkU1a1B1WGFw?=
 =?utf-8?B?Mkk3KzExM3NadVk4TDhYalJ0UmtzRUdadU5CQ1NBQThkandBUGEvT2VNa2RX?=
 =?utf-8?B?WTkyWXczNzRBcHVrMjJ4Q0ZwWU05UnUvM3U0UTdSYTNTT0xGRGpIMzBoRlp5?=
 =?utf-8?B?ZjVjRHRsWG1NZElFRUVqRnEwUEVXVFMwUEtxaXE4Zm1GN2hoVHJjWW1sYkNu?=
 =?utf-8?B?ZEZEeG5YcHNwMTF5RExGTVFsdDl0ek9ZaTM0QmJjVFpxcW9EMTNLWU1sS1ND?=
 =?utf-8?B?eEcxQk5BbnhYTTkyK21NRmNYQWxPZmtTV0xVN2FFM25vQXdMN3RVVk9UZjVS?=
 =?utf-8?B?cXZGMWF4V0JIQ28zQXFCU3kyT0RlTWR2U1NGN2xrQ21LakNuSzFQaUFLQytt?=
 =?utf-8?B?c0psWHV1cUk1NkxPbXh0R3F4NHp4YWw1SmRsbk9Xb3lHSGxHVGlFMHh2SitY?=
 =?utf-8?B?WTl1cHE2TkFsUEhTbE1xc2liU2xmblBBa1dpbzVLc0E2VHJOdWZUQnVHc2tX?=
 =?utf-8?B?bEdPWk02QXd2c1o5N2RRWWtGcm91YkJ6eXEyYWtMM0VWcFg2ZHZETTJaa2dL?=
 =?utf-8?B?b0pRL1g1YjIyYlM4RVFhZWgvbEVEeExsRkl2a3hFemhETGdKSEtYenBzN08y?=
 =?utf-8?B?OVlrV2N6YjFrMFJJNWh3cVlScmdBVUVoTVc0dGhnaXBiOTRQSHRNdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37676440-c3cb-439f-e414-08dec5265e7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 06:22:52.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu7sr3FFf9muhYHYIIqaP6GeX95VbTIY0P+fvhuTjD1UFZLgR+LTHGnEhqbkzPxv2LMwHHnEw5oJszpeMqJ9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11290-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:stable@vger.kernel.org,m:Frank.Li@nxp.com,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:digetx@gmail.com,m:pkunapuli@nvidia.com,m:dmaengine@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jonathanh@nvidia.com,m:ldewangan@nvidia.com,m:akhilrajeev@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kkartik@nvidia.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,kernel.org,gmail.com,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kkartik@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80F3B65318F

Hi Vinod,

On 22/04/26 14:56, Jon Hunter wrote:
> 
> On 22/04/2026 07:41, Kartik Rajput wrote:
>> Currently, the Tegra GPC DMA hardware requires the transfer length to
>> be a multiple of the max burst size configured for the channel. When a
>> client requests a transfer where the length is not evenly divisible by
>> the configured max burst size, the DMA hangs with partial burst at
>> the end.
>>
>> Fix this by reducing the burst size to the largest power-of-2 value
>> that evenly divides the transfer length. For example, a 40-byte
>> transfer with a 16-byte max burst will now use an 8-byte burst
>> (40 / 8 = 5 complete bursts) instead of causing a hang.
>>
>> This issue was observed with the PL011 UART driver where TX DMA
>> transfers of arbitrary lengths were stuck.
>>
>> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   drivers/dma/tegra186-gpc-dma.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>> index 5948fbf32c21..0aa3a02b2277 100644
>> --- a/drivers/dma/tegra186-gpc-dma.c
>> +++ b/drivers/dma/tegra186-gpc-dma.c
>> @@ -825,6 +825,13 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
>>        * len to calculate the optimum burst size
>>        */
>>       burst_byte = burst_size ? burst_size * slave_bw : len;
>> +
>> +    /*
>> +     * Find the largest burst size that evenly divides the transfer length.
>> +     * The hardware requires the transfer length to be a multiple of the
>> +     * burst size - partial bursts are not supported.
>> +     */
>> +    burst_byte = min(burst_byte, 1U << __ffs(len));
>>       burst_mmio_width = burst_byte / 4;
>>       if (burst_mmio_width < TEGRA_GPCDMA_MMIOSEQ_BURST_MIN)
> 
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Thanks
> Jon
> 

This applies cleanly on top of Akhil's Tegra264 series:
https://lore.kernel.org/linux-tegra/20260331102303.33181-1-akhilrajeev@nvidia.com/T/#t

Could you please pick this up if there are no objections?

Thanks,
Kartik

