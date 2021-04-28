Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43C36D79A
	for <lists+dmaengine@lfdr.de>; Wed, 28 Apr 2021 14:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbhD1Mq2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Apr 2021 08:46:28 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:35137
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237717AbhD1Mq1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Apr 2021 08:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7HJk3duwbIhN6yxSamhhPO6B2kncJ2acPISZ9L9IWaNjpUrmQIRvrfhsfnUbU6Efoa2VwnbjfGWmaYR9prOqSb07+4MZY2/SCYdDJoNoTu7O2aD04uZfK+H5Rm9v3nVjRA32JTRDySbAyJ5gEWqYPUc4OnxjO7b9UimQuIVnPJf1R9nlJa1hBdJCnPNolTw4R7Wm4Fg8Z7jTd/l3ldYOBvFb0eiaJKmgaaeRwUlaPM+HRHnU8oFd1pUb/EM8k5g/Gj3XiE9EPAiVG40iV02BilmOc5ZoASq6mRQATyeUzQEzFi4ybuL7qk06bHDB1qtg5xLPo/odnbFsGC1S97ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0IX8xIzgAMlnkMvOHmgOQkBdPq0S/Mu39eg6JopCII=;
 b=EYsUBv9Lp6v5ykL+SXURJS4l3ZCarMRY6YJqiUo0xVEedemISgf+CgHuJr7aTCf6wsItdGoOPgYx4S2dtxMFN/pF8i0Shwr4OCsOSyV2YdJRBNGr/FBBvXaWt+OGSEFTblkq4+yPcjtZ3x2allpMS8VYdD0+ZmbhBFa80Pusk4mHEKkW5EI9w0txeigdujQ0+8IwwNbLS7voOeAK9Bu29UpbnqHpVfHvHmZoF9PetaT/M0CnWQ2xp9IUp0KdP+0APAXjKukdVgkFHByZ/A1uZZ6lPHHPYpLaBcVQmHODnz/SHD0u04Y8MDN32aDAtG+cB6RV+zJizhni3Ci8PSnVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0IX8xIzgAMlnkMvOHmgOQkBdPq0S/Mu39eg6JopCII=;
 b=IEGEYDlG3mf5HdeZhMz9fkggfgrS0nIbPD6lsAJH/LKlMJbv4D3uS6VI5w+uXtULY8234xrqFhvdYTTrmRjPUiUhSE1qEFyMSGImTGrQZyHJkCPwts7SeFE/GifFavqF5u2wk/YYjuSgLnUCripIdn0BDdPmYbAkxMYNiy/YTR0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7805.eurprd06.prod.outlook.com (2603:10a6:102:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 12:45:39 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 12:45:39 +0000
Date:   Wed, 28 Apr 2021 14:45:26 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: dma: altera-msgdma: add OF support
Message-ID: <YIlY5pPg1Zuxy56F@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::25) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P193CA0020.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 12:45:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf644ee-4529-4d10-e1b9-08d90a438712
X-MS-TrafficTypeDiagnostic: PAXPR06MB7805:
X-Microsoft-Antispam-PRVS: <PAXPR06MB7805A17B7AC52364D7449D768F409@PAXPR06MB7805.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFHNw9+vTrkfc3VSn1jugpmG2uiXcI3hMRZTT4rVFo+Z6VVJAFKkveb6TH+cwM6Bbf+YdZbiBNXCrNt94KxKnZTtf0TvtXlgW1MKw2J/BMNofORa8FDk5f1MSdfd6cdrw0OhN3msReaIOBXb/UsWa+Tz9bRSQHSpeqbfZEnvZfcQ8Jb3rJaKV/hqZKwO2PVPN0wmtUZOmQ0jTM4PE8E/xxfAQVSvQ5IuZ+8CMgQZJdsTnY1KYZeWzXPGnQ+jwgZavJkEm+9yBl5WGxo5DKojjVjDw4SNiSaAiYNLgoajrCtkJHVxVKWFGPSeEd+BTC24ME4QZ8LyIMfw9DipTBxkXmOgX6IrqiIMtztQq6WGVwN4wESzoUIyYylMaJ187JhRH2BslaXc9ZPcPhavawG5szpe9fuygqut2A3O/vrjRsehtwhLxXhppQ0e5+5lJ5iUriZRkFFIhibDW+pip255Zu5BrCCaKns1hyCQRujbrYtJzQUVqgVoPhvR4F1F5JDDIlNwIYK43RAJrxBpBL1lAu1jdINa1jO1lj8x6BfkKbVTLtU6srftH45LpBtJKg3zR1J+AzLeb2toPhsusKuDbpf4KYiD3WcWM4WgE3bG5fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(110136005)(4326008)(478600001)(186003)(8936002)(8676002)(7696005)(83380400001)(38100700002)(44832011)(36756003)(316002)(2906002)(16526019)(86362001)(8886007)(2616005)(5660300002)(66556008)(66946007)(66476007)(6666004)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WkR3b005YnFyTjhQTXFUVk1BR3ZEa0JXM21BVEtJSW1CakkxWVFxT2dWZkhr?=
 =?utf-8?B?dUN2QWpkY1ExTUE4RCtHVVJxR1AwcXBKbU1wcWpuaDM4NjlXbUovRzQ5b0lX?=
 =?utf-8?B?S2gvRlBiVVptYnpPYWxQSDRMUzV0MjAyY3FQaDlpLzRkU21wVWltUS80enVq?=
 =?utf-8?B?b1AvNEFzWjJVb1FLejMvN2hRUmwwOWt5TlM4TG1vcDJBYVFjRkZ6VlN3TTkx?=
 =?utf-8?B?NUdBWTdadjExT0traTBPV1pLUjhTUFdSYlhoRkFnNnYrRmM0QnM5RllUeW9G?=
 =?utf-8?B?RWRBNFRvL0NLYlk5b2lhbld5ZlBnUi9ObVVzMGszbzlRU01rSWJSbVNXaTFV?=
 =?utf-8?B?aThSc3M3R2VaZ3VLQzkvL3dYcGlmLzJzMXV2UkNyVVJSYmNoVE1qcEl5d3FS?=
 =?utf-8?B?eUY3Z05NN2ZuOHB2dlU4RzFqNkg1Yjg0NENpL2VXTk5qYjh3UWVyeWhSTUww?=
 =?utf-8?B?V1AzOGlNcm5sZUlnZzNuOHpQSHV6SGdtcmVRcU5NdUhvV2k3MjVjNWlCQ1k0?=
 =?utf-8?B?dk85U2ptbDBxZUZoeFNIVWhJL3c3VVQ3c216V3E1MkhUNlN0ZnBDOXI2cGFU?=
 =?utf-8?B?RStra2VLK00zOEZiOWM3WFgwb3duUVJSaEpiUm13TEthSUt5WnlGZFpsa3d2?=
 =?utf-8?B?NzdZSGRjRStINFRBdUlsNzFaR2g3ODdpOUlFZHhWUElSTDU5Yk41Zjd3VG5j?=
 =?utf-8?B?ZWRzOHp6bU4zemp5czRDTFdIRzdMNmp3THBoWU5vZEdGZS95RzNCdEJLY1ll?=
 =?utf-8?B?NGFPUno4S1ROR21kTm44M0NUSkdHNHdiR2lDTDdPRW4yUjlUNlVMV01ybkc2?=
 =?utf-8?B?MXQzSmZhdmoxRmJnRjdSaHBIUnJCbUtKdlF5NXZDMkk4cGZKUUZLTXA3Z1Bw?=
 =?utf-8?B?SGxObWYwRThTUm8wc0d4U2RMUGw4di9WeXJwR2tocEdqVGkzbEsvdmdzSlFn?=
 =?utf-8?B?bEhEVnYyVG5uU095UG9YU3FjN3Q1bWNDcEwwWjZrNFA3NG1lb1R5QnlzVCs2?=
 =?utf-8?B?WXg0NEsvWnQzY09jbWZQZ3lpRHBMeXcxTjJWUnNxTGgzSDFWbldBTW9DaTB1?=
 =?utf-8?B?ZE5KU1NiU0dqM2xXSitqTVpRa0trNlJHbHVNRlJQR2FyR1E3TWRWTXM3R05k?=
 =?utf-8?B?WG10enYzQkpObEZUbVMxaUdwd3FLdUN5MDIxdzRoZUlhMHN0bllzTXd4NXp5?=
 =?utf-8?B?OVk4eTdqTWE3RHRTMzZyS0lydFJ6S0VKWnY2ZlV3SENMb2ZzbmRKM053Y2Js?=
 =?utf-8?B?allWSVRPei9sYlF5SUFGeEZKVDdxS1ozWVNJR1JDRkVZWFNtcWsxa3lzcXJu?=
 =?utf-8?B?aTJhV2l3MVBRc20vMWhmakdTL1gwaUo3RWtYY2tmeVJMYktHSEZ0NmJxdVV1?=
 =?utf-8?B?b01yall5bGc5ektFblBXVHpNK0NGbzRlSFFjdjg4aHJ6OTRSaFRJdkNEeTZ1?=
 =?utf-8?B?anhaWjduSnJFMlMyanlWd05hem14SXk0c2hBVkpzOUcrd1Fia2FSSnBDL0pS?=
 =?utf-8?B?MFdjN2NHWk56VW1vZTFjaWorL1ZmRUxhbndTbVNna1FYU0g5YitIRkRkUndH?=
 =?utf-8?B?WEZMUkxxZExyRjNMS3FpdWxGNmZCUnBWOHY3SHV3OXdLOXY1OWVmVDBZZFh3?=
 =?utf-8?B?YlhzejdRdm5OWmxNT3FsWkI0TS82RGFwNWpjclBpc2RtQUozTXJIRTVjRWRy?=
 =?utf-8?B?RWFjd0VtSGh3eGx0QUR1SWNQaStHWGlzMkVwaFJMakJXaTJXdTkwbEtyU05m?=
 =?utf-8?B?MnRGWjFQcUhPRkNZTkJ0QTNZK2dwbC9ONmdkTDZ4UGExdDRXY0pjNzNaVjNs?=
 =?utf-8?B?K0U2b085bDFwc3A5UmRhN0ZsVFVvYmZwODRiRjR3WnhITC9MaWQyc2JvVzVs?=
 =?utf-8?Q?gdfftpBoUppsE?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf644ee-4529-4d10-e1b9-08d90a438712
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 12:45:39.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfPuM5MaDyZbofub8siVlHv0HJpby79U98HiiMD5WNHmKMV1VwujIUKyp5FdN1DK8/lI5TBX2IWUx7isATwT0SEkuxUfZ6p4zeuPagavwHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7805
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

