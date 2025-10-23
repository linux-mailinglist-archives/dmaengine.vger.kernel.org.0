Return-Path: <dmaengine+bounces-6948-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C895BBFF94C
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942FA3AF5C3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780B2F6187;
	Thu, 23 Oct 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SkAyX/O3"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062D2F533B;
	Thu, 23 Oct 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203988; cv=fail; b=FNu+xMb5RcUdlEgu1fJsrJpgn16ye6PHPjxaCwZ4iHp0fPQRMyoFCpBTzaA59RBhtMG2q9gWJB6n98Tgyxo4z9NULS5zjc4R041Oic2npcfuXQxU2u2m7d8fEOli2xdoPLMta7HkJvHYvqM5uQR+E8dL0UA3qWEj7EYgRrFLU3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203988; c=relaxed/simple;
	bh=IwRJSYYCHW+arUQH+jgv5LVyDlTzgEkG2OXMy0RUcvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUKi4tSrvoKZ3LidvFKNNmx9OZ2/EelUJ5hofGyz78qju5PVh1JyX6GZuIbv3HOretAH6VDE1vJnAFrL7PXlU2SUKY+3lnS+ax5JKdbrWnLVLuVefdGNVthPcpulVZcXh/YwhytZCRHremOI/c7fKcc1OznUO93ipI3MQiCCRzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SkAyX/O3; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovFz1bUGrrF1GW3ENh+APac+lXYv8+N/BEz01vonvgMOFl6IEka6/kfAp8N2NQd/oeeEZzDZejN2w2Uy6zvuIS7Vi0tkd6cSDcLu0cp/A1rxiPNa2s66u2yssfT2NzeVM2H7gUnqqg07gqBMQPlapdxo2umxMiEaT4r7Ld7gBcOCZlNYMx4TybWaG03gcexoFusaHE6jS18fAUd6Xk+19cPrCgw7StHDSh9BDofjCjQuSfO4GRSFtJjC+Y0nAHF7TcBMf4cmHqEJl+iIYY+d5O/PXUR3cz1Fd9iY1GatRj0FoN68o/HyAsVGbc36uqi/Asdv3kw+IwLnskuUHl2fXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eKKf4PLN2NGNo+q5U3GhgohlVVgb0YtLRcj+yQL+BY=;
 b=i0MRwbCa+WeNJ7vsnrIuR8z2M9BIysHHxwxBGIK+73h/G98735Qk/uShRTFb33cDz0njpGnLjJj9FzUbd7UIxOp/61fmNtoixz/jaTb+7G9eCeFdswwPAcY5Ze7Ki+IrZ8uCKHKe2HFs+ao5LWgGJYcN1IwzXZ3HaMj4+Kh91xBbh+2Iz4mNfy9QpndmAWiPqDK1H324AADe1fqKmzcnC/fJZjcsW90PnzF6kVtiP+HzFxkc3+Zi5PXc16vEcwr2oxECcMZafg0x4yPhKwG+mFnXJMv3wQ7UlPArkAAkrv/70bwnRol+zN+xqmjIhqDJA2JWO4raQXxXzlSmceGCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eKKf4PLN2NGNo+q5U3GhgohlVVgb0YtLRcj+yQL+BY=;
 b=SkAyX/O3c0Di6gfTCxg0TJFLUtHSooIwuS3DWMQc4hkp1spKvKWh/GiksAA4h7znXX1IcV0074YeWpCK28lUhi105/yB7RXAPLt+8kyaLh+9lfJXxQyfxciH1c9gsqfPiO44G5E4sL6PccGo4SHxY7/jr53YZoaeEUI4yptwJQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:38 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:38 +0000
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
Subject: [RFC PATCH 13/25] NTB/msi: Skip mw_set_trans() if already configured
Date: Thu, 23 Oct 2025 16:19:04 +0900
Message-ID: <20251023071916.901355-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0022.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::9) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6545a4-99ef-4d54-4592-08de120486dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0RItjBpUvO1mW44x0+U4YhzDoLwPQtmk9kKyX3yVeEx63LPsoiwSpUAIr5BB?=
 =?us-ascii?Q?p5r04euiMUC3UDY3XGa4y37TlWz7E6gpiLhvP5dii4iguGYcCJxiIXRZqq6h?=
 =?us-ascii?Q?pJG0TGC2BtHi/vclOvb0I8PnKUJX5viz1bGf1WmmKtRzlKb3oSa+3KjvkYGd?=
 =?us-ascii?Q?dMXm6xBLA03B3nQbHmKpKrh0tSexpNHFOieWLKhLX4TFQBQ18hosH4OB7Efv?=
 =?us-ascii?Q?+hyk0Scp5YxqjdHrw16Kqlv95wVxf67XvZhMg6bcQZT26keFp2bJUpS75ju4?=
 =?us-ascii?Q?WzqEb8YiKXPFbGXUA+FpXrn6xL6n5IYt2y/4fLRRcU37hMQT/tLN5pLfQSRB?=
 =?us-ascii?Q?nwMIStj8NPFik2swaJoU1xiLyduF25USU+8S6Z6d52POLKsfUFRKN8j5tRR0?=
 =?us-ascii?Q?+y4uOJqQBuBkafAJGB6VrnIfKhewCmP5Qg5ZGmlWe80OoFTrNTYoCXdFWevq?=
 =?us-ascii?Q?rNkxSQrlpM0IDiGuX2XI1lmRHR3Tl93U0l5X1Jow0SFusH3/XykIYp0JXs0X?=
 =?us-ascii?Q?ajTteI+OwV7DH1wbYqmwrghdgZK+4QVC583+oqkh1Umg6T7aWizSwMTOuwQ6?=
 =?us-ascii?Q?5Wxs98c06Q2Fo5/HQEp0r6NChB6i53plQEi38Gu0Pr0pq9bLvr8Br89gGcWT?=
 =?us-ascii?Q?p50oB2H6LcP580e52NihF8faqK2MKepqv+qddGtBYWFMGBr8FLZC/ZUFQSjb?=
 =?us-ascii?Q?sTUt1ugrmutpry9J/JJMk66a1+PYUlV8K9kc97vD4ilKjE/oOs4nozciVGxx?=
 =?us-ascii?Q?g4u9YDJQc6cwL1tbaaDVOJm3iJ14Ab9PGb1jTtAvmN5r9hNqWl3nmLrkoIi9?=
 =?us-ascii?Q?vIUYULbZAeiBmJQvlZUZIZcDPTvDz3LfkYs30GgZ9Hv2Cb9aQfi9FskApsl3?=
 =?us-ascii?Q?blUoIWB71Sg5ynW5gOMT9iIhQrM2RGrKv7oEdp4A3S+0iP3Evybc9zbGscMB?=
 =?us-ascii?Q?Jdh1oH1PZZ0gpSiFP3lGyHWuF7b5fslqazyWEeG1Kx3PWaDhcmo5u3ACQOQ4?=
 =?us-ascii?Q?XAePwWmTcrdWA52i6elmg86s/49KaCm8qvHMgPU1zXy+WGd1T+F/awstgzYx?=
 =?us-ascii?Q?cQcNP1fE1eDs8EqDdYT66lQVku6cADPbw4S4K2/hRzmbCAy2A161x84yjWN6?=
 =?us-ascii?Q?rOE5NtODRB39U+ZxzjELahGpa7F4SMpdo6XHl2XSD3Q3zZr3yQ9yBgVWXrR3?=
 =?us-ascii?Q?gWvWqMOeC7Pqp9WBXG61K7OcjD2N8gKCEMeeaUt1zGFVNReklHW+oYfG7Dla?=
 =?us-ascii?Q?QAQqTSoWobwhZr+nNudMs17Qq85mTRPEw6bTg0z8TkhkwA9xe77qc2hdZlTA?=
 =?us-ascii?Q?Sbg45XRt+JTlAe+CL94DPKeYW8d5cNC67/z6V/Ab/Q21lH2ckU8x5E4n4c+v?=
 =?us-ascii?Q?knGQS8dlAsxuF56ku8K5W2aMAbFUoBC1trBV242HOYbh6JM/wLfbh1dg+K5R?=
 =?us-ascii?Q?yCik/g0ZssgwvCu4Y/59yTj7Ku7b9ZNa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0jdrttSUDaVJU5drkMBiv2oVQvViqc2SrEeKv2wojfAFIge0jDp/oK0v8lQ?=
 =?us-ascii?Q?wxM6SIjRtFJclRpdhOPTisZDkb3YSt6LrlPUdJEQTUvRyZERJ6DB1Dh2H7mz?=
 =?us-ascii?Q?bxrf9qBjObkpL9EYiXZqifKyzGd0ygFSs27S9mCs5zmAZffBCvAMwq8HwDGE?=
 =?us-ascii?Q?kEwEQzAKLBiWAUc9jGS/bSekSnUZ+Gz4d9QCZaHco2CgPSYhQ7oCqMkTdTEy?=
 =?us-ascii?Q?mezOIX4MolJ9A/eTl4zLZ8PLVH4zny2asX651gJteIhTT182axyHdSRwmoY/?=
 =?us-ascii?Q?4WC6HtO0BnTbOesEe1Lti7ECNOcNnElTPIJAdU9Gu3l6xEWzMMUhaeuJ6Wz3?=
 =?us-ascii?Q?NKhYjxXBzuyDwt4rvIWAvCa7mAwA+GyJrfste5ULA5PuftfS8lJfN1LM/cMp?=
 =?us-ascii?Q?5/B3o+BSfhiR7NS5zN/G2oAVP9KKGi4wM6ueydOk2t3FtAlQs53eZyT8K2VC?=
 =?us-ascii?Q?NAk3gsG0v3U+jqKnGXCTz3LUwtrYs72ikkDcVN0ialaSO96GyZBh+j1UjTT+?=
 =?us-ascii?Q?9O/jw2wVJr8EtjdqRAvdpSWVM4CqDwFKqhvZBrbc4tl3qRRque9+tDQX9xkI?=
 =?us-ascii?Q?zP8oI0iY+Vzr5FOWVo8E81FlndUm+H2s9bc9jdvfaSvhYRBrqEUSu6jwKW+x?=
 =?us-ascii?Q?fF+cPvRHqSQIq/lTFTb5Z9Sc68nxzquyKGob+scUsIfLsS7QEcu+LJsYNq4c?=
 =?us-ascii?Q?OgSB4kcCM8IpDukpzmuDN0z+ZvFHQ6+33lEF+EVGn1Yk4GUBi1+zYOgZ6H2t?=
 =?us-ascii?Q?G8zaJe9Ep94gmgAwb11bP02enUaM8dzLmWBHQNYLTEaggPAwxoAr0yi3KZw9?=
 =?us-ascii?Q?+/iTCYk0Xn0pAYF23WU+QlLsiiApMq+CU2/Iz4MkLzI6ROwfz85sWX2NhnpM?=
 =?us-ascii?Q?QG4LLRV8jSuSHdpLAIdjsDL02CQxT/oisn2g6xEgDuHI4B18mohjNoRBxm3N?=
 =?us-ascii?Q?ku5pHO6ayeVi8uzvA9LsedlkRitOGinfwwwheoAIEs4HeHtvGupYmJeJ7tkQ?=
 =?us-ascii?Q?CxrAx0fo5kmwy4PcUn57F04XnTmQbULEqVsk61g62DAlgMhh1rP4ASnGqphl?=
 =?us-ascii?Q?GFz+maMmChS5SXwIjo14w5qXEsrgn5jXH38gKOmJN/7YZ8DsWh5uicdAF17t?=
 =?us-ascii?Q?9JwHJ5L6dMq/moWaTdVToZ1hxo6Y+xANkKwB9PftK8264841NhbuQl4RrwJN?=
 =?us-ascii?Q?9RECTqzacnPdw3KyCj304TqQiTQEQw9W9bG+pmuO3m7V0vJzWB7YANatDSj7?=
 =?us-ascii?Q?Cvu4qui7VHEs9cIA/qj5VmyAYtlQcXguEyjE8+KRF8bQlpH9uWARJon63xBF?=
 =?us-ascii?Q?uNvguZG8aHB/Z9P7jwo2l7XqAwGbXZlDEN1MlRUhnzWNGktIJwzh6dL/W2ZW?=
 =?us-ascii?Q?xU8SN6f/2O4Araww660HTFUwxUhjBIoxCo5X75bh/TxZBpZsJOvcXfoQbKJB?=
 =?us-ascii?Q?B6lSz5cj+1T337iSKCKA+o/OeRLVoX+O/0ayNMkyoeg669zwsRJMufMiPTep?=
 =?us-ascii?Q?GsDZ00VhMcdT3MJw48QcWoHG7QpA9nPH5rSOzGR6rQhSrKO7sXxXfaOlSGgg?=
 =?us-ascii?Q?Pyn062odyHqpPu332PlZ3qDI/cZ2T1ApuIbDdjvGuRg+W4opKNtC6LP22MSR?=
 =?us-ascii?Q?7SE5+UfT+7oAeIwt1b1S72E=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6545a4-99ef-4d54-4592-08de120486dc
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:38.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOGDsnYNPJxJfuV+kx5+eceaxyDrTneQZ7OVlr6ZEoogK4l+R9v7JkFb8rXFKR5z6osam466pZcDm+VzvrUcbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

Return early if msi->base_addr is already set, avoiding redundant
mw_set_trans() calls and unnecessary reprogramming of address
translations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 00218cfa6fd5..6d48418aa756 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -106,6 +106,9 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	if (!ntb->msi)
 		return -EINVAL;
 
+	if (ntb->msi->base_addr)
+		return 0;
+
 	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
 		desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
 		addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
-- 
2.48.1


