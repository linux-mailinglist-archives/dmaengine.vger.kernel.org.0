Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3C242DDE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Aug 2020 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHLRMw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Aug 2020 13:12:52 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54712 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHLRMv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Aug 2020 13:12:51 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 590A49E7;
        Wed, 12 Aug 2020 19:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597252368;
        bh=QoKbFMycp/gY2/n2EwpisDURT2EHGgua9YLB785v7O4=;
        h=From:To:Cc:Subject:Date:From;
        b=tpU3TZgu08QaYdjnLXvGPtf9kYWvjzQ5KRms2QPcQupZqods2EoFLxsOzy1ypOOS4
         ZVc2LMcJTEdphc4UR3oSbClStV1eNWrujM/zwyvSI3wHGNkhDWQ1k9YOdjrg8lEv5o
         Y885RNhpzigeTsxurGC/9sgefmeterVvfiZ5RNJc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: xilinx: dpdma: Add debugfs support
Date:   Wed, 12 Aug 2020 20:12:28 +0300
Message-Id: <20200812171228.9751-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Expose statistics to debugfs when available. This helps debugging issues
with the DPDMA driver.

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v7:

- Don't cerate dpdma debugfs subdirectory
- Don't consider debugfs initialization error as a failure

Changes since v6:

- Move debugfs node to the dmaengine directory
- Destroy debugfs directory upon removal

Changes since v3:

- Return -EFAULT instead of bytes remaining after copy_to_user()

Changes since v2:

- Refactor debugfs code
---
 drivers/dma/xilinx/xilinx_dpdma.c | 209 ++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index b37197c772aa..7db70d226e89 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -10,6 +10,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
@@ -266,6 +267,210 @@ struct xilinx_dpdma_device {
 	bool ext_addr;
 };
 
+/* -----------------------------------------------------------------------------
+ * DebugFS
+ */
+
+#ifdef CONFIG_DEBUG_FS
+
+#define XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE	32
+#define XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR	"65535"
+
+/* Match xilinx_dpdma_testcases vs dpdma_debugfs_reqs[] entry */
+enum xilinx_dpdma_testcases {
+	DPDMA_TC_INTR_DONE,
+	DPDMA_TC_NONE
+};
+
+struct xilinx_dpdma_debugfs {
+	enum xilinx_dpdma_testcases testcase;
+	u16 xilinx_dpdma_irq_done_count;
+	unsigned int chan_id;
+};
+
+static struct xilinx_dpdma_debugfs dpdma_debugfs;
+struct xilinx_dpdma_debugfs_request {
+	const char *name;
+	enum xilinx_dpdma_testcases tc;
+	ssize_t (*read)(char *buf);
+	int (*write)(char *args);
+};
+
+static void xilinx_dpdma_debugfs_desc_done_irq(struct xilinx_dpdma_chan *chan)
+{
+	if (chan->id == dpdma_debugfs.chan_id)
+		dpdma_debugfs.xilinx_dpdma_irq_done_count++;
+}
+
+static ssize_t xilinx_dpdma_debugfs_desc_done_irq_read(char *buf)
+{
+	size_t out_str_len;
+
+	dpdma_debugfs.testcase = DPDMA_TC_NONE;
+
+	out_str_len = strlen(XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR);
+	out_str_len = min_t(size_t, XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE,
+			    out_str_len);
+	snprintf(buf, out_str_len, "%d",
+		 dpdma_debugfs.xilinx_dpdma_irq_done_count);
+
+	return 0;
+}
+
+static int xilinx_dpdma_debugfs_desc_done_irq_write(char *args)
+{
+	char *arg;
+	int ret;
+	u32 id;
+
+	arg = strsep(&args, " ");
+	if (!arg || strncasecmp(arg, "start", 5))
+		return -EINVAL;
+
+	arg = strsep(&args, " ");
+	if (!arg)
+		return -EINVAL;
+
+	ret = kstrtou32(arg, 0, &id);
+	if (ret < 0)
+		return ret;
+
+	if (id < ZYNQMP_DPDMA_VIDEO0 || id > ZYNQMP_DPDMA_AUDIO1)
+		return -EINVAL;
+
+	dpdma_debugfs.testcase = DPDMA_TC_INTR_DONE;
+	dpdma_debugfs.xilinx_dpdma_irq_done_count = 0;
+	dpdma_debugfs.chan_id = id;
+
+	return 0;
+}
+
+/* Match xilinx_dpdma_testcases vs dpdma_debugfs_reqs[] entry */
+struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
+	{
+		.name = "DESCRIPTOR_DONE_INTR",
+		.tc = DPDMA_TC_INTR_DONE,
+		.read = xilinx_dpdma_debugfs_desc_done_irq_read,
+		.write = xilinx_dpdma_debugfs_desc_done_irq_write,
+	},
+};
+
+static ssize_t xilinx_dpdma_debugfs_read(struct file *f, char __user *buf,
+					 size_t size, loff_t *pos)
+{
+	enum xilinx_dpdma_testcases testcase;
+	char *kern_buff;
+	int ret = 0;
+
+	if (*pos != 0 || size <= 0)
+		return -EINVAL;
+
+	kern_buff = kzalloc(XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE, GFP_KERNEL);
+	if (!kern_buff) {
+		dpdma_debugfs.testcase = DPDMA_TC_NONE;
+		return -ENOMEM;
+	}
+
+	testcase = READ_ONCE(dpdma_debugfs.testcase);
+	if (testcase != DPDMA_TC_NONE) {
+		ret = dpdma_debugfs_reqs[testcase].read(kern_buff);
+		if (ret < 0)
+			goto done;
+	} else {
+		strlcpy(kern_buff, "No testcase executed",
+			XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE);
+	}
+
+	size = min(size, strlen(kern_buff));
+	if (copy_to_user(buf, kern_buff, size))
+		ret = -EFAULT;
+
+done:
+	kfree(kern_buff);
+	if (ret)
+		return ret;
+
+	*pos = size + 1;
+	return size;
+}
+
+static ssize_t xilinx_dpdma_debugfs_write(struct file *f,
+					  const char __user *buf, size_t size,
+					  loff_t *pos)
+{
+	char *kern_buff, *kern_buff_start;
+	char *testcase;
+	unsigned int i;
+	int ret;
+
+	if (*pos != 0 || size <= 0)
+		return -EINVAL;
+
+	/* Supporting single instance of test as of now. */
+	if (dpdma_debugfs.testcase != DPDMA_TC_NONE)
+		return -EBUSY;
+
+	kern_buff = kzalloc(size, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+	kern_buff_start = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, buf, size);
+	if (ret < 0)
+		goto done;
+
+	/* Read the testcase name from a user request. */
+	testcase = strsep(&kern_buff, " ");
+
+	for (i = 0; i < ARRAY_SIZE(dpdma_debugfs_reqs); i++) {
+		if (!strcasecmp(testcase, dpdma_debugfs_reqs[i].name))
+			break;
+	}
+
+	if (i == ARRAY_SIZE(dpdma_debugfs_reqs)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = dpdma_debugfs_reqs[i].write(kern_buff);
+	if (ret < 0)
+		goto done;
+
+	ret = size;
+
+done:
+	kfree(kern_buff_start);
+	return ret;
+}
+
+static const struct file_operations fops_xilinx_dpdma_dbgfs = {
+	.owner = THIS_MODULE,
+	.read = xilinx_dpdma_debugfs_read,
+	.write = xilinx_dpdma_debugfs_write,
+};
+
+static void xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
+{
+	struct dentry *dent;
+
+	dpdma_debugfs.testcase = DPDMA_TC_NONE;
+
+	dent = debugfs_create_file("testcase", 0444, xdev->common.dbg_dev_root,
+				   NULL, &fops_xilinx_dpdma_dbgfs);
+	if (IS_ERR(dent))
+		dev_err(xdev->dev, "Failed to create debugfs testcase file\n");
+}
+
+#else
+static void xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
+{
+}
+
+static void xilinx_dpdma_debugfs_desc_done_irq(struct xilinx_dpdma_chan *chan)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 /* -----------------------------------------------------------------------------
  * I/O Accessors
  */
@@ -842,6 +1047,8 @@ static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
+	xilinx_dpdma_debugfs_desc_done_irq(chan);
+
 	if (active)
 		vchan_cyclic_callback(&active->vdesc);
 	else
@@ -1477,6 +1684,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	xilinx_dpdma_enable_irq(xdev);
 
+	xilinx_dpdma_debugfs_init(xdev);
+
 	dev_info(&pdev->dev, "Xilinx DPDMA engine is probed\n");
 
 	return 0;
-- 
Regards,

Laurent Pinchart

