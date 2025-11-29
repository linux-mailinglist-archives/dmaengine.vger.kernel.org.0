Return-Path: <dmaengine+bounces-7405-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A90ADC942C5
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAC864E6043
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846BF31691C;
	Sat, 29 Nov 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rVGgB/WI"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011045.outbound.protection.outlook.com [52.101.125.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908523164BC;
	Sat, 29 Nov 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432291; cv=fail; b=Id230LywfqogUA/NaCD//CzbC/VZE/apd+sFxElGzozSy7bzkdmzb2ynvdMOj28PUOzvWvIAJNUJXSTIPVJmlvNZNHZXfMBmwhB4uNLT1C+i+y02k2Y7X+htAvbFFjXru86oH6yvB02t3x9uvBe214ESJLOiW20xup49Tf+XD0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432291; c=relaxed/simple;
	bh=xJZGvYuCeSbC6phOlKF8o5hPNyQP0OqtQctI1zAhwXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSgnkg1gaa4I2SLzvTNrWaPf1KY8gp2EVuP7y9j3UNSBw0EasvqzxvvE9G5wY69xUE/xJpdr5WCH4Yf7R6aFdeI67pc0AwCibtPP+gZtUHjNCQdAyiaadTWVjGRFF2iKylxstIqYH3P0vP4P3y4mIQohCRgBsCgfiPzUCPk2GF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rVGgB/WI; arc=fail smtp.client-ip=52.101.125.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbbVzoeKCDLjL5yVMfNOZlHkLNjcEAD2+dsmg+JAgtaSaivjFrvbc8QSJmu0gop2dbA9XGy+IsF0Q8sURT4qivMYNU0rBkSn7Kx3ANgwFC4dq+SR6isVi7KSJVDOGeY5UD58FAtv/yS8Zl59tzdcZftZWHcar1k8PzUXznTr6XutLVpXY0QWwkJpzzfWYeaHskDf4wd1SvwMr9obviei8wAkKfkg8u/Hu4/c3JROYF2apb3m6v2dmi/PWKTdhXbtF81jJ30mOUtIJE6SxxGdTFRC9ayi9weMwnPbsv4xBU2i25UJ4uRqtwlFLjYxbRoGrJU4jrWJaOKQOB8NslAK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJzuE/8T0QfJ3rJwSw9tBk8CiI+6yl2UQyJuh0sK59M=;
 b=hujoQ14yzeALEnpC30wiTv4vMKWKlPg2+7ON8/z3IbCSFU60B+ttYt23OxyBPg7LwvibYLb41/EIGwgCgb8SNKi9cib40XNssdmOUayuNKLfrWIapQb0v0qtesNiusCgrN1OgFVeTny/dSFPX+8eRRj2pyRxTo8u7Du+6VnIR2tYyf24HBLYolOTYE3y2UsQ57STtnQGZhsVrkJSk9ujs3Ms1djMVRf8wjJ9oGlY1wRu1sWlrejLqfGvh38CNiG3SL+tp1b+eadX2bzgXY08l7cQPo9qvw1m7pn/VWJSJZT7W+9yHcIYjXS6waEQNo0JDxihfYU5ZumKeAZf+3pxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJzuE/8T0QfJ3rJwSw9tBk8CiI+6yl2UQyJuh0sK59M=;
 b=rVGgB/WIWFW8yg0RG2qS6WSh+rprAZKAWgvGoG/psAI11cYnaj0QsWaiTsmvGRT0KrJoVaCfyTWUYAtcx56avfrLN16BnIQ2do61iVA0Hz0w4eBN849/c1pRr2EchobzZNP6BRp6dNJiZM8Yxdqkt4ECaCnYHSe2W9oW2X0PrOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:40 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:40 +0000
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
Subject: [RFC PATCH v2 21/27] NTB: epf: Provide db_vector_count/db_vector_mask callbacks
Date: Sun, 30 Nov 2025 01:03:59 +0900
Message-ID: <20251129160405.2568284-22-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0196.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::7) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1e461e-e19e-407f-92c2-08de2f6100c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TLU5oq0N3j4GXD+0wXks83DScRTrwWOOoOUvGC9cS1XIuRyUb999uNou0Iiu?=
 =?us-ascii?Q?+lbxWWwe8pPEUkwSc8dJ1/HnuyJeV5oB+ENwPJCTRwW5lI5RaxWqWeX0sLlI?=
 =?us-ascii?Q?D7olTIXH3GORNJUxXPzY3eY0SVrlFlhIjkXBh9yHJwXoxNmF4wUhAUzEe9xS?=
 =?us-ascii?Q?10Ea+gQiSgo+PNrUOQFS0tvzK49kNimHJWMZtEytiQysqGA9X3GqMNUCX//c?=
 =?us-ascii?Q?FW+MWlYEGu0B3d3UcOYbaQSe8xrmxnfWa/STKKDtVxQegpqYASjjz30pKC6w?=
 =?us-ascii?Q?h3t2UwLG1PAzZtgZ3OVpUjFVWsUdhMdU6t8m3FnRrDbyjwNF06R1SeJJ3FoP?=
 =?us-ascii?Q?gAyIaj47p67YL42ujPr8TR+22qByHPifVSddXlACvXRApuewl8QnulizM4lv?=
 =?us-ascii?Q?W70a7p4aRHHrWYmHdznv7+iRIwf6xfY2fMP4T0PoMWqBImgqPkw+/qCfl6Uc?=
 =?us-ascii?Q?q/omxHtlYtkTna7xQtcaRdNjhbxREy1o89STD2sSo5BfhDdrvRew3KQ8n+14?=
 =?us-ascii?Q?8jAJaZnGzCCS+zSVH7WeOppZj6BuRGFPNntDxclUhd9MCmY1wnby+fcpdM7K?=
 =?us-ascii?Q?qDm5gyOsBqQNamruJ98RCGqR6cpjG1ZVVc0q9WtU//4Dl975pcd1/+cFzUhZ?=
 =?us-ascii?Q?XxnqdvHlsv3YR8Iq2n2GppXPZd5zEBWa1zxwFM4n66/7yN/nI2V4BeeMV9AI?=
 =?us-ascii?Q?kyXe9aDgdGLJb4t9L5g63yluU57qTIw2cNlboGFPIE+zhWEO+S8XvwnTJnKx?=
 =?us-ascii?Q?5lb3bc3hK9+cCQnVmQfyBdvcfsHXHw29E7wNVSSPYtQqLqI08VgQ2X1ZqVh5?=
 =?us-ascii?Q?az11VTyTEucP0w0Lt5g+wLqqqt3iLcLmTHeunYbQUdPB268Ea2AaTR9B+6ei?=
 =?us-ascii?Q?MYzrwqvPNWjgsatSpqD8+eMW2FGgtFMmSwN6OYbS2oSd3MQY4G52Wu6vYkrH?=
 =?us-ascii?Q?BtzFFO42rp0dTcP2zQH+E4EDN08sYi2iT8dIu3+8WS1M+QWr7NhGlsAiV+m+?=
 =?us-ascii?Q?0UiZ7NEbw+7G5ZbJ5os7zryYP/Toutg6Sydw9v4YRe4/rGNmXA2yeFq9imfF?=
 =?us-ascii?Q?8YKWkUv6q1Z6Tb6KRqge72yqYb4lgRUM1uQmm5IpBbG/Ly/ErZQ1sraCKSPa?=
 =?us-ascii?Q?0rrVsWCX1J6nGE/SkHcTDVKoSvYPUYHKtOZlU1UvmAKz7cR9qcg49Qvl9211?=
 =?us-ascii?Q?TKWXkf6+R0qJ5sux3Ac4bbGGNFS21er0QUvWP9FDduMBnCdQhqi/ySwVOf+z?=
 =?us-ascii?Q?qNXoj7gCUjsoTt+S81AFAlX4eJ8+we56CiVupsx7KjJdwiHpxUtNbYtTz2SO?=
 =?us-ascii?Q?rzwSP+KBvZM7hWHQaRf4aWFN4LD4+CWOz9aMP/sUwC3VOvbCIsdXBS7bJfUh?=
 =?us-ascii?Q?TPdmye6AI2Yiq2MAw0mZOKlhT4maWb3QwC0BcKGQd33GyROcVbspAKefWFg7?=
 =?us-ascii?Q?8cfll+riSwXrKXx5XiIc+7OeMniWBkCr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y5uCejhBKLqdVPGZ5wa5gmCHNcqCV/E8O8Hz/2A1LUUWQAp6kseDQF+QSWyu?=
 =?us-ascii?Q?TXWmUbKhObuk5tkycDhXgBGaKdxsMuAV6LjLUfAl7yLZKe329aQ9ma8lGzl6?=
 =?us-ascii?Q?fLGU6a5iVGA/Ge6do9j04z0ReOE09X9IVzQCEMssoICcdpRH10hoqC9JEXKf?=
 =?us-ascii?Q?TPrnlNVzvjwMCmc/mJQFdaocUzWBa8RSoyGy99/HG/m9Zm4C+vQSAGdSqrrR?=
 =?us-ascii?Q?No5vMpK8NO1LWoFDvEDEvVKzd4HCq7uWoar8adRiZ4cSYEt0HEmrlbJeSXDG?=
 =?us-ascii?Q?fcQmLNrOrBsfC++vp4RGwfTwx1ugwF20uvLyLQESCyV8XDErrQ5l89WR2R7K?=
 =?us-ascii?Q?3fXtDXnkr11PMVKbuyKSXVQvdQYS3VHIpAiWzwuQhq+QAnVdG194sBx8F43W?=
 =?us-ascii?Q?eiRvc+BFTiVn/4Ezaebk34vLWsmiXVfBdQ0qxXPRPU/V11aDmyf9StQK/JlO?=
 =?us-ascii?Q?xzWF6r203ljBqEhnUI8BB5MLuZFSO4oMO/UzO55iRIeQ3RFs1h3AkEv3Qav5?=
 =?us-ascii?Q?wHalQmJAlUywuILhzr0ogbhzv7NH1k8onyhQWqRGje6mBhy5ZjXHwIcmRcpl?=
 =?us-ascii?Q?wrDFt837cL1JuIHd/IFdSf+2JOzUGpOy0NjATD25WhKsewxewYTotU1WbRpX?=
 =?us-ascii?Q?ewu4OVt2EDwGajEYKcHWZmZdFYnfAU8d/4YpicTaUbcCK7G7mkTtPcKF43CG?=
 =?us-ascii?Q?VV7RQ9QUx0kLzyJnHOcXqk7JSuvo8TFrrF/aDA/jDcmu9h25VC6AFiz2/tNS?=
 =?us-ascii?Q?P1rQE7mP8DYaz5LbsUYBe5gWQ9rPViVfTMcXAQo8QAlPOZ2FNUmCHSyMhmJi?=
 =?us-ascii?Q?a9Fdiz7x7OY3n3to4AEg8T9N+wBVLPcf2qyHWaxaiph4w9SyevK5PcQ99ayg?=
 =?us-ascii?Q?zSNoF7xKZziA72/TDDnLDnn7NWjXLlDORBXUp1cZYc6wkEKGAaPpzPUbNQhQ?=
 =?us-ascii?Q?r/FT7RQ+Z6rxiSCVnHDhpnpQK2iCOMRZ6WqwpzwAVyxVbs+nd02JKzTbhfT8?=
 =?us-ascii?Q?BPRMXdgHsa0x4OyqmIwxL/bL6Zt7A1Mnw5ahEqhe6C7dpTvq/+umQeN6YxrN?=
 =?us-ascii?Q?FcvEshDIGNsNszvrVnoDXI33gIWQSiEZ2HSn6fJpPoH3Ttkemf3T9zyLDQAt?=
 =?us-ascii?Q?D2TiBkGRCJSAAC1WcjyREI3IhyM4t7/Z4XWJSG5LmHeXmT7KRVQ96t7Juhlr?=
 =?us-ascii?Q?jOdKh5LrzZVmI6NXjSlPdyFMKpWxzcXPsNJYUKOVG2e7wMxjqs4U+2Pvnixh?=
 =?us-ascii?Q?vnQ94DbEQ527HyN8SxzmZqN6rDKJJS/JOKS4CKf69ExGt7QoxtZf1T4/wl68?=
 =?us-ascii?Q?4yQLMGsCqfrPqFQEsu1axjNAopOMvNedp9yvbQnRvN/l2/3y6Qf87DWjIjkx?=
 =?us-ascii?Q?eXLE3e0EiAo2KXrGcfARWryLl0q1MG6irHBYCwYrlsYpfWCiM0dA3z5ljKJo?=
 =?us-ascii?Q?pzmToDtuJ17hVcPVfeXYaII83B4XSJuh6NNWRLd6QLRs1tKmQxYl7R/Ny7E8?=
 =?us-ascii?Q?IMWB7R0pfS79Og2DdgpDgc9kfdDOM0UbamuSA8wK87FF5mNZ06ZEAys5ZTXA?=
 =?us-ascii?Q?fIzpBBgysbyDGVVXi/yhHZG3/kbtEqRErn8euboOFpjothwRbTMq8lLrqh4W?=
 =?us-ascii?Q?b380egq1sx0u4XC947qVOfY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1e461e-e19e-407f-92c2-08de2f6100c6
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:40.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjdA021VR9s4NuIciJzJn7PiFW5qoqMMnE4PQ7Jubt0gp+W8FQU/2b0LD/Siu0cKwQ1ZnYAxzGJZgdokemQrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

Provide db_vector_count() and db_vector_mask() implementations for both
ntb_hw_epf and pci-epf-vntb so that ntb_transport can map MSI vectors to
doorbell bits. Without them, the upper layer cannot identify which
doorbell vector fired and ends up scheduling rxc_db_work() for all queue
pairs, resulting in a thundering-herd effect when multiple queue pairs
(QPs) are enabled.

With this change, .peer_db_set() must honor the db_bits mask and raise
all requested doorbell interrupts, so update those implementations
accordingly.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 47 ++++++++++++-------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++++++---
 2 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c94bf63d69ff..d9811da90599 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -363,7 +363,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		}
 	}
 
-	ndev->db_count = irq;
+	ndev->db_count = irq - 1;
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
 				   argument | irq);
@@ -397,6 +397,22 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->db_valid_mask;
 }
 
+static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->db_count;
+}
+
+static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	db_vector--; /* vector 0 is reserved for link events */
+	if (db_vector < 0 || db_vector >= ndev->db_count)
+		return 0;
+
+	return ndev->db_valid_mask & (1ULL << db_vector);
+}
+
 static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -480,26 +496,21 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 interrupt_num = ffs(db_bits) + 1;
-	struct device *dev = ndev->dev;
+	u32 interrupt_num;
 	u32 db_entry_size;
 	u32 db_offset;
 	u32 db_data;
-
-	if (interrupt_num >= ndev->db_count) {
-		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
-			interrupt_num, ndev->db_count);
-		return -EINVAL;
-	}
+	int i;
 
 	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
 
-	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
-	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
-
-	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
-	       db_offset);
-
+	for_each_set_bit(i, (unsigned long *)&db_bits, ndev->db_count) {
+		interrupt_num = i + 1;
+		db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
+		db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+		writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
+		       db_offset);
+	}
 	return 0;
 }
 
@@ -529,6 +540,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.spad_count		= ntb_epf_spad_count,
 	.peer_mw_count		= ntb_epf_peer_mw_count,
 	.db_valid_mask		= ntb_epf_db_valid_mask,
+	.db_vector_count	= ntb_epf_db_vector_count,
+	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
@@ -561,8 +574,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	int ret;
 
 	/* One Link interrupt and rest doorbell interrupt */
-	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
-			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
+	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE,
+			       NTB_EPF_MAX_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE);
 	if (ret) {
 		dev_err(dev, "Failed to init ISR\n");
 		return ret;
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 93fd724a8faa..af8753650051 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1379,6 +1379,22 @@ static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
 }
 
+static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->db_count;
+}
+
+static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	db_vector--; /* vector 0 is reserved for link events */
+	if (db_vector < 0 || db_vector >= ndev->db_count)
+		return 0;
+
+	return 1ULL << db_vector;
+}
+
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -1488,20 +1504,28 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 
 static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 {
-	u32 interrupt_num = ffs(db_bits) + 1;
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	u8 func_no, vfunc_no;
-	int ret;
+	u64 failed = 0;
+	int i;
 
 	func_no = ntb->epf->func_no;
 	vfunc_no = ntb->epf->vfunc_no;
 
-	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
-				PCI_IRQ_MSI, interrupt_num + 1);
-	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+	for_each_set_bit(i, (unsigned long *)&db_bits, ntb->db_count) {
+		/*
+		 * DB bit i is MSI interrupt (i + 2).
+		 * Vector 0 is used for link events and MSI vectors are
+		 * 1-based for pci_epc_raise_irq().
+		 */
+		if (pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
+				      PCI_IRQ_MSI, i + 2))
+			failed |= BIT_ULL(i);
+	}
+	if (failed)
+		dev_err(&ntb->ntb.dev, "Failed to raise IRQ (0x%llx)\n", failed);
 
-	return ret;
+	return failed ? -EIO : 0;
 }
 
 static u64 vntb_epf_db_read(struct ntb_dev *ndev)
@@ -1575,6 +1599,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.spad_count		= vntb_epf_spad_count,
 	.peer_mw_count		= vntb_epf_peer_mw_count,
 	.db_valid_mask		= vntb_epf_db_valid_mask,
+	.db_vector_count	= vntb_epf_db_vector_count,
+	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
-- 
2.48.1


