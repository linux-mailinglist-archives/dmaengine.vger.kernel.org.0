Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48D1460BD
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 03:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWCaG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 21:30:06 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59068 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgAWCaF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jan 2020 21:30:05 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2EF081228;
        Thu, 23 Jan 2020 03:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579746602;
        bh=MktafxUEhyCCPUJUg8yuDA263Q7rlUD1MU9sC04rBWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=En2snttYcJQSZsF6OHpXDHK6RrV1zVCQEkeWVJckKAo/1Zz+vW9l8cx/GnVnPmXns
         7SzNHeyvi3oOF1ImSSZ4ot45A2isJu6ZQ5yGo0FySSCskD6HUu+yNFVNL+NUZo8+dY
         sYFLgRUwd37L2GqGG6DTdwfhsDbDIksYXknq1c48=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: [PATCH v3 5/6] dmaengine: xilinx: dpdma: Add debugfs support
Date:   Thu, 23 Jan 2020 04:29:38 +0200
Message-Id: <20200123022939.9739-6-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
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
Changes since v2:

- Refactor debugfs code
---
 drivers/dma/xilinx/xilinx_dpdma.c | 227 ++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 15ba85aa63d9..a0df729e2034 100644
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
@@ -265,6 +266,228 @@ struct xilinx_dpdma_device {
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
+	int ret;
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
+	ret = copy_to_user(buf, kern_buff, size);
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
+static int xilinx_dpdma_debugfs_init(struct device *dev)
+{
+	int err;
+	struct dentry *xilinx_dpdma_debugfs_dir, *xilinx_dpdma_debugfs_file;
+
+	dpdma_debugfs.testcase = DPDMA_TC_NONE;
+
+	xilinx_dpdma_debugfs_dir = debugfs_create_dir("dpdma", NULL);
+	if (!xilinx_dpdma_debugfs_dir) {
+		dev_err(dev, "debugfs_create_dir failed\n");
+		return -ENODEV;
+	}
+
+	xilinx_dpdma_debugfs_file =
+		debugfs_create_file("testcase", 0444,
+				    xilinx_dpdma_debugfs_dir, NULL,
+				    &fops_xilinx_dpdma_dbgfs);
+	if (!xilinx_dpdma_debugfs_file) {
+		dev_err(dev, "debugfs_create_file testcase failed\n");
+		err = -ENODEV;
+		goto err_dbgfs;
+	}
+	return 0;
+
+err_dbgfs:
+	debugfs_remove_recursive(xilinx_dpdma_debugfs_dir);
+	xilinx_dpdma_debugfs_dir = NULL;
+	return err;
+}
+
+#else
+static int xilinx_dpdma_debugfs_init(struct device *dev)
+{
+	return 0;
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
@@ -840,6 +1063,8 @@ static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
+	xilinx_dpdma_debugfs_desc_done_irq(chan);
+
 	if (active)
 		vchan_cyclic_callback(&active->vdesc);
 	else
@@ -1469,6 +1694,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	xilinx_dpdma_enable_irq(xdev);
 
+	xilinx_dpdma_debugfs_init(&pdev->dev);
+
 	dev_info(&pdev->dev, "Xilinx DPDMA engine is probed\n");
 
 	return 0;
-- 
Regards,

Laurent Pinchart

