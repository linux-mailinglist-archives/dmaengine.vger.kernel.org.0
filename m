Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E91529B4
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBELQK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 06:16:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43562 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBELQK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Feb 2020 06:16:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 015BG18B054316;
        Wed, 5 Feb 2020 05:16:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580901361;
        bh=pbpHh099rDbmAhrqweejk71STC56PC+PVlT97eCxYhc=;
        h=From:To:CC:Subject:Date;
        b=MjFhnATFDk9Teer1vOn2c44pDZSaJxNjtuPM/YYjXL8yL0j9C0UiWAMJpegBc8l63
         zMGLCcUZu4KXkEzCW3wAm+bttLm1Z7CYXqIwubGvtdabk7Z0BqvkuIluGzHPqwTfdy
         WPsLPSR5YKmOwH+sJlMJexApzAIXA2R7JDpYyHYw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 015BG19Y111832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Feb 2020 05:16:01 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 05:15:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 05:15:59 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 015BFvGL017869;
        Wed, 5 Feb 2020 05:15:58 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
Subject: [PATCH v3] dmaengine: Add basic debugfs support
Date:   Wed, 5 Feb 2020 13:15:57 +0200
Message-ID: <20200205111557.24125-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
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
 dma1chan0    | 2b00000.mcasp:tx
 dma1chan1    | 2b00000.mcasp:rx
 dma1chan2    | in-use
 dma1chan3    | in-use
 dma1chan4    | in-use
 dma1chan5    | in-use
 dma1chan6    | in-use
 dma1chan7    | in-use

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
Hi,

Changes since v2:
- Use dma_chan_name() for printing the channel's name

Changes since v1:
- Use much more simplified fops for the debugfs file (via DEFINE_SHOW_ATTRIBUTE)
- do not allow modification to dma_device_list while the debugfs file is read
- rename the slave_name to dbg_client_name (it is only for debugging)
- print information about dma_router if it is used by the channel
- Formating of the output slightly changed

Regards,
Peter

 drivers/dma/dmaengine.c   | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h | 12 +++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c3b1283b6d31..37c3a4cd5b1a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -32,6 +32,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/platform_device.h>
+#include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -760,6 +761,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
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
@@ -837,6 +843,11 @@ void dma_release_channel(struct dma_chan *chan)
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
@@ -1562,3 +1573,57 @@ static int __init dma_bus_init(void)
 	return class_register(&dma_devclass);
 }
 arch_initcall(dma_bus_init);
+
+#ifdef CONFIG_DEBUG_FS
+static void dmaengine_dbg_show(struct seq_file *s, struct dma_device *dma_dev)
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
+static int dmaengine_debugfs_show(struct seq_file *s, void *data)
+{
+	struct dma_device *dma_dev = NULL;
+
+	mutex_lock(&dma_list_mutex);
+	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
+		seq_printf(s, "dma%d (%s): number of channels: %u\n",
+			   dma_dev->dev_id, dev_name(dma_dev->dev),
+			   dma_dev->chancnt);
+
+		if (dma_dev->dbg_show)
+			dma_dev->dbg_show(s, dma_dev);
+		else
+			dmaengine_dbg_show(s, dma_dev);
+
+		if (!list_is_last(&dma_dev->global_node, &dma_device_list))
+			seq_puts(s, "\n");
+	}
+	mutex_unlock(&dma_list_mutex);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(dmaengine_debugfs);
+
+static int __init dmaengine_debugfs_init(void)
+{
+	/* /sys/kernel/debug/dmaengine */
+	debugfs_create_file("dmaengine", 0444, NULL, NULL,
+			    &dmaengine_debugfs_fops);
+	return 0;
+}
+late_initcall(dmaengine_debugfs_init);
+
+#endif	/* DEBUG_FS */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 64461fc64e1b..9f232b7618f1 100644
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

