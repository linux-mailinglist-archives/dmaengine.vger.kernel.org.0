Return-Path: <dmaengine+bounces-6151-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC04B3246B
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 23:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294F3621316
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCC350D41;
	Fri, 22 Aug 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01fbC/9W"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099135083A
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898001; cv=none; b=Sj/OJdz/9MVa4A1EfXNLP+J6M+8QoY8j5DlaGgJ6Uf4t5b+SVySFfH9NM2OBAZZPddu2aWl9IitJ2WCBW3EX9GhsFgthWs9gFm1tPXbRQTTyCYxl6/7qQWKOkef4jPza0hWq/3sJkboNWJyu6mU6HSIZXdmcMdA5SSLCzHDStr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898001; c=relaxed/simple;
	bh=PH4BNmL4j1oTedv99HmaZlHHjgHjW0yJS2VjqLuYMsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n8UyhLAd9+jrZUOYTlJ/9p2Lh2G9JN/a4fZCQ/jtIjm6AqGaMMN5HFe6goLXiwGmlEq4Z/Hgiu7eGElbHEufMURqOIp9gK629odJQHOVitfTKlDcEA5vJrL1nnMUjRN6XNuklR6XYN7imECZe5DqKBn0YaqlQ71z31wftpVRpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01fbC/9W; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267915ebso4757411a91.1
        for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898000; x=1756502800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UK7Q+9AUfaqveTp0dvJV4DUGXRbDetwM3vZUKcGC+KM=;
        b=01fbC/9Wh9vtnsqruKx09jnePZBJRkQryaZJ4LAh7ikvgjO6P10IwrbDP9RUXXbbw9
         8zR5ShJTT++owajEShhWi1fz515/Q7oQ8GRAZoCZYL9IowF0K3uFTRlmIG8ArKN8+QiO
         b/fF4wA95FBBOr/5hA1B8pkvbyFoak1ixtQTG6widRraRedPsSqRjzSurxQn52+HQPdk
         Sg6FYqlWSO5cGkqe6pCGLtNlKcY6TruRaeieXGMULX1GWrLLRa/l4ezaAo1zu5ZgMbeU
         x7yRxATryMS77G0/+KnK+3R7RkJmQAh4srdR32LDYranK+JVQoPixXVzrKwGFnh+Zixm
         mI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898000; x=1756502800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK7Q+9AUfaqveTp0dvJV4DUGXRbDetwM3vZUKcGC+KM=;
        b=KK9bLpbnLHR+hIpz1VSVW4TxaS2K0OjwLej99ZGQtepH9qQdeidpWzxi1ZlEVnTPqY
         mzdyr1cEtPT7D5ZLEegXZM17w9dCq5rECdUGT0/EbOTLLX41Aas+p9wTOwJZ4gZdmtSR
         mLZeYMVAZyoCzkbm5oqDof83PacyvxOYDKcKFCAn9M3sB7tsxaAbU1FRjQBovCYpMYUA
         Smy+4TIMg/qaMBZ7LPjzPk3MDkZ8tsLqTL/Mst5X6bmn+ymsAJJ0XbN+lpjI+zGmObAo
         s8SFPohcdmQJhMQPyIhTvpTB8NWQk1kVzyI05HIA8muC7D1DlgnY4WMKHHmTl0Dbfvkr
         TzDw==
X-Forwarded-Encrypted: i=1; AJvYcCXk8AR0puHTcPMQU717d6cWjKJJBy/JlRwLU0komh6whMm/XTNXhul2Vr5GoLypXexLpP1qGj8Jf+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjdO0pmgThMwKcFRQDffYnNPmykiq25oIBoqIBbyfPXta2MSc
	QyNBpXznxqjd65teIRJ88LN6GMk8nxkyqWS6i2g7klIzE371XYQ7S//TvwA3h42Ez80ibkK148Y
	LmZTHK/oGauFp+A==
X-Google-Smtp-Source: AGHT+IHyMzZ1btZjsaiimjf+KhNRS17D5VjPY2ftKJ/LCnTGKnhdff6k/oQDK0ClOf/fC8qyK4uuXPSsGaIbUA==
X-Received: from pjee11.prod.google.com ([2002:a17:90b:578b:b0:31f:37f:d381])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3842:b0:321:75c1:65b2 with SMTP id 98e67ed59e1d1-32515eabbb3mr6183819a91.18.1755897999801;
 Fri, 22 Aug 2025 14:26:39 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:08 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-22-dmatlack@google.com>
Subject: [PATCH v2 21/30] dmaengine: idxd: Allow registers.h to be included
 from tools/
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

Allow drivers/dma/idxd/registers.h to be included from userspace in
tools/ by adjusting the include path to uapi/linux/idxd.h if __KERNEL__
is not defined.

A subsequent commit will use registers.h to implement a userspace driver
for Intel DSA devices in tools/testing/selftests/vfio.

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/dma/idxd/registers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 9c1c546fe443..02bab136385e 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -3,7 +3,11 @@
 #ifndef _IDXD_REGISTERS_H_
 #define _IDXD_REGISTERS_H_
 
+#ifdef __KERNEL__
 #include <uapi/linux/idxd.h>
+#else
+#include <linux/idxd.h>
+#endif
 
 /* PCI Config */
 #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


