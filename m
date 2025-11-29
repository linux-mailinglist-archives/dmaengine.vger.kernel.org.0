Return-Path: <dmaengine+bounces-7393-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE4C9423E
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C0F14E405D
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273E26E704;
	Sat, 29 Nov 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="w0KuEbcL"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169330FF08;
	Sat, 29 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432274; cv=fail; b=VFtjU1GpWayIBtoLhDzEf+CglDByvYPlMlxqhN8TGS0hTG0Co/bvXAVa1Yo1SfxgfhPRdbJlZ36iCHf6+huU/7MIBMc/KCeE52iw8ewYIJrKG0yQpkxIJ6Oi7mZ2y1882OeeTTg+3IWye5m3dD7xgsnP5rQah62L6RXb26CwtWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432274; c=relaxed/simple;
	bh=tbf73dOZtj0Ulye1XhN4F3IYT742SOxBV64WQiEMKTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwLNA33p/ALMZf9q9rdNkMIQBMJl3ldSdAWpTLvJgi4YvRk8KZrefr7Fvn5J9CMb/wnDLS4A477cYyUl3E25G89sz3+YqC9WFc91Jee1X2FWKS1JO42vIrYbbUYxExhbY+3jFPRUbsG/HIT7omRvsNrzCSriQcjl5B0Pmkl+6v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=w0KuEbcL; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wat9JxhCW5VcxE0KI59a7/CklxXFVUkxS3z79YjUIKlHf3INryKpRkqHPeHOOnQd4fS4FTRN5JM+ITLj2EBj067Iihj+gRG0Ic9hOw+D1kFEC7AK1QjAH3uJWf8m2JxjDCthSG5L6TQMJB/XW3ubdh1E5PlJ7OHONDOFuHqfKmRsEoFavcpnzm/CIkmT445jbfZ7YHU72G0GVZ4BsOQ3mBx67nLOldvfwQsdumq5ZGhbXeU6plDNekuyRBfRA6HGwlkPOh4CNd8rMLlYOMaXKcCfLijCcX9AVfGnRfvN1766wAsu8UUtD7qi0Qm7x5KiNs+9HqF7N42xyjSvgWPSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGqgP0DQDCnOPYAQoXMzFUzjOXFvdiJP/I3swwaedF4=;
 b=lGQcC0NFLJVzDtNJKlV0izBGB+DGJ4uyEnsO66iz7NkxisXtyLAlU592iukuvUB1fWPLD9QIKR6TfBurAZMUd7pKQsAl3GyToa7tmkLDbc4yTkT2gB90IwhC9dzA+N936zyQrd4bffFGaDsbfZEp8QePmdspNvEdXSkgLZV5Y+jJQ+KnLebc/zP82MaFlOpJL0WL3KAE91eRYJlGg8uBLilyLTE6JjoOxaOpEZuP3NChrtmhb8F+D/kyyJRRD2OxYHduIe3TklDQN5wspqICRTKe7yR9ZCvEj1nzpCsz6kgS6wBoYVHiTWAHwhuNvGV/bC0GCtLOKOLY1ayZEreM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGqgP0DQDCnOPYAQoXMzFUzjOXFvdiJP/I3swwaedF4=;
 b=w0KuEbcLbgZYNk8Aovuh3AH+ZyFY2sJkj7AqGeQZXk0SasjAg97rYjEgWTEv/oW2ShO0MiDnppCSXjqa6WEaUtLm/qee5xwEK93zNet3p7RnCEdnuoiTG2QPMMJjWUclPfLm3TDW6WPw+N/qG6fv0Nhas1ob6dl1+YwXZjqBdLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:25 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:25 +0000
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
Subject: [RFC PATCH v2 07/27] NTB: Add offset parameter to MW translation APIs
Date: Sun, 30 Nov 2025 01:03:45 +0900
Message-ID: <20251129160405.2568284-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::10) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 228c3c99-34b5-44e0-89e6-08de2f60f7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3A2lT+6jCt/oVr/1LvnRGPXrBbN3fyRj3FpmWrTXbyc4EdL1eqprALDpQSFw?=
 =?us-ascii?Q?+pPUuNLiEZ3mbVzq3nQIb8J0gkvIDpYw60fXmeZmh6GuO+lqr/ND/TtonTDz?=
 =?us-ascii?Q?1BKv8QUgwdYZNdWGjGyeJkfCIsrjsSBnFetZUiS0QtETJtNJzRIB0eEkmJsV?=
 =?us-ascii?Q?Q/6wqG4+vRb5LwYmpvKB7lQSdanZ+9vPCZsHCdPI9LbK4qtZ+AV7GDc9Ee4P?=
 =?us-ascii?Q?HIKwM0qWTk2opKcSq/QOzX8EKkU1J3I+uxGoV8O1ia/29YPEzm44uaaF/rlI?=
 =?us-ascii?Q?PBgCYMxopmsIyaqDOcZPkgp7xNBV764XX5yqwkJAFLqFNhwfV9Bd/4cdnjO+?=
 =?us-ascii?Q?9lT+LMFxfbpElmFSyDPSgdid064nkv66hw5EKUYuU6h4ACCaKI/8ZgqQzqAR?=
 =?us-ascii?Q?n+LCHzWOTybE2uUj4qreO23AxFLnTctYCg93gqRenw+6Gm6wXGxGjGkwRYV3?=
 =?us-ascii?Q?ftA37kyIB0NOJszOgvptJ6QY5tYrmxn/roVYPf4JUJQZHNR0YIh+Viowdl4V?=
 =?us-ascii?Q?PuDiqxTBbQmF2MglpL1ZLs2QlTJIYqHCKSRoOeXIP5v24SPhzxzzSinwK9Pp?=
 =?us-ascii?Q?flOi0uzaC5Yy5QNfzZa1J81m0vUoZSjEQMZaVSIhMHRiQA/n3vHrS8WS2xUc?=
 =?us-ascii?Q?aFSSil0vTM5Y5dDG/BhsoGaWncbkWf0jSt8E1MYJ0mI9594pk1yOiGgs2R4+?=
 =?us-ascii?Q?zd+5eCfVk2qYuQozOPvHQvZGg54EWw9Ib5ZjpttQtWRvBaYIbEt1j6guaeVX?=
 =?us-ascii?Q?EIVZcfHzBbGLRZtGmcCddLK4fqXh9TGBYh7Ad/106wFO6sY/lLymgR5/33NQ?=
 =?us-ascii?Q?wLdLMB6MQwF62FR6cdpUmwgkgfD3Y43s5Qiuzd2t1OXNjUnSb1VIhqYrmIBL?=
 =?us-ascii?Q?JY8ln7x/klWNZ0N1dHiw6JjtPBCMgBy8AcCKcDD6egQBCPO05HyX5ixoUJc9?=
 =?us-ascii?Q?bFS0BvFHRB0+dFt2Kg+Qjwa87/MrO2lafI9E5kedloehOiq8JDAp6PuLNo8V?=
 =?us-ascii?Q?gfevsH0vlg6zwuq/gyVrwIM9hDChm0Hm5nOehfLhIPMX2VUdGQ090i+ENDZE?=
 =?us-ascii?Q?Cqqp8IztxyggsIWIV8I+r6GE1K3QU974tPAbxJZexA6Lu0GeDuoY3AprD38q?=
 =?us-ascii?Q?c8WNsIkQ3HbFVoNDjLjvm4njMDhfcFyMzQBb8SKH96vCV1zLsPuRu+tqsNjs?=
 =?us-ascii?Q?AtTCVHGLojmRkblTQJJQc+gUqcss25zhJ4KT6/vu0BR78d+C1uaMqBFaOHEd?=
 =?us-ascii?Q?byaL5hTJLhg4Vhyjx4FeolXq+7k7BvjGa83oxckIJhsJ7wk0zbxR4cVITxd3?=
 =?us-ascii?Q?yN4sEtsTWyvfLR8syopIrQFKEDGHRiMGdUXAg/qpQHEy97LEkpMIZ681GLZG?=
 =?us-ascii?Q?ino+8szHXIrOmqG/3rvP4Fw4lyVJps2nS410vPZ/XI0yJjwPVYPE6kGMsQUw?=
 =?us-ascii?Q?2K6P3FqUwiGQucIO9PAwTk0qpNL4/G9G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/NLZUUQex1JmIHdl3mp1puKUXxip4b33h2bGLLtd/KTo8ptRz2hBgolLzn8?=
 =?us-ascii?Q?GQKkfsR7CvyoNe4XU+A1wYp+K+wX6LntdHs6mx7Ty2EPaK4ziPLgiMi5dtib?=
 =?us-ascii?Q?Yt6q6EPLh1mUYn1kLlUfI68cUjnFSiigPsLlrWxlXxpipIe8yiYwkRG3N4lD?=
 =?us-ascii?Q?BktdojIkSFfKAVBQDHElun7ioZfINF5sKy1uNF6/gYJGDJg7rshTwatiY0l+?=
 =?us-ascii?Q?NobV1ATHzyC76WgNNGt9zE0JxtxwnTMg7FKysVK32s7HE3rldzyCojxfWmn4?=
 =?us-ascii?Q?vTtRCSVaP/LAiEXufCL88UuIBBIcPpC/MV/6+ySoHWlz1QqUyog33Fi5mqx4?=
 =?us-ascii?Q?189f47jlTlNMMcvMhg4Nc4C9N7UaAOCrLDIGbim0QMWF94ZRT5qRbU2o0/TC?=
 =?us-ascii?Q?XppE/0GndemxU6D2xjI5hxFuuorXB/FFsTrvxC7+CDkWJJG53mk6UgLZBTUI?=
 =?us-ascii?Q?frkxvU09Ozhw6reDUAwdVG4gUuOB05XF6oP+i9pAqcM9BLJJPzJ28Y0tWwDw?=
 =?us-ascii?Q?S+7VcFv+N9gfLj5LKfBb1W5subJlWG6eXaVZVPvc5y8lFsxROo0fTnFGn0wI?=
 =?us-ascii?Q?bEk/BhqO89Qik7VyIebDRWEYp26/WGqY4tgqY/mnJNvhRvOJ9oJLQIhU6ztc?=
 =?us-ascii?Q?dSIG5tvbtETl/GzgZKIrvO8twJ6UenKaBE8Tmc2hX6kjz0X9G5DLRppDwCyf?=
 =?us-ascii?Q?8eIHNZETQ0deuaCuMCjWT/GT5V4Rx3EoFpW95c0f5K/Ej/JVi/UN3OEBwLi6?=
 =?us-ascii?Q?4eS4Z1O/rndRboRWfwvj00Y5JrwOr9H7cT1YfnrD3hc8nckMNeOH1MvdzNlP?=
 =?us-ascii?Q?10aPwGRe7UWBYmHO9fd2wzGCHLV9ooNk/EMDBHkrWQ4aJZlf6B9Z9N5Bqk+w?=
 =?us-ascii?Q?7E1is1IxPtmEgVwBU8lZPGNxfZOW5yvz/ytci0QiCRlkgNClzLc5rPBbieaW?=
 =?us-ascii?Q?jhF4PCO23jHItCmflVfFqiRIS1wDR3r0Q9vCP9KL8pMyD2OT7UDLGzHEGlT/?=
 =?us-ascii?Q?4KC/BKueTU9CbFk64vkQKcGSthZc48dcFrVrPz3RgwKn9p780dJmMebTCulX?=
 =?us-ascii?Q?2D3jTEuSG7a6iQYxcUUHwtWybCpdgFqc9xB9PtoSX0ZobN7YX3AILOn0C274?=
 =?us-ascii?Q?WdsbnHh9yz9tvoI181GIUj7K9Kx4q8+6IlVV1u5ExbMzg66heXKQWYvUwDx5?=
 =?us-ascii?Q?jeAi4o0x9dbTKtrW8TI5Np+bZz0mRSJD26S7YD+cTT2E0VwhBSWyndq7URJc?=
 =?us-ascii?Q?WDFVltAROxExzXdCuQ5DKjlCdrP5GL5SQ0v8k8RSMHhC/FrfG8b+dC3Pngsx?=
 =?us-ascii?Q?4Z+SWrENTweZlAN9nSY1qXJ8LJTLlK3L5Jrub7ecC9yZpiSW2tI6tHcOu67K?=
 =?us-ascii?Q?AP3uBvSAtcKxJeEdAKMlUm2T6q8Z5uBAxmTUcnuCvyWtGxFBE5ajThp9nghT?=
 =?us-ascii?Q?hc0y5Xuz8mRr+BKU107OkT+Bmz2Gz7pFEQS/JMOip9pTkDe929YcZ2hAjQOD?=
 =?us-ascii?Q?wjUHcz9b2abHbDNdoUaBFULPehe9fzx2zvhxwsf4+T5pYmzxUsKSKNjAEJbl?=
 =?us-ascii?Q?XVrJc7CWnru9QqZkGKHFDq+RBcYc/2B12T6Pv8Qu8gSIvEAurdF3CTIdEVlL?=
 =?us-ascii?Q?Wl52/fh+rPIL/rhag2y/YuA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 228c3c99-34b5-44e0-89e6-08de2f60f7cd
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:25.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mavh2Yjs7giWoVIxn1i+OwF9pm/SrL7V/YzubNlnJzBdh3hDnbvNbuPEb3CPyg0T+IM2u3TC6Mz0zrsIPR1URg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

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
index 42e57721dcb4..8dbae9be9402 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1385,7 +1385,7 @@ static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 }
 
 static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
-		dma_addr_t addr, resource_size_t size)
+		dma_addr_t addr, resource_size_t size, resource_size_t offset)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct pci_epf_bar *epf_bar;
@@ -1403,7 +1403,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	epf_bar->barno = barno;
 	epf_bar->size = size;
 
-	ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, 0);
+	ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, offset);
 	if (ret == -EOPNOTSUPP)
 		ret = pci_epc_set_bar(epc, 0, 0, epf_bar);
 
@@ -1514,7 +1514,8 @@ static u64 vntb_epf_db_read(struct ntb_dev *ndev)
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


