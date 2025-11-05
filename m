Return-Path: <dmaengine+bounces-7061-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429EC37D29
	for <lists+dmaengine@lfdr.de>; Wed, 05 Nov 2025 22:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB634F5DE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Nov 2025 21:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32A345CCD;
	Wed,  5 Nov 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NycLZwM5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011612D6E53
	for <dmaengine@vger.kernel.org>; Wed,  5 Nov 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376617; cv=none; b=R5Saf6dD0Qow8OfhSy6xEa3YNngpIwE2PPh8U7tpFGbDe2oPla3lbERuFDEhKGQNBK9OKWAudZAc2z91Wurj9Yec6XwTQPU4UlZ1bWu8FoD6GKYctOSog2t4tXWbtPfRvgtaaar1u6ZOZBD6wRG92woAb90S85O0aTjmMaS8Xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376617; c=relaxed/simple;
	bh=tQi93lzM5aeu3ogJvKrADSMGFMS5RnUQoFSMx1fNffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XH3OgisnfjET6hWqsmNEGjigg+gr3OX+rSEKjzQJBEwBo3S3GuQDpm9MyXm5stweMcUHTwjZdCLq7zRmo5SmhNIeHD/AZG37JxgsSZd/hSaYENhSF7d5XLsjBCfgLwOmWjrrO49NuqgeckQ6EbUSdtsQBYLYEvf8rw2kA/f2uvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NycLZwM5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ba599137cf8so253975a12.0
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 13:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762376615; x=1762981415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=343sy24w6YTxt7tYy8ayiZuHRTB8gorNxc1SSzGdAHE=;
        b=NycLZwM5DYBbAPkdkP/u7/TGcz82iExx4YXTXPP3mb+msqZg5ZeF+nqM2EBSTMK/Ke
         1TZSyU87a3isBguN1BqhDa/1TysAfHqifjJQ5IWwnzRDomGsat1bvmhubSHJHKbH0LtE
         xLXMAS51VCo5dlIHVzZpPlLTRNd8u/cctmahzSl22iyQ3rTXiEOASRrLCj2Bxx8F14RW
         k7+28sh2eeYmDbxEha1O99tqCKWiHEHwvLEus1SiKDlVPWcD3hYuYdvALWywp9oKObqo
         hnWpoSGuH81feVmV6fqCE7CDb95PU1fHuvZDWhok0C7s15hcCBP9q1mmQASVIQ0IPULU
         bx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762376615; x=1762981415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=343sy24w6YTxt7tYy8ayiZuHRTB8gorNxc1SSzGdAHE=;
        b=MVG4FSCBvvlEv1nJ0G7MAHbkjL3UaLSP8egPsvL+TfmetYC8DmsPhRjZQ8/UZMzSCr
         g86JNtjtPj5qO7p0yiQgZC/adNNZAonPQUXWj+c98Rhbysb5L+fh1RI7xQW1mXpnZehB
         KKpP0O3Hws9hfwSnOC6rr6JukApFb9Q0Ek422s6s18dbkOsxyxxi06HAHGj2o7VfZ4Ea
         cXZaMy+omKzGfVaJ/PbY9MBd7+fNAUPL3xtVCoEhd7DhTml8zBInpiwBQdYsZFO0a/y1
         Uq+Nz7H1XfwSOikDDGbt0L+IuAVEAMhgjElWOQSV7kItBc9Tn1RQ1vhrXok519TkbnmO
         3GBQ==
X-Gm-Message-State: AOJu0YwYvbfyPjm7O/NRqguo0O9a6olPA8nueVbRo54108ktLG8qi+F2
	AnJC2JxFJU3Q7jf3/pzbH/QWMiCg2VSqu4go+VyS9GQvt7HSyYl0ciCDNF7Ybg==
X-Gm-Gg: ASbGncvX9MnB2JyXiKgzzRF69ghHD4d+OoWhcYxtIQj8iWp0rBqvvdJOo0o2TT6F72w
	q4DeQ4vefud+MBvM0zrmceZHqnArU3SkkvZDTANPOYOnwV5Zy6YREtqjhfQLi1akRKfPPAkO/G4
	vuNp1uBXt6865mobo3vNgkQ6kTEFj9aBJBel3bGNI0qeihGnxnJFyT2w93Jd3ejDRV4+NwmFTqR
	mQ5PtPu3+PUfR4Uqagn0kgElv14C9mBxyz4q9d9pLydursrmJ5sGSk+uaGr4l7FaauEDwM91wXV
	1HV296mLxJrZ5zUk5ckX2Vj9T08lW3ktS/BkqNJjEq89gh4m8Ox+OMKrOcYNmcC9/kc20TO/Vnl
	ND7/9oeixWEzpzyWs567V8CyXFG1sNWFOvob6OksWSDRVpak=
X-Google-Smtp-Source: AGHT+IH9KVolxbFQMAWQh/itfTmucWy+EosW0ssU2GKl97kxaV+n0qi7R7CaKpI9HbFQndlA/lF+wg==
X-Received: by 2002:a05:6a20:6a1b:b0:342:c634:e272 with SMTP id adf61e73a8af0-350df200d41mr1036693637.28.1762376614938;
        Wed, 05 Nov 2025 13:03:34 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d125c93fsm13626a91.14.2025.11.05.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:03:34 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 dmaengine 0/2] mv_xor: some devm cleanups
Date: Wed,  5 Nov 2025 13:03:15 -0800
Message-ID: <20251105210317.18215-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devm cleanups that are now possible.

It's interesting that this driver lacks a _remove function to free its
resources...

v2: resent with dmaengine prefix
v3: add error handling for devm_clk_get_optional_enabled to potentially
handle EPROBE_DEFER.
v4: remove request_irq based on feedback.

Rosen Penev (2):
  dmaengine: mv_xor: use devm_platform_ioremap_resource
  dmaengine: mv_xor: use devm_clk_get_optional_enabled

 drivers/dma/mv_xor.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

--
2.51.2


