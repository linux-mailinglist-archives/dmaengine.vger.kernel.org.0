Return-Path: <dmaengine+bounces-6136-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B9EB32432
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F2B669E1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF327780C;
	Fri, 22 Aug 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DGJJQks"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E2341678
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897979; cv=none; b=tShXv4WqBJHg0TAVH5dAzdVX48jQ+XmizYIk6PjgvKKrAqsyGi+5W/E0PCrD4THtBiKUWTx6Fetg6Ng5jBfrRRdXLwQEYiO4IkiWnUcxYrileIcaq4/MWKrlW7Pf3IsioN7uapJlXPo1ObFnuIrdpHXqAkWmbsGgJl8V3cCLBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897979; c=relaxed/simple;
	bh=rTedQTx7eploZdzRSeYzRhrwcXGIFjc9zqT/oqADDoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aus5e3TeqkTnzmzLB1/N+GpyUi/vFJPxAsl4WXtUvIJYpTcK0zcRdJXPtE9UL72VKA5Ml/gM7w6XiWUz6ZZ+oEk0DOUjxP1KkaknXYQO3Em0O5RvcBesKOgyQKEp0DJC/i3WAdw9zbiu3R9/ELn62m8Zxp62qIhDybOeSmjZU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DGJJQks; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e349ef5fso2819738a91.3
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897977; x=1756502777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5POFsslZ3cS9lDcKk5vxlnt8J7p4Kctxo7cJXLtCsc=;
        b=3DGJJQks/Z5dry5uxl5t4mjQMZH5B1d9qdbO74Xu1raUSjCE1DWgNK1SuPqJbRtj4l
         KZHq86OL2vFksGhC8PwLmIhbPKUxhxOqi2qEWcL2wfcvX0DdPTzsKam4VEjiHS01cTTv
         kh/ZFZ+WvFe9uUUHR9ko34UUyVquKXoLOS4T07kKSjWIx/gxuGsrc4J1nOXET5GsU6tV
         lEUxu+OUvMnPuzeHRnasIqqOJzsdbrxY/Gl+Rdcv4rYO3qYDee6p/d9zTdPDBq5LL4Rn
         MjfHt2ayHd8CaAFAIzCgfQ7eQIigxceBEE97LmIqH7rErpLP/VmAD/8sr1q5mrYaUMK+
         Hl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897977; x=1756502777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5POFsslZ3cS9lDcKk5vxlnt8J7p4Kctxo7cJXLtCsc=;
        b=huRISHinvTnL7+xVCCKK0s8oz4chl5D34UlEgJ+LGW6hNZE+WsB7JS2wIKkkgRwsdC
         OAp9ptq3oo6YPAQZT1eDCkXI7AEkmAg3LwsLunWsfcxjlITMubVjjl0MPcG/yfVFZKlI
         mhIgLFEGJnuP56FNCAvmlQ9NgTB+CHzlgwKxmji+dC5Cf9P9e6JU+E2YSaKQyDtr4C/0
         EhsLuoHZiC+CAN7avlmk1x1PEkEoSskKJGnZu7cMrJCzfjSf/++wguJUDKgHQjLjOvwn
         w2VWod+xrA9FjinwSbXPo0x7UJkrbw36dkGfJPv2/iiUBzcWvaJxbYBKjkIP9rEhtxqY
         GrUg==
X-Forwarded-Encrypted: i=1; AJvYcCV87WcdOWndUkQakAOR1NOPDlATVGe8UpiRLcYdlnpMvCeUaQXr8KCBDV3/3BwfiW8FA8GRGuq1Fes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhqZPon1sNzN5SdKJh3r/IcgrMzjJpzVn+fCP1F6yvnRT0vNJ
	MVtAW1ltQHzvB55e8C12RjhTuIBEcuhfmK8o6BpRKpjrcn9FT5V5FhWPnVf33AccdIyQT0TkWGZ
	MzJl/sA8n4wr1TA==
X-Google-Smtp-Source: AGHT+IF7wFxJCdujaonVKDe1BfckHqzrcOR99YLcQfrNtopL72z0UcvegQI8wQkaI+RMy+BubUkyEFbMtJLsTw==
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:314:d44:4108])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c4:b0:31e:6f0a:6a1a with SMTP id 98e67ed59e1d1-32515e12e55mr5914007a91.3.1755897977220;
 Fri, 22 Aug 2025 14:26:17 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:53 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-7-dmatlack@google.com>
Subject: [PATCH v2 06/30] vfio: selftests: Add test to reset vfio device.
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

From: Josh Hilke <jrhilke@google.com>

Add a test to vfio_pci_device_test which resets the device. If reset is
not supported by the device, the test is skipped.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/include/vfio_util.h | 1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c   | 5 +++++
 tools/testing/selftests/vfio/vfio_pci_device_test.c  | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index b7d2bb8c18ba..234403b442af 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -83,6 +83,7 @@ const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, int iommu_type);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
+void vfio_pci_device_reset(struct vfio_pci_device *device);
 
 void vfio_pci_dma_map(struct vfio_pci_device *device, u64 iova, u64 size,
 		      void *vaddr);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 76adb1841f16..98cce0a6ecd7 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -202,6 +202,11 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 		       write ? "write to" : "read from", config);
 }
 
+void vfio_pci_device_reset(struct vfio_pci_device *device)
+{
+	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
+}
+
 static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 {
 	char dev_iommu_group_path[PATH_MAX] = {0};
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index a2e41398d184..82e3c947f45d 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -155,6 +155,14 @@ TEST_F(vfio_pci_irq_test, enable_trigger_disable)
 	vfio_pci_irq_disable(self->device, variant->irq_index);
 }
 
+TEST_F(vfio_pci_device_test, reset)
+{
+	if (!(self->device->info.flags & VFIO_DEVICE_FLAGS_RESET))
+		SKIP(return, "Device does not support reset\n");
+
+	vfio_pci_device_reset(self->device);
+}
+
 int main(int argc, char *argv[])
 {
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


