Return-Path: <dmaengine+bounces-6951-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60CBFF93C
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3B754845C
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA72FB965;
	Thu, 23 Oct 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LqhpEFBm"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A52F7ADC;
	Thu, 23 Oct 2025 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203991; cv=fail; b=py9kQN9O9I/K7/KM2bboY7+jvFgzFrcoXzY8G2EUnKbuPZFhjRNECqD38D8DiGlNro48xEXK0w4TmpUGs6nH6FoHx6Bqna/CTlb+SREjphg0KnjcmGIV53HuC3z43Y6iDc9OaYV7HZwoHnGxFYnce58CjWJYE3crlI8zmlkQyTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203991; c=relaxed/simple;
	bh=9BayqkwdMFUuFFNoiZModBX6MXTHNhopW26mdqJGZ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usXMVG4XVfvM0Rfwm7zwiS++3C+PeLzUfswcnlucMlOGeQ9NNKThd/+2+OJf0aEYqo9SrcuAjhBUBB7mQiPR3x3BtoAlsXC3nz2eYKK/OBSOl16yJrURuLdWPxLbkI1X2/rCrCK0l9a613tJy7pUs3pH6hRxANhZnzRLDzqw3Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LqhpEFBm; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIYOzuQs9ElWRSVM2P5DZwcKPWphKU168Nv8EadaGlm9Qg/Nmh6mZmJ7e5DKqB+ElWhBCezjviT99qPJQv/5U5Q1XslUtNau4r3PAJHw2xetRIsnu+pFCUpbrQAlcU5k7F985Qc5RhvQtXGcz3/RT7d3zQNWNJzNe1pUOg2lOhhrTuCBtdCs2ajERG7teh38cuhHXgRE8FDHhIQf2lmdxROtH9Zo982vQc/luVdOWtEazzyKoyyVEyHcbseC5yTtGDylwmCFeZ2wtW7k9v5MbHa7CN/m8zvDjnbV2J4xjF0SmPOeALhFUdoaq1QaFLpBK1UPfNxID+qRQ0JESuPmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRwwL4Ol4YYczw73Inc3X9+xfWPyI16h+gL0z2OJlHU=;
 b=RPymhlsnGSH38E6ShLJqJ2Xjwga0lRCNrsSco+BxY9d1wtRxb1StWFmxW19QSFVeeWHnb6mWUWMWMpv0bVkrp6+HZt5H8451Gg4YGZJHqA138nWxfH9kTqSZMaNd9Aczo6EsfoZjOyL0wnkKuSB5VhipXsjuGOicPuomPU5kqMXdvsgwjVS15kKJ0wLF6DxH0y91jaOXEJX0BF1Jzy+fixCRvz+ilp5D21e5I6VDmpkftXdunQkr+aUs+uYfyGnvVyrLqZRlaVYztxyuLrhMq7iQr7XEunDXv8F3uldxFkA3oI+NVIBTN8CGeQXH+LF+b6sCQf8D3Pv7lyME9TYG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRwwL4Ol4YYczw73Inc3X9+xfWPyI16h+gL0z2OJlHU=;
 b=LqhpEFBmrUuUK75H0iJ6IOmyGQ9AjT3w4KBSNw2EyOw1KnWayDmXo1xHGnjchDsLRNfsn2CMQV2gLQ8U9EeMD/2jaB2T8UIXur5CoFJq61oPNCGZkGRRsC426+K5B5ZLV5LIh7W4HIH2eb6UoydtXhzVJ7BTs/uH6XRcHvJlP3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:46 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:46 +0000
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
Subject: [RFC PATCH 19/25] NTB: epf: vntb: Implement .get_pci_epc() callback
Date: Thu, 23 Oct 2025 16:19:10 +0900
Message-ID: <20251023071916.901355-20-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::19) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 313a7e19-4abd-4677-af85-08de12048b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PS42BXTFpDdtyyXgcy5ue9cE38JpvoDKUhMkzWeJlw3yFJ8apC7Eod+n4wD5?=
 =?us-ascii?Q?zl6AMzN7o1GMGitEC+zSFia3ZyPXafVpKfNF9kpXOsrb0hCRJliuSo03YDU4?=
 =?us-ascii?Q?LbWBIOHjNh9KssZ+Ib9SR4bVndryROj5wHhErjd5zAWcdeOnMUrZU3+9oGuq?=
 =?us-ascii?Q?eN0xxk6Ot2n9so5cWE3BzcEU9hYvfa68xte6d4G75cqi4K2WQByOknuqa/K3?=
 =?us-ascii?Q?ZxDOi/K1c7erNYg0y+UXgw+gjzCE+Jfc9uH7Fi+a+D8B1Ixh+1EmehtVaubX?=
 =?us-ascii?Q?HrDQU9mCMgbehwwRqITqddr2n9ElFilapc1w4+2XJ/B01/6c2t6PhYUGumLE?=
 =?us-ascii?Q?aFSYQ2tpTnCmgQn4apjVQpf4RwY09gbftGOnK2dbf8Fl+0iPzmVN/n6Of3o8?=
 =?us-ascii?Q?ap1AkiWFwmcvBNt/NFs0mHgRR6F6E4lHlFm4nl24TNEf+y9qtXJXMVsTk2eY?=
 =?us-ascii?Q?PA+XXmT2mPFuPxnG7IY6jdub5W/ntjgMLVwQ7vov/X1JyrYVkWGhIuDy4rur?=
 =?us-ascii?Q?2OQi+oN5uQE3RdAEcU5HxxXeerGt6BYBb+b2KMd3FTjMIfjYnNPaG3TSMyUj?=
 =?us-ascii?Q?FKH0j7hEfOGT+Ops6533b7t1FSGiTu0aMCjPRcOiU6bDBbyzFxRGBifz9AJo?=
 =?us-ascii?Q?TqLDCXszykbxZo8NmAQCqEiGsgeAk764DhOkNJ+qde4asARAp+nYhGEI8hQr?=
 =?us-ascii?Q?toNfU46yPkOyOVx/UpngdUoXSE5ygtpsjAf6dvczIdtWXgv2A9wEyBGY2z12?=
 =?us-ascii?Q?9FqACKwo07lVAPQnrDtsVWGC3PqHYyIihORvTJvC7Qh4fTEEEU63gaswlbzX?=
 =?us-ascii?Q?4lIOiqOvxGziR0bGR5aD4GTVjPjei6Vjv246UMyF5hGhZrE79z2IyQBBwj5g?=
 =?us-ascii?Q?8r+cxS7GP+bLv+oAhPVcEXBpthOge5uwdaTR9lFiEZz+cYeMqaU0wMUIIb46?=
 =?us-ascii?Q?JjeiouPQ4mNwM/hZPB0JOzZl6VXfxfYYjGqxd+P/3aRH7wS5YO+AevW0bRnk?=
 =?us-ascii?Q?RA06XcILTstk71Z5iBvT5o8CO5MKHa+A+ZkCQg/LlJVov8aCCphpj90iHs54?=
 =?us-ascii?Q?NLIODebv2WRFEaMXz4UI2b34hiBitRTJLgGrUqS2c/U/BinTpO7W92ZhVF9D?=
 =?us-ascii?Q?bm9SM15VOF2+6i2zU8bFiicgT0XydlByT2WMkSYum+faVprxkWn5e1w/D8VZ?=
 =?us-ascii?Q?lgjbc2IS4GtR+f8R9Z+g9/Rwb6OCf+rmsuKMFB6ilQZFkUJOqZCz6Umvel8d?=
 =?us-ascii?Q?fac3V5oIGq0SR19hK7qEKtssNGU5fQxrplU+QPSJQFvOz8TKgrL4xEYl1BIZ?=
 =?us-ascii?Q?nvYnIdhCWdlurDyUnKmFnmeJlNhBrgLtjA2aGAvPuvRe+75EFDCogablrlhi?=
 =?us-ascii?Q?0k/XYBPbG0R2HRiS/rIEim298gikp/nCb831v2keoCKfW/BF12qFb82Mvp3J?=
 =?us-ascii?Q?V+WhEM/TJ/QsOgrJWgqhAWyQUpCvttJl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EF1jRKSRj8RJUF5Zcx8Rg9kHuThtbx2bCrdQNchrO6hZgN1/FflZpTZL3xk7?=
 =?us-ascii?Q?55G+c4Dd6E++G+dgKBkEdVeXq3U1efxaeiDeUHpfiT+8dferDbStClUJU0Ob?=
 =?us-ascii?Q?sNoXSe8yoWSmTieoDUtDs48NSA836fJV/ULNBlbedZzU+Rgbo0CYBW/pRJTu?=
 =?us-ascii?Q?4cjF0iySe3Vw2yqqIVE6w9Tzh3/XyfR0rLVd4tmLbzuxkwh+E+BMgYoKuXMW?=
 =?us-ascii?Q?LBkthn/O/CyAIZD5Tu7KxZ3gvLpdyEcANgUf6tIzzMRzIqv1ppF/i+FjZgNv?=
 =?us-ascii?Q?4VH8TBTmeGhcxeLSIKUuq4M9JRh10GCkwwMazswBGYjU8KPR8O2feO0XnGHj?=
 =?us-ascii?Q?IN3emC2nsbxuakrk0Xe0yVpYWafspkOhLfIGBMJzL/x1sP0RDC7XPdE2fETL?=
 =?us-ascii?Q?/acJAz5g21RlG+NozkbxQd2msAfbwUq3ILocYvPUHI+MTTVR9J1YWBuhCg2v?=
 =?us-ascii?Q?hHlo+pMCtW1/t2MmO/l42zhhcULxyNsVC20FyCuOMnHoGE3WS2GlK3MxE3nW?=
 =?us-ascii?Q?59bj2gIREJj2QdC5foAvxOFUxe7O7Yfkc381PLNxiPtF4/1n+NRogdmQjdCh?=
 =?us-ascii?Q?fbN+BitJJhZdwJzCXIW7y8s1WkfEMrfZ4jZoDbl1GFV2GMH6wPd2KKfnMRDx?=
 =?us-ascii?Q?16tGJzZlAqG+XH+yc7f2lCsqAzWZdh83G8CR79Lfz1jL+Yq0oo+WoPZdHkHs?=
 =?us-ascii?Q?cdawfi9S4roJj4hJhT0WtMAmOKQtN+I4AvOZtPDxGCTDg7HPF4zMIFVfRINs?=
 =?us-ascii?Q?wZ56PdW1ScEGMLV1VhM3F5/22Yo0nnMN3epfa/yea8QSFgzNGI84RnbSw67X?=
 =?us-ascii?Q?U4B3rxrw3Pg1BNnkyVUEwlXhCrqHvjUweraWa5aT+WtAcWr8ZqYvda7HL9OD?=
 =?us-ascii?Q?A+wd0I6ED2tNy5ChkiaLQ7nWyBBK1iTrBStbs2vkPW+VrxLcF9H7ii4ATgsu?=
 =?us-ascii?Q?HxOU0z5kB+Yk5vXSE24+auJqN+Flw9xiBuC3ZUyINIZfhTNSdTRCoP0vQTLy?=
 =?us-ascii?Q?rPYljyX44H8dhAP4MnNEaysT8E3gqCY5HCa1j46o1gN7YrSuAJN6cBm/Galz?=
 =?us-ascii?Q?vlBKQrQHAebYXiaKHen+y+sfspkNMT0g3b6VFmyLSX9YDr/nM7qCPjHS3HhX?=
 =?us-ascii?Q?t/18tcnVJrZmm8Cl4l29VLrC+7SRV/7lR7E26u3Oke59lxVX3zFo2Llj7AkA?=
 =?us-ascii?Q?B3DM3ry4RwdYOCv/j5xlgeqGXEhMPWPFDU33tRcv0rqH2XTavlVdY2mNsH1F?=
 =?us-ascii?Q?IOSLdEtdREKsitWULRYOE2Ctvggr2bbRNsL0zV908iYolv7iPIboTrjkXklw?=
 =?us-ascii?Q?C1zl6SZMyIRqHDgTG1Wk4B9gGRo1tTPTMa3LTXRYJvcJrwNIibWR6Pd+9AkR?=
 =?us-ascii?Q?1+uRzL6Di5jO8jB5lGz8LvsbqNSbxBnZ0ukGBZJvYeOB+Q3mAsc0KS/LUIn5?=
 =?us-ascii?Q?KCTtwtFKof4OMeXJNa9D+wXb2ilT1whu8xkFxOVgMaiW6d1YjMMOgMkDmhlW?=
 =?us-ascii?Q?YaEbYP2Lu/XcUUAhMqFRyaUoKch8gDCvew23Jp4cV1Bqz4ZXRHdIGa6Z1fzc?=
 =?us-ascii?Q?XIvt33PfNmdno7ZG0vm/lxD+e/s4KdZ2PEyMJr9s4H6uGJP75SqfNeyD9l2Z?=
 =?us-ascii?Q?POfOEbZkTfEBpjygzTvKtQU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 313a7e19-4abd-4677-af85-08de12048b77
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:46.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMOhipxLj9uHnPjf/5b5vXNYin2D7yZSfWTkqZmeeM/1Q6IH3SV4SMm9rYsOAwkpGsBeecQPSffAmM3vvFeQNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Implement the new get_pci_epc() operation for the EPF vNTB driver to
expose its associated EPC device to NTB subsystems.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 6495f99ffd4f..e3acea19f473 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1446,6 +1446,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
+static struct pci_epc *vntb_epf_get_pci_epc(struct ntb_dev *ntb)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	if (!ndev || !ndev->epf)
+		return NULL;
+	return ndev->epf->epc;
+}
+
 static const struct ntb_dev_ops vntb_epf_ops = {
 	.mw_count		= vntb_epf_mw_count,
 	.spad_count		= vntb_epf_spad_count,
@@ -1467,6 +1476,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.db_clear_mask		= vntb_epf_db_clear_mask,
 	.db_clear		= vntb_epf_db_clear,
 	.link_disable		= vntb_epf_link_disable,
+	.get_pci_epc		= vntb_epf_get_pci_epc,
 };
 
 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.48.1


