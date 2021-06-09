Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3675A3A1943
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jun 2021 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhFIPYV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 11:24:21 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:14421
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235817AbhFIPX5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Jun 2021 11:23:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUArZmtlG8o3BOW6j9ZIlUytZ0MLrK/OWsomveym95//VvjUbVnH+BcWk7Kqzf0os1QokYbt3gnZbsexL3rAqWmVmrmNUZP8rOeTJAoHs0cC/ljLc8XOZWH4Nd5dKh/gu7/ql2COpxL1CIB2EbdtFMh5cLpoEBca59xtVGueDBNEcTdoecH9rFw0LClno3NcIfpKiby6GXU61cfh7mC7Uf/2zZJSFzLyZvJQ2k2T6kyh2fxpbGtSrgfYHXENdS0vDUApi64pwAo49CTe8UOG3egObotO3zc0mxOUxpfhsDtx6E7shdf6ovbUSLv3nNAaRrots4b8cIqbrfSwK81RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rnd5sNBF5S9QcxqBiQw2XbwNsJnjJk+Nbruk9sQAl0=;
 b=JdejN6iZC2WD7txCi/J7Zw0Az1cpmg713e4wf9Zs3T9WcGNv+U8c22VUll/mNBdP8L37xUWdsyJgA4omrp/7jbUff7qoB/vualTu6oGAQ10xOJQmIAaX30DcyATrmhEao9DgQDjhVNECyDbmUwaVlAGilUxG5hLzad3flY25xWWRoTUD2z3VRWTOeq0srAReVcSjcz74uixGvH1KWZuyPgzv1InQ7+JySnTw1jgrI5ap79JtezJtKeiN8cCMp/EjNC1QjONesR2UAQCGht9tmoXnKZu6CYi+9VwJtR1EiXNR3xJS9P4drOk06U/D4l8j6dsQ6yr62IjBdv2kIb0FBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rnd5sNBF5S9QcxqBiQw2XbwNsJnjJk+Nbruk9sQAl0=;
 b=UooagZgwzdRMnzTbEffz1xrFHDCffUu6JkWmQ+h85lE8Up5nO9bHbMKAtFaPoSxSXaRytinaE68AJSUlzDNuk1Jate2NM6awZkRiiaT4FOj/wqi8pckwANdb4I2KG2BGf7pZKYy0kiDJnHwiRIP+EDSMWQdSNZY66xaf1zaVGmw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7629.eurprd06.prod.outlook.com (2603:10a6:102:152::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 15:21:59 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 15:21:59 +0000
Date:   Wed, 9 Jun 2021 17:21:46 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] dmaengine: altera-msgdma: add OF support
Message-ID: <7459635ba093d87b6bf12413cf7cfe09f6e3019b.1623251990.git.olivier.dautricourt@orolia.com>
References: <7487a25cdb240d1be4a8593aa602c3c73d8f5acb.1623251990.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7487a25cdb240d1be4a8593aa602c3c73d8f5acb.1623251990.git.olivier.dautricourt@orolia.com>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: AM0PR06CA0137.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::42) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by AM0PR06CA0137.eurprd06.prod.outlook.com (2603:10a6:208:ab::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 15:21:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85fa09d6-149a-44cb-7378-08d92b5a5369
X-MS-TrafficTypeDiagnostic: PAXPR06MB7629:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB7629FD5D1028C4EF51BE3A378F369@PAXPR06MB7629.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKTTxoIhOWjlVAPt1ULNEXMpr1e4sp2WdCF/yAA2B8S349xy+DpQGV6qhuu4qPDk44zaN3ljjep57Ixpaq6QNI6SBmPoAxxxrzUw2+zE+wh0Ke8tcGnbCZ/l+nHeRt6DMZ/qQDze8noPx4KNV19nM4pREVB8MQh6Obnjz7T/xt7DsEq5pv+beBG5ule/wF1mSPvbtxj2wQsxn+m88ruij+9bpXyl/fNnC9zlON9zAGqqtYKgHZCkya4goBSPvJa/WTjQnZXS6TMnON8jFdt0T07C6H792YC9gnhOYPZzheUE63hSj2iSBH+ZFa2pGVDsxrI32flzOZSufCEduCUHDUXpXE+DFwBApTxFy/b21nejH3Kea6zZofdmhbXh1nrxHMpZTg6XNyOQMFqlBQBLgaGvAMxWkVk1FXSFq0076iiqZ4zOVHVNu9VQ8pLEVElgT/FDb7mmebKKV3EKA5bXFxP5YKO0ygrOTv39fZwqP8stzkHtfRyQic0g2CB9OTdEh8xsg1pHDt3ysW83Jw0PdIRnj2hpBq6kR0ak/A+mJaIUKf3IMsYn1+WL0lJC5ZgeMjlx6NLWrAuyWuS5X6/uXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39850400004)(66556008)(66946007)(66476007)(8936002)(8676002)(478600001)(55016002)(6666004)(83380400001)(8886007)(2616005)(5660300002)(36756003)(7696005)(44832011)(38100700002)(110136005)(16526019)(316002)(186003)(86362001)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3P6aFEbEybrzXhhKK4qXj6u7UeYseAGWy63Pdsrd5C0RX1k6qB2z1r3Q3MdS?=
 =?us-ascii?Q?ROi4nsr4AobwvwyZMQqY9Z1Pcady0e2FJWuT7Z78ejBuSJNS5SqHkw6yXlqM?=
 =?us-ascii?Q?+cJ38uMP67feASA6xy2FpbKM2Ue6+JDiw/4aLy+L6TLR7nUbdy6zSU9+UuND?=
 =?us-ascii?Q?BI9DZ8O+2ke2+pJcjL488U/DgmtaoXrwbSX6AiOd0nHvr+0iGOzbt+VO+CTL?=
 =?us-ascii?Q?V5+wu52fCf8HwbZp0Wa2EgebK1U3DEojgWxQeGG0CQzvRyr+dH4h3mc4A0gZ?=
 =?us-ascii?Q?K3lkibdLgabB3khkmSY0mE+0lrR/aaWIzZWCdN9Ce6jKiXZ160hiPrHBedSG?=
 =?us-ascii?Q?/svzP9C1hOGVQIdycWmYR6jb0nHioo6kDkLTkM83WQhhjG8/Oql8BUWrJH2B?=
 =?us-ascii?Q?L//GC27eYGCxaflaCHuhYBFLq1rts7eEx4Tn7QqDm6ZO4QBSaxEaBVWplR8T?=
 =?us-ascii?Q?cne9bJR2wuyouyX0uXajPu8Bu6fCAx5N7HowLc2TjqaXy9uSuHqTM1wQPOyh?=
 =?us-ascii?Q?RyK8nfNKtBoFnLc91xQ4dlUkhr2qvsMbBeAtJcr38nUsTATOXNXmj2U/HGJ+?=
 =?us-ascii?Q?0yTK/1irtPF95ttGDwU3oy9TBz1q7NnxggmmoyjgFGczZePWhuGz8nkU21Gr?=
 =?us-ascii?Q?3MbBHpNJLGZ9juLLLbNgJ5CQu3bZJkidcNhRV/iEQr0Kjh7qE1exWnuFubmD?=
 =?us-ascii?Q?d6Mz2oa/SBzoBEoYav9x58+Ych6jszLVKHXrBz45UnBeCwh4ob/ZN7B2jLaY?=
 =?us-ascii?Q?VI5cKrML1wgNsliGYKNbM2PUpQZrO/gwCLR3mthi1USd3hWBN3wK8N1t/PGu?=
 =?us-ascii?Q?/YQS09c4Aiow+MTHBORUcJQlnxcsCG284sCSDX8ryQOdYEjdN98BJAp50oqD?=
 =?us-ascii?Q?XlS5PusRHc1rnrM9fqbiYynPlPd3mNUj32rNnw1D9ftE58GR3aZtgODwm1qs?=
 =?us-ascii?Q?64HNpP8Aoub6ENMSeNEDmSQJ9PuqAZcF4Hh10KDsQlytYPFTrA+CfXvUCUFN?=
 =?us-ascii?Q?k9ihS7MtH73E1xiRGIlzD648Z8/Bk7XZQ+rU0q6LSR9NukPC6CWEfV/EJevm?=
 =?us-ascii?Q?u3GQD7quoAOlB6N9VepFMktuCFyLtGXv428ufd/6lQrLXW2Gt4WlkILIb4sZ?=
 =?us-ascii?Q?jMB87kPIt8a/kYvmyvZP+2nEa7RikyDds7eusTR7KGwpdUVyftgiyoP7RQOa?=
 =?us-ascii?Q?UkBdhpj+jzpX97TUi/4rIQBTJfCpw82kwMR8oYMe0R+Dbkjfs5iUDyoGbquG?=
 =?us-ascii?Q?Yn3VW+Bnjz7JXUc9y99DBd+qCci9yvxftSuMkE88EDByj3PrG7KGLOiI4/Sf?=
 =?us-ascii?Q?I3il0zbrQZgh/dQKPXVHd1j59EWJlA7F7mRaD0MACxOu6lkpwr311ASy959G?=
 =?us-ascii?Q?1dwa6sYnfzq9UQAPVhtknw20egsA?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fa09d6-149a-44cb-7378-08d92b5a5369
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:21:59.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6jdgLVFSIWOQx/DPtktPcytYb1r5V38WdLyWYXClKuu5DXy0wLb6uW7iiwNFFwFhbbm6SSxFR03r4A/JXeJQQ5GYXTl/VV5ruF2SLlPtIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7629
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This driver had no device tree support.

- add compatible field "altr,socfpga-msgdma"
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
    v6:
        use of_dma_xlate_by_chan_id and expect the dma cell to be 0 in dt (id of
        the unique channel)
        Check ret value of of_dma_controller_register
    	-EINVAL: non-dt device on OF system
    	0 or -ENODEV: success or non-of system
    	other: fail

        call of_dma_controller_free on dettach :)

 drivers/dma/altera-msgdma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..0fe0676f8e1d 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of_dma.h>

 #include "dmaengine.h"

@@ -888,6 +889,13 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;

+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 of_dma_xlate_by_chan_id, dma_dev);
+	if (ret == -EINVAL)
+		dev_warn(&pdev->dev, "device was not probed from DT");
+	else if (ret && ret != -ENODEV)
+		goto fail;
+
 	dev_notice(&pdev->dev, "Altera mSGDMA driver probe success\n");

 	return 0;
@@ -908,6 +916,8 @@ static int msgdma_remove(struct platform_device *pdev)
 {
 	struct msgdma_device *mdev = platform_get_drvdata(pdev);

+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&mdev->dmadev);
 	msgdma_dev_remove(mdev);

@@ -916,9 +926,19 @@ static int msgdma_remove(struct platform_device *pdev)
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


--
Olivier Dautricourt

