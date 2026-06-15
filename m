Return-Path: <dmaengine+bounces-11524-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6hAZFVweMGowOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11524-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E66687D96
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=UOdPCMm+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11524-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11524-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F30030FBFC5
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30B4071F4;
	Mon, 15 Jun 2026 15:41:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFAF401A3A;
	Mon, 15 Jun 2026 15:41:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538092; cv=fail; b=G4hU56lV+ZFZXKAcfoGVnwZbG9rtGgsu8ks24NaAePqiQH6oasn50csKTuJ7uJFc80R4qm0rrd7Nl4xmZWElGUTgxtrIV24UelrTaJjaOJJHdqMdk+WZxSetM5d98x5Z1Vkstwjq+yGkTqg6SUm8RV/5w+F9wh8sp+AR4IMsR1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538092; c=relaxed/simple;
	bh=dbXekdKvVFm0Qzji30MqCGdcpDjmvbq2ypt0BpdlnEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejLTAEY/UPd2x8hDP+K8glnguuX9Dyl0rQAstL1arbknMYPFMjOVlt136S8Y0faJG2X5PfwXIJvMvLT7qclYdgLHB3uaUBUs+UBavXn/gLzmnjkzMlnWdf+9+ac8Es4C5HCe7Iu5Ky9kO6NiA+JGSvwEe0Pcucwp9CrzWB5HyqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UOdPCMm+; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7SeXFp3t59mSQLS+1Rn7i97UgiK9khj08rjNxvdLVPhuALzS076DN8sSi4xTNXJM3rR5JCuNTzp8exWMxOk5x8OIUDh3eKpE6jlFMHevw7ivmJTc56qZf6NRMznE1kPe6wB9TlW7b4nC97o1EG/e4eAHwLMIjELX4y2NYiz9r3Pof2QuxhUDcSbJvcJ7nC4yTUBC18jaa2rSMMFttrmg90XKEceuVfRWDbrIus+5NPtggpXONKRmCVs5IqUrwAyph9+5nb4DzfnJdQ8V1SAB5TzyEjZTJ0svw5tIfjeHGL+hUfLth1mvED/AEKR9SYssOWStDZByM+sfn+AI9LVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SsGjy/5LU4K8dnxuoKo68xHa+Kfm4wZ+9KSZoDBP2M=;
 b=w7fy1JVAGX7GusgXN/bn0j6hVHjmsJUtrzq4AJ4TRSl4rBGOGedMI6JPHtX95cMAcxl8cVasBi1jLiaess0YlLot3SxByBvV9IKpJb2Nah2v7/d8MaWJQPi39SidgrdAxVZJoZQnqy9rIQxe2+U+MqTdVQlRe1Gg7RXuo4LuuaMHim0bfUwKQimVmw3vmqFJAcfAi/FhMdNTEk4NxYONE4oyf5AN46jSIdsaGfF+TzbBxfCaiEwRC55bbJ4qN6yIxGpYRbhIeJDGM5AAXm1rv++Bn5YGtW6cgeH5yHc+op+PjdHfHLVPPOD1gA/dzQaHTuWMaeg9moG8RM60vCfcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SsGjy/5LU4K8dnxuoKo68xHa+Kfm4wZ+9KSZoDBP2M=;
 b=UOdPCMm+0PHC7ET4js+kK24UR0qgdPuwuBAWmqHC+ZZg9ktCupcy5UwGznk48ZWNhEW0zqox0Gay8iJ8CEzoBNMo48GIJValZAuIrVcM0w9WBa3WYlWTiHKConsyVYvYWLvktMz3D5M0QvtCJaqbnZb76Ur3FEzwudS+VN6o+Os=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:24 +0000
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
Subject: [PATCH 03/17] dmaengine: dw-edma: Terminate STOP requests without callbacks
Date: Tue, 16 Jun 2026 00:40:57 +0900
Message-ID: <20260615154111.2174161-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 70704542-7b8d-428d-6ec2-08decaf48e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	OH0HnX1+Ye8mywhGWw/N7R8MgB/AKFRNf7ZjD5pZ5u57iq4vlFRuUtc6RQyVGbaqrnNvb37dEqUXtMzT48zvebsM5pGRNmQN/M2O1fqLNBTY1dfAitle3H8w2N5v9NinYaB+UW/gPy+8uZK/1XPG6xgIm6MPhjnIcCHCAQZ6UYU5ZKJ1apA+6Hg0PBZrgXMqK/gTZtjpZwqdYmsnGHZ0j3KXQnjLpASWZy89PIVhgTs/UIH259Vl/OOUssabliwlhl3zOFlvltsEnvsUVs+3YS+frl5F1lB3XbIxJNKC7yZHg52eM7bXMYDz4WUtDJXOstGT5v+Hjw9fxyCuTCqymT0E1STq6xVO09sH+iF9tV/4WLJmt1kHn1xuQKLQPbwOyuqEEuGwMaLaAH20sBXWtgItymfON+85dZG5+cdInGI78uUzmqSxdAcsAdwQ90MxDQFiNhlde+DQlecfhZa/Xey2cdePTW/DGFSWJo2lj7x28LcdmicUR7g/FCI4SSbXWoi/2fHhvhLZNDP89a5q+cyiNGHQNpu6K6b6xMzXVl9TghEWHKMW2M7gnjehOnTE+IDp6KKibiuxKTVPVb1vN2eyKwzjlddtg7j211Ru9BONlCfbKS6GIVUJpqUAJtZ93qHsLFv/yg80LbnsqyjSbMnf3k+jyF1SvptxrTrweud1m1NO0aQd23hB13VRmZfFUSl2a0OAntEvHUA0it2ZOx5n1w6l9EY3Z10XwXyVSQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2lODNiW9COL/6b8fwepSoHdddqFjwTv9uQiE0QVJIHvZNg0wV/ZxXsi6rG1?=
 =?us-ascii?Q?0f8i3lNL/dO3xUM2CsOWUxFUtD7l6LlklTClmalatboaY37eGl9h4MTa8LPY?=
 =?us-ascii?Q?Diz+VfPhMsLBK6Pb5qP0ZsasEjtlujrJECUac+RkwrovZsBe6/PtGr86oWwu?=
 =?us-ascii?Q?A4f8YC46WjEhoZqjp98hZWjym2JJ77wjHnVOM90kaF00jGUF5K/QpT5fMdBW?=
 =?us-ascii?Q?lA377k+bSDsUy/yFBWHifeQVt81XYnjgJejIhdp2W4PoW+EL2ZQ/mMKe9jMV?=
 =?us-ascii?Q?be/msWyXX1mNSvSHKRRAslfSKnQiB/hzAjYs/sSBpwgXPhqOiovCw0ZQOT8a?=
 =?us-ascii?Q?QFz/GU9MHah8nWu4mxy2FVrtcPFRPZpnDnCuVVMXGfJ0DS3YtzfJmQhgqQAW?=
 =?us-ascii?Q?HN7iKWTz/XNdDUFUkogVwngw13EbUEXSVV9yaIXduS12t5bHKp8iv4nXIkHI?=
 =?us-ascii?Q?En9wfwtTQazagxtSQDOpP1z5yWlSzcFZo/e+Vawxpi7cN+0uMV21MkAYcId7?=
 =?us-ascii?Q?tSiM1b5sHGYGxF1F7jNXroy6ZFjBylQkKpUBzJRBtUki77ncN6aS5DyxbcHT?=
 =?us-ascii?Q?eiY7sG9GioAWa/EFCiByKTGz01hREArQ80LKqeIKGsHPgtzhj5Swwzw3ORR3?=
 =?us-ascii?Q?we+lXS6dpnsgdpAwbBPp2zjY52prxAHsv98qtxt8TFF3Mfr4ylEasPx8AvLL?=
 =?us-ascii?Q?GKEFWtrIxJlbInI6lto+bJ79Sv+jlIIzFD2bFVtIivgVq70wT5VpnGOSdliH?=
 =?us-ascii?Q?E6AJwnYVL6GRfy2QL/qTFY0NWpjda9BXUgA1IY7H2pEJCowDP7MftQOuAA+e?=
 =?us-ascii?Q?WBumNv419YkIUxttSsnN6VUt7txfND0lgdnT46YYUp+rwIYWiaFFHctbWwkn?=
 =?us-ascii?Q?reH4dZsn0lmxltWQgsLhWp2kVi1GPIG1KHWNJwKFdGZGZc6y19SaOw0kxpCX?=
 =?us-ascii?Q?KfsfGNaEQpOdFy9Mx4QVpHf9nakyDKCLFR8u+6NsyXKYX82lRxwBnqgfnM9t?=
 =?us-ascii?Q?ld2eZPRCz6sZ6A5b45ebKPgQDmPWmn2ciVQwrwnV1GHBHyhqNZrGj1mk333B?=
 =?us-ascii?Q?nU4+T3/lspbv6YR1CcC2CYyMWySXqgj5VlN2pE40A64keyjaP8NoZ03ws35Y?=
 =?us-ascii?Q?9xx5kRRWWfmDOCBKm3gQkUeJpROaH+FcnemMWx4g+CMPv/v9AIh3OLytANig?=
 =?us-ascii?Q?RXEplJKiQivv014DP2msP+oHJLslUe4c7Hn4g7dA4zDkvUm/FzeQ3yyTUcFi?=
 =?us-ascii?Q?WjepVEC+DzZhf3IjWqzQBZOYgmHhr9c7mOaeet12xuKWO7WgjYHvLXd1IrNZ?=
 =?us-ascii?Q?K/nPNc4z4+3JLElfyQOaphvAOD3P1GAA44DdL6qx9J6sG2stY93SJ0wqMmZ6?=
 =?us-ascii?Q?9+qHLS0bEdiHHjQ2FABe1Q7oC4Xy/COed+07c18tqmGknCKbgYEEJK0gPoNl?=
 =?us-ascii?Q?MpPcQPDv/3KNJzDXZP9sQ3rycUGpeMAD7S6YK4sulpzxBvbj5nyhR4Khaxmh?=
 =?us-ascii?Q?pIQEZs1Wl+6bQYdve3JwfpeZcarRiYuuk1+2qjdlF/a2BfU+lNRDvcU4CbXd?=
 =?us-ascii?Q?fkNzoiyCTwuPaJgslpAeoJnqcCRn9OjQYwbyhDDvkMLnWLEdyeXyQJm/dexK?=
 =?us-ascii?Q?53VMd+0o6mh5fZNo8KwkfAzkI9oGSXPZAyxdX2gMTd0acqi/mxebJHL48lpD?=
 =?us-ascii?Q?eJ3mw6Qoze8k9mryqvd+5R1usu95qqeptBjIu2v1EKdzKb8uUqIR1xw5O9Oa?=
 =?us-ascii?Q?mGmh3Rc6Yo9qxcn1Jn+UPCHV2HwNTDLxH7NlU2Ndlojwp5Xp8GAZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 70704542-7b8d-428d-6ec2-08decaf48e55
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:24.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEEjq0i3VDcfxHNe8ztDKYr/V6CgT0EoefouAP0oFNdOiLDVXV75iDMVegQmLDu92ynl02EjSiQUaG70C62T+A==
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
	TAGGED_FROM(0.00)[bounces-11524-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9E66687D96

The STOP request path handles device_terminate_all(). The DMA Engine
client documentation says in the "Terminate APIs" section of
Documentation/driver-api/dmaengine/client.rst:

  "No callback functions will be called for any incomplete transfers."

dw-edma used vchan_cookie_complete() for a stopped descriptor. This
queues the descriptor on the completed list and schedules its callback.
A late callback after dmaengine_terminate_sync() can dereference
callback state, such as a request object, that the client has already
freed.

Move stopped descriptors to the terminated list. Complete the cookie
before doing so, so cookie polling observes that the transfer is no
longer in flight, but do not schedule the completion callback. Add a
synchronize callback so virt-dma can release terminated descriptors.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index d99b6256660a..bedaee6d30ab 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -106,6 +106,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	return 1;
 }
 
+static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
+{
+	list_del(&vd->node);
+	dma_cookie_complete(&vd->tx);
+	vchan_terminate_vdesc(vd);
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -537,8 +544,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 			break;
 
 		case EDMA_REQ_STOP:
-			list_del(&vd->node);
-			vchan_cookie_complete(vd);
+			dw_edma_terminate_vdesc(vd);
 			chan->request = EDMA_REQ_NONE;
 			chan->status = EDMA_ST_IDLE;
 			break;
@@ -610,6 +616,13 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	return 0;
 }
 
+static void dw_edma_device_synchronize(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+
+	vchan_synchronize(&chan->vc);
+}
+
 static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
@@ -723,6 +736,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_pause = dw_edma_device_pause;
 	dma->device_resume = dw_edma_device_resume;
 	dma->device_terminate_all = dw_edma_device_terminate_all;
+	dma->device_synchronize = dw_edma_device_synchronize;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
 	dma->device_prep_slave_sg_config = dw_edma_device_prep_slave_sg_config;
-- 
2.51.0


