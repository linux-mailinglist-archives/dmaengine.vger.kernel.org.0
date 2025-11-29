Return-Path: <dmaengine+bounces-7390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5CC9421A
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADEC13479E0
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3E30FC21;
	Sat, 29 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Od17OFzf"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99430EF9F;
	Sat, 29 Nov 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432271; cv=fail; b=qYHPEbw1RZuofG1Odz+MLt4ECCiHXYXmBnYGPT/jB9gItUvyfzgISN2CPbHGNvrSGnZqtufPXXpeccGzPB329EahLMVWsCAMnJp94sgVoY1sJ7U3CBs23icUr2MIOQmvQUHgbG0ITxnwHYJX4VxwxagKHrrl3thFUl9d+z249do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432271; c=relaxed/simple;
	bh=Uz+H7U01vTVLFt8qibtvEfs4Cb3SM90mTAbz1IWJsPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qanB3SrYpXO0jqnzpXbG0ewwppwwXM+lSIwf483Lm+TRkijO7NhovpYEruCmnvFeH1+1amm1nni03MTTZtpTNBRVSlxzk2QTvB6aPT5XL1PIDUffp9LNWP91QhgYD0GVGbjZdlVAUa1lKChNl1vsABOI2dHuhRb9gDAp3u5+U98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Od17OFzf; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nph1wG6BBF0nGJl0oKH4+snFI3VvyXnuFM/ZuvkcLQjTfR5h4nWN/TpWG2CUkvdpg9zMAuSuhPD//O3ZYPc1rtmRQEiiON+VN3bIzw5MDsEVSzx29fF5DQIBZqo9Ux7jHdMMNR02DeRuqORq31pEMWQLsc/gXkHBO83unemCMDU5DQyMLXipS/HNzX7Y7qB4Wt4Yc/h4gaCNy9QRhXyqJA/FYAy78a2lkSCBYKnajI0hisjHo/otSakCv3bODyJD4h5fo7vgH6JCbXj9hONCvrbpVLoJ64VS8CgpC+rkpZY9LbtnHShJNfIzoW7WvdUqF9Iu6hYuRYK7P8VzVlJ0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN9iIdb3saEUBItvVyKOBmgx9oe9wRVt+45e9cdCAkU=;
 b=vHSOmbCYYoLi1eFb4l4oep7mZgtaJfnRqgHU02zhZEZOXkEqrTBqPd+QLkmrz1feorCWS0zsSlVG8OEZGDgH2jE5E4Z+a9O/t5ct/qK4REPhCXEuFHZJtDNxC22KcIhXl9XW49Qp2BrddS4bZrs37JfR1B5WYoYWAsC9z+q3S4DNhDi74Au80KHVN3tM02vxXLwX85ZrHERVZ28iepm/uFEEFxuqnrC1/W2t01cKPyBfG9L6LkyhKG8FhTPFRcUjmdOSxI0NUHPuWufHCwS8BY7aunByr4JZ4i6g6VUfdrN4diWBNcggmbUsZWn30b/ABeB/S0s9NYTYXJ8ITUqWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN9iIdb3saEUBItvVyKOBmgx9oe9wRVt+45e9cdCAkU=;
 b=Od17OFzfua3VsBLzDwEuo8/gqxdAhBIZpJTWYl04iKjCCdrTfoH+LG0oDviok5bz+dfT2uA0v8Oni45grK9DEcv/o0z0J80oZF0uWwiLIjErzRG40lfTcOhorb48sjoiA5nF+NPhlZvssp34AwlPGJoe4eEDNMnC/XSfN2j3g20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:23 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 05/27] PCI: dwc: ep: Implement EPC inbound mapping support
Date: Sun, 30 Nov 2025 01:03:43 +0900
Message-ID: <20251129160405.2568284-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 921972cf-8830-4849-f0a3-08de2f60f67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RP3hsJWL9v3IT+zTzhjKs2bz3gfySGkCrXrvKpN5jC9DgYvukdC6jjOIc5cX?=
 =?us-ascii?Q?mKB5i3gPjSTBA/c4ZInhR/9iLIJWFtuQYarynxsmg26cjlyBstdSVutnB09B?=
 =?us-ascii?Q?KNxAelGDEgokSAapyvU0x3pquanDcGNpv3Mc/s2cO0nHF3IDzRDyMtuw4qaX?=
 =?us-ascii?Q?e8vu4gnaqQzD4KUlXL2aaZyYaQHXmfdmqjfGkSjm+iu1zEsZ7s8/JXodgZQe?=
 =?us-ascii?Q?jkzYqD+RpYrtdGDbWXqf8/xrru40wUWlnjK73ueH9iEV7Dv3A/XdSRvo3oba?=
 =?us-ascii?Q?bDnD2k4JyYYnfWA5NmpxIfDaal2E4kADE39v2fEGQo0kJCoMXyPmiwxiPG8g?=
 =?us-ascii?Q?8n+lor0yiTBGV4jwpnJikGmax/Jem/hmuAxvy1Eu0gBWgZDg+4CYxktSkXxb?=
 =?us-ascii?Q?NeTgXtEhsJjBH8jqv9IY1IdS3biz2fTeaqYK7k+0IDM41pcynHx0Z1Y3tZ/V?=
 =?us-ascii?Q?VSX4o/UAMmFI0gIYK9YlAZObpJtEjDgLfbQyP/SyQDDy/tTjgw9FqvGV5Fpk?=
 =?us-ascii?Q?E0CvwdEg0K/zmUIEcICwZOgVPyEKMyM6bRMGVUjQTfl9S1mLDIYyDSz7jBYl?=
 =?us-ascii?Q?BGFOW85bUHM+22q3CNAj0cgELPrgi1pZtze6iW0y74V7FT/4K++Vdg6R5hlp?=
 =?us-ascii?Q?80LI81vtKRIksD5pZEtI27p7TfwVf91+rQi597YACvLYAJfEvzORfRG+YFm5?=
 =?us-ascii?Q?F5pZch92Go2ZCuhR/ChLd7py9ULppitMYtGGjdp+kWZlmdBkpLW1rAqEh6Yn?=
 =?us-ascii?Q?3GKM258e0oSziEchrrD+E4KFEzM2YpHKEVhgh4zYCko3ZtN/T4Vn9Tjs2ELR?=
 =?us-ascii?Q?VfB1uqALRlEk5zXiQlEWooyMgXgTdIBr+Ilfyxkph8K17lkb59AHFxWeChZs?=
 =?us-ascii?Q?f3d6twGNbDbc08VqEVKFZGq3XempNEHwSkB+QZTGWF07lEV+wmgYgxShEYcw?=
 =?us-ascii?Q?ZAbnV2nIzmPBvThA189S37fKGIA8yEhPG1LgxTkUdfEPE1jYrzaPykLgnvNL?=
 =?us-ascii?Q?aGn+DJxbAbeToLKvgKBAJTG5BQBfIuCxyzyBHWi+afsLlYTVNZc7b64s6v+R?=
 =?us-ascii?Q?wS/ODzxwkzu/fHA0xJpfjryzxAtd4DbV7ncqfnyI+XK9bUtyQsl8vP6wtOaz?=
 =?us-ascii?Q?vnDxDgPCKByCt9TOef0yhWdKgUfqyW1x3Q9kHUqq3JWa2vLdnqPv3WVzvtyG?=
 =?us-ascii?Q?/qBCzRv9ofb/y8ry/Sae4NZ0wQjC34Ab92v6T/cEclyx97uJU2bL7UwN+5WZ?=
 =?us-ascii?Q?lfC/5qzMegXyyShtcgfkWO2hsJW98qLLUTPeWDls334Q9PIs0SEe7IP5SLZL?=
 =?us-ascii?Q?l/dSZOnGPLAneOF3i4Jw5u92VBTJoxS2/6Hh5eArM21aWkfkmtI0NSDYelnU?=
 =?us-ascii?Q?hTFC7QNUXAPfczW4mjjJU5I1s/2gwq/MWrJUkqQGiCxqGXLYJIo4Z9McHJGt?=
 =?us-ascii?Q?5vi20gWl3J4/FxCeWY9pOfTddYgsOO5A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVnwqy6IzNzwP4V59K5t1ufW1PVhpkq98m9vPGPzAkxmVDHCXO1Wfi7Dtqo6?=
 =?us-ascii?Q?sEOXI/oqxIFBZ8ji/hVOzztnF35BgdHSPFD8qwAheSqIqHbO8Xn/ZvJDV1t+?=
 =?us-ascii?Q?2ARF3zeTZFc067wxEw9xaA2TSYD35cCqryihuV3bpp1q3bLwIq1LVjPuu0ri?=
 =?us-ascii?Q?aThMUgGwJV0CN01OOAtT0EdNZ4D6varPoKQ98KbP3gFoGO9jFaXEiCfo4jGI?=
 =?us-ascii?Q?VEG0bI+2ZPuacE6YdOpG6HPk2BKElnux8kBYVtDpGMAvbyL4jOB+pHmXPNhm?=
 =?us-ascii?Q?gjmu7BULfEdN4LuUw1YhAMiFnImM7R6jpIa1vNlLMr1uVBfXK0vLc+ZW7dQR?=
 =?us-ascii?Q?GxqOsJhlL6rje1g9ySww6a3AIbBNspe4yZTPFLPlhPj8/jYpeOo8hJNl/z0n?=
 =?us-ascii?Q?Kqgi30MECwCKGqwRyAl+R+LIOQbNEJE3H54l9Qu1kaBN/oTpcI0dy0PVxbYU?=
 =?us-ascii?Q?rzTQ6Y6vWWaE+6Iq/qVeG0lQCg4ym5JsAsjjF4zopgWynBIX8E4d5OyHIO/T?=
 =?us-ascii?Q?VTjnBqSaGQKiTQL4/iZH9EA9/fpYCWgtVnqvEg9PICaPR0tg30Ot18kolwzm?=
 =?us-ascii?Q?aYAZY6LJljoyKUrWZBhH3ne1eXu4HVkijPBPq63Dn7+uJnoHeUVAKUSngNZR?=
 =?us-ascii?Q?ruKsuLGIkXGJnv94S0AlEVqX5E5GLi3UfypN/INJh7qweZ0LTkuxOLBDUHpW?=
 =?us-ascii?Q?J0rUklwKPcOQyDefSzkKCmItomrAeB8zgbMz9m9gRDiww9aD53yPm/WBpZ9p?=
 =?us-ascii?Q?eKmFAH4DJKLxf1ryEudCL3fqDuKxvcfHWbpAMTjN88vyXkyUaQt/T67PKrql?=
 =?us-ascii?Q?0nIdjP+pH7XXTUkMt8DNDe/AlHPZwy3tDhja1ekQGWgTmcQprqRVGyJk0t1j?=
 =?us-ascii?Q?7IUcJF8M2cJ/VOhAiRkEGWgXI+Ddstsq1YE5He3VQO6OsE0KHSiIJkT7fBro?=
 =?us-ascii?Q?if28ny4mzi8MPMSdHXr3UXmRqs8Weoh6QRt7pzKVOt93CQzf6Homi5wBcNkX?=
 =?us-ascii?Q?Mh4biLhHkJhiy1VI3neWQK2ToFYxvSkaHIe6irIY7lURx/JuKqyEjnmhddpx?=
 =?us-ascii?Q?jxi7Yt1+m/Ri1bme50Z7KITpFn9gIEJ3FKv/UPVarjvZa12bamsFrr0Ooo2X?=
 =?us-ascii?Q?cfwDKIT125S2+I906t9rYHl8w9yHv29xaRM1zPv6aAD/H1jmLUPJhmOYMOd9?=
 =?us-ascii?Q?Y5SEvXc9PJhVCn3KyIwT9bJyL2ZGjoVapdeK7VxoFh6KTdxFIKyeorGI5EGU?=
 =?us-ascii?Q?GQ+Cz+7p3/ocKozgSJ+kKBcZwj8UWof4J8S818TVv9I/yw0JZvslzyzKOF8p?=
 =?us-ascii?Q?BrYtJbgi5l19URUM7wIvQvplevrBtXISt4vUX+cc65g2K6DrcgRtnYbHhgb0?=
 =?us-ascii?Q?NKsK6eUD6PoDckimIIJyyIcN8+Nm0Bjv9IV1rhHeYI1IIyTQcClfciQub7Hr?=
 =?us-ascii?Q?m6W63J8UVHatZLSol0mc0OPaRtUpBsa275qCfKJgVimxpQQDu3WLSpxa2O/i?=
 =?us-ascii?Q?KKUO9CzqWltxU3Q0dGSkK+mM8icWu8L/go3Cl3cqa02LcIhAYLyGc/khNZdw?=
 =?us-ascii?Q?YTRniSh6kt9TsH5e+jiI+5viv7nFhxDw0o7Hu7XjTJEMTXlikwq0e0NcaRH9?=
 =?us-ascii?Q?7RmQuwmQu3zTcetyktXMfJg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 921972cf-8830-4849-f0a3-08de2f60f67c
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:23.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Lrq79aV0jhUWXpZUmgcrZ/QUOBicEUUhAoHppjnmhUo+x18Dwjtv0Uwpa+/+Flh3WHuxah/LxXj5ziSYm1gdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Implement map_inbound() and unmap_inbound() for DesignWare endpoint
controllers (Address Match mode). Allows subrange mappings within a BAR,
enabling advanced endpoint functions such as NTB with offset-based
windows.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 239 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 2 files changed, 212 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 19571ac2b961..3780a9bd6f79 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -8,13 +8,25 @@
 
 #include <linux/align.h>
 #include <linux/bitfield.h>
+#include <linux/list.h>
 #include <linux/of.h>
+#include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 
 #include "pcie-designware.h"
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
+struct dw_pcie_ib_map {
+	struct list_head node;
+	enum pci_barno bar;
+	u64 pci_addr;           /* BAR base + offset at map time */
+	phys_addr_t cpu_addr;   /* EP local phys */
+	u64 size;
+	u32 index;              /* iATU inbound window index */
+};
+
 /**
  * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
  *				 the endpoint function
@@ -205,6 +217,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
 	u32 atu_index = ep->bar_to_atu[bar] - 1;
+	struct dw_pcie_ib_map *m, *tmp;
 
 	if (!ep->bar_to_atu[bar])
 		return;
@@ -215,6 +228,16 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	clear_bit(atu_index, ep->ib_window_map);
 	ep->epf_bar[bar] = NULL;
 	ep->bar_to_atu[bar] = 0;
+
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, node) {
+		if (m->bar != bar)
+			continue;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
+		clear_bit(m->index, ep->ib_window_map);
+		list_del(&m->node);
+		kfree(m);
+	}
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
@@ -336,14 +359,46 @@ static enum pci_epc_bar_type dw_pcie_ep_get_bar_type(struct dw_pcie_ep *ep,
 	return epc_features->bar[bar].type;
 }
 
+static int dw_pcie_ep_set_bar_init(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				   struct pci_epf_bar *epf_bar)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	enum pci_epc_bar_type bar_type;
+	int ret;
+
+	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
+	switch (bar_type) {
+	case BAR_FIXED:
+		/*
+		 * There is no need to write a BAR mask for a fixed BAR (except
+		 * to write 1 to the LSB of the BAR mask register, to enable the
+		 * BAR). Write the BAR mask regardless. (The fixed bits in the
+		 * BAR mask register will be read-only anyway.)
+		 */
+		fallthrough;
+	case BAR_PROGRAMMABLE:
+		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
+		break;
+	case BAR_RESIZABLE:
+		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(pci->dev, "Invalid BAR type\n");
+		break;
+	}
+
+	return ret;
+}
+
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epf_bar *epf_bar)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
-	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
-	enum pci_epc_bar_type bar_type;
 	int flags = epf_bar->flags;
 	int ret, type;
 
@@ -374,35 +429,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		 * When dynamically changing a BAR, skip writing the BAR reg, as
 		 * that would clear the BAR's PCI address assigned by the host.
 		 */
-		goto config_atu;
-	}
-
-	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
-	switch (bar_type) {
-	case BAR_FIXED:
-		/*
-		 * There is no need to write a BAR mask for a fixed BAR (except
-		 * to write 1 to the LSB of the BAR mask register, to enable the
-		 * BAR). Write the BAR mask regardless. (The fixed bits in the
-		 * BAR mask register will be read-only anyway.)
-		 */
-		fallthrough;
-	case BAR_PROGRAMMABLE:
-		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
-		break;
-	case BAR_RESIZABLE:
-		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
-		break;
-	default:
-		ret = -EINVAL;
-		dev_err(pci->dev, "Invalid BAR type\n");
-		break;
+	} else {
+		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
+		if (ret)
+			return ret;
 	}
 
-	if (ret)
-		return ret;
-
-config_atu:
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
 		type = PCIE_ATU_TYPE_MEM;
 	else
@@ -488,6 +520,151 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
+static inline u64 dw_pcie_ep_read_bar_assigned(struct dw_pcie_ep *ep, u8 func_no,
+					       enum pci_barno bar, bool is_io,
+					       bool is_64)
+{
+	u32 reg = PCI_BASE_ADDRESS_0 + 4 * bar;
+	u32 lo, hi = 0;
+	u64 base;
+
+	lo = dw_pcie_ep_readl_dbi(ep, func_no, reg);
+	if (is_io)
+		base = lo & PCI_BASE_ADDRESS_IO_MASK;
+	else {
+		base = lo & PCI_BASE_ADDRESS_MEM_MASK;
+		if (is_64) {
+			hi = dw_pcie_ep_readl_dbi(ep, func_no, reg + 4);
+			base |= ((u64)hi) << 32;
+		}
+	}
+	return base;
+}
+
+static int dw_pcie_ep_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				  struct pci_epf_bar *epf_bar, u64 offset)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	size_t size = epf_bar->size;
+	int flags = epf_bar->flags;
+	struct dw_pcie_ib_map *m;
+	u64 base, pci_addr;
+	int ret, type, win;
+
+	/*
+	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
+	 * 1 and 2 to form a 64-bit BAR.
+	 */
+	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
+		return -EINVAL;
+
+	/*
+	 * Certain EPF drivers dynamically change the physical address of a BAR
+	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
+	 * calling clear_bar() would clear the BAR's PCI address assigned by the
+	 * host).
+	 */
+	if (epf_bar->phys_addr && ep->epf_bar[bar]) {
+		/*
+		 * We can only dynamically add a whole or partial mapping if the
+		 * BAR flags do not differ from the existing configuration.
+		 */
+		if (ep->epf_bar[bar]->barno != bar ||
+		    ep->epf_bar[bar]->flags != flags)
+			return -EINVAL;
+
+		/*
+		 * When dynamically changing a BAR, skip writing the BAR reg, as
+		 * that would clear the BAR's PCI address assigned by the host.
+		 */
+	}
+
+	/*
+	 * Skip programming the inbound translation if phys_addr is 0.
+	 * In this case, the caller only intends to initialize the BAR.
+	 */
+	if (!epf_bar->phys_addr) {
+		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
+		ep->epf_bar[bar] = epf_bar;
+		return ret;
+	}
+
+	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar,
+					    flags & PCI_BASE_ADDRESS_SPACE,
+					    flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+	if (!(flags & PCI_BASE_ADDRESS_SPACE))
+		type = PCIE_ATU_TYPE_MEM;
+	else
+		type = PCIE_ATU_TYPE_IO;
+	pci_addr = base + offset;
+
+	/* Allocate an inbound iATU window */
+	win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
+	if (win >= pci->num_ib_windows)
+		return -ENOSPC;
+
+	/* Program address-match inbound iATU */
+	ret = dw_pcie_prog_inbound_atu(pci, win, type,
+				       epf_bar->phys_addr - pci->parent_bus_offset,
+				       pci_addr, size);
+	if (ret)
+		return ret;
+
+	m = kzalloc(sizeof(*m), GFP_KERNEL);
+	if (!m) {
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, win);
+		return -ENOMEM;
+	}
+	m->bar = bar;
+	m->pci_addr = pci_addr;
+	m->cpu_addr = epf_bar->phys_addr;
+	m->size = size;
+	m->index = win;
+
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	set_bit(win, ep->ib_window_map);
+	list_add(&m->node, &ep->ib_map_list);
+
+	return 0;
+}
+
+static void dw_pcie_ep_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epf_bar *epf_bar, u64 offset)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	struct dw_pcie_ib_map *m, *tmp;
+	size_t size = epf_bar->size;
+	int flags = epf_bar->flags;
+	u64 match_pci = 0;
+	u64 base;
+
+	/* If BAR base isn't assigned, there can't be any programmed sub-window */
+	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar,
+					    flags & PCI_BASE_ADDRESS_SPACE,
+					    flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+	if (base)
+		match_pci = base + offset;
+
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, node) {
+		if (m->bar != bar)
+			continue;
+		if (match_pci && m->pci_addr != match_pci)
+			continue;
+		if (size && m->size != size)
+			/* Partial unmap is unsupported for now */
+			continue;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
+		clear_bit(m->index, ep->ib_window_map);
+		list_del(&m->node);
+		kfree(m);
+	}
+}
+
 static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -630,6 +807,8 @@ static const struct pci_epc_ops epc_ops = {
 	.align_addr		= dw_pcie_ep_align_addr,
 	.map_addr		= dw_pcie_ep_map_addr,
 	.unmap_addr		= dw_pcie_ep_unmap_addr,
+	.map_inbound		= dw_pcie_ep_map_inbound,
+	.unmap_inbound		= dw_pcie_ep_unmap_inbound,
 	.set_msi		= dw_pcie_ep_set_msi,
 	.get_msi		= dw_pcie_ep_get_msi,
 	.set_msix		= dw_pcie_ep_set_msix,
@@ -1087,6 +1266,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 
 	INIT_LIST_HEAD(&ep->func_list);
+	INIT_LIST_HEAD(&ep->ib_map_list);
+	spin_lock_init(&ep->ib_map_lock);
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 31685951a080..269a9fe0501f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -476,6 +476,8 @@ struct dw_pcie_ep {
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
+	struct list_head	ib_map_list;
+	spinlock_t		ib_map_lock;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
-- 
2.48.1


