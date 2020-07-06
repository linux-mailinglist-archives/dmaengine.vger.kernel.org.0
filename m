Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4535B215E4C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgGFS3Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgGFS3Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jul 2020 14:29:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257CC061755
        for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2020 11:29:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so12321312pjw.2
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2020 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=5XSq7OO9rM0CLOQD7n6mX7XsW2ZRv5yna9p15ga+kCw=;
        b=pD2osB3QnOE9+Y4L7+srnL6/+6xdiChov7AsIq9RAJNdHOqDa9U2uj+6Gf4sDaUpHX
         2IUNnUESEpRRx0pfh4gIZve1wzcSVfCP0Wk7DeexnscAGDgs42DOf3ag2X0ex1F9GvyO
         URU6JC67NT79h/1F6BAddVOzmQPXjePmYsy8kv4ahPPRD9IBTTHeQzH9UqKPNvXATUGi
         hCUv1otfW4oV9AAEb0o3N7+Kkjq0xRAF3gJlyAaJtXRrQKnPj+N0DSsPg6mD1RVQGdN1
         QB8nbu1KNNiC+50uyzGdZf2nU7X2Q8zV0Nljb9FQI2iHLXd6BYLj+QALwn1OdGJIhqMD
         9I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=5XSq7OO9rM0CLOQD7n6mX7XsW2ZRv5yna9p15ga+kCw=;
        b=CHznCIJ8EiqGuWyGDRlBK6EQIpBYHMw5IMWgWkvDPT+bqp1OONp4XeJfDf8vxQbSIT
         aalaswOH/wsNU1yHroeF5AEmpz4X0iQwLCrd9SA7awEs1ePHqJHTwpHpybJkL8e/SueF
         FRJ5DGF3dmf7fiTMSnWNW0QX16PyiqU3QnXZPc/HbuRwcWk5lDFKRPI3DaaosqTsepyt
         gjyfcq/DXmHG8Lfd98C6AJhuiXWpWr58nP/X0dhab7vHZwBlDwym8mYAXlVIdBWHGFc5
         ybaUBNvWTKXIyrB9K/IfQxHwN4H7eRz1INBWQAwtx4wDl+Uf5xTzUmIknOvqIYVGsBCB
         Z+gg==
X-Gm-Message-State: AOAM5324MvIgIfWVHDL9Qg7qxZX/9Gc1NOI6kCLlCIqfR0FfbZoIBx0W
        WxYhVooXG3EEEmUdE6gi+jYxew==
X-Google-Smtp-Source: ABdhPJwu7RRaD8Ty1tHTb7H5t+OzymXheeTl6YYUApH9wpZaiQVRYnkm3kuoTcf+9H0yYr+/yvt6Rw==
X-Received: by 2002:a17:90a:3684:: with SMTP id t4mr465789pjb.91.1594060164331;
        Mon, 06 Jul 2020 11:29:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h9sm143679pjs.50.2020.07.06.11.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 11:29:23 -0700 (PDT)
Message-ID: <5f036d83.1c69fb81.10199.06d0@mx.google.com>
Date:   Mon, 06 Jul 2020 11:29:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: next-20200706
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: next
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-collabora
Subject: next/master bisection: baseline.login on qemu_arm64-virt-gicv3
To:     Swathi Kovvuri <swathi.kovvuri@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, kernelci-results@groups.io,
        gtucker@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master bisection: baseline.login on qemu_arm64-virt-gicv3

Summary:
  Start:      5680d14d59bd Add linux-next specific files for 20200706
  Plain log:  https://storage.kernelci.org/next/master/next-20200706/arm64/=
defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.txt
  HTML log:   https://storage.kernelci.org/next/master/next-20200706/arm64/=
defconfig+CONFIG_RANDOMIZE_BASE=3Dy/gcc-8/lab-collabora/baseline-qemu_arm64=
-virt-gicv3.html
  Result:     deb9541f5052 dmaengine: check device and channel list for emp=
ty

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
  Branch:     master
  Target:     qemu_arm64-virt-gicv3
  CPU arch:   arm64
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     defconfig+CONFIG_RANDOMIZE_BASE=3Dy
  Test case:  baseline.login

Breaking commit found:

---------------------------------------------------------------------------=
----
commit deb9541f5052b2f93bd51cb263d9035bfd89fa96
Author: Dave Jiang <dave.jiang@intel.com>
Date:   Fri Jun 26 11:09:41 2020 -0700

    dmaengine: check device and channel list for empty
    =

    Check dma device list and channel list for empty before iterate as the
    iteration function assume the list to be not empty. With devices and
    channels now being hot pluggable this is a condition that needs to be
    checked. Otherwise it can cause the iterator to spin forever.
    =

    Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregi=
ster of channels")
    Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
    Signed-off-by: Dave Jiang <dave.jiang@intel.com>
    Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
    Link: https://lore.kernel.org/r/159319496403.69045.16298280729899651363=
.stgit@djiang5-desk3.ch.intel.com
    Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2b06a7a8629d..0d6529eff66f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -85,6 +85,9 @@ static void dmaengine_dbg_summary_show(struct seq_file *s,
 {
 	struct dma_chan *chan;
 =

+	if (list_empty(&dma_dev->channels))
+		return;
+
 	list_for_each_entry(chan, &dma_dev->channels, device_node) {
 		if (chan->client_count) {
 			seq_printf(s, " %-13s| %s", dma_chan_name(chan),
@@ -104,6 +107,11 @@ static int dmaengine_summary_show(struct seq_file *s, =
void *data)
 	struct dma_device *dma_dev =3D NULL;
 =

 	mutex_lock(&dma_list_mutex);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return 0;
+	}
+
 	list_for_each_entry(dma_dev, &dma_device_list, global_node) {
 		seq_printf(s, "dma%d (%s): number of channels: %u\n",
 			   dma_dev->dev_id, dev_name(dma_dev->dev),
@@ -324,10 +332,15 @@ static struct dma_chan *min_chan(enum dma_transaction=
_type cap, int cpu)
 	struct dma_chan *min =3D NULL;
 	struct dma_chan *localmin =3D NULL;
 =

+	if (list_empty(&dma_device_list))
+		return NULL;
+
 	list_for_each_entry(device, &dma_device_list, global_node) {
 		if (!dma_has_cap(cap, device->cap_mask) ||
 		    dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node) {
 			if (!chan->client_count)
 				continue;
@@ -365,6 +378,9 @@ static void dma_channel_rebalance(void)
 	int cpu;
 	int cap;
 =

+	if (list_empty(&dma_device_list))
+		return;
+
 	/* undo the last distribution */
 	for_each_dma_cap_mask(cap, dma_cap_mask_all)
 		for_each_possible_cpu(cpu)
@@ -373,6 +389,8 @@ static void dma_channel_rebalance(void)
 	list_for_each_entry(device, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node)
 			chan->table_count =3D 0;
 	}
@@ -556,6 +574,10 @@ void dma_issue_pending_all(void)
 	struct dma_chan *chan;
 =

 	rcu_read_lock();
+	if (list_empty(&dma_device_list)) {
+		rcu_read_unlock();
+		return;
+	}
 	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
@@ -613,6 +635,10 @@ static struct dma_chan *private_candidate(const dma_ca=
p_mask_t *mask,
 		dev_dbg(dev->dev, "%s: wrong capabilities\n", __func__);
 		return NULL;
 	}
+
+	if (list_empty(&dev->channels))
+		return NULL;
+
 	/* devices with multiple channels need special handling as we need to
 	 * ensure that all channels are either private or public.
 	 */
@@ -749,6 +775,11 @@ struct dma_chan *__dma_request_channel(const dma_cap_m=
ask_t *mask,
 =

 	/* Find a channel */
 	mutex_lock(&dma_list_mutex);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return NULL;
+	}
+
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		/* Finds a DMA controller with matching device node */
 		if (np && device->dev->of_node && np !=3D device->dev->of_node)
@@ -819,6 +850,11 @@ struct dma_chan *dma_request_chan(struct device *dev, =
const char *name)
 =

 	/* Try to find the channel via the DMA filter map(s) */
 	mutex_lock(&dma_list_mutex);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return NULL;
+	}
+
 	list_for_each_entry_safe(d, _d, &dma_device_list, global_node) {
 		dma_cap_mask_t mask;
 		const struct dma_slave_map *map =3D dma_filter_match(d, name, dev);
@@ -942,10 +978,17 @@ void dmaengine_get(void)
 	mutex_lock(&dma_list_mutex);
 	dmaengine_ref_count++;
 =

+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return;
+	}
+
 	/* try to grab channels */
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node) {
 			err =3D dma_chan_get(chan);
 			if (err =3D=3D -ENODEV) {
@@ -980,10 +1023,17 @@ void dmaengine_put(void)
 	mutex_lock(&dma_list_mutex);
 	dmaengine_ref_count--;
 	BUG_ON(dmaengine_ref_count < 0);
+	if (list_empty(&dma_device_list)) {
+		mutex_unlock(&dma_list_mutex);
+		return;
+	}
+
 	/* drop channel references */
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
+		if (list_empty(&device->channels))
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node)
 			dma_chan_put(chan);
 	}
@@ -1132,6 +1182,39 @@ void dma_async_device_channel_unregister(struct dma_=
device *device,
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 =

+static int dma_channel_enumeration(struct dma_device *device)
+{
+	struct dma_chan *chan;
+	int rc;
+
+	if (list_empty(&device->channels))
+		return 0;
+
+	/* represent channels in sysfs. Probably want devs too */
+	list_for_each_entry(chan, &device->channels, device_node) {
+		rc =3D __dma_async_device_channel_register(device, chan);
+		if (rc < 0)
+			return rc;
+	}
+
+	/* take references on public channels */
+	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
+		list_for_each_entry(chan, &device->channels, device_node) {
+			/* if clients are already waiting for channels we need
+			 * to take references on their behalf
+			 */
+			if (dma_chan_get(chan) =3D=3D -ENODEV) {
+				/* note we can only get here for the first
+				 * channel as the remaining channels are
+				 * guaranteed to get a reference
+				 */
+				return -ENODEV;
+			}
+		}
+
+	return 0;
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device:	pointer to &struct dma_device
@@ -1247,33 +1330,15 @@ int dma_async_device_register(struct dma_device *de=
vice)
 	if (rc !=3D 0)
 		return rc;
 =

+	mutex_lock(&dma_list_mutex);
 	mutex_init(&device->chan_mutex);
 	ida_init(&device->chan_ida);
-
-	/* represent channels in sysfs. Probably want devs too */
-	list_for_each_entry(chan, &device->channels, device_node) {
-		rc =3D __dma_async_device_channel_register(device, chan);
-		if (rc < 0)
-			goto err_out;
+	rc =3D dma_channel_enumeration(device);
+	if (rc < 0) {
+		mutex_unlock(&dma_list_mutex);
+		goto err_out;
 	}
 =

-	mutex_lock(&dma_list_mutex);
-	/* take references on public channels */
-	if (dmaengine_ref_count && !dma_has_cap(DMA_PRIVATE, device->cap_mask))
-		list_for_each_entry(chan, &device->channels, device_node) {
-			/* if clients are already waiting for channels we need
-			 * to take references on their behalf
-			 */
-			if (dma_chan_get(chan) =3D=3D -ENODEV) {
-				/* note we can only get here for the first
-				 * channel as the remaining channels are
-				 * guaranteed to get a reference
-				 */
-				rc =3D -ENODEV;
-				mutex_unlock(&dma_list_mutex);
-				goto err_out;
-			}
-		}
 	list_add_tail_rcu(&device->global_node, &dma_device_list);
 	if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 		device->privatecnt++;	/* Always private */
@@ -1291,6 +1356,9 @@ int dma_async_device_register(struct dma_device *devi=
ce)
 		return rc;
 	}
 =

+	if (list_empty(&device->channels))
+		return rc;
+
 	list_for_each_entry(chan, &device->channels, device_node) {
 		if (chan->local =3D=3D NULL)
 			continue;
@@ -1317,8 +1385,9 @@ void dma_async_device_unregister(struct dma_device *d=
evice)
 =

 	dmaengine_debug_unregister(device);
 =

-	list_for_each_entry_safe(chan, n, &device->channels, device_node)
-		__dma_async_device_channel_unregister(device, chan);
+	if (!list_empty(&device->channels))
+		list_for_each_entry_safe(chan, n, &device->channels, device_node)
+			__dma_async_device_channel_unregister(device, chan);
 =

 	mutex_lock(&dma_list_mutex);
 	/*
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [bb5a93aaf25261321db0c499cde7da6ee9d8b164] x86/ldt: use "pr_info_on=
ce()" instead of open-coding it badly
git bisect good bb5a93aaf25261321db0c499cde7da6ee9d8b164
# bad: [5680d14d59bddc8bcbc5badf00dbbd4374858497] Add linux-next specific f=
iles for 20200706
git bisect bad 5680d14d59bddc8bcbc5badf00dbbd4374858497
# good: [2549a884c8373a109a93521bf806cc523c92340b] Merge remote-tracking br=
anch 'crypto/master'
git bisect good 2549a884c8373a109a93521bf806cc523c92340b
# good: [f94ee8e6645aadfc1e80c2a5fe5fb07841526610] Merge remote-tracking br=
anch 'selinux/next'
git bisect good f94ee8e6645aadfc1e80c2a5fe5fb07841526610
# good: [16d4f454c697a796cfac0af2b5ab39bedf71f4fe] Merge remote-tracking br=
anch 'thunderbolt/next'
git bisect good 16d4f454c697a796cfac0af2b5ab39bedf71f4fe
# bad: [2c43abadd30bab02d2a94b5aa72a7eb6edbe6b96] Merge remote-tracking bra=
nch 'nvdimm/libnvdimm-for-next'
git bisect bad 2c43abadd30bab02d2a94b5aa72a7eb6edbe6b96
# bad: [d5a942e3894462eb44f6bb51dde5b5b481ba355a] Merge remote-tracking bra=
nch 'scsi/for-next'
git bisect bad d5a942e3894462eb44f6bb51dde5b5b481ba355a
# good: [bd7a168a024dcfbc4db7fb79a51c8b574f55b527] staging: rtl8712: use co=
mmon ieee80211 constants
git bisect good bd7a168a024dcfbc4db7fb79a51c8b574f55b527
# good: [28ed7374401b20915bf980fdf2d3ac80f8c2945d] scsi: lpfc: Fix language=
 in 0373 message to reflect non-error message
git bisect good 28ed7374401b20915bf980fdf2d3ac80f8c2945d
# good: [198d6cb9263bb25156132d87babfe6e6506a4c88] Merge remote-tracking br=
anch 'icc/icc-next'
git bisect good 198d6cb9263bb25156132d87babfe6e6506a4c88
# good: [7244068998c8266300c48f1a3af7b237446de885] Merge branch 'misc' into=
 for-next
git bisect good 7244068998c8266300c48f1a3af7b237446de885
# good: [999a32efed09d724c426568731c5691233d3a680] dmaengine: hisilicon: Us=
e struct_size() in devm_kzalloc()
git bisect good 999a32efed09d724c426568731c5691233d3a680
# good: [d12ea5591eddf625b7707c018b72e46e8674c3c2] dmaengine: pl330: Make s=
ure the debug is idle before doing DMAGO
git bisect good d12ea5591eddf625b7707c018b72e46e8674c3c2
# bad: [f50b150e315ed133b74a75e3c71864fb2cd4cece] dmaengine: idxd: add work=
 queue drain support
git bisect bad f50b150e315ed133b74a75e3c71864fb2cd4cece
# bad: [deb9541f5052b2f93bd51cb263d9035bfd89fa96] dmaengine: check device a=
nd channel list for empty
git bisect bad deb9541f5052b2f93bd51cb263d9035bfd89fa96
# first bad commit: [deb9541f5052b2f93bd51cb263d9035bfd89fa96] dmaengine: c=
heck device and channel list for empty
---------------------------------------------------------------------------=
----
