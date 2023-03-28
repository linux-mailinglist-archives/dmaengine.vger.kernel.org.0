Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E16CC69C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 17:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjC1PhP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 11:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjC1Pgg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 11:36:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD181040C;
        Tue, 28 Mar 2023 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017770; x=1711553770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ObaQS2pwjlIdSbSrb0xThYdsWIAaK38OpfGK6YL3zRc=;
  b=ZIv/wZCmoXylMch4yUqpHuHT4Vx0N8aNfNNzwehyfp8MjfrlQMfj4Oe8
   fiiXZJA/VjWmnIk9kRntNw8Mdp88/ajGF2sYE1fPWp4q0XJ7Py9HXISEX
   lnoqGHeqWo1JXzO9WOfT+DflCm4LZC2DbFfvH+SBzJfUNmGi0l+ab5igu
   M7njhm8gwQIAQ76QP77QhALrlBg6iiB5XyYyOXao/qGFyRV62pQGDXCew
   5AxoV2okAwMajcaXfmXtwD2WAeENbGkckKfvjgREPabhc5vJ5FjEdtyYA
   y3cRz5mlB/WbxbycbbPnDkd0WvUgto0xnCGHSik3jqmY+EHfGYif0uFs0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342192182"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342192182"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683948451"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683948451"
Received: from sdwarak1-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.127.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:36:05 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v2 10/15] crypto: iaa - Add per-cpu workqueue table with rebalancing
Date:   Tue, 28 Mar 2023 10:35:30 -0500
Message-Id: <20230328153535.126223-11-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The iaa compression/decompression algorithms in later patches need a
way to retrieve an appropriate IAA workqueue depending on how close
the associated IAA device is to the current cpu.

For this purpose, add a per-cpu array of workqueues such that an
appropriate workqueue can be retrieved by simply accessing the per-cpu
array.

Whenever a new workqueue is bound to or unbound from the iaa_crypto
driver, the available workqueues are 'rebalanced' such that work
submitted from a particular CPU is given to the most appropriate
workqueue available.  There currently isn't any way for the user to
tweak the way this is done internally - if necessary, knobs can be
added later for that purpose.  Current best practice is to configure
and bind at least one workqueue for each IAA device, but as long as
there is at least one workqueue configured and bound to any IAA device
in the system, the iaa_crypto driver will work, albeit most likely not
as efficiently.

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |   7 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 244 +++++++++++++++++++++
 2 files changed, 251 insertions(+)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 5d1fff7f4b8e..c25546fa87f7 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -27,4 +27,11 @@ struct iaa_device {
 	struct list_head		wqs;
 };
 
+struct wq_table_entry {
+	struct idxd_wq **wqs;
+	int	max_wqs;
+	int	n_wqs;
+	int	cur_wq;
+};
+
 #endif
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index c35a778d53a6..cf728cf8798f 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -22,10 +22,92 @@
 
 /* number of iaa instances probed */
 static unsigned int nr_iaa;
+static unsigned int nr_cpus;
+static unsigned int nr_nodes;
+static unsigned int nr_cpus_per_node;
+
+/* Number of physical cpus sharing each iaa instance */
+static unsigned int cpus_per_iaa;
+
+/* Per-cpu lookup table for balanced wqs */
+static struct wq_table_entry __percpu *wq_table;
+
+static void wq_table_add(int cpu, struct idxd_wq *wq)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
+
+	if (WARN_ON(entry->n_wqs == entry->max_wqs))
+		return;
+
+	entry->wqs[entry->n_wqs++] = wq;
+
+	pr_debug("%s: added iaa wq %d.%d to idx %d of cpu %d\n", __func__,
+		 entry->wqs[entry->n_wqs - 1]->idxd->id,
+		 entry->wqs[entry->n_wqs - 1]->id, entry->n_wqs - 1, cpu);
+}
+
+static void wq_table_free_entry(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
+
+	kfree(entry->wqs);
+	memset(entry, 0, sizeof(*entry));
+}
+
+static void wq_table_clear_entry(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
+
+	entry->n_wqs = 0;
+	entry->cur_wq = 0;
+	memset(entry->wqs, 0, entry->max_wqs * sizeof(struct idxd_wq *));
+}
 
 static LIST_HEAD(iaa_devices);
 static DEFINE_MUTEX(iaa_devices_lock);
 
+/*
+ * Given a cpu, find the closest IAA instance.  The idea is to try to
+ * choose the most appropriate IAA instance for a caller and spread
+ * available workqueues around to clients.
+ */
+static inline int cpu_to_iaa(int cpu)
+{
+	int node, n_cpus = 0, test_cpu, iaa = 0;
+	int nr_iaa_per_node, nr_cores_per_iaa;
+	const struct cpumask *node_cpus;
+
+	if (!nr_nodes)
+		return 0;
+
+	nr_iaa_per_node = nr_iaa / nr_nodes;
+	if (!nr_iaa_per_node)
+		return 0;
+
+	nr_cores_per_iaa = nr_cpus_per_node / nr_iaa_per_node;
+
+	for_each_online_node(node) {
+		node_cpus = cpumask_of_node(node);
+		if (!cpumask_test_cpu(cpu, node_cpus))
+			continue;
+
+		for_each_cpu(test_cpu, node_cpus) {
+			if ((n_cpus % nr_cpus_per_node) == 0)
+				iaa = node * nr_iaa_per_node;
+
+			if (test_cpu == cpu)
+				return iaa;
+
+			n_cpus++;
+
+			if ((n_cpus % cpus_per_iaa) == 0)
+				iaa++;
+		}
+	}
+
+	return -1;
+}
+
 static struct iaa_device *iaa_device_alloc(void)
 {
 	struct iaa_device *iaa_device;
@@ -141,6 +223,53 @@ static void del_iaa_wq(struct iaa_device *iaa_device, struct idxd_wq *wq)
 	}
 }
 
+static void clear_wq_table(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		wq_table_clear_entry(cpu);
+
+	pr_debug("cleared wq table\n");
+}
+
+static void free_wq_table(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		wq_table_free_entry(cpu);
+
+	free_percpu(wq_table);
+
+	pr_debug("freed wq table\n");
+}
+
+static int alloc_wq_table(int max_wqs)
+{
+	struct wq_table_entry *entry;
+	int cpu;
+
+	wq_table = alloc_percpu(struct wq_table_entry);
+	if (!wq_table)
+		return -ENOMEM;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		entry = per_cpu_ptr(wq_table, cpu);
+		entry->wqs = kzalloc(GFP_KERNEL, max_wqs * sizeof(struct wq *));
+		if (!entry->wqs) {
+			free_wq_table();
+			return -ENOMEM;
+		}
+
+		entry->max_wqs = max_wqs;
+	}
+
+	pr_debug("initialized wq table\n");
+
+	return 0;
+}
+
 static int save_iaa_wq(struct idxd_wq *wq)
 {
 	struct iaa_device *iaa_device, *found = NULL;
@@ -195,6 +324,8 @@ static int save_iaa_wq(struct idxd_wq *wq)
 		return -EINVAL;
 
 	idxd_wq_get(wq);
+
+	cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa;
 out:
 	return 0;
 }
@@ -210,6 +341,97 @@ static void remove_iaa_wq(struct idxd_wq *wq)
 			break;
 		}
 	}
+
+	if (nr_iaa)
+		cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa;
+	else
+		cpus_per_iaa = 0;
+}
+
+static int wq_table_add_wqs(int iaa, int cpu)
+{
+	struct iaa_device *iaa_device, *found_device = NULL;
+	int ret = 0, cur_iaa = 0, n_wqs_added = 0;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+
+	list_for_each_entry(iaa_device, &iaa_devices, list) {
+		idxd = iaa_device->idxd;
+		pdev = idxd->pdev;
+		dev = &pdev->dev;
+
+		if (cur_iaa != iaa) {
+			cur_iaa++;
+			continue;
+		}
+
+		found_device = iaa_device;
+		dev_dbg(dev, "getting wq from iaa_device %d, cur_iaa %d\n",
+			found_device->idxd->id, cur_iaa);
+		break;
+	}
+
+	if (!found_device) {
+		found_device = list_first_entry_or_null(&iaa_devices,
+							struct iaa_device, list);
+		if (!found_device) {
+			pr_debug("couldn't find any iaa devices with wqs!\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		cur_iaa = 0;
+
+		idxd = found_device->idxd;
+		pdev = idxd->pdev;
+		dev = &pdev->dev;
+		dev_dbg(dev, "getting wq from only iaa_device %d, cur_iaa %d\n",
+			found_device->idxd->id, cur_iaa);
+	}
+
+	list_for_each_entry(iaa_wq, &found_device->wqs, list) {
+		wq_table_add(cpu, iaa_wq->wq);
+		pr_debug("rebalance: added wq for cpu=%d: iaa wq %d.%d\n",
+			 cpu, iaa_wq->wq->idxd->id, iaa_wq->wq->id);
+		n_wqs_added++;
+	};
+
+	if (!n_wqs_added) {
+		pr_debug("couldn't find any iaa wqs!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static void rebalance_wq_table(void)
+{
+	int cpu, iaa;
+
+	if (nr_iaa == 0)
+		return;
+
+	clear_wq_table();
+
+	pr_debug("rebalance: nr_nodes=%d, nr_cpus %d, nr_iaa %d, cpus_per_iaa %d\n",
+		 nr_nodes, nr_cpus, nr_iaa, cpus_per_iaa);
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		iaa = cpu_to_iaa(cpu);
+		pr_debug("rebalance: cpu=%d iaa=%d\n", cpu, iaa);
+
+		if (WARN_ON(iaa == -1)) {
+			pr_debug("rebalance (cpu_to_iaa(%d)) failed!\n", cpu);
+			return;
+		}
+
+		if (WARN_ON(wq_table_add_wqs(iaa, cpu))) {
+			pr_debug("could not add any wqs for iaa %d to cpu %d!\n", iaa, cpu);
+			return;
+		}
+	}
 }
 
 static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
@@ -218,6 +440,7 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 	struct idxd_device *idxd = wq->idxd;
 	struct idxd_driver_data *data = idxd->data;
 	struct device *dev = &idxd_dev->conf_dev;
+	bool first_wq = false;
 	int ret = 0;
 
 	if (idxd->state != IDXD_DEV_ENABLED)
@@ -248,10 +471,19 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 
 	mutex_lock(&iaa_devices_lock);
 
+	if (list_empty(&iaa_devices)) {
+		ret = alloc_wq_table(wq->idxd->max_wqs);
+		if (ret)
+			goto err_alloc;
+		first_wq = true;
+	}
+
 	ret = save_iaa_wq(wq);
 	if (ret)
 		goto err_save;
 
+	rebalance_wq_table();
+
 	mutex_unlock(&iaa_devices_lock);
 out:
 	mutex_unlock(&wq->wq_lock);
@@ -259,6 +491,10 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 	return ret;
 
 err_save:
+	if (first_wq)
+		free_wq_table();
+err_alloc:
+	mutex_unlock(&iaa_devices_lock);
 	drv_disable_wq(wq);
 err:
 	wq->type = IDXD_WQT_NONE;
@@ -277,6 +513,10 @@ static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 
 	remove_iaa_wq(wq);
 	drv_disable_wq(wq);
+	rebalance_wq_table();
+
+	if (nr_iaa == 0)
+		free_wq_table();
 
 	mutex_unlock(&iaa_devices_lock);
 	mutex_unlock(&wq->wq_lock);
@@ -298,6 +538,10 @@ static int __init iaa_crypto_init_module(void)
 {
 	int ret = 0;
 
+	nr_cpus = num_online_cpus();
+	nr_nodes = num_online_nodes();
+	nr_cpus_per_node = boot_cpu_data.x86_max_cores;
+
 	ret = idxd_driver_register(&iaa_crypto_driver);
 	if (ret) {
 		pr_debug("IAA wq sub-driver registration failed\n");
-- 
2.34.1

