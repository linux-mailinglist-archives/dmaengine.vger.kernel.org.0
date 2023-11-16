Return-Path: <dmaengine+bounces-122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE827EE93F
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 23:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BA02811BF
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2930F88;
	Thu, 16 Nov 2023 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XF0KrzjD"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45359195;
	Thu, 16 Nov 2023 14:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es1LNgLGBjePft6fHRPmqWx8Hc7u+tLOSsNU9x4tHtzvFfged9+n+KaGhR7iT9KOl3ZIMICDef8iA7Ce/3ThmovXWMhqnujCoRC5rM60fX9MMJah+8Tn4fJLVrt4NbTiFMXXqyCELcDD6mCB8gy6pBaSbjm5YJPHiqUqJgzTZp78pZJb64kaCRHxO4zrABA/pMXqLSnbxe0jB1P1S7qwpqz2HE4WM+U+3/BnAAgI4ba7LAaPGmxEHMf64/CgPkAZ2l26sLwHa8vTNMH32dmQBQZsVZiEAMKfKfZvu9iw1hND7/HD/xJzaTA3uMPggAYtd1tYfprpvGEVQgpNKEfirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p71L0//r6YCNnfKOK7C6mFO8tOps2E5l4lDxQGv7yhk=;
 b=k558v+cddFVr3JJ0irnLRKvKw+mUNA98Xk7bqwtaZKwPU6HgNe4Do3scU4Lxm/NsqNEkk+BfpCeWBEzIU2teldUcl/kGcnW4cBD/cRJjesckQ6/yNJU3agf9N9ShACKX2bdfP8ZCbCoIbHku4PVkvY2yFiegWkB4bj42+Ybrzt3/sMnj4bSmpk/y+YQ3VIdVQad9DGfADcZyrg/kWXj9wPft/FNFR67VqqM9pGX6i7+F5lrKSv8VMuMqW5U0lyKRBUe07DI4Y6tiNVF/qANvLPBXRF/0f7LCKC6NHBH8lSD4EbV2VUtr7YR14aKzFASpqAVx5Gz2+JEFo/kthnhpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p71L0//r6YCNnfKOK7C6mFO8tOps2E5l4lDxQGv7yhk=;
 b=XF0KrzjDNgy5CJt+ntlylJijg7M4tC9pRfXyhjK7ltsAVfqQQiSTKNIKt95KaNwrz3wpjvVr3Pmb71eVBwc6/B7TmXjUYgWxbSzQS/nt2/lJF7OGkx5LdaYUJykb1lMO1GQit+i1hJ4167QAzTCc0NVwdaCBMSmt6czG7ZEBnKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 22:28:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf%3]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 22:28:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v2 3/5] dmaengine: mcf-edma: force type conversion for TCD pointer
Date: Thu, 16 Nov 2023 17:27:41 -0500
Message-Id: <20231116222743.2984776-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116222743.2984776-1-Frank.Li@nxp.com>
References: <20231116222743.2984776-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 811e8b8e-7759-43d3-16c9-08dbe6f350a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OBFQ/pXNKRyCRmwTImQhlP0Mw2yLSwbSSYKaRe0kMDlDY0Uo0xglHoKZLTM0A/i5OrnCqvRtZcOuvdz5c+H0QvzTtz+YZ6h1NhNvO56tiz8W9IKDKBvmw7DRKLf0OM/ildkhD93xmj0UpBwSFqBzhkB4f6RyIcb5JShWtpriZ7fanMwJ6PisQEF5zEHz194NXO5zvncRWjsL5F3iFUbUR6NgiJJ8ut+Fg5k7w/Dri/IR/08zcz7GOd+TpW2Hx4O2fvFA+F7hxE7AYhnns1cxc6zwFbfm1hJOrraZBq5GpiruhvYQONLGEa1AAvinOitBil94hL1vgmDCy2Ni6PXqIiEoRilO7Cx/1hHkYqMobE8+I9NQTyXCvmeHlHdvHi0SYpCKeJOjvRkV4NzY1ZFARIPOQEPIQLcr4JGRQXly0lmTXNGavO7tXoFQvOHuPNMOQkHiGkZ0v0qrDglRXwyUNKu0fy878P/K5DsktH6H6dvOECgUefwCVRMRocYf76TAAUZnt0s/dQ/7G8b1SmYGwAAZtLAgGVko13KzErmyCliwyXBmL9mBiEdpBYfHMsaX4dEC7mJpnWGhHz82Z1pxFfjVC7bXTtMRL4AQweGZLfRTRtSx9twA3X2KtJrnmByX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6666004)(2906002)(2616005)(6506007)(5660300002)(52116002)(86362001)(8676002)(4326008)(8936002)(4744005)(6512007)(66476007)(66946007)(66556008)(316002)(41300700001)(83380400001)(38100700002)(26005)(36756003)(38350700005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YWC5klyCuagzWHCFUJChgovmKvGV2VYOgJj6CQfSapm2TyQzjB1eeFPqvmvt?=
 =?us-ascii?Q?zu7ALU/NV+z5FFbl9GKBGozrKja6vXJWAEknpu9Fv4xBTVXOJne9jqbX3PMz?=
 =?us-ascii?Q?1yOZx8BD0fVQttE4zws0X32u2c5Sr8RtNXOSX2ipZwrnJHMzJ9KbbfWOytM+?=
 =?us-ascii?Q?x33pA5tt8LbXz0Qspyuy1XY3US7uUl0UTbNaqiAEROQ70Rik3sXgaNENgtKb?=
 =?us-ascii?Q?FiqCyHt1agzIYDZKxZM1vRW03v/r3cdoQeQPfysD+JXkXaN/lXZJCPU0E3Y/?=
 =?us-ascii?Q?s7j8GNdTNlya+ha/OFnRAkUv2Ks/fbkJYoUDDV29iiV/BWIWZYJLn4QoQxGb?=
 =?us-ascii?Q?q7R/Y6b1GPxOwdIE1SeCxOOcopPumsAES6JfSj5hOXguwQYaHoHmH/BwNwUG?=
 =?us-ascii?Q?zrD3MgLMChIO7kR+8O+Dgu740XXeuEY5RokQ4TjT5TWEO2E8skjlUbde84u1?=
 =?us-ascii?Q?lTWvQlHyV9Dpm4dnTSfvbi0Oo+Bbpt490FLvcnoIH9J2lERPR2imgMEIxcr5?=
 =?us-ascii?Q?p8YCkycHNMnjSDWTOtZi6Xjkv1YD1unyYXpwZ0oW4F1Kxjtj2KCjtigsHMzb?=
 =?us-ascii?Q?RgeeB7u364z0ZI6gjHl9qlOSlYO6gSG3jJqX52WwfQkdd5te8TcxksLQ9PWv?=
 =?us-ascii?Q?or10xWZqUmz7JKS/cQBeXIZ5sMjEKTFv/bOeK0RdxmY2IC9hUpegvKJZnhm9?=
 =?us-ascii?Q?TZWI3v6XaIE/rJXd/VkFK1GiRyqgkJPOg7IrHWLQRL+LoNJI+aQHqb9PZOUM?=
 =?us-ascii?Q?3uT7TLbpATvXInFOY7Q8UsXafTQ9GJfSdFsuTY+pU4OJn2+oBMF9EibjfOJ+?=
 =?us-ascii?Q?fc1jZzQvzDKQMKmV/hYYeqxsBjocXTy7C855PeohsiSWzLAIDj00EZzGWb8E?=
 =?us-ascii?Q?lw1xqXYn0oMzOjkEQb0OEgYD1zjwqflYjBG/ai96Io5VmUQnBZkXbuZzilqA?=
 =?us-ascii?Q?c0taETZkNU9lIUsMmxNwnY0PwLnPfy9L7JqAb69xYO7QY0KEfmutnC4Da5hr?=
 =?us-ascii?Q?tnY844dzpSBOmnDpcPFdOGz/+EXVF2C9gESn3R519gvCBLGRK5EfwskIVs8J?=
 =?us-ascii?Q?8IfNw6RUnhkSh4Pg+Hlzs2f+FAaakGoLvRvR0n08eDod0Sdy54wYDX8OVqWP?=
 =?us-ascii?Q?Dkkie6htWNivSjKQoFG3f9sYHIUqzVsZldV5ZqlrNx1ij4vy32ku2KEM5WWE?=
 =?us-ascii?Q?MaWvrcT5N6myFfK/Hfr5yt2JCeyiz7x9UxW2pcBmbOhBbyQFTbgNoOklhOir?=
 =?us-ascii?Q?5y7+aFsuaHOHKeAsTRm6wgEMTEgNUAW6M9/tHjXBIA3eRnjjMR9WXCccRCjL?=
 =?us-ascii?Q?S5fTUC8NjXT96qB500GrrRLKJFTo88DrxSze9PEdi+QD/IJXxk29gEdqJO3M?=
 =?us-ascii?Q?8BsAZsK2A/D4saT2rGjr7tSYeNfA7ejsIK30bme8GLlL1R8GwtAEBQiZ7GIN?=
 =?us-ascii?Q?y9EFOI8BiB9m5aLFAiXL1kAgqJjMZKPtdDgsbwj+Gvh+vW4QQNUuRjbBb8FB?=
 =?us-ascii?Q?MI0p4wi0FRuldgzEMwMD2B+Cy3pQguGGftXqyzmYSZR7ZI2LuZGN9nqazeKh?=
 =?us-ascii?Q?0jSaTDBbe/I3xzbrpo3N0danHPnCSiwfy6RhSjxu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811e8b8e-7759-43d3-16c9-08dbe6f350a7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:28:11.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW+fCmPteUYF5mutJjXK9QOnYDEn5jnnhLebajlDok4wU7QPFJNFAvAfIvPixhLAdwtxUGbX7aswWtjaa6OFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

The TCD structure undergoes changes, with some fields extending to 64 bits.
When TCD64 is enabled, the type of TCD changes to 'void *' . This addresses
the need to force the type conversion to 'struct fsl_edma_hw_tcd *' at
here.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mcf-edma-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index ab21455d9c3a4..204a0a7bdea35 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -202,7 +202,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
 		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
 				+ i * sizeof(struct fsl_edma_hw_tcd);
-		iowrite32(0x0, &mcf_chan->tcd->csr);
+		iowrite32(0x0, &((struct fsl_edma_hw_tcd *)mcf_chan->tcd)->csr);
 	}
 
 	iowrite32(~0, regs->inth);
-- 
2.34.1


