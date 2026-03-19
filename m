Return-Path: <dmaengine+bounces-9517-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAg0HFfDu2n1ngIAu9opvQ
	(envelope-from <dmaengine+bounces-9517-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 10:35:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F02792C8C32
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3E7C31FFEE8
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D163B3BE2;
	Thu, 19 Mar 2026 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="IqkevzXw"
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023120.outbound.protection.outlook.com [40.107.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DC3B6366;
	Thu, 19 Mar 2026 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911839; cv=fail; b=oKgTlc5H2eemeRr8wVbhqWlGLiPu0GvC6IFyHOrffvGMJ7kH/8eQgsxsN1AbCFXfv1RonSzTxeS6FQR02NhNQnd17EjoDAENo7niqCX1tipZoCIaNvxeSvBsKytXxmq8FXwifcd90hR6fB6+CEndquW9XccYJX+egrHH3PQX6sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911839; c=relaxed/simple;
	bh=qv2SQeP7VntSeOpHgVfD0ThVidHK+mxmpmBnjh6Tafo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YgWofpmgZ/nbAKxV+29yx7gWAyA59HjBvcOhBu2DrLPkWZYIg1OluwiDoqdv/Z2XUlDD0lvth9W1DEpwlgrzAilhPLiecjYNLhru9vsPrExAV29XBDFPbjceMFoG5mm9Gt8NVjAXXYomlgLhaZrY2N40or7edd+GbcjRxmSMJ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=IqkevzXw; arc=fail smtp.client-ip=40.107.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaBzXM8TK5bqXAPym9iJZgwrd0Cfxq/PkWePkEysKrFLPdol/R+yc8/FRNL6rkf9n0l42gmmVJwnf+7luwBdyq5J1RcVVmIxPL9vrQ7PKsh2TSRZSeItr4Ylpp6zE81y+89a74HCMGXMykKklT2YAQJ58Pp0asBar1O5zLI88AG6n6mas1bpxxUbGoR1PfHhV6j5lTehIr3m12zqztUXqGD7e5lkBTXTMHxcfoGbmpjsHJf8GujIZgvLONkQtH0p9Ub/7MM0SwEpsGhnVQKlOAHdacvoIZ8uOzgoBo7s6yVgdFvqXWU9wng5z7TstroxlgKTngpt7aBMHu+sV0oaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ro8Lvos7gjp8WE8rthHbsSe1Y84ro7puloUOoV2ySvQ=;
 b=HZFSP7BU9z+7K8SGlPPebLGJyrq1QPNIQUtcHyv8AxLyQI4vgSL0xe1BB7UwPGwNy7L5jvOY0w2+/p+ltFbR61wRELHva2ArhqDZDk6RjwaQ3jLpxo3Hm71Q1T3rA9yduWY99RDe5pgcsCwFvi+jO0ROqiWezVQ2sEqhvGB2hLleXGTNEh/zRdRKBRpUf262AVHAIkxYV1EMBRMdKggCBhaJXF6BDgd+AWKQ1Fx9Mmke131RNE3gaAHXzQYAxg70ayKrpGRt1aOCmIBsfvT7bBmcnY2wCzjf7OzNsIgy/UFhESQB40x+3YmeDdZC6IGB/3dJklBD2o1EGgXYq5cumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro8Lvos7gjp8WE8rthHbsSe1Y84ro7puloUOoV2ySvQ=;
 b=IqkevzXw2qTMrM2oMsKO0tjPA++jXN7PAura/sKKsU1O5kaGc+s7XqLp3Do4LeXNMAh5WNjr52+KeUb1kH27fptLdnqy2v/9viKnEcfxWwwNv6bDhbE9zC5Ge32pOw1Okgvfj8v/63U+HItBQzfPxRbFumwRSYNEmwPnsnHbl1w2K66iBAjyH3YuX926aBcHO6NsihXFODOmgENqyQnSjdP21iv+I1h23HJQBG4auJHJnXd1mgTA4x2P4MUyIZgLcHcUMhGrzW3sJG9FZVW1l731eTPpNfZUevL8oU/m6hyCTY7MpjIJLAn9Gl2JJFG+ZJZ5vH9BvzBLTHUh2Y2LoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB7845.apcprd03.prod.outlook.com (2603:1096:400:44e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:17:14 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:17:14 +0000
Message-ID: <7ad0af10-5999-4cc1-88da-089c4174bcde@amlogic.com>
Date: Thu, 19 Mar 2026 17:17:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dmaengine: amlogic: Add general DMA driver for A9
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, linux-amlogic@lists.infradead.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260309-amlogic-dma-v6-0-63349d23bd4b@amlogic.com>
 <20260309-amlogic-dma-v6-2-63349d23bd4b@amlogic.com> <abk3TUTaov3zIfFm@vaman>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <abk3TUTaov3zIfFm@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::10) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: a14b8da6-5b14-487c-796a-08de85984ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FVUv2i3McGS6uNMH2YrRgHPt9wVLef6WJd/DobMgRDbIQWHG/f7Y4Wsn0pJ46SxrcX80c8sZgmHg3zK8LEl4p2lwhbwzfZ2MJyw8Hk1IK96VnqkWaywWe5vf6ilmTdX7+jJ7oEQ46YWdYnl/nUSVW3vG4z8oYc1EV04xaQqUQDuEprSJzX4kqgJHimzT8XmNgEr/RPmGKpuk1nxpoQUNSCtxUwjEUsZ+1DCtGQcmiXhIid118Tg4Az+IiNsZ7wOqmhuQ2tirduosda/nQ1CNd5Q54pE0ZeV8n+nhlb58XFTUj5k7IRei3oHxNTkKL9dl+JcxUFLq3FRuxObCpqKOIdkgdX0iT2mwRuQwnhGl1gvsuPUOlgL433BdvoBQUXoNLBvOOOl1TQAs5tNNEsDfpJSk+woHTbVC3p/MxeteN2ZKlaZvdTZlrwYXjZX/PFZqbe1evBnjrqsIXVD7SGcHXibf51+7+qgQypYdcOIuvnIhSsFVSl4W8LK9BuT9yAt8FsxQN/p6qRSQJt+E+EyImUCrOqIgRaBtSfFaXCUJUXDIhKgfrkDGHUJ4gREEcMWCn8SoyCYbFk4XUisIApjssESFlYDWTU8UaD0uvNGEMcT7+OMXyxfs/ONd9AjxmngzQpnJV1O2qyu0+Yg3E7uCAjSK0BcumaVE+zUliz536Ju4pHcYIpoRAkRab3A3NWq+2zLjdS8q63zD1mr1AYBsG1f6jCnfTVVcNQQ3obI5ZTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFp5WE8rNzdaS0dGWk9FNU5WOWtLdTB0YTBFN0IxdytxZk9nVEl6N3JJV0Qw?=
 =?utf-8?B?RHpqUndoeGUyU3Q2a0FWblZiaENWOUtvOGlEcUY2ZGxHQ2JhOEFqdEE2eVRl?=
 =?utf-8?B?akdMNVVpNWE0NWx2SkNqZUg2eXdSdDZ4RFlSQlRXK3BoMDUzRjFWeGdWVVBP?=
 =?utf-8?B?MUN4V3VPellmdzB4bjUvT1lndHVIZDA5cVNZc0NOVlR1ejJoekxKZkpSNUY5?=
 =?utf-8?B?TXdRaURyMmVGcXlENVVXSmMrV2pVTkY2QWpqUHp0ckI5UjlXNVpqeTJxbWhX?=
 =?utf-8?B?UVFaUUdnR21oSHl3NUtmOHcvQUltQVJKVU8vRnhRSEpBaGppM3ZWZmNVNlBw?=
 =?utf-8?B?WDd1RDRsNHVIS2xrNlNIVFYyNlc2M2twZ2wzQW4ramNvdjdGMjVRVENoYXlM?=
 =?utf-8?B?U2p3emp5a05uN1RUS0Z1eHF0ZmFNcDEvajJoTHE5ak4xQ2J1MU01eUYveGhK?=
 =?utf-8?B?cGhoUHpEdFJyRDYxZmJZZ0ZjcEJyamFXaG5DckdNTUIxdFczSWt0WlJhMDBJ?=
 =?utf-8?B?OGY4SC8yQzZTQ0haZm9sRW8rZ21VNlVMZ29zd3o1bi9EQzFSSGNrYlVzWVdY?=
 =?utf-8?B?d1NDWnhpQlRpd2VLMDU1RHJvUVl6YTgyRmxGL015ZkJuMmNZQUcxTE9BSzZV?=
 =?utf-8?B?cmJkMVNzRys1aW5mVXNjV2l3T1lzT3hXRTFjcTFsTlJSWk9DVmcwbGRsaGt2?=
 =?utf-8?B?cDFwOGxIaFc3VGZrVXdicmE1eVZsaUNmc0x0a1J5djRFczVjc09lbkVXaHBD?=
 =?utf-8?B?cGZLVzBEdUdMU2tpZ1A4RytHYWQ1bWJ4OTRkTmlvbXBMekR6dmx1MkNGNWli?=
 =?utf-8?B?Y05BSmx5dHJ5SjhyYzV1WUU2WUpQN1JkY2ZJcUlMajJEc25CN21ZWFZkVDJH?=
 =?utf-8?B?T0lhdmJIY0lkQ1kyN2ZZQjdDZGZ6YmFDcXd1SFlGTHdSd3A4S25Ca0QrNVQx?=
 =?utf-8?B?M0NJTk50ZTNzWENiM2ZsOFErWXhtYmFuL3lmaDVsWUpwazBDZ3c4RWt4S1hM?=
 =?utf-8?B?UDREY2ZmWTNLbkp3UDBzYW1ybmJwVVU1TFh2ejE1NkgvOEFocTJxNkk0TXZM?=
 =?utf-8?B?ZFYxNm1PM0hLNVhPUXd2WVcxS21tVGRwclVrMFFSNkVGMkIrcSs2ZU94TkVq?=
 =?utf-8?B?WTM2VHRKbVUwekJuR0FPRUZVOUg4VWQrZnk5bko2aVEvODZSK3pHRVRyd0lx?=
 =?utf-8?B?RjZRWmVQajg4QTRRR28wcWhVWWNKZjBCZ1M2L2x0NmJlMkNLV2RBaVN3S25n?=
 =?utf-8?B?ZWJGQUNhTVpZeDYxdjdFNWY0VzNSMnNFZitjNTBJTkRlWkN4VnBlS3J5V0U0?=
 =?utf-8?B?OU9mUHVoYU4xc2xzbms5K28rWFU2eXFGUW8xdlVUYjlGbVFhOE1jbWlRSUJz?=
 =?utf-8?B?MlphR1NoSW1paitSUmRNdW9uNXhTSjZ4aTZzZzIzazlteUZ1QzZucGtjNzRl?=
 =?utf-8?B?RmpFb1BpNUswUDZHdWxEa1RseW4ybUhWU1QrMEJLejJ1dUtpQk1ITFhJZWlk?=
 =?utf-8?B?T3B6VWNOOHdjNXoxblRUeTBSR3JGNHJNK2JEUWZhNGE1bVVtZCtFQzZvNE9U?=
 =?utf-8?B?enZWU1RPYWJIZHRsS3FDSDYvT2srQ00vaGNNQXNCdWQreWNwNWtCZVIxRVlp?=
 =?utf-8?B?Q1FCaElWZ2cyV0psTzZWSlFzeWJpWUQ0bXo1dFo0TUNDV0Jpa3VHV3FlQTFm?=
 =?utf-8?B?bmoyMXp3dCt6WWhwbjVHNUhaQ0dzem1DVzdnb3hGQitadlEvc3RsZUtuRy9Y?=
 =?utf-8?B?RU9WQytDMWw2M3A3R21rbTEyRkhVemtRK1IreGIwS1Y3R1ZEamx2R0oyMlpC?=
 =?utf-8?B?bXlSSGZHUllhTHhqQ0xUN2lWckl5ZGQraXh0UWFFQ3JFWktsRjhhWHptc3Bk?=
 =?utf-8?B?ZUdITjN2SGF4RDlESVZIandqZ0tXQlVDdUswQmJ5R09kTjlUaWRLNU92MkZp?=
 =?utf-8?B?WXp2RlprdnVoV1BEa0pORmdLdG41c2cyWjZ2cnJvSGlkdmVzZDRWRVRRdzAv?=
 =?utf-8?B?ZHM5WjRaQzJBWHVCb0RHdm4vWkMvM1U0ZE4xOURqbHFUMzJEbnAyRGZwdlBB?=
 =?utf-8?B?YlpWYXpuOXhFZWFIQ3MvUy81SXRFYTBaUTFjVWpNdmpRUjl1SmgwWnZ3c3dG?=
 =?utf-8?B?eWtwQWE3WkFrVzlDbnc3ZVFhbloxSVc4QWcrdVZIeUYvWm92Um8zZHVJK2k0?=
 =?utf-8?B?MDA1OHFrR0ROL3Qrbm9BWWl3dmE1Qm1mNndHalo1SExrY0dibkd5N0RHSXZw?=
 =?utf-8?B?bXhNdi8vOHkyVUhFU3RIYlVneHR5TkdOT3BaWThTZ01wdkwybWpZeGVXZEFj?=
 =?utf-8?B?cng0ZEJ4N0wyVW5PdGxEWVJCN3pUUUllVk5zSWk2YlZ1bXRoRHh0QT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14b8da6-5b14-487c-796a-08de85984ef8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:17:14.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYvCEZZVS7abbZ+yYAQ8n3LvQe7gQCBLJDO5CBtkUem2qjig5k8DfqIZtURABWJhsJczekS0sl8OzgHnovVW2qk0g2MhfjRkLzgCtFRHlqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7845
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9517-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amlogic.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:dkim,amlogic.com:email,amlogic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F02792C8C32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinod,
    Thanks for your advice.

On 2026/3/17 19:13, Vinod Koul wrote:
> On 09-03-26, 06:33, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> +static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>> +{
>> +     return dma_cookie_assign(tx);
>> +}
> You lost tx, why was it not saved into a queue?
> 
>> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
>> +             (struct dma_chan *chan, struct scatterlist *sgl,
>> +             unsigned int sg_len, enum dma_transfer_direction direction,
>> +             unsigned long flags, void *context)
>> +{
>> +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
>> +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
>> +     struct aml_dma_sg_link *sg_link;
>> +     struct scatterlist *sg;
>> +     int idx = 0;
>> +     u64 paddr;
>> +     u32 reg, link_count, avail, chan_id;
>> +     u32 i;
>> +
>> +     if (aml_chan->direction != direction) {
>> +             dev_err(aml_dma->dma_device.dev, "direction not support\n");
>> +             return NULL;
>> +     }
>> +
>> +     switch (aml_chan->status) {
>> +     case DMA_IN_PROGRESS:
>> +             dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
>> +             return NULL;
> And why is that. You are preparing a descriptor and keep it ready and
> submit after the current one finishes
> 
> 
>> +
>> +     case DMA_COMPLETE:
>> +             aml_chan->data_len = 0;
>> +             chan_id = aml_chan->chan_id;
>> +             reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
>> +             regmap_set_bits(aml_dma->regmap, reg, BIT(chan_id));
>> +
>> +             break;
>> +     default:
>> +             dev_err(aml_dma->dma_device.dev, "status error\n");
>> +             return NULL;
>> +     }
>> +
>> +     link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
>> +
>> +     if (link_count > DMA_MAX_LINK) {
>> +             dev_err(aml_dma->dma_device.dev,
>> +                     "maximum number of sg exceeded: %d > %d\n",
>> +                     sg_len, DMA_MAX_LINK);
>> +             aml_chan->status = DMA_ERROR;
>> +             return NULL;
>> +     }
>> +
>> +     aml_chan->status = DMA_IN_PROGRESS;
>> +
>> +     for_each_sg(sgl, sg, sg_len, i) {
>> +             avail = sg_dma_len(sg);
>> +             paddr = sg->dma_address;
>> +             while (avail > SG_MAX_LEN) {
>> +                     sg_link = &aml_chan->sg_link[idx++];
>> +                     /* set dma address and len  to sglink*/
>> +                     sg_link->address = paddr;
>> +                     sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
>> +                     paddr = paddr + SG_MAX_LEN;
>> +                     avail = avail - SG_MAX_LEN;
>> +             }
>> +             sg_link = &aml_chan->sg_link[idx++];
>> +             /* set dma address and len  to sglink*/
>> +             sg_link->address = paddr;
>> +             sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
>> +
>> +             aml_chan->data_len += sg_dma_len(sg);
>> +     }
>> +     aml_chan->sg_link_cnt = idx;
> There is no descriptor management here. You are directly writing to
> channel. This is_very_  inefficient and defeats the use of dmaengine.
> 
> Please revise the driver. Implement queues to manage multiple txns and
> we have vchan to help you implement these, so take use of that
> 

I will take use vchan to support mltiple txns.

> --
> ~Vinod

