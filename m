Return-Path: <dmaengine+bounces-11529-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id onqULMMeMGp9OAUAu9opvQ
	(envelope-from <dmaengine+bounces-11529-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:48:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684E687DE6
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:48:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=tMusacK2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11529-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11529-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED69307F255
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F740802F;
	Mon, 15 Jun 2026 15:41:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E53407CE6;
	Mon, 15 Jun 2026 15:41:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538096; cv=fail; b=lCWvAYcFmDMYYZ00qD1HYC7jlxl390eakTbVHwv8F3IziV1p4EeKuAVr266wS+zv9C9nJfWZ6QpyfFZRLMRkiq/60HxEupbyfVOrxMKt0jJmVO0M8BV5Mzv10mQqplbR3ZBoecQWYct/WI9QlSpF8kL5rbzciBYNElNd5ujYEcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538096; c=relaxed/simple;
	bh=XAX1I/+2ZgSdx3nvC/Kyxmuc45FuA+/+BZS2R87IB3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NE4FmvRpkFXLvxBzfIzuqn7FiBvf0Nt//raBa8YyTx3iCyx1Amn4OQUP6i/vcbis9JQo6SbFMPCW2Zl75eFMMBIx5MuMYOiQC++lLGQfSyyy25lvw+4ftbFDncfQY2ai5rEs3IisktFqApPqVrkmlZkP049CNL2TbSe2TPoMWaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tMusacK2; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRyYscYloJhnfd7CqClG/QCf0DMm3pWu+JGvhxMGZkOvJQvAY3pq/sW+VwGXH0WVIroL5rOnkNYtikYZxnsiHpaRl9ffDDu3WFVLErpvx8lxE161wGHGbvFE3u/IaxEsdOVTIJaOcwGZRW+OZCX3CeRwL3MIMPXVwwgG/HodvD3lMx+e7U19/I9gOpe72W0KFl3IwqtbMNWf+Ip5G90EocWwaRKMk5i9wPynea36PLm/p8VMwCw17r9kikAlkfqXdum2BdSUaDnH426AP0xMetuX5ttM5r8WUMhe8MlUXIiSNnFSwvd5I+5zCbf+83INfREbB530X/JztiDLKWLVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5ZeBksws3HxwOUe5F8ifBLA9vryWEPFsIi+jZ0x6Bo=;
 b=XJvq1fN+rcMwBP3lu8LtRh7WisTqFCOeDXBiUVi91Vn2lLCCz5+zBM6koVuyGleQNl0848Yu0+5g9Oxe0+YbVBggKVprYdu4NpccOk6hw8kTAUvUNbLsacPPmVsq1lMCWExIBisptOPuo2iaGIAtDOKGs16LK06bBzcsghnphP0LxuV4qFs4UcB31TVnIxBo/Xz2KI0srpdfBxzv/4S08UXHQ2P+tFLy35xUbPIpAc6eCQc6C5X/KAHOmPQQg2+uXQ8uAHWAdhcA5+y7Rw4NLQ4KlMJvdl4jYaexClXj6letkFF/SuVgP9TQF+DW+pwcr9q/VcfPN4QEWjiuON9nRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5ZeBksws3HxwOUe5F8ifBLA9vryWEPFsIi+jZ0x6Bo=;
 b=tMusacK22MDcsb93DPADas4X1o/ZxyZTz+ma2N1G8D3hPsr2xfpALGycieeaAEX0AiwK/NZLCrZtBwf/XNEZfNRzf4vNzbVopJplYOubNoWUF/BVkVKxDPyaNvZJLpecywYZW3ZUXGIl+Ep8Bh0i3DqRWRqQhPEM5r8OgW0MI+w=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:27 +0000
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
Subject: [PATCH 07/17] dmaengine: dw-edma: Move dw_hdma_set_callback_result() up
Date: Tue, 16 Jun 2026 00:41:01 +0900
Message-ID: <20260615154111.2174161-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: db53b1b6-56d3-4a56-9993-08decaf4901b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QwovM4z65T36IIas58KhhCVFZnBeyFdu7YcSN04wT45tX2BHOb71t9FrwEu+tPam9bu3zmHuvdzkOaRhhmP4blkt2VbqwKxuoRc30zW0RcllXlyaKPevx7kBe9OtnnEEetMtRNS716M2HE/sE+l0aT2W5yg7CqPSsbfsk5JMv452JbP7MePB3PySUO4lJ4/81enRgGz7FG2Gsx7k0OBtF9Kah4WKpEMMvI1nyncQbVwVNamso/0qgH5phDD9ZDoD81w5YA4jHCNHUcVHkRv8IZrullWOuF4MQeYcUnyHaHVladzylBLW9oRQNcWOAkkWnrnhDowzku0unstbji84xlidWHhV5EfqhIGfOKngu8N+fBGatPonohivwy+pwJfQ0NfaZ7odRCZuNwBhNmWrLwGeWC7OvExspOTzBjdvyLs8Z6YXd1XFevufkNcrcRvwhZIJP98qCcqotmJU5Av7EQtLeeaaThLs3vP+n7JXEvyFSx/6zBP6oGckN92Ips531Y9QlNYicIVcS9+8qvW8UWgDGSVp6nq7U5IvEbbZqMX6miQKehOIhxGcDbMUN+cQStEiMmfCMdXVjid+q2QQAsI52XTlPJH0UlaILdRORSxzJe3iqYx2jVdIcFdvC00U0QlAA4/vgAdAcxsUUwG2N/wlxwyAdyZn+LSwBVtwSSwhgkrdMf5LiueG4voxxtpBAT3ypDhvO4cGhXTkeAlABiAifo2thI6S4Gcz5poKLA8DXfhOUGg9OP2PlRVBXqDa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+jGpuSSGNbUaE3qtcveXfUEkv3PgS8Rk/kagPXa5cOe62iXHyEGtPAc2VC96?=
 =?us-ascii?Q?7Oz15FjW4Fwm8x4oVOfuwK9nv1RvG6B8jgZmDnFZ/ArePvseuOnv6iyNTo44?=
 =?us-ascii?Q?Q8CFVjdQoFdjHfvPajJTK6eBuTXTbBNJmeZP2SdNhwhYKRbCnOAgkAEusrYQ?=
 =?us-ascii?Q?P9k0kFg9Qz7cGUuT8Yh1aSVYBAAibKkdAftk79S6FY0BHM9q9NMqVm0A+FZ6?=
 =?us-ascii?Q?juimqSQastUdTRc6BCubFEmMCTtRNG3f5ZxGubbBpH37Rc7znllQxpt7Um7Y?=
 =?us-ascii?Q?jUKvkODZj0MhjstI/iOFAUIt7f+zFR+zXqybgxwskXiLLVQiCCeoPB/8Ch1/?=
 =?us-ascii?Q?hRV/PAaIS0rH4uZjocZF7LtJM5+V1KkxUDqsiasw65wkx/49j0uUOd4wRbgD?=
 =?us-ascii?Q?YRxZXDhmJwfJAbWhSwKi05OubpTbXTNcXzgCZcu9S/jjsrYbkUEd7whadggC?=
 =?us-ascii?Q?IO7kkMnSm1Psf7x7ulEkAxp0etG1XDMIBW913x/ANu0GSvYL/QzZHmIuPCyA?=
 =?us-ascii?Q?Z911I2TNAilLQ6l1Q0MvFhCBexXVXmmpz7blEhAB11zOObzjt966PzQTm2/2?=
 =?us-ascii?Q?zeHxJ1ePiMLvIGUtqBv/BBzWqTfPGTizzyo6AXVKetYCtcN0AFrOl72u8qzL?=
 =?us-ascii?Q?KWdgMKsZrxRZT2I1ZHP8m8+HlXt6TlDqe5tyHkow7nK+VOL34W/w199Oxm0s?=
 =?us-ascii?Q?PaZWBLioLQrgfVZy43PXFeZiAXUz+5R8XVPu6I0oAC6qsDd/QMvc4uWmPwSF?=
 =?us-ascii?Q?TYX4pSCiEvVyEuX6JIyEDISCe6tB7+OLT6rvdlGfXuDaa7EKFr/EhhLdrlzy?=
 =?us-ascii?Q?We3oiGb1fg5QmzdmctfEzLtTnZ7ynwGVhTiY2FSffsrWC3mAwZWI9Gmp4jfy?=
 =?us-ascii?Q?FKuE9ZFHBBKfuonfne2Ez9Z51CdmB8pSWnxS5vz+nayYa1CB8fnUmdA3rsax?=
 =?us-ascii?Q?KfWmIsaqRXAGrb+62xSYactfvLW7Q7Fje0ZhVRbWqorp+/HoUKkPFeYkX8z5?=
 =?us-ascii?Q?Ri5oQij9U17bKpNrSgvBpw0IDwCkWYO234ZFul7LDFHDSks+z9M8g5/MUyaf?=
 =?us-ascii?Q?Unwfa/DJU4Yo37nZBOrV6MQkD/H7mWAFaknKWPicMtK3eIxZu8PdUpPrmt1m?=
 =?us-ascii?Q?sVu8re0PM9xrTsJpKqHoEsfXF6QY/b+i2opNsNIJ2bXkoFX+e1+e6N3s7Uux?=
 =?us-ascii?Q?4SlInWB8XjRLf7oQzKnR2+wdOR6rYBz/iCYoETNXZdv26JUkIbONixelAX1U?=
 =?us-ascii?Q?jG2zTIUQVrmnzA4HScjz+Q+/FTdTGTIPzb+vsKAe19U+Mvh1wmXUu13ehv/9?=
 =?us-ascii?Q?SBpkML43kLdgp5y7XDa5qdvxoXHsFnqvqdbmZyIAydKC19DFz6FSVrWZNfek?=
 =?us-ascii?Q?G8JOJv3Ow1IX6iblLLkLbao+XIE70Nu3RKzo3epdR8y+N2K2n/DJFPl1dQF8?=
 =?us-ascii?Q?0cS/yVViiMgEMmooCxn5tQixXW4u3UdAIgf0KOA9Z/qIv1b0C0kRsbJej5Jv?=
 =?us-ascii?Q?ObZXPSS5H2zBh0nqvmPYrnb8YlTsQHof7+Fl6EnbfBz0hZB3qhc8GOG/rhkJ?=
 =?us-ascii?Q?OMODwVmQmMSjy+O541DIEg0fVFBb6+RKcpLg9UnfPnw84+aaXTt6ZG4J9nFd?=
 =?us-ascii?Q?ad5a1/01qhqrDiU15yIc9bqho2kJJOW0DW4a3J/C2W5nVlVVtOtvs1yo6ul9?=
 =?us-ascii?Q?m7zaxQG5F1UsyJOFvVc88xN4aXl23wQW+ahZ0eCXUi6JTYk24wLB5wcPlOXv?=
 =?us-ascii?Q?Fl6khdR3gno9uoidSeeG429pPFAlgmmT8U/6Om2bEvz8zqRoXdKP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: db53b1b6-56d3-4a56-9993-08decaf4901b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:27.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2DaIyWlOB6fXr8srNS7vHSQfb1gnwMhjO4yHLtPEhbAs5cgSvJkHPxfBO/q0MMnDR4cwRUmbNMYO+M+31dEeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11529-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2684E687DE6

From: Frank Li <Frank.Li@nxp.com>

Move dw_hdma_set_callback_result() before dw_edma_device_tx_status() to
avoid forward declare.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Unchanged from Frank's original submission:
https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-2-9a98c9c98536@nxp.com/
except one trivial typo fix in the commit message (s/declear/declare/).

 drivers/dma/dw-edma/dw-edma-core.c | 50 +++++++++++++++---------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 489f7fe49840..5e41b1aab450 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -107,6 +107,31 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	return 1;
 }
 
+static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
+					enum dmaengine_tx_result result)
+{
+	u32 residue = 0;
+	struct dw_edma_desc *desc;
+	struct dmaengine_result *res;
+
+	if (!vd->tx.callback_result)
+		return;
+
+	desc = vd2dw_edma_desc(vd);
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
+
+	res = &vd->tx_result;
+	res->result = result;
+	res->residue = residue;
+}
+
 static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
 {
 	list_del(&vd->node);
@@ -527,31 +552,6 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
-static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
-					enum dmaengine_tx_result result)
-{
-	u32 residue = 0;
-	struct dw_edma_desc *desc;
-	struct dmaengine_result *res;
-
-	if (!vd->tx.callback_result)
-		return;
-
-	desc = vd2dw_edma_desc(vd);
-	if (desc) {
-		residue = desc->alloc_sz;
-
-		if (result == DMA_TRANS_NOERROR)
-			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
-		else if (desc->done_burst)
-			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
-	}
-
-	res = &vd->tx_result;
-	res->result = result;
-	res->residue = residue;
-}
-
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
-- 
2.51.0


