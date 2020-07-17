Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6DC223059
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 03:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGQBeD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jul 2020 21:34:03 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41702 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgGQBeD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jul 2020 21:34:03 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D2840F7D;
        Fri, 17 Jul 2020 03:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594949633;
        bh=g7O/xJ/c7iD3cMa/cHDYZSB64RPg/unnqKp/oU38eE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uolKBFwv6ivDxMvGbImoIh6yUBV/J25mspSA9sMnPZYtuPePq0EznNp0ca4wgFRKQ
         cfgRGO0ElKa/eTw80K3vfVygQ7RR3oC+kq9NYbhHg8Z4/l83Pbq0GUov7wti8pBlgR
         oBUtcZRq4+bt4Ne8ox1pEmrXBnQzYj+Pg/W/ZRAA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v7 4/5] dmaengine: xilinx: dpdma: Add debugfs support
Date:   Fri, 17 Jul 2020 04:33:36 +0300
Message-Id: <20200717013337.24122-5-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
References: <20200717013337.24122-1-laurent.pinchart@ideasonboard.com>
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
Changes since v6:

- Move debugfs node to the dmaengine directory
- Destroy debugfs directory upon removal

Changes since v3:

- Return -EFAULT instead of bytes remaining after copy_to_user()

Changes since v2:

- Refactor debugfs code
---
 drivers/dma/xilinx/xilinx_dpdma.c | 238 ++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index af88a6762ef4..753c0c8c4833 100644
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
@@ -252,6 +253,7 @@ struct xilinx_dpdma_chan {
  * @axi_clk: axi clock
  * @chan: DPDMA channels
  * @ext_addr: flag for 64 bit system (48 bit addressing)
+ * @debugfs_dir: root debugfs directory for the device
  */
 struct xilinx_dpdma_device {
 	struct dma_device common;
@@ -263,8 +265,238 @@ struct xilinx_dpdma_device {
 	struct xilinx_dpdma_chan *chan[XILINX_DPDMA_NUM_CHAN];
 
 	bool ext_addr;
+
+	struct dentry *debugfs_dir;
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
+static void xilinx_dpdma_debugfs_cleanup(struct xilinx_dpdma_device *xdev)
+{
+	debugfs_remove_recursive(xdev->debugfs_dir);
+	xdev->debugfs_dir = NULL;
+}
+
+static int xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
+{
+	struct dentry *dent;
+
+	dpdma_debugfs.testcase = DPDMA_TC_NONE;
+
+	dent = debugfs_create_dir("dpdma", xdev->common.dbg_dev_root);
+	if (IS_ERR(dent)) {
+		dev_err(xdev->dev, "Failed to create debugfs directory\n");
+		return -ENODEV;
+	}
+
+	xdev->debugfs_dir = dent;
+
+	dent = debugfs_create_file("testcase", 0444, xdev->debugfs_dir, NULL,
+				   &fops_xilinx_dpdma_dbgfs);
+	if (IS_ERR(dent)) {
+		dev_err(xdev->dev, "Failed to cerate debugfs testcase file\n");
+		xilinx_dpdma_debugfs_cleanup(xdev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+#else
+static void xilinx_dpdma_debugfs_cleanup(struct xilinx_dpdma_device *xdev)
+{
+}
+
+static int xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
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
@@ -840,6 +1072,8 @@ static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
+	xilinx_dpdma_debugfs_desc_done_irq(chan);
+
 	if (active)
 		vchan_cyclic_callback(&active->vdesc);
 	else
@@ -1475,6 +1709,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	xilinx_dpdma_enable_irq(xdev);
 
+	xilinx_dpdma_debugfs_init(xdev);
+
 	dev_info(&pdev->dev, "Xilinx DPDMA engine is probed\n");
 
 	return 0;
@@ -1500,6 +1736,8 @@ static int xilinx_dpdma_remove(struct platform_device *pdev)
 	/* Start by disabling the IRQ to avoid races during cleanup. */
 	free_irq(xdev->irq, xdev);
 
+	xilinx_dpdma_debugfs_cleanup(xdev);
+
 	xilinx_dpdma_disable_irq(xdev);
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&xdev->common);
-- 
Regards,

Laurent Pinchart

