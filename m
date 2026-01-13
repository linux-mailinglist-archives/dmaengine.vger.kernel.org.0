Return-Path: <dmaengine+bounces-8236-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74FD1B19D
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9DEA3004639
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 19:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531E369231;
	Tue, 13 Jan 2026 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Avh+gM2Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nAVitvHM"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9530DEDD
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333677; cv=none; b=LiS4kF3wxclcAMziJMutdBN9w+FU9wIWQQpVxfYiyN/O5HAfqfscKihI5f3c8WVy8zOQrHScIIx4Ndp/AcMG63ISQdvx2ljiCYj3sBL1a49rtpyTu95l6oIfEWVRL+4InpXNZhLeZ4wn5jXhohpqTjqHVNTuVIjediJxxCudBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333677; c=relaxed/simple;
	bh=m7H4fYTAN2wd1dmuh2ZoMuMP5dHupazPoMOEB3geRO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iXCBXzUsTirkSEnrrynfBmK+5WyDAIJi4wuIcZ403Bo1OuGWOwFEqS7xnTM3faKQqtUelvhI50wBmTXogfjupTrwX3+w86+a39RUCdynlqrgF+FneSy8FSYSfra36wUwYSu8AvdxEEzy6swtVXZc3wsWrtsMlTTMHAeFTZYQfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Avh+gM2Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nAVitvHM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768333675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h/J0VdyKSP8djFklxCotVlWBB1IldyLH81OZ7k+LqYY=;
	b=Avh+gM2YODwOkGSrcCcS4mZP+fIJqNPWixuvRtuKbMgTExMyLWW6PDpe9FtggbNOO1PrB9
	4nqepEWo4bPjWxYiP3YRD7RX4XKyuUopImSS23GeZkkY+nti/Wy+abrJDoJ4GkA6If3OUL
	VFBSyYEcwOyIcaeRgJTSjNsFI5mxRX8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-De0t-9KlNceCAIUQcXp4DQ-1; Tue, 13 Jan 2026 14:47:52 -0500
X-MC-Unique: De0t-9KlNceCAIUQcXp4DQ-1
X-Mimecast-MFC-AGG-ID: De0t-9KlNceCAIUQcXp4DQ_1768333672
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b1d8f56e24so2069712885a.2
        for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 11:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768333671; x=1768938471; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/J0VdyKSP8djFklxCotVlWBB1IldyLH81OZ7k+LqYY=;
        b=nAVitvHMb84tJ6AE5FITabya2rROB3lJDXEMGmyyNOFe6zXLyDqKiI11K/gCxyXuJk
         pJsodYDyzmeKaKnVEXjI0obHJjspo1vfKiTebHSWZEc6bcm+Xdo5Poo02nlDvU6eKLc8
         wjToX2UxAGS0WuG51sYqs/mFjCNwoLTLBfYMCCyBuo9b+WhFM3kbePX2r9Y8s/cr4vy2
         uhYx22bPh9qelYtJFPmVt+0XFwrpIYLe+3X2N7NEqFBy3vq+UZQSVjuh6m2CyExeJ4pu
         WkzFzeaOmpA3CE7KQne/DMlkiI+LeFOWScRT7wpkpXdK+/KsCWkx1lhX7T+QZeYzzvRo
         bQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768333671; x=1768938471;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/J0VdyKSP8djFklxCotVlWBB1IldyLH81OZ7k+LqYY=;
        b=UgKbMaLn0h7qyXeFyqiKQuTBnACCmuAae6b+dDaXq556uVOphr3on2x+Ro6/voIw+1
         1J1R/2rWX8K352SeEmQ+R9TvIZIH4BXDsawThx7VaQrOMbE4GExkvDTq3pdV7nNq+lIJ
         jzjaelLwa0AKJUlkVfIxBLrCfpt9ZTpEyLJspgWr46wItemRDhKxx5Z+kRbIo0+HZOmI
         3oa6WttZ/PtV+BcKfy391MMSqyv8SV3O/bj51uDK1eXriOGEBl2h/BxBKzbaPjgJHh8R
         q/i5umtbsF0+V32aXcUM+yJcX2QSqR6txk3YHv6VD4IOm3UCWXmn8pmiFEQnpGHFLNKY
         w/ww==
X-Forwarded-Encrypted: i=1; AJvYcCUqaMN1l+n66QBzo5As8mXyETcFa2R/1RcRxZBQ/TsL5VHpgQGPSG1MZT3U/nbHq0t3i1TLDc2aF1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bUCHO1ncR6nrdBNWiHvTUIi0adA7nBzEmgDeNiZ1ZeXwQF9p
	w0j0I7mJMrfvJLrEIdGU8PtZ0TFg8Ms8Bj4rYYoAmE7Twd+SUHjI56DcIqyfquHdjf2f1+1LFSS
	OlB9Gi2hHv8GzsiwLwLEgNq+4wGyM/D12aDgGNZLlUDu9yrhxti+xDNIyi7kEKg==
X-Gm-Gg: AY/fxX7Uh6aDXRXMG4X4fMvXWvkMsLcJhCWf2EzPyyL6YLV1q0ssVXV+rDBcdt3b2m8
	3KCE37TNwmv9X/aErZU0mkEN9S9WO5aVpV4k689I3EQlbry+KwfsYfh1U2nienQrZn8sG948/pr
	JARZUJ1PaGHJFWANAMRfjm11jJgb22qcUybTPZ0BGuGAKVaTzL5VWz6MmK5oxt91kubtf/AAiKB
	5MRQ2H0yj9xMhHLtNhqs55DMF950dngV6ZC9PUGTgfINHUaAt+menFcwXvkww7k9Pwi4YwOLglH
	/WIHA8tR418E9gLbXLnK51VLbsHw9yzhrW4aXBGJkYxnV0jhsI9UAkdyL48h1awj0LiwDTaL5lq
	hq7PI3iZW4xnZMu18C/ekKWHrSrRGGfickJVqMxWIXg==
X-Received: by 2002:a05:620a:7088:b0:8c3:7016:1d8c with SMTP id af79cd13be357-8c52fbdde52mr54923985a.88.1768333671654;
        Tue, 13 Jan 2026 11:47:51 -0800 (PST)
X-Received: by 2002:a05:620a:7088:b0:8c3:7016:1d8c with SMTP id af79cd13be357-8c52fbdde52mr54921585a.88.1768333671231;
        Tue, 13 Jan 2026 11:47:51 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4400:eb20:99f3:ffd5:11da:6745])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e4262sm159356436d6.20.2026.01.13.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:47:50 -0800 (PST)
From: Jared Kangas <jkangas@redhat.com>
Date: Tue, 13 Jan 2026 11:46:50 -0800
Subject: [PATCH] dmaengine: fsl-edma: don't explicitly disable clocks in
 .remove()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-fsl-edma-clock-removal-v1-1-2025b49e7bcc@redhat.com>
X-B4-Tracking: v=1; b=H4sIACmhZmkC/x3MQQqEMBAF0atIr20wQUW8irgI7Y82RiMJyIB49
 wku36LqoYykyDRWDyXcmjWeBaauSDZ3rmBdisk2tm+MsexzYCyHYwlRdk444u0Ct+iGwUK8E1C
 JrwSvv288ze/7B1XCBg1oAAAA
X-Change-ID: 20260112-fsl-edma-clock-removal-4e5882ecface
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Alison Wang <b18965@freescale.com>, Arnd Bergmann <arnd@arndb.de>, 
 Jingchang Lu <b35083@freescale.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jared Kangas <jkangas@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768333669; l=2024;
 i=jkangas@redhat.com; s=20251111; h=from:subject:message-id;
 bh=m7H4fYTAN2wd1dmuh2ZoMuMP5dHupazPoMOEB3geRO8=;
 b=RTdr4dUq+xENYTPbNTXSYKGcwPQ5UmP3ZVIZbo6p8PArbQkhSnZe+H6uVpra2B+HKhbYHt2dy
 I+vvV99uQZJDUMBR0Gcy9NobxdDF8Dy+ng6btr6YNj4TQMSGLLvIHhc
X-Developer-Key: i=jkangas@redhat.com; a=ed25519;
 pk=eFM2Mqcfarb4qox390655bUATO0fG9gwgaw7kGmOEZQ=

The clocks in fsl_edma_engine::muxclk are allocated and enabled with
devm_clk_get_enabled(), which automatically cleans these resources up,
but these clocks are also manually disabled in fsl_edma_remove(). This
causes warnings on driver removal for each clock:

        edma_module already disabled
        WARNING: CPU: 0 PID: 418 at drivers/clk/clk.c:1200 clk_core_disable+0x198/0x1c8
        [...]
        Call trace:
         clk_core_disable+0x198/0x1c8 (P)
         clk_disable+0x34/0x58
         fsl_edma_remove+0x74/0xe8 [fsl_edma]
         [...]
        ---[ end trace 0000000000000000 ]---
        edma_module already unprepared
        WARNING: CPU: 0 PID: 418 at drivers/clk/clk.c:1059 clk_core_unprepare+0x1f8/0x220
        [...]
        Call trace:
         clk_core_unprepare+0x1f8/0x220 (P)
         clk_unprepare+0x34/0x58
         fsl_edma_remove+0x7c/0xe8 [fsl_edma]
         [...]
        ---[ end trace 0000000000000000 ]---

Fix these warnings by removing the unnecessary fsl_disable_clocks() call
in fsl_edma_remove().

Fixes: a9903de3aa16 ("dmaengine: fsl-edma: refactor using devm_clk_get_enabled")
Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
 drivers/dma/fsl-edma-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 97583c7d51a2e8e7a50c7eb4f5ff0582ac95798d..093185768ad8ef09270ae02c99d0ee2accc183bd 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -915,7 +915,6 @@ static void fsl_edma_remove(struct platform_device *pdev)
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
-	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 }
 
 static int fsl_edma_suspend_late(struct device *dev)

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20260112-fsl-edma-clock-removal-4e5882ecface

Best regards,
-- 
Jared Kangas <jkangas@redhat.com>


