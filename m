Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD09F2513
	for <lists+dmaengine@lfdr.de>; Thu,  7 Nov 2019 03:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfKGCOR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 21:14:17 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47162 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbfKGCOR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 21:14:17 -0500
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C352B8C;
        Thu,  7 Nov 2019 03:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1573092855;
        bh=eYC5ZV8XZDzkuFNTokw7SBmwDzQ5FrQmR7JvaQ83Aas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Svn4od+7JNaCd6boEVMc2D1f5YNHT/nOYX7C+vhcD3TbVdtmnXcKf78F68Dr5p+uB
         tF+KVLNqum5mtq/3IEPpwCLSaps2dSuRWnE0afBjsQQpbWOJ9cNLKr3/q2EXvtnHvG
         GDA5kJv9EpQBPBDKKCF5sS9g0DpoGGIVrAM+wqqg=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     dmaengine@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: [PATCH v2 3/4] dma: xilinx: dpdma: Add debugfs support
Date:   Thu,  7 Nov 2019 04:13:59 +0200
Message-Id: <20191107021400.16474-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
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
 drivers/dma/xilinx/xilinx_dpdma.c | 238 ++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index a8420b485ebc..3ca36a7cbcd9 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -10,6 +10,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmaengine.h>
@@ -313,6 +314,239 @@ struct xilinx_dpdma_device {
 			  dma_addr_t dma_addr[], unsigned int num_src_addr);
 };
 
+/* -----------------------------------------------------------------------------
+ * DebugFS
+ */
+
+#ifdef CONFIG_DEBUG_FS
+
+#define XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE	32
+#define XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR	"65535"
+#define IN_RANGE(x, min, max) ({		\
+		typeof(x) _x = (x);		\
+		_x >= (min) && _x <= (max); })
+
+/* Match xilinx_dpdma_testcases vs dpdma_debugfs_reqs[] entry */
+enum xilinx_dpdma_testcases {
+	DPDMA_TC_INTR_DONE,
+	DPDMA_TC_NONE
+};
+
+struct xilinx_dpdma_debugfs {
+	enum xilinx_dpdma_testcases testcase;
+	u16 xilinx_dpdma_intr_done_count;
+	unsigned int chan_id;
+};
+
+static struct xilinx_dpdma_debugfs dpdma_debugfs;
+struct xilinx_dpdma_debugfs_request {
+	const char *req;
+	enum xilinx_dpdma_testcases tc;
+	ssize_t (*read_handler)(char **kern_buff);
+	ssize_t (*write_handler)(char **cmd);
+};
+
+static void xilinx_dpdma_debugfs_intr_done_count_incr(int chan_id)
+{
+	if (chan_id == dpdma_debugfs.chan_id)
+		dpdma_debugfs.xilinx_dpdma_intr_done_count++;
+}
+
+static s64 xilinx_dpdma_debugfs_argument_value(char *arg)
+{
+	s64 value;
+
+	if (!arg)
+		return -1;
+
+	if (!kstrtos64(arg, 0, &value))
+		return value;
+
+	return -1;
+}
+
+static ssize_t
+xilinx_dpdma_debugfs_desc_done_intr_write(char **dpdma_test_arg)
+{
+	char *arg;
+	char *arg_chan_id;
+	s64 id;
+
+	arg = strsep(dpdma_test_arg, " ");
+	if (strncasecmp(arg, "start", 5) != 0)
+		return -EINVAL;
+
+	arg_chan_id = strsep(dpdma_test_arg, " ");
+	id = xilinx_dpdma_debugfs_argument_value(arg_chan_id);
+
+	if (id < 0 || !IN_RANGE(id, ZYNQMP_DPDMA_VIDEO0, ZYNQMP_DPDMA_AUDIO1))
+		return -EINVAL;
+
+	dpdma_debugfs.testcase = DPDMA_TC_INTR_DONE;
+	dpdma_debugfs.xilinx_dpdma_intr_done_count = 0;
+	dpdma_debugfs.chan_id = id;
+
+	return 0;
+}
+
+static ssize_t xilinx_dpdma_debugfs_desc_done_intr_read(char **kern_buff)
+{
+	size_t out_str_len;
+
+	dpdma_debugfs.testcase = DPDMA_TC_NONE;
+
+	out_str_len = strlen(XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR);
+	out_str_len = min_t(size_t, XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE,
+			    out_str_len);
+	snprintf(*kern_buff, out_str_len, "%d",
+		 dpdma_debugfs.xilinx_dpdma_intr_done_count);
+
+	return 0;
+}
+
+/* Match xilinx_dpdma_testcases vs dpdma_debugfs_reqs[] entry */
+struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
+	{"DESCRIPTOR_DONE_INTR", DPDMA_TC_INTR_DONE,
+			xilinx_dpdma_debugfs_desc_done_intr_read,
+			xilinx_dpdma_debugfs_desc_done_intr_write},
+};
+
+static ssize_t xilinx_dpdma_debugfs_write(struct file *f, const char __user
+					       *buf, size_t size, loff_t *pos)
+{
+	char *kern_buff, *kern_buff_start;
+	char *dpdma_test_req;
+	int ret;
+	int i;
+
+	if (*pos != 0 || size <= 0)
+		return -EINVAL;
+
+	/* Supporting single instance of test as of now*/
+	if (dpdma_debugfs.testcase != DPDMA_TC_NONE)
+		return -EBUSY;
+
+	kern_buff = kzalloc(size, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+	kern_buff_start = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, buf, size);
+	if (ret < 0) {
+		kfree(kern_buff_start);
+		return ret;
+	}
+
+	/* Read the testcase name from a user request */
+	dpdma_test_req = strsep(&kern_buff, " ");
+
+	for (i = 0; i < ARRAY_SIZE(dpdma_debugfs_reqs); i++) {
+		if (!strcasecmp(dpdma_test_req, dpdma_debugfs_reqs[i].req)) {
+			if (!dpdma_debugfs_reqs[i].write_handler(&kern_buff)) {
+				kfree(kern_buff_start);
+				return size;
+			}
+			break;
+		}
+	}
+	kfree(kern_buff_start);
+	return -EINVAL;
+}
+
+static ssize_t xilinx_dpdma_debugfs_read(struct file *f, char __user *buf,
+					 size_t size, loff_t *pos)
+{
+	char *kern_buff = NULL;
+	size_t kern_buff_len, out_str_len;
+	enum xilinx_dpdma_testcases tc;
+	int ret;
+
+	if (size <= 0)
+		return -EINVAL;
+
+	if (*pos != 0)
+		return 0;
+
+	kern_buff = kzalloc(XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE, GFP_KERNEL);
+	if (!kern_buff) {
+		dpdma_debugfs.testcase = DPDMA_TC_NONE;
+		return -ENOMEM;
+	}
+
+	tc = dpdma_debugfs.testcase;
+	if (tc == DPDMA_TC_NONE) {
+		out_str_len = strlen("No testcase executed");
+		out_str_len = min_t(size_t, XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE,
+				    out_str_len);
+		snprintf(kern_buff, out_str_len, "%s", "No testcase executed");
+	} else {
+		ret = dpdma_debugfs_reqs[tc].read_handler(&kern_buff);
+		if (ret) {
+			kfree(kern_buff);
+			return ret;
+		}
+	}
+
+	kern_buff_len = strlen(kern_buff);
+	size = min(size, kern_buff_len);
+
+	ret = copy_to_user(buf, kern_buff, size);
+
+	kfree(kern_buff);
+	if (ret)
+		return ret;
+
+	*pos = size + 1;
+	return size;
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
+static void xilinx_dpdma_debugfs_intr_done_count_incr(int chan_id)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 /* -----------------------------------------------------------------------------
  * I/O Accessors
  */
@@ -709,6 +943,8 @@ static void xilinx_dpdma_chan_desc_done_intr(struct xilinx_dpdma_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
+	xilinx_dpdma_debugfs_intr_done_count_incr(chan->id);
+
 	if (!chan->active_desc) {
 		dev_dbg(chan->xdev->dev, "done intr with no active desc\n");
 		goto out_unlock;
@@ -2008,6 +2244,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
 
 	xilinx_dpdma_enable_intr(xdev);
 
+	xilinx_dpdma_debugfs_init(&pdev->dev);
+
 	dev_info(&pdev->dev, "Xilinx DPDMA engine is probed\n");
 
 	return 0;
-- 
Regards,

Laurent Pinchart

