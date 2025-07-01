Return-Path: <dmaengine+bounces-5710-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D2AF0694
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 00:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90A317A003
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC823497B;
	Tue,  1 Jul 2025 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kj1y5Plc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9772602
	for <dmaengine@vger.kernel.org>; Tue,  1 Jul 2025 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409104; cv=none; b=Rujkt4xHFPbPIiP6n9wcWxTg/8/QsLwBAFiUZdcrZJ0neF+055dvEh4QpyYrVLGrkxS31P5CwNdY/vzbJOAyv5Px6IddomMdsE28piDrLlFJx5REfNmvkDq0otMQeX/Fe2meCe8OiHaz2MuKH1Wm1g9zFEDjJc+/E7RXOwbWwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409104; c=relaxed/simple;
	bh=Y38NyVKnZ82iZGpTSGed9LlVmfbMXnVz10ETj3CqMPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VPSEN8gZFx7MRBEq8gK9P4EsmfcQB3n9Fn/rCbrWfLYEcPy6ezCLUflXiL6tx3iBVsSD7uOhjcmC7bD2SoivEzlLh+DcGNiG/e+C0nAqIf9E82MlwFlsEZGY0veRuBW5Zn8moO8itOIr//uhKyZb52/y3l6AkV/OSBabOiEBDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kj1y5Plc; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2efbbf5a754so2636427fac.0
        for <dmaengine@vger.kernel.org>; Tue, 01 Jul 2025 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751409102; x=1752013902; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+APmr3mcxG70O2Gf3NLRFLfhkFazHT+YEHSsydc6Nw=;
        b=kj1y5PlcxzfBzqjp9yr8loT+juWB7r8INMsofwd8QC6Y7b98u33Q3AxfAF4d2g6CSA
         /CVBEU3/xeliL93K2KQyOQjVRay3xmTVRtFBA9mepks6vm5Wx+alMulLlwFd0XFhI003
         Rz1zvGQaLX8x+EYp5B5F11brux4O3QSykY+I0TmKfP+2tdvr/VkFAS0BdsXQCObiXI/Y
         irqr79atlNC6apnQiyLcmifgcAEVrUk1G6envMDiGPbUWn8SnYhwii6H/u1Hhf125ioP
         HNVs0KIpTTOywVXXD6837FwBo8I/LTBSvIc707sUi2y0PzUsR5urXcV31YUMB3GBuNNo
         oEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751409102; x=1752013902;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+APmr3mcxG70O2Gf3NLRFLfhkFazHT+YEHSsydc6Nw=;
        b=gbFKLTvhOy8TQ3+hPXv8/aYSMKmcVJUi2imSc3N1QoMDxTBKgBX48Brj6xK4gtQDdg
         0wUt7d+h+U5GZ33j8dZ/iPKNAhTMpe0O0Pwixk7rI1fJhhGivIPSGQADH/xEshdbgCc3
         zMkP1xwIKLfLc5VQvhUuFNXHCMCEr+y4wiVGcSTBafas7yh+X6QJSeFMNPhOxttiQsxr
         SCgBYKUZ682aHQkCUfLoSg8FgaZEBhCgosDsg/Xsm5pSX2Ei5+CHHyextwOES/2sLaOK
         M0LYUfEuphjTBsQU+f3kPYPg29LgCkygulzGqlKT3h6hqZRZVrs5zaqigA47i0oP85hg
         GGEA==
X-Forwarded-Encrypted: i=1; AJvYcCWYbkxbRPK215x25YR6SFQ6XXUIFY82LeD3yU3MluyuCtKh5S7IuGYrIi9bddQNB8TUScx8tQUamhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbImMBwqNq7amboeVnEERABNbVfCsbLyDhbAUgYl+DdCULEHF
	6R5zNH8nO3cJub1GbR8gj60cFcdwP/8KRmtIw30EzKi30ca/JduPK+NREh4zQm1XQbg=
X-Gm-Gg: ASbGncsrGxs5D2VjwQCcO/OSuf7Am6vHP71aRsw9eH3hUc+HW6KGrhkuTeyFAxfHmeB
	HmDZRGhFaPCKMAJg5dQqFyL0eAmsXfyh1EBlLq7QLHeT4aDo5HD3Q1oLrowrNg3nZEERaWjFBYr
	zgmk2B51oWUHSBBwzKhWvKiUUc/R/mmnswyeAVjuikfFIu6YMYbdjamPRyY22Cjjyyd1/Nz8Cc8
	/61edDRok5k+Z/mbDX6OKzJjQiayEHRx3k8dZP3o85HJ+TsAAeuQhCAxR3a+rcU37UDXWACKg4r
	WH0nN7y3/g4CJ4wn61ajWIEBIji5brloCQ4fNso8Vp7tB6umMIsEtRcuQuHLBYM/Rk0d9g==
X-Google-Smtp-Source: AGHT+IEsUQPOhLWTesKKtP8Y6vrAjQiXU7OxciWMUsj0112kKHLpaSXzrVlr3Y2T3n6p/TQSmzEMbg==
X-Received: by 2002:a05:687c:820:b0:2bc:716c:4622 with SMTP id 586e51a60fabf-2f5c7de279fmr396814fac.38.1751409101828;
        Tue, 01 Jul 2025 15:31:41 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d663:8de8:cafb:14e3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73afb10088esm2275056a34.50.2025.07.01.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:31:41 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:31:40 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: nbpfaxi: Fix memory corruption in probe()
Message-ID: <b13c5225-7eff-448c-badc-a2c98e9bcaca@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The nbpf->chan[] array is allocated earlier in the nbpf_probe() function
and it has "num_channels" elements.  These three loops iterate one
element farther than they should and corrupt memory.

The changes to the second loop are more involved.  In this case, we're
copying data from the irqbuf[] array into the nbpf->chan[] array.  If
the data in irqbuf[i] is the error IRQ then we skip it, so the iterators
are not in sync.  I added a check to ensure that we don't go beyond the
end of the irqbuf[] array.  I'm pretty sure this can't happen, but it
seemed harmless to add a check.

On the other hand, after the loop has ended there is a check to ensure
that the "chan" iterator is where we expect it to be.  In the original
code we went one element beyond the end of the array so the iterator
wasn't in the correct place and it would always return -EINVAL.  However,
now it will always be in the correct place.  I deleted the check since
we know the result.

Cc: stable@vger.kernel.org
Fixes: b45b262cefd5 ("dmaengine: add a driver for AMBA AXI NBPF DMAC IP cores")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 drivers/dma/nbpfaxi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 0d6324c4e2be..7a2488a0d6a3 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1351,7 +1351,7 @@ static int nbpf_probe(struct platform_device *pdev)
 	if (irqs == 1) {
 		eirq = irqbuf[0];
 
-		for (i = 0; i <= num_channels; i++)
+		for (i = 0; i < num_channels; i++)
 			nbpf->chan[i].irq = irqbuf[0];
 	} else {
 		eirq = platform_get_irq_byname(pdev, "error");
@@ -1361,16 +1361,15 @@ static int nbpf_probe(struct platform_device *pdev)
 		if (irqs == num_channels + 1) {
 			struct nbpf_channel *chan;
 
-			for (i = 0, chan = nbpf->chan; i <= num_channels;
+			for (i = 0, chan = nbpf->chan; i < num_channels;
 			     i++, chan++) {
 				/* Skip the error IRQ */
 				if (irqbuf[i] == eirq)
 					i++;
+				if (i >= ARRAY_SIZE(irqbuf))
+					return -EINVAL;
 				chan->irq = irqbuf[i];
 			}
-
-			if (chan != nbpf->chan + num_channels)
-				return -EINVAL;
 		} else {
 			/* 2 IRQs and more than one channel */
 			if (irqbuf[0] == eirq)
@@ -1378,7 +1377,7 @@ static int nbpf_probe(struct platform_device *pdev)
 			else
 				irq = irqbuf[0];
 
-			for (i = 0; i <= num_channels; i++)
+			for (i = 0; i < num_channels; i++)
 				nbpf->chan[i].irq = irq;
 		}
 	}
-- 
2.47.2


