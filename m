Return-Path: <dmaengine+bounces-10410-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJeEI+leBGqiHQIAu9opvQ
	(envelope-from <dmaengine+bounces-10410-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:22:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9C6532184
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BF1E3017BC7
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3D3A6B74;
	Wed, 13 May 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eUp74g0s"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF03A6B6F;
	Wed, 13 May 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671327; cv=fail; b=JL0OXaHq/Zv5IDh08CNeO3OJ9PDoMMmh3Df+nGy+k2aVS3jFdHSkS3SkEhM41p/VEro5StyyW+j7hb7PAxSfaTr6coVZzKVavvcfSZLEua70xMVeBA5KkEpmhab6CLIfkqRMFhm+MlFEhRVLDWp9JaAn4YH+tVVVJeBSU3P2cL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671327; c=relaxed/simple;
	bh=sleXLuUTzNf/SHS/8iKVR0zJAT8+ZTrPVCRtzPuGTuI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DYZKG9i8FKHn2n/a4lsQkwH526xlYh4RLBQ7jSMA8Eq7PxgxzE7nghmVYdO4T8K9cxVMH3BzhJ6pEf4UUJdr5PXj/Xj98wCuS8fv3bcxAVmqrZLnRXWqkp11ZPQPeB6V730sdQIV8L+qD8Qf3SWXkshmtnz9+B+8DWDG+EqJ7Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eUp74g0s; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrdMbMF4PFpn0H5v2RKkgAF3JxkbdF7VfjyQ2nsYOQsQ0E+St5FXSjYD8zAn8C9l7lENuxwj6EHleat0MtfuwWATNrVhLwVwEEQsmcKQoBu43Y3yUVlmcdmUL3tKnfLgURe1k7uYEHpL8FaYe16jhtbXeiIESh8KqQnELAA+Yj5LSlC0EAsy2W7dU9mAOD3ZzJvqux43ZbGnqNmmjU/2WnKjwUBCQn4I+PlAmkmkENol/VE2+2qOHT7HE54OELWKO8JATCWBMTIDgxjIhkE2v06aQvk9U1dmz1ga1izhs8GMz3U6Zqz/hW+r6P8+8GVMxu1lb43DNuZaO/o/x31e3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlaq4i6Tzc7KqdEatm30LP4UuSRfa7XpVx246TA4zWc=;
 b=CJWCDlqFFFOtBo9FAfBnwd/+8avTDxsoJ6/fnfvo6Xs1Dm4SQvRxTwPrlFJsRvrhD1NmOagfG9eKOBWSC0iHVJ7eN29+dJszFb58gVRDFn6/X7FN1TiwotEWd8usWgO07a8o2TymZYfiO5P+yuywzX1RM6/mip/f0Fndt5cthZlpvSWldn+Qd4zw1SO6zdOT/BXC8B8O92J7/RN+xNxtDkFCNYA/TjNZfLxn0YhVQHiQ6TCeRSUo+WcRrMKE8SFL2Vgt3q5KSrsy3RAf6XQYWcC3yXnOj4iYADw7cuqJ+sb0KajtBPj9A87mQH127ufHHFagebciK7DwFUIoCAhmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hlaq4i6Tzc7KqdEatm30LP4UuSRfa7XpVx246TA4zWc=;
 b=eUp74g0sN7haHHuL8qYeykm8q6bGo0scBr1bDnv+pxC5YPnMGJW494hAzndMQ1ugETaK2nvhLH/U+jd3J+sEldxqdi0EZAd/aCKLwFp85PxaSWbANi8zidyXtbZvH3yusQkxW7jzv2yItmaVQ9/JpoKXo9CN5LxIgNtHobByN/0dmDj5TFhccD2wxUdYT4MqCxhzTbUY3UKua7NiWHdVTIYNEu2qoxM4uFJ16TnTwIT1gZCwf8OWT3JuEdJ66CEXlrWYhL0rcXhRtY0pekfGYeoYOIMi/GD5YHBHdGI+wqkw//lcBENbwXnq4X2HKNAaIS4rtZLeo5GFLyzrzZXN2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:22:03 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 11:22:03 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Wed, 13 May 2026 19:23:47 +0800
Subject: [PATCH v5 1/4] dmaengine: fsl-edma: use
 devm_clk_get_optional_enabled() for channel clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-b4-b4-edma-runtime-opt-v5-1-1e595bfb8423@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 82c48362-255d-4090-41b7-08deb0e1db99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	o3okGIM0BLZuokO1Cg4/mBU/G/Zt8N9FiPks4n5YBE7TCI0QeUiT2pbYKKHGhqEx9wZfIeK8r5ogqdDukwQfmuIDKcx+AwVn9q7RByFERwVyJaDAQqVFXaV1TPMsdS1pRY5ZN+NlhvPt9PinG0l1BF5MexivhK2/lSGC8hLkiP26F1pOU7WyI0WL90RHQnWfiSpNhUDntKyaRthBRjbDkQON7CKCbxDsgIXkJlPseOkUh9zF4t0ItLlddO8MWJhJCrsQM5XNhD10dDEGTG3THvhA4J4iv35ybZw5fx7HFtJM057hzzRyOrSayx0OSavwwMgWiUs94X0VqxsP22Qjj26K57E/DlWT6UWrVN2eQc5dWLveL2R07s8SlN6FehIlYF40fRkxBC2DP7IJNi+8Ba9D+Li0h5sutOcIos5NYR/WMkyhfSiDkdTmpJTQy4JAqTySzdpkwApYMvE4GE74TYagfQWgM9iWNpal943ZkSslElp46sbVLJc0T7nkwVeIz2i6krlNiKID41Iz5X7L7E0iIdFelRfIJhENyUwv3Yq8+D21MoviXGILjmAjm2tsBzDZSPQBtuQQo7sYfqN8uNzdhUB0SPp3aKz1IHOX4WISP47+q/7colu2P6deo57BBT6XRsOfy4iZ6KoJ/UsqmfPA6Iuc5TAMWvf0Cu95kII1O5RWF2NKzzzodJMJP2OeHL43rJ50l5rAteOqVtoIcGRK9/FVKbCi/J0bAzq5dW9vu3U3fLd9Rmlvth77wHpw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU9ueTlMeVhOanI5RUxYZ0FiWHBvazA1a0NBQ2g4clk2WkRaNkJlZjFENU5t?=
 =?utf-8?B?VjBqYmxZZDdHbGV6YlJYUEVwR3pzdFZmRzR2RkFZa3FYZkVOVHluc0xqem1I?=
 =?utf-8?B?Y0J0Y2dUWEduRSt0WEpLVXFSZzAzNDNZQzRwcno4OFcvSWV6S3dya1BVRkl1?=
 =?utf-8?B?Ynl2dk1lblhadGZKcm1GNWNCWnpySzA5RUlxeG5tM2o3WDRJMlVHSmM0Mkdn?=
 =?utf-8?B?VUFUYklOZUNZVmhYblY5YzVFTGtVYyttMUZxd3hCSy9aaFhuNDdGVHZOZHQ1?=
 =?utf-8?B?VVFiOU5hTGMxQWJ4TUJPVStVZDh0OWkxSjA5OFJmT1JTVmFsQWo1R081dUI3?=
 =?utf-8?B?Q29KK1NRZTQvVUZkVlY5YzZ6NTFRdC9KeXgvRkJSVnpDRkpaM1FhbncwQWVH?=
 =?utf-8?B?K1hCRzdlampNZUs1TVYrYWh3d2U3eXJMdnIvUGJqbDVkRXVURFUxMnZQczNL?=
 =?utf-8?B?c1pncmpubVp2YkVSbCs3QjNRUWgwdXU2S1VDa3FoYjIzdHpOek1zbEhXc05N?=
 =?utf-8?B?b0w2OERhU0hVSDJhZ0REcU1kaW9hS0VmaWdyZjg0K080ai9wb0s3eUZGUGNF?=
 =?utf-8?B?ejdleHdCdDVKTy9FeElvbkRlT1AwYVUydUd4aVkyUXdSSzJubUo2UFFmSkxX?=
 =?utf-8?B?T1d2T256VE5OelJFTXZmajJnSVhlc25tZTA3bTZxdldxVWEwU0xYMWZyTEh6?=
 =?utf-8?B?VHRQMDhveWxwSUV5ajRTZHkzb2pHTFhBd2ZPOVVTSkp1MkY1ZlFuYkN4Ti9E?=
 =?utf-8?B?a3lOK2hFajhMdkVCTWZyVVFKV1JrMDh5OWQ4VWlFcnhyV2l5OWtrY2V1Zzdp?=
 =?utf-8?B?MWVCNE1WY0RSYWYwQlVxZnkzNkNWVkN5MHB1WHMwOGJrTitxaCtiTytWTU1U?=
 =?utf-8?B?M0JVNHVkTldFMnkwK3JnZFpzeU1sem5HNitTWm12VE15RzYxejZOOGFyWU82?=
 =?utf-8?B?WHZUMFBycGdKOHNtQU1OZTdMbkhQU21TdlJuK0tLWnk5OGZSbkxzbEFuQ0I2?=
 =?utf-8?B?UVN5NlYrcFdYRktiU2g3VEdjQ2l1R25jZm11Tmp6cHpkdlBIZkdxWFFQOHNQ?=
 =?utf-8?B?S2xWYnl6dWpIL1JoVHROYnRwN0pYS2lJM2s2NktQT2NXWlBZR3BsenpCSXYr?=
 =?utf-8?B?VTdvRktXSWFxbk5jeGJwdFh6SlpEQ2hIOWFNdUtKL1oxeExxN21IVDRTUmFm?=
 =?utf-8?B?TFlYb2lhRVplbFlMUlFlYVZNQ29zNzFvOEdHVUkyNG5palIwQWNmRTA4ZkZy?=
 =?utf-8?B?MHlTR1ErWUpaOHQ4NWZ2T1llUXRuTXBRMkhYKzJkVmdwbmtiNDNDVm0yTWxs?=
 =?utf-8?B?cWsyNVVobWE1WHhmWjhBK0VHb0ZsOHpibmpkV0w3MFpETExNd3RwNjNzLzhG?=
 =?utf-8?B?QXh1VXBGZEFUVVBCc1hGdnpmSWZqdzB3NllkMFZaS0hxSlVFKzJDOXlyQWV6?=
 =?utf-8?B?VGZrTklRVnBFVHRRNnN6cWEzeHIyRzh4MnZrV2lCRXhXcnZqZWRKRElOTllk?=
 =?utf-8?B?R0VsVVZRS3JDQnk3Q0U3ekVibkdVRUVUWlhaNEZzVFVnU1p0OVBScE5CYlJM?=
 =?utf-8?B?Wi9HRnY5anpxajdZd3pWb0lyblFPN0hIbTdrYmtmYmNSVUVBQ2RkdnMyV0RW?=
 =?utf-8?B?RzJTNUZxbDVQd1Rsd3BXb1NWN1JOemJ6alVXRHVKVkIrTHJpc2MwbDJML3lC?=
 =?utf-8?B?eGJBL2pDSDNVN0lsOG1wN21PcGdKdWRTVWdnWFpvdUVKNHVTbnl0c2FoSWhk?=
 =?utf-8?B?WWF5aWpWM3NLc0wrdW5aaFhnWGdWTWpjcnFmVkcxYm9ENW1rUTFKTnlGaUNO?=
 =?utf-8?B?dHhPUUxWVlV3dThwbWkveURoQzlzUy9YZ01DWWxnNitRMFY5SjdpSnVlWUV1?=
 =?utf-8?B?U0FyTEpGWTY5dFlFRWdRU1BVMDBwREZ4QVd2ZnBXVWlqeWY0SHlCbml1WG1i?=
 =?utf-8?B?Mjc1M1ZvVmxUeVlQaDVRRGtFRnBXT1lGdGsyWEE4QzBTc0dDUmZ3YkFxTzVH?=
 =?utf-8?B?czQxOFhGN0RscUkzK3ZjZjN0SGF2WXNUdFByM3BBVmJCNzEwVWs4a1d5cEdM?=
 =?utf-8?B?VWlGRzRBckkwekx0NDdqdWIrRTg5WU81Q3dhWnBMSEgwcXBUYWJORGV6azZD?=
 =?utf-8?B?Y01hVUpWUjNjQVR3SVlkS2t1K2NQb3dNeFpuRWk5SFdONXF0ekt6TXVqdHRO?=
 =?utf-8?B?cjlCeUxQQ3ZoWmlzRHJOL2NpN09DcDQxRERBMEhCZW5MMTFnMjk3TVRBQzBE?=
 =?utf-8?B?Rjh5c2s4UktkYzJ3TDZjeXFJcWVkZENvZWZGelZFaC9rempROUtkbFZYYUxY?=
 =?utf-8?Q?HJV1ozdF3DzMpNncoH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c48362-255d-4090-41b7-08deb0e1db99
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:22:03.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTasl2N6NWqrX97gJkGUfao8FAbL+1eocrR6U/ZmWggE+3HzwT3wryXvuW5CIxvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
X-Rspamd-Queue-Id: 0B9C6532184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10410-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@nxp.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The channel clock is optional and not present on all platforms. Replace
devm_clk_get_enabled() with devm_clk_get_optional_enabled() and remove
FSL_EDMA_DRV_HAS_CHCLK flag to simplify clock handling.

Prepare to add channel runtime pm support.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  4 +---
 drivers/dma/fsl-edma-common.h |  1 -
 drivers/dma/fsl-edma-main.c   | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index bb7531c456dfa0a8812883a2cf3e9e2e23b0f55e..e1ca25ff228dbe392bb800f6ecac5a85ca326bf1 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -844,9 +844,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret = 0;
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_prepare_enable(fsl_chan->clk);
-
+	clk_prepare_enable(fsl_chan->clk);
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
 				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094805aa728b72a51ae101cd88fa003..f4354b586746d64faf375cc9ce04e15a7b6d86ab 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -210,7 +210,6 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_WRAP_IO		BIT(3)
 #define FSL_EDMA_DRV_EDMA64		BIT(4)
 #define FSL_EDMA_DRV_HAS_PD		BIT(5)
-#define FSL_EDMA_DRV_HAS_CHCLK		BIT(6)
 #define FSL_EDMA_DRV_HAS_CHMUX		BIT(7)
 #define FSL_EDMA_DRV_MEM_REMOTE		BIT(8)
 /* control and status register is in tcd address space, edma3 reg layout */
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 36155ab1602a9b264df73dbde3ec2b3aa6cc27c0..87f575d6ccafff455d47f8c794a503abf97e2af1 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -567,8 +567,7 @@ static struct fsl_edma_drvdata imx8qm_data = {
 };
 
 static struct fsl_edma_drvdata imx8ulp_data = {
-	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_CHCLK | FSL_EDMA_DRV_HAS_DMACLK |
-		 FSL_EDMA_DRV_EDMA3,
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA3,
 	.chreg_space_sz = 0x10000,
 	.chreg_off = 0x10000,
 	.mux_off = 0x10000 + offsetof(struct fsl_edma3_ch_reg, ch_mux),
@@ -808,22 +807,17 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->tcd = fsl_edma->membase
 				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
 		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
+		snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
+		fsl_chan->clk = devm_clk_get_optional_enabled(&pdev->dev, (const char *)clk_name);
 
-		if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
-			snprintf(clk_name, sizeof(clk_name), "ch%02d", i);
-			fsl_chan->clk = devm_clk_get_enabled(&pdev->dev,
-							     (const char *)clk_name);
-
-			if (IS_ERR(fsl_chan->clk))
-				return PTR_ERR(fsl_chan->clk);
-		}
+		if (IS_ERR(fsl_chan->clk))
+			return PTR_ERR(fsl_chan->clk);
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
 		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
-		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
-			clk_disable_unprepare(fsl_chan->clk);
+		clk_disable_unprepare(fsl_chan->clk);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);

-- 
2.37.1


