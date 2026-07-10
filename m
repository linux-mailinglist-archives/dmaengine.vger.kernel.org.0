Return-Path: <dmaengine+bounces-12285-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2E54MXGqUGpx3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12285-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E973858B
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=K67sQeHY;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12285-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12285-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE30F3037DD2
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591E3EFFDE;
	Fri, 10 Jul 2026 08:15:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E273F0744;
	Fri, 10 Jul 2026 08:15:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671338; cv=fail; b=Sdhinxa1aktUS6xAxjZAqxirmvxTN3NN+5Du0tKfxgZ5aCcagYrw19LbWTSK8+QdZ4LWksBiMqD6+mwEkr6xR4oXDgnUdM53uoYJPagjYxZEGCVfoP7JNGmEY3aKSPeyEY4rOx0topb7o6Nep+ItV3tebvcUuxNcE4nqBgZZwa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671338; c=relaxed/simple;
	bh=U1gW0Cmis/dUrqFBi/K4J2fVNAqHyoccpO06glM66Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICq6kguMPdU2huPRbvZfKW1+4AE8oEK+p8REaYdPnxaSMtk8r4Qh8OG2kwUPGH4MKgeKYQOLluJ0ISM0DQaSAMq1N6FRJs6V485EaLKpr4gnZrvlPltulrTnnavrifa6wnSQcXZ5BsKODteY30lf7YWFLFUJjsQcb7+kTH6A7kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=K67sQeHY; arc=fail smtp.client-ip=52.101.229.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/KdKsnhx1+9subHlpO+60KESwnYeZ1hyTMPUNFLtL1rk1IW5KUtXEwGSjH9Vr181G4cRN40RvCxrgKlh3qqYXrZPsRIHLqjY2q4ftoQZ8WPzXHraiXxMsFvU/VaGKfmXuK2XtF8LmPOogKDW8lbI6sTP2NbvvMUaeBhe3n5LdS1cd50dWRdVzRqWkxoNUZqZSFoty/rOEcNVSbAJGjIdzn2bFoEMH4MtcEW7821ElzkWh3wmpoJUfdVZ04X+xce1jTmsoax4I8V8pS1lWJ1S5BlrcTXKZWnBcMxmaRnpPbkbfgKdYvTwY8c9jrp/OWnu/16pIYHLgiUIucNGU8fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/Y55Puc6OsRzJPv8/5TRpmxL6Ov7DZ/7saBpzy6NIM=;
 b=deikwjqTl9h12IfxqFlTL+Cws0zqssmKd1um7OPC4Oy7D3MtuoR4oL/I/XYxq224uDW1EWQZQnt2p0t2H3gz1/6bP1g3iU8h9wUeyljzfXTSlTPAKT6GyvExHV2hLiSlfll57c6y8L+sWm0seCbI8JfHN7ny5sRJjdIX4dBMxyz4BdLcU8XxmRnpDHtRsQUmVfMQLnDS2IzJ8MMXfTN00D2IpnlmFVPp8sCUXUUQSKzSss+dXAkb7nOwwmUCSxe2p7UuzoipmLmLQPd96F9TO6kUbGrF2Bd70YRiBSxEkx8tFj72aKWv6+YDWp2mrDJ17cjb0ssuyYSChA/mvA8VAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/Y55Puc6OsRzJPv8/5TRpmxL6Ov7DZ/7saBpzy6NIM=;
 b=K67sQeHYvo+VY8W5sG2V04AbistHtebL1LdHMq5JolLtdFleGXJZSsxBdrOlQ1Tw/wu0+U2xR4KXUEg4WGJ6vTjzhflkZeMcmElzpLmWjVy3CRf3hjw+6WvQI0HiPN2ggOXyer9s+/MdKDUsu32MIj4i/mwQe/kIy6TJC61DjVc=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/14] dmaengine: dw-edma: Add partial channel ownership mode
Date: Fri, 10 Jul 2026 17:15:09 +0900
Message-ID: <20260710081518.2394357-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 948a9032-2f76-4e73-0898-08dede5b64be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|6133799003|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	7QSFMYShTum7b4ZwZmAyy44fKzW9hS1PfK1MT/+/BJsr8dnomXkYHJ9QPMBZLpvHk/dg6lFcTjQ6IRIYfXguTCIb2/yEyPtLiELC6wztUs0WAgR3ReSVyyACYxu13+LPfKxIFEn3wyBW6otbnv43MAwQ9JFpVLRklhVpSK4ApHSH/Y06lprzKgzb85aE6ZcZiPn/uzGBs2By9cGFdBUWqViAvU5OJiSltopI+c7BC3Gnjdr07lxv99lA7t1zQ/buUYcs4aUMgviAgL6Sr3tx2eUauDfz7PAjzPoF1WSbvnrOJ6flLbFcdHWlXmJ6yzR5z+MrG7+gGpJ9G3ZdvzDuaGwpx7nshQXlh0nNKEhrxyKZSDP3I7WFQgTIjbRxzcrTCFbC7ErxL7hi4zw0f2D84E25+z9ChDytudPhVhEhybdJyfmLjq6+YsLAK64rfvelPoKzjmRGm8r3g7okVBOx7f3C4TFa7aHxXga9ZNGRqmynS1n6/R5rGC1REA1/BvcrXEuqQi0yQ4vfPirj1PVtpAqvUtXxo0K0iQsTTvhAq1RPNSmtaWyvnSZv2C3Sq8zSXfXUW3g2xYmUoNMgJuarRQT6DOa1SvjzRFSqKk2rJ/5DZkpC4ESStn0Of8Fe+QWpdZ5dV2qHp7D8N+MmANtDAoMXhSw57KMxFkF9SwZXF30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BcL52Nd3YTQuVPfXpLN9yBiKUUJQlBSnX5euL0kxe5wzDnHjNv/vrDDuEkEe?=
 =?us-ascii?Q?dAHCN2n28NSdArCbetgeM5Tg+6VhCSVeN426NCYUr8EN6vSfF40Ld2n9IKtO?=
 =?us-ascii?Q?jdz2/WmtaNIYd7oS5a/t2c4W5gN4rREbZk0BBuxwpdn59ElH5P2TyM7iDIor?=
 =?us-ascii?Q?2VJgFo+VzgG246Kd2bv/4NDsOBUhB/aQmPAYP/138SKB1TPvMEaB6tQQdhWn?=
 =?us-ascii?Q?xgs+CYrT2OEhCOcRbdyO7osE0FasYysFnQ0u7fuxYGSGP0hi+UASnrLINU7C?=
 =?us-ascii?Q?vzok4PXT1mevk6unwj/UfBi9TXYCJtRja50/NX22hiUUCNA4/qHXfF4quijV?=
 =?us-ascii?Q?ooIEJCdvOHnaACCs7YFHP9+tJfBR7AXTXzRs9sGIuD8JYJ/nUJsYPGESl0Or?=
 =?us-ascii?Q?2W/V7m8OTQdRnBDpe34hdT6W0yTwBzxvvVldzf1JS+sKHWvrV8J6xcVBJmlT?=
 =?us-ascii?Q?CXvGq+s/bXA8sqXko6y2PIi1ZARGRFintLnnSuKwyWvzjSV+tfHH7EgBh8fc?=
 =?us-ascii?Q?zMR+59CMR8ulf3KcWlK+17aMcJs/dVPmEzuE+2acwiNgOkyg3hUmif/soumG?=
 =?us-ascii?Q?h5wMGFe+/7xatuRljpolKfe1/CmHm/aKYV+tFOwgBiReAYXah3Oldf2xOpwY?=
 =?us-ascii?Q?R9fubvpbMpw5DcP0VJkMFwADxgHHljHUOCs48T5lgFSoUHyQW/3hDZHb/I9x?=
 =?us-ascii?Q?MXk3j5BPBCJf0mxK+XIqcjlZt1MGaV0YbvH/iPrqa9bzHA+DZV0Vlc7TlOJO?=
 =?us-ascii?Q?pSpQbMNMJzTo1MT7AMLyq14g7LXRlKuTMZKCthhIX8eJZvotimlCCDpukMVZ?=
 =?us-ascii?Q?woHJuaBfeDNvP3aiDNHDWO0x2DORjFqgyw7EuB3oI+SSvKlcTSq74IJ8TjTz?=
 =?us-ascii?Q?er7zrZMNF4NIRM3x5+WQeqVNXVjLFnpv3ydcEqpIqIPDnuMBs4MeWMqKdDU2?=
 =?us-ascii?Q?fnuKvY4hS7KKaMYj2g3SPX0o6LAJrHg9JSFTp042o+wRx0Y2WioHzFa3RP1U?=
 =?us-ascii?Q?aT8qFyHN1b9827w1S70F/6iB+9CIDERP26q7fM7L6IdqCeEkS2mhqG2y0IJr?=
 =?us-ascii?Q?ivBUcM/uIBPXij5HEDdz8hujNoYSvo1MlR6pi1d08qk5PUGvc4NuRqNvkumU?=
 =?us-ascii?Q?xEdeMV+NSG/OtvJk0W1ljL3n/FNR+XnpFKilo0yD0RBMhO+s/7i8LHOoyCXG?=
 =?us-ascii?Q?GGbFTzjAIJP8j4PVzmep8BO5NvSRZM/icBvhF9QcLZOCBJY0UG8tMG3/nYXE?=
 =?us-ascii?Q?z/Oq5XbNyJO4KSgXjnv0EQuBd1qjOrgfD20d/5hX/EvZAO1vR+6yVKxuy/k2?=
 =?us-ascii?Q?oSw7JObkrU6BqQ5LAMGNGJNkxMTp1hPsOq3qvyjvAVPVZZgVlKLwCLc+sAu+?=
 =?us-ascii?Q?n9kULohtdGJsrcHTrvwzHpyHlJTbd4pVQmaW6i8FvmcrKUbtQptIOkw++hmj?=
 =?us-ascii?Q?oZwZgGJppwF0VrIc8j2riYAydaorVJAoaGkP+RcTfjSYaVo8mgcM2nAhkczE?=
 =?us-ascii?Q?sjC/YBUVdMFBkV4YWA4KwMQmszhYo5//yd1373Hk3IvwSPw0lFYN8ngJd0eA?=
 =?us-ascii?Q?oArzqkUO9zOBBU8RSRTLmXdCF98IaP0Temk2Li01Hn3T/ZnoAJ1FHpdgzhO6?=
 =?us-ascii?Q?arrng4U5Pqg5SOD+uYIB31DyfnrVMKEIOkVDyjwQQxlOKwO7IUIolaHO+Ktw?=
 =?us-ascii?Q?aJRYQIjPy0XcyWryplaiiAFxzdrtOUiTPFr4KtB7R3EYpxsOqy5uK5RWZOQf?=
 =?us-ascii?Q?SjKWp+IMnrMHMdpitNw4VvOGF88nLNK7g3aAf/qYGDNeSjaQkC5f?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 948a9032-2f76-4e73-0898-08dede5b64be
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:24.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PG4itI48us2N0d/SBqZpwbHSeucSNcQSvz9p3+U7pL+mL1BKA7LuDm4O4iUcjonZ3na3IzZyI+94fxltrLNCLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12285-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B6E973858B

A DesignWare eDMA instance may represent only a subset of channels that
is also initialized by another OS instance, such as an endpoint-side OS.
Add a partial ownership flag for instances that must preserve
controller-wide state owned by that peer.

In partial ownership mode, dw-edma skips the initial core reset and uses
the limited quiesce path in probe() and remove() instead of the full
core-off path. The flag also makes the driver validate the ownership
granularity required by each register layout before registering
channels.

Partial instances also skip interrupt-emulation doorbell allocation: the
emulated doorbell is a controller-level resource, and a partial owner
must not claim it on behalf of the whole block.

For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, the driver programs
per-direction registers, such as DMA_{WRITE,READ}_INT_MASK_OFF and
DMA_{WRITE,READ}_INT_CLEAR_OFF. These register layouts have at most
EDMA_MAX_{WR,RD}_CH channels per direction, so the capped hardware
channel count still represents the whole direction. A partial instance
can therefore expose write or read channels only if it owns every
channel in that direction; otherwise two OS instances could update the
same direction-wide registers without a shared locking protocol.

In contrast, HDMA native uses per-channel registers, so it can be owned
at channel granularity.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Fix and revise commit message. (Frank)
  - Move partial-ownership validation into dw_edma_check_partial().
    (Frank)
  - While at it, add a small source comment that explains why local
    variables hw_{wr,rd}_ch_cnt are introduced separately.
  - Quiesce represented resources during partial probe as well as
    remove, draining stale channel state from a previous owner without
    resetting controller-wide state.

 drivers/dma/dw-edma/dw-edma-core.c | 75 ++++++++++++++++++++++++++----
 include/linux/dma/edma.h           |  7 +++
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index fb17074917df..0d38de4480a0 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -831,6 +831,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
 	chip->db_irq = 0;
 	chip->db_offset = ~0;
 
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
+		return 0;
+
 	/*
 	 * Only meaningful when the core provides the deassert sequence
 	 * for interrupt emulation.
@@ -1188,10 +1191,33 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	return err;
 }
 
+static int dw_edma_check_partial(struct dw_edma_chip *chip,
+				 u16 hw_wr_ch_cnt, u16 hw_rd_ch_cnt)
+{
+	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
+		return 0;
+
+	if (chip->mf != EDMA_MF_EDMA_UNROLL &&
+	    chip->mf != EDMA_MF_HDMA_COMPAT)
+		return 0;
+
+	/*
+	 * Direction-wide registers are shared by all channels in that
+	 * direction, so a direction must have a single owner.
+	 */
+	if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
+	    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int dw_edma_probe(struct dw_edma_chip *chip)
 {
 	struct device *dev;
 	struct dw_edma *dw;
+	u16 hw_wr_ch_cnt;
+	u16 hw_rd_ch_cnt;
 	u32 wr_alloc = 0;
 	u32 rd_alloc = 0;
 	int i, err;
@@ -1203,6 +1229,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dev || !chip->ops)
 		return -EINVAL;
 
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
+		switch (chip->mf) {
+		case EDMA_MF_EDMA_UNROLL:
+		case EDMA_MF_HDMA_COMPAT:
+		case EDMA_MF_HDMA_NATIVE:
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
 	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
 	if (!dw)
 		return -ENOMEM;
@@ -1216,13 +1253,21 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
+	/*
+	 * chip->ll_*_cnt describes the channels exposed by this instance. Keep
+	 * the usable hardware counts separate for partial ownership checks.
+	 */
+	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
+			     EDMA_MAX_WR_CH);
+	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
+			     EDMA_MAX_RD_CH);
+
+	err = dw_edma_check_partial(chip, hw_wr_ch_cnt, hw_rd_ch_cnt);
+	if (err)
+		return err;
 
-	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
+	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
+	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
 		return -EINVAL;
@@ -1239,8 +1284,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
 		 dev_name(chip->dev));
 
-	/* Disable eDMA, only to establish the ideal initial conditions */
-	dw_edma_core_off(dw);
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
+		/*
+		 * Do not reset the shared controller, but drain stale state
+		 * from resources represented by this instance.
+		 */
+		dw_edma_core_quiesce(dw);
+	} else {
+		/* Disable eDMA only when this instance owns the controller. */
+		dw_edma_core_off(dw);
+	}
 
 	/*
 	 * Deferred IRQ works are queued from the hard IRQ handlers, so the
@@ -1296,8 +1349,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	if (!dw)
 		return -ENODEV;
 
-	/* Disable eDMA */
-	dw_edma_core_off(dw);
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
+		dw_edma_core_quiesce(dw);
+	else
+		dw_edma_core_off(dw);
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1007122d4123..3c33d12d1cdb 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -55,9 +55,16 @@ enum dw_edma_map_format {
 /**
  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
  * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
+ *				owned by this driver. Controller-wide state
+ *				must be preserved, and layouts with shared
+ *				direction-wide registers must only be shared at
+ *				direction granularity. Layouts with per-channel
+ *				registers may be shared at channel granularity.
  */
 enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
+	DW_EDMA_CHIP_PARTIAL	= BIT(1),
 };
 
 /**
-- 
2.51.0


