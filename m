Return-Path: <dmaengine+bounces-8044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A7CF69A0
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 04:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8874130361C8
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 03:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821F21CFFA;
	Tue,  6 Jan 2026 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/lespdn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC16A33B
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670015; cv=none; b=K0Y+vrsndNmed8eW6SD8GwyYkxtJmiyN/ZpjznOWYu/rvZLN+/Uh0Ll1pnvO7lNCvQwwW/vW74NKm/IiljE19xv1z50wu17E1J8ZcwjbZr0OKogCLuA1k2q/WgCRaNPoVT9iRrwmICBluBJ/7OvcTdbdjlmRlH2L9LqHJhW0AfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670015; c=relaxed/simple;
	bh=WphbtP+07j0Sq9Tc/QyJOxrijkPvtXMVy9nc92Z9m0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtLl6mY+PZUJ0a/E547J+2uzxZgtgJ3DCAX0/EIhJjIwpleECHth4AjvKEimKxnV+xmjtax74638EYkvw+/8V6zGO44wvJr8JTXsdrOcsH4gCfHRrpJiZW4mZHIXHw5UfP0WRH6JFaVZJgkough9mXpIPjqIMC6uccP3KO3DrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/lespdn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a09d981507so4308145ad.1
        for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 19:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767670013; x=1768274813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wR1MSUoaJRAFiNJlWr8HhqFICJzJ7+kLKFZPOUpoQow=;
        b=E/lespdnPWLoCXJIDOA8eTf5HCI7EnFb/R5iarQUsUYL+DcGcVQH7RIUgTCkZs051F
         YjIj5LH0txkDADBj6PBRYdT+TNVqEm68W3nwD6omhHgNsmCptNoVnqtdkqRUVQU1fkcY
         0bh/f3m6wQ/GeVQdZeFE2PWK0LRc4vn5yyQawggZETvoI9iNsSd7DN26m8/rupAbeF7V
         o/nhaJm6iiSy1F3BKcrUxikB8HMYeu9nfFHnuuXh7KEznHrN5U/dNyvUY8aYQZ9/v0uD
         /6IxeGVBWSq0T0kqm7/0lkj6lx77VaMaJMdZfVZ5smP+GSCzFPqBPGR7wU16pHMa18zu
         BT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767670013; x=1768274813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR1MSUoaJRAFiNJlWr8HhqFICJzJ7+kLKFZPOUpoQow=;
        b=m+RiNqJ/8+avWGw70XsUXTXM9b1DWdf4uCU61hGflYk8yG8i233rIE0CWlXUkGPYv4
         UsjQl4ujh91lSQKQ2VzFFQqe0T5wL2RDDKvkBGGpZ0SsHC9TpgXZeQpw41Ir5vl2Y6eK
         qkIZ/QZtr+iSiG3CZaG4IVIVCm/9F+h/TShcU2ZQkGSDg5lVfxHndgPjBa1ITMlOoqRn
         AtH6HoUSjlHfkOvCd0Nj8+kZGwaUKRrumJ/Ne9Q8B53jtIEiiXgt2IF4Xj6+ceEtHMBn
         UbxKqy2PE5bbQW7ehrkfri3k6l2BaLxxAGYC2q9LFOdDuQs5lnpuFce5X1cPlaK57DJD
         y78w==
X-Gm-Message-State: AOJu0YziZMVfwDnBD3xOpV0IiI64ZPcmqFuOJF7TxYVIA9A2EYVuK15Z
	qRzIWRj9xpfW2WTZaWqc0C9vs+FWwBTTeN6wnJ658DnvdP8qSqguaq8t
X-Gm-Gg: AY/fxX5Sg9JGuUbuUtfpmp9ATA12FtBIvfVyuriZvfz1RywenNxBJsTKTjpsrSLcAYU
	wI1hrWB5s2Lz0IU9azRJXkujSQ8ObuDmoZp692EFSJdmJ7sNmIiLwTY5gOE5zokleKY2CFfEq/+
	z5NtsQ5WDV9OzOkK5co4p4F7dG1wIunmrlwBFBIru95f+Tvn11gs3g/47GFWHRgJGD5PAIssoCU
	uUwadfNlxgT1EVwZDC9ZQxik+57XCar4WYj7iblxQXM49o0RPoohWKPzUWKaR6lMA7044RimdvI
	WDiH/2N13XE2EY/7bZWYCNYNdxtFJbSsaIkq8WJeUOzwgUyglAzBfAlQgSk3CeoaQzXd/dHpfgY
	kmTZHOPtJ8yZCLlAamdgiH763st0cE0CrRB4XTnxyqiJD1UdUUksx5fzk83qWCFNSYRzWxdo5OJ
	g=
X-Google-Smtp-Source: AGHT+IHOOFYI+Cg+QugdDQZSOMcSDfr5Vr4lWsSoYC7o7j/ha8quLvx9mLb9pw9SafljoCTnMFvWig==
X-Received: by 2002:a17:903:15cf:b0:2a0:eaf5:5cd8 with SMTP id d9443c01a7336-2a3e399125bmr10804835ad.9.1767670013251;
        Mon, 05 Jan 2026 19:26:53 -0800 (PST)
Received: from oslab.. ([101.6.43.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88fcsm5784785ad.83.2026.01.05.19.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 19:26:52 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] dmaengine: idxd: fix possible wrong descriptor completion in llist_abort_desc()
Date: Tue,  6 Jan 2026 11:24:28 +0800
Message-ID: <20260106032428.162445-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of this function, d is the traversal cursor of flist, but the
code completes found instead. This can lead to issues such as NULL pointer
dereferences, double completion, or descriptor leaks.

Fix this by completing d instead of found in the final
list_for_each_entry_safe() loop.

Fixes: aa8d18becc0c ("dmaengine: idxd: add callback support for iaa crypto")
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/dma/idxd/submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 6db1c5fcedc5..03217041b8b3 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -138,7 +138,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	 */
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del_init(&d->list);
-		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true,
+		idxd_dma_complete_txd(d, IDXD_COMPLETE_ABORT, true,
 				      NULL, NULL);
 	}
 }
-- 
2.43.0


