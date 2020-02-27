Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89A170FAA
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2020 05:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgB0Ebl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 23:31:41 -0500
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:6187
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728221AbgB0Ebk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Feb 2020 23:31:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4M3UiT+YM5Intam3IwD5vHWKhYjwnux/ExNfZKnlQvH1PbRD65hF/1W886Sqms9C6G6u8LBmaN4bVIY970vrtTj+3Cb8zQ1I5mA8fOHS4adci5rVh3QjVgFKuc0XRxlqA5S9N3MMbINZqS5Fgpz7ceD+ydKRpdQRMJuOU0Q3QhvKHwEGs8mmfePEBY7HznlSTmjsNhOj0M53r+T6132DQ4x4ReArVFbdKWm/8M25UXvK4c0A67Cftcyt+bmwPRsyucRT/BIkNWCzh0FAJjbEGWL9AaQXaAIFeKrERi5azZ/UEGsl6t0dZioELDW3TfuWojEEQdJ57uKF9G0EZV+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/KYc+1Aaz4A2WCEIWsEwkh1y5okitHp6hhClW0favg=;
 b=M27x6P/B3TCqexgaul+tuTNLxK9zV4y+8KLZYyT1yMgeYZg+RwZdt4GIBT2TRDceQimpKDQgtG5jzhkLA+L2LsgTepYJcCSv4lzarhVHXdra+lpn/gOnNMdUB3E2sZXmSoplPKeZ/wpx0EIrD6BDTFLorb5+hugew3O6CwrsYn7e36qD+yOVDDx1IbvgwVW/rpkXXYdIxFhYvAl/Ac1G/45IPpdw0R1A9f7riAGRG88NoCA5xedJ4Sbo+1LvX9BHY7R0mjKw4gPdWK9DQYhdgy7ECj9nXL1uhkbjOHpqDK0WctDSB9xI6pFXRTytjGNciiMCPLbqQiCZGOUGs1dohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/KYc+1Aaz4A2WCEIWsEwkh1y5okitHp6hhClW0favg=;
 b=fOwe1dq6Q6SLGitoAmzvhuOPZBu3OVYqCcOLHN4OyQl2n1+7RewLtDKihH3dTK5Y8JKoUyPSeyEiZm4AaNBX9uMtCJPrnAXeWT1HR+BShHcICwHbFRv4Wz5xY7hx+R4R+rUk2d30WWGo9NUPXyVi4qDyZV7hkbx4FaSjoifgTHQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB3006.eurprd04.prod.outlook.com (10.170.226.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 04:31:36 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::10f0:dc6d:c9f9:edfc]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::10f0:dc6d:c9f9:edfc%5]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 04:31:35 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     natechancellor@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] dmaengine: fsl-dpaa2-qdma: Adding shutdown hook
Date:   Thu, 27 Feb 2020 12:28:41 +0800
Message-Id: <20200227042841.18358-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 VI1PR04MB4431.eurprd04.prod.outlook.com (2603:10a6:803:6f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.3 via Frontend Transport; Thu, 27 Feb 2020 04:31:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ece945fa-29a7-4a89-be6f-08d7bb3dedf2
X-MS-TrafficTypeDiagnostic: VI1PR04MB3006:|VI1PR04MB3006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB30065ECBCFC08C9C62189831EDEB0@VI1PR04MB3006.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(199004)(189003)(1076003)(6512007)(26005)(6506007)(2616005)(52116002)(8936002)(44832011)(81156014)(81166006)(86362001)(6666004)(8676002)(69590400006)(36756003)(478600001)(6486002)(956004)(316002)(66476007)(5660300002)(16526019)(66556008)(4326008)(66946007)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3006;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2asagvhXpivzRjdAy07yAkds1PedvsiZE2enAC9MpZhwjaCUFCDARApS8ARh7f59XVDw6ponIu+9KLfErnj+4OoGpWmBJAUETGqjrsbu7o5glM38KlIhifi7St9Zd+24SEV2n93aXP3605AsIMTts5pyn/B9O7fYTEpa9ONmEjt9OtaT96yyfrp6ykAKC0adlWBkcHHVZzwADp+M/iziS57PSVq32gwj8kvqkrEKfrrCQMibsN9ou4ZUNheu+WC8CUW8ew1P4Lf9U8w9mES94kv/xoR7qNqdEF6xhnCxbXll+FcK1jfz1rhlQC1fg/ptMoGg0qKX7OwpVYrOe+59REfIKMIDEbq93Hny0aZ6s4JWOyL2DCLtt0tFLE5OsTEUQ9lbANjT/U4X0KOUX2CqUj43LpJjYWMfPgBfu2Bh78wRlwlGWdZcqfjEQn78Skkmlquug/QQaUvYuTdbbQ9QsLrrusmBvWcmd5BTGimMoMcsPkfXNK6cyvNWkwnXuW82zVa6MnEbQd0L0AaVExYsxe6PzXCDiSi22M3LTCEMZs8=
X-MS-Exchange-AntiSpam-MessageData: yvUHAjGZrUoa6BjHa9+GJgCtClSyIvY2bl8jgSUXxAASqqeST0UDPxDNCq8MQLuxjP89ckvUbmQYEFknrC+17+x10ZqMqQ2OSyTJMhyrUgq+0pTeNNLQhB//o7yw+YgzIFfkuvkW+HMrJvu5SpFeFg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece945fa-29a7-4a89-be6f-08d7bb3dedf2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 04:31:35.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jDQ6F+y7Rzt2zNybts9tkG6cH63tzuSTHdNlWfvXzxSxAPC4/PfyKTYXL9mQA9+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3006
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We need to ensure DMA engine could be stopped in order for kexec
to start the next kernel.
So add the shutdown operation support.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 17 +++++++++++++++++
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c     | 21 +++++++++++++++++++++
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h     |  2 ++
 3 files changed, 40 insertions(+)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index c70a7965f140..fabbbb90b2c7 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -790,6 +790,22 @@ static int dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
 	return 0;
 }
 
+static void dpaa2_qdma_shutdown(struct fsl_mc_device *ls_dev)
+{
+	struct dpaa2_qdma_engine *dpaa2_qdma;
+	struct dpaa2_qdma_priv *priv;
+	struct device *dev;
+
+	dev = &ls_dev->dev;
+	priv = dev_get_drvdata(dev);
+	dpaa2_qdma = priv->dpaa2_qdma;
+
+	dpdmai_disable(priv->mc_io, 0, ls_dev->mc_handle);
+	dpaa2_dpdmai_dpio_unbind(priv);
+	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
+	dpdmai_destroy(priv->mc_io, 0, ls_dev->mc_handle);
+}
+
 static const struct fsl_mc_device_id dpaa2_qdma_id_table[] = {
 	{
 		.vendor = FSL_MC_VENDOR_FREESCALE,
@@ -805,6 +821,7 @@ static struct fsl_mc_driver dpaa2_qdma_driver = {
 	},
 	.probe          = dpaa2_qdma_probe,
 	.remove		= dpaa2_qdma_remove,
+	.shutdown	= dpaa2_qdma_shutdown,
 	.match_id_table	= dpaa2_qdma_id_table
 };
 
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index f8d22115154a..878662aaa1c2 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -159,6 +159,27 @@ int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
 	return 0;
 }
 
+/**
+ * dpdmai_destroy() - Destroy the DPDMAI object and release all its resources.
+ * @mc_io:      Pointer to MC portal's I/O object
+ * @cmd_flags:  Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:      Token of DPDMAI object
+ *
+ * Return:      '0' on Success; error code otherwise.
+ */
+int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DESTROY,
+					  cmd_flags, token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+EXPORT_SYMBOL_GPL(dpdmai_destroy);
+
 /**
  * dpdmai_enable() - Enable the DPDMAI, allow sending and receiving frames.
  * @mc_io:	Pointer to MC portal's I/O object
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
index 6d785093da8e..b13b9bf0c003 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
@@ -18,6 +18,7 @@
 #define DPDMAI_CMDID_CLOSE		DPDMAI_CMDID_FORMAT(0x800)
 #define DPDMAI_CMDID_OPEN               DPDMAI_CMDID_FORMAT(0x80E)
 #define DPDMAI_CMDID_CREATE             DPDMAI_CMDID_FORMAT(0x90E)
+#define DPDMAI_CMDID_DESTROY            DPDMAI_CMDID_FORMAT(0x900)
 
 #define DPDMAI_CMDID_ENABLE             DPDMAI_CMDID_FORMAT(0x002)
 #define DPDMAI_CMDID_DISABLE            DPDMAI_CMDID_FORMAT(0x003)
@@ -160,6 +161,7 @@ struct dpdmai_rx_queue_attr {
 int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
 		int dpdmai_id, u16 *token);
 int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
+int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
 int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
 		  const struct dpdmai_cfg *cfg, u16 *token);
 int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
-- 
2.17.1

