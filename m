Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23744D524D
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiCJT04 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiCJT0z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:55 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20D137032;
        Thu, 10 Mar 2022 11:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrwJe/GWCEWTRA7Jm6kJdI/jAB7ajon6EEw1shr9EHvs0nv+iMSFCZtF/LfgNtKpyL9JKdxW5F5KT0S3ezo+IHTk+cyKS3UgCEjO6RLoLJJf9Mw25/WmxSlkm5+cEF6slQcM4fgJA1gZK3wXdSKG+MhYHKlrVnAV7gIgxvGfycAD9r75IS9Q6uYTMNlSInk0Vdtlk/D+j77A+rY58DLp1yh9zgOOv9Xn6t3lsyePz8LSPPy/E1ZlzEaoHE8YQpoRi3D0UHUTy+vvNIoNJZ8ilzwy6kHzDvYk5si1KcLzFJvChn6k8Gr47N5sfjYZGrcWI/uOjFTut7QPg1xQmPUMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bzfzJG5ma+hOdOIf/GOHIp/ZCbgsvfSgRFHi0BBcoU=;
 b=MCnF35Sw/DqKsmusi+OznCpSjdhFKWLdLWc0vIAO++Wd6pMGTY6Fww2N8cj8Da7iG1Iev87EIDJURAXpa93yHx6KdizVj0WBRFwsKAtkUthkGrR5q0YpnsDAn0dU227xhNrVZxQfWTivV9KRRK7RmiwyyNo1GTipqKGtb8Joj6Bx93XMnH814dO/4XbWPeBCgbusUb62Lu1DuS/uFqe9XZhxw2WR5Pd8EoOxl9/t/at6mAlUwDbcetfF8DsojIbG1hrzigQrxVCSpoMe3q3Eak9+0YsIR7ha9KpUcF883E5uPBpeWzP+UkGosfzh7bX8sGDlrOWm6zGb4j0AlZrq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bzfzJG5ma+hOdOIf/GOHIp/ZCbgsvfSgRFHi0BBcoU=;
 b=Gfe/WrVF0hf+cCNUjJ7lwBJbfb/6dkZMOvGSmQ3dn9JTILVe5ED5czgogMznGfc7Sq+1tDZuKVv8qkSPK6D9we3BnIE4iDDkXXfzSo3Mo7rK8xkMqPE4WwLquHwCsWgdwnHJeWCAMvbaYIQ4zUb/lfUH8xUvqbCzeI03EWi5bG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:51 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 9/9] PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
Date:   Thu, 10 Mar 2022 13:24:57 -0600
Message-Id: <20220310192457.3090-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3369698-1a78-4bd3-2d15-08da02cbc9b8
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB485822C7F7E0882D49590F3E880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5T/atPdeIYi36gcE8duTVX8Sb+wusMknjx717E8HGDklZwM6HmIjcElRtlifgXBnVD69s+6jKbjy+he/tMBrH/P2NGWexKVMXKHLqsiP3F5DvviJGbm4WlguFgeUFDy1t2w5wFgEP5d8yQm18m08i4MIrNGk2+Cyql4WLWp4wfDqQes+Hh3ZRb8yQNBzYvMciiOXpCyl/BEdsaHVQuJrVBAk78HiAGU2Y8GCePBzQGY39SvpzcTWfhv5dGFK/hAc8FwYlK8ycUKJaahbUwg3c0KQrskCX/w5nn/uyQJq94q8wOstY64j4+gp4jh+l4WG6yeW9vMs+f5KpkEt+ntB3JlVOZ7xepV8fkIAGnLZ8765SkKQQelaYpQ5bmjPHQNiHTMyRwslMBpmtSYlgY4ZrUTktLJoosLJsezm+V5Ra6inv35p2/yWqi/KRQXqMDid/HdrLbZdEigFXKxQaWvj7elMYiM5ONlTJOm73F6awjDxmj6KvVgmWs57g6aF2Xy0wgHI+ID0OCVX5EYv88nmxUfoP4YS5Us1ovd2NYJpmoWJoYmWRA6QJNB8ao700F9WuT80ztUje3QhDPsHm4Bg2E/lAsVAIH6YEga+1Pg8oL2JHW9R25Sffq94L8otbh+4IL4I6dzSj6KkDzxUpPqsowN5Cdbw2BTdSzqh0fWlWEkAVU7dMEcgwgkEGieZytDAA6QIOSb/qmXCBZtLEwfIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sIjDg8S3u/DPFtO2nbi5A62ZM68pkcbuibK72C4Z/ZDI65TB04ESsLPOpjb?=
 =?us-ascii?Q?v3BrXIl/uejwn57l78SEkpcA+wlHg608F1xAXVF1i9GUpyiuFu75/DK46fji?=
 =?us-ascii?Q?WtJFF17UzZgbsyXwLnlDrfmlseKU0NaaM/Vzbe7ivrHwJ0AWhAoWnQbkM8yx?=
 =?us-ascii?Q?t4BTdPi71lga6BHmjQNbiox+XNrm0SzvAXDzt2iYHSFHs6sc/ljJR/l9ltya?=
 =?us-ascii?Q?zGwvh1o3l/bfUQq5mp1qNkeTlnJZmzLqelullSygK2eUo4N3Sz2JZESxXs01?=
 =?us-ascii?Q?8pcf6xdFkFv87fl+0zjCjPcnriRgFV+aUK8FIGwA7bmldUpXP/YQelMKo6DJ?=
 =?us-ascii?Q?qL27w9cH2pXBljqDTR/vMy+oqykkoDRdG6NyM5Dyhe6Qekx+wnJgMkCMUvlL?=
 =?us-ascii?Q?zvtHOu+Ac0J1VTA5ZkqXOAfa8xJ525wYJsvEhDNNQMH/WXUATTeFxe7mboM1?=
 =?us-ascii?Q?iAtEDWvMVy7a0TFW6ZXs+ZZ3FGs4SugZaP3HH+yIX88RtrRtesbMPGZhAc+j?=
 =?us-ascii?Q?Z9icrIwothtthsZPmc378Q0rkZgD+SeVE8t8+oAwLUY+DSSlkCfOqcjBNH6w?=
 =?us-ascii?Q?S1qW/he1qDQmJdaxlIZnbIrx6eNf/dDDFWWsQlSG1nc8Eo9YuUeqfplQR1sj?=
 =?us-ascii?Q?xhLbriP/1H1naWhrATMyi2/J5+MeUfr02/bQTrECgtKLNccYXAgu30C4g1h7?=
 =?us-ascii?Q?pTrcb8yh2bjwz/2aTrmoHGEgP2uzYJh9dEjQnneUKbkxdXzCb8lQ5Rbgl/6H?=
 =?us-ascii?Q?/ccC79eXorVJh6GX56iZArxCow0PIuvwe2JLC3ySB20W4WMd4ZtkhJ5+e2nO?=
 =?us-ascii?Q?1aWfs2J3p0McJvXULrFF8dBTMVqMwsqmlTMnXSWzT8k869Ws8gcE0iNJCzZw?=
 =?us-ascii?Q?6roRvPdnKcmmGBJuYgCCm3/G1xjb9btymmzpwk6wItYqWASUSWjSFMV5lse3?=
 =?us-ascii?Q?m2Z4kRC1tC2YFs87QSajlayVtMtM2tuO71yhZk1Yeb5H05YNqA1NHze4ozVn?=
 =?us-ascii?Q?WWSRLUAtRKs3XgNNoCPCvfNTwJfyT7+8ErcBS1YVGEelaKxk13gEaidxDCfH?=
 =?us-ascii?Q?iyHX2Q08/4seVU+CSS5LuXzcV38avDOqdrr5qog8MuBOl9EnsGQnAYv8rWAA?=
 =?us-ascii?Q?/iX+YNCE/hyZtJ29gl7otGyliAet0y4G8NINTIMwlP7ZRXtFu2WYQ7OoTAJl?=
 =?us-ascii?Q?bdjs+cGqGcIpTFeEuT2J3oZaibgxOKV4r45bBypbUKp8vZcU3fsuggcqwe8C?=
 =?us-ascii?Q?her2sOctevwReuwQ1H0IHkmVLFT4tuNrSd+nhEqA3/Jhaa/M6hBwZ+IqwOuH?=
 =?us-ascii?Q?ryfCDkiIwA/7iXuc36s0tWd/3+rDHGvRiByrLiaA+FAffbtgYnccp6290+Dl?=
 =?us-ascii?Q?Zaen1tcr4MiShy/5vp5hKdRLWD577d0iY4jgA8djJ2GTOQdV0XrRhLDHTT5x?=
 =?us-ascii?Q?9+4F3Kj7xpsBI1Qat+ZDMOpI8WydApxZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3369698-1a78-4bd3-2d15-08da02cbc9b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:51.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8vDUDcnNwBNT3WDzqbcfTkUt5lCaO4dfoX/Vmkgh7uEjgm8y3YHX4DvW0+Qt7LxXxWQ+s2Q623JI/sRV0Q1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Designware provided eDMA support in controller. This enabled use
this eDMA controller to transfer data.

The whole flow align with standard DMA usage module

1. Using dma_request_channel() and filter function to find correct
RX and TX Channel.
2. dmaengine_slave_config() config remote side physcial address.
3. using dmaengine_prep_slave_single() create transfer descriptor
4. tx_submit();
5. dma_async_issue_pending();

Tested at i.MX8DXL platform.

root@imx8qmmek:~# /usr/bin/pcitest -d -w
WRITE ( 102400 bytes):          OKAY
root@imx8qmmek:~# /usr/bin/pcitest -d -r
READ ( 102400 bytes):           OKAY

WRITE => Size: 102400 bytes DMA: YES  Time: 0.000180145 seconds Rate: 555108 KB/s
READ => Size: 102400 bytes  DMA: YES  Time: 0.000194397 seconds Rate: 514411 KB/s

READ => Size: 102400 bytes  DMA: NO   Time: 0.013532597 seconds Rate: 7389 KB/s
WRITE => Size: 102400 bytes DMA: NO   Time: 0.000857090 seconds Rate: 116673 KB/s

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5:
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
2.24.0.rc1

