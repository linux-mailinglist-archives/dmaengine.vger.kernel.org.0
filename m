Return-Path: <dmaengine+bounces-11527-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DG+ZEZceMGpXOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11527-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:47:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E73EC687DC0
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:47:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=UCGCkBjU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11527-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11527-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B568316C0C5
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B919407CDE;
	Mon, 15 Jun 2026 15:41:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4B4071D3;
	Mon, 15 Jun 2026 15:41:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538095; cv=fail; b=ZBsrhpNfPeXYrRJ/HeJWEhiw3kM5okcniBYwd21z0Pz426k4QgWTmuSZm9fPi9Oh9jp1uMOOUxDlNuoWFt2ZGzrO6z1fuKQ0aq9jg2/DaRw41big2jMZkN6gxzN7qr7/jw4kRPwHrc6Rrz5OO5WAoguR6Tq3g758vw4zKb+mm+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538095; c=relaxed/simple;
	bh=Sk72BO3ZXHX9ABqg1x97jxhDB3DM2CnJREBmTskK4t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1okaz+p0OlRCxLTfllthJBS8TnHyTQo4E61CiN9SDbF94WGj5m9tztQpa4RsFS/HYDBNfH20sgc+PavhYRp8FWvupOPt+zyp7ky39jcBNHK3qs+R1Ry+AemD0I7daSL8+j/b9gEUN0P1d4mw1M7wXjA7vUgY1d9b/9Btf/Bogc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UCGCkBjU; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2soB3ge7S/KJD1oZqMlyXObqzuNzw7tnaPqTi8sbIzFAAwuucrFpFrlIXSo4JGrb6igS8JxUJxqtNHu1Ij31undwW8IS7s9BFKqvP5+lmBPONCl0j8XBipncmIVMEaMzjmGGEkKsltt0oAALOs0u/rpUOYQ5Fzp+r21fGPkWJurDNQU6t7HV+UEyb19VKqTxkCYtgggbt+x0E/+WZKpF41STijIZ2g8hqc1iOjLO2R1sta46hUdZcqHCnRJgVte3ww/7Gt8755b4tuQZCS7ZmaQS2pK10n2/b48uXOwKF47N+XbfG2s4bOsAoSnhc2UxPRJlCAqADACjB6ebsOaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htQzYusiIXl7tfyGP5kg/3YtYrLX4a7CjDrC6hOEEy4=;
 b=YZGfCF6TMsvbqfUSPUohZJyqiQ5HO5G+nBlbDbGcr7YR9/okNsUp6Gjvl3UDNd9WGWc6MuvgxcIdVr1wBbqY91qZw1ENg2Kgll30+8bYHRhrlIkjvMvNLvyU9ZfQy9t8TBTdrTSxDsgzoqlaeWeLf/RmaSVr5bnYZTTHNLbHESVto+duy74fmqQa8pd5DdRBQJFpBXkImfEaCQEfxOM8qeMNzO6/N8GO5KYtkBSC5+NGuzLVODu3/PaM+hxoezRKbS0Q/7HMQ5WSf2lgRxEgM05rgRcJPeLGWfX7/NuMhBSR2d4zEKXSDZvRT1kBH3v2CDAyb9FT3B2jJa2OweCGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htQzYusiIXl7tfyGP5kg/3YtYrLX4a7CjDrC6hOEEy4=;
 b=UCGCkBjU5dubmT2BkeO7NDIU23ygYazGBAyzlDPIOd6KBzgUtPtIL84Z2yv1g0nITpzIEhGGD0/tq1l+Erb7wnBNFV538U3EoY8+VchX6SyYvYFqoVaKfBS7mNxFz+vUGGrfT/t+WBmP8YFqxRSh/IbAjhSxMUBjiZ9hcSKF74w=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] dmaengine: dw-edma: Serialize channel state checks
Date: Tue, 16 Jun 2026 00:40:59 +0900
Message-ID: <20260615154111.2174161-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0115.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6822e9d9-9d9e-41e6-3e69-08decaf48f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HVCfqH5T8+yxi0MkEobYJa3dENc4DlEtIDhjnnnVRcQyAYLcKHk7E0VKuCi+oUXrd/YQ6WXBMXdkU9XCYGFzdcgifOZo4yHsL/Ra8/XXJIsq7gOQYh09AWlF8bVCGwHM7XX4RcYJ7oiA4t55Mn5ARN69VmvBNtlHbrMrH8yara2yRDv/lFIUFeEZ0v7mENgjS8GYYM7zh8kQb+EBGUORYQmsbuXxgL0tNlrOXlgMzWMTxydA8DNOuywBjwfK6CHrNj/nug4C8U8haSlVQk2W7Dpx2BdesauQvy6h0FrYWb4ihjsXbrj2P42xUMT5I56Wu+rHWRFxC9+KKfk8V5MHwAthMh+F5yltxAQ6+dfxONY9Exh8cc/MUhy1XXfFLNgE9i0vqGvLwC+5iDB1FW3OJBJ5EbCXrCheqpm8nseDqGYC0CtD8bOuifu951M10lyBqjNZDGySYew8FT8OOH2/h/ZsKqbTrixEvLNRC6wdOIBynXfK5Vjf0C0EghrOd57BY5V2HRMx7Qy7tSYoZcR6Zl2ybCazTEaYFieLGtqpb3PPzVx/o1Sa02UE52GBephIfqEP3lIiElBfvC02UW3eQgxptcBEZZFo1ciBKg/HoflzH7UBmY5+2Dl+xXYRuPgk2oRFp0/BntuZ2bMfTIKRi+oCGmrnA7kcG63oRZ05nnOVxYkhmT9YfWgDgIVYTuk3gwEwzLh378cvs2EwNLziH9+iIxTROiunKPKY23ArZmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AW6ITPzkl3xr0PAB1sY8Tc9FzqMzrWVaBRkn3G5Ozo0KI0w+z5T539y9cjac?=
 =?us-ascii?Q?3SdB/+c458ffE2GP7H/MgnUjRKcv7FRUYTd5Popg1ccrr8KAJB3X2Hx7UKmq?=
 =?us-ascii?Q?I51sWKWlXhjY0UCsXxZzQZ87L8E4yxpeplTJ/IIeYqlfhYfX2i2q5nn5Eb8y?=
 =?us-ascii?Q?RlxMvF4WSSSiWXacVEr3eLLkOSmm8A5PztFv788x14nTKpQvQvuYiCCUy3gD?=
 =?us-ascii?Q?/ByWxMsRg+1wxJ3++a22qes7bjJarf285sAXDg93vN04Ly8kfEyIaV4evvMl?=
 =?us-ascii?Q?gy1uIWKUJj6CLrC0BHUIC7/CpaMM2zMeQjMiNjjPQPWD95FBfUT9+Hvyojz8?=
 =?us-ascii?Q?f7hXhbyLsxDgVzAOuZqop9o1WAx8FIAYROlPlCLmXmxeuGIA+nV4otlPSrlf?=
 =?us-ascii?Q?fwQNdWS0W2wg4IIaU8Uqhuq/PnpjbU3jgk85RiPh+ci0RDe+/CPBwt+58Vv3?=
 =?us-ascii?Q?bwWmvS9L3apKQ3UhgHkMlRuWt6t1BwK6D0hWuOezRnRoh+JPG5zb7wbhcIEN?=
 =?us-ascii?Q?R1bNSDydVBqIh8hVfoPkVsdhK/d8aIgozN0GPlqknBkz6IbsIwzNHajklWp9?=
 =?us-ascii?Q?CzUFP9ZWrDniXM6TQON1ABZ0WuMtoTGieqbvhler6Jcxyzg37+7TXxjmYgnl?=
 =?us-ascii?Q?3A7XtbkiJBCZXtFwBg6jgD6LOoUiAd7qEeLhK/Q+jt9Ye/4g3PSFSQrUaCJk?=
 =?us-ascii?Q?3YiHPZ3kiYPs9DCXB0RCzaLG+XshLo4N98FwreizGTsPt1Zvf3J3hSN59X1A?=
 =?us-ascii?Q?qZmrEd3aLZvs0JYAxXAS+uvGl3ziap/I3BYfNhL7ru59NubVGM+HSVckvLXu?=
 =?us-ascii?Q?0v6kVpO551ytTBGpLIyiVKprochmXP2CXo09xN7O8OMrcqPqLA6sFBLwKl1v?=
 =?us-ascii?Q?ocY5e/z/rDjl9veji5aiObuePhA+zEW0CS6aO/rt0tXnctwgcXIvg7QgQokX?=
 =?us-ascii?Q?IErOpN/LQeOburPkX43vwMl7KyI7Qe23o3WGg+AHVnaGAjhUD/MBUWEJg1dD?=
 =?us-ascii?Q?a7khZvIg5M8pW+U/NT3qbeBBqf64F5aROoj2npYLQbcpYv8uMfhJzwoJpK3K?=
 =?us-ascii?Q?y4Be2XKvMe3YRUdoCZW7hBNew3X89xEjLo0aUSs39dPjJ+iSUVoLjDz/s4Qt?=
 =?us-ascii?Q?Gv9HobZ+23ASSo/tg4WtxvsYdNFpC1J/CfGBI0tab9SZql9SnrypVa/iWgnq?=
 =?us-ascii?Q?92tTdxma1gdtWNNKg1JOXqm9T6d0mKAeptlUVQkK11v6RCIxjfLoJUbGM5fQ?=
 =?us-ascii?Q?1P4Q8nA7VxI96dwp4j6jS46l4iUmPFQ1s+lh+l2rZOelom8VjYvUA+IFnr31?=
 =?us-ascii?Q?6r0Nf3uia2xxxPJN4Hc+uCJyEm+aa4brFdDVVopGhDyIircX6ytdggxaUtTd?=
 =?us-ascii?Q?AbQO9UjLgwR4bZECwo4OxkYMHnBwTMujSmwpg6Y0f5Dil6DpgB3DgJF7vuXZ?=
 =?us-ascii?Q?l+vZwdncX6RtQi/Y/4s63kAmtGhp1rg4M5Nz+lLit/IJ1j8IJw+cs5maleSE?=
 =?us-ascii?Q?S8dDoBJK4WsyZ9wWQoRJNPKe8PJxQONPPaVHRYRfRO7Z/v5GzJa2KoEOyZR1?=
 =?us-ascii?Q?DKaD5uD8X92OWD3yPvbswUWRApP3aPL34XpYAy3JMzzOKmaBUOF+0iZNKw5B?=
 =?us-ascii?Q?u6us5I3J+ykRYVP42RGCoQ5EsB8WEAqkuE/HjLW4Zvg98JF//QfLcDqWplL7?=
 =?us-ascii?Q?5EH+U96pdQI8q4rbDBPdZpxRzOdknVAVbHd7d8Z1ktG4FkQyeYenlEIZyhCG?=
 =?us-ascii?Q?7f+QZwcST+aIEYLQXH3ae6JBTskJVLs98gERbgyEj0DNrKSdTIhR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6822e9d9-9d9e-41e6-3e69-08decaf48f34
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:25.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPEoGwq2faZMvixY9K3vMtkOkh+zaEQBSSfpE6PTu6aX2HAaQqM+LNnDYj+OAQjBuXbyH2wUyy5YFe6/LtjrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11527-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E73EC687DC0

pause() and resume() read and update channel state without holding
vc.lock, while the interrupt handlers update the same state under it.
Take the same lock around those state checks so that request, status,
and configured stay consistent.

For example, pause() can observe EDMA_ST_BUSY right before the interrupt
handler completes the final descriptor and moves the channel to
EDMA_ST_IDLE, and then record EDMA_REQ_PAUSE on an already idle channel.
No further interrupt will acknowledge the request, and since
issue_pending() requires EDMA_REQ_NONE, the channel is wedged for good:
terminate_all() leaves the stale request behind, so even reconfiguring
the channel does not recover it.

issue_pending() already runs under vc.lock, but it tests configured
before taking it. Move that test under the lock as well, so that the
decision to start work is made against the current value rather than one
observed before a concurrent terminate_all() deconfigured the channel.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2777dc0b2aed..489f7fe49840 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -177,8 +177,10 @@ dw_edma_device_get_config(struct dma_chan *dchan,
 static int dw_edma_device_pause(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
 	int err = 0;
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (!chan->configured)
 		err = -EPERM;
 	else if (chan->status != EDMA_ST_BUSY)
@@ -187,6 +189,7 @@ static int dw_edma_device_pause(struct dma_chan *dchan)
 		err = -EPERM;
 	else
 		chan->request = EDMA_REQ_PAUSE;
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return err;
 }
@@ -194,8 +197,10 @@ static int dw_edma_device_pause(struct dma_chan *dchan)
 static int dw_edma_device_resume(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
 	int err = 0;
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (!chan->configured) {
 		err = -EPERM;
 	} else if (chan->status != EDMA_ST_PAUSE) {
@@ -206,6 +211,7 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return err;
 }
@@ -249,11 +255,9 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
 
-	if (!chan->configured)
-		return;
-
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	if (chan->configured && vchan_issue_pending(&chan->vc) &&
+	    chan->request == EDMA_REQ_NONE &&
 	    chan->status == EDMA_ST_IDLE) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
-- 
2.51.0


