Return-Path: <dmaengine+bounces-7402-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD30C942B0
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65C5F34C0A9
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F84314B93;
	Sat, 29 Nov 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="v1Bh3mk7"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D153148BC;
	Sat, 29 Nov 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432285; cv=fail; b=LRTAeMfi7Yh82ZFB5BJmvHSz0f2fxn8ooV4mFR/R8ya7Y8KSGl/Ui7GZ81nnXlFRJrKGy+cYNwZIhUgeB9W5LgLaNR4WCHnyqyqVemiG80eaLLgndNFWDXrMooLDGWahNhLZ/wU1+SOOXxD5dA5TMjE+KQI7TMgvaNX6r8tTNFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432285; c=relaxed/simple;
	bh=/Bu4m78ABjt1vaCPw5+WcrQBGGvvNPTdJ44NbQc2J2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNIVUzvh8Besc8GpAqp5RgjQRfpkv+6UnlNN1a8XmewHXzukBDEtSF3fJbZxVh2GgMdgRKmPaeqFzgsAlOxtQcqm1IJFn6ZoEnossNPEIQILppv7FlNE/xCNVvrZqwSUZKvukgNpz4B47oOhnRqqkoW+wBbXXAWXjHhMCIOr148=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=v1Bh3mk7; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI55h7XskYFjEWqeHLn4MUrc8tlRFASN+S4vmMbESGit29ut/46CRrSe3BMaREBA8lFQF74HKXtEhqkBOlLvJplpV/pJWxVf73q4SAZv2QVLBulP+8gezuzjrieIqAFHs8QShm4MWcKibBpZiaiIsmc3VBL+Zlp+ZBz7aEZ/rdWGvH0+PlsirQioMLvBzjEp1l4rmIGPVQ0GPDaB5zxMQdQlsuEK+bwSGGJ9LpnUZA9VQQNBn9yoO/sWWwNrEm6SIWMHQdf6OpZPMwP72CqUupLNa3rObfPhudBlcMQ5L0kie10OA7r/qlHq1IPr3IPhdHZjqykIuZ8KPusllPr3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAxbBQ+7fHRatyglL4TEtm+nsUfs+xFkMAG5MqEr+5A=;
 b=Tts2yKpPtqoDC30LKbv2wZaJEL2NvTnG/eSdv9Z628UEOOiHMz2eWVJB7ubSQumQYiNuvsGBCE5+8hf5TDTgor5GR154VU7nikRy2q3kIAZB0IPAKVkhxCkRf9pNa4UJBIAH+E3CgaRrPDzYXpblUN4TxjsD0E/1tuK9SeoBtBIChVFktPhZi6IS78gYm8CluRrofKwcKrML4gphkdDUvwVyFlpYuEsAulveeQWEYzdpF0DYPl4ugvy7fIhLqOVm3aeLW4pvidV2KGGHbxh6LDvLWxwuB2OIdE96pO8D9cxaHGROWe55aQSTRWxGgWpZbrbfDd0ZotupS4TWSneeuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAxbBQ+7fHRatyglL4TEtm+nsUfs+xFkMAG5MqEr+5A=;
 b=v1Bh3mk77AMAJM2vvcI4qyjtw9B386NM97O85mDd9e3l/P563QiA+Euw+PjY3kfdPfpjiKLnmTJenX0VFjIPC29tn/9v4eLuaJJlm3bTe5hPfIYtqDB0+JcMJTXflzhLMfz19kpPbEEP16e5SLqXwjwJRBHskUKjePwv/gOZ2as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:36 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:36 +0000
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
Subject: [RFC PATCH v2 17/27] NTB: epf: Reserve a subset of MSI vectors for non-NTB users
Date: Sun, 30 Nov 2025 01:03:55 +0900
Message-ID: <20251129160405.2568284-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0332.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 089f83d5-ca02-46ff-2e7b-08de2f60fe5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z1gjfq4iz4DuJY72y2JWCGj2VWH2dUUo0WXyW9FrmAuTk/G7azmbHC/Qmmai?=
 =?us-ascii?Q?OOYh1hZ5z232xifhFOE7tGwWUJdvC+MNqVAnmBEE76Ulo+101QCDDWDRJ28/?=
 =?us-ascii?Q?8Pk4sx3R/tIh2H6ELjgPopFXiI5KHtmNcSxdwUZZaQE038J+TSb9RdIyiGB/?=
 =?us-ascii?Q?rJwRMUlLNnq6XltgbX4Txq+Dpbg+vmmrTJdxuf5UcxAxYjagXzUVbPtijn1N?=
 =?us-ascii?Q?qWbVaOdzUPZXEKXTHeWagDAWbm1UoykkB8wiL/N61aneOeGx58tFwROo0uUM?=
 =?us-ascii?Q?WrcUgILisLhkQOG9anMydu4Q6EkbegyMyjhWzqNz1w1veXrbimSg+XML3FH6?=
 =?us-ascii?Q?s/EJBtyVyiXTx9aHf7jM+rk39CwiJYKkykcjboxkY0XmIexpPosfF/HssFl/?=
 =?us-ascii?Q?19z6rxmsFRcB65eJKcHUrPhBKUburxliISL6d1vSx1rxYs7T9cRLIRkBuNNS?=
 =?us-ascii?Q?pqMWjP7fDxW8NX+Y2gY3FX8ka0PiCXiwcjBnkMwVuzyGV8svwCN2rZ1NtDIs?=
 =?us-ascii?Q?YsB5bsgplKd9vGkpiBETUSBK+UGV4V+fAx3TkPlsbamdyy2qxK2/DZXsFm0/?=
 =?us-ascii?Q?aSIu1yvNvTMxYEHdXr3rhBxwmKySQtnA88IGq8hH/uPzenDBlU0wxbroUTHA?=
 =?us-ascii?Q?mMoq3hkCGlR1yUDskdyr0SOuLzFYiJtxCjd1LM5BL57GA9SgLnglfF2Y2hqC?=
 =?us-ascii?Q?CZA1TVonao2mN6L6F7slrvwL1ImuKcR1x52OIXAl0IBfarpN336PFGckhuPw?=
 =?us-ascii?Q?EWnLp0FRd8NEYUWNctlSsnMDU+s+FpsLla+f1aWJLP0P1C9O1zBgPIawe6qQ?=
 =?us-ascii?Q?T8D32cvno3lk0Z5dUjkaNcT7So12C4v+FyUXlEhnmnIpfeNb1Fi+W9axNYF1?=
 =?us-ascii?Q?8bT1VXDGiun+ilYm4Mv1sDPEPtjxhuALX9zMBf91IeF3bzImkCX0Z53Hs1Ng?=
 =?us-ascii?Q?C1LbilcL0vpwwByKOTbhpB3Zu5I6I+6jsVTHCR+js3caEep8heRxYq1OrwIo?=
 =?us-ascii?Q?iK3RDWfGEtWX9KdZsWsv3THjc7iesYsMFZkEtOK5MYHVzWklvdAPsAF9ccoE?=
 =?us-ascii?Q?pqy1pajO63g2w62hwfyC/icIjtqITHg6X4zBdCgblEt1YE3D8U2FdGClvF8H?=
 =?us-ascii?Q?ptu9DSInQiM8pJHoxPGGW9r0YG3sigG/pFbMjZnLKoEhB1fNa7hrFf7BKZCU?=
 =?us-ascii?Q?Gcz9KLgu6UypRsFav+Rt8cQWEX/lxaGBM5/4YbTm8V5uASqQ6YX5kSQ8tvGf?=
 =?us-ascii?Q?LNuM5iI8RbAd/RB88Nrg5Z6FHAy94+n6h1GlbtRqhgJaQsUxWVx7yhbZqC0A?=
 =?us-ascii?Q?01hOAQChITXKFptNbS3Fwp6IZtkLPxVnnVjXpyLZd0A8yg9+Pz2Uyb1T1/iN?=
 =?us-ascii?Q?kIShKxd8pIfos5/2BAfW9iDCfoPh+loB3Cf29IEZ0zuI5yJkVIQA5hadW33/?=
 =?us-ascii?Q?mAwRE1HM3rJ0hdl2MTDG/Dq9KFmj+z9D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q/yDRPxG/Mpklcaxs5y02EOlFtdCiiY25h5OI+o5i9Ts4K2qxQ7kkSrp+52A?=
 =?us-ascii?Q?ZGCTJukRTYHAYOrF4wGPX5H7Y4rYWFH5NpDOhaPD5a3y+vuRRK6iG9n5Inb/?=
 =?us-ascii?Q?dYLiuIgaGdwK+2lB0X82Hdwh9qIXnIf6RA5AYRoUbe0AEhtxu5XFwvrG9mxq?=
 =?us-ascii?Q?XelmEWWu6gNFhV8c5Ex3D9KWQk9z7yuyD58ttiveeQZAQ0dj7+cnBnUKVaXd?=
 =?us-ascii?Q?ENjcBjeKRXM4vUEC9r7UfPJTmSD511LS1FvEFqMQtaqIrZMNXsh2R7a22LyE?=
 =?us-ascii?Q?PsnpurEB7rnMy2+hoHvY4xBYCT5ntZSPJ5dCnI/E6P0YWTb1y/eUHE3TH/6v?=
 =?us-ascii?Q?76dyE8ncvuB0rhBx0z5T/SyUUopqUPn53RETe3bOfBMDAtjp1eg6M15Zt1gC?=
 =?us-ascii?Q?ZRlMlbKDb/ZAjYcUmlTwUJGgFNuX70evJHRdEsm5XNBoZw490ndp87C5ZSsA?=
 =?us-ascii?Q?/A6FsiErATqwnGlbLGN+Edzu1RlnvcWnzRjnaUQ0lWxpz2wUjCZBCZ8rn4Or?=
 =?us-ascii?Q?ZbyRkhVtYbxaWgLyQlPo/bDl6l0wZJJ6rlI7BldLMHn9cDfL44rQmLwuPgdP?=
 =?us-ascii?Q?Hx8v0UiiSjA1IdR/n6NICgMxQN6dbBQlRugOCl3c0Yx1rplUCbgXkldAXuJk?=
 =?us-ascii?Q?X3T9HGBOtVbEjG45JyqG4zEJOgaFXXwwu8vXcAFFhpRN744IeyIFD18bKwPI?=
 =?us-ascii?Q?pCS90hM0a9Q5sTN3aavSf28ktAvgOYaAw/Wg22HFX0+C/0k6ezZKFbdeXWuy?=
 =?us-ascii?Q?o902LihslFaspE/wptxl9X6roy9xZT9wOPrQDNRhe2o+dLoQP7FzXnnC+8RO?=
 =?us-ascii?Q?HRNv50zdsCEYgIjTPVWXV2JaLNrfM6cGiZT7865yHE1TfeFzd5XaDe21iIR/?=
 =?us-ascii?Q?yEEpdrF6oQ+fGTQGaKp8gaSKHQD5Rql8LRCp/I35+8jqfRfVhyLM8+3o/oUf?=
 =?us-ascii?Q?lVyuHewoxxsRfzDLVxzGkLd5XaQTHJ+lUc55jvTXdmuXg9zTLst+htdGyG5h?=
 =?us-ascii?Q?GqNYMfWY+lqyQ/ftifbZCzeD7Z9QhvXVbBoNCc3kCs2Mwfnd9wijxZ9GRpe2?=
 =?us-ascii?Q?8Ne8hfpj0V2BnskHhJ1y7UawijwiIHPzD9BjXvTL8caCjs8t1YTKmYdP3+G3?=
 =?us-ascii?Q?xEXIKDYqVKgLx6x1zADBk1mp1x+EUSkopdXV0BL9EKorYP4trpflH3vOQ7z1?=
 =?us-ascii?Q?A6WwvR/oKOSBZCOIkkoI+CRUDvC1bd7HjPCLNSWleAmiAVvWH36eTg+oxLC5?=
 =?us-ascii?Q?oC81RFG+1wCMIBMB8zs4cDblGBgYUhqMXB2miYCj4URp1JDPSya/8V5fmjBP?=
 =?us-ascii?Q?jaB5U1u3GkxTiH4Ceixqse+nX66E+ThZpP3kM1RJS/LWVRG+wzYIR8zTyroe?=
 =?us-ascii?Q?QWOxauJnEoAfjpt++Smf4e6N3yFS4RzMnk/UpOH1HHjHB+TjjXwHLgw8I0yp?=
 =?us-ascii?Q?e21xMVr7OIER5ymwY0ubhEbb+4x4vm84tqxdWpJ5NI7p2arhHotWGfsaeBp4?=
 =?us-ascii?Q?K4EnO0hhXXWTK6J1X0JwI4vL2z9a/IjNOL7mTbHYEQ4rAa4ZobzPlUWlh4Tv?=
 =?us-ascii?Q?XJAHhGBwtc2QnPVqn7gnVQ+jNDE1q5ctk07hBHYCqoYRSob2YCrMstq/os1y?=
 =?us-ascii?Q?7iE0fuHD5Vj14LHzdzuEY4o=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 089f83d5-ca02-46ff-2e7b-08de2f60fe5e
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:36.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsHIx69SIx0ZyDsKFmgVX8FFPbdupOJJyC9uIpKK01v+HvzbbLH8vWXheGvNsudyYjb531t16ePdZF3t9xnprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

The ntb_hw_epf driver currently uses all MSI/MSI-X vectors allocated for
the endpoint as doorbell interrupts. On SoCs that also run other
functions on the same PCIe controller (e.g. DesignWare eDMA), we need to
reserve some vectors for those other consumers.

Introduce NTB_EPF_IRQ_RESERVE and track the total number of allocated
vectors in ntb_epf_dev's 'num_irqs' field. Use only (num_irqs -
NTB_EPF_IRQ_RESERVE) vectors for NTB doorbells and free all num_irqs
vectors in the teardown path, so that the remaining vectors can be used
by other endpoint functions such as the integrated DesignWare eDMA.

This makes it possible to share the PCIe controller MSI space between
NTB and other on-chip IP blocks.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d55ce6b0fad4..c94bf63d69ff 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -47,6 +47,7 @@
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
+#define NTB_EPF_IRQ_RESERVE	8
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
@@ -75,6 +76,8 @@ struct ntb_epf_dev {
 	unsigned int spad_count;
 	unsigned int db_count;
 
+	unsigned int num_irqs;
+
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
 	void __iomem *peer_spad_reg;
@@ -329,7 +332,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	u32 argument = MSIX_ENABLE;
 	int irq;
 	int ret;
-	int i;
+	int i = 0;
 
 	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
 	if (irq < 0) {
@@ -343,33 +346,39 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
+	ndev->num_irqs = irq;
+	irq -= NTB_EPF_IRQ_RESERVE;
+	if (irq <= 0) {
+		dev_err(dev, "Not enough irqs allocated\n");
+		ret = -ENOSPC;
+		goto err_out;
+	}
+
 	for (i = 0; i < irq; i++) {
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
 				  0, "ntb_epf", ndev);
 		if (ret) {
 			dev_err(dev, "Failed to request irq\n");
-			goto err_request_irq;
+			goto err_out;
 		}
 	}
 
-	ndev->db_count = irq - 1;
+	ndev->db_count = irq;
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
 				   argument | irq);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
-		goto err_configure_db;
+		goto err_out;
 	}
 
 	return 0;
 
-err_configure_db:
-	for (i = 0; i < ndev->db_count + 1; i++)
+err_out:
+	while (i-- > 0)
 		free_irq(pci_irq_vector(pdev, i), ndev);
 
-err_request_irq:
 	pci_free_irq_vectors(pdev);
-
 	return ret;
 }
 
@@ -477,7 +486,7 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 	u32 db_offset;
 	u32 db_data;
 
-	if (interrupt_num > ndev->db_count) {
+	if (interrupt_num >= ndev->db_count) {
 		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
 			interrupt_num, ndev->db_count);
 		return -EINVAL;
@@ -487,6 +496,7 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 
 	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
 	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+
 	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
 	       db_offset);
 
@@ -551,8 +561,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	int ret;
 
 	/* One Link interrupt and rest doorbell interrupt */
-	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-			       NTB_EPF_MAX_DB_COUNT + 1);
+	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
+			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
 	if (ret) {
 		dev_err(dev, "Failed to init ISR\n");
 		return ret;
@@ -659,7 +669,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 
 	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
 
-	for (i = 0; i < ndev->db_count + 1; i++)
+	for (i = 0; i < ndev->num_irqs; i++)
 		free_irq(pci_irq_vector(pdev, i), ndev);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.48.1


