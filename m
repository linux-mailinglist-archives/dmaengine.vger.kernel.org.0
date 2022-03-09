Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF464D3BDA
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbiCIVOH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbiCIVOE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:14:04 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B65B89D;
        Wed,  9 Mar 2022 13:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmwY3Ju4XvuzEMGy9gTs4WR2SOeOM+M0Sb8UhXCqYudqAj+r/5ewyMnoKFcd7Fgz/W2GfXxTsVxdE3iQUOFF2obrl1+NnsqmZ9rlGxlsd3LrV6p0JYNcc5WP1c5ASGoI38Qpive77kX7vMpzQFQFn2dKWxrUTrY2FigCOEY20c5JFfFk4sSJaTc/DMz0i8+ya8VZC86ES3XZSOVteOp3nUh0l5SOPa1PiR/aA3LkqH6XELUZCGMc8DQbo/+vjScZASk4tbnVDO0OILUTqsFCGXzkBFlyhiq0m1cKdjRHw8oRsWNRjjZ2O7eEEuaguziLqcMmx0/CPyrEVQ/1noVXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoH5+xnf51thSn+tNBhcfaJCTYOPly/hZtbnkzVknfo=;
 b=ogf/Y7O7abxvPWmaHTRF9LxoC2aAgBps7Ssk7TSh3BLJaYNvIIbXVGzSEgHvVXrGwljH8dDwPIkdZflevsNVKaiqM+aN74MAp1SW3OCmpvobc/xRYbTuFS7IInVF3gvByrTP32niFRxRUS5Kmwvb7PTH6YDlHJK5ITShA6yE+nos/Lla75+QZfQublzT6JjE5i8iT3VO8e/0hdb1yijSceANkslG+TIxpHYXCBfGlbJKNofbEYhs+GVCSd7KAUxC97sInbwYp4VrN7PlFqLMqZEOgBmy/LdN4RYTbUtSGXn0e8VduH49k4GwIiCi1W2iHQAICUMtWEinQd2hEGkWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoH5+xnf51thSn+tNBhcfaJCTYOPly/hZtbnkzVknfo=;
 b=lwMFgZWqwR4ysIZUu603IQDWe1dAysdSoC+EA+Cn3y62XXlwCYQy4uTaI9d18zNdDk+LeRkiZWvbczTAadAdZIe8gd9WvAdddt7pO28Bd4/VMWEP3ZyPux+U5jBgvU6ur1U9GT9uSCfxZU87iABtyLQVVZoxZdM2p8KrCGy97MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:13:02 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:13:02 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 8/8] PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
Date:   Wed,  9 Mar 2022 15:12:04 -0600
Message-Id: <20220309211204.26050-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220309211204.26050-1-Frank.Li@nxp.com>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60501543-c495-432a-67db-08da0211983c
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB83585902BF64F8707EB1DAAD880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8t5XobC/eK2xqPVhgMZKj1KMvoxtpZNVcsYY7mmU4SXRbh8GUnOqhTAiaerhPXFQArKrPOuG6sjybV7l/DTu1yCOfB5Zd7HM/XFOqRw/zr+2LN9c4m57EP2CtST9xufTJvwXfZjKITQ1mXX6lUG9bc0FouTRPTv4oQtM8rMqfgDvX5IZNFmL7i2jQuRSFbwiG4rtyyGQJdzwdrIRygEZN/m+bfvA4v+1WexKCcK+6bglssjJBKUG4NW+NKOfGATpJOjPmCqsEj706sp+tQECiGOMiSPv33S9pGp2Cr5nt/oXSY2DkbIodPeRCJUEUsrenYjqFTc1MXvjsYyvZ1/8mSmo68BrNgZ5XeSyCfaZ95SAasZ5PFi5RTz9MkdMGjupfK+aJvjYDIQP/rNGYtsOZnKsrbi2+kswzR3bp1kcskdx/Q6S2kyJSk013YmlktkccmR8/+k4NyHBPGIkAWZyQ7r/YjNDZOUE3Yk7ewYYiUIxsUEjsj82MdtF3v6d4G0BDN4FimySLtfxMkNst2oE6KcS9Eio8JPoJTsiT7gDCSrrUiJKHoa/4gErXEGjqbLnLeOnUHHKVvhUb4XjKqutG8MvrLW5NZSgjNoKPRWneB4fLg42QM0ScW8b4FHh9w6oHDpUJBlgDtbdBtwpxboLxqTWOzTF8VdB40epYOlX3XF1qRLQn4r5yg8QK7S8m2o/05a39lhQcWobEPNsj1zX3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xRF+XDH0gdJzE5zfbyn23bkrZfN62YqFPI3VWAfymagLHqMQwY4OaaL+xOng?=
 =?us-ascii?Q?wk/dVmKIAtLlxk/l0n5+ouXGrngTc0VDDp2mNknJVExi4LMTuwFdf4wj+ZHF?=
 =?us-ascii?Q?V0cdYE7iCHHLlYKetgXoqqh1XSYTd5XKnEKb/5t3f4aus1A3m7JfppIkPM+3?=
 =?us-ascii?Q?hhacLNxHyd5yk/CUPrEPlU7xoSTy+owRMaApyx8ae9s0kl8sVPddHIWewsnz?=
 =?us-ascii?Q?bFEE8pJXycjVmjMzZHz/kw+UdvCncz18mOUncouAHMt4q3puIhs08grAOQB8?=
 =?us-ascii?Q?YCprvCqVXUfjSpqmwTsq3a2No2NAjPWGuuWpeMvNR6ayZlHfuMXcPXxzzQRE?=
 =?us-ascii?Q?SwfO2xPaMlgsWUaG1XZd08/iJzjjtuObs+sJskG3YttegIPxMeufwGOBf14t?=
 =?us-ascii?Q?XTSbVGg9eiDuBFSclnvkJUZMm35zsnx/g9hbbvv5WfhJL4IwsoL5ePjA1DuT?=
 =?us-ascii?Q?Jv0NmTrj01ykfB8lJeDySAKViBMy0guiPJbZ7K7j4HPDNfysOfgqGIJ0bSek?=
 =?us-ascii?Q?SsCX+S8FwpDf0yOIJZ6vsWgIBBRFZbxlEV5TTWkgT5uzMSKU1QLAcHRN2tuf?=
 =?us-ascii?Q?MQg+doC1OmmZ6kZU4zTh6ux0xvYt8kPCx/InWpf3NifvORYPuHz2E9Ai9igy?=
 =?us-ascii?Q?o1KcnF4YN+imFdhERhZ31QSgc7St8EH3ni4Ed5+D+yPy4Og1jEIN9ylvlpov?=
 =?us-ascii?Q?Lby5DyK6VVKKj1ukJyswQKMJ6ma6qz3j4sQpSAb5tJDQHtjhBj3h/fvB+fN9?=
 =?us-ascii?Q?gthG6TGCZdgevWPPnxG6A2aIVyrTx0SNLGHbFxK0RD+ik5RvQxGGcFdhl6uU?=
 =?us-ascii?Q?t3dNhJZdwS0P6vo0ijimFqCO8q+uM9qDDKt2KETEkSu0Vki9HJZMGXv9EPVY?=
 =?us-ascii?Q?9ZfqxLcBGClnqg74DTBXfl8upTwQsNgzfglYs+D5NyQDLX32v+6TB3IwYo0Z?=
 =?us-ascii?Q?aHHxN950I3s+s53Z3rTBdBFtUNdbRmZH80PpCSm9c+TYX9elmPSVRKDMdIy/?=
 =?us-ascii?Q?iNgEmp+you5qObPildb5i84cltAIkCyxRijf3GFaHObhMNGPtW6ZT7CIoWUx?=
 =?us-ascii?Q?LVEuCmWLrdE5J3yXKAC+Q0Tz2pfRz+0xOsUbC/JvNYf92l3DcOr6euwR1ty8?=
 =?us-ascii?Q?0IQYPs0lL63EEbpiGAjCBktDyD+oyGYERG6rDCXbXE1XfmZD/MkUApUsSPyn?=
 =?us-ascii?Q?OJQ9WJgGYALDydECH6TxAvF+8HoT2GZ6/m9lsCrV+8TUEaTBdxkx0DJ1MqdU?=
 =?us-ascii?Q?igEELSKvagB8iq/kgI7xNcBxBm3qTy7I9cCgv4e7MU/Snl6/eCXQFOQjEIn6?=
 =?us-ascii?Q?St17uGBxzYNba5+PSPzbyNoxflJGo2x8vCrShTUxkpHNCWl+j4XiAHJkM9Uj?=
 =?us-ascii?Q?Z98ZeGhGx6swyGKqzVdW9+Q+A3kyaUQKbt3l81GOgBd5Zq6gC+OScUK6nHf9?=
 =?us-ascii?Q?g/cDMCfduKBDsDA6lY4KK07/PCNud8WUjkyKfGDBKtPvhq+VIH6Lc2rud1OD?=
 =?us-ascii?Q?4YtqxSW+TJGzljLFhg7LwSMEux51hIkHT9qbvuym+0GMM0nMLiJVCLihucNd?=
 =?us-ascii?Q?f0xAZkGSmr+xtHHYjbNsd0lCnWAzRy4jJj2WjNAh0Bu1qXLBjig9W6xl/jzS?=
 =?us-ascii?Q?2tx8c6lViKpveVFfJz4t/rY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60501543-c495-432a-67db-08da0211983c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:13:02.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uNWJ25S3YVdRyU/QeZ8hn3VRczEWwq4RkYn+9oeSv+9dpEuRwo7JxEKaI0Erm4YgyyyZABCaH1SdKYhdWnZrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
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

