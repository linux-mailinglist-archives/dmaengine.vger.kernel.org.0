Return-Path: <dmaengine+bounces-8826-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPtRHfN+iWlx+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8826-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0719D10C0B7
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86DA530087AF
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780282EE5FD;
	Mon,  9 Feb 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qRIv30yB"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020126.outbound.protection.outlook.com [52.101.229.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA072ECE9B;
	Mon,  9 Feb 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618603; cv=fail; b=j/BLGfxeTBaV170UHNf4/zfrhUwOaF1xQjo08PgAlrwzGTxuGq6pYQ+ZOYrdu9fTZr+GnhPWFUVYCydKTiOcOXqSmSvJ0Hg4VZbZ7zhFmw6SLH5gg2CiNTOiMm1csRRyX99EJpadof8Ksif06uAtGOrLvL3j38CZRenWlOC1bno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618603; c=relaxed/simple;
	bh=lXfJZIw9AX+NJWDkD3dF8x5HAzKct0gZYRojwUwrJGw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ln8ha9e8TPCmMUa+vkcrc5ZYgczNkog5xrPits8tVg5H/4Gibh7dWR4o5Tetc37aq1XcC68Hk/qaWXTXrpf1n3XfHbzow698x+ybOj7qiYni85Bx/CV1kRktC2xTUk/CQ2izYoxSKmvK/qP/JpkDc35GNBIfgFtlcIzwlTVZfSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qRIv30yB; arc=fail smtp.client-ip=52.101.229.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZzPesSiv3qZXkKi8vyFJsVUuVt0tMJ24vnSOfnwdsIPsOUT118gbhjLbA09gmN7faQZ8jFBrqFQRK4UckANucjLF9ZazCfWdjV9qzDQp1LSE/T5AOnUyZJuwIxBwonlUZ8nzXFHxAI1vV0N302a/cSQUUfWBdcOMn/N0q+JhA+U65pRDIr1/ItcmkK/hXp3CDjhnHqVq6LJejVBYFBKh80ALtJv/UXnvPE032N7QgG9fxUQoq3GKRkf1kl73fC0AeqLPa66yWiBx9knjCCSR2QCbqV3tY9x9qJ3IY+HO64V8GR4QYtAcEJohNHNcvwWNrPgF301uV9K3tnJKc91sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV20rzS6aOq11oWT0Z6PKY7PhbZdcxz3qjIj01zC3Ww=;
 b=iG9cxSr5Ga+sJy/PHLR2V5Pxxj7xbvhBRothEZmdn5xHOo/P5G1auIRJios13xnWQNiQte/pBJtl2mbL7yoiY9Q+HtAdVe4necNLocM1hWVBTUvP4Icc7+m0dRtgTfOSCN3uMKiQUYIP+DRZut3o0bETRM3eFesMalRk/9HouDXb2Vh1YQv5wudS3Y7COVkkoEKauomg2BksMis+LLp8mWijlQrGw/M6Ey0ruNkogSl+SDGfJFa4LKagJQs344ASJ3hiag1wNqLb2X2glpU79OT1zoBBKmcxv4yViMjGEE3FMuqSDsFBt293JnLBq4yZLcbCKVuMO9SzswiRZo2urQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV20rzS6aOq11oWT0Z6PKY7PhbZdcxz3qjIj01zC3Ww=;
 b=qRIv30yBo9I9JAsY/CuhOWvaXcosaE1v+I8GYtxrUnnB83NF7IlMrfS8OzDlX/EXknhWoPfGkEWNvclTwuhwWbDDY+Z8HwD7FsRkXcHzlHTOHTPPhLdelw5agIKxlMHbNmyZ/Inhpv6EBwUPZH8qr9gLvFmbEa2sDHaA7oBq6NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB1974.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:165::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 06:29:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:29:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Mon,  9 Feb 2026 15:29:43 +0900
Message-ID: <20260209062952.2049053-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB1974:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f43256-9ea0-4be3-2471-08de67a4a618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1E6XqbHfwebDFCxFBu7pmjMuFIRzDvavwTADUl4/grHeKIe1KmC8ewxM7O2?=
 =?us-ascii?Q?xeFv/a8F8nq7CACYnK7f9VnWczau7ZhRBYRQnUknNUDglOJkP3+LhFqQIrkQ?=
 =?us-ascii?Q?uEvdg5XVXww8pHNuKPyAwsWtTajPPkC1QkMXBtlf/JGlM64rLNr7NOpLCcOH?=
 =?us-ascii?Q?ys7QCYVFlkyXn6nAJg+RtxTdrS8dAD/6IwWT/FRuljCIFs8/ox0/GlGrfX/F?=
 =?us-ascii?Q?RJWyjbWvHknhUssL4rBVkacz9XJNcA4nrUBzQZ3ZrL4Hou2wi1q73cWFdJcj?=
 =?us-ascii?Q?jcqdQG+o8oudOMdAJEfIU36CoZXYpOoZT2czZWED2ZxO1csPhBpJrxA/LTQV?=
 =?us-ascii?Q?4+XLoe5e3jG6kujDn2Yf8+d0odXtzYBfJ21wSbsQYjLJQK8tzEwbl/Z9hfb+?=
 =?us-ascii?Q?LoMvSjcGdPwOY16N2Demj6EAhOIqlJOaCiZEh6KmLDg5J8CaIf7m7wxmb+tk?=
 =?us-ascii?Q?SBmMjHLpsfr0KgvIUAhvgMTxZZLlGrcYqX25DM/PPc2mYqR7/pUBb92WyBYE?=
 =?us-ascii?Q?1wKZOMQwYL93z7VTNzT6Pvb78CSvlBWG48C37bnKvf0fMDR3RwZ7fpQEpWP6?=
 =?us-ascii?Q?zrPyI/39qQvDa31Ho2TB59/4BTcJSIeZrgF5fEwD7Llb4W//1yuAxmOrB2nD?=
 =?us-ascii?Q?gUD2szeZgcf8xE/uP0IKx5zajWyt1uFEDLQFr0/k4a5Bh+Sqe4orJwltIUlf?=
 =?us-ascii?Q?zi5o6YK0OPD40JduI0RccDySNEEzEJd2w/C6P74+s8IFDMS5j1jWHPVruWc5?=
 =?us-ascii?Q?Q6D10ujJWKgi0iTgVzXUhaMYg4QHSFNQRUo1dWs4Kh6010masZ8pfa33xmC/?=
 =?us-ascii?Q?f112nZ+XsBDiBE2/3QbaXeOdiHhUahqN6Yel+wT3qecEhgIdDX+us//wSif9?=
 =?us-ascii?Q?PdN2TSv5S9wUG3f6omeLBBSYEVrrpxlWs7QHhb1M2Jg/t9ml9g/2gpgdkyQJ?=
 =?us-ascii?Q?Ik+8+ZtCQmecKSnqQW8C2GKxAJgs/ud2a9apOkf5V7kGLac091kxvV4h72FW?=
 =?us-ascii?Q?ceZiRYEXAgWnXHQ6kpxi5TIik2LIfEZDk06P2KA3S1n3eI2OC2x2RnrkiMSI?=
 =?us-ascii?Q?CvC2YXNOrLnicTd8ZcsaFw90bbWJSYxeeb0pkq09uDT/sTFVs32LdIcZG4hv?=
 =?us-ascii?Q?O/EZgpdjVvo0pK+jV6bPM6tR1o0jPR+7+Vyp9MhN10idDFeKFuVqP7vcZVgP?=
 =?us-ascii?Q?jLRDdSse36+266CzGgtMql6ixN6o0Pz2RVIWNQyEmRtYO1otimL1N72TixMC?=
 =?us-ascii?Q?oRqHrS7/2qDRUhoEPGEwHn13rCk3FK9bl5wbtn0fjRxeJ5HipfiShA2CwQVe?=
 =?us-ascii?Q?9aRBZrsKtxEwungmwiRtiOuaiAw81TnRAfkZ+Wrphi3Mh7X80k8u+TjZevxk?=
 =?us-ascii?Q?NN5lYw01ti0q2I6Yx6wG+Na72II1iTTGBclwRu0l1R9LHTSuXNQuwrRC+Hrv?=
 =?us-ascii?Q?yeEDVXBf6SjeBuIGy/LiD4U8/MBZebhtyV5Ti7ZuTuLKp3CheFhsbcnlhx4i?=
 =?us-ascii?Q?Rxcl+fgmgdbCUyhbXxysXNLnN9i9YPyDcOUTAEuxBx+rBOpCFymfIMYY2JEH?=
 =?us-ascii?Q?/pj9A91a2fjOPr+cjPkmQhcpyzMwahLYA0EPqxBbqVH8vzkq1Fqd9+y/Nptg?=
 =?us-ascii?Q?girK+lr+b/qQkYNSsUdah3o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9TZPSrryyf6lMBbOmtbmPpOWruBgh6qshZJQ+HAFoNjDQNvkJcpS24hy1lQ?=
 =?us-ascii?Q?B3oTp6UCCLM1bJud2g9iJfZzmqfr9PrWFSKXytWWhfpuT9Ec1a1fue3EbEYI?=
 =?us-ascii?Q?Vghd90VV0JgwYaLvHbdcsbCgxQuU/wheC5T+ZcGHlZVI1MCsBa8GAdJtM1LG?=
 =?us-ascii?Q?M/2N9Q97iao8OzGQ9Z6c5ILmg6/6O2IoyPHgwYLCHvbvCvbLm9j3K88Pvcs5?=
 =?us-ascii?Q?ToQUTvZZRPrS6SbDJyF/hd59K7Va5NpGPVyv7nRkU8+JFQz26Ixvk5mxgaga?=
 =?us-ascii?Q?goLEpvA3nvnIgK9wMFpgiTbwOqkL6H9pBV8e7SkgOU3g8bCxFG52BiSvLJ5G?=
 =?us-ascii?Q?fE0MwRwnO+kO03p2SZt/KIWGOmqjtI+oLzi+7kQV6r5R1sQKoHmGXFQiqASR?=
 =?us-ascii?Q?RkEQGVS3siAInaVEgQJU8Z5MUe8GHQiaOC967EgMYLSKuzUM0NfSGMG9w4vd?=
 =?us-ascii?Q?+vqfHUAzTv4Ttc9t1Kn78G6MdqAsxKuwiNCS22rc2QF4s3NVBs11tEHcy1Ud?=
 =?us-ascii?Q?Dek1zG+PhWPohRkb0XZ+aNfjcA6tNiz1S4mR3IIpEMATRCS3YpsN/T5fASBT?=
 =?us-ascii?Q?vS82Um+JzlShPuiRd0dZwS5hswrsVjE8Jix/Nkvvnz4h8M3FGH4pJKN93nTw?=
 =?us-ascii?Q?wNoJ2MIv4QC6PH+W/jjTmNb3HVt8YpZrPnZ1hNm9FKGmOoFtGEjuR4eqIrW/?=
 =?us-ascii?Q?RnI/hHf60SuPwTp5/sMHoZTJSEWd3tGeQLNo4Edwr0GGcx+wOTM+FwMAw/qu?=
 =?us-ascii?Q?jYcadsLMooT386vuJ0JtB8c8G1goxLh60QWF6KE7r+i6o+lFZf0O8gDDq0EZ?=
 =?us-ascii?Q?sTC1m5qKmQzJSAHmncpluHERFUjWnEyTKONpBqPN82CprsK4l4L26tN5wtmT?=
 =?us-ascii?Q?dfWEU8R22MpOmf3oGTLgg6SQDEVmzlMzgMtpDsYZx2WFCi08n/IKQh6WaRSa?=
 =?us-ascii?Q?EjYmOYl893WDGOmcL68O/7TjTpMnRDuOenGY2fyQc0dsoRM5pu4HWv3/Shod?=
 =?us-ascii?Q?D4ByEySWwANDka4T9h1JpwBGJFS9Cs9iwyb6bJosJjoq8FiVkx6uIx7CtkYI?=
 =?us-ascii?Q?DFLMvDgvy/0zDA8MYcwlAbHkP01V+1wgocxeqF4Zd9OH/jXWARrLoimhFEYp?=
 =?us-ascii?Q?d79IV0xHgZrLg3IPxLyEkMsnn4Q0O+JPJoLHlNByC00aJzuIPwT7fxn5pdZa?=
 =?us-ascii?Q?RRS5ZPKcuReTGMnYBzPAzxIhVliOGaMebYvw5ARO2vyJPxyYjyl6PJy4DwLN?=
 =?us-ascii?Q?LoHceI0Pd/CA2cxbgSpIr/aEnDTMjLOXGzIGmzYqXn5TMnS3TLhaBhNJ6jRs?=
 =?us-ascii?Q?MKUlGuKC7s0ms2oMzZ1CGP2aYbpfdi+Bqx/1weEHBFpFs/3M9J7sEaZavz1Z?=
 =?us-ascii?Q?Pjcf+STHKxklN+PfeOK0tHD4UsDMvhOXGayQ/A2fZ13ijrYW/8MzDq/xzui4?=
 =?us-ascii?Q?T4bl/qoWGjK3zEna8FxiVcs/lTCJFrtKOAXTA51pE3DAblqZ/bwv+a8PjbaO?=
 =?us-ascii?Q?itNMmNzRfwdsF0ZZLdtZbalvaaSAmurPZLvQXc7E85hDe0KwAsBVfbDvAPgY?=
 =?us-ascii?Q?sUQCzw0VdfeD+sjQ5Qdx8EpNgXddzgx5BXlNBivF+4Du3zhv091BxtuBIcUK?=
 =?us-ascii?Q?oy4MLa+vtfQBQtpBYO5j7bJdicpO3vuUFAkk6lZ0kmoEpjhZuchJbgIYH6Sr?=
 =?us-ascii?Q?2mJU6OrqTREa+fLrSBNzdC79gHviwzJLNIAE/2q6chvr66UWs5WkcER3wECB?=
 =?us-ascii?Q?WwFrzeMR3gLz751oXV6Ns01AUlQ6jKeT3gZNVOWZZhdyKe8SLaOv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f43256-9ea0-4be3-2471-08de67a4a618
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:29:59.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuZjb63PIVSi5OdqbClzFdjdkH62PLAXtRUIhsgQXHR89Cgzhtb31IS5eR87CeRdWypkaWLeWfHwZAeey4J3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB1974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8826-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0719D10C0B7
X-Rspamd-Action: no action

Hi,

Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
instance alongside the PCIe controller. In remote eDMA use cases, the host
needs access to the eDMA register block and the per-channel linked-list
(LL) regions via PCIe BARs, while the endpoint may still boot with a
standard EP configuration (and may also use dw-edma locally).

This series focuses on using DesignWare eDMA emulated interrupt doorbell as
a pci-ep-msi fallback, in a generalized manner without exporting any
DesignWare eDMA-specific API.

  * dmaengine:

    1. Add explicit deassert handling for eDMA interrupt emulation in the
       IRQ handler so level-triggered/shared IRQ lines don't remain stuck.
       => Patch 01/08

    2. Cache per-channel IRQ number and an interrupt-emulation doorbell
       register offset, so integrated-controller drivers can expose these
       to EPF users via the auxiliary resource metadata.
       => Patch 02/08

  * pci/endpoint:

    1. Add a generic auxiliary resource enumeration API
       (pci_epc_get_aux_resources()) for EPF drivers to discover
       controller-owned resources that can be mapped into BAR space (e.g.
       an integrated DMA MMIO window and per-channel LL regions metadata).
       => Patch 03/08 - 05/08

    2. Add an "embedded (DMA) doorbell" fallback to pci_epf_alloc_doorbell()
       (used when platform MSI doorbells are unavailable/unusable), and
       update in-tree users (pci-epf-test, pci-epf-vntb) to request IRQs
       correctly (shared IRQ constraints, required flags).
       => Patch 06/08 - 08/08

Note: As discussed in the v4 thread, v4 Patch 01/09 (dw-edma per-channel
interrupt routing control via dma_slave_config.peripheral_config) is
dropped from this series for now, so the series contains only what's needed
by the current, concrete consumer.

This series evolved out of:
https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/


Kernel base
===========

Patches 1-8 cleanly apply to pci.git 'controller/dwc':
Commit 43d324eeb08c ("PCI: dwc: Fix missing iATU setup when ECAM is enabled")


Tested on
=========

I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
R-Car Spider boards:

  $ ./pci_endpoint_test -t DOORBELL_TEST
  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
  #            OK  pcie_ep_doorbell.DOORBELL_TEST
  ok 1 pcie_ep_doorbell.DOORBELL_TEST
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

with the following message observed on the EP side:

  [   80.464653] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback

(Note: for the test to pass on R-Car Spider, one of the following was required:
 - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
 - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)


Changelog
=========

* v4->v5 changes:
  - Change the series subject now that the series has evolved into a
    consumer-driven set focused on the embedded doorbell fallback and its
    in-tree users (epf-test and epf-vntb).
  - Drop [PATCH v4 01/09] (dw-edma per-channel interrupt routing control)
    from this series for now, so the series focuses on what's needed by the
    current consumer (i.e. the doorbell fallback implementation).
  - Replace the v4 embedded-doorbell "test variant + host/kselftest
    plumbing" with a generic embedded-doorbell fallback in
    pci_epf_alloc_doorbell(), including exposing required IRQ request flags
    to EPF drivers.
  - Two preparatory fix patches (Patch 6/8 and 7/8) to clean up error
    handling and state management ahead of Patch 8/8.
  - Rename *_get_remote_resource() to *_get_aux_resources() and adjust
    relevant variable namings and kernel docs. Discussion may continue.
  - Rework dw-edma per-channel metadata exposure to cache the needed info
    in dw_edma_chip (IRQ number + emulation doorbell offset) and consume it
    from the DesignWare EPC auxiliary resource provider without calling back
    to dw-edma.

* v3->v4 changes:
  - Drop dma_slave_caps.hw_id and the dmaengine selfirq callback
    registration API. Instead, add a dw-edma specific dw_edma_chan_info()
    helper and extend the EPC remote resource metadata accordingly.
  - Add explicit acking for eDMA interrupt emulation and adjust the
    dw-edma IRQ path for embedded-doorbell usage.
  - Replace the previous EPC API smoke test with an embedded doorbell
    test variant (pci-epf-test + pci_endpoint_test/selftests).
  - Rebase onto pci.git controller/dwc commit 43d324eeb08c.

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

v4: https://lore.kernel.org/all/20260206172646.1556847-1-den@valinux.co.jp/
v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/

Thanks for reviewing,


Koichiro Den (8):
  dmaengine: dw-edma: Deassert emulated interrupts in the IRQ handler
  dmaengine: dw-edma: Cache per-channel IRQ and emulation doorbell
    offset
  PCI: endpoint: Add auxiliary resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Report integrated eDMA resources via EPC aux-resource
    API
  PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
  PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
  PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback

 drivers/dma/dw-edma/dw-edma-core.c            |  57 ++++++-
 drivers/dma/dw-edma/dw-edma-core.h            |  19 +++
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  22 +++
 drivers/dma/dw-edma/dw-hdma-v0-core.c         |   8 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  78 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  38 ++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   3 +-
 drivers/pci/endpoint/pci-ep-msi.c             | 141 ++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  41 +++++
 include/linux/dma/edma.h                      |  17 +++
 include/linux/pci-epc.h                       |  46 ++++++
 include/linux/pci-epf.h                       |  17 ++-
 14 files changed, 471 insertions(+), 22 deletions(-)

-- 
2.51.0


