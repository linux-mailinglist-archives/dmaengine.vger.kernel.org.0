Return-Path: <dmaengine+bounces-5580-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DABEAE266C
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jun 2025 01:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4977ADA72
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BB24469B;
	Fri, 20 Jun 2025 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwcFvbV/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E5246BD1
	for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461714; cv=none; b=W97QBmIotaTR5ueCVD/VFWS3k09NrJ7m9GrAYD4j1CvUbYNGOppvdzWxwvyxfgT0a8ivoF7JJhpe9i+DkXuM394DI2bcIlk0Sa/SrKqrYz+3P2vXTqrCAJcEu6qpW06oufw3PAvTb0ElJdP+lsawz9Me6sDryHj7B/3cC+likHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461714; c=relaxed/simple;
	bh=Ncx74SpAzcNntzZHo1q9tv5rzSgXexrKxG6ODpCJH/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f7PqY1UBQsqzn2gOsK0WMRIJZ5PZR0HIbg2BoFjGvau0Uxly23xB/WNAdTk60HLN0+okiK/b6u6Qncxw43a7UxWo0eZhlv4jR/rmH8xXosT6ddD9rVTQYCrTCReYa4Yqp9TnQtsJlhPzDfCzo3zyczW+bZ72a7uiRKXXqov16mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwcFvbV/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so3647750a91.2
        for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461712; x=1751066512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZKSIsXOLOueB130oF7Z5E/CnqwtspAwtEMUlKs5jYA=;
        b=jwcFvbV/Xb3KN33jbSx/vnO71Iv8nAz2PhGMlT2Ww+6SeCGe6EL3vvnEHFPojgLDT0
         26VeYTrJuiGEiPTI1FDOFtQKa7Ia6WIKT26OacUwnAYcxqpOFrRSzUA6qzu1Tkfs5amD
         FYY/rphzsgaZAz3ulrSnv9Z+E27Wio0j2le8rpG6ZN5/46pWD0tmB+X6Oq+wx+Cu15ek
         GTEGgnLYRZ6F3nkWIcX2GvF1ah/JIIf0BAVu2vNV2fFQIYtjvzYy5bydEKuYuLuotp6F
         vxDqSP1U1v2bjm+htnHv1/NIRQIEhyDVHKQX1M2QN2SdzVws/k4lhDV8q0jB3+4Gre3v
         Qjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461712; x=1751066512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZKSIsXOLOueB130oF7Z5E/CnqwtspAwtEMUlKs5jYA=;
        b=Exf/fmnJuTtv67GfnDOTVkmGiTw95Ns1nzwhqDv5Hr37uzvPvkHXA2NASPELOC+d9R
         jA643sDd5/77/GBmGXWezWVuPB7Huo/2HSeGz76ICEY2tHCwoMrIENDPBrNguRockDZJ
         iZ1t4Znj2J9RXucb8hEfqTlgYx1rzPsK2bgzDpYbOPjQlUukk5GanSf3/Hzk3Ed6HxpF
         V7o8Upcb/WT0/lUxLcAkaSyywBPoLF4v3cF5mQgwxIjuLTZZxKSr5YGzc6dRGcZyvTTc
         e09GQX63VLENYJIVtA5OjgprtXsFr5Fx0eCZ6leBQ8C5BEZuZLpeFe2P5HsUFaCa1Iwv
         n92Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfhGzpEcrgrlTCekg0ouFQuE0mVXMeUY85zFI69PBBWakn3fZ7DaXgcFPUK161ITxnggMq49sLX0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFlMW2WyUFEw0scD+Ns4tGgNk3uuMAGnoGqtC3ucX9wvIldjR
	YCZMLdVDTjLCWOd7ttXcxyEctBvR4gf48Hog+jepIFvxa9xJ233fMxWG/m3448vsCr8S4A3PPPS
	NotbUoCccGJgGRw==
X-Google-Smtp-Source: AGHT+IFHJjxL70GMJGRTf7hame7Lzw6gdvygwoTOqgJ1QDn6ZRT3o3M4PRqA6yGQe4JeCam/FXpiNmMlKZ+qbA==
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:311:f699:df0a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2808:b0:313:f83a:e473 with SMTP id 98e67ed59e1d1-3159d67bbd3mr7117272a91.15.1750461712326;
 Fri, 20 Jun 2025 16:21:52 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:31 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-34-dmatlack@google.com>
Subject: [PATCH 33/33] KVM: selftests: Add -d option to vfio_pci_device_irq_test
 for device-sent MSIs
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add the -d option to vfio_pci_device_irq_test that will make the device
send an MSI rather than synthesizing an eventfd notification from VFIO.
This requires a VFIO selftest driver for the device that supports the
send_msi() function.

This option allows the test to exercise IRQ Bypass (e.g. VT-d
device-posted interrupts in Intel).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/kvm/vfio_pci_device_irq_test.c  | 61 +++++++++++++++++--
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
index 9b90cf9dd38f..64fd4efe2096 100644
--- a/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
@@ -7,6 +7,8 @@
 #include <pthread.h>
 #include <time.h>
 #include <linux/vfio.h>
+#include <linux/sizes.h>
+
 #include <vfio_util.h>
 
 static bool guest_ready_for_irq;
@@ -60,10 +62,53 @@ void *vcpu_thread_main(void *arg)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-i iommu_mode] [segment:bus:device.function]\n", name);
+	printf("Usage: %s [-i iommu_mode] [-d] [segment:bus:device.function]\n", name);
+	printf("  -d: Send a real MSI from the device, rather than synthesizing\n"
+	       "      an eventfd signal from VFIO. Note that this option requires\n"
+	       "      a VFIO selftests driver that supports the device.\n");
 	exit(KSFT_FAIL);
 }
 
+static int setup_msi(struct vfio_pci_device *device, bool use_device_msi)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	struct vfio_dma_region *region;
+
+	if (use_device_msi) {
+		/* A driver is required to generate an MSI. */
+		TEST_REQUIRE(device->driver.ops);
+
+		/* Set up a DMA-able region for the driver to use. */
+		region = &device->driver.region;
+		region->iova = 0;
+		region->size = SZ_2M;
+		region->vaddr = mmap(NULL, region->size, prot, flags, -1, 0);
+		TEST_ASSERT(region->vaddr != MAP_FAILED, "mmap() failed\n");
+		vfio_pci_dma_map(device, region);
+
+		vfio_pci_driver_init(device);
+
+		return device->driver.msi;
+	}
+
+	TEST_REQUIRE(device->msix_info.count > 0);
+	vfio_pci_msix_enable(device, 0, 1);
+	return 0;
+}
+
+static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int msi)
+{
+	if (use_device_msi) {
+		printf("Sending MSI %d from the device\n", msi);
+		TEST_ASSERT_EQ(msi, device->driver.msi);
+		vfio_pci_driver_send_msi(device);
+	} else {
+		printf("Notifying the eventfd for MSI %d from VFIO\n", msi);
+		vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, msi);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	/* Random non-reserved vector and GSI to use for the device IRQ */
@@ -73,19 +118,24 @@ int main(int argc, char **argv)
 	struct timespec start, elapsed;
 	struct vfio_pci_device *device;
 	const char *iommu_mode = NULL;
+	bool use_device_msi = false;
 	const char *device_bdf;
 	struct kvm_vcpu *vcpu;
 	pthread_t vcpu_thread;
 	struct kvm_vm *vm;
+	int msi;
 	int c;
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "i:")) != -1) {
+	while ((c = getopt(argc, argv, "i:d")) != -1) {
 		switch (c) {
 		case 'i':
 			iommu_mode = optarg;
 			break;
+		case 'd':
+			use_device_msi = true;
+			break;
 		default:
 			help(argv[0]);
 		}
@@ -95,10 +145,9 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 
 	device = vfio_pci_device_init(device_bdf, iommu_mode);
-	TEST_REQUIRE(device->msix_info.count > 0);
+	msi = setup_msi(device, use_device_msi);
 
-	vfio_pci_msix_enable(device, 0, 1);
-	kvm_add_irqfd(vm, gsi, device->msi_eventfds[0]);
+	kvm_add_irqfd(vm, gsi, device->msi_eventfds[msi]);
 	kvm_route_msi(vm, gsi, vcpu, vector);
 
 	pthread_create(&vcpu_thread, NULL, vcpu_thread_main, vcpu);
@@ -106,7 +155,7 @@ int main(int argc, char **argv)
 	while (!READ_ONCE(guest_ready_for_irq))
 		sync_global_from_guest(vm, guest_ready_for_irq);
 
-	vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, 0);
+	send_msi(device, use_device_msi, msi);
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


