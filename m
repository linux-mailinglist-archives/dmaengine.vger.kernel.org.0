Return-Path: <dmaengine+bounces-12272-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fSufEWOqUGpo3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12272-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7C738576
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=Vxs3Ekh3;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12272-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12272-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BB03306CF19
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4943E7166;
	Fri, 10 Jul 2026 08:09:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020099.outbound.protection.outlook.com [52.101.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8173EA955;
	Fri, 10 Jul 2026 08:09:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670964; cv=fail; b=K5P9xIw5sEGZTnbvxl+NhpgNdhKZsBtW36dbw9o6wwbsf8t4JzdlschzAL7oyLeetYSuBpFWkSO3MBZE5gfM5vlcdiNpEwnnuu5c/Le6kEnIEXfZ3UZjrYhLiAZ3Wu+dsvDxah+T1xF1ptdUDBeJp8xcmrOwxPirfFsn89iVYng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670964; c=relaxed/simple;
	bh=na7Hl/1bqiiTvA+mw7LghLA1efiUAW7RGydcz2RqBXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JV00ofJgFcgP4WEoQ8o7GkyRB9wHBt1gTyMCHE5/1ZV6KJmeVVk501QBTl9GDBunxeMQ5AaBGoJr4rpNmQnbBZmSFZRUrnUM5G0fgBPi4mwejYLmkESsPagDU0ggE0/uzZ438h9JwB/lZqT3PkQV8fiMadt9Rw+rPi+EkGPI+i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Vxs3Ekh3; arc=fail smtp.client-ip=52.101.228.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCVrShM9Pqs2ql49irYT/GQugksccbKOkd2THap+WThzhv8rLuyJvgdfdFKDQMQTMvcDo4pZoNUXNP7pNjoJTqpJN2aUp3ZAqEiVvAZ+yUyBjYG4Wq1bLHif2/uqXLWah0qlYXU67ONXbihmeML8ntoZnMn3vjA3CSMGmKh0fSjhIVdIrmlHdSEtvVu89WOgc5mBEa9gfXuM1C34MdQYJ2LzrsloT4iqR3UU3U4f988O9ok6sOOcLjkQGMqBhJF6Q6kTeD6HCYAuzFIXIX2CSv28KZ7h2Fnmr6IlDBPdqjSB+iH5SYukh8KqKLUKuzNTarQSHYOp24AazfDVKQpRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K3c3LnigU4qLRMcg0zSi2MugLZDbWu4CltYvh2Z+XM=;
 b=uODt+/203a7A3hf0sXEA4NIeh28BzuEWB/IxOZxo8IwT9Z8CdcljQkEww6OAIr/QDpNYWV0sN/kCq9H+X4siiYrYCU0lNnHB2WXUigWlpAsqD0xsg5zp/g22r6uTBT1CiP49WNLAFxYKkblVFsld1k3LEwmK/utU0CrdFNMkXi5Fd9LFqdO+evnLn9a8+hrtUglBabxPOFJ3KleNRa2cqw49J3/hxPR1VD7cgvc8CYBSu3ul7WS7NXSC6tRJxT2ZfN0UEuRDZFkeuAiH4PfF9SsxYSlGmC99iJoObbLfh8VndXPR/qECwaagyYt5omvgoppKcVnq0mkAtgJxR3owXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K3c3LnigU4qLRMcg0zSi2MugLZDbWu4CltYvh2Z+XM=;
 b=Vxs3Ekh3y11NpUCsk0WZ7ZEfM1zp3C5uccOLdy9CH5+qxvrYEc2YxQQvm+EsUMncDr3gLQyJoChGfDQ6iPwVVreF0sBPqx/flN53QlK9WzTCinDopyVAyfTZbLeqpTCivLSnJr2G7yS/EzWSAyrjxa0aqNL59UhrP0rc5J/L/rc=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dmaengine: dw-edma: Clean up vchan descriptors on termination
Date: Fri, 10 Jul 2026 17:08:59 +0900
Message-ID: <20260710080903.2392888-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710080903.2392888-1-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0106.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac8aeca-8410-4642-6918-08dede5a86c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+K/bmfCk5NEJrvjc9VvFjkkvbUN1joHX8GZA5UzhZ1TU1tRiF1aQ9hrv+HW8sPRH4yzNwK1UZSI4ss0bFJjU0m28zRUcQSiaZix6bHrVpTebjkrssSb/R080NkYKGn+HhTTCkQjumMH0paPwId29XY8lcta47C3qpYSauuE6cVGc7skeMPYwVrAoIWnJ7Ea4OkrfUgJKrHiLd7qPejrcsT8m34TkGe851gBoR+JRPKq/PmXrttYO9YAMYrrbAnwOF91UO81ElcWqsCNGTAHkockKPblvS5Lk0/SHnBnaWeWPmTFTwvi1hu2BDqo0FXLHjY25pQunPFoyGVsTQ3IU1B+h/aGT6FT+pKLGv8qtTjXh+hebcvODTiOp+JFLSFBUmYwZXSXcgCI8FvnulN1/nhvV7Z5NA9SzOCd9kWKEfFZ+FuSgJFPHmcH5KaYFUC/InX0NKL1J54GVgu0cVBnmxUTpab1RsA6bYmXrcs4u1a7sNccDATBE4yIlybk9q6EhwP0WVSoo/6aehx8YsloWFOP2l+WiKzX9y/9rz4nAsPeSe0+jgUKgO3QgZYdo3GFSUzadlgd2LQFcQZSpXVjzvp5NrkGfpRbH6IsR2Oh+P8J5H69inG2ASrcvpja8u34rpe+HWcgvT+bjyfc4KoSrUi1cvUuAV2isYyOjRiBcmU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oMULJy2ZEhXTRi5b/+QhFvSl3OO0kYyYth2vO6E1Dfx9w3YQNaLw7hllCaQX?=
 =?us-ascii?Q?r5TOwq3D6GXbIFf3o/79oHnRbxXeJwFqD8sIq7Yq5lofDTerjF+u0F1VvLl0?=
 =?us-ascii?Q?qTylHAf60Alquu/WINxi9hPVPa99rsWv2InDU+VyCCHLlZGB4ouRZ6dQRZAI?=
 =?us-ascii?Q?oIXmnmkFOmj9/YC+lx/g54Dzk4sjRzWzmVU/DBjkh2hKBhlXaQmBqcdTGrK8?=
 =?us-ascii?Q?oRhTcoSrWDv15ttg2FVoZOq+PjZVfGeuj9CAygjTOm5dbIoA+YF/o9uhsX2+?=
 =?us-ascii?Q?73v+D7GWeaJDT50yRgRE0NmxpnhHBlxIqT7BEtFfMN8Ov4HdPQ9alN0LE0iM?=
 =?us-ascii?Q?/Psph2ETAVyTT0RnW4H2bY4atlboEctifuewp1IlqF2gdx/Ug/BfxbyeVS0o?=
 =?us-ascii?Q?0uXTBeKXy+CFq5cDeQQXPZZHASL4VAe9OKcLOtfZ1TOoPE1FaDlDUs9n1Dcd?=
 =?us-ascii?Q?oN86/YYC0R/nS40bZQvSUK+qbxfmm7EZGZ2zWwTzyyCfM8G3/jkYg09SwyQz?=
 =?us-ascii?Q?Wex0OVc3uxFiMCKMFbZJi5zdb9UjZBnaoglLG+4SuqRE80gCjA9M4aNFJCg0?=
 =?us-ascii?Q?RSg84i8DinGUrlE3GbJJB8BZ12UgmznHqdXcHbo6Ipf2U+rs7gttiyffgZKD?=
 =?us-ascii?Q?YcPDkJtWfFLRot6/PwQvxaz7T3uNhjWeCbNzeD6ANPk61ZMx6bjGd2RZR3xZ?=
 =?us-ascii?Q?qEvjO2+ivJNV7jYVd8KtgfIdvCiGnZM9OGRNlM7yphrRDI6Xu/A872q5XQvA?=
 =?us-ascii?Q?gIxSuxFBh8JBlrCWfESOF1ADYxQ2t1OcTHSVJxE6k3jGpfTRa5WTvHBJf5Ke?=
 =?us-ascii?Q?cv6ZY8Tq1aViGVfGLbBqWji0+9ANzWYK59G/+laBMBhHR7QSocT/wDAM5MsD?=
 =?us-ascii?Q?hVWUj2RsOmPXmjFuHGyQDgY8/c6BeBuBc9PTETANifYyxhGFv6y7163C60Tr?=
 =?us-ascii?Q?NsRsowDWT88iRodfzseEH9GXeLXBcGu0zLK2c4zlSfflZbOJv5n6TQUIA5Hc?=
 =?us-ascii?Q?/JvorqoedX4Akcf91yEYt9mdUArPb93WKuzeF7xtmfF6T/3CLIrC4TbtXpmA?=
 =?us-ascii?Q?bOmq5C5vrS4hlvYDwzy4ZK8e/pJsKyVHdqgWEezHlgLzd8iv3WQTpUlVf88i?=
 =?us-ascii?Q?BwUguyz+Lq5LnBbPILV3EH74AKNpfvxnW25x199RGIOC3Fa+JF7XtnGgpLLv?=
 =?us-ascii?Q?j8rBXlEwyyps+k0CYx3IJKxYr8zpDJkA9ba/mOWZy52ccYVKSMUexzaVLiEb?=
 =?us-ascii?Q?rvJw1nuXBwMC6LkF12ZASkzyRnMSJc7rbSha4f/uHeq2Sr4jXYmUnOonVrJZ?=
 =?us-ascii?Q?YS000Ilzn/Z5UIlhy4LCjaWnzFXaoMg2vkxVTZ3lZ8BBsl1T/VitpvX/Gu4Q?=
 =?us-ascii?Q?AgLDCliRvr2k7+BE2AGQHQ84PEgOt1l3v05GbcB0ryjB5skNPTAtRkDjiyRG?=
 =?us-ascii?Q?G4zIFBxPzRXZald25q8jPVrJvXxZdOhJMXsd8R1+91tLFA42iRZQOGVicfKz?=
 =?us-ascii?Q?Ggr3UDGVP0hj3jtl+781/ngIOHIsQmnWWmMTjNMegmIdvgzlGfkkB+dXqL46?=
 =?us-ascii?Q?jXM+MdvATrhdEv79wZaLpFXdI69MdbHD1Pk4+BPsDp4DVjtF102DRO/8g+c6?=
 =?us-ascii?Q?x/TDgDBcLqpdC9cPJg8wHgZD8pzCqFw5lWLvxoaslsuJwzB39deI4ClGzQp4?=
 =?us-ascii?Q?4KIydusH6xxjUlvf86MqTmHNGOHbpww6DqOgqISbQYRw5Qhyy+np+Fh66dtN?=
 =?us-ascii?Q?wuEhhK0/h2qiUyZLLMnpIORnBNUOWgu2T+QKBCwdmpz+Qg4R1vCp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac8aeca-8410-4642-6918-08dede5a86c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:12.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsGAWKHmLdJpAecum/XPIR5RiYbU0WJejFjt9LERWJk2ukn9Ghaoce7nvNUywEWQ07ot9ZMvQn/amG2TbqHvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12272-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93B7C738576

dw-edma resets channel state from terminate_all() paths, but pending
virt-dma descriptors can remain on the submitted and issued lists. A later
issue_pending() may then restart work that the client already terminated,
possibly into buffers that were already reused. Descriptors that are never
restarted leak instead.

Move issued and submitted descriptors to the terminated list whenever a
termination request completes. Also release virt-dma resources from
free_chan_resources().

If termination was deferred because the channel was still running, wait
until the STOP path deconfigures the channel before synchronizing or
freeing virt-dma resources. Otherwise dmaengine_terminate_sync() can return
before the deferred STOP cleanup has moved issued descriptors to the
terminated list and before the channel is known to have stopped.

The old free_chan_resources() loop usually broke as soon as terminate_all()
returned zero, so it did not effectively spin until the timeout. This wait
can now last until the existing timeout, so use cond_resched() instead of
busy-polling with cpu_relax(), and warn if the timeout expires.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Poll with usleep_range() (and include linux/delay.h for it) instead
    of a cond_resched() busy loop in the termination wait; each
    iteration does an MMIO read that is a non-posted round trip on
    remote setups.
  - Split out into this preparation series (was patch 04/17 of
    the dynamic LL appends v1).
  - Let dw_edma_free_chan_resources() reuse dw_edma_device_synchronize()
    instead of open-coding the same wait-and-synchronize sequence.

 drivers/dma/dw-edma/dw-edma-core.c | 79 ++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 4e0dc52397e2..1b493c104a5b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/dmaengine.h>
@@ -15,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/dma/edma.h>
 #include <linux/dma-mapping.h>
+#include <linux/sched.h>
 #include <linux/string_choices.h>
 
 #include "dw-edma-core.h"
@@ -208,6 +210,28 @@ static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
 	vchan_terminate_vdesc(vd);
 }
 
+static void dw_edma_terminate_vdesc_list(struct list_head *head)
+{
+	struct virt_dma_desc *vd, *_vd;
+
+	list_for_each_entry_safe(vd, _vd, head, node)
+		dw_edma_terminate_vdesc(vd);
+}
+
+/* Must be called with vc.lock held. */
+static void dw_edma_terminate_all_descs(struct dw_edma_chan *chan)
+{
+	/*
+	 * This order must not be reversed. Cookies are assigned when
+	 * descriptors are submitted, so desc_issued contains older cookies
+	 * than desc_submitted. Completing desc_submitted first could move
+	 * chan->vc.chan.completed_cookie backwards when desc_issued is
+	 * terminated afterwards.
+	 */
+	dw_edma_terminate_vdesc_list(&chan->vc.desc_issued);
+	dw_edma_terminate_vdesc_list(&chan->vc.desc_submitted);
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -313,20 +337,25 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
 	int err = 0;
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (!chan->configured) {
-		/* Do nothing */
+		dw_edma_terminate_all_descs(chan);
 	} else if (chan->status == EDMA_ST_PAUSE) {
+		dw_edma_terminate_all_descs(chan);
 		chan->status = EDMA_ST_IDLE;
 		chan->configured = false;
 	} else if (chan->status == EDMA_ST_IDLE) {
+		dw_edma_terminate_all_descs(chan);
 		chan->configured = false;
 	} else if (dw_edma_core_ch_status(chan) == DMA_COMPLETE) {
 		/*
 		 * The channel is in a false BUSY state, probably didn't
 		 * receive or lost an interrupt
 		 */
+		dw_edma_terminate_all_descs(chan);
 		chan->status = EDMA_ST_IDLE;
 		chan->configured = false;
 	} else if (chan->request > EDMA_REQ_PAUSE) {
@@ -334,6 +363,7 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 	} else {
 		chan->request = EDMA_REQ_STOP;
 	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return err;
 }
@@ -680,7 +710,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 			break;
 
 		case EDMA_REQ_STOP:
-			dw_edma_terminate_vdesc(vd);
+			dw_edma_terminate_all_descs(chan);
 			chan->request = EDMA_REQ_NONE;
 			chan->status = EDMA_ST_IDLE;
 			break;
@@ -862,28 +892,49 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	return 0;
 }
 
+static void dw_edma_wait_termination(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
+	unsigned long flags;
+	bool configured = true;
+
+	/*
+	 * dw_edma_device_terminate_all() may defer cleanup to a later interrupt
+	 * while the channel is still running. Retry until the channel is
+	 * deconfigured, which marks that termination completed.
+	 */
+	while (time_before(jiffies, timeout)) {
+		dw_edma_device_terminate_all(dchan);
+
+		spin_lock_irqsave(&chan->vc.lock, flags);
+		configured = chan->configured;
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
+		if (!configured)
+			return;
+
+		usleep_range(1000, 2000);
+		cond_resched();
+	}
+
+	dev_warn(chan->dw->chip->dev,
+		 "timeout waiting for channel termination\n");
+}
+
 static void dw_edma_device_synchronize(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 
+	dw_edma_wait_termination(dchan);
 	vchan_synchronize(&chan->vc);
 }
 
 static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
-	int ret;
-
-	while (time_before(jiffies, timeout)) {
-		ret = dw_edma_device_terminate_all(dchan);
-		if (!ret)
-			break;
-
-		if (time_after_eq(jiffies, timeout))
-			return;
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 
-		cpu_relax();
-	}
+	dw_edma_device_synchronize(dchan);
+	vchan_free_chan_resources(&chan->vc);
 }
 
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
-- 
2.51.0


