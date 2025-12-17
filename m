Return-Path: <dmaengine+bounces-7775-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6266CC8824
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E224322CEB9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9DC362121;
	Wed, 17 Dec 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Vrppv7b9"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885935E55A;
	Wed, 17 Dec 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984669; cv=fail; b=c28jkWNWEmzJ6AQMxDK5TT5RW5WApEelZp7VN8H2Nr03T8ndnnx6tdXBbeexUVeQ5ECxSJfBC8S6FpBvV/fNceieklJnQw48JXpPfNC+eAKGpY/Ksuqp8v1rxplC3x8NLReeMI8VqprGtRE3up8s/7ky6FiA/uxI6kGKh9QQQ24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984669; c=relaxed/simple;
	bh=d0rACje9YjjOsG5lQZ7JZ5/XwL3Df1IiGPbPtd6KSxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6UVd5lypjRxSgQUGXWLXBW7QG7m/iVzPeqKDgPARt8h++H4xa3RQVMwCXZhKPBCLpUh3zy2MeFaC8/mdtOBozRIv35ESIwfLSDQGGW85tDV4NJAZ1lvnJyo3mIHELDm4JKDsGgjFxMOabhLaS/yN1NsYYNUktWQXUt3CMWIj+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Vrppv7b9; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rdsn95x3hV+v9H5iJbEdARDHCDj98oNtEcSa1PwPC6J5PxAgKAueF2RJrL+yCqV++XOlwK0X94p1mdJfdbs1QAthL+wOJ9hMyk6rnCo9tBmgHhfjQM8VLpDkAJNbXtkF5fBD8WezmppHvk6ak4BlyKJ30TC91wUXxVrumkqaj/7m5yewGUpbJL/kBfovrRdJERFaNiagp8YCSBu/5s9j949f2didgXFJTglT7B2DIYLmtOZtDtjRiIeJZQyIz9dLKI7b82pZ8km2Fli8TCZHIp5uaRE5m6zf3E68d1VugZNLjFZlMuUB/AC4I3NCPGBVCJ5e8kt0Iom9QvDCFNwowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL83BuiDgQhlPZrb1PXPTF4fyQ31mx307j1bQxvQqP0=;
 b=rciSIdAmy75kgmxAMnnTl3xthyJf9Ho7GNtjhS76Gu4nVKxJmDIJfR/UhSSXKs+k6+i18rxWu4WJBKI3fHqm2AnXafU4QE6YYi0nNTwkxf0QFIZfYHfI8P5qc2ttzGBELY0sc/rIqjAO82VCu9tTTIyvBHkQgx+fzXDab3Q5Px2gyeq4BC8Qj/zHToKsHochrIwlaUo+H4ZYfCfaH2L9PvcbwJu6n+v2R7f6LmCptQhRuxKCg+KRvTVDzGQRD2bHOP9OpNfmsk9GxEC098E3yprhs1ltEDgjAh49fAOQR0Zq/laRe9+c2M+Rr9LKkXPsjLewsVCCkLf8bxIq5v8U2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL83BuiDgQhlPZrb1PXPTF4fyQ31mx307j1bQxvQqP0=;
 b=Vrppv7b9Lqm5f8bZU//HIiHyITcIPLxKTjf7jYHrwB4duz88iWmZthiwHTKGznEcADoA16BW18tOdfKYa5S4t5mRJac2l04BkEmvPDJ3CfPUzMCQ+9QWkkDIQAThSU3LZVm61t+CSScsA3HMiaOKPgw+EI284axn2nHqpEa9goI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:36 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:36 +0000
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
Subject: [RFC PATCH v3 25/35] NTB: hw: Introduce DesignWare eDMA helper
Date: Thu, 18 Dec 2025 00:15:59 +0900
Message-ID: <20251217151609.3162665-26-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9fab2d-e9a2-4516-cdf9-08de3d7f4521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LhFmzEObNAFdIJTiUV+FiPJogMkZKZKugFDf5JC06L/IO8opSVDVWQUdFoQb?=
 =?us-ascii?Q?/snk3vrFRMIWxGBxEj3D+1VHmSMnDUT8jZFeXLr9WACzS8iQzOlzANrZmqEo?=
 =?us-ascii?Q?/pxW824+zDDVRY0Z6jTIsZk63ft5ZfyXUJ5+FNHnQaIfsbAmafemaCmOIR4h?=
 =?us-ascii?Q?Ii5plO8hqr4IARssVMNr7HZlp2hHnz0lre+i5yXB5qZ2AAUHwO3q11PEC55x?=
 =?us-ascii?Q?w8CBqeq0VK/SLqGy4Mw0+yY/MuJTQ8BRIvx3XYkuLlpC9mJugurzoPrbiSdU?=
 =?us-ascii?Q?XmSYiIYJrK0vsCa9Pxh7pt7SRF5gL5NlQ8rm8+tZXJeH2cNwERAadG4QDJkP?=
 =?us-ascii?Q?Ae4OSTt8cSARBpuF9kJKOR0wzEJQ/I8ZLQl6OQfifIvECYajv2JSXzVgvWaA?=
 =?us-ascii?Q?yadsDN7mECNnDXgGPmAU4mLsXu3+re2pWb4xdcD8yFix3XXKJe04Utugb+4r?=
 =?us-ascii?Q?RF9mrZsub7x2f9qn/DH2VM7LZSDwhY9uIdcTV/j151kOw8t0DosSoI1pioVb?=
 =?us-ascii?Q?C2pDBMYWRqqn4wR3ICp5/xF72/e2pdV4qPA+P2XwMQL49AEz4aPAcLxkRRQu?=
 =?us-ascii?Q?TB4hbJ+jqaaUcbYHxPXPQp57bmq6iZpe+0gUEcwkFAjweDoRPo7mxk+wTjeS?=
 =?us-ascii?Q?fu3uY1pqOkMXPRBkJmfmITasaZiWCfqeRbY1+oWdoTCQLphvUcThtKEOfT0c?=
 =?us-ascii?Q?jFkZbZhqfgtoSMy4ZUlmPQE80OImMaAh/ca//oGfoR1+GOVbNNR+gTWzrt0I?=
 =?us-ascii?Q?L1D5OsbCJZ/WmlsanqCt7h2SZrNoH6jKKCII0+lipiZqMgCetTF/QHqSU80u?=
 =?us-ascii?Q?Pza7EFMqJ4Bvg4HJpc2zf1G32BB+7Ff/eMtG8yTWNZ206txYjaSplCRFvWZW?=
 =?us-ascii?Q?QmhANSzbonmZWJ4YLNYTo9LEkpDTnn7LYqOlpkExxY93qKzDsAAB2Zsfp2Di?=
 =?us-ascii?Q?sHH1pNoBDFPkUbitpr0VYmFvnWjxRpum4uACfGBzbUmSapZPC+zh2wzfZquf?=
 =?us-ascii?Q?ZD2NgdrQSnkAbJCZzuuBgVYPZYdgjYwcdWDtiMQNu0lv3NI5UDqDUQApGMiD?=
 =?us-ascii?Q?Z7z/HIe0TI/FwKqLRvbpEd+Iu9tO01aAJor2IHAhIuJZmUIaIjN6Ob8ANAs8?=
 =?us-ascii?Q?/FKFaqSIlhtM6czwq/ehVs16qa7WxLC+KWQ+ux5W1bXLE/00FgnC9nTh0cUx?=
 =?us-ascii?Q?+0PWaq93Zf3Rg0UOsw3KbkevZ3AVJaPd/mW8img0gwkIhv1QbyrCytc6pyIZ?=
 =?us-ascii?Q?fLfHX2ihLvw5Y4DbyGKiFTzWCSVbJxnBZFHRg627/H6JL7E7TIT6gAg989Af?=
 =?us-ascii?Q?iHL/Zdv1S5fEIS2eSGVTpBmUkVwenfaon51ERccR7KVWvnzJTIlXCED+ADBG?=
 =?us-ascii?Q?WH37+9ozPq9oGd51lYOM4K7N68gfoT7Fm42jeJRQ2rGmGchcSeQwllIQoT32?=
 =?us-ascii?Q?Ogg5xUsK+0Qf7bc131QvJ+3Snk/r9Lmq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2F742udNjpquDKzD/7V3zViRHsKBkX8qFf+iweKMVPbprCexq6Mqpe+uROq?=
 =?us-ascii?Q?XlG4dSwSdHAnkLLYmSRHU90TqkqbkbWUt4TOIQOFAL0TcxkypyK6ji3wjVFy?=
 =?us-ascii?Q?WbBrJh96x4bgJFsJW3ubJ4XSVU/+FAlkAKp99j4OPPfjOdarHgNv+IGeO7fi?=
 =?us-ascii?Q?s+OuDt6tjMy0CiVhHaaPfrycq1htDVVHDskfGdau9i6zQjoQBjhcF08+oBZO?=
 =?us-ascii?Q?0hewKl5VG78jbucsCik4fPoarjRql7gU3ORI0pKbv1KSV+hWN4CLfbSOBzGv?=
 =?us-ascii?Q?AP1gCqHoFSetRuVfKJ2X2o7B+o3mRP2K2Ps+GMvnKWH+nh4nrRXvbXoaE/5G?=
 =?us-ascii?Q?miutG1hFND7B2mJqJiEQwMwCpSpO1C0x6JXpXwBLqC1SU/AXn+Hwv9jf61e4?=
 =?us-ascii?Q?vve5aa47fuJy57U2MTCAGZIe2czLMNI1K1Ed9brHHoXwTeHFnMQLhnlMKCpN?=
 =?us-ascii?Q?b42lHYs1vdllIn03hYDRNdpZGmOn9uD2YMJ/AbScgLU3hRhEIBDqJZanEuFW?=
 =?us-ascii?Q?Jsu6tmZdbqRi2pLOyAmKFQ0cA4FejctULdsvLNRyphsnJfeISqpnJjzLfnKc?=
 =?us-ascii?Q?UcHh1HVvr1xicR4y+ZGjqe+Bo48IWYbPfek4RZYnQne/6549i/haWkPOTDs0?=
 =?us-ascii?Q?KCjbWjQMQFJc2rgtMpudEZg+CMvJfVjw2eojrapNZahcVkbduSUxwLSkQrM9?=
 =?us-ascii?Q?oRWTzPBYG60HjyQsnV99SOzJg/VSUhehUi8q/NFxEg8GdYydBLBnZ+N8yb9o?=
 =?us-ascii?Q?mL2C1Ux2tdr7sKW6hOgnBDyPxNhb7YL6knbtz6h8Lh8f6T+i42sWNZpocskf?=
 =?us-ascii?Q?JGP9V7+7PU7fg9K+86vioHtxbSLoOeZKsTE61YUu84pHGC8XSGR0OplR6S6r?=
 =?us-ascii?Q?r+iUlIYrGyC7RraZrmpvU+8tiwBWJ6SQKBh12QRSOsGxoS5kIh+9a9CzJLW1?=
 =?us-ascii?Q?Yx2+sd+c2tGgJdDDD1zX5GZgErc2hqr+Org72UryC6TxHdukqJrweyJvTnue?=
 =?us-ascii?Q?OubiRByr0q+K8TKyjRe1HcRh+QWLvwLHTYwn8IfWxfe4OTBMwDZuU6qclzXo?=
 =?us-ascii?Q?fNTbD69u4w+zkF5yzYuODAcGbeuWXWgmuUuCdNhcSVvzmWSs+nvD9Uh3e3oF?=
 =?us-ascii?Q?Yboz8fZh/jSO7lEJRwvRQI/HfZmJ/nZC4I6zHPEYtYbqMD+Crxm+MJL3jlF1?=
 =?us-ascii?Q?28CUOUECCPU90lhSW6ZWkYR2O/4mbhPveNmfzyKUJRUHz3RqMxllp001+RZS?=
 =?us-ascii?Q?Dy++b3W512uIY6pGqesY30ughq+wU3FSZ15raOuD/oshQYBd6VoI5vTWCqjL?=
 =?us-ascii?Q?1LDehfnAFLEfxHjfo/YDwR6Wy/AD3+FiYLMYSEcnf9nRYdej8HkL+s/1rh9/?=
 =?us-ascii?Q?IPEV+uDtWX8vdsgNizvKl4idYuxFHSzfvhyFK+M2UW/Vg0SM1wF+9ITrztvz?=
 =?us-ascii?Q?BasnD2GFFbFdDJgD7zAZRQ7Jc+zJobbqvB6mNhrockIeWEEL1UMQRez33FkP?=
 =?us-ascii?Q?9DA8rNC5DvcM/u+o7JU7kY2EpiNowqjrJ+IybWi5R0gNDydirXNVJPeQpNPe?=
 =?us-ascii?Q?0NDBLKbsqbqTJv3dYa0xpm92C9rdYF+W+6usuqoUbNLeqCZfXbaYYyGLOfjs?=
 =?us-ascii?Q?CGk7BQvbme5GB2AdyoXI/N4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9fab2d-e9a2-4516-cdf9-08de3d7f4521
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:36.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAA92okvx5MyQrC4axPVpfSAZmBcjp/khICAHUaUBmiqyvSJtpvvpQEToMkVNKzcxwNnoI9b65lEjZXoIBkBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Add a helper library under drivers/ntb/hw/edma/ that is to be used by
the NTB transport remote eDMA backend. This is not an NTB hardware
driver but rather encapsulates DesignWare eDMA specific plumbing.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/edma/ntb_hw_edma.c | 754 ++++++++++++++++++++++++++++++
 drivers/ntb/hw/edma/ntb_hw_edma.h |  76 +++
 2 files changed, 830 insertions(+)
 create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.c
 create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.h

diff --git a/drivers/ntb/hw/edma/ntb_hw_edma.c b/drivers/ntb/hw/edma/ntb_hw_edma.c
new file mode 100644
index 000000000000..50c4ddee285f
--- /dev/null
+++ b/drivers/ntb/hw/edma/ntb_hw_edma.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NTB remote DesignWare eDMA helpers
+ *
+ * This file is a helper library used by the NTB transport remote-eDMA backend,
+ * not a standalone NTB hardware driver. It contains the DesignWare eDMA
+ * specific plumbing needed to expose/map peer-accessible resources via an NTB
+ * memory window and to manage DMA channels and peer notifications.
+ */
+
+#include <linux/dma/edma.h>
+#include <linux/dmaengine.h>
+#include <linux/device.h>
+#include <linux/iommu.h>
+#include <linux/irqdomain.h>
+#include <linux/ntb.h>
+#include <linux/pci.h>
+#include <linux/pci-epc.h>
+#include <linux/spinlock.h>
+
+#include "ntb_hw_edma.h"
+
+/* Default eDMA LLP memory size */
+#define DMA_LLP_MEM_SIZE	PAGE_SIZE
+
+#define NTB_EDMA_MW_IDX_INVALID	(-1)
+
+struct ntb_edma_ctx {
+	bool initialized;
+
+	/* Fields for the notification handling */
+	u32 qp_count;
+	u32 *notify_src_virt;
+	dma_addr_t notify_src_phys;
+	struct scatterlist sgl;
+
+	/* Host to EP scratch buffer to tell the event info */
+	union {
+		struct ntb_edma_db *db_virt;
+		struct ntb_edma_db __iomem *db_io;
+	};
+	dma_addr_t db_phys;
+
+	/* Below are the records for teardown path */
+
+	/* For ntb_edma_info to be unmapped on teardown */
+	struct ntb_edma_info *info_virt;
+	dma_addr_t info_phys;
+	size_t info_bytes;
+
+	int mw_index;
+	bool mw_trans_set;
+
+	/* eDMA register window IOMMU mapping (EP side) */
+	bool reg_mapped;
+	struct iommu_domain *iommu_dom;
+	unsigned long reg_iova;
+	size_t reg_iova_size;
+
+	/* Read channels delegated to the host side (EP side) */
+	struct dma_chan *dchan[NTB_EDMA_TOTAL_CH_NUM];
+
+	/* RC-side state */
+	bool peer_initialized;
+	bool peer_probed;
+	struct dw_edma_chip *peer_chip;
+	void __iomem *peer_virt;
+	resource_size_t peer_virt_size;
+};
+
+typedef void (*ntb_edma_interrupt_cb_t)(void *data, int qp_num);
+
+struct ntb_edma_interrupt {
+	ntb_edma_interrupt_cb_t cb;
+	void *data;
+};
+
+struct ntb_edma_filter {
+	struct device *dma_dev;
+	u32 direction;
+};
+
+static struct ntb_edma_ctx edma_ctx;
+static struct ntb_edma_interrupt intr;
+
+static DEFINE_SPINLOCK(ntb_edma_notify_lock);
+
+static bool ntb_edma_filter_fn(struct dma_chan *chan, void *arg)
+{
+	struct ntb_edma_filter *filter = arg;
+	u32 dir = filter->direction;
+	struct dma_slave_caps caps;
+	int ret;
+
+	if (chan->device->dev != filter->dma_dev)
+		return false;
+
+	ret = dma_get_slave_caps(chan, &caps);
+	if (ret < 0)
+		return false;
+
+	return !!(caps.directions & dir);
+}
+
+static void ntb_edma_notify_cb(struct dma_chan *dchan, void *data)
+{
+	struct ntb_edma_interrupt *v = data;
+	ntb_edma_interrupt_cb_t cb;
+	struct ntb_edma_db *db;
+	void *cb_data;
+	u32 qp_count;
+	u32 i, val;
+
+	guard(spinlock_irqsave)(&ntb_edma_notify_lock);
+
+	cb = v->cb;
+	cb_data = v->data;
+	qp_count = edma_ctx.qp_count;
+	db = edma_ctx.db_virt;
+	if (!cb || !db)
+		return;
+
+	for (i = 0; i < qp_count; i++) {
+		val = READ_ONCE(db->db[i]);
+		if (!val)
+			continue;
+
+		WRITE_ONCE(db->db[i], 0);
+		cb(cb_data, i);
+	}
+}
+
+static void ntb_edma_undelegate_chans(struct ntb_edma_ctx *ctx)
+{
+	unsigned int i;
+
+	if (!ctx)
+		return;
+
+	scoped_guard(spinlock_irqsave, &ntb_edma_notify_lock) {
+		intr.cb = NULL;
+		intr.data = NULL;
+	}
+
+	for (i = 0; i < NTB_EDMA_TOTAL_CH_NUM; i++) {
+		if (!ctx->dchan[i])
+			continue;
+
+		if (i == NTB_EDMA_CH_NUM)
+			dw_edma_chan_register_notify(ctx->dchan[i], NULL, NULL);
+
+		dma_release_channel(ctx->dchan[i]);
+		ctx->dchan[i] = NULL;
+	}
+}
+
+static int ntb_edma_delegate_chans(struct device *dev, struct ntb_edma_ctx *ctx,
+				   struct ntb_edma_info *info,
+				   ntb_edma_interrupt_cb_t cb, void *data)
+{
+	struct ntb_edma_filter filter;
+	struct dw_edma_region region;
+	dma_cap_mask_t dma_mask;
+	struct dma_chan *chan;
+	unsigned int i;
+	int rc;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+
+	filter.dma_dev = dev;
+
+	/* Configure read channels, which will be driven by the host side */
+	for (i = 0; i < NTB_EDMA_TOTAL_CH_NUM; i++) {
+		filter.direction = BIT(DMA_DEV_TO_MEM);
+		chan = dma_request_channel(dma_mask, ntb_edma_filter_fn,
+					   &filter);
+		if (!chan) {
+			rc = -ENODEV;
+			goto err;
+		}
+		ctx->dchan[i] = chan;
+
+		if (i == NTB_EDMA_CH_NUM) {
+			scoped_guard(spinlock_irqsave, &ntb_edma_notify_lock) {
+				intr.cb = cb;
+				intr.data = data;
+			}
+			rc = dw_edma_chan_register_notify(
+					chan, ntb_edma_notify_cb, &intr);
+			if (rc)
+				goto err;
+		} else {
+			rc = dw_edma_chan_irq_config(chan, DW_EDMA_CH_IRQ_REMOTE);
+			if (rc)
+				dev_warn(dev, "irq config failed (i=%u %d)\n",
+					 i, rc);
+		}
+
+		rc = dw_edma_chan_get_ll_region(chan, &region);
+		if (rc)
+			goto err;
+
+		info->ll_rd_phys[i] = region.paddr;
+	}
+
+	return 0;
+
+err:
+	ntb_edma_undelegate_chans(ctx);
+	return rc;
+}
+
+static void ntb_edma_ctx_reset(struct ntb_edma_ctx *ctx)
+{
+	ctx->initialized = false;
+	ctx->mw_index = NTB_EDMA_MW_IDX_INVALID;
+	ctx->mw_trans_set = false;
+	ctx->reg_mapped = false;
+	ctx->iommu_dom = NULL;
+	ctx->reg_iova = 0;
+	ctx->reg_iova_size = 0;
+	ctx->db_phys = 0;
+	ctx->qp_count = 0;
+	ctx->info_virt = NULL;
+	ctx->info_phys = 0;
+	ctx->info_bytes = 0;
+	ctx->db_virt = NULL;
+	memset(ctx->dchan, 0, sizeof(ctx->dchan));
+}
+
+int ntb_edma_setup_mws(struct ntb_dev *ndev, int mw_index,
+		       unsigned int qp_count, ntb_edma_interrupt_cb_t cb,
+		       void *data)
+{
+	struct ntb_edma_ctx *ctx = &edma_ctx;
+	const size_t info_bytes = PAGE_SIZE;
+	resource_size_t size_max, offset;
+	dma_addr_t db_phys, info_phys;
+	size_t reg_size, reg_size_mw;
+	struct ntb_edma_info *info;
+	phys_addr_t edma_reg_phys;
+	struct iommu_domain *dom;
+	struct ntb_edma_db *db;
+	size_t ll_bytes, size;
+	struct pci_epc *epc;
+	struct device *dev;
+	unsigned long iova;
+	phys_addr_t phys;
+	u64 need;
+	int rc;
+	u32 i;
+
+	if (ctx->initialized)
+		return 0;
+
+	/* Clean up stale state from a previous failed attempt. */
+	ntb_edma_teardown_mws(ndev);
+
+	epc = (struct pci_epc *)ntb_get_private_data(ndev);
+	if (!epc)
+		return -ENODEV;
+	dev = epc->dev.parent;
+
+	ntb_edma_ctx_reset(ctx);
+
+	ctx->mw_index = mw_index;
+	ctx->qp_count = qp_count;
+
+	info = dma_alloc_coherent(dev, info_bytes, &info_phys, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	memset(info, 0, info_bytes);
+
+	ctx->info_virt = info;
+	ctx->info_phys = info_phys;
+	ctx->info_bytes = info_bytes;
+
+	/* Get eDMA reg base and size, IOMMU map it if necessary */
+	rc = dw_edma_get_reg_window(epc, &edma_reg_phys, &reg_size);
+	if (rc) {
+		dev_err(&ndev->pdev->dev,
+			"failed to get eDMA register window: %d\n", rc);
+		goto err;
+	}
+	dom = iommu_get_domain_for_dev(dev);
+	if (dom) {
+		phys = edma_reg_phys & PAGE_MASK;
+		size = PAGE_ALIGN(reg_size + edma_reg_phys - phys);
+		iova = phys;
+
+		rc = iommu_map(dom, iova, phys, size,
+			       IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO,
+			       GFP_KERNEL);
+		if (rc) {
+			dev_err(&ndev->dev,
+				"failed to direct map eDMA reg: %d\n", rc);
+			goto err;
+		}
+
+		ctx->reg_mapped = true;
+		ctx->iommu_dom = dom;
+		ctx->reg_iova = iova;
+		ctx->reg_iova_size = size;
+	}
+
+	/* Read channels are driven by the peer (host side) */
+	rc = ntb_edma_delegate_chans(dev, ctx, info, cb, data);
+	if (rc) {
+		dev_err(&ndev->pdev->dev,
+			"failed to prepare channels to delegate: %d\n", rc);
+		goto err;
+	}
+
+	/* Scratch buffer for notification */
+	db = dma_alloc_coherent(dev, sizeof(*db), &db_phys, GFP_KERNEL);
+	if (!db) {
+		rc = -ENOMEM;
+		goto err;
+	}
+	memset(db, 0, sizeof(*db));
+
+	ctx->db_virt = db;
+	ctx->db_phys = db_phys;
+
+	/* Prep works for IB iATU mappings */
+	ll_bytes = NTB_EDMA_TOTAL_CH_NUM * DMA_LLP_MEM_SIZE;
+	reg_size_mw = roundup_pow_of_two(reg_size);
+	need = info_bytes + PAGE_SIZE + reg_size_mw + ll_bytes;
+
+	rc = ntb_mw_get_align(ndev, 0, mw_index, NULL, NULL, &size_max, &offset);
+	if (rc)
+		goto err;
+
+	if (size_max < need) {
+		rc = -ENOSPC;
+		goto err;
+	}
+
+	/* iATU map ntb_edma_info */
+	rc = ntb_mw_set_trans(ndev, 0, mw_index, info_phys, info_bytes, offset);
+	if (rc)
+		goto err;
+	ctx->mw_trans_set = true;
+	offset += info_bytes;
+
+	/* iATU map ntb_edma_db */
+	rc = ntb_mw_set_trans(ndev, 0, mw_index, db_phys, PAGE_SIZE, offset);
+	if (rc)
+		goto err;
+	offset += PAGE_SIZE;
+
+	/* iATU map eDMA reg */
+	rc = ntb_mw_set_trans(ndev, 0, mw_index, edma_reg_phys, reg_size_mw,
+			      offset);
+	if (rc)
+		goto err;
+	offset += reg_size_mw;
+
+	/* iATU map LL location */
+	for (i = 0; i < NTB_EDMA_TOTAL_CH_NUM; i++) {
+		rc = ntb_mw_set_trans(ndev, 0, mw_index, info->ll_rd_phys[i],
+				      DMA_LLP_MEM_SIZE, offset);
+		if (rc)
+			goto err;
+		offset += DMA_LLP_MEM_SIZE;
+	}
+
+	/* Fill in info */
+	info->magic = NTB_EDMA_INFO_MAGIC;
+	info->reg_size = reg_size_mw;
+	info->ch_cnt = NTB_EDMA_TOTAL_CH_NUM;
+	info->db_base = db_phys;
+
+	ctx->initialized = true;
+	return 0;
+
+err:
+	ntb_edma_teardown_mws(ndev);
+	return rc;
+}
+
+static int ntb_edma_irq_vector(struct device *dev, unsigned int nr)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret, nvec;
+
+	nvec = pci_msi_vec_count(pdev);
+	for (; nr < nvec; nr++) {
+		ret = pci_irq_vector(pdev, nr);
+		if (!irq_has_action(ret))
+			return ret;
+	}
+	return 0;
+}
+
+static const struct dw_edma_plat_ops ntb_edma_ops = {
+	.irq_vector     = ntb_edma_irq_vector,
+};
+
+int ntb_edma_setup_peer(struct ntb_dev *ndev, int mw_index,
+			unsigned int qp_count)
+{
+	struct ntb_edma_ctx *ctx = &edma_ctx;
+	struct ntb_edma_info __iomem *info;
+	struct dw_edma_chip *chip;
+	void __iomem *edma_virt;
+	resource_size_t mw_size;
+	phys_addr_t edma_phys;
+	unsigned int ch_cnt;
+	unsigned int i;
+	int ret;
+	u64 off;
+
+	if (ctx->peer_initialized)
+		return 0;
+
+	/* Clean up stale state from a previous failed attempt. */
+	ntb_edma_teardown_peer(ndev);
+
+	ret = ntb_peer_mw_get_addr(ndev, mw_index, &edma_phys, &mw_size);
+	if (ret)
+		return ret;
+
+	edma_virt = ioremap(edma_phys, mw_size);
+	if (!edma_virt)
+		return -ENOMEM;
+
+	ctx->peer_virt = edma_virt;
+	ctx->peer_virt_size = mw_size;
+
+	info = edma_virt;
+	if (readl(&info->magic) != NTB_EDMA_INFO_MAGIC) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ch_cnt = readw(&info->ch_cnt);
+	if (ch_cnt != NTB_EDMA_TOTAL_CH_NUM) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	chip = devm_kzalloc(&ndev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	off = 2 * PAGE_SIZE;
+	chip->dev = &ndev->pdev->dev;
+	chip->nr_irqs = 4;
+	chip->ops = &ntb_edma_ops;
+	chip->flags = 0;
+	chip->reg_base = edma_virt + off;
+	chip->mf = EDMA_MF_EDMA_UNROLL;
+	chip->ll_wr_cnt = 0;
+	chip->ll_rd_cnt = ch_cnt;
+
+	ctx->db_io = (void __iomem *)edma_virt + PAGE_SIZE;
+	ctx->qp_count = qp_count;
+	ctx->db_phys = readq(&info->db_base);
+
+	ctx->notify_src_virt = dma_alloc_coherent(&ndev->pdev->dev,
+						  sizeof(*ctx->notify_src_virt),
+						  &ctx->notify_src_phys,
+						  GFP_KERNEL);
+	if (!ctx->notify_src_virt) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	off += readl(&info->reg_size);
+
+	for (i = 0; i < ch_cnt; i++) {
+		chip->ll_region_rd[i].vaddr.io = edma_virt + off;
+		chip->ll_region_rd[i].paddr = readq(&info->ll_rd_phys[i]);
+		chip->ll_region_rd[i].sz = DMA_LLP_MEM_SIZE;
+		off += DMA_LLP_MEM_SIZE;
+	}
+
+	if (!pci_dev_msi_enabled(ndev->pdev)) {
+		ret = -ENXIO;
+		goto err;
+	}
+
+	ret = dw_edma_probe(chip);
+	if (ret) {
+		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
+		goto err;
+	}
+
+	ctx->peer_chip = chip;
+	ctx->peer_probed = true;
+	ctx->peer_initialized = true;
+	return 0;
+
+err:
+	ntb_edma_teardown_peer(ndev);
+	return ret;
+}
+
+void ntb_edma_teardown_mws(struct ntb_dev *ndev)
+{
+	struct ntb_edma_ctx *ctx = &edma_ctx;
+	struct device *dev = NULL;
+	struct pci_epc *epc;
+	struct ntb_edma_db *db;
+	struct ntb_edma_info *info;
+	dma_addr_t db_phys, info_phys;
+	size_t info_bytes;
+
+	epc = (struct pci_epc *)ntb_get_private_data(ndev);
+	WARN_ON(!epc);
+	if (epc)
+		dev = epc->dev.parent;
+
+	scoped_guard(spinlock_irqsave, &ntb_edma_notify_lock) {
+		db = ctx->db_virt;
+		db_phys = ctx->db_phys;
+
+		/* Make callbacks no-op first. */
+		intr.cb = NULL;
+		intr.data = NULL;
+		ctx->db_virt = NULL;
+		ctx->qp_count = 0;
+	}
+
+	info = ctx->info_virt;
+	info_phys = ctx->info_phys;
+	info_bytes = ctx->info_bytes;
+
+	/* Disconnect the MW before freeing its backing memory */
+	if (ctx->mw_trans_set && ctx->mw_index != NTB_EDMA_MW_IDX_INVALID)
+		ntb_mw_clear_trans(ndev, 0, ctx->mw_index);
+
+	ntb_edma_undelegate_chans(ctx);
+
+	if (ctx->reg_mapped)
+		iommu_unmap(ctx->iommu_dom, ctx->reg_iova, ctx->reg_iova_size);
+
+	if (db && dev)
+		dma_free_coherent(dev, sizeof(*db), db, db_phys);
+
+	if (info && dev && info_bytes)
+		dma_free_coherent(dev, info_bytes, info, info_phys);
+
+	ntb_edma_ctx_reset(ctx);
+}
+
+void ntb_edma_teardown_peer(struct ntb_dev *ndev)
+{
+	struct ntb_edma_ctx *ctx = &edma_ctx;
+	void __iomem *peer_virt = ctx->peer_virt;
+	struct dw_edma_chip *chip = ctx->peer_chip;
+	u32 *notify_src = ctx->notify_src_virt;
+	dma_addr_t notify_src_phys = ctx->notify_src_phys;
+
+	/* Stop using peer MMIO early. */
+	ctx->db_io = NULL;
+	ctx->db_phys = 0;
+	ctx->qp_count = 0;
+
+	if (ctx->peer_probed && chip)
+		dw_edma_remove(chip);
+
+	ctx->peer_initialized = false;
+	ctx->peer_probed = false;
+	ctx->peer_chip = NULL;
+
+	if (notify_src)
+		dma_free_coherent(&ndev->pdev->dev, sizeof(*notify_src),
+				  notify_src, notify_src_phys);
+
+	ctx->notify_src_virt = NULL;
+	ctx->notify_src_phys = 0;
+	memset(&ctx->sgl, 0, sizeof(ctx->sgl));
+
+	if (peer_virt)
+		iounmap(peer_virt);
+
+	ctx->peer_virt = NULL;
+	ctx->peer_virt_size = 0;
+}
+
+void ntb_edma_teardown_chans(struct ntb_edma_chans *edma)
+{
+	unsigned int i;
+
+	if (!edma)
+		return;
+
+	for (i = 0; i < NTB_EDMA_CH_NUM; i++) {
+		if (!edma->chan[i])
+			continue;
+		dma_release_channel(edma->chan[i]);
+		edma->chan[i] = NULL;
+	}
+	edma->num_chans = 0;
+
+	if (edma->intr_chan) {
+		dma_release_channel(edma->intr_chan);
+		edma->intr_chan = NULL;
+	}
+
+	atomic_set(&edma->cur_chan, 0);
+}
+
+int ntb_edma_setup_chans(struct device *dev, struct ntb_edma_chans *edma,
+			 bool remote)
+{
+	struct ntb_edma_filter filter;
+	dma_cap_mask_t dma_mask;
+	unsigned int i;
+	int rc;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+
+	memset(edma, 0, sizeof(*edma));
+	edma->dev = dev;
+
+	mutex_init(&edma->lock);
+
+	filter.dma_dev = dev;
+	filter.direction = BIT(DMA_MEM_TO_DEV);
+	for (i = 0; i < NTB_EDMA_CH_NUM; i++) {
+		edma->chan[i] = dma_request_channel(
+					dma_mask, ntb_edma_filter_fn, &filter);
+		if (!edma->chan[i])
+			break;
+		edma->num_chans++;
+
+		if (remote)
+			rc = dw_edma_chan_irq_config(edma->chan[i],
+						     DW_EDMA_CH_IRQ_REMOTE);
+		else
+			rc = dw_edma_chan_irq_config(edma->chan[i],
+						     DW_EDMA_CH_IRQ_LOCAL);
+
+		if (rc) {
+			dev_err(dev, "irq config failed on ch%u: %d\n", i, rc);
+			goto err;
+		}
+	}
+
+	if (!edma->num_chans) {
+		dev_warn(dev, "Remote eDMA channels failed to initialize\n");
+		ntb_edma_teardown_chans(edma);
+		return -ENODEV;
+	}
+	return 0;
+err:
+	ntb_edma_teardown_chans(edma);
+	return rc;
+}
+
+int ntb_edma_setup_intr_chan(struct device *dev, struct ntb_edma_chans *edma)
+{
+	struct ntb_edma_filter filter;
+	dma_cap_mask_t dma_mask;
+	struct dma_slave_config cfg;
+	struct scatterlist *sgl = &edma_ctx.sgl;
+	int rc;
+
+	if (edma->intr_chan)
+		return 0;
+
+	if (!edma_ctx.notify_src_virt || !edma_ctx.db_phys)
+		return -EINVAL;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_SLAVE, dma_mask);
+
+	filter.dma_dev = dev;
+	filter.direction = BIT(DMA_MEM_TO_DEV);
+
+	edma->intr_chan = dma_request_channel(dma_mask, ntb_edma_filter_fn,
+					      &filter);
+	if (!edma->intr_chan) {
+		dev_warn(dev,
+			 "Remote eDMA notify channel could not be allocated\n");
+		return -ENODEV;
+	}
+
+	rc = dw_edma_chan_irq_config(edma->intr_chan, DW_EDMA_CH_IRQ_LOCAL);
+	if (rc)
+		goto err_release;
+
+	/* Ensure store is visible before kicking DMA transfer */
+	wmb();
+
+	sg_init_table(sgl, 1);
+	sg_dma_address(sgl) = edma_ctx.notify_src_phys;
+	sg_dma_len(sgl) = sizeof(u32);
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.dst_addr = edma_ctx.db_phys; /* The first 32bit is 'target' */
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.direction = DMA_MEM_TO_DEV;
+
+	rc = dmaengine_slave_config(edma->intr_chan, &cfg);
+	if (rc)
+		goto err_release;
+
+	return 0;
+
+err_release:
+	dma_release_channel(edma->intr_chan);
+	edma->intr_chan = NULL;
+	return rc;
+}
+
+struct dma_chan *ntb_edma_pick_chan(struct ntb_edma_chans *edma,
+				    unsigned int idx)
+{
+	return edma->chan[idx % edma->num_chans];
+}
+
+int ntb_edma_notify_peer(struct ntb_edma_chans *edma, int qp_num)
+{
+	struct dma_async_tx_descriptor *txd;
+	dma_cookie_t cookie;
+
+	if (!edma || !edma->intr_chan)
+		return -ENXIO;
+
+	if (qp_num < 0 || qp_num >= edma_ctx.qp_count)
+		return -EINVAL;
+
+	if (!edma_ctx.db_io)
+		return -EINVAL;
+
+	guard(mutex)(&edma->lock);
+
+	writel(1, &edma_ctx.db_io->db[qp_num]);
+
+	/* Ensure store is visible before kicking the DMA transfer */
+	wmb();
+
+	txd = dmaengine_prep_slave_sg(edma->intr_chan, &edma_ctx.sgl, 1,
+				      DMA_MEM_TO_DEV,
+				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!txd)
+		return -ENOSPC;
+
+	cookie = dmaengine_submit(txd);
+	if (dma_submit_error(cookie))
+		return -ENOSPC;
+
+	dma_async_issue_pending(edma->intr_chan);
+	return 0;
+}
diff --git a/drivers/ntb/hw/edma/ntb_hw_edma.h b/drivers/ntb/hw/edma/ntb_hw_edma.h
new file mode 100644
index 000000000000..46b50e504389
--- /dev/null
+++ b/drivers/ntb/hw/edma/ntb_hw_edma.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _NTB_HW_EDMA_H_
+#define _NTB_HW_EDMA_H_
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+
+#define NTB_EDMA_CH_NUM		4
+
+/* One extra channel is reserved for notification (RC to EP interrupt kick). */
+#define NTB_EDMA_TOTAL_CH_NUM	(NTB_EDMA_CH_NUM + 1)
+
+#define NTB_EDMA_INFO_MAGIC	0x45444D41 /* "EDMA" */
+
+#define NTB_EDMA_NOTIFY_MAX_QP	64
+
+typedef void (*ntb_edma_interrupt_cb_t)(void *data, int qp_num);
+
+/*
+ * REMOTE_EDMA_EP:
+ *   Endpoint owns the eDMA engine and pushes descriptors into a shared MW.
+ *
+ * REMOTE_EDMA_RC:
+ *   Root Complex controls the endpoint eDMA through the shared MW and
+ *   drives reads/writes on behalf of the host.
+ */
+typedef enum {
+	REMOTE_EDMA_UNKNOWN,
+	REMOTE_EDMA_EP,
+	REMOTE_EDMA_RC,
+} remote_edma_mode_t;
+
+struct ntb_edma_info {
+	u32 magic;
+	u32 reg_size;
+	u16 ch_cnt;
+	u64 db_base;
+	u64 ll_rd_phys[NTB_EDMA_TOTAL_CH_NUM];
+};
+
+struct ntb_edma_db {
+	u32 target;
+	u32 db[NTB_EDMA_NOTIFY_MAX_QP];
+};
+
+struct ntb_edma_chans {
+	struct device *dev;
+
+	struct dma_chan *chan[NTB_EDMA_CH_NUM];
+	struct dma_chan *intr_chan;
+
+	unsigned int num_chans;
+	atomic_t cur_chan;
+
+	struct mutex lock;
+};
+
+int ntb_edma_setup_mws(struct ntb_dev *ndev, int mw_index,
+		       unsigned int qp_count, ntb_edma_interrupt_cb_t cb,
+		       void *data);
+int ntb_edma_setup_peer(struct ntb_dev *ndev, int mw_index,
+			unsigned int qp_count);
+void ntb_edma_teardown_mws(struct ntb_dev *ndev);
+void ntb_edma_teardown_peer(struct ntb_dev *ndev);
+int ntb_edma_setup_chans(struct device *dma_dev, struct ntb_edma_chans *edma,
+			 bool remote);
+int ntb_edma_setup_intr_chan(struct device *dma_dev,
+			     struct ntb_edma_chans *edma);
+struct dma_chan *ntb_edma_pick_chan(struct ntb_edma_chans *edma,
+				    unsigned int idx);
+void ntb_edma_teardown_chans(struct ntb_edma_chans *edma);
+int ntb_edma_notify_peer(struct ntb_edma_chans *edma, int qp_num);
+
+#endif
-- 
2.51.0


