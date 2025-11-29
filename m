Return-Path: <dmaengine+bounces-7397-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFD3C94274
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B70A3349FF6
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8433126C8;
	Sat, 29 Nov 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KsiPGG6+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C931195D;
	Sat, 29 Nov 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432278; cv=fail; b=DKkOmMNgedHaaG7QpQ6pF5ij/2glaKFuNRjV6uVhPfvx6m2A7NhXk1p3UaGbyZ/CW2xO+hsi0mcLF0nRusBeoCxoLAh2YNn62liakFZdcNiA1Q1iiSQbvqCHZF9F2SXZ6pYcR7i74C5rXoDsJZStoYb8SE/v0MTcIGnd6cxooYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432278; c=relaxed/simple;
	bh=spQ1GUF6bl9p2sFXjMocMvSQpOm8zBeXECUzxO3T964=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHceaIV2jnqzFLifIxL1djwA0gBEk639X4uAy2M/Es7bPLvDZmhT7ouyoeS0K5v3XjsPSALrxVqDe5J90lON879yhFNtFwaBEehc+0vLtzwdK8MfaLXX7OTQ1BtlctO06wLgMitXWND9NYuBDIPTBwe2jKfIrIzSWEof6EHQ/mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KsiPGG6+; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqoicUIJca1CQyhna1BokRTCaFi5QqqMYlaYdBBgwcUdoU4Hx/CAfHyKwoR/lw30+aNchdyu81UYG+MSj9NfKkI5esHCe7evcw91dvDAZtvIhF8pAwz5jM1wH6NIx7/+ZELijfXmGpH5Q5Z10f30Z9tIAIQphP4aTsd48mvBVSg0+aImKPeh6h0Wn4X/FXTOD325x0T+N4JldzkPRk3GXDkbvaxZJul+2mgiME9kNwK//F+zTOV57PGHu9lxEuWSE0tHie5AtUuAGZhtbkbiV0g5hEXZneoExqVC7YAGEVWDxeZ0BHH7k//xRi6pujkFL9/ax+sIBWUgztO59WLCdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vjXBomzXe1ytPQHhDE+/UaBFWrMDT31AogCCEHOTNY=;
 b=Jk6BDMjaufeG57aWa1gbRIkdFAwoTwoFHAUpH2TcGHLPezAyu12ed8VrxxyZ2EPjPCKFt1NYpEXFmg9SonPYeQH76JYWbWCYdFvvEfSViYtVtfQYtCj1GqK+D88EgkCeKpjkzQY/w1hbEk0bsAvAKZwzOTVoZ+zDr1DLr6jEJzDSn2JMmcBDirOPQQyU3LQEAAm9QBaG66A7lcHD6BZM+KGHOC5lL8Qhtl6hw7lrbPqHXb0lNah2B/MhXoTqiCDRiWjwnybThTb79OatXdcvMCo2pdwOy20RMgKTFrZOHkt+G201+8iKVrxQ1QMAZ4KoDeMPgHR6NPI2/Cba8DocwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vjXBomzXe1ytPQHhDE+/UaBFWrMDT31AogCCEHOTNY=;
 b=KsiPGG6+ky2SgZplOAbxGu6Sl/hX5cK1JMNjBN3XaDvLP9orrq1opCrTNDpC2TrlPTdnGOSYF1OdJ/XTP9TF2c4AMcjv3khAiU8zROsA149EHHnzsiPXuRGYQjdY8t1kI8Q+fq7mE95WpFVX5rYfgdnr+0Gi1QTkB8Kq7W2p/kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:34 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:34 +0000
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
Subject: [RFC PATCH v2 15/27] NTB: ntb_transport: Dynamically determine qp count
Date: Sun, 30 Nov 2025 01:03:53 +0900
Message-ID: <20251129160405.2568284-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: df360f69-c2b5-4db0-d08a-08de2f60fcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gyf+ULmY+PGu3I/7qqe5Xk3RUvUf+Dk5ZtQ9emvFXEj7IA01eMYigAQ/XVKg?=
 =?us-ascii?Q?rzD3TgMvnoqN0WK5EQADJS0RoLVgw/nfA3U/JYWuP3AjHIYqsDRmezYpKz2U?=
 =?us-ascii?Q?H4DFMianwz6Zy9MdIY3+ZKoVL0ov4I8YfsyheUHVQeGomR+DWWGUWXwHXFzL?=
 =?us-ascii?Q?qBdbqC5GpowqIAk0FdMKvXDN5Zrdj94QoSiGwltiafoKhfGbTyjeCW7wdBRW?=
 =?us-ascii?Q?oAH8e24W48xqLXZPkHgzJXGF2i4Tsyrdv0RsiaqZ89XbWucCYkF7pJpYJ70R?=
 =?us-ascii?Q?/+fUNKjm2NYw4tO3ggAS7l9QXjFX/0pdMIO1abq6Qz20CY45juMRK+7BdeY2?=
 =?us-ascii?Q?6bizvYZ4RNJ9La15QKNllOaYPQS0+DHwZyK6wo0UJ9o44P4UtrIuvqof8WyM?=
 =?us-ascii?Q?nQA8KUFtzpJAjfITU6Fx8SV+omFZIUTMx5Sg0njnnINo6hLtgBwixjAyEx3h?=
 =?us-ascii?Q?2ADtKekD5zKQdTxa/++EU9HaaQV6eIyHdLXqQ3nzUSnz9H9VyJie8dc3pisn?=
 =?us-ascii?Q?Vaf1H1CjJSPCXFp/g/isxP+Gh4wspzI5S6G6qqMjY2ALqNYVUUsNhn0UyS/7?=
 =?us-ascii?Q?Omg5e5EVK+TudX5Duo/X3ruYy7IWb8hJbwcNKjP7YSOoikCE2BPlL5cecVhF?=
 =?us-ascii?Q?uZcEWziYv+KNSXL7w5ibnfB4pJfyH9u4obZoXrcdiuqVs6QEgXfQ0+mwuSm6?=
 =?us-ascii?Q?Xm8BsgXcqqAracTZNVP3z8iES/j+jinOanFD1MBCiwmx09JjjUzAJEB3h+A3?=
 =?us-ascii?Q?HepOVO05p94zdIAYYeQ4/DHMCRR+Tpe90G4vpD5ZlwYCTnOLk7JBAgscDO1x?=
 =?us-ascii?Q?Q1Zu1x903PuyZSiLAhl89v8r2oO1M+gBlKhNgDPQpJnXeEBo9W/QIcCCn0Lg?=
 =?us-ascii?Q?rc/7v81QtR3sZd9WTn98CUsTfPINJQdabV1CSSjBTuvRahFiwgD6R7hVmlQZ?=
 =?us-ascii?Q?TJna4v+ovhhyu73xoYTDXQnxIZof5On6ydaDJgGNOpiQJlgJxSfs2+54qa/D?=
 =?us-ascii?Q?b1s9gTyxmEu6x0Vf+luvzFwCDZOnnyq4zXhuQqngpTX0n9559Tute/J6zj42?=
 =?us-ascii?Q?LUTXqBCCBkC2ZfSUAKitJp6eYeq516gGFw5DYru9qxmriXfh7uvDz9rMFZVA?=
 =?us-ascii?Q?buD5dvGpWVIDtWp1NQkwSg+aax2A77db847Xq+XpBt84PXms8YT5gHlDemt4?=
 =?us-ascii?Q?y5MKCNVHHBdbDYI2bvNvrKM4mVQVwT2as3VDkwY2FodSGYTE2sWSyFSOJkL5?=
 =?us-ascii?Q?Y8VcPLDKFIdgXxRbNiegqimhuJTesH4ZSxVB4PjPNHUM3F4cUt/V28BFu/Ui?=
 =?us-ascii?Q?ILp+BlPt9VK5igzmDS6pmP7odZSdlSPEYTfhgGbCAN/oy4NPldh2rksALBMb?=
 =?us-ascii?Q?Dn/xcVlfltFk0SclNq22vzHAxWdErWLZGBw2RhOsWFLgMyYDNr5SpZGILIBc?=
 =?us-ascii?Q?HsEaq+7OT2iulNXjjMdtSLgKGujVzvfN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1NixTGgrSdW4F2LJ23m1ulNh6Ijq3+hQBA+1ZvHl529zd9vMXYsZjYpw7h7?=
 =?us-ascii?Q?dMhlvMk3IbqW72i9c4I4mRCt2gR886P/ZFVrV6ffWV18CDx46nH9Ck3hfJUk?=
 =?us-ascii?Q?Az0J5Z0Ht03cgemGpQKcaeBltjZe533XpEINcOJMK/Oa72x/zSKyud45zqHP?=
 =?us-ascii?Q?pmhwNLjHxUHt2asC2kdSDeK6cFIiC7L7eViqj4FUupKnpbbBcWCad9Lvnd1r?=
 =?us-ascii?Q?32geXrnOVSnPFu3XsPQgJIOVQ1jCXhaA8x/QMBURFCpSQ69PLTpSdLrqdy16?=
 =?us-ascii?Q?CyatKmGEjOjlxuatv8JmVfFehHDq1+ogFp1Cz8fjHDYUm/1/i4A1kPluPBcu?=
 =?us-ascii?Q?gSqRvmz/ODAPGaamZnX1ZLBIJKHvoEfvYuNA4oS3k9hBXnfF8MSLwSoxqbo2?=
 =?us-ascii?Q?tddGSMfhz/dEYBqB8TKf8eHTgPLw+UAfJy2EEOCBaW0eMWfvqYRLVk/G7YcW?=
 =?us-ascii?Q?1yj7Oak3/H9VnvIk1uJ/eMCvqy193d0+JzL0Kwl88zb/Mnk6xb6yCV1pS6zf?=
 =?us-ascii?Q?vmJBq/uEF4QsylwwQiQnBKNwjOPibIQntBw4XLtTmdtf5WB8yTE5Fu+vH5lI?=
 =?us-ascii?Q?FAZNHfPVGUfySJU0skCnHPzUPeBDyxnJZiUWrppN3A8f9DtIKJBPxiHRVob6?=
 =?us-ascii?Q?8Kvc3Se4AkjCABCQ7tAG9NAiU3xmLu/7Bxrg+UYQKO9lVrmBoAuzIqgiakEG?=
 =?us-ascii?Q?dqb//QTpBom9hLHgq63V9IxoYdDJFHxau6K8q3orv1XXD4vbVbWITMkbWQiM?=
 =?us-ascii?Q?XvIpnLPp2IpOK/i2ZgkHtdvtfFSGHUyrWVj5tQtPov9HrZnafDlOioKx9GSg?=
 =?us-ascii?Q?tbdojNuhyVxHedGre8b8QOdn06IJTHJi68NMs7l9KUHJuDBzzzsoYgT4LDB6?=
 =?us-ascii?Q?JJf+c2KrB6lfjw/uD1HkHwER0GUCq2oHSsW9TutXt71e0VUV3yOuYphADT/p?=
 =?us-ascii?Q?G+CT/hv/QBBExXmuUubUkOM7ABBix87Fczk3+JIPqUt0ns36PGB624beWC6q?=
 =?us-ascii?Q?niBrkSzar/4L1+yZuTRE1Uofsomj75Rqq+urldVGKX2aPPzCMNoKQbRQ0Hez?=
 =?us-ascii?Q?GyQVCUANN34X6BZ6ls+NBrd/vEIlVOS3msJf9ATBbSc/NERGTse2TFtjqIOM?=
 =?us-ascii?Q?6LzX8gaV6DJD5hgeOY/CwJ8Y1uBOiF3DSkqYlsbd2ZZyf3UhXwaYyRzcmag+?=
 =?us-ascii?Q?fvQF3qmDRuXtjC+ewVTganx8hcoQdaHg7DkZPhkQKsPXQo1WxZrWEe+3LEoj?=
 =?us-ascii?Q?mdx9jWuLDkfKWoeOLCmQX4sqiBHHuJGcc+qhExsTRYnWECgnIFX7Iv6mqa//?=
 =?us-ascii?Q?dxF5StOzOJM5WFrxJKwllhDIJt0ESHYZ2hEnKuzv4Lq9LNLgTlKrWOE++PUT?=
 =?us-ascii?Q?e6qJoyZINz0B1C8bFEkM79Rg7xosUntPxcKzRPg0JEalYpOkrBkS39E8ykMv?=
 =?us-ascii?Q?XKG2o0nUEbi0e9CPypFT1OzR75V63cQobJjIoGm3Nmq9KkgPKocMjP57koAa?=
 =?us-ascii?Q?Qq4VNP20ARQ3SO3Bou61tbIItckL95svv6tFLlXdnWPaRjLprdu2ouF7Hi+Y?=
 =?us-ascii?Q?Mwkz9tErf+VCY+gugSvGW8WsvH3vcdEfwIJAM9DdJcpWqmMsUMSXgOMw7f5q?=
 =?us-ascii?Q?R40yFIccK9CfGuN7M4BKoJ8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: df360f69-c2b5-4db0-d08a-08de2f60fcdd
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:33.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny9gysjUYL8dr9k+tLSGMFHnql60jcOFxch7nptWt8uOoh/Y9JDYzCO1jm/QUTiaHU0FhwjRHwfr0NBn8HstaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

One MW can host multiple queue pairs, so stop limiting qp_count to the
number of MWs.

Now that both TX and RX MW sizing are done in the same place, the MW
layout is derived from a single code path on both host and endpoint, so
the layout cannot diverge between the two sides.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 79063e2f911b..5e2a87358e87 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1015,6 +1015,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	struct ntb_dev *ndev = nt->ndev;
 	struct pci_dev *pdev = ndev->pdev;
 	resource_size_t size;
+	u64 qp_bitmap_free;
 	u32 val;
 	int rc = 0, i, spad;
 
@@ -1062,8 +1063,23 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	val = ntb_spad_read(ndev, NUM_QPS);
 	dev_dbg(&pdev->dev, "Remote max number of qps = %d\n", val);
-	if (val != nt->qp_count)
+	if (val == 0)
 		goto out;
+	else if (val < nt->qp_count) {
+		/*
+		 * Clamp local qp_count to peer-advertised NUM_QPS to avoid
+		 * mismatched queues.
+		 */
+		qp_bitmap_free = nt->qp_bitmap_free;
+		for (i = val; i < nt->qp_count; i++) {
+			nt->qp_bitmap &= ~BIT_ULL(i);
+			nt->qp_bitmap_free &= ~BIT_ULL(i);
+		}
+		dev_warn(&pdev->dev,
+			 "Local number of qps is reduced: %d->%d (qp_bitmap_free: 0x%llx->0x%llx)\n",
+			 nt->qp_count, val, qp_bitmap_free, nt->qp_bitmap_free);
+		nt->qp_count = val;
+	}
 
 	val = ntb_spad_read(ndev, NUM_MWS);
 	dev_dbg(&pdev->dev, "Remote number of mws = %d\n", val);
@@ -1298,8 +1314,6 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	if (max_num_clients && max_num_clients < qp_count)
 		qp_count = max_num_clients;
-	else if (nt->mw_count < qp_count)
-		qp_count = nt->mw_count;
 
 	qp_bitmap &= BIT_ULL(qp_count) - 1;
 
-- 
2.48.1


