Return-Path: <dmaengine+bounces-6947-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DFBFF909
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C224A50061F
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51D2F39D0;
	Thu, 23 Oct 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FqjXv3vW"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3D2F39BE;
	Thu, 23 Oct 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203985; cv=fail; b=aWcwncZhPKo6HMfXyIpL2EzsX+8m052htfMSs+4/jT0vFRhF2sPPXrJNtMvS+Oh2ihy2Gm9v385lP0XxODieJJzwojOhfp817ULeABhvQtI6S3zOQHvOos44oEIv+k93tI4DoFm2jzlpTb4HV4SOM2rtcS2ShkEma80QkwQ4WEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203985; c=relaxed/simple;
	bh=/IoB0AkrbcDupR/q5PJoYcwbGmUiJ0mVeKxosiYXDLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fe3wMWn6zhBWQ8Lk2EPTh5dnCR3VlECQKg4iEpDpq8EE/Hb5hJE4C50YWaK2TF6uoHwB/XoOuJ4u2xBdaS2QvKoNzHsz2xJoMysYe6CHH2Q+c4Riw1P1f+16dF4Xg9P+wHpmbVvdYZ38E9ZHXunNo4jLkjznVMinIjnTKMkevDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FqjXv3vW; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVQzsNfDUkrrD5udJN0nKrRq9M8vdC8wd5RMeBIBU2U7y4cYRce+/taIqzbD41HDmZ9qniSgEAv7Vetcq4J6nyaV7AxgjP9SYELB316z5dzETcbDWzLyr2ngk5Dr6AsVULwGXyF0OjnOlZG/Kypc7kalZ8s10/sF2DEdKpG+1vJ41GvpqMpbdEUycU1JEXTWQllAt39rne0uBTMb82EVEYJ5PiIknDflxBbD31reyS6KRwqGUTRALrynRUwQavPoLll+vpf4SCxHhbkQ6zHxtq7dI0j8czCqUJwrln7VV359n5dYSmtEFm5YDk0IqOrEiy2rPnxYBvAXVvSTOZVO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDgi9m8MlEOrHXRPmxzUoGNgDV3BqJrwMznVUN70AvU=;
 b=DjR4jg8KK499+qVIZaoZ3LPvSzS6kV+shtrJ1ddXnmfelR9z4REh6PZbWbied6aCDtVR225/KklyRucg0XexMckkTmUaRjxl4Aulhilz6MPq1uCimn+jJIhWfm1JwxvFFGJS/U8lMz1CvZ5FqiPtKevsHgRuW4FFftRLkKWk9var7jLM+BmZcMmwmIv6SU/SwBxYieKJzxGmuAn3SzcFyQGwk8BEzwTuNGL4C+MGnMnG5xY/hYqbgCfkE18DQ0F6+mU4aWC6MkO67GViO2IXJcUY2TMwOeE04ThMHiGJSds2yZBDfuORR3RkjJhzw3w2JesQqeyrer7HB6VvCBz0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDgi9m8MlEOrHXRPmxzUoGNgDV3BqJrwMznVUN70AvU=;
 b=FqjXv3vWbI5ulDONIZ/D7AhzOmzOvlCEsXBS046GfIOkn4yvlMY/Q4uEnLe2wYB+XeSBfvl2mm6o5PjcVhy9cKickIRBA+N5HLjmcDqfLhec7KxoXmIavlJ7M9R6FSjzcyThbSIkdwNg0eLjnNv1NlPed/9b+P7HDxkia8PY/C8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:37 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:37 +0000
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
Subject: [RFC PATCH 12/25] NTB: ntb_transport: Stricter checks for peer-reported interrupt values
Date: Thu, 23 Oct 2025 16:19:03 +0900
Message-ID: <20251023071916.901355-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f411ce6-5921-49f3-7bf1-08de12048623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfpEBFZPmTjWp33E8bn1THbK71Xz3DBcL6hTJWGUbwjbGMDHOrh9YIL3mTVW?=
 =?us-ascii?Q?Yb5NBPAQOzRoE7+4lTn+deAnd9juSRHm56/3UwZvq1JmrbJ0/Gq0yIUxCuEO?=
 =?us-ascii?Q?5TgYslvBkSS4bC7BZd2h4g9Wmk2UL9tSTGzJ3FzIzQ/wKy6Of+B2jCQ4ZThi?=
 =?us-ascii?Q?5XkN6aluH1rCXiKncIxJ4UMZF3CyrbhxhLz1gDs8HaKizYDFQ+WtOw9M1Cri?=
 =?us-ascii?Q?QvfSbjp3MZxgC2pUg3Xm6WBw/zRYU6FMmGNKbCD986aFYQ720nD9QtpU/lQG?=
 =?us-ascii?Q?pbfUrX1Fe1w7RGe4wCpMRFPtVCTf4Tg7pFli4PjzjUsIKBICA1QG9NSm2tWx?=
 =?us-ascii?Q?cdc49UHAZ35lgWGtMzojDn1ygmnIQOYsQPJ894SZqvKY8aae36zyKhszFqky?=
 =?us-ascii?Q?G9iSxG7cf3BeJDziLFCKnMgUUvSwVEa8eg32UiGzz3mxBleZ5bWKsBxMBqvj?=
 =?us-ascii?Q?m9+DTi3ae2T1BkT3pk28z7qcVAdunFPKkB1xtmWivEBjXfb3YO+ty/+nzuEJ?=
 =?us-ascii?Q?LudshQT93kAliJ4y/CrUVN3OFW3IrhuyfHgRvDtkDI/3q9uBOb01EyC8slAY?=
 =?us-ascii?Q?mGp9B8uumjysADrfGZHubx2sLBWtIWi7u5/VX7RuXx0ahhbX47sF5Z98FC9h?=
 =?us-ascii?Q?CYuBPO/WFYq571JcOg1Lv8gFqktYpWCFKq1uvix+tog1VC5YxfwQe9AJcnVD?=
 =?us-ascii?Q?kzCajK6FGRQVu2cy+j1Ai8I2mQf80a/pQv0zybUXbYMKgQ30IG3DTtT/9HE/?=
 =?us-ascii?Q?9l/HnmDpzLXTcm1jbZdWsJLix90kBTbEACPdJ/NjOASdzdaIy97porfJO5RV?=
 =?us-ascii?Q?62XTjBiwCB2HfHZacDcbdh07A1Sg8d/XMaF5EwcwWSV3rDgJbsUxSyW90TqH?=
 =?us-ascii?Q?NL3QtyAVH51cBt9tUKACTz5vdNIJhqipWZ8n1O1wK0OZWUXz066tbotMLN0Q?=
 =?us-ascii?Q?ux6TBO+Iwjih/h54FaISV/PUI6E7vZcjfimCigekJer9/i9TEntTJ9rkSLga?=
 =?us-ascii?Q?/rv3iNRZgVEM4lnqJvHTHyPRIa5OE0CxbSqFuWMs3pBlDlS9jBbxt3s++suT?=
 =?us-ascii?Q?UGfDkzweqvFXEi/pV6r7GByIvgu2W2tZivvNaPeQBbCNiYsPlm7WSlj8GpvK?=
 =?us-ascii?Q?2u4UNxzGGxzpOboooAMfj/2yKs2gTzv6fV34bhMlWWwZ7+NMd1OYHPN42E8Y?=
 =?us-ascii?Q?No9HXs9YS5DUmb8tA23S3jXrBaJTeRy33jP6t1WdhaA3IKkp5BS1wod7GaEH?=
 =?us-ascii?Q?D9W6a0M0RNnd5dK10qtwwDT/l3PQAErs7V604DU147vaaDMP75VCpxNFPi1V?=
 =?us-ascii?Q?2T4AG3DeR8tZD9pLr7rOTXwD8YNNSXtVz1za4xG0+DDV/NS07kfABcmyZNag?=
 =?us-ascii?Q?hEs85gXfQsyyq9bcrlgkn6bJitkMPJ6rIssMMY0dB0eaeHiSEDjEhG2kG/Lk?=
 =?us-ascii?Q?/fz6E5Y6tBtWDhZdfzUPcKvsQsXN7UeF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9vQKmRhpNq1J/2WFNyLWGA9TgYRRdUC51VfCgEoaIXyuyQCGqlj0WYoxI+nI?=
 =?us-ascii?Q?ieKqwRCbivvybo1b3NICIe1KBfdsoIsXZRuObYH0a2PVyO7JvtwVYTn1Fy2L?=
 =?us-ascii?Q?yZSjeLPhOH9bKigqw7tEoJ6MnLvNcpfJRkMAKPjwaTuSSVGRHE/hPfyjCxmE?=
 =?us-ascii?Q?T4Eg7K0/vOu7HsihGrg7dMmpPEbfeyqLbEGE+oBut9iRsM7gC7AHX7bC+1aD?=
 =?us-ascii?Q?MGuwzLeM0eejy+eWiq5qVUUbmjPBjPkAu0wKSrWvQ+G7JAY7XvuNIy3aruT5?=
 =?us-ascii?Q?1y4fzAi1r9uhMq/YmtLW3t+/V0UkC9U1G69+PqXBqAf18TqDqF5ZF2qlzxiW?=
 =?us-ascii?Q?LxHfKRDGJmoPNy3bk9/Fj4a8XqC+39OUHeT9shhTg4nfsQ3w6aRkdDMalznp?=
 =?us-ascii?Q?xCLCgZ/InW/m/+7PdzMGf5iJ54rabAmmB4nHkkkpwqhjIEyvNRR3yNO0gIZS?=
 =?us-ascii?Q?bOfZtFuf7HCs9h9XS9wUzfL2LBOSPywDuvIwyJP983nR4ok6vY9OXooo2K7n?=
 =?us-ascii?Q?fcuZIx7sJ4LDXBOUFEy8Cbnj2dcng030nZJgELh4AB+XqznJC3EhnaxdbSU4?=
 =?us-ascii?Q?9TRH4QmWoUAX5Zv6WtX70h7Cs1zaEnCYxWIzE2MaaRP8Nd951vTNUV7+nUut?=
 =?us-ascii?Q?jWYNn/PADWMzWxppdy1TaGolRE1bdKKx0zvL11SDoCHK9Ok2Qjmb05GSD8Aa?=
 =?us-ascii?Q?fLW/ZhrHJut7PkNOlceLuFsR7ineoZEtrboh4LvIGiM6y0Ll4imYnNiOSeY6?=
 =?us-ascii?Q?9gOUNUoMagaaTpCEXpe//kfphMBucNa7Iok/gwMDRL0NtfXziCIg8rcZ4qBg?=
 =?us-ascii?Q?sB/GR1JPaFuJZj7CoWylXyBCFL82yK8l2GXnSVgRNZdv2iWjWl20IUPQqXAW?=
 =?us-ascii?Q?V3DzYkxN2LbFRRDX1rGz4BpRwBSIbBxmGAezBplhMOp8i7AuXwH5n1T1zoiH?=
 =?us-ascii?Q?0CrUWN4QEvWqVxfh9kchWRtcfR/5IhKNMjDz7rAVLxeWL/25hAHj8zOVSJF+?=
 =?us-ascii?Q?ktz8NfuqFEhYFj/HUZM538mdsDCLpsp6XsQ66JMsoM6RI7KI7kxnDpxlybx8?=
 =?us-ascii?Q?e0hCTtxVQX0g950iPchCpzc1Vf3NXR19/dmJqUBxF37KArmCoVURPJsN+2tE?=
 =?us-ascii?Q?fVdM+OyzQbU+BWVO1JH/vSI2pLNQnCMjGh4MyWbFuQHdtU9oWVZ9ocfYaJSR?=
 =?us-ascii?Q?aAZU4duL5z69flF4FALENgNyHkrvrB8qSDt8ntxMuVNwDVp5Y3AaUuA9kNLW?=
 =?us-ascii?Q?3wx05pFlD3WhA/UZJ+oKomhZJBN2UaMhcbVyMCZNOF/bXK/PJfMfq7yqmaUt?=
 =?us-ascii?Q?34InZb0msx/YEQ8aoIqYvwslr8fRojK5QIyZw+32IJ4fgi64Z9asGn/faw6J?=
 =?us-ascii?Q?dHk01qmorlHcjIBVRT6Qa+IPX7SMZvAiKW2WqY81L6s3OMDVFpnBLT+942Qr?=
 =?us-ascii?Q?w9m2CVevw9Ghl4TXt1oF6+hC/KEWCulNaiBlj93L4Uht4t9eXk9Y0v8RB2cF?=
 =?us-ascii?Q?+4fKIdJzNQuC9CH9KxduXcRgoNpmE7ERUiNQYDSXXkcjU7+ysHt/rcdfPIuf?=
 =?us-ascii?Q?WCUq8yjXaJyg6bNG+mlE3RNom0qXA3Alj2508QvNtI4epiGB7lbk3Ov0ZOvY?=
 =?us-ascii?Q?QF5cJcBUwHDzLm4RZ5AuiBE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f411ce6-5921-49f3-7bf1-08de12048623
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:37.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waHRlj1FGf6rEotaGS02LBJM/ZAzGwkTdsZKrLqbVKAqJ7g5gyBa6k9FKtVPJUTOHebn/crzVL17R8lV4nxmXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

addr_offset and/or data may legitimately be zero, depending on alignment
constraints. Introduce more clearly invalid default values and
strengthen validation of peer-reported ones to prevent false rejections.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3f3bc991e667..d9fc450ef497 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -69,6 +69,9 @@
 #define NTB_TRANSPORT_DESC	"Software Queue-Pair Transport over NTB"
 #define NTB_TRANSPORT_MIN_SPADS (MW0_SZ_HIGH + 2)
 
+#define INTR_INVALID_ADDR_OFFSET	U32_MAX
+#define INTR_INVALID_DATA		U32_MAX
+
 MODULE_DESCRIPTION(NTB_TRANSPORT_DESC);
 MODULE_VERSION(NTB_TRANSPORT_VER);
 MODULE_LICENSE("Dual BSD/GPL");
@@ -715,7 +718,11 @@ static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
 	dev_dbg(&qp->ndev->pdev->dev, "QP%d Peer MSI addr=%x data=%x\n",
 		qp_num, qp->peer_msi_desc.addr_offset, qp->peer_msi_desc.data);
 
-	if (qp->peer_msi_desc.addr_offset) {
+	if (qp->peer_msi_desc.addr_offset == INTR_INVALID_ADDR_OFFSET ||
+	    qp->peer_msi_desc.data == INTR_INVALID_DATA)
+		dev_info(&qp->ndev->pdev->dev,
+			 "Invalid addr_offset or data, falling back to doorbell\n");
+	else {
 		qp->use_msi = true;
 		dev_info(&qp->ndev->pdev->dev,
 			 "Using MSI interrupts for QP%d\n", qp_num);
@@ -723,12 +730,18 @@ static void ntb_transport_setup_qp_peer_msi(struct ntb_transport_ctx *nt,
 }
 
 static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
-				       unsigned int qp_num)
+				       unsigned int qp_num, bool changed)
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
 	int spad = qp_num * 2 + nt->msi_spad_offset;
 	int rc;
 
+	if (!changed && qp->msi_irq)
+		return;
+
+	ntb_spad_write(qp->ndev, spad, INTR_INVALID_ADDR_OFFSET);
+	ntb_spad_write(qp->ndev, spad + 1, INTR_INVALID_DATA);
+
 	if (!nt->use_msi)
 		return;
 
@@ -738,9 +751,6 @@ static void ntb_transport_setup_qp_msi(struct ntb_transport_ctx *nt,
 		return;
 	}
 
-	ntb_spad_write(qp->ndev, spad, 0);
-	ntb_spad_write(qp->ndev, spad + 1, 0);
-
 	if (!qp->msi_irq) {
 		qp->msi_irq = ntbm_msi_request_irq(qp->ndev, ntb_transport_isr,
 						   KBUILD_MODNAME, qp,
@@ -789,7 +799,7 @@ static void ntb_transport_msi_desc_changed(void *data)
 	dev_dbg(&nt->ndev->pdev->dev, "MSI descriptors changed");
 
 	for (i = 0; i < nt->qp_count; i++)
-		ntb_transport_setup_qp_msi(nt, i);
+		ntb_transport_setup_qp_msi(nt, i, true);
 
 	ntb_peer_db_set(nt->ndev, nt->msi_db_mask);
 }
@@ -1068,7 +1078,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	}
 
 	for (i = 0; i < nt->qp_count; i++)
-		ntb_transport_setup_qp_msi(nt, i);
+		ntb_transport_setup_qp_msi(nt, i, false);
 
 	for (i = 0; i < nt->mw_count; i++) {
 		size = nt->mw_vec[i].phys_size;
-- 
2.48.1


