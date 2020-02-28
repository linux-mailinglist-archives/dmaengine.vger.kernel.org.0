Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4926A1737E5
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2020 14:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB1NIC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Feb 2020 08:08:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38570 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1NIB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Feb 2020 08:08:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01SD7pZQ011550;
        Fri, 28 Feb 2020 07:07:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582895271;
        bh=42Kd2NmuD2KX5smzhDQPlg7uqqCq2Ohxi2uxGYOlrRk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XpPA8fA1N6ZSydpnC6AxKKDXVAmASiKzjM2GQCdYJsbTa+tSzv1HF6GvJf4Gie972
         rHRimTp+LTBSxuaAHjIHKHmHxN425Y4HROUyPXxjlnq9O66T38RlRtGXxIcJwaT2iA
         +bdmnNwxUILjWDcupmgrJVOApvVVWUwIYqMzNf4Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01SD7prU105541;
        Fri, 28 Feb 2020 07:07:51 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 07:07:51 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 07:07:51 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01SD7lct037330;
        Fri, 28 Feb 2020 07:07:50 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v4 1/2] dmaengine: Add basic debugfs support
Date:   Fri, 28 Feb 2020 15:07:46 +0200
Message-ID: <20200228130747.22905-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228130747.22905-1-peter.ujfalusi@ti.com>
References: <20200228130747.22905-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Via the /sys/kernel/debug/dmaengine/summary users can get information
about the DMA devices and the used channels.

Example output on am654-evm with audio using two channels and after running
dmatest on 4 channels:

dma0 (285c0000.dma-controller): number of channels: 96

dma1 (31150000.dma-controller): number of channels: 267
 dma1chan0    | 2b00000.mcasp:tx
 dma1chan1    | 2b00000.mcasp:rx
 dma1chan2    | in-use
 dma1chan3    | in-use
 dma1chan4    | in-use
 dma1chan5    | in-use

For slave channels we can show the device and the channel name a given
channel is requested.
For non slave devices the only information we know is that the channel is
in use.

DMA drivers can implement the optional dbg_summary_show callback to
provide controller specific information instead of the generic one.

It is easy to extend the generic dmaengine_summary_show() to print
additional information about the used channels.

In case DMA drivers want to create additional files under the dmaengine
directory to provide additional debug points, they can use the
dmaengine_get_debugfs_root() to get the dentry of the rootdir.

I have taken the idea from gpiolib and clk subsystems.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c   | 77 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/dmaengine.h   |  6 +++
 include/linux/dmaengine.h | 12 +++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c3b1283b6d31..b5e8b737785c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -760,6 +760,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 		return chan ? chan : ERR_PTR(-EPROBE_DEFER);
 
 found:
+#ifdef CONFIG_DEBUG_FS
+	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
+					  name);
+#endif
+
 	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
 	if (!chan->name)
 		return chan;
@@ -837,6 +842,11 @@ void dma_release_channel(struct dma_chan *chan)
 		chan->name = NULL;
 		chan->slave = NULL;
 	}
+
+#ifdef CONFIG_DEBUG_FS
+	kfree(chan->dbg_client_name);
+	chan->dbg_client_name = NULL;
+#endif
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
@@ -1562,3 +1572,70 @@ static int __init dma_bus_init(void)
 	return class_register(&dma_devclass);
 }
 arch_initcall(dma_bus_init);
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *rootdir;
+
+struct dentry *dmaengine_get_debugfs_root(void)
+{
+	return rootdir;
+}
+EXPORT_SYMBOL_GPL(dmaengine_get_debugfs_root);
+
+static void dmaengine_dbg_summary_show(struct seq_file *s,
+				       struct dma_device *dma_dev)
+{
+	struct dma_chan *chan;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count) {
+			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
+				   chan->dbg_client_name ?: "in-use");
+
+			if (chan->router)
+				seq_printf(s, " (via router: %s)\n",
+					dev_name(chan->router->dev));
+			else
+				seq_puts(s, "\n");
+		}
+	}
+}
+
+static int dmaengine_summary_show(struct seq_file *s, void *data)
+{
+	struct dma_device *dma_dev = NULL;
+
+	mutex_lock(&dma_list_mutex);
+	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
+		seq_printf(s, "dma%d (%s): number of channels: %u\n",
+			   dma_dev->dev_id, dev_name(dma_dev->dev),
+			   dma_dev->chancnt);
+
+		if (dma_dev->dbg_summary_show)
+			dma_dev->dbg_summary_show(s, dma_dev);
+		else
+			dmaengine_dbg_summary_show(s, dma_dev);
+
+		if (!list_is_last(&dma_dev->global_node, &dma_device_list))
+			seq_puts(s, "\n");
+	}
+	mutex_unlock(&dma_list_mutex);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(dmaengine_summary);
+
+static int __init dmaengine_debugfs_init(void)
+{
+	rootdir = debugfs_create_dir("dmaengine", NULL);
+
+	/* /sys/kernel/debug/dmaengine */
+	debugfs_create_file("summary", 0444, rootdir, NULL,
+			    &dmaengine_summary_fops);
+	return 0;
+}
+late_initcall(dmaengine_debugfs_init);
+
+#endif	/* DEBUG_FS */
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index e8a320c9e57c..72cd7fe33638 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -182,4 +182,10 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+struct dentry *dmaengine_get_debugfs_root(void);
+#endif
+
 #endif
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 64461fc64e1b..a0fff2f9f3b5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -300,6 +300,8 @@ struct dma_router {
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @name: backlink name for sysfs
+ * @dbg_client_name: slave name for debugfs in format:
+ *	dev_name(requester's dev):channel name, for example: "2b00000.mcasp:tx"
  * @device_node: used to add this to the device chan list
  * @local: per-cpu pointer to a struct dma_chan_percpu
  * @client_count: how many clients are using this channel
@@ -318,6 +320,9 @@ struct dma_chan {
 	int chan_id;
 	struct dma_chan_dev *dev;
 	const char *name;
+#ifdef CONFIG_DEBUG_FS
+	char *dbg_client_name;
+#endif
 
 	struct list_head device_node;
 	struct dma_chan_percpu __percpu *local;
@@ -805,7 +810,9 @@ struct dma_filter {
  *     called and there are no further references to this structure. This
  *     must be implemented to free resources however many existing drivers
  *     do not and are therefore not safe to unbind while in use.
- *
+ * @dbg_summary_show: optional routine to show contents in debugfs; default code
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
+	void (*dbg_summary_show)(struct seq_file *s, struct dma_device *dev);
+#endif
 };
 
 static inline int dmaengine_slave_config(struct dma_chan *chan,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

