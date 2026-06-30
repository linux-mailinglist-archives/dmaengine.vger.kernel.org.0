Return-Path: <dmaengine+bounces-11882-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4NU4GNRvQ2qoYQoAu9opvQ
	(envelope-from <dmaengine+bounces-11882-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 09:27:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C896E1220
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 09:27:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=jlDrJPJ8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11882-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11882-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76AFB3013A62
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC2A375F87;
	Tue, 30 Jun 2026 07:22:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B132B131;
	Tue, 30 Jun 2026 07:22:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804129; cv=fail; b=Rx7HT54E7e0c+AiVOY5/mTlOgj/FckAQHOTMHumi9zyDWaqqwb3UhMssksMpUxO2oJLXmH33mkcW74aKbCdO/tt29XU8gZz+xCy0PkkZ6qzrSy0yNhuajXHhXvQHykFr4CHji3aJHIk7ZS1ZWY3UNygKosYyKmfMhD932yG9UqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804129; c=relaxed/simple;
	bh=zJy3mOzznTNo0wEsjxksD+EW9jKLYUerlyTmALz/Cvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uehcVBiIIiKKYSYbVvLrST8BgtMRa6NpZDdu/ffYj2+MDTRRSGIuzuQ5cjediT2NKHWuD5/mT4byVv3Ygf0iYSEuT4LsxH8iFqve4siqXIFjaQkERBFXkIaQbyQCuOkqNoNINABLXTvSVro7XfxCataka95EqIo15n7sexJlFS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jlDrJPJ8; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WS0wmry7Py2+1k3/lvC21izHI+iZHdFPawS3X5HTOqcUw9d+KC2yLwKu0AFli4MgLr0DM5mg4qdsl6m0kdDFo1z7nmILPWiOygs4ATM9+/m26lbqwU8IgJr9IKh5vBqt8mpHjvAkDwIpQ3iDDCvuKAKgsaQUWb513DNwHTrvszK+7s+ObWIQzOglzW407YGiUX4xFmkTjOdhYZqxKLb9WcMLae0qLLGdnrQhFu7D2+7/Wjs6SEpgo8Ug0+Zafn5dlxul/Y2MhJ4YtjmSt8icfPFjxTxrryhxeKIv9otFW1RTiJI0Q9M6M9v+CXLpXZ8/AGqFhrraRsUcYwobXwXfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpQAtNj71NDO1JRIwOq38nHWYW7kk2seEhp+YO/dj/s=;
 b=WJx02umi7BzBtfWq/XkCdYwS02lyDxGEeyIvjbhXIUImiE4VEyV+tR21L5CRbBVyS+ZXwVpamhT3CMup7oK1ZCKaG99Q8iJsiheWQlgH4PVSLHkoSwTXcfTfHQMkZiuJyjSYWYqH0XU3PgKsFVHMgEI4qt+uVggQp5so73De15qHAt+DqvdjU4T549DYVlvHJesqEA3str68/maowWlOCyDbFlJFI9X4YSQ/3kiMwq1kTsjrEPys5QhwW3FEnsW+0K7UfmilNoHGqP+sDrBayvgYj2O2xH4hu8HbMf0Om8g7wVld4DTVcXPLWRVk1ORiP/8mECHPrsHSkDV7zocZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpQAtNj71NDO1JRIwOq38nHWYW7kk2seEhp+YO/dj/s=;
 b=jlDrJPJ8ppbtyeIYdlXB/T5EJHL4n2yn6slr1b6p/RC++4O5OOXTUjbtAHSCqX8p2aHFpjN5TaDVdRztQY3XpMIg3JUOZKeOeNCD/8mpFqSLv4nl3J7owGAIBjfZtfdoz6pVxXy6CYXJSAO3qpvMEn9hW1icIxE1FP/pc3bmxMY=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 07:21:59 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:21:59 +0000
Message-ID: <46cea045-3e41-4cf3-b1bc-8a010d0022e6@amd.com>
Date: Tue, 30 Jun 2026 12:51:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: zynqmp_dma: fix race between runtime PM
 and device removal
To: Golla Nagendra <nagendra.golla@amd.com>, vkoul@kernel.org,
 Frank.Li@kernel.org, michal.simek@amd.com, abin.joseph@amd.com,
 kees@kernel.org, ptsm@linux.microsoft.com, sakari.ailus@linux.intel.com,
 radhey.shyam.pandey@amd.com, u.kleine-koenig@pengutronix.de
Cc: git@amd.com, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630064844.705173-1-nagendra.golla@amd.com>
 <20260630064844.705173-2-nagendra.golla@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260630064844.705173-2-nagendra.golla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::11) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 1948601a-50b6-441e-8c37-08ded6784614
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|921020|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	GxoiTiYe3swlsgA3sIQmhkcmPPMs1Gd749T3bxM+b/rGhYtvNNEuiop7lmstDdXp6qjQvdNnaQWK8mJb6oW2hKY5QTT2L2iOJFWsemARpXQ6lceszZYKT8Hb6XcgeOb32uw7MtGQYVr9obdm4v4zxZarT8zaNu2um59QeuqT2wovUzOyNae11Gh0hSmJNlT2kwbMsylEuDf7QwQfMgI2eMaI7ggCZ3unOOUxw9EIf4ev8juRifnXbqrbsh54oaWJl1v20HgDEiWEzvI/fsk1DjlreAqIILGzspxhcLW3gtUbEkr5y9jc+KKwsN2TC+zdhM5JQEXAgoI66zUi6/eh13nUHKbEymyedLYpUJqtxulbnSRSpGavC+aWaqgQXJAzY2Umuy6lOiNw+cNMljJvQyWYCaBUDu2B6n7j1mhuOZWTkIAZxUdhR/V36rpuS9hjjTZbL/mvsa+TBTtvp0/m5/2t4xjOWwZh2TfBsJfIYPQ3ycTQUkjaxu/rpXVh8Zsm/Lf9f+35aHrjaKFtIjK4tpqjJw6t+CmNAAtPJY245g1Wf967Dd4pZoJpULNYs1c6eHQvaNSdhjzTFXZRr9qpY/eT/TOLvl6Sppmpko2Gv+DsaiXQNW3vZcgJhrY0+2Nimb0oIbGXOzLplr4Hl5xmKKuPOTsKRwmQOicaL9BiOgoF69sNTC7FuVjF4y9divmG47P4liD2m1YCluUP/ozB+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(921020)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHNjeEVXQU41Q05aYWxvK1oxRFVWbVpBT3VKSnZEcTJib2c3YXZzSEIrc0ZH?=
 =?utf-8?B?RnUxK0JseXRUSkJNbXhtRnFkMmdUL3dncm5md2JBcVdSTGdFdGlMa0lrelU4?=
 =?utf-8?B?a05JYmdCNzBBMU00RnZ5Q3laTEVTUGVabWJCaXRkSHltNml6MWNtNzVlQWwr?=
 =?utf-8?B?dWJjajBuRjMrZzRYWWNWTFcybW03Q2FUdFJOdk5GNC9WZzNUUTE3VFZDeDZU?=
 =?utf-8?B?OS9BM004QVhBNnovMFVtLzNhcnExKzYwRUVqN1QvYmtDRGIyVnhpNGlBenVC?=
 =?utf-8?B?OW96UU51Y3QrRU8rdUdEVEhFRWNIMjc4TDZCUDR6eTRJTDl4a0EzSklQNWhv?=
 =?utf-8?B?NTdBcFFQTmk3ZjVVa3dsdTM2aWNHRDJsNFh6S09ZVGFTZEFGRDV0T0IzTDNK?=
 =?utf-8?B?RU1mR0g5MDFrbzhRTnhJOEFDcm5LTGZEdHdXL2szWUVJOS8xNGV1SzBLV3dT?=
 =?utf-8?B?RW1DRStwdHVwYURhVFphVlhSZUJwV1Z5TDZEQzVPOUd3SEptTUR1V3Z4RWFv?=
 =?utf-8?B?ZVVvcnFlNThuNGpveU9PSEw3S2sxRmJNcnZ6Z1ZCNmdpRml0UUszb2hWR0FG?=
 =?utf-8?B?SlVicXpGbXVmMnpzN3YyWlJjM2xwZkwzM0RXbUJMRlFyUG9RblVGZlJ0ZkVY?=
 =?utf-8?B?aXh0cGdqMmY3RjVUYUFwZUNqOVJ4eG9jU21IYmZLTHcyck54am5pc2FrZFZt?=
 =?utf-8?B?Q0JpVnF5ZVg5SUJPY3kxdUZVNWxJVHFIRFhmVTFOQTNHSHJZaS9JT1A3Mzlk?=
 =?utf-8?B?OVdBZDgxUFpydzdyTkcvZW95cDlhb25LVHdYZ0dtblBqR2ZUNG9pQTZzUlZC?=
 =?utf-8?B?a2ppZzJINlBvZEFxOG9wdWx3enJVNE5sVnA3Z0pLOGZBZ3BMblh4MytyZEpV?=
 =?utf-8?B?ODkwSkFIQ1ROamRzRnExZ01DeTJQdTM3VDR5RGtnOFVsTk5PbkQxRmIzd2dq?=
 =?utf-8?B?MHRXaU10dXNjeVNpSFFsaytqbnJ2cUEwcDU1aXpPSEJPb2V6M2QwZlFBQnAy?=
 =?utf-8?B?bW5xS3cwaEM2UU5tbFZ5MDVCZkh4Rm5jTHMwTUsrYk1qTzRndjZ0QkRQdlpm?=
 =?utf-8?B?d3U0Y2U5TDFpeVUvWDY3enFaSHFBQmVIcGx2RENaN3VaRk5VUkVPK285Y0h0?=
 =?utf-8?B?ZWwwMld1anhkVkVIUytjSUs5RFVKeGNtaE5LRzhFcEhzb3lHcnphZSsxd3Bs?=
 =?utf-8?B?bjBaSUpqMWhJL1JqZlA3d0gxaXB1VzdHK0k3aVozUEMxek5GNWp5U2NRSXAx?=
 =?utf-8?B?bkk3dDRvU2lUd0hRRjlTaWl5aXFrYVQ4NGZlcm5PT2xqaCtXOHBmaG1GSDY1?=
 =?utf-8?B?VUFTMmUzdE5BcWRVSU0veEpEcTlQZGhEL1JOdTJwQ1NDTSt2WjIzN21GNGVn?=
 =?utf-8?B?VXQzOXhMaHdkZXhmZ3RGckY4Y3BZSnV4RGZMTkdHblE2TVlkcWZ4WWxsRlVt?=
 =?utf-8?B?eXdocVJzektaNWM1TWpZUmJDSnVWcW1QYk15akNSOXB5ZVJrL0orcEhaTUlO?=
 =?utf-8?B?WnhZS09sN2ltU1RTdCsyWkM5cFJ0RzlRa0NhVU5tcUVscEVtSE5uQ1gzS05v?=
 =?utf-8?B?UytMZ1ViN2tJbjZkd0ZDK3E4alF5OVF3Q2p1WG1HODA5WlBpdDR5WTRlTjQx?=
 =?utf-8?B?QytxeU1ZUURtcThvenRJbUQxN0IxZnhxZTBZTjQ5cFVwcFhGNkxLc3c3Zkdm?=
 =?utf-8?B?MDRlcjUrMUZEWjFRVjVySTVzcUR6NklWMXptMmc2UExqQ0xxN0JHMnhwRytX?=
 =?utf-8?B?VEtVRzJCcTkrWEVJb2lZY1J0bW1MN2J1R1czcVBZR3k5TDUyY293S1NRNTRO?=
 =?utf-8?B?ZzZkQllNcEZmYS9vbzJBb3NxaDExbGQrUTNKbHNzQjB6eGZBb0ovVGF1WFQy?=
 =?utf-8?B?eUlpbHRRVmkzdmtQWitZeDJIN3NXSDVlaEFnemxpTEMzVEU1NUgvK2Vyajkz?=
 =?utf-8?B?NjlnQmtXdlpvdGlhVWJPQWhhTUhmM3B4RldWWjRqUjdkUkc4WFYrUFNOK2hy?=
 =?utf-8?B?Q2tTL3JwMXNtWUY0WXdYVVNjQVFFNTYwa3ZPOFFucnVxYi9iZXhDczhxS3pC?=
 =?utf-8?B?eFFwRWpjaENTdkRQUkV0UXoreGJsSW1VVkNtTi9DRDUyZTVTazBCUERYd1FK?=
 =?utf-8?B?eFdOd05UbmczU0hJUTgvSGtGNkRNd245VVl4UElrZEJWY0JZQWs0alo3ZGRX?=
 =?utf-8?B?eE9WOGIvbzJIejhDL3lpanliTXI2L2ViNm1RbG1HcHJHOVY3TmZrZ1VlaUtS?=
 =?utf-8?B?K01QYkdacXVLamRGRWMxaE1LV1lVTTlYclNhbzRrVU45WEh2cGoveEg4Sllj?=
 =?utf-8?B?aGhFay9FL1Uwc2c4bVliOUoyQklSZi9FVVpNb01xdldNd1JTcXZqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1948601a-50b6-441e-8c37-08ded6784614
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:21:59.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRGNXlKDTgSyF+zmJpgXJISOdWRhWbRNskJZCMvxdAQyuhp/XkRBpmPicmqgAhaG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11882-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8C896E1220

> In zynqmp_dma_remove(), runtime PM was disabled only after checking
> state and doing a manual suspend. This can race with runtime PM in the
> remove/unbind (rmmod) path.
> 
> Disable runtime PM first, then suspend only if the device is not already
> suspended. To prevent any further runtime PM transitions.
> 
> Fixes: 72dd8b2914b5 ("dmaengine: zynqmp_dma: Add shutdown operation support")
> Co-developed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>   drivers/dma/xilinx/zynqmp_dma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 1402331f7ef5..26f097db593d 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1188,9 +1188,9 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
>   	dma_async_device_unregister(&zdev->common);
>   
>   	zynqmp_dma_chan_remove(zdev->chan);
> -	if (pm_runtime_active(zdev->dev))
> -		zynqmp_dma_runtime_suspend(zdev->dev);
>   	pm_runtime_disable(zdev->dev);
> +	if (!pm_runtime_status_suspended(zdev->dev))
> +		zynqmp_dma_runtime_suspend(zdev->dev);
>   }
>   
>   static const struct of_device_id zynqmp_dma_of_match[] = {


