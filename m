Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B1517B77
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiECBM1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiECBMT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:12:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2403FDBE;
        Mon,  2 May 2022 18:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTfLKsXeMIJZnUhwZfrVzQa3egAjnDXQqmo/ZaTyxnp1WPi4BLqrJjO0GqAVfc9ndZRIDQByXF3AdCSeUSwJhAPmpw77DLWS1IYxqX60hxAqu1FgXIAoMYpvaUH0oxIotOAKfBNykXoWyBxfNifjTunjc/uCAJToi1qesa+9Wbvzn69yMHCevZJp2xGIQP8IOfN+zR4HeynmtRIKlBgXVY5KcfgagZS14s6LEte3H4On1VJr8k/eR7eSqNejBcAWU/Z3vPKY5bRtXq3vUnMsM5PLRJJzwq6RJncSEIf1CNIOr/w9keaafrKeoTDd+QtRVhUULFUAjuXuo5ZsplQx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ykW5pAix36l4RRsrqzAHO0ieyzdKcQpoUlgOJnyQQI=;
 b=fxdy/vTJ7FOchSXeSJdfDbpTYN/bmdBldFXhaaAAX0FhLkGU7k4XDKIuNAcUxDehUkJ5xoBNhtkV2py71DzToGm5XIcuMyRUo6H/WGYlxyC/fJsI/7YBRfu2+sTFdABk/RedYSbYJedh4FKKrWYnJZxK5k/EytLVOAthJ2rlQP+p7uZj+5ffMIn6kCW4gBvdvTxTZXsyHS6JANgL3R/vavyUYhHSLLaijgpL+eqf8uxebSMJH5pjNe5WP1Bgi2w7dYIUtzgkywqReikRs6+8RnivzCALhilg1H8z9jmY05+GQPu6HmK9PqS0597i4grxyi8gXdEeDkgKQvTsr8rNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ykW5pAix36l4RRsrqzAHO0ieyzdKcQpoUlgOJnyQQI=;
 b=CVlFt3w2Z0DbrRCbOzdAJUPwfdPjeqC/QY3hI3NO4VqcbOzMBPto6Nsf5e/0acDxHZ4fsj5gyWpKXOZuV4ZCsAegLVpx6LYVb3MLNKDH+i3HyG0AMzPBtXlcfdRj+xDtIuv7sCMlL+pshPaNHNR3nqYcy+lJKq8vgH05Hraxn8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB4431.eurprd04.prod.outlook.com (2603:10a6:803:6f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 00:58:57 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 9/9] PCI: endpoint: Enable DMA controller tests for endpoints with DMA capabilities
Date:   Mon,  2 May 2022 19:58:01 -0500
Message-Id: <20220503005801.1714345-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68bdb19c-1a58-4d13-d6ee-08da2ca01a01
X-MS-TrafficTypeDiagnostic: VI1PR04MB4431:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4431813401D4F8357E1EA78F88C09@VI1PR04MB4431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8oUDmoaeNwqFuJHMpI3zXYnqDgYjm0nKp90+xw1pDusgt1wmtTKCscGYokYLrrGq0SQzMcFXNBGmlzVM+3xHLB4zKZjiOhRkkuydYiuhA5nPzviFA8Z9qIvpM8hZ+wq5GYT/DiqN10UU4yo2SamWzRtZ7g+S21s9xGVVc4iJG5Df7Eps4JWJ5VExmXU1yW+Yxsh9zQzEPEqcqsVhci9bAe6GSzy7K1V5c86rXzfnSxf6WyUYDel7Vj1RvpOI+cllsZg8+n9X8HqOoxcz+TeKcpnjJpYFFZRC68pqO/gw3lzL8fWD6U7c7ur36DpH96R/0x/vC9yU4lCLurPVgMxHVU42PHzjtALbT0LhLiqo5wB1ZVc8MnzvwhYbF7mdGoBZaV/4vYKdjrFj5qbWfCvo1SpKYM3ZZR3sG6oXu28l4uDYdt876xmyW0TK4BOpytY1yD/2iSiwlbfuadpqBCdSdO/Wq668uGbooGseYelQgF3nQgKNZ4WnGPDrTfDa2U9rAKEEES219I8QBzqk0BCZvStyjHpsXV5nUQ9nZUevYm1RVQsiJ7w86drejNpvcCaisLMRIUObFM9CSFhuh6roeS6sfq1MMCwltwrdlnkBedpNWfZJNg5LMmHocC/pOhJoWf+Y94qP+Y+WlLKug3X4i9+T7PLMIAAKPHAOnHJZGvEE4qb0799JSxc4ZwvYLE64VXMVRpzuwKx9gmCvyAeOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(7416002)(83380400001)(6486002)(66476007)(8936002)(66946007)(86362001)(66556008)(4326008)(5660300002)(508600001)(2616005)(38350700002)(6666004)(26005)(316002)(186003)(6506007)(1076003)(6512007)(2906002)(52116002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wd/kf/mS6a66hWbAi+29gCweIGMW4yirsC1Ubu9wqXmNdOeD5i0tj7WoEH/B?=
 =?us-ascii?Q?491olIXEDO4IgvXd1EsJwh5/0+cvAD14TuNkICIttm2Ho3K8CwMfUdScoyOa?=
 =?us-ascii?Q?DYHvis1ImTQsPaVGWUkcUfYMOvKAEHnXbYX8hL055JBfoNLGVTBncnKQkSPD?=
 =?us-ascii?Q?xlQo4SVhOTkcwC6fYbvnAdJABNVZCyryMG+gcX/hwqAO8SgSXECJw6eIdQ4M?=
 =?us-ascii?Q?cO6IdmXagalQBTScpKfi3siJENBZWVLZ6ZCUGX5rJKkfqfQh1du7SrimFgOh?=
 =?us-ascii?Q?eg7UN+KmBdk4Rs0XDGXkP+UioJpr9fDUW1LbQCz/N3J7N+twdEPB3DmpEpL8?=
 =?us-ascii?Q?jKHOIz0M+sWewvyy2w6Kx0HbX0h9FQKmappQIAgSw2nD7pRfs4vi0kV4DKo7?=
 =?us-ascii?Q?luU7VPl9lvQnGFBPpX2RcGCav/XPBhT63y/I42k3x62Fe6ev+qqW/Y1q5WXL?=
 =?us-ascii?Q?pXvnXGBOH/JnnnxlleFLztkbx6COMq6QJGtm3nhZteubgU1XhwMwNQQs2cqa?=
 =?us-ascii?Q?5bptqLB/fWelilJ9m0tSnG1K3EnWxsG8YUE+5THTBxjoOmeQc+MCAS0k1ZMQ?=
 =?us-ascii?Q?Mv4Wk6RCL4O4z8FQE+TZU2Wal57kVSZKRttGAYd4rezSyHPR0ca6lEVpDiv5?=
 =?us-ascii?Q?XZmRLgnvWG6Bxo2yU0ckD+Tu54pyMQyQr67rmcoIfa9Q1smQT5iYd/iY/kNa?=
 =?us-ascii?Q?JY6C+jMHfjN+ENa015whiBCxDswAdz7Dfv9EjX7DYrlQMaQD0m+82sK514xE?=
 =?us-ascii?Q?/0BgmvUO6r2vMtCNqxCqiuYFmDNhT9Iy/CN10k7OGGLmUxoOYWcQ+wF1l0eF?=
 =?us-ascii?Q?Mgs0UtLoeGbIH/tHtZvYAA8h+MtBgTKXO47LOF4BI9/fBL3lI78fSjgKHYJU?=
 =?us-ascii?Q?VXzRilksvcVdeERPs3JkyB0AH0LYttKLnx9fPfwQY7l5HXF7dy/T5wsSoTRi?=
 =?us-ascii?Q?UpMUXHYNLPLLUtYZUowSCESieZ4FVIfdgg6qlbtJfWlR7xR2hJtOY6N68+l/?=
 =?us-ascii?Q?d+lmu/n+RIjzoxHlcqs85A5ZH+RHRGysxmn+W0hMEJZM8cZBMjQ7KRv9BgAe?=
 =?us-ascii?Q?DImBsDTtacERURL67GQMOQzK/PlcwKxMndFjgmawv56Ul5+DZ2YOZBKMxqgo?=
 =?us-ascii?Q?g8gP0W2PAU4JFTfwgZYwuoU/A2dmlu9eUqtg/Cviw0OaTIjIM0ISD4N33BvW?=
 =?us-ascii?Q?0c3uTtBfG3uj88W8pMrrsXDAWXv2oJatoxbQOCvIG31e9Ll4FNhPZWX4Jh9I?=
 =?us-ascii?Q?+jTO3lBdASVgLHmbuedTQGGWaOBglP2og17B4G0X+vJYjLFlm8ZeeDinta2S?=
 =?us-ascii?Q?N0CxQ92agtHV/pHHrCh4T3UBJr3cFCNczawYom3aswwnmpWEUKPWAsPyqYRi?=
 =?us-ascii?Q?ACW88NtLXx0uEBzP1h6B0oumIjoJNxGiJ1US3Q2PtSEM+nomePafo6Vr0q8f?=
 =?us-ascii?Q?lISJcpQqhNDJFOynpo6iZp90ZSDYkMssoBQ87m/xMTIc7gML/lIKdQ0BnAgR?=
 =?us-ascii?Q?chA4VYRMR7WRZiPNOtuFFIHNkYBCdlTCov4mBD8Xg695ik9i8IjsAro24IYC?=
 =?us-ascii?Q?mi4W0VvD1Jl9CG8WNOGv+o7GscY4CvpGOssaYoFNiNeQDYrCYqAVqu1ZReEW?=
 =?us-ascii?Q?w/FSIglwj5Ezgy052iTN9tAulO3r9eNozraEX0k1fSqWXgRLG+xP3+6+62oz?=
 =?us-ascii?Q?EUF4DYTvMZmnIJeneK42hyLov1H+nkct7XyORJZo+5wUAc5PlgEV7BGT6vJw?=
 =?us-ascii?Q?4Ft+rzEmHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bdb19c-1a58-4d13-d6ee-08da2ca01a01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:57.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mc9tDRJJJ6CrnoDPWY/43Hxce36dN+I/oMaXRJKDXHLVVpgQy2zHM4WK3QndEE3bWbigIPWZvCH6LLYQrk+zTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some Endpoints controllers have DMA capabilities.  This DMA controller has
more efficiency then a general external DMA controller.  And this DMA
controller can bypass outbound memory address translation unit.

The whole flow use standard DMA usage module

 1. Using dma_request_channel() and filter function to find correct
    RX and TX Channel. if not exist,  fallback to try allocate
    general DMA controller channel.
 2. dmaengine_slave_config() config remote side physcial address.
 3. using dmaengine_prep_slave_single() create transfer descriptor.
 4. tx_submit();
 5. dma_async_issue_pending();

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v9 to v10:
 - rewrite commit message
Change from v4 to v9:
 - none
Change from v3 to v4:
 - reverse Xmas tree order
 - local -> dma_local
 - change error message
 - IS_ERR -> IS_ERR_OR_NULL
 - check return value of dmaengine_slave_config()
Change from v1 to v2:
 - none

 drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++++++--
 1 file changed, 98 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868f..f26afd02f3a86 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -52,9 +52,11 @@ struct pci_epf_test {
 	enum pci_barno		test_reg_bar;
 	size_t			msix_table_offset;
 	struct delayed_work	cmd_handler;
-	struct dma_chan		*dma_chan;
+	struct dma_chan		*dma_chan_tx;
+	struct dma_chan		*dma_chan_rx;
 	struct completion	transfer_complete;
 	bool			dma_supported;
+	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 };
 
@@ -105,12 +107,15 @@ static void pci_epf_test_dma_callback(void *param)
  */
 static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      dma_addr_t dma_dst, dma_addr_t dma_src,
-				      size_t len)
+				      size_t len, dma_addr_t dma_remote,
+				      enum dma_transfer_direction dir)
 {
+	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
+	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-	struct dma_chan *chan = epf_test->dma_chan;
 	struct pci_epf *epf = epf_test->epf;
 	struct dma_async_tx_descriptor *tx;
+	struct dma_slave_config sconf = {};
 	struct device *dev = &epf->dev;
 	dma_cookie_t cookie;
 	int ret;
@@ -120,7 +125,22 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EINVAL;
 	}
 
-	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	if (epf_test->dma_private) {
+		sconf.direction = dir;
+		if (dir == DMA_MEM_TO_DEV)
+			sconf.dst_addr = dma_remote;
+		else
+			sconf.src_addr = dma_remote;
+
+		if (dmaengine_slave_config(chan, &sconf)) {
+			dev_err(dev, "DMA slave config fail\n");
+			return -EIO;
+		}
+		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
+	} else {
+		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	}
+
 	if (!tx) {
 		dev_err(dev, "Failed to prepare DMA memcpy\n");
 		return -EIO;
@@ -148,6 +168,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	return 0;
 }
 
+struct epf_dma_filter {
+	struct device *dev;
+	u32 dma_mask;
+};
+
+static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
+{
+	struct epf_dma_filter *filter = node;
+	struct dma_slave_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	dma_get_slave_caps(chan, &caps);
+
+	return chan->device->dev == filter->dev
+		&& (filter->dma_mask & caps.directions);
+}
+
 /**
  * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
  * @epf_test: the EPF test device that performs data transfer operation
@@ -158,10 +195,44 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 {
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
+	struct epf_dma_filter filter;
 	struct dma_chan *dma_chan;
 	dma_cap_mask_t mask;
 	int ret;
 
+	filter.dev = epf->epc->dev.parent;
+	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+	if (IS_ERR_OR_NULL(dma_chan)) {
+		dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
+		goto fail_back_tx;
+	}
+
+	epf_test->dma_chan_rx = dma_chan;
+
+	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
+	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
+
+	if (IS_ERR(dma_chan)) {
+		dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
+		goto fail_back_rx;
+	}
+
+	epf_test->dma_chan_tx = dma_chan;
+	epf_test->dma_private = true;
+
+	init_completion(&epf_test->transfer_complete);
+
+	return 0;
+
+fail_back_rx:
+	dma_release_channel(epf_test->dma_chan_rx);
+	epf_test->dma_chan_tx = NULL;
+
+fail_back_tx:
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
 
@@ -174,7 +245,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	}
 	init_completion(&epf_test->transfer_complete);
 
-	epf_test->dma_chan = dma_chan;
+	epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
 
 	return 0;
 }
@@ -190,8 +261,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan);
-	epf_test->dma_chan = NULL;
+	dma_release_channel(epf_test->dma_chan_tx);
+	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+		epf_test->dma_chan_tx = NULL;
+		epf_test->dma_chan_rx = NULL;
+		return;
+	}
+
+	dma_release_channel(epf_test->dma_chan_rx);
+	epf_test->dma_chan_rx = NULL;
+
+	return;
 }
 
 static void pci_epf_test_print_rate(const char *ops, u64 size,
@@ -280,8 +360,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 			goto err_map_addr;
 		}
 
+		if (epf_test->dma_private) {
+			dev_err(dev, "Cannot transfer data using DMA\n");
+			ret = -EINVAL;
+			goto err_map_addr;
+		}
+
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size, 0, DMA_MEM_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 	} else {
@@ -363,7 +449,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size);
+						 phys_addr, reg->size,
+						 reg->src_addr, DMA_DEV_TO_MEM);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
@@ -453,8 +540,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		}
 
 		ktime_get_ts64(&start);
+
 		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size, reg->dst_addr, DMA_MEM_TO_DEV);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 		ktime_get_ts64(&end);
-- 
2.35.1

