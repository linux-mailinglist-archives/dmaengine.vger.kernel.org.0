Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365E36EC3E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbhD2OTV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 10:19:21 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:21180
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237338AbhD2OTQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Apr 2021 10:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA1/sgZ1IMQbNJ0VZFJv1942Z776vDEzMvkxZbwSzL7PuQbljsT9O7aN8FvtOABwW1R1pT7feTNLJvkKqsKe6pOuxXg0TGkbA3r/t51gK4jtWEroLB8JTLmYIu+YAHYIFb/MCA+tkVTLh/T9ebxJWI5axXT49AvJfSsfAJqqoyoyEunJW2+mSKXSBqPeSwNhkjs4hf84NJaLlAjfqKJp4i9RcmtDVb8CthnnG/1aMMtmzpwyd3q7vh6G9udE4j5hvPFTjmE1Kk2SrVzlnqAKpXtuSF3ezX6zSdTnI2dO9TUn+JEZhU3Xo7magHsawNd7I4gSS+tVS9ec2mvi7YWJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ84y2DX4bP9kJgVH7ZJn/krYAvmm/3AvWphpkDgfbE=;
 b=nRZ8a3yCfqwbqJxiqG9lb7PofYuluKs9q/2TjR3zIAgidWBU0s8ovI15TY7wxYWigkDAdEVjMIfW5yekw3UkySe9gTo81JmzuKiDwghzcVo+MypVVunOUUdHeHVvijSSG+R6/h6zZ7Rl3umKjYKJmIB4N9iVgutqBy7LWtU4RFOM6xylCvkFsmLDbisO4LiVRu5G20HMO7+5Ka9fu4GrrRbLIXRIu5Cgesl9hCKC6bqaK+WObULdCXvNEV/wUOa/wJiIwvpCEsqLEXxkl+/1u4/3NfyjuBYWCWa7knfBuRnVCDLZVoaQC/Y6+wlUSDcbIhShd/6iksWhbo6KJW46YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ84y2DX4bP9kJgVH7ZJn/krYAvmm/3AvWphpkDgfbE=;
 b=mVb1ZFhwzBbZU7UhQx8Je1/kHB+8yb3CzSjiXqTNIUJfJcdcmBCB19uSRCj7V7auV6J+ZtrpfzfdJM/bXqgAz9FM5WnDfoycT52VanrhBArZAY0kGPUO8Aavd2ZqluypLdK8nql1xz9eTbW5DhcXf5PBCJPLzBrsE8scwRrb/fw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7645.eurprd06.prod.outlook.com (2603:10a6:102:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 14:18:26 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::246f:58b2:79d6:6aba%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:18:26 +0000
Date:   Thu, 29 Apr 2021 16:18:13 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] drivers: dma: altera-msgdma: add OF support
Message-ID: <YIrAJce3Ej8hNbkA@orolia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: PR3P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::27) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by PR3P193CA0022.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:18:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 156e2156-e255-425d-86d7-08d90b19a794
X-MS-TrafficTypeDiagnostic: PAXPR06MB7645:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB76451819883AD3F5344B987D8F5F9@PAXPR06MB7645.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LyjvoCPHMKrzIrIwpMEbb6F/pR6w2WHVAt64SLeqVtTQIfOo4h2u4r2Xb+PtuCkhL1D46SvYSLfyOby4XhGYoTsx7iCAmzPGKfe8SXOJz5xddd5yFC4zavlKXOb7RaD0WevXHvuogCx7oy7v5+reVEvUeBUgKSh36mbB/55ckSFyEg2RFWlabw/wmSHxyFteNv5QSJiug+dlEBYn8dbrOQHOFnCeMBYplhmrqlIT9BBOMZ5BL0DD6bjGykckSGGW0f0fpTuGfTJJu6Ima+CUvKH26McMVI8khtkfoepBkJyJ5NSvNXjxtOxS8IQD7RxA0wttM+Pad4YXF9PGgtgTBzqPvpADb4nFcevC4s3n8kECB4LOvHQ4nL+D64n2E07QsZWdiaREmmD0NijMxHbwTI2BIErfxzh47hUOHzdHl8jMcT5vKnPXidqb7aM38iTGp+QzZSRsEhF4AAOCGkfP7n+uUnaHkey/lxOY1ih7DwGxxa6eBlhT8ud13l/hxA2oF5zqkQ1SOoo+6oEwYMci4SL/tm/XuY86LBwdgEfxdzyL4a2/mOs9ENSsXxaeQoTBIeAcjkTtHac585T7PMt0IqwRnAN752YUghYx98SfFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(396003)(136003)(366004)(2616005)(6666004)(8936002)(8676002)(16526019)(186003)(2906002)(55016002)(44832011)(316002)(478600001)(8886007)(5660300002)(4326008)(36756003)(66476007)(110136005)(86362001)(7696005)(83380400001)(66556008)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eW9FZzVBRjlvWmNqU0lGY2pwSWpTQk9GelFuVG8yNm9Hc2s3dC90MGttMmow?=
 =?utf-8?B?NUxTUVowZEp5NE53UnJ5UEpYVFdPblNBUWtIUzNZMXFxV1p3V1grTnNLVGVn?=
 =?utf-8?B?YThOUlJSWERITVppcnRhamtzemVFQldWMjJsNFptRlFvU2ZSUGcvVTdTSVpU?=
 =?utf-8?B?WFdYOU53L3Z1NDFYLy9kQWwwZ1lxbnBtK1BSVWgvb09wZFdHaTR0SGFGdzI0?=
 =?utf-8?B?OWxKNGV0VTFVNXd6RjMyNUJvc1RLSElHWU9HZjZWdmE0akE5cVBMN1NVMnNG?=
 =?utf-8?B?YWk5TkF6UlY2eEo5QWJ0MUNyeDJ4MDVGVHlxM1pUMzJLK2t4ZnFqaCtxQ0pW?=
 =?utf-8?B?YXZjbDRteHNTRDJuNFdjREhEVFBiYjRyY2FKdCs0UTRIV3l0UXFXZTk1NGoz?=
 =?utf-8?B?YTh0bUd5aW4vWG9iNGNkN0REWWJlRThOSERURHdEYlF3RzBWSDhCQ2Q4WVhn?=
 =?utf-8?B?UVVhS3ltdnREVXoxVjYvRjhKT3VkT1h3NG9CZGJEMys4RXZ6M3JzTDRMUkVz?=
 =?utf-8?B?ckdqTXIvcEJqK01hV2k4ZTNJU0I5dFM4QXRHTUE4TkJhamFjVXZUVDFzVkZk?=
 =?utf-8?B?V3JScWJwSXg4dXc1SDl0V2tJZFB5WEZ2dHBQS2Z3Wmd1ZkoyUUcyeVMzeEJ5?=
 =?utf-8?B?SkwxSHlqbC91TE5SS3VDQ3RmNWJyYWUvMmJRS1JHQytuZ3ZPVGdDOHJ4MUNy?=
 =?utf-8?B?UnlnZk9zOExncXlJWHA3bnIrbC9BSGtxblo4Vm1XYWR5U2VlZnBqdWhCUTVO?=
 =?utf-8?B?TFlZblg4dmxjRi9JZi9aNDErdFZmOCtDUk5YUVJjbk1MdGJ4KzYzWDE0eGFx?=
 =?utf-8?B?M093QktZK0N5ejh5bUF6dWVPZmowV3JVVGJpeGl6cGh6b3l1bFNFak9nNG9y?=
 =?utf-8?B?QmVGYlJ5elI4YWdPQ2NXUHl0WHo3M2lQSW14TDRvU3JlaHNuTGV3WTBsVi9C?=
 =?utf-8?B?bTlTQklvSVJDZkVSOGtoc2ptZFRUWFFLenMxUVhrVTk2SEVqRDc5K0o5NXpL?=
 =?utf-8?B?MUtxdnNReGhZREpMUnFoV2V0dnZWa2I2ZmlDcGJpRk1OeTE3aDNQMTRsZnZG?=
 =?utf-8?B?MzZYbGlIUjM5WitZRnpWY0Rab2gvdlQzczZHVzdMayt4WTV0czBVSzJXWC9j?=
 =?utf-8?B?S0xDMzlDTFBmdU1zL2N2TUxQZkQ1eERyZUQzWFI1Ly81ZzFFdjEwWTA1RHhr?=
 =?utf-8?B?b093WkFvNGJxaXg1S3FnV3U5Z25pdEFTUVZFRTFTaUU1NldhbklucmNnL21N?=
 =?utf-8?B?VGNVaXgxMUNOVjBHTFdtMm9UakQ4Vi95L0phUTFlUElNOXJEN1hkWHF0WXRn?=
 =?utf-8?B?N2R3OUlnaFlmYVU0SkY0cXZFVGZiSHlSSFhDNXFSd0toV29yQUF1SVhFTHJy?=
 =?utf-8?B?RUFLY0tBWm1NUFNKWlZDOGFOYUcwNUU2VHJSbVZDbkw3MFp0cmk0YjlyWDRR?=
 =?utf-8?B?NVU0TGtKTmZxa1pzWlFDK2J3WDFvS3RSd0tBSVIxNzBtOC80S0x4VjdEdFNs?=
 =?utf-8?B?TURNMXVCaWRUcnY2N3Z6aVJmY2RqUWJYNnBBZzIyTytJdldEOXdseFdHZmxm?=
 =?utf-8?B?ZW5JTmpycllmNXdzM2JlWXR4N3RWdythL0NaNVpZT0MyNmREMzlmbVhPbkVt?=
 =?utf-8?B?Y3dBL3lKTmZBTzVhNmZHYWFJNHdPOCtJditIM01nZTM0SE9XOTNaSWRzckFE?=
 =?utf-8?B?aFBlK2hlTG1hUndNNmo5THBoaWg1dDY4NnRvY0hxVVBTOVBKSEtld3B4eUNP?=
 =?utf-8?B?OGFENm5Od1c0RTVsSS9VeGRRUVR2MjZsNzMyUjlUNkt4dDFMcFBhcklPTmln?=
 =?utf-8?B?Y0UzSXFwU2ZBUC9tKytLZVNkeVBSMWZmUE5peWRDMERveTAwZFRuSHBCcVdP?=
 =?utf-8?Q?L2i4tqM7zDCUY?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156e2156-e255-425d-86d7-08d90b19a794
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:18:26.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM+8xY+8VUUEqU3jm1URVAX/iuV1PNo9J+vtWnz96cudzTB7QjKEWixngHK2tyuUSsGg3APVwtdMh32pNXPKgbDDoT2VAmGTcCgpdzj7PE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7645
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

    Changes from v3 to v4
    	Reintroduce #ifdef CONFIG_OF for msgdma_match
    	as it produces a unused variable warning

 drivers/dma/altera-msgdma.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..7e58385facef 100644
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

