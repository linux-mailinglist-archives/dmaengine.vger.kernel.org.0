Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D37A14DB0A
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgA3Mys (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 07:54:48 -0500
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:6225
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbgA3Myr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jan 2020 07:54:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvtZl8pUxhd08dejzkKP/16fS50KWWMsW/nRT790bU9Mf1pOtnUAoZ4w+m1YyBdGLVRn96rcZM7Jh+7MiXhz5u012hxsANWDx01XTeVcbokQYK430U5BPuNBXzillcZ2/4DCJgAAs51mGHwp7F84aKoWluO0qKs93Rc045o1YY4CJrQPORModBQOeFWTbWfMEyrmijhRXdqevZG4TplvTwgc8fSG/zH7AouzoG/2J5CUS5Oun6P3/SiqBKhfNEqZ5w/Cvw+Mx0HHtdcDczmFQnjQKOu4PDNeoTil4sf7HjkLb/tQTqMhPbqtH1Qzjtvld567zwAIegBKD3m39Da27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhLXgiGuszIBfcG1G61tvdtivkjgjvIFmr71xbLJH7A=;
 b=gPGNHapsoYnSCfkW3ZL6XHfUJpnU8XWlDWf8HI8na+q7xifUpv7ZfYaYabDH9osP/UfF4eUbf4N8Rgl+ILXi8IYvy31UnsiSbfgVr5C+arzh8AWuU6xgP5j9v+3LvIxBYdTDXzt7AUCOsUPCHIG+zsyTUNqNpnkNS26TvhbJPb72nTRYG804YvojnVVCz+3bWEipyPTl48pytKp2oWaiZBe5kZw1md7vpY7N4c8JbL1FVKcInXQvFfxsd/gzgCIaoRCXsEv7Np11QRVT8wBt99H5NGNB1RtLevoPwW6FlNSGVWZob2T/sqPZNWi2apUiNm2LnAuaX0fJHUBhetuHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xhdpunnaia40.localdomain; dmarc=none action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhLXgiGuszIBfcG1G61tvdtivkjgjvIFmr71xbLJH7A=;
 b=sRuKYI+LIl+BeiJlqiU8o+ntTcEwF91RNJTJnuwAcnHOST9WVBptwMUZ9Wr2xcA1YUPZu9H9OW6xkhJ07eiivS23peiU+o6y/MWMnivoiP/jmIapFo1CGM4f1/jDxB76tggh2NMYAHBE4FuTXaZz7xA9hSGB2ZKx4jKelyHtghY=
Received: from SN4PR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:803:2b::34) by BL0PR02MB4818.namprd02.prod.outlook.com
 (2603:10b6:208:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Thu, 30 Jan
 2020 12:54:41 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by SN4PR0201CA0024.outlook.office365.com
 (2603:10b6:803:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Thu, 30 Jan 2020 12:54:41 +0000
Authentication-Results: spf=none (sender IP is 149.199.60.83)
 smtp.mailfrom=xhdpunnaia40.localdomain; vger.kernel.org; dkim=none (message
 not signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: None (protection.outlook.com: xhdpunnaia40.localdomain does not
 designate permitted sender hosts)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Thu, 30 Jan 2020 12:54:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9LD-0004Li-7F; Thu, 30 Jan 2020 04:54:39 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9L7-0000iS-Eh; Thu, 30 Jan 2020 04:54:33 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00UCsWEj005669;
        Thu, 30 Jan 2020 04:54:32 -0800
Received: from [10.140.184.180] (helo=xhdpunnaia40.localdomain)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1ix9L5-0000hh-Tk; Thu, 30 Jan 2020 04:54:32 -0800
Received: by xhdpunnaia40.localdomain (Postfix, from userid 13245)
        id 21482FF8AA; Thu, 30 Jan 2020 18:24:31 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 2/2] dmaengine: xilinx_dma: In dma channel probe fix node order dependency
Date:   Thu, 30 Jan 2020 18:24:25 +0530
Message-Id: <1580388865-9960-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580388865-9960-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1580388865-9960-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.880-7.0-31-1
X-imss-scan-details: No--5.880-7.0-31-1;No--5.880-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(428003)(249900001)(199004)(189003)(498600001)(36756003)(5660300002)(8936002)(107886003)(42882007)(26005)(6266002)(450100002)(4326008)(70206006)(2616005)(42186006)(316002)(356004)(6666004)(81166006)(81156014)(2906002)(70586007)(8676002)(82310400001)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4818;H:xsj-pvapsmtpgw01;FPR:;SPF:None;LANG:en;PTR:unknown-60-83.xilinx.com;A:0;MX:0;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a26fdec-0929-4702-c434-08d7a5839270
X-MS-TrafficTypeDiagnostic: BL0PR02MB4818:
X-Microsoft-Antispam-PRVS: <BL0PR02MB481830C3E81645B769EFF817D5040@BL0PR02MB4818.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02981BE340
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYW+7YqwuMA0J9hmqT80eyRbwntWOxnBme3MCITE6Eld9ZVDhqIcVb++SPZxuF3zdOyiH3oRZ11scRiQOi/pOpBsJvTKiCRbNZ7nHuKj9poiBsI5eny9H0JlMAY45jt7lG0be7kAHWprDSZTigpszLGUKJ42VZbs1zmh5KGWWORgB6Oi84PEiZ4xwcn0u+qg9kL+ukiwqZe8lVYik2NdmgbG2BeO6aU/czVRrS0Ar9DCELeDBSqJ/jh+KkW3jwdzRs0W/jd12ahKwaTAki48C5x3jeZOWKpdhEYZ39JFvl3qTwGofNDS9b5iTlfqpjx+lXzxAh3Jxp+1sBmjcOvvJpxz0HKV8S0X+FGaxE2+PrlT70EpgADaLexXciuRwfzBo9M79celZjm1GTAhW7K2OpmCn8l/8yQKSDaMrCXRJRULJUDIdt1NI69YwHEPHeq7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 12:54:41.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a26fdec-0929-4702-c434-08d7a5839270
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4818
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In overlay application we noticed that dma channel node probe order is
inverted i.e s2mm channel is probed first followed by mm2s channel. The
reason for this inversion is fdtoverlay utility which uses a function
called fdt_add_subnode(*). It stores the subnodes after the properties,
this has the effect of inserting the new subnode before any others and
the end result is a reversal.

Because of this inverted channel probe order, the node probed first is
assigned a '0' index instead of Channel ID should be '0' for tx and '1'
for rx and dmatest client using the DT convention fails in dma transfer
as channel are swapped.

To fix above behavior and make channel assignment index independent
of probe order, always assign mm2s channel at '0' index and the s2mm
channel at IP specific fixed offset derived from the max_channels
count.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 2281af3..aecd5a3 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -488,16 +488,15 @@ struct xilinx_dma_config {
  * @txs_clk: DMA mm2s stream clock
  * @rx_clk: DMA s2mm clock
  * @rxs_clk: DMA s2mm stream clock
- * @nr_channels: Number of channels DMA device supports
- * @chan_id: DMA channel identifier
+ * @s2mm_chan_id: DMA s2mm channel identifier
+ * @mm2s_chan_id: DMA mm2s channel identifier
  * @max_buffer_len: Max buffer length
- * @s2mm_index: S2MM channel index
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
 	struct device *dev;
 	struct dma_device common;
-	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
+	struct xilinx_dma_chan *chan[XILINX_MCDMA_MAX_CHANS_PER_DEVICE];
 	u32 flush_on_fsync;
 	bool ext_addr;
 	struct platform_device  *pdev;
@@ -507,10 +506,9 @@ struct xilinx_dma_device {
 	struct clk *txs_clk;
 	struct clk *rx_clk;
 	struct clk *rxs_clk;
-	u32 nr_channels;
-	u32 chan_id;
+	u32 s2mm_chan_id;
+	u32 mm2s_chan_id;
 	u32 max_buffer_len;
-	u32 s2mm_index;
 };
 
 /* Macros */
@@ -1748,7 +1746,7 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	if (chan->direction == DMA_DEV_TO_MEM)
-		chan_offset = chan->xdev->s2mm_index;
+		chan_offset = chan->xdev->dma_config->max_channels / 2;
 
 	chan_offset = chan_offset + (chan_id - 1);
 	chan = chan->xdev->chan[chan_offset];
@@ -2734,12 +2732,11 @@ static void xdma_disable_allclks(struct xilinx_dma_device *xdev)
  *
  * @xdev: Driver specific device structure
  * @node: Device node
- * @chan_id: DMA Channel id
  *
  * Return: '0' on success and failure value on error
  */
 static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
-				  struct device_node *node, int chan_id)
+				  struct device_node *node)
 {
 	struct xilinx_dma_chan *chan;
 	bool has_dre = false;
@@ -2791,8 +2788,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
 	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
 		chan->direction = DMA_MEM_TO_DEV;
-		chan->id = chan_id;
-		chan->tdest = chan_id;
+		chan->id = xdev->mm2s_chan_id++;
+		chan->tdest = chan->id;
 
 		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2808,9 +2805,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		   of_device_is_compatible(node,
 					   "xlnx,axi-dma-s2mm-channel")) {
 		chan->direction = DMA_DEV_TO_MEM;
-		chan->id = chan_id;
-		xdev->s2mm_index = xdev->nr_channels;
-		chan->tdest = chan_id - xdev->nr_channels;
+		chan->id = xdev->s2mm_chan_id++;
+		chan->tdest = chan->id - xdev->dma_config->max_channels / 2;
 		chan->has_vflip = of_property_read_bool(node,
 					"xlnx,enable-vert-flip");
 		if (chan->has_vflip) {
@@ -2912,9 +2908,7 @@ static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
 		dev_warn(xdev->dev, "missing dma-channels property\n");
 
 	for (i = 0; i < nr_channels; i++)
-		xilinx_dma_chan_probe(xdev, node, xdev->chan_id++);
-
-	xdev->nr_channels += nr_channels;
+		xilinx_dma_chan_probe(xdev, node);
 
 	return 0;
 }
@@ -2932,7 +2926,7 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
 	struct xilinx_dma_device *xdev = ofdma->of_dma_data;
 	int chan_id = dma_spec->args[0];
 
-	if (chan_id >= xdev->nr_channels || !xdev->chan[chan_id])
+	if (chan_id >= xdev->dma_config->max_channels || !xdev->chan[chan_id])
 		return NULL;
 
 	return dma_get_slave_channel(&xdev->chan[chan_id]->common);
@@ -3019,6 +3013,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
+	xdev->s2mm_chan_id = xdev->dma_config->max_channels / 2;
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
 	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
@@ -3112,7 +3107,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
-		for (i = 0; i < xdev->nr_channels; i++)
+		for (i = 0; i < xdev->dma_config->max_channels; i++)
 			if (xdev->chan[i])
 				xdev->chan[i]->num_frms = num_frames;
 	}
@@ -3142,7 +3137,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 disable_clks:
 	xdma_disable_allclks(xdev);
 error:
-	for (i = 0; i < xdev->nr_channels; i++)
+	for (i = 0; i < xdev->dma_config->max_channels; i++)
 		if (xdev->chan[i])
 			xilinx_dma_chan_remove(xdev->chan[i]);
 
@@ -3164,7 +3159,7 @@ static int xilinx_dma_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&xdev->common);
 
-	for (i = 0; i < xdev->nr_channels; i++)
+	for (i = 0; i < xdev->dma_config->max_channels; i++)
 		if (xdev->chan[i])
 			xilinx_dma_chan_remove(xdev->chan[i]);
 
-- 
2.7.4

