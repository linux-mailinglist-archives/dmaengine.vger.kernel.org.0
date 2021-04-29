Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F1E36E5FE
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhD2Han (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 03:30:43 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:30751
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239259AbhD2Had (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 03:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfYd58N3RzuB9IMVMl5sYomgV4r9jZPFTSGAMo3G0tFQLvQ8FykWTUTE0UBuR8YtM4ws254t6XBF6aUFJEVZHfZVrVE9nJYJ0/jjHWYOBg2ChxIAXqWZPXNfborOnHZCJUEZljv7NApRW87bqIPBmd0pMAEOI23uUADgkOzQoVu85Xza2s9hPoOqE2lQ8t4aBgE4mD5kQ2sB4c5rXXok/ZFYx179Seqbqar4ggAhGupfajEapI51sCToi5Y3dkukCMWKurd1d7nJ2R6Q0u+AzSo6I3vYUqdGJfj//pe4pczEFojQMZIhhk4YvBNUkOuE3/J1r1Iw4HSCBqW736K9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXenXv0aE0GXZlpKqm2uUhHw6PMu1jnT6YkVOjrAvUc=;
 b=YxR4Xnnihde3mcclUWTfo3aPiQJLbgBKajubGaSOWoMXMHHMNIlcVdtvu2V7oN3nKGic2TlTTSjmoEllkEZ11AnfVtSYVCDHLlBOUh8LloN0fE0SuhKhvl09VIB5LV3eBA1pZTjMNP7ucvRz19XkdRY08V3EY54gqfkZ896U/+z/auVuDunzDn0ruZFGRy4AB6xDnwKV6r0x0tS0a8FTJA1lgKCRHluV+xgBv09Zr+x2tmsB95o+Sui/QZBDfE94pFmj/POqK+vzNdEq+qOY/8Jfb6scCjqJGKu5AAHzz5jut/gtEmxSsJZ+f67m9moaBQ3CQP3zAFvLckCFbfyLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXenXv0aE0GXZlpKqm2uUhHw6PMu1jnT6YkVOjrAvUc=;
 b=GS7+t/wX/2wjRHzKptVXOn6hi9XVz/IUALjOEYxhrieqi5NX6/+Dzq4VYOtlrlGp6uLI9MEs1AaCQ+X9y1n503b8i3KE2BxU5mXLws7MkYyw8MV3nv7lLpcdWF/i8ob1K961h86Fe7TRadAxdD9yWn/sUajgmnXh0SFkuy8x4d0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7423.eurprd06.prod.outlook.com (2603:10a6:102:154::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 07:29:33 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 07:29:33 +0000
Date:   Thu, 29 Apr 2021 09:29:20 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drivers: dma: altera-msgdma: add OF support
Message-ID: <YIpgUJ1427/ZFpUD@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3PR09CA0008.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::13) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3PR09CA0008.eurprd09.prod.outlook.com (2603:10a6:102:b7::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9edc8e9-9a6b-4876-98e8-08d90ae088d3
X-MS-TrafficTypeDiagnostic: PAXPR06MB7423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB7423AA4A16DF4ED5956A0E208F5F9@PAXPR06MB7423.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7u0N1SliL0V9B70mXXQFPidWeYNNHVmyKwncegpCmr5vNI0NsjnKk3Xx8Vz6fpVogIWkpf8Aj9Qn10oHDbB5/4adRao1ccudKMQYOAvLIruYSx3FGZEp0pBGYuTZlg+iJ89F1ChupxsP8drZYAi/M3nWcWsMi/oiCECv6NtDluiBm6AplUSgAu8gTPftsEP/BmRE+GG/JICMZ419pyPSRVAx07H934GQcf8hHqmrDvjqGpNCZNEcC60Rxx8EV2zGKxklKQAOjqeVAQpk525GdGKPsWYS+YKHmqAIfTVslGtXSXWJQVPvZ1q7EodqgkZjv+ST5Yn6y3xcAoFuwB6JXJzLEnUz9U/B3US60kWphFV3zXbC6sk4YHW1vRh4z8VzfS8NuIIKaRJNrMzXhCxxm5j47c0IaBjFZjTMDcr/f1t5XkHfZUD2hL/+g0wMWZugp2UD7LBwuYokw/Eas7JZbL8VB7E6H3ttyYeR9Axiy6akhsaFhXkANh56EUQX5La1PSe+wiXxMS+w67t1sGo11SWCN+C9etZcOr9XpeBnMaATTZBUYXq/R6riq8NwpOo0sCcEnFeYuBdigkucTaGJ8KovKpkNgT10Bww1fEhyB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39840400004)(186003)(16526019)(4326008)(8886007)(5660300002)(36756003)(7696005)(8676002)(38100700002)(478600001)(2616005)(55016002)(86362001)(6666004)(44832011)(8936002)(2906002)(66556008)(316002)(66946007)(66476007)(110136005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUJGQVpSNFBoY1FSYXhnUVVvUTFrK3JycXlIK2ZoT2YweFA5c2o0Qlh6Qmdu?=
 =?utf-8?B?WjhmdFV0MUIvVWxGSVViQURoOVpXUUZKbFBSeURaK3orR2RRVkdISmlSREF2?=
 =?utf-8?B?clc0aEtWSEtOZ0d6WnlTM1ZmdlRaQkZVMkpOVVBuUVJsK05hSnFCeUIxbkVi?=
 =?utf-8?B?WEw3VVE5cjhQcjd0K3dad0hYVWNDZzdtOXlLOXI5UDhLTDZVQkdQTW1zbUlZ?=
 =?utf-8?B?bWdQajRmNVVKS2trLzRRUC90eDFySVRRejZKemlmZU9rMlpuYW5wUGlwaDJo?=
 =?utf-8?B?L2ZNQklKV2x0ZUdhVjc3OWdLQVp0YVpLWEpleWx0QTFhdU9kSyttcFpGdElI?=
 =?utf-8?B?bU1pZi9LQktNaVZJTmdBUWhnWEJPZEpaSERlOXZ1d1BPcERuYTBTL0ZOMU85?=
 =?utf-8?B?QnBpb3ZWNjhLRmRPTzU1MlNEL1ZkQ1dwUnJ3WEU1TWF2QkVUOVRrRHpORVFs?=
 =?utf-8?B?RExmZjM3R3RHV0pBZ1B5UGMwNkk4MkFPQXF3VUlSZncrMS9IK1REdlE3aXRI?=
 =?utf-8?B?cE02TzBLYmwvQ2JBN05Kc1JXZU1pVUlwViszUnFxb3J6cHhpNW9mWEc0REtu?=
 =?utf-8?B?ZEN3L05Gei9PQTdQYUpOWGoybHZvdXZmUERTWkZ6ODkzZ1NDZHNYdzdkbUVu?=
 =?utf-8?B?Zy9vKzlqalNJUTEyRFhZZVhEVzVGS01TVEE1WmFoMG9XRStYNGFGMnhvbHJ0?=
 =?utf-8?B?YXJpU0N1cXpmNUc5QjRRclUxdnVqeVhSaUhVb2ppYU1MNHJsS1pOOEcyOW13?=
 =?utf-8?B?ejcvQmNzY1VXQWYvL0ZFSU93VUthdmdPNW4rMUwzcmRQQklDTjRWc2tqdEhq?=
 =?utf-8?B?bmVvQURtOWNYYUdZeU85MHBhMllJdUUvcHdZUGJqQ2xKcDg0N0l6NlpnS2ho?=
 =?utf-8?B?ajMyWUpPcTdvOGxKK09Jb1NmTTR6TU9pSzhlWU1kdmJtTmJoa2w4NjlOZVpW?=
 =?utf-8?B?NGRHNVQ3RFcreGtaVmxmSGdReDdLNysvVWlWQXVUVStoUFcyMTJYN3JGQ2ky?=
 =?utf-8?B?WHI3OXBqa0dSMjFEekIxdXVJd2k1MjhDM3pvZVMrT090QURkbEJyYVRzSFov?=
 =?utf-8?B?cmpmUHQ5RjNRNDI3cHBRLzhFUUUrbTlwRTFTVWw2dFZIVk4yZTA4VGM1RkpF?=
 =?utf-8?B?R3d6dGk1dm9VMjZ3dTZIdG8wYmQvSTUra2NEdXRNOHBGNGNtdTlvS3NSbnB0?=
 =?utf-8?B?dEl2RzR1SkR0T0dIbFFSZ3o2S0pzWlg1Nmplb1JZTTJqbHRtaDJDKzhXdDZu?=
 =?utf-8?B?dElZSURqUVpmZHpoQUlSYUVuM0VnZkp2d2hvYlpQdTZuVFFiWVFLS2xBNTVM?=
 =?utf-8?B?Y1JUektyVGovbmlkSHFDYUNoVCs0dEQvOHFlRzJ5b1dKd0xQbmxyRVpTRG5L?=
 =?utf-8?B?ckZBK2MvU1llUnNieWRQMHFqQ054VnlWR1E0b3NJTUxaZXdYb012aXlaTjlG?=
 =?utf-8?B?ZUl5VzkrZFpoc2lUUWZGWTBRNlY5aHF2cUdvd0VORFdPSjIwVUhneFRZUmF1?=
 =?utf-8?B?bzhSUVhwVW15WGlFQWVUTjVDWWtmL2hQaEpKZjZrSVNxL3FFdkd5bG54YTBB?=
 =?utf-8?B?Q0lFNVBiUEREMTlwUTBnNkdqb3cybGtsVUoyMkxmYStXRXpJenlFOFJrZUFP?=
 =?utf-8?B?YnJZSS83b082KytLaVh3NEVWUExldUl2TmcyRkkzMmVqOVpvMUxvSUpCS0tj?=
 =?utf-8?B?KzVjK3FvbXlZZ0VDVzZBSVVXUi9pTFVtZ0RWZVlTT0poZ2tqa0hBb2UyRmlJ?=
 =?utf-8?B?TktOSDc2UDRWNkRCcldHNXRaTVNlS040Zyt3V2JTaER0QzFob0tzWDlndk0y?=
 =?utf-8?B?ZjZ3bFhhNVpPdzJhSHh1bFJTR3NId0pDT2k4VXZiQnJtNjNmRitUeGtpZkpD?=
 =?utf-8?Q?XesgRoSlTr+/X?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9edc8e9-9a6b-4876-98e8-08d90ae088d3
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:29:33.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk8JJQBVu810cxyBJ0T2I1HM8SEA8Ixa0mrgXYiTmDlaWSFEe40aH63NNpyLBsJjtJZBHGI0Ghb8JibZhF3V++ERAFVqQpS93J4QsPDmGOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7423
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This driver had no device tree support.

- add compatible field "altr,msgdma"
- define msgdma_of_xlate, with no argument
- register dma controller with of_dma_controller_register

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---

Notes:
    Changes in v2:
    	none

    Changes from v2 to v3:
    	Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
    	only once.

 drivers/dma/altera-msgdma.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..5a6eb5b501ad 100644
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
+	return dma_get_any_slave_channel(&d->dmadev);
+}
+
 /**
  * msgdma_probe - Driver probe function
  * @pdev: Pointer to the platform_device structure
@@ -888,6 +897,16 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;

+	if (IS_ENABLED(CONFIG_OF)) {
+		ret = of_dma_controller_register(pdev->dev.of_node,
+						 msgdma_of_xlate, mdev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to register dma controller");
+			goto fail;
+		}
+	}
+
 	dev_notice(&pdev->dev, "Altera mSGDMA driver probe success\n");

 	return 0;
@@ -916,9 +935,17 @@ static int msgdma_remove(struct platform_device *pdev)
 	return 0;
 }

+static const struct of_device_id msgdma_match[] = {
+	{ .compatible = "altr,msgdma",},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, msgdma_match);
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

