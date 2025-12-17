Return-Path: <dmaengine+bounces-7781-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F825CC88F0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5A131BFC9D
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550A369970;
	Wed, 17 Dec 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oxfZ4vRM"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62287364EAB;
	Wed, 17 Dec 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984676; cv=fail; b=ed+Axlz8RnK0QPT4zRFQiIv+fx3b4VvBq2ljebopHhlr7zhZoD/SJZOBdr2LCb7jYuhWeRxtUMEjrXLUDlb//8JiGLuroWu/4/2oE0gaDCaljZr89dQ96PKxfxwrnsd9TWFv7uo+Ep+BEhJGVnJIgdDlgA1rvYZRDbGaIPuxw0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984676; c=relaxed/simple;
	bh=woB06NkymuQMz4leOTLhvgJLQVdNeKEJIZ9thr0VS2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O18wyDmKRlKyMqrRkTYQ2L2kRjH3q2Qqvh7/XK4o9E9wO/UwS8DhV0gFPSEx5IoGprvOPkI9NCrk3+NYJJ5T1dd8R6bj8pzEpobhYfl8538fs6y+ct6uKrJRFzvSOQz+W35xxkVe6IywT3c/OXNtG6M9wumX2pM85qQDIjBs3uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oxfZ4vRM; arc=fail smtp.client-ip=52.101.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVNu7IEj99CfnOpDcpNHKJLjfcUDSRv8a1IwD8CMdAMG0tn98aklbb76pgk7RACFrgZjeviHrQ328Oez+PS+W371Y4XkY592uOC1OJwtyPv0h1Whe6ZtQsr9ENjzxZTrxT11m+WFJpGbDQd0GfoGsM1ANbYDamzwmDFUfnIlwl4aYUnG+anCVm7rJ1+cImBZU6+oIU0lMrRfHTBC5r8pO2Rfj267tk5MrZ6DtbX5vnqsf16wz02NPvL5KXeNevPNXpd2a2tz+N/9tVhfEhYRYGsFiZCAEmUn7HRWvCi74zrq16oeb/MfP5q3DUQfbROv5Tu3OEFu8INe0V529N5G/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAVmbXBmrEALoCTWYu49qfxKawjYIsxIDI1OIzbn8cU=;
 b=TDN891NQRr7aP/GNhvuivATFuq10j4I/BIwhAJhzIeBNpUf5ON8GbBh04SLgMrlV38t0dhNBgE8/YRBor9blMWqCNAqyBPZkYENQvNz/zFZ7n5wWEQBT8yw0cxUYKw8lw9kTyUNfMPlKpiKw7inpC/MHUtgbaBJadYjrcHl7Xa4Sht6ADB8DvhE8/i31CZ9756rxRKcdSEnrqY8QOHsE3YvW5DETcMb/xdKKnzQmQKZGkG6iSPOztWR9Sab+K03C+L9zea6mjaJhdEfD9AhstmVFy8Vwv5sv/Hz970KRU+M9LSlpp/nsNPQaTwsIc+zh7JBGGsHe/S+SMsR5XgEqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAVmbXBmrEALoCTWYu49qfxKawjYIsxIDI1OIzbn8cU=;
 b=oxfZ4vRMOh3m7EFVElGqQ8cQVIbgaqoFYwv3uBXZ8Lv/0lokO0W1rctBJxoybhHLHLYTihv/o+GYqemAv+gRn5iwvprzqEbd+Ke46fFYDKslJmML+uyk3j46LmvSLY3KUCcakkTPFgYb6hCn0W3T9Uh6zisoYbfriWpD9qpphN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:17:11 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:17:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 33/35] NTB: epf: Add an additional memory window (MW2) barno mapping on Renesas R-Car
Date: Thu, 18 Dec 2025 00:16:07 +0900
Message-ID: <20251217151609.3162665-34-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0103.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e5d0e4-7ff5-411f-03a4-08de3d7f4937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/vv/oLGwynS/Wn9IVZIBchARkfdYIlTdq4xBMfNZq5UOiX4pGmDvkXoOhMb?=
 =?us-ascii?Q?DaHpkCreXsnRyBEBKA/1vAlx5rzrHkH9L6ehobVGjDWe+ih8aul/NaMJ0EV5?=
 =?us-ascii?Q?FXF+wKPKxC1grbonP43705qJkNNVrg6ELVIiU5qpm+2VB5XkpcQAj/XTzJEZ?=
 =?us-ascii?Q?0QiQfvAAJDaTL0ASMcAhlQ/Bnp49miOzWac6w15fUlQwntQ2PTTstx82MpSK?=
 =?us-ascii?Q?c2xWqTCejXesQYildCAjZ/Pck937g6vt4sYl41huBVcdc0In5WSKIl0yEi8M?=
 =?us-ascii?Q?d5uD+LapTH6g+tG0sLagJJf3SxzMPKehY4WSdsHB0m4xbS9w380+wvaJHjkf?=
 =?us-ascii?Q?e7gApiCiNF68KYzAnTyEtpigcQNei6R6hDqxeBkplkZ4opTFZOpm9qFR5l8l?=
 =?us-ascii?Q?0SxmkdT4X69RO4RPrY33cjZYzPT4SxR9Lt7E5viyqLyazyLpnQlICnfQVHHG?=
 =?us-ascii?Q?TMA3R2pcKzS++Roz/JerPj2Nb+KR8nNtAKQvQR9YBJ+TwWf7XRKYTxxZ+lwX?=
 =?us-ascii?Q?v3uby32I3g9tqH7irArfmqqbMwOl7CT997bhwrApz+3WvpY4vwDWQ0WbOvab?=
 =?us-ascii?Q?a70kK0wDSxyk23ehJGVDOdtu6HGymNQo9kutCSk1aTQ+dYwnakzDMaV5OWh9?=
 =?us-ascii?Q?XPN/OEn8+Et51kq4VV/LpGYKytLa2xoe/8cJ36XGtHDX2jbaaf99jz2Lq5No?=
 =?us-ascii?Q?emwePIv6YRrwsv+4E7bz2PVB8YCqpWkOQJe7vaY+AX4lF9wBqEGh915qNNi2?=
 =?us-ascii?Q?KkfC4l7+wf/AwWgBcSPMeJW1sxEgYbW/pfK5hoPvQBIGyZULL1SBIVIgvsC0?=
 =?us-ascii?Q?6OpdNrUM4Uu2XNFY2lFNCZce5cXDUcUKZYb3X0z891KRMe1Ac4qetBafGRfA?=
 =?us-ascii?Q?Lc789aizY1J3/q1haj7ChbZscRtGii8rwsux+KXhp/vjrwT5hZUgAIaCBjRi?=
 =?us-ascii?Q?SsKxSKYa7TN07G5VHWCJM+cwRmQzIugfEmClzc7aJYd/oxQJ0Sr/bzfixb+Y?=
 =?us-ascii?Q?iCdCiPtwHuI3ugt2NlUKuFKwuCncKXaenAgBgz9iuMIdrMjnR4WpsfO3821S?=
 =?us-ascii?Q?d5VEPplSXlwps7vEwZDyjV5+EUr6GRALrM0Kyhukc7YBHue8bmlI00/6C/VF?=
 =?us-ascii?Q?QMLJXDe8Mx/3wKqcb00RlHxDJVINU24v6/j+ZS7B5Wt3rZBZ8iJRnk/8QX2s?=
 =?us-ascii?Q?NUcJWgv8001zsg5aTnc01oSf6FBgQgYOs09uhwFXhT5+/31rZSnVSN7BzKYu?=
 =?us-ascii?Q?13lqh27L5gYKK83twZAO67/MPokIpBDF40vC4BQz5/TTdIU+96OZk8vqjxNh?=
 =?us-ascii?Q?zx1ppRqOeLg25Raa6/GIsjHIEXU4F2l85MuJWXauvYbAE+xMSRez+RLZ5I+E?=
 =?us-ascii?Q?wojf8g1KUGNoo7eZ1qRSF80wUpTpMpPKN1lnei6oY0/kHIMa+IvvpdXAjySM?=
 =?us-ascii?Q?EwNlYq7k4YOepTAQOHK4nz9hnfFFH40n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TODbqSpMRtddSOZR9hPo5hUbWO6QS44gB84nBbNKqUZvPf7x2WeS/nfvPvxy?=
 =?us-ascii?Q?QfKh6wO/Ry2Z8G8I4WBpSwSEbhNekuEwKtfahqphNtUQvWyrooUiIlNwirpp?=
 =?us-ascii?Q?BHNVXRoGWim/hJzrD6fFZgqqfRoVnJ6gNZNWv1zyGp376rZQwZle0NauLI9l?=
 =?us-ascii?Q?0/2fIfVwMMz62lRDriaqPHxs9ypVowtqY/loUKIqGK+ieVGK1wpGD29Nm0X4?=
 =?us-ascii?Q?0FYxtf2T5iXrNsp7i+U2zDvajkPEejRcdW1Ftb/ZNzMqltuvDiHuBvKWj/77?=
 =?us-ascii?Q?rKer+0CqxNmovyZXW1aRJoum7cFsknkoHp1GggjQaxtBwRiWz21/o+bBB8La?=
 =?us-ascii?Q?k5SagymLi3cUZfvUzFCTB1h8dK+MBT6BdHRCwUp8z28KpYhB2GNXaf6zRh1z?=
 =?us-ascii?Q?krXqql827psL9bgF+GgZ7hCm5D3ZnFXaURsVFjNCKLu/PKVJItON4FGmwL6K?=
 =?us-ascii?Q?ii7PKe4sGkOuTpnWwBhwIDwmhxPzzh2NHX8FtCZ9LGfxIv9TJkmqsbN1g15e?=
 =?us-ascii?Q?ZjE5LV4ieQGlsiOncaMZtmI0EvNFDxENvgvpz0KK0dAqrYBC97Q+ju3spPB+?=
 =?us-ascii?Q?SHUvzltYWtgNNbNwbxAXjaGfE8XPICSzsABOaNBYcyw9guQKPIP5QGugx17I?=
 =?us-ascii?Q?fmDepnXDfbaFtR2h+bYdCc3+NrtqWjy3JhXrA5dHKUb/65hbvz0yMELnSAxo?=
 =?us-ascii?Q?rH3lRpFguBB6rUnvxox4W9N+x1S1yykjDmS3R0J+omKauZqGETdJeQd5+6av?=
 =?us-ascii?Q?sQ6QnBvJ53J5VchdDDjdiPEwrKhOAow1euHS3xoa8rR0ma/SOxGeouWjcIjs?=
 =?us-ascii?Q?4OBZVQjUKs8exUP4n7Q/eHVJoVPmvCJPHPDb50bl5eKj1CSDuCMahq8b2Khn?=
 =?us-ascii?Q?cReNqlutSzhEPGvnBCUtus0TfI2jOphEahXEL372d5c1rgDeMKQx4mCFTHy2?=
 =?us-ascii?Q?0LWjHzCoGVqdVo5eeO/zOaSxRnG/D/J+ihHWr54O1bo1l3vRG6yxnMvUnc71?=
 =?us-ascii?Q?nBwNMiP0xpXEXdka4kfIpIZ/+GGobl3H3G64axLeQ8wz8qEg50eyeMufMasd?=
 =?us-ascii?Q?XZXmhFglsOAW5dkWrE4om+5bN4jZ0g0po6UQBCiuN2rOA/O/rf7QUj4QcPo6?=
 =?us-ascii?Q?uxqar1FXnpz98lL55TWCNA8QVmcFD4gE77sHGtUmi+dvqMZV4I0IF6L0fA6p?=
 =?us-ascii?Q?NWuaWzxvB7txCWJUGJJLC3Ps0k+/zuYMyImAKIok5OBnAvkuYaPMAjHNCTCQ?=
 =?us-ascii?Q?O+y6IZvRXOMjCQtd04UxxdQRYbrf9rH6EQ4fWVPfs3mn64nfzAPjZPuOxH1N?=
 =?us-ascii?Q?6QVeQC8cg7iKmBqP9BH6sxvPYuYetoTSkriXOLQ63diShBDY3PHgEi+133w3?=
 =?us-ascii?Q?2VbwnQsJUCGZ6wS1yGc1XIR5PWX9WMnIUk0BQKlzDjfqDVe67oA4R0DWuk8t?=
 =?us-ascii?Q?Gq7PphFp8CXB1dhdPwoJBC3B+CddKvyUmh2UJ1Lo1ZoKjBlSGJiE+2NA8l6E?=
 =?us-ascii?Q?jHUK9n2LfpGnC+l3FtuXqnj1/9nulOVCCwOM/VDwC/g8+FwyznDav34U3eca?=
 =?us-ascii?Q?iXLJ5s8XLEOSiR42HkmhefruNMt36tVuMlthdOwKP7VLWqFt2ADbbb6coNxd?=
 =?us-ascii?Q?jQRywO/kfYEr8sTlKCBHplM=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e5d0e4-7ff5-411f-03a4-08de3d7f4937
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:43.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OrsiPET/W9IY9CcFYdoG0DgklRJGy8JesSb8xG13F2M1v2mv0bCc/IN2mY4+7lYSAszsnW+qVuARamdLJo3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

To enable remote eDMA mode on NTB transport, one additional memory
window is required. Since a single BAR can now be split into multiple
memory windows, add MW2 to BAR2 on R-Car.

For pci_epf_vntb configfs settings, users who want to use MW2 (e.g. to
enable remote eDMA mode for NTB transport as mentioned above) may
configure as follows:

  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
  $ echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
  $ echo 0x20000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
  $ echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index efe540a8c734..18d27ba9b6f4 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -826,7 +826,7 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
 	[BAR_PEER_SPAD]	= BAR_0,
 	[BAR_DB]	= BAR_4,
 	[BAR_MW1]	= BAR_2,
-	[BAR_MW2]	= NO_BAR,
+	[BAR_MW2]	= BAR_2,
 	[BAR_MW3]	= NO_BAR,
 	[BAR_MW4]	= NO_BAR,
 };
-- 
2.51.0


