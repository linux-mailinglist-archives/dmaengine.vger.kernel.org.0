Return-Path: <dmaengine+bounces-4146-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649BA15223
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 15:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869441677D9
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2025 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81F91547F5;
	Fri, 17 Jan 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kPXLKJ2g"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9125A62E;
	Fri, 17 Jan 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125545; cv=fail; b=TOakhjD5E5vWWPAiRgN2Z/cNrcgY4362r1et9sMdvSqgyIP/HHzcxfVdBFICQmGDiTuTWKknRTifpyWiaS4G1MZn4bunFFvOVVFcCjOJsiawrOHJ7jo2x+rgDjZ/6D08x/TmzIchhCRHPakZu8BnNTwlSPY0/peUnLTAdNRTQ3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125545; c=relaxed/simple;
	bh=H8cz6xUeTAtygTxtjFq9ebfTYwjh3vIXrm2a6B2odeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPBbA6th4PFO1BUqQ1EkQteSr7ouuIuapFYibQTtVfbL9ZrBZ8iS175iHNn1nUvkzV6pvrFcVD3y4jGTkKcY1ie9Zj7TVbeU8pga1oT6W+QpY8cKF2cQ97QshVGKVJCfF4OuYU4hDEWo6+y/fYjEpGmnaaSZxeWpXWOvxiLN6AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kPXLKJ2g; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTxP/r2PZt/tHD2MmHQKT5fiT2DaH1WIUYQSxUQqd9bppkVE9EFzkZjLosf/hqdFyVlwHHW67tJzl/XSSmke7IlkfODja8jY71I5/WC86ubD6mGCtmF1ZQgJm1Kh/QSTeIC3dyYz2VUt1T/oQueQzIoUjc4bt2U4NKp6Vql6PM+d3VjKDgr2geAv/EaHbYKXlpOAZa5eCIaZBR+QmeVpOTmebOC+MR+yJeT/Yy0C/YIs5m8XhnX4rRdhCYxqmWusu/L8xONNPg4Bqk3PkttcO0Uf9ec0IuPX/pt0OSXGZqQeTadFNNwC9UxT/jlzfTDc6bt5+4uAsc3kVMVLFCUQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BocPNPRlHtDqUFy8dfDzEDGHyeY1kF+qjQpj2w6bS+c=;
 b=TwekUX2EWDgcCgS3kxbePPlzMwGZr3ZLVEv8lTlORvm1biLGdO2b+cyuW1F2Mdb/rjO83WzzJqbOoBHLeyv3UtnNg+koZIiFH85fwfvVZJzREw7b2k/69qnp2s9GzZ+u8340/9KSmUQGChOcqNpK3MfFoUF6BI8RG9mMabzKlJJDENxu/U7oj86WfFb6OyqeZ8ZhDq9MpgZfpeY2sOmXwxJaYUspKFQCWEFgq63tfGX8S1x1hKrMY5HlKR1FBknXxjEbMJHnH3s7/JB9wLLXDRpnJ5ArkN4B4VgsrODyeCmGUFQjj9BrUtetEVXjUChVFGh9p+tpy9HDkCvtf+sZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BocPNPRlHtDqUFy8dfDzEDGHyeY1kF+qjQpj2w6bS+c=;
 b=kPXLKJ2gh08myM7sbCw0XMOnz0GKRF3q2shNmrK2ZUauvfFOzF+0wYP+YZFiwo+tPcqVwJbG6vu4bOz5vcpLoaGKGElFaC5qA/NQQEZaNS5eFtU3wgVqLjDNvQnAE3d6l3w0DiW4YJT13U4Bnjr4OzxPkq2E1CCnCJ7BlakB5t3s2ND8nXKV3qNTKxSu8VvDNTPRod+qg+pSbLs7OhoWd0L//C3l70tQAAqKrIiDY97PmP7Hl/rjZmPwL9x8iFb1kiIhSFW1IKMzC6/+/3QGxFvgbr5AR7fojiOj7YHYn6WxY7VbxFF8g5w+6JfK9sr1dTTZ0duja1DNgNtOQzXhng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 14:52:21 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 14:52:21 +0000
Message-ID: <ea04c16a-67c9-4ec6-8dd0-54c18bac87d9@nvidia.com>
Date: Fri, 17 Jan 2025 14:52:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
To: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org,
 thierry.reding@gmail.com
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-2-mkumard@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250116162033.3922252-2-mkumard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: a34d6419-2f19-42ea-6776-08dd37068bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXpVQkRobkJxc1htc3cwYldmRG9pNjFXWnMxdHdTSXBFWjRvRHpYVDNPOWVG?=
 =?utf-8?B?T0x5eGw3MG5neUZtencrMzJqaFN6b0c0bUNOaHN6VEV6U1Zhb3NXYUxEcU93?=
 =?utf-8?B?L2pTOTdIV3BOUGI2dTBlWE9RZEVkR3MzdzFIOEprK2t0SEpmQ0ovdmM0UzJO?=
 =?utf-8?B?bVhNRU9MZjI1TWc1N0dJOFF1REYvaDJmeUJodXJNSkx5NXlXemZZT1pIclJj?=
 =?utf-8?B?YkRLTk1HMHJDSDU4WWNLc2hHYjBsWWJKemc4cXRUTHk0dWk3czEvNlF1N3Jx?=
 =?utf-8?B?QjUvazNhNTRheXc3S1BpeEFxSnBQWjh4M1FGZGRUdklLc3RiL2FxaE5scTlz?=
 =?utf-8?B?VElzU0RSVU1rTEFUaVAzMzlRLzRhN2ZEd2YzRG05eDJ2MXBZUnJObGQyWnBG?=
 =?utf-8?B?dTJ3NVhwM0FnRVR6MXpXYURvdzd3Y25rR3daR2l1QWltb3IrcWgvVlRnOW14?=
 =?utf-8?B?ZWhTOEYxWC9kemZ4d2tMVERnV01iVzNoR2FrYXNSZDh1dEJuT0Q0R2ZYdWI2?=
 =?utf-8?B?aUp1YlExbnhnRG9MbVU3amRJanFOcXJ0engyMkVENzBGaHFLM1VkUEJJL09W?=
 =?utf-8?B?RVdwVVZ5YnlleUxJQlM3cC9OUkt1RFFiMEl0aWYvWkpyS1h4a3hvaENOZE50?=
 =?utf-8?B?SHk5OGJtRlFkRHZHenM2MHgrNytSeWR3eURoQ3p3NWsrSndzaFBheWRtRkV1?=
 =?utf-8?B?VTlaaHhpcHhrZGZTVldTY21EdldweittajdmNXdaWGMxRzQveTkwY201YmpW?=
 =?utf-8?B?VjUzTnVvOFpvbExFUVBKUkk3dkRDS0RSTTVJYVZyMjRwcTNFZmh3aW1OWGhr?=
 =?utf-8?B?RkxNZGxuVFh4MjgwSE5aRk04dzVhK25qS0NiYW9adDNOaU5ONkV2M2JMbUZK?=
 =?utf-8?B?NjY0SGZyWjVoTnZSa2w3NjRjamtjajlESVJCRHA0TkVqY1JDTW5KbkFzYi9Z?=
 =?utf-8?B?elRsMlQxT3lpQ2lvSm1zcFUxZEhzZVZndkdLRXplTTFEaWVNeXgyQi9CR3kz?=
 =?utf-8?B?eEcybE5PVk0zM0JVNkYyRmhSTXBTdGhlNFNpWit0WXdTdkdlVW5BeGxCYU1Z?=
 =?utf-8?B?ZWV3a3NKYVg0V0EyakdwcnA0c0RIOG8wdG96Rkt2NXZkbFFEellFWi92S3BJ?=
 =?utf-8?B?Z1RuOG5mWUtBbWlTSWoySFlhVWtoRE9tL1NKWXVzb2NwSWhFWTM2U0VTR0pl?=
 =?utf-8?B?anJ6Vld0SGtmN2F3TTk4NnFNQVBjRGxWRWV3RUhJdEw5S2R5YXF5Z2ZIbVBL?=
 =?utf-8?B?alYwdmVSbDRUalg4YlgxOEZYeE1MNVRIVFFOYXFKeGdUUnFEWUR5WVI3UGNk?=
 =?utf-8?B?TFhzejhQSnRqUkJSYk9VeFBuL21uNmNheGd3V2RZRGdvbXFGcU9xK3pUTHg2?=
 =?utf-8?B?bHVsYW9HcUtndEoyVGVGZTUyeStsanNCa01tZXdFaldMYmVYaFBLNUhaSjZ6?=
 =?utf-8?B?bUtHL0tQNG9Vd0tjMHNPZHAwTklXRnlOK09OODE2QWc0OHBYdWkwSFZGZEJX?=
 =?utf-8?B?WlhVbll4dnQ3UnQyTnF1Vkc1NjFmeWpnWUpoaXl0cjY0Wno1TGtpaDFmb2VX?=
 =?utf-8?B?aXJKRmE5Z3lvZ3FmOGpXRXZ3ZXl4YjBuL1VjMDRIajlHU1o4V3FYc1d4NGww?=
 =?utf-8?B?M1c0d0ZXRktGRmxhNjRBZWlLemxKTmUwNHQwRmc0OGlIYzV1cVIyclNiMGtI?=
 =?utf-8?B?M0lwT0NmejBVOU4zbTFiYWxkSnZPZzlGSm5ib0N5V1pkeEJMK1R2KzhOQWhv?=
 =?utf-8?B?aE1vcUNKRDZtUGsyRGNVZnI5N0llN2JXU2JOOWo0cnZZelVwS1JFRnJBUFNR?=
 =?utf-8?B?SVovM1ZvM2dsenQ5ckdZL0R6YlJkSWVrQWdvSzR4elBlWGYvVldmdk5JQU83?=
 =?utf-8?Q?Tj5er7gny7YZi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aS9PcitrRHdWYmIyaXJRNVREVjU4NExMMzNhNnlNdHJlYk9NNmEvMXBtSm92?=
 =?utf-8?B?K2pqRHowWEFFbnVxNHJCbWNuQjE0YXJFZ01UNGxXWlpSUVZOZkJycjNNaXpG?=
 =?utf-8?B?dURHYkNET0hxU2RHL1RZZktMLzR5b3plMlNyUDNTbXhUdENKTHZUMTNaM0kv?=
 =?utf-8?B?eUdad1dyTFI3UjExRDVoejNTazF3b2toL0VlVFJsV29OL0xlemlIcGx5V0JN?=
 =?utf-8?B?UDA0K3Zwemtna29LbzFkcTduL2ZNelNaUXcva2tmdGFMRi9RM3MzdXdKVDBG?=
 =?utf-8?B?L016a2ZNQW9PZGw2ekFBaU5zZU15b1ExVGRiMXkwYVZHTndTaVNRcmhuWjBa?=
 =?utf-8?B?MzRDWE53VURuQlVjT2V4ZXpMQWtPZnp0OVpCY3ZkUDZpNVNJVnZtNExlcElT?=
 =?utf-8?B?cTZaSmtBWER0a05FOXhmck1uZE5LZTQvZE44TmM3c1BYR3VkVkE1UGsxMkFB?=
 =?utf-8?B?c1FJYW5SL2ZGT1poeG1VK25kbTJNL2EwcG1wKzNBU3BMS0lLdThJVys0Ti9y?=
 =?utf-8?B?MFM5T2ZWd3VxK1ZDYmRka3BQWVpKbmVSRVkvQkZkenJMSTBWeDNjTmlQMTNk?=
 =?utf-8?B?VnJzaENJalN4QmRkQTN5TEd0NVZoOE8weW9kOUFmZ2dwZEgvSVM2UmZOYWJD?=
 =?utf-8?B?Q25ZdTQrbTJYckdEOVFvWmZobFhUNkRRZG9EV0JzV2k4RkJKOFk4dDlBNmx5?=
 =?utf-8?B?ZHUzSlY5ZWZ0cmVteHM1RUhhajlsT2FHTC9DcXlyRXlDb3lmN2RoYkpIdnEx?=
 =?utf-8?B?S2NZYldXNFQ1OGVmdmprZm1VSlcyY1FWUnBhcCsrTU53WGs3cmIzdVVPRlJy?=
 =?utf-8?B?NmFRa2h0ckQxOW5ZdHZYVC8vZW00bDRUMmljVDQ3QjhBR2s1SWtCYkhJSlo4?=
 =?utf-8?B?Ui9mdWh4YlcyVXphelVoZkNWdzVSc3RQMU55MFlpSkJDdHJuUlpIbExVUXFz?=
 =?utf-8?B?NXVPS0lSczJkSGtucUhsdU5aVnA0OVV6MWxnT0lZblZNNE5DVHgxQXY3YUgy?=
 =?utf-8?B?Nmd6YXhEZUwrOGlNTXkyeFhBNHFKZ0NxMDF0dHJ4ZVQraWpKY2w4YWNuMHpZ?=
 =?utf-8?B?U3MzdCtELzV0cHlKY1VRSE9kOWxiRTIyZmhKS3lsOGp6OFpHWEZuRG1VV2ti?=
 =?utf-8?B?NzVleDNrWEROYnFFcGRlNmJJMWVvMFc5b0NzUDV2eTlTVVNxZHpST1lwOElG?=
 =?utf-8?B?Qmp1Nm9EQ3BYL1NTd1dETkFzVHBXNkFQK0trZlJCVTZMR1JNMVY4d0tFRlFw?=
 =?utf-8?B?UC9ZV2JpeW9YMFFzRWdISG5WaVlhOEVNTnhXU1kxVWJkR0Y1ZFFBR29aZjFW?=
 =?utf-8?B?YnVIaHVXMUtTWEFaVVpzdU82bnkwSGlVeEgxSDVRZUY2Wll6dkFXT1pwYTll?=
 =?utf-8?B?RzU1bGtEOGhUd2htNUgzUHhpNWxlbzhSblh0cE1TeEdrOFYvYlN1WjBYK0ZE?=
 =?utf-8?B?U1JtanYyNjZwS3Y2OGpCTXp0VW5iTk43QnVKU3loTEpobDZCamVjNzhBNzkv?=
 =?utf-8?B?a0pId09DaERWWWNNVmhoTThGVVh0UTZFT1YxT2hnRlBBcnAxODBWa3g0dk5L?=
 =?utf-8?B?RFlySnNxempnbGNZKytOMEZ6OGRKbUxvN3Nlb3FJNlVCVXFKMVpPNHdxNU9K?=
 =?utf-8?B?eU9yeXRiZ3k1cFJsZWJzNm5RWG9RV3lXSUZ3ZFJ5SUcxQXl5eHRwcEJTWC9w?=
 =?utf-8?B?MmZWZDJOa1dUTHZ2cXFGM2YwcFVBTitTNERIK1ZlRHV3Z3RKUTBjR1dTZ0kw?=
 =?utf-8?B?bUlXcXpRcE5mbmNhVm9yamJoZ2p1UlVhSGJxR2pMNVZ3TDNEeWVXaU8zeTRq?=
 =?utf-8?B?T2IvVWhwei8zUjN5Qk4rK3R4aWVCbzMrL01FZ3h2WFltWHdwT3NzNUtIMzl1?=
 =?utf-8?B?SlNlcXhMZGpDY1N4SnJUc2xrZ0pJd1hOdTc4NHZNaEhPdTAwRTVvWDVNL0t5?=
 =?utf-8?B?aCszbGRTNC9WRU1tLzZZQTNyL2dKZFhlY1E4RjNudWdteU5XZnBWU28rTWwy?=
 =?utf-8?B?QitqSEluODgwM3VLdEhpcnRpandud2dHN29LdFkwTEl0aEw5KzIyLzcxY3Rh?=
 =?utf-8?B?UytOMXRMcXZ5cGFCWng0UUlOOTltYzl4aytkVmw3NGJnMWlCRmdyQzJTLzA1?=
 =?utf-8?B?VEQwN1hZQUxmbVo5N1BmeFhpK1krSm11d01ibkhjYS9mTGpTYVBLRXZ0Ritr?=
 =?utf-8?Q?mnsObY6WPlZKViHyJEE6Pv6SJ5IZAaA4eusbShX942Ot?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34d6419-2f19-42ea-6776-08dd37068bf0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:52:21.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/iWhu+4fd54CR0NzywcJX9WWwpOj6rD3BIeePPBU6Cq8fU78oXviXoPiqD+UZ34+slAXUEe+AoWQ+t64CQVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806


On 16/01/2025 16:20, Mohan Kumar D wrote:
> Kernel test robot reported the build errors on 32-bit platforms due to
> plain 64-by-32 division. Following build erros were reported.
> 
>     "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undefined!
>      ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
>      tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi3'"
> 
> This can be fixed by using lower_32_bits() for the adma address space as
> the offset is constrained to the lower 32 bits
> 
> Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-lkp@intel.com/
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 6896da8ac7ef..258220c9cb50 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   	const struct tegra_adma_chip_data *cdata;
>   	struct tegra_adma *tdma;
>   	struct resource *res_page, *res_base;
> -	int ret, i, page_no;
> +	unsigned int page_no, page_offset;
> +	int ret, i;
>   
>   	cdata = of_device_get_match_data(&pdev->dev);
>   	if (!cdata) {
> @@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
>   		if (res_base) {
> -			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
> -			if (page_no <= 0)
> +			if (WARN_ON(lower_32_bits(res_page->start) <=
> +						lower_32_bits(res_base->start)))
> +				return -EINVAL;
> +
> +			page_offset = lower_32_bits(res_page->start) -
> +						lower_32_bits(res_base->start);
> +			page_no = page_offset / cdata->ch_base_offset;
> +			if (page_no == 0)
>   				return -EINVAL;
> +
>   			tdma->ch_page_no = page_no - 1;
>   			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>   			if (IS_ERR(tdma->base_addr))


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


