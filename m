Return-Path: <dmaengine+bounces-10846-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIAIFkgLFGr6JAcAu9opvQ
	(envelope-from <dmaengine+bounces-10846-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:41:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E46915C7EB5
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49E6F3019478
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528E33CDBD5;
	Mon, 25 May 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="P7xZq8Br"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04D36215F;
	Mon, 25 May 2026 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698257; cv=fail; b=ZjKD9XYfA7lCdjxQsoHYV9bWMWMtcNR++w/oILOM26/13B0P57eL76cFvcNxxfWOPjxx6ru3jAWOsqMnUGkxyB0qOnAP6PdXvxjGHVbwCXf4OvWrlCNKZeLjzn0pfYRGfDuakKC8K+IOnIOmTku93M5G/Apx68yOjfavoe+cnHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698257; c=relaxed/simple;
	bh=Oyw/l5rJy+nfPYldiU0ScGZ16iZ52Pe24EhntE/Ql0A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WqTjHANUK/vVl3m8AiYweAHCSsfR/fYEgDievsCEESp/Z1dqFVQs8rSjbSQpMMaMUZRleB4WzJQmH1IcfWSz2YzPrU8ADcqaHRgutzMTXoLtPwD6qcQSpssKb6PrmdRPAORO4bUHn0yCbKcEsYc8Gd6IPkf78Higp7leqeRRPXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=P7xZq8Br; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuSgOcmaW5aMyagei1Wcwz4iAi7Zm18t3pAf9NILCTvCmpCx3PzDBVdc6xOqKMWsa11zEa+YHR1KoKPNUHTyM20UXjTVYGtfwArrKs27opQXh3t5y9ApJtF6JQjx8Jkt4PyqbAzeO0Jl4sUj5/srLIc1OaztBCzGO49sQIfz0fD2DYMWGgoDkvkvykMI0a83Ae18XhbmUIiSTppj74KSPgLCIa/poMPe6olcNWNtkFfwp9GprdwMBp1uoJyz4srjtuNRJrovMZYzURtoBm3p4BHfnCYlmZpgjpoxWqemL01tq14QXeQ/61XhtUl0Ipr6t21akGfiwy+DIWLCS0UAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnLqzU+LDw96IM/JZj2S+eewr/0pvGvJqDzJ8iYV77U=;
 b=D4hbvnQiKqfWIZNYFyffRYEnDYMy6A8V5YyDEb0KCrQ06B56/iRJqopFhBSw2kowpxtyfPAh9jExTKOcXROMFZOfQvULdo0B8cld1WK+TlgQ0IK19AJJk+SIhR9oRbIWRSdwWjtH/2JwFl5L++V4vdNHMzUcEiQfQ7VaW3CIyuwZUjRzWSZ8Tsq+WEGGwqhQCtFBvHGcPHUuzGyAi6KI34HzpbOpd1qqu7GpfqXyl/VuzgyyK5KpKP07ZT5Z9v1X3R6l9f/FeI1I2uhvEp+OEfjTS1cyA8XEQNsIsb6qoozsxrlQCGQPTcQStshfDa/lsK7jiwpnONrUCEDIVOlggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnLqzU+LDw96IM/JZj2S+eewr/0pvGvJqDzJ8iYV77U=;
 b=P7xZq8Bra28w7L1vvXlzFUDHLKMBqP5QzYRY9bUqIhV8VuaFWFTIsQWE86WMaXON6s/4/P5lE3WSlFJzEB5iQXYpBLuCz8s/s+Q4IOVrVa5BsblqAK6m97Fl1YPUvTq4X9SfLn8WRnPiMylFYk2/aTcRY6e+iqEEXFt6KYRvdnsgUJbzvz3+Nii6EX+UDlqrIb2hh4NDhZpHwzyKDVleuGGrQB1jrYab0Eqdb/hfXqyqBc9rWJtaCboxMwZ8SV/PfaDBBb06ajeMzbaIaiGyoxL2HIoFq6BVq8oRppJ6XlSrb1q8aJA+4FrX9G4NBSKBxKrS5oE8aiFaiDK8b6FWWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by MW4PR03MB6457.namprd03.prod.outlook.com (2603:10b6:303:120::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:37:32 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 08:37:32 +0000
From: tze.yee.ng@altera.com
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor FIFO writes
Date: Mon, 25 May 2026 01:37:30 -0700
Message-ID: <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::9) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|MW4PR03MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: ad722a7b-d853-4a7f-f2de-08deba38dcfb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ibfQ6USqOxia8je2ONFLMCpuvxNKDab6llnPxYISaBXxM37g72Dx4N+WWypm+/n231pFYki97z1OM+IQMjoNf3/HXM4PnG0g+Ve0oX5jB3oJJ6+FrsK8L/DV6jJzjeujV1zDPJbXdJUj3XJJLrtN4CMhioHsFlEiGd9d+syasFf9mYnQn5oSpuQyzqIgTWry+HfV2KC2otamoBKsSjrO++suWbMcfGiQv4V3BMr/3jhYRfVfL4QBxPHdlwx/ElAkPvB+u55Gtj1C3zSvMlpB/oAL/XFgzMU7ly0kC5zgyRqfE6ZAtaCKBlr5jXJH2UwmgpRNj66RT0em0KLoAYDgFx32NosxK7c3kCFn9/zT8br1OHWkq51SPKHHxPRnGXRn6tklo+iKifvemcq9MrrS/+9SU2Oxh8P5aXZyFwGUVAscELwhR5HFDiAKC9r0X20J5X0A4mO+4qpW9UQmYuIqhbJ4f8BPwlk4JBvc6U+wANt0M+jJcJ1OAx5L9Xgf5krih4xgdOt31xAfv1Wss6QnNBs5fHsRBPq+4m0NYMtXtQ37YBki77dmKFwnmG0MrIN1lBzX5LP/LTNIXo+yAFkHZMx27gXWBleNmf83j7InmE/GBHBMukDyVNJKq1tIy4csKMkazHks46XJT1qKNEmdZ0uJubwUtETbDwJhsLyqN55ro4MIILKBi/BJQnK8X/lK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(55112099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elJ1MmFqdjdONnEvOHZrYmlkRzBTNW0zRUgxS0tDRnVQQ3A5ajV4N3FPb1dk?=
 =?utf-8?B?bS9kOE1sZmg0TW9BYTl0ajVUMzN0YTJJbFA2L1JEV1J4MGNGZCtDQTB5TGRY?=
 =?utf-8?B?R1V3R1BKWG9ic3Aybmh5TmZpRGcweTJNOHRTRmxIaHR6RWFPaXJlN1lXcjRo?=
 =?utf-8?B?QlNZNktOS1JmZUxqdVJWVU1PSVdiZGVHQTBmVGtWQk5KOW1MMStrZy9zQklZ?=
 =?utf-8?B?L2M3MnhXK0pIeFRHdWwwcEc4KzZMR3BWTHZZekFablNjejM3Y2w5Q3VCY3Bv?=
 =?utf-8?B?bEpoUnRNeEM4czZyZkd2bkVuY0xCN0NQeE5FTGFZQldIbWJkOEF3L0ZrQm9H?=
 =?utf-8?B?TUM4cEtsa3NVeWZxekR3NENoaUNUTDNVT1IwSGo5SnlUZE0xMWtGajNZMGhT?=
 =?utf-8?B?M3FUdmM2WFJvYlR5SlJ6Z1ZTVk5CZjZFdU5EanErMFk0YjJUekd2cnZQNHRx?=
 =?utf-8?B?VDFqQTIveXNYcHd3NU8vejlKZVhZeEdiQURBbWE1RUU1ZkI3OWlkMERSZ0Jw?=
 =?utf-8?B?MTZZUExDd0ltbTRlakFINXEwZEYyQ2wrNVNLZGluOW4vZXIvK3V5Tys4ZE5i?=
 =?utf-8?B?U2VUT3lKOVJNYzZ2Y3B4Q3VKcURjM2dRTUtlaXovRndMczVDaHc3RVFGbWtO?=
 =?utf-8?B?QzNoaldZZVI0bGw4QWx4eENWZnRQdG9Na2ptdjRCNXYrY0NacCtzVTlOdm1Z?=
 =?utf-8?B?ZlJnMkVWMlhMcWx5ZzN6bDhNdWlsTkNmNEozK0ZrTTJCQUFEVXZkMzZna2ZH?=
 =?utf-8?B?Q29LM2llK25MbEV6T3NnYm1MejNrZXhmNlBWL282aElab2l2TnNJNW5kbUZr?=
 =?utf-8?B?YnRpMC9mZGFkRzMwZHBpb2ZxYnBvZjlyZ1E5QVZwTjdwdkU0UEo0YVIvRnEx?=
 =?utf-8?B?OThBVEFpY01qcVFLRkpIUFFSS1JTdDhTMVkxeFpuZmZPSnBrVXphRzhscXRx?=
 =?utf-8?B?aXllaGNMUnVhS2NDeG9FU2cvc3VjaTVLb1FLU0lSSlF2R0x0b0dpSGE2cmtm?=
 =?utf-8?B?Qkg0dUFibzhLMWRZTFFyY05qZXVzZ1d6S2laWnRYU1I2ZSsrOEpENW5lNGEr?=
 =?utf-8?B?TnhTYVJKZnljdWloMEl4NmpEcTQ5L3dPRGE3TWMrL3pyUTNVaExDTU5SWmJl?=
 =?utf-8?B?cG5FUC9sNk1tUzBPUXI5Q09iR2ladFp2cm55VDZOSXRoNzRMOHliS0h3MThX?=
 =?utf-8?B?cFBqNm1TVGRkRElEWFloODlFNHZCdTFnZkFPWnovaU9RUERTd2xuVzJjeHpu?=
 =?utf-8?B?NDJQVVFYTDJ1NWU5TTEveXpsOUtSWXJzb2pOOUFYYWhNR0wrZ21aRmtBU3FZ?=
 =?utf-8?B?eXFXS1ZBMFBJR05SLzFFZ3FlK1JUS1MvSkVMT0wySkp6L0Nnd3FSWnZjSVo1?=
 =?utf-8?B?VEYvR21qSjA2TjhZR2VqUzA0NmV4ZTZzVU9pVEVETEJpWG1BRGJiZ29saEY4?=
 =?utf-8?B?SS9QQmRRbERBaEhiTkY3L2xIMGJ6MUxBb3pkL1hFempYWFR6UERBRnlsVWdM?=
 =?utf-8?B?STV6bXB6MXh0VFhBbmVMM3Q3QlpKelhlbFh0cGtaZjJGWWpYR29BRXBRRDds?=
 =?utf-8?B?ZmFPRnJJVWdhSFNiM0lKTUlBbWZWWGJTNE42SkF5azBkSUI1NTVJTDNxdFV1?=
 =?utf-8?B?azZvdHI4ZFNzbG1jdFA1Q09tNUhNQVpHU2dVZWVpSkpKaUdjdHlrWWphK0tH?=
 =?utf-8?B?Z2ZNbURHWVhFV1g4THoycUsxcHJoN2FOS3ZYVWN5RVBjRDNiY1dOajEzQnRk?=
 =?utf-8?B?T1NRWFZ1L0VDNi82YWNTSDFSd1ZVMkpaNlE4aHYxUTZaZkJtREdURmtNS3lw?=
 =?utf-8?B?RmxYZHJlcnh6WldHcE00YWlmQzV2NndqaWc3R2g0Q2pBd0hVQVZEQnlHSnhC?=
 =?utf-8?B?b3AwakwyOFUrdTBmbVJsMnRPdWVoYVVPZHMwWXhSNjArUWhEcWk3dGNPRVZJ?=
 =?utf-8?B?emNuaFdMTFF6QlpCZTVhVHRUM3UrQVc4cWpXRkgrSnVTd2laaEFNS21NMUJM?=
 =?utf-8?B?dUJhWEU0WDNJajZZdnAwaXRaWDJKU2ZmaElReGcrRWV0cXBQcElwdDdza3Nk?=
 =?utf-8?B?TW1GL0VaSHBydkRMbHp3bmNjclRoS2V2VkRrYitZbXVDT2NLekc5dTVVaits?=
 =?utf-8?B?Sk00eTFvbUk0VkpETHdpMEEvTytQUHlpb3lteUxXNkRpQmdYdWE5U3ZYRitu?=
 =?utf-8?B?aW5CampoNUxhb3g0YkhCT0g2R2tVVS9IWnlsNHlYK015VkZKdmIxRnQ2OVY2?=
 =?utf-8?B?eEtUNTZOU0cwRDhpbzFCYitQVTlFTi83ZnlLbFMxVENSQ0xaT2lnQ1ZGMlB3?=
 =?utf-8?B?V1M0VlBBaWp6ZXl6L3lKNkdMRDh2dEQ2NUR5R1F6R1pLbDg5YUFCdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad722a7b-d853-4a7f-f2de-08deba38dcfb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 08:37:32.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jEkkVlH41Ovyi2b9ZcoL/vFB1DvWCUcVUsU3fiJQc6OExBClsXrzVJimD8XShGqFHYLc405Nl6xkG8YQzIkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6457
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10846-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E46915C7EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

The descriptor FIFO requires that all words of a descriptor are written
in order, with the control word written last to flush it into the DMA
engine. Using memcpy() with __force to __iomem is not the correct API
and does not guarantee appropriate MMIO access on all architectures.

Replace the descriptor body copy with memcpy_toio(), using
offsetof(struct msgdma_extended_desc, control) to exclude the control
word. This matches the previous sizeof(desc->hw_desc) - sizeof(u32)
length only when control is the last struct member; add a static_assert
to enforce that layout so a future field after control cannot silently
break FIFO ordering.

Keep writing the control word separately with write barriers, so it
remains the final word pushed into the FIFO.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Update the patch to use memcpy_toio for descriptor FIFO writes.
- Add static_assert to enforce control is the last field in msgdma_extended_desc.
---
 drivers/dma/altera-msgdma.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index b46999c81df0..e23e5b441a24 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -496,6 +496,11 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 {
 	void __iomem *hw_desc = mdev->desc;
 
+	/* Ensure control is the last field — required for correct FIFO flush ordering */
+	static_assert(offsetof(struct msgdma_extended_desc, control) ==
+		      sizeof(struct msgdma_extended_desc) - sizeof(u32),
+		      "control must be the last field in msgdma_extended_desc");
+
 	/*
 	 * Check if the DESC FIFO it not full. If its full, we need to wait
 	 * for at least one entry to become free again
@@ -504,17 +509,18 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 	       MSGDMA_CSR_STAT_DESC_BUF_FULL)
 		mdelay(1);
 
+	/* Ensure control is the last field — required for correct FIFO flush ordering */
+	static_assert(offsetof(struct msgdma_extended_desc, control) ==
+			sizeof(struct msgdma_extended_desc) - sizeof(u32),
+			"control must be the last field in msgdma_extended_desc");
+
 	/*
-	 * The descriptor needs to get copied into the descriptor FIFO
-	 * of the DMA controller. The descriptor will get flushed to the
-	 * FIFO, once the last word (control word) is written. Since we
-	 * are not 100% sure that memcpy() writes all word in the "correct"
-	 * order (address from low to high) on all architectures, we make
-	 * sure this control word is written last by single coding it and
-	 * adding some write-barriers here.
+	 * Copy the descriptor into the descriptor FIFO of the DMA controller,
+	 * excluding the control word. The FIFO is flushed and the descriptor
+	 * becomes valid once the control word is written last.
 	 */
-	memcpy((void __force *)hw_desc, &desc->hw_desc,
-	       sizeof(desc->hw_desc) - sizeof(u32));
+	memcpy_toio(hw_desc, &desc->hw_desc,
+		    offsetof(struct msgdma_extended_desc, control));
 
 	/* Write control word last to flush this descriptor into the FIFO */
 	mdev->idle = false;
-- 
2.43.7


