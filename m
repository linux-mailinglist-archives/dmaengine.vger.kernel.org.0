Return-Path: <dmaengine+bounces-6936-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB48BFF825
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94526358D02
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F112C2345;
	Thu, 23 Oct 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qZlc5vYi"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C172C11F7;
	Thu, 23 Oct 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203968; cv=fail; b=r4UD+AfEdX6ACGBu/CB7R2AE7DzGCZJFD3lczuRDZOET+Eqt+niOOWeklgpMHaFA+MEQwc3OOWMkdhDp/uqxSIZA1T+6A02lf1etYT85ihqyicFWV6BtkcZklvLLh8KS/wIls/gQqYpyMsWqtXW+FvgX5J0Tw7qMC7JAzv2TSkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203968; c=relaxed/simple;
	bh=kYcPo/e+76X7vQgmNhDlTUiJS/yKrpJnAPxmXms5ArU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZRFErY44Bm/OCWzmY67yNtZqheBqeNhp9pTzgdOo0zKAHBN+4VeNPZ1AHOtEwlQ+SdTHNLJitjOufV+G7D0NXHq7BBDijTDmwRmdGhNYCTNaaljpWuY2H+ZvUx6w3Heb3sxJY33N7pOZ4NR0hzhDqGuzVYM1aB4iK6duN7r/QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qZlc5vYi; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPAMORpSCqpspEXxpuRKPwz6mmCzvPTCJ4kANapl1Pnf52aUv6Vbs4sqAzOINs5Un4RxTeMuLtKB17sDpl3SYO0avl0arC4ulgJbQKSbvEQm6k2L/94dXEMF/B0fkmTLMiYG4Ws9Kjzel97TrryHYERKaAuCDGbaEnj8CNZaj1j5kLAT0/NCYjHX4sH61ZuQh24xYNIOpb6R3tkur33iFsKXqeI//N+azBAtXCHdcyJ7i2RFjHYWufbJdTtDyu9nhmCdnx+7KNGr/ISYNXe7ntm2jGHUZ6abnfyC1D21K5NRrqX49UjjqwKRDGDF9JkfHptZ1fx2TVbWVdfUT6bzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ts8xvUH71Ep3aN6nBzFjG4X0+NqfIZ80CmoQcpWyQo=;
 b=r7vnEguG4JxWR5F9BK6qnYmWLQ1x6JTE8K7xM89RorilrGMcusI46hqDltvkucfhjFZH7PZaUo9tPNVVVFjOTGdcZnrWPsJOpV37Zd4dmEwY1UWz96TXgiy0fTVmi8O8EaWHgLQukcEygQ/yC+RVXmU8Qbps3W9GuZPoDVcthtU5D9dnH0wKwrt/swO3wnKEfo3GcL//QgssRy2Uwmsucol2jxNLm9kQVgsP5BHsSGJ1Ko5lGBUEQ4zd0f8BXGsRoD+7FepEeDiHMrJm0pWsgmgGB4IImdrCU0qRLPde+edS/hlj0rDjh7lEdBUofJKkW94FK/umEUdaM4wisTJAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ts8xvUH71Ep3aN6nBzFjG4X0+NqfIZ80CmoQcpWyQo=;
 b=qZlc5vYi7ydweoP5RbEEYOMbZTeGxT8+8LLh3c9SldlZSkOS5TuACjpqHERVqowj3IJFoOQz94WnZj6pWQpn9uwLwvR3v+GEFvII6C9/0sPEgcXyz8y84i0GjQQHfG1zyhU799H5xSRNqWgqiORfhkLWEKLTIqffRd2nfsZPGSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:23 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 01/25] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
Date: Thu, 23 Oct 2025 16:18:52 +0900
Message-ID: <20251023071916.901355-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0257.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::8) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: c370deb5-21f9-454d-ba9d-08de12047d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djfQ9t6OyRqWpPV2e7w7LZVhtGIKM51T7xk850Zxuc4GnO5Yj0r3AXeZJjQI?=
 =?us-ascii?Q?OplHL8zuqME1LP5q9cNNSYzk6ZKDM5n0OIolG+KyQ2VKs0ooAju2AfnzuEe+?=
 =?us-ascii?Q?ZmsihuNGxjv8Q/ovV4TQJq+JR07oYQS+sLnZKyXyIGdPQHboI7betjx4xpua?=
 =?us-ascii?Q?QRBK1EdgBjrzUzD18wVIaVX1sxqkSNnPAI9P7zmnIOeo0M6X23byuqA/imFp?=
 =?us-ascii?Q?lVY3IgGcSi3ck66KsakDdQWu5Jqo7DVDlMOCXiQFeOaJ2HTCPIka0LSCIVAC?=
 =?us-ascii?Q?Sq5WvqM5rVec8dRCwkhBXyYRV6Bu9/euagt3uoEp6LqamZeiRIPrb9/De7e2?=
 =?us-ascii?Q?J43nrlK+0M8+yOUFEJIhV9QvoPWn/feqItKZ3mbmICeSFkk51j7c0fJ5dU2J?=
 =?us-ascii?Q?kYj4Qjfc/bGGGwqGaNWyBz17nY3g82hmKWIvQJAdGMx8cNdP37QBG3rOnJxX?=
 =?us-ascii?Q?QlXDvtJi7GcTQmE94OKKsa6B6k/ULAxTLqg6EdC74NzOAGkLRfDQOLz/NZbM?=
 =?us-ascii?Q?ubYI3Uny8VV7MEiCYfIbP1iw9/BVKJiQS1pbCEnkxNOSGKwF+/uJaslGbXAR?=
 =?us-ascii?Q?GxFC2LIs6guJMXXFnPTDbXQTJEFJZiuBJoRuBu32k/Rop8QUtyITi9mtn8c0?=
 =?us-ascii?Q?Uc/75bu5R0d3wiFzT5K1Cn6kGjH2hlvlXOLqjcHIERxSbKJK4/36gRkzGHXK?=
 =?us-ascii?Q?MJmP5QyVW7frqIfyyIzxKidgIHOc6CxYuI9dfv/MsO6onItaUGl8AX3Mcrmb?=
 =?us-ascii?Q?3H673ifG977jY1paPPC6vhSeVuXngo8rig9pE+mXMsvJMV6G5N/i0+UAvSUA?=
 =?us-ascii?Q?k2MNTZNWhFKGHN+5O5mYN6XfGLlYq7QPLdpOu10eLk3Ojy4IajHur9A134mE?=
 =?us-ascii?Q?QdPfnDfp/ztPtC4WTzbgCdQGMfFfzHgPwmHhN0s/7K6qPL4wI3DXXW/6H3It?=
 =?us-ascii?Q?z09oPvRv00yG0OuutoAo255GmtDOQB0DaLjZu6p0TG/Xcisx8RgJv7A4oNJ1?=
 =?us-ascii?Q?S9gQWRf7rJXWN9r+1GF32v5C5eAaLkDJXbnOxj9Go3lVD7l+Rq8zO1LkRiYU?=
 =?us-ascii?Q?6LRlnjqYfbAkISaFFcGXWVy5HDW4hKjZTtw3IqFIGXLcad0NCD4N0TkoKvJk?=
 =?us-ascii?Q?V9kAz1pvhVBWVtHc8EjZCGpl3GLb17OeTIMJ2rBH4BjIxa2SD8vyzcZpqeOO?=
 =?us-ascii?Q?mX7e4eQ5bCKau/nmgaPDTzvcD1rF5trUHPTdDREwI2wfZ+vE40k6cSsntO58?=
 =?us-ascii?Q?AWzEhpFuDmkS7rPu/oUEGbw5i7V7BkaaI6nfvpbwCKNevchnpTAkRb6wrqvj?=
 =?us-ascii?Q?o2IboNrgyOSr6P38jw0kM/S1g+NYH2i2kC1xUibF6UKzw9IHzUIWrkPxzF9w?=
 =?us-ascii?Q?ICnGe9AOJerR6rs7dbBwxqFYVFfVbhxAnznw8CER0bY3bErOGIvwwctTp3XN?=
 =?us-ascii?Q?SM2s9q3YnmrrRvX0OXG4CSuuhnHuHcvD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YXW8EwTbhPZJWtyUGTVNy8Esz7ZFNN8GuAIjwPN9YddkDSZbUKQpreNzx9dK?=
 =?us-ascii?Q?qHrL3lsOjvlBHwQMka+YrfQ7faAGxUW85C7nKyVHh+IFw3T3PxhuTiNabBf7?=
 =?us-ascii?Q?mCCCizDaWLIWlu4fynadY7LdDKvYgg/fxStfPlnuOkSt6gIF3qEygy0PKuNv?=
 =?us-ascii?Q?WcWPro98745Z9o2qSlXlYqEYbS/sCtlM3lo6mn4BGGOMwsCWuH98/ogmHn8O?=
 =?us-ascii?Q?BpJQDSDMnqZCA+ZRcJjZbiTX3Mk3K1v/wjkgeoAHPLfuDzh9bZXPOph+tJhB?=
 =?us-ascii?Q?fidIHdrJG9STYJj1DjT4WLhC5VCA+NZmZXyuX4FDq0Ybxbim4LKej/ZVxtZm?=
 =?us-ascii?Q?B/jygEr/Kq8BBnbH2UO7Ns5LRCgQ53a+HoK/Vg8/2Cez5SH1haseJ5TCy+f+?=
 =?us-ascii?Q?rif/1Jdx65N5kQ6lMO6NoJgj9+AsKP6mmlduomW+qpPtEuM7tiBFILUl4351?=
 =?us-ascii?Q?dP10cOdnV0G3gUmMr2L7Sy6/71CjoBUCvOG8nFL70ttAHiYF1TdnXutYX1iG?=
 =?us-ascii?Q?c+J+GRO1kNp8DkuKQM94ole0IyEAoWvjBtSUHyGi9pMGtlywO5IKnlc/mtaf?=
 =?us-ascii?Q?Xk+leMpWLVHPl3r8md9XypK3f8pGJroNgnR1/FXo7qskGecex/HnT0EtQcbr?=
 =?us-ascii?Q?ZrRo6smmSjTntI4bnLO+bteypcFNhDHsyZA+ExoRbv9hlEM+OYQ+4McT6Z72?=
 =?us-ascii?Q?MLJRxNenvGIxBmeHx+pAFElU9YHvgvS8s4H9As8+ZjJBDJuiBNNMXOAqaPV2?=
 =?us-ascii?Q?A61nHkUJHthwBgVKSVfElPyiZUz59hI+ZIDABGD3Lea0MMtn7l6BvKVpee48?=
 =?us-ascii?Q?3r+j/Tb9CmlOeIX2lvgOlnXJ/HGCN3V1pxYeLf44LHBTFy21dZb2+1Z95meo?=
 =?us-ascii?Q?XY3anFSItQbEaz76FWd9uS7aqm9JSHMqagPES7cFCH6yqUspMlgflqosuUFQ?=
 =?us-ascii?Q?utkrBlfE6T3NKnMPcHMuLSlkCHGD0rxtG8F9VIkt0NwJ/NQm756f3U/DouFl?=
 =?us-ascii?Q?RRLMj+Uwcl/ZVSDO60er3o4z8rEamkadfWS8zxsdcWYow/9hSedmpdOLJSbg?=
 =?us-ascii?Q?EuOxgL/flzMYClku0/EycPfgmIuJN0tTQIeZ0YWYC13LyXFl1AWkaUTGiVPK?=
 =?us-ascii?Q?KPKlKl44G10xkIaiDW84ullMofKvk/Ux2hZWVA1Y6vi3+yVS+IqCqy/DIuP+?=
 =?us-ascii?Q?Sji2puJ5QcoVVKYhhUZcCXDwi7XcZ06uPveumKUZP/iCEu4nEgZ62834btev?=
 =?us-ascii?Q?Su0lRufs+Y+5I/Lj5GaaMs+2OODgyZpjgZAFJRU2DMX3M4wxY8lQOgwHvkuR?=
 =?us-ascii?Q?CX+ZDmYZZ1ow36/MBMGj8pQ2mBz+ysyD4Qr5DG8vnbQ+ab5z241iZI/xqRKy?=
 =?us-ascii?Q?djVIIyOaYprz4TwuK2d0Y+/YNwGxD7zVy/VJQFukU3ZD3LT5BpZTrjaIWm9u?=
 =?us-ascii?Q?pP5JDNESzvMt1JEraKPSq90PrgL1ezUMfHg44hZq0csM94OyK25f3cX1Ha3o?=
 =?us-ascii?Q?/h+3lVTbNkTUj2+IJnzR7WghStCTkiPGpg602UQyupstZRBZvutVBM7UZ0pB?=
 =?us-ascii?Q?nVqWQ87rBfJ+sQ4dSJ9RGZ8gwW7v45DxtEveF4t6p9Ji2HG3N+C/pOP0NALc?=
 =?us-ascii?Q?wyCxTkVBBhtI3HSzd/xSodE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c370deb5-21f9-454d-ba9d-08de12047d8e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:23.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3TJllLrko2R06pKWE5P6/ojJcxyt6jddRfU7t27vWi0D7zNFnaZZmM48LXOP41+vFBRjyWUVZuZb+mNa6Whrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Follow common kernel idioms for indices derived from configfs attributes
and suppress Smatch warnings:

  epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
  epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..55307cd613c9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -876,17 +876,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 									\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
-	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
-									\
-	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	return sprintf(page, "%lld\n", ntb->mws_size[idx]);		\
 }
 
 #define EPF_NTB_MW_W(_name)						\
@@ -896,7 +898,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 	u64 val;							\
 	int ret;							\
 									\
@@ -907,12 +909,15 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
-	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
 									\
-	ntb->mws_size[win_no - 1] = val;				\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mws_size[idx] = val;					\
 									\
 	return len;							\
 }
-- 
2.48.1


