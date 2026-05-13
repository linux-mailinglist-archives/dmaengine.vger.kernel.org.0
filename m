Return-Path: <dmaengine+bounces-10411-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BytBKtfBGqiHQIAu9opvQ
	(envelope-from <dmaengine+bounces-10411-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:25:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A5D5322E8
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4455310EE6D
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB13A759E;
	Wed, 13 May 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ikWZGRCj"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B9389DE3;
	Wed, 13 May 2026 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671339; cv=fail; b=IYOlIyJHKsq8Zi99I082TD9hYxUcvzcYGENRVj2b+36Mi+UHwwevEvFNFMKVUQiLYC2H00lOMc0KNJ+2y4eheeqtv/bbzAGwPqPJhGacq1rw+zWQB9WIgcKKCcIqnCzgsuIHFpqykHeoM23vtaFbu4Rp8D6iYaxqmt5EDXMDiqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671339; c=relaxed/simple;
	bh=/HCWQc6UC3B5bmAiwu4mTBajY3lfDB/cNiGl9esFeBE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aEvyTrbflzvk6z/mqc75OjTCvwpH0s7+SfQdd3yZ4sr4ZNd/YVfGP/PvVoPwmZrtocyCZa75Knp/g9/lET8ICf7B/0Q0Un2epyEPPBI5wAI+Rp4qh+xW+cAEFgLBtc3a04ufDjvg/lcVosNgh2Oc43+AX1g4vNlCWhM2HfElNaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ikWZGRCj; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6ZYip7usrHrjdMGo9XKHgGiV03I4rIxhiZIZHZHsKUC9q2F7F1Dc9HkjDgtNDEw9HSYmRzIxE5lO3z9X9zONP7ye9haE9fkB79GpgiJWHOxkCa+xuARkqIkVbSkkoJJoEBfmJTJvpZtjKPnY+HvumohbUxlXJ0zUQeEhLBOyM4nmD9QFlUfvGiVCUodSHATE87cbEQlPrtguYrSs7utNSyE9EelbQvv44zhzJrxkJuqdd9khl1BWt6yRwlMtxuVubWtdZV6yP8ki9Wc/iU84zeaBegoHshPlVX6x+qm3mmJbBLniYVTO+tKtymUYt7boZg7qoecS7H5DSsXAX2jlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDowFMFYIK/JumGU6Jq6Sm0Xv/Rb1g3p3qXGG0MvIN0=;
 b=kgVJMjt5TRZNCuWFgjxnbvIqnwmjiePg+0jrUqMQiXxUwLFOYgWcPQpCkMfD33wmQ89ERQPHQMp2Bfe1xPt0NwGfgSjCWAU0yr/+TXMrf+goFVily0EhPcv9cJZmL09LLJl4QKNo/rwtygid0gzhzOt9qAWhkw/N4nxeth8Pkc3nqBY0yG61kQnSnjV0OiNAQHK8X19QIy+MAkLh57uQE3n3MLbVshmcdOfwlMGY7dWJWrJirrCZ/MTXYtJy9QMk4IZ9uYs+WB9yatMILuBkO/MP0F72m2ZDM/6bgh5v64AilF7tEK/q0HZBgtgMOfjjcyE9eF6+vTzjc46kEozfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDowFMFYIK/JumGU6Jq6Sm0Xv/Rb1g3p3qXGG0MvIN0=;
 b=ikWZGRCjWEnx0enNBvsQW1Vixon+TExgRnzvd8Tg2bL+DETUS4XO1wMVagU4aWRx9+W/Wnf1xMfhxTlK/bkXtWmWnqiLbtSlLLZIvnAWvltm+b0+7ObLxvznuc/PL3crnEa2X7CJ2DN7l1qfr1h3cV9UJgk6RzWvmB8I95i/rQGpV+fWYhGALM58EBtgRB+wpxR7mImDXVlX28pedhDL1FR1NzrTu+xQ2bjxQrrD7L3WpsKbccf7t62t9edci1Vd6myxBT3jAXWzYhd9Jsam5Tu0z2ViCMBDfUS3IsBygkf1SWyaq9OPk10SmLQbhCdWmG9tohZilOFJ4BL3ugs7PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:22:06 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 11:22:06 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Wed, 13 May 2026 19:23:48 +0800
Subject: [PATCH v5 2/4] dmaengine: fsl-edma: use
 devm_clk_get_optional_enabled() for DMA engine clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-b4-b4-edma-runtime-opt-v5-2-1e595bfb8423@nxp.com>
References: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5765:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff9ec05-9486-48ad-d59d-08deb0e1dd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wGE1hTjntPZBNCDCt76RwQlmj7DU/h7ALNghlyzsDqA2459FaZL4aw4qZSRkWujxeM4L0UtvNriOUh10+MYyAuL7esYBndKjYCEZ1NZIsdwqlzMHwNOKG+SCqo4dyCPoOqq8PLaJN+6KImvMyy31ZcRCIy6bkXoogIZ8NhgVVyOQEauqAB9eqtfXnST9vmFuYPe7qpXodXUdkf7PzAzvifYHVv6nmyWl0JniomcbYGY+Gw0tFSOF6BHaxiO15bolOy0fulWzui1soIGtHyncOp014jVh4ZxiMGcZjFZ60//6aaSE3mIaTmXVNmvspeeAMeVbH3cJdjGb18gd/YhNXHuAE7JwIPNG1Ken0/B+3VZ8FTA3R6oReRYXYBTu5sjq/Fb4gN4KSCTSzHEcfIAVZ6Fj3KHoym+BPJ3PibhWR/HUtwlNcUQGodQsMHPd91VENCn0hX74f2eRO4QNdo1RQYJeRGtgbMHGOXswckvhsmrHSMhkvk4YkEdJskyUjaIQ4yK2GXJlb/xmnBdG+R6bTHUm4TBf/kpItR9v8LMlIBIA8b+A0dNpicTsIUzYuiYRHx6RBFCeA4+mw56hbRlgGWxBzf5r+kZAnG+5X8aNplKJWnci4KIn8KwC1x2MTPAYWFDdjoZPyMi5nMUl0VfqBuX3i1t7Tsxbl9/dBiVALy/ar9wnNFxs0Ltw5vmoUBSL/DYyS8tPyRwqX12ICn2K2f2fSuyIgw7dwu2/dSlDfzh3PPGZrW+CtfhOBDxVDaD/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25weExLeEE5MGxKbmZlR3UxWGo4Zml4aVFRb0NqTExpYmVQaFBGdVVQRHZV?=
 =?utf-8?B?bzgrbkdrN2pmUzZwQzRDVkhjYStQRm9TSEkyeldvUDAvUmRYTk1oTXl2a1Zz?=
 =?utf-8?B?TGhlZkhMTFNhQnAxdlJtZGFrQnUyZG04MTgrK2pXNGdLUzlmY1NWY1J5UXBh?=
 =?utf-8?B?NkQ5anB5MmJCNDNyOVhoaFJHK1VWUXVMNnFRcU5UTDB4eUNKem9mb3RqVHht?=
 =?utf-8?B?RndibnRQOTJaUkNBZ1lNM1pOb3VqS2M4VURvZm1FOUx1cjFWOGJzYTUzL1Z5?=
 =?utf-8?B?TkdRaGhNTUVmaU03bFZ6SGNRK3poV0hBTEUzOE9KKzZvT0lxN0pXV00zMnVM?=
 =?utf-8?B?bmhXY0l4MU83KzhnQnA0cWVrWU9DbFgzMjAxZDVHN1N5Mk5xbjR2UlpucEVN?=
 =?utf-8?B?Z20yVmQycDd2SXNNQjlvZmdPTFAvVVJzSUJmNnNkQkNQZDNvMjR5T2NxS2RX?=
 =?utf-8?B?QmtzOStoNU5Gd1JCeUpVWGgxYjZGUUFjcnJHVFNtRmFUbjBYTWhBcVRGdTJJ?=
 =?utf-8?B?SDhZMFU2VkFTMWdPVDNKamNvMktjck1yd3hjOTBiR3FYTHBxenI1UWxqMm0r?=
 =?utf-8?B?czVPV1VUN2xmdllLYjcreHlJQlEwamh0N0ZoSGFyVXJEWi91OWh6QW1ZaXdP?=
 =?utf-8?B?V2V2MXFaamxYYTNmaHJ4VFhBUm9PSGpNY0FIdFA5S1N6S1RaZmk3cG9DZTdk?=
 =?utf-8?B?S2pESk0wcFhUTFArb0NsN3hLZEo4K2x5ME8rUmZKQVlnWWJWUSt5ZWtIbGhq?=
 =?utf-8?B?TVFyMG5QVlYrbVREUVFWR1pDV0xPRkRHTWhzOHlpaGJqQ3NVNnFlQ1FveXFO?=
 =?utf-8?B?d3liQVFiNHZUTW1IaU52T3crd1Zmb09UeUQ5WTBId2JONzZjTTdBNlh6N0du?=
 =?utf-8?B?L1Q0bDcyZ2dlUkdOUlp4ZEdUaUtyTkxKdjUvK0lJWWpsV1paejNvZEtLVnIw?=
 =?utf-8?B?NFlVaFI2djB5OVVwWFVRWGlnZVN0RmRvUGpjWFZrVmFvK21hbUtUditVU3Qx?=
 =?utf-8?B?VHZRYWxCd0JQamQwWUdsY1NWZnM3V0JoSTdWeDBpazd1U2U5ZG8zVjF4YjY4?=
 =?utf-8?B?YmhkYWFPRnNIQXA0aXJIeGRTQy91UnQzNm5NUnVIVEZWUVBJMkRIV0txcHRz?=
 =?utf-8?B?VEdwUXJTZm9GVUIwY1Q2c2V4amhBVG82TzBKb2ZLaDMwTW4veUFzUVdHL2s3?=
 =?utf-8?B?TUJhZFNTdndJV1FJbWNoOEdQSlRZZUR0T2VxUlNpY1lObkpCT0EyWlhXdE9F?=
 =?utf-8?B?MGdMcFRwdG12OEhPR2hWY0VQbktLWEpwV2pEQnd1aFlSSTE2ckNJcDY5WU5J?=
 =?utf-8?B?YTZmaWRpMmR3VFJCQVRHMit6dHdWTnBJYlV3a0NDaFFtUmZBdWtVSjlJbVND?=
 =?utf-8?B?NENjbmJjak5IcTFsaVdDa2hhSGgyb1gzeFh4Ry9YV2NRMnhEYjJ3Nm13ZlFF?=
 =?utf-8?B?cWJieVd6WnQ4eG9oTTIzQmNJbWxGelU0dmFJc3NBRjg2NUxxaFVjNTRsMUhV?=
 =?utf-8?B?emkrSVpOR3N2WFY0L1NtTkVrM0QxT2dxV3VIUWhnV0tmL2hyeTNkRENKZkpI?=
 =?utf-8?B?SExOZEw3aHRLYXFDV1huVWJoWFNheU8zRXB1N0pDQkRrSWtaeDRYNDF4Unpq?=
 =?utf-8?B?TFBIYlgvamJ2ODZYVTczU1AwaTRqeldNRlNCeEtLbWtUcW04RVFQdmlWS2lZ?=
 =?utf-8?B?RkljQmZjTHZRSEVsRlZVMDVaenZjSDdRTGRYQWJjMEwxaEI1WkJsSFZDNXpY?=
 =?utf-8?B?WTQ2ZmF5eWJybjZUY0N6QTY1dFhzSktBWWp4dUNhT3crem1EbGJacEdKcTFr?=
 =?utf-8?B?a3dFNHR2bGJJVEVKQUkySVg5WUFQMU9ZVDV1MGVoRzRwN3ZJWVRreEZNT1RS?=
 =?utf-8?B?RUJhbGNoVnBjcFZ1RnlJbFV4ckpWYTlNWjh2azNTUGRadUhBT1hCNFpxUTVW?=
 =?utf-8?B?ZVdkZ3k3UU9jdExpU1hObWtsUkV5c244Vk9MT2lZSWp3cVA5dFF3MkxNNWNm?=
 =?utf-8?B?REFacTFDVDMvQ2hoTUZFNHgvQXpOSExWZlNzQ0RzUXRod2JKb0Z2RlVMRHhj?=
 =?utf-8?B?eWhvNDA3SGRxaFd3cEdLMkRPTDd2U1pxZm5MZC9RWkptNWhkMFhvQWowVHVB?=
 =?utf-8?B?cXdvOFphTE1IK3RlYzVNWVZWenUrRGUvSVF1cTcrSldWMGNHY3pYWXIwUG9n?=
 =?utf-8?B?M2lKOTZIZW80UEFlWE9CL1dVWVljRHBTNFQrWjFXSTkwblhxRitZbmRkMzAz?=
 =?utf-8?B?Vzk0ZmszSXV3VzVJellTNnBLYTRKSXFMNW9YWXh3NXBaUUlxNFdtUlZkZFFh?=
 =?utf-8?Q?mhyqVonODKgiTwf+M8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff9ec05-9486-48ad-d59d-08deb0e1dd7a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:22:06.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcR0UWpPycv0QdimyLXMp1XqsEWNTLPBGt+x5OvAmFCbxK2UksckBv9VqrQzk+JM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
X-Rspamd-Queue-Id: 69A5D5322E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10411-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@nxp.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The eDMA engine clock is optional and not present on all platforms.
Replace devm_clk_get_enabled() with devm_clk_get_optional_enabled()
and remove FSL_EDMA_DRV_HAS_DMACLK flag to simplify clock handling.

Prepare to add channel runtime pm support.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   | 22 ++++++++++------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index f4354b586746d64faf375cc9ce04e15a7b6d86ab..54128b3f45cb399e1c11d9f86d64adce5c65c102 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -204,7 +204,6 @@ struct fsl_edma_desc {
 	struct fsl_edma_sw_tcd		tcd[];
 };
 
-#define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
 #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
 #define FSL_EDMA_DRV_CONFIG32		BIT(2)
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 87f575d6ccafff455d47f8c794a503abf97e2af1..ecd14967bfbc07d373a74790e87f9aa36b60e6c9 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -554,7 +554,7 @@ static struct fsl_edma_drvdata imx7ulp_data = {
 	.dmamuxs = 1,
 	.chreg_off = EDMA_TCD,
 	.chreg_space_sz = sizeof(struct fsl_edma_hw_tcd),
-	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
+	.flags = FSL_EDMA_DRV_CONFIG32,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
@@ -567,7 +567,7 @@ static struct fsl_edma_drvdata imx8qm_data = {
 };
 
 static struct fsl_edma_drvdata imx8ulp_data = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA3,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
@@ -576,14 +576,14 @@ static struct fsl_edma_drvdata imx8ulp_data = {
 };
 
 static struct fsl_edma_drvdata imx93_data3 = {
-	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
+	.flags = FSL_EDMA_DRV_EDMA3 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.setup_irq = fsl_edma3_irq_init,
 };
 
 static struct fsl_edma_drvdata imx93_data4 = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA4
 		 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
@@ -593,7 +593,7 @@ static struct fsl_edma_drvdata imx93_data4 = {
 };
 
 static struct fsl_edma_drvdata imx95_data5 = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4 |
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_EDMA4 |
 		 FSL_EDMA_DRV_TCD64 | FSL_EDMA_DRV_ERRIRQ_SHARE,
 	.chreg_space_sz = 0x8000,
 	.chreg_off = 0x10000,
@@ -733,13 +733,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		regs = &fsl_edma->regs;
 	}
 
-	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
-		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
-		if (IS_ERR(fsl_edma->dmaclk))
-			return dev_err_probe(&pdev->dev,
-					     PTR_ERR(fsl_edma->dmaclk),
-					     "Missing DMA block clock.\n");
-	}
+	fsl_edma->dmaclk = devm_clk_get_optional_enabled(&pdev->dev, "dma");
+	if (IS_ERR(fsl_edma->dmaclk))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(fsl_edma->dmaclk),
+				     "Failed to get/enable DMA clock.\n");
 
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
 

-- 
2.37.1


