Return-Path: <dmaengine+bounces-7760-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85832CC8698
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 263A3312C2FD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4133F376;
	Wed, 17 Dec 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gkDNkU88"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572A327C16;
	Wed, 17 Dec 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984588; cv=fail; b=JJTmVgRsGAlp0+Wj0gzOVUGq2W5aZDVtemfPlon/2KFm5+DoRwn4j7NO681VFwJbuHiHgtpwKf3k6aHDlqsQopyslH3RcK3ymX5pZbzPTaSOJ/SiFQCLQ0p6HWV7oRnlxPIbFDzKnv8sKB6vtuit/0ziWAwe3HjGEYi2JzfeG4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984588; c=relaxed/simple;
	bh=2u3lyzFsEoriGSBKZFVhMcyrxqLnTLHLtKL/GpAejm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gw1rRwTXv9cQ22UQwwtYQuJlQ9flw8fEe/l0P66ZySDyEcHcimZ9397X4JS7CFlySPvpQoUcjGZ/wV7BVmKh+E+3Wgdddmv5BMnWvgn5MRF/mmIiKup6ueRB1ArWQeexLDTinVmyOwIYbBQ8dGo8uLAxm5yrk9+2ZqbEFkOMfcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gkDNkU88; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUDuSmnp2c0WNPCXSYFkp/keXu+jZtOEutVeOnZJ3wH23WBgJDorVKxqwWTRNp324HwQ3s5Xc3RRuef8TcYHLyXiDYaJcUW8fRKkOdNkB3K+s7Bd/zMJ6z5t7Yh91KM+df/tvYbWIjHB6cb1Dfa7+cc23ItK15KJ4yP5cDGUpGpOw5gEPQ0vW5DEV7A2ClLVRdc5Hm6JdQFlm6Oz4sQV/vVI0xszeayiYgb2H2Ag7UBPiGzDb+RlmUpO/m3jh/JuD71c+TLOx35C/a87F9ahe0TBzLm684mzBean+YRyotvCO+LbklLVGPuGk5665Kml5xdOYrvRPpl6UVfZcUstXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0PeFBjEMLUdkexj1/MJOCFfd1OFOpcl4uLb7EqfGkg=;
 b=rv+aQTaWHVLQHAtqvhLJNFHrY0LTFscDkbrKBiWbE0kI86WdcorQzZw3Bgm9vyo4vXfpLGz+UivdMRbSV4Yl0+jcRqzGtgIoUzUNUKkblrg5OCQWbzRjuTeXPCfEczuln/9O7nlPYuSSWPvbUdU/gvhchFmnjtZAeKBNSJUcui5cQWxAP9Q9QRLukp3a8kJbeWCEqXGrFVmaTPz9/ISp2fP2s8j4K1G8srQlpcuoiT8AMPQ2AR590fg/UB5K+L7RDmXZ6XjqvMPJBfphgr6tTlSAa+Wz23Ev30Fv3vSe+Tiw5fGanbaXk8RdVCH1n3SJJ+ipbUoCX3wAMpMixXeOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0PeFBjEMLUdkexj1/MJOCFfd1OFOpcl4uLb7EqfGkg=;
 b=gkDNkU8860YgprETxvbd4qJXUnfzJxNUkvH/cVJOcPw7FULUFynfGRaUAC3eSSiACPIpgMto+veGSV0RxcLHuGINtl4f7eZvgSJiv7XyB6/QbNy18ieqLfokZfafX2XvChYJOGIUC9VD0h5SRWoD3NYFqY4DbZAhlWfwPdvUrcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:17 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:17 +0000
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
Subject: [RFC PATCH v3 04/35] NTB: Add offset parameter to MW translation APIs
Date: Thu, 18 Dec 2025 00:15:38 +0900
Message-ID: <20251217151609.3162665-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::13) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ec2af5-4910-4272-2f3b-08de3d7f3990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zQGnDVmMckRaUssL1uD9+uQ4TgsMfRmk1Q1HJCUvrJOwGY3C2OmVhNFZGEkP?=
 =?us-ascii?Q?kthNWG8YVfnvxtdXGkbSI57WzhBS3i8O7isRInBefVDlkDd6YMWKOWyr5Q6r?=
 =?us-ascii?Q?28hZuK0B9XCVsg/d44WySwcVkU/pDfAla0NJIgmdORXkXQ8yQu+S/cHQzzp3?=
 =?us-ascii?Q?06RL1ALxnkDLKf16VsIASilJu1xnucofNXfaY73zpzKbHr8XxENLe8uz5f/f?=
 =?us-ascii?Q?yjnczuXmezJct+TqChAo3C27wd+PcwLwK82NvtQjUh1HACG+4/AozgOVq+dX?=
 =?us-ascii?Q?LMbLbjzKUM5dXNCVsq6VPv4WaiHWacNEnKnJ+str7qyvO9KowfQ1q/AM2T1N?=
 =?us-ascii?Q?O+Qr3PVMek7TeMYaruC97LnESPOn5Ycr+fLt4ntACtXZ7L94SWZuZCs+naTz?=
 =?us-ascii?Q?6vwHW+TCOqIFIgXllp5LYnxDybqvh0j02vI04G4bxpTUcahcJ0UeDV/MtgNl?=
 =?us-ascii?Q?IyXdwppm+J6xr24F3OaiTpxRcaqs62XaJIuaTByXfkI1GyZHEEI5xGvj9OqH?=
 =?us-ascii?Q?cYQzSTE1HtUx0Oz4LKzfPXt5+m/wNXLjnoGHVJCLlpa/S64UuBc2YyyRmywp?=
 =?us-ascii?Q?YPI7ThktE14h8E8mQD/aDUdsKOkGx/wYLsCmVa5YzZwHn1CrdRt7I8pIUkBN?=
 =?us-ascii?Q?ScNNtSfGwxX1EhZGTCdNVvckDTiqVV4h8nmPKcNmH0tVE5IfEVLX/qBphLwu?=
 =?us-ascii?Q?M8VAtI4zdDoEv+Z8rA3++7LlGqbMO3I5bR6NIFfmYKGfPNT8bUx9Phvd5Dh7?=
 =?us-ascii?Q?04ZdldmDQAqqILWkZScv8pdsQeFXhEW6ax7QmHAzolMKuHAyK3sBG1dKxuWj?=
 =?us-ascii?Q?C/C1Yu7s+yIkmIzy6hrtibWU6j9TybXdr50yJlR+kVvaeumAaWLeBUsfnISm?=
 =?us-ascii?Q?3RxLNkvAQmQUt75AWhTurO7uoshSTOSZGM1jrZgQNTfOA6O/kX5zzUOl+6Jr?=
 =?us-ascii?Q?Kg+kKSLIaCyD2y/2qqcJwaGpGXKnbD9Vrpj4xSOCDfATb+fBHBsEdbcH0roN?=
 =?us-ascii?Q?aesCXKCw4NYqlbc9F35WN//ImS7eMgNEHv9se0zE799a4xx5sQ0p3e13Bagl?=
 =?us-ascii?Q?l4o1zFz6CRbMuleKg3bndXRkkQZqvv9IvvO/4schPB+4XFWLiL7opYh1O1m/?=
 =?us-ascii?Q?YdiMN/H5f63TtG3XbPJb6H7CDN7qOfcd6HQ92wfL0ckvL7qz3a9fR/NcSggt?=
 =?us-ascii?Q?VgV5JdZGy4ri3M0eFs/9nlxgoWIOfEMc3GZx4/kxilp5AbhVmwEsNusEgSTe?=
 =?us-ascii?Q?+rudUDjFWwo9PgLQjuOtbgP0QVYWyvoI4R3hJx40fhXf0c2EtDMTH9PauGBn?=
 =?us-ascii?Q?nl+BwuAsLQAUGI7X4brJ30uZhgUgr6jFg5IY2OX/jt67BZnXixn52OzDli45?=
 =?us-ascii?Q?WUhGmr/IPTlsEfDDAqMshB/Dmyw8U6La+uo8DlfgyyfFsHX01hGhlSQnCMuu?=
 =?us-ascii?Q?+d3ByPM8EchweTlnBT6JjVwCR1GpHk5C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YU1tMIj+fo0qo2/9bNef4vIoQkV1pNoR4Dp01atiKxoMK9vqpTSNa993ctiy?=
 =?us-ascii?Q?g8D4rV8vOTC9SM+bzEAdLpXe6jwFI/qpUgkNgiD5xRgr+PSH+s7dk+69zNNu?=
 =?us-ascii?Q?d8eEElnvmTAKaLLENtTjMwkoq5Nbqo2sh60nxSaBgtGMqmwRW2suyG/G0CwY?=
 =?us-ascii?Q?d9GJTFsSjZLOZrhT7TH0WdT6DleWpJHDBcMVVk21pkHiQtk8Oe5x4qxCQzqL?=
 =?us-ascii?Q?rKD6uImA+1Y8bLtHEEB075mdeOWChp0WOF+wkG4umoWEuKZUs5sV1o9Lcu9E?=
 =?us-ascii?Q?2NiX2r0PUYRx+rk234r5w9//PgdQwEm/RZLVUSz9Zb/Znu0v8Vrm2rRNj4wz?=
 =?us-ascii?Q?Lxld47WKQO5eoKovc4DW+A9bYdt35ItoPfHX9hcN380t62lHYNArjGH0teij?=
 =?us-ascii?Q?gg7PPLcDZAy0ZUEyj2izh4aHickLRVP9xdXRJBZysAAykFyOpBgbgqRJAy5Q?=
 =?us-ascii?Q?xfRTLN0/x5bAO+ooW4LMt08dk6uWg+R5zXLAWLFI5Ga2jgak4ZV353sPxFbL?=
 =?us-ascii?Q?T+NQk9ycMN+u+upSEF3+TBEDyZG08O9FLurLZv76Ofg59KXMo5glco3cZqfr?=
 =?us-ascii?Q?StM1Qak5k1/UD3JAlEqdBZix4uWBjoP/iPvQHnWSHhFQK8WyNg/gw1FFFwoK?=
 =?us-ascii?Q?yA6GMpPhpZkv+5tu/RnK8ZM9LML48VYNZCvDHxtucsENdWmtzWMBpkKVZ+QM?=
 =?us-ascii?Q?44R81ib9o7jNrPHqFWLJhXnj2vgqCleJ3j+ZjYflCn+qDwqQ3r4YQQQjt1Iu?=
 =?us-ascii?Q?xPEJkGDKDycSU1YJNLqfSvadm41NGaubFCQw38pSB5kpbrZrERWI1Ju0Xxf4?=
 =?us-ascii?Q?JIxnoWCi8ArAD0937kI6hOQobvcR2b/tKaBGaTtlfQ8h9fTIKdLKrsvH3GDm?=
 =?us-ascii?Q?nVrcmrduiXV6Hh0XHp783OPjHPlE/DDmTjiItgMOJn0lEp8aRNFOQuI4tYg9?=
 =?us-ascii?Q?fPfJS3FKd7j1txAjuW0ZUTTvyHad1uOh82sy5+FqREOCSnlzfqJJg1Eo2RDt?=
 =?us-ascii?Q?koYks4pciSPFSxLxKwOB7JsHrnk6QpZ76tYP8rx1jmcvtZS0RxQQsgzS8hHe?=
 =?us-ascii?Q?LwKdfn0FyJvBpk6Afkucy0J58x6cndosFtwvwNkSKiHm3smRkn5DzdA4M4gZ?=
 =?us-ascii?Q?sDIlJZsC8YxB8gpqF3RWcGmrx5nfP3C1oaYjkDBwBM7JZfMPhn47hjAoeYEY?=
 =?us-ascii?Q?ZOTk67xin+WhBqJ6VMjJ6D77irfJXQigScmptq0NSwdKhKu10q8njupwZTh2?=
 =?us-ascii?Q?tYaj3QzgUlVfeO6tnLRVFWBhf0BMbHXK0dcPYB8MT/Yuuaat0OgEsODB0cg0?=
 =?us-ascii?Q?9H7A1Zb3ZE8+fZvXfjGR3Lkjq0R2tEU+MKsEa1Bq3IQwTdkWmV9lHG7xVEiI?=
 =?us-ascii?Q?xmkmTTwiOX2qfBezcIUF0cr+eSPY2Stk1Dm67DUtBo2OqfFQMAQGpaRCNgsC?=
 =?us-ascii?Q?EuG/B+/rJaRKJMvspash+FJ+YzIkjpSAD0Rxqmm1GqDpVZPlvyHNJbdHH8qi?=
 =?us-ascii?Q?5aiFFcSLDHr+rfMlidGDatj+MI09NJJM67mt4sihDzUA2ApA6wkCYV5y2t63?=
 =?us-ascii?Q?hoNvnu97RshbTqRq+vjcYJLfkvI6HgrisVv/t8s0RoDaMmw4HaZa0/7nvnUb?=
 =?us-ascii?Q?jVw20j2NfQpySgfqpJ2gMv0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ec2af5-4910-4272-2f3b-08de3d7f3990
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:16.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5dAGYJD9XIeEwDXzDIutLNUxMMhcvCO4DGuNQngss/tPti/s8/Hs2u8nGNaApAMABWEuJr2QFBhOQd3TFz5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

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
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  5 +++--
 include/linux/ntb.h                           | 18 +++++++++++-------
 14 files changed, 49 insertions(+), 32 deletions(-)

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
index 126ba38e32ea..89a536562abf 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -167,7 +167,8 @@ static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 				resource_size_t *addr_align,
 				resource_size_t *size_align,
-				resource_size_t *size_max)
+				resource_size_t *size_max,
+				resource_size_t *offset)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	struct device *dev = ndev->dev;
@@ -405,7 +406,8 @@ static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
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
index d5a544bf8fd6..e16a8147ddc5 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -829,7 +829,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		return -EINVAL;
 
 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
-			      &xlat_align_size, NULL);
+			      &xlat_align_size, NULL, NULL);
 	if (rc)
 		return rc;
 
@@ -864,7 +864,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 
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
index 4dfb3e40dffa..4db1fabfd8a4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1384,7 +1384,7 @@ static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 }
 
 static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
-		dma_addr_t addr, resource_size_t size)
+		dma_addr_t addr, resource_size_t size, resource_size_t offset)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct pci_epf_bar *epf_bar;
@@ -1507,7 +1507,8 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
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
2.51.0


