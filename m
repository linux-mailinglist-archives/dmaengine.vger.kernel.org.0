Return-Path: <dmaengine+bounces-5570-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D4AE264A
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jun 2025 01:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A7D188D4B5
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jun 2025 23:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A982459FF;
	Fri, 20 Jun 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUigECvl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF8244660
	for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461699; cv=none; b=N+Bd2ITS3xQgyHU4pY9cUXoyOw+8Qzy0ZJEkxcjjMlDShVSzu4xV1SGvJBRo1o4iFt5R3S3/P07K7rvUwLco+3Pyw29S5oO8cMiStaGwlyeVIM79OMRn1Rmg+/9xc7iv/S2syzP3RlpyO2jDwbCXOiRibfh9MFs2TOKm55+gaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461699; c=relaxed/simple;
	bh=VgUzUA87V9iGPM4JzN6sxW6caKGlhyFE3Jg63H7+SSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m1S7NIpqQ61OG4JQcBZNBAT5o0FkhWAgV1c/UxEpOXC6EJ5mpYcKoToqautcEHhrHclQGKeFaDXjpGGbe+afKNNv3M7npkR53YfUnSkT3f8Bb+k/qVObJGjUekiuUFkgwh3fJcfjiBC8Ms7sCL2LBgUZojq+iFD5TDA03lNjSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUigECvl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23507382e64so22470855ad.2
        for <dmaengine@vger.kernel.org>; Fri, 20 Jun 2025 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461697; x=1751066497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMZ83Hi7G7KaLtPIuaXRZZpxtrxYuH9dxkh3pjVWSes=;
        b=nUigECvltckacgo4vdiR1ddsk0F8f44vSE6MWjyT+HjvsCNuktHV91tJeMgYcNQ5y3
         e3yC7pb/rZqFjoBhdjNXD3LU5vxkYyInA8uj0ShrL178oxAC8gZM4eae/aYbJ6xQVL30
         JYT1pbYrCroJtjJ7XXb+NwEtZxGJ6eYMSzdDFihe13SRkOUK8TXJibTNRqKhJFrf3Ode
         IUppVa0XoE5vuFsBqTstDPIExli3wtqxilsdRB36ovFdN/wMZlZ4+hFA4OHY+DYJQCOW
         Jr2y9Oubf7pqwdQhMCxG4aAXOoMHy7f/zCdmvKJGRTP+uVqptVzXbiHRkKFqwsgEtMYy
         QU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461697; x=1751066497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMZ83Hi7G7KaLtPIuaXRZZpxtrxYuH9dxkh3pjVWSes=;
        b=RnrEvW5B+tqdrEkR208nED2aMQCBbDdp6SVYtgwft1ZuMMIP9SouHhfDIcICljty4C
         uQfuNcN3v9Hs0pVlIGtYDETKkFDA8+1RlghaOtTiYsbXznO27HoMIbWvNH+x4ACFtDpb
         VjiX8RsmmGnM/JB1zwi3G+0KFay91lXHux1yK+exKCiH+cI6ZmkM6Zx5ilVTKvZOepff
         kkSrqOvOjCvdXdVChkhgAFK/ZwzKSeNAgJxWXaGwW88+iHSFIweFECa5+5KgMGCa+hsj
         PSPcP4hYze9kNX0Qw2XtiPfZ+M63NVbyd0j+sTA6NZhYUKH/ROzrxt6eemyZ/XdpMjst
         JZQg==
X-Forwarded-Encrypted: i=1; AJvYcCVnX2mNhgx0Q6CStRAHJ9VP4b4n98b6mxIyokGLHKXnLrWQHc5B73n5M3eOQzbF+mJ2Q0WtTx2E34c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8sG0eJoBgGhb/IgkH9h2olbORNX5s1gunnulQCcfkQ6DEIpZ
	Skg/sNo1SHuJKvuENKZVflQaD5h2MNCCT4ZOCDdOr8NQC9kGyzMdERC0zsNZ90YvJXvoYxfIG8d
	p3Gv1aHhxuz2A1g==
X-Google-Smtp-Source: AGHT+IE8YwbzxdzhmhCAr711LK1aIYxsvfRO/y3cHPfx6n48pQwPqmz4AJ0U1iM9sqk78kLZc8JtL03gOmtihQ==
X-Received: from plev19.prod.google.com ([2002:a17:903:31d3:b0:234:952b:35a2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db02:b0:236:94ac:cc11 with SMTP id d9443c01a7336-237d987d810mr71222585ad.7.1750461697299;
 Fri, 20 Jun 2025 16:21:37 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:20:21 +0000
In-Reply-To: <20250620232031.2705638-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620232031.2705638-1-dmatlack@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-24-dmatlack@google.com>
Subject: [PATCH 23/33] vfio: selftests: Move helper to get cdev path to libvfio
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

Move the helper function to get the VFIO cdev path to libvfio so that it
can be used in libvfio in a subsequent commit.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 31 +++++++++++++++++
 .../selftests/vfio/vfio_iommufd_setup_test.c  | 34 ++-----------------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index a7d05a4299a1..05a10417e0d7 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -175,6 +175,7 @@ struct vfio_pci_device {
  * If BDF cannot be determined then the test will exit with KSFT_SKIP.
  */
 const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
+const char *vfio_pci_get_cdev_path(const char *bdf);
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d8bb227e869d..d53e2d682c7e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <dirent.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <stdlib.h>
@@ -332,6 +333,36 @@ static void vfio_pci_device_setup(struct vfio_pci_device *device, const char *bd
 		device->msi_eventfds[i] = -1;
 }
 
+const char *vfio_pci_get_cdev_path(const char *bdf)
+{
+	char dir_path[PATH_MAX];
+	struct dirent *entry;
+	char *cdev_path;
+	DIR *dir;
+
+	cdev_path = calloc(PATH_MAX, 1);
+	VFIO_ASSERT_NOT_NULL(cdev_path);
+
+	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
+
+	dir = opendir(dir_path);
+	VFIO_ASSERT_NOT_NULL(dir, "Failed to open directory %s\n", dir_path);
+
+	while ((entry = readdir(dir)) != NULL) {
+		/* Find the file that starts with "vfio" */
+		if (strncmp("vfio", entry->d_name, 4))
+			continue;
+
+		snprintf(cdev_path, PATH_MAX, "/dev/vfio/devices/%s", entry->d_name);
+		break;
+	}
+
+	VFIO_ASSERT_NE(cdev_path[0], 0, "Failed to find vfio cdev file.\n");
+	VFIO_ASSERT_EQ(closedir(dir), 0);
+
+	return cdev_path;
+}
+
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type)
 {
 	struct vfio_pci_device *device;
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
index f45335d9260f..3655106b912d 100644
--- a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -1,8 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <assert.h>
-#include <dirent.h>
-#include <fcntl.h>
-
 #include <uapi/linux/types.h>
 #include <linux/limits.h>
 #include <linux/sizes.h>
@@ -11,7 +7,6 @@
 
 #include <stdint.h>
 #include <stdio.h>
-#include <string.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
 
@@ -19,32 +14,7 @@
 #include "../kselftest_harness.h"
 
 static const char iommu_dev_path[] = "/dev/iommu";
-static char cdev_path[PATH_MAX] = { '\0' };
-
-static void set_cdev_path(const char *bdf)
-{
-	char dir_path[PATH_MAX];
-	DIR *dir;
-	struct dirent *entry;
-
-	snprintf(dir_path, sizeof(dir_path), "/sys/bus/pci/devices/%s/vfio-dev/", bdf);
-
-	dir = opendir(dir_path);
-	assert(dir);
-
-	/* Find the file named "vfio<number>" */
-	while ((entry = readdir(dir)) != NULL) {
-		if (!strncmp("vfio", entry->d_name, 4)) {
-			snprintf(cdev_path, sizeof(cdev_path), "/dev/vfio/devices/%s",
-				 entry->d_name);
-			break;
-		}
-	}
-
-	assert(strlen(cdev_path) > 0);
-
-	closedir(dir);
-}
+static const char *cdev_path;
 
 static int vfio_device_bind_iommufd_ioctl(int cdev_fd, int iommufd)
 {
@@ -150,7 +120,7 @@ int main(int argc, char *argv[])
 {
 	const char *device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	set_cdev_path(device_bdf);
+	cdev_path = vfio_pci_get_cdev_path(device_bdf);
 	printf("Using cdev device %s\n", cdev_path);
 
 	return test_harness_run(argc, argv);
-- 
2.50.0.rc2.701.gf1e915cc24-goog


