Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E5314D9F8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 12:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA3Llp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 06:41:45 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37446 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3Llo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 06:41:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfc5p039522;
        Thu, 30 Jan 2020 05:41:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580384498;
        bh=nOaK30hKcU0nHopMIcNcNAI7Bta7pqRO8AZ6vId2DZU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iYEDvFcQ1/K+Xei33XXarqTk2bXsPv6Meu3Q+Fq4bt1TwJJwidwjI6nwQgYz2AS6t
         nCMmEbdIpnVJzX5i+etGWlch5N0I+txNPEYv5xyRZ6L2LFXXfRWYU8Mh84fHAMTOwy
         UPT/w4MdxQ/YFcnz4vezisOhneFcjnsLlTWGMvDo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfcUf008738;
        Thu, 30 Jan 2020 05:41:38 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 05:41:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 05:41:38 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UBfW7Y104655;
        Thu, 30 Jan 2020 05:41:36 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH 2/2] dmaengine: Add basic debugfs support
Date:   Thu, 30 Jan 2020 13:42:20 +0200
Message-ID: <20200130114220.23538-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130114220.23538-1-peter.ujfalusi@ti.com>
References: <20200130114220.23538-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Via the /sys/kernel/debug/dmaengine users can get information about the
DMA devices and the used channels.

Example output on am654-evm with audio using two channels and after running
dmatest on 6 channels:

 # cat /sys/kernel/debug/dmaengine
dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0:             2b00000.mcasp:tx
 dma1chan1:             2b00000.mcasp:rx
 dma1chan2:             in-use
 dma1chan3:             in-use
 dma1chan4:             in-use
 dma1chan5:             in-use
 dma1chan6:             in-use
 dma1chan7:             in-use

For slave channels we can show the device and the channel name a given
channel is requested.
For non slave devices the only information we know is that the channel is
in use.

DMA drivers can implement the optional dbg_show callback to provide
controller specific information instead of the generic one.

It is easy to extend the generic dmaengine_dbg_show() to print additional
information about the used channels.

I have taken the idea from gpiolib.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c   | 120 ++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  12 +++-
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 75516f9fbab4..7573a4d0f9d7 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -32,6 +32,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/platform_device.h>
+#include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -760,6 +761,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 		return chan ? chan : ERR_PTR(-EPROBE_DEFER);
 
 found:
+#ifdef CONFIG_DEBUG_FS
+	chan->slave_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev), name);
+	if (!chan->slave_name)
+		dev_warn(dev,
+			 "Cannot allocate memory for slave name (debugfs)\n");
+#endif
+
 	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
 	if (!chan->name) {
 		dev_warn(dev,
@@ -840,6 +848,13 @@ void dma_release_channel(struct dma_chan *chan)
 		chan->name = NULL;
 		chan->slave = NULL;
 	}
+
+#ifdef CONFIG_DEBUG_FS
+	if (chan->slave_name) {
+		kfree(chan->slave_name);
+		chan->slave_name = NULL;
+	}
+#endif
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
@@ -1562,3 +1577,108 @@ static int __init dma_bus_init(void)
 	return class_register(&dma_devclass);
 }
 arch_initcall(dma_bus_init);
+
+#ifdef CONFIG_DEBUG_FS
+static void *dmaengine_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct dma_device *dma_dev = NULL;
+	loff_t index = *pos;
+
+	s->private = "";
+
+	mutex_lock(&dma_list_mutex);
+	list_for_each_entry(dma_dev, &dma_device_list, global_node)
+		if (index-- == 0) {
+			mutex_unlock(&dma_list_mutex);
+			return dma_dev;
+		}
+	mutex_unlock(&dma_list_mutex);
+
+	return NULL;
+}
+
+static void *dmaengine_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct dma_device *dma_dev = v;
+	void *ret = NULL;
+
+	mutex_lock(&dma_list_mutex);
+	if (list_is_last(&dma_dev->global_node, &dma_device_list))
+		ret = NULL;
+	else
+		ret = list_entry(dma_dev->global_node.next,
+				 struct dma_device, global_node);
+	mutex_unlock(&dma_list_mutex);
+
+	s->private = "\n";
+	++*pos;
+
+	return ret;
+}
+
+static void dmaengine_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static void dmaengine_dbg_show(struct seq_file *s, struct dma_device *dma_dev)
+{
+	struct dma_chan *chan;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count) {
+			seq_printf(s, " dma%dchan%d:", dma_dev->dev_id,
+				   chan->chan_id);
+			if (chan->slave_name)
+				seq_printf(s, "\t\t%s\n", chan->slave_name);
+			else
+				seq_printf(s, "\t\t%s\n", "in-use");
+		}
+	}
+}
+
+static int dmaengine_seq_show(struct seq_file *s, void *v)
+{
+	struct dma_device *dma_dev = v;
+
+	seq_printf(s, "%sdma%d (%s): number of channels: %u\n",
+		   (char *)s->private, dma_dev->dev_id, dev_name(dma_dev->dev),
+		   dma_dev->chancnt);
+
+	if (dma_dev->dbg_show)
+		dma_dev->dbg_show(s, dma_dev);
+	else
+		dmaengine_dbg_show(s, dma_dev);
+
+	return 0;
+}
+
+static const struct seq_operations dmaengine_seq_ops = {
+	.start = dmaengine_seq_start,
+	.next = dmaengine_seq_next,
+	.stop = dmaengine_seq_stop,
+	.show = dmaengine_seq_show,
+};
+
+static int dmaengine_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &dmaengine_seq_ops);
+}
+
+static const struct file_operations dmaengine_operations = {
+	.owner		= THIS_MODULE,
+	.open		= dmaengine_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int __init dmaengine_debugfs_init(void)
+{
+	/* /sys/kernel/debug/dmaengine */
+	debugfs_create_file("dmaengine", S_IFREG | 0444, NULL, NULL,
+			    &dmaengine_operations);
+	return 0;
+}
+subsys_initcall(dmaengine_debugfs_init);
+
+#endif	/* DEBUG_FS */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 64461fc64e1b..5b9d6b1aa6e9 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -300,6 +300,8 @@ struct dma_router {
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @name: backlink name for sysfs
+ * @slave_name: slave name for debugfs in format:
+ *	dev_name(requester's dev):channel name, for example: "2b00000.mcasp:tx"
  * @device_node: used to add this to the device chan list
  * @local: per-cpu pointer to a struct dma_chan_percpu
  * @client_count: how many clients are using this channel
@@ -318,6 +320,9 @@ struct dma_chan {
 	int chan_id;
 	struct dma_chan_dev *dev;
 	const char *name;
+#ifdef CONFIG_DEBUG_FS
+	char *slave_name;
+#endif
 
 	struct list_head device_node;
 	struct dma_chan_percpu __percpu *local;
@@ -805,7 +810,9 @@ struct dma_filter {
  *     called and there are no further references to this structure. This
  *     must be implemented to free resources however many existing drivers
  *     do not and are therefore not safe to unbind while in use.
- *
+ * @dbg_show: optional routine to show contents in debugfs; default code
+ *     will be used when this is omitted, but custom code can show extra,
+ *     controller specific information.
  */
 struct dma_device {
 	struct kref ref;
@@ -891,6 +898,9 @@ struct dma_device {
 					    struct dma_tx_state *txstate);
 	void (*device_issue_pending)(struct dma_chan *chan);
 	void (*device_release)(struct dma_device *dev);
+#ifdef CONFIG_DEBUG_FS
+	void (*dbg_show)(struct seq_file *s, struct dma_device *dev);
+#endif
 };
 
 static inline int dmaengine_slave_config(struct dma_chan *chan,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

