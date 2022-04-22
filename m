Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879B350BA4D
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448753AbiDVOkY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385535AbiDVOkX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49525BD2C;
        Fri, 22 Apr 2022 07:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1ZBhBtl2ewUvZJ9cvvEnE5yV/z6XEdzU6yNnaoGe9yU8i4fnDm3SL8Wg/ebRBx3iFlFNU9lX3lT86TLLSZzv/KImDAF5iJx0KmaULMpsx8U9vxCHPJtypUsc0rorh1Xo31sFvtphKMDDoUu3GtT22zP7UBTksxEkWl62HdHFejnCSXb4ER1tLInSD7jsurokW6T+4EP5me9qbolhScvVEbnv9ifs+psxA8mxtn1ZARJhkLGfyFWykRPv8mqdLbjB+4hCWpl9P5TU0CIGg/jKA7HzkQDNCxSjNx1JpOEoiqgQPTi0tLSG4JGkdSL3uk1IMeMODb/RaiM/37t5SyGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGTLw2y6VrAiWijhCa3rs5lrQadT5NKLethjYAQIDn8=;
 b=QbA62K61X5k22tGJou/KpkfsUFdt1SxyXfsQ5wwJs5vyVACkXfOn24BgxLlwmfxrmH7Kh/kHZGJrdaEozEcgCmdNal92iX4fd6ivr3W5GhJ6yqO78DReTJL1Jsg5X+5HYKQJ+OOXGCDN5mAwu1u90VbON/wfKOQJSmwnzSxa/b4WQl7CYH6hiIYZd/dpwJXTE6+mIeKfEyfv/ilNyhOMO+EWwDOYq6rSRL2qqhXEbGTOs+qEZRdbFkcXZal/xa/uUIyTTdpRjGaPwBtYvYaD7IWdjhv0AuoNBm5vgDp20KaxaJDe0ogGVCvyN7f3WiFq1qJ98kSsUvUhK7YtbyA89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGTLw2y6VrAiWijhCa3rs5lrQadT5NKLethjYAQIDn8=;
 b=c2VB2F/MiYc4F0QiiAnNH1dQfvb9feGdilzHeCXloHtTrNqd6nhjDy56Cb3RwCwzGnVIJDAeKBn2A6iY0Z+J/BVTCMjFDjLj0OiU3/ooBJXtPO8NomK/sFXlUuQN7edO8iNLaDQeMAgInGpbNWelkpuZk7+fPmjBe5QQkRm5QPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:37:27 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:27 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 9/9] PCI: endpoint: Add embedded DMA controller test
Date:   Fri, 22 Apr 2022 09:36:43 -0500
Message-Id: <20220422143643.727871-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e3767e0-cc52-4ca2-8bb1-08da246d9f5b
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB26442E983EA2BFB3A451A95588F79@AM5PR0401MB2644.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQgNV886rmfk7SLH1/XWAIlpKAWuX8r/fQLLhGgAZNpMkw+oCerC6zo/Lyufze+Y62of6mLF7wCYYejzsPQ5995ag8WRmH22Ril1cYWyqj4hYB2DqIRCHzzn2VlC2jFr77S9grHW7fq5tzL5QDtQW81JAdzlehxmnMmIq+/TDHA0IqP57N9Jzm4bnJvo6+4Ag0ft/Z27BTdousuHaSNRf/7+bVG6xlwZLMm3tO8S50vxvm4eSWHqFHBfLZZaxk+7LNdHy3HK/0lfXbH0bAX5ar0OCSjCZBeqZoF8l+k2c/T5BTGMQ+AQ7ltYpInQK7cv93B4YntkiD7QFLD8K4odax18RDeeefQTzFt6T9cr2bl4LPVbuIvYuXNQfN2r+10vKtBi9jBUF8o0G05Qm/x5ytH0fz4SZ/qubVoh/TgHsf1PZnNvGCvUJEOCH4RvlHG5SiPyAIDUQxAPxDzVUA6+9wjnHDQjepgslU48dMjA5y/Nmm6Sft4mDAF+HaNbJtlmK6Aa7KG4GZ+lHlh1dFuyc6WiDnEEf5ixE+iWAd/A0vPD51paQPCmskJyezIGHp1Sw6cmjq9AKAzu79huUY7xXhdr2BmmxJh+VrOvNvbgc+/NhUCWxWxSzFkW0eHKFCOM0BOKJUHH/IeNGN8lmi1utzmKjYz61erWd2uIaSeRQWm159h5d3GarFJr7anQ8RpZmJrgS5bwTVUnRXjGlrok4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(4326008)(6666004)(66946007)(83380400001)(508600001)(5660300002)(6506007)(86362001)(38350700002)(6512007)(36756003)(52116002)(26005)(38100700002)(2616005)(6486002)(66556008)(7416002)(8676002)(66476007)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpzlUd82YAiaoVBcujZEnJ6jgl1j5biPoSR+1nCgYhO73Ou16AVvviI7On0y?=
 =?us-ascii?Q?jFfnmS7GrliWjWbCyBbKAfGh/MtgiLGvf5uxDpaK8b6ebyUgbcw4up+iWYTt?=
 =?us-ascii?Q?UQtPKp/Q5dpS9Zt0E5y9nGth4l6j2K+ug/vsDdVC1Bh4ZOQ5O5h9/ADsjwzd?=
 =?us-ascii?Q?ohmderceEpOzKdgkjSC/sEjBPMbythD0mF46O1eKhzhSCb3U3GX5L4aRXfo4?=
 =?us-ascii?Q?KSXPAZA1FPW/iir12phsoXLTyVTTh9m3/nlgqO4WGHyRPBnpPa89j8m4kyyz?=
 =?us-ascii?Q?06/mX8wwXKPcX8zgmfXPi6BmExWP6AEHk3LeeSGEam/G+Tuh0ePdy4i22mZf?=
 =?us-ascii?Q?u4MqZs+bjP4+rHlBy1O4Zgq6o22+1NJ9uqY1BRkpRuO2ItzfAZ2/Y/vRSF1c?=
 =?us-ascii?Q?Axaz2jLdvuuNujv2rzGhXemXYEJ3iFRARnK6XPnh5G5TCj3C5MJNFsZe2Mc8?=
 =?us-ascii?Q?zVD4VwqpgqyIwTw3Jyz0nZBWNu3HShv5+XjgBAGcWKlAC65NVP+JUG+fuleg?=
 =?us-ascii?Q?quPaTUc7JFJ2x/r4Z8ww4t6qYM6hQ+/hzcIe3dcbZP3QqR4HMWr+8SYybGdg?=
 =?us-ascii?Q?9Ju2kt55e04K0rYDqzMy+3bQEN5oIJ9NqSsz507EhWqORPFZE4z4Ik2FbstX?=
 =?us-ascii?Q?0UrASnUd9pURYBk7ofM3adjQTtK8YwLiESIgklEvgrHsTbG3N3zEgUCilLUe?=
 =?us-ascii?Q?R6ZQ9Dt49ltm0MU81uSJRCXMp9Obdotnxzzfc08yTr+iy1yLYE3TQW1IZqXn?=
 =?us-ascii?Q?SCC1OPSewpqc6UAsmgnJ5AVfuh2Khmxx7txxhGXfiZ94lvjLqM4btT0e/moR?=
 =?us-ascii?Q?w3pljZ9+me9yHrd99fM1hyqKsPb3VtuTkV/sTBUiYAONy46pNuc7R7ys2nKs?=
 =?us-ascii?Q?2grKPiFtN2AJcZMZ8UpeiD+wi3mNEahJjnFIOe+aqTs+o5u8UW3VCoEuXTR4?=
 =?us-ascii?Q?d0CO4y3edynIdjQ86/VzM3tVqr0Ghs+/BehvEYPsvHDeG1FN72GIhUDnG0ge?=
 =?us-ascii?Q?IbGjFyoJIlYN9vqGw9WBG0LqKu2V59Rkf5XmA9zUq0iawdCeOpf7ga3GKCx0?=
 =?us-ascii?Q?ol8/1axjH1PKoUIk1UCO4ULHZYSXE6ILtegXrUAlqby95HIDyNLWVwZLEmAe?=
 =?us-ascii?Q?Lba7IWOe4v/vMPCuNFtDg25AELdF8A0vqwA6PmMqcQAzoQFj+nMkyxVJm7bS?=
 =?us-ascii?Q?FefQi6nBBuVjb50OW2T8JOgxTa0iiC3WP/kjqGAKhyTFGEvzt4Jk36eOoNPp?=
 =?us-ascii?Q?J1uBRG+Z7Jm0wwQCJFlgGNH5Q6Ut3kDhNBz9C0HW0ixvxqDFgkM+eQVHjEkG?=
 =?us-ascii?Q?x6hyyOYcwMNelDb63mHALk23dKkSWpWGVquAmV6k2l5kmLaXne40SHk33B4K?=
 =?us-ascii?Q?uWTTh5P77qFAV/orccD+NhqL6Lm6UGo1r+DRZWjZL07r7d7uFZhhC9Tsx1Le?=
 =?us-ascii?Q?elA+2NbZGHV9Pjb3dbM9CXbHy7fXrQv5RDyxgUfdYS4loAF5k8X+flNbQfZs?=
 =?us-ascii?Q?KLTmMJ/r/RcEUqerfRcrkuFiQpKtepsWjW3BpQuQ9FDAPkHED/4DIEnbf0Vg?=
 =?us-ascii?Q?kJTcs1NDOItgxYO95vwCCy6ECp8VBtxgERa5jnMUcdqV/gLy8+yWsxHdsxhl?=
 =?us-ascii?Q?Ll9bzZo9pDG3wN4K/TAUi5j9aid1VuAtVLfNvJxDffiB0y6l9gZ6Jpl0R821?=
 =?us-ascii?Q?X0TLN6Qv3VsJB7wZ+3j2bgPAFstt/PZJG7wOr2/Eb7PSpoYpjKmcXvoRigMI?=
 =?us-ascii?Q?ePcw2HPifg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3767e0-cc52-4ca2-8bb1-08da246d9f5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:27.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHCIVXFOM1nqOnvZ6EUeEe+V0+k0w8LlFKXgjANQI8a1BvONqKBhxemA/YGH/FvxZWa+vyqeTVGMMXHAxnZpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Change from v6 to v9:
 - none
Change from v5 to v6:
 - change subject
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
2.35.1

