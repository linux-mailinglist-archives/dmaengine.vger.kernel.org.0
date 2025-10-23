Return-Path: <dmaengine+bounces-6940-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22CBFF846
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3AA19A6509
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C42E0411;
	Thu, 23 Oct 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Lpzeg8Yi"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977892E92DD;
	Thu, 23 Oct 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203975; cv=fail; b=TUa55fmbxhAYqs+9+ocwEmNqD82IL30MxOz4CSBaDdwqLgygAg225Sk5xQqL52dP3XVXNPi9TE4k+l9bhZfAVNKeA+jMmsQS5nZdTFDWXxaHmppyw0Oc+gRSArRw9dPC2OB76MZCWMaiGzwvIjYF2xJaV+o8zQsbSI08DSlDz9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203975; c=relaxed/simple;
	bh=xB55dIyctDZhBRl7GnM6pSLRk1u5twZOqPvIarE3RbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2eIggj1OmOyHDhOC+e17EKAt52vrqVQY0BfnTDpZM3NQb+PGJrnFuAiY/m5xFKOdfvCNQMAG3yoTdBaFWep9d6r3koC/f82UXoJZWOU08ZZEBCyxjvpNuiFpocwqzwYwtbUerweZcVxi8QhtIbx7Z/xj+CUMOXoezmB1dCguZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Lpzeg8Yi; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8M5i+IKHa7hO7N57J1bKn8Vv7uHLGmY64ng95qZmr/EY1nJKM9/YGqPQpo4Q+kR7XUnhx4pYi+KwobwAlBvfx+Gt7XDZrnlQs1ve7d2PqdCcQJ4lcqNaNeT3q3j7jf+FjU41ESPA3F/Un9KoIVVoZcM7OlfSGzou9Fb5rmnvc1dRpTZq8teiR+7MqUeD7H0gttrd9X0ViBgYubT86cNn+Bibt0a01TPS6DW7itfRrU99+hMBAtEncyvyZyajA9VdoXnJLKOwPlA051H15h8goiDz0PIGIyMUuDfQ+39zj72SA1ddAJIn0Wpg01u3/ei6iGtoq+5hoZk3ofGUkRSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gdUTrx3yiNH6JbvYN5AciSbf3dvcsYhf2+LjTIRs5Q=;
 b=e9gLTIyH/fzioGG+DmGwoYK5r566QYOkYYbM3Qp1ydnY06LTaKbZlsVVejlN/DKWanTDt2/UZyg87yrr9BjsMhdclgWAbvIAXmRCPFn/zRc22k5O9zp5I3SEdEA65Mb6Ezx4E1T5JyspH+TPPIw7oqz6BGTi1GCpLEl16ZC/TE3fDO0Kx9UsBIWV396GkxoAcNVNF9SkZsTDpPL+BAKPES73p6X4UFj6BltVI0i4+Idtj4uDjPiD/TmcHlNVo/NlC92ayqnxl5g9nnbz0T/Ocs8zpFSLd7G9/2cXVjipv+sajnDHGmQOKCbuxeuN6bUULVY+Td6rUrnn+z90W6D/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gdUTrx3yiNH6JbvYN5AciSbf3dvcsYhf2+LjTIRs5Q=;
 b=Lpzeg8Yitmr7KDKuHdGFvhs7YLo3baJB8eNAJKaP+XLAB+vGaR5ZOWakp7I33p64wvDH3uhAh+LnHTSNSw47DRVXmjuFGiZ28TuaxtNP0R0KjWKMizdVDkvQc1WdWnGBXQyPWt4HS4zf8cTw5ohSD03SYNWA5g5/yeq7vP9xpss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:31 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:31 +0000
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
Subject: [RFC PATCH 07/25] NTB: Add offset parameter to MW translation APIs
Date: Thu, 23 Oct 2025 16:18:58 +0900
Message-ID: <20251023071916.901355-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0092.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::16) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b99437-69eb-49d2-27d6-08de1204824b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?66TYCRwseo37pGjpsuhPPwEyj09Ef1v8cmqIhZyry6xGeTeZqWgMnf8T6tjG?=
 =?us-ascii?Q?hGpARSuN9IfklIBd7g9GmTI6HKt5y4MQPuDnQb+KP+Bh6hNo4bY4j6xdXksh?=
 =?us-ascii?Q?+MpjB5xBFTtwn3pCQAVpJKJXmpe9Jt8Rea8M0O5uS4jq9nZdVhGVY6dOsIL4?=
 =?us-ascii?Q?xK0eFMqpSHWCxDfpaKpKbMGSv2vePlEr4rXDUdRew1KOPseAdx2IPJyqqINa?=
 =?us-ascii?Q?NGVT4LuO9FUgm0WszlGyeWUCjN37RoQneEyOwD8R1fghUFzBrRt7njyvT9vR?=
 =?us-ascii?Q?7iqnmt9L+EFj6yPO1Sgq5kFmdCNFTy8tlnOu2gmNPwILcc1ta/gmloaP1cET?=
 =?us-ascii?Q?WnRHVTUVO9Iz3Wo7AfDIrCkYG+Or/gMpY7XqIfdvr3o3DDXLsFT1h6kv0vb0?=
 =?us-ascii?Q?H/c28qsbltcTXDqJ+m4Pv65Z5BBGMQ0CyeaENCV/9b2zhA0wqZs4Wk3ntKKU?=
 =?us-ascii?Q?6iw9k8kUfE70VtYenWphhxKe+rwkYtL5j/FrWC0LJN6sNW5SzUDESOrRev8M?=
 =?us-ascii?Q?8dx5KZSWyNSHX5HEjBTOVR8Ne1CNiG2HyCm6YKzMXgrZ2JFZnfTVNoDaMrMS?=
 =?us-ascii?Q?9OuBIbECOjJtL8so3cd3Mk8HDdJ08P1mmQheIKcnNK9XhwmveFhkf1Rk/2/P?=
 =?us-ascii?Q?xfL2ibYF3X5Jtn3rSpPVhDjhg1GAhh2hR6hH3L1jilfU0zpT8CVa3sT4//5w?=
 =?us-ascii?Q?oU9y+8/Mn+21RJQoyO83MDDdSuVM6uykLNVbuQ8BTyya2OZnuy4uldLgt9Ut?=
 =?us-ascii?Q?lYxM8pk+BLCOtxjVHqgxvtG4y2QXWQ17gwJHa1QC+tmyvpsZqeYrDjQB6A9m?=
 =?us-ascii?Q?osV/IYS8EgkvpkscfdZ4oEAehIB6H/sSld1mtUdJT8NDjSASxu5D/xSGjcwm?=
 =?us-ascii?Q?wl8w+tHhCNmLbsTwexEyc14BRkLYZJ4K+uLHZcnMeT6FXI1pXYIBwxwElf21?=
 =?us-ascii?Q?FHEMw5Qqv4BpzoiQrY/WrKtc808PT/jExAxkwFE3UufyPFPZ32fOFPbmnQH3?=
 =?us-ascii?Q?zA727m6DIafn4ZyBGNBHro0SB4XL/4ZntSxTFREUVKdCNbVLOJSkScQ+lTlL?=
 =?us-ascii?Q?n2g+yYBaui9IddsDtU2tDFDwS+pHy1Yv7pXgoY441AYRrfet/4j4XgiiclOz?=
 =?us-ascii?Q?FPeFCtX5FiSYe4d8do/SNINcsFYNlWixqLNFnCT299BGyYYVZuUDDXt4SL2P?=
 =?us-ascii?Q?B3Hq3Njd1P/Myjjg1USFurAxMMO1FmZYr3+A+c4KE7VDLVIpa+Jdu/gv8GXs?=
 =?us-ascii?Q?Y7vaOjtkqWVeydAM9bMtZep9OTkKafEIj4ad4ckPwK6uTsfuvehxchzIvP7h?=
 =?us-ascii?Q?FCxJ2EHpvrML9ILezoHHtSPbZUbKe+xSYS28e6LXVtj0GCHdC0ybo5C6GpZ2?=
 =?us-ascii?Q?RvKtCW7THyJgf2a+JldAay0ENgT59dqvoS4kAR1CXe2da1gbChwtNxeMJMjl?=
 =?us-ascii?Q?RhItEUo4txoUp1YEYdBnbi7MZ40QwTrQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ElhpBLYeL1YZluaOGeuKrYnPCMobC4PsitKbl2PtQz3rvDdH5IjuR7TG8ZBq?=
 =?us-ascii?Q?JhA6FEDbvc6PQ4VZ+1EZbhBsFcvT4Hr8aGfhemEDdZl/fOZKYVVO/uYvuYdx?=
 =?us-ascii?Q?ZfbLy2juYixqe62Zbws9irfqROQEYtKtrJfhoTYNQTZYe3Idelf3+mQVkK3q?=
 =?us-ascii?Q?8d0Yv9Bsq7ZxurfJcCXBSJ9cdBjuT9V2GHzUPd52Fr9IdC0nt22ww+g499r7?=
 =?us-ascii?Q?FuLTPW3fo4AmJvxqnhg8WTR6/lSnhIVmTb1WFTFtDi10c9HvDVw8/oYVranv?=
 =?us-ascii?Q?RyimsgdsRaZqMDs2NkhGW1g8tcL5wEUcxG4ns8jjynMmTY+Fi2F53lgpGRom?=
 =?us-ascii?Q?GoanTrs7QzUTFHvgLoaVrX/aQvkcRLKRdsY2LAqsuwbC2mOkk01quRSTHHlp?=
 =?us-ascii?Q?DXaUYvatpa4dwLR8SItC8ZS4a/aC9cy5ryOc33MtM0WWJ0rU+Vyw0Ie538Fw?=
 =?us-ascii?Q?WWBhYJg4ZOZVL5b2ja0RL6rRV9syct7erUV6CN/74PqdejJtR/dSsyPujJrc?=
 =?us-ascii?Q?MPZzfWO3WQxZNJH2fvBrWdBozUNi41MpFUrYN0tVhWpljaQpjVHgaKNApz96?=
 =?us-ascii?Q?zRiew9uPmM8u7O+UNYTIws5yahqnEUOjNSISZfdOvSBuhksvqBJt8dkBRxw5?=
 =?us-ascii?Q?q0hhaXrCdzOvhW8oaQnYk4avXkWvUZanSG0F/RwJACgcwmngoKDtvKwfaIPS?=
 =?us-ascii?Q?2jbUiyUOZWIhZ5omGuLT/RPULdcKdpMxigtCh9vB5QxvHc45MyVVxEU5i046?=
 =?us-ascii?Q?WuEA32Ev/y7A1JWV5aRvjsVtiRZjkCnc1ZqxJRdLTv8HKnFWJNkL3ssjIj1w?=
 =?us-ascii?Q?921ytdG/gpcrFag2SDN+y6J9+1uCplvuzzV38Z1wpTTJYugftnAZQfzPSV4T?=
 =?us-ascii?Q?RtR+scrlYDeWUWr3LnATeOLab/So2VTQAdVNSWX5aCdQaH4UtJRaJmwbOb8E?=
 =?us-ascii?Q?jAZfPqSWQzwBweOXJKmXFdBkAep3GcndBrThgJr74T8AwZyroHXOl418aDv3?=
 =?us-ascii?Q?AWTS0t8ROFQRuDocIswsfBpBkI8ks5ywJ4dUbQjBYlH/XlFO/KAGouPaDY6e?=
 =?us-ascii?Q?gR/8qDOFqgIaKaoKsSNasPTrBFLPhjkIxsUAiDx5uZpTWJgYaskROaAkLI9Q?=
 =?us-ascii?Q?oTmW2HqVh9DuZ+z7iGuUM9HYxhiKecQ8rG4lBxJL0cybSuW9O7CIQc1xXdWW?=
 =?us-ascii?Q?PLExww0ZXcdwFc0dD11d0I61CBnpsDZ+JjKEPGDZZ5E6d5qK30GfoySvFOmE?=
 =?us-ascii?Q?ryMANKSPJc276UablKK0kz5gLdxqKFfT5SZ6zp3j6DQe0Ln5aWJl7+WJnlTU?=
 =?us-ascii?Q?exKF9ykI83UEyzC8i1ZMcX5y+izocFP8aQMJm3vd9YIhH69SGW1PJh9DLHan?=
 =?us-ascii?Q?mLi9MWhujvGh/K/oZeoMdDhfPnkHmEbocGmrCUI77iNh/vTnJLlZVRiwOnMB?=
 =?us-ascii?Q?HSwqift1pX0Q1lWj+iSuf951xUHbTlP22ELHgCoUN737DrJ+ThBqUoIwTU1s?=
 =?us-ascii?Q?xQmK3vkWnobyhxPu49UO0123vOciNJPkHZaRbKfUmhLbyt/BJfQ2OWbe9xBW?=
 =?us-ascii?Q?oPoozLrBtKW1zZkNpoz4vMREp9G/xxL29ASkunM5YbWuZMQyBkOHmEsDCs3w?=
 =?us-ascii?Q?VacDukbCSI9q72+RotV1+Lg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b99437-69eb-49d2-27d6-08de1204824b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:30.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hT5BEqVx1yI3mk4Dvm2BmekPnK5yQg5QU8WivLLDggE/nlk39sG4CemMQDl52oszcA3JiE7V0aIjBkHP52GlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

Extend ntb_mw_set_trans() and ntb_mw_get_align() with an offset
argument. This supports subrange mapping inside a BAR for platforms that
require offset-based translations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c               |  6 ++++--
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  6 ++++--
 drivers/ntb/hw/idt/ntb_hw_idt.c               |  3 ++-
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |  6 ++++--
 drivers/ntb/hw/intel/ntb_hw_gen1.h            |  2 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c            |  3 ++-
 drivers/ntb/hw/intel/ntb_hw_gen4.c            |  6 ++++--
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |  6 ++++--
 drivers/ntb/msi.c                             |  6 +++---
 drivers/ntb/ntb_transport.c                   |  4 ++--
 drivers/ntb/test/ntb_perf.c                   |  4 ++--
 drivers/ntb/test/ntb_tool.c                   |  6 +++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  7 ++++---
 include/linux/ntb.h                           | 18 +++++++++++-------
 14 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 1a163596ddf5..c0137df413c4 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -92,7 +92,8 @@ static int amd_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 static int amd_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 				resource_size_t *addr_align,
 				resource_size_t *size_align,
-				resource_size_t *size_max)
+				resource_size_t *size_max,
+				resource_size_t *offset)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	int bar;
@@ -117,7 +118,8 @@ static int amd_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 }
 
 static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
-				dma_addr_t addr, resource_size_t size)
+				dma_addr_t addr, resource_size_t size,
+				resource_size_t offset)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	unsigned long xlat_reg, limit_reg = 0;
diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 91d3f8e05807..a3ec411bfe49 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -164,7 +164,8 @@ static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 				resource_size_t *addr_align,
 				resource_size_t *size_align,
-				resource_size_t *size_max)
+				resource_size_t *size_max,
+				resource_size_t *offset)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	struct device *dev = ndev->dev;
@@ -402,7 +403,8 @@ static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 }
 
 static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
-				dma_addr_t addr, resource_size_t size)
+				dma_addr_t addr, resource_size_t size,
+				resource_size_t offset)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	struct device *dev = ndev->dev;
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index f27df8d7f3b9..8c2cf149b99b 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1190,7 +1190,8 @@ static int idt_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 static int idt_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
 				resource_size_t *addr_align,
 				resource_size_t *size_align,
-				resource_size_t *size_max)
+				resource_size_t *size_max,
+				resource_size_t *offset)
 {
 	struct idt_ntb_dev *ndev = to_ndev_ntb(ntb);
 	struct idt_ntb_peer *peer;
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 079b8cd79785..6cbbd6cdf4c0 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -804,7 +804,8 @@ int intel_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 int intel_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 			   resource_size_t *addr_align,
 			   resource_size_t *size_align,
-			   resource_size_t *size_max)
+			   resource_size_t *size_max,
+			   resource_size_t *offset)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 	resource_size_t bar_size, mw_size;
@@ -840,7 +841,8 @@ int intel_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 }
 
 static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
-				  dma_addr_t addr, resource_size_t size)
+				  dma_addr_t addr, resource_size_t size,
+				  resource_size_t offset)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 	unsigned long base_reg, xlat_reg, limit_reg;
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.h b/drivers/ntb/hw/intel/ntb_hw_gen1.h
index 344249fc18d1..f9ebd2780b7f 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.h
@@ -159,7 +159,7 @@ int ndev_mw_to_bar(struct intel_ntb_dev *ndev, int idx);
 int intel_ntb_mw_count(struct ntb_dev *ntb, int pidx);
 int intel_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		resource_size_t *addr_align, resource_size_t *size_align,
-		resource_size_t *size_max);
+		resource_size_t *size_max, resource_size_t *offset);
 int intel_ntb_peer_mw_count(struct ntb_dev *ntb);
 int intel_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 		phys_addr_t *base, resource_size_t *size);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index a5aa96a31f4a..98722032ca5d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -444,7 +444,8 @@ int intel_ntb3_link_enable(struct ntb_dev *ntb, enum ntb_speed max_speed,
 	return 0;
 }
 static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
-				   dma_addr_t addr, resource_size_t size)
+				   dma_addr_t addr, resource_size_t size,
+				   resource_size_t offset)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 	unsigned long xlat_reg, limit_reg;
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
index 22cac7975b3c..8df90ea04c7c 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
@@ -335,7 +335,8 @@ ssize_t ndev_ntb4_debugfs_read(struct file *filp, char __user *ubuf,
 }
 
 static int intel_ntb4_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
-				   dma_addr_t addr, resource_size_t size)
+				   dma_addr_t addr, resource_size_t size,
+				   resource_size_t offset)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 	unsigned long xlat_reg, limit_reg, idx_reg;
@@ -524,7 +525,8 @@ static int intel_ntb4_link_disable(struct ntb_dev *ntb)
 static int intel_ntb4_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 				   resource_size_t *addr_align,
 				   resource_size_t *size_align,
-				   resource_size_t *size_max)
+				   resource_size_t *size_max,
+				   resource_size_t *offset)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 	resource_size_t bar_size, mw_size;
diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index e38540b92716..5d8bace78d4f 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -191,7 +191,8 @@ static int peer_lut_index(struct switchtec_ntb *sndev, int mw_idx)
 static int switchtec_ntb_mw_get_align(struct ntb_dev *ntb, int pidx,
 				      int widx, resource_size_t *addr_align,
 				      resource_size_t *size_align,
-				      resource_size_t *size_max)
+				      resource_size_t *size_max,
+				      resource_size_t *offset)
 {
 	struct switchtec_ntb *sndev = ntb_sndev(ntb);
 	int lut;
@@ -268,7 +269,8 @@ static void switchtec_ntb_mw_set_lut(struct switchtec_ntb *sndev, int idx,
 }
 
 static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
-				      dma_addr_t addr, resource_size_t size)
+				      dma_addr_t addr, resource_size_t size,
+				      resource_size_t offset)
 {
 	struct switchtec_ntb *sndev = ntb_sndev(ntb);
 	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 6817d504c12a..8875bcbf2ea4 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -117,7 +117,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 			return peer_widx;
 
 		ret = ntb_mw_get_align(ntb, peer, peer_widx, &addr_align,
-				       NULL, NULL);
+				       NULL, NULL, NULL);
 		if (ret)
 			return ret;
 
@@ -132,7 +132,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 		}
 
 		ret = ntb_mw_get_align(ntb, peer, peer_widx, NULL,
-				       &size_align, &size_max);
+				       &size_align, &size_max, NULL);
 		if (ret)
 			goto error_out;
 
@@ -142,7 +142,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 			mw_min_size = mw_size;
 
 		ret = ntb_mw_set_trans(ntb, peer, peer_widx,
-				       addr, mw_size);
+				       addr, mw_size, 0);
 		if (ret)
 			goto error_out;
 	}
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..4bb1a64c1090 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -883,7 +883,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		return -EINVAL;
 
 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
-			      &xlat_align_size, NULL);
+			      &xlat_align_size, NULL, NULL);
 	if (rc)
 		return rc;
 
@@ -918,7 +918,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 
 	/* Notify HW the memory location of the receive buffer */
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
-			      mw->xlat_size);
+			      mw->xlat_size, 0);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dfd175f79e8f..b842b69e4242 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -573,7 +573,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	/* Get inbound MW parameters */
 	ret = ntb_mw_get_align(perf->ntb, peer->pidx, perf->gidx,
-			       &xlat_align, &size_align, &size_max);
+			       &xlat_align, &size_align, &size_max, NULL);
 	if (ret) {
 		dev_err(&perf->ntb->dev, "Couldn't get inbuf restrictions\n");
 		return ret;
@@ -604,7 +604,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 	}
 
 	ret = ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx,
-			       peer->inbuf_xlat, peer->inbuf_size);
+			       peer->inbuf_xlat, peer->inbuf_size, 0);
 	if (ret) {
 		dev_err(&perf->ntb->dev, "Failed to set inbuf translation\n");
 		goto err_free_inbuf;
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 641cb7e05a47..7a7ba486bba7 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -578,7 +578,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 		return 0;
 
 	ret = ntb_mw_get_align(tc->ntb, pidx, widx, &addr_align,
-				&size_align, &size);
+				&size_align, &size, NULL);
 	if (ret)
 		return ret;
 
@@ -595,7 +595,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 		goto err_free_dma;
 	}
 
-	ret = ntb_mw_set_trans(tc->ntb, pidx, widx, inmw->dma_base, inmw->size);
+	ret = ntb_mw_set_trans(tc->ntb, pidx, widx, inmw->dma_base, inmw->size, 0);
 	if (ret)
 		goto err_free_dma;
 
@@ -652,7 +652,7 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
 		return -ENOMEM;
 
 	ret = ntb_mw_get_align(inmw->tc->ntb, inmw->pidx, inmw->widx,
-			       &addr_align, &size_align, &size_max);
+			       &addr_align, &size_align, &size_max, NULL);
 	if (ret)
 		goto err;
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 5b3aa1abeb70..becfad483643 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1269,7 +1269,7 @@ static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 }
 
 static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
-		dma_addr_t addr, resource_size_t size)
+		dma_addr_t addr, resource_size_t size, resource_size_t offset)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct pci_epf_bar *epf_bar;
@@ -1288,7 +1288,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	epf_bar->size = size;
 
 	if (epc->ops->map_inbound)
-		ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, 0);
+		ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, offset);
 	else
 		ret = pci_epc_set_bar(epc, 0, 0, epf_bar);
 
@@ -1399,7 +1399,8 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
 static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *addr_align,
 			resource_size_t *size_align,
-			resource_size_t *size_max)
+			resource_size_t *size_max,
+			resource_size_t *offset)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 8ff9d663096b..d7ce5d2e60d0 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -273,9 +273,11 @@ struct ntb_dev_ops {
 	int (*mw_get_align)(struct ntb_dev *ntb, int pidx, int widx,
 			    resource_size_t *addr_align,
 			    resource_size_t *size_align,
-			    resource_size_t *size_max);
+			    resource_size_t *size_max,
+			    resource_size_t *offset);
 	int (*mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
-			    dma_addr_t addr, resource_size_t size);
+			    dma_addr_t addr, resource_size_t size,
+			    resource_size_t offset);
 	int (*mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
 	int (*peer_mw_count)(struct ntb_dev *ntb);
 	int (*peer_mw_get_addr)(struct ntb_dev *ntb, int widx,
@@ -823,13 +825,14 @@ static inline int ntb_mw_count(struct ntb_dev *ntb, int pidx)
 static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
 				   resource_size_t *addr_align,
 				   resource_size_t *size_align,
-				   resource_size_t *size_max)
+				   resource_size_t *size_max,
+				   resource_size_t *offset)
 {
 	if (!(ntb_link_is_up(ntb, NULL, NULL) & BIT_ULL(pidx)))
 		return -ENOTCONN;
 
 	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
-				      size_max);
+				      size_max, offset);
 }
 
 /**
@@ -852,12 +855,13 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
-				   dma_addr_t addr, resource_size_t size)
+				   dma_addr_t addr, resource_size_t size,
+				   resource_size_t offset)
 {
 	if (!ntb->ops->mw_set_trans)
 		return 0;
 
-	return ntb->ops->mw_set_trans(ntb, pidx, widx, addr, size);
+	return ntb->ops->mw_set_trans(ntb, pidx, widx, addr, size, offset);
 }
 
 /**
@@ -875,7 +879,7 @@ static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int pidx, int widx)
 {
 	if (!ntb->ops->mw_clear_trans)
-		return ntb_mw_set_trans(ntb, pidx, widx, 0, 0);
+		return ntb_mw_set_trans(ntb, pidx, widx, 0, 0, 0);
 
 	return ntb->ops->mw_clear_trans(ntb, pidx, widx);
 }
-- 
2.48.1


