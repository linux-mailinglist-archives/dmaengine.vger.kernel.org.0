Return-Path: <dmaengine+bounces-8719-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFruFNZdg2kHmAMAu9opvQ
	(envelope-from <dmaengine+bounces-8719-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:55:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D38E7969
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DC983010B62
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2141B37A;
	Wed,  4 Feb 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="M4cvHUty"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E841B367;
	Wed,  4 Feb 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216891; cv=fail; b=n+Ck6oOhfQP2jx00VbZXV5Sxg0jSFO8GySDf82jwBMbbV+4YeSEbNbuFEb0Nz/oPEKAljNyAM7/wLcrCe1IFPgI5wUZJRI/IhSQUBUqslNQoAYGZ1epEAMSPId6XYSSLsQfRR4H6wYUzX1fA50Fi8NgIDgfzvzlnchRUHyQv50E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216891; c=relaxed/simple;
	bh=8wmcUSapQgb0NCMpMIDBPrFfsCJUKz1Op0iC4PY9W/g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gkTx6WdjgfthpHeAeb9QvjYfV9v/M+2fYMafqrI9wLrsU/oiga3X9UbyV3zZbVMaE5dfpeCHYqMFKWlqMHgWmVM5oACMWAQtX0lCiVR7xj92lMO7hl9hYRcmOqeTbOCDPUuqN4AZwn1sdVvUNZvBcBLU5R8p950QUMRmUDL+yqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=M4cvHUty; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSbQuMFuM1Riz2jZL8kgNtnT9xns0l5A+EcBMddrRsAcfiVeR1xpXb80kFRu9e2zusK5PspGgs1zew0DG9TcR3pJE5iWAcUtmxD/j9ccXrG1Dk4G0WIU9xL3HMVntZij1tZTNls4Bnk2EWWmavlqITQ+52c0khnew2nZT8WxgSBJ/QquxOru+KVcQJW2WUv73N6sz+7JkFjE/8GJtAxe5D5Y4jV8jNpkxdIxi0CBBkfq+zjT7cuMZqcbD3ZTO39OTOHKOTQrDHJRnlnqrzaa41EKcwkIqBL5M9ssBXhsSwUYvTkwVCYuqUoe1aVv/3CMMzgPjU6uRzUAWNM2escbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuFuUDK6hWEWpj4ieawOGVJP7u7+Fkih5XvHpKnVeEc=;
 b=O4SfNfmQOMp2aF3J3kMT9TZKtuH5vuyaexSTOKEqAARF+MQl5746NyK1hUPpseRFa4JIK4Tn6dRYhNMA0bJ9ohw6pJ2Y5QJbCPQX6Zvp/d4Fr7V+U0+rU4Z2WUUyvE5ON7N+2Kl5dpHZrC7/b/LssJkWOBNeL2IY7qV5tk69FGDet1NsgjHSiDqLuQ+DYKqcKP75CgfsGFadQ1wK+stB8NIpBo3Qf/HoiOg+BGmCFTle5uNOKkAElSJm6TZnEyIu4ukA2P8X7O8FrarqihLSlTTrca5qi7DUerOJZRNcr5Qsj3zUT9yIF0hjQ2bns8P/ylbLb2glekRAlCVi13g1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuFuUDK6hWEWpj4ieawOGVJP7u7+Fkih5XvHpKnVeEc=;
 b=M4cvHUtyeTPp2Xd4CTANxx4qRH4HxBV1FWcvL+SciF5Rk59jbmklo7v69jNp7o6CFOGlJ6GOd75ALMqAa5JCKmoQw4x/6EJ/hDYpspzQ/+lJsB51WW5BYO+pda9fdZ4RJ1cEpEw9Sn1ghD6FwoOIvLAY0GcZ3SisaDQOVd5e4TE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:47 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] dmaengine, PCI: endpoint: Enable remote use of integrated DesignWare eDMA
Date: Wed,  4 Feb 2026 23:54:28 +0900
Message-ID: <20260204145440.950609-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0242.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: 646869e5-192e-4f60-fedd-08de63fd5719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Do21TmqiozB8iJMNelbIzJbGWu88ptuSgGV69Mw3QuGcSO9jGh3hRfVmj6PR?=
 =?us-ascii?Q?2ChttHIhoOc3yE6wwxYkCLNrVgrkEzX8AVl/puqVkNnaX7Cry1ML1j3AKEqI?=
 =?us-ascii?Q?E8T8OP4Bbu3KsH9zJIo2gYr3sDPFY69c7nRkzRN0+/Jv3B4UhQxYmeZxVPMU?=
 =?us-ascii?Q?/XOD5OvTk6rZh6c28o6UFpgQKswnfvGTnnWiFWzUrXqv1KtrnFXlJP94uYyg?=
 =?us-ascii?Q?75PU/rt26SN55BLc3JmPEspa+daKEFSqAKFpULAoY3DEXzqcqRgWo2KhKoN0?=
 =?us-ascii?Q?5+6nMDDPBM8EKarMCwwU7gefiQbjzMbzoR4V8i8uxDibRtPvVr/APwD7Gbc9?=
 =?us-ascii?Q?y0wZ3EbCkIw+gcNE1szNqYdwZMHKB1rFkcFmmdBN5VMHom0Sum2uTP6P7kpB?=
 =?us-ascii?Q?uyPOOF5pkGXL4to0nVEuxy3sqCBK18zs5nF0tx6eLdV0u8MImp1YPJxHP3Rf?=
 =?us-ascii?Q?bD24l4wZOvwcjAsaVVHR1kZL92DR5eMQ7zd7Kv4A42ph9uyYZKZrjITHDduW?=
 =?us-ascii?Q?2FqcExbegjqA287QnCDOkoULrSPmrkm/lcB/Z2p+Ldo/IrXF4zJ26DrPigQ+?=
 =?us-ascii?Q?efyxf20owtD/cJEcO/LoG3GkvJL5MHD4P+cO3kgvMCvQ29IiLRRr1G8Zy6Ua?=
 =?us-ascii?Q?CivofcnJeSQ3NJ1aq4bk/InhvrKWAW3Zdi4/cbQ5hwdYASyRIH933Ayl2qa0?=
 =?us-ascii?Q?5xGNPOGFG6b6CyvD3mc7FzQyGIgV9nLxNR8edk1Pv56Db1z8GiyJiYbd2O5k?=
 =?us-ascii?Q?2JLKRAUEugg5YIOwAd2moYHSdPEN/BOUe6DDCvy0fHV4Fx32jrg/+ovmEquH?=
 =?us-ascii?Q?6rJI8chmhPKAGgaN9yxCHGfazzz19eAOjqGgVQqRccLSvsMjIqQwyEOPgO0l?=
 =?us-ascii?Q?esuf6BKbLZpr/wnYHUDdXZ9LlY2R98EODEp/MT2sI9qSLMYUHCwIXEGuBvWk?=
 =?us-ascii?Q?0bg85mDlvI5d4mqKRsC6RIBpk3JnEIwswMkokR2b8RqUpFaSNvZV3xxVtcSD?=
 =?us-ascii?Q?Qfq/l3JskX5xFjDJ38FTKnGn9hyGrJFdsdrkEm21dbAWM1tw7+NA7gQU6zxm?=
 =?us-ascii?Q?p9af9W1bnVdyoBlx+z9svLsNpAkwB6X/swNHbUgzlKQyyBPj25JLD9VVXotF?=
 =?us-ascii?Q?iEL88xXP7hcBI8cUT5qbtzaOzvM/HKLl/0VWNGF3u9WoK+9biPOz7dXQ9AzU?=
 =?us-ascii?Q?dLTtHgn01IottZk0hbrj+OVp8Ucp+3GLdBEmcFjrRHMAllj8KmQpSY5lYAUL?=
 =?us-ascii?Q?CyDKo8WkT6Ydvsr82QAC8HdSYju19Rw/qpkfGVvTYIO435b2uM8CuD0Va5M2?=
 =?us-ascii?Q?Uh5JibSPd+dFNEFAHJ8sL0q54y8Ne6YXPxKibzeFJTIbGQrpbUjv+FgMWM8p?=
 =?us-ascii?Q?flhVX0uKga/kkSIbcToF0o41hF0A6alqbty5ISNQtF6ai04mXATCc3SCRL2V?=
 =?us-ascii?Q?TrVylx/Fqxls6R17gwP8YhBvmdni9KdXjbPLAzxWAtw5syO16l4EXDrQwtQf?=
 =?us-ascii?Q?dKeO0yUWy+XHb/hXzw0CSB+iOoKkgKjXzL53HuUzb/taczsSiqbSRqe6rfTH?=
 =?us-ascii?Q?fe0SXIquef3aQYCIHvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mlZ1P+1xsYfJ50vJsgYpTLL5Xig/CnPV73i5R1pjhDnLaPE8un1GX92aFkkS?=
 =?us-ascii?Q?Xu+KPVwCal7yjGNPtVTYJmHyUJhFi6cT7+WcJmglLKETitKidrygrgfMWax6?=
 =?us-ascii?Q?xTaiydb29fao8E72/knnkVUHPS36S1icov3yPFM38zcFSuLnxGXvEbkSP46Y?=
 =?us-ascii?Q?tCtfzxyL6z2Ps2YJQDBHddR71bTAIjwvHK4XF+z6fG/BFe6mtaP3kFr28qhC?=
 =?us-ascii?Q?KBrhRYPu129OPfKF+93Ru9+KUX2yxPAWYHaid6IbTYU34v5fe6nFYsfqQ4X6?=
 =?us-ascii?Q?EkfC8fER1QgOgjA4vctmXQl/GxAZ0NwA0AgWONQLasDfF+NMox7HUFoYsvRM?=
 =?us-ascii?Q?5gRKRPuu6DUFwUTzGSZbILWRulPBcLVGuG5Ia7eo1I2Mq7RJQzQZwJ8xAmJ0?=
 =?us-ascii?Q?9jkYSezm2zl5lQjVjWvpJEppCVA5/dthILlSUgHoG2Ohks+yc6J1EO3X0Wzk?=
 =?us-ascii?Q?Hw2gP3GAKDliCYC2UiMnBX1pPn6KLdG5zifdFYGU7xOohJ1tf/0mivlEZ2gx?=
 =?us-ascii?Q?URJ3TI9Ob35zk+GP6Qbh1LPIzuwRrPyI9ct2FPKhHhuRj3Tqflf190KwAOvt?=
 =?us-ascii?Q?fbSmCB/511jkOYfvu2U6lXJivKP7fJnC4SOBc99BRA7cMGaSjHbBBaW3E8il?=
 =?us-ascii?Q?imz1hq4BxsRDsPPh2fIh+xM8mDL3BatpRxHm/4i1je/cXzv1jfkSvieRFhP3?=
 =?us-ascii?Q?CqYS6lmyctusX2UAVRAkafXa3k2y5CId91Wm4Bhx+pPh5GDOiDlAHCOvG7aR?=
 =?us-ascii?Q?N9LobmNcUl90gifVzqWO2tya4SDmW6h39TcscQ+NoBYPjQ7CVMpROAA9YwN/?=
 =?us-ascii?Q?rsSCkXhjkXywxXXL5gWrVqZPBrVN31szpEbBiyiMo7e3YMIRJgrve+FmsxyI?=
 =?us-ascii?Q?iHMNtdtpeLwMqybcHQbrDET3ZDtm0VWEBXgqSOJjKjGPrrRkzyWO4/TC7Zij?=
 =?us-ascii?Q?ew5fXfGLDpvyxyC+GCSfzPrheKYbPiqMMj7KRx5blpfZ49do+ie3icUWylon?=
 =?us-ascii?Q?2p+C0LswMYhgtMRbsjd+U35GrkoRYs1+sN+lGxYLGd58532VZRWDznYDtTfd?=
 =?us-ascii?Q?uUpawBTvoZbePEE2ghXD8fv9uU645N/TCI/VQ+qCMv36nyd4/b5LlXJtcoiS?=
 =?us-ascii?Q?UYmq8nfxrrGS/s9gmRxLk25DR1ulxJVMRmqSEqsf29h89+YAz0fVZIDWrQDm?=
 =?us-ascii?Q?lnY2UJgVoReYdclrEXT+W4AKjz1g6JXlFxs0XuRk6DeXpYNukQHWZktWWKQS?=
 =?us-ascii?Q?SgBO3CLxInzEqxvWgtXrP7+8DRF+BOCKn7D0ezQAQfS/cXsttKAMucD8Os3P?=
 =?us-ascii?Q?t9eW3ZbQidR45VK7Ijy4RT+EPBm75ddzynn0o5BXHQhh5n6b6Ep74bPrARom?=
 =?us-ascii?Q?rQeOvIesNbv+T/lxgjNFfy5LUXYUGn9O8nXjN/63gEmouqnbJZAXr5uyGRf3?=
 =?us-ascii?Q?AXRFBpQ7XaJeO3VY0c6NCoI78cfhj8Bk5RlK912U/+Ky0VItnyJGpZZbEEu1?=
 =?us-ascii?Q?6Pul4gJbBcs9HEPP+tsfyOJhVTEOQfxH/FRmAwq3XAx33wmjPvoFgfgow69J?=
 =?us-ascii?Q?+/0VSwGjEFCfpHUMKTa5NoWG1wJ9g1nGJ9VILHj16wiIzDez6joczuJcii9l?=
 =?us-ascii?Q?QT+8AmplWbZPiurYSH6TQepxjpb1ZP85s7MQSK4azk37hHE7NHaw5iNaljbm?=
 =?us-ascii?Q?YHspUYjINCzfIwqT0SjHZMmrVOj9465MIbWpcT3onyW08n6VJsYGbom3JPBV?=
 =?us-ascii?Q?5fAp1fepAjKh5ykEh9x6sV3pykZFCojRohTpHzKkAmibRkOALIHZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 646869e5-192e-4f60-fedd-08de63fd5719
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:47.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYAGnSbxseb2i95D3MD/lSEnz5NC3cH0n+gerAMVvSbJ19vJeeqYq43aZV/SnDFu4l1UwzfSYAmQI8LQdgyg3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8719-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54D38E7969
X-Rspamd-Action: no action

Hi,

Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
instance alongside the PCIe controller. In remote eDMA use cases, the
host needs access to the eDMA register block and the per-channel
linked-list (LL) regions via PCIe BARs, while the endpoint may still
boot with a standard EP configuration (and may also use dw-edma
locally).

This series provides the following building blocks:

  * dmaengine:

    1. Add dma_slave_caps.hw_id and report it from dw-edma so clients can
       correlate a dma_chan obtained via dma_request_channel() with
       hardware-specific resources (e.g. per-channel LL regions) returned
       by pci_epc_get_remote_resources().
       => Patch 01/11 - 02/11

    2. Add dw-edma-specific per-channel interrupt routing control via
       dma_slave_config.peripheral_config.
       => Patch 03/11

    3. Add dmaengine_(un)register_selfirq() API, and implement it for
       dw-edma. For dw-edma, a write to WR/RD_DONE_INT_STATUS can raise an
       interrupt without setting DONE/ABORT status bits, and dw-edma uses
       this behaviour.
       => Patch 04/11 - 05/11

  * pci/endpoint:

    1. Add a generic remote resource enumeration API
       (pci_epc_get_remote_resources()) for EPF drivers to discover
       controller-owned resources that can be mapped into BAR space (e.g.
       an integrated DMA MMIO window and per-channel LL regions). Implement
       it for dwc.
       => Patch 06/11 - 08/11

    2. Add a smoke test for the new EPC API.
       => Patch 09/11 - 11/11

This series evolved out of:
https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/


Kernel base
===========

Patches 1-5 cleanly apply to dmaengine.git 'next':
Commit 3c8a86ed002a ("dmaengine: xilinx: xdma: use sg_nents_for_dma() helper")

Patches 6-11 cleanly apply to pci.git 'controller/dwc':
Commit e3c3a5d25dc0 ("PCI: dwc: ep: Add comment explaining controller level PTM access in multi PF setup")

If preferred, I can split the series into two.

Changelog
=========

* v2->v3 changes:
  - Replace DWC-specific helpers with a generic EPC remote resource query API.
  - Add pci-epf-test smoke test and host/kselftest support for the new API.
  - Drop the dw-edma-specific notify-only channel and polling approach
    ([PATCH v2 4/7] and [PATCH v2 5/7]), and rework notification handling
    around a generic dmaengine_(un)register_selfirq() API implemented
    by dw-edma.

* v1->v2 changes:
  - Combine the two previously posted series into a single set (per Frank's
    suggestion). Order dmaengine/dw-edma patches first so hw_id support
    lands before the PCI LL-region helper, which assumes
    dma_slave_caps.hw_id availability.

v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/

Thanks for reviewing,


Koichiro Den (11):
  dmaengine: Add hw_id to dma_slave_caps
  dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: Add selfirq callback registration API
  dmaengine: dw-edma: Implement dmaengine selfirq callbacks using
    interrupt emulation
  PCI: endpoint: Add remote resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Report integrated DWC eDMA remote resources
  PCI: endpoint: pci-epf-test: Add smoke test for EPC remote resource
    API
  misc: pci_endpoint_test: Add EPC remote resource API test ioctl
  selftests: pci_endpoint: Add EPC remote resource API test

 drivers/dma/dmaengine.c                       |   1 +
 drivers/dma/dw-edma/dw-edma-core.c            | 143 +++++++++++++++++-
 drivers/dma/dw-edma/dw-edma-core.h            |  30 ++++
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  37 ++++-
 drivers/misc/pci_endpoint_test.c              |  49 ++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |  74 +++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  88 +++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  41 +++++
 include/linux/dma/edma.h                      |  28 ++++
 include/linux/dmaengine.h                     |  72 +++++++++
 include/linux/pci-epc.h                       |  46 ++++++
 include/uapi/linux/pcitest.h                  |   1 +
 .../pci_endpoint/pci_endpoint_test.c          |  28 ++++
 15 files changed, 631 insertions(+), 13 deletions(-)

-- 
2.51.0


