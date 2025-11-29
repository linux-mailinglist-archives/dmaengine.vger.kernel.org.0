Return-Path: <dmaengine+bounces-7409-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D9C942DD
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D6DB344AB2
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842A30F818;
	Sat, 29 Nov 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fWFin0ip"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011045.outbound.protection.outlook.com [52.101.125.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F749319847;
	Sat, 29 Nov 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432295; cv=fail; b=ZLvzojgX/3K6RR/63h9cuj9f/sJux7kIdDIac8yL9qP+oD4IWa4SesaGOD27rY1nIvrN8zdkPaoOtJvlyHGZTmbVkMpsjHzgWVcLCf97EiL8rnWJHgSgNRBjgDnorQJkLyAbNRjGC+391aQ4QuD3QegLpC2G5r3jnJxCLCq/DGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432295; c=relaxed/simple;
	bh=1I/yrRfiAOnNgmQm/lN2Aanhz2YYhJvByAbC7EKxCvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6HwxL4VKCiIvYKiXgTHMPeqIrO7bg+kdzpmianpeaEgIJNL83JAhGtfGwCfY4WM/U6//l2mmXg6A78s1h5kAjk6UCYq24oReNFWqp32QZrX6CG2PkPrf1F0wXvesM+wxlvd0HHucjZR6YrLr246TnwR6lZT3VAzoE8iIuZH7f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fWFin0ip; arc=fail smtp.client-ip=52.101.125.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkQTiBRyn2nYyAdLKrJVS+//Akjz+jdcJJT4Jz6FCKM39wWEB8ZxAJglOs0XmCeCtV6zPzWYQjvno6M8EBKStOg4VWKjd0HWYjeMgYVoSEoHNhIncv/wFcUVj9ATMcB5ULac3/Ky+qC7N0jhQuOHBr/nCe1xv1R25pYG9Jy4mz5sR9Oqfy03t1knZ8PfNb/XIhgUP/8kghNCJCJpH8wdU3mR6e9HscPUdpkyfSZJ7cKYNrOCC23Q6hYZgHIrnWpBa0f+hlmohmWZgJszeTWVYybtwlnyydhv6Q0Tni7nLeVBYKv7Jt9wzbBvgGPTnqxgzv5Ti8XSvAm9VXxbcPmdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5fSQgtjsF6qlPS2pYSm9OSObEzDAYW160iNMo5YHfk=;
 b=bXr62OIwbs5Qtf9saY/Ez8HXS8zlItFEVkDqfGaTyHCiZAjkD8lzr7PTFvnjw0tau+KROLqYyCcacvKJgBH+dAzk19qfmgnEboztzNJNZtAAw+uN0CzYI/oz5C8APzcldjBm3tC5SWPYq0IrQvqbg53AwcIJZSA92yzBptStpcq7pJKvQV2yIhQ/R91c0IqbTT/8y9+MtmS1+7uqUCGX8jGCw/QHXlrYxqGJKqQnsNCLR+4IhFvQs9U6m3YBtF8JYKuRFqSuuuUU7a4+fVArQKJqTUl3/vfxybzksBq2NFek2nQB5Elf179i1/fl3SRYsdEj1hv3YO+/VlUrKULoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5fSQgtjsF6qlPS2pYSm9OSObEzDAYW160iNMo5YHfk=;
 b=fWFin0ip1eXh0ot7It+HI5iZe/Uc1PEs2zJNyaPoSLBvRJwWik+7HxiuuxQH8K0h0jQneOB9PrlZ8O/pQZbzi4C6VeNeEeyumo19BPfq4qUDrpkMLrpu0DRmjEjjh2w4FRrgNnXNVW6Ugu5yACerW4I4AoMoVD+QDsrKgLaS3KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:43 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:43 +0000
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
Subject: [RFC PATCH v2 24/27] iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
Date: Sun, 30 Nov 2025 01:04:02 +0900
Message-ID: <20251129160405.2568284-25-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4c6f6d-31fc-443c-36d2-08de2f610290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EKT9Lux598S2ymtM9laZNQH6tsbBrpi3Ie36PULaJnD1Rc0MQ9vgYGz4cJeo?=
 =?us-ascii?Q?NpjcIjBM/b/G65CeO9Mor1yGurIbvRsfExp2x5PMzXtLGZsfOEEMdEqpm9NX?=
 =?us-ascii?Q?NXFs1JAZmkrJTlqHTfrhYqM90hjhsQhIMD9LuHJts5RY4XSCECJoC8vNTql8?=
 =?us-ascii?Q?NmcPbYyJ66utI25mEE2KazzojNlN+bsF5u1MESfBXBeFIANHI6ZM2KxYF9Gw?=
 =?us-ascii?Q?j5mIK7QtTI9pW4Wt+hfYjPDlM5Fjgru40iXq+rkkIxuJzjIolGiXgjfa97gX?=
 =?us-ascii?Q?fk1BpVsDLMbg/90ePSp8vYLVIpUcihlAbp74Zd+zvm39t8psBr7kLs4Q9cxK?=
 =?us-ascii?Q?2IrNiEv91wjJb89jgeJPEFFOTefGgew2Ql8lH/Srjk0+A/JvcyWWI1RL4HfZ?=
 =?us-ascii?Q?bsijF3+8i66nquvecN8Ak0lVuTFZbgiu1rRqhATZeE9+cnxAGV6+q6YVn8vj?=
 =?us-ascii?Q?ALZtqVl4SBKOfU/SYNsTP/tquhGeX3vJyCTUB9ox2tDRlxdit0eu20UpircB?=
 =?us-ascii?Q?UAnw8p0XS9hW4q3Z41W0Cq9F4mn0D9VoT8vt8EujC/zf23ErilSSpq/LdoBt?=
 =?us-ascii?Q?eukR8MllsYIDarcmHhWXmj/Q914HEroLHADsQ7bYx4G1WfNoUxv/mJqCXbUV?=
 =?us-ascii?Q?NqIDhdo8ucibu3PEyEE+r5jsR65/Bny9vT0tkninyZRe8iZ8ig8xXQpTQjmY?=
 =?us-ascii?Q?tYbLymSK0VKNljbL375cy1B3yNem23uOOh4qH9vDK76YZmLtS0gE/G2JlbK7?=
 =?us-ascii?Q?5LLH/w5llyDdG1M4rGwGAuvb7Dql10QwEmI78fNxP0UGzB14Fv9ENee8Md5a?=
 =?us-ascii?Q?kgvgBZYwu4WgQI5yq6RCiDwi6MXqdsh2viYFe4eVzkjhuID3v0aIga8xh8JA?=
 =?us-ascii?Q?ILHUyA8OqC+mvjXThBjnJ+9CGoA0ybVKvFTuDlfSNVQO41OMRf7FSqIempeF?=
 =?us-ascii?Q?Fq46bhOoQ/VNVCBkalIcGAFDVmFmKXlxoZZTHy9QT80hHvP6D2tYRK48CLKt?=
 =?us-ascii?Q?SeEkwoXnfVnumzrPG7Z1IBEyThF2giADIpDMiezx31yLA4TrIACaDdl+67cb?=
 =?us-ascii?Q?dfRiWOjKiQWcXQ49g2Ia7g7g/vK0joHTZ2rdBwyRhk5/E3amhC/yQoQm2sTa?=
 =?us-ascii?Q?vaeVgty3knJEuj0dvfDqZ+AjlomFWnDCNQKdpIKziwHcTg+V9ILzcTRqOW8H?=
 =?us-ascii?Q?KB75p6GPTvemypt22gCvVLJTsJbXAMZOHTjHPD8N868hC+4IU6vkCWzqs6wC?=
 =?us-ascii?Q?9HbZ5j7r9hDHDcRe1SW2f/1oPogB//BifNzIuNhdd0ySktpY4tr753uIGT+4?=
 =?us-ascii?Q?OjI+1dey9dWjodS/8jR36lfdMnM90zv3/vY9sY35sHvpKAsPGZPc+297iIh7?=
 =?us-ascii?Q?XvNsfL8bJ7fbPEsBJ/ehz81ElA1q61yzx/ovFP+W4SxdCOE6b8IPCkVOE9zO?=
 =?us-ascii?Q?sZMFAlGkPOQN6R0mB6KO0SWwlE8/otLd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZeIfA7zq8Gj+oSDhwuhcDDzXEECNAsZxHv+8oEXgvP0xYqioei7HFQA2CMCK?=
 =?us-ascii?Q?6RDmODF2aD4VnI5NgL6BZ3VNbkw46aOVA69YnrSqL1Gh5wyhkzq3Dm8dtGng?=
 =?us-ascii?Q?g6S7NKCadXu8wLBsqFjpSB+tU8ytrawH+fC2BFnu0Fe0h1D251KtOjQl3Mh9?=
 =?us-ascii?Q?rAMCrV/whsW2/lVRCXc22i8S1ueX3GePQjyF/WgHRwX/9tEMETHIFo1KEtuh?=
 =?us-ascii?Q?EDU9XciyhVK+OPz+B4DHvZUwPhcDTDJUm2obfKe3HepCCcfE43xifVpQF77U?=
 =?us-ascii?Q?pLyNiGcuMJFIhc5qh0t0kc2cF0adO6sv9Pm2EiqZmXrKIqKnTqneLfNXpRrD?=
 =?us-ascii?Q?zCs1JPJDG3KhSE9qUCBxPrRqv2DFObvHsi6STirEZEjmNFpvVZJfEntJh7IF?=
 =?us-ascii?Q?9lzeUTzzOSN2SkFGRtL7uKBec+6e98+tsigt14oSQw4driqtxX7QGLhCkkMu?=
 =?us-ascii?Q?rwQqYIMbQ4TtItljM5loV1jHVXdfvUhhlr2tL5UxXkflK+NYMlZfBG0TpRah?=
 =?us-ascii?Q?NKe5gvZ5tJBr5PgVIf7zaalnmhNM1NRkuH4aJLbmMuh+L31Y1OlGXOxUltH1?=
 =?us-ascii?Q?6OuskTmhl74h2ru20ltnVdzQvBxzMaodf4TegOoE4mflTy7RN6U7LjKL90TF?=
 =?us-ascii?Q?noqciL1XqRGNmhPcdA3Y54tIxPFsAtIei+T6+s5ONPaotk/UiFP0bz50FX1E?=
 =?us-ascii?Q?JEr2QvujLAC2R3EOx/JntlC0mF0BdQz7ypBGXVGxuCKr76XzEdc23DdLlhM+?=
 =?us-ascii?Q?gpLP8XCFvsLORDh8PIQ9ZeS/FHBEJGdSF4f3dsUEx2wTaH3C4XL9cDe/fJnK?=
 =?us-ascii?Q?/RHwFqlprxhD2xstFB1nrBrcwN2DGdaXvOsnbTTxrTjgLKQMIxpj/6DO9pLY?=
 =?us-ascii?Q?Cl2CNqSF+Vd04HDKuEHHnFPC/JHUoSv6JR12HprIodxBwF9EofzXSrL9QMCS?=
 =?us-ascii?Q?qQMDNwkYLOzCEp63HTGMoi9JF90Bdet75o9v+Ns5GZ0IBOWTMqSLe1tsANNC?=
 =?us-ascii?Q?fx5Fj24NHZE38pf+uGdNlJcPfXA5gRJzs51j+TbYyEGPFtvsEb7gVIrmmdo4?=
 =?us-ascii?Q?5jfs0yUIi5M69VTqh1EZOPrVPRwkzeNfnYuPb8YzDsiykGtOUiJOKkqXv1Yw?=
 =?us-ascii?Q?RTfMtyxTmAJvKCg1FIT3/JQyh/9mPmPjuOnKjTkEqlGazAirUrbv/mxSDhHe?=
 =?us-ascii?Q?MfFj8P4GCVWL0Hg8iFfKXfn6tFr5RjJ9GmzBr1S15xRC20pxlhgKHlc9XWJH?=
 =?us-ascii?Q?J5sin/D56939fvYu+ZgTKL+xe956bf0Lx+Ev7jKidYT+4mDC6RC8u3sopIQN?=
 =?us-ascii?Q?LjM50ECpGVLo/phSzWzDinE4ZUGGVKAeoVcNq5C4blFpWpvh7gRXtHx3f2IZ?=
 =?us-ascii?Q?6p+bEaC1cjyhCknJL2A4xeobAyCGDjc62KLpTUtDnYMIPMKqvSIBTl8GwgOo?=
 =?us-ascii?Q?M0m4AcsO7wna9OgEFAxERsb1W2EKd4i8fF6j5BEj7cHeft/I7i/qvzJHrQ9P?=
 =?us-ascii?Q?boF9Lukg/ykivBR12gShyAk+VkJZF8sry7RYzYZidCk4hLgo+LYehuhgL2RF?=
 =?us-ascii?Q?TlEOl112h2ZG8w0bvxTpiyzF6LqbjJoM6790cmrybufm4suaL1a6i2vWA5Il?=
 =?us-ascii?Q?baIcREo/NzMw9o9UCwSdgJM=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c6f6d-31fc-443c-36d2-08de2f610290
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:43.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIeGuuzpRK2FiWOMuxg6/I6QCOj9ug8WVE0FBJUkSQf6MkYh8FZxEB48vCDDeL3Ybs3GeFW9MVyEaJMrJe4rGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

Add the PCIe ch0 to the ipmmu-vmsa devices_allowlist so that traffic
routed through this PCIe instance can be translated by the IOMMU.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ca848288dbf2..724d67ad5ef2 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -743,7 +743,9 @@ static const char * const devices_allowlist[] = {
 	"ee100000.mmc",
 	"ee120000.mmc",
 	"ee140000.mmc",
-	"ee160000.mmc"
+	"ee160000.mmc",
+	"e65d0000.pcie",
+	"e65d0000.pcie-ep",
 };
 
 static bool ipmmu_device_is_allowed(struct device *dev)
-- 
2.48.1


