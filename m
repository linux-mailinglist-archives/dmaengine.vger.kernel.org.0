Return-Path: <dmaengine+bounces-2009-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DEA8C0EA3
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2024 13:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9761F210A6
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2024 11:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5624130E39;
	Thu,  9 May 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0ipQ+M0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61312EBC8
	for <dmaengine@vger.kernel.org>; Thu,  9 May 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252539; cv=none; b=Grdzqn/hNGSCzHtz56vgzqdBrQcM2vo0TJjTWLb6LbUHkrjp1tkfiSBRajW2CoQF1ngmwaSlX4VmXizunCnb033nJC2THSykpOF6hjCOR2zTGPsVXsnyDzDGsOAoEAS70pttV0ytkWDYqb1fj9g0yyqUSA6mRMOV4jCfjfyt+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252539; c=relaxed/simple;
	bh=A3vBu1+lM8pshELKRiGuf0seEpLOmb3b3ZaRgmMoH+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vDHx+kJhHmAlUBpznacmhRpyg532dnC2jjPhHRpqLVPjG5Q0YZVpkpVrEXSZy9vwXcJwOSFoGltHF1tjZyYD7QJB7pVQ2YryiJGbefY/Pg0vTnvv2AQV19kkrTxZ/5zpx+24VAGzcK2cqxs7BdoWJ06W5bkCLAaMMt1OAl4SoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0ipQ+M0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b81d087aso174579066b.3
        for <dmaengine@vger.kernel.org>; Thu, 09 May 2024 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715252535; x=1715857335; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wuXHAIfnkMBAUhyPZI5mP5lslC3VrOjOuRB2Uj+Zic=;
        b=u0ipQ+M028bRXeIQrD9VTjIUcpKypoWcwvZytkvEe20m3PhlnahU0VFFKoafBu0YSH
         eKxU8yUittAikxDKryt8jR6pfj6Jj2Mcr2jvnsTOjS2w1ek+qPM/7nmq4fIuqMBF3z3L
         Fi3FGF8KSFJmN2Yn1tzOyftxV1KQKfML3lkppohSyq+PxZjhwfK7F+Wt/9vR2dGI/Ve+
         0nj3gUcZsZJcAZE9Cg/s6fEEY43SX9Ab3mx4pAAS+yKDqf6RPQPVwcuQGNH5dx5K9iaU
         Je5PmZJGq1IIjjk0V8jvoFagZ7kdIbPm4YkKnA1KKRR29UC9favt7eOFhISL0EMHCJOF
         KztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252535; x=1715857335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wuXHAIfnkMBAUhyPZI5mP5lslC3VrOjOuRB2Uj+Zic=;
        b=RnBADARac42DrxW1Zo2DQDoZAf9Z0YLNaTGiFc0n+9GyJAsEm/aaOldYY41S2ohtR7
         3woehfx6z7QScjMvJZCQZw8RM5cn2vXMjKEaqM3HrCQpxqiytvWTCcwhxST91lxd3hop
         Bzg8l/mUA++PhW1JLusc8ltVfmGUvmjYXk3VLWBgf6hEkKig3Vjb/5OAkJxQEcJ2PZNF
         3Y0a0DDaTUSf509BTxuFD6Oi1KBD3IuuEi58UieBvVCn5MAiX38KWTmXW1b/kXr4j7cD
         FeSjaJoIFT3poEjxGak4fo2rx92OgRU/kJP9gCi2EJ1A9dy2uopJ1NBFz3nJ7SH1oJyy
         jz9w==
X-Forwarded-Encrypted: i=1; AJvYcCUJLN4PzibO+FqCwqfzxvBzx3HSX3cJV5IpQzgkN1uXOOugoLaB2sxyn5GomVJsPCQmSmFSRI4QIj4odz3ybw0j8VcslB/pfsoP
X-Gm-Message-State: AOJu0YzDuLwrIFW7OGJDva07DmPEsIhysdjbmfOtsy7OhxSrxwtFbwHm
	f3pcIzE0BeFrqdCAKqkrAOGn6ENa1WiGVO+1YxmMcuZID4748HcQjIs8mzVcfiY=
X-Google-Smtp-Source: AGHT+IGHxe72lWDhQ0aCoZ86yCgXcL/PPUZxUSmPMufSVnI5xrZmniOhMXjiFBMVNiepfD12ToMK2A==
X-Received: by 2002:a17:906:68c6:b0:a59:a2f0:ee51 with SMTP id a640c23a62f3a-a59fb9c6ccbmr432024466b.54.1715252535132;
        Thu, 09 May 2024 04:02:15 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17987sm60970066b.201.2024.05.09.04.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:02:14 -0700 (PDT)
Date: Thu, 9 May 2024 14:02:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: gpi: clean up the IRQ disable/enable in
 gpi_reset_chan()
Message-ID: <8be473eb-65e0-42b4-b574-e61c3a7f62d8@moroto.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The calls write_lock/unlock_irq() disables and re-enables the IRQs.
Calling spin_lock_irqsave() and spin_lock_restore() when the IRQs are
already disabled doesn't do anything and just makes the code confusing.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/qcom/gpi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 1c93864e0e4d..ed7918c8bda1 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1197,7 +1197,6 @@ static int gpi_reset_chan(struct gchan *gchan, enum gpi_cmd gpi_cmd)
 {
 	struct gpii *gpii = gchan->gpii;
 	struct gpi_ring *ch_ring = &gchan->ch_ring;
-	unsigned long flags;
 	LIST_HEAD(list);
 	int ret;
 
@@ -1220,9 +1219,9 @@ static int gpi_reset_chan(struct gchan *gchan, enum gpi_cmd gpi_cmd)
 	gpi_mark_stale_events(gchan);
 
 	/* remove all async descriptors */
-	spin_lock_irqsave(&gchan->vc.lock, flags);
+	spin_lock(&gchan->vc.lock);
 	vchan_get_all_descriptors(&gchan->vc, &list);
-	spin_unlock_irqrestore(&gchan->vc.lock, flags);
+	spin_unlock(&gchan->vc.lock);
 	write_unlock_irq(&gpii->pm_lock);
 	vchan_dma_desc_free_list(&gchan->vc, &list);
 
-- 
2.43.0


