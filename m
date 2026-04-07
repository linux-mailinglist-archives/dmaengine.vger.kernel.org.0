Return-Path: <dmaengine+bounces-9897-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ4iIT9/1GlLugcAu9opvQ
	(envelope-from <dmaengine+bounces-9897-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:51:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCF43A9810
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63F7930067BD
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 03:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B50374E6F;
	Tue,  7 Apr 2026 03:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBJW7dTk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9337474B
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533885; cv=none; b=lOivIKZpqd3isugnswBqT5T62vYQ/AeuWuK13jXRLlOop8vXttVT5VYZJ5fRvN6/RN3DSEz0WQUgJtGMwPs3F6HoUAsL6c1LnICkxP+2Hh5t2JkfhNAR9TJb/7pTUpb9nRq2XHKc3oWg4W4b/qaXE56ei0n1ougDxC/j5g6qel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533885; c=relaxed/simple;
	bh=k5lLsZIMUxHi9EN73AFgrC0u8zbL3WKK2rTs9YaRudc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhmNl/vufj9E+FA4hqegMAYpCL39mjyimQhTTkSiHoIkTRNg+Cz8X+eHgxwbMCgHWZuM7WQoerzWKCUZHONeQE4CPkIzS2MAx7ZQsqwUXnvnTgxjtpsszHsIV/B0UBg3nQ2SN2B8JKkBl7xzRZ0QGWL/B4/cWOGMQR9vFPTJyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBJW7dTk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d0288d24f6so658607485a.0
        for <dmaengine@vger.kernel.org>; Mon, 06 Apr 2026 20:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775533883; x=1776138683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGbv+HAUlQ4z6abs3ebFwZ/zDmg6dyC322KQ/p/5iD4=;
        b=oBJW7dTkt+y0Wdy8e/UJvNGALzW5PdwMjfwfGXAyU8ZeNXRUe3uRrOWak11Q1wg9iF
         XE84NuG2Ygkq/Cr7ZSTgi7umAa4dqxaLIx8RpPhLXJU4V5wBgzyCwWpZD0vVrXjxt16d
         /eWV9QVsJ8HIjCdEArYyytQOQDkEg55uE28TRw1FjZDQOUzBsOmZ/iAg4Asz5I/SQJfH
         F1lcQPtmIwPU+43qGraMtWTQlUn6oDjLaPZNNG3fxZXPPvJ4uV3RfvMKCiJfDtJLhsFd
         1KJd1O28YKapChyhnlJjXNk5ol9QHkoiqXP+4VSZdLOImjFvthATCy07x+jENM0153gg
         9+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533883; x=1776138683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGbv+HAUlQ4z6abs3ebFwZ/zDmg6dyC322KQ/p/5iD4=;
        b=j7tVCqYeeqmkKRXWA2Tw3VBG1fwy8LIgaorv1/RF6s6inm72j0nULeEzffqiLHq6yr
         Hze6WlrXGVKxAlPizJS/nPE/VjmRG3CZjTuOKtXD8HXN5hkuLCkWwWFOaZZTi1Gis9qd
         PCPjcjGp7k1cLocR6LPc947MyuQ903mz9il69fvxPvz5YF1Q5etB2rrq7osXBLEAK4yp
         feMEAEktewsfucnqfvg3N8yOKdJkaM2tR+2A10+Y6S/C+6u6wQyvQqYaYOxY+t16v+vE
         Kj47VD7p742eTkvXZ4RUfYXR4dSFHIC0II+s4PRm13Dz2w4ytmfp1W4SfH1jF9O+xpUG
         v7nQ==
X-Gm-Message-State: AOJu0YzwfLhLTgZqo79cXfYuooBcKnJmqG1KGsB1aWnTIWFlh+hO0/C9
	AB8sS0JA7VivUwWcZtGB5xARdWFZDM9MwQoxR5beImWsFCjr+F29MRuBKa/XCw==
X-Gm-Gg: AeBDiesSkaMsS9aONdEwwLTJjGrVgpR+Aq3Tu3wQOyMobf3CT5TGV0rMTSwWWxvEQRy
	My5GQoOdCJwC58phO3XrZXAjt+BrspwbIJfqyzxNHcd//tuPTFALiWnkxxfS2aNa87cYvMTkOrb
	li0DziiL0j0nMrF3daNi3km9qQg5XAQfq3Wz94lFeYCkceGPWS6hiJABXHFAuUr5Ulx2sxkPJ71
	Nd8Z7LZIh5VZihDxOHOUiksiPlQgV1h2fN+trdsT673W/nkzk45/IKCEhvJnxIBG8LdOXk9N/+r
	OQkPNgXo1AiqjUCr89TTiJDx/WcAkc02fW5fuF4+ZePvbM/3uQjowbQMx/wkpwgCzNX0eXv0Epv
	xYNF7Oc0Md6dwJxJBA6N0RPXBms2gd/BvVkNEsej7Ba1G4PzJDPAQvgQrz6FHorm6al/gFcAXtE
	MZtuf47QhiU+j7sm19D131JGQLIUw+bMS5DPJ8SWhDvGZLcoES4c13DHk=
X-Received: by 2002:a05:620a:450d:b0:8d7:a543:19a5 with SMTP id af79cd13be357-8d7a5431d5fmr822810985a.32.1775533882644;
        Mon, 06 Apr 2026 20:51:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392d28sm1148883485a.5.2026.04.06.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:51:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma: add COMPILE_TEST to AMBA_PL08X
Date: Mon,  6 Apr 2026 20:51:04 -0700
Message-ID: <20260407035104.98985-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9897-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FCF43A9810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The LPC18XX driver has COMPILE_TEST in it that does not get selected
because of a depend on AMBA_PL08X. Adding it here enables COMPILE_TEST
there.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 3520b20fb58f..87436491f128 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -66,7 +66,7 @@ config ALTERA_MSGDMA
 
 config AMBA_PL08X
 	bool "ARM PrimeCell PL080 or PL081 support"
-	depends on ARM_AMBA
+	depends on ARM_AMBA || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.53.0


