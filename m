Return-Path: <dmaengine+bounces-9400-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHl9DhnwsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9400-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE77276149
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D7F30CEE0A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17A3FCB0A;
	Thu, 12 Mar 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ehPLFBau"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020091.outbound.protection.outlook.com [52.101.229.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95A3DC4BB;
	Thu, 12 Mar 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334234; cv=fail; b=idQKjjGi6rsBS+1crCc3VYqS82Bz4sH0G0XU4jV+I15c3z69gw4GqeQUkRWJeGMyYMk5SlCMw3XXtXn2XTUSx+yy100p/2qnlf44UyvWXAOHHIq0OCcoTudMX56ROE1uABeEYwV41yUT8m9+RLICDkvBZlA6t5ZWkfVyHM8m8EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334234; c=relaxed/simple;
	bh=hMSc4+V2Rc5oAz+8IFUraqdzIDnxtLLw4juiMxyXkMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLvN4TVCFUGFSF6wS3AlUrdapJIQeRub8zP+gpiLsEzcu94BJEX25cgOfyWU5BnIKXz+6oCCPgPokyW1WCvGED3RsJ59zConGk8zmV48EeuhXRZ4DBS4pnzgaOpqwhPjtwcuGDDHciHS2tMVXvr8tG+lDuwhLSssiluQzle/Q0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ehPLFBau; arc=fail smtp.client-ip=52.101.229.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poXYbfII7n+RRw5zVr5r/TYFl9uMFDl6lat3KhnIhMke2rwlHupBknRu3VwVMn3MsPbjIfh9QmjEHY4rH4IZaEvMtP/CCztDVpDFXlCcb5g5BrygVN9PLzdFEo3Zk0xZH48itpAN2VyCQuA54JPfQbpVzyCcjRO3MfaR8jXCJwESZ0FO8RPDR+8UugBV/P0bp4hSxE2b/PHHExY6k8Xt0n/imuLfDQnQY8AKKIEioT57CxT93kytILt9L4dOj6vo0VoL6yaZt6MC4LdVmqVeTb3yL419RCs0OwtKa67HDIviLlDkKWcpCGyxOtvNQl8JatHRjP5LfDK9ayNgWmNU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8vSjZ5Ix5QegsO621JgF06QzQaoh+MimNxQ/RvfoPg=;
 b=cfbEeUEDPCIQx+kz3BUmECFT9QJNeFxeClVMRz4V7ToOIoCWrNCFC+tWWSDFH7UdTbeNgdiM94mn1WcjGq8dwsRM+cQ4kH4Kgjmh7PH/cc2gEIs5HnwgSTg4NqK7I03ED6fQJPYHMBFE2A05axE4OhWkxSEANDR+syivKsh4OiKfznkKht6gqCv/2Zudv/vuAf9LwgqnZNgZ1frg9YpSSED0W4sqekMW0gqjrl5dOVncNL15nkZU1z3aEPkT3fl0y9ZpF6Kk+Ad6DI9ZLnuJozU4XruoS5PlCjm9R/AGS4VS4rt2e5d7GG1UXAisbz5DRVba4kNhFll8SXxt8v/slg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8vSjZ5Ix5QegsO621JgF06QzQaoh+MimNxQ/RvfoPg=;
 b=ehPLFBaubhh5u3/P+Px9/isZr/OCDGdakbSc0XseSWSb1j8rtYlaf4SaiCNz68jBjCqby2TIrpsYJ7hhITeNcupo8v3RfQgvHFbCuQSarbn+UjtZajIhjP8UvWYtI5+pelDFT6RlpC1vOw07uPwXseI7YCeJvGyiJ+Ne4YN/ROY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:14 +0000
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
Subject: [PATCH 05/15] dmaengine: dw-edma: Compose MSI messages from allocated IRQs
Date: Fri, 13 Mar 2026 01:49:55 +0900
Message-ID: <20260312165005.1148676-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0116.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5a93eb-1b6c-49bd-fd9d-08de80576f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xf3yeKwXJqNwHfUxPd0mN6EWOHAVxzm5aZQ4MBNWzIwPSpAYWHtZRJesr5J/zDbCcc1IKGY8OPhTIAMiNgWcHoFQRQ94W/D1lTij53DsOU+799QprQBSsTbYiHENKaZmYfJ8lkUZRkYvs05HYdpYHiJIVBVy1nTq0ZrEX5s5e9R/nm7gz62wfPe40Fi9l3M+ZGGy7T95gif7vb3EUhOD5M0HmpkusFptLuiCgpgya27F2TzyHMseZiP6qjTCRbT4/+WGEYRrpglZ3weDrT2ncZZgvBhpNEEwPGxTSsyJ5CL01AOhs8LMgLRMgjjpQ6dMSKHohQJTo+gYxP4taY678eUna0Ty4UZ1fX4zXX/kaENLjBBoByAQbISFfkw7oNpNQDc/K7NuZsJerX4DwmCMFRWvgzrYigyJmVG0qUo6d+PXv+o8GbHb0RZjxnQP8vQbKpm5vaNt9dhRURHcSLlwEzTBRE0jcv2yecdmfjeG/RM1CoaTFwIFNd3GlGbFx0+lc+aW0AaYil98CmWW3Ta2xekWMqAVeQ3jETmOeYPHxFpiZp4JFWw0Ft68NDvgE5PE7fZaABA0ifGU3VIBuPtf6uexrquPZrqTi1+2+IUmXtbVuTjRBqp6F+HJnqkB6wjsD86Y3mfXdyF5wbcMUafX/I+jUqmvbGJnDWvAPFCKkTCXVNdok4ouLgpIAm0hTAfBAbVc46g/utNTQTpBrZ0hc+12h3RjxurU3kdNppyfTxUCuDGcccF3pTEfUKKQ4zqqDUyztXnJSuPaidWvpkRSYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MwoJkRkV6naHM/Glsuf/WG/OCrCnVNS0OQyzw7JRzKOzfxg+eVyVXHEFIqZT?=
 =?us-ascii?Q?S3OM8N9k13VVZNVdnddCgifE6LZfFXwJEns1h6iYe7F/pmdVIlx6ASWnXHl3?=
 =?us-ascii?Q?fNyW7KxdRaL09t8AT7p0r3ASDJcfrZA5bq2ZxnlvmyuCM+DODE3EKw00098u?=
 =?us-ascii?Q?wUu6lfdpqWG3JhS3MfaBvSclGvDgiLxVnAciIR9HUF/xRVYAUjwElZL2fZd9?=
 =?us-ascii?Q?rAgsxpgGyj/k6H0Dyxh+8KMuansmIgY8H996H+hKz+YNKZ9QMonFqhoKTb8w?=
 =?us-ascii?Q?RlbcK/AITbGPW+pcZQe7UqXfZmPmTVIHwz9RHxqGhXgdJ5sIe6wdmCON2Rmm?=
 =?us-ascii?Q?ec7yP1gpXwREH7MuuZBQe0fZMmILO2bPhRdXf4pZBd9wFNMyNZBbp4wuBwbG?=
 =?us-ascii?Q?Sf+bmwBRzUqmm2RUtH46qtIt+i1CoiBiKE5T16CTRXSqEpZGwypFJuW6z2gk?=
 =?us-ascii?Q?GuOQlg8WlYQkkd0/L9f87IbvPSeaNYqtyAbGxQBh6uZ/ydUKseLMKHn1ebEX?=
 =?us-ascii?Q?7/weUYk4vWUBQDAmyA87cSfYJPzO1D3ZcgTFI/vNzOyzqcIVlYUKpNiOijDC?=
 =?us-ascii?Q?xwS/5xueAoq3KVnHfNKsP0oDGRy14SCy6VEreD5SGw1jSeaacx5+d1h4/Xvz?=
 =?us-ascii?Q?9cMHOQGnFmJDBmTAAWB0XRgYv++aN14mOPwGDBf7k/mGTAmWZKn2z/IuUQMj?=
 =?us-ascii?Q?s/Gonr2UWx6bJTV3Zyi4by9qxM682Jbztgkwr1E+s7XUtNcrPKZQomTKl29w?=
 =?us-ascii?Q?XH53TyR1PKGoHfm/uicw7uEcfGDXP02RBW/DsZaUj6VEXTwjcNNNS6bLyZPf?=
 =?us-ascii?Q?qbu7FZDUqE7XWNU+j3Gvfr5m1rwuedBVJNQnxe+7zcTn2AXA/eBlPRZBqWSm?=
 =?us-ascii?Q?Ud10RpYXn+suzrk659hXjchIH3pt13Be7eYsv9FGEUGQKO3vZKqYNuy3FR9X?=
 =?us-ascii?Q?v5CZ7Dre+W8OSlx3OlHQN20pReqNUNnQB96u1Fd2HpOvSJEtLPIA7B6MuQlr?=
 =?us-ascii?Q?99CVwhIfrkvl+aM4QBp5Ct74kt/wBr+yCEC8ijv8RXuOXq1/XRDN/FzSjdsf?=
 =?us-ascii?Q?0dS8/L9u+TpArpcdq9qqHAPq04wBvwX7bWA5Xs2AlI53Lxyt7mDMRy+lSs91?=
 =?us-ascii?Q?Ye2zYy3HHfnzaWlpsxn9mBb5E1Unsa6SOSPseRufNwgzNohirHQeUJaBBu7X?=
 =?us-ascii?Q?tsEXSkBIEYm/K1usx7y7mWG0aiMlX4a/fezzY58GwR06HerydXPrfKGebQBz?=
 =?us-ascii?Q?eLxpgI+TjPu1ueSZVy4n0QEhZ3eJkJZKzrFNGyee8tolnaIV0EDgW008UJin?=
 =?us-ascii?Q?3QTEDGPfIjx3nlmzMoCfKJZoqWjlKNxeHvDLmaRpWYoKRBh6K9dIlkDTzPgW?=
 =?us-ascii?Q?jtnRucRnevk3ALxIosrT7XNLOSLfyxaej/ma4ZRsohCfVEei8ptCJ+Cwq6L8?=
 =?us-ascii?Q?91tD5jlvw2WsSU/aX80lfK3KiJA715ZjP5g+QqbTf6AseDMejCmO45hX1iGa?=
 =?us-ascii?Q?yMwMS9IJfsSONT4GHqFLUoAwAM2z75Sw0PFYJ9aKc6IY8XvEXaw3LclpTOCz?=
 =?us-ascii?Q?/vdG52o1zX++62fmUPrxpdaZ/Dn9XLaX4kR0GiUmYfUAfhyMDFuZJsiu0AA5?=
 =?us-ascii?Q?qlsh76ykPvBVXeuBLHGh+2nD+RSLGzrA4QyxX/ZLurcGuxomTr/KmxUDZvAu?=
 =?us-ascii?Q?zmYMBjeMClI38J2iMg1jEa+DIaSayrNwBechhyFja89paxJ5XGDRLrR/9ccR?=
 =?us-ascii?Q?V9+dqFEK2C5S3Ne/3RNtvzIXZP/bTIWwBlW5NRFfDW45AgYz//G8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5a93eb-1b6c-49bd-fd9d-08de80576f31
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:14.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR14o9wSqch4PavpzzwB3p1CwVcLIsAYkFyucHLkFLopQbljw9Gw0e6pwdjYKQzRMXuK+4oVMzuqJjnJLxqpOw==
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
	TAGGED_FROM(0.00)[bounces-9400-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msg.data:url]
X-Rspamd-Queue-Id: 9FE77276149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dw-edma caches the MSI/MSI-X message programmed into each channel so the
controller can generate IMWr interrupts for completed transfers.

Today that message is built inline while dw-edma requests its IRQs and
implicitly assumes that the allocated vectors belong to dw-edma itself
only. That becomes fragile once another frontend also requests IRQs
from chip->dev and dw-edma still needs to derive the right MSI data
value for its own vectors.

Factor the logic into a helper that composes the MSI message from the
allocated IRQ number and the owning device. For multi-vector MSI, derive
the per-vector data value relative to msi_get_virq(dev, 0) instead of
assuming a dw-edma-private vector block.

No functional change intended for existing users.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 6341bda4c303..c404248767e8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1020,6 +1020,28 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
 		(*mask)++;
 }
 
+static void dw_edma_compose_msi(struct device *dev, int irq, struct msi_msg *out)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	struct msi_msg msg;
+	unsigned int base;
+
+	if (!desc)
+		return;
+
+	get_cached_msi_msg(irq, &msg);
+	if (!desc->pci.msi_attrib.is_msix) {
+		/*
+		 * For multi-vector MSI, the cached message corresponds to
+		 * vector 0. Adjust msg.data by the IRQ index so that each
+		 * vector gets a unique MSI data value for IMWr Data Register.
+		 */
+		base = msi_get_virq(dev, 0);
+		msg.data += (irq - base);
+	}
+	*out = msg;
+}
+
 static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
@@ -1050,8 +1072,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			return err;
 		}
 
-		if (irq_get_msi_desc(irq))
-			get_cached_msi_msg(irq, &dw->irq[0].msi);
+		dw_edma_compose_msi(dev, irq, &dw->irq[0].msi);
 
 		dw->nr_irqs = 1;
 	} else {
@@ -1077,8 +1098,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 			if (err)
 				goto err_irq_free;
 
-			if (irq_get_msi_desc(irq))
-				get_cached_msi_msg(irq, &dw->irq[i].msi);
+			dw_edma_compose_msi(dev, irq, &dw->irq[i].msi);
 		}
 
 		dw->nr_irqs = i;
-- 
2.51.0


