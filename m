Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6C367491
	for <lists+dmaengine@lfdr.de>; Wed, 21 Apr 2021 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbhDUVFf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Apr 2021 17:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240539AbhDUVFf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Apr 2021 17:05:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D1156140F;
        Wed, 21 Apr 2021 21:05:00 +0000 (UTC)
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     vkoul@kernel.org
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 1/2] dmaengine: idxd: Add IDXD performance monitor support
Date:   Wed, 21 Apr 2021 16:04:54 -0500
Message-Id: <33de3d43f8151f75eba1e993d82398847b886e52.1619033785.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1619033785.git.zanussi@kernel.org>
References: <cover.1619033785.git.zanussi@kernel.org>
In-Reply-To: <cover.1619033785.git.zanussi@kernel.org>
References: <cover.1619033785.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Implement the IDXD performance monitor capability (named 'perfmon' in
the DSA (Data Streaming Accelerator) spec [1]), which supports the
collection of information about key events occurring during DSA and
IAX (Intel Analytics Accelerator) device execution, to assist in
performance tuning and debugging.

The idxd perfmon support is implemented as part of the IDXD driver and
interfaces with the Linux perf framework.  It has several features in
common with the existing uncore pmu support:

  - it does not support sampling
  - does not support per-thread counting

However it also has some unique features not present in the core and
uncore support:

  - all general-purpose counters are identical, thus no event constraints
  - operation is always system-wide

While the core perf subsystem assumes that all counters are by default
per-cpu, the uncore pmus are socket-scoped and use a cpu mask to
restrict counting to one cpu from each socket.  IDXD counters use a
similar strategy but expand the scope even further; since IDXD
counters are system-wide and can be read from any cpu, the IDXD perf
driver picks a single cpu to do the work (with cpu hotplug notifiers
to choose a different cpu if the chosen one is taken off-line).

More specifically, the perf userspace tool by default opens a counter
for each cpu for an event.  However, if it finds a cpumask file
associated with the pmu under sysfs, as is the case with the uncore
pmus, it will open counters only on the cpus specified by the cpumask.
Since perfmon only needs to open a single counter per event for a
given IDXD device, the perfmon driver will create a sysfs cpumask file
for the device and insert the first cpu of the system into it.  When a
user uses perf to open an event, perf will open a single counter on
the cpu specified by the cpu mask.  This amounts to the default
system-wide rather than per-cpu counting mentioned previously for
perfmon pmu events.  In order to keep the cpu mask up-to-date, the
driver implements cpu hotplug support for multiple devices, as IDXD
usually enumerates and registers more than one idxd device.

The perfmon driver implements basic perfmon hardware capability
discovery and configuration, and is initialized by the IDXD driver's
probe function.  During initialization, the driver retrieves the total
number of supported performance counters, the pmu ID, and the device
type from idxd device, and registers itself under the Linux perf
framework.

The perf userspace tool can be used to monitor single or multiple
events depending on the given configuration, as well as event groups,
which are also supported by the perfmon driver.  The user configures
events using the perf tool command-line interface by specifying the
event and corresponding event category, along with an optional set of
filters that can be used to restrict counting to specific work queues,
traffic classes, page and transfer sizes, and engines (See [1] for
specifics).

With the configuration specified by the user, the perf tool issues a
system call passing that information to the kernel, which uses it to
initialize the specified event(s).  The event(s) are opened and
started, and following termination of the perf command, they're
stopped.  At that point, the perfmon driver will read the latest count
for the event(s), calculate the difference between the latest counter
values and previously tracked counter values, and display the final
incremental count as the event count for the cycle.  An overflow
handler registered on the IDXD irq path is used to account for counter
overflows, which are signaled by an overflow interrupt.

Below are a couple of examples of perf usage for monitoring DSA events.

The following monitors all events in the 'engine' category.  Becuuse
no filters are specified, this captures all engine events for the
workload, which in this case is 19 iterations of the work generated by
the kernel dmatest module.

Details describing the events can be found in Appendix D of [1],
Performance Monitoring Events, but briefly they are:

  event 0x1:  total input data processed, in 32-byte units
  event 0x2:  total data written, in 32-byte units
  event 0x4:  number of work descriptors that read the source
  event 0x8:  number of work descriptors that write the destination
  event 0x10: number of work descriptors dispatched from batch descriptors
  event 0x20: number of work descriptors dispatched from work queues

 # perf stat -e dsa0/event=0x1,event_category=0x1/,
                dsa0/event=0x2,event_category=0x1/,
		dsa0/event=0x4,event_category=0x1/,
		dsa0/event=0x8,event_category=0x1/,
		dsa0/event=0x10,event_category=0x1/,
		dsa0/event=0x20,event_category=0x1/
		  modprobe dmatest channel=dma0chan0 timeout=2000
		  iterations=19 run=1 wait=1

     Performance counter stats for 'system wide':

                 5,332      dsa0/event=0x1,event_category=0x1/
                 5,327      dsa0/event=0x2,event_category=0x1/
                    19      dsa0/event=0x4,event_category=0x1/
                    19      dsa0/event=0x8,event_category=0x1/
                     0      dsa0/event=0x10,event_category=0x1/
                    19      dsa0/event=0x20,event_category=0x1/

          21.977436186 seconds time elapsed

The command below illustrates filter usage with a simple example.  It
specifies that MEM_MOVE operations should be counted for the DSA
device dsa0 (event 0x8 corresponds to the EV_MEM_MOVE event - Number
of Memory Move Descriptors, which is part of event category 0x3 -
Operations. The detailed category and event IDs are available in
Appendix D, Performance Monitoring Events, of [1]).  In addition to
the event and event category, a number of filters are also specified
(the detailed filter values are available in Chapter 6.4 (Filter
Support) of [1]), which will restrict counting to only those events
that meet all of the filter criteria.  In this case, the filters
specify that only MEM_MOVE operations that are serviced by work queue
wq0 and specifically engine number engine0 and traffic class tc0
having sizes between 0 and 4k and page size of between 0 and 1G result
in a counter hit; anything else will be filtered out and not appear in
the final count.  Note that filters are optional - any filter not
specified is assumed to be all ones and will pass anything.

 # perf stat -e dsa0/filter_wq=0x1,filter_tc=0x1,filter_sz=0x7,
                filter_eng=0x1,event=0x8,event_category=0x3/
		  modprobe dmatest channel=dma0chan0 timeout=2000
		  iterations=19 run=1 wait=1

     Performance counter stats for 'system wide':

       19      dsa0/filter_wq=0x1,filter_tc=0x1,filter_sz=0x7,
               filter_eng=0x1,event=0x8,event_category=0x3/

          21.865914091 seconds time elapsed

The output above reflects that the unspecified workload resulted in
the counting of 19 MEM_MOVE operation events that met the filter
criteria.

[1]: https://software.intel.com/content/www/us/en/develop/download/intel-data-streaming-accelerator-preliminary-architecture-specification.html

[ Based on work originally by Jing Lin. ]

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../sysfs-bus-event_source-devices-dsa        |  30 +
 drivers/dma/Kconfig                           |  12 +
 drivers/dma/idxd/Makefile                     |   2 +
 drivers/dma/idxd/idxd.h                       |  45 ++
 drivers/dma/idxd/perfmon.c                    | 662 ++++++++++++++++++
 drivers/dma/idxd/perfmon.h                    | 119 ++++
 drivers/dma/idxd/registers.h                  | 108 +++
 include/linux/cpuhotplug.h                    |   1 +
 8 files changed, 979 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa
 create mode 100644 drivers/dma/idxd/perfmon.c
 create mode 100644 drivers/dma/idxd/perfmon.h

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa b/Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa
new file mode 100644
index 000000000000..3c7d132281b0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa
@@ -0,0 +1,30 @@
+What:		/sys/bus/event_source/devices/dsa*/format
+Date:		April 2021
+KernelVersion:  5.13
+Contact:	Tom Zanussi <tom.zanussi@linux.intel.com>
+Description:	Read-only.  Attribute group to describe the magic bits
+		that go into perf_event_attr.config or
+		perf_event_attr.config1 for the IDXD DSA pmu.  (See also
+		ABI/testing/sysfs-bus-event_source-devices-format).
+
+		Each attribute in this group defines a bit range in
+		perf_event_attr.config or perf_event_attr.config1.
+		All supported attributes are listed below (See the
+		IDXD DSA Spec for possible attribute values)::
+
+		    event_category = "config:0-3"    - event category
+		    event          = "config:4-31"   - event ID
+
+		    filter_wq      = "config1:0-31"  - workqueue filter
+		    filter_tc      = "config1:32-39" - traffic class filter
+		    filter_pgsz    = "config1:40-43" - page size filter
+		    filter_sz      = "config1:44-51" - transfer size filter
+		    filter_eng     = "config1:52-59" - engine filter
+
+What:		/sys/bus/event_source/devices/dsa*/cpumask
+Date:		April 2021
+KernelVersion:  5.13
+Contact:	Tom Zanussi <tom.zanussi@linux.intel.com>
+Description:    Read-only.  This file always returns the cpu to which the
+                IDXD DSA pmu is bound for access to all dsa pmu
+		performance monitoring events.
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0c2827fd8c19..b417217c148c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -300,6 +300,18 @@ config INTEL_IDXD_SVM
 	depends on PCI_PASID
 	depends on PCI_IOV
 
+config INTEL_IDXD_PERFMON
+	bool "Intel Data Accelerators performance monitor support"
+	depends on INTEL_IDXD
+	help
+	  Enable performance monitor (pmu) support for the Intel(R)
+	  data accelerators present in Intel Xeon CPU.  With this
+	  enabled, perf can be used to monitor the DSA (Intel Data
+	  Streaming Accelerator) events described in the Intel DSA
+	  spec.
+
+	  If unsure, say N.
+
 config INTEL_IOATDMA
 	tristate "Intel I/OAT DMA support"
 	depends on PCI && X86_64
diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index 8978b898d777..6d11558756f8 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,2 +1,4 @@
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
 idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
+
+idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 8055e872953c..30da7982cabe 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -9,6 +9,8 @@
 #include <linux/wait.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
 #include "registers.h"
 
 #define IDXD_DRIVER_VERSION	"1.00"
@@ -29,6 +31,7 @@ enum idxd_type {
 };
 
 #define IDXD_NAME_SIZE		128
+#define IDXD_PMU_EVENT_MAX	64
 
 struct idxd_device_driver {
 	struct device_driver drv;
@@ -61,6 +64,31 @@ struct idxd_group {
 	int tc_b;
 };
 
+struct idxd_pmu {
+	struct idxd_device *idxd;
+
+	struct perf_event *event_list[IDXD_PMU_EVENT_MAX];
+	int n_events;
+
+	DECLARE_BITMAP(used_mask, IDXD_PMU_EVENT_MAX);
+
+	struct pmu pmu;
+	char name[IDXD_NAME_SIZE];
+	int cpu;
+
+	int n_counters;
+	int counter_width;
+	int n_event_categories;
+
+	bool per_counter_caps_supported;
+	unsigned long supported_event_categories;
+
+	unsigned long supported_filters;
+	int n_filters;
+
+	struct hlist_node cpuhp_node;
+};
+
 #define IDXD_MAX_PRIORITY	0xf
 
 enum idxd_wq_state {
@@ -235,6 +263,8 @@ struct idxd_device {
 	struct idxd_dma_dev *idxd_dma;
 	struct workqueue_struct *wq;
 	struct work_struct work;
+
+	struct idxd_pmu *idxd_pmu;
 };
 
 /* IDXD software descriptor */
@@ -417,4 +447,19 @@ int idxd_cdev_get_major(struct idxd_device *idxd);
 int idxd_wq_add_cdev(struct idxd_wq *wq);
 void idxd_wq_del_cdev(struct idxd_wq *wq);
 
+/* perfmon */
+#if IS_ENABLED(CONFIG_INTEL_IDXD_PERFMON)
+int perfmon_pmu_init(struct idxd_device *idxd);
+void perfmon_pmu_remove(struct idxd_device *idxd);
+void perfmon_counter_overflow(struct idxd_device *idxd);
+void perfmon_init(void);
+void perfmon_exit(void);
+#else
+static inline int perfmon_pmu_init(struct idxd_device *idxd) { return 0; }
+static inline void perfmon_pmu_remove(struct idxd_device *idxd) {}
+static inline void perfmon_counter_overflow(struct idxd_device *idxd) {}
+static inline void perfmon_init(void) {}
+static inline void perfmon_exit(void) {}
+#endif
+
 #endif
diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
new file mode 100644
index 000000000000..d73004f47cf4
--- /dev/null
+++ b/drivers/dma/idxd/perfmon.c
@@ -0,0 +1,662 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 Intel Corporation. All rights rsvd. */
+
+#include <linux/sched/task.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include "idxd.h"
+#include "perfmon.h"
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf);
+
+static cpumask_t		perfmon_dsa_cpu_mask;
+static bool			cpuhp_set_up;
+static enum cpuhp_state		cpuhp_slot;
+
+/*
+ * perf userspace reads this attribute to determine which cpus to open
+ * counters on.  It's connected to perfmon_dsa_cpu_mask, which is
+ * maintained by the cpu hotplug handlers.
+ */
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *perfmon_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group cpumask_attr_group = {
+	.attrs = perfmon_cpumask_attrs,
+};
+
+/*
+ * These attributes specify the bits in the config word that the perf
+ * syscall uses to pass the event ids and categories to perfmon.
+ */
+DEFINE_PERFMON_FORMAT_ATTR(event_category, "config:0-3");
+DEFINE_PERFMON_FORMAT_ATTR(event, "config:4-31");
+
+/*
+ * These attributes specify the bits in the config1 word that the perf
+ * syscall uses to pass filter data to perfmon.
+ */
+DEFINE_PERFMON_FORMAT_ATTR(filter_wq, "config1:0-31");
+DEFINE_PERFMON_FORMAT_ATTR(filter_tc, "config1:32-39");
+DEFINE_PERFMON_FORMAT_ATTR(filter_pgsz, "config1:40-43");
+DEFINE_PERFMON_FORMAT_ATTR(filter_sz, "config1:44-51");
+DEFINE_PERFMON_FORMAT_ATTR(filter_eng, "config1:52-59");
+
+#define PERFMON_FILTERS_START	2
+#define PERFMON_FILTERS_MAX	5
+
+static struct attribute *perfmon_format_attrs[] = {
+	&format_attr_idxd_event_category.attr,
+	&format_attr_idxd_event.attr,
+	&format_attr_idxd_filter_wq.attr,
+	&format_attr_idxd_filter_tc.attr,
+	&format_attr_idxd_filter_pgsz.attr,
+	&format_attr_idxd_filter_sz.attr,
+	&format_attr_idxd_filter_eng.attr,
+	NULL,
+};
+
+static struct attribute_group perfmon_format_attr_group = {
+	.name = "format",
+	.attrs = perfmon_format_attrs,
+};
+
+static const struct attribute_group *perfmon_attr_groups[] = {
+	&perfmon_format_attr_group,
+	&cpumask_attr_group,
+	NULL,
+};
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &perfmon_dsa_cpu_mask);
+}
+
+static bool is_idxd_event(struct idxd_pmu *idxd_pmu, struct perf_event *event)
+{
+	return &idxd_pmu->pmu == event->pmu;
+}
+
+static int perfmon_collect_events(struct idxd_pmu *idxd_pmu,
+				  struct perf_event *leader,
+				  bool do_grp)
+{
+	struct perf_event *event;
+	int n, max_count;
+
+	max_count = idxd_pmu->n_counters;
+	n = idxd_pmu->n_events;
+
+	if (n >= max_count)
+		return -EINVAL;
+
+	if (is_idxd_event(idxd_pmu, leader)) {
+		idxd_pmu->event_list[n] = leader;
+		idxd_pmu->event_list[n]->hw.idx = n;
+		n++;
+	}
+
+	if (!do_grp)
+		return n;
+
+	for_each_sibling_event(event, leader) {
+		if (!is_idxd_event(idxd_pmu, event) ||
+		    event->state <= PERF_EVENT_STATE_OFF)
+			continue;
+
+		if (n >= max_count)
+			return -EINVAL;
+
+		idxd_pmu->event_list[n] = event;
+		idxd_pmu->event_list[n]->hw.idx = n;
+		n++;
+	}
+
+	return n;
+}
+
+static void perfmon_assign_hw_event(struct idxd_pmu *idxd_pmu,
+				    struct perf_event *event, int idx)
+{
+	struct idxd_device *idxd = idxd_pmu->idxd;
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->idx = idx;
+	hwc->config_base = ioread64(CNTRCFG_REG(idxd, idx));
+	hwc->event_base = ioread64(CNTRCFG_REG(idxd, idx));
+}
+
+static int perfmon_assign_event(struct idxd_pmu *idxd_pmu,
+				struct perf_event *event)
+{
+	int i;
+
+	for (i = 0; i < IDXD_PMU_EVENT_MAX; i++)
+		if (!test_and_set_bit(i, idxd_pmu->used_mask))
+			return i;
+
+	return -EINVAL;
+}
+
+/*
+ * Check whether there are enough counters to satisfy that all the
+ * events in the group can actually be scheduled at the same time.
+ *
+ * To do this, create a fake idxd_pmu object so the event collection
+ * and assignment functions can be used without affecting the internal
+ * state of the real idxd_pmu object.
+ */
+static int perfmon_validate_group(struct idxd_pmu *pmu,
+				  struct perf_event *event)
+{
+	struct perf_event *leader = event->group_leader;
+	struct idxd_pmu *fake_pmu;
+	int i, ret = 0, n, idx;
+
+	fake_pmu = kzalloc(sizeof(*fake_pmu), GFP_KERNEL);
+	if (!fake_pmu)
+		return -ENOMEM;
+
+	fake_pmu->pmu.name = pmu->pmu.name;
+	fake_pmu->n_counters = pmu->n_counters;
+
+	n = perfmon_collect_events(fake_pmu, leader, true);
+	if (n < 0) {
+		ret = n;
+		goto out;
+	}
+
+	fake_pmu->n_events = n;
+	n = perfmon_collect_events(fake_pmu, event, false);
+	if (n < 0) {
+		ret = n;
+		goto out;
+	}
+
+	fake_pmu->n_events = n;
+
+	for (i = 0; i < n; i++) {
+		event = fake_pmu->event_list[i];
+
+		idx = perfmon_assign_event(fake_pmu, event);
+		if (idx < 0) {
+			ret = idx;
+			goto out;
+		}
+	}
+out:
+	kfree(fake_pmu);
+
+	return ret;
+}
+
+static int perfmon_pmu_event_init(struct perf_event *event)
+{
+	struct idxd_device *idxd;
+	int ret = 0;
+
+	idxd = event_to_idxd(event);
+	event->hw.idx = -1;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* sampling not supported */
+	if (event->attr.sample_period)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	if (event->pmu != &idxd->idxd_pmu->pmu)
+		return -EINVAL;
+
+	event->hw.event_base = ioread64(PERFMON_TABLE_OFFSET(idxd));
+	event->cpu = idxd->idxd_pmu->cpu;
+	event->hw.config = event->attr.config;
+
+	if (event->group_leader != event)
+		 /* non-group events have themselves as leader */
+		ret = perfmon_validate_group(idxd->idxd_pmu, event);
+
+	return ret;
+}
+
+static inline u64 perfmon_pmu_read_counter(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct idxd_device *idxd;
+	int cntr = hwc->idx;
+
+	idxd = event_to_idxd(event);
+
+	return ioread64(CNTRDATA_REG(idxd, cntr));
+}
+
+static void perfmon_pmu_event_update(struct perf_event *event)
+{
+	struct idxd_device *idxd = event_to_idxd(event);
+	u64 prev_raw_count, new_raw_count, delta, p, n;
+	int shift = 64 - idxd->idxd_pmu->counter_width;
+	struct hw_perf_event *hwc = &event->hw;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = perfmon_pmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+			new_raw_count) != prev_raw_count);
+
+	n = (new_raw_count << shift);
+	p = (prev_raw_count << shift);
+
+	delta = ((n - p) >> shift);
+
+	local64_add(delta, &event->count);
+}
+
+void perfmon_counter_overflow(struct idxd_device *idxd)
+{
+	int i, n_counters, max_loop = OVERFLOW_SIZE;
+	struct perf_event *event;
+	unsigned long ovfstatus;
+
+	n_counters = min(idxd->idxd_pmu->n_counters, OVERFLOW_SIZE);
+
+	ovfstatus = ioread32(OVFSTATUS_REG(idxd));
+
+	/*
+	 * While updating overflowed counters, other counters behind
+	 * them could overflow and be missed in a given pass.
+	 * Normally this could happen at most n_counters times, but in
+	 * theory a tiny counter width could result in continual
+	 * overflows and endless looping.  max_loop provides a
+	 * failsafe in that highly unlikely case.
+	 */
+	while (ovfstatus && max_loop--) {
+		/* Figure out which counter(s) overflowed */
+		for_each_set_bit(i, &ovfstatus, n_counters) {
+			unsigned long ovfstatus_clear = 0;
+
+			/* Update event->count for overflowed counter */
+			event = idxd->idxd_pmu->event_list[i];
+			perfmon_pmu_event_update(event);
+			/* Writing 1 to OVFSTATUS bit clears it */
+			set_bit(i, &ovfstatus_clear);
+			iowrite32(ovfstatus_clear, OVFSTATUS_REG(idxd));
+		}
+
+		ovfstatus = ioread32(OVFSTATUS_REG(idxd));
+	}
+
+	/*
+	 * Should never happen.  If so, it means a counter(s) looped
+	 * around twice while this handler was running.
+	 */
+	WARN_ON_ONCE(ovfstatus);
+}
+
+static inline void perfmon_reset_config(struct idxd_device *idxd)
+{
+	iowrite32(CONFIG_RESET, PERFRST_REG(idxd));
+	iowrite32(0, OVFSTATUS_REG(idxd));
+	iowrite32(0, PERFFRZ_REG(idxd));
+}
+
+static inline void perfmon_reset_counters(struct idxd_device *idxd)
+{
+	iowrite32(CNTR_RESET, PERFRST_REG(idxd));
+}
+
+static inline void perfmon_reset(struct idxd_device *idxd)
+{
+	perfmon_reset_config(idxd);
+	perfmon_reset_counters(idxd);
+}
+
+static void perfmon_pmu_event_start(struct perf_event *event, int mode)
+{
+	u32 flt_wq, flt_tc, flt_pg_sz, flt_xfer_sz, flt_eng = 0;
+	u64 cntr_cfg, cntrdata, event_enc, event_cat = 0;
+	struct hw_perf_event *hwc = &event->hw;
+	union filter_cfg flt_cfg;
+	union event_cfg event_cfg;
+	struct idxd_device *idxd;
+	int cntr;
+
+	idxd = event_to_idxd(event);
+
+	event->hw.idx = hwc->idx;
+	cntr = hwc->idx;
+
+	/* Obtain event category and event value from user space */
+	event_cfg.val = event->attr.config;
+	flt_cfg.val = event->attr.config1;
+	event_cat = event_cfg.event_cat;
+	event_enc = event_cfg.event_enc;
+
+	/* Obtain filter configuration from user space */
+	flt_wq = flt_cfg.wq;
+	flt_tc = flt_cfg.tc;
+	flt_pg_sz = flt_cfg.pg_sz;
+	flt_xfer_sz = flt_cfg.xfer_sz;
+	flt_eng = flt_cfg.eng;
+
+	if (flt_wq && test_bit(FLT_WQ, &idxd->idxd_pmu->supported_filters))
+		iowrite32(flt_wq, FLTCFG_REG(idxd, cntr, FLT_WQ));
+	if (flt_tc && test_bit(FLT_TC, &idxd->idxd_pmu->supported_filters))
+		iowrite32(flt_tc, FLTCFG_REG(idxd, cntr, FLT_TC));
+	if (flt_pg_sz && test_bit(FLT_PG_SZ, &idxd->idxd_pmu->supported_filters))
+		iowrite32(flt_pg_sz, FLTCFG_REG(idxd, cntr, FLT_PG_SZ));
+	if (flt_xfer_sz && test_bit(FLT_XFER_SZ, &idxd->idxd_pmu->supported_filters))
+		iowrite32(flt_xfer_sz, FLTCFG_REG(idxd, cntr, FLT_XFER_SZ));
+	if (flt_eng && test_bit(FLT_ENG, &idxd->idxd_pmu->supported_filters))
+		iowrite32(flt_eng, FLTCFG_REG(idxd, cntr, FLT_ENG));
+
+	/* Read the start value */
+	cntrdata = ioread64(CNTRDATA_REG(idxd, cntr));
+	local64_set(&event->hw.prev_count, cntrdata);
+
+	/* Set counter to event/category */
+	cntr_cfg = event_cat << CNTRCFG_CATEGORY_SHIFT;
+	cntr_cfg |= event_enc << CNTRCFG_EVENT_SHIFT;
+	/* Set interrupt on overflow and counter enable bits */
+	cntr_cfg |= (CNTRCFG_IRQ_OVERFLOW | CNTRCFG_ENABLE);
+
+	iowrite64(cntr_cfg, CNTRCFG_REG(idxd, cntr));
+}
+
+static void perfmon_pmu_event_stop(struct perf_event *event, int mode)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct idxd_device *idxd;
+	int i, cntr = hwc->idx;
+	u64 cntr_cfg;
+
+	idxd = event_to_idxd(event);
+
+	/* remove this event from event list */
+	for (i = 0; i < idxd->idxd_pmu->n_events; i++) {
+		if (event != idxd->idxd_pmu->event_list[i])
+			continue;
+
+		for (++i; i < idxd->idxd_pmu->n_events; i++)
+			idxd->idxd_pmu->event_list[i - 1] = idxd->idxd_pmu->event_list[i];
+		--idxd->idxd_pmu->n_events;
+		break;
+	}
+
+	cntr_cfg = ioread64(CNTRCFG_REG(idxd, cntr));
+	cntr_cfg &= ~CNTRCFG_ENABLE;
+	iowrite64(cntr_cfg, CNTRCFG_REG(idxd, cntr));
+
+	if (mode == PERF_EF_UPDATE)
+		perfmon_pmu_event_update(event);
+
+	event->hw.idx = -1;
+	clear_bit(cntr, idxd->idxd_pmu->used_mask);
+}
+
+static void perfmon_pmu_event_del(struct perf_event *event, int mode)
+{
+	perfmon_pmu_event_stop(event, PERF_EF_UPDATE);
+}
+
+static int perfmon_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct idxd_device *idxd = event_to_idxd(event);
+	struct idxd_pmu *idxd_pmu = idxd->idxd_pmu;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx, n;
+
+	n = perfmon_collect_events(idxd_pmu, event, false);
+	if (n < 0)
+		return n;
+
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+	if (!(flags & PERF_EF_START))
+		hwc->state |= PERF_HES_ARCH;
+
+	idx = perfmon_assign_event(idxd_pmu, event);
+	if (idx < 0)
+		return idx;
+
+	perfmon_assign_hw_event(idxd_pmu, event, idx);
+
+	if (flags & PERF_EF_START)
+		perfmon_pmu_event_start(event, 0);
+
+	idxd_pmu->n_events = n;
+
+	return 0;
+}
+
+static void enable_perfmon_pmu(struct idxd_device *idxd)
+{
+	iowrite32(COUNTER_UNFREEZE, PERFFRZ_REG(idxd));
+}
+
+static void disable_perfmon_pmu(struct idxd_device *idxd)
+{
+	iowrite32(COUNTER_FREEZE, PERFFRZ_REG(idxd));
+}
+
+static void perfmon_pmu_enable(struct pmu *pmu)
+{
+	struct idxd_device *idxd = pmu_to_idxd(pmu);
+
+	enable_perfmon_pmu(idxd);
+}
+
+static void perfmon_pmu_disable(struct pmu *pmu)
+{
+	struct idxd_device *idxd = pmu_to_idxd(pmu);
+
+	disable_perfmon_pmu(idxd);
+}
+
+static void skip_filter(int i)
+{
+	int j;
+
+	for (j = i; j < PERFMON_FILTERS_MAX; j++)
+		perfmon_format_attrs[PERFMON_FILTERS_START + j] =
+			perfmon_format_attrs[PERFMON_FILTERS_START + j + 1];
+}
+
+static void idxd_pmu_init(struct idxd_pmu *idxd_pmu)
+{
+	int i;
+
+	for (i = 0 ; i < PERFMON_FILTERS_MAX; i++) {
+		if (!test_bit(i, &idxd_pmu->supported_filters))
+			skip_filter(i);
+	}
+
+	idxd_pmu->pmu.name		= idxd_pmu->name;
+	idxd_pmu->pmu.attr_groups	= perfmon_attr_groups;
+	idxd_pmu->pmu.task_ctx_nr	= perf_invalid_context;
+	idxd_pmu->pmu.event_init	= perfmon_pmu_event_init;
+	idxd_pmu->pmu.pmu_enable	= perfmon_pmu_enable,
+	idxd_pmu->pmu.pmu_disable	= perfmon_pmu_disable,
+	idxd_pmu->pmu.add		= perfmon_pmu_event_add;
+	idxd_pmu->pmu.del		= perfmon_pmu_event_del;
+	idxd_pmu->pmu.start		= perfmon_pmu_event_start;
+	idxd_pmu->pmu.stop		= perfmon_pmu_event_stop;
+	idxd_pmu->pmu.read		= perfmon_pmu_event_update;
+	idxd_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+	idxd_pmu->pmu.module		= THIS_MODULE;
+}
+
+void perfmon_pmu_remove(struct idxd_device *idxd)
+{
+	if (!idxd->idxd_pmu)
+		return;
+
+	cpuhp_state_remove_instance(cpuhp_slot, &idxd->idxd_pmu->cpuhp_node);
+	perf_pmu_unregister(&idxd->idxd_pmu->pmu);
+	kfree(idxd->idxd_pmu);
+	idxd->idxd_pmu = NULL;
+}
+
+static int perf_event_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct idxd_pmu *idxd_pmu;
+
+	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
+
+	/* select the first online CPU as the designated reader */
+	if (cpumask_empty(&perfmon_dsa_cpu_mask)) {
+		cpumask_set_cpu(cpu, &perfmon_dsa_cpu_mask);
+		idxd_pmu->cpu = cpu;
+	}
+
+	return 0;
+}
+
+static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
+{
+	struct idxd_pmu *idxd_pmu;
+	unsigned int target;
+
+	idxd_pmu = hlist_entry_safe(node, typeof(*idxd_pmu), cpuhp_node);
+
+	if (!cpumask_test_and_clear_cpu(cpu, &perfmon_dsa_cpu_mask))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+
+	/* migrate events if there is a valid target */
+	if (target < nr_cpu_ids)
+		cpumask_set_cpu(target, &perfmon_dsa_cpu_mask);
+	else
+		target = -1;
+
+	perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
+
+	return 0;
+}
+
+int perfmon_pmu_init(struct idxd_device *idxd)
+{
+	union idxd_perfcap perfcap;
+	struct idxd_pmu *idxd_pmu;
+	int rc = -ENODEV;
+
+	/*
+	 * perfmon module initialization failed, nothing to do
+	 */
+	if (!cpuhp_set_up)
+		return -ENODEV;
+
+	/*
+	 * If perfmon_offset or num_counters is 0, it means perfmon is
+	 * not supported on this hardware.
+	 */
+	if (idxd->perfmon_offset == 0)
+		return -ENODEV;
+
+	idxd_pmu = kzalloc(sizeof(*idxd_pmu), GFP_KERNEL);
+	if (!idxd_pmu)
+		return -ENOMEM;
+
+	idxd_pmu->idxd = idxd;
+	idxd->idxd_pmu = idxd_pmu;
+
+	if (idxd->data->type == IDXD_TYPE_DSA) {
+		rc = sprintf(idxd_pmu->name, "dsa%d", idxd->id);
+		if (rc < 0)
+			goto free;
+	} else if (idxd->data->type == IDXD_TYPE_IAX) {
+		rc = sprintf(idxd_pmu->name, "iax%d", idxd->id);
+		if (rc < 0)
+			goto free;
+	} else {
+		goto free;
+	}
+
+	perfmon_reset(idxd);
+
+	perfcap.bits = ioread64(PERFCAP_REG(idxd));
+
+	/*
+	 * If total perf counter is 0, stop further registration.
+	 * This is necessary in order to support driver running on
+	 * guest which does not have pmon support.
+	 */
+	if (perfcap.num_perf_counter == 0)
+		goto free;
+
+	/* A counter width of 0 means it can't count */
+	if (perfcap.counter_width == 0)
+		goto free;
+
+	/* Overflow interrupt and counter freeze support must be available */
+	if (!perfcap.overflow_interrupt || !perfcap.counter_freeze)
+		goto free;
+
+	/* Number of event categories cannot be 0 */
+	if (perfcap.num_event_category == 0)
+		goto free;
+
+	/*
+	 * We don't support per-counter capabilities for now.
+	 */
+	if (perfcap.cap_per_counter)
+		goto free;
+
+	idxd_pmu->n_event_categories = perfcap.num_event_category;
+	idxd_pmu->supported_event_categories = perfcap.global_event_category;
+	idxd_pmu->per_counter_caps_supported = perfcap.cap_per_counter;
+
+	/* check filter capability.  If 0, then filters are not supported */
+	idxd_pmu->supported_filters = perfcap.filter;
+	if (perfcap.filter)
+		idxd_pmu->n_filters = hweight8(perfcap.filter);
+
+	/* Store the total number of counters categories, and counter width */
+	idxd_pmu->n_counters = perfcap.num_perf_counter;
+	idxd_pmu->counter_width = perfcap.counter_width;
+
+	idxd_pmu_init(idxd_pmu);
+
+	rc = perf_pmu_register(&idxd_pmu->pmu, idxd_pmu->name, -1);
+	if (rc)
+		goto free;
+
+	rc = cpuhp_state_add_instance(cpuhp_slot, &idxd_pmu->cpuhp_node);
+	if (rc) {
+		perf_pmu_unregister(&idxd->idxd_pmu->pmu);
+		goto free;
+	}
+out:
+	return rc;
+free:
+	kfree(idxd_pmu);
+	idxd->idxd_pmu = NULL;
+
+	goto out;
+}
+
+void __init perfmon_init(void)
+{
+	int rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+					 "driver/dma/idxd/perf:online",
+					 perf_event_cpu_online,
+					 perf_event_cpu_offline);
+	if (WARN_ON(rc < 0))
+		return;
+
+	cpuhp_slot = rc;
+	cpuhp_set_up = true;
+}
+
+void __exit perfmon_exit(void)
+{
+	if (cpuhp_set_up)
+		cpuhp_remove_multi_state(cpuhp_slot);
+}
diff --git a/drivers/dma/idxd/perfmon.h b/drivers/dma/idxd/perfmon.h
new file mode 100644
index 000000000000..9a081a1bc605
--- /dev/null
+++ b/drivers/dma/idxd/perfmon.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 Intel Corporation. All rights rsvd. */
+
+#ifndef _PERFMON_H_
+#define _PERFMON_H_
+
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/sbitmap.h>
+#include <linux/dmaengine.h>
+#include <linux/percpu-rwsem.h>
+#include <linux/wait.h>
+#include <linux/cdev.h>
+#include <linux/uuid.h>
+#include <linux/idxd.h>
+#include <linux/perf_event.h>
+#include "registers.h"
+
+static inline struct idxd_pmu *event_to_pmu(struct perf_event *event)
+{
+	struct idxd_pmu *idxd_pmu;
+	struct pmu *pmu;
+
+	pmu = event->pmu;
+	idxd_pmu = container_of(pmu, struct idxd_pmu, pmu);
+
+	return idxd_pmu;
+}
+
+static inline struct idxd_device *event_to_idxd(struct perf_event *event)
+{
+	struct idxd_pmu *idxd_pmu;
+	struct pmu *pmu;
+
+	pmu = event->pmu;
+	idxd_pmu = container_of(pmu, struct idxd_pmu, pmu);
+
+	return idxd_pmu->idxd;
+}
+
+static inline struct idxd_device *pmu_to_idxd(struct pmu *pmu)
+{
+	struct idxd_pmu *idxd_pmu;
+
+	idxd_pmu = container_of(pmu, struct idxd_pmu, pmu);
+
+	return idxd_pmu->idxd;
+}
+
+enum dsa_perf_events {
+	DSA_PERF_EVENT_WQ = 0,
+	DSA_PERF_EVENT_ENGINE,
+	DSA_PERF_EVENT_ADDR_TRANS,
+	DSA_PERF_EVENT_OP,
+	DSA_PERF_EVENT_COMPL,
+	DSA_PERF_EVENT_MAX,
+};
+
+enum filter_enc {
+	FLT_WQ = 0,
+	FLT_TC,
+	FLT_PG_SZ,
+	FLT_XFER_SZ,
+	FLT_ENG,
+	FLT_MAX,
+};
+
+#define CONFIG_RESET		0x0000000000000001
+#define CNTR_RESET		0x0000000000000002
+#define CNTR_ENABLE		0x0000000000000001
+#define INTR_OVFL		0x0000000000000002
+
+#define COUNTER_FREEZE		0x00000000FFFFFFFF
+#define COUNTER_UNFREEZE	0x0000000000000000
+#define OVERFLOW_SIZE		32
+
+#define CNTRCFG_ENABLE		BIT(0)
+#define CNTRCFG_IRQ_OVERFLOW	BIT(1)
+#define CNTRCFG_CATEGORY_SHIFT	8
+#define CNTRCFG_EVENT_SHIFT	32
+
+#define PERFMON_TABLE_OFFSET(_idxd)				\
+({								\
+	typeof(_idxd) __idxd = (_idxd);				\
+	((__idxd)->reg_base + (__idxd)->perfmon_offset);	\
+})
+#define PERFMON_REG_OFFSET(idxd, offset)			\
+	(PERFMON_TABLE_OFFSET(idxd) + (offset))
+
+#define PERFCAP_REG(idxd)	(PERFMON_REG_OFFSET(idxd, IDXD_PERFCAP_OFFSET))
+#define PERFRST_REG(idxd)	(PERFMON_REG_OFFSET(idxd, IDXD_PERFRST_OFFSET))
+#define OVFSTATUS_REG(idxd)	(PERFMON_REG_OFFSET(idxd, IDXD_OVFSTATUS_OFFSET))
+#define PERFFRZ_REG(idxd)	(PERFMON_REG_OFFSET(idxd, IDXD_PERFFRZ_OFFSET))
+
+#define FLTCFG_REG(idxd, cntr, flt)				\
+	(PERFMON_REG_OFFSET(idxd, IDXD_FLTCFG_OFFSET) +	((cntr) * 32) + ((flt) * 4))
+
+#define CNTRCFG_REG(idxd, cntr)					\
+	(PERFMON_REG_OFFSET(idxd, IDXD_CNTRCFG_OFFSET) + ((cntr) * 8))
+#define CNTRDATA_REG(idxd, cntr)					\
+	(PERFMON_REG_OFFSET(idxd, IDXD_CNTRDATA_OFFSET) + ((cntr) * 8))
+#define CNTRCAP_REG(idxd, cntr)					\
+	(PERFMON_REG_OFFSET(idxd, IDXD_CNTRCAP_OFFSET) + ((cntr) * 8))
+
+#define EVNTCAP_REG(idxd, category) \
+	(PERFMON_REG_OFFSET(idxd, IDXD_EVNTCAP_OFFSET) + ((category) * 8))
+
+#define DEFINE_PERFMON_FORMAT_ATTR(_name, _format)			\
+static ssize_t __perfmon_idxd_##_name##_show(struct kobject *kobj,	\
+				struct kobj_attribute *attr,		\
+				char *page)				\
+{									\
+	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
+	return sprintf(page, _format "\n");				\
+}									\
+static struct kobj_attribute format_attr_idxd_##_name =			\
+	__ATTR(_name, 0444, __perfmon_idxd_##_name##_show, NULL)
+
+#endif
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 751ecb4f9f81..ffc1f7c7b3b5 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -378,4 +378,112 @@ union wqcfg {
 #define GRPENGCFG_OFFSET(idxd_dev, n) ((idxd_dev)->grpcfg_offset + (n) * GRPCFG_SIZE + 32)
 #define GRPFLGCFG_OFFSET(idxd_dev, n) ((idxd_dev)->grpcfg_offset + (n) * GRPCFG_SIZE + 40)
 
+/* Following is performance monitor registers */
+#define IDXD_PERFCAP_OFFSET		0x0
+union idxd_perfcap {
+	struct {
+		u64 num_perf_counter:6;
+		u64 rsvd1:2;
+		u64 counter_width:8;
+		u64 num_event_category:4;
+		u64 global_event_category:16;
+		u64 filter:8;
+		u64 rsvd2:8;
+		u64 cap_per_counter:1;
+		u64 writeable_counter:1;
+		u64 counter_freeze:1;
+		u64 overflow_interrupt:1;
+		u64 rsvd3:8;
+	};
+	u64 bits;
+} __packed;
+
+#define IDXD_EVNTCAP_OFFSET		0x80
+union idxd_evntcap {
+	struct {
+		u64 events:28;
+		u64 rsvd:36;
+	};
+	u64 bits;
+} __packed;
+
+struct idxd_event {
+	union {
+		struct {
+			u32 event_category:4;
+			u32 events:28;
+		};
+		u32 val;
+	};
+} __packed;
+
+#define IDXD_CNTRCAP_OFFSET		0x800
+struct idxd_cntrcap {
+	union {
+		struct {
+			u32 counter_width:8;
+			u32 rsvd:20;
+			u32 num_events:4;
+		};
+		u32 val;
+	};
+	struct idxd_event events[];
+} __packed;
+
+#define IDXD_PERFRST_OFFSET		0x10
+union idxd_perfrst {
+	struct {
+		u32 perfrst_config:1;
+		u32 perfrst_counter:1;
+		u32 rsvd:30;
+	};
+	u32 val;
+} __packed;
+
+#define IDXD_OVFSTATUS_OFFSET		0x30
+#define IDXD_PERFFRZ_OFFSET		0x20
+#define IDXD_CNTRCFG_OFFSET		0x100
+union idxd_cntrcfg {
+	struct {
+		u64 enable:1;
+		u64 interrupt_ovf:1;
+		u64 global_freeze_ovf:1;
+		u64 rsvd1:5;
+		u64 event_category:4;
+		u64 rsvd2:20;
+		u64 events:28;
+		u64 rsvd3:4;
+	};
+	u64 val;
+} __packed;
+
+#define IDXD_FLTCFG_OFFSET		0x300
+
+#define IDXD_CNTRDATA_OFFSET		0x200
+union idxd_cntrdata {
+	struct {
+		u64 event_count_value;
+	};
+	u64 val;
+} __packed;
+
+union event_cfg {
+	struct {
+		u64 event_cat:4;
+		u64 event_enc:28;
+	};
+	u64 val;
+} __packed;
+
+union filter_cfg {
+	struct {
+		u64 wq:32;
+		u64 tc:8;
+		u64 pg_sz:4;
+		u64 xfer_sz:8;
+		u64 eng:8;
+	};
+	u64 val;
+} __packed;
+
 #endif
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f14adb882338..264d911424c0 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -167,6 +167,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_RAPL_ONLINE,
 	CPUHP_AP_PERF_X86_CQM_ONLINE,
 	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
+	CPUHP_AP_PERF_X86_IDXD_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_CFD_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
-- 
2.17.1

