Return-Path: <dmaengine+bounces-6131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6CB32433
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D595C62205A
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01C33A03C;
	Fri, 22 Aug 2025 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+9X9ADw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722602F6190
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897972; cv=none; b=c2TftigSuyJdjDfgZbh35sM4BrF57Z7IY35V3bUdWAWbyzghA37hB3aZeOHtTEDBCHesNrb8X1E5EhnalVYzKUNVoVAOIgNj1UPZXUEJGow2fmuQp2L2wEA1dF0HZX9PbQ+UbTbU0AIIT4PZ/p97S65WBTQd3VqG4s5Hqy+GMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897972; c=relaxed/simple;
	bh=P/eCCoCkpMCfjDcsuB43jhwZkfWS0SGXtVwm7br/3VQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iUL4lwFKPj0fxf3ZshKs5WAOhSIsHGKegBNVNUeorszj5cQf6tihDAuY8tT+8bbF/1W0Wm59fJn7/bOqv8Z3+sa5F7w2nn2lNCR5q3dTjAjECE0U6Wb8/MjL7BtRoakcZRaRauX38nE55AwDsxAlH1BkUvH/KuaU29bOq2V+kqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+9X9ADw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49c1c130caso1095210a12.2
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897970; x=1756502770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQC5DBvbLONYRU8N3RGNlWn4WjV0oiKIWFlBAVUPdSY=;
        b=F+9X9ADwkF39jvpjlHZxrfm9P7tbup5lMDNQZp2B+Cr+S3paOlyoObG72jX7bkSu0y
         dy1eMtfVoLw1HJRtklGThgBfvcG/fKx7StZrjtdR7OADKaoNjzg4NU1O9NccfCD5nBVE
         h7fIpSivIi4O89XdwLapa4m8et3EtnDJklqsLoCfz6LSsbXGma9pdIAzJ+IwdDMdcGo0
         rVIvKn1/4oNy4mOLUc/iOM619Vq5zAd2uCOaV0RZbf3N54HZhPB8ov9mAvphxoOJ0Ncw
         vSSxnnZVY7qJTU4mf4wvxvLgTP0crdfacWzfTCxLbCwn9BV7xGBe1ufJNfDgC62Ga58f
         NskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897970; x=1756502770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQC5DBvbLONYRU8N3RGNlWn4WjV0oiKIWFlBAVUPdSY=;
        b=LhVXZRxwWaPlWlkvZAbst4vABgEDwb+NJZJLng+SyAGmbZNclayjeiZ3IK5chNqex0
         CNcMH6i6xqZPJQU4nfndwB83f0K6TF/jiukBLDfCCCETVSODBp+38+gmPpdXDlcFG8nd
         NeoY22LMtoUbpBH+xvNUNFBNw44HZWgscxYmlxnvxu8T2Iu3A+vk4ulI0lPuKRVvbsU2
         AAOY14D4uXcE9k0TqZDngMsUXxekBzdavotQly5zKNqd18kR9VtTjDvTUS3SISZ2Umm/
         6XCTQvh9+9z9y4++swKFIWGSYOxUaW9zs1Iz1ETQ5sWsS9kMT7NJDFglnR++i2oLLnVZ
         IuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAIYAD/OeFdvtTM6VDP9LfKisnNCxriP+JJY8M9dVE8Fe5Ie/qowZqzyTe0zc32N4jO1YG0gjrLV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7jp9T2I6+FZjhd01vXPcWaz14BlLbcdkybLvPGT4VUNSnOkL
	RinW5noEJK9vmcgaK5QgEtRE/QS1tF7tMdBxEZaWY/jXGZwLmIHZlvb5RrQ+jQLSm76hHzXtd9Y
	nx2T3oTDEJrKUTQ==
X-Google-Smtp-Source: AGHT+IE3eOIVFNSLoddpyih3ffrWVV2dQyNS8cTE0qIv8mMe5du6Qdpq3G1SOpPqWgxL5OA3hYDPILN+89PMsw==
X-Received: from plcr17.prod.google.com ([2002:a17:903:151:b0:242:abd5:b3bf])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db0c:b0:240:10dc:b7c9 with SMTP id d9443c01a7336-2462ee2ba4dmr43299695ad.9.1755897969721;
 Fri, 22 Aug 2025 14:26:09 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:48 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-2-dmatlack@google.com>
Subject: [PATCH v2 01/30] selftests: Create tools/testing/selftests/vfio
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

Create the directory tools/testing/selftests/vfio with a stub Makefile
and hook it up to the top-level selftests Makefile.

This directory will be used in subsequent commits to host selftests for
the VFIO subsystem.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                             | 7 +++++++
 tools/testing/selftests/Makefile        | 1 +
 tools/testing/selftests/vfio/.gitignore | 7 +++++++
 tools/testing/selftests/vfio/Makefile   | 2 ++
 4 files changed, 17 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/.gitignore
 create mode 100644 tools/testing/selftests/vfio/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..1af6e92a167c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26410,6 +26410,7 @@ F:	drivers/vfio/
 F:	include/linux/vfio.h
 F:	include/linux/vfio_pci_core.h
 F:	include/uapi/linux/vfio.h
+F:	tools/testing/selftests/vfio/
 
 VFIO FSL-MC DRIVER
 L:	kvm@vger.kernel.org
@@ -26474,6 +26475,12 @@ L:	qat-linux@intel.com
 S:	Supported
 F:	drivers/vfio/pci/qat/
 
+VFIO SELFTESTS
+M:	David Matlack <dmatlack@google.com>
+L:	kvm@vger.kernel.org
+S:	Maintained
+F:	tools/testing/selftests/vfio/
+
 VFIO VIRTIO PCI DRIVER
 M:	Yishai Hadas <yishaih@nvidia.com>
 L:	kvm@vger.kernel.org
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 030da61dbff3..c4e616183aa5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -124,6 +124,7 @@ TARGETS += uevent
 TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
+TARGETS += vfio
 TARGETS += x86
 TARGETS += x86/bugs
 TARGETS += zram
diff --git a/tools/testing/selftests/vfio/.gitignore b/tools/testing/selftests/vfio/.gitignore
new file mode 100644
index 000000000000..6d9381d60172
--- /dev/null
+++ b/tools/testing/selftests/vfio/.gitignore
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+*
+!/**/
+!*.c
+!*.h
+!*.S
+!*.sh
diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
new file mode 100644
index 000000000000..2bba39aff5d9
--- /dev/null
+++ b/tools/testing/selftests/vfio/Makefile
@@ -0,0 +1,2 @@
+CFLAGS = $(KHDR_INCLUDES)
+include ../lib.mk
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


