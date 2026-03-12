Return-Path: <dmaengine+bounces-9396-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAvmMjLwsmlBRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9396-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:56:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54400276173
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E10BE300B85B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B953FB06E;
	Thu, 12 Mar 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CwKa/Dqh"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF33EF669;
	Thu, 12 Mar 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334224; cv=fail; b=s3tZtVJWTDdIdllZVJJo2Pln79bR9lWUNUq93Mpx3MVxX7vTRPwbESn6dElFqVQk4mo4/RgiXbvKD4pph+H+San2EXE8cyx9IKuwFyNUY05/Sj/15RWaQSG+iK8OGCUOmvJhMVdseYAiFgTcdtRjcHSnJTsQOYwb8hbTLWfl6NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334224; c=relaxed/simple;
	bh=ush4VQgX+jLSnuTCOLjePMU+iEIXFEAIygH8cF+AAWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d60eIM8edL4azuqDd0EOz8ULguDW6RaQ55mMpaLQLEbov27EuPADIx19cuTNNrIVpyTPW4XLaaYJ3URT6MCqFBqMEAK0Uj6uBqMoQss9WwAw+XkpxqAR1V+UvYmxZgvZsqkyhU5mn4LZ+BEvcaufw4gNh4SZG2FAIrqeRieRcF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CwKa/Dqh; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqt+o3kZRXTWo/IHGuJgrRiT67ACNqgJzCYETdMDaQB4Ef4xdCgx8KA0L5BBhvlK9VDChfxizg9b9qiFerO98VAuOZcHnBohSCRxvJvvmionK8iLIIxhqgYoCKZGxu/2C4TdA6nnth1L5fj0EC1V/vqWIaN+aTJ1Zk/D2VlUltN6/6yMdZM8sYOOaAxbQ13O+wb25hRxPPwMZoHmRVRRQxjfkdj0FaRrFOyc5DVfe4fnbHHVSOumb14q5ha6KGBSc2XRVNd+IHRqVNJ8sU225pZ+TqJIPIvPhUOICa/j5a+O9dfzSB8PzogvTzIXU/HMMWkVm5D7HVOKZ52AXF0ZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cRKkznOSajfg00OPI1Y9kXBgICWZYrmkUZfnU2i5WI=;
 b=O+N7hPDcXEXDb1vh61tly3tZCO0ebnwEs5pjVMCuyb+JjXRL6AiFbu3Fm0nQLK7eYxAdbhYWj9zZ+6OJHZJHZc5J+MXLucYr9Wdrjn9Ik5p0ENCilPZApO5saH7pfcrO9yUYxumq8COB9W7BvOZnrgY60cKcOSOTMnKXXXlcH7q4JOaIKb3dM44mWo3JEhOuZ0wcMUrsmaXahcLmG0z2f/X3EzqQUscihIejMPeaYJOQWM9f6wY8Lth6otMW25nm0iH16K8uAsNrjNZfCWXfN5RxqVjBtwiUKt+tfJLcCSggM22byHew7bjp8V/IpMKvdrWh+QSZh52Ut8PlrBvDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cRKkznOSajfg00OPI1Y9kXBgICWZYrmkUZfnU2i5WI=;
 b=CwKa/DqhhH+fAKec+LvzherHjTNqkASFYaowXi6B1Ywce2ylnHIeDGqq3TSAI1FqfIA+FEuLyk8GOeqUSoQJj2iAqrtwcnUBVxL+aHnplT4Ba4CAfTLiLwhlt7076dyCQ+4MQpQDTfLAPpFxDOZ1Zmok0SgMfvS8Ebys+aRkvbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:12 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:12 +0000
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
Subject: [PATCH 01/15] dmaengine: dw-edma: Cache DMA channel IDs in dw_edma_chip
Date: Fri, 13 Mar 2026 01:49:51 +0900
Message-ID: <20260312165005.1148676-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 028847b7-3803-4d1a-be75-08de80576d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uYhVFlxlrxySVjP7OVF2FtyXV8zGoGUYMDpB44PnsP3UCQu6Ph/tx7iscqBE0yInr6g41A1C08BklxYCYBOtj2DQH5JDsjPXgyK/r4/skZklpo07vRoWfajTqUt1i47MTnjp2JEoBkOauCreQ9UyiHV0kyu/jFsJRnBSbzNmq5hyWv5530QZa7BcpZGXSaT/xJmELDqJCaB2l7Iq6rb0lNrZf1sR2C3Y3gPoDOrdNZkV4Nzs03DWOcIZ0sFAACvUvPTj8BFmgxKo8t15+6byPo748uhTPp+GqNUngu8ehS5fPxAUFYpY9ePA2UXuNfZtN9yCHHZxuhOVZBENGryBu3R5O2ACybhIyX5bMKmLMtlEQKRHHTgBUClIFUbeoTr5LIZZfPqr+3URF/npYEde69wAdTB31k034gE6QTMTNO0W4v1qhR+T5TOyTSk/HSzKC9VKRyHZ3/7ef/CrVoKVTyJ5rbGNZueGkcRGrgRnX8Cvu55h8zggIgFKYy8zaZAePm4nSFveoUw1H+8U4J0KULhv1kCwrIGgvjHDYLgjFY1OnXiL5jglopXGNKmcAses7oKLmXprxeaeZiHceELrJhSMnHDLsFjMwedqpCdSgKmYudEYCIUFS7IjQk7U9U+CghFMozBiA4PgcSFjWu4At3VXiKxl64HKurnt2ecEqPUlyVRSOowsUO2fu/E/Lfs3ctuu5D1/umdYvaBLh1NBVveJWX9e14FBuvsMOGvTKpUbt8iFgBPU4ag00vlN/tuyOXb8rkk5l63mHzuLm580Eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ap3RZMqymQxCGOBuHiJ+AonhCT7DjtEoEiooUJOvdPceG26W3GXcgJccgjaa?=
 =?us-ascii?Q?hxLa83q47IbtzRPz2eU3yhR/WRUvcey7Tkrwx42sUSBz3O/0cIVJXLPciWKS?=
 =?us-ascii?Q?0U5kmrxGTDNPp7SoHBS0tLEJsXxoGOis/Q5f7X4lVGSGA35tWlADqJnuy7PR?=
 =?us-ascii?Q?GsTFN64UoympnZUiZDH3KnMfSBwfJTamJg6qRWly0vBVf7kTTjcfvLBDKqjv?=
 =?us-ascii?Q?vA3Lt1WOItjaV8NFNThCiYijJaq/RCRPt3YPXmptT4BrEFChvVFJkE464wLk?=
 =?us-ascii?Q?37jdBd2zaRWMZxNxbyBwNApCe12FjYimA4CflH29/OA1zKZ0548DTKIrQJM1?=
 =?us-ascii?Q?woLwPMP7kiDKUryW8kcqI7QcEHSltaWDJBhSmocdbwaj8AjbhpCmk0NX8Flo?=
 =?us-ascii?Q?c43s0fij9KwvuCMW/FI3d2tpts+SAW+OrJ6tI4DFAo24W8LKwwlVp7AYS/oW?=
 =?us-ascii?Q?LIUIW8XPKNEIgAcsgYooe8ihCl3Wcle4pixAhMXGXwPhpwmo/EGn738FXc70?=
 =?us-ascii?Q?jUwHD2g7+bfT8doFcDeVQowtzoX3iZNBkYGevcEgCEYPCeu7Yt1TZOl+CCfr?=
 =?us-ascii?Q?77rKn7vKilISUxVy0/b4EXL9FL+VAZ3Kf+vVeczILxWkCmijkkdtZ4ICfbrv?=
 =?us-ascii?Q?sIYQ2aVRbU5JhUFv4py9fGKPSIO5dJOcryeq1gr20vt+rjAk0Q1IxrApBpY3?=
 =?us-ascii?Q?hddyZwX38YAk3xKYfSKvFLiLXbzcQfvAUFPb8Cj/lqPT0AFGqAj0ROTZCyiM?=
 =?us-ascii?Q?aWvAUoK68uaWhtiFU0XcEK1RMipcDIbN3FLwtJrqW9TEQbm84NX5DUU2dKwm?=
 =?us-ascii?Q?1QXxQ1Slr20BNKlrDCj22d9vtiuuo3y/quppwxZHMCB9OQjTLmyj9YheFUzB?=
 =?us-ascii?Q?f58R6VxfNGCsxlsRelpdeh3MSIc3rgeA213q7Qr6XYnvMBMRd7crIb/iGBJf?=
 =?us-ascii?Q?5UNgSe29URtVyXQf2CMbM0WVj4mn5OiqolayiNs4RatCHkOc4qqQi9a658hy?=
 =?us-ascii?Q?XLfBYcRQfsOvyV1InIWMNGIXkupf2HJ/+cIlTQtARMJdnbo1488WgEjWq/vP?=
 =?us-ascii?Q?BDdhzYs/8fWyTCb7hvJGz2nfZXn5SByt7b8yNhMVTsMoYrJhdy03FTHbuUy2?=
 =?us-ascii?Q?ZhSTOnHB3rMwDFqPwPYp4yfgVO0wHKBmLkUVZwio4o/jx/DYC//sjxVPgK2U?=
 =?us-ascii?Q?0TYPo6ZyEiWKCXWPumFLMK9jpx1/NhF8M9/foPvuQ9INn0SaHMtTFQCF6xHh?=
 =?us-ascii?Q?Hr3tpyjSiBuxpAHnyEG9douYttuh0gi9AGTwYQo6L9m1Uru3Em/0kEjM23Uz?=
 =?us-ascii?Q?Uzu7faW9lCRrtgPNw8LJCZTWURxADg6LN9OtYjmZNUAoYTUUKpKT0xWHAxfz?=
 =?us-ascii?Q?J4Rp8TPpapT4bRi1kRT5UcdvHZbZOQO0CdiYLPtetnZcWMS0fxbizWjdkjU8?=
 =?us-ascii?Q?9W+YcHox2iO+QWsvRu4Vi1Bun33o7luJz9nYrm3RohmypROMCXk4p0IKQdaH?=
 =?us-ascii?Q?LG3ZArcPQMsn96fIIlu7iXMfgo4hTERa0vj2mU2vWldf28vV7BqOyeeIpv+p?=
 =?us-ascii?Q?wmgRv51no5Z47vf2QUz3A+1GrzTkxMOVX2mZ/gUIfx0LIYPkaqqVFEDHvSjn?=
 =?us-ascii?Q?67Ik837CScJOnv4JkZ1IL/OnqQ0a6kNK5+TQKro/iazOoH1kO+V41n6d9FKB?=
 =?us-ascii?Q?wyernRRnsMpCcajZCrUJ6l6iT1eLNWq63oW1vSzehcW4QT7WclW1gHdK2V9x?=
 =?us-ascii?Q?Bjm6S+CPRWUBkmF5g5SnyOlrxmgHp/H5rRz7rZBKP3J0R5coXtZC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 028847b7-3803-4d1a-be75-08de80576d61
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:11.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NyGuqgwsAS4sCyFfxOv0Jrx0C3M6u6rBeORoHqZSGyfQpQ5zNcNAK0ztFaoFQ3/v+yjkcf+YOJ+YB+d3upDWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9396-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,dma_chan.id:url]
X-Rspamd-Queue-Id: 54400276173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The exported-DMA path needs to describe each exposed descriptor window
with the DMAEngine channel ID that owns it. Those IDs are only assigned
once the channels have been registered.

Cache the dma_chan IDs in dw_edma_chip after registration so controller
frontends can later publish them as auxiliary-resource metadata without
reaching back into the live channel objects.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++++++++++++-
 include/linux/dma/edma.h           |  4 ++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index cd34a3ea602d..a13beacce2e7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -837,6 +837,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	struct dma_device *dma;
 	u32 i, ch_cnt;
 	u32 pos;
+	int ret;
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 	dma = &dw->dma;
@@ -932,7 +933,22 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma_set_max_seg_size(dma->dev, U32_MAX);
 
 	/* Register DMA device */
-	return dma_async_device_register(dma);
+	ret = dma_async_device_register(dma);
+	if (ret)
+		return ret;
+
+	/* Cache dma_chan.id in dw_edma_chip */
+	for (i = 0; i < ch_cnt; i++) {
+		chan = &dw->chan[i];
+
+		if (i < dw->wr_ch_cnt)
+			chip->chan_ids_wr[i] = chan->vc.chan.chan_id;
+		else
+			chip->chan_ids_rd[i - dw->wr_ch_cnt] =
+						chan->vc.chan.chan_id;
+	}
+
+	return 0;
 }
 
 static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 9da53c75e49b..0b861e8d305e 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -100,6 +100,10 @@ struct dw_edma_chip {
 	int			db_irq;
 	resource_size_t		db_offset;
 
+	/* dma_chan ids */
+	int			chan_ids_wr[EDMA_MAX_WR_CH];
+	int			chan_ids_rd[EDMA_MAX_RD_CH];
+
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
-- 
2.51.0


