Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB352A609
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349863AbiEQPUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349880AbiEQPUV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:20:21 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150072.outbound.protection.outlook.com [40.107.15.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC024B87E;
        Tue, 17 May 2022 08:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFT1tn/kcgXPGJWcjpMCwNNN5d1H8/ZOzfUgX4xywk20XklSDD0iBoUKJTY2B98EPM+Sh/LKXtqRHtEGTOGi+EZlWvCeGAbKVfbL6omwkkIctow+F+oWVSDGXdg2vCTDQj8fmuuiQCPImzV/EPAt1Z1fOqEmTG8PvM+eIrLrnjkTEFUBQApNynQ1seNOFbVHdSASlan+wVNkIwrewmJIG3/bc1uYFi6Et+iKtWGmb0hEeHayvL9d3wHe3RD4gAxvUTqHqUatf2SgHBf+cZtpLEJPSbH5VuQqd/vDm0bhG2g9BLHG40j5cEhvE0wArfJRDg35Li4D6fiBTHG3G3v/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyfunC8Q8A3yMuDWqmS3ef7y7nn123i4uP2/OGKTaC8=;
 b=db4WKBfphC8VN7kBPvj2ruCJvRhu5S2kJMgHWp17/qH2Zt0J7mKhEbOoRcCtcN4lujFPrKL8yfKTWzZgNZwvNyKYxa7hV4oAldTLIBeBuEs6SjB/qxJXd1/lSKGOnLmwwbZ7fYCzlJP44dS+vnM3XDnYjf+nT3E5X8v02WFdQtZo3KH8ENRiYPM9T3gBKIRjpHD9Ya4TSHMU29iS+6uPN+CbkHyAcsjKKfAcPHOFb1go4K+w8Ow582so2N9nAHxkD/8WN54BCbRGq9PsvTwspQIcgic3u75IXnErW6h4kHTEmnbyDYwlfiQ1mdIKpBd/YndofI5O/wC2DAcSiNENng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyfunC8Q8A3yMuDWqmS3ef7y7nn123i4uP2/OGKTaC8=;
 b=WgLAKF8w9ZfA6u9+SsyufUhsGPV1iVNyuZ6AwpxThA8sDUV4d3EzxDkTxszluwecAZ8CZyTNEMROPNS+GbQ31tufK1+1evZhrFfAcPkrB6/U0IzK2r/fpdxIs44Qy6rZ1P1c6OjVOH7d66yX8Fqqh6428ABIwS7yuOYSFQUwWS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0401MB2285.eurprd04.prod.outlook.com (2603:10a6:800:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:20:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:20:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 8/8] PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
Date:   Tue, 17 May 2022 10:19:15 -0500
Message-Id: <20220517151915.2212838-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517151915.2212838-1-Frank.Li@nxp.com>
References: <20220517151915.2212838-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e35e8d6b-661e-4186-8dae-08da3818bcfa
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2285F0BC3F2D836024E80B6188CE9@VI1PR0401MB2285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMRyUOHWby4ZAgl0rcuwStiSOFsbShOMw8a/5Ln9BFaimJNOzeqAgn0eMF2SyIfrlS9nr/EzXzFcaV8Llt6LH2ikEmE3bhdXTfu1PUhxrmCcI/Ri/i7w2NKjzIySpbqv6L42q5k+GHyuhvUXH8usn0+qlpAxCb+OH4K5Q0fHjdBmHks12mBvZtZbJGBbuhgNYTmNgGi/PEnsUDxQcmViQhUTsE9KQMla6tcy4Z8ioGdA/lsYVwW4L1dRklRiPv2D5kVAvq//n+gv2bH69z6w9lsDxcnAOxHc5v37anY38DSnd+c7CVcjy4dvd78Mbfw6Awkq/fNMIaQXzwUPe9gdV1M3HhiRzhQf7ZCsTZUTWtec5DVqY4Pkmz5n7IDjeo0q+xLNx+WWYL23kc5OvV2AwonlmQx8WuyCOmhE7Kfw5KFrjYtL8PKtmCt5wKkUS4wFabgQ4OqVacI0SrBriHY5266MwfdFgrZpp5L2F8HnFKkyoqtlpzanhHW+xKziAnAGX69/aQCPNdQGE8ZMW7i0pzl1wFhtyaZ8YuSZLrme4nkpR1IHsk4rqRp+fpw7QIGcEtfIGGTKIoJ6HOEGWHR0QkDY1Wh43QuI9B2UuAerEB2ZnxrgNh1GhTuInliQP/lMDrRKDlvuTr2p60PAyZyBHdSxHGm+vCM+VVB/yQA77m9zMrARoFg+tw4M+F0yt0kI4UXS3VTgiqw5QhKN7NKKnGOk8xi2PiXxX+Rv0mS2h9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(52116002)(8676002)(6506007)(66556008)(86362001)(36756003)(6486002)(316002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(186003)(921005)(83380400001)(8936002)(2906002)(6512007)(66476007)(26005)(5660300002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WyEgUrMoJWH5odxKS946vmWyPYRlxj8HWWkoPDlv7vtKxmXfHz7uXjwDodkG?=
 =?us-ascii?Q?Z1g44B4zzdpcR/zBtYT5vuWHeW6ROW0qjr9K1SM0UcBvRdWUpzKz9a+df4Q2?=
 =?us-ascii?Q?QZbfU6XWq/mp26gZRIN1dei1vOuCuXT5Bz62PG+qtiBg9HFONuMXPwUbKc+z?=
 =?us-ascii?Q?p21/hkRy0OCnTq2eXEZxVbCxRZah2bc+eVB032bRmGui/r5kR1X3s5DvV/ET?=
 =?us-ascii?Q?CGhnT9yj4nzmB7VSxrnGPS7bUS/6EJj7G7D4HeGiZELju9zSuo8v9ah846Ny?=
 =?us-ascii?Q?Ytf4/Eq5tYo81Rl5UCqYt8tYUPArcSxKzentdogKAEtXXn1/sVY8ZLkKDjw4?=
 =?us-ascii?Q?/Q/XDN/UbN31y7PjgmMxfJKDFb4SjDLGTUbB2HwQutUEPjx6OTDrVf3iJCfp?=
 =?us-ascii?Q?UIxjD/69VOhhkMo84O8DSUejEZcf4pDXuKvfhP/lysgSGyhufv4OoTjnv6IL?=
 =?us-ascii?Q?LA3ZTECPcypXzAyIzTjX5pFVxJCUBUHrfrz+hBW6npWw4gjQzceqvzaxSBlQ?=
 =?us-ascii?Q?L0ZHGqyhfO4T0WV0e3XUnNL4uZYgwjFN1xMsMOYCPcycdNffr1omKr/qFd/6?=
 =?us-ascii?Q?kEnbrGbO/rFmQKu8tfl+NHuFx6Ls6tm6VW6KFcgIPHL/CICGjx0+eDwYY16H?=
 =?us-ascii?Q?TPKpBxA3Q5vAoyhS+PbhOqyEwEqdEdBBIjcpblznWahn/rkPz71fOWkCsUZo?=
 =?us-ascii?Q?aZX5ga9wzObnrsVyEKRNvJHY5EesAIUtkmyONp4DxWpO0Ay/0wB3uF+xZ+Cl?=
 =?us-ascii?Q?M5em7H1aG0jzl9J7g3UEs0fh7TgL7n3cnnDFRY7iv512gUkTYumb/HB99KwD?=
 =?us-ascii?Q?Q+s4BePiq1SkmztKrBV5+fJp66B1alCDLzuz1ZY5UFLDvzyKRuSQkwRIFZdy?=
 =?us-ascii?Q?tN/AuX0rWGtq+ua8j2QVZXKxkRrlKkyV/ZrYweGop4XtbvfExavVtHS6FzZC?=
 =?us-ascii?Q?Oij1IU1I3WbDwc9DzDPRGKUHZLDRiUKztu+Pf0MhhaNyYRvk6DU0KtCvaYpU?=
 =?us-ascii?Q?Jq1QMANFWHlOl92YyiiUG6nBPVrDQ1dJCZLEevq/AX2t4GSYkG5cJ5Lunn6W?=
 =?us-ascii?Q?4DdXsYmGfyC/m6qk3WACVnDnek0oA6hXdpNWXICOOp2fBaQwsdGgRvqNll8r?=
 =?us-ascii?Q?IWJhKA8LmuUJPKuopLsqvoYpgb4wIjC5S6JwB//xvhmZYBwU2sc2CScRdCIE?=
 =?us-ascii?Q?TT4vaKASPMIFHJy8KSnV32VZBaqT7aAjcwT2cF9mFumxTSr+TIHxrrIJHVtW?=
 =?us-ascii?Q?GgopWX1OzlCTWWaVJNDpIjvFrefge/35Nx83ze2+0yHiZB4oG7Nzh6Jaq2vb?=
 =?us-ascii?Q?RMK1St7a5dt8/JrCHbmp2XtL6/V6r0R+568JoO4jzUTRxls1eCgdmrlFPcIw?=
 =?us-ascii?Q?LkSf9zUxueP8PpybU0gfbQPa0O+P/c18VCUqwUm57n3w9DwNJcp1NQFU5WsJ?=
 =?us-ascii?Q?tVX4FuJYq7UuByAIk8fh5MZsEtnW8i8PJs56dti7TlXtEhapPm33Tx6NeANi?=
 =?us-ascii?Q?EAIQ20f+0E6MEBqwIS9rB/0zvw1pTf5oFZzqoAhJrbrqSxUbJ+qP8F/7llfK?=
 =?us-ascii?Q?SM0RuOZztedabTU9O16PDCjJpVlwWShfcegT/mBINn7necAZbY7T+FrMzEwg?=
 =?us-ascii?Q?qmgrXlWD5Li5MT34X4v8p1K9NRuM+XgUzupfBsl3Vw1aInl4JfaVs+svUPxV?=
 =?us-ascii?Q?NsDfRtV7mr0jh0Ydd+Fy9hKPM0RAKXMWLhsTJhAgc9/sTftO7nJM9PgrGq/H?=
 =?us-ascii?Q?nFbRTYkhUg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35e8d6b-661e-4186-8dae-08da3818bcfa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:20:12.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBUcnnYNRYgjGT5ftoVfzGl4bdHDrXmpgXsJGbzE8Sn9ViWzC82CkIr6UewWdw0YeVuWn1qW+Yt07WCyt782qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some PCI Endpoints controllers integrate an eDMA (embedded DMA).
eDMA only sends once a bus read/write command to complete once
data transfer. eDMA can bypass the outbound memory address translation
unit to access all RC memory space.

Add DMA support for pci-epf-test.

EPF test can use, depending on HW availability, eDMA or general system
DMA controllers to perform DMA. The test probes the EPF DMA channel
capabilities.

Separate dma_chan to dma_chan_tx and dma_chan_rx. eDMA channels have
higher priority than general DMA channels. If general memory to memory
DMA hannels are used, dma_chan_rx = dma_chan_tx.

Add dma_addr_t dma_remote in function pci_epf_test_data_transfer()
because eDMA using remote RC physical address directly

Add enum dma_transfer_direction dir in function pci_epf_test_data_transfer()
because eDMA chooses the correct RX/TX channel by dir.

The overall steps are

1. Execute dma_request_channel() and filter function to find correct eDMA
RX and TX Channel. If a channel does not exist,  fallback to try to allocate
general memory to memory DMA  channel.
2. Execute dmaengine_slave_config() to configure remote side physical address.
3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
4. Execute tx_submit().
5. Execute dma_async_issue_pending()

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v10 to v11:
 - rewrite commit message
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

