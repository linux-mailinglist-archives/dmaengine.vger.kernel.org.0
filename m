Return-Path: <dmaengine+bounces-8482-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELwMJ8IZd2kCcQEAu9opvQ
	(envelope-from <dmaengine+bounces-8482-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 489E184E2D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376363003615
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEF2D8793;
	Mon, 26 Jan 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mydkdGWi"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D62D12EE;
	Mon, 26 Jan 2026 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413047; cv=fail; b=KeosJA2uJCafjQbnhXVYfPy0daT4jx6NV7AXlENEcBJ7+j+oVNGP77uUV3VrrM08bxvoEgyDrVXOMQAV2Mh31akzY5+3spvERcDGMaGpRvv5SkeQdK+RaVHYIE5YFBWnLn1SVOivc+ylANcmbu2E/ptOJnt7v+DdFrTiKbPitAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413047; c=relaxed/simple;
	bh=9wUJh1mb7/M0WIiD5OOV+aBnJNY1Gw1tp4wVloV8TpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ks9ubn745k23lIjBf97W5UIFkYx5Cyb51376xSK/F1P9ueY/Ud7c5HGkCeeBciDIXMKqHlyUgk7k7S1D9hY4vhxkyG1Xo6b3oIAVb95tn9aiSoxbrahfYIErtMDaNZ8pwLXRDLfAp6MSotxfTqhrgamny1Cbt7Bdi7h4s3nPmsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mydkdGWi; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBF8HI+eVYzXgi+D5B8yvP/kI9XHvf0SNfLdJRsgwP5FEAOfDGDr6Zrt/WtKb7deMp7dOSL0688/dklcgdT2dpVZmoDxcSjLAv7n6idWQM8X8YLIVuuVzHZbva4Q/WgVyeQqEEj7dGnIV6cYd6ux5qJIDEzxowwyvuosbkOjbBa50aEfKQvAgUf1vkFH0Ao2PTMZZblgQUlRilugD3ga+Gh+rshC3S0Nm1wNKN93F2aK9JShVeuVHj25aZrujVVmhrQb9E943891qZCpnoZry3YQD7U/Djbe2+yBZTF0oSEbreRQOK7QWvPVbqbTnNzqMnzOOUYeEvCY0Hp7Qu8RHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOAOtt7rw9JvlbQtyb41TBx8M+OcA1z+AHRwwOkU5tE=;
 b=lWzrqgqOGzRgI/cFn45LSMwNXeWxzuz38BdFWU/Fy82zxhkwJgiutcSzkYXoxWek06BJJFNWNeEJb6TDIyh6tHnVoNOrfl9972dD6l4V3m2cs9rt1QyU0pwxncMWU7FuIlM1YScHwIYVW8LWdmsCip2PM1Ie8rgo21s4+iH/hTFrFxjZMUeYbcv9Gxu9rGApSnOerXpU2n+i22ONidSoyq+z+vkd1XAskyoAUmWCp92xxZV2nx5OWiX4+gjfxrc1ABBTIzOipcrUkTmtkAReH2hW/17yWt+IJK6s/0FrqqGsGPvkVTIX2sL70Fm3IL4eOD18zaprBQtCAFzGSDE0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOAOtt7rw9JvlbQtyb41TBx8M+OcA1z+AHRwwOkU5tE=;
 b=mydkdGWiXA1s9Eu36r4BHfsmoziwBqd11ZbEeDZ0/YqYOKhU7XXGeD57xlLJxeEzxLtLQkTOTmr7wlbb6CxHBrmVbw72I7GFW7Z8SGr3TY2jeZlSPCGhRys7J6xaj1QH/WOjo/3dQo3hs7fCGllwVJuOV1Yd2pi6rE7Fg3joo4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6300.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:420::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 07:37:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:37:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
Date: Mon, 26 Jan 2026 16:36:49 +0900
Message-ID: <20260126073652.3293564-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126073652.3293564-1-den@valinux.co.jp>
References: <20260126073652.3293564-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: b27c4b78-b409-4b17-3c6a-08de5cadb56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?On8n5PHHVherhgr2jNVUYb3rTmDw3LSzRLWT+jxa7Emy7dsXuGF/k532B1xi?=
 =?us-ascii?Q?o/faHb9V4dG4lU+YPDDDP4MboDJCRi7f/RG9ikOztE9jXlNf12KcD3VHMgOR?=
 =?us-ascii?Q?rVEhsiOisT7OdBWzRmTtZN2HH4XT0B8PpOtKagx2FvJt2003AVBeAAP1a2Yf?=
 =?us-ascii?Q?3OsiwiIWlkYwZFtShVLTYlTXKnr+ZQ/SiriS0Tddpowx4mbNZHeDPetVyUuC?=
 =?us-ascii?Q?SAr64VqT06KmiUhBZwYcuP+YkInanmjnqrj87/ts3RQM9cOSYq4tDrYoAtvV?=
 =?us-ascii?Q?0WIMzIQ6SCSxBGYD4qxevGzJ6wd4GvjJ1qHncT+a/cBUeuy2HxFH+JaUWBPd?=
 =?us-ascii?Q?rYGn1UPFTTwyyCuQkfJj2F30DJMCJpyU9FlQusUdwSFomibaOR4LRQ57My1l?=
 =?us-ascii?Q?wJmmFv0ESriPbU3jTarC6lUEmS1f6HRvVDRTDZvz1rDcAuPT6uvaRol73Dgi?=
 =?us-ascii?Q?f0Y5ADZuUiKTU1G1q4nnOMcWiFgwUDwSX5am8ZQPP7XqAexp6ltgBhlyXjlu?=
 =?us-ascii?Q?M5jtb3S2dwPIUdbTxUmwWUZ0/jdSIQOA/QRTrkLFcIZ/HfvE2Ha8HO+IPtgz?=
 =?us-ascii?Q?C9b0lqg4RVfQ+eui5FeQaq1msz4Mfw3KUTeOaMGNGeZWATCovgNFKpljmzn8?=
 =?us-ascii?Q?pwck9WRULYE1Eg7UFqUK/H8diL1dh2jDJVuZS09aFu0EaEVkZlXVPAPYwaee?=
 =?us-ascii?Q?UgOFBCTydQJ9xpxXvtWR9Y3o3XSdUtYsvuLm5yLDF8cxDm036yGxC0wFXlNb?=
 =?us-ascii?Q?SV6vpP41AmSbNxhnuTPj/5ImgsIVPE0t309Y7m4fclgYwoOxrB9xHGvD/V47?=
 =?us-ascii?Q?AEpwafj0GpFhgfCeFZIk+OTtbhgym19tEl0LcA86O3mwfcV7PsdFyKPPcpk+?=
 =?us-ascii?Q?ENQzozBIZGgeQuzTbb72IUiEvU4DOkYJriYBU+pNqW1ucfNaVUr8/AbVyKje?=
 =?us-ascii?Q?Nj6K2HeV4GB7ERc/7Duo21LcYTYnqg3cD/otuMXxPQ8y8qBjGa8tBEk43+ZN?=
 =?us-ascii?Q?/mGxZPzlvgvp/hl0fQumCx58xeOMhLDdcoJspfA6LjG+u+9S5SZREI5az3VD?=
 =?us-ascii?Q?UKYe06i9dKbpTWMSgs8NoVah5D1fWOXApv+77SPd2cfKkrQSuQQ+NDIFCn5l?=
 =?us-ascii?Q?N9hj+WfcQAYaTbxrrRBQUDWPaZsHs33N55NiEUvy2Q0h8ZZyDJLgtR2wYJYx?=
 =?us-ascii?Q?8ejcC4FQtOcZDMZI2XiTcNkYkCtaHf42d/kt7RKBVBfYVReWEWyg30IcYD69?=
 =?us-ascii?Q?DNjAP4lLvU47gXScn0YKNu0UPgXTwtRlEFVXAPfKoMsufhzgyIG0+Pu2qfaQ?=
 =?us-ascii?Q?ToR8r+DoL0glqUWRjEDR7Kl5BVBpGmoyuUDSui/odpvcSC38V+krjPdYnnX/?=
 =?us-ascii?Q?FRFHt/kcsFqc030hQLki+YjcyOy60Uxdai42sIE6VbDKr3c6Ph0/8W6pDm7b?=
 =?us-ascii?Q?YPHF38e9/lzFV1NSSr1HMFbJWbWo0+ylz0z3g4wSnEZyVfRA1A8u6YvqxtTs?=
 =?us-ascii?Q?WgUcZW37FUm3wQfT6GwCvLN+/YYW9WsbhwFJu3qphpvwELMOlNXhgPCcL9K7?=
 =?us-ascii?Q?5OLBS/Cw6WbqkjF4Peo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DRvoU4Cu4FInTyXCNzaFEyUIffMbFT7BI8zHCaZWIZo7Tv6XCoDEWfcfvbjC?=
 =?us-ascii?Q?vGOw62gzxwOYs/JkYpXCeFpttdkMGYgHs6Bae2thz8w9gWYVpGj14yk8g/cI?=
 =?us-ascii?Q?xqOJfuTJMGyoOYUIGN2al3u88lFfWWyZGQyQkmd3YmpbCajKJqAMToE+OEDV?=
 =?us-ascii?Q?4EYQXcc8JozxMVAEW4wb4EyIZyG0PmWNprCzdjQF8+1g+k4mvIB8TuYeZKeL?=
 =?us-ascii?Q?e3g8tImGnjcu+DuJkuB8PyIB15upRbxuyoKeGCkRl5nqorp7fHDnprIonNHx?=
 =?us-ascii?Q?+HzhPVBWz2D6OcEWkJyo3eQs5pdgWCTW9o0tAPnylRg5C5lhWNKDYS5uxyaN?=
 =?us-ascii?Q?98UjyWbgt23suZJZqtkxHnUhusd5yOZ/P9pCZZGQpPU175cDQkDfHDeER8ac?=
 =?us-ascii?Q?KXUvHaYwwKBFya0zGQuLHhN6WbKFESBgY3yy41ZgFtdG77PY6VTPVsDOvd+l?=
 =?us-ascii?Q?B/Jt7JH7m9GHNctKG4ZMmDCx/8oqACtfM0/Jgj/sRxVAW71AD2aHLTl11HEf?=
 =?us-ascii?Q?TfStfjV+ls0QkhPAuxL7mPiay8XfCluYqhjlc6KIHKPRkNCKF3J44oKsg5vw?=
 =?us-ascii?Q?taBDohqS5gINs356eXsFG8sfjdv1FlorEFespg3/efMpG7fHvItPHInrITKO?=
 =?us-ascii?Q?LwMdyv9zR4DPX7xj7NivqeJUoPcepC/Ai7AMVUYrT2BxWfP0Krt/L8x1p1Pw?=
 =?us-ascii?Q?it8AuKAheCx90IJoBwkrqi8o558Z+1KRhHArmAKAAknm54CVvDEAvb5h6eik?=
 =?us-ascii?Q?oPYmGpRr5biP0RVcLoODMq+S6TILlBUdxFokdlI10qLWwFX5lti8arM7fibU?=
 =?us-ascii?Q?s0U/EMP3gtsGHjWU8juY/u/2xuEYmrPFZkNcTxvfih71h9HpTX0f4t/A0tqf?=
 =?us-ascii?Q?PjUfDPNYbxTzcs5YwdC0PhJqL1hYCHtyXEpQy+sMy2vIHwwYMTNdOlqyke0F?=
 =?us-ascii?Q?S6KaUO/A5smOAUC8gzy7S53HMJ9zWopRhaWMtqq9MSG2G7G3nl+5ZjDpw/i/?=
 =?us-ascii?Q?lPHQJmxTkMMKVG51NeoIAxGuqOiNldLhVhICtlOoASbLaL6DB3SELiEU44OT?=
 =?us-ascii?Q?dAXDMWnXDcxKrFyYzU9JsP55mOlLYQsCFxbtvU43RAU7tAcXeeYrE97WgGUw?=
 =?us-ascii?Q?cWN1Dif+bE1/500YQHzN1aYS9jmJERTDrauJWYXMNDZnZz2TVEiews4M66K2?=
 =?us-ascii?Q?gpKvdxOIQS9out8zKkVa+d4P1JNHf7g5TsH0auyoko1JJ7nE+gC92NYrkz4e?=
 =?us-ascii?Q?JqF76Ejd6FmZjEMTM5ppoi5/qEuLjnY8ebRycU9OcPQfZEGiHp8UKI1AZ4pc?=
 =?us-ascii?Q?Mq9nXCVo2NL2TxmgBmMTTPjP6V/nfvxkiWf/og8JdrgaLieCijETOcxBCFFU?=
 =?us-ascii?Q?tuAVEDjghX8YfrlIBL+cru2GpsBwqwGP3mVBhTO0IuJMO8IiQOLoQwmaDRaH?=
 =?us-ascii?Q?ps5i6vXFunYP2VU5BuPiVBgkk766zvlMgDJ2zbzC6f8r87nUW0eHuecmWkv0?=
 =?us-ascii?Q?AtItY5Urod55QSii60GdleQqorsT14g5R2onLGe/76dgGQF2Ou5/fFtaHWoU?=
 =?us-ascii?Q?0ylyURRLq4fNS8GE45SJo8PWa66fo1r8yfxMnS1GhO4sjJQ6ScimaE+69Knh?=
 =?us-ascii?Q?4jK7SyPTtnWwdF7Cu1PAqnXEXCFa+OBysZTzso0ihtmgoj/4yjMd9w4LPDa5?=
 =?us-ascii?Q?5gxJaPrBL2eEaeSyya+AKCyqO/3ahaCHNUc1S2bEdeOAi4wgsYdb3wK34SA8?=
 =?us-ascii?Q?y6iRHPrI4NMBz20Xr3pBQyJ9snOboRoelodoSXP0FZgoPkoGuJ4A?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b27c4b78-b409-4b17-3c6a-08de5cadb56b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:37:07.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmHJfSytI+Gf0AdTZOxJ8A1uNhwExTRCWqH2PGhfvkJVsEpjuEpyw2Wfye4W1WIp08HOgKSi9JO1znBGvDd7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6300
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8482-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 489E184E2D
X-Rspamd-Action: no action

Expose the DesignWare eDMA per-channel identifier (chan->id) via
dma_get_slave_caps(). Note that the id space is separated for read and
write channels.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..38832d9447fd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -217,6 +217,7 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 		else
 			caps->directions = BIT(DMA_MEM_TO_DEV);
 	}
+	caps->hw_id = chan->id;
 }
 
 static int dw_edma_device_config(struct dma_chan *dchan,
-- 
2.51.0


