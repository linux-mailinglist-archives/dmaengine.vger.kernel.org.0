Return-Path: <dmaengine+bounces-7392-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88593C94235
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B658E348238
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256193101BC;
	Sat, 29 Nov 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="frFJhWwj"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565EE30FC29;
	Sat, 29 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432273; cv=fail; b=QRTDydr4PKMNdFoTDcVnauogyBglHnpJ4jQ8YCTAFxPxdmmYlW2qz1EbK5UayodjWXqv3coEksOGIK+Wu4swBq+uIq6vptk6c4CP+0WsT0yUcNh2v62p1EMxabtb7FpTrixhCNa2esoHjc/jukbNAGu/3ObmHGOzknenyVL9ya8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432273; c=relaxed/simple;
	bh=occownK8G72EcW94+48Y/f7/w3LAM/dmgTZKQ7bA0YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=emNEoV35lEamUAROGwKzMdH2b7NM8/hadZKKEUNifFBBkSm3cnjqGAtfRUwZw4am6ub3TUNdWOlfsILOcfzYGoqKL4NXF9fBIV5pYJhgAT+YeUUa7qsYuzu3pMSKrLWpJquVYJZg7Yktz7MpC6WUwp6iz+0nLp1Rc3Nu0ZckNlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=frFJhWwj; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YF9hn1PG5cu7F5sq1zX8dP2Fv1LJzrPwaYMmpMJehen0NUmPb9PnySPqZpHkKLVA1YOmxaFUKkrv5Ft4BYYpfFzfNTVwA/Fbvh0oeNL6TFqNwpH8CkpnZGaDxss8ZSrkzdYWtn5UAoE+5nWaCbuk4pcfj7SwsuSIIwiahw3htWCRZ5hmm9azehoku5K1aSdqS/q2S9/yAZmiqlbqRsULKvYy/MQUjozSuryeFlsLVhrTHCk5wpoBlzjL9LNxDVSF41w7UXk2zPodrYkV57JU67Jl+RWRUb/2M9H2J21A/KAT3TPyj3mO9xsIXQGl8YDM3QoIWd4Ga6vX4duajv2eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew+6uMSrIZ+4V/4I/w5CPWa/b+oYQm3yFXEFTxZG5pw=;
 b=q09/3z1ivqhiClaRjzlVgeWzCQFH9bEzIuEPT+nD3kHkbmCMZPLm3QBQ2G5rDhI4dQ9I1jPed2mfmFl1KUVNjs2FIfhc85BIWlZMgSWHTucbb9BrghItNdRrF9oVkOY1JKAwUkhNxqvS9wGEyIvViwbFZr9rOKLqzqwY8b1Kp+uMs+ByCy6/t8+m0lAjm5+vC4sqZsqTrxN71OPF6D1MtwL8/XCmfXW41u/zDD9Z7SW2OW/DrJcef32OkRzhMabaf3GPlfTpzRrZ4XyuIwuQ4EpqDs/q2WbLV12Pt1U6KRcymwg3JcOCrm0oEFM6cQ5UEpi0OOOGOGpaNuUOG8LcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew+6uMSrIZ+4V/4I/w5CPWa/b+oYQm3yFXEFTxZG5pw=;
 b=frFJhWwjJFVh6dvNBE4IknxvuWuoPmaZ2mfm7lX3N+ETUtJJGeT72kh+HL6kjN0wSZX5QW5jQwlHePi72Ez+ZWxks3/JnvLikY2bjxR0fB7OGw3jQ+Yow+EBiNuIn+DzCzPaII+2hnrXaB/4PEBCHpHLiMTrSAXTq40NUpG8mf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:26 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:26 +0000
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
Subject: [RFC PATCH v2 08/27] PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when present
Date: Sun, 30 Nov 2025 01:03:46 +0900
Message-ID: <20251129160405.2568284-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::7) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 15740015-afe2-4c4e-6c90-08de2f60f856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmcmsX6KIHcy+U9bfsaR2vUIb2vAgtOnXxdc8fA37AWpbhq3dB2Oqe7niQw0?=
 =?us-ascii?Q?+tLtuO7zzoTOzGgQ1i6SU3jfRk6TGnqL0L5Qe7K5b0mrKAHZ+8xUn6ffXmte?=
 =?us-ascii?Q?97OU+lOeRJkaz8/I6YKGN3gnzj+LtM8ku3gRGiCnBEMJCxNF0HqdIetDI2fV?=
 =?us-ascii?Q?hQxXYx2hGMDvh80WuxtSnM1fo416MJo4uCQa40Ew8mZ+6q0Gte9tPj3tlAzV?=
 =?us-ascii?Q?Pv8X38/wMmrkrcEBZfFUKKsM1Wu18NK6cH/BipKFIx5Q7MNqoy7tq7IbTQvR?=
 =?us-ascii?Q?D/PctNQa67M3eyX7nRypcXK9YWY8SWWAhjCtCIMhkCXZBxMz4zBOR1/Y+wdj?=
 =?us-ascii?Q?ScrrxkAR0IXUYOQrAtqxtKHcF+kQ18mRhwTRL/imzFewkREC76bhHjrv+2W5?=
 =?us-ascii?Q?cWJQK0um310jU9I7wb2WmvhlDRlTrj+vSxYlXSfjfTwIX2XE6UAnzpE4SPCn?=
 =?us-ascii?Q?hRFP2qnw698rd/i0elH2BkN07ZiZ7MjBliylIH9SNt42hp6T+UOVPeeDVJ84?=
 =?us-ascii?Q?OZsLFBWgzWg3xTlaBwczXhqsqOu97RQODqQvpLWJ3bVO8KNo5g6ZagbWEH//?=
 =?us-ascii?Q?l4GRWYCC1famAhEIzz9HBObgnzbZtXwTyxhH4Io9mis8fPC/1x+EiBhSaW9S?=
 =?us-ascii?Q?7XIU7HtfKNzIc8aR8mJihK4EZASPxiAnB66eN4L8v1trJOkvYV/6qKo8FS86?=
 =?us-ascii?Q?sRFptlabiInYoYRKI0K0I21ZziUO57DNcCWF+OJxqkyc7Ic8sCcY18nS5fQj?=
 =?us-ascii?Q?QndMMNJwwDWXLohngCe+7ols5ato6yet+0OP6OG9moMdAvjF2E2sQtahv8fO?=
 =?us-ascii?Q?XNJ/xDz/Zs4lqVRI/CfNCruH8+IyqlHqCilwIWq3x5qgz1SjeCNRkR+a5Byc?=
 =?us-ascii?Q?xmmnvVxxqKqdFfiU3zAhO4T2P6BUqaItVRtJY9Y7fSMuHXRw233kKA21FXYB?=
 =?us-ascii?Q?+m7Wc8n8X0RQPHz8/YDLId64yPChGJ/YGaVRNsfBDFmsiTEaO13NKuO7xuiH?=
 =?us-ascii?Q?106XVPAGBOg+v+MzTFASidE/bSK/26sZWWJuafWDta65FPiy9NoPSExvQ7jr?=
 =?us-ascii?Q?Bp8DziYh3Zi1VAVpR7t32hPgCmdLNQFIHW8Z0z1rfu37yDx0nLrJdHm2oDl7?=
 =?us-ascii?Q?bXin+ka/8sj6KhwanQWTowlAwcG5OhuQi5XavtjlN0xmj0B8rBE4DxOo4fhU?=
 =?us-ascii?Q?TnpU3mYLBXufWRkvEwrUfd9e5dNryZCGoC/hmSa2as4tWUHKKr7f86tRmldJ?=
 =?us-ascii?Q?Jdip4px01k0tyFO5k+4pS8VVulaBxiFTInO6aeKfScnf13uxbwemSQ0IOiGQ?=
 =?us-ascii?Q?b0yyp62mpjTEhoA1NqHvOpcYBAwUzoJH5AZfAT2eEVedMLaIF/gkmQdQ6Gly?=
 =?us-ascii?Q?E8qF8s+7Y8Ynk4TuWXN9fDaDs7x0FntSKt96idp+duRPZUFZ4Q+3fA4Nr9uW?=
 =?us-ascii?Q?4GPTSm/GFaRk57Tg8EEFzjYoxJXeW82w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18rL2gxbf8ChDdWYR/f6iVjY3uQOhU2ssIS2GZ4xc66yP/9AylrlfscqEGXd?=
 =?us-ascii?Q?VMOttp6LGY+1/qqMcBnhVhAWqnHpcW3CSGaevQbh1q8g8dNG2Xj8vKkxxgh+?=
 =?us-ascii?Q?D1Dhs4eritQrQr0x91t6QGOH4c1MTpzYebIdshYiLKUdzhEXjw7u/H1a7AFA?=
 =?us-ascii?Q?QwUlLRfqiDRi9XfrUBoTeEj6S57BuWOoNl5/SVmN9b0t14a88K6jCmoHyF32?=
 =?us-ascii?Q?Oqwxl6VWi3BlyVE+J57588mebQLZenl6Jy12CtAxQ793pWqh3ZGfn5Auoy7+?=
 =?us-ascii?Q?PJcds8nRIYGZQTq3FTDCbd6YJkMj6hScOcKu9wQj9qTlIYUgY09ROdjpnKGc?=
 =?us-ascii?Q?CtXXcstN+JPSP8+nsTuHn6f6Cxmf2lfXSckhzOLDfQZ2hgjCcWkQa9gvc6Gl?=
 =?us-ascii?Q?CgcdlOnpoaegWr0UGwvmn7NnWTY6QWbnekWsbQ0mPZXz7og0Og2YGmHayT38?=
 =?us-ascii?Q?8hX4dZMKy+RoazQvomyQZYKTOW+bdCoM9P5Pztvnp5QnHgohVk9wz2VActLW?=
 =?us-ascii?Q?XKf6nHu/EkzdUxw0ANKHPr6o7r4oNUM/C/AKXvF+Nc22fGSS2MTe5CzqKHtU?=
 =?us-ascii?Q?say/tFl7uRqHvbqu2elaILx/mbsDs04TFlLQgouOjNuT8j9oi3jF6FDG4PCr?=
 =?us-ascii?Q?beqkAOSvQVq9fB/7LvNrNM54njOwvqgcomNNG5ajFW58sVoYEPCCms9TkpBh?=
 =?us-ascii?Q?yPI46myJZF6KU8Pz/6XOX6xAEgl+KgwsS4bVfT+olzgkGAsaJQrx7ztjmxLB?=
 =?us-ascii?Q?Ti4MfWyRwWTbRtjs3KX2fBaMYksBIZHHc7r5O+argldFcbkAowaZchCcddBX?=
 =?us-ascii?Q?S0vBga0BWULwNOfFeCeaYPg8IW5nTfb/C7nHKS9koIulsKWf/YUJV+pt8F1Y?=
 =?us-ascii?Q?A00zv9KLQSIIwhpFPI5Szde3TRYn++owVYCGuOgUmyAR/7lTZWSV3Q8ZlIZ6?=
 =?us-ascii?Q?lYKkjlCQRVH0PF6CiZMZnKhELcVCoFWbEwv+T/MtSdKQ9+4YwL1LCpE+TNV0?=
 =?us-ascii?Q?GHP8kfJFJN55Ei6zgJxBPKfMJFYDRqllRx8S0fFlSIxw/DE+Sv2MoHZln9UA?=
 =?us-ascii?Q?TONjes0uQt0Rs3XKAXEa91OwywiMucl6smWsdszmNYxdZDlgMqKPk3PpR+Wy?=
 =?us-ascii?Q?olJ/iwnOgXRV34z4Ozgpvqp77j2xeLD6vu1WG5qNUPfqLDyG8kUnL1IMEYFY?=
 =?us-ascii?Q?ix/GJaQbVENdTSK/c3VAdt8BBPhD0U9czEl6f1CQ4dI/+xsbGGrG5E2LZcYT?=
 =?us-ascii?Q?YSITsIilJ7EHDHR0GtZo8LVinE1kutIAF9umJg+TvCNRWlpbcLPRs9oI/2kT?=
 =?us-ascii?Q?KB5sZshIVlU98hrxdn70GAfQ9U11E/SLmH20B80NrpgEMExJTCiNkmFJiKA7?=
 =?us-ascii?Q?2utQrEJayCwJNoK/Ktd+zpJ56zArLhUgj3j07RHlc3DtGd7H82iQJk+5MYtN?=
 =?us-ascii?Q?/s8oQnmfJ+KFZPQR09V9NX8QJgiFHVFrMXJDE+tDv/URb2v/s4CDp6Pf8K/p?=
 =?us-ascii?Q?NYWgqq5YJbb00/MFaugJh8+PAKy+BOCHYFXMJhKJfj1GVKxvnZR40HDP4739?=
 =?us-ascii?Q?njhlJ5lxKWNzzeasJjkCZ1ml9GojwgLcwajuB99YMYU4wFLq3ZA0oDXjQQxZ?=
 =?us-ascii?Q?7Lc2vRuK9c1d2GCgoFRIH+Q=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 15740015-afe2-4c4e-6c90-08de2f60f856
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:26.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaIKrhJfnQbYli4n/2yTW3+s6/5KTseZADhp+C0KrzMEfOHS1bKJSFlxKCpdE2gSd1rp3HhTvdqcZ6jiRGJy6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
support non-zero MW offsets. Update pci-epf-vntb to populate
mws_offset[idx] when the offset parameter is provided. Users can now get
the offset value and use it on ntb_mw_set_trans().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8dbae9be9402..aa44dcd5c943 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1528,6 +1528,9 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 	if (size_max)
 		*size_max = ntb->mws_size[idx];
 
+	if (offset)
+		*offset = ntb->mws_offset[idx];
+
 	return 0;
 }
 
-- 
2.48.1


