Return-Path: <dmaengine+bounces-5552-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5834AE2616
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jun 2025 01:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FC97A5B8C
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 23:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A69246BCF;
	Fri, 20 Jun 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vx8RaCaS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68F24469B
	for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461673; cv=none; b=Ym+dQqydwuPUqwM16btpbevbVfs5G/lSxLXSFO5VMFJVY49Rfjb9KYLwJWZp46fiQxsxMWvbfQnq0ujMErG0Rvf64uDTPxcjDT99BAuVj3fK3Q5mg+S1iQikYxn2zn3VWq76khFmEi/hHMU/qWsKNBWMho4J5LHxqjJUG2r28Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461673; c=relaxed/simple;
	bh=Thn2kGILsZpOcISVVCPwQX6ozovmwgpWPoq/39SJxvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JiEYQTsvBNxwAMY4FBAJ8RK7K+NdWWXcoUAycAV4Gs3S/eAEKfLfuFEADX5U+EmNar1VcFXXBNJ1UYo04i2wFmprf9yV4a/yA3TAqRr8agAM8ebrLcawXDjF5cy6vGxSWr4gMZrrrW5f/WaRYvRac5JPBHNWa6vBUR94Tk8qms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vx8RaCaS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso2979855a12.0
        for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 16:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461671; x=1751066471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp1f+KUSk06SNHk+ZMUdZvIrFgA8bi4jwIb5ocRzBgg=;
        b=vx8RaCaSRYigViXyEpEjMl1GshuOE99xROx08w36rJQ9L17gN7OOXjrD6m+PNBqa+D
         25mURsXXonmBkTkdRJg3aU809+EdNylUr1wdk/YG34mqTlR/GhWjzv7IeLX6Pub6u+T6
         reAu9+1uwXkrJqiwckkwF6JSDFjLGeJ6/ELz4K/5E0i3TnnBTgC/3cZVHcD0gXwxUs/u
         hEWCXutUy/K9INXUTlQRpIDUU0HXkCEX1+sYib4xG3I46nKMqsdtGs6uBq4tJLK2W/AX
         Oe9T71KO9TWUwz2xSD57tX6rpQivjoJDVip3MkXYXO1VubUOH8nV1sRP2AOwQt7IctTO
         OZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461671; x=1751066471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp1f+KUSk06SNHk+ZMUdZvIrFgA8bi4jwIb5ocRzBgg=;
        b=Ja6aZs+fVN/Kk6onBkVmrvO2sXlKK5oWJwQK+RBRFBQfgC8Ouc/xB6387vjdFwEtX7
         quPDk6TcW1yvDK8yI95PjhZgFzu3dj1dU69zpFHnZPZ1Ra+k1zu1kaKQpUyeSqGzj6DP
         h/K+9svcKg1e4rLzuFds8NjzyvjAaiGEvjvIQmT6n2NxFnZGgxYolSfdPEGN3rTY45co
         cOvNdVoBa3Ea/wjo4VeymopF77Et422qh2/0kwMyPoURG0SyKZPV5niB8CHEOG/Za+VZ
         M8bt7wjj92bzdAAfIOLPSbfyfg3XIJ/uWTsmQMNq20ioK9eURhF20nQxX1YsiISIa9MP
         QAiA==
X-Forwarded-Encrypted: i=1; AJvYcCXC4MxQ1Ceyd2L5nMpWXeiVcwwmBVI6qBTt3/TUFea4F6iLBRD0nu+tEV2x7g0kw4fD0WwRYBbJtqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu86GcD+YMWFoWpriodaY7edYKA+LdmXn3gHaDLn1TF8T284eS
	b6WYn/j4z5jgG9QsMUk0B9IktRxwqmRDjYCCuoBjlGH2THxisZDdSyRIo/f+8Fb980tjsx++Pbp
	Z9TwN5M6ZRRZ90Q==
X-Google-Smtp-Source: AGHT+IFA1Cx49P1qbP07hQLaZuzsTSyWkcOiwP4/KUZkuAkEtuwOmzQKxaL6C5aZ2XoNsYw+6cuKJXxwwRCeQg==
X-Received: from pgif2.prod.google.com ([2002:a63:f102:0:b0:b2e:bfa8:7724])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c6cb:b0:201:b65:81ab with SMTP id adf61e73a8af0-22026f15dc1mr7011815637.23.1750461670602;
 Fri, 20 Jun 2025 16:21:10 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:03 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-6-dmatlack@google.com>
Subject: [PATCH 05/33] vfio: selftests: Move vfio dma mapping test to their
 own file
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

From: Josh Hilke <jrhilke@google.com>

Move the dma_map_unmap test from vfio_pci_device_test to a new test:
vfio_dma_mapping_test. We are going to add more complex dma mapping
tests, so it makes sense to separate this from the vfio pci device
test which is more of a sanity check for vfio pci functionality.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/vfio_dma_mapping_test.c    | 49 +++++++++++++++++++
 .../selftests/vfio/vfio_pci_device_test.c     | 16 ------
 3 files changed, 50 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e4a5d6eadff3..05c5a585cca6 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,5 @@
 CFLAGS = $(KHDR_INCLUDES)
+TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 include ../lib.mk
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
new file mode 100644
index 000000000000..39a6d71b0f75
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <vfio_util.h>
+
+#include "../kselftest_harness.h"
+
+static const char *device_bdf;
+
+FIXTURE(vfio_dma_mapping_test) {
+	struct vfio_pci_device *device;
+};
+
+FIXTURE_SETUP(vfio_dma_mapping_test)
+{
+	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
+}
+
+FIXTURE_TEARDOWN(vfio_dma_mapping_test)
+{
+	vfio_pci_device_cleanup(self->device);
+}
+
+TEST_F(vfio_dma_mapping_test, dma_map_unmap)
+{
+	const u64 size = SZ_2M;
+	const u64 iova = SZ_4G;
+	void *mem;
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(mem, MAP_FAILED);
+
+	vfio_pci_dma_map(self->device, iova, size, mem);
+	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
+	vfio_pci_dma_unmap(self->device, iova, size);
+
+	ASSERT_TRUE(!munmap(mem, size));
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 6d3a33804be3..a2e41398d184 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -36,22 +36,6 @@ FIXTURE_TEARDOWN(vfio_pci_device_test)
 	vfio_pci_device_cleanup(self->device);
 }
 
-TEST_F(vfio_pci_device_test, dma_map_unmap)
-{
-	const u64 size = SZ_2M;
-	const u64 iova = SZ_4G;
-	void *mem;
-
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	ASSERT_NE(mem, MAP_FAILED);
-
-	vfio_pci_dma_map(self->device, iova, size, mem);
-	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
-	vfio_pci_dma_unmap(self->device, iova, size);
-
-	ASSERT_TRUE(!munmap(mem, SZ_2M));
-}
-
 #define read_pci_id_from_sysfs(_file) ({							\
 	char __sysfs_path[PATH_MAX];								\
 	char __buf[32];										\
-- 
2.50.0.rc2.701.gf1e915cc24-goog


