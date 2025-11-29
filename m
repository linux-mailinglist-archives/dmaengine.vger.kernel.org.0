Return-Path: <dmaengine+bounces-7404-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C9C942BD
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 828A134CB0D
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E43164AB;
	Sat, 29 Nov 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CDLCyyFQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011045.outbound.protection.outlook.com [52.101.125.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA8315772;
	Sat, 29 Nov 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432289; cv=fail; b=mldCkTSIvsPPPY4+ZPK2nhgbRx5Y8r5BlrwwsYvLBDIUTYO2tivvkF7DErKLbqB0SE4Ca2FYBc7XCIViOz7EZ7eIl2TBuGKF55N6nbqnFpZeR11UYg4ddFZGZbVzq3tdjwmUUiFK97ySfl5b/3uxfMBycwcIJO4FOf9P299ScxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432289; c=relaxed/simple;
	bh=fiMBDRUYfBs5rSBrbw2nIMzIiU8A7GqGLImVVIEMXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MiplRxATYAUczbgGo5xKxJppH9D31yHjbw1JNoAV1u4SElLNQ0p+IBptlcGNB3O36Mil56Re/0tglUld9CX627O5GaKZDFkkZoQLftm4AYrFTWRAySNveTDq+hh24wuCopHmQnYTi8wkrRG+rcFAE1SDTcM7uwA6oAMYNCy5cfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CDLCyyFQ; arc=fail smtp.client-ip=52.101.125.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeqXqQXFoWFKp48vzSNDR20gFIa9ApIkyCvxe84hc3iSk9LPFPdsXIybn9HNRtQRILop0b7yH4pWZULeceWpItGgcJokFJAXpGahhyW/M0yopVCyKFdSXJcesLELQpESVhgyPd36rI8lPfI0KylaRMbg/YzKtYHABSNJtGz47V1oq4YxiPi9I99GRyCrYZAdk0HdvRKqEws7BbqN+WtMxTUi38xhghi6CNykSFjj9iqILnnWpA0wODCqB8Ju9RgsNXvr+7i8S+Q506bs2RMj6zasiEdzLZRYv0NFJCBwjAoejxKqLAl2fLrox7kdt7j1p/lBMJGrQPsXepV4jMfHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap6JZbXQ4PKlbN2HX6+P+lU7vs3MHQP99YGzQzy0Bho=;
 b=QWId/SPnEIp4AxnnKsuNBOcBUQVHw8n3hEFWtWLAYiiJCVHjrk7GBUVUPQ0u+oBVn6ayUau4a/vF4IHn2F1hxhSrxPP4lvtYX3uXMj0Z8QJt4Uz5ynNP+WSQjdo0Y2AOyDzudgVFjoJluKdCrkHskBVwo+TojADYxt1hDzEs2coWaA/J0dZAP5Rpfs6/+spAM0YVYCKnR5mjiEhn4yUkUKQfZvZ7lapRny7EFW1oGGw1nMdt2ZwEoJN8vCz29I1JGyBgrdMDyuMnZ1V/kMFkbv8z/cMcgD4bxFNd6y9BH0k1GYcMcPOiW96QyLL1A46vLYObIG1ntHqyzhXm5socwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap6JZbXQ4PKlbN2HX6+P+lU7vs3MHQP99YGzQzy0Bho=;
 b=CDLCyyFQWaMmOInc6jyvw7D2sCXbfdLHC079MqNGKI5nPs8XX2A6u4OqleodNLEt6/LmQ9vSa9MCkc2wZoFtak1weO6fO5EKkXNbxSuZ7WTYsFA10dNq7rzSTB6e0QcnjTcBnkYCtM4ZOp6tD/STbypcCbQjdXJLYE/tSFCm6yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:37 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:37 +0000
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
Subject: [RFC PATCH v2 18/27] NTB: ntb_transport: Introduce ntb_transport_backend_ops
Date: Sun, 30 Nov 2025 01:03:56 +0900
Message-ID: <20251129160405.2568284-19-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::16) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: ef642ad6-de8a-4295-f182-08de2f60fef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8MT5mLhMoRvVmbLxPZAKlV2UyVG9HNK4hsAosfa+SPwhJ5XlWLR2rotK8WD?=
 =?us-ascii?Q?1B+su4qxn4eSMlrHIEbcl0jrMM+Gd7ih1AHBmp11lcWePCcHwX/aC1zetWGo?=
 =?us-ascii?Q?1HioPjRY3nz9waJDV4thVZJZwGIC2QxdD2LfpEvlxRVDgf6JMrsXbHv3jqgF?=
 =?us-ascii?Q?g4umWEqwz7G/+0WfeIn474InfmcfGKratJxzZNdZnlO6W6JbUuaX3cK0vC93?=
 =?us-ascii?Q?wevLrQa+GSZbRMNAM+u50cMgqeF3ECSFnebUOpMu8vS02A4gdFxfSSGCNh8S?=
 =?us-ascii?Q?GWKNQ3SigaWnAzktk2N6lC7S/6v88WMgWNo/BLAKb2wECfp4Y8cOD36Syh6n?=
 =?us-ascii?Q?cFRV7klxPcbJ2VPjk8IEIg+zUvyIJXJWGu3VINQZ9UGofGEQ3EgSPdz/mjix?=
 =?us-ascii?Q?rKiS1/QISC9lxkCy7acB5fniSkeBIGymSfR0kFkA0vhbllFB+ISIXSu/h40E?=
 =?us-ascii?Q?GgsMjTmQziyuCFfzcA7UIQjTvsxbWbmS4/KBHXzTYkZ7Fg5Fs8G+pSB6WLXC?=
 =?us-ascii?Q?Y+t2sVMG6nKBaLElbtIljlPM1UXOotNbNflSdK/3vh429vcFN8LCxR5F7ZsI?=
 =?us-ascii?Q?JdzjSHnWMnM2MK/yy3HNC3LJFPo2mhQh73mTDG8QgyNS5Fh3SePGnytSw1wF?=
 =?us-ascii?Q?/f5l1NdtF2eGu3z+vr+OCCO6Yqkzje06uomou9rovkbm9JSpE/jfrVI+VRBO?=
 =?us-ascii?Q?We5Bef11+xlLhGV5FP8bCQq5RpNu+oJbT1Tw1dLja5c3liCY3gx39zdIdBfT?=
 =?us-ascii?Q?70F7wRpiYZY+c/2JD4o3R4AeUzQSbHh5iSTVgh+Aeft1ORHOjvmhqd4tQj0m?=
 =?us-ascii?Q?XDQF49qjW+u6R5FQK+H2hYVR/fII1NiMRJUTKSuVXvLzrMws3FkZupU/JYkA?=
 =?us-ascii?Q?raNETjA4QvtgayaqqR+GXfQ4B03g444peaGbl76otGIMy1UCzSRl9lHKtqs3?=
 =?us-ascii?Q?mUd/aU0SLVu8J6b5HnE76KUo5X94VOm6vg5Y96/o/GW0syn3v6LOkyrSAA6F?=
 =?us-ascii?Q?yIEvWOViMi7ftBshA4h/qQkm/PgVn+MgxqJU7enyAz3g+aH5AmH1o4OWRxj9?=
 =?us-ascii?Q?tVaS5YS6CpFTljnxUjhAyR609XgU6Y4WlRJLBdNjDIv28fLQGi83HihcZOHU?=
 =?us-ascii?Q?+3Z2sOuwtcT5YHELJVDRA5IEYdfv7qL0I3eQcvKBVmjSm5xv3fjtSqRi95vF?=
 =?us-ascii?Q?VLsfrbd/41mue4Okq89OQsQHqpnOKchEclyN7UsoalBIZ8g4Kppykgrmek73?=
 =?us-ascii?Q?4ALdzgI8zJk/l41omZXuGzEQolm080XnkL+SBok8XMrIMeKaXVjxiZWLgEUA?=
 =?us-ascii?Q?XWaTFdKUI6+XXhGYzgDl8oH3ElHZddkTin+pJHbh6Ne6oURMHUcgbAv5wRi5?=
 =?us-ascii?Q?wDtL/IPr/djicdvlLkA10O84jcguYj61F7/gMQQn9rX+MwaZGXiJeWjm+e1g?=
 =?us-ascii?Q?Xt0skHI+G8MGBVs9oj0ILQXIs/mgo5lr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0qWKP3spIw7vuMm7b4ah2m3+LPVcet2m/mbBeOJ+SgX6yI/YIgmpyZ180Rg?=
 =?us-ascii?Q?eYJfn8eswYvGlOoU4bLNM/RsMVN89yNxUKvCTJogxIpWEBD6RZvPmetZgyZY?=
 =?us-ascii?Q?EfXLE2wf4nF51KbB6pb6JRA8OTau4dSA2CXwya5itymcBDi2iP+XJ04qBX7V?=
 =?us-ascii?Q?/CFL+A5impxPr+3zcJVCR0vyImCH+y3iOeRbfBBe4lgIfZIFu7xE3+1sgObQ?=
 =?us-ascii?Q?Vh2uvwE+8I+W6D16+rpe+kYx2zYAgjE+sUlMcIiHtZEAjbAKfK6rTn7pvYMM?=
 =?us-ascii?Q?eC9TNGQP4ATTtPBpn4MCVOF7V36eCQdxGjn4DD2wzhgRIfyL75IqRLsWKZSe?=
 =?us-ascii?Q?iI5X8uW0OsRMbosz6qEOrq/fV09thexCdhqe8hhPaf/y4jL2GofIJfMeVwkE?=
 =?us-ascii?Q?6nZR+V/n3avPYu3sF0sy9iLNxsDkCUc7U2hPyrMfwpHHL+amgjEIZaVSz+sR?=
 =?us-ascii?Q?eRB+5PBWSt25NjzWDgl1THzMT90j0uIMb3MOmj2eJ9OzGuE1pfILzrl8WBl5?=
 =?us-ascii?Q?cLaWufIpMxU7ZXG7V+5JBZaVnWjlS9IoUQce6XjmXGeARvACqNb3BQ+DlY+z?=
 =?us-ascii?Q?8pt/TND5Q8XpH8TMCkZu6N2vJ+3Xb+yJTCadplw9R4bbX+c4nWIPR+In4Kpb?=
 =?us-ascii?Q?ZBg1nEVO3A2ZGksn9oUGgcqNBePyM0wOW1hKqI72ii23e3PhKWxKmUfWsOqU?=
 =?us-ascii?Q?jYx6UZoHVIZTY5daXwvt6p6xlu9rtmq42+frCLaHPN+0guyfqa5Ke/7HrYuZ?=
 =?us-ascii?Q?HbI7zcXAl/UCrziXOUvhyEW14YCH3WpLERkQZf4XnoR9+GCM8eDaiYwYqQFK?=
 =?us-ascii?Q?b0xsgiarIQfY/SnwUWVmjGNKfQH0mZpt/m7LDi9bc99R4PJXDbXL6Jr2SwqA?=
 =?us-ascii?Q?+6FzNiyuuQ3FXBV6LOMvsxQpl5YfeRCr72tpdlZoT4yzWDvOWGoZx0LnZu4a?=
 =?us-ascii?Q?cZfsFTHhOlZ9qeF3/W/9MnTPlRImhdfsd795v47ws83qj9wJx32RkQGBDFVC?=
 =?us-ascii?Q?Rq1aHmyYFqjy/QZFSyT+cvfsu/fD/FJxFaz1hf8WC6duWvkCOuCHBxi7snhi?=
 =?us-ascii?Q?KZMOeBQSLcSmENAtZa2hlHAaXQbvJXAAZY1DWrGOFz35SqHNI3eRCPqc/cr4?=
 =?us-ascii?Q?DmPW+86ChYhCetxSfDp1AhyDw8sXHacjrkFmtVbRx5JLgy0MN3T+FxaQkDY3?=
 =?us-ascii?Q?vc2wijLWfwy0H0eTbEfcCYFZQ36ENBPCEULMeM9Dv6sAfsw+uyb743C59a0k?=
 =?us-ascii?Q?rJazsQKLKDtGe5ZGLmakncSqbm0kV+oQnVpin1CgPRQnZOtQ9692Xm6YlKxV?=
 =?us-ascii?Q?1nrqLWceS94iwaqztgWN7kiLDEJ/3id9p01aBZYGmX8rKQvDSVblPGUiqqKv?=
 =?us-ascii?Q?/lSPBsZt3oGqHTi2lRA/DA3hHL5Hl7WhAfUIErjfZKGGPZQ+Fz54Uu7qBYKc?=
 =?us-ascii?Q?HQP1YleKRIcQk36d1npK6yK1sj+/7/fUG8viZqPYpnwlllZ3z659t/FaBKwy?=
 =?us-ascii?Q?ZwfmQLFozq0SmJtpNjKUavjqkbNrZrWWn6L1TRcn4XiozWklH7moMKLyUfbZ?=
 =?us-ascii?Q?nW1BO9XYSbL1R4zOm5U4Q7w0m9wNmly2xDQyhXuolBazB/s6ysPky+QNHdEB?=
 =?us-ascii?Q?Sy4f74rixOiSHHZmBrVVy0A=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef642ad6-de8a-4295-f182-08de2f60fef5
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:37.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrWTPZQCTV60ytTkBq4lzcSOZgczRFRYjhGhP2CD4EX3OulyVq9JLvu+0Vr0v7pLQuKk3siAu0N/3T/FceejFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

Introduce struct ntb_transport_backend_ops to abstract queue setup and
enqueue/poll operations. The existing implementation is moved behind
this interface, and a subsequent patch will add an eDMA-backed
implementation.

No functional changes intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c   | 127 +++++++++++++++++++++++-----------
 include/linux/ntb_transport.h |  21 ++++++
 2 files changed, 106 insertions(+), 42 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index dad596e3a405..907db6c93d4d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -228,6 +228,8 @@ struct ntb_transport_ctx {
 
 	struct ntb_dev *ndev;
 
+	struct ntb_transport_backend_ops backend_ops;
+
 	struct ntb_transport_mw *mw_vec;
 	struct ntb_transport_qp *qp_vec;
 	unsigned int mw_count;
@@ -488,15 +490,9 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 
-static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
+static void ntb_transport_default_debugfs_stats_show(struct seq_file *s,
+						     struct ntb_transport_qp *qp)
 {
-	struct ntb_transport_qp *qp = s->private;
-
-	if (!qp || !qp->link_is_up)
-		return 0;
-
-	seq_puts(s, "\nNTB QP stats:\n\n");
-
 	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
 	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
 	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
@@ -526,6 +522,17 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
 	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
 	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
+}
+
+static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
+{
+	struct ntb_transport_qp *qp = s->private;
+
+	if (!qp || !qp->link_is_up)
+		return 0;
+
+	seq_puts(s, "\nNTB QP stats:\n\n");
+	qp->transport->backend_ops.debugfs_stats_show(s, qp);
 	seq_putc(s, '\n');
 
 	return 0;
@@ -583,8 +590,8 @@ static struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock,
 	return entry;
 }
 
-static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
-				     unsigned int qp_num)
+static int ntb_transport_default_setup_qp_mw(struct ntb_transport_ctx *nt,
+					     unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
 	struct ntb_transport_mw *mw;
@@ -1128,7 +1135,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
-		ntb_transport_setup_qp_mw(nt, i);
+		nt->backend_ops.setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
 
 		if (qp->client_ready)
@@ -1236,6 +1243,40 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
+static unsigned int ntb_transport_default_tx_free_entry(struct ntb_transport_qp *qp)
+{
+	unsigned int head = qp->tx_index;
+	unsigned int tail = qp->remote_rx_info->entry;
+
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+}
+
+static int ntb_transport_default_rx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry)
+{
+	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+
+	return 0;
+}
+
+static void ntb_transport_default_rx_poll(struct ntb_transport_qp *qp);
+static int ntb_transport_default_tx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry,
+					    void *cb, void *data, unsigned int len,
+					    unsigned int flags);
+
+static const struct ntb_transport_backend_ops default_backend_ops = {
+	.setup_qp_mw = ntb_transport_default_setup_qp_mw,
+	.tx_free_entry = ntb_transport_default_tx_free_entry,
+	.tx_enqueue = ntb_transport_default_tx_enqueue,
+	.rx_enqueue = ntb_transport_default_rx_enqueue,
+	.rx_poll = ntb_transport_default_rx_poll,
+	.debugfs_stats_show = ntb_transport_default_debugfs_stats_show,
+};
+
 static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 {
 	struct ntb_transport_ctx *nt;
@@ -1270,6 +1311,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	nt->ndev = ndev;
 
+	nt->backend_ops = default_backend_ops;
+
 	/*
 	 * If we are using MSI, and have at least one extra memory window,
 	 * we will reserve the last MW for the MSI window.
@@ -1679,14 +1722,10 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	return 0;
 }
 
-static void ntb_transport_rxc_db(unsigned long data)
+static void ntb_transport_default_rx_poll(struct ntb_transport_qp *qp)
 {
-	struct ntb_transport_qp *qp = (void *)data;
 	int rc, i;
 
-	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
-		__func__, qp->qp_num);
-
 	/* Limit the number of packets processed in a single interrupt to
 	 * provide fairness to others
 	 */
@@ -1718,6 +1757,17 @@ static void ntb_transport_rxc_db(unsigned long data)
 	}
 }
 
+static void ntb_transport_rxc_db(unsigned long data)
+{
+	struct ntb_transport_qp *qp = (void *)data;
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
+		__func__, qp->qp_num);
+
+	nt->backend_ops.rx_poll(qp);
+}
+
 static void ntb_tx_copy_callback(void *data,
 				 const struct dmaengine_result *res)
 {
@@ -1887,9 +1937,18 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	qp->tx_memcpy++;
 }
 
-static int ntb_process_tx(struct ntb_transport_qp *qp,
-			  struct ntb_queue_entry *entry)
+static int ntb_transport_default_tx_enqueue(struct ntb_transport_qp *qp,
+					    struct ntb_queue_entry *entry,
+					    void *cb, void *data, unsigned int len,
+					    unsigned int flags)
 {
+	entry->cb_data = cb;
+	entry->buf = data;
+	entry->len = len;
+	entry->flags = flags;
+	entry->errors = 0;
+	entry->tx_index = 0;
+
 	if (!ntb_transport_tx_free_entry(qp)) {
 		qp->tx_ring_full++;
 		return -EAGAIN;
@@ -1916,6 +1975,7 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 
 static void ntb_send_link_down(struct ntb_transport_qp *qp)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct pci_dev *pdev = qp->ndev->pdev;
 	struct ntb_queue_entry *entry;
 	int i, rc;
@@ -1935,12 +1995,7 @@ static void ntb_send_link_down(struct ntb_transport_qp *qp)
 	if (!entry)
 		return;
 
-	entry->cb_data = NULL;
-	entry->buf = NULL;
-	entry->len = 0;
-	entry->flags = LINK_DOWN_FLAG;
-
-	rc = ntb_process_tx(qp, entry);
+	rc = nt->backend_ops.tx_enqueue(qp, entry, NULL, NULL, 0, LINK_DOWN_FLAG);
 	if (rc)
 		dev_err(&pdev->dev, "ntb: QP%d unable to send linkdown msg\n",
 			qp->qp_num);
@@ -2227,6 +2282,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_remove);
 int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct ntb_queue_entry *entry;
 
 	if (!qp)
@@ -2244,12 +2300,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->errors = 0;
 	entry->rx_index = 0;
 
-	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
-
-	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
-
-	return 0;
+	return nt->backend_ops.rx_enqueue(qp, entry);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
 
@@ -2269,6 +2320,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len)
 {
+	struct ntb_transport_ctx *nt = qp->transport;
 	struct ntb_queue_entry *entry;
 	int rc;
 
@@ -2285,15 +2337,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 		return -EBUSY;
 	}
 
-	entry->cb_data = cb;
-	entry->buf = data;
-	entry->len = len;
-	entry->flags = 0;
-	entry->errors = 0;
-	entry->retries = 0;
-	entry->tx_index = 0;
-
-	rc = ntb_process_tx(qp, entry);
+	rc = nt->backend_ops.tx_enqueue(qp, entry, cb, data, len, 0);
 	if (rc)
 		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
 			     &qp->tx_free_q);
@@ -2415,10 +2459,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
-	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	struct ntb_transport_ctx *nt = qp->transport;
 
-	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+	return nt->backend_ops.tx_free_entry(qp);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 7243eb98a722..297099d42370 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -49,6 +49,8 @@
  */
 
 struct ntb_transport_qp;
+struct ntb_transport_ctx;
+struct ntb_queue_entry;
 
 struct ntb_transport_client {
 	struct device_driver driver;
@@ -84,3 +86,22 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
 bool ntb_transport_link_query(struct ntb_transport_qp *qp);
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp);
+
+/**
+ * struct ntb_transport_backend_ops - backend-specific transport hooks
+ * @setup_qp_mw:    Set up memory windows for a given queue pair.
+ * @tx_free_entry:  Return the number of free TX entries for the queue pair.
+ * @tx_enqueue:     Backend-specific TX enqueue implementation.
+ * @rx_enqueue:     Backend-specific RX enqueue implementation.
+ * @rx_poll:        Poll for RX completions / push new RX buffers.
+ * @debugfs_stats_show: Dump backend-specific statistics, if any.
+ */
+struct ntb_transport_backend_ops {
+	int (*setup_qp_mw)(struct ntb_transport_ctx *nt, unsigned int qp_num);
+	unsigned int (*tx_free_entry)(struct ntb_transport_qp *qp);
+	int (*tx_enqueue)(struct ntb_transport_qp *qp, struct ntb_queue_entry *entry,
+			  void *cb, void *data, unsigned int len, unsigned int flags);
+	int (*rx_enqueue)(struct ntb_transport_qp *qp, struct ntb_queue_entry *entry);
+	void (*rx_poll)(struct ntb_transport_qp *qp);
+	void (*debugfs_stats_show)(struct seq_file *s, struct ntb_transport_qp *qp);
+};
-- 
2.48.1


