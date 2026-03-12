Return-Path: <dmaengine+bounces-9401-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE0oAzXwsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9401-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:56:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC0C276189
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F82B313889F
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7593FB7E7;
	Thu, 12 Mar 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Bc8CIroU"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507593FBEBF;
	Thu, 12 Mar 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334238; cv=fail; b=m2sQaa9ZC+T6/ZgK4BO6mACNLSwgcjxMH0hasKUvXmR//oyMF9nN/X9f+BYPMynciYR0dcGkSLUUOpOTY8t0wFE1qhGaekFRAO45ED7r1tgOHR3hhsqNUusOlcbb+XjqtO4G2RdHO/bGex8YUwoRjAcnL4TOiW2pa3czyCL5Zrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334238; c=relaxed/simple;
	bh=ZizYC7Zwg9hyYSKeDkKZSozZhjWwESyDYCuRwHX4Mm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2gIyzDQidxxpYSyB2cH80cjLv0nvs+G0SVYZHzw8k1Ws3U1MDlDdSpxdGt+tXj2KSbuXDzuS5Dtd5qN80YQZTFAkJpPFW4RiXRCSVQtFug4VHKXvj/LEiEsv642eo6ftZ5TaVHN/h+04Mhpwrx+5XjbcYwwOV1+pm63SvLTeGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Bc8CIroU; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bjs9nyMjiI8GNGxZe1khjTtciX65dcG8pFxuTnkGQG4AWpDWwIsQyKzKYSvt6awH9sJ3TnQzpoU8R/zksYVcyB6QWb+ccgYqXtWex6Kdv5nt7Hr4PjNVnSBbdOZrYbgE/MQerYTXW0QKSth/GHtw/5BsQndcyro6qORH3MHpruMeeV1UIPz4mg043/7Rzy+FNZnriJYAfXhq4b0rORVX+0QeRQV/G/29M/YndLrqKcxgwBByOw6/3LKoVuUpcahcjAoGr8iX37mArZZQMJfhRqzdeye73OBCMqcDiLl3c9z8OePZzXR3pAA8AE2/s++DwdLE/dqSdxwGRccLnNlCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbbIB9k+jZKilBIva7FK6qSuyXTmkI2tLXlEIdpWhmM=;
 b=UQ496hXG6+ZXGKNtUiOEJL4+BwQ4YQxee8vMXwqP4Vp1ilp5agXDpCswR1z9ucYkD+YWn8Jj64pjrG0eZemqGjBXdPRAFse3eFvDJUdL0u3lu9+5iZmTmi9f5FLzib4InrzfmKQaZL0qriCm/rF0a0gP3VMZAkQw7vTEzaszMHGN/moD1l0MWOFVC+H1USk7JowHVnkNhJMIyU1RBlurJjSbOs9mMLNb4ZhSYxPy+gXm7aNVj6JGKUIjMjxBL9AOFeN39fDRP1PCmyxUPP8fm8J1XPI3JWo+lgB+BZOgrikjw9I+7fF9JfjCRLwAkoTYfqD9EbIvyTw1VObf7/4YFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbbIB9k+jZKilBIva7FK6qSuyXTmkI2tLXlEIdpWhmM=;
 b=Bc8CIroUq7tmztUHWzuUJ4DGM609nKK99f/qQfi2s8iCjhkowm/H5tI4/2xIAMmZRvMOcAHMjZ/7yEKFP3ddw5ELZyMhXs3mVwpxHNpkailxkE2YKRZLHba2PKsrv41NVnJKBkW1DOafZiDLjiszJmHZa5qAT8gNe9t0CypB/BE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:16 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 06/15] PCI: endpoint: pci-epf-vntb: Fold MW runtime state into a struct
Date: Fri, 13 Mar 2026 01:49:56 +0900
Message-ID: <20260312165005.1148676-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8832e286-dafa-4505-d6cb-08de8057700d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TtUljG4XAVi6qGg8P8R9qWKSiAF+ZbJeAN2LPkdHo3E6Zo4Q8fTAlSuV6u3+E1h4GWyQPNhTjqFZXBMpT/B94M2r96ESl8irEQPxeS/S5YkvRBodP5vYjov7nJdRI64T5RDN1x6H704A4Or6mXKwaIYlfxFtY0h+qYxxcBFQ+esW9G/gvkYRRwov1qvnt9WTx16L+zS31jCDJMHGq43SymuadGQUrylapIo52I7guNCEjR/iiDk13M9wyPsJ5e2RlGaOWQdb/SfLJfeje8R9bUfgsoLJwO3C7sjWaJCxSys5uZb0rVnzff6KO1vdN1Iek7lNNZx+DEB5t8NMQdXQgr7vgJ9x8IikbAGTBSJLGhukj7gMd6Th5EeCWnyb5lJrr8OJBzVReFKbsKjvIJdsQimRH6YxbbEW70MvU71jHYa3fs2LFpsDofdqgsk0NOfGIKHc815gIbYgdwp6OIQ5oiQKhqhXUhgkynU26ovD/ZYwMJ+HqTyUnRiBeULZXx+gmRWC3GuQM3fJUUqr58fSPI92+KRuRZ3eUwonJLJAUm7B4DOoQ21VpwK8VzREyjFgp8rMtJR2oQD8+jAYQHD/omA/Tk0SIxQR7aGIOqiA6F45aWdK2J+kRRBeE7o0HOlRS9cvXY408Es5w2PT4q0dSr8khGTcXIS35D20aTvytDEv8WuRxZsAcOdSbPA3VGGKbdx6t32okYCH1b1hKp6hNDgKauX8enzqUozFHDZSTcdTmlZAI2vsqUjJLxuSHtBSNhn6qGPzUlURQ5IKZSUoDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?32TZ2iAx3XK1uLng3ew5bi4mVpY0Uj6PuZcET3gLjQkyyhB5DHacc8DaP2L9?=
 =?us-ascii?Q?aOAutc0b7LAPsBN6lIcWDoTq/EkjAIunNT6iBeonafNwz2ryePmvOdqg+5/s?=
 =?us-ascii?Q?IyX0zEKVhIIrRLvNCcN0wDMEoPpNFwCf2kNrFqJ6Tp+WdKHq1VqZBARsJ7Uh?=
 =?us-ascii?Q?B+84TkQFdb6LIMeb+G4n5KRwRqziyd1YZa6uPbVptNlR9pdCcy/nU1n8+MlH?=
 =?us-ascii?Q?34x8VKkoSA+sWiuD7dTbh6IFQJV5T50SvIOxRvSz/xDjTQ1q3SiYukX5ThZt?=
 =?us-ascii?Q?TwKBf0wWmejZ0if3ivMlSJE2+rFnb6K16uXXn+SW/t0VawX5BY+QyQ7HcdJz?=
 =?us-ascii?Q?+Qw0oQejBUyihjXE5fRnDmblsuYmqAWNIHXUcAFPoxuLsomd/HE5dg1qPnQq?=
 =?us-ascii?Q?69M7jkSFahFeT9r0/5KTjplsQcjOaLPCsSC72I2XCRQY15wYfBw24co/AB0W?=
 =?us-ascii?Q?FgsJrIh2LVWh+zSZM7q3fhrelik2Jq4rV6At6JgA/fXbKjXfd1EnN6FVa/dm?=
 =?us-ascii?Q?XbN1Bk9kGicfRD5h/+y+pl1CkSBO5bdnLaSWNnNL3IfOs9/mRa7C2Py+r2Yt?=
 =?us-ascii?Q?EGniSWcIaWrTyFQlMlk/rIIKyV8ahS9KwkF+HRljy8Aqb7xMmpLnBgbi5zJi?=
 =?us-ascii?Q?XXBPxS10IyXSl86Jbqz5B+2/8Q9PwB+0FYPiYyBYeZOo0LOvWgFfBTrj5GI0?=
 =?us-ascii?Q?K61LGVNvADQZjwo7vGcH+HEjl+ioNkftpFWbqm6yaPn7nkJP9fS1c9vSAYen?=
 =?us-ascii?Q?PSzp6G+fpZQWQjYLXYhxdh8rEWkerftgJscF8+ruRPYxFuPaAG+hDwghFKlG?=
 =?us-ascii?Q?S35uRqauAKjEhEXeOwnJJMcuuC3fXojbEu04I6dpZWAdTsuC1KReKc2hYQor?=
 =?us-ascii?Q?fXvo62Rv2XpNuxYVHZnuf5NisyFk7KOFOUFfUGpwlrR8x+F43qqFTsXuTUdL?=
 =?us-ascii?Q?kWxgNqG9Tbfs4HL2LMd18OMUIe/2ZWtIlhkuzFcI3FbSvtmXl9TFmS+s0E9C?=
 =?us-ascii?Q?OJYv5MVvqxSTqBUJxF40Ahs428ZsLZGeah9CfRF3ejUTGkaR4Sd/PGXpnQXl?=
 =?us-ascii?Q?YLYIqjgJWTjheYz746EnB1mzvZ3WOyWchJJfUt7IG00lZYJ1ZMexQkFUfAQ1?=
 =?us-ascii?Q?O0OIxQWTMTnIxpjUo0fjQ7KVKk3PTlYKHUqFXcAm5kdDEiLExZvyBS/NaQQb?=
 =?us-ascii?Q?b5FL6eDDUrMdTbljTI4fwN4Oc/tfmT9nMXzbmM56mu5tP5fsfyOuwVKCqPpD?=
 =?us-ascii?Q?mSC09trw7FaQFPq8ye550CTTPWLasKV8mJGW3Xe9NK9tIOMOY/5olU1+tMe4?=
 =?us-ascii?Q?1Cr5G1AT2UACFvQ+pVnZl0VWdL7IDzI9I0pLcFnB9lpBKjD180Jk0fa0azBg?=
 =?us-ascii?Q?NtITf+VW1lGIZFnJtGYy6MUR3vKJ32jsCGVqHstN+UfpYXgiQCvo0RdtXJLT?=
 =?us-ascii?Q?PvKAQjMDiGi6kJvIMlHl4WmnecuyWoSOjsi0OJGp8o1SS3+H0zZxWzHACRG+?=
 =?us-ascii?Q?3R1qdpOFJU94pVVmPBBwTGKD+LXcJptutnzYbM5EBjV7TxGeGlMQnIVZA1tN?=
 =?us-ascii?Q?A380WUS6H23dJjAlHVvE7CM4txL8ev4FdcN1VXpqLQf3aojVg3aZsDkmuZFV?=
 =?us-ascii?Q?yPaqjeHxpUSXqK40/LPkTScs9rg7BOSifflON7hrilOCg5VwJo1R3nhyntye?=
 =?us-ascii?Q?MXT0lShyXqvsjcXmqe5Lz+ORAWlWsmteZytl7pLO7GnypOEV8T1DYJvdCoiB?=
 =?us-ascii?Q?prEqVVQ1frD+kKoyy3qRSTl/kE3bidlRATAYmIbPwaW3UmmSPtKh?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8832e286-dafa-4505-d6cb-08de8057700d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:16.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoMs9DGDEEsaQRuNJuEbAR53lVyNnGZv1raopu9Xe+t6/G5DIM0qPwMTiqzPLriUj6JgSkU7zj0oRWfdLkxKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9401-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Queue-Id: AAC0C276189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The next patches add per-memory-window offsets, shared BAR placement,
and optional DMA export state. Keeping per-window state in parallel
arrays would make that work noisy and error-prone.

Group the runtime memory-window state into struct epf_ntb_mw so
follow-up changes can extend a single object instead of touching
multiple arrays.

No functional change intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 42 ++++++++++---------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index bd9a3380a537..16656659a9ce 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -128,6 +128,12 @@ struct epf_ntb_ctrl {
 	u32 db_offset[MAX_DB_COUNT];
 } __packed;
 
+struct epf_ntb_mw {
+	u64 size;
+	phys_addr_t vpci_mw_phys;
+	void __iomem *vpci_mw_addr;
+};
+
 struct epf_ntb {
 	struct ntb_dev ntb;
 	struct pci_epf *epf;
@@ -136,7 +142,7 @@ struct epf_ntb {
 	u32 num_mws;
 	u32 db_count;
 	u32 spad_count;
-	u64 mws_size[MAX_MW];
+	struct epf_ntb_mw mw[MAX_MW];
 	atomic64_t db;
 	atomic64_t peer_db_pending;
 	struct work_struct peer_db_work;
@@ -159,9 +165,6 @@ struct epf_ntb {
 
 	u32 *epf_db;
 
-	phys_addr_t vpci_mw_phy[MAX_MW];
-	void __iomem *vpci_mw_addr[MAX_MW];
-
 	struct delayed_work cmd_handler;
 };
 
@@ -227,7 +230,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
 	u64 addr, size;
 	int ret = 0;
 
-	phys_addr = ntb->vpci_mw_phy[mw];
+	phys_addr = ntb->mw[mw].vpci_mw_phys;
 	addr = ntb->reg->addr;
 	size = ntb->reg->size;
 
@@ -254,7 +257,7 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
 	pci_epc_unmap_addr(ntb->epf->epc,
 			   ntb->epf->func_no,
 			   ntb->epf->vfunc_no,
-			   ntb->vpci_mw_phy[mw]);
+			   ntb->mw[mw].vpci_mw_phys);
 }
 
 /**
@@ -763,7 +766,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mws_size[i];
+		size = ntb->mw[i].size;
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 
 		ntb->epf->bar[barno].barno = barno;
@@ -784,10 +787,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		}
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
-		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
-							      &ntb->vpci_mw_phy[i],
-							      size);
-		if (!ntb->vpci_mw_addr[i]) {
+		ntb->mw[i].vpci_mw_addr =
+				pci_epc_mem_alloc_addr(ntb->epf->epc,
+						       &ntb->mw[i].vpci_mw_phys,
+						       size);
+		if (!ntb->mw[i].vpci_mw_addr) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
 			goto err_set_bar;
@@ -824,9 +828,9 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 				  &ntb->epf->bar[barno]);
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
-				      ntb->vpci_mw_phy[i],
-				      ntb->vpci_mw_addr[i],
-				      ntb->mws_size[i]);
+				      ntb->mw[i].vpci_mw_phys,
+				      ntb->mw[i].vpci_mw_addr,
+				      ntb->mw[i].size);
 	}
 }
 
@@ -1065,7 +1069,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 		return -ERANGE;						\
 	}								\
 	idx = array_index_nospec(idx, ntb->num_mws);			\
-	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
+	return sprintf(page, "%llu\n", ntb->mw[idx].size);		\
 }
 
 #define EPF_NTB_MW_W(_name)						\
@@ -1093,7 +1097,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 		return -ERANGE;						\
 	}								\
 	idx = array_index_nospec(idx, ntb->num_mws);			\
-	ntb->mws_size[idx] = val;					\
+	ntb->mw[idx].size = val;					\
 									\
 	return len;							\
 }
@@ -1400,10 +1404,10 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
 	if (base)
-		*base = ntb->vpci_mw_phy[idx];
+		*base = ntb->mw[idx].vpci_mw_phys;
 
 	if (size)
-		*size = ntb->mws_size[idx];
+		*size = ntb->mw[idx].size;
 
 	return 0;
 }
@@ -1556,7 +1560,7 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = ntb->mws_size[idx];
+		*size_max = ntb->mw[idx].size;
 
 	return 0;
 }
-- 
2.51.0


