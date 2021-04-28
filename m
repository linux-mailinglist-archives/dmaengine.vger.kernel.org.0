Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8836E249
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 01:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhD1Xvw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Apr 2021 19:51:52 -0400
Received: from mail-eopbgr90053.outbound.protection.outlook.com ([40.107.9.53]:1894
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229794AbhD1Xvv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Apr 2021 19:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXegaM5pOCGJFnedhWUmrnmALvifx1XiYBDsjTN7T1qQvL3H8YNG06QC9oYHpcosH0FdNyvS6UUHqb759Yp2ZdSuGNU51PAfeMbISS9+mtupWxpx7UfJ5fjfI2IopeclSmVGXzjlkTMkeChr10yyo03q3nIfe0PFgl71+c0oD4GH3fnOt3YkN/b0/zxsraObxgX+n7ZFdQx6h6I5pTCASLkfR4zWv///bfyogFfnBj5KusFzynVjAmFSTzYprxNxLbWnoF7S3b++dj+HVBaVhpoxfUxDrdW45uVwVj3qfMIeNyPNPRxdQKE0BzPUvtig28IpL0OJ6drjO2mQIS0B/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0IX8xIzgAMlnkMvOHmgOQkBdPq0S/Mu39eg6JopCII=;
 b=CZROxxtY76+dwMGGrUi86P0zx+TPN5P1bUMeg8e0a74AmUUsdzWKPV1uEIRTYjF+nfHXCySCLVFemoLJIlPk9tdfaeiV1lrlPypIw13IpcIO675hQWvOvFQj3HsQ2lwiQMn2kDHKtwH5WO8H64T0nCyoBcvas6AXapN3OQBtQO1KuZarTLxMveM2kpw1ZE76IpdGmeBGb4RUDgdLc7S8RVdTlV7nZhg00Jrung2YuFg4osAPdlpQHgLqWGksTKzhPrGq/MS+onnK2Npogju0TgNVUS97/U2PSRoffnHi4NIyqX6tqxEWSHjcXPvo0S7ZBwowyqBpzT4kp325uflCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0IX8xIzgAMlnkMvOHmgOQkBdPq0S/Mu39eg6JopCII=;
 b=PnVoUh2512APHCNKYGlo/2w1HaWPQ+VmznIMK5cYUBVryRfrQwbq0BsVYpgxN4mnwSxBqVQn7YCNGZUKdmCIhyHIORCGao/V8n7X1RYafIb7148auYslxlvtrrjm/g+abDK/CtRgOqc3UcErBvUGL9nCzXxIxiHsupiG+yMxqBA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PR1PR06MB6073.eurprd06.prod.outlook.com (2603:10a6:102:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 23:51:04 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 23:51:03 +0000
Date:   Thu, 29 Apr 2021 01:50:50 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drivers: dma: altera-msgdma: add OF support
Message-ID: <YIn02rUOMrDoBTHx@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::9) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 23:51:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 878a2165-f32f-4e36-7475-08d90aa07bc4
X-MS-TrafficTypeDiagnostic: PR1PR06MB6073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR1PR06MB6073FF82BD8C9E913C2B96FB8F409@PR1PR06MB6073.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/GwD9Zqi9U+iut4uRetBhowjh17MDinUZkrXpBzWF+JL/AX8+qkn8VjdUWIWcynWw+IgHxofDkuDkQ1xEFzwgKnHjbluzKvvbQTBx/9Rc/VCboftwXtq4SH8oj8IbRWKCjrr5orqXE56SOziWTp5yB2K2nhKusZ8MD/Z8cWgOA3f64CXPVrh8OIdlUVcwKLQdaGH5n6OOaVBprI5wFhZPAXQMpaV0CFHU65TM3wcTS4H4t8dnKt8La3D2cz0UJG+hjqxx9JPcDxd2La4EL6YxJu1/RqCP3yOGQdAVCd0SjVIeO+ivL28WP9vCeRQtWhHZi/OWP7enasK1bYmFerXJ4CKexSkIs6HsXdX49ZomDpCkOMKPlCRrOfayewrCOFGvQaGTkaSCfFGMaLQdqqkocr85gJNHfZaTy4T9x9ltepsh/TXMftX6SEee+6iVfeAGXfFu1T+/hQVdt5Ezn0it8Kws3D1I+dfMDzKXPipaC3jMZBlmvt29GnEfybN9Q3DDLzm/O9wguQ/iyAHUvtFkuytA4C7oLqBKWcLAQY35suLkSXPrwN4dyRw1I5S9XIdpFDChmWqfycydWyMjmN179bAI+7OxVrBnF/7fBsn0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39830400003)(376002)(55016002)(8936002)(2616005)(2906002)(83380400001)(66946007)(110136005)(8886007)(5660300002)(478600001)(36756003)(8676002)(6666004)(16526019)(186003)(316002)(38100700002)(44832011)(86362001)(66476007)(66556008)(4326008)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1ZtaDdTaEQzb0JWOTBmZ0dMbUhXQ3ZEbGlvelhIQVFpdGdETVFCSE04UVRx?=
 =?utf-8?B?dDE3elR2OE96ODlxcjV0K0o2Nkd5V3BiQ3FjTnNLeVozdVFONXNmcGNqTzV4?=
 =?utf-8?B?T0FQZEg3VnVFOUFObjhyZ2s1QytzWmxCTzlEb1l0VGFFc2ZVMTM0VXlVL3l0?=
 =?utf-8?B?d1diZkJVR1JuVUJ0QndHTTZwMkF4NmlweTM2K2plSVhnREFWdmJvVURZSUs5?=
 =?utf-8?B?d2dEU1JIQVRNeVlQVEZHdnZvRWNydFJpZHlhNXJMOTMvdjFMWE9jTjBka1lD?=
 =?utf-8?B?M1FLVFdDT0VSMCtJcXp3QXdTQkpwZkdBUDhqZlY0bklJK21Nd0NxcmFldEdC?=
 =?utf-8?B?ZHQybmVDOVZGVnpaOUp1eDZwNTErb211OVlSZEVrZWNUVG1wSERDdnRab0Y3?=
 =?utf-8?B?TTk1bVg5ajFRKzQrdnBUMEM5ZFpwQThHSWZqVWdHOFVyZXQxNkwzdGI1NElD?=
 =?utf-8?B?WW45UWhkM2ZxZWpHM3p1d1VWOGFkT2EwREVqVDRZcTQwQThGc3IybVI5WjRR?=
 =?utf-8?B?M2Jacnpua1d2SHk5YiszdDhHblJFSi9qZEI3eGpVRy8xZ3o3ajBtWmtONWpO?=
 =?utf-8?B?VjB6TE1OT0hycktNS3lneDNZVndySCtIVXJIcXNUQUpHaEdVM3JSbDMzeERV?=
 =?utf-8?B?RHRBWXI5TGs2MWNTK2NxVzJRejAyVUFqaDBTd25iazZoMTAyK2dLN1AwNjR5?=
 =?utf-8?B?eHRoSVpKNFRIa3FYTXJzZjRIUWtXM3pOR2lHcE9UYXlESXN3Mk5WVWZYck1i?=
 =?utf-8?B?ZGpoZXRqN3FSOTYyVzF4emdYSVdjcWs4cEc1R0U2TW83MHY0UnI0c3R4TG9P?=
 =?utf-8?B?aEVYQjlYZS9vQitCaStsd3ZndzFtY3U0dk02RFl5d0pRbE1MZHUzSEVQVmhp?=
 =?utf-8?B?QzNWRmV1ZFhCaGowRmhsQVNnVDIra1ZDcDR3M3ZUTGhPbHFXdWdBUU5UVXlL?=
 =?utf-8?B?d2h1VDR1S0QrVHJGV2dKdFVXUjBtODFxUFJ4Q0tDYlRGRFdRQTUzNE11Nmc3?=
 =?utf-8?B?UFIweVVWN2dYT2xFVG1tSU10eEtMTyt6YitsNDMrWnlYNjB3WXQvMGs5NDEy?=
 =?utf-8?B?ODUwQktiU1B2dmhJK2JrWnlLdk4wWkJLaGhoaXRJMmlmL0wyY2xnSjRGcjRI?=
 =?utf-8?B?enB1dFBzcTBCUmdRRmdhMFhSTnl4bUJBRGNrOGkvSldvaS9CRmFTL0ZlSzZT?=
 =?utf-8?B?alNnUFNwOG5CWWVySk5XK2MxUk1NbEpvZ1plTllUSFV0eWRUZXg0Z21XeFhU?=
 =?utf-8?B?Rk9adGlSSmJOamJTVmpEeG4vZm1oNk1zZXdoYVlMaHpoK2FrV0FqS0xib0Vo?=
 =?utf-8?B?allkMFVwNHNvK1RkdFFQR2ZmUHFuZWdKU0lhdkJ2M3pFaWUxbVAveXlNRVp4?=
 =?utf-8?B?RzBZR3hRR0lVK0w1ckFqVHBwTXBwek1RRzduVmZ4R3ZjWmpmeUxLM3lDWlJl?=
 =?utf-8?B?bSt3OFpoMEducHhvSG1WS3ljTW5wS0kxVmNYVmE0QWRiMUYyMHBtNHBGOUpx?=
 =?utf-8?B?RTBCbzhpWlFnbTcrTC9sSE1QZmJaVDQ0R3VydUFXWVU4ejFmem9ZRGprT2Yz?=
 =?utf-8?B?eHhxTHo4WTFDQVNTL3p2cDBWcE1XVm80alpwMkNSOFc0dnZTUVQ5MkVYMGxZ?=
 =?utf-8?B?dVNuR1pGVmFWVlNSYzNTR3FXTkEwdUx2RG1BYTBFY3F6Mk8rbVFrTFoxN2tX?=
 =?utf-8?B?c3FRWTJTc25SR0dFSkN4ZmRJY1gyUlBLMm55UzIzbmc2RmE4STNvcHdVaVIz?=
 =?utf-8?B?YjJpL3JZcEdGRStITHBESFJnTzVaODZtMGMxd1pmSnFCb3NQT3h3Z2lSRjhi?=
 =?utf-8?B?dGx0V1FkVnRxM0JPaUpoZmZEbncxanhhcVByQUFWdjJrV3FYN3YzczFNTFBo?=
 =?utf-8?Q?qCnpMZYZEUZHJ?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878a2165-f32f-4e36-7475-08d90aa07bc4
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 23:51:03.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lObCogh8FVkHuG96k49E3oZDIVneW6eCrlli5tzfV4w0QwEodT4/Y/+RmyhdDXyLFeHBISeQ+9mmim/IWbZw9efeaGep+9HGrogU6+Ft1Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB6073
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This driver had no device tree support.

- add compatible field "altr,msgdma"
- define msgdma_of_xlate, with no argument
- register dma controller with of_dma_controller_register

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---
 drivers/dma/altera-msgdma.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..2b062d5aa636 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of_dma.h>

 #include "dmaengine.h"

@@ -784,6 +785,16 @@ static int request_and_map(struct platform_device *pdev, const char *name,
 	return 0;
 }

+#ifdef CONFIG_OF
+static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct msgdma_device *d = ofdma->of_dma_data;
+
+	return dma_get_any_slave_channel(&d->dmadev);
+}
+#endif
+
 /**
  * msgdma_probe - Driver probe function
  * @pdev: Pointer to the platform_device structure
@@ -888,6 +899,14 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;

+#ifdef CONFIG_OF
+	ret = of_dma_controller_register(pdev->dev.of_node, msgdma_of_xlate,
+					 mdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register dma controller");
+		goto fail;
+	}
+#endif
 	dev_notice(&pdev->dev, "Altera mSGDMA driver probe success\n");

 	return 0;
@@ -916,9 +935,19 @@ static int msgdma_remove(struct platform_device *pdev)
 	return 0;
 }

+#ifdef CONFIG_OF
+static const struct of_device_id msgdma_match[] = {
+	{ .compatible = "altr,msgdma",},
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

