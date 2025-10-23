Return-Path: <dmaengine+bounces-6944-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962FBFF8F7
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276773ADC43
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21D2ECD03;
	Thu, 23 Oct 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Zl8ZHSrt"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8872EB84A;
	Thu, 23 Oct 2025 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203979; cv=fail; b=nuPEf3o6DJkdxF0qI6fjd33ovd4oU/7+BdJgiLrgADOyAKcBIFNHb3Uu1uujmiNszkuPnwWWIFtfVTUj4GLyWM5jp4+gEszVTD3EgUWdPqbJULCUWubfVqS/+yU4f9oB4YL9ZBfyqgDiZ49bWUOSr9BMdG5L0rRFON/zoDduyUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203979; c=relaxed/simple;
	bh=MWApLqD4f8u7iEs3/UyJJ7ZW/qflz4ZEtoTREEceFto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVpc+MDF6vc1s4vR/MLg08iT7GsZXyKadQ+o1f2TuhB7G4SMEOaiXAKTy+hgX1vCbukwMhUL0HOznxXqHspmHP9PqKRl4E3hmao5rQgkzhWQXvcc1X+hd1GeTs8vPYRYIe3IqeJVgGz9W/VU/ztQgNEwfrA6HNpSBuEPgMoKS3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Zl8ZHSrt; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAtJTai4Fp7qYihMgHL7u6gUE1cWOaiORE/UNvtNHPcw5eEYMzAIi0CUxdO6YtOTIU9JPwsRDB32WG1fSmPRMNW3XN51brXipibf4qRWTa/PbajmQ7PRemv57aSbXuIBunWWyn4kfqFUQb+SXlzuIKfiOYO7mTVfpLDc2xVVtaePH0Wk8dhH+f69ryykKSeO2UXo4AkrDZezozOnvbeKXEn4eGgSGM7xJTsYGfgWTlABfPR7kT0lH7WBEEXum3HfAd+4VGbszQ3aYm2JVF57XPa8bnfdbAF024wI2YBwQJ54Qt/r+DaUVgfQpoXW1uuVCyzFsbcVdCnboMtcM6Xv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvywiF7A/J6u/C0VKVz/MyeKxEHR5eMLNrym9BVeHxQ=;
 b=xn6r04aefDZlUtuYinCimGLtIW6YllJIhwtsqPqcr9fZ5DpSy1ZtlQ1crUrPuq53B+wKCk087VUK+tsPwStg1m4mGV7WGMdXIqXXuv6wVRZMDH4ll4RvKVUp/wfbIrCYSmZR8b91BBs9KuZM7x7Mg+vmB+0vCtbD5fickbE0YC9//Xh5nkOYqMeSeEQOqVyNiot+EblaEOokbTbpM5sjOzmyKr/noJhOklhFTj/VBZO4Ay+2HcJXzsRMolxJT8KfkzvnBld0HbujRSOatzYHuf19l4JnIe3G8L54tdoLqRoD+nAiETR7rieWoGFoYc23UL4Jn698aQlQwhhXXlc6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvywiF7A/J6u/C0VKVz/MyeKxEHR5eMLNrym9BVeHxQ=;
 b=Zl8ZHSrtnWTCv3frQtt4GLSpLhk4sudYTn7PeFu7/osjJlyt/iIl/U+Ali0+vcgn4HqpWTiY6DiSDgnI5JyrG1MQoSc8Y3hS7Jrc31P2t40r8GPlItNCJBNpiaIL41SQ1QNJv75F3Iu3vUCPHrw7hF9cQIZL+JSu8+WlPWJIHNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:33 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:33 +0000
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
Subject: [RFC PATCH 09/25] NTB: ntb_transport: Support offsetted partial memory windows
Date: Thu, 23 Oct 2025 16:19:00 +0900
Message-ID: <20251023071916.901355-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::8) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cff626e-c1c2-4b3e-dd6e-08de120483b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6Hu9iDHdWTFoTdBA1tc/UI6JkxGu7QmsTQ2tk6lxmSnmR6uJiyzXoy54Tp7?=
 =?us-ascii?Q?PKsWF7sU+OdRna/HlCSG2ZcXN2IEh5qC5hXkxDlnSMQC34JfXoNuh1cYnBcg?=
 =?us-ascii?Q?vbZI0k+UvTGv+gVLtzUEnbBpWfyJ7mjrNMqHyXYFSd3L8vV0mwLGrn7uDbQS?=
 =?us-ascii?Q?W2nPGEAuvM8+GnUJNGW/OUhh1hKNsycSubjkuIDwT/m2tZdTrJAGOoZOONYh?=
 =?us-ascii?Q?dbks4JO0kYiIK2Ke1z1LrQTJFkbHk27VOTHSO5F9J5MUqU6vQW92xnYKI/CW?=
 =?us-ascii?Q?7naRQdrRfOr/jJ3fSdhSl5rONcJ9cQS96CRLvx5lJb70Mf/0/0fLsIXwdlyx?=
 =?us-ascii?Q?WaKnaxwN+QlYIBG2qR5EOy77G9P/rwGVsfkSncmWNnQ10g1kWMMMdzNnMXvC?=
 =?us-ascii?Q?hi37pis/vWDcU44RXJNaYU5U2n3m0OumIri6IkNeraCZRZQq+lzkuxrtsgIt?=
 =?us-ascii?Q?XUJxPwmscKqI92J1n6rqXmt3//1HqN0WNjnIilUWvD3bZbkk4NGDViY6WpWb?=
 =?us-ascii?Q?GiU0c9KHMsnvbl8Lg7vf/ZK6C7wZcTsk4yGmfBewsR+d1lz2IqX9NIOpViIQ?=
 =?us-ascii?Q?G4V6gfXzSm0m/noOCSMS/UMuErKLa9vS/oqCQ4Dcjm1nTxg3VXqmpcdKW3NT?=
 =?us-ascii?Q?jo/HXQmUEAk7V8ZRotO8BkRlnOULLD9RNTn3Ivjt51J+JfZLX/sD3QJfSjFs?=
 =?us-ascii?Q?a9q1l9X+ZlcLtkziZrLmo1WfAjyo8JpUTzenmvmCfR/XlwXPKGweL6SEvFD6?=
 =?us-ascii?Q?1Q11Ihjk7V9NMUY2v0uny6ZIq4PemhBtBZrSHmAcAKW2Rm1vWbX4GeK3NAKp?=
 =?us-ascii?Q?rlDUHyylRCXAR6KE/x5BvbpierGgQhWIfqGYwekNMEiUNLZGHgYcfLOMEy+y?=
 =?us-ascii?Q?F2pO9wYdj0lPvsGZu+QQ9UFknfBTIsTsRza3t4hzwpqiFR+fMSDK8A1z4uqN?=
 =?us-ascii?Q?2LhiU1E12PFqDO5P01mgYccCAARu71emDdfm3rTfZjCnakot+0EgvVaje1XY?=
 =?us-ascii?Q?0Aofgok/DPAk8N3fbaFAjgzzer8RwPdk3g7oP52AZUQzggQXUo96rGOHgHJx?=
 =?us-ascii?Q?vm10rrp8kS5f2hxTV3fG4F5jkzDMZ+1pLo+UBLRbj1vNwGxOeRXU1nwu6Ajp?=
 =?us-ascii?Q?M2O4Ud5sCMlXyoLvvDl+OOqFVG4359x2e9aZRbqk/cabbBurPcDARMRNfROH?=
 =?us-ascii?Q?Tke6ObGNENjXTm3xYbzOnPYDVK+XcEqU2ilPaxs6BubApCyZq81lTIV3roVe?=
 =?us-ascii?Q?6JWbtGrqfggHobQF+LdnWa5jZaOiO7kBgRRqmNmZ56o955YWEe5MBta1vjex?=
 =?us-ascii?Q?Or2K4JdtaIwBhmCWvsmRtzTR7syLFFS+nnK8uPUQyFpBc/sHXIIQuUgJ2Sw4?=
 =?us-ascii?Q?HYMQ5n1zwstszc1K19BU8QInlxLrV0+Y7hMGb8KRrKArMmpFvqx91eWBenwU?=
 =?us-ascii?Q?xJ8HwRoxAbzAV23KIrk/azTSM1FHHwEu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DH5vHGpWVdwDkvDReOFQ7OaPMXzIgWjqdDX9UggqqcbaX/9IquHPRaHt15j7?=
 =?us-ascii?Q?4bn58Pbe1QcfTmTEYyp6s1LGUOyZTc75IqF4dk3o8CKvyQra2vH3DgzqdR4U?=
 =?us-ascii?Q?JC30/9wOeaG16QpPne4KZ2VdOAo92O17EmpW/7FNQsWCvlrX8QWItQcamdwa?=
 =?us-ascii?Q?2CCAoEwI2xWNYFmEkFCy2RXbNqtSDpzXx+6fpyE0agunHTikkk9ZxHwWke76?=
 =?us-ascii?Q?kC7O0v47f8YHWlxgVzrlplGIF62soRZqAMCPrIfm6DV4dEKllisHhanPr4QC?=
 =?us-ascii?Q?tjU7kNwuq9PvTpl2nzZ0zMtlEbxO7w8lhLZpbtwO3L7fm/+v6WSVnT8YBl1Y?=
 =?us-ascii?Q?qAUsGxUtjEn4/Xi/ka4cVSDKvkxBBnUw0Ij6UICI4IPvHiTZfOKx/Dzbp6of?=
 =?us-ascii?Q?E2H6SY/EKbm3Sz2g+iS1HiKmABRSBF+PJaGGSz64f+rpcV3IjKGGrqpTU+he?=
 =?us-ascii?Q?Geg8RdikGDtlXBCMCEmNGBLstIeL1+bIqoWq6yWmwKlA/vgKtxSjo7VbLJwm?=
 =?us-ascii?Q?nd3rwBf0jPgAOo7qt5rKdyqtRX99/TduQdjc7JPaFGKB7aTunQN+MHP5Tl47?=
 =?us-ascii?Q?gZVOI5s6Y17wyxiqd9Ixbmv3UROFnDBYZgE1oEi+TPpZ8s5WQPCHOQm+Wh5I?=
 =?us-ascii?Q?ZihD5GSIbjB5cgpqR26S++UaQJ39ZeaCHq5d3NkAlOmVIdSY3xvExV+acZIp?=
 =?us-ascii?Q?u86u8ju1CYR6d1irauY3bKSCaGCTrQqHuuyvtacqat2/kH3J3/CCeB1FJ+vJ?=
 =?us-ascii?Q?sWRkE+BfLZfY4kmEiIiK0vsaCU59ccVvO6LTtlAbO5ogA2ekjb+mFDkuHxHH?=
 =?us-ascii?Q?/ignRKZ668A6DKktUu7LEbFoplFkcjKGPCzXxIu8YdhmMPGRdfwRODA2lgSg?=
 =?us-ascii?Q?K2BYaXRC0HW4nOw26Kxo5Rf7Q6EVV/0pDsI+LFTmPrDGpLUmJGg9vmjwUAo9?=
 =?us-ascii?Q?DNqbvXv617Py3OO1q4GUt0UPWPlwjS9M66kIYN21k7dAZhxQToRNRNdh+6oP?=
 =?us-ascii?Q?lEFKIJQuBO4dnHqh1jmoTGJgeEBK048kRjb9fxkRm040wTtfUiGiG8AXUuiZ?=
 =?us-ascii?Q?sx2kMsV3NfQ6Ya6oymGYhvU3qOe/X9HoxO45D4SuwvQItlsGNl5OoMcHIP2D?=
 =?us-ascii?Q?Al4P/yq3u924McKOK1O5PMhShEyFACWbsI5+46WMLR4UuV660lv4cxMxSgRv?=
 =?us-ascii?Q?u7wn+Sb6BWVVFQhnJYx2boxvRmctTVckr7op8mJ+k0H4F20LJ2p/fxLg8/cO?=
 =?us-ascii?Q?FVB6ulTfclaznt/b837QlZRFFbexnaK6wAsgURGoFsm0a2EIOUfZMZviXLrs?=
 =?us-ascii?Q?YbFugRnFpl/x3MHpTK4iq05BAHARv1mgmJNgwc5zBe9FrlA2mnv+/aapsND+?=
 =?us-ascii?Q?BsqV9ZIDyNrRF8U9iWRVJfUlvx4i1XCcnRCrw/vdGdXzorEPq43RRhir6BK+?=
 =?us-ascii?Q?Chmt9qXb/0fdoJHnYz+S4Oywjpwvvn2tErq7GaHGKj7OZYFfSwzHQvWnX7uR?=
 =?us-ascii?Q?idogbNdyqdFt1aC6HTuAhkC1uW76NFU1i2UhMsR4o6FGvfHyjx4oqO/7NP32?=
 =?us-ascii?Q?1kxnxMLUQFwAlTg6Y3G0/YBGlhXI2DXBe9fKsHfcQijLAukK/T/lkUGLldop?=
 =?us-ascii?Q?6du6AL79wrZ00S8Vn1/EFoA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff626e-c1c2-4b3e-dd6e-08de120483b6
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:33.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWodmzIjuyeTBAuINcQbVi4lmxB4TVXHm1420M2+sJuIWE0RMxhmlCIWHhmWPMERACL5L2BbChCxAc6mdxAfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
support non-zero MW offsets. Update ntb_transport to make use of this
capability by propagating the offset when setting up MW translations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4bb1a64c1090..3f3bc991e667 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -877,13 +877,14 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
+	resource_size_t offset;
 	int rc;
 
 	if (!size)
 		return -EINVAL;
 
 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
-			      &xlat_align_size, NULL, NULL);
+			      &xlat_align_size, NULL, &offset);
 	if (rc)
 		return rc;
 
@@ -918,7 +919,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 
 	/* Notify HW the memory location of the receive buffer */
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
-			      mw->xlat_size, 0);
+			      mw->xlat_size, offset);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
-- 
2.48.1


