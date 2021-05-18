Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D956A3879DE
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349561AbhERN1J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 09:27:09 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:49123
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244483AbhERN1G (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 May 2021 09:27:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J32mF+hNRRpYduiCb9y34MbtxVyKsmjOkrLS0RLPcdxpD/oQeRK8NskUoPIrSo7rdLykydZ9NKw0Qm+wjqODSTiCYLiRHp2kb49Ly8OBFHeDTStqdSUqYTeCjZ/sD5f/Uj9SHfvIi/ZXDQK08QzxsTLe0mYs9XcTaEzr3vXdxz1pvq3io9+qMWqYD6kAi8YgR5uOtCOjEUutVSpo3FGHetK1A2NQrXabzqCpQjqwqTgOB+5bYlEpDJiY03z7CGoIFKlIU9qV7Ez39/DCvnrDHkb5tcoxykXkaa5Nyz91XWVt5YXedcu1jaKj6J1vPUjzmGF9gT6SeHWoiB28bObsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtQpf0avNAMZsCvYKNv6eXa6zRAUCsVEAGdIO3CPzfc=;
 b=S3Vg35Hm3N4RHeiqccQWnDIBefI8vM1L0Xam2HWlLXiZmKOBeBKeqJgsH1ryhSV7xNuWYFph3tZGv5RN1EPGowGJdA+7mb7dhpgeb2gxyUVtzlcPZ3alOe0d2XPbU74Ltflir8KWhKdRHvS39XzOtReOSQlE2nLwx8a5190Id2803J8x2mGMSBGwCKWp6EsZ5Lwx68Ke1rZXyIxHjM+lNhUJOHzxrvwTC0YNmm+az34IH/W9dpww+JPR3YRhslWihDLUUlLZSEABrzQKEIDHaVLDIBkkNGcw4AjGtbd81tyfhf8tZpqB3564HONVyPi9nbSCHQrU0onqVTkI6QtXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtQpf0avNAMZsCvYKNv6eXa6zRAUCsVEAGdIO3CPzfc=;
 b=IizmXhL9CfkVzyYclFecVXtXvHZ/gtJllfSos38grbvsloJ8ypy27ydU5KR3gRIMFYXXMBxYYsYfOr5kESCjsmZxJzQ/vzIxyvF5TA929CEnWSRitRnSZeJwYaultD2BIDFD06iBOFdtPqcmU97er8CZddUi8GiMO1tEy05d6nI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR3PR06MB6715.eurprd06.prod.outlook.com (2603:10a6:102:65::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 13:25:46 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%6]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 13:25:46 +0000
Date:   Tue, 18 May 2021 15:25:32 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] dmaengine: altera-msgdma: add OF support
Message-ID: <088a373c92bdee6e24da771c1ae2e4ed0887c0d7.1621343877.git.olivier.dautricourt@orolia.com>
References: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PAYP264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::16) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PAYP264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 13:25:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c601982b-8f04-4c5b-e742-08d91a0071e6
X-MS-TrafficTypeDiagnostic: PR3PR06MB6715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR06MB67154F86711AAA5A8AD923198F2C9@PR3PR06MB6715.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwasrRSWYzLp+b01tvnISbBxvPf2sT8L1Piv4ejwvhnyqjXGF7Ook2f1ph1YY1T9zpsGITK501x5fQWzPIF9NTDUvL6nMlQ6nfkamMqmtlZ2X4WjWwmVicFOAvCFPuJbvqarZ9l0WFF8rKGUs/kqEhA/Njeu+WsYFusDJcL5yHbfX+z9THeiMpSUhHeXxjnYz0l2wCmFbv+0hDM1SrjmqkDePg0QTIN0SQPUQRmecHCEteHFJ2iQiwpd05VmRGoGmCBYlMZfza5tAPp97hPTd0yJJjpHGfgGg3hDo/1lYpyQRahGh7vvDzg4AMmVcxoLUbK9BZeMczci3SVlvnH6JMzmaGwPGlKw2NWrJKqfivnZ3T7PVU9TWmuO/j76mzz3hlNZrd/Wtf+6x+vR4LQdjG/pLhM5PygQ2IeHq9P7eXLTHUhb2KLufEraMoiXGju4bOs8QZ07mjAg/hl+HUyN73XuJNnkpXWZoqecug6QBcdzPuVZG9R6wCDOwCXKBzdyhJAZ1ZwBsWx9LAlbHnqNamT44gmA1duv3+YArSwWnhRCjw6aHJppxSeejyy6hrln656h012owCmPLURd14DPb92GXukPNsEseYTRsJ7UYtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(366004)(376002)(396003)(83380400001)(6666004)(478600001)(66556008)(66476007)(36756003)(66946007)(2906002)(8886007)(7696005)(110136005)(2616005)(44832011)(4326008)(186003)(316002)(55016002)(8936002)(16526019)(86362001)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hV6Kn7SUaD4re4kBs7G2DEPtZVvarNRdkOIrQDPi3RlVQhoq5lLut9ECKLJ3?=
 =?us-ascii?Q?vvWt0eB0KVfhHy33aJhaprDWW1vReygl/BUF9XNge553Po8y67eABbNXbMif?=
 =?us-ascii?Q?HtgLIasrMn7tkxQFOC43GKmAS3HD4Hs4s8SjdW96xQyMu1IIujUsSiJFEm0G?=
 =?us-ascii?Q?+jtQ6qHJxej0owP82vzpPzb+POlfYoAXWdC+czznPORHPlglZ0Ax4DR52RXR?=
 =?us-ascii?Q?XpbUGbRYocRpqOa+eMCNz/UwcvfsFlgyFS2g/tNOGr3VeUBVVCK+z0lQt9hG?=
 =?us-ascii?Q?+ddNl4idlExWzycfSVa+ip2x0b8c2jIqLeKDLaCkfJ+85f78HUvAuEKStxwN?=
 =?us-ascii?Q?+kQ2amMlQzweHjuUfuC5/ry6+TQnM3OjlqJFhbn09TBm6zQTH7xm2X1Dk8vw?=
 =?us-ascii?Q?yVBY6+VEZtxf26ey/7OVzu76XjWjAXa9kt6i73c8Wrb9aiXSa3RWpteCiBSE?=
 =?us-ascii?Q?PDYxqZk6t8NaeDFVQLQQDV9xVh+JYmcs5Qa75K19SpjQ9PjTtnl4beXmRhDE?=
 =?us-ascii?Q?1OGaB1A74A8tScLIcbj11RuTchgCuY4l8VwqHOHypzJKYAv+/DDKCi+g6ZHP?=
 =?us-ascii?Q?NMKYqrQaGLlOgDYW/rk7OWnnV1xKyvz1J2fuedb7ZcHOzSeafo+/+pdcB2VR?=
 =?us-ascii?Q?xvPL/8HiGr8d3Fjm+iUT4pJg6du8+XF8nPRQEOijEHNzh8Kukou9Qj6plkxL?=
 =?us-ascii?Q?LhpJJArEvI4HaWuk1prbYEH9bMy3bWtmL4UH90V8FCMR4sOp//L1IGehNpbO?=
 =?us-ascii?Q?GlHYAZy3KggVMXh/fvekbUgDQXKZwSf8/GpRL7xNFBC1POp/TAi6+lyJl9Ym?=
 =?us-ascii?Q?8chBNlNDOfaMMZZlZabjTN68dU/gNTbFwwUjZTBTxNCg6OhIt/M/BK/PiOCr?=
 =?us-ascii?Q?ApuJoR2yZfcNJFdx5N5QQtX2iacLYm6Y03//rL9PdpkzKMU0i00vFzJyU5Ko?=
 =?us-ascii?Q?ieim+i6YVY8nKX75Z8tZqN6ry8vxKcYS0lH88UKxtJu9PTEXqg0tMaFb9kF8?=
 =?us-ascii?Q?LD2gt6w913hNzYC8Nigru2GxSjWRnDbXwGYoOvSAGgkrJ8b5gz7mLtpDBWZu?=
 =?us-ascii?Q?WBPIisJZCcpiAOoZcSw8k7IAv41wzJKPHPGNZhL4wqKdWh4PcUxQLveew10P?=
 =?us-ascii?Q?CGXXBICh6VdSy9d+AfbzYF2xHcbE9Rsje1uwNgFRQdEF7oDvMvQG3b9zCEgk?=
 =?us-ascii?Q?vyeau/CtrtNqJ7JjRcj52Bqn/1Rp1+RZnRvaBInlwGKoUVpV2V03SbrrJObo?=
 =?us-ascii?Q?EVSE9/Kw54T0mfUUUwMZRYXverC+hAv1pQyptvjFd52GZFrjwvrmR0VybP1R?=
 =?us-ascii?Q?SXD/n++xUT0n7usXGU4T7/TSSqZdLRcz3xeQ8lu3DgPCt0ORENa6Fls1UzQg?=
 =?us-ascii?Q?CoJWGwddLp4A4fxJeHJBqjuO42Wt?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c601982b-8f04-4c5b-e742-08d91a0071e6
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 13:25:46.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8MnRHio10zn9ee0dFQhotmAIn+3OKQbsGS20Ad4okakPFDjTToT0JSi2RWbuF7V5uHGF8jUd9iMh5FZCWrsPyI0YuYpCIoT1nJEKOs6IBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6715
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This driver had no device tree support.

- add compatible field "altr,socfpga-msgdma"
- define msgdma_of_xlate, with no argument
- register dma controller with of_dma_controller_register

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---

Notes:
    Changes in v2:
        none

    Changes from v2 to v3:
        Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
        only once.

    Changes from v3 to v4
        Reintroduce #ifdef CONFIG_OF for msgdma_match
        as it produces a unused variable warning

    Changes from v4 to v5
        - As per Rob's comments on patch 1/2:
          change compatible field from altr,msgdma to
          altr,socfpga-msgdma.
        - change commit title to fit previous commits naming
        - As per Vinod's comments:
          - use dma_get_slave_channel instead of dma_get_any_slave_channel which
            makes more sense.
          - remove if (IS_ENABLED(CONFIG_OF)) for of_dma_controller_register
            as it is taken care by the core

 drivers/dma/altera-msgdma.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..acf0990d73ae 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of_dma.h>

 #include "dmaengine.h"

@@ -784,6 +785,14 @@ static int request_and_map(struct platform_device *pdev, const char *name,
 	return 0;
 }

+static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct msgdma_device *d = ofdma->of_dma_data;
+
+	return dma_get_slave_channel(&d->dmachan);
+}
+
 /**
  * msgdma_probe - Driver probe function
  * @pdev: Pointer to the platform_device structure
@@ -888,6 +897,13 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;

+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 msgdma_of_xlate, mdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register dma controller");
+		goto fail;
+	}
+
 	dev_notice(&pdev->dev, "Altera mSGDMA driver probe success\n");

 	return 0;
@@ -916,9 +932,19 @@ static int msgdma_remove(struct platform_device *pdev)
 	return 0;
 }

+#ifdef CONFIG_OF
+static const struct of_device_id msgdma_match[] = {
+	{ .compatible = "altr,socfpga-msgdma", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, msgdma_match);
+#endif
+
 static struct platform_driver msgdma_driver = {
 	.driver = {
 		.name = "altera-msgdma",
+		.of_match_table = of_match_ptr(msgdma_match),
 	},
 	.probe = msgdma_probe,
 	.remove = msgdma_remove,
--
2.31.0.rc2

