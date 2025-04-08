Return-Path: <dmaengine+bounces-4859-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4823A813D2
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2437AF7DF
	for <lists+dmaengine@lfdr.de>; Tue,  8 Apr 2025 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051D23BFBC;
	Tue,  8 Apr 2025 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix0cOZeI"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AE22DFA4
	for <dmaengine@vger.kernel.org>; Tue,  8 Apr 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133930; cv=none; b=cDo8f75GZhtuh82NF12duaDxsISNuB5BTkX9ovFiJXUdPPL9K9DRXZiV0dqbKMHQDNJDcp2p15hb/DDnrL7qKVs3WxHkpbyDt6YaehgmXqxobvofhuNr4KJn3nVGfQ6kNQkC2eMCSuWav9VweN+KY86O+/g3bYn6t1hn0mIZ6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133930; c=relaxed/simple;
	bh=AkuP0bUUMlSOQKFownX9JGiZ0AtO1qOpMcVVRDDfLNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+b81ttUixwRudSczuIb3EeUfFDvYWlFFYjdW9ROGLC9QmpsE1rXny4TwV/rp5NePbHxsEj+ZqdO/PGk1FuyvP+euNthCylogpeibavq1fGW/PXn+q0BjNsUa/qvS0dGxQ37GbmIgTR6Lo19+xoos/Alkm2PQRCINfPSR+Sm0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix0cOZeI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744133927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=itYmtHonV37X5He5iLoB2zIL/ZP2GM0njYcsfBzTAtA=;
	b=ix0cOZeI5aSsDF2j89gfmS6acu5oQnFOF02/bB+xxKt7Sr4IPKoJsSrMyAY2HFghr0YF+n
	9bTQ598YAPGOetFAGM+NfNZogeTfzPEJd07tsHGwE9IBCzKfkS0N8RNg90NIWMjYRvcNGK
	otdE61bjmkioeUQHPEcJucH0/iCX0/M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-CAxqeKhHNMOGODJUYiZQ0g-1; Tue,
 08 Apr 2025 13:38:43 -0400
X-MC-Unique: CAxqeKhHNMOGODJUYiZQ0g-1
X-Mimecast-MFC-AGG-ID: CAxqeKhHNMOGODJUYiZQ0g_1744133922
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F40E1800266;
	Tue,  8 Apr 2025 17:38:42 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.45.224.220])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56AAD19560AD;
	Tue,  8 Apr 2025 17:38:40 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>
Subject: [PATCH] dmaengine: idxd: Remove unused pointer and macro
Date: Tue,  8 Apr 2025 19:38:29 +0200
Message-ID: <20250408173829.892317-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The pointer 'extern struct kmem_cache *idxd_desc_pool' and the macro
'#define IDXD_ALLOCATED_BATCH_SIZE 128U' were introduced in commit
bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data
accelerators") but they were never used.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 drivers/dma/idxd/idxd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 214b8039439f..74e6695881e6 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -19,7 +19,6 @@
 
 #define IDXD_DRIVER_VERSION	"1.00"
 
-extern struct kmem_cache *idxd_desc_pool;
 extern bool tc_override;
 
 struct idxd_wq;
@@ -171,7 +170,6 @@ struct idxd_cdev {
 
 #define DRIVER_NAME_SIZE		128
 
-#define IDXD_ALLOCATED_BATCH_SIZE	128U
 #define WQ_NAME_SIZE   1024
 #define WQ_TYPE_SIZE   10
 
-- 
2.49.0


