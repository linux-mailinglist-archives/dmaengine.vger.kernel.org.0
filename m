Return-Path: <dmaengine+bounces-12321-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XFCwGwwjUWpb/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12321-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:51:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4B73CC06
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:51:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=z4UD3hOX;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12321-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12321-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3098F303182E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4536A365;
	Fri, 10 Jul 2026 16:45:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65F367284;
	Fri, 10 Jul 2026 16:45:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701941; cv=fail; b=CMyXK2CD3d1aADZr/HLX92ZueX/T9t49xM+IogPn4UuVGI2/99vq6nup0uXxTV2G61gTXPRWA0Q1V+06Nily4fZGm5nXjQX02fSFpv0o5NnzwXo5soYIvNGZJh+yIwmeCIJXMj30h4gH26LfV/vuM6AG8+LDi446X6BaUNTRBIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701941; c=relaxed/simple;
	bh=BHT0zHYRTXsS5azgj08A3qwWjVHrIXErIx+em9iuLRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lekl+NWQL8h0s2CSqZxWOL0ftCbPyTj/r/Xm7PRQIykdGCq89TKDFPlptAMXjdFrdhXj5fFY0zRji34f5ob3ciCK0bqzkki0iFzk7J6ASPHQome8OHsDS+srQJCRABj2driIunvqSsD1mybHNA6uSKO4M8bbCCkfjMqnkA94TGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z4UD3hOX; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwT46/jTfTHWMUboJzKmL+EQbwiCd8Fxa8AZVLHtbYezG7dkIjLC2NI9GOEuTd9VMUFYQSEAl4WYUp2y8D6w/VluWyqefHNlXZAre2/c8MiapapB1gkuVga3U2IEfd3FeFgBoFX4jVwVR46J7y4wgdzlZIhA9bGgqprLE+pJPah5Z/GANdplC8j7087/j2k1qMeF+lMp60TMugIXpmfPikEZzC+8NfL26dB0U+Tz/rlCwbMr/vHvzsP0MYs6dlU5pfZDtbr/qw8uB9npCY6lbeOjtmzkWqgjAWQOrCPg4RqVPkSwuSZ2WRdOJXDRyHAUeDyID/oFWsjQaPoCb3ISRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJfCbXl2xVadEhgwkEF9VcBCZxMqh4Z8EanCCByehqU=;
 b=NfNATZdIN/iQut+itpXaomLpKjME7kiQwLUHwZkguHPGKXxGnM6KROnTxO/x2ZNcT0+W5fmB2lvIix19AuaNGJyc4ygrnIsBKbyh6yxw6NVkO8IxEK/QPtlgAYR/dFrIv6rF4CjK0TiSsdgKqCUHDyYYJ2EG+XlD2HoGuN0pxR5KmKUcn0kLG65hzMWiSCoKqYAEGHr3/Hm0ffutE0TkdTstOXQ7XOxdzqoFUWqARyYYv1njiRx0RvYIFGrwSrui7AeIobHU+J1p3Iqcmnwcr0s/jDh5vfxBdThSxBoQPqGtHhYtkR9TeP4W7BNk88g5YJAhKSpOnK0T4Elcdz30eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJfCbXl2xVadEhgwkEF9VcBCZxMqh4Z8EanCCByehqU=;
 b=z4UD3hOXxGewwqZZz8A8/Z4+OkZN1oWntffeyRGYseFvCU59vp9r7iWL4hQjvGQ0M/nIdqvUq+TJIXcbzjTO6J62+3vTiPAdrhH7JGqGsNhFf0wmO2x+2P27SNX7GCDi3nNM0ziF/iz7nMBx1lW0muIuBXuUao6nUNoEZDGG/iY=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by IA5PR12MB999325.namprd12.prod.outlook.com (2603:10b6:208:603::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 16:45:33 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 16:45:33 +0000
Message-ID: <1fad886d-9d69-4c73-b6d8-c1771c0a1075@amd.com>
Date: Fri, 10 Jul 2026 22:15:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] dmaengine: dw-edma: flatten desc structions and
 simplify code
To: Frank.Li@oss.nxp.com, Manivannan Sadhasivam <mani@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::13) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|IA5PR12MB999325:EE_
X-MS-Office365-Filtering-Correlation-Id: 18db16d0-8847-4159-e8c1-08dedea2a897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	xrcQVGFyIvsRW1OByWCBRVu/s668/dEGiL/s6513zgutR/7SAMikqiF6G6lnb0uZtJQReDMPsxSwGMJHnZyZfmDxCqrh+FjzXxyZnxCtfzUzWIXmjQjYjXZN+Je42+k8vsumkjHl6uuQTKZZlvV6h9oJgzTSLXE2b4bU95bRHhcgiSVqBE2yggsPQg0LPf5KNhCi2XUHlv/ClO1JfNk8sfPfEwRbYWokmdgOjt29Tirf+6RodDx8FaQkcRV+xvzwhhHoWKEvA7wJ6XUyrc1LbagSCH8Gic25j+PRDQ1qd4cC9qLcskP6NX84wpkOgaPyV1wn8wZuYxvXbL4rDTsPCvPtmFQpGa/tk5C4mebD0L8f2SHnTsf/2aaccK61cjOb4eH6kTEpIqmG4xvqgl7+BjfyFh+Y3xQiHef8PbcNA+9Tn0myxz1b+Iay6H0Yq14310i1idNKglD0siDHUfi+eAscga32N0UJ8sPTS6e0sMvhjYrsWY9hRqDTm983Jdf0mYsNDlzwRvcmshTJ70bSv3IkCUzlXOd04fMoEeZ0sgrsQ0kWQoAKWsE1MqbO4xnN1R2vUohfm8xgxU8BccIw5pvxlj0JpVPjBTcp/F8OB9LhIqpxD9McqIDQPGB0V9hkZZQhqAowL9OzfDpqu2dcPCcjOXMSeb4UvflHP1DW4zw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnhYd25uNTVlbUVKUS91TTlKR29VNmxBTkhmOHFyKzlCRkpLd2tuTE5KVVdO?=
 =?utf-8?B?aG03bUFFMVBrSHlDbGhweGZickttVXhRYXNoTGhtRnRXNGlyRGxzcE9vRnVi?=
 =?utf-8?B?eGJBWGRuNjZuY0laL0I1WFZvS1hyUlBRcDNXQTgwR1UyN240MEdENkFpandy?=
 =?utf-8?B?MDNVaUhsOG9aK3RvRzY2dVd6VnRVd1ptQWZIT2FYQkx4ekZGdTNMcGMxRU1W?=
 =?utf-8?B?Ym9rclJBc2piN0EwMmJsYlgwVkR4OE5ZM0JjZkM4UTJlcnU1QUtrYzlBTTlT?=
 =?utf-8?B?SjZGcEVza3NNTk1mMC9scmtpaGlZcUEvOE5CQ1JKUXh1NlRlSUIzSTMwTFhv?=
 =?utf-8?B?c3VWUlNHbHVTNG55THdEcE1OQkJxWkwwb21VTmxoNjFPaUc4djdUSUhGRzli?=
 =?utf-8?B?VUFSWUZNU0ZBUmVQa0t1TWVLR1hMaFNZY1I1NE9LLyttRHEyeDJyNi8xbjBz?=
 =?utf-8?B?UTNaSU5FdHZLYkVTVmFsVDNTVXFmRTg4TWZEb252UFE4eGVnZWFTVHNacVB3?=
 =?utf-8?B?RDBGdHQxQ3hVaEhWSmJ5MG9DbWx3YWltSy9SNkU5YWxON0twOVQ1UXBVWlJv?=
 =?utf-8?B?ZEpxZkJKeXNTNCt1bkxXT1FLZDFtWFNBdThvZDZNS1NIMHA3aG94NWJrYjFG?=
 =?utf-8?B?YmZXWmhqMUw2ODRwK3o4NkNVeVQzeEhheDhsM3djSm9iVnc1UHhKbHIzeUZj?=
 =?utf-8?B?Wjg4c0dQR2NOWkdGbk8zZ1VqNjFPWVFSTG1rQnFqNk5CeWpiUzdLMkw0dHlk?=
 =?utf-8?B?czY4SjErMENXanZZQ1hkNHRyUUNIOE9OOXZnMkNVUjluV0U4SkN4TFBXeGIx?=
 =?utf-8?B?REV1Q1pheWJSVzJRRW1Qam9VclJjcDd3NThVdkJvaWQ5QU0vQmo1NDhJSGsw?=
 =?utf-8?B?MW9IWnlkUmhPU2ozYUlvTzZRZnRpZytyVFBKSkI3bzZCbGdxSU1Da29yNXd0?=
 =?utf-8?B?empKM2RvY244UU1UZzl0ejhFY3RGQlcvcFBia0g4T0QvUVhDV3owSmVwVXlr?=
 =?utf-8?B?d1ArRm9HUEE2bDE3Qmtkc01Pc0hGeVNSR2lvR2V2WVRLVjBlWGpTcys0eHps?=
 =?utf-8?B?cWJvdkVwVExyaVhZR1F2dmJMa2FoVFNIR3hXZVJwazYwTWJLK21rdk0xK1o4?=
 =?utf-8?B?Q2t5ckNpNm9IMDA0OTRINXNVWldGbHZXU21uTjk2aGQweHRzY0lDU2NveGJh?=
 =?utf-8?B?bTRmd0NRa1hIbEpjaE8vYUtwT1lhWURTWWt4KzhLQlA0dlMyZmdoL2hwbkJx?=
 =?utf-8?B?bjdpNXVVdkRKN3B0UW9xK21seSs5YzJ2d1ZsQ2Q5M1JXSU9QdnhyUVl6a2tC?=
 =?utf-8?B?ZXIxb2RvOXR2QzZDNUJYZS91TVdBVkN2VnpidnNyeTF4djA1RGZ3TmNuZFFa?=
 =?utf-8?B?Y09nWXBhVXdVOFUwMzBtOXdtLzVhVzFiSFd6VGw5aktmck5rTUF5YWdlRS9v?=
 =?utf-8?B?RVdBc1pUUGptL2FHcjlFWVdwVEQ4M2hZNFh6UnkxbG9oWGZPeXRYQ1NQQ0dE?=
 =?utf-8?B?Njkwd1Q4UUt5QWdZcEJDaTREWXQzcU1ES1dUZFVVeEhZSWNDQTB2Tis1Umlz?=
 =?utf-8?B?TG1VcFZWUlBtL2k2dUx5TlhobzVsaVBHS2E5Q3dmTUdwbHJPSmRlV3dFWWhy?=
 =?utf-8?B?eFlOTG12N2hrWFgrSndzSDlRNzJwMmdFcXVYRzBBOTJ6WW9aUk5KM3BNQjBV?=
 =?utf-8?B?OFZVOGdQK1J1Z1N2U0ZnbTNSV2hLVzhDZDV0WnBSQUpvdmlYQldvUURnMFJB?=
 =?utf-8?B?MjlMVHEyQUQ0U0czc2JpNG05Ty9TR0VUak1FR2t0MmZkQkNkYVc2YUhUMjNl?=
 =?utf-8?B?QjFkOHN0VkNwenR4QnNQclNsZ2pzd1YvRXB2UVl0eVJXMG1jd1ZkTDVqdnp1?=
 =?utf-8?B?RWc3aUZMcnhqWDNrV2pqOWRHRnVwOEpWOTdvV3NUejFIQzM0d1BRZUNPaHdw?=
 =?utf-8?B?YUk0TEMrMlU3aVdXUGxOKzBKZ1VxTkFRNzlOOTFnZzJnR0t1bU1rSUZFaW5F?=
 =?utf-8?B?MEJ5K3hEbTduZlNrSzUvN2JPUkRhdTZnbDVkY1lURkFQMENFZzE3TzFHMTBk?=
 =?utf-8?B?bzVja0pHVEw0ZGN4WGVLdEZNbE9pZitvbWVFUVFQL1hpalRqY3MxNXBzRjZS?=
 =?utf-8?B?WDMvdTJXL09WNWIycVBBVjNCb1hOMmhOVFRaSlVjZytnb2l3anBqVXB0dkIv?=
 =?utf-8?B?REJpY2FKZnowZVZURWJ1ZE5PWXhKRGI0M0ZycWREQmtudjZpS3VBVXVPQW1V?=
 =?utf-8?B?T3pEaTJqY3ZvVzQ3UWhSOTN1cTExeGsrc0hmUVBNd0pDVzlqcnM4WVMxa0J5?=
 =?utf-8?B?MHh4cDg5N01PanRQR2VZQzNOYzRyTWl0QjZIbGZGZXFaUTZiQXA3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18db16d0-8847-4159-e8c1-08dedea2a897
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:45:33.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRjX78pnaiC6+yFyTm2NKc0hHD9PF6Z9RrSv7m1S7n25TMjNgdJ6W8g2W3WpPVr3ESS+9Nwk1zAgeKah8dkw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999325
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
	TAGGED_FROM(0.00)[bounces-12321-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0A4B73CC06



On 09-Jul-26 21:03, Frank.Li@oss.nxp.com wrote:
> Verma, Devendra:
> 	Can you help check if block non-ll mode?
> 

The current patch series is tested for non-LL mode.
The testing included varying data sizes for transfer and running
C2H (Write) & H2C (Read) for a specified duration on all the 8 Read
and 8 Write channels.
non-LL code works fine with this patch series.
Tested-By: Devendra Verma <devendra.verma@amd.com>

-Devendra

> Basic change
> 
> struct dw_edma_desc *desc
>         └─ chunk list
>              └─ burst list
> 
> To
> 
> struct dw_edma_desc *desc
>              └─ burst[n]
> 
> Flatten desc structions and simplify code.
> 
> I only test eDMA part, not hardware test hdma part.
> 
> The finial goal is dymatic add DMA request when DMA running. So needn't
> wait for irq for fetch next round DMA request.
> 
> This work is neccesary to for dymatic DMA request appending.
> 
> The post this part first to review and test firstly during working dymatic
> DMA part.
> 
> performance is little bit better. Use NVME as EP function
> 
> Before
> 
>    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
>    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>    Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
>    Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
>    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
>    Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
>    Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
>    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
>    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
>    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
>    Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
>    Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
>    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
>    Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
>    Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
>    Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
>    Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
>    Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
>    Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
>    Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
>    Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
>    Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
>    Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
>    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
>    IOPS=261, BW=132MiB/s (138MB/s
> 
> After
>    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
>    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>    Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
>    Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
>    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
>    Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
>    Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
>    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
>    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
>    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
>    Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
>    Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
>    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
>    Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
>    Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
>    Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
>    Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
>    Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
>    Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
>    Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
>    Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
>    Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
>    Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
>    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
>     IOPS=266, BW=135MiB/s (141MB/s)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v5:
> - Fix cover letter typo
> - Fix double subtract found by sashiko AI
> - Link to v4: https://patch.msgid.link/20260708-edma_ll-v4-0-cc128f0afb61@nxp.com
> 
> Changes in v4:
> - collect Koichiro Den test by tags
> - use addr in argument when set ll address, found by sashiko
> - fix iterate burst problem when exceed max link list, found by sashiko
> - Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com
> 
> Changes in v3:
> - remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
> - rebase to vnod's dmaengine topic/config_prep_api
> - Add non-ll-start() callback to handle non-ll mode transfer
> - Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> 
> Changes in v2:
> - use 'eDMA' and 'HDMA' at commit message
> - remove debug code.
> - keep 'inline' to avoid build warning
> - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> 
> ---
> Frank Li (10):
>        dmaengine: dw-edma: Move control field update of DMA link to the last step
>        dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
>        dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
>        dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
>        dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
>        dmaengine: dw-edma: Add callbacks to fill link list entries
>        dmaengine: dw-edma: Add non_ll_start() callback
>        dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
>        dmaengine: dw-edma: Use burst array instead of linked list
>        dmaengine: dw-edma: Remove struct dw_edma_chunk
> 
>   drivers/dma/dw-edma/dw-edma-core.c    | 218 ++++++++----------------------
>   drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
>   drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
>   drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
>   4 files changed, 304 insertions(+), 388 deletions(-)
> ---
> base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
> change-id: 20251211-edma_ll-0904ba089f01
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 


